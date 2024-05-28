Return-Path: <linux-kernel+bounces-191768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF778D13DB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 07:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B3091F22705
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 05:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F44502BE;
	Tue, 28 May 2024 05:27:25 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102B65024E
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 05:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716874044; cv=none; b=EeAKOJdA3Uv+9N6JvlGgHt8NoIPEUK8ko0awgolxmW9hoC4n8YBk5bwBTKwoa0lhD9t3F2p1y6lyQLCf3trkNBQdMC5tcAq50Fa7aAk48FZaeynKK/ZQdvHHEdd+Puuf6eC2CpMX5druwApn79yDNt21dxU0CA4cyzCm9ga8GRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716874044; c=relaxed/simple;
	bh=+Shw7zR690jr3idhKiqiWTUKDLsJwUBVnnWwdO4y98o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=c4Q4MoZsjWgbVOSENlDIcjrBiGKZcdMUTWToR1H6g91RvnAudOXHyB2uX7AuJo0T70i4BLWOFv5S+6pajBAbCQ5fQEwmv3juAQTn2OcsPzHey3a/I2a0kl2bzjEVX1NIYAR48Kh4bK6bxBG0a8hC8OYf4aHagoBmFEtqzNOS9vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7e94cac3c71so55717339f.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 22:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716874042; x=1717478842;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b7hzebFTeLz7yfGu/UlsI/xjrNpVG/KUc4fMo86WGtk=;
        b=j0ZDVLEE4nnBIMAYzWy5z9DTF4vSvkUU4GuHZm1S+I87c+cCbZ/FsQltEJNbQt0t6/
         ZH+Fja6ZoTl2aIOYe1opeZGXbz+i83aOP+zzUK3wNIVpHVBehpOWPJ3fA+rXaMmTtvEs
         OLIDGMMF9QDx47271NlxscIPL8k7R1NLQ9TcUv90MMXowii+8zAKmSu0dffLlHZWEOSG
         SBv4ATGIiwc+R+iTllUoJeKZIpENiAahJN80+4c5VCLsxa8/YeM2FsVf7pELqe0+a7vS
         h+o10NLdluUaqgWXlZ/VHXUeVvFZhnw5O4Zln40WNoAPwgKRSTA8o4uVtw6nyLEJvKex
         GcDA==
X-Forwarded-Encrypted: i=1; AJvYcCU8IZ7RkVMWUU9hvpRwt33C+2e8fFKXV3C+wG3p4e09lUxx06wXDHe9QF9Ug/8Es2LHZ5WMDXmREj1WE9YQ8olRKMbtYGp02x7Z82r3
X-Gm-Message-State: AOJu0YzgsKHLoQsTvKNlirqTKZA7ySQ6OsDQJfGGXy8d78H0Fs1V3rLM
	h5MtnGs1exdStEFkpEy1uENCKXa6OxQbGAbtoTNDbGMu1GTjFGtYC+BpS800I2rHjsw4fHhf0BY
	gMyBKk9RlM7Y88F7wMspnGmabyiTwZUKkbBCfy55fYEHHp2ilLT/cRJw=
X-Google-Smtp-Source: AGHT+IHBiyBJypn0fw7TJjxQC/VxcTm6DfBNXqMYmx6lbjPFNjaIqdvaLZGN2lUq4GWVn2KFaLwXmahIpBxOkzxJfRURW7yw8nUP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3401:b0:7de:d6a0:d48b with SMTP id
 ca18e2360f4ac-7e8c75d56f4mr43374739f.3.1716874042196; Mon, 27 May 2024
 22:27:22 -0700 (PDT)
