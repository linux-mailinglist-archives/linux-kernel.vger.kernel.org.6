Return-Path: <linux-kernel+bounces-209017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1328902BDF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 00:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C0C2283028
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00851514DE;
	Mon, 10 Jun 2024 22:50:37 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302E5481DA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 22:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718059837; cv=none; b=LlEqHpKpbAZDnwcFbvMZIrxI+iGNuUBWAe3V0eUOv2vgRzbNRkprH1EfO8gbXjQZTqfFQCwTIgf4VUeBktu8FBQYWFxN6gjloEBUCrhadbFYKdVFeP4Eo+5nNBWhtX/5yuI+jrxSAjZFV79GS012I0cn+lqSdgOViQMpjqSn1lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718059837; c=relaxed/simple;
	bh=2iBHUC4QPXd3W1eGIj88wI1FtpPKcYHcGeHyqkzCdGU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PaAXubfU2N2A6LPXi6Hm+S5DqBzplwWTDCzXIyQ79Vl8s+j1/6QL/9uNzKtxy6nILOU6c6UHbmsajFtVXcenH97cM0KxYs06nmyYCCMp6TkS20GNzK9KaUmcL897RQ66Vl5J0jRkKzAESSAA3w4vwtmiNdaxSPTUUlwdr+3V6Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7eb80de5e7dso41599439f.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 15:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718059834; x=1718664634;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y5utWOrdfx8y7ZVnfXaC1Ab6azeYl0T2mqo58QFjZGs=;
        b=spFEHQPasVFhRASLm/Utyh1atsgk9unIn99gQhBsN+CgmBOImgda7Gx2NCWIVCh9pX
         S/DIJkLFSx3fgBrUeEv853qtnsN0MxymbtIS0xTMvmPdtXvvKvaFF0I71kovynUFGthj
         9D86klNeM+gwFCwYyW/odtO0kuCRRHz5V/mS6f5C02PUzC8bKm9VULotmAR+YBtMX4+B
         xXKiavhwIUUZFVhRgiHLsomlZuekepdEv3Dou4XvAboovWbAvAQPowUcq5ME+M8Ot3rF
         G3fkAjmTvTnKcdCnn73fpgPdr9xrrplRYG2iYIcuTbuiiKT8wN63IkeQHYx4YGL+Ydaz
         cMZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJXLR+lH4IdpuQk1zWzWV8ZiNT4vqFJABAWW2NsObSvkQdzjEtMJntEetFw5AcOSbYMu4XB145xc/eOEV5plDP2j52KSRRUeisSrzk
X-Gm-Message-State: AOJu0YxF0+17w4HbanXkwZ8TfZpNxRdLCQDZ6IcXs3Aade35i1i5TCsT
	NizDBh2DYA67znNS+GuFcb5DhCBdttwJYWbMMxKkOEjI+l9RySzdngHWJgTO4+LiSQfSjUt/POd
	EZcxYoeGqlummjRPdo2u6DotnWLEAR+aJAjLOGYx/KxKq9SoHrkbLm0k=
X-Google-Smtp-Source: AGHT+IEgnkEeTzAAujFvGhZVTwtDaAaMV++DF9ZGuEopf7IM6+K2SaA8IwvzjiQwKOApQjNAqbnEok7Zg+BuQY1c8BgMpjcH9bCE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:40a7:b0:4b9:165a:ffbe with SMTP id
 8926c6da1cb9f-4b9165b0475mr233722173.0.1718059834254; Mon, 10 Jun 2024
 15:50:34 -0700 (PDT)
Date: Mon, 10 Jun 2024 15:50:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001fb6bb061a90fa73@google.com>
Subject: [syzbot] [jfs?] possible deadlock in jfs_rename
From: syzbot <syzbot+456e180af22874103cc8@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d30d0e49da71 Merge tag 'net-6.10-rc3' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17f4bfd6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=96fd46a1ee1615e0
dashboard link: https://syzkaller.appspot.com/bug?extid=456e180af22874103cc8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-d30d0e49.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/970e3906a552/vmlinux-d30d0e49.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d80af4a76ff6/bzImage-d30d0e49.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+456e180af22874103cc8@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc2-syzkaller-00222-gd30d0e49da71 #0 Not tainted
------------------------------------------------------
syz-executor.1/17764 is trying to acquire lock:
ffff888000379448 (&jfs_ip->commit_mutex/1){+.+.}-{3:3}, at: jfs_rename+0x602/0x19d0 fs/jfs/namei.c:1163

