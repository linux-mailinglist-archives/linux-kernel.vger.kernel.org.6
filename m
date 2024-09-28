Return-Path: <linux-kernel+bounces-342381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDBB988E47
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 09:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA0C1F21E40
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 07:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433FA19DFB3;
	Sat, 28 Sep 2024 07:43:31 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC93C19DF5E
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 07:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727509410; cv=none; b=OC1l6dqY16hUlih7OuM9I07egkGYsFM1VBCHYurpFxrh2sUZ0ufmP8rhHAV7s0zpaa8lgHVK1ghqLzkbkM8mCl2B8pLLpST5pr0riqA8q+E0BwK71VAVC2iGniJ9C1ls4bpumH8Ghwt1OX19krZClrtUfnA2qSn+W0y64UqvojI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727509410; c=relaxed/simple;
	bh=Tkb88qVKUeBdJ42G5bZlcBOL2evQ60bmKznik7IOpmw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=X+caNjiKDXZaHSVZ2s20R3DA4s/9xHWktnpObn5zRpIbM9Qe8vkAZ2OE4oTRIiyXpP7X2DCTdmM1tffAHM+VXynlqv3VLaS5izUGJgMHSiZRuB0qhMTJk2nc234e8mS2JRh1TmvCYBWIS6N05VqXfUsp8J7keXjyS7sZhQxwbrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a0ce7e621aso29843515ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 00:43:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727509408; x=1728114208;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hG+T+iEHIkMxk78v6Kd9mBWnMS1ZVclr8awfuHMXyDo=;
        b=n7VpbVB4UbD3HxohxPJRmOC57rJSOVtOeggWK6jKqVNXlXSG2WXmTxNyRnsOyyleGe
         iZSJfcw5AUir8s7xFxpgfseawAUt+whCVI1f/CNPBUOwWtcEh7FZy/vYvJRJcb+exkdF
         URX9KMzeFfaPXb3tMjG7ZSNzNHWoY2RBeYDgMiLpHDf/A3uRO51ditMP2BlQIVPGwcDu
         g/AcVkXrzYPPM96FHvjzn/SlLicG2/N8yTegxrZjgkIbRH56M/Mn1VxtkSdNNEWJjeb7
         4E+I8UQhnxiYkPw8j+kQtZP9dYoaZF1AQcIHphAAil1pZd2KyVeIp/S4CbpSxeiNU9cF
         KfFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOrFlIJaPI1CCTw4/1+tlKqVLUhb5cBGPXPvFPoLkjeNcdDEn0pn29T2SKV6bi986Ns0VuYIIwfEZBFnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyz7XoHKYwg+PZeAL4CApcG4k0JkPeZtkVdF7emMa8IMEb5BaW
	+Gsdeir5Ujc+EqskJpE1fp+VC8tI1Sz9o62uWAFpCS9WZX7NUdvKQFpM/kaWNfneZNQBMyGB0iG
	NiXw6n17C39nYJeCqoPqXGqdk5NQgsRJKibOCtNMGt7qeVSREukQGlFk=
X-Google-Smtp-Source: AGHT+IFM1YWvUWRHXQWqE/Aadyx9q2Mwl55+UhMiIQs002s9HIo9pMzVcizKzN+EyQgJLG9zGOzbZLHfKBn/QzOiFDkCvBtLvZ8C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca0c:0:b0:3a3:35f0:4c0c with SMTP id
 e9e14a558f8ab-3a3451b070dmr41985425ab.18.1727509407940; Sat, 28 Sep 2024
 00:43:27 -0700 (PDT)
Date: Sat, 28 Sep 2024 00:43:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f7b39f.050a0220.46d20.0037.GAE@google.com>
Subject: [syzbot] [ext4?] possible deadlock in ext4_xattr_inode_lookup_create
From: syzbot <syzbot+d91a6e2efb07bd3354e9@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, jun.nie@linaro.org, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2b7275670032 Add linux-next specific files for 20240925
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12fdd627980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=441f6022e7a2db73
dashboard link: https://syzkaller.appspot.com/bug?extid=d91a6e2efb07bd3354e9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1771ca80580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=102e0907980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/de8e955e430e/disk-2b727567.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cdc30f0c4010/vmlinux-2b727567.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5bce68c83e37/bzImage-2b727567.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b35179829fb5/mount_0.gz

The issue was bisected to:

