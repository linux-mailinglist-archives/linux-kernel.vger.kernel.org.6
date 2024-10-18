Return-Path: <linux-kernel+bounces-371028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0DA9A3558
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C8A11C2382A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 06:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FCF187FEA;
	Fri, 18 Oct 2024 06:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZP60lHE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D206118755F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 06:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729232811; cv=none; b=p10z7Ph6EfdKZS+GMM8omKDFFhUHA0XIV1kNgjcY6AgTSTyir+RjfALdkwVfbCfKOgWJCVdOKgvX5D+0zhedDL5GJiKBc6ucE4ew4PLo8jbvfiuWzx4tVd+0ThWqHQjsw9v3gytnknxExVwowQizFbdC9A4WYFE9H55vF8uikYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729232811; c=relaxed/simple;
	bh=29xKPT2f4WvFDNlKwJOT/T2nkzhUujZxCZronc8t5Ho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cL5USPGDu3IyXY+mpSWvU/cmFRsqA/+xFRwnIwibce7a7ncMV5LiN3qFK5kEsHrPNEhUdTnHFUhy4mm7r/SuUvWYWek9GxWJJhbJw2QvEdTwzujWjtUcId0q5Xx6acm3wiiW/AJyODaV+5OxUl9esOr1vSxpCLkVDsMnOh8OZGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZP60lHE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDDDC4CEC3;
	Fri, 18 Oct 2024 06:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729232811;
	bh=29xKPT2f4WvFDNlKwJOT/T2nkzhUujZxCZronc8t5Ho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JZP60lHEiUTNb7iX8ezSHM9FSIeRrDbnSWPX8dm782ij56p1n0Iy/7OoyWbYsooyg
	 U1bv7Tn5RRMxtIh19vCOBXdLek2KO02QXl9MmhT5DVyyNWkWcWnD2Nea9uMiCMkSWj
	 Wqhu2KUy/lhWUGqaVdzj28XNugMtwqrQSgtFhKugwBdVsh4qf2lqUb/V3seD2Vdkvb
	 MEuM/SWDbGQVfJ+EoR3uBDW8U/wRsP7UD64wyGwB4F/R6gZTnAdiYp2CFx+kgyy8Fc
	 JpWgoikS/1jFGNVue9cnGLryy4W3PWtaLcPffIAPXmsLs0YU6FaRE0/eMH9xP9gEAO
	 i65PK8JSYDEoQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 3/3] f2fs: support NOCoW flag
Date: Fri, 18 Oct 2024 14:26:38 +0800
Message-Id: <20241018062638.2619214-3-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241018062638.2619214-1-chao@kernel.org>
References: <20241018062638.2619214-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Overhead of pinfile is heavy due to:
1) GC tries to skip migrating section which contains pinfile's data
block, it will cost more time during GC,
2) and also it will take high risk when GC unpins file and migrates
it's data block once inode.i_gc_failure exceeds threshold.

This patch proposes to support NOCoW flag on inode, which has similar
semantics to pinfile:

			Pinfile			NOCoW
[Enable]
only regular		yes			yes
only empty file		yes			no
blkzoned=on,mode=lfs	Support			Support
blkzoned=off,mode=lfs	Not support		Not support

[fsync/wb/dio IO behavior]
block in regular device	IPU			IPU
block in zoned device	N/A			OPU

[Misc IO behavior]
GC			skip/OPU		OPU
defrag ioc/swapon	Not support		Support

If userspace doesn't need pinned physical block address for following
direct access, we can tag file w/ NOCoW flag instead of pinfile flag,
we will be benefit from it for below cases:
1) user's write won't fragment NOCoW file's data block due to IPU
2) GC/defrag/swapon won't fail on NOCoW file.

Please note that, this patch changes to not show NOCoW flag for a
pinned file, the logic is as below:

Before
			Pinned file
lsattr			C
f2fs_io pinfile get	pinned

After
			Pinned file		NOCoW file
lsattr			-			C
f2fs_io pinfile get	pinned			un-pinned

So, to consider backward compatibility, if NOCoW flag shown on a
target inode, we need to check pinned flag to see whether NOCoW
flag was really tagged or not.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 21 ++++++++++++++++++++-
 fs/f2fs/f2fs.h | 10 ++++++++--
 fs/f2fs/file.c | 22 ++++++++++++++++++----
 3 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c6d0e4aa12e3..b8ba97b2c11f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1636,7 +1636,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 	/* use out-place-update for direct IO under LFS mode */
 	if (map->m_may_create && (is_hole ||
 		(flag == F2FS_GET_BLOCK_DIO && f2fs_lfs_mode(sbi) &&
-		!f2fs_is_pinned_file(inode)))) {
+		!f2fs_is_pinned_file(inode) && !f2fs_is_nocow_file(inode)))) {
 		if (unlikely(f2fs_cp_error(sbi))) {
 			err = -EIO;
 			goto sync_out;
@@ -2636,6 +2636,11 @@ bool f2fs_should_update_inplace(struct inode *inode, struct f2fs_io_info *fio)
 	if (file_is_cold(inode) && !is_inode_flag_set(inode, FI_OPU_WRITE))
 		return true;
 
+	/* allows NOCoW file to be migrated during defragmentation and swapon */
+	if (f2fs_is_nocow_file(inode) &&
+		!is_inode_flag_set(inode, FI_OPU_WRITE))
+		return true;
+
 	return check_inplace_update_policy(inode, fio);
 }
 
@@ -2658,6 +2663,9 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
 					sbi->first_zoned_segno)
 			return true;
 	}
