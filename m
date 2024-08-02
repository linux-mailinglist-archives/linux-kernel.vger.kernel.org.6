Return-Path: <linux-kernel+bounces-272503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BCE945D36
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 13:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 648831F22368
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 11:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09D21E2124;
	Fri,  2 Aug 2024 11:23:25 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810F61E2105
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 11:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722597805; cv=none; b=F2JnOwHNX++dhNGnUm5RUxAMsYNvUX2BAp1Po5CTa8vDNJFYm1GYvaga4H8WFGOCh994LPhnrovcF2wT+gC6B5OFJGaSGJ961eIgRlrcyCoQXWBbJLTaOfPAXTCdusYdfoPHnDzo4j7+VAOQDz/ILtpC6/gkegtzVj+tiG3zm1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722597805; c=relaxed/simple;
	bh=hAsozl+HJiKjvJZgGVsLVy4wmnkbduL5ahxrrVzDqYI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tmpeq9pNGUYfQr0HWH398V8WTkPwwhMlQcM1ft3IdOONlQfJkEyfrUAfoLrILWpwJ3DSBDNnUTaIxVsS4ow6Cb5XyhvlsFOa0S3LAlWolw21aOU63b1VaDRexnZY3YEJlcsCyjsXG0S798lTH6Z6h77OutRSLAiX0U7tqlwuUpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f7fb0103fso360348839f.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 04:23:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722597802; x=1723202602;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5fRdRUEXRw84Ye9MfYJd2zHy6udnN9R3+/QYoDUc3FM=;
        b=WgRyLr75nDnKuzeA0r0cPRYNLvBC25BIZdwHQXg9t51mylL5KD7CTU2CJV9+5q/rmD
         VoNVvmSrMuxTyxt9odqcs0WUfV2pdqzjQHSimyzxbd1FY9eMmxnO0j6Y2qZLEQKbG4FY
         LcWPUl/dyLt58LvHfaa3+wek1PPk+5NWJcZ5jLtVkQVM6yQkW2qO/itqyP6Msfbzm8DU
         bkefKd/lmtfZEzwpqO0C3cGvtACde4sp7XsKhYe4pA9UC3OZHdDo8s/MCWAYGik/IsIm
         yd4njb14g03iontowr4BFXF3uBhK39oVetuHX9e3C5YajQsU0sc3rFP4HCfxDEY5wvMa
         /6oA==
X-Forwarded-Encrypted: i=1; AJvYcCV7106bdCXuzJH3WV7Pny41fbAnkRQ8XLDBuzZUN/iAQMe5OUrO/mWNfJ1AEEDbkltgJUwgwq+unNm1h1EkuYbruBsQsA8uQmk59/Jl
X-Gm-Message-State: AOJu0Yy1LebAa2pLF5m3gRHF/P9R63P6wgHdQ9vW0tKw/96NAao2/FZW
	+7/rbGk+OxXylGYh/Yk4TMuL1aW60LkCFZUuy7tVMmVjAWW8ILaJemkgTmT4crcLeLNuw4rxxxv
	tY2QswCBlh4a2kO3z9MjQ08XH/WIO2B9QmpXG8jbgY94VXPbNe2d2zaw=
X-Google-Smtp-Source: AGHT+IE/pj2EVjOTjJcxhTFH+3BzAqJxtAlwHRkoIbW921Db1yDBspG8Agr2HOC/t+byfvv+2uDj2PEHxMblHEJbjMPBcjRCZwNL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a23:b0:39b:c00:85aa with SMTP id
 e9e14a558f8ab-39b20054434mr2218145ab.0.1722597802522; Fri, 02 Aug 2024
 04:23:22 -0700 (PDT)
