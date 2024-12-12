Return-Path: <linux-kernel+bounces-443130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CB69EE7C3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B173281E24
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E230215059;
	Thu, 12 Dec 2024 13:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Q51AZGui"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111FD2144AA
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 13:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734010522; cv=none; b=kccGu6ecJr2QMaRrUiYyG0A2OJZZCSLNFRtnxNOqASviAQDv876mROY/bLz0NqrDIVMig6kQi8CrLwbCWQwjGnSjcRcDuI1TqoPOIjEUawNbLQ73kVXquuzbrS77DIXEUK4GiZQlRSt2BYiggYS/X/DXpOIku985hMSjwISi9nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734010522; c=relaxed/simple;
	bh=OpViFrPlolMbv6Z8XdW24GI4w1zIebTByXyMl8ZaTOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5L39yVSR4qUHz2a+R323Admppm/4WWoLYYJBBrTFlD6HUqR248p37geDWtcl6b6RYF6O85hLFKsPKoM9U4hFSCxZ6t6sNl2pl6BDaoK33yFuvfPHnoYs1ShHdIVV78drilIYyvvSEtoxFPZlYzNuBxxuI2kTOvcegmWeK4lvz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Q51AZGui; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734010512; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=UyJPya5OT9LNAFzMrChSZjHIOfkqieiGV8h+l6rPH0s=;
	b=Q51AZGuiCmX4bphdhwb3QglRnHi70JjULX32GRQiYA8bqx9loG+m9ZOiZ5nWi29n9hHckrXZliWbXQE5sjxWlVrONQwBKiw7z+2cU18D8k+bTE373+fBFUxbwp6A8fTdmWaYLJcvGF8bqL8+dVMFf0Q5rKU/ZDsaDWSyaCcv2HY=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLLvJpH_1734010510 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Dec 2024 21:35:11 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/4] erofs: use `struct erofs_device_info` for the primary device
Date: Thu, 12 Dec 2024 21:35:02 +0800
Message-ID: <20241212133504.2047178-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241212133504.2047178-1-hsiangkao@linux.alibaba.com>
References: <20241212133504.2047178-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of just listing each one directly in `struct erofs_sb_info`
except that we still use `sb->s_bdev` for the primary block device.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/data.c     | 10 +++-------
 fs/erofs/internal.h |  7 ++-----
 fs/erofs/super.c    | 27 +++++++++++++--------------
 3 files changed, 18 insertions(+), 26 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 1c49f8962021..0b0385fa3025 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -56,7 +56,7 @@ void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
 
 	buf->file = NULL;
 	if (erofs_is_fileio_mode(sbi)) {
-		buf->file = sbi->fdev;		/* some fs like FUSE needs it */
+		buf->file = sbi->dif0.file;	/* some fs like FUSE needs it */
 		buf->mapping = buf->file->f_mapping;
 	} else if (erofs_is_fscache_mode(sb))
 		buf->mapping = sbi->s_fscache->inode->i_mapping;
@@ -201,12 +201,8 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 	erofs_off_t startoff, length;
 	int id;
 
