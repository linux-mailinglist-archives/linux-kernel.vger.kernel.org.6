Return-Path: <linux-kernel+bounces-266097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 391F693FAF4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3751C22450
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A664618FC75;
	Mon, 29 Jul 2024 16:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VQOYsBuk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA4F18F2F0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722270136; cv=none; b=pT4SbmjL1iGlywaojFkyc0k6KW/f/myfW/JhtYq9MbTYYikoj+fCnsCv1ScIndDgrCRHLKya9huYGIfvwF/VIDCnmrlRioSBw2/axKizhcauGjiaHpIHw40Vg26J3hkZJ2uGhRvjC5Gh2G8MZWQyeGLfxc+KKgZr4cuC/hkGMfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722270136; c=relaxed/simple;
	bh=Euv3WbrHNaIXCWLvkkyDvCcDtp8hp/LRltMuZyPRX3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CxDGCuXCuUj4RxkrRx/OaLyl033+zuPNFYs/Avzxi1hbijlt+o7xzIIJMn4D3Qf0IHqFQ4VUEF1Y3lSqCtDC9OyaWufEe/M/XtOSjLLQFNnaUKp8LInPPT7QNJKV9QHiG57gsDgE9HVnaVXwEsptUcRLOlVkA4e92KFNGWr3Lmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VQOYsBuk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722270134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BEg00OpRQajVHUnNP+IlkJUc9WaKog3YPTamcSjZGjQ=;
	b=VQOYsBuk0L5/bWLodvm0XwkIbLirVueGeT6IJKBdM9ivUTRgzaFHJDhaTVEL1mwu4AAYmo
	72T6K7uKLV32iR8eK4auaYifnnNVuT1LE56cRqI1WGR30eWF7KZUaVLYDKS9L9+B3F6boU
	pGjmX6p/q+3rINc9jVeYVjdP91rFf+Q=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-ds710c1LMjSgj0Ce6FlwDA-1; Mon,
 29 Jul 2024 12:22:09 -0400
X-MC-Unique: ds710c1LMjSgj0Ce6FlwDA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 48C2B1955BFE;
	Mon, 29 Jul 2024 16:22:06 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.216])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B55D7300018D;
	Mon, 29 Jul 2024 16:22:00 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 15/24] netfs: Provide an iterator-reset function
Date: Mon, 29 Jul 2024 17:19:44 +0100
Message-ID: <20240729162002.3436763-16-dhowells@redhat.com>
In-Reply-To: <20240729162002.3436763-1-dhowells@redhat.com>
References: <20240729162002.3436763-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

---
 fs/netfs/internal.h      |  4 +---
 fs/netfs/misc.c          | 18 ++++++++++++++++++
 fs/netfs/write_collect.c |  3 +--
 fs/netfs/write_issue.c   |  6 +++---
 4 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index e1149e05a5c8..21a3c7d13585 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -69,6 +69,7 @@ int netfs_buffer_append_folio(struct netfs_io_request *rreq, struct folio *folio
 			      bool needs_put);
 struct folio_queue *netfs_delete_buffer_head(struct netfs_io_request *wreq);
 void netfs_clear_buffer(struct netfs_io_request *rreq);
+void netfs_reset_iter(struct netfs_io_subrequest *subreq);
 
 /*
  * objects.c
@@ -161,9 +162,6 @@ struct netfs_io_request *netfs_create_write_req(struct address_space *mapping,
 void netfs_reissue_write(struct netfs_io_stream *stream,
 			 struct netfs_io_subrequest *subreq,
 			 struct iov_iter *source);
-int netfs_advance_write(struct netfs_io_request *wreq,
-			struct netfs_io_stream *stream,
-			loff_t start, size_t len, bool to_eof);
 struct netfs_io_request *netfs_begin_writethrough(struct kiocb *iocb, size_t len);
 int netfs_advance_writethrough(struct netfs_io_request *wreq, struct writeback_control *wbc,
 			       struct folio *folio, size_t copied, bool to_page_end,
diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 1700849491a0..a9baa46a17ff 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -84,6 +84,24 @@ void netfs_clear_buffer(struct netfs_io_request *rreq)
 	}
 }
 
+/*
+ * Reset the subrequest iterator to refer just to the region remaining to be
+ * read.  The iterator may or may not have been advanced by socket ops or
+ * extraction ops to an extent that may or may not match the amount actually
+ * read.
+ */
+void netfs_reset_iter(struct netfs_io_subrequest *subreq)
+{
+	struct iov_iter *io_iter = &subreq->io_iter;
+	size_t remain = subreq->len - subreq->transferred;
+
+	if (io_iter->count > remain)
+		iov_iter_advance(io_iter, io_iter->count - remain);
+	else if (io_iter->count < remain)
+		iov_iter_revert(io_iter, remain - io_iter->count);
+	iov_iter_truncate(&subreq->io_iter, remain);
+}
+
 /**
  * netfs_dirty_folio - Mark folio dirty and pin a cache object for writeback
  * @mapping: The mapping the folio belongs to.
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 1521a23077c3..801a130a0ce1 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -219,9 +219,8 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 		/* Determine the set of buffers we're going to use.  Each
 		 * subreq gets a subset of a single overall contiguous buffer.
 		 */
+		netfs_reset_iter(from);
 		source = from->io_iter;
-		iov_iter_revert(&source, subreq->len - source.count);
-		iov_iter_advance(&source, from->transferred);
 		source.count = len;
 
 		/* Work through the sublist. */
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index d581fd8a568b..520be44d132e 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -259,9 +259,9 @@ static void netfs_issue_write(struct netfs_io_request *wreq,
  * we can avoid overrunning the credits obtained (cifs) and try to parallelise
  * content-crypto preparation with network writes.
  */
-int netfs_advance_write(struct netfs_io_request *wreq,
-			struct netfs_io_stream *stream,
-			loff_t start, size_t len, bool to_eof)
+static int netfs_advance_write(struct netfs_io_request *wreq,
+			       struct netfs_io_stream *stream,
+			       loff_t start, size_t len, bool to_eof)
 {
 	struct netfs_io_subrequest *subreq = stream->construct;
 	size_t part;


