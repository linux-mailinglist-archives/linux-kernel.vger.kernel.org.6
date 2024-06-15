Return-Path: <linux-kernel+bounces-215740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE81C909680
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 09:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74CAA1F2231B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 07:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE8217579;
	Sat, 15 Jun 2024 07:17:28 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B5819D893
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 07:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718435848; cv=none; b=e2QQ4mQe2MIOs8EvrB27LmzH2L2Dg+JjWYGaPOjgsUqHgGUIXG6m4Or/jFZBXt1Hddz7IpvWcHjH6Cynb/ijU1d9YHCc/p6WhB636Bgz65ftex004Dbm8ANrl4y09Vc8exEChEjILdBgAHiDXMZ0BaV96jkbLZGTasLlvzHNE/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718435848; c=relaxed/simple;
	bh=UZwPlevoa47vYTu1LU1Z0nyM9yQuDjVEFg5Bz4Z2+LM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AQSLoJDtOkyzeLyqXhjpCPdLXfr3MDgt65qSH3WusD4l1XHEMBtQgmzela/9F1dE1oVNEJZW+Rv/93kmao2TM1NRK8AQge0Ry69utDp4yKUNyfQOwSdEtum2NRlJO3MLJa4NN6Esy4GrijKS1TywcazcuITEBrhUHfIn3FLnEmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7e92491e750so194995139f.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 00:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718435845; x=1719040645;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M7HxTcY9HGZ88QORBAPj7iceLv2FXtx63X63Tww9Bvs=;
        b=Q/LYQeGbApEJ4d6/xnfizoBPPdSgtdDcWL3S2EIP7TWJJeteO0WbhgkdSY3MyMyQit
         dWnCgwhXsCIr35AbgWx5U4OlPlQdGuHrWMcys9uMXaEQPVZaVbcI440dILmX7XmqwaVA
         dqJUH50PEnCCklapPfoxoZlvfnodiLh8Rn35WZg7aO4G9YbogbSGk8GFEKQa6t6D+cz/
         dmnVbQitORddBC9x2TzrK0ieh8arTWjxbnTSmMv5lkzs1crHWwy8MHS7IWedwfiM7CLB
         MT0AQQC6jo1eZ97mKUWnth41xM5wqekY6d8WjKyb5Lx6LyE944wa7v9Fq8RvCj6o4Twl
         dDFA==
X-Forwarded-Encrypted: i=1; AJvYcCXdRc9tBZyHG/gEyPVlLn5zJVBboH6SFeAfw9sm1dhjTG0QSaOPozARlb+5ncLzLoQVtPKFkHkv1J8SSiGzOXww2/vTWDosboD8DkfY
X-Gm-Message-State: AOJu0YzOJGK0KrmOhZBA7HAObyb8J/gZTDsMY6QW0xoBu973BAJfZ4Mf
	j0s/403KTIs7Xy627qT+02xxUenXsWLVqOuEvavowx1nOLF/pDbafKRUEAUlZNtkgk2R5mssSry
	J2Fquz3+zrrv9ekpJhVBapF28WKapEan80wQBUk8iQXZljsEhqu6h3DI=
X-Google-Smtp-Source: AGHT+IEdTY1YAoBscGSHJoQ+v23HFe8H2uuO4khud3RyEUWfqQlt3OdBW2PPBggQLWbWwVXj9VzprAaeD4adbLFcuJsOniiOT7xm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2a:b0:374:9ea3:a2e with SMTP id
 e9e14a558f8ab-375e01adbf1mr2537805ab.1.1718435845533; Sat, 15 Jun 2024
 00:17:25 -0700 (PDT)
Date: Sat, 15 Jun 2024 00:17:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002488fc061ae886f8@google.com>
Subject: [syzbot] [ntfs3?] possible deadlock in ntfs_file_mmap
From: syzbot <syzbot+c1751b6739d83d70bb75@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a957267fa7e9 Add linux-next specific files for 20240611
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1139caa2980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a880e96898e79f8
dashboard link: https://syzkaller.appspot.com/bug?extid=c1751b6739d83d70bb75
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6451759a606b/disk-a957267f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7f635dbe5b8a/vmlinux-a957267f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/33eafd1b8aec/bzImage-a957267f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c1751b6739d83d70bb75@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4096
ntfs3: loop0: Different NTFS sector size (4096) and media sector size (512).
======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc3-next-20240611-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.0/9000 is trying to acquire lock:
ffff88805b15dbb8 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:795 [inline]
ffff88805b15dbb8 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: ntfs_file_mmap+0x5d8/0x860 fs/ntfs3/file.c:302