Date: Fri, 02 Aug 2024 04:23:22 -0700
In-Reply-To: <00000000000078a6b2061ae9c05c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001c4ae9061eb18ef4@google.com>
Subject: Re: [syzbot] [ntfs3?] possible deadlock in ntfs_file_write_iter
From: syzbot <syzbot+d7452fc408a961bcc6ec@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    c0ecd6388360 Merge tag 'pci-v6.11-fixes-1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17478c7d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=288f248fe2b6eab0
dashboard link: https://syzkaller.appspot.com/bug?extid=d7452fc408a961bcc6ec
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=142941a1980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15b302d9980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0cb5895deab9/disk-c0ecd638.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bce552aea06e/vmlinux-c0ecd638.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5489dae15424/bzImage-c0ecd638.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/56ae044ae9a1/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d7452fc408a961bcc6ec@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.11.0-rc1-syzkaller-00154-gc0ecd6388360 #0 Not tainted
------------------------------------------------------
syz-executor170/5231 is trying to acquire lock:
ffff888078ac6098 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock_killable+0x1d/0x70 include/linux/mmap_lock.h:153

but task is already holding lock:
ffff888074715460 (&sb->s_type->i_mutex_key#14){+.+.}-{3:3}, at: inode_trylock include/linux/fs.h:819 [inline]
ffff888074715460 (&sb->s_type->i_mutex_key#14){+.+.}-{3:3}, at: ntfs_file_write_iter+0x24a/0x740 fs/ntfs3/file.c:1166

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&sb->s_type->i_mutex_key#14){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       down_write+0x99/0x220 kernel/locking/rwsem.c:1579
       inode_lock include/linux/fs.h:799 [inline]
       ntfs_file_mmap+0x5bf/0x850 fs/ntfs3/file.c:368
       call_mmap include/linux/fs.h:2129 [inline]
       mmap_region+0xe8f/0x2090 mm/mmap.c:2957
       do_mmap+0x8f9/0x1010 mm/mmap.c:1468
       vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:588
       ksys_mmap_pgoff+0x4f1/0x720 mm/mmap.c:1514
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&mm->mmap_lock){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
       __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       down_read_killable+0xca/0xd30 kernel/locking/rwsem.c:1549
       mmap_read_lock_killable+0x1d/0x70 include/linux/mmap_lock.h:153
       get_mmap_lock_carefully mm/memory.c:5879 [inline]
       lock_mm_and_find_vma+0x29c/0x2f0 mm/memory.c:5930
       do_user_addr_fault arch/x86/mm/fault.c:1361 [inline]
       handle_page_fault arch/x86/mm/fault.c:1481 [inline]
       exc_page_fault+0x1bf/0x8c0 arch/x86/mm/fault.c:1539
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
       fault_in_readable+0x108/0x2b0 mm/gup.c:2236
       fault_in_iov_iter_readable+0x229/0x280 lib/iov_iter.c:94
       generic_perform_write+0x29f/0x840 mm/filemap.c:4009
       ntfs_file_write_iter+0x663/0x740 fs/ntfs3/file.c:1193
       new_sync_write fs/read_write.c:497 [inline]
       vfs_write+0xa72/0xc90 fs/read_write.c:590
       ksys_write+0x1a0/0x2c0 fs/read_write.c:643
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sb->s_type->i_mutex_key#14);
                               lock(&mm->mmap_lock);
                               lock(&sb->s_type->i_mutex_key#14);
  rlock(&mm->mmap_lock);

 *** DEADLOCK ***

3 locks held by syz-executor170/5231:
 #0: ffff88802a594d48 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x24e/0x310 fs/file.c:1191
 #1: ffff88802c5b8420 (sb_writers#9){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2876 [inline]
 #1: ffff88802c5b8420 (sb_writers#9){.+.+}-{0:0}, at: vfs_write+0x227/0xc90 fs/read_write.c:586
 #2: ffff888074715460 (&sb->s_type->i_mutex_key#14){+.+.}-{3:3}, at: inode_trylock include/linux/fs.h:819 [inline]
 #2: ffff888074715460 (&sb->s_type->i_mutex_key#14){+.+.}-{3:3}, at: ntfs_file_write_iter+0x24a/0x740 fs/ntfs3/file.c:1166

stack backtrace:
CPU: 0 UID: 0 PID: 5231 Comm: syz-executor170 Not tainted 6.11.0-rc1-syzkaller-00154-gc0ecd6388360 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2186
 check_prev_add kernel/locking/lockdep.c:3133 [inline]
 check_prevs_add kernel/locking/lockdep.c:3252 [inline]
 validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
 __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
 down_read_killable+0xca/0xd30 kernel/locking/rwsem.c:1549
 mmap_read_lock_killable+0x1d/0x70 include/linux/mmap_lock.h:153
 get_mmap_lock_carefully mm/memory.c:5879 [inline]
 lock_mm_and_find_vma+0x29c/0x2f0 mm/memory.c:5930
 do_user_addr_fault arch/x86/mm/fault.c:1361 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x1bf/0x8c0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:fault_in_readable+0x108/0x2b0 mm/gup.c:2237
Code: 00 00 00 0f 01 cb 0f ae e8 48 89 de 48 81 e6 ff 0f 00 00 31 ff e8 48 af b7 ff 48 89 d8 48 25 ff 0f 00 00 4c 89 74 24 18 74 30 <8a> 1b e8 51 aa b7 ff 43 0f b6 04 2f 84 c0 0f 85 4d 01 00 00 88 5c
RSP: 0018:ffffc90003487a00 EFLAGS: 00050202
RAX: 0000000000000440 RBX: 0000000020005440 RCX: ffff88801cff8000
RDX: 0000000000000000 RSI: 0000000000000440 RDI: 0000000000000000
RBP: ffffc90003487ab8 R08: ffffffff81dbbb68 R09: ffffffff84a51eb9
R10: 0000000000000002 R11: ffff88801cff8000 R12: 000000000000000f
R13: dffffc0000000000 R14: 1ffff92000690f44 R15: 1ffff92000690f48
 fault_in_iov_iter_readable+0x229/0x280 lib/iov_iter.c:94
 generic_perform_write+0x29f/0x840 mm/filemap.c:4009
 ntfs_file_write_iter+0x663/0x740 fs/ntfs3/file.c:1193
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa72/0xc90 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0a955a2c59
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0a95537218 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f0a9564a6d8 RCX: 00007f0a955a2c59
RDX: 000000000000000f RSI: 0000000020005440 RDI: 0000000000000004
RBP: 00007f0a9564a6d0 R08: 00007ffdf6185d97 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f0a95616830
R13: 0000000000000016 R14: 7275632e73646970 R15: 69662f7375622f2e
 </TASK>
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	00 0f                	add    %cl,(%rdi)
   4:	01 cb                	add    %ecx,%ebx
   6:	0f ae e8             	lfence
   9:	48 89 de             	mov    %rbx,%rsi
   c:	48 81 e6 ff 0f 00 00 	and    $0xfff,%rsi
  13:	31 ff                	xor    %edi,%edi
  15:	e8 48 af b7 ff       	call   0xffb7af62
  1a:	48 89 d8             	mov    %rbx,%rax
  1d:	48 25 ff 0f 00 00    	and    $0xfff,%rax
  23:	4c 89 74 24 18       	mov    %r14,0x18(%rsp)
  28:	74 30                	je     0x5a
* 2a:	8a 1b                	mov    (%rbx),%bl <-- trapping instruction
  2c:	e8 51 aa b7 ff       	call   0xffb7aa82
  31:	43 0f b6 04 2f       	movzbl (%r15,%r13,1),%eax
  36:	84 c0                	test   %al,%al
  38:	0f 85 4d 01 00 00    	jne    0x18b
  3e:	88                   	.byte 0x88
  3f:	5c                   	pop    %rsp


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

