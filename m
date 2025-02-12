Return-Path: <linux-kernel+bounces-510678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D02A32054
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ADAC16580F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC382204C00;
	Wed, 12 Feb 2025 07:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqcY2wjr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD7F2046B3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 07:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739346770; cv=none; b=Iags+EM0spgXmwle02xes1eo2UEFQpwblboUT9Xm5GOzfd8q+FaXhpEX56FzuHXtqd8Kmtrvm0xxUpF2U5SnuhO8E3HSrisCwoz9vCADZuvmua9vnSLOT+Y/bzh9d64M3H7eYmlmq/a+ZSEMUcnZLswXsikK42MgzqVDQbm9vLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739346770; c=relaxed/simple;
	bh=o6Omrk5mpniLuURjnCYmDYyCsZtUDfiNV2x9rR1U9Ho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZofndBYjMRsC06Delfm3Qk+gu4QzFaQAl8xBvkAQDdpw8ugFjvBYMJedghBA7cdZw2XGket8Lnyy0ivVzUCu8tFiULDkG3HEBK9c3GLcKDWXkf+l0Fth4fG78eH3EUygy8KXiZx3mWxo9RoBjnklQ161Aq7WGlPLDtiMa0lAuaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqcY2wjr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F25C4CEDF;
	Wed, 12 Feb 2025 07:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739346769;
	bh=o6Omrk5mpniLuURjnCYmDYyCsZtUDfiNV2x9rR1U9Ho=;
	h=From:To:Cc:Subject:Date:From;
	b=WqcY2wjrJ1jC288l8H7MSpntzmJZqoZw8/M0txvc5h2rC+aIJC+QBk4c/T6BkmQzk
	 7BgAPQ59eTYHUDjCRzRQDqZbhrVmXSHcXMyUL5taDY5gzKk6KUay2WdmyYPlr7vmei
	 48hKG7Ai+hMr2wsmiKuZ5cB5DuR31UEcTRJI01ymNqa33NFd8Lejh0gbMUH+cNF88j
	 i5ulx7mURJL5y2uUoyXDJSm4fLo75inh7V0fawj8Ywz7PhJxVsglFRKSKMFl6Meo7F
	 eGEbnE8FPuT4R7QIGqJAknYr5xMrvzbT/e2AJGtBYFrRBmg4qEFwLtm2V2Xxg3Wfq1
	 MKBeCo3mf7Mbg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	syzbot+b6b347b7a4ea1b2e29b6@syzkaller.appspotmail.com
Subject: [PATCH] f2fs: fix to avoid accessing uninitialized curseg
Date: Wed, 12 Feb 2025 15:52:42 +0800
Message-ID: <20250212075242.988652-1-chao@kernel.org>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reports a f2fs bug as below:

F2FS-fs (loop3): Stopped filesystem due to reason: 7
kworker/u8:7: attempt to access beyond end of device
BUG: unable to handle page fault for address: ffffed1604ea3dfa
RIP: 0010:get_ckpt_valid_blocks fs/f2fs/segment.h:361 [inline]
RIP: 0010:has_curseg_enough_space fs/f2fs/segment.h:570 [inline]
RIP: 0010:__get_secs_required fs/f2fs/segment.h:620 [inline]
RIP: 0010:has_not_enough_free_secs fs/f2fs/segment.h:633 [inline]
RIP: 0010:has_enough_free_secs+0x575/0x1660 fs/f2fs/segment.h:649
 <TASK>
 f2fs_is_checkpoint_ready fs/f2fs/segment.h:671 [inline]
 f2fs_write_inode+0x425/0x540 fs/f2fs/inode.c:791
 write_inode fs/fs-writeback.c:1525 [inline]
 __writeback_single_inode+0x708/0x10d0 fs/fs-writeback.c:1745
 writeback_sb_inodes+0x820/0x1360 fs/fs-writeback.c:1976
 wb_writeback+0x413/0xb80 fs/fs-writeback.c:2156
 wb_do_writeback fs/fs-writeback.c:2303 [inline]
 wb_workfn+0x410/0x1080 fs/fs-writeback.c:2343
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3317
 worker_thread+0x870/0xd30 kernel/workqueue.c:3398
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Commit 8b10d3653735 ("f2fs: introduce FAULT_NO_SEGMENT") allows to trigger
no free segment fault in allocator, then it will update curseg->segno to
NULL_SEGNO, though, CP_ERROR_FLAG has been set, f2fs_write_inode() missed
to check the flag, and access invalid curseg->segno directly in below call
path, then resulting in panic:

