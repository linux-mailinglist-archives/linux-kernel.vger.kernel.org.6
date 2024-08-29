Return-Path: <linux-kernel+bounces-306516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C85B1964003
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 356DEB253E9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CACB18E76C;
	Thu, 29 Aug 2024 09:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CUrnffja"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1089318E045
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724923615; cv=none; b=A9236SMrF+Ofqub2DfSHbOq29eljv05EGtAeCOzdgFhVhDYnLYC2pD2h4QHBmwfn9NG5CgSwquse8FOlR4c/f2L4ds1mc8c2uc980PVHewNbx2bpNoog/tW18/Eofe8GGL4Y/tZeUC38ugIWQuCCb9ChjhwsgN7onUzPzKASJgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724923615; c=relaxed/simple;
	bh=3RFKBM1wxHWxd2KLzfRn2JU5rPIFjCDuLWNaHBscUmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3aEpN91Qgf+VehfacBeYYp4akUG+g6uccCulzImqCunGO1tL2Iay2Rq5tarmTyaW0fBlgDimADePhVF2S1GD7bzwco+6jAvx+FO1ad1Idw0Nc/KvaDExBUYaSw9OOLj3p95sWTuM/d0trMQOnk9lvwuHId8+d/+/f/73A1qmMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CUrnffja; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724923604; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=nE0r6MOo4Y9TdfoZuwJt3CbuaVG/XLrtl0+sCPchGDI=;
	b=CUrnffjaPUEf3L297Ocfu/7/1ysD98Yqsoz0pVYzqariiQZxakghl1geNq3r/qO8dGJuO0xkJNmY8aStlFebtWIVsG3I8doYMK3IlQKtWqbjCapGDuhRm3S3t7vj1aOluOxNOEtJGIts7wZ2dW2D2V4vUu078ldVE4WpyMH5UwA=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDsbXRo_1724923603)
          by smtp.aliyun-inc.com;
          Thu, 29 Aug 2024 17:26:44 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 3/4] erofs: support compressed inodes for fileio
Date: Thu, 29 Aug 2024 17:26:13 +0800
Message-ID: <20240829092614.2382457-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240829092614.2382457-1-hsiangkao@linux.alibaba.com>
References: <20240829092614.2382457-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use pseudo bios just like the previous fscache approach since
merged bio_vecs can be filled properly with unique interfaces.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/data.c     | 36 ++++++++++++++++++++++
 fs/erofs/fileio.c   | 25 +++++++++++++---
 fs/erofs/inode.c    |  6 ----
 fs/erofs/internal.h | 11 +++++++
 fs/erofs/zdata.c    | 73 ++++++++++++++-------------------------------
 5 files changed, 90 insertions(+), 61 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index ee00128fd83d..b4c07ce7a294 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -256,6 +256,42 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 	return 0;
 }
 
+/*
+ * bit 30: I/O error occurred on this folio
+ * bit 0 - 29: remaining parts to complete this folio
+ */
+#define EROFS_ONLINEFOLIO_EIO			(1 << 30)
+
+void erofs_onlinefolio_init(struct folio *folio)
+{
+	union {
+		atomic_t o;
+		void *v;
+	} u = { .o = ATOMIC_INIT(1) };
+
+	folio->private = u.v;	/* valid only if file-backed folio is locked */
+}
+
+void erofs_onlinefolio_split(struct folio *folio)
+{
+	atomic_inc((atomic_t *)&folio->private);
+}
+
+void erofs_onlinefolio_end(struct folio *folio, int err)
+{
+	int orig, v;
+
+	do {
+		orig = atomic_read((atomic_t *)&folio->private);
+		v = (orig - 1) | (err ? EROFS_ONLINEFOLIO_EIO : 0);
+	} while (atomic_cmpxchg((atomic_t *)&folio->private, orig, v) != orig);
+
+	if (v & ~EROFS_ONLINEFOLIO_EIO)
+		return;
+	folio->private = 0;
+	folio_end_read(folio, !(v & EROFS_ONLINEFOLIO_EIO));
+}
+
 static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
 {
diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index 6191336b42b6..02b522ff7876 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -23,7 +23,6 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
 			container_of(iocb, struct erofs_fileio_rq, iocb);
 	struct folio_iter fi;
 
-	DBG_BUGON(rq->bio.bi_end_io);
 	if (ret > 0) {
 		if (ret != rq->bio.bi_iter.bi_size) {
 			bio_advance(&rq->bio, ret);
@@ -31,9 +30,13 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
 		}
 		ret = 0;
 	}
-	bio_for_each_folio_all(fi, &rq->bio) {
-		DBG_BUGON(folio_test_uptodate(fi.folio));
-		erofs_onlinefolio_end(fi.folio, ret);
+	if (rq->bio.bi_end_io) {
+		rq->bio.bi_end_io(&rq->bio);
+	} else {
+		bio_for_each_folio_all(fi, &rq->bio) {
+			DBG_BUGON(folio_test_uptodate(fi.folio));
+			erofs_onlinefolio_end(fi.folio, ret);
+		}
 	}
 	kfree(rq);
 }
@@ -68,6 +71,20 @@ static struct erofs_fileio_rq *erofs_fileio_rq_alloc(struct erofs_map_dev *mdev)
 	return rq;
 }
 
