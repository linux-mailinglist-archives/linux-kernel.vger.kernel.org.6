Return-Path: <linux-kernel+bounces-216071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1408909AE2
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 03:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7159B20DD0
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 01:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382123D6B;
	Sun, 16 Jun 2024 01:04:27 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE1F1870
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 01:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718499866; cv=none; b=ACZNXShmgKpNv9cmtvFi/QqiAkWA48pyMZQUEfiNnY6CU4wCoVsQ0utbQsa3FeZEjLZlk7e32k6LHBTKwLToE4KW+JqB7C30djcJ53JXRfKnnn4yHHVl1DX0Pxcz3K2DPzvyeA3D2ILresYNyDjNwJJxJuTc5xsAzLLdSmiahhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718499866; c=relaxed/simple;
	bh=QP/kNVTAQOOubsILHR5sH3r9pTaZ+GaY3aM8GdjdN7c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=u3h+Qv8o7zKMZaFEpIKtdSCk5FWpNEcJstugIb7O+xThh7e4VfmZ0BjTU20ZA6DeLRRy9fZwyFtBxCTdm+eBX16H++i14n7P6GmhJsgeASBVtdrqYkO09nC/dz4eTwMK/CdcLuGqvY5qpacrdVSdF6UStEzoBomo4osV7PbkJTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-375ea274166so15376055ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 18:04:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718499864; x=1719104664;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nyaB5Rpu8CF5SAQPjrZeUJKclfgjkHJDmq3B0+cL4ao=;
        b=MtmJSgz+nY+vhDWZaMyM6HSX2ZIZE5CBsBzSKLg8cgjpVR4ZK6ijREBlS7ZV4O/qKR
         UxDxxyNjVmbjwe9sE/2NMrmF47x5oTpVOut3yK5zDProJgM0iu9poWE2/xqsLnHrlwhU
         /cL6oq4c6bfwmGWiB8uh/G6cf0EMX8bXm5Z7M/FVdZ8GmPNY3iNzIR5FcEH99kxSahXk
         530RHt9nzJ4JGESz7SsOIm2yPAzc94PwjGEiDTcagIOoNXOwyqb6b9+zDrCAHKJJeuG7
         +KaOWaMOJLdsVuJu/7oeWKzAJzVWZDu8gd1Q7Hi1GUhbK5AlCgn87D7nKwbNvZ+Lpojs
         YbvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAPHcVoJmV7VAQUC4w2fSsSUK4COeismgWKeEY47S6MBX6LRntF0+UJpzwTifb8x5gqpYGOJEXQovpnOnARLdLKX0BIYIy1wTle/hx
X-Gm-Message-State: AOJu0YwlzsK7VYw9UCZmKfDKQSyZMMBfF+T1Ii/a7QB5QursQ5NBjU0V
	JF4og/mybHATCtogtrYv2m4q7NQwbco1EHZ348MTlj2/R960VYoA5onrSNYEPITAYeK1iibZTUq
	xGQqW2MTo4JFv5Gy8/rz2TCd4Lz+GzKIAKk6d2FSK2aapt83EXYAjBpA=
X-Google-Smtp-Source: AGHT+IEmzxHHD/iPdADADltwY0yaCVbzG9L0rC4Fq78rJiJl6AxaEzxFmAyQp/JXeDdIpemDxcot/yqV5f32uS1x+M+RpmlDaAFl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19cc:b0:375:ae14:145b with SMTP id
 e9e14a558f8ab-375e1014777mr3851525ab.6.1718499863991; Sat, 15 Jun 2024
 18:04:23 -0700 (PDT)
Date: Sat, 15 Jun 2024 18:04:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f0a808061af76dd7@google.com>
Subject: [syzbot] [f2fs?] possible deadlock in mempool_alloc_noprof
From: syzbot <syzbot+9a18f6f681a8e79a3654@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2ccbdf43d5e7 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16a5b7ee980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=81c0d76ceef02b39
dashboard link: https://syzkaller.appspot.com/bug?extid=9a18f6f681a8e79a3654
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-2ccbdf43.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/13cdb5bfbafa/vmlinux-2ccbdf43.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7a14f5d07f81/bzImage-2ccbdf43.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9a18f6f681a8e79a3654@syzkaller.appspotmail.com

