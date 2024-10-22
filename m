Return-Path: <linux-kernel+bounces-375699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 054589A9988
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66EE3B23809
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 06:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44129136E0E;
	Tue, 22 Oct 2024 06:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9vW1b1o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82844823C3
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 06:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729577753; cv=none; b=bjY+DXyHSfiqef5n8NIk9iu9wqEsL0Cl4VT8sltEIGAM2CrPfwYdHSKW83qA5tUaMAW5NX5op/1lASEI4CmTfbKF50N1YtRODJ28vJ8BAiiS28mD9WJGeAFGSRbI214p22TIEkqpW93kabS2lTuP3/fZRgDUTKxpJh00G8fG+Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729577753; c=relaxed/simple;
	bh=pRLgs8Px7OgibatzaQuylzyFATh2wP1xLsLeGYb7dqs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MPj00L+bQUctQh/y09ugEdMqqMz+47G+frKs+FHJ2BRjnzzBKQbbzlGotAzBPF8/lCq4ne9ZsNfa6ZWYO9Qv0Bbujlj2MaGR0wozYl9R3IUh8ScnWXmrVejFc7nPnrZXF1Mqnf9TAiM0xu2wnU050mRyuRn2yCKDmOVm2Ge1EsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9vW1b1o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3736C4CEC3;
	Tue, 22 Oct 2024 06:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729577753;
	bh=pRLgs8Px7OgibatzaQuylzyFATh2wP1xLsLeGYb7dqs=;
	h=From:To:Cc:Subject:Date:From;
	b=I9vW1b1orsU83e0sc5SOPJtkiyjLNpVJjkFptKgHbjn8k8ZXXHAQOP7jVsJHDv5pJ
	 DX7DYCRyPx9RRCqPgiLxRkQk5UzrlV516Wwj6gNBYUQPZtCXGHTBQ0stRpvXajfIm3
	 5+jqpKf/2jhv9clKDFDdtTeyrssvTQhSyWm9A13t0WOS5HDLE32mmOrRWgQ/ZGK4N9
	 TH/JqZKp48fN7Z4C78NCrZ+eZyH7p0anYVRQauqsMkM30E9g+qzLRCr26zded5Q2Fg
	 /KlMoOUUTXUh9Nq3NljCat6U/tq4Gt/GtojBRszPYcCtGviv6OJatJZFQhUL9fiuxj
	 Kfb4boJqGZxow==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	syzbot+be4a9983e95a5e25c8d3@syzkaller.appspotmail.com
Subject: [PATCH] f2fs: fix to avoid potential deadlock in f2fs_record_stop_reason()
Date: Tue, 22 Oct 2024 14:15:45 +0800
Message-Id: <20241022061545.2527370-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reports deadlock issue of f2fs as below:

======================================================
WARNING: possible circular locking dependency detected
6.12.0-rc3-syzkaller-00087-gc964ced77262 #0 Not tainted
------------------------------------------------------
kswapd0/79 is trying to acquire lock:
ffff888011824088 (&sbi->sb_lock){++++}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2199 [inline]
ffff888011824088 (&sbi->sb_lock){++++}-{3:3}, at: f2fs_record_stop_reason+0x52/0x1d0 fs/f2fs/super.c:4068

