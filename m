Return-Path: <linux-kernel+bounces-228229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E0B915D11
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 04:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11FC61C20A45
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 02:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D71371748;
	Tue, 25 Jun 2024 02:53:27 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B828849646
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 02:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719284006; cv=none; b=iqZC4NlaUUv75jIxlaC1QKyusj1Ztlx1pkKvzgpjghTJ0WGVnB9LuM0VC7qVDe9w8BXOXwPe2iIRwNzDmpgYzc2/k/p6K+7Wcc/nW8+bjw+XeWjxzUtgncPW3oMEz/0onaklWfhzujKN40Yj1Pj95sIPN7ROyWxmH0h/g0maWAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719284006; c=relaxed/simple;
	bh=S7+gfm4d4iNVGs0RhSA8T413pRdFnjgMne0Asyf/u+0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=spKecTPpOBkbglm/tGktUk/Y95IsZG4YmwbWaxqSYvc7Ppc2aAJsnqqikdpJApUtecEE+idm8/NpzxbMFU5xJWlDrfruB9fzpFMsxlC/vbtnl9awCnRNe1JynWOkmy/W7M5ElND9+QO+kiL6g4GN14oPZ0sZjOAUjCfoTJULWr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3737b3ae019so62470645ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 19:53:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719284004; x=1719888804;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kP+P6RJcUraw7F4CvjY12yZNpRMlORe3aYPwCWneHec=;
        b=ZBLlDNyXZ8Dq1lYFX8P2HpjmgiUmjJD0eEzNq1mpSr8sYYYQRv52ZmGIcUVyu8W4/N
         PQQFcYD2QmNyQ2yK/wbqV1PDYAov19rMCDFnROe0tQqm8s/Fa5hYPsXLVxT4Azt5gRg1
         R5R8khnitky1SeQk2b0otjRwBlLV0Dy8vquqrCppimp56actTUynD/UyLQFhARgUSbVl
         RIQwjAuF7vEJSw3UG9VI6P984AneZigMdMSKdydF9Yb9aRO2xXrBHGfjNDnFZIv4z5v4
         Yw8D40rdKi1ZMdfwJy7IB3m4f4KdMgEck/5QQBxK0wRQw1kVcoNEpBGyRXipohoq7SFS
         NuLw==
X-Forwarded-Encrypted: i=1; AJvYcCUyBU1usz/HJCT4FckCn7CGqu4rcLRfStN6RTf+Wq9ptaF1tkusi+ofvM1qrPswQoYKme0O/lOsNjr9Zf1fQldAHOjY/F+H7ENqkWMz
X-Gm-Message-State: AOJu0YzHWDzsdAyE5WhdvYnLb9rSw61XNA52guyyKr9lwniaKvFFACf7
	7WhGoyB96kzmWxTaHNU0LLzwk/oruJBg6Q9i8joajNSqPehnszOcOI+6q+e4DE9egO/zhE/FfYE
	3Rphzh28GAUqwYzOlJVrL+VlM/NlwL71T4NnaSBeDpERQoAfxzNmfky0=
X-Google-Smtp-Source: AGHT+IE3vwI0DzChUs9N++W+hrM+DaKAH0FtMM0xQyI3sbD52/1IrnaqUMXWniAvRU7FzFLAqZNk0ZOgndtzrkLHs1R7+N+sruPg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b21:b0:374:a021:f1b2 with SMTP id
 e9e14a558f8ab-3763f7424b5mr4915975ab.5.1719284003905; Mon, 24 Jun 2024
 19:53:23 -0700 (PDT)
Date: Mon, 24 Jun 2024 19:53:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000523442061bae0072@google.com>
Subject: [syzbot] [jfs?] possible deadlock in jfs_create
From: syzbot <syzbot+bdacb5fa2bf85deafea9@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    50736169ecc8 Merge tag 'for-6.10-rc4-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14c0d08e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d24262d81a9225c6
dashboard link: https://syzkaller.appspot.com/bug?extid=bdacb5fa2bf85deafea9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-50736169.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c6c00759502a/vmlinux-50736169.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c94681a1aaa3/bzImage-50736169.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bdacb5fa2bf85deafea9@syzkaller.appspotmail.com

loop2: detected capacity change from 0 to 32768
======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc4-syzkaller-00148-g50736169ecc8 #0 Not tainted
------------------------------------------------------
syz-executor.2/9183 is trying to acquire lock:
ffff88804c874288 (&jfs_ip->commit_mutex/1){+.+.}-{3:3}, at: jfs_create+0x2c3/0xb40 fs/jfs/namei.c:101

