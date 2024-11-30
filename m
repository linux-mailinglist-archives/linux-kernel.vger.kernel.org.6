Return-Path: <linux-kernel+bounces-426014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1419DEDC0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A1481631EB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 00:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4F32F2E;
	Sat, 30 Nov 2024 00:07:32 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012052572
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 00:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732925251; cv=none; b=nAJsqqqL23CnmfBOrdLsZjSumfhhqPJf3AeaQjKWzLCjOmUpYXruzAfYIe5TlHJJwGw/ud7vCGTb2XvJUXFD+N13pGRkl97hsHrAjfgbnFZXZX2CPqAAaLN0YeK84qxX1jCwHUZI11K3kN9KSkcqFoi0mDC9uZeP9QSy6mdnRKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732925251; c=relaxed/simple;
	bh=LnYPHK32WOqUL1jPaHpZhXq4a6sC1IYLnjPRvbBweNE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MD0PosJ3gnn0QevMMu9ACzaEnnMBts/8XBnOOsTFYNgRKwv2NmFCP2RO5GskqgEg0RlWuuDEaNjXYdzO6N/v/3VhI3dXi0HxHyUkNT+0aygKQfh91Uu/YzrnKdOok5gM3RDeeekfxL3aQkaK8xxk1NLGFydTJ4iVCwQubSDa00s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a763f42b35so28468385ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 16:07:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732925249; x=1733530049;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=41P7vPKffU91pYvGSwhSs8ri6IUQKOAy7s8jnDTAGlw=;
        b=wcmWBID4YhNOKjQ00GyhENgKg4Y40ldphyTw/ivj2KeW3TuG/K1oZz4pj3k/mO9zGR
         qs0DfjgXKCAsQVpaT15k81pHs/JvSWjlbuyOnk/D/w0BVNTCxp3MxUT+icJAI+J2oSf3
         /lYcDiGKeEbpIJEzQaPVnxQdtyYeyu1XbTiO66ZovCU0S2JxV4mfEX1n7ZT8GsNvQM3N
         ywdF5zX+SASqTm83DeLoxoM+g0v518Y7UwXZozVN/MkQzsd+ktL9/MXA+6Qd5PB2k/hv
         6Ne9Kowshe8JtxrDQTCXmk4YsomC9lIVdde/nHPSUeUNEW+LpieVPVu/QKF10LKmHK74
         oISA==
X-Forwarded-Encrypted: i=1; AJvYcCXRmOSJMpEOuzncpYVG35M1zib8Zso4k29jcYxRO4+Su3i8H/htAcoeQ0mrTCqolwdNghzi79j32v3aCeE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9VYxlXigLKJTtkUGFjkHcsUIXl+2OSvmzYDC6x7DPJqeuTNhI
	Tp5EVTHrZ3rW1e/o2EIMQNVOBFUuTud0ujR9C1Wtl+jGArGI5gNlgYlsYzy8oi5ZTNVmRTonwvq
	3O5o7pr3uyo0887oof61sPtGqgTxc+yLEiquhDNRkwvjp1yvDRxm6vY0=
X-Google-Smtp-Source: AGHT+IGh6dFDfmU73NL1knOS8Kyq4c5m9ewAtS9qRNNMfA+plPhYoyaZzBMDggr5OzhGEv3Zyxr4nt2rXh1yD3WIPrl8AoelHB3V
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9a:b0:3a7:d7dd:e70f with SMTP id
 e9e14a558f8ab-3a7d7dde9dcmr41877845ab.12.1732925248876; Fri, 29 Nov 2024
 16:07:28 -0800 (PST)
Date: Fri, 29 Nov 2024 16:07:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674a5740.050a0220.253251.00d1.GAE@google.com>
Subject: [syzbot] [ntfs3?] possible deadlock in vfs_rename (2)
From: syzbot <syzbot+9edbc41b1330724a6243@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9f16d5e6f220 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13406778580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=54f7b2f59e7640e5
dashboard link: https://syzkaller.appspot.com/bug?extid=9edbc41b1330724a6243
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7562d921dc97/disk-9f16d5e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8fb84b5dec53/vmlinux-9f16d5e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cac8b3f180c1/bzImage-9f16d5e6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9edbc41b1330724a6243@syzkaller.appspotmail.com

