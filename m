Return-Path: <linux-kernel+bounces-215792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B6890970D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 10:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A14D284D84
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 08:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D56F1B5AA;
	Sat, 15 Jun 2024 08:45:22 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E5FB66C
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 08:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718441121; cv=none; b=MQIYzrL8ZVbs30r77wVI8bONe7Q5NkgG1PF6nYrOpUVnm01ScLW7Da04uEb9VO9cDJQZ8SQg3oRCoXCI1i/FifMbdlCZ/nPylJ4SV5VbfkH+o5lraeIWkYDXGqCmQihtghKhpG0k8tPob24oKLroXBQVUXj0aUJSFq2wtgO7Cyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718441121; c=relaxed/simple;
	bh=l1Sx3qmy06FcL1F7V68RUCWwd7IUlBKp/eAYZ+FUVME=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mP1TxysMOjuXOeS7VyuUrQQD9hPjfvIrGi5fOZruMJd/0s++fGRx34D6dkgXjjGk3PO+gKDWu9e8VgStaAlCpNy0tG6sDOuUJrCa1VVm+y/5BG7fkxVB3Ah3jdxgBz+gGn6QHHYZLKlPha6zGPljHTYlyD7yEx6X7AsrcZrg228=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-375c390cedeso30472405ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 01:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718441119; x=1719045919;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=beM6ivaNLd2GldzB/4jrOyU5rDywP4/PSTtvn1v3Pxk=;
        b=MIJK/X+ts7svZGUlEy5LdAJd5BaXLZspnoNkOBiED3B9fiNYPFVXvmg9VR4S5CjUQg
         PGP5a6gK+QfRFlF0faVu6J1CpgROqDK+p+dK0EM49cpyujV7hKnJrrF4FQcvn30XvnSw
         tXirBHRHUWQFYVQ3lr3ZF38CiLF54qtgjYdKPSRth9v6PwQti+RQ/9aptfqPlkOCSL8k
         nfsAYITG0fGE39Q1P5DeMQJrCRbZpEneYezKWSy0tMum+JU6cr8yDZ/+OT8k/f/UZvJC
         kkFep7m37ZZQAy1fKLBoYqUs/mxdKHaLxqE+fqd9OjBK2hT+KZbtZ/KxA5tG5p2zbyVM
         YjrQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9nouU5iHpbdkjYK4AGWcuRe6n/EXHo6WFAxTpuzLPD3CM0hKjlFQiGXI1HmKnUIMUqcQ8mu5iW4MybGTwrdVsBYBCNBU9wt6Nq0Kp
X-Gm-Message-State: AOJu0Yw+EaHYE67K2Fp9CHS4HAVlB5EyEuh6zsz1+7TWRBU2EWDgBcJe
	IhFgvl4b+KVkCqV3dbWI6JdFsznA6xjJegzV8F7q0odYUv1DF6jsUkkpnQRIXMr6+0fHUNx2z+C
	/SDtCkkknR6p21CuHjgG92c+DLQt33ZbC/D5kOyJJFSC2MMluqvqcU10=
X-Google-Smtp-Source: AGHT+IFAO4PHyAvEQ+aUGIt4aWSJCCXaaTFwvL7NyNefxLmHvquZ4pxTpuQZnNT6sFjZBVwlXkSCFHknCJbLv6QrYmoawX9ChRRm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1909:b0:375:9e28:49b with SMTP id
 e9e14a558f8ab-375e0e2be9bmr3706085ab.2.1718441119092; Sat, 15 Jun 2024
 01:45:19 -0700 (PDT)
Date: Sat, 15 Jun 2024 01:45:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000078a6b2061ae9c05c@google.com>
Subject: [syzbot] [ntfs3?] possible deadlock in ntfs_file_write_iter
From: syzbot <syzbot+d7452fc408a961bcc6ec@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a957267fa7e9 Add linux-next specific files for 20240611
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16aea4ee980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a880e96898e79f8
dashboard link: https://syzkaller.appspot.com/bug?extid=d7452fc408a961bcc6ec
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6451759a606b/disk-a957267f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7f635dbe5b8a/vmlinux-a957267f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/33eafd1b8aec/bzImage-a957267f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d7452fc408a961bcc6ec@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc3-next-20240611-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.1/11846 is trying to acquire lock:
ffff88807bdfba98 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock_killable+0x1d/0x70 include/linux/mmap_lock.h:153

