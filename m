Return-Path: <linux-kernel+bounces-185020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD978CAF7E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 15:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3339E283EBA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4AF7EF18;
	Tue, 21 May 2024 13:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UCPjIXSY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0CE76049
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 13:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716298675; cv=none; b=bfeTkS/8EPNgkHePdk57OJzQPS39B3fQd4EeXf+cfC38fssMhBOAK1x4vWXqGngh4MdKRn9jRKcUaK/9YyYrY9g/vgqxuOf3FxqRHc8FZQf9fTFLtgIieaauBKIgLZWgH+rxm6/wCSZzqoHzc2F8BrBeBISEcUM36bMV7Ziflew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716298675; c=relaxed/simple;
	bh=7INAOGtFzIQ6Gh/pVWdLpMxhgHEOfWNqpfhFK2p6qdg=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=QJjEfahAUrgUMRBquVdb3UqHlkgUEOPcCw4CL5ufb75wiEHlU9hJSMP+a/tKumUZAALRSS7WwrqCN1GOhdKa5ZX1cQn5UbPfp6AuhZd2L63f5L/Ao+1x3b/S7JaYWXGlp2+8Suw44bvLXjPX7FvlXGJmPatC22ciX7QZJoKDbR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UCPjIXSY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716298670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yOcMvNO//1W6FqwIcohFnux5QRyePYcjnQaavCfQFB8=;
	b=UCPjIXSYXy3h+nv2fe1wcfkkM1+AK/NW6aoBfVel2LmLtreY+8mkoU5eZrt8KbSI90E/RR
	DDKh7ESGXR5s65TqKoCESvpExG+FigszX7g+RIgKnlMtb6I6/EWjJB2qRJL7Geiiy4z1yI
	HF1yQfQVQZMalw580syMCfXTiNIFKtw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-6G-zXPF0MmCejZwxiQ4EAg-1; Tue, 21 May 2024 09:37:49 -0400
X-MC-Unique: 6G-zXPF0MmCejZwxiQ4EAg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4306A18188B0;
	Tue, 21 May 2024 13:37:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ECFEB1C09480;
	Tue, 21 May 2024 13:37:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Steve French <stfrench@microsoft.com>
cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    Enzo Matsumiya <ematsumiya@suse.de>,
    Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev,
    v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
    linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Fix io_uring based write-through
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <295085.1716298663.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 May 2024 14:37:43 +0100
Message-ID: <295086.1716298663@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

This can be triggered by mounting a cifs filesystem with a cache=3Dstrict
mount option and then, using the fsx program from xfstests, doing:

        ltp/fsx -A -d -N 1000 -S 11463 -P /tmp /cifs-mount/foo \
          --replay-ops=3Dgen112-fsxops

Where gen112-fsxops holds:

        fallocate 0x6be7 0x8fc5 0x377d3
        copy_range 0x9c71 0x77e8 0x2edaf 0x377d3
        write 0x2776d 0x8f65 0x377d3

The problem is that netfs_io_request::len is being used for two purposes
and ends up getting set to the amount of data we transferred, not the
amount of data the caller asked to be transferred (for various reasons,
such as mmap'd writes, we might end up rounding out the data written to th=
e
server to include the entire folio at each end).

Fix this by keeping the amount we were asked to write in ->len and using
->submitted to track what we issued ops for.  Then, when we come to callin=
g
->ki_complete(), ->len is the right size.

This also required netfs_cleanup_dio_write() to change since we're no
longer advancing wreq->len.  Use wreq->transferred instead as we might hav=
e
done a short read.

With this, the generic/112 xfstest passes if cifs is forced to put all
non-DIO opens into write-through mode.

Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Steve French <stfrench@microsoft.com>
cc: Enzo Matsumiya <ematsumiya@suse.de>
cc: netfs@lists.linux.dev
cc: v9fs@lists.linux.dev
cc: linux-afs@lists.infradead.org
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/direct_write.c  |    2 +-
 fs/netfs/write_collect.c |    7 ++++---
 fs/netfs/write_issue.c   |    2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index 608ba6416919..28163516bf03 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -12,7 +12,7 @@
 static void netfs_cleanup_dio_write(struct netfs_io_request *wreq)
 {
 	struct inode *inode =3D wreq->inode;
-	unsigned long long end =3D wreq->start + wreq->len;
+	unsigned long long end =3D wreq->start + wreq->transferred;
 =

 	if (!wreq->error &&
 	    i_size_read(inode) < end) {
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 60112e4b2c5e..426cf87aaf2e 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -510,7 +510,7 @@ static void netfs_collect_write_results(struct netfs_i=
o_request *wreq)
 	 * stream has a gap that can be jumped.
 	 */
 	if (notes & SOME_EMPTY) {
-		unsigned long long jump_to =3D wreq->start + wreq->len;
+		unsigned long long jump_to =3D wreq->start + READ_ONCE(wreq->submitted)=
;
 =

 		for (s =3D 0; s < NR_IO_STREAMS; s++) {
 			stream =3D &wreq->io_streams[s];
@@ -690,10 +690,11 @@ void netfs_write_collection_worker(struct work_struc=
t *work)
 	wake_up_bit(&wreq->flags, NETFS_RREQ_IN_PROGRESS);
 =

 	if (wreq->iocb) {
-		wreq->iocb->ki_pos +=3D wreq->transferred;
+		size_t written =3D min(wreq->transferred, wreq->len);
+		wreq->iocb->ki_pos +=3D written;
 		if (wreq->iocb->ki_complete)
 			wreq->iocb->ki_complete(
-				wreq->iocb, wreq->error ? wreq->error : wreq->transferred);
+				wreq->iocb, wreq->error ? wreq->error : written);
 		wreq->iocb =3D VFS_PTR_POISON;
 	}
 =

diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index acbfd1f5ee9d..3aa86e268f40 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -254,7 +254,7 @@ static void netfs_issue_write(struct netfs_io_request =
*wreq,
 	stream->construct =3D NULL;
 =

 	if (subreq->start + subreq->len > wreq->start + wreq->submitted)
-		wreq->len =3D wreq->submitted =3D subreq->start + subreq->len - wreq->s=
tart;
+		WRITE_ONCE(wreq->submitted, subreq->start + subreq->len - wreq->start);
 	netfs_do_issue_write(stream, subreq);
 }
 =