but task is already holding lock:
ffff88804844f0c8 (&jfs_ip->commit_mutex){+.+.}-{3:3}, at: jfs_rename+0x5e6/0x19d0 fs/jfs/namei.c:1162

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #5 (&jfs_ip->commit_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       diNewIAG fs/jfs/jfs_imap.c:2519 [inline]
       diAllocExt fs/jfs/jfs_imap.c:1902 [inline]
       diAllocAG+0xc59/0x2300 fs/jfs/jfs_imap.c:1666
       diAlloc+0x8f7/0x1a70 fs/jfs/jfs_imap.c:1587
       ialloc+0x84/0x9e0 fs/jfs/jfs_inode.c:56
       jfs_mkdir+0x244/0xb30 fs/jfs/namei.c:225
       vfs_mkdir+0x57d/0x860 fs/namei.c:4131
       do_mkdirat+0x301/0x3a0 fs/namei.c:4154
       __do_sys_mkdir fs/namei.c:4174 [inline]
       __se_sys_mkdir fs/namei.c:4172 [inline]
       __ia32_sys_mkdir+0xf0/0x140 fs/namei.c:4172
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #4 (&jfs_ip->rdwrlock/1){++++}-{3:3}:
       down_read_nested+0x9e/0x330 kernel/locking/rwsem.c:1651
       diAlloc+0x3ea/0x1a70 fs/jfs/jfs_imap.c:1385
       ialloc+0x84/0x9e0 fs/jfs/jfs_inode.c:56
       jfs_create+0x23e/0xb40 fs/jfs/namei.c:92
       lookup_open.isra.0+0x10a1/0x13c0 fs/namei.c:3505
       open_last_lookups fs/namei.c:3574 [inline]
       path_openat+0x92f/0x29f0 fs/namei.c:3804
       do_filp_open+0x1dc/0x430 fs/namei.c:3834
       do_sys_openat2+0x17a/0x1e0 fs/open.c:1405
       do_sys_open fs/open.c:1420 [inline]
       __do_sys_creat fs/open.c:1496 [inline]
       __se_sys_creat fs/open.c:1490 [inline]
       __ia32_sys_creat+0xcc/0x120 fs/open.c:1490
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #3 (&(imap->im_aglock[index])){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       diFree+0x2ff/0x2770 fs/jfs/jfs_imap.c:886
       jfs_evict_inode+0x3d4/0x4b0 fs/jfs/inode.c:156
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

-> #2 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:3783 [inline]
       fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3797
       might_alloc include/linux/sched/mm.h:334 [inline]
       slab_pre_alloc_hook mm/slub.c:3890 [inline]
       slab_alloc_node mm/slub.c:3980 [inline]
       __do_kmalloc_node mm/slub.c:4120 [inline]
       __kmalloc_noprof+0xb5/0x420 mm/slub.c:4134
       kmalloc_noprof include/linux/slab.h:664 [inline]
       ea_get+0x21f/0x12c0 fs/jfs/xattr.c:487
       __jfs_setxattr+0x1ed/0xfb0 fs/jfs/xattr.c:718
       __jfs_xattr_set+0xc6/0x150 fs/jfs/xattr.c:917
       __vfs_setxattr+0x173/0x1e0 fs/xattr.c:200
       __vfs_setxattr_noperm+0x127/0x660 fs/xattr.c:234
       __vfs_setxattr_locked+0x182/0x260 fs/xattr.c:295
       vfs_setxattr+0x146/0x350 fs/xattr.c:321
       do_setxattr+0x146/0x170 fs/xattr.c:629
       setxattr+0x15d/0x180 fs/xattr.c:652
       path_setxattr+0x179/0x1e0 fs/xattr.c:671
       __do_sys_lsetxattr fs/xattr.c:694 [inline]
       __se_sys_lsetxattr fs/xattr.c:690 [inline]
       __ia32_sys_lsetxattr+0xbd/0x160 fs/xattr.c:690
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #1 (&jfs_ip->xattr_sem){++++}-{3:3}:
       down_read+0x9a/0x330 kernel/locking/rwsem.c:1526
       __jfs_getxattr+0xee/0x360 fs/jfs/xattr.c:805
       jfs_get_acl+0x7c/0x170 fs/jfs/acl.c:38
       __get_acl+0x378/0x4e0 fs/posix_acl.c:159
       get_inode_acl fs/posix_acl.c:184 [inline]
       posix_acl_create+0x14c/0x5f0 fs/posix_acl.c:647
       jfs_init_acl+0x9a/0x3a0 fs/jfs/acl.c:135
       jfs_create+0x2d9/0xb40 fs/jfs/namei.c:103
       lookup_open.isra.0+0x10a1/0x13c0 fs/namei.c:3505
       open_last_lookups fs/namei.c:3574 [inline]
       path_openat+0x92f/0x29f0 fs/namei.c:3804
       do_filp_open+0x1dc/0x430 fs/namei.c:3834
       do_sys_openat2+0x17a/0x1e0 fs/open.c:1405
       do_sys_open fs/open.c:1420 [inline]
       __do_sys_creat fs/open.c:1496 [inline]
       __se_sys_creat fs/open.c:1490 [inline]
       __ia32_sys_creat+0xcc/0x120 fs/open.c:1490
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #0 (&jfs_ip->commit_mutex/1){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       jfs_rename+0x602/0x19d0 fs/jfs/namei.c:1163
       vfs_rename+0xf84/0x20a0 fs/namei.c:4887
       do_renameat2+0xc54/0xdc0 fs/namei.c:5044
       __do_sys_renameat2 fs/namei.c:5078 [inline]
       __se_sys_renameat2 fs/namei.c:5075 [inline]
       __ia32_sys_renameat2+0xeb/0x130 fs/namei.c:5075
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