-	map->m_bdev = sb->s_bdev;
-	map->m_daxdev = EROFS_SB(sb)->dax_dev;
-	map->m_dax_part_off = EROFS_SB(sb)->dax_part_off;
-	map->m_fscache = EROFS_SB(sb)->s_fscache;
-	map->m_fp = EROFS_SB(sb)->fdev;
-
+	erofs_fill_from_devinfo(map, &EROFS_SB(sb)->dif0);
+	map->m_bdev = sb->s_bdev;	/* use s_bdev for the primary device */
 	if (map->m_deviceid) {
 		down_read(&devs->rwsem);
 		dif = idr_find(&devs->tree, map->m_deviceid - 1);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 1c847c30a918..6e91fcdeba94 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -107,6 +107,7 @@ struct erofs_xattr_prefix_item {
 };
 
 struct erofs_sb_info {
+	struct erofs_device_info dif0;
 	struct erofs_mount_opts opt;	/* options */
 #ifdef CONFIG_EROFS_FS_ZIP
 	/* list for all registered superblocks, mainly for shrinker */
@@ -124,13 +125,9 @@ struct erofs_sb_info {
 
 	struct erofs_sb_lz4_info lz4;
 #endif	/* CONFIG_EROFS_FS_ZIP */
-	struct file *fdev;
 	struct inode *packed_inode;
 	struct erofs_dev_context *devs;
-	struct dax_device *dax_dev;
-	u64 dax_part_off;
 	u64 total_blocks;
-	u32 primarydevice_blocks;
 
 	u32 meta_blkaddr;
 #ifdef CONFIG_EROFS_FS_XATTR
@@ -187,7 +184,7 @@ struct erofs_sb_info {
 
 static inline bool erofs_is_fileio_mode(struct erofs_sb_info *sbi)
 {
-	return IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) && sbi->fdev;
+	return IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) && sbi->dif0.file;
 }
 
 static inline bool erofs_is_fscache_mode(struct super_block *sb)
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 1ce5ca11d32b..934fb1513095 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -203,7 +203,7 @@ static int erofs_scan_devices(struct super_block *sb,
 	struct erofs_device_info *dif;
 	int id, err = 0;
 
-	sbi->total_blocks = sbi->primarydevice_blocks;
+	sbi->total_blocks = sbi->dif0.blocks;
 	if (!erofs_sb_has_device_table(sbi))
 		ondisk_extradevs = 0;
 	else
@@ -307,7 +307,7 @@ static int erofs_read_superblock(struct super_block *sb)
 			  sbi->sb_size);
 		goto out;
 	}
-	sbi->primarydevice_blocks = le32_to_cpu(dsb->blocks);
+	sbi->dif0.blocks = le32_to_cpu(dsb->blocks);
 	sbi->meta_blkaddr = le32_to_cpu(dsb->meta_blkaddr);
 #ifdef CONFIG_EROFS_FS_XATTR
 	sbi->xattr_blkaddr = le32_to_cpu(dsb->xattr_blkaddr);
@@ -602,9 +602,8 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 			return -EINVAL;
 		}
 
-		sbi->dax_dev = fs_dax_get_by_bdev(sb->s_bdev,
-						  &sbi->dax_part_off,
-						  NULL, NULL);
+		sbi->dif0.dax_dev = fs_dax_get_by_bdev(sb->s_bdev,
+				&sbi->dif0.dax_part_off, NULL, NULL);
 	}
 
 	err = erofs_read_superblock(sb);
@@ -627,7 +626,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	}
 
 	if (test_opt(&sbi->opt, DAX_ALWAYS)) {
-		if (!sbi->dax_dev) {
+		if (!sbi->dif0.dax_dev) {
 			errorfc(fc, "DAX unsupported by block device. Turning off DAX.");
 			clear_opt(&sbi->opt, DAX_ALWAYS);
 		} else if (sbi->blkszbits != PAGE_SHIFT) {
@@ -707,14 +706,13 @@ static int erofs_fc_get_tree(struct fs_context *fc)
 
 		if (!fc->source)
 			return invalf(fc, "No source specified");
-
 		file = filp_open(fc->source, O_RDONLY | O_LARGEFILE, 0);
 		if (IS_ERR(file))
 			return PTR_ERR(file);
-		sbi->fdev = file;
+		sbi->dif0.file = file;
 
-		if (S_ISREG(file_inode(sbi->fdev)->i_mode) &&
-		    sbi->fdev->f_mapping->a_ops->read_folio)
+		if (S_ISREG(file_inode(sbi->dif0.file)->i_mode) &&
+		    sbi->dif0.file->f_mapping->a_ops->read_folio)
 			return get_tree_nodev(fc, erofs_fc_fill_super);
 	}
 #endif
@@ -771,8 +769,8 @@ static void erofs_sb_free(struct erofs_sb_info *sbi)
 	erofs_free_dev_context(sbi->devs);
 	kfree(sbi->fsid);
 	kfree(sbi->domain_id);
-	if (sbi->fdev)
-		fput(sbi->fdev);
+	if (sbi->dif0.file)
+		fput(sbi->dif0.file);
 	kfree(sbi);
 }
 
@@ -817,11 +815,12 @@ static void erofs_kill_sb(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
-	if ((IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid) || sbi->fdev)
+	if ((IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid) ||
+	    sbi->dif0.file)
 		kill_anon_super(sb);
 	else
 		kill_block_super(sb);
-	fs_put_dax(sbi->dax_dev, NULL);
+	fs_put_dax(sbi->dif0.dax_dev, NULL);
 	erofs_fscache_unregister_fs(sb);
 	erofs_sb_free(sbi);
 	sb->s_fs_info = NULL;
-- 
2.43.5


