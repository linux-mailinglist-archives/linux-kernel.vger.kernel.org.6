Return-Path: <linux-kernel+bounces-560517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E840A605E8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 00:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E0444225BD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 23:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133A520FAB4;
	Thu, 13 Mar 2025 23:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KFflVzQC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EE420E716
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 23:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908946; cv=none; b=SgR0yaLXv8vv0jvQyp1KgBGn3wPEg7FadS2AoBTSg6P6nDVwBgv5YAjeMvn+FpmRsJ3f9svwzhAdVD7dTeGtsjy4ccRKC4U3pu4YcBxDxPq557P2/6rSCbP/EkrspgSBqzc5lD/UpnOT+3jAz8pte42qDmR4zHRqQWZeX4HbvEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908946; c=relaxed/simple;
	bh=o/Zr6xlF5B6lSctEAHGp+Z0dT3it5fkkfwvSYDNK+ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3Dq5sUEm7q+MxZd4c9C44boM6a+AzwMhgPIzHRXzW/k/HFLuLMH9WbF/45KamfaReHj6cGrHclxeU+pcUtBOx6ZpSQk9ytANDcsJvR9MS+uUD5frztMdrpP9u67oSxr7stjmQg033f5ld0gQhY8aPovPYcbpKagAThAQVpREbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KFflVzQC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741908942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4S9pWAwkvg/dSOZrmn04PqAhUhdiqhkkXPp5wd+gSpI=;
	b=KFflVzQCLK4YPTrB0adkp/gF3Jqv+rEwpCBkMjkrmThAbP0lQUTOeT6EHrswJCEEYlZFyr
	tFbRtgWnca3RR8uXYHgBAExu4oZuLnYUHPf0+HV0NUW3uepii37ZnDhYNvarAc9wig+Raw
	L7pdONEP8ZHBj5xrg6Fhn3wgNUaPByE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-290-sUUhUPBnPb2374m58HGoLQ-1; Thu,
 13 Mar 2025 19:35:39 -0400
X-MC-Unique: sUUhUPBnPb2374m58HGoLQ-1
X-Mimecast-MFC-AGG-ID: sUUhUPBnPb2374m58HGoLQ_1741908937
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC6111956087;
	Thu, 13 Mar 2025 23:35:37 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7188618001F6;
	Thu, 13 Mar 2025 23:35:35 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	Alex Markuze <amarkuze@redhat.com>
Cc: David Howells <dhowells@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 29/35] netfs: Allow fs-private data to be handed through to request alloc
Date: Thu, 13 Mar 2025 23:33:21 +0000
Message-ID: <20250313233341.1675324-30-dhowells@redhat.com>
In-Reply-To: <20250313233341.1675324-1-dhowells@redhat.com>
References: <20250313233341.1675324-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Allow an fs-private pointer to be handed through to request alloc and
stashed in the netfs_io_request struct for the filesystem to retrieve.

This will be used by ceph to pass a pointer to the ceph_writeback_ctl to
the netfs operation functions.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_read.c | 11 ++++++-----
 fs/netfs/direct_read.c   |  2 +-
 fs/netfs/direct_write.c  |  2 +-
 fs/netfs/internal.h      |  2 ++
 fs/netfs/objects.c       |  2 ++
 fs/netfs/read_pgpriv2.c  |  2 +-
 fs/netfs/read_single.c   |  2 +-
 fs/netfs/write_issue.c   | 17 +++++++++++------
 fs/netfs/write_retry.c   |  2 +-
 include/linux/netfs.h    |  3 ++-
 10 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 4dd505053fba..10daf2452324 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -343,7 +343,7 @@ void netfs_readahead(struct readahead_control *ractl)
 	int ret;
 
 	rreq = netfs_alloc_request(ractl->mapping, ractl->file, start, size,
-				   NETFS_READAHEAD);
+				   NULL, NETFS_READAHEAD);
 	if (IS_ERR(rreq))
 		return;
 
@@ -414,7 +414,8 @@ static int netfs_read_gaps(struct file *file, struct folio *folio)
 
 	_enter("%lx", folio->index);
 
