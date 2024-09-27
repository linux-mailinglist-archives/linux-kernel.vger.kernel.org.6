Return-Path: <linux-kernel+bounces-341434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 444EB98800D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F073A282A69
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAF91898E2;
	Fri, 27 Sep 2024 08:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+mDSQHI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDA6189524
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727424531; cv=none; b=TPyC7dvzxyPg4wC+P46z5c0wdFStGWDd8QDWvY7puzdEuKCPuwce1ZFO0zIzH1p1JklTJ/uce5XH3KNqAeAlB4L9kRLtNjz8pSdQYbolSr82oGtDrhe/I7hoNEBLmd5NW6gZuFCsuDWdjFUPLMOqLy24z2Oi986w/Dsxsa2wo2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727424531; c=relaxed/simple;
	bh=fK1o3/Zap6YvcXCyS+ikxHLZLg3HttRFFDFPN6FAgo0=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=OJrvrYBejik6TNJ9WJjgBZvP5DCwhAmOeWiN0QQKAsn8frdguHlWjsCRsyKAycLQuoDlnKmos7gyiBncNfyeZ98vNvwbUCfuDivxwQdJ/Pmc7p+2KXqXaOEfeKcTqJuvoejQMLkX3ttHhzznnGAvf1x4T3gLbRow+k555X4dko0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a+mDSQHI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727424528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hd5968n+p2pQ26vFBvKdRu1b9H8SsPrweq9SO2NgOYE=;
	b=a+mDSQHI7V5KEZcneur3j+OZ2mjQGlo3l2KsKhXiHN7oQDoolO23AeoSaImxrEWy8S3Dux
	84V6NSjuH/SLkWFQMNUTpMEI+FJuGTwzom/dDcyxHkYrmme0QNdxtbcBJIL6vGqYgJ91ot
	q++89wMyaT+38B51crAwXKsW5xZArUQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-Pd0lZRXNOGKvbcIWikKdQA-1; Fri,
 27 Sep 2024 04:08:47 -0400
X-MC-Unique: Pd0lZRXNOGKvbcIWikKdQA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA7DC1936B85;
	Fri, 27 Sep 2024 08:08:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.145])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BDFF519560A3;
	Fri, 27 Sep 2024 08:08:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
cc: dhowells@redhat.com, Steve French <sfrench@samba.org>,
    Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Advance iterator correctly rather than jumping it
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2238547.1727424522.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Sep 2024 09:08:42 +0100
Message-ID: <2238548.1727424522@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

In netfs_write_folio(), use iov_iter_advance() to advance the folio as we
split bits of it off to subrequests rather than manually jumping the
->iov_offset value around.  This becomes more problematic when we use a
bounce buffer made out of single-page folios to cover a multipage pagecach=
e
folio.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/write_issue.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 0929d9fd4ce7..6293f547e4c3 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -317,6 +317,7 @@ static int netfs_write_folio(struct netfs_io_request *=
wreq,
 	struct netfs_io_stream *stream;
 	struct netfs_group *fgroup; /* TODO: Use this with ceph */
 	struct netfs_folio *finfo;
+	size_t iter_off =3D 0;
 	size_t fsize =3D folio_size(folio), flen =3D fsize, foff =3D 0;
 	loff_t fpos =3D folio_pos(folio), i_size;
 	bool to_eof =3D false, streamw =3D false;
@@ -472,7 +473,12 @@ static int netfs_write_folio(struct netfs_io_request =
*wreq,
 		if (choose_s < 0)
 			break;
 		stream =3D &wreq->io_streams[choose_s];
-		wreq->io_iter.iov_offset =3D stream->submit_off;
+
+		/* Advance the iterator(s). */
+		if (stream->submit_off > iter_off) {
+			iov_iter_advance(&wreq->io_iter, stream->submit_off - iter_off);
+			iter_off =3D stream->submit_off;
+		}
 =

 		atomic64_set(&wreq->issued_to, fpos + stream->submit_off);
 		stream->submit_extendable_to =3D fsize - stream->submit_off;
@@ -487,8 +493,8 @@ static int netfs_write_folio(struct netfs_io_request *=
wreq,
 			debug =3D true;
 	}
 =

-	wreq->io_iter.iov_offset =3D 0;
-	iov_iter_advance(&wreq->io_iter, fsize);
+	if (fsize > iter_off)
+		iov_iter_advance(&wreq->io_iter, fsize - iter_off);
 	atomic64_set(&wreq->issued_to, fpos + fsize);
 =

 	if (!debug)