- f2fs_write_inode
 - f2fs_is_checkpoint_ready
  - has_enough_free_secs
   - has_not_enough_free_secs
    - __get_secs_required
     - has_curseg_enough_space
      - get_ckpt_valid_blocks
      : access invalid curseg->segno

To avoid this issue, let's:
- check CP_ERROR_FLAG flag in prior to f2fs_is_checkpoint_ready() in
f2fs_write_inode().
- in has_curseg_enough_space(), a) verify status of curseg before accessing
its field, and b) grab curseg_mutex lock to avoid race condition.

Fixes: 8b10d3653735 ("f2fs: introduce FAULT_NO_SEGMENT")
Reported-by: syzbot+b6b347b7a4ea1b2e29b6@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/67973c2b.050a0220.11b1bb.0089.GAE@google.com
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/inode.c   |  7 +++++++
 fs/f2fs/segment.h | 27 ++++++++++++++++++++++-----
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 02f1b69d03d8..5c1b515eab36 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -799,6 +799,13 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
 		!is_inode_flag_set(inode, FI_DIRTY_INODE))
 		return 0;
 
+	/*
+	 * no need to update inode page, ultimately f2fs_evict_inode() will
+	 * clear dirty status of inode.
+	 */
+	if (f2fs_cp_error(sbi))
+		return -EIO;
+
 	if (!f2fs_is_checkpoint_ready(sbi)) {
 		f2fs_mark_inode_dirty_sync(inode, true);
 		return -ENOSPC;
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 943be4f1d6d2..e9fcf2b85b76 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -559,15 +559,23 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
 			unsigned int node_blocks, unsigned int data_blocks,
 			unsigned int dent_blocks)
 {
-
+	struct curseg_info *curseg;
 	unsigned int segno, left_blocks, blocks;
 	int i;
 
 	/* check current data/node sections in the worst case. */
 	for (i = CURSEG_HOT_DATA; i < NR_PERSISTENT_LOG; i++) {
-		segno = CURSEG_I(sbi, i)->segno;
-		left_blocks = CAP_BLKS_PER_SEC(sbi) -
+		curseg = CURSEG_I(sbi, i);
+
+		mutex_lock(&curseg->curseg_mutex);
+		if (!curseg->inited || curseg->segno == NULL_SEGNO) {
+			left_blocks = 0;
+		} else {
+			segno = curseg->segno;
+			left_blocks = CAP_BLKS_PER_SEC(sbi) -
 				get_ckpt_valid_blocks(sbi, segno, true);
+		}
+		mutex_unlock(&curseg->curseg_mutex);
 
 		blocks = i <= CURSEG_COLD_DATA ? data_blocks : node_blocks;
 		if (blocks > left_blocks)
@@ -575,9 +583,18 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
 	}
 
 	/* check current data section for dentry blocks. */
-	segno = CURSEG_I(sbi, CURSEG_HOT_DATA)->segno;
-	left_blocks = CAP_BLKS_PER_SEC(sbi) -
+	curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
+
+	mutex_lock(&curseg->curseg_mutex);
+	if (!curseg->inited || curseg->segno == NULL_SEGNO) {
+		left_blocks = 0;
+	} else {
+		segno = curseg->segno;
+		left_blocks = CAP_BLKS_PER_SEC(sbi) -
 			get_ckpt_valid_blocks(sbi, segno, true);
+	}
+	mutex_unlock(&curseg->curseg_mutex);
+
 	if (dent_blocks > left_blocks)
 		return false;
 	return true;
-- 
2.48.1.502.g6dc24dfdaf-goog