but task is already holding lock:
ffff88807d087398 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:122 [inline]
ffff88807d087398 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff+0x17c/0x3d0 mm/util.c:571

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&mm->mmap_lock){++++}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5817
       gup_fast_fallback+0x24c/0x2b40 mm/gup.c:3534
       pin_user_pages_fast+0xcc/0x160 mm/gup.c:3658
       iov_iter_extract_user_pages lib/iov_iter.c:1583 [inline]
       iov_iter_extract_pages+0x3db/0x720 lib/iov_iter.c:1646
       dio_refill_pages fs/direct-io.c:173 [inline]
       dio_get_page fs/direct-io.c:214 [inline]
       do_direct_IO fs/direct-io.c:916 [inline]
       __blockdev_direct_IO+0x150f/0x49d0 fs/direct-io.c:1249
       blockdev_direct_IO include/linux/fs.h:3201 [inline]
       ntfs_direct_IO+0x195/0x370 fs/ntfs3/inode.c:803
       generic_file_direct_write+0x130/0x350 mm/filemap.c:3941
       __generic_file_write_iter+0x129/0x230 mm/filemap.c:4097
       ntfs_file_write_iter+0x68f/0x770 fs/ntfs3/file.c:1126
       new_sync_write fs/read_write.c:497 [inline]
       vfs_write+0xa72/0xc90 fs/read_write.c:590
       ksys_write+0x1a0/0x2c0 fs/read_write.c:643
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3159 [inline]
       check_prevs_add kernel/locking/lockdep.c:3278 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3902
       __lock_acquire+0x1359/0x2000 kernel/locking/lockdep.c:5194
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5817
       down_write+0x3a/0x50 kernel/locking/rwsem.c:1579
       inode_lock include/linux/fs.h:795 [inline]
       ntfs_file_mmap+0x5d8/0x860 fs/ntfs3/file.c:302
       call_mmap include/linux/fs.h:2123 [inline]
       mmap_region+0xe8f/0x2090 mm/mmap.c:2927
       do_mmap+0x8ad/0xfa0 mm/mmap.c:1438
       vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:573
       ksys_mmap_pgoff+0x4f1/0x720 mm/mmap.c:1484
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&mm->mmap_lock);
                               lock(&sb->s_type->i_mutex_key#21);
                               lock(&mm->mmap_lock);
  lock(&sb->s_type->i_mutex_key#21);

 *** DEADLOCK ***

1 lock held by syz-executor.0/9000:
 #0: ffff88807d087398 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:122 [inline]
 #0: ffff88807d087398 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff+0x17c/0x3d0 mm/util.c:571

stack backtrace:
CPU: 0 PID: 9000 Comm: syz-executor.0 Not tainted 6.10.0-rc3-next-20240611-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:91 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:117
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2075
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2204
 check_prev_add kernel/locking/lockdep.c:3159 [inline]
 check_prevs_add kernel/locking/lockdep.c:3278 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3902
 __lock_acquire+0x1359/0x2000 kernel/locking/lockdep.c:5194
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5817
 down_write+0x3a/0x50 kernel/locking/rwsem.c:1579
 inode_lock include/linux/fs.h:795 [inline]
 ntfs_file_mmap+0x5d8/0x860 fs/ntfs3/file.c:302
 call_mmap include/linux/fs.h:2123 [inline]
 mmap_region+0xe8f/0x2090 mm/mmap.c:2927
 do_mmap+0x8ad/0xfa0 mm/mmap.c:1438
 vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:573
 ksys_mmap_pgoff+0x4f1/0x720 mm/mmap.c:1484
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7e2707cea9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7e27de60c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007f7e271b3f80 RCX: 00007f7e2707cea9
RDX: 00000000007fffff RSI: 0000000000003000 RDI: 0000000020000000
RBP: 00007f7e270ebff4 R08: 0000000000000004 R09: 0000000000000000
R10: 0000000000000012 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f7e271b3f80 R15: 00007ffee8137f98
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

