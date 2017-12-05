FROM alpine:3.6 as build
MAINTAINER Liu Hao <sniperliuhao@gmail.com>

RUN apk add --update --no-cache ca-certificates git

ENV VERSION v2.7.2
ENV FILENAME helm-${VERSION}-linux-amd64.tar.gz

WORKDIR /

RUN apk add --update -t deps curl tar gzip
RUN curl -L http://storage.googleapis.com/kubernetes-helm/${FILENAME} | tar zxv -C /tmp

# The image we keep
FROM alpine:3.6

RUN apk add --update --no-cache git ca-certificates

COPY --from=build /tmp/linux-amd64/helm /bin/helm
