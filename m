Return-Path: <linux-kernel+bounces-343054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A76698964C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 18:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB6BFB238AB
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 16:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF1E17BB11;
	Sun, 29 Sep 2024 16:46:32 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89CD2B9A2
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 16:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727628391; cv=none; b=cot8CC1c7aAnVmnjQJLvFuPLwPc17oE30Xv1Vxtu2NO7hx0uO/c03hGGdZHSS9ovb6nw792kC39gsu3tyuPXCX9ZzSpkYdi2JuTG8jaI1lBEqBSVxhJ76wrLAigZcFYTTlXPKXkE7S42JeY6UZOi3/ULpIQZeUOFuRD5kLuBw3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727628391; c=relaxed/simple;
	bh=3YT9/lQf+Bsr2lxgK1X252Eyd42VMNSIuEUeXAWSMjA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SBMOEKh1hwudINORwLcsN5egn6qR/9i3aIBl5ddO7hCSYFuwFRcXO+Isy3EgUakuupncOD6yQTNR0XSROA1Xs5Jdv7vLEy7kquIFs+KaqcY3zVsrtx/CBHB30B3AcZ+iXNXc58KyDA3MgTfV5FwMMDLm7HqVkHNwq9SzK4MLSZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a342620f50so31738505ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 09:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727628389; x=1728233189;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nA9vNJ33ziLAMUoq1DGpLbP1DOxuxWdI+NAj1zjU9Mo=;
        b=F8Bw7A8YJCaJMp4kc/P8eBVqoMorfgXUsBWrrtI3cRTxXdQsqGupRdWfE5icMFkLYm
         yLLjiDrPF70FG3UwMsbtuy0MO+2EUSVWfEo7MqkV4R2QkPucsQm0rHh1xc4/II8ni7wf
         sBnqfwW45JnJYri+Q9HW58FaSxi4ZIw2VHsxEVRK5zl8BbDkVdNVbKOIs7P2s5BQmjXU
         FGhFJ3S4YdoVl2Jsw0ayX7GziKPx1FXvj6x563BIM90JmVAGEwrAsQglOVtzrhPWic0G
         sJD62yiDUmShlobOek3wXkzZhK+3c4UpEYdTG9FV49gJkgPygAyV+0Z556ChoiLIu/xb
         +T1g==
X-Forwarded-Encrypted: i=1; AJvYcCUZK1KKc964WlxGrz8rmPcn5yJ2xANtXXFl4Ngg4ur1kUJsKbKebyXqkZJur/+/NQ28Sj4cD3ND1MEuMZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS6G+E2hsQi2xZfjYys25e+gsgy6TCy460UVjyvURmo69fZemA
	7yUaWeZy9V+bVg426xkQXP1kKJC73jix/dYLP0s/Qc3NrJEAgnVkDsiq6ZubPAIRBbImhT+AbRD
	8Pwii3l1T40hrCR+qcxhktvSrnXnNPsFWrM0QuKshxwQDLZjhaPDLnME=
X-Google-Smtp-Source: AGHT+IFHwSnT8AxTXLv5qxTvLkU9eWDKyzRf0lXRXmgz0n8IwF5ciEFxL/PAjq+BgC3bT8/JemAq953xomHMzkQK9TYmqVA5HkO1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b08:b0:3a0:beb4:e402 with SMTP id
 e9e14a558f8ab-3a345150546mr79722225ab.1.1727628389076; Sun, 29 Sep 2024
 09:46:29 -0700 (PDT)
Date: Sun, 29 Sep 2024 09:46:29 -0700
In-Reply-To: <66f7b3a0.050a0220.46d20.0038.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f98465.050a0220.aab67.001e.GAE@google.com>
Subject: Re: [syzbot] [mm?] possible deadlock in shmem_file_write_iter
From: syzbot <syzbot+288aa6838b3263f52e7e@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, hughd@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    3efc57369a0c Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1648f507980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4fcb065287cdb84
dashboard link: https://syzkaller.appspot.com/bug?extid=288aa6838b3263f52e7e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17af2980580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11607d9f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b5a4faec7a99/disk-3efc5736.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/971adf9a5295/vmlinux-3efc5736.xz
kernel image: https://storage.googleapis.com/syzbot-assets/49516da34e16/bzImage-3efc5736.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+288aa6838b3263f52e7e@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.11.0-syzkaller-11993-g3efc57369a0c #0 Not tainted
------------------------------------------------------
syz-executor601/5480 is trying to acquire lock:
ffff888021316098 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock_killable+0x1d/0x70 include/linux/mmap_lock.h:153

