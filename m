Return-Path: <linux-kernel+bounces-430656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E64449E3427
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EFBB163540
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 07:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4845718BB9C;
	Wed,  4 Dec 2024 07:31:25 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ECC18A6C1
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 07:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733297484; cv=none; b=gP7irz1SbPMar9ipF8kA6BUjFr6OgOwUNnpG/c1wzh8eDOHwxG0DQm0Ya9PWoDWPI6n6RWNuRnFRQpbVOgeLSx8dzAYe1tElHi7/QuB08Jk4eou84NFBfGyGhpnJ+w6iXviXkiapGkjje2s2+1gVPDR5otyKnW2XaU+yUnBLalw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733297484; c=relaxed/simple;
	bh=7baa6KFZ7iXTgIonAh4DW2GpvLcRif6AZ0N/b8FGQ4A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nd8gonVxdIU8jOlrBHnuevugtIeB6MlCUgDZCYpdwieqQK4mqCo83n++fvT6g7jgK/B4ZcMWHfzuuwzSfXWPDVZ9oyGX1Btgxe/V78PDR5YWvPRoWAEGwQKiDUdyjZ84+jRgt9mtQt0UeeqE3pMbRUtD5RqXSByYr+7YiW/lm2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a7807feadfso59808415ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 23:31:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733297482; x=1733902282;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WlMLfBzIHUfIWqZslxmqOKkQVXOaPdTwKGOz06hYOso=;
        b=GPHrX0bU0BCxq6nmm6Q6O2RE5zBd4znR4t6r/TX8Gqv93B6SCQ6trUbeKqRTCKGzh5
         YxB2cWyArzOn/rpgHWwqiBtCd9YNQtN1GDolSYGinRASysjj7Kg1tMC+YyFkerFBJGBb
         RpRXFqhOW22EoGgMe4HUzHrUB0oqQMLZlsjRKm7s2Gw3GwO8NoXKZI+DMlnYg1JDHJiN
         Lq3/O0JzSjTv6EHVgIoXolKL9b0hSkT0+5iO/QTyiD1kB4pGiFAUuXetao+5dBBnXowc
         nZVBNz5WWSaJi7P0lpNMRS6382+AOgmzKrhOW7GLPzYUGqAxuIyYTBaHeFzlALvBz8+X
         Kd9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUeovwgyFzjjd0kya/49vIb8dUjrywVOrEKWuX7NlACCL2q28cgKQqaeZMpyzn+EFf8DWjdZD+vM3P3pXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzeV/nrwrsthi6nGC5F2kgKqDo0vGtcgDPE7xSwtEW9jtQOHgF
	I3OMq7kl/yrvZUT5/8MdhjKPnmen9sOOm5HVnh3fSauxmG7OW0CxpQV8kQpPAcNae76Y+opprI1
	7COcxwBYL06IRkzckYJ33zg25dN/ZUv+S9KuaYcy1guu/loGvKq6T5ps=
X-Google-Smtp-Source: AGHT+IEqj6VZ0tmaFwGsVzWFtAK+RyhnbWZpwceK9cvm9fJ/cnCHWVFlqEFpdT5kqIbX69uNewOyJ8AhOqDwVSJ6wby463MLVF+m
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a66:b0:3a7:6d14:cc29 with SMTP id
 e9e14a558f8ab-3a7f9a35f8bmr61996075ab.1.1733297482007; Tue, 03 Dec 2024
 23:31:22 -0800 (PST)
Date: Tue, 03 Dec 2024 23:31:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67500549.050a0220.17bd51.005f.GAE@google.com>
Subject: [syzbot] [ntfs3?] possible deadlock in lock_mm_and_find_vma (3)
From: syzbot <syzbot+936adc4458c5f973d899@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    509f806f7f70 Merge tag 's390-6.13-2' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16977f5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=29e5eaaea951b791
dashboard link: https://syzkaller.appspot.com/bug?extid=936adc4458c5f973d899
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7d1fb1c4f755/disk-509f806f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/453a88841053/vmlinux-509f806f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5f46d3b52d30/bzImage-509f806f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+936adc4458c5f973d899@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.12.0-syzkaller-10740-g509f806f7f70 #0 Not tainted
------------------------------------------------------
syz.3.1412/11243 is trying to acquire lock:
ffff8880276e4fe0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock_killable include/linux/mmap_lock.h:153 [inline]
ffff8880276e4fe0 (&mm->mmap_lock){++++}-{4:4}, at: get_mmap_lock_carefully mm/memory.c:6158 [inline]
ffff8880276e4fe0 (&mm->mmap_lock){++++}-{4:4}, at: lock_mm_and_find_vma+0x3a9/0x6a0 mm/memory.c:6209