other info that might help us debug this:

Chain exists of:
  &jfs_ip->commit_mutex/1 --> &jfs_ip->rdwrlock/1 --> &jfs_ip->commit_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&jfs_ip->commit_mutex);
                               lock(&jfs_ip->rdwrlock/1);
                               lock(&jfs_ip->commit_mutex);
  lock(&jfs_ip->commit_mutex/1);

 *** DEADLOCK ***

8 locks held by syz-executor.1/17764:
 #0: ffff88801bb26420 (sb_writers#22){.+.+}-{0:0}, at: do_renameat2+0x3d6/0xdc0 fs/namei.c:4974
 #1: ffff88801bb26730 (&type->s_vfs_rename_key#8){+.+.}-{3:3}, at: lock_rename fs/namei.c:3078 [inline]
 #1: ffff88801bb26730 (&type->s_vfs_rename_key#8){+.+.}-{3:3}, at: do_renameat2+0x4ef/0xdc0 fs/namei.c:4979
 #2: ffff88804844f480 (&type->i_mutex_dir_key#17/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:826 [inline]
 #2: ffff88804844f480 (&type->i_mutex_dir_key#17/1){+.+.}-{3:3}, at: lock_two_directories+0x162/0x2d0 fs/namei.c:3054
 #3: ffff88804844a140 (&type->i_mutex_dir_key#17/5){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:826 [inline]
 #3: ffff88804844a140 (&type->i_mutex_dir_key#17/5){+.+.}-{3:3}, at: lock_two_directories+0x199/0x2d0 fs/namei.c:3055
 #4: ffff888000379800 (&sb->s_type->i_mutex_key#29){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:791 [inline]
 #4: ffff888000379800 (&sb->s_type->i_mutex_key#29){+.+.}-{3:3}, at: lock_two_nondirectories+0x195/0x200 fs/inode.c:1111
 #5: ffff88804844aa80 (&sb->s_type->i_mutex_key#29/4){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:826 [inline]
 #5: ffff88804844aa80 (&sb->s_type->i_mutex_key#29/4){+.+.}-{3:3}, at: lock_two_nondirectories+0xed/0x200 fs/inode.c:1113
 #6: ffff88804844a638 (&jfs_ip->rdwrlock#3){++++}-{3:3}, at: jfs_rename+0xf08/0x19d0 fs/jfs/namei.c:1144
 #7: ffff88804844f0c8 (&jfs_ip->commit_mutex){+.+.}-{3:3}, at: jfs_rename+0x5e6/0x19d0 fs/jfs/namei.c:1162

stack backtrace:
CPU: 0 PID: 17764 Comm: syz-executor.1 Not tainted 6.10.0-rc2-syzkaller-00222-gd30d0e49da71 #0
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
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
 jfs_rename+0x602/0x19d0 fs/jfs/namei.c:1163
 vfs_rename+0xf84/0x20a0 fs/namei.c:4887
 do_renameat2+0xc54/0xdc0 fs/namei.c:5044
 __do_sys_renameat2 fs/namei.c:5078 [inline]
 __se_sys_renameat2 fs/namei.c:5075 [inline]
 __ia32_sys_renameat2+0xeb/0x130 fs/namei.c:5075
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf730b579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f5efd5ac EFLAGS: 00000292 ORIG_RAX: 0000000000000161
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000020000340
RDX: 0000000000000005 RSI: 00000000200003c0 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
find_entry called with index = 0
read_mapping_page failed!
ERROR: (device loop1): txAbort: 

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