-	rreq = netfs_alloc_request(mapping, file, folio_pos(folio), flen, NETFS_READ_GAPS);
+	rreq = netfs_alloc_request(mapping, file, folio_pos(folio), flen,
+				   NULL, NETFS_READ_GAPS);
 	if (IS_ERR(rreq)) {
 		ret = PTR_ERR(rreq);
 		goto alloc_error;
@@ -510,7 +511,7 @@ int netfs_read_folio(struct file *file, struct folio *folio)
 
 	rreq = netfs_alloc_request(mapping, file,
 				   folio_pos(folio), folio_size(folio),
-				   NETFS_READPAGE);
+				   NULL, NETFS_READPAGE);
 	if (IS_ERR(rreq)) {
 		ret = PTR_ERR(rreq);
 		goto alloc_error;
@@ -665,7 +666,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 
 	rreq = netfs_alloc_request(mapping, file,
 				   folio_pos(folio), folio_size(folio),
-				   NETFS_READ_FOR_WRITE);
+				   NULL, NETFS_READ_FOR_WRITE);
 	if (IS_ERR(rreq)) {
 		ret = PTR_ERR(rreq);
 		goto error;
@@ -730,7 +731,7 @@ int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 	ret = -ENOMEM;
 
 	rreq = netfs_alloc_request(mapping, file, start, flen,
-				   NETFS_READ_FOR_WRITE);
+				   NULL, NETFS_READ_FOR_WRITE);
 	if (IS_ERR(rreq)) {
 		ret = PTR_ERR(rreq);
 		goto error;
diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
index fc0a053ad5a8..15a6923a92ca 100644
--- a/fs/netfs/direct_read.c
+++ b/fs/netfs/direct_read.c
@@ -264,7 +264,7 @@ ssize_t netfs_unbuffered_read_iter_locked(struct kiocb *iocb, struct iov_iter *i
 
 	rreq = netfs_alloc_request(iocb->ki_filp->f_mapping, iocb->ki_filp,
 				   iocb->ki_pos, orig_count,
-				   NETFS_DIO_READ);
+				   NULL, NETFS_DIO_READ);
 	if (IS_ERR(rreq))
 		return PTR_ERR(rreq);
 
diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index e41614687e49..83c5c06c4710 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -300,7 +300,7 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *
 
 	_debug("uw %llx-%llx", start, end);
 
-	wreq = netfs_create_write_req(iocb->ki_filp->f_mapping, iocb->ki_filp, start,
+	wreq = netfs_create_write_req(iocb->ki_filp->f_mapping, iocb->ki_filp, start, NULL,
 				      iocb->ki_flags & IOCB_DIRECT ?
 				      NETFS_DIO_WRITE : NETFS_UNBUFFERED_WRITE);
 	if (IS_ERR(wreq))
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 2a6123c4da35..9724d5a1ddc7 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -101,6 +101,7 @@ int netfs_alloc_bounce(struct netfs_io_request *wreq, unsigned long long to, gfp
 struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 					     struct file *file,
 					     loff_t start, size_t len,
+					     void *netfs_priv2,
 					     enum netfs_io_origin origin);
 void netfs_get_request(struct netfs_io_request *rreq, enum netfs_rreq_ref_trace what);
 void netfs_clear_subrequests(struct netfs_io_request *rreq, bool was_async);
@@ -218,6 +219,7 @@ void netfs_wake_write_collector(struct netfs_io_request *wreq, bool was_async);
 struct netfs_io_request *netfs_create_write_req(struct address_space *mapping,
 						struct file *file,
 						loff_t start,
+						void *netfs_priv2,
 						enum netfs_io_origin origin);
 void netfs_prepare_write(struct netfs_io_request *wreq,
 			 struct netfs_io_stream *stream,
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index 7fdbaa5c5cab..4606e830c116 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -16,6 +16,7 @@
 struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 					     struct file *file,
 					     loff_t start, size_t len,
+					     void *netfs_priv2,
 					     enum netfs_io_origin origin)
 {
 	static atomic_t debug_ids;
@@ -38,6 +39,7 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 	rreq->len	= len;
 	rreq->origin	= origin;
 	rreq->netfs_ops	= ctx->ops;
+	rreq->netfs_priv2 = netfs_priv2;
 	rreq->mapping	= mapping;
 	rreq->inode	= inode;
 	rreq->i_size	= i_size_read(inode);
diff --git a/fs/netfs/read_pgpriv2.c b/fs/netfs/read_pgpriv2.c
index cf7727060215..e94140ebc6fb 100644
--- a/fs/netfs/read_pgpriv2.c
+++ b/fs/netfs/read_pgpriv2.c
@@ -103,7 +103,7 @@ static struct netfs_io_request *netfs_pgpriv2_begin_copy_to_cache(
 		goto cancel;
 
 	creq = netfs_create_write_req(rreq->mapping, NULL, folio_pos(folio),
-				      NETFS_PGPRIV2_COPY_TO_CACHE);
+				      NULL, NETFS_PGPRIV2_COPY_TO_CACHE);
 	if (IS_ERR(creq))
 		goto cancel;
 
diff --git a/fs/netfs/read_single.c b/fs/netfs/read_single.c
index b36a3020bb90..3a20e8340e06 100644
--- a/fs/netfs/read_single.c
+++ b/fs/netfs/read_single.c
@@ -169,7 +169,7 @@ ssize_t netfs_read_single(struct inode *inode, struct file *file, struct iov_ite
 	ssize_t ret;
 
 	rreq = netfs_alloc_request(inode->i_mapping, file, 0, iov_iter_count(iter),
-				   NETFS_READ_SINGLE);
+				   NULL, NETFS_READ_SINGLE);
 	if (IS_ERR(rreq))
 		return PTR_ERR(rreq);
 
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 3921fcf4f859..9b8d99477405 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -90,6 +90,7 @@ static void netfs_kill_dirty_pages(struct address_space *mapping,
 struct netfs_io_request *netfs_create_write_req(struct address_space *mapping,
 						struct file *file,
 						loff_t start,
+						void *netfs_priv2,
 						enum netfs_io_origin origin)
 {
 	struct netfs_io_request *wreq;
@@ -99,7 +100,7 @@ struct netfs_io_request *netfs_create_write_req(struct address_space *mapping,
 			     origin == NETFS_WRITETHROUGH ||
 			     origin == NETFS_PGPRIV2_COPY_TO_CACHE);
 
-	wreq = netfs_alloc_request(mapping, file, start, 0, origin);
+	wreq = netfs_alloc_request(mapping, file, start, 0, netfs_priv2, origin);
 	if (IS_ERR(wreq))
 		return wreq;
 
@@ -598,14 +599,18 @@ static void netfs_end_issue_write(struct netfs_io_request *wreq)
  * @mapping: The file to flush from
  * @wbc: Details of what should be flushed
  * @group: The write grouping to flush (or NULL)
+ * @netfs_priv2: Private data specific to the netfs (or NULL)
  *
  * Start asynchronous write back operations to flush dirty data belonging to a
  * particular group in a file's pagecache back to the server and to the local
  * cache.
+ *
+ * If not NULL, @netfs_priv2 will be set on wreq->netfs_priv2
  */
 int netfs_writepages_group(struct address_space *mapping,
 			   struct writeback_control *wbc,
-			   struct netfs_group *group)
+			   struct netfs_group *group,
+			   void *netfs_priv2)
 {
 	struct netfs_inode *ictx = netfs_inode(mapping->host);
 	struct netfs_io_request *wreq = NULL;
@@ -627,7 +632,7 @@ int netfs_writepages_group(struct address_space *mapping,
 		goto out;
 
 	wreq = netfs_create_write_req(mapping, NULL, folio_pos(folio),
-				      NETFS_WRITEBACK);
+				      netfs_priv2, NETFS_WRITEBACK);
 	if (IS_ERR(wreq)) {
 		error = PTR_ERR(wreq);
 		goto couldnt_start;
@@ -683,7 +688,7 @@ EXPORT_SYMBOL(netfs_writepages_group);
 int netfs_writepages(struct address_space *mapping,
 		     struct writeback_control *wbc)
 {
-	return netfs_writepages_group(mapping, wbc, NULL);
+	return netfs_writepages_group(mapping, wbc, NULL, NULL);
 }
 EXPORT_SYMBOL(netfs_writepages);
 
@@ -698,7 +703,7 @@ struct netfs_io_request *netfs_begin_writethrough(struct kiocb *iocb, size_t len
 	mutex_lock(&ictx->wb_lock);
 
 	wreq = netfs_create_write_req(iocb->ki_filp->f_mapping, iocb->ki_filp,
-				      iocb->ki_pos, NETFS_WRITETHROUGH);
+				      iocb->ki_pos, NULL, NETFS_WRITETHROUGH);
 	if (IS_ERR(wreq)) {
 		mutex_unlock(&ictx->wb_lock);
 		return wreq;
@@ -953,7 +958,7 @@ int netfs_writeback_single(struct address_space *mapping,
 		mutex_lock(&ictx->wb_lock);
 	}
 
-	wreq = netfs_create_write_req(mapping, NULL, 0, NETFS_WRITEBACK_SINGLE);
+	wreq = netfs_create_write_req(mapping, NULL, 0, NULL, NETFS_WRITEBACK_SINGLE);
 	if (IS_ERR(wreq)) {
 		ret = PTR_ERR(wreq);
 		goto couldnt_start;
diff --git a/fs/netfs/write_retry.c b/fs/netfs/write_retry.c
index 187882801d57..f727b48e2bfe 100644
--- a/fs/netfs/write_retry.c
+++ b/fs/netfs/write_retry.c
@@ -328,7 +328,7 @@ ssize_t netfs_rmw_read(struct netfs_io_request *wreq, struct file *file,
 		bufsize = bsize * 2;
 	}
 
-	rreq = netfs_alloc_request(wreq->mapping, file, start, len, NETFS_RMW_READ);
+	rreq = netfs_alloc_request(wreq->mapping, file, start, len, NULL, NETFS_RMW_READ);
 	if (IS_ERR(rreq))
 		return PTR_ERR(rreq);
 
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 69052ac47ab1..9d17d4bd9753 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -459,7 +459,8 @@ int netfs_write_begin(struct netfs_inode *, struct file *,
 		      struct folio **, void **fsdata);
 int netfs_writepages_group(struct address_space *mapping,
 			   struct writeback_control *wbc,
-			   struct netfs_group *group);
+			   struct netfs_group *group,
+			   void *netfs_priv2);
 int netfs_writepages(struct address_space *mapping,
 		     struct writeback_control *wbc);
 bool netfs_dirty_folio(struct address_space *mapping, struct folio *folio);


