Return-Path: <linux-kernel+bounces-237963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B5392414A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 16:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F560B28FC0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC451BA89B;
	Tue,  2 Jul 2024 14:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DxXBMRAa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AEE1BA08B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719931824; cv=none; b=Odv2CGs8KocimCJN5UwQTX5R0XeTOi6Lt0niLMeOoPo8Cngg4gIjIlUtXRIHBTc57aUm2s2FH4J9ypC9+5dYNCqC9/WFpquupeRIKkOj6uRSavo0Gll6AJtKoEWm162zntXy2QwdtQNe7Id8+KSUnCEfZMT6M5dDBSPZrxS+Hjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719931824; c=relaxed/simple;
	bh=j04qJCMTRC27SFYKj5QHjaBXylUAzvskB/hwKauQY1s=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=OvxnfwJQEHzBvcRotFusaslJQfxaFV46NLhVeV0hYRSfQGqGnarV891tDaJ8H+lyf5f+0DXSr1V3k8e5kZSiFNFqOQSPZo7Fo6qt66JREeKgUs4kgEvuQ92nGsq6qiCwitXg/XKhKZ/jzEAInzsoAApdoOSBd94haDqdcgrvK3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DxXBMRAa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719931821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uWZifttcEAbyBfObjSbGpm26/PI7fGmjt0k2HweKiRc=;
	b=DxXBMRAalBWmSrdJ2I6mfrjlzzKp/e0V+BOeC6bDyNcOOCAHg015pEdZ3LIFGzzrGrLlmT
	Z1IBJkDs+O/tMZM7/7wNvuaNOkf+QHFd7rhV5Cm8CpwTeBFefyNOLMIbgBScz//XwV2vux
	PmwUDityAoH8fSKRdl0Ve5Z3s4TZyhY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-7te1MDSUOmGrLCL5FkfiOg-1; Tue,
 02 Jul 2024 10:50:16 -0400
X-MC-Unique: 7te1MDSUOmGrLCL5FkfiOg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0252219560B8;
	Tue,  2 Jul 2024 14:50:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.111])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 640C93000221;
	Tue,  2 Jul 2024 14:50:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.com>,
    Jeff Layton <jlayton@kernel.org>,
    Christian Brauner <christian@brauner.io>,
    Matthew Wilcox <willy@infradead.org>, linux-cifs@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: Fix read-performance regression by dropping readahead expansion
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3042270.1719931809.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jul 2024 15:50:09 +0100
Message-ID: <3042271.1719931809@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

cifs_expand_read() is causing a performance regression of around 30% by
causing extra pagecache to be allocated for an inode in the readahead path
before we begin actually dispatching RPC requests, thereby delaying the
actual I/O.  The expansion is sized according to the rsize parameter, whic=
h
seems to be 4MiB on my test system; this is a big step up from the first
requests made by the fio test program.

Fix this by removing cifs_expand_readahead().  Readahead expansion is
mostly useful for when we're using the local cache if the local cache has =
a
block size greater than PAGE_SIZE, so we can dispense with it when not
caching.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/smb/client/file.c |   30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index f1f2573bb18d..1374635e89fa 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -245,35 +245,6 @@ static int cifs_init_request(struct netfs_io_request =
*rreq, struct file *file)
 	return 0;
 }
 =

-/*
- * Expand the size of a readahead to the size of the rsize, if at least a=
s
- * large as a page, allowing for the possibility that rsize is not pow-2
- * aligned.
- */
-static void cifs_expand_readahead(struct netfs_io_request *rreq)
-{
-	unsigned int rsize =3D rreq->rsize;
-	loff_t misalignment, i_size =3D i_size_read(rreq->inode);
-
-	if (rsize < PAGE_SIZE)
-		return;
-
-	if (rsize < INT_MAX)
-		rsize =3D roundup_pow_of_two(rsize);
-	else
-		rsize =3D ((unsigned int)INT_MAX + 1) / 2;
-
-	misalignment =3D rreq->start & (rsize - 1);
-	if (misalignment) {
-		rreq->start -=3D misalignment;
-		rreq->len +=3D misalignment;
-	}
-
-	rreq->len =3D round_up(rreq->len, rsize);
-	if (rreq->start < i_size && rreq->len > i_size - rreq->start)
-		rreq->len =3D i_size - rreq->start;
-}
-
 /*
  * Completion of a request operation.
  */
@@ -329,7 +300,6 @@ const struct netfs_request_ops cifs_req_ops =3D {
 	.init_request		=3D cifs_init_request,
 	.free_request		=3D cifs_free_request,
 	.free_subrequest	=3D cifs_free_subrequest,
-	.expand_readahead	=3D cifs_expand_readahead,
 	.clamp_length		=3D cifs_clamp_length,
 	.issue_read		=3D cifs_req_issue_read,
 	.done			=3D cifs_rreq_done,


