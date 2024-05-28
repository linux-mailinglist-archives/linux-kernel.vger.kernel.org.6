Return-Path: <linux-kernel+bounces-193045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEE68D260D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43175286531
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0D717921D;
	Tue, 28 May 2024 20:40:32 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678701791F2
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 20:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716928832; cv=none; b=WewsPRdTDwQ5MTq01cb7FQUz1vDAK35mXUyLO8gC+yW1D6jre/MR89C+RLKsbfBCkZhNsuV2bfdBGt0WrP3lg/hcTgT/Aj7PjJ9d2TGHNsNlZKUd08WEb1u3UalbRGjE23YcYpDb5wwRfwLPYZOgP4P7/Nn2ufAuIDRqoyTLSMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716928832; c=relaxed/simple;
	bh=73yupYHmt9pNwsbVVHnDOx7R2Zf7aFpVkVPAjwnHI5Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FdKrUNDJ8sLziXPzIu5pUiRglLpVEHzv83E5icN/RuvsU57c2xGWkJscpYU+CB9KlMWmfuM/RAj5pbbZYc0BzCKpCvGQcjaaE2r0CNdT3f2HZv4XaBROk/xwdToYnpuOrrYbpS6jceKHNy2aw6QvFMJ3EQWLVlEi+RyBsmQpe/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7eada05bd3bso143714439f.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 13:40:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716928829; x=1717533629;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=61vCZL0ZUE6NF9rNLv7XPINYfuoRg4l1gKt8IuzxJho=;
        b=MphxQ4aPkmz9am/p5JBh6vauKIocLgvyLjEjIJUd4HPfM3YRajfOpL40Ra/6Qk5Efu
         48VOAuXyeo9Shsa2EnsCuPgBhmkjAgvuxGzsSbL0Fiw9CKS9I2BACz1Hm6+zTg6NxBbx
         uHPRxKZ+3hpY7uTF5HvWPaJOgrk7prVPDjQGJ7ll5DM1xPl8+c3frEZB6Mo2hcKAx1kW
         B5imQNyIG4XgN0CftJRcLWnRF4YGtQ8PKKzBMvw5hOW9CWOhCPHnb6YG8nl6jBJGFFET
         s1qjIU6dDAHnAwo0IQ3OCEmWzFuH1XYhPxS+N1Hzt+SNv2T/Xh8fEbRbJKA2cPig5ohV
         T65A==
X-Forwarded-Encrypted: i=1; AJvYcCWlcGIDFmwSrIR1XWt9LrOgESWsOv0S2wIspGbqCQvb66Fymckh1yQAHsPePaHki50PlPPRrqkv+dku/+lzfJO2RVKjthP0Xk3FsyiI
X-Gm-Message-State: AOJu0YwUnoWeap37y5JRoTWWIpGYRzjL6B7/N6UrLoowxjQdlAInbcIU
	wl+zU7ZuMIsSIRVSg2lndr1ksJJvBgpL9YtrJHuMsoDVEZuF9LOccAZgHwGa9JaqKe03HwQjuZy
	2xtMMm0+Bz4G2ZrINrA7ZFWEudQVAmzXPZWCb8NvI4xRslRzFNx9RWoM=
X-Google-Smtp-Source: AGHT+IG4ooGiZ72ftGO+GKC3FtuDTLtJvTNmFV4UTA8Wnfv1htrL/nWuuabnyxKorVEkQvPwHFNzZiJVS+emnTceGqPAiksCfHfL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:830b:b0:4b1:1112:bf1c with SMTP id
 8926c6da1cb9f-4b11112c0e0mr41673173.2.1716928829601; Tue, 28 May 2024
 13:40:29 -0700 (PDT)
Date: Tue, 28 May 2024 13:40:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fe4688061989a44f@google.com>
Subject: [syzbot] [ntfs3?] possible deadlock in ntfs_set_size (2)
From: syzbot <syzbot+516b0263e31e4b561fdd@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    02c438bbfffe Merge tag 'for-6.10-tag' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14b92b3f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2b8d1faad9ceb620
dashboard link: https://syzkaller.appspot.com/bug?extid=516b0263e31e4b561fdd
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-02c438bb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f15f7f7666df/vmlinux-02c438bb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/171158a72c15/bzImage-02c438bb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+516b0263e31e4b561fdd@syzkaller.appspotmail.com

