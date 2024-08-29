Return-Path: <linux-kernel+bounces-306546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1319896404E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A105B255A5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9243318E049;
	Thu, 29 Aug 2024 09:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oex3A2Ek"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B661189BB6
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924194; cv=none; b=ijLDJEdfcHj15IhHZCbEjWmzZMG80/V3oPj9x6eALjv0cLXKHWwDo+gFTcEfGJJJqWeuw7biBmRfCc19yoMTuwPs+3T7z23i0Jt5ONuJ16O380hiapOqG52eYsunLrTXDVcCbWoiVxQya9at1LG9Q8AUOEnoKqJcDiMGMZ0cPwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924194; c=relaxed/simple;
	bh=R0dv3EHNRgbYHnt+nu8W65WKnx42ud7JpuxZbmh7oeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJhW+IEJt7vUS9MlT5dGFeKvSYkpwZWY+DkZMjtYd3VfiEOo218dT3GMz/AJRerWPOK6sWuqJLty39zcVnTweRhxTLkvCF6Heb5dwsSyEkJpSJ6/usheATbKV3o0XB3YvvvpostiLk873KO1ddHb0pEulJ1jIcbnY9qLggBmEEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oex3A2Ek; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724924189; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ni6Wd2921JKk1tCiLPVMYY/9nJO6LsKJh19RuT/t7O8=;
	b=oex3A2EkbcgGyQh85w6AhHkJ9tRGx5cQ8EV2qxer+tzhVtcknV00jV57AbnGw8KsFrXdEyPJP9G3SwsUm1lXXT6KRHbuNeVGA1zYVpLEo8DrDBdLjCYlfAJZDC5OKhnvHhE6pl3jqRja5KDGCpVVTntNCh1A4WuQG0ClwiEI8EM=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDsbb0T_1724924187)
          by smtp.aliyun-inc.com;
          Thu, 29 Aug 2024 17:36:28 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH RESEND 3/4] erofs: support compressed inodes for fileio
Date: Thu, 29 Aug 2024 17:36:16 +0800
Message-ID: <20240829093617.2396538-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240829093617.2396538-1-hsiangkao@linux.alibaba.com>
References: <20240829092614.2382457-1-hsiangkao@linux.alibaba.com>
 <20240829093617.2396538-1-hsiangkao@linux.alibaba.com>
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
 fs/erofs/fileio.c   | 25 +++++++++++++++++++++----
 fs/erofs/inode.c    |  6 ------
 fs/erofs/internal.h |  8 ++++++++
 fs/erofs/zdata.c    | 27 +++++++++++++++++----------
 4 files changed, 46 insertions(+), 20 deletions(-)

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
index 9bc4dcfd06d7..4efd578d7c62 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -489,6 +489,14 @@ static inline void z_erofs_exit_subsystem(void) {}
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
index 350612f32ac6..2271cb74ae3a 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1618,10 +1618,12 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
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
@@ -1637,10 +1639,13 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
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
@@ -1667,10 +1672,12 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
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


