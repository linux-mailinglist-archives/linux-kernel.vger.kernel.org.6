Return-Path: <linux-kernel+bounces-306532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA63C96402F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1D74287508
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EDF18E047;
	Thu, 29 Aug 2024 09:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LkupgfH/"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1909718CBF8
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724923924; cv=none; b=JcrljVIwuSjeQO0lQjvDXpy0NxfGcKd9vDP4O21PBJuamIg6MKI+/xHmILeFOZ8fTr7NM0ia+UvjTKCkVBFgwDHnNZAaOnFWV53kdqyktaCOEzEB8QlhHMnXBXJkc6gL930wlI+UfShcpVtAjGy5meOENI6f8eEYTVLX3yFc1I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724923924; c=relaxed/simple;
	bh=uje8kyyDniWsx2sD49nlmJpU1APk5MnbprQYuKcuVUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FPD1en5jdVEXfc63Mb/dLBW9fhyHi6l269PPeM/nVkrbvRoVdCUYt9B81RGmqSrlcp2kTNNPoAgpZPoLEZyUjmZdijEU+Q3slqDv20kbCiSlufLt1ZaSy+L1//b94d0Iu8xwv2FSGt3rTki3zr3yis2MiIGOrArQEBJpu8bW98g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LkupgfH/; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724923918; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=VCxnTziBmt+9PeXVXOPKFs9Zna8WaKnYz7VhDueS+QU=;
	b=LkupgfH/D2t/xOlvYn0rFtjJL2Y2m7Au1K3/JwO6UQ1LvFNMIlsDqkmpvVdGabtblPSWyly9kZ0XlCuFiH7coqMx33ZBCBq8s9S73Da3NUeHNASfkBtzuvQ7/AUYfN7vZHDRxPmmYPgpsRnJ/bqgTTE9twxHTlisyvIOUxaNGyA=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDsbXF2_1724923575)
          by smtp.aliyun-inc.com;
          Thu, 29 Aug 2024 17:26:41 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/4] erofs: add file-backed mount support
Date: Thu, 29 Aug 2024 17:26:11 +0800
Message-ID: <20240829092614.2382457-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It actually has been around for years: For containers and other sandbox
use cases, there will be thousands (and even more) of authenticated
(sub)images running on the same host, unlike OS images.

Of course, all scenarios can use the same EROFS on-disk format, but
bdev-backed mounts just work well for OS images since golden data is
dumped into real block devices.  However, it's somewhat hard for
container runtimes to manage and isolate so many unnecessary virtual
block devices safely and efficiently [1]: they just look like a burden
to orchestrators and file-backed mounts are preferred indeed.  There
were already enough attempts such as Incremental FS, the original
ComposeFS and PuzzleFS acting in the same way for immutable fses.  As
for current EROFS users, ComposeFS, containerd and Android APEXs will
be directly benefited from it.

On the other hand, previous experimental feature "erofs over fscache"
was once also intended to provide a similar solution (inspired by
Incremental FS discussion [2]), but the following facts show file-backed
mounts will be a better approach:
 - Fscache infrastructure has recently been moved into new Netfslib
   which is an unexpected dependency to EROFS really, although it
   originally claims "it could be used for caching other things such as
   ISO9660 filesystems too." [3]

 - It takes an unexpectedly long time to upstream Fscache/Cachefiles
   enhancements.  For example, the failover feature took more than
   one year, and the deamonless feature is still far behind now;

 - Ongoing HSM "fanotify pre-content hooks" [4] together with this will
   perfectly supersede "erofs over fscache" in a simpler way since
   developers (mainly containerd folks) could leverage their existing
   caching mechanism entirely in userspace instead of strictly following
   the predefined in-kernel caching tree hierarchy.

After "fanotify pre-content hooks" lands upstream to provide the same
functionality, "erofs over fscache" will be removed then (as an EROFS
internal improvement and EROFS will not have to bother with on-demand
fetching and/or caching improvements anymore.)

