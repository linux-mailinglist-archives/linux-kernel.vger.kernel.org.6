Return-Path: <linux-kernel+bounces-306515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 284E4963FFF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D51F1C21765
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F286E18C32B;
	Thu, 29 Aug 2024 09:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HmF2hLpR"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2317218E02D
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724923608; cv=none; b=MrLukBvJphCkOcgTQ+RywpiTyU3OKwO/af0YOrVqMgAme1kl3IQZu0GBtiAlzt0wgKeMtfhbhx4i3yBmsAIfLccSDOa6a76t6+BkapvS1acPKv+Fkw6KpMpcVsFCFklOCfghemhm3oru89y6yRaENY2fzNsQvc0bMgXn6rhTNic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724923608; c=relaxed/simple;
	bh=EWH3c3g1Hk9DRWJfGm0L4yfut/BK7Uf2YJHY/sgwAo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P49rARqrNHiTjo3u7NvfC2FXv3+L+hhdrW7w7bv4I3KKYu5YV6N4UBKI1lX12JuLhdjZdsCGdL9VDHEJ92wxbkvX2EXdGlmz6We0pwaIFDyEoYSSYHqH/I/WMiUohdCWL4SWayNSpRpDttXMwU7OIdaQzFtnM8TWJtxIRfjc88w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HmF2hLpR; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724923603; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=QdXSVlGKxGxLO84ELPgVOz0iC5ufr6VpdS7SL+U2mCo=;
	b=HmF2hLpRRz+WrFjQbWtDywTfPEmUGdbcYQEFX460K25Sr8J2AQaEXm7BIZ74X5TWtd9WG1tChE1b04HaU8AH0aJrN+n/S208/ck8BcPfxmz6Lhc5BLfmQ7Y4CndftN5N//MY/88SFYgKuO21WVaYC8hO0pd0Ra8p/AgdxYtyQP0=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDsbXRF_1724923601)
          by smtp.aliyun-inc.com;
          Thu, 29 Aug 2024 17:26:42 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/4] erofs: support unencoded inodes for fileio
Date: Thu, 29 Aug 2024 17:26:12 +0800
Message-ID: <20240829092614.2382457-2-hsiangkao@linux.alibaba.com>
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

Since EROFS only needs to handle read requests in simple contexts,
Just directly use vfs_iocb_iter_read() for data I/Os.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/Makefile   |   1 +
 fs/erofs/data.c     |  14 +++-
 fs/erofs/fileio.c   | 179 ++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/inode.c    |  17 +++--
 fs/erofs/internal.h |   4 +-
 5 files changed, 205 insertions(+), 10 deletions(-)
 create mode 100644 fs/erofs/fileio.c

diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index 097d672e6b14..4331d53c7109 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -7,4 +7,5 @@ erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o zutil.o
 erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
 erofs-$(CONFIG_EROFS_FS_ZIP_DEFLATE) += decompressor_deflate.o
 erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
+erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) += fileio.o
 erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 0fb31c588ae0..ee00128fd83d 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -132,7 +132,7 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
 	if (map->m_la >= inode->i_size) {
 		/* leave out-of-bound access unmapped */
 		map->m_flags = 0;
-		map->m_plen = 0;
+		map->m_plen = map->m_llen;
 		goto out;
 	}
 