but task is already holding lock:
ffff88804bd92610 (sb_internal#2){.+.+}-{0:0}, at: f2fs_evict_inode+0x662/0x15c0 fs/f2fs/inode.c:842

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #2 (sb_internal#2){.+.+}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1716 [inline]
       sb_start_intwrite+0x4d/0x1c0 include/linux/fs.h:1899
       f2fs_evict_inode+0x662/0x15c0 fs/f2fs/inode.c:842
       evict+0x4e8/0x9b0 fs/inode.c:725
       f2fs_evict_inode+0x1a4/0x15c0 fs/f2fs/inode.c:807
       evict+0x4e8/0x9b0 fs/inode.c:725
       dispose_list fs/inode.c:774 [inline]
       prune_icache_sb+0x239/0x2f0 fs/inode.c:963
       super_cache_scan+0x38c/0x4b0 fs/super.c:223
       do_shrink_slab+0x701/0x1160 mm/shrinker.c:435
       shrink_slab+0x1093/0x14d0 mm/shrinker.c:662
       shrink_one+0x43b/0x850 mm/vmscan.c:4818
       shrink_many mm/vmscan.c:4879 [inline]
       lru_gen_shrink_node mm/vmscan.c:4957 [inline]
       shrink_node+0x3799/0x3de0 mm/vmscan.c:5937
       kswapd_shrink_node mm/vmscan.c:6765 [inline]
       balance_pgdat mm/vmscan.c:6957 [inline]
       kswapd+0x1ca3/0x3700 mm/vmscan.c:7226
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #1 (fs_reclaim){+.+.}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       __fs_reclaim_acquire mm/page_alloc.c:3834 [inline]
       fs_reclaim_acquire+0x88/0x130 mm/page_alloc.c:3848
       might_alloc include/linux/sched/mm.h:318 [inline]
       prepare_alloc_pages+0x147/0x5b0 mm/page_alloc.c:4493
       __alloc_pages_noprof+0x16f/0x710 mm/page_alloc.c:4722
       alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
       alloc_pages_noprof mm/mempolicy.c:2345 [inline]
       folio_alloc_noprof+0x128/0x180 mm/mempolicy.c:2352
       filemap_alloc_folio_noprof+0xdf/0x500 mm/filemap.c:1010
       do_read_cache_folio+0x2eb/0x850 mm/filemap.c:3787
       read_mapping_folio include/linux/pagemap.h:1011 [inline]
       f2fs_commit_super+0x3c0/0x7d0 fs/f2fs/super.c:4032
       f2fs_record_stop_reason+0x13b/0x1d0 fs/f2fs/super.c:4079
       f2fs_handle_critical_error+0x2ac/0x5c0 fs/f2fs/super.c:4174
       f2fs_write_inode+0x35f/0x4d0 fs/f2fs/inode.c:785
       write_inode fs/fs-writeback.c:1503 [inline]
       __writeback_single_inode+0x711/0x10d0 fs/fs-writeback.c:1723
       writeback_single_inode+0x1f3/0x660 fs/fs-writeback.c:1779
       sync_inode_metadata+0xc4/0x120 fs/fs-writeback.c:2849
       f2fs_release_file+0xa8/0x100 fs/f2fs/file.c:1941
       __fput+0x23f/0x880 fs/file_table.c:431
       task_work_run+0x24f/0x310 kernel/task_work.c:228
       resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
       exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
       exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
       __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
       syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
       do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&sbi->sb_lock){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       down_write+0x99/0x220 kernel/locking/rwsem.c:1577
       f2fs_down_write fs/f2fs/f2fs.h:2199 [inline]
       f2fs_record_stop_reason+0x52/0x1d0 fs/f2fs/super.c:4068
       f2fs_handle_critical_error+0x2ac/0x5c0 fs/f2fs/super.c:4174
       f2fs_evict_inode+0xa61/0x15c0 fs/f2fs/inode.c:883
       evict+0x4e8/0x9b0 fs/inode.c:725
       f2fs_evict_inode+0x1a4/0x15c0 fs/f2fs/inode.c:807
       evict+0x4e8/0x9b0 fs/inode.c:725
       dispose_list fs/inode.c:774 [inline]
       prune_icache_sb+0x239/0x2f0 fs/inode.c:963
       super_cache_scan+0x38c/0x4b0 fs/super.c:223
       do_shrink_slab+0x701/0x1160 mm/shrinker.c:435
       shrink_slab+0x1093/0x14d0 mm/shrinker.c:662
       shrink_one+0x43b/0x850 mm/vmscan.c:4818
       shrink_many mm/vmscan.c:4879 [inline]
       lru_gen_shrink_node mm/vmscan.c:4957 [inline]
       shrink_node+0x3799/0x3de0 mm/vmscan.c:5937
       kswapd_shrink_node mm/vmscan.c:6765 [inline]
       balance_pgdat mm/vmscan.c:6957 [inline]
       kswapd+0x1ca3/0x3700 mm/vmscan.c:7226
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

Chain exists of:
  &sbi->sb_lock --> fs_reclaim --> sb_internal#2

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(sb_internal#2);
                               lock(fs_reclaim);
                               lock(sb_internal#2);
  lock(&sbi->sb_lock);

Root cause is there will be potential deadlock in between
below tasks:

Thread A				Kswapd
- f2fs_ioc_commit_atomic_write
 - mnt_want_write_file -- down_read lock A
					- balance_pgdat
					 - __fs_reclaim_acquire  -- lock B
					  - shrink_node
					   - prune_icache_sb
					    - dispose_list
					     - f2fs_evict_inode
					      - sb_start_intwrite  -- down_read lock A
 - f2fs_do_sync_file
  - f2fs_write_inode
   - f2fs_handle_critical_error
    - f2fs_record_stop_reason
     - f2fs_commit_super
      - read_mapping_folio
       - filemap_alloc_folio_noprof
        - fs_reclaim_acquire  -- lock B

Both threads try to acquire read lock of lock A, then its upcoming write
lock grabber will trigger deadlock.

Let's always create an asynchronous task in f2fs_handle_critical_error()
rather than calling f2fs_record_stop_reason() synchronously to avoid
this potential deadlock issue.

Fixes: b62e71be2110 ("f2fs: support errors=remount-ro|continue|panic mountoption")
Reported-by: syzbot+be4a9983e95a5e25c8d3@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6704d667.050a0220.1e4d62.0081.GAE@google.com
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9325d8dc7f7d..21d6fb60171a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4174,10 +4174,12 @@ void f2fs_handle_critical_error(struct f2fs_sb_info *sbi, unsigned char reason,
 	if (!f2fs_hw_is_readonly(sbi)) {
 		save_stop_reason(sbi, reason);
 
-		if (irq_context && !shutdown)
-			schedule_work(&sbi->s_error_work);
-		else
-			f2fs_record_stop_reason(sbi);
+		/*
+		 * always create an asynchronous task to record stop_reason
+		 * in order to avoid potential deadlock when running into
+		 * f2fs_record_stop_reason() synchronously.
+		 */
+		schedule_work(&sbi->s_error_work);
 	}
 
 	/*
-- 
2.40.1