ntfs3(loop1): mft corrupted
ntfs3(loop1): Failed to load $Extend (-22).
ntfs3(loop1): Failed to initialize $Extend.
======================================================
WARNING: possible circular locking dependency detected
6.12.0-syzkaller-09073-g9f16d5e6f220 #0 Not tainted
------------------------------------------------------
syz.1.1301/14345 is trying to acquire lock:
ffff88807c587918 (&sb->s_type->i_mutex_key#32/4){+.+.}-{4:4}, at: vfs_rename+0x6a2/0xf00 fs/namei.c:5038

but task is already holding lock:
ffff88807c583e58 (&sb->s_type->i_mutex_key#32){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:818 [inline]
ffff88807c583e58 (&sb->s_type->i_mutex_key#32){+.+.}-{4:4}, at: lock_two_nondirectories+0xe1/0x170 fs/inode.c:1281

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&sb->s_type->i_mutex_key#32){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_write+0x99/0x220 kernel/locking/rwsem.c:1577
       inode_lock include/linux/fs.h:818 [inline]
       ntfs_file_mmap+0x5bc/0x850 fs/ntfs3/file.c:377
       call_mmap include/linux/fs.h:2183 [inline]
       mmap_file mm/internal.h:124 [inline]
       __mmap_new_file_vma mm/vma.c:2291 [inline]
       __mmap_new_vma mm/vma.c:2355 [inline]
       __mmap_region+0x2204/0x2cd0 mm/vma.c:2456
       mmap_region+0x1d0/0x2c0 mm/mmap.c:1347
       do_mmap+0x8f0/0x1000 mm/mmap.c:496
       vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:588
       ksys_mmap_pgoff+0x4eb/0x720 mm/mmap.c:542
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (&mm->mmap_lock){++++}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __might_fault+0xc6/0x120 mm/memory.c:6751
       _inline_copy_to_user include/linux/uaccess.h:192 [inline]
       _copy_to_user+0x2c/0xb0 lib/usercopy.c:26
       copy_to_user include/linux/uaccess.h:225 [inline]
       ni_fiemap+0x57c/0x18c0 fs/ntfs3/frecord.c:2139
       ntfs_fiemap+0x132/0x180 fs/ntfs3/file.c:1352
       ioctl_fiemap fs/ioctl.c:220 [inline]
       do_vfs_ioctl+0x1c01/0x2e40 fs/ioctl.c:840
       __do_sys_ioctl fs/ioctl.c:904 [inline]
       __se_sys_ioctl+0x80/0x170 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&ni->ni_lock/5){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       ni_lock fs/ntfs3/ntfs_fs.h:1109 [inline]
       ntfs_save_wsl_perm+0x8f/0x500 fs/ntfs3/xattr.c:959
       ntfs_create_inode+0x21a0/0x3760 fs/ntfs3/inode.c:1631
       ntfs_symlink+0xde/0x110 fs/ntfs3/namei.c:197
       vfs_symlink+0x137/0x2e0 fs/namei.c:4669
       do_symlinkat+0x222/0x3a0 fs/namei.c:4695
       __do_sys_symlink fs/namei.c:4716 [inline]
       __se_sys_symlink fs/namei.c:4714 [inline]
       __x64_sys_symlink+0x7a/0x90 fs/namei.c:4714
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&ni->ni_lock#3/6){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       ni_lock_dir fs/ntfs3/ntfs_fs.h:1114 [inline]
       ntfs_rename+0x72f/0xd10 fs/ntfs3/namei.c:311
       vfs_rename+0xbdb/0xf00 fs/namei.c:5067
       do_renameat2+0xd94/0x13f0 fs/namei.c:5224
       __do_sys_rename fs/namei.c:5271 [inline]
       __se_sys_rename fs/namei.c:5269 [inline]
       __x64_sys_rename+0x82/0x90 fs/namei.c:5269
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&sb->s_type->i_mutex_key#32/4){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_write_nested+0xa2/0x220 kernel/locking/rwsem.c:1693
       vfs_rename+0x6a2/0xf00 fs/namei.c:5038
       do_renameat2+0xd94/0x13f0 fs/namei.c:5224
       __do_sys_rename fs/namei.c:5271 [inline]
       __se_sys_rename fs/namei.c:5269 [inline]
       __x64_sys_rename+0x82/0x90 fs/namei.c:5269
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &sb->s_type->i_mutex_key#32/4 --> &mm->mmap_lock --> &sb->s_type->i_mutex_key#32

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sb->s_type->i_mutex_key#32);
                               lock(&mm->mmap_lock);
                               lock(&sb->s_type->i_mutex_key#32);
  lock(&sb->s_type->i_mutex_key#32/4);

 *** DEADLOCK ***

5 locks held by syz.1.1301/14345:
 #0: ffff888051910420 (sb_writers#22){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:515
 #1: ffff888051910730 (&type->s_vfs_rename_key#7){+.+.}-{4:4}, at: lock_rename fs/namei.c:3219 [inline]
 #1: ffff888051910730 (&type->s_vfs_rename_key#7){+.+.}-{4:4}, at: do_renameat2+0x5cf/0x13f0 fs/namei.c:5159
 #2: ffff88807c585460 (&type->i_mutex_dir_key#14/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:853 [inline]
 #2: ffff88807c585460 (&type->i_mutex_dir_key#14/1){+.+.}-{4:4}, at: lock_two_directories+0x1a8/0x220 fs/namei.c:3195
 #3: ffff88807c580398 (&type->i_mutex_dir_key#14/5){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:853 [inline]
 #3: ffff88807c580398 (&type->i_mutex_dir_key#14/5){+.+.}-{4:4}, at: lock_two_directories+0x1d1/0x220 fs/namei.c:3196
 #4: ffff88807c583e58 (&sb->s_type->i_mutex_key#32){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:818 [inline]
 #4: ffff88807c583e58 (&sb->s_type->i_mutex_key#32){+.+.}-{4:4}, at: lock_two_nondirectories+0xe1/0x170 fs/inode.c:1281

stack backtrace:
CPU: 0 UID: 0 PID: 14345 Comm: syz.1.1301 Not tainted 6.12.0-syzkaller-09073-g9f16d5e6f220 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 down_write_nested+0xa2/0x220 kernel/locking/rwsem.c:1693
 vfs_rename+0x6a2/0xf00 fs/namei.c:5038
 do_renameat2+0xd94/0x13f0 fs/namei.c:5224
 __do_sys_rename fs/namei.c:5271 [inline]
 __se_sys_rename fs/namei.c:5269 [inline]
 __x64_sys_rename+0x82/0x90 fs/namei.c:5269
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f171917e819
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1719f99038 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007f1719335fa0 RCX: 00007f171917e819
RDX: 0000000000000000 RSI: 00000000200002c0 RDI: 0000000020000240
RBP: 00007f17191f175e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f1719335fa0 R15: 00007ffd570c5a98
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

