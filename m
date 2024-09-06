Return-Path: <linux-kernel+bounces-318225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D68E96EA4A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27B131F254BA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 06:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3788C14C58C;
	Fri,  6 Sep 2024 06:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7HyKsMP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C37813D891
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 06:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725604055; cv=none; b=s4h9S9DnBuUYYmWNN+duO1jBqLVv/XIX6sDcxcYaYwEuUzagWrPmkdNMK6Ung9k78Qqa7PBaLgY6OLBak+xBdp1XHLOb0Cd7Fm04vhAyCiLAGGwUhjc2BBoLINme1b0ww54LMrleq6K+vwDENnnF9GjgM2/sIfWQBUoO7f2tJT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725604055; c=relaxed/simple;
	bh=CoOEbAggfh217kPkgbX+dUxoPywR5THB11oX8gQOwn0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k86wNTy7ghmUan6mlcZxn7t02dxuZOur5T0QLUyi8ZZCwYS0r2Jo30nEvElETR9hVZJAmaAVprU/m+/BfBF2q7/5zVBvHZ5TseQ1mDMX3J29iZefvnltth8ZHfKn+t9971tiV0i6cozxwowAKng9xALPSmKCQXyDssBS54np4VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7HyKsMP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6FBDC4CEC4;
	Fri,  6 Sep 2024 06:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725604055;
	bh=CoOEbAggfh217kPkgbX+dUxoPywR5THB11oX8gQOwn0=;
	h=From:To:Cc:Subject:Date:From;
	b=m7HyKsMP2mz1QuP8pcPdn/42CA7vIDxMS7lJ8vcfC01QI2qv/5aUckVrz4TIU8+Tq
	 KpfcsSiPq6ELZwpNkX0myT27UejgnRWIKmSLp8r9hwIjbrXM7MiXeVEchlJ7PP/V0a
	 A7ojDtYJpIvKc+pW8/em9g5udzdTnkyY7hxdF6My3gv8Pq8tdu+CJ3tO2eIicf4ZS2
	 jZie67R7B3crV5eRiBHhGmntbMEPiFgCwm9jHcLRVrfmaBzU09ZtEjZ77x5mFMcUFv
	 it2U62Fuy5rOW50Jbid3Ov+SCiztnqQsiK3/qEvAxzNwA09TOCWagpOCj4h9Px2qb5
	 UlJ0rVg4FE3iQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	syzbot+ebea2790904673d7c618@syzkaller.appspotmail.com
Subject: [PATCH] f2fs: get rid of online repaire on corrupted directory
Date: Fri,  6 Sep 2024 14:27:24 +0800
Message-Id: <20240906062724.3569496-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reports a f2fs bug as below:

kernel BUG at fs/f2fs/inode.c:896!
RIP: 0010:f2fs_evict_inode+0x1598/0x15c0 fs/f2fs/inode.c:896
Call Trace:
 evict+0x532/0x950 fs/inode.c:704
 dispose_list fs/inode.c:747 [inline]
 evict_inodes+0x5f9/0x690 fs/inode.c:797
 generic_shutdown_super+0x9d/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1696
 kill_f2fs_super+0x344/0x690 fs/f2fs/super.c:4898
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:228
 ptrace_notify+0x2d2/0x380 kernel/signal.c:2402
 ptrace_report_syscall include/linux/ptrace.h:415 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:477 [inline]
 syscall_exit_work+0xc6/0x190 kernel/entry/common.c:173
 syscall_exit_to_user_mode_prepare kernel/entry/common.c:200 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:205 [inline]
 syscall_exit_to_user_mode+0x279/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0010:f2fs_evict_inode+0x1598/0x15c0 fs/f2fs/inode.c:896

Online repaire on corrupted directory in f2fs_lookup() can generate
dirty data/meta while racing w/ readonly remount, it may leave dirty
inode after filesystem becomes readonly, however, checkpoint() will
skips flushing dirty inode in a state of readonly mode, result in
above panic.

Let's get rid of online repaire in f2fs_lookup(), and leave the work
to fsck.f2fs.

