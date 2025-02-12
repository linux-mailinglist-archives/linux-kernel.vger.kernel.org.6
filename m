Return-Path: <linux-kernel+bounces-510472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E00A31D7D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 05:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC60E3A756D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 04:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C90C1E7C2D;
	Wed, 12 Feb 2025 04:31:29 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7FA208AD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 04:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739334689; cv=none; b=BOlT5D22APdPoClFVlylbZF7sUzcxSsvpNfJeDO2ndsRX8ojQP80cmwhVgXVJn0L0ZbH69ZupVKhU2Up/Zg8Svd9rfvS7XqpkQbzDGDny0fcjg24RiyjKQdOk0N9ALqIm0brqgMvxW9jC2H4EYsEPxsMajuO48KbyMdN7p7wsGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739334689; c=relaxed/simple;
	bh=4PznAC+gxGjstQieNrLRGjHCV5KWLQvyS8PnIARW0fY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qwPgHYwuNWmsrb0oQ/wQnHbD4hEkfwO39tp6cYyBeSZ4n7I7Ac6eCaZgsqwGXfCE05eM/TmiI2nHWawLw59z7xMDgavVrSYyyTf+5QLcNpBt5YGMf7s6Kwn+mxQTeJhf/GIfT7qzB3VOOnaaR4p+LsoVHTvv331Xxkx0pWAvqrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-8521d7980beso460790739f.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 20:31:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739334686; x=1739939486;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v0jyxb47WXqd4HeHAwjltOrsfpdXxUzY/hHdlduEBro=;
        b=AhOEDvva7PnyV/+euriE5Vwm4H46vBIeXvqQx8zy5GAjAw+7xhevJgY0iWz1CnahMf
         fZ7+Q85ABhSdCdOci1d/C8tIUKnlnMbVuUT72eThsMHNuF+pDA1kiNZxSXMX6Fe8tiPD
         Lc5Zvc7DTdRFXrJtEDU3vxFmllctNXMDG8kic3Wl/xq0Uc0LNowLe7vbFDszaTbZK4DQ
         dqbiM1pKnL6VMxXZTLhxcB55TK52aK6kWK34wnM8LK6shA3Y9QbdLUDaUOeamO2WFgao
         4uFYfShKiTjF6bhTm65jUvihv4wk1DkrpbhuhtabXMkPlsbg74HKk7fU+naLLlod10s6
         /OKg==
X-Forwarded-Encrypted: i=1; AJvYcCW0Wvp6EcyMN8ahH6UWKiA9LylxK/NCHxqH7lZXHGfg6Xq7o6rdt3EIdzVttYO37WTCXhF8uqHOTPM6NIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfKRMSur8r2jCx10MtOdYxyxVAtlfOt3uXiCtIk5BW9aAHoJZI
	XUibUi4wCmiprzoZYLPAgT/EM07LQxnmzJ3BQO1c16YWnRv/Vs9iLtJr1Xks5RxZrDw5VEfHhRn
	ewDJHMLSeYxupbG0wlfnNxUmfbtHcZ74TfD2ZQXRzv+zXDVlUBd1ayLg=
X-Google-Smtp-Source: AGHT+IHKWfO3Wf/YNY3cxdtsH4H+vNz5YyDAoLDDaaMdaCHhGo2HvYVj/h8vOcHtndCXhb93ZiSk96Fy5EfWgkdBaPspH5tzWG3i
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184a:b0:3d1:79ec:bef2 with SMTP id
 e9e14a558f8ab-3d17bf25622mr20045305ab.6.1739334686286; Tue, 11 Feb 2025
 20:31:26 -0800 (PST)
Date: Tue, 11 Feb 2025 20:31:26 -0800
In-Reply-To: <66f97d9a.050a0220.6bad9.001d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ac241e.050a0220.110943.0047.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] possible deadlock in pcpu_alloc_noprof
From: syzbot <syzbot+fe63f377148a6371a9db@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    09fbf3d50205 Merge tag 'tomoyo-pr-20250211' of git://git.c..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14370aa4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c2347dd6174fbe2
dashboard link: https://syzkaller.appspot.com/bug?extid=fe63f377148a6371a9db
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17404718580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-09fbf3d5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/835b3d29c46c/vmlinux-09fbf3d5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ff4bfd8a5d42/bzImage-09fbf3d5.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/24d046ee591e/mount_7.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/fc8a49472f19/mount_9.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fe63f377148a6371a9db@syzkaller.appspotmail.com

