Return-Path: <linux-kernel+bounces-193893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C82E98D33B8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49E9C286590
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 09:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519CC16E896;
	Wed, 29 May 2024 09:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1COFIhq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8438F16A360
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 09:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716976342; cv=none; b=eMXzsRtKgPKklGOEYNAOtIPc9q/BK6UWkeEqU0xCz4q9Md+4chFE8efbakwIQqPi9GzaTCJvbLQ48EOXCWnKcGG65K1J2JNR1H+OAHzsnBOVPWkNWSTCc4CJkKiDAEdy7mpNuk7pqk9oAK2KCr91ezhlnJpf4vt4rOPxmzt9Hu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716976342; c=relaxed/simple;
	bh=JrVzi9t9nN2k3gm4A1Sjc6C5/DP/aCCwcBk5RcZ7FEA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hpBMTN2G5B4JgCCzSEMOf2/7mwIA5jkuCf9Cwib7Fd9DGrWBcpKPltWt7bcgwl6rIQx3V4ZcVXDn/Rgc0DYc/8FWuXVPOPLqSpUVSplGHhIvKqCDpA/v9BuLIgCafdwJwXEF5aZXJ2OymIiHm3A7qbmWCaPxYEQMpnBvPVlSlxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1COFIhq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499C8C2BD10;
	Wed, 29 May 2024 09:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716976342;
	bh=JrVzi9t9nN2k3gm4A1Sjc6C5/DP/aCCwcBk5RcZ7FEA=;
	h=From:To:Cc:Subject:Date:From;
	b=p1COFIhqjJ4asDHG21pfERVJ9zWJwfenyf40Noe+DGze98xkg5OORjd2/E+jtXf4Z
	 7GxLU6+GAn7fceD1m+HPG9HkIQCjAnaOesYB8BHYHNgdiynaNOPDxKM9ndBmo6OSUc
	 w6MKxG/Ti1ZPLgf+UQGwH/QWRjEwdM1LtN9A63wwVwFEQNufp0VNnUAm/Iz2eZLedf
	 YYlEMe+2ayZ4ze4aSwSbyfpj1Jsi5OGDQju0yPscYoKawH0zfrhiCk7KTEI6cTCXAh
	 kQOdF8jkGGQnKVFhGRwOicWSUHG9hMOuw1WbRNsPKxnMCaYdpc+pdeMJ0b2pVfAOHb
	 Vl0M7bGNBa4OA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	syzbot+74ebe2104433e9dc610d@syzkaller.appspotmail.com
Subject: [PATCH] f2fs: fix to cover read extent cache access with lock
Date: Wed, 29 May 2024 17:52:11 +0800
Message-Id: <20240529095211.323808-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reports a f2fs bug as below:

BUG: KASAN: slab-use-after-free in sanity_check_extent_cache+0x370/0x410 fs/f2fs/extent_cache.c:46
Read of size 4 at addr ffff8880739ab220 by task syz-executor200/5097

CPU: 0 PID: 5097 Comm: syz-executor200 Not tainted 6.9.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 sanity_check_extent_cache+0x370/0x410 fs/f2fs/extent_cache.c:46
 do_read_inode fs/f2fs/inode.c:509 [inline]
 f2fs_iget+0x33e1/0x46e0 fs/f2fs/inode.c:560
 f2fs_nfs_get_inode+0x74/0x100 fs/f2fs/super.c:3237
 generic_fh_to_dentry+0x9f/0xf0 fs/libfs.c:1413
 exportfs_decode_fh_raw+0x152/0x5f0 fs/exportfs/expfs.c:444
 exportfs_decode_fh+0x3c/0x80 fs/exportfs/expfs.c:584
 do_handle_to_path fs/fhandle.c:155 [inline]
 handle_to_path fs/fhandle.c:210 [inline]
 do_handle_open+0x495/0x650 fs/fhandle.c:226
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

We missed to cover sanity_check_extent_cache() w/ extent cache lock,
so, below race case may happen, result in use after free issue.

- f2fs_iget
 - do_read_inode
  - f2fs_init_read_extent_tree
  : add largest extent entry in to cache
					- shrink
					 - f2fs_shrink_read_extent_tree
					  - __shrink_extent_tree
					   - __detach_extent_node
					   : drop largest extent entry
  - sanity_check_extent_cache
  : access et->largest w/ lock

let's refactor sanity_check_extent_cache() to avoid extent cache access
and call it before f2fs_init_read_extent_tree() to fix this issue.

Reported-by: syzbot+74ebe2104433e9dc610d@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-f2fs-devel/00000000000009beea061740a531@google.com
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/extent_cache.c | 48 +++++++++++++++++-------------------------
 fs/f2fs/f2fs.h         |  2 +-
 fs/f2fs/inode.c        | 10 ++++-----
 3 files changed, 25 insertions(+), 35 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 48048fa36427..fd1fc06359ee 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -19,33 +19,23 @@
 #include "node.h"
 #include <trace/events/f2fs.h>
 