+struct bio *erofs_fileio_bio_alloc(struct erofs_map_dev *mdev)
+{
+	struct erofs_fileio_rq *rq;
+
+	rq = erofs_fileio_rq_alloc(mdev);
+	return rq ? &rq->bio : NULL;
+}
+
+void erofs_fileio_submit_bio(struct bio *bio)
+{
+	return erofs_fileio_rq_submit(container_of(bio, struct erofs_fileio_rq,
+						   bio));
+}
+
 static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
 {
 	struct inode *inode = folio_inode(folio);
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 4a902e6e69a5..82259553d9f6 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -260,12 +260,6 @@ static int erofs_fill_inode(struct inode *inode)
 	mapping_set_large_folios(inode->i_mapping);
 	if (erofs_inode_is_data_compressed(vi->datalayout)) {
 #ifdef CONFIG_EROFS_FS_ZIP
-#ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
-		if (erofs_is_fileio_mode(EROFS_SB(inode->i_sb))) {
-			err = -EOPNOTSUPP;
-			goto out_unlock;
-		}
-#endif
 		DO_ONCE_LITE_IF(inode->i_blkbits != PAGE_SHIFT,
 			  erofs_info, inode->i_sb,
 			  "EXPERIMENTAL EROFS subpage compressed block support in use. Use at your own risk!");
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 302cbb57f79a..4efd578d7c62 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -413,6 +413,9 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *dev);
 int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		 u64 start, u64 len);
 int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map);
+void erofs_onlinefolio_init(struct folio *folio);
+void erofs_onlinefolio_split(struct folio *folio);
+void erofs_onlinefolio_end(struct folio *folio, int err);
 struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid);
 int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		  struct kstat *stat, u32 request_mask,
@@ -486,6 +489,14 @@ static inline void z_erofs_exit_subsystem(void) {}
 static inline int erofs_init_managed_cache(struct super_block *sb) { return 0; }
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
+#ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
+struct bio *erofs_fileio_bio_alloc(struct erofs_map_dev *mdev);
+void erofs_fileio_submit_bio(struct bio *bio);
+#else
+static inline struct bio *erofs_fileio_bio_alloc(struct erofs_map_dev *mdev) { return NULL; }
+static inline void erofs_fileio_submit_bio(struct bio *bio) {}
+#endif
+
 #ifdef CONFIG_EROFS_FS_ONDEMAND
 int erofs_fscache_register_fs(struct super_block *sb);
 void erofs_fscache_unregister_fs(struct super_block *sb);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 424f656cd765..2271cb74ae3a 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -122,42 +122,6 @@ static bool erofs_folio_is_managed(struct erofs_sb_info *sbi, struct folio *fo)
 	return fo->mapping == MNGD_MAPPING(sbi);
 }
 