fscrypt: AES-256-CBC-CTS using implementation "cts-cbc-aes-aesni"
======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7 #0 Not tainted
------------------------------------------------------
syz-executor.0/9291 is trying to acquire lock:
ffffffff8dd3aac0 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:334 [inline]
ffffffff8dd3aac0 (fs_reclaim){+.+.}-{0:0}, at: mempool_alloc_noprof+0xd9/0x390 mm/mempool.c:392

but task is already holding lock:
ffff8880529643a8 (&sbi->cp_rwsem){++++}-{3:3}, at: f2fs_down_read fs/f2fs/f2fs.h:2154 [inline]
ffff8880529643a8 (&sbi->cp_rwsem){++++}-{3:3}, at: f2fs_lock_op fs/f2fs/f2fs.h:2203 [inline]
ffff8880529643a8 (&sbi->cp_rwsem){++++}-{3:3}, at: f2fs_mkdir+0x297/0x620 fs/f2fs/namei.c:778

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&sbi->cp_rwsem){++++}-{3:3}:
       down_read+0x9a/0x330 kernel/locking/rwsem.c:1526
       f2fs_down_read fs/f2fs/f2fs.h:2154 [inline]
       f2fs_lock_op fs/f2fs/f2fs.h:2203 [inline]
       f2fs_evict_inode+0x115a/0x1e50 fs/f2fs/inode.c:866
       evict+0x2ed/0x6c0 fs/inode.c:667
       iput_final fs/inode.c:1741 [inline]
       iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
       iput+0x5c/0x80 fs/inode.c:1757
       f2fs_evict_inode+0x125/0x1e50 fs/f2fs/inode.c:818
       evict+0x2ed/0x6c0 fs/inode.c:667
       dispose_list+0x117/0x1e0 fs/inode.c:700
       evict_inodes+0x34e/0x450 fs/inode.c:750
       generic_shutdown_super+0xb5/0x3d0 fs/super.c:627
       kill_block_super+0x3b/0x90 fs/super.c:1676
       kill_f2fs_super+0x2b4/0x440 fs/f2fs/super.c:4907
       deactivate_locked_super+0xbe/0x1a0 fs/super.c:473
       deactivate_super+0xde/0x100 fs/super.c:506
       cleanup_mnt+0x222/0x450 fs/namespace.c:1267
       task_work_run+0x14e/0x250 kernel/task_work.c:180
       resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
       exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
       exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
       __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
       syscall_exit_to_user_mode+0x278/0x2a0 kernel/entry/common.c:218
       __do_fast_syscall_32+0x80/0x120 arch/x86/entry/common.c:389
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #1 (sb_internal#4){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1655 [inline]
       sb_start_intwrite include/linux/fs.h:1838 [inline]
       f2fs_evict_inode+0x1844/0x1e50 fs/f2fs/inode.c:853
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
       __fs_reclaim_acquire mm/page_alloc.c:3801 [inline]
       fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3815
       might_alloc include/linux/sched/mm.h:334 [inline]
       mempool_alloc_noprof+0xd9/0x390 mm/mempool.c:392
       bio_alloc_bioset+0x480/0x8b0 block/bio.c:554
       f2fs_grab_read_bio+0x268/0x7d0 fs/f2fs/data.c:1050
       f2fs_submit_page_read+0xaa/0x1d0 fs/f2fs/data.c:1095
       f2fs_get_read_data_page+0x304/0xaf0 fs/f2fs/data.c:1271
       f2fs_find_data_page+0x13b/0x720 fs/f2fs/data.c:1293
       find_in_level fs/f2fs/dir.c:323 [inline]
       __f2fs_find_entry+0x3fd/0xc80 fs/f2fs/dir.c:388
       f2fs_do_add_link+0x109/0x290 fs/f2fs/dir.c:818
       f2fs_add_link fs/f2fs/f2fs.h:3586 [inline]
       f2fs_mkdir+0x37b/0x620 fs/f2fs/namei.c:779
       vfs_mkdir+0x57d/0x860 fs/namei.c:4131
       do_mkdirat+0x301/0x3a0 fs/namei.c:4154
       __do_sys_mkdirat fs/namei.c:4169 [inline]
       __se_sys_mkdirat fs/namei.c:4167 [inline]
       __ia32_sys_mkdirat+0x84/0xb0 fs/namei.c:4167
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