[1] https://github.com/containers/storage/pull/2039
[2] https://lore.kernel.org/r/CAOQ4uxjbVxnubaPjVaGYiSwoGDTdpWbB=w_AeM6YM=zVixsUfQ@mail.gmail.com
[3] https://docs.kernel.org/filesystems/caching/fscache.html
[4] https://lore.kernel.org/r/cover.1723670362.git.josef@toxicpanda.com
Closes: https://github.com/containers/composefs/issues/144
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/Kconfig    | 17 +++++++++++
 fs/erofs/data.c     | 35 ++++++++++++---------
 fs/erofs/inode.c    |  5 ++-
 fs/erofs/internal.h | 11 +++++--
 fs/erofs/super.c    | 74 +++++++++++++++++++++++++++++----------------
 5 files changed, 99 insertions(+), 43 deletions(-)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 7dcdce660cac..1428d0530e1c 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -74,6 +74,23 @@ config EROFS_FS_SECURITY
 
 	  If you are not using a security module, say N.
 
+config EROFS_FS_BACKED_BY_FILE
+	bool "File-backed EROFS filesystem support"
+	depends on EROFS_FS
+	default y
+	help
+	  This allows EROFS to use filesystem image files directly, without
+	  the intercession of loopback block devices or likewise. It is
+	  particularly useful for container images with numerous blobs and
+	  other sandboxes, where loop devices behave intricately.  It can also
+	  be used to simplify error-prone lifetime management of unnecessary
+	  virtual block devices.
+
+	  Note that this feature, along with ongoing fanotify pre-content
+	  hooks, will eventually replace "EROFS over fscache."
+
+	  If you don't want to enable this feature, say N.
+
 config EROFS_FS_ZIP
 	bool "EROFS Data Compression Support"
 	depends on EROFS_FS
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 1b7eba38ba1e..0fb31c588ae0 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -59,8 +59,12 @@ void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset,
 
 void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
 {
-	if (erofs_is_fscache_mode(sb))
-		buf->mapping = EROFS_SB(sb)->s_fscache->inode->i_mapping;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+
+	if (erofs_is_fileio_mode(sbi))
+		buf->mapping = file_inode(sbi->fdev)->i_mapping;
+	else if (erofs_is_fscache_mode(sb))
+		buf->mapping = sbi->s_fscache->inode->i_mapping;
 	else
 		buf->mapping = sb->s_bdev->bd_mapping;
 }
@@ -189,10 +193,22 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
 	return err;
 }
 
+static void erofs_fill_from_devinfo(struct erofs_map_dev *map,
+				    struct erofs_device_info *dif)
+{
+	map->m_bdev = NULL;
+	if (dif->file && S_ISBLK(file_inode(dif->file)->i_mode))
+		map->m_bdev = file_bdev(dif->file);
+	map->m_daxdev = dif->dax_dev;
+	map->m_dax_part_off = dif->dax_part_off;
+	map->m_fscache = dif->fscache;
+}
+
 int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 {
 	struct erofs_dev_context *devs = EROFS_SB(sb)->devs;
 	struct erofs_device_info *dif;
+	erofs_off_t startoff, length;
 	int id;
 
 	map->m_bdev = sb->s_bdev;
@@ -212,29 +228,20 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 			up_read(&devs->rwsem);
 			return 0;
 		}
-		map->m_bdev = dif->bdev_file ? file_bdev(dif->bdev_file) : NULL;
-		map->m_daxdev = dif->dax_dev;
-		map->m_dax_part_off = dif->dax_part_off;
-		map->m_fscache = dif->fscache;
+		erofs_fill_from_devinfo(map, dif);
 		up_read(&devs->rwsem);
 	} else if (devs->extra_devices && !devs->flatdev) {
 		down_read(&devs->rwsem);
 		idr_for_each_entry(&devs->tree, dif, id) {
-			erofs_off_t startoff, length;
-
 			if (!dif->mapped_blkaddr)
 				continue;
+
 			startoff = erofs_pos(sb, dif->mapped_blkaddr);
 			length = erofs_pos(sb, dif->blocks);
-
 			if (map->m_pa >= startoff &&
 			    map->m_pa < startoff + length) {
 				map->m_pa -= startoff;
-				map->m_bdev = dif->bdev_file ?
-					      file_bdev(dif->bdev_file) : NULL;
-				map->m_daxdev = dif->dax_dev;
-				map->m_dax_part_off = dif->dax_part_off;
-				map->m_fscache = dif->fscache;
+				erofs_fill_from_devinfo(map, dif);
 				break;
 			}
 		}
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 419432be3223..d05b9e59f122 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -258,7 +258,10 @@ static int erofs_fill_inode(struct inode *inode)
 	}
 
 	mapping_set_large_folios(inode->i_mapping);