ntfs3: loop2: Different NTFS sector size (4096) and media sector size (512).
ntfs3: loop2: Mark volume as dirty due to NTFS errors
======================================================
WARNING: possible circular locking dependency detected
6.9.0-syzkaller-12220-g02c438bbfffe #0 Not tainted
------------------------------------------------------
syz-executor.2/10627 is trying to acquire lock:
ffffffff8dd3a860 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:334 [inline]
ffffffff8dd3a860 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slub.c:3890 [inline]
ffffffff8dd3a860 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:3980 [inline]
ffffffff8dd3a860 (fs_reclaim){+.+.}-{0:0}, at: __do_kmalloc_node mm/slub.c:4120 [inline]
ffffffff8dd3a860 (fs_reclaim){+.+.}-{0:0}, at: __kmalloc_node_noprof+0xbb/0x450 mm/slub.c:4128

but task is already holding lock:
ffff888028cef050 (&ni->file.run_lock#2){++++}-{3:3}, at: ntfs_set_size+0x119/0x220 fs/ntfs3/inode.c:843

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&ni->file.run_lock#2){++++}-{3:3}:
       down_read+0x9a/0x330 kernel/locking/rwsem.c:1526
       mi_read+0x301/0x660 fs/ntfs3/record.c:129
       mi_format_new+0x376/0x540 fs/ntfs3/record.c:420
       ni_add_subrecord+0xd1/0x4f0 fs/ntfs3/frecord.c:372
       ntfs_look_free_mft+0x209/0xdd0 fs/ntfs3/fsntfs.c:715
       ni_create_attr_list+0x75b/0x1280 fs/ntfs3/frecord.c:876
       ni_ins_attr_ext+0x236/0xae0 fs/ntfs3/frecord.c:974
       ni_insert_attr+0x305/0x820 fs/ntfs3/frecord.c:1141
       ni_insert_resident+0xd2/0x3a0 fs/ntfs3/frecord.c:1525
       ni_add_name+0x48b/0x820 fs/ntfs3/frecord.c:3047
       ni_rename+0xa1/0x1a0 fs/ntfs3/frecord.c:3087
       ntfs_rename+0x96f/0xf20 fs/ntfs3/namei.c:334
       vfs_rename+0xf84/0x20a0 fs/namei.c:4887
       do_renameat2+0xc54/0xdc0 fs/namei.c:5044
       __do_sys_rename fs/namei.c:5091 [inline]
       __se_sys_rename fs/namei.c:5089 [inline]
       __ia32_sys_rename+0x80/0xa0 fs/namei.c:5089
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #1 (&wnd->rw_lock/1){+.+.}-{3:3}:
       down_write_nested+0x3d/0x50 kernel/locking/rwsem.c:1695
       ntfs_mark_rec_free+0x2f4/0x400 fs/ntfs3/fsntfs.c:742
       ni_delete_all+0x6ad/0x880 fs/ntfs3/frecord.c:1637
       ni_clear+0x519/0x6a0 fs/ntfs3/frecord.c:106
       evict+0x2ed/0x6c0 fs/inode.c:667
       iput_final fs/inode.c:1741 [inline]
       iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
       iput+0x5c/0x80 fs/inode.c:1757
       dentry_unlink_inode+0x295/0x480 fs/dcache.c:400
       __dentry_kill+0x1d0/0x600 fs/dcache.c:603
       shrink_kill fs/dcache.c:1048 [inline]
       shrink_dentry_list+0x140/0x5d0 fs/dcache.c:1075
       prune_dcache_sb+0xeb/0x150 fs/dcache.c:1156
       super_cache_scan+0x32a/0x550 fs/super.c:221
       do_shrink_slab+0x44f/0x11c0 mm/shrinker.c:435
       shrink_slab_memcg mm/shrinker.c:548 [inline]
       shrink_slab+0xa87/0x1310 mm/shrinker.c:626
       shrink_one+0x493/0x7c0 mm/vmscan.c:4790
       shrink_many mm/vmscan.c:4851 [inline]
       lru_gen_shrink_node+0x89f/0x1750 mm/vmscan.c:4951
       shrink_node mm/vmscan.c:5910 [inline]
       kswapd_shrink_node mm/vmscan.c:6720 [inline]
       balance_pgdat+0x1105/0x1970 mm/vmscan.c:6911
       kswapd+0x5ea/0xbf0 mm/vmscan.c:7180
       kthread+0x2c1/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
       __fs_reclaim_acquire mm/page_alloc.c:3783 [inline]
       fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3797
       might_alloc include/linux/sched/mm.h:334 [inline]
       slab_pre_alloc_hook mm/slub.c:3890 [inline]
       slab_alloc_node mm/slub.c:3980 [inline]
       __do_kmalloc_node mm/slub.c:4120 [inline]
       __kmalloc_node_noprof+0xbb/0x450 mm/slub.c:4128
       kmalloc_node_noprof include/linux/slab.h:681 [inline]
       kvmalloc_node_noprof+0x9d/0x1a0 mm/util.c:634
       run_add_entry+0x7ba/0xb00 fs/ntfs3/run.c:389
       attr_allocate_clusters+0x213/0x720 fs/ntfs3/attrib.c:181
       attr_set_size+0x142e/0x2b90 fs/ntfs3/attrib.c:572
       ntfs_set_size+0x13d/0x220 fs/ntfs3/inode.c:845
       ntfs_extend+0x401/0x570 fs/ntfs3/file.c:335
       ntfs_file_write_iter+0x433/0x2050 fs/ntfs3/file.c:1115
       new_sync_write fs/read_write.c:497 [inline]
       vfs_write+0x6b6/0x1140 fs/read_write.c:590
       ksys_write+0x12f/0x260 fs/read_write.c:643
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

other info that might help us debug this:

Chain exists of:
  fs_reclaim --> &wnd->rw_lock/1 --> &ni->file.run_lock#2

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ni->file.run_lock#2);
                               lock(&wnd->rw_lock/1);
                               lock(&ni->file.run_lock#2);
  lock(fs_reclaim);

 *** DEADLOCK ***

5 locks held by syz-executor.2/10627:
 #0: ffff88801de9f048 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xeb/0x180 fs/file.c:1191
 #1: ffff88802bf00420 (sb_writers#21){.+.+}-{0:0}, at: ksys_write+0x12f/0x260 fs/read_write.c:643
 #2: ffff888028cef240 (&sb->s_type->i_mutex_key#30){+.+.}-{3:3}, at: inode_trylock include/linux/fs.h:811 [inline]
 #2: ffff888028cef240 (&sb->s_type->i_mutex_key#30){+.+.}-{3:3}, at: ntfs_file_write_iter+0x2db/0x2050 fs/ntfs3/file.c:1093
 #3: ffff888028ceefa0 (&ni->ni_lock/4){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1123 [inline]
 #3: ffff888028ceefa0 (&ni->ni_lock/4){+.+.}-{3:3}, at: ntfs_set_size+0x111/0x220 fs/ntfs3/inode.c:842
 #4: ffff888028cef050 (&ni->file.run_lock#2){++++}-{3:3}, at: ntfs_set_size+0x119/0x220 fs/ntfs3/inode.c:843

stack backtrace:
CPU: 3 PID: 10627 Comm: syz-executor.2 Not tainted 6.9.0-syzkaller-12220-g02c438bbfffe #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 __fs_reclaim_acquire mm/page_alloc.c:3783 [inline]
 fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3797
 might_alloc include/linux/sched/mm.h:334 [inline]
 slab_pre_alloc_hook mm/slub.c:3890 [inline]
 slab_alloc_node mm/slub.c:3980 [inline]
 __do_kmalloc_node mm/slub.c:4120 [inline]
 __kmalloc_node_noprof+0xbb/0x450 mm/slub.c:4128
 kmalloc_node_noprof include/linux/slab.h:681 [inline]
 kvmalloc_node_noprof+0x9d/0x1a0 mm/util.c:634
 run_add_entry+0x7ba/0xb00 fs/ntfs3/run.c:389
 attr_allocate_clusters+0x213/0x720 fs/ntfs3/attrib.c:181
 attr_set_size+0x142e/0x2b90 fs/ntfs3/attrib.c:572
 ntfs_set_size+0x13d/0x220 fs/ntfs3/inode.c:845
 ntfs_extend+0x401/0x570 fs/ntfs3/file.c:335
 ntfs_file_write_iter+0x433/0x2050 fs/ntfs3/file.c:1115
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0x6b6/0x1140 fs/read_write.c:590
 ksys_write+0x12f/0x260 fs/read_write.c:643
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7330579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f5f225ac EFLAGS: 00000292 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000020000100
RDX: 0000000000000020 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

