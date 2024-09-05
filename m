Return-Path: <linux-kernel+bounces-316659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 482E596D271
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B15ACB210D7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2311194A60;
	Thu,  5 Sep 2024 08:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lH1xFS4r"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E133B5256
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725526071; cv=none; b=ronQhZlZsY4Dd7qIz8aqXeiVJAypGu3/X0ZLNW3dgfOkboxYN4WZ+myM7blEbAOAq3W1ydAdlszSZpkN4i999iy5fProNy/7UkM7GWhvrN2tX84uFb/Yw72kSu9UB9oTbkxOj13vDHgeA/qx4hDt8RSkWq/XERVYBat1bBq0fyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725526071; c=relaxed/simple;
	bh=RrGvaazur0Ah+f8b8oQj/KfgZN09ZyXT1T2qwu7qjnM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=njPJWuZXtt/PWjX9NpurYu42r2oODxu4g79hi7oN7D4opkUpigu0jnw73cF7FZ8YPBKSmiJKQ4N0q3/YUfB0iSRSePRzlixs2IbvhzlC6nC8ryQqGr08x3CIi85Kyb86sIHZCiF9R2SlQfH5taQA2nZalRiLUC99JGKxIyNsY3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lH1xFS4r; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725526061; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=KBcIhc8Q7kIsMJt6qdxk6IoQjq0pkuleDwCZgpWG3ek=;
	b=lH1xFS4rRcXnMOQWw8rkPAJx+rYHIT7ge/GdE7vjI3HQ0HGUihbZ7tEO5LATvkUCU6X3ZBIUaMKUVSxzJWPuWlfnhtSnvaH2qc7j6uX2XLTXApNx2gtdnc7MNpIbLbwB3jnX7E54+HVkGgLRul7vXVAGlwuR5hq8gGAY2XL3gf0=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEKumsr_1725526053)
          by smtp.aliyun-inc.com;
          Thu, 05 Sep 2024 16:47:41 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: sunset unneeded NOFAILs
Date: Thu,  5 Sep 2024 16:47:32 +0800
Message-ID: <20240905084732.2684515-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With iterative development, our codebase can now deal with compressed
buffer misses properly if both in-place I/O and compressed buffer
allocation fail.

Note that if readahead fails (with non-uptodate folios), the original
request will then fall back to synchronous read, and `.read_folio()`
should return appropriate errnos; otherwise -EIO will be passed to
user space, which is unexpected.

To simplify rarely encountered failure paths, a mimic decompression
will be just used.  Before that, failure reasons are recorded in
compressed_bvecs[] and they also act as placeholders to avoid in-place
pages.  They will be parsed just before decompression and then pass
back to `.read_folio()`.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 57 ++++++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 785ae6ca77b1..ad0b59b3d23e 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1154,9 +1154,10 @@ static int z_erofs_parse_in_bvecs(struct z_erofs_decompress_backend *be,
 		struct z_erofs_bvec *bvec = &pcl->compressed_bvecs[i];
 		struct page *page = bvec->page;
 
-		/* compressed data ought to be valid before decompressing */
-		if (!page) {
-			err = -EIO;
+		/* compressed data ought to be valid when decompressing */
+		if (IS_ERR(page) || !page) {
+			bvec->page = NULL;	/* clear the failure reason */
+			err = page ? PTR_ERR(page) : -EIO;
 			continue;
 		}
 		be->compressed_pages[i] = page;
@@ -1232,8 +1233,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 					.inplace_io = overlapped,
 					.partial_decoding = pcl->partial,
 					.fillgaps = pcl->multibases,
-					.gfp = pcl->besteffort ?
-						GFP_KERNEL | __GFP_NOFAIL :
+					.gfp = pcl->besteffort ? GFP_KERNEL :
 						GFP_NOWAIT | __GFP_NORETRY
 				 }, be->pagepool);
 
@@ -1297,8 +1297,8 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	return err;
 }
 
-static void z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
-				     struct page **pagepool)
+static int z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
+				    struct page **pagepool)
 {
 	struct z_erofs_decompress_backend be = {
 		.sb = io->sb,
@@ -1307,6 +1307,7 @@ static void z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
 			LIST_HEAD_INIT(be.decompressed_secondary_bvecs),
 	};
 	z_erofs_next_pcluster_t owned = io->head;
+	int err = io->eio ? -EIO : 0;
 
 	while (owned != Z_EROFS_PCLUSTER_TAIL) {
 		DBG_BUGON(owned == Z_EROFS_PCLUSTER_NIL);
@@ -1314,12 +1315,13 @@ static void z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
 		be.pcl = container_of(owned, struct z_erofs_pcluster, next);
 		owned = READ_ONCE(be.pcl->next);
 
-		z_erofs_decompress_pcluster(&be, io->eio ? -EIO : 0);
+		err = z_erofs_decompress_pcluster(&be, err) ?: err;
 		if (z_erofs_is_inline_pcluster(be.pcl))
 			z_erofs_free_pcluster(be.pcl);
 		else
 			erofs_workgroup_put(&be.pcl->obj);
 	}
+	return err;
 }
 
 static void z_erofs_decompressqueue_work(struct work_struct *work)