-	if (erofs_inode_is_data_compressed(vi->datalayout)) {
+	if (erofs_is_fileio_mode(EROFS_SB(inode->i_sb))) {
+		/* XXX: data I/Os will be implemented in the following patches */
+		err = -EOPNOTSUPP;
+	} else if (erofs_inode_is_data_compressed(vi->datalayout)) {
 #ifdef CONFIG_EROFS_FS_ZIP
 		DO_ONCE_LITE_IF(inode->i_blkbits != PAGE_SHIFT,
 			  erofs_info, inode->i_sb,
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 45dc15ebd870..9bf4fb1cfa09 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -49,7 +49,7 @@ typedef u32 erofs_blk_t;
 struct erofs_device_info {
 	char *path;
 	struct erofs_fscache *fscache;
-	struct file *bdev_file;
+	struct file *file;
 	struct dax_device *dax_dev;
 	u64 dax_part_off;
 
@@ -130,6 +130,7 @@ struct erofs_sb_info {
 
 	struct erofs_sb_lz4_info lz4;
 #endif	/* CONFIG_EROFS_FS_ZIP */
+	struct file *fdev;
 	struct inode *packed_inode;
 	struct erofs_dev_context *devs;
 	struct dax_device *dax_dev;
@@ -190,9 +191,15 @@ struct erofs_sb_info {
 #define set_opt(opt, option)	((opt)->mount_opt |= EROFS_MOUNT_##option)
 #define test_opt(opt, option)	((opt)->mount_opt & EROFS_MOUNT_##option)
 
+static inline bool erofs_is_fileio_mode(struct erofs_sb_info *sbi)
+{
+	return IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) && sbi->fdev;
+}
+
 static inline bool erofs_is_fscache_mode(struct super_block *sb)
 {
-	return IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && !sb->s_bdev;
+	return IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) &&
+			!erofs_is_fileio_mode(EROFS_SB(sb)) && !sb->s_bdev;
 }
 
 enum {
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index aae3fd15899a..8e92ad3fbead 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -10,6 +10,7 @@
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
 #include <linux/exportfs.h>
+#include <linux/backing-dev.h>
 #include "xattr.h"
 
 #define CREATE_TRACE_POINTS
@@ -161,7 +162,7 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	struct erofs_fscache *fscache;
 	struct erofs_deviceslot *dis;
-	struct file *bdev_file;
+	struct file *file;
 
 	dis = erofs_read_metabuf(buf, sb, *pos, EROFS_KMAP);
 	if (IS_ERR(dis))
@@ -183,13 +184,17 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 			return PTR_ERR(fscache);
 		dif->fscache = fscache;
 	} else if (!sbi->devs->flatdev) {
-		bdev_file = bdev_file_open_by_path(dif->path, BLK_OPEN_READ,
-						sb->s_type, NULL);
-		if (IS_ERR(bdev_file))
-			return PTR_ERR(bdev_file);
-		dif->bdev_file = bdev_file;
-		dif->dax_dev = fs_dax_get_by_bdev(file_bdev(bdev_file),
-				&dif->dax_part_off, NULL, NULL);
+		file = erofs_is_fileio_mode(sbi) ?
+				filp_open(dif->path, O_RDONLY, 0) :
+				bdev_file_open_by_path(dif->path,
+						BLK_OPEN_READ, sb->s_type, NULL);
+		if (IS_ERR(file))
+			return PTR_ERR(file);
+
+		dif->file = file;
+		if (!erofs_is_fileio_mode(sbi))
+			dif->dax_dev = fs_dax_get_by_bdev(file_bdev(file),
+					&dif->dax_part_off, NULL, NULL);
 	}
 
 	dif->blocks = le32_to_cpu(dis->blocks);
@@ -566,15 +571,16 @@ static void erofs_set_sysfs_name(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
-	if (erofs_is_fscache_mode(sb)) {
-		if (sbi->domain_id)
-			super_set_sysfs_name_generic(sb, "%s,%s",sbi->domain_id,
-						     sbi->fsid);
-		else
-			super_set_sysfs_name_generic(sb, "%s", sbi->fsid);
-		return;
-	}
-	super_set_sysfs_name_id(sb);
+	if (sbi->domain_id)
+		super_set_sysfs_name_generic(sb, "%s,%s", sbi->domain_id,
+					     sbi->fsid);
+	else if (sbi->fsid)
+		super_set_sysfs_name_generic(sb, "%s", sbi->fsid);
+	else if (erofs_is_fileio_mode(sbi))
+		super_set_sysfs_name_generic(sb, "%s",
+					     bdi_dev_name(sb->s_bdi));
+	else
+		super_set_sysfs_name_id(sb);
 }
 
 static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
@@ -589,14 +595,15 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_op = &erofs_sops;
 
 	sbi->blkszbits = PAGE_SHIFT;
-	if (erofs_is_fscache_mode(sb)) {
+	if (!sb->s_bdev) {
 		sb->s_blocksize = PAGE_SIZE;
 		sb->s_blocksize_bits = PAGE_SHIFT;
 
-		err = erofs_fscache_register_fs(sb);
-		if (err)
-			return err;
-
+		if (erofs_is_fscache_mode(sb)) {
+			err = erofs_fscache_register_fs(sb);
+			if (err)
+				return err;
+		}
 		err = super_setup_bdi(sb);
 		if (err)
 			return err;
@@ -693,11 +700,24 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 static int erofs_fc_get_tree(struct fs_context *fc)
 {
 	struct erofs_sb_info *sbi = fc->s_fs_info;
+	int ret;
 
 	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
 		return get_tree_nodev(fc, erofs_fc_fill_super);
 
-	return get_tree_bdev(fc, erofs_fc_fill_super);
+	ret = get_tree_bdev(fc, erofs_fc_fill_super);
+#ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
+	if (ret == -ENOTBLK) {
+		if (!fc->source)
+			return invalf(fc, "No source specified");
+		sbi->fdev = filp_open(fc->source, O_RDONLY, 0);
+		if (IS_ERR(sbi->fdev))
+			return PTR_ERR(sbi->fdev);
+
+		return get_tree_nodev(fc, erofs_fc_fill_super);
+	}
+#endif
+	return ret;
 }
 
 static int erofs_fc_reconfigure(struct fs_context *fc)
@@ -727,8 +747,8 @@ static int erofs_release_device_info(int id, void *ptr, void *data)
 	struct erofs_device_info *dif = ptr;
 
 	fs_put_dax(dif->dax_dev, NULL);
-	if (dif->bdev_file)
-		fput(dif->bdev_file);
+	if (dif->file)
+		fput(dif->file);
 	erofs_fscache_unregister_cookie(dif->fscache);
 	dif->fscache = NULL;
 	kfree(dif->path);
@@ -801,6 +821,8 @@ static void erofs_kill_sb(struct super_block *sb)
 	erofs_fscache_unregister_fs(sb);
 	kfree(sbi->fsid);
 	kfree(sbi->domain_id);
+	if (sbi->fdev)
+		fput(sbi->fdev);
 	kfree(sbi);
 	sb->s_fs_info = NULL;
 }
@@ -903,7 +925,7 @@ static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_namelen = EROFS_NAME_LEN;
 
 	if (uuid_is_null(&sb->s_uuid))
-		buf->f_fsid = u64_to_fsid(erofs_is_fscache_mode(sb) ? 0 :
+		buf->f_fsid = u64_to_fsid(!sb->s_bdev ? 0 :
 				huge_encode_dev(sb->s_bdev->bd_dev));
 	else
 		buf->f_fsid = uuid_to_fsid(sb->s_uuid.b);
-- 
2.43.5