but task is already holding lock:
ffff88804d648af0 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}, at: inode_trylock include/linux/fs.h:838 [inline]
ffff88804d648af0 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}, at: ntfs_file_write_iter+0x19d/0x2300 fs/ntfs3/file.c:1240

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}:
       down_write+0x93/0x200 kernel/locking/rwsem.c:1577
       inode_lock include/linux/fs.h:818 [inline]
       ntfs_file_mmap+0x610/0x780 fs/ntfs3/file.c:379
       call_mmap include/linux/fs.h:2183 [inline]
       mmap_file mm/internal.h:124 [inline]
       __mmap_new_file_vma mm/vma.c:2291 [inline]
       __mmap_new_vma mm/vma.c:2355 [inline]
       __mmap_region+0x1789/0x2670 mm/vma.c:2456
       mmap_region+0x270/0x320 mm/mmap.c:1347
       do_mmap+0xc00/0xfc0 mm/mmap.c:496
       vm_mmap_pgoff+0x1ba/0x360 mm/util.c:580
       ksys_mmap_pgoff+0x32c/0x5c0 mm/mmap.c:542
       __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
       __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
       __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:82
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&mm->mmap_lock){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain kernel/locking/lockdep.c:3904 [inline]
       __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5226
       lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
       down_read_killable+0x9d/0x380 kernel/locking/rwsem.c:1547
       mmap_read_lock_killable include/linux/mmap_lock.h:153 [inline]
       get_mmap_lock_carefully mm/memory.c:6158 [inline]
       lock_mm_and_find_vma+0x3a9/0x6a0 mm/memory.c:6209
       do_user_addr_fault+0x2b5/0x13f0 arch/x86/mm/fault.c:1361
       handle_page_fault arch/x86/mm/fault.c:1481 [inline]
       exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1539
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
       fault_in_readable+0xee/0x200 mm/gup.c:2228
       fault_in_iov_iter_readable+0x101/0x2c0 lib/iov_iter.c:94
       generic_perform_write+0x21b/0x920 mm/filemap.c:4045
       __generic_file_write_iter+0x1f7/0x240 mm/filemap.c:4156
       ntfs_file_write_iter+0xe4e/0x2300 fs/ntfs3/file.c:1267
       new_sync_write fs/read_write.c:586 [inline]
       vfs_write+0x5b1/0x1150 fs/read_write.c:679
       ksys_pwrite64 fs/read_write.c:786 [inline]
       __do_sys_pwrite64 fs/read_write.c:794 [inline]
       __se_sys_pwrite64 fs/read_write.c:791 [inline]
       __x64_sys_pwrite64+0x1f6/0x250 fs/read_write.c:791
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sb->s_type->i_mutex_key#24);
                               lock(&mm->mmap_lock);
                               lock(&sb->s_type->i_mutex_key#24);
  rlock(&mm->mmap_lock);

 *** DEADLOCK ***

2 locks held by syz.3.1412/11243:
 #0: ffff888025344420 (sb_writers#17){.+.+}-{0:0}, at: ksys_pwrite64 fs/read_write.c:786 [inline]
 #0: ffff888025344420 (sb_writers#17){.+.+}-{0:0}, at: __do_sys_pwrite64 fs/read_write.c:794 [inline]
 #0: ffff888025344420 (sb_writers#17){.+.+}-{0:0}, at: __se_sys_pwrite64 fs/read_write.c:791 [inline]
 #0: ffff888025344420 (sb_writers#17){.+.+}-{0:0}, at: __x64_sys_pwrite64+0x1f6/0x250 fs/read_write.c:791
 #1: ffff88804d648af0 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}, at: inode_trylock include/linux/fs.h:838 [inline]
 #1: ffff88804d648af0 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}, at: ntfs_file_write_iter+0x19d/0x2300 fs/ntfs3/file.c:1240

stack backtrace:
CPU: 0 UID: 0 PID: 11243 Comm: syz.3.1412 Not tainted 6.12.0-syzkaller-10740-g509f806f7f70 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x419/0x5d0 kernel/locking/lockdep.c:2074
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain kernel/locking/lockdep.c:3904 [inline]
 __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5226
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
 down_read_killable+0x9d/0x380 kernel/locking/rwsem.c:1547
 mmap_read_lock_killable include/linux/mmap_lock.h:153 [inline]
 get_mmap_lock_carefully mm/memory.c:6158 [inline]
 lock_mm_and_find_vma+0x3a9/0x6a0 mm/memory.c:6209
 do_user_addr_fault+0x2b5/0x13f0 arch/x86/mm/fault.c:1361
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:fault_in_readable+0xee/0x200 mm/gup.c:2228
Code: 01 cb 0f ae e8 4d 89 ee 31 ff 41 81 e6 ff 0f 00 00 4c 89 f6 e8 c3 c9 b9 ff 4d 85 f6 0f 84 f2 00 00 00 e8 45 c7 b9 ff 45 31 f6 <41> 8a 45 00 31 ff 44 89 f6 88 44 24 28 e8 70 c9 b9 ff 45 85 f6 0f
RSP: 0018:ffffc9000f977968 EFLAGS: 00050246
RAX: 00000000000058a3 RBX: 0000000000000000 RCX: ffffc9000cf2b000
RDX: 0000000000080000 RSI: ffffffff81d4fd3b RDI: 0000000000000007
RBP: 000000002000ff2f R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000274 R11: 0000000000000000 R12: 0000000000000cbb
R13: 000000002000f274 R14: 0000000000000000 R15: 1ffff92001f2ef2e
 fault_in_iov_iter_readable+0x101/0x2c0 lib/iov_iter.c:94
 generic_perform_write+0x21b/0x920 mm/filemap.c:4045
 __generic_file_write_iter+0x1f7/0x240 mm/filemap.c:4156
 ntfs_file_write_iter+0xe4e/0x2300 fs/ntfs3/file.c:1267
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x5b1/0x1150 fs/read_write.c:679
 ksys_pwrite64 fs/read_write.c:786 [inline]
 __do_sys_pwrite64 fs/read_write.c:794 [inline]
 __se_sys_pwrite64 fs/read_write.c:791 [inline]
 __x64_sys_pwrite64+0x1f6/0x250 fs/read_write.c:791
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0e30780849
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0e314c6058 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
RAX: ffffffffffffffda RBX: 00007f0e30945fa0 RCX: 00007f0e30780849
RDX: 000000000000fdef RSI: 0000000020000140 RDI: 0000000000000005
RBP: 00007f0e307f3986 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000fecc R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f0e30945fa0 R15: 00007ffe3585a1a8
 </TASK>
----------------
Code disassembly (best guess):
   0:	01 cb                	add    %ecx,%ebx
   2:	0f ae e8             	lfence
   5:	4d 89 ee             	mov    %r13,%r14
   8:	31 ff                	xor    %edi,%edi
   a:	41 81 e6 ff 0f 00 00 	and    $0xfff,%r14d
  11:	4c 89 f6             	mov    %r14,%rsi
  14:	e8 c3 c9 b9 ff       	call   0xffb9c9dc
  19:	4d 85 f6             	test   %r14,%r14
  1c:	0f 84 f2 00 00 00    	je     0x114
  22:	e8 45 c7 b9 ff       	call   0xffb9c76c
  27:	45 31 f6             	xor    %r14d,%r14d
* 2a:	41 8a 45 00          	mov    0x0(%r13),%al <-- trapping instruction
  2e:	31 ff                	xor    %edi,%edi
  30:	44 89 f6             	mov    %r14d,%esi
  33:	88 44 24 28          	mov    %al,0x28(%rsp)
  37:	e8 70 c9 b9 ff       	call   0xffb9c9ac
  3c:	45 85 f6             	test   %r14d,%r14d
  3f:	0f                   	.byte 0xf


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