but task is already holding lock:
ffff888077e4d460 (&sb->s_type->i_mutex_key#26){+.+.}-{3:3}, at: inode_trylock include/linux/fs.h:815 [inline]
ffff888077e4d460 (&sb->s_type->i_mutex_key#26){+.+.}-{3:3}, at: ntfs_file_write_iter+0x25a/0x770 fs/ntfs3/file.c:1099

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&sb->s_type->i_mutex_key#26){+.+.}-{3:3}:
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

-> #0 (&mm->mmap_lock){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3159 [inline]
       check_prevs_add kernel/locking/lockdep.c:3278 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3902
       __lock_acquire+0x1359/0x2000 kernel/locking/lockdep.c:5194
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5817
       down_read_killable+0xca/0xd30 kernel/locking/rwsem.c:1549
       mmap_read_lock_killable+0x1d/0x70 include/linux/mmap_lock.h:153
       get_mmap_lock_carefully mm/memory.c:5846 [inline]
       lock_mm_and_find_vma+0x29c/0x2f0 mm/memory.c:5897
       do_user_addr_fault arch/x86/mm/fault.c:1361 [inline]
       handle_page_fault arch/x86/mm/fault.c:1481 [inline]
       exc_page_fault+0x1bf/0x8c0 arch/x86/mm/fault.c:1539
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
       fault_in_readable+0x108/0x2b0 mm/gup.c:2382
       fault_in_iov_iter_readable+0x229/0x280 lib/iov_iter.c:94
       generic_perform_write+0x492/0x640 mm/filemap.c:4006
       ntfs_file_write_iter+0x68f/0x770 fs/ntfs3/file.c:1126
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
  lock(&sb->s_type->i_mutex_key#26);
                               lock(&mm->mmap_lock);
                               lock(&sb->s_type->i_mutex_key#26);
  rlock(&mm->mmap_lock);

 *** DEADLOCK ***

3 locks held by syz-executor.1/11846:
 #0: ffff88801d356fc8 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x24e/0x310 fs/file.c:1191
 #1: ffff88801f5e0420 (sb_writers#18){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2870 [inline]
 #1: ffff88801f5e0420 (sb_writers#18){.+.+}-{0:0}, at: vfs_write+0x227/0xc90 fs/read_write.c:586
 #2: ffff888077e4d460 (&sb->s_type->i_mutex_key#26){+.+.}-{3:3}, at: inode_trylock include/linux/fs.h:815 [inline]
 #2: ffff888077e4d460 (&sb->s_type->i_mutex_key#26){+.+.}-{3:3}, at: ntfs_file_write_iter+0x25a/0x770 fs/ntfs3/file.c:1099

stack backtrace:
CPU: 1 PID: 11846 Comm: syz-executor.1 Not tainted 6.10.0-rc3-next-20240611-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
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
 down_read_killable+0xca/0xd30 kernel/locking/rwsem.c:1549
 mmap_read_lock_killable+0x1d/0x70 include/linux/mmap_lock.h:153
 get_mmap_lock_carefully mm/memory.c:5846 [inline]
 lock_mm_and_find_vma+0x29c/0x2f0 mm/memory.c:5897
 do_user_addr_fault arch/x86/mm/fault.c:1361 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x1bf/0x8c0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:fault_in_readable+0x108/0x2b0 mm/gup.c:2383
Code: 00 00 00 0f 01 cb 0f ae e8 48 89 de 48 81 e6 ff 0f 00 00 31 ff e8 a8 56 b5 ff 48 89 d8 48 25 ff 0f 00 00 4c 89 74 24 18 74 30 <8a> 1b e8 b1 51 b5 ff 43 0f b6 04 2f 84 c0 0f 85 4d 01 00 00 88 5c
RSP: 0018:ffffc900035df9e0 EFLAGS: 00050202
RAX: 0000000000000240 RBX: 0000000020081240 RCX: ffff8880760d9e00
RDX: ffffc9000a56f000 RSI: 0000000000000240 RDI: 0000000000000000
RBP: ffffc900035dfa98 R08: ffffffff81ddf628 R09: ffffffff84ac0ea9
R10: 0000000000000002 R11: ffff8880760d9e00 R12: 0000000000001000
R13: dffffc0000000000 R14: 1ffff920006bbf40 R15: 1ffff920006bbf44
 fault_in_iov_iter_readable+0x229/0x280 lib/iov_iter.c:94
 generic_perform_write+0x492/0x640 mm/filemap.c:4006
 ntfs_file_write_iter+0x68f/0x770 fs/ntfs3/file.c:1126
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa72/0xc90 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9a82c7cf69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9a839f60c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f9a82db4050 RCX: 00007f9a82c7cf69
RDX: 000000000208e24b RSI: 0000000020000240 RDI: 0000000000000009
RBP: 00007f9a82cda6fe R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f9a82db4050 R15: 00007ffef2c2b4c8
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
  15:	e8 a8 56 b5 ff       	call   0xffb556c2
  1a:	48 89 d8             	mov    %rbx,%rax
  1d:	48 25 ff 0f 00 00    	and    $0xfff,%rax
  23:	4c 89 74 24 18       	mov    %r14,0x18(%rsp)
  28:	74 30                	je     0x5a
* 2a:	8a 1b                	mov    (%rbx),%bl <-- trapping instruction
  2c:	e8 b1 51 b5 ff       	call   0xffb551e2
  31:	43 0f b6 04 2f       	movzbl (%r15,%r13,1),%eax
  36:	84 c0                	test   %al,%al
  38:	0f 85 4d 01 00 00    	jne    0x18b
  3e:	88                   	.byte 0x88
  3f:	5c                   	pop    %rsp


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

