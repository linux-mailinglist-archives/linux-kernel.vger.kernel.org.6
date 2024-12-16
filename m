Return-Path: <linux-kernel+bounces-447346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9454A9F30F1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3F6167699
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163CC2054FF;
	Mon, 16 Dec 2024 12:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SeelnLkj"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6601F204C2C
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734353604; cv=none; b=lxZmSvRouBhxVhGg/BlTuh9uaTtDD0rXNjtstJ1ywDm84S9t7U7OtRrLukPAnA4L/Gz75993e5siKHDx+9NH/gE+B0nTI570oe7ahHZzRh3hsFb8DAMeAbpmMBNRaCWtsnUPITr2pQ5TEJAMf1LPUZYJhEOxhzuZ99VnofoPZ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734353604; c=relaxed/simple;
	bh=mZ+JgoveWNeWT7SqOIoPyzKOJirJRI2+wU25YXY5F78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DFfi+OLfkM0aOTAN2HuTUMMgvDf/d+D7WP9kYKHrgb0ksF+0y4DmurkO9nQUz7WNRDWVOnDO+vO20R9b4pgiFsMosndWTR0octUXucdEg8mPWqrQdwUVD7ZNrMclu1Bm8i6laYzrr3W6Dd2VnQAw7PNngdqeD5CD+711TA91r+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SeelnLkj; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734353598; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=PqTCnmya6pJ/BUWy1H3GyVZP6YqSpAKVxcHFV//6xNs=;
	b=SeelnLkj3MluSbxkT3sLNGCvhs4BlQynAUwlFea9ycCj2UFuemPJnIOz0tfw6vXGbLtS02ImKYVt9aS45cQbwIfM+JDU9KqJnvBQReVjBLzCl+aPZ0VNTkTkMuwgAiahx3ouO2FmOlMLeIioXb06ZxiuS0UVk+09qZguHCbhcdk=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLcksLx_1734353597 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 16 Dec 2024 20:53:18 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v3 2/4] erofs: use `struct erofs_device_info` for the primary device
Date: Mon, 16 Dec 2024 20:53:08 +0800
Message-ID: <20241216125310.930933-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241216125310.930933-1-hsiangkao@linux.alibaba.com>
References: <20241216125310.930933-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of just listing each one directly in `struct erofs_sb_info`
except that we still use `sb->s_bdev` for the primary block device.

Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
changes since v1:
 - forgot to convert `sbi->s_fscache` which impacts fscache functionality.

 fs/erofs/data.c     | 12 ++++--------
 fs/erofs/fscache.c  |  6 +++---
 fs/erofs/internal.h |  8 ++------
 fs/erofs/super.c    | 27 +++++++++++++--------------
 4 files changed, 22 insertions(+), 31 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 1c49f8962021..622017c65958 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -56,10 +56,10 @@ void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
 
 	buf->file = NULL;
 	if (erofs_is_fileio_mode(sbi)) {
-		buf->file = sbi->fdev;		/* some fs like FUSE needs it */
+		buf->file = sbi->dif0.file;	/* some fs like FUSE needs it */
 		buf->mapping = buf->file->f_mapping;
 	} else if (erofs_is_fscache_mode(sb))
-		buf->mapping = sbi->s_fscache->inode->i_mapping;
+		buf->mapping = sbi->dif0.fscache->inode->i_mapping;
 	else
 		buf->mapping = sb->s_bdev->bd_mapping;
 }
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
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index fda16eedafb5..ce7e38c82719 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -657,7 +657,7 @@ int erofs_fscache_register_fs(struct super_block *sb)
 	if (IS_ERR(fscache))
 		return PTR_ERR(fscache);
 
-	sbi->s_fscache = fscache;
+	sbi->dif0.fscache = fscache;
 	return 0;
 }
 
@@ -665,14 +665,14 @@ void erofs_fscache_unregister_fs(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
-	erofs_fscache_unregister_cookie(sbi->s_fscache);
+	erofs_fscache_unregister_cookie(sbi->dif0.fscache);
 
 	if (sbi->domain)
 		erofs_fscache_domain_put(sbi->domain);
 	else
 		fscache_relinquish_volume(sbi->volume, NULL, false);
 
-	sbi->s_fscache = NULL;
+	sbi->dif0.fscache = NULL;
 	sbi->volume = NULL;
 	sbi->domain = NULL;
 }
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 1c847c30a918..3e8d71d516f4 100644
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
@@ -166,7 +163,6 @@ struct erofs_sb_info {
 
 	/* fscache support */
 	struct fscache_volume *volume;
-	struct erofs_fscache *s_fscache;
 	struct erofs_domain *domain;
 	char *fsid;
 	char *domain_id;
@@ -187,7 +183,7 @@ struct erofs_sb_info {
 
 static inline bool erofs_is_fileio_mode(struct erofs_sb_info *sbi)
 {
-	return IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) && sbi->fdev;
+	return IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) && sbi->dif0.file;
 }
 
 static inline bool erofs_is_fscache_mode(struct super_block *sb)
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index de8e3ecc6381..9044907354e1 100644
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