@@ -1462,17 +1464,21 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
 	folio_unlock(folio);
 	folio_put(folio);
 out_allocfolio:
-	page = erofs_allocpage(&f->pagepool, gfp | __GFP_NOFAIL);
+	page = erofs_allocpage(&f->pagepool, gfp);
 	spin_lock(&pcl->obj.lockref.lock);
 	if (unlikely(pcl->compressed_bvecs[nr].page != zbv.page)) {
-		erofs_pagepool_add(&f->pagepool, page);
+		if (page)
+			erofs_pagepool_add(&f->pagepool, page);
 		spin_unlock(&pcl->obj.lockref.lock);
 		cond_resched();
 		goto repeat;
 	}
-	bvec->bv_page = pcl->compressed_bvecs[nr].page = page;
-	folio = page_folio(page);
+	pcl->compressed_bvecs[nr].page = page ? page : ERR_PTR(-ENOMEM);
 	spin_unlock(&pcl->obj.lockref.lock);
+	bvec->bv_page = page;
+	if (!page)
+		return;
+	folio = page_folio(page);
 out_tocache:
 	if (!tocache || bs != PAGE_SIZE ||
 	    filemap_add_folio(mc, folio, pcl->obj.index + nr, gfp)) {
@@ -1695,26 +1701,28 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 	z_erofs_decompress_kickoff(q[JQ_SUBMIT], nr_bios);
 }
 
-static void z_erofs_runqueue(struct z_erofs_decompress_frontend *f,
-			     bool force_fg, bool ra)
+static int z_erofs_runqueue(struct z_erofs_decompress_frontend *f,
+			    unsigned int ra_folios)
 {
 	struct z_erofs_decompressqueue io[NR_JOBQUEUES];
+	struct erofs_sb_info *sbi = EROFS_I_SB(f->inode);
+	bool force_fg = z_erofs_is_sync_decompress(sbi, ra_folios);
+	int err;
 
 	if (f->owned_head == Z_EROFS_PCLUSTER_TAIL)
-		return;
-	z_erofs_submit_queue(f, io, &force_fg, ra);
+		return 0;
+	z_erofs_submit_queue(f, io, &force_fg, !!ra_folios);
 
 	/* handle bypass queue (no i/o pclusters) immediately */
-	z_erofs_decompress_queue(&io[JQ_BYPASS], &f->pagepool);
-
+	err = z_erofs_decompress_queue(&io[JQ_BYPASS], &f->pagepool);
 	if (!force_fg)
-		return;
+		return err;
 
 	/* wait until all bios are completed */
 	wait_for_completion_io(&io[JQ_SUBMIT].u.done);
 
 	/* handle synchronous decompress queue in the caller context */
-	z_erofs_decompress_queue(&io[JQ_SUBMIT], &f->pagepool);
+	return z_erofs_decompress_queue(&io[JQ_SUBMIT], &f->pagepool) ?: err;
 }
 
 /*
@@ -1776,7 +1784,6 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
 static int z_erofs_read_folio(struct file *file, struct folio *folio)
 {
 	struct inode *const inode = folio->mapping->host;
-	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
 	int err;
 
@@ -1788,9 +1795,8 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
 	z_erofs_pcluster_readmore(&f, NULL, false);
 	z_erofs_pcluster_end(&f);
 
-	/* if some compressed cluster ready, need submit them anyway */
-	z_erofs_runqueue(&f, z_erofs_is_sync_decompress(sbi, 0), false);
-
+	/* if some pclusters are ready, need submit them anyway */
+	err = z_erofs_runqueue(&f, 0) ?: err;
 	if (err && err != -EINTR)
 		erofs_err(inode->i_sb, "read error %d @ %lu of nid %llu",
 			  err, folio->index, EROFS_I(inode)->nid);
@@ -1803,7 +1809,6 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
 static void z_erofs_readahead(struct readahead_control *rac)
 {
 	struct inode *const inode = rac->mapping->host;
-	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
 	struct folio *head = NULL, *folio;
 	unsigned int nr_folios;
@@ -1833,7 +1838,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	z_erofs_pcluster_readmore(&f, rac, false);
 	z_erofs_pcluster_end(&f);
 
-	z_erofs_runqueue(&f, z_erofs_is_sync_decompress(sbi, nr_folios), true);
+	(void)z_erofs_runqueue(&f, nr_folios);
 	erofs_put_metabuf(&f.map.buf);
 	erofs_release_pages(&f.pagepool);
 }
-- 
2.43.5


