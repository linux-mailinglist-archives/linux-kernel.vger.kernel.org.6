Return-Path: <linux-kernel+bounces-510390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB70A31C20
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CE177A3B13
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 02:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0C91D63C4;
	Wed, 12 Feb 2025 02:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkKnt5vv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763F2288B1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 02:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739327730; cv=none; b=kH0temC4x9ZT6Xjfq1Mbb19dXSnf+jNXwm44lc/70q+uENqFd8qFngW7hP/ZyPi/ELzFTV1cNO+Syh0XpWXA5LFOtt2OHuKqxj/Zo6NWsqMeyu3JQF7N1HWQIBmsYsJY/8OGuZfPo+gSf/nBMxAePkMJQzWBnGekDvRcvGXX04o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739327730; c=relaxed/simple;
	bh=523usukJQiQ4zNcD63qCVaINbRFHn+sdeIQlaijqliQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uCOn7+ygxGh9kkvEh0wZWgvXVDN1OF5HQRLpJxUyF5/foVakJRkb7lVd1gVYHsYSdoYfEpSdZzhAuporZZongsi5MbnteiQJ9xiT9D0m3+sDjmtpMEL92chSJBMWU4NTy58tCRGpxj+rvEs5LDZuE6MWaQb78o6I3R3BBXVKAgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkKnt5vv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB5CC4CEDD;
	Wed, 12 Feb 2025 02:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739327730;
	bh=523usukJQiQ4zNcD63qCVaINbRFHn+sdeIQlaijqliQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YkKnt5vvGa/xIPlVfKDMouO+DK9lMgbn5SFP0stiRCTSMFckyKCgBEAz6A1AfAiu7
	 JVSAQBZbtnrIrHeos5jVEkdK1sFL37wBrqLPVXxzJebsGx+k3hQYFvzthsp61kxeMK
	 g/T32gFkgIm4luPXvKPcmF/7DO4IT/r20ZjE51zdvyr2z6o7pBhhbwDKfXoPiZpVKk
	 dOPUU7pgy8R8RlZkB4lI6MytmpotL07AWneL8xhg6ggYzog2ApVjBO31HTELfbVFMG
	 lSzfc2DggZ59WbB48BP/KsIRj8+hiT25bTARBnzvikGWWrCdl96EiE/ergZ2cg9NOr
	 v0R9xtuAcabZQ==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: keep POSIX_FADV_NOREUSE ranges
Date: Wed, 12 Feb 2025 02:31:56 +0000
Message-ID: <20250212023518.897942-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250212023518.897942-1-jaegeuk@kernel.org>
References: <20250212023518.897942-1-jaegeuk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch records POSIX_FADV_NOREUSE ranges for users to reclaim the caches
instantly off from LRU.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/debug.c |  3 +++
 fs/f2fs/f2fs.h  | 12 +++++++++-
 fs/f2fs/file.c  | 60 ++++++++++++++++++++++++++++++++++++++++++++-----
 fs/f2fs/inode.c | 14 ++++++++++++
 fs/f2fs/super.c |  1 +
 5 files changed, 84 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 468828288a4a..16c2dfb4f595 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -164,6 +164,7 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->ndirty_imeta = get_pages(sbi, F2FS_DIRTY_IMETA);
 	si->ndirty_dirs = sbi->ndirty_inode[DIR_INODE];
 	si->ndirty_files = sbi->ndirty_inode[FILE_INODE];
+	si->ndonate_files = sbi->donate_files;
 	si->nquota_files = sbi->nquota_files;
 	si->ndirty_all = sbi->ndirty_inode[DIRTY_META];
 	si->aw_cnt = atomic_read(&sbi->atomic_files);
@@ -501,6 +502,8 @@ static int stat_show(struct seq_file *s, void *v)
 			   si->compr_inode, si->compr_blocks);
 		seq_printf(s, "  - Swapfile Inode: %u\n",
 			   si->swapfile_inode);