bcachefs (loop0): initializing new filesystem
bcachefs (loop0): going read-write
bcachefs (loop0): marking superblocks
======================================================
WARNING: possible circular locking dependency detected
6.14.0-rc2-syzkaller-00039-g09fbf3d50205 #0 Not tainted
------------------------------------------------------
syz.0.21/5625 is trying to acquire lock:
ffffffff8ea19608 (pcpu_alloc_mutex){+.+.}-{4:4}, at: pcpu_alloc_noprof+0x293/0x1760 mm/percpu.c:1782

but task is already holding lock:
ffff888051401c68 (&bc->lock){+.+.}-{4:4}, at: bch2_btree_node_mem_alloc+0x559/0x16f0 fs/bcachefs/btree_cache.c:804

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&bc->lock){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19c/0x1010 kernel/locking/mutex.c:730
       bch2_btree_cache_scan+0x184/0xec0 fs/bcachefs/btree_cache.c:482
       do_shrink_slab+0x72d/0x1160 mm/shrinker.c:437
       shrink_slab+0x1093/0x14d0 mm/shrinker.c:664
       shrink_one+0x43b/0x850 mm/vmscan.c:4868
       shrink_many mm/vmscan.c:4929 [inline]
       lru_gen_shrink_node mm/vmscan.c:5007 [inline]
       shrink_node+0x37c5/0x3e50 mm/vmscan.c:5978
       kswapd_shrink_node mm/vmscan.c:6807 [inline]
       balance_pgdat mm/vmscan.c:6999 [inline]
       kswapd+0x20f3/0x3b10 mm/vmscan.c:7264
       kthread+0x7a9/0x920 kernel/kthread.c:464
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #1 (fs_reclaim){+.+.}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
       __fs_reclaim_acquire mm/page_alloc.c:3853 [inline]
       fs_reclaim_acquire+0x88/0x130 mm/page_alloc.c:3867
       might_alloc include/linux/sched/mm.h:318 [inline]
       slab_pre_alloc_hook mm/slub.c:4066 [inline]
       slab_alloc_node mm/slub.c:4144 [inline]
       __do_kmalloc_node mm/slub.c:4293 [inline]
       __kmalloc_noprof+0xae/0x4c0 mm/slub.c:4306
       kmalloc_noprof include/linux/slab.h:905 [inline]
       kzalloc_noprof include/linux/slab.h:1037 [inline]
       pcpu_mem_zalloc mm/percpu.c:510 [inline]
       pcpu_alloc_chunk mm/percpu.c:1430 [inline]
       pcpu_create_chunk+0x57/0xbc0 mm/percpu-vm.c:338
       pcpu_balance_populated mm/percpu.c:2063 [inline]
       pcpu_balance_workfn+0xc4d/0xd40 mm/percpu.c:2200
       process_one_work kernel/workqueue.c:3236 [inline]
       process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3317
       worker_thread+0x870/0xd30 kernel/workqueue.c:3398
       kthread+0x7a9/0x920 kernel/kthread.c:464
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (pcpu_alloc_mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3163 [inline]
       check_prevs_add kernel/locking/lockdep.c:3282 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3906
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5228
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19c/0x1010 kernel/locking/mutex.c:730
       pcpu_alloc_noprof+0x293/0x1760 mm/percpu.c:1782
       __six_lock_init+0x104/0x150 fs/bcachefs/six.c:876
       bch2_btree_lock_init+0x38/0x100 fs/bcachefs/btree_locking.c:12
       bch2_btree_node_mem_alloc+0x565/0x16f0 fs/bcachefs/btree_cache.c:807
       __bch2_btree_node_alloc fs/bcachefs/btree_update_interior.c:304 [inline]
       bch2_btree_reserve_get+0x2df/0x1890 fs/bcachefs/btree_update_interior.c:532
       bch2_btree_update_start+0xe56/0x14e0 fs/bcachefs/btree_update_interior.c:1230
       bch2_btree_split_leaf+0x121/0x880 fs/bcachefs/btree_update_interior.c:1851
       bch2_trans_commit_error+0x212/0x1380 fs/bcachefs/btree_trans_commit.c:908
       __bch2_trans_commit+0x812b/0x97a0 fs/bcachefs/btree_trans_commit.c:1085
       bch2_trans_commit fs/bcachefs/btree_update.h:183 [inline]
       bch2_trans_mark_metadata_bucket+0x47a/0x17b0 fs/bcachefs/buckets.c:1043
       bch2_trans_mark_metadata_sectors fs/bcachefs/buckets.c:1060 [inline]
       __bch2_trans_mark_dev_sb fs/bcachefs/buckets.c:1100 [inline]
       bch2_trans_mark_dev_sb+0x3f6/0x820 fs/bcachefs/buckets.c:1128
       bch2_trans_mark_dev_sbs_flags+0x6be/0x720 fs/bcachefs/buckets.c:1138
       bch2_fs_initialize+0xba0/0x1610 fs/bcachefs/recovery.c:1149
       bch2_fs_start+0x36d/0x610 fs/bcachefs/super.c:1042
       bch2_fs_get_tree+0xd8d/0x1740 fs/bcachefs/fs.c:2203
       vfs_get_tree+0x90/0x2b0 fs/super.c:1814
       do_new_mount+0x2be/0xb40 fs/namespace.c:3560
       do_mount fs/namespace.c:3900 [inline]
       __do_sys_mount fs/namespace.c:4111 [inline]
       __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4088
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  pcpu_alloc_mutex --> fs_reclaim --> &bc->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&bc->lock);
                               lock(fs_reclaim);
                               lock(&bc->lock);
  lock(pcpu_alloc_mutex);

 *** DEADLOCK ***

4 locks held by syz.0.21/5625:
 #0: ffff888051400278 (&c->state_lock){+.+.}-{4:4}, at: bch2_fs_start+0x45/0x610 fs/bcachefs/super.c:1010
 #1: ffff888051404378 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:164 [inline]
 #1: ffff888051404378 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:256 [inline]
 #1: ffff888051404378 (&c->btree_trans_barrier){.+.+}-{0:0}, at: __bch2_trans_get+0x7e4/0xd30 fs/bcachefs/btree_iter.c:3377
 #2: ffff8880514266d0 (&c->gc_lock){.+.+}-{4:4}, at: bch2_btree_update_start+0x682/0x14e0 fs/bcachefs/btree_update_interior.c:1180
 #3: ffff888051401c68 (&bc->lock){+.+.}-{4:4}, at: bch2_btree_node_mem_alloc+0x559/0x16f0 fs/bcachefs/btree_cache.c:804

stack backtrace:
CPU: 0 UID: 0 PID: 5625 Comm: syz.0.21 Not tainted 6.14.0-rc2-syzkaller-00039-g09fbf3d50205 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2076
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2208
 check_prev_add kernel/locking/lockdep.c:3163 [inline]
 check_prevs_add kernel/locking/lockdep.c:3282 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3906
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5228
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0x19c/0x1010 kernel/locking/mutex.c:730
 pcpu_alloc_noprof+0x293/0x1760 mm/percpu.c:1782
 __six_lock_init+0x104/0x150 fs/bcachefs/six.c:876
 bch2_btree_lock_init+0x38/0x100 fs/bcachefs/btree_locking.c:12
 bch2_btree_node_mem_alloc+0x565/0x16f0 fs/bcachefs/btree_cache.c:807
 __bch2_btree_node_alloc fs/bcachefs/btree_update_interior.c:304 [inline]
 bch2_btree_reserve_get+0x2df/0x1890 fs/bcachefs/btree_update_interior.c:532
 bch2_btree_update_start+0xe56/0x14e0 fs/bcachefs/btree_update_interior.c:1230
 bch2_btree_split_leaf+0x121/0x880 fs/bcachefs/btree_update_interior.c:1851
 bch2_trans_commit_error+0x212/0x1380 fs/bcachefs/btree_trans_commit.c:908
 __bch2_trans_commit+0x812b/0x97a0 fs/bcachefs/btree_trans_commit.c:1085
 bch2_trans_commit fs/bcachefs/btree_update.h:183 [inline]
 bch2_trans_mark_metadata_bucket+0x47a/0x17b0 fs/bcachefs/buckets.c:1043
 bch2_trans_mark_metadata_sectors fs/bcachefs/buckets.c:1060 [inline]
 __bch2_trans_mark_dev_sb fs/bcachefs/buckets.c:1100 [inline]
 bch2_trans_mark_dev_sb+0x3f6/0x820 fs/bcachefs/buckets.c:1128
 bch2_trans_mark_dev_sbs_flags+0x6be/0x720 fs/bcachefs/buckets.c:1138
 bch2_fs_initialize+0xba0/0x1610 fs/bcachefs/recovery.c:1149
 bch2_fs_start+0x36d/0x610 fs/bcachefs/super.c:1042
 bch2_fs_get_tree+0xd8d/0x1740 fs/bcachefs/fs.c:2203
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3560
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4088
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcaed38e58a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcaec5fde68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fcaec5fdef0 RCX: 00007fcaed38e58a
RDX: 00004000000000c0 RSI: 0000400000000180 RDI: 00007fcaec5fdeb0
RBP: 00004000000000c0 R08: 00007fcaec5fdef0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000400000000180
R13: 00007fcaec5fdeb0 R14: 0000000000005a05 R15: 0000400000000480
 </TASK>
bcachefs (loop0): initializing freespace
bcachefs (loop0): done initializing freespace
bcachefs (loop0): reading snapshots table
bcachefs (loop0): reading snapshots done
bcachefs (loop0): done starting filesystem


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

