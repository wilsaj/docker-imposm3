FROM ubuntu:14.04

ENV IMPOSM_VERSION 32623ccce097584be79ec8617dfae42d595ac2b8

# Build imposm3 binary and clean up afterwards
RUN apt-get update \
    && apt-get install -y \
        golang \
        git \
        libgeos++-dev \
        libleveldb-dev \
        libprotobuf-dev \
        libsqlite3-dev \
        mercurial \
    && mkdir /imposm \
    && git clone https://github.com/omniscale/imposm3 /imposm/src/imposm3 \
    && cd /imposm/src/imposm3 \
    && git checkout $IMPOSM_VERSION \
    && GOPATH=/imposm go get imposm3 \
    && GOPATH=/imposm go build -o /imposm3 imposm3 \
    && cd / \
    && rm -rf /imposm \
    && apt-get purge -y --auto-remove golang \
    && apt-get purge -y --auto-remove git \
    && apt-get purge -y --auto-remove mercurial