+		seq_printf(s, "  - Donate Inode: %u\n",
+			   si->ndonate_files);
 		seq_printf(s, "  - Orphan/Append/Update Inode: %u, %u, %u\n",
 			   si->orphans, si->append, si->update);
 		seq_printf(s, "\nMain area: %d segs, %d secs %d zones\n",
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 395f9d37449c..3abcb84a0d47 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -850,6 +850,11 @@ struct f2fs_inode_info {
 #endif
 	struct list_head dirty_list;	/* dirty list for dirs and files */
 	struct list_head gdirty_list;	/* linked in global dirty list */
+
+	/* linked in global inode list for cache donation */
+	struct list_head gdonate_list;
+	pgoff_t donate_start, donate_end; /* inclusive */
+
 	struct task_struct *atomic_write_task;	/* store atomic write task */
 	struct extent_tree *extent_tree[NR_EXTENT_CACHES];
 					/* cached extent_tree entry */
@@ -1274,6 +1279,7 @@ enum inode_type {
 	DIR_INODE,			/* for dirty dir inode */
 	FILE_INODE,			/* for dirty regular/symlink inode */
 	DIRTY_META,			/* for all dirtied inode metadata */
+	DONATE_INODE,			/* for all inode to donate pages */
 	NR_INODE_TYPE,
 };
 
@@ -1629,6 +1635,9 @@ struct f2fs_sb_info {
 	unsigned int warm_data_age_threshold;
 	unsigned int last_age_weight;
 
+	/* control donate caches */
+	unsigned int donate_files;
+
 	/* basic filesystem units */
 	unsigned int log_sectors_per_block;	/* log2 sectors per block */
 	unsigned int log_blocksize;		/* log2 block size */
@@ -3968,7 +3977,8 @@ struct f2fs_stat_info {
 	unsigned long long allocated_data_blocks;
 	int ndirty_node, ndirty_dent, ndirty_meta, ndirty_imeta;
 	int ndirty_data, ndirty_qdata;
-	unsigned int ndirty_dirs, ndirty_files, nquota_files, ndirty_all;
+	unsigned int ndirty_dirs, ndirty_files, ndirty_all;
+	unsigned int nquota_files, ndonate_files;
 	int nats, dirty_nats, sits, dirty_sits;
 	int free_nids, avail_nids, alloc_nids;
 	int total_count, utilization;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f2f298c75921..014cb7660a9a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2450,6 +2450,52 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 	return ret;
 }
 
+static void f2fs_keep_noreuse_range(struct inode *inode,
+				loff_t offset, loff_t len)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	u64 max_bytes = F2FS_BLK_TO_BYTES(max_file_blocks(inode));
+	u64 start, end;
+
+	if (!S_ISREG(inode->i_mode))
+		return;
+
+	if (offset >= max_bytes || len > max_bytes ||
+	    (offset + len) > max_bytes)
+		return;
+
+	start = offset >> PAGE_SHIFT;
+	end = DIV_ROUND_UP(offset + len, PAGE_SIZE);
+
+	inode_lock(inode);
+	if (f2fs_is_atomic_file(inode)) {
+		inode_unlock(inode);
+		return;
+	}
+
+	spin_lock(&sbi->inode_lock[DONATE_INODE]);
+	/* let's remove the range, if len = 0 */
+	if (!len) {
+		if (!list_empty(&F2FS_I(inode)->gdonate_list)) {
+			list_del_init(&F2FS_I(inode)->gdonate_list);
+			sbi->donate_files--;
+		}
+	} else {
+		if (list_empty(&F2FS_I(inode)->gdonate_list)) {
+			list_add_tail(&F2FS_I(inode)->gdonate_list,
+					&sbi->inode_list[DONATE_INODE]);
+			sbi->donate_files++;
+		} else {
+			list_move_tail(&F2FS_I(inode)->gdonate_list,
+					&sbi->inode_list[DONATE_INODE]);
+		}
+		F2FS_I(inode)->donate_start = start;
+		F2FS_I(inode)->donate_end = end - 1;
+	}
+	spin_unlock(&sbi->inode_lock[DONATE_INODE]);
+	inode_unlock(inode);
+}
+
 static int f2fs_ioc_fitrim(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -5168,12 +5214,16 @@ static int f2fs_file_fadvise(struct file *filp, loff_t offset, loff_t len,
 	}
 
 	err = generic_fadvise(filp, offset, len, advice);
-	if (!err && advice == POSIX_FADV_DONTNEED &&
-		test_opt(F2FS_I_SB(inode), COMPRESS_CACHE) &&
-		f2fs_compressed_file(inode))
-		f2fs_invalidate_compress_pages(F2FS_I_SB(inode), inode->i_ino);
+	if (err)
+		return err;
 
-	return err;
+	if (advice == POSIX_FADV_DONTNEED &&
+	    (test_opt(F2FS_I_SB(inode), COMPRESS_CACHE) &&
+	     f2fs_compressed_file(inode)))
+		f2fs_invalidate_compress_pages(F2FS_I_SB(inode), inode->i_ino);
+	else if (advice == POSIX_FADV_NOREUSE)
+		f2fs_keep_noreuse_range(inode, offset, len);
+	return 0;
 }
 
 #ifdef CONFIG_COMPAT
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 3f03b1c9b7f1..543fb942bec1 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -814,6 +814,19 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
 	return 0;
 }
 
+static void f2fs_remove_donate_inode(struct inode *inode)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+
+	if (list_empty(&F2FS_I(inode)->gdonate_list))
+		return;
+
+	spin_lock(&sbi->inode_lock[DONATE_INODE]);
+	list_del_init(&F2FS_I(inode)->gdonate_list);
+	sbi->donate_files--;
+	spin_unlock(&sbi->inode_lock[DONATE_INODE]);
+}
+
 /*
  * Called at the last iput() if i_nlink is zero
  */
@@ -848,6 +861,7 @@ void f2fs_evict_inode(struct inode *inode)
 
 	f2fs_bug_on(sbi, get_dirty_pages(inode));
 	f2fs_remove_dirty_inode(inode);
+	f2fs_remove_donate_inode(inode);
 
 	if (!IS_DEVICE_ALIASING(inode))
 		f2fs_destroy_extent_tree(inode);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 759b642991d4..f5c69cc2de72 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1441,6 +1441,7 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	spin_lock_init(&fi->i_size_lock);
 	INIT_LIST_HEAD(&fi->dirty_list);
 	INIT_LIST_HEAD(&fi->gdirty_list);
+	INIT_LIST_HEAD(&fi->gdonate_list);
 	init_f2fs_rwsem(&fi->i_gc_rwsem[READ]);
 	init_f2fs_rwsem(&fi->i_gc_rwsem[WRITE]);
 	init_f2fs_rwsem(&fi->i_xattr_sem);
-- 
2.48.1.601.g30ceb7b040-goog