-/*
- * bit 30: I/O error occurred on this folio
- * bit 0 - 29: remaining parts to complete this folio
- */
-#define Z_EROFS_FOLIO_EIO			(1 << 30)
-
-static void z_erofs_onlinefolio_init(struct folio *folio)
-{
-	union {
-		atomic_t o;
-		void *v;
-	} u = { .o = ATOMIC_INIT(1) };
-
-	folio->private = u.v;	/* valid only if file-backed folio is locked */
-}
-
-static void z_erofs_onlinefolio_split(struct folio *folio)
-{
-	atomic_inc((atomic_t *)&folio->private);
-}
-
-static void z_erofs_onlinefolio_end(struct folio *folio, int err)
-{
-	int orig, v;
-
-	do {
-		orig = atomic_read((atomic_t *)&folio->private);
-		v = (orig - 1) | (err ? Z_EROFS_FOLIO_EIO : 0);
-	} while (atomic_cmpxchg((atomic_t *)&folio->private, orig, v) != orig);
-
-	if (v & ~Z_EROFS_FOLIO_EIO)
-		return;
-	folio->private = 0;
-	folio_end_read(folio, !(v & Z_EROFS_FOLIO_EIO));
-}
-
 #define Z_EROFS_ONSTACK_PAGES		32
 
 /*
@@ -965,7 +929,7 @@ static int z_erofs_scan_folio(struct z_erofs_decompress_frontend *f,
 	int err = 0;
 
 	tight = (bs == PAGE_SIZE);
-	z_erofs_onlinefolio_init(folio);
+	erofs_onlinefolio_init(folio);
 	do {
 		if (offset + end - 1 < map->m_la ||
 		    offset + end - 1 >= map->m_la + map->m_llen) {
@@ -1024,7 +988,7 @@ static int z_erofs_scan_folio(struct z_erofs_decompress_frontend *f,
 			if (err)
 				break;
 
-			z_erofs_onlinefolio_split(folio);
+			erofs_onlinefolio_split(folio);
 			if (f->pcl->pageofs_out != (map->m_la & ~PAGE_MASK))
 				f->pcl->multibases = true;
 			if (f->pcl->length < offset + end - map->m_la) {
@@ -1044,7 +1008,7 @@ static int z_erofs_scan_folio(struct z_erofs_decompress_frontend *f,
 			tight = (bs == PAGE_SIZE);
 		}
 	} while ((end = cur) > 0);
-	z_erofs_onlinefolio_end(folio, err);
+	erofs_onlinefolio_end(folio, err);
 	return err;
 }
 
@@ -1147,7 +1111,7 @@ static void z_erofs_fill_other_copies(struct z_erofs_decompress_backend *be,
 			cur += len;
 		}
 		kunmap_local(dst);
-		z_erofs_onlinefolio_end(page_folio(bvi->bvec.page), err);
+		erofs_onlinefolio_end(page_folio(bvi->bvec.page), err);
 		list_del(p);
 		kfree(bvi);
 	}
@@ -1302,7 +1266,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 
 		DBG_BUGON(z_erofs_page_is_invalidated(page));
 		if (!z_erofs_is_shortlived_page(page)) {
-			z_erofs_onlinefolio_end(page_folio(page), err);
+			erofs_onlinefolio_end(page_folio(page), err);
 			continue;
 		}
 		if (pcl->algorithmformat != Z_EROFS_COMPRESSION_LZ4) {
@@ -1654,10 +1618,12 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 			if (bio && (cur != last_pa ||
 				    bio->bi_bdev != mdev.m_bdev)) {
 io_retry:
-				if (!erofs_is_fscache_mode(sb))
-					submit_bio(bio);
-				else
+				if (erofs_is_fileio_mode(EROFS_SB(sb)))
+					erofs_fileio_submit_bio(bio);
+				else if (erofs_is_fscache_mode(sb))
 					erofs_fscache_submit_bio(bio);
+				else
+					submit_bio(bio);
 
 				if (memstall) {
 					psi_memstall_leave(&pflags);
@@ -1673,10 +1639,13 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 			}
 
 			if (!bio) {
-				bio = erofs_is_fscache_mode(sb) ?
-					erofs_fscache_bio_alloc(&mdev) :
-					bio_alloc(mdev.m_bdev, BIO_MAX_VECS,
-						  REQ_OP_READ, GFP_NOIO);
+				if (erofs_is_fileio_mode(EROFS_SB(sb)))
+					bio = erofs_fileio_bio_alloc(&mdev);
+				else if (erofs_is_fscache_mode(sb))
+					bio = erofs_fscache_bio_alloc(&mdev);
+				else
+					bio = bio_alloc(mdev.m_bdev, BIO_MAX_VECS,
+							REQ_OP_READ, GFP_NOIO);
 				bio->bi_end_io = z_erofs_endio;
 				bio->bi_iter.bi_sector = cur >> 9;
 				bio->bi_private = q[JQ_SUBMIT];
@@ -1703,10 +1672,12 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 	} while (owned_head != Z_EROFS_PCLUSTER_TAIL);
 
 	if (bio) {
-		if (!erofs_is_fscache_mode(sb))
-			submit_bio(bio);
-		else
+		if (erofs_is_fileio_mode(EROFS_SB(sb)))
+			erofs_fileio_submit_bio(bio);
+		else if (erofs_is_fscache_mode(sb))
 			erofs_fscache_submit_bio(bio);
+		else
+			submit_bio(bio);
 		if (memstall)
 			psi_memstall_leave(&pflags);
 	}
-- 
2.43.5