-bool sanity_check_extent_cache(struct inode *inode)
+bool sanity_check_extent_cache(struct inode *inode, struct page *ipage)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct f2fs_inode_info *fi = F2FS_I(inode);
-	struct extent_tree *et = fi->extent_tree[EX_READ];
-	struct extent_info *ei;
-
-	if (!et)
-		return true;
+	struct f2fs_extent *i_ext = &F2FS_INODE(ipage)->i_ext;
+	struct extent_info ei;
 
-	ei = &et->largest;
-	if (!ei->len)
-		return true;
+	get_read_extent_info(&ei, i_ext);
 
-	/* Let's drop, if checkpoint got corrupted. */
-	if (is_set_ckpt_flags(sbi, CP_ERROR_FLAG)) {
-		ei->len = 0;
-		et->largest_updated = true;
+	if (!ei.len)
 		return true;
-	}
 
-	if (!f2fs_is_valid_blkaddr(sbi, ei->blk, DATA_GENERIC_ENHANCE) ||
-	    !f2fs_is_valid_blkaddr(sbi, ei->blk + ei->len - 1,
+	if (!f2fs_is_valid_blkaddr(sbi, ei.blk, DATA_GENERIC_ENHANCE) ||
+	    !f2fs_is_valid_blkaddr(sbi, ei.blk + ei.len - 1,
 					DATA_GENERIC_ENHANCE)) {
 		f2fs_warn(sbi, "%s: inode (ino=%lx) extent info [%u, %u, %u] is incorrect, run fsck to fix",
 			  __func__, inode->i_ino,
-			  ei->blk, ei->fofs, ei->len);
+			  ei.blk, ei.fofs, ei.len);
 		return false;
 	}
 	return true;
@@ -394,24 +384,22 @@ void f2fs_init_read_extent_tree(struct inode *inode, struct page *ipage)
 
 	if (!__may_extent_tree(inode, EX_READ)) {
 		/* drop largest read extent */
-		if (i_ext && i_ext->len) {
+		if (i_ext->len) {
 			f2fs_wait_on_page_writeback(ipage, NODE, true, true);
 			i_ext->len = 0;
 			set_page_dirty(ipage);
 		}
-		goto out;
+		set_inode_flag(inode, FI_NO_EXTENT);
+		return;
 	}
 
 	et = __grab_extent_tree(inode, EX_READ);
 
-	if (!i_ext || !i_ext->len)
-		goto out;
-
 	get_read_extent_info(&ei, i_ext);
 
 	write_lock(&et->lock);
-	if (atomic_read(&et->node_cnt))
-		goto unlock_out;
+	if (atomic_read(&et->node_cnt) || !ei.len)
+		goto skip;
 
 	en = __attach_extent_node(sbi, et, &ei, NULL,
 				&et->root.rb_root.rb_node, true);
@@ -423,11 +411,13 @@ void f2fs_init_read_extent_tree(struct inode *inode, struct page *ipage)
 		list_add_tail(&en->list, &eti->extent_list);
 		spin_unlock(&eti->extent_lock);
 	}
-unlock_out:
+skip:
+	/* Let's drop, if checkpoint got corrupted. */
+	if (f2fs_cp_error(sbi)) {
+		et->largest.len = 0;
+		et->largest_updated = true;
+	}
 	write_unlock(&et->lock);
-out:
-	if (!F2FS_I(inode)->extent_tree[EX_READ])
-		set_inode_flag(inode, FI_NO_EXTENT);
 }
 
 void f2fs_init_age_extent_tree(struct inode *inode)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9118a4e2db6d..9688df332147 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4191,7 +4191,7 @@ void f2fs_leave_shrinker(struct f2fs_sb_info *sbi);
 /*
  * extent_cache.c
  */
-bool sanity_check_extent_cache(struct inode *inode);
+bool sanity_check_extent_cache(struct inode *inode, struct page *ipage);
 void f2fs_init_extent_tree(struct inode *inode);
 void f2fs_drop_extent_tree(struct inode *inode);
 void f2fs_destroy_extent_node(struct inode *inode);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 4b39aebd3c70..3a13f32b43a2 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -508,16 +508,16 @@ static int do_read_inode(struct inode *inode)
 
 	init_idisk_time(inode);
 
-	/* Need all the flag bits */
-	f2fs_init_read_extent_tree(inode, node_page);
-	f2fs_init_age_extent_tree(inode);
-
-	if (!sanity_check_extent_cache(inode)) {
+	if (!sanity_check_extent_cache(inode, node_page)) {
 		f2fs_put_page(node_page, 1);
 		f2fs_handle_error(sbi, ERROR_CORRUPTED_INODE);
 		return -EFSCORRUPTED;
 	}
 
+	/* Need all the flag bits */
+	f2fs_init_read_extent_tree(inode, node_page);
+	f2fs_init_age_extent_tree(inode);
+
 	f2fs_put_page(node_page, 1);
 
 	stat_inc_inline_xattr(inode);
-- 
2.40.1


