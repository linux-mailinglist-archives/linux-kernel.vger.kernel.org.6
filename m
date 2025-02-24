Return-Path: <linux-kernel+bounces-528703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADC4A41B08
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E2483AF3C5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B482505B7;
	Mon, 24 Feb 2025 10:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAUxquax"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701BC1EA7E6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392968; cv=none; b=ADRnnrQYfWFYqHD/iIPrLaVAwz32gz7A1eqBdaYlqt+9WPYQNmoM0Noq9kwZDrcLaMlaQeSHHZwkHrk1hVigkUDD5H01JM0r41zitIt0KdNQ1uK4nWFn8qJ9XTPCAplhNJ/5hzQqC0jJihIm2DeogF7wYFO0isQEyBNrydQZgrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392968; c=relaxed/simple;
	bh=dWEGzYt4wM4ufHLVVrN6xRzW2jMG5XwLK79Wlm0T60M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JK30Gxrqhw5BexdxFX7dk0qYgJ2cAsMP7M01LoxofEvMxsHrlVueHR76YUK9WGv+r6STeOcc+tnnPNrOWT80iOayeOAxQSst5nZKezVlz0rdhtL3K02inLsgdsNJamVjUt0VB7Pt2dCmKnNG2kdw+nc5biEYEDVtfXREHDXByc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAUxquax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFEAAC4CED6;
	Mon, 24 Feb 2025 10:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740392967;
	bh=dWEGzYt4wM4ufHLVVrN6xRzW2jMG5XwLK79Wlm0T60M=;
	h=From:To:Cc:Subject:Date:From;
	b=NAUxquaxkaLTf1W3DN1oNtcJdmMex0f1RFv+yq7kKNqcJzQz7seFScQhBXCJEY2tY
	 BfotNacrulqKBUk35EyJ1hPE/SKjKtuVHP1YbjaVGvzZAR81BF9FCIPTTnXWkv+0mY
	 BnXTvPo3ZEiOo6oO3JzaFB/aED0KbDGelSWXZluV2jOss/M7NAE+hTUTnRLQo6fbxk
	 henFwhsBaPVYW83+AYCs/gWajDyoRE4RZf54K14nBmtFio0hStTkjpzxcgUUgzsi1J
	 ruICIjcKEsoRqYxU2RH8IMRQ5PdZaFTYRg+yhjGVrSyNDOzh6QjwrnPt0aixQuiiGX
	 tmyje3REYnqww==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	syzbot+b6b347b7a4ea1b2e29b6@syzkaller.appspotmail.com
Subject: [PATCH v2] f2fs: fix to avoid accessing uninitialized curseg
Date: Mon, 24 Feb 2025 18:29:23 +0800
Message-ID: <20250224102923.93758-1-chao@kernel.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
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
- in has_curseg_enough_space(), save curseg->segno into a temp variable,
and verify its validation before use.

Fixes: 8b10d3653735 ("f2fs: introduce FAULT_NO_SEGMENT")
Reported-by: syzbot+b6b347b7a4ea1b2e29b6@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/67973c2b.050a0220.11b1bb.0089.GAE@google.com
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- get rid of potential blocking on curseg_mutex
 fs/f2fs/inode.c   | 7 +++++++
 fs/f2fs/segment.h | 9 ++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index d6ad7810df69..6aec752ac098 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -793,6 +793,13 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
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
index 943be4f1d6d2..0465dc00b349 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -559,13 +559,16 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
 			unsigned int node_blocks, unsigned int data_blocks,
 			unsigned int dent_blocks)
 {
-
 	unsigned int segno, left_blocks, blocks;
 	int i;
 
 	/* check current data/node sections in the worst case. */
 	for (i = CURSEG_HOT_DATA; i < NR_PERSISTENT_LOG; i++) {
 		segno = CURSEG_I(sbi, i)->segno;
+
+		if (unlikely(segno == NULL_SEGNO))
+			return false;
+
 		left_blocks = CAP_BLKS_PER_SEC(sbi) -
 				get_ckpt_valid_blocks(sbi, segno, true);
 
@@ -576,6 +579,10 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
 
 	/* check current data section for dentry blocks. */
 	segno = CURSEG_I(sbi, CURSEG_HOT_DATA)->segno;
+
+	if (unlikely(segno == NULL_SEGNO))
+		return false;
+
 	left_blocks = CAP_BLKS_PER_SEC(sbi) -
 			get_ckpt_valid_blocks(sbi, segno, true);
 	if (dent_blocks > left_blocks)
-- 
2.48.1.601.g30ceb7b040-goog