@@ -197,8 +197,13 @@ static void erofs_fill_from_devinfo(struct erofs_map_dev *map,
 				    struct erofs_device_info *dif)
 {
 	map->m_bdev = NULL;
-	if (dif->file && S_ISBLK(file_inode(dif->file)->i_mode))
-		map->m_bdev = file_bdev(dif->file);
+	map->m_fp = NULL;
+	if (dif->file) {
+		if (S_ISBLK(file_inode(dif->file)->i_mode))
+			map->m_bdev = file_bdev(dif->file);
+		else
+			map->m_fp = dif->file;
+	}
 	map->m_daxdev = dif->dax_dev;
 	map->m_dax_part_off = dif->dax_part_off;
 	map->m_fscache = dif->fscache;
@@ -215,6 +220,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 	map->m_daxdev = EROFS_SB(sb)->dax_dev;
 	map->m_dax_part_off = EROFS_SB(sb)->dax_part_off;
 	map->m_fscache = EROFS_SB(sb)->s_fscache;
+	map->m_fp = EROFS_SB(sb)->fdev;
 
 	if (map->m_deviceid) {
 		down_read(&devs->rwsem);
@@ -399,7 +405,7 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 }
 
 /* for uncompressed (aligned) files and raw access for other files */
-const struct address_space_operations erofs_raw_access_aops = {
+const struct address_space_operations erofs_aops = {
 	.read_folio = erofs_read_folio,
 	.readahead = erofs_readahead,
 	.bmap = erofs_bmap,
diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
new file mode 100644
index 000000000000..6191336b42b6
--- /dev/null
+++ b/fs/erofs/fileio.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024, Alibaba Cloud
+ */
+#include "internal.h"
+#include <trace/events/erofs.h>
+
+struct erofs_fileio_rq {
+	struct bio_vec bvecs[BIO_MAX_VECS];
+	struct bio bio;
+	struct kiocb iocb;
+};
+
+struct erofs_fileio {
+	struct erofs_map_blocks map;
+	struct erofs_map_dev dev;
+	struct erofs_fileio_rq *rq;
+};
+
+static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
+{
+	struct erofs_fileio_rq *rq =
+			container_of(iocb, struct erofs_fileio_rq, iocb);
+	struct folio_iter fi;
+
+	DBG_BUGON(rq->bio.bi_end_io);
+	if (ret > 0) {
+		if (ret != rq->bio.bi_iter.bi_size) {
+			bio_advance(&rq->bio, ret);
+			zero_fill_bio(&rq->bio);
+		}
+		ret = 0;
+	}
+	bio_for_each_folio_all(fi, &rq->bio) {
+		DBG_BUGON(folio_test_uptodate(fi.folio));
+		erofs_onlinefolio_end(fi.folio, ret);
+	}
+	kfree(rq);
+}
+
+static void erofs_fileio_rq_submit(struct erofs_fileio_rq *rq)
+{
+	struct iov_iter iter;
+	int ret;
+
+	if (!rq)
+		return;
+	rq->iocb.ki_pos = rq->bio.bi_iter.bi_sector << 9;
+	rq->iocb.ki_ioprio = get_current_ioprio();
+	rq->iocb.ki_complete = erofs_fileio_ki_complete;
+	rq->iocb.ki_flags = (rq->iocb.ki_filp->f_mode & FMODE_CAN_ODIRECT) ?
+				IOCB_DIRECT : 0;
+	iov_iter_bvec(&iter, ITER_DEST, rq->bvecs, rq->bio.bi_vcnt,
+		      rq->bio.bi_iter.bi_size);
+	ret = vfs_iocb_iter_read(rq->iocb.ki_filp, &rq->iocb, &iter);
+	if (ret != -EIOCBQUEUED)
+		erofs_fileio_ki_complete(&rq->iocb, ret);
+}
+
+static struct erofs_fileio_rq *erofs_fileio_rq_alloc(struct erofs_map_dev *mdev)
+{
+	struct erofs_fileio_rq *rq = kzalloc(sizeof(*rq), GFP_KERNEL);
+
+	if (!rq)
+		return NULL;
+	bio_init(&rq->bio, NULL, rq->bvecs, BIO_MAX_VECS, REQ_OP_READ);
+	rq->iocb.ki_filp = mdev->m_fp;
+	return rq;
+}
+
+static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
+{
+	struct inode *inode = folio_inode(folio);
+	struct erofs_map_blocks *map = &io->map;
+	unsigned int cur = 0, end = folio_size(folio), len;
+	loff_t pos = folio_pos(folio), ofs;
+	struct iov_iter iter;
+	struct bio_vec bv;
+	int err = 0;
+
+	erofs_onlinefolio_init(folio);
+	while (cur < end) {
+		if (!in_range(pos + cur, map->m_la, map->m_llen)) {
+			map->m_la = pos + cur;
+			map->m_llen = end - cur;
+			err = erofs_map_blocks(inode, map);
+			if (err)
+				break;
+		}
+
+		ofs = folio_pos(folio) + cur - map->m_la;
+		len = min_t(loff_t, map->m_llen - ofs, end - cur);
+		if (map->m_flags & EROFS_MAP_META) {
+			struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
+			void *src;
+
+			src = erofs_read_metabuf(&buf, inode->i_sb,
+						 map->m_pa + ofs, EROFS_KMAP);
+			if (IS_ERR(src)) {
+				err = PTR_ERR(src);
+				break;
+			}
+			bvec_set_folio(&bv, folio, len, cur);
+			iov_iter_bvec(&iter, ITER_DEST, &bv, 1, len);
+			if (copy_to_iter(src, len, &iter) != len) {
+				erofs_put_metabuf(&buf);
+				err = -EIO;
+				break;
+			}
+			erofs_put_metabuf(&buf);
+		} else if (!(map->m_flags & EROFS_MAP_MAPPED)) {
+			folio_zero_segment(folio, cur, cur + len);
+		} else {
+			erofs_onlinefolio_split(folio);
+			if (io->rq && (map->m_pa + ofs != io->dev.m_pa ||
+				       map->m_deviceid != io->dev.m_deviceid)) {
+io_retry:
+				erofs_fileio_rq_submit(io->rq);
+				io->rq = NULL;
+			}
+
+			if (!io->rq) {
+				io->dev = (struct erofs_map_dev) {
+					.m_pa = io->map.m_pa + ofs,
+					.m_deviceid = io->map.m_deviceid,
+				};
+				err = erofs_map_dev(inode->i_sb, &io->dev);
+				if (err)
+					break;
+				io->rq = erofs_fileio_rq_alloc(&io->dev);
+				if (!io->rq) {
+					err = -ENOMEM;
+					break;
+				}
+				io->rq->bio.bi_iter.bi_sector = io->dev.m_pa >> 9;
+			}
+			if (!bio_add_folio(&io->rq->bio, folio, len, cur))
+				goto io_retry;
+			io->dev.m_pa += len;
+		}
+		cur += len;
+	}
+	erofs_onlinefolio_end(folio, err);
+	return err;
+}
+
+static int erofs_fileio_read_folio(struct file *file, struct folio *folio)
+{
+	struct erofs_fileio io = {};
+	int err;
+
+	trace_erofs_read_folio(folio, false);
+	err = erofs_fileio_scan_folio(&io, folio);
+	erofs_fileio_rq_submit(io.rq);
+	return err;
+}
+
+static void erofs_fileio_readahead(struct readahead_control *rac)
+{
+	struct inode *inode = rac->mapping->host;
+	struct erofs_fileio io = {};
+	struct folio *folio;
+	int err;
+
+	trace_erofs_readpages(inode, readahead_index(rac),
+			      readahead_count(rac), false);
+	while ((folio = readahead_folio(rac))) {
+		err = erofs_fileio_scan_folio(&io, folio);
+		if (err && err != -EINTR)
+			erofs_err(inode->i_sb, "readahead error at folio %lu @ nid %llu",
+				  folio->index, EROFS_I(inode)->nid);
+	}
+	erofs_fileio_rq_submit(io.rq);
+}
+
+const struct address_space_operations erofs_fileio_aops = {
+	.read_folio = erofs_fileio_read_folio,
+	.readahead = erofs_fileio_readahead,
+};
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index d05b9e59f122..4a902e6e69a5 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -258,11 +258,14 @@ static int erofs_fill_inode(struct inode *inode)
 	}
 
 	mapping_set_large_folios(inode->i_mapping);
-	if (erofs_is_fileio_mode(EROFS_SB(inode->i_sb))) {
-		/* XXX: data I/Os will be implemented in the following patches */
-		err = -EOPNOTSUPP;
-	} else if (erofs_inode_is_data_compressed(vi->datalayout)) {
+	if (erofs_inode_is_data_compressed(vi->datalayout)) {
 #ifdef CONFIG_EROFS_FS_ZIP
+#ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
+		if (erofs_is_fileio_mode(EROFS_SB(inode->i_sb))) {
+			err = -EOPNOTSUPP;
+			goto out_unlock;
+		}
+#endif
 		DO_ONCE_LITE_IF(inode->i_blkbits != PAGE_SHIFT,
 			  erofs_info, inode->i_sb,
 			  "EXPERIMENTAL EROFS subpage compressed block support in use. Use at your own risk!");
@@ -271,10 +274,14 @@ static int erofs_fill_inode(struct inode *inode)
 		err = -EOPNOTSUPP;
 #endif
 	} else {
-		inode->i_mapping->a_ops = &erofs_raw_access_aops;
+		inode->i_mapping->a_ops = &erofs_aops;
 #ifdef CONFIG_EROFS_FS_ONDEMAND
 		if (erofs_is_fscache_mode(inode->i_sb))
 			inode->i_mapping->a_ops = &erofs_fscache_access_aops;
+#endif
+#ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
+		if (erofs_is_fileio_mode(EROFS_SB(inode->i_sb)))
+			inode->i_mapping->a_ops = &erofs_fileio_aops;
 #endif
 	}
 out_unlock:
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 9bf4fb1cfa09..302cbb57f79a 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -372,6 +372,7 @@ struct erofs_map_dev {
 	struct erofs_fscache *m_fscache;
 	struct block_device *m_bdev;
 	struct dax_device *m_daxdev;
+	struct file *m_fp;
 	u64 m_dax_part_off;
 
 	erofs_off_t m_pa;
@@ -380,7 +381,8 @@ struct erofs_map_dev {
 
 extern const struct super_operations erofs_sops;
 
-extern const struct address_space_operations erofs_raw_access_aops;
+extern const struct address_space_operations erofs_aops;
+extern const struct address_space_operations erofs_fileio_aops;
 extern const struct address_space_operations z_erofs_aops;
 extern const struct address_space_operations erofs_fscache_access_aops;
 
-- 
2.43.5