but task is already holding lock:
ffff88804c873948 (&jfs_ip->commit_mutex){+.+.}-{3:3}, at: jfs_create+0x2a7/0xb40 fs/jfs/namei.c:100

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
       __lock_release kernel/locking/lockdep.c:5468 [inline]
       lock_release+0x33e/0x6c0 kernel/locking/lockdep.c:5774
       __mutex_unlock_slowpath+0xa3/0x650 kernel/locking/mutex.c:912
       diNewIAG fs/jfs/jfs_imap.c:2634 [inline]
       diAllocExt fs/jfs/jfs_imap.c:1902 [inline]
       diAllocAG+0x912/0x2300 fs/jfs/jfs_imap.c:1666
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
       __fs_reclaim_acquire mm/page_alloc.c:3801 [inline]
       fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3815
       might_alloc include/linux/sched/mm.h:334 [inline]
       slab_pre_alloc_hook mm/slub.c:3891 [inline]
       slab_alloc_node mm/slub.c:3981 [inline]
       __do_kmalloc_node mm/slub.c:4121 [inline]
       __kmalloc_noprof+0xb5/0x420 mm/slub.c:4135
       kmalloc_noprof include/linux/slab.h:664 [inline]
       ea_get+0x21f/0x12c0 fs/jfs/xattr.c:487
       __jfs_setxattr+0x1ed/0xfb0 fs/jfs/xattr.c:720
       __jfs_xattr_set+0xc6/0x150 fs/jfs/xattr.c:919
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
       __jfs_getxattr+0xee/0x360 fs/jfs/xattr.c:807
       jfs_get_acl+0x7c/0x170 fs/jfs/acl.c:38
       __get_acl+0x378/0x4e0 fs/posix_acl.c:159
       get_inode_acl fs/posix_acl.c:184 [inline]
       posix_acl_create+0x14c/0x5f0 fs/posix_acl.c:647
       jfs_init_acl+0x9a/0x3a0 fs/jfs/acl.c:135
       jfs_mkdir+0x2df/0xb30 fs/jfs/namei.c:236
       vfs_mkdir+0x57d/0x860 fs/namei.c:4131
       do_mkdirat+0x301/0x3a0 fs/namei.c:4154
       __do_sys_mkdir fs/namei.c:4174 [inline]
       __se_sys_mkdir fs/namei.c:4172 [inline]
       __ia32_sys_mkdir+0xf0/0x140 fs/namei.c:4172
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
       jfs_create+0x2c3/0xb40 fs/jfs/namei.c:101
       lookup_open.isra.0+0x10a1/0x13c0 fs/namei.c:3505
       open_last_lookups fs/namei.c:3574 [inline]
       path_openat+0x92f/0x29f0 fs/namei.c:3804
       do_filp_open+0x1dc/0x430 fs/namei.c:3834
       do_sys_openat2+0x17a/0x1e0 fs/open.c:1405
       do_sys_open fs/open.c:1420 [inline]
       __do_compat_sys_openat fs/open.c:1480 [inline]
       __se_compat_sys_openat fs/open.c:1478 [inline]
       __ia32_compat_sys_openat+0x16e/0x210 fs/open.c:1478
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

3 locks held by syz-executor.2/9183:
 #0: ffff888057d1c420 (sb_writers#29){.+.+}-{0:0}, at: open_last_lookups fs/namei.c:3563 [inline]
 #0: ffff888057d1c420 (sb_writers#29){.+.+}-{0:0}, at: path_openat+0x19e6/0x29f0 fs/namei.c:3804
 #1: ffff88804c873d00 (&type->i_mutex_dir_key#13){++++}-{3:3}, at: inode_lock include/linux/fs.h:791 [inline]
 #1: ffff88804c873d00 (&type->i_mutex_dir_key#13){++++}-{3:3}, at: open_last_lookups fs/namei.c:3571 [inline]
 #1: ffff88804c873d00 (&type->i_mutex_dir_key#13){++++}-{3:3}, at: path_openat+0x8c7/0x29f0 fs/namei.c:3804
 #2: ffff88804c873948 (&jfs_ip->commit_mutex){+.+.}-{3:3}, at: jfs_create+0x2a7/0xb40 fs/jfs/namei.c:100

stack backtrace:
CPU: 3 PID: 9183 Comm: syz-executor.2 Not tainted 6.10.0-rc4-syzkaller-00148-g50736169ecc8 #0
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
 jfs_create+0x2c3/0xb40 fs/jfs/namei.c:101
 lookup_open.isra.0+0x10a1/0x13c0 fs/namei.c:3505
 open_last_lookups fs/namei.c:3574 [inline]
 path_openat+0x92f/0x29f0 fs/namei.c:3804
 do_filp_open+0x1dc/0x430 fs/namei.c:3834
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1405
 do_sys_open fs/open.c:1420 [inline]
 __do_compat_sys_openat fs/open.c:1480 [inline]
 __se_compat_sys_openat fs/open.c:1478 [inline]
 __ia32_compat_sys_openat+0x16e/0x210 fs/open.c:1478
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf72ca579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f5ebc5ac EFLAGS: 00000292 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 00000000ffffff9c RCX: 0000000020000040
RDX: 000000000000275a RSI: 0000000000000000 RDI: 0000000000000000
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