+	/* should check NOCoW flag after lfs_mode check condition */
+	if (f2fs_is_nocow_file(inode))
+		return false;
 	if (S_ISDIR(inode->i_mode))
 		return true;
 	if (IS_NOQUOTA(inode))
@@ -2722,11 +2730,22 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 						DATA_GENERIC_ENHANCE))
 			return -EFSCORRUPTED;
 
+		/*
+		 * if data block of NOCoW inode locates in sequential-zone,
+		 * let's trigger OPU.
+		 */
+		if (f2fs_is_nocow_file(inode) &&
+			f2fs_blkzoned_has_regular_section(fio->sbi) &&
+			GET_SEGNO(fio->sbi, fio->old_blkaddr) >=
+					fio->sbi->first_zoned_segno)
+			goto get_dnode;
+
 		ipu_force = true;
 		fio->need_lock = LOCK_DONE;
 		goto got_it;
 	}
 
+get_dnode:
 	/* Deadlock due to between page->lock and f2fs_lock_op */
 	if (fio->need_lock == LOCK_REQ && !f2fs_trylock_op(fio->sbi))
 		return -EAGAIN;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6781b4fab43f..9b7fa960cd8b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3047,6 +3047,7 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
 #define F2FS_NOCOMP_FL			0x00000400 /* Don't compress */
 #define F2FS_INDEX_FL			0x00001000 /* hash-indexed directory */
 #define F2FS_DIRSYNC_FL			0x00010000 /* dirsync behaviour (directories only) */
+#define F2FS_NOCOW_FL			0x00800000 /* Do not cow file */
 #define F2FS_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
 #define F2FS_CASEFOLD_FL		0x40000000 /* Casefolded file */
 #define F2FS_DEVICE_ALIAS_FL		0x80000000 /* File for aliasing a device */
@@ -3332,6 +3333,11 @@ static inline bool f2fs_is_cow_file(struct inode *inode)
 	return is_inode_flag_set(inode, FI_COW_FILE);
 }
 
+static inline bool f2fs_is_nocow_file(struct inode *inode)
+{
+	return F2FS_I(inode)->i_flags & F2FS_NOCOW_FL;
+}
+
 static inline void *inline_data_addr(struct inode *inode, struct page *page)
 {
 	__le32 *addr = get_dnode_addr(inode, page);
@@ -4658,8 +4664,8 @@ static inline bool f2fs_low_mem_mode(struct f2fs_sb_info *sbi)
 static inline bool f2fs_may_compress(struct inode *inode)
 {
 	if (IS_SWAPFILE(inode) || f2fs_is_pinned_file(inode) ||
-		f2fs_is_atomic_file(inode) || f2fs_has_inline_data(inode) ||
-		f2fs_is_mmap_file(inode))
+		f2fs_is_nocow_file(inode) || f2fs_is_atomic_file(inode) ||
+		f2fs_has_inline_data(inode) || f2fs_is_mmap_file(inode))
 		return false;
 	return S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode);
 }
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 92d7c62eba29..580609223799 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1998,6 +1998,20 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 	if (IS_NOQUOTA(inode))
 		return -EPERM;
 
+	if ((iflags ^ masked_flags) & F2FS_NOCOW_FL) {
+		if (iflags & F2FS_NOCOW_FL) {
+			int ret;
+
+			if (!S_ISREG(inode->i_mode))
+				return -EINVAL;
+			if (f2fs_should_update_outplace(inode, NULL))
+				return -EINVAL;
+			ret = f2fs_convert_inline_inode(inode);
+			if (ret)
+				return ret;
+		}
+	}
+
 	if ((iflags ^ masked_flags) & F2FS_CASEFOLD_FL) {
 		if (!f2fs_sb_has_casefold(F2FS_I_SB(inode)))
 			return -EOPNOTSUPP;
@@ -2077,6 +2091,7 @@ static const struct {
 	{ F2FS_NOCOMP_FL,	FS_NOCOMP_FL },
 	{ F2FS_INDEX_FL,	FS_INDEX_FL },
 	{ F2FS_DIRSYNC_FL,	FS_DIRSYNC_FL },
+	{ F2FS_NOCOW_FL,	FS_NOCOW_FL },
 	{ F2FS_PROJINHERIT_FL,	FS_PROJINHERIT_FL },
 	{ F2FS_CASEFOLD_FL,	FS_CASEFOLD_FL },
 };
@@ -2108,7 +2123,8 @@ static const struct {
 		FS_NOCOMP_FL |		\
 		FS_DIRSYNC_FL |		\
 		FS_PROJINHERIT_FL |	\
-		FS_CASEFOLD_FL)
+		FS_CASEFOLD_FL |	\
+		FS_NOCOW_FL)
 
 /* Convert f2fs on-disk i_flags to FS_IOC_{GET,SET}FLAGS flags */
 static inline u32 f2fs_iflags_to_fsflags(u32 iflags)
@@ -2171,7 +2187,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 	inode_lock(inode);
 
 	if (!f2fs_disable_compressed_file(inode) ||
-			f2fs_is_pinned_file(inode)) {
+		f2fs_is_pinned_file(inode) || f2fs_is_nocow_file(inode)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -3273,8 +3289,6 @@ int f2fs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 		fsflags |= FS_VERITY_FL;
 	if (f2fs_has_inline_data(inode) || f2fs_has_inline_dentry(inode))
 		fsflags |= FS_INLINE_DATA_FL;
-	if (is_inode_flag_set(inode, FI_PIN_FILE))
-		fsflags |= FS_NOCOW_FL;
 
 	fileattr_fill_flags(fa, fsflags & F2FS_GETTABLE_FS_FL);
 
-- 
2.40.1


