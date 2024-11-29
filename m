Return-Path: <linux-kernel+bounces-425930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 352D69DECA9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 21:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC8C716154F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 20:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631DA156C5E;
	Fri, 29 Nov 2024 20:25:10 +0000 (UTC)
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D571A302E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 20:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732911909; cv=none; b=cn5jD8rcMfqxmQx5jZuEEk7J9rf20WNLX1z26s+7Pc1K8i6ehRdNSUXsu1QT1syNqmHCsgOJQtXCdu6uREI9VQ9dVertbVksMOq8WpZZZi5/0RaGJ/bi5bNt34r4ge6LszD+DWB0oZr1E2YAya8G999GYd4KSj1xK4FnfKT3W1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732911909; c=relaxed/simple;
	bh=RJudoZEwGpm8Png5FES9kH3/fPjjml2ou+mMnayj/+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDQdXSXhi2I5uFIQKOG5urGRQFeL15TWPE1c57YRStGGsM0jDjJAT8Gvzds4hjTqnFMK/Fm61UCnw2QS59UFQdf7rhbmUlFQsYz9HLJ4Eay48DoajHehTryHhuWqTFNN2aYMQjasXPTgc9+lPOJG1jSMvC8PmTzqg2a0NRIohhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 29 Nov 2024 15:24:54 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+78f4eb354f5ca6c1e6eb@syzkaller.appspotmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] possible deadlock in trans_set_locked