Fixes: 510022a85839 ("f2fs: add F2FS_INLINE_DOTS to recover missing dot dentries")
Reported-by: syzbot+ebea2790904673d7c618@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000a7b20f061ff2d56a@google.com
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h          | 11 -------
 fs/f2fs/namei.c         | 68 -----------------------------------------
 include/linux/f2fs_fs.h |  2 +-
 3 files changed, 1 insertion(+), 80 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f280b757c590..729b264b3bab 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -790,7 +790,6 @@ enum {
 	FI_NEED_IPU,		/* used for ipu per file */
 	FI_ATOMIC_FILE,		/* indicate atomic file */
 	FI_DATA_EXIST,		/* indicate data exists */
-	FI_INLINE_DOTS,		/* indicate inline dot dentries */
 	FI_SKIP_WRITES,		/* should skip data page writeback */
 	FI_OPU_WRITE,		/* used for opu per file */
 	FI_DIRTY_FILE,		/* indicate regular/symlink has dirty pages */
@@ -3082,7 +3081,6 @@ static inline void __mark_inode_dirty_flag(struct inode *inode,
 			return;
 		fallthrough;
 	case FI_DATA_EXIST:
-	case FI_INLINE_DOTS:
 	case FI_PIN_FILE:
 	case FI_COMPRESS_RELEASED:
 		f2fs_mark_inode_dirty_sync(inode, true);
@@ -3206,8 +3204,6 @@ static inline void get_inline_info(struct inode *inode, struct f2fs_inode *ri)
 		set_bit(FI_INLINE_DENTRY, fi->flags);
 	if (ri->i_inline & F2FS_DATA_EXIST)
 		set_bit(FI_DATA_EXIST, fi->flags);
-	if (ri->i_inline & F2FS_INLINE_DOTS)
-		set_bit(FI_INLINE_DOTS, fi->flags);
 	if (ri->i_inline & F2FS_EXTRA_ATTR)
 		set_bit(FI_EXTRA_ATTR, fi->flags);
 	if (ri->i_inline & F2FS_PIN_FILE)
@@ -3228,8 +3224,6 @@ static inline void set_raw_inline(struct inode *inode, struct f2fs_inode *ri)
 		ri->i_inline |= F2FS_INLINE_DENTRY;
 	if (is_inode_flag_set(inode, FI_DATA_EXIST))
 		ri->i_inline |= F2FS_DATA_EXIST;
-	if (is_inode_flag_set(inode, FI_INLINE_DOTS))
-		ri->i_inline |= F2FS_INLINE_DOTS;
 	if (is_inode_flag_set(inode, FI_EXTRA_ATTR))
 		ri->i_inline |= F2FS_EXTRA_ATTR;
 	if (is_inode_flag_set(inode, FI_PIN_FILE))
@@ -3310,11 +3304,6 @@ static inline int f2fs_exist_data(struct inode *inode)
 	return is_inode_flag_set(inode, FI_DATA_EXIST);
 }
 
-static inline int f2fs_has_inline_dots(struct inode *inode)
-{
-	return is_inode_flag_set(inode, FI_INLINE_DOTS);
-}
-
 static inline int f2fs_is_mmap_file(struct inode *inode)
 {
 	return is_inode_flag_set(inode, FI_MMAP_FILE);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 38b4750475db..57d46e1439de 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -457,62 +457,6 @@ struct dentry *f2fs_get_parent(struct dentry *child)
 	return d_obtain_alias(f2fs_iget(child->d_sb, ino));
 }
 
-static int __recover_dot_dentries(struct inode *dir, nid_t pino)
-{
-	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
-	struct qstr dot = QSTR_INIT(".", 1);
-	struct f2fs_dir_entry *de;
-	struct page *page;
-	int err = 0;
-
-	if (f2fs_readonly(sbi->sb)) {
-		f2fs_info(sbi, "skip recovering inline_dots inode (ino:%lu, pino:%u) in readonly mountpoint",
-			  dir->i_ino, pino);
-		return 0;
-	}
-
-	if (!S_ISDIR(dir->i_mode)) {
-		f2fs_err(sbi, "inconsistent inode status, skip recovering inline_dots inode (ino:%lu, i_mode:%u, pino:%u)",
-			  dir->i_ino, dir->i_mode, pino);
-		set_sbi_flag(sbi, SBI_NEED_FSCK);
-		return -ENOTDIR;
-	}
-
-	err = f2fs_dquot_initialize(dir);
-	if (err)
-		return err;
-
-	f2fs_balance_fs(sbi, true);
-
-	f2fs_lock_op(sbi);
-
-	de = f2fs_find_entry(dir, &dot, &page);
-	if (de) {
-		f2fs_put_page(page, 0);
-	} else if (IS_ERR(page)) {
-		err = PTR_ERR(page);
-		goto out;
-	} else {
-		err = f2fs_do_add_link(dir, &dot, NULL, dir->i_ino, S_IFDIR);
-		if (err)
-			goto out;
-	}
-
-	de = f2fs_find_entry(dir, &dotdot_name, &page);
-	if (de)
-		f2fs_put_page(page, 0);
-	else if (IS_ERR(page))
-		err = PTR_ERR(page);
-	else
-		err = f2fs_do_add_link(dir, &dotdot_name, NULL, pino, S_IFDIR);
-out:
-	if (!err)
-		clear_inode_flag(dir, FI_INLINE_DOTS);
-
-	f2fs_unlock_op(sbi);
-	return err;
-}
-
 static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 		unsigned int flags)
 {
@@ -522,7 +466,6 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 	struct dentry *new;
 	nid_t ino = -1;
 	int err = 0;
-	unsigned int root_ino = F2FS_ROOT_INO(F2FS_I_SB(dir));
 	struct f2fs_filename fname;
 
 	trace_f2fs_lookup_start(dir, dentry, flags);
@@ -558,17 +501,6 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 		goto out;
 	}
 
-	if ((dir->i_ino == root_ino) && f2fs_has_inline_dots(dir)) {
-		err = __recover_dot_dentries(dir, root_ino);
-		if (err)
-			goto out_iput;
-	}
-
-	if (f2fs_has_inline_dots(inode)) {
-		err = __recover_dot_dentries(inode, dir->i_ino);
-		if (err)
-			goto out_iput;
-	}
 	if (IS_ENCRYPTED(dir) &&
 	    (S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode)) &&
 	    !fscrypt_has_permitted_context(dir, inode)) {
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index f17f89a259e2..b0b821edfd97 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -278,7 +278,7 @@ struct node_footer {
 #define F2FS_INLINE_DATA	0x02	/* file inline data flag */
 #define F2FS_INLINE_DENTRY	0x04	/* file inline dentry flag */
 #define F2FS_DATA_EXIST		0x08	/* file inline data exist flag */
-#define F2FS_INLINE_DOTS	0x10	/* file having implicit dot dentries */
+#define F2FS_INLINE_DOTS	0x10	/* file having implicit dot dentries (obsolete) */
 #define F2FS_EXTRA_ATTR		0x20	/* file having extra attribute */
 #define F2FS_PIN_FILE		0x40	/* file should not be gced */
 #define F2FS_COMPRESS_RELEASED	0x80	/* file released compressed blocks */
-- 
2.40.1