Date: Mon, 27 May 2024 22:27:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000068d0b006197ce3c1@google.com>
Subject: [syzbot] [ntfs3?] possible deadlock in attr_collapse_range
From: syzbot <syzbot+66feeab2e2b600100de0@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8f6a15f095a6 Merge tag 'cocci-for-6.10' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=176bb6dc980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a6e600de1a27f120
dashboard link: https://syzkaller.appspot.com/bug?extid=66feeab2e2b600100de0
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/60dc1346b348/disk-8f6a15f0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f1699c08d767/vmlinux-8f6a15f0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f0c1de6d998e/bzImage-8f6a15f0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+66feeab2e2b600100de0@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.9.0-syzkaller-10323-g8f6a15f095a6 #0 Not tainted
------------------------------------------------------
syz-executor.1/19565 is trying to acquire lock:
ffff88805b5bf7b0 (&ni->file.run_lock#3){++++}-{3:3}, at: attr_collapse_range+0x3be/0x1400 fs/ntfs3/attrib.c:1894

but task is already holding lock:
ffff88805b5bf700 (&ni->ni_lock#2/4){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1123 [inline]
ffff88805b5bf700 (&ni->ni_lock#2/4){+.+.}-{3:3}, at: ntfs_fallocate+0x9af/0x1120 fs/ntfs3/file.c:556

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&ni->ni_lock#2/4){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       ni_lock fs/ntfs3/ntfs_fs.h:1123 [inline]
       ntfs_fallocate+0x9af/0x1120 fs/ntfs3/file.c:556
       vfs_fallocate+0x4b8/0xfb0 fs/open.c:330
       ksys_fallocate fs/open.c:353 [inline]
       __do_sys_fallocate fs/open.c:361 [inline]
       __se_sys_fallocate fs/open.c:359 [inline]
       __x64_sys_fallocate+0xd5/0x140 fs/open.c:359
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (mapping.invalidate_lock#4){++++}-{3:3}:
       down_read+0x9a/0x330 kernel/locking/rwsem.c:1526
       filemap_invalidate_lock_shared include/linux/fs.h:846 [inline]
       filemap_fault+0x275/0x2610 mm/filemap.c:3301
       __do_fault+0x10a/0x490 mm/memory.c:4562
       do_read_fault mm/memory.c:4926 [inline]
       do_fault mm/memory.c:5056 [inline]
       do_pte_missing mm/memory.c:3903 [inline]
       handle_pte_fault mm/memory.c:5380 [inline]
       __handle_mm_fault+0x39e2/0x53f0 mm/memory.c:5523
       handle_mm_fault+0x476/0xa00 mm/memory.c:5688
       do_user_addr_fault+0x2e5/0xe50 arch/x86/mm/fault.c:1389
       handle_page_fault arch/x86/mm/fault.c:1481 [inline]
       exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1539
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
       rep_movs_alternative+0x30/0x70 arch/x86/lib/copy_user_64.S:50
       copy_user_generic arch/x86/include/asm/uaccess_64.h:110 [inline]
       raw_copy_from_user arch/x86/include/asm/uaccess_64.h:125 [inline]
       _copy_from_user+0xc6/0xf0 lib/usercopy.c:23
       copy_from_user include/linux/uaccess.h:183 [inline]
       get_user_ifreq+0xf1/0x250 net/socket.c:3346
       sock_do_ioctl+0x16c/0x280 net/socket.c:1234
       sock_ioctl+0x22e/0x6c0 net/socket.c:1341
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:907 [inline]
       __se_sys_ioctl fs/ioctl.c:893 [inline]
       __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:893
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&mm->mmap_lock){++++}-{3:3}:
       __might_fault mm/memory.c:6240 [inline]
       __might_fault+0x11b/0x190 mm/memory.c:6233
       _copy_to_user+0x2b/0xc0 lib/usercopy.c:36
       copy_to_user include/linux/uaccess.h:191 [inline]
       fiemap_fill_next_extent+0x232/0x390 fs/ioctl.c:145
       ni_fiemap+0x9eb/0xc10 fs/ntfs3/frecord.c:2044
       ntfs_fiemap+0xc9/0x120 fs/ntfs3/file.c:1206
       ioctl_fiemap fs/ioctl.c:220 [inline]
       do_vfs_ioctl+0x404/0x1ad0 fs/ioctl.c:841
       __do_sys_ioctl fs/ioctl.c:905 [inline]
       __se_sys_ioctl fs/ioctl.c:893 [inline]
       __x64_sys_ioctl+0x116/0x220 fs/ioctl.c:893
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&ni->file.run_lock#3){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
       down_write+0x3a/0x50 kernel/locking/rwsem.c:1579
       attr_collapse_range+0x3be/0x1400 fs/ntfs3/attrib.c:1894
       ntfs_fallocate+0x9c9/0x1120 fs/ntfs3/file.c:557
       vfs_fallocate+0x4b8/0xfb0 fs/open.c:330
       ksys_fallocate fs/open.c:353 [inline]
       __do_sys_fallocate fs/open.c:361 [inline]
       __se_sys_fallocate fs/open.c:359 [inline]
       __x64_sys_fallocate+0xd5/0x140 fs/open.c:359
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &ni->file.run_lock#3 --> mapping.invalidate_lock#4 --> &ni->ni_lock#2/4

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ni->ni_lock#2/4);
                               lock(mapping.invalidate_lock#4);
                               lock(&ni->ni_lock#2/4);
  lock(
&ni->file.run_lock#3);

 *** DEADLOCK ***

4 locks held by syz-executor.1/19565:
 #0: ffff88807b294420 (sb_writers#17){.+.+}-{0:0}, at: ksys_fallocate fs/open.c:353 [inline]
 #0: ffff88807b294420 (sb_writers#17){.+.+}-{0:0}, at: __do_sys_fallocate fs/open.c:361 [inline]
 #0: ffff88807b294420 (sb_writers#17){.+.+}-{0:0}, at: __se_sys_fallocate fs/open.c:359 [inline]
 #0: ffff88807b294420 (sb_writers#17){.+.+}-{0:0}, at: __x64_sys_fallocate+0xd5/0x140 fs/open.c:359
 #1: ffff88805b5bf9a0 (&sb->s_type->i_mutex_key#25){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:791 [inline]
 #1: ffff88805b5bf9a0 (&sb->s_type->i_mutex_key#25){+.+.}-{3:3}, at: ntfs_fallocate+0x2ac/0x1120 fs/ntfs3/file.c:472
 #2: ffff88805b5bfb40 (mapping.invalidate_lock#4){++++}-{3:3}, at: filemap_invalidate_lock include/linux/fs.h:836 [inline]
 #2: ffff88805b5bfb40 (mapping.invalidate_lock#4){++++}-{3:3}, at: ntfs_fallocate+0x6fb/0x1120 fs/ntfs3/file.c:486
 #3: ffff88805b5bf700 (&ni->ni_lock#2/4
){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1123 [inline]
){+.+.}-{3:3}, at: ntfs_fallocate+0x9af/0x1120 fs/ntfs3/file.c:556

stack backtrace:
CPU: 0 PID: 19565 Comm: syz-executor.1 Not tainted 6.9.0-syzkaller-10323-g8f6a15f095a6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
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
 down_write+0x3a/0x50 kernel/locking/rwsem.c:1579
 attr_collapse_range+0x3be/0x1400 fs/ntfs3/attrib.c:1894
 ntfs_fallocate+0x9c9/0x1120 fs/ntfs3/file.c:557
 vfs_fallocate+0x4b8/0xfb0 fs/open.c:330
 ksys_fallocate fs/open.c:353 [inline]
 __do_sys_fallocate fs/open.c:361 [inline]
 __se_sys_fallocate fs/open.c:359 [inline]
 __x64_sys_fallocate+0xd5/0x140 fs/open.c:359
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2890c7cee9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2891a740c8 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00007f2890dabf80 RCX: 00007f2890c7cee9
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000008
RBP: 00007f2890cc949e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000007000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f2890dabf80 R15: 00007ffefad699c8
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