Message-ID: <vkwc4py3f5crc5byn4h24u3bcbsyke2hzeuzd752ncra7iptdz@5hibgcwmd3go>
References: <6749f54c.050a0220.253251.00bc.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6749f54c.050a0220.253251.00bc.GAE@google.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Nov 29, 2024 at 09:09:32AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7b1d1d4cfac0 Merge remote-tracking branch 'iommu/arm/smmu'..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=17d6af78580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9bc44a6de1ceb5d6
> dashboard link: https://syzkaller.appspot.com/bug?extid=78f4eb354f5ca6c1e6eb
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=107bdf5f980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ae49e8580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/4d4a0162c7c3/disk-7b1d1d4c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/a8c47a4be472/vmlinux-7b1d1d4c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/0e173b91f83e/Image-7b1d1d4c.gz.xz
> mounted in repro #1: https://storage.googleapis.com/syzbot-assets/5ab7b24d2900/mount_0.gz
> mounted in repro #2: https://storage.googleapis.com/syzbot-assets/fbfbb60588c1/mount_2.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+78f4eb354f5ca6c1e6eb@syzkaller.appspotmail.com
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.12.0-syzkaller-g7b1d1d4cfac0 #0 Not tainted
> ------------------------------------------------------
> syz-executor203/6432 is trying to acquire lock:
> ffff0000da100128 (bcachefs_btree){+.+.}-{0:0}, at: trans_set_locked+0x5c/0x21c fs/bcachefs/btree_locking.h:193
> 
> but task is already holding lock:
> ffff0000dc661548 (&c->fsck_error_msgs_lock){+.+.}-{3:3}, at: __bch2_fsck_err+0x344/0x2544 fs/bcachefs/error.c:282
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (&c->fsck_error_msgs_lock){+.+.}-{3:3}:
>        __mutex_lock_common+0x190/0x21a0 kernel/locking/mutex.c:608
>        __mutex_lock kernel/locking/mutex.c:752 [inline]
>        mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:804
>        __bch2_fsck_err+0x344/0x2544 fs/bcachefs/error.c:282
>        bch2_check_alloc_hole_freespace+0x5fc/0xd74 fs/bcachefs/alloc_background.c:1278
>        bch2_check_alloc_info+0x1174/0x26f8 fs/bcachefs/alloc_background.c:1547
>        bch2_run_recovery_pass+0xe4/0x1d4 fs/bcachefs/recovery_passes.c:191
>        bch2_run_online_recovery_passes+0xa4/0x174 fs/bcachefs/recovery_passes.c:212
>        bch2_fsck_online_thread_fn+0x150/0x3e8 fs/bcachefs/chardev.c:799
>        thread_with_stdio_fn+0x64/0x134 fs/bcachefs/thread_with_file.c:298
>        kthread+0x288/0x310 kernel/kthread.c:389
>        ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862
> 
> -> #0 (bcachefs_btree){+.+.}-{0:0}:
>        check_prev_add kernel/locking/lockdep.c:3161 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3280 [inline]
>        validate_chain kernel/locking/lockdep.c:3904 [inline]
>        __lock_acquire+0x33f8/0x77c8 kernel/locking/lockdep.c:5202
>        lock_acquire+0x240/0x728 kernel/locking/lockdep.c:5825
>        trans_set_locked+0x88/0x21c fs/bcachefs/btree_locking.h:194
>        __bch2_trans_relock+0x2a0/0x394 fs/bcachefs/btree_locking.c:785
>        bch2_trans_relock+0x24/0x34 fs/bcachefs/btree_locking.c:793
>        __bch2_fsck_err+0x1664/0x2544 fs/bcachefs/error.c:363
>        bch2_check_alloc_hole_freespace+0x5fc/0xd74 fs/bcachefs/alloc_background.c:1278
>        bch2_check_alloc_info+0x1174/0x26f8 fs/bcachefs/alloc_background.c:1547
>        bch2_run_recovery_pass+0xe4/0x1d4 fs/bcachefs/recovery_passes.c:191
>        bch2_run_online_recovery_passes+0xa4/0x174 fs/bcachefs/recovery_passes.c:212
>        bch2_fsck_online_thread_fn+0x150/0x3e8 fs/bcachefs/chardev.c:799
>        thread_with_stdio_fn+0x64/0x134 fs/bcachefs/thread_with_file.c:298
>        kthread+0x288/0x310 kernel/kthread.c:389
>        ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862
> 
> other info that might help us debug this:
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(&c->fsck_error_msgs_lock);
>                                lock(bcachefs_btree);
>                                lock(&c->fsck_error_msgs_lock);
>   lock(bcachefs_btree);
> 
>  *** DEADLOCK ***
> 
> 3 locks held by syz-executor203/6432:
>  #0: ffff0000dc600278 (&c->state_lock){++++}-{3:3}, at: bch2_run_online_recovery_passes+0x3c/0x174 fs/bcachefs/recovery_passes.c:204
>  #1: ffff0000dc604398 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu_lock_acquire+0x18/0x54 include/linux/srcu.h:150
>  #2: ffff0000dc661548 (&c->fsck_error_msgs_lock){+.+.}-{3:3}, at: __bch2_fsck_err+0x344/0x2544 fs/bcachefs/error.c:282
> 
> stack backtrace:
> CPU: 1 UID: 0 PID: 6432 Comm: syz-executor203 Not tainted 6.12.0-syzkaller-g7b1d1d4cfac0 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Call trace:
>  show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:484 (C)
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:120
>  dump_stack+0x1c/0x28 lib/dump_stack.c:129
>  print_circular_bug+0x154/0x1c0 kernel/locking/lockdep.c:2074
>  check_noncircular+0x310/0x404 kernel/locking/lockdep.c:2206
>  check_prev_add kernel/locking/lockdep.c:3161 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3280 [inline]
>  validate_chain kernel/locking/lockdep.c:3904 [inline]
>  __lock_acquire+0x33f8/0x77c8 kernel/locking/lockdep.c:5202
>  lock_acquire+0x240/0x728 kernel/locking/lockdep.c:5825
>  trans_set_locked+0x88/0x21c fs/bcachefs/btree_locking.h:194
>  __bch2_trans_relock+0x2a0/0x394 fs/bcachefs/btree_locking.c:785
>  bch2_trans_relock+0x24/0x34 fs/bcachefs/btree_locking.c:793
>  __bch2_fsck_err+0x1664/0x2544 fs/bcachefs/error.c:363
>  bch2_check_alloc_hole_freespace+0x5fc/0xd74 fs/bcachefs/alloc_background.c:1278
>  bch2_check_alloc_info+0x1174/0x26f8 fs/bcachefs/alloc_background.c:1547
>  bch2_run_recovery_pass+0xe4/0x1d4 fs/bcachefs/recovery_passes.c:191
>  bch2_run_online_recovery_passes+0xa4/0x174 fs/bcachefs/recovery_passes.c:212
>  bch2_fsck_online_thread_fn+0x150/0x3e8 fs/bcachefs/chardev.c:799
>  thread_with_stdio_fn+0x64/0x134 fs/bcachefs/thread_with_file.c:298
>  kthread+0x288/0x310 kernel/kthread.c:389
>  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

syzbot seems to now be re-opening bugs just because the patch hasn't
been merged into the branch it's testing?