but task is already holding lock:
ffff8880120b02c8 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:815 [inline]
ffff8880120b02c8 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at: shmem_file_write_iter+0x80/0x120 mm/shmem.c:3211

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
       down_write+0x99/0x220 kernel/locking/rwsem.c:1579
       inode_lock include/linux/fs.h:815 [inline]
       process_measurement+0x439/0x1fb0 security/integrity/ima/ima_main.c:250
       ima_file_mmap+0x13d/0x2b0 security/integrity/ima/ima_main.c:455
       security_mmap_file+0x7e7/0xa40 security/security.c:2977
       __do_sys_remap_file_pages mm/mmap.c:1692 [inline]
       __se_sys_remap_file_pages+0x6e6/0xa50 mm/mmap.c:1624
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&mm->mmap_lock){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3158 [inline]
       check_prevs_add kernel/locking/lockdep.c:3277 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3901
       __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5199
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
       down_read_killable+0xca/0xd30 kernel/locking/rwsem.c:1549
       mmap_read_lock_killable+0x1d/0x70 include/linux/mmap_lock.h:153
       get_mmap_lock_carefully mm/memory.c:6108 [inline]
       lock_mm_and_find_vma+0x29c/0x2f0 mm/memory.c:6159
       do_user_addr_fault arch/x86/mm/fault.c:1361 [inline]
       handle_page_fault arch/x86/mm/fault.c:1481 [inline]
       exc_page_fault+0x1bf/0x8c0 arch/x86/mm/fault.c:1539
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
       fault_in_readable+0x165/0x2b0
       fault_in_iov_iter_readable+0x229/0x280 lib/iov_iter.c:94
       generic_perform_write+0x259/0x6d0 mm/filemap.c:4044
       shmem_file_write_iter+0xf9/0x120 mm/shmem.c:3221
       new_sync_write fs/read_write.c:590 [inline]
       vfs_write+0xa6d/0xc90 fs/read_write.c:683
       ksys_write+0x183/0x2b0 fs/read_write.c:736
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sb->s_type->i_mutex_key#12);
                               lock(&mm->mmap_lock);
                               lock(&sb->s_type->i_mutex_key#12);
  rlock(&mm->mmap_lock);

 *** DEADLOCK ***

3 locks held by syz-executor601/5480:
 #0: ffff888028a922b8 (&f->f_pos_lock){+.+.}-{3:3}, at: fdget_pos+0x24e/0x320 fs/file.c:1187
 #1: ffff888076168420 (sb_writers#5){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2931 [inline]
 #1: ffff888076168420 (sb_writers#5){.+.+}-{0:0}, at: vfs_write+0x224/0xc90 fs/read_write.c:679
 #2: ffff8880120b02c8 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:815 [inline]
 #2: ffff8880120b02c8 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at: shmem_file_write_iter+0x80/0x120 mm/shmem.c:3211

stack backtrace:
CPU: 1 UID: 0 PID: 5480 Comm: syz-executor601 Not tainted 6.11.0-syzkaller-11993-g3efc57369a0c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2203
 check_prev_add kernel/locking/lockdep.c:3158 [inline]
 check_prevs_add kernel/locking/lockdep.c:3277 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3901
 __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5199
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
 down_read_killable+0xca/0xd30 kernel/locking/rwsem.c:1549
 mmap_read_lock_killable+0x1d/0x70 include/linux/mmap_lock.h:153
 get_mmap_lock_carefully mm/memory.c:6108 [inline]
 lock_mm_and_find_vma+0x29c/0x2f0 mm/memory.c:6159
 do_user_addr_fault arch/x86/mm/fault.c:1361 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x1bf/0x8c0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:fault_in_readable+0x165/0x2b0 mm/gup.c:2235
Code: b3 ff 4c 8d b3 ff 0f 00 00 48 89 d8 4d 01 e6 49 81 e6 00 f0 ff ff 49 39 c6 72 6b e8 b5 c8 b3 ff 4c 39 f3 74 6e 4c 89 64 24 10 <44> 8a 23 43 0f b6 04 2f 84 c0 75 18 44 88 64 24 40 48 81 c3 00 10
RSP: 0018:ffffc900041e7a40 EFLAGS: 00050293
RAX: ffffffff81e11d97 RBX: 00000000200ee000 RCX: ffff888024029e00
RDX: 0000000000000000 RSI: 0000000000000240 RDI: 0000000000000000
RBP: ffffc900041e7af8 R08: ffffffff81e11d08 R09: ffffffff84b941b9
R10: 0000000000000002 R11: ffff888024029e00 R12: 0000000000200000
R13: dffffc0000000000 R14: 0000000020201000 R15: 1ffff9200083cf50
 fault_in_iov_iter_readable+0x229/0x280 lib/iov_iter.c:94
 generic_perform_write+0x259/0x6d0 mm/filemap.c:4044
 shmem_file_write_iter+0xf9/0x120 mm/shmem.c:3221
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xa6d/0xc90 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd0953e3829
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd09537c238 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fd09546e3d8 RCX: 00007fd0953e3829
RDX: 000000000208e24b RSI: 0000000020000240 RDI: 0000000000000003
RBP: 00007fd09546e3d0 R08: 00007fd09537c6c0 R09: 00007fd09537c6c0
R10: 00007fd09537c6c0 R11: 0000000000000246 R12: 00007fd09546e3dc
R13: 000000000000006e R14: 00007ffc57bc6200 R15: 00007ffc57bc62e8
 </TASK>
----------------
Code disassembly (best guess):
   0:	b3 ff                	mov    $0xff,%bl
   2:	4c 8d b3 ff 0f 00 00 	lea    0xfff(%rbx),%r14
   9:	48 89 d8             	mov    %rbx,%rax
   c:	4d 01 e6             	add    %r12,%r14
   f:	49 81 e6 00 f0 ff ff 	and    $0xfffffffffffff000,%r14
  16:	49 39 c6             	cmp    %rax,%r14
  19:	72 6b                	jb     0x86
  1b:	e8 b5 c8 b3 ff       	call   0xffb3c8d5
  20:	4c 39 f3             	cmp    %r14,%rbx
  23:	74 6e                	je     0x93
  25:	4c 89 64 24 10       	mov    %r12,0x10(%rsp)
* 2a:	44 8a 23             	mov    (%rbx),%r12b <-- trapping instruction
  2d:	43 0f b6 04 2f       	movzbl (%r15,%r13,1),%eax
  32:	84 c0                	test   %al,%al
  34:	75 18                	jne    0x4e
  36:	44 88 64 24 40       	mov    %r12b,0x40(%rsp)
  3b:	48                   	rex.W
  3c:	81                   	.byte 0x81
  3d:	c3                   	ret
  3e:	00 10                	add    %dl,(%rax)


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