commit 1e9d62d252812575ded7c620d8fc67c32ff06c16
Author: Jun Nie <jun.nie@linaro.org>
Date:   Tue Jan 3 01:45:16 2023 +0000

    ext4: optimize ea_inode block expansion

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14edcaa9980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16edcaa9980000
console output: https://syzkaller.appspot.com/x/log.txt?x=12edcaa9980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d91a6e2efb07bd3354e9@syzkaller.appspotmail.com
Fixes: 1e9d62d25281 ("ext4: optimize ea_inode block expansion")

EXT4-fs: Ignoring removed nomblk_io_submit option
======================================================
WARNING: possible circular locking dependency detected
6.11.0-next-20240925-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor177/5387 is trying to acquire lock:
ffff888071dd97c8 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:815 [inline]
ffff888071dd97c8 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}, at: ext4_xattr_inode_create fs/ext4/xattr.c:1514 [inline]
ffff888071dd97c8 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}, at: ext4_xattr_inode_lookup_create+0x1a31/0x1f20 fs/ext4/xattr.c:1596

but task is already holding lock:
ffff888071ddc7e0 (&ei->i_data_sem/3){++++}-{3:3}, at: ext4_truncate+0x994/0x11c0 fs/ext4/inode.c:4180

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&ei->i_data_sem/3){++++}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       down_write+0x99/0x220 kernel/locking/rwsem.c:1577
       ext4_update_i_disksize fs/ext4/ext4.h:3398 [inline]
       ext4_xattr_inode_write fs/ext4/xattr.c:1452 [inline]
       ext4_xattr_inode_lookup_create+0x16b8/0x1f20 fs/ext4/xattr.c:1602
       ext4_xattr_ibody_set+0x214/0x730 fs/ext4/xattr.c:2269
       ext4_xattr_set_handle+0xba6/0x1580 fs/ext4/xattr.c:2446
       ext4_xattr_set+0x241/0x3d0 fs/ext4/xattr.c:2560
       __vfs_setxattr+0x468/0x4a0 fs/xattr.c:200
       __vfs_setxattr_noperm+0x12e/0x660 fs/xattr.c:234
       vfs_setxattr+0x221/0x430 fs/xattr.c:321
       do_setxattr fs/xattr.c:629 [inline]
       path_setxattr+0x37e/0x4d0 fs/xattr.c:658
       __do_sys_setxattr fs/xattr.c:676 [inline]
       __se_sys_setxattr fs/xattr.c:672 [inline]
       __x64_sys_setxattr+0xbb/0xd0 fs/xattr.c:672
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       down_write+0x99/0x220 kernel/locking/rwsem.c:1577
       inode_lock include/linux/fs.h:815 [inline]
       ext4_xattr_inode_create fs/ext4/xattr.c:1514 [inline]
       ext4_xattr_inode_lookup_create+0x1a31/0x1f20 fs/ext4/xattr.c:1596
       ext4_xattr_block_set+0x274/0x3980 fs/ext4/xattr.c:1916
       ext4_xattr_move_to_block fs/ext4/xattr.c:2669 [inline]
       ext4_xattr_make_inode_space fs/ext4/xattr.c:2744 [inline]
       ext4_expand_extra_isize_ea+0x12d7/0x1cf0 fs/ext4/xattr.c:2836
       __ext4_expand_extra_isize+0x2fb/0x3e0 fs/ext4/inode.c:5831
       ext4_try_to_expand_extra_isize fs/ext4/inode.c:5874 [inline]
       __ext4_mark_inode_dirty+0x524/0x880 fs/ext4/inode.c:5952
       ext4_ext_truncate+0x9f/0x2b0 fs/ext4/extents.c:4457
       ext4_truncate+0xa1b/0x11c0 fs/ext4/inode.c:4185
       ext4_evict_inode+0x90f/0xf50 fs/ext4/inode.c:263
       evict+0x4e8/0x9b0 fs/inode.c:806
       __dentry_kill+0x20d/0x630 fs/dcache.c:615
       dput+0x19f/0x2b0 fs/dcache.c:857
       do_renameat2+0xda1/0x13f0 fs/namei.c:5181
       __do_sys_renameat2 fs/namei.c:5213 [inline]
       __se_sys_renameat2 fs/namei.c:5210 [inline]
       __x64_sys_renameat2+0xce/0xe0 fs/namei.c:5210
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ei->i_data_sem/3);
                               lock(&ea_inode->i_rwsem#8/1);
                               lock(&ei->i_data_sem/3);
  lock(&ea_inode->i_rwsem#8/1);

 *** DEADLOCK ***

7 locks held by syz-executor177/5387:
 #0: ffff88802da0e420 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:515
 #1: ffff88802da0e730 (&type->s_vfs_rename_key){+.+.}-{3:3}, at: lock_rename fs/namei.c:3165 [inline]
 #1: ffff88802da0e730 (&type->s_vfs_rename_key){+.+.}-{3:3}, at: do_renameat2+0x5cf/0x13f0 fs/namei.c:5114
 #2: ffff88807755f0f0 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:850 [inline]
 #2: ffff88807755f0f0 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: lock_two_directories+0x145/0x220 fs/namei.c:3131
 #3: ffff888071dd83f8 (&type->i_mutex_dir_key#3/5){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:850 [inline]
 #3: ffff888071dd83f8 (&type->i_mutex_dir_key#3/5){+.+.}-{3:3}, at: lock_two_directories+0x16f/0x220 fs/namei.c:3132
 #4: ffff88802da0e610 (sb_internal){.+.+}-{0:0}, at: __sb_start_write include/linux/fs.h:1721 [inline]
 #4: ffff88802da0e610 (sb_internal){.+.+}-{0:0}, at: sb_start_intwrite include/linux/fs.h:1904 [inline]
 #4: ffff88802da0e610 (sb_internal){.+.+}-{0:0}, at: ext4_evict_inode+0x2f4/0xf50 fs/ext4/inode.c:217
 #5: ffff888071ddc7e0 (&ei->i_data_sem/3){++++}-{3:3}, at: ext4_truncate+0x994/0x11c0 fs/ext4/inode.c:4180
 #6: ffff888071ddc620 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_trylock_xattr fs/ext4/xattr.h:161 [inline]
 #6: ffff888071ddc620 (&ei->xattr_sem){++++}-{3:3}, at: ext4_try_to_expand_extra_isize fs/ext4/inode.c:5871 [inline]
 #6: ffff888071ddc620 (&ei->xattr_sem){++++}-{3:3}, at: __ext4_mark_inode_dirty+0x491/0x880 fs/ext4/inode.c:5952

stack backtrace:
CPU: 0 UID: 0 PID: 5387 Comm: syz-executor177 Not tainted 6.11.0-next-20240925-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
 __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 down_write+0x99/0x220 kernel/locking/rwsem.c:1577
 inode_lock include/linux/fs.h:815 [inline]
 ext4_xattr_inode_create fs/ext4/xattr.c:1514 [inline]
 ext4_xattr_inode_lookup_create+0x1a31/0x1f20 fs/ext4/xattr.c:1596
 ext4_xattr_block_set+0x274/0x3980 fs/ext4/xattr.c:1916
 ext4_xattr_move_to_block fs/ext4/xattr.c:2669 [inline]
 ext4_xattr_make_inode_space fs/ext4/xattr.c:2744 [inline]
 ext4_expand_extra_isize_ea+0x12d7/0x1cf0 fs/ext4/xattr.c:2836
 __ext4_expand_extra_isize+0x2fb/0x3e0 fs/ext4/inode.c:5831
 ext4_try_to_expand_extra_isize fs/ext4/inode.c:5874 [inline]
 __ext4_mark_inode_dirty+0x524/0x880 fs/ext4/inode.c:5952
 ext4_ext_truncate+0x9f/0x2b0 fs/ext4/extents.c:4457
 ext4_truncate+0xa1b/0x11c0 fs/ext4/inode.c:4185
 ext4_evict_inode+0x90f/0xf50 fs/ext4/inode.c:263
 evict+0x4e8/0x9b0 fs/inode.c:806
 __dentry_kill+0x20d/0x630 fs/dcache.c:615
 dput+0x19f/0x2b0 fs/dcache.c:857
 do_renameat2+0xda1/0x13f0 fs/namei.c:5181
 __do_sys_renameat2 fs/namei.c:5213 [inline]
 __se_sys_renameat2 fs/namei.c:5210 [inline]
 __x64_sys_renameat2+0xce/0xe0 fs/namei.c:5210
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9326d33469
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 21 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdce15cbc8 EFLAGS: 00000246 ORIG_RAX: 000000000000013c
RAX: ffffffffffffffda RBX: 00007f9326d7c0a0 RCX: 00007f9326d33469
RDX: 0000000000000005 RSI: 0000000020000080 RDI: 0000000000000006
RBP: 0000000000000000 R08: 0000000000000000 R09: 00007ffdce15cc00
R10: 00000000200000c0 R11: 0000000000000246 R12: 00007ffdce15cbec
R13: 0000000000000031 R14: 431bde82d7b634db R15: 00007ffdce15cc20
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