other info that might help us debug this:

Chain exists of:
  fs_reclaim --> sb_internal#4 --> &sbi->cp_rwsem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(&sbi->cp_rwsem);
                               lock(sb_internal#4);
                               lock(&sbi->cp_rwsem);
  lock(fs_reclaim);

 *** DEADLOCK ***

3 locks held by syz-executor.0/9291:
 #0: ffff8880593be420 (sb_writers#13){.+.+}-{0:0}, at: filename_create+0x10d/0x530 fs/namei.c:3893
 #1: ffff8880511650a0 (&type->i_mutex_dir_key#8/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:826 [inline]
 #1: ffff8880511650a0 (&type->i_mutex_dir_key#8/1){+.+.}-{3:3}, at: filename_create+0x1c2/0x530 fs/namei.c:3900
 #2: ffff8880529643a8 (&sbi->cp_rwsem){++++}-{3:3}, at: f2fs_down_read fs/f2fs/f2fs.h:2154 [inline]
 #2: ffff8880529643a8 (&sbi->cp_rwsem){++++}-{3:3}, at: f2fs_lock_op fs/f2fs/f2fs.h:2203 [inline]
 #2: ffff8880529643a8 (&sbi->cp_rwsem){++++}-{3:3}, at: f2fs_mkdir+0x297/0x620 fs/f2fs/namei.c:778

stack backtrace:
CPU: 0 PID: 9291 Comm: syz-executor.0 Not tainted 6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7 #0
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
 __fs_reclaim_acquire mm/page_alloc.c:3801 [inline]
 fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3815
 might_alloc include/linux/sched/mm.h:334 [inline]
 mempool_alloc_noprof+0xd9/0x390 mm/mempool.c:392
 bio_alloc_bioset+0x480/0x8b0 block/bio.c:554
 f2fs_grab_read_bio+0x268/0x7d0 fs/f2fs/data.c:1050
 f2fs_submit_page_read+0xaa/0x1d0 fs/f2fs/data.c:1095
 f2fs_get_read_data_page+0x304/0xaf0 fs/f2fs/data.c:1271
 f2fs_find_data_page+0x13b/0x720 fs/f2fs/data.c:1293
 find_in_level fs/f2fs/dir.c:323 [inline]
 __f2fs_find_entry+0x3fd/0xc80 fs/f2fs/dir.c:388
 f2fs_do_add_link+0x109/0x290 fs/f2fs/dir.c:818
 f2fs_add_link fs/f2fs/f2fs.h:3586 [inline]
 f2fs_mkdir+0x37b/0x620 fs/f2fs/namei.c:779
 vfs_mkdir+0x57d/0x860 fs/namei.c:4131
 do_mkdirat+0x301/0x3a0 fs/namei.c:4154
 __do_sys_mkdirat fs/namei.c:4169 [inline]
 __se_sys_mkdirat fs/namei.c:4167 [inline]
 __ia32_sys_mkdirat+0x84/0xb0 fs/namei.c:4167
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7325579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f5ef65ac EFLAGS: 00000292 ORIG_RAX: 0000000000000128
RAX: ffffffffffffffda RBX: 00000000ffffff9c RCX: 0000000020000080
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
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

