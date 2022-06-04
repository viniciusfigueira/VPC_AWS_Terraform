# VPC
resource "aws_vpc" "mongovpc" {
  cidr_block = "10.54.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "mongovpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "lab_gw" {
  vpc_id = aws_vpc.mongovpc.id

  tags = {
    Network = "Public"
    Name = "mongovpc-igw"
  }
}

# Subnets
resource "aws_subnet" "public0" {
  vpc_id = aws_vpc.mongovpc.id
  cidr_block = "10.54.14.0/24"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = "true"

  tags = {
    Network = "Public"
    Name = "mongovpc-public-us-east-2a"
  }
}

resource "aws_subnet" "public1" {
  vpc_id = aws_vpc.mongovpc.id
  cidr_block = "10.54.16.0/24"
  availability_zone = "us-east-2b"
  map_public_ip_on_launch = "true"

  tags = {
    Network = "Public"
    Name = "mongovpc-public-us-east-2b"
  }
}

resource "aws_subnet" "public2" {
  vpc_id = aws_vpc.mongovpc.id
  cidr_block = "10.54.24.0/24"
  availability_zone = "us-east-2c"
  map_public_ip_on_launch = "true"

  tags = {
    Network = "Public"
    Name = "mongovpc-public-us-east-2c"
  }
}

# Internet Route
resource "aws_route" "internet_route" {
  route_table_id = aws_vpc.mongovpc.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.lab_gw.id
}

# Subnet Associations to Route Table
resource "aws_route_table_association" "srta0" {
  subnet_id = aws_subnet.public0.id
  route_table_id = aws_vpc.mongovpc.default_route_table_id
}

resource "aws_route_table_association" "srta1" {
  subnet_id = aws_subnet.public1.id
  route_table_id = aws_vpc.mongovpc.default_route_table_id
}

resource "aws_route_table_association" "srta2" {
  subnet_id = aws_subnet.public2.id
  route_table_id = aws_vpc.mongovpc.default_route_table_id
}