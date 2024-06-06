Return-Path: <linux-kernel+bounces-203807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D929D8FE0AE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D34371C23CC5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B569913C673;
	Thu,  6 Jun 2024 08:14:30 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520DA13A898
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717661670; cv=none; b=u6VZO9XlTJgt2xFFFIOw0JmGBrji6YrJBGPGT/HcdzaERvicTuspSwrRmpK4VxSv4bbYzPSqOU9/T9itDJVE0xij8xb8F5zmC+yc6aCdcuxw5xvTMaNdl/2OOPeCQWoHKUOkEAs8HQIZiMONxaBog3Xx2Fou03zNn2upkXpevok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717661670; c=relaxed/simple;
	bh=LDSQqOl+OJl03Ml/7OIYVgt/p58ir6WP469EFDT17XQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZC4BilgAgIwlSNdtiD6K0rjJUg4/XVTFWt8HiYF3A2YGX7kHp9lVxtbw4ClEbVCV5jC5NFW7J4758AHx86RGUsnrhXfh29Rdbf7D36SreXAY8cHtlIEpDRTn8qb5otfFxoEUDPybQDHa7nxQ0pO4wH030pGogyGeQa2KTyPYo8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-374b7648ab3so7622685ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 01:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717661667; x=1718266467;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B+ouDivlT1UsPVZhY1dEBo1XO973QOPuJP8MaEC6UFM=;
        b=WgboZlfS/4QqLL+CmgbY/EzJ4RDyLat6Y6lRyCskiZq2KTesH9HlfxCtM0EUTPH8vi
         WusQF5QC0RYyAjybeJeamfrEinRSiFtPLep8vK/3PskVQkbKmUAUl/Jv78/DgXVqzbcr
         OLqUg7rHmCoI/05ChZqvGh26lLk5c9QhkfS7VgIhTKYhn7ajZhuDGySiLkMXBeqmIbsj
         QTanhNYf8f2fi0ZFvI+eyrO1Shdgjm08btYVLEEe8Y9Fe7dhkXTAQVxTLb4N99WK1k9R
         Mk/cyfhGO9yelu1J1IAUPzAheKfbdhV3oNxtroQgnHzAOeS4I0722XqwmFp0PlONO8Bl
         ZlGg==
X-Forwarded-Encrypted: i=1; AJvYcCWL5Pnlf+U40bjNU48dOOwcQVzP5HS/0d/jblTQOjXkfxkbeIQkwThg6JFTa/hCypXZDeODJKykE0RMQV8IUtsJSI94T0SFQqxdbNhz
X-Gm-Message-State: AOJu0YzoGlOW/lrPgRy1Guhft+xYliexcx0wnUMBb52UKBsU6gt9hYkU
	d0aHkish2oGXtwLOIEJFLeJsm/YE0GFVqxcFagm/C0kDO9dQEDhHf6n1Yqsj0KZ+V21xip903Dr
	2k7QWTCJZFGbTzhcsy/+H4OTMOCea7duY9K+qdfJrMIRcuCRtYrXszYY=
X-Google-Smtp-Source: AGHT+IFnuukPoUH3TWr9eYPpzA6nwhvaBxMKmgpKeVyzSestLETYqAdjt7NsfjBJQSfvTWKvo7GLL7vNf+6ZJfsA9dB6BW2NhYWR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0d:b0:374:491c:6567 with SMTP id
 e9e14a558f8ab-374b1f82795mr2511185ab.5.1717661667495; Thu, 06 Jun 2024
 01:14:27 -0700 (PDT)
Date: Thu, 06 Jun 2024 01:14:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000892280061a344581@google.com>
Subject: [syzbot] [btrfs?] possible deadlock in btrfs_commit_inode_delayed_inode
From: syzbot <syzbot+3dad89b3993a4b275e72@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2ab795141095 Merge tag 'cxl-fixes-6.10-rc3' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=118fff2c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=998c63c06e77f5e7
dashboard link: https://syzkaller.appspot.com/bug?extid=3dad89b3993a4b275e72
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-2ab79514.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/31177e3311d1/vmlinux-2ab79514.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a9fa69e4242e/bzImage-2ab79514.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3dad89b3993a4b275e72@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc2-syzkaller-00010-g2ab795141095 #0 Not tainted
------------------------------------------------------
kswapd0/111 is trying to acquire lock:
ffff88801eae4610 (sb_internal#3){.+.+}-{0:0}, at: btrfs_commit_inode_delayed_inode+0x110/0x330 fs/btrfs/delayed-inode.c:1275

but task is already holding lock:
ffffffff8dd3a9a0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0xa88/0x1970 mm/vmscan.c:6924

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:3783 [inline]
       fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3797
       might_alloc include/linux/sched/mm.h:334 [inline]
       slab_pre_alloc_hook mm/slub.c:3890 [inline]
       slab_alloc_node mm/slub.c:3980 [inline]
       kmem_cache_alloc_lru_noprof+0x58/0x2f0 mm/slub.c:4019
       btrfs_alloc_inode+0x118/0xb20 fs/btrfs/inode.c:8411
       alloc_inode+0x5d/0x230 fs/inode.c:261
       iget5_locked fs/inode.c:1235 [inline]
       iget5_locked+0x1c9/0x2c0 fs/inode.c:1228
       btrfs_iget_locked fs/btrfs/inode.c:5590 [inline]
       btrfs_iget_path fs/btrfs/inode.c:5607 [inline]
       btrfs_iget+0xfb/0x230 fs/btrfs/inode.c:5636
       create_reloc_inode+0x403/0x820 fs/btrfs/relocation.c:3911
       btrfs_relocate_block_group+0x471/0xe60 fs/btrfs/relocation.c:4114
       btrfs_relocate_chunk+0x143/0x450 fs/btrfs/volumes.c:3373
       __btrfs_balance fs/btrfs/volumes.c:4157 [inline]
       btrfs_balance+0x211a/0x3f00 fs/btrfs/volumes.c:4534
       btrfs_ioctl_balance fs/btrfs/ioctl.c:3675 [inline]
       btrfs_ioctl+0x12ed/0x8290 fs/btrfs/ioctl.c:4742
       __do_compat_sys_ioctl+0x2c3/0x330 fs/ioctl.c:1007
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #2 (btrfs_trans_num_extwriters){++++}-{0:0}:
       join_transaction+0x164/0xf40 fs/btrfs/transaction.c:315
       start_transaction+0x427/0x1a70 fs/btrfs/transaction.c:700
       btrfs_rebuild_free_space_tree+0xaa/0x480 fs/btrfs/free-space-tree.c:1323
       btrfs_start_pre_rw_mount+0x218/0xf60 fs/btrfs/disk-io.c:2999
       open_ctree+0x41ab/0x52e0 fs/btrfs/disk-io.c:3554
       btrfs_fill_super fs/btrfs/super.c:946 [inline]
       btrfs_get_tree_super fs/btrfs/super.c:1863 [inline]
       btrfs_get_tree+0x11e9/0x1b90 fs/btrfs/super.c:2089
       vfs_get_tree+0x8f/0x380 fs/super.c:1780
       fc_mount+0x16/0xc0 fs/namespace.c:1125
       btrfs_get_tree_subvol fs/btrfs/super.c:2052 [inline]
       btrfs_get_tree+0xa53/0x1b90 fs/btrfs/super.c:2090
       vfs_get_tree+0x8f/0x380 fs/super.c:1780
       do_new_mount fs/namespace.c:3352 [inline]
       path_mount+0x6e1/0x1f10 fs/namespace.c:3679
       do_mount fs/namespace.c:3692 [inline]
       __do_sys_mount fs/namespace.c:3898 [inline]
       __se_sys_mount fs/namespace.c:3875 [inline]
       __ia32_sys_mount+0x295/0x320 fs/namespace.c:3875
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #1 (btrfs_trans_num_writers){++++}-{0:0}:
       join_transaction+0x148/0xf40 fs/btrfs/transaction.c:314
       start_transaction+0x427/0x1a70 fs/btrfs/transaction.c:700
       btrfs_rebuild_free_space_tree+0xaa/0x480 fs/btrfs/free-space-tree.c:1323
       btrfs_start_pre_rw_mount+0x218/0xf60 fs/btrfs/disk-io.c:2999
       open_ctree+0x41ab/0x52e0 fs/btrfs/disk-io.c:3554
       btrfs_fill_super fs/btrfs/super.c:946 [inline]
       btrfs_get_tree_super fs/btrfs/super.c:1863 [inline]
       btrfs_get_tree+0x11e9/0x1b90 fs/btrfs/super.c:2089
       vfs_get_tree+0x8f/0x380 fs/super.c:1780
       fc_mount+0x16/0xc0 fs/namespace.c:1125
       btrfs_get_tree_subvol fs/btrfs/super.c:2052 [inline]
       btrfs_get_tree+0xa53/0x1b90 fs/btrfs/super.c:2090
       vfs_get_tree+0x8f/0x380 fs/super.c:1780
       do_new_mount fs/namespace.c:3352 [inline]
       path_mount+0x6e1/0x1f10 fs/namespace.c:3679
       do_mount fs/namespace.c:3692 [inline]
       __do_sys_mount fs/namespace.c:3898 [inline]
       __se_sys_mount fs/namespace.c:3875 [inline]
       __ia32_sys_mount+0x295/0x320 fs/namespace.c:3875
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #0 (sb_internal#3){.+.+}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1655 [inline]
       sb_start_intwrite include/linux/fs.h:1838 [inline]
       start_transaction+0xbc1/0x1a70 fs/btrfs/transaction.c:694
       btrfs_commit_inode_delayed_inode+0x110/0x330 fs/btrfs/delayed-inode.c:1275
       btrfs_evict_inode+0x960/0xe80 fs/btrfs/inode.c:5291
       evict+0x2ed/0x6c0 fs/inode.c:667
       iput_final fs/inode.c:1741 [inline]
       iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
       iput+0x5c/0x80 fs/inode.c:1757
       btrfs_scan_root fs/btrfs/extent_map.c:1118 [inline]
       btrfs_free_extent_maps+0xbd3/0x1320 fs/btrfs/extent_map.c:1189
       super_cache_scan+0x409/0x550 fs/super.c:227
       do_shrink_slab+0x44f/0x11c0 mm/shrinker.c:435
       shrink_slab+0x18a/0x1310 mm/shrinker.c:662
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

other info that might help us debug this:

Chain exists of:
  sb_internal#3 --> btrfs_trans_num_extwriters --> fs_reclaim

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(btrfs_trans_num_extwriters);
                               lock(fs_reclaim);
  rlock(sb_internal#3);

 *** DEADLOCK ***

2 locks held by kswapd0/111:
 #0: ffffffff8dd3a9a0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0xa88/0x1970 mm/vmscan.c:6924
 #1: ffff88801eae40e0 (&type->s_umount_key#62){++++}-{3:3}, at: super_trylock_shared fs/super.c:562 [inline]
 #1: ffff88801eae40e0 (&type->s_umount_key#62){++++}-{3:3}, at: super_cache_scan+0x96/0x550 fs/super.c:196

stack backtrace:
CPU: 0 PID: 111 Comm: kswapd0 Not tainted 6.10.0-rc2-syzkaller-00010-g2ab795141095 #0
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
 percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
 __sb_start_write include/linux/fs.h:1655 [inline]
 sb_start_intwrite include/linux/fs.h:1838 [inline]
 start_transaction+0xbc1/0x1a70 fs/btrfs/transaction.c:694
 btrfs_commit_inode_delayed_inode+0x110/0x330 fs/btrfs/delayed-inode.c:1275
 btrfs_evict_inode+0x960/0xe80 fs/btrfs/inode.c:5291
 evict+0x2ed/0x6c0 fs/inode.c:667
 iput_final fs/inode.c:1741 [inline]
 iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
 iput+0x5c/0x80 fs/inode.c:1757
 btrfs_scan_root fs/btrfs/extent_map.c:1118 [inline]
 btrfs_free_extent_maps+0xbd3/0x1320 fs/btrfs/extent_map.c:1189
 super_cache_scan+0x409/0x550 fs/super.c:227
 do_shrink_slab+0x44f/0x11c0 mm/shrinker.c:435
 shrink_slab+0x18a/0x1310 mm/shrinker.c:662
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
 </TASK>


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

