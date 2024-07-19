Return-Path: <linux-kernel+bounces-257660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CDE937D1E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 22:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F25ADB21E41
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 20:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673DC14884D;
	Fri, 19 Jul 2024 20:01:25 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA58147C74
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 20:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721419284; cv=none; b=D4J0V5/rvmBf921wwFKk/q5fPeEaA2awZDtEKl4mPiixwF1mUDUexDgMGw4mwQyM5TdteOmh4VXZSkLDOfTjMVb4DTJZQfChrWh0rAmQ1Kd9kQd1FUerWIAWIGua7xsuFcJSOYBG6OrCoG7vqRcbTnk7y2T2XHNt3tKZwS33tZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721419284; c=relaxed/simple;
	bh=/ODQVaF+kj4R5ZdkoO7A1k0FsHYPHHK+Iq8kAVC4/ms=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=E/CzVw7EPY6ilBRVYnXKA9PvU9tYv/C83xI4s5/+VafUMmKkZiq1l0rqu9SpWT3plN+Wp1zOLT4ZDCkIk1PKAUYqKLrFj3Lp3Q4ijo/Q5rQxUCgb7Mtq+cn65CoGbTORb2tM6NqimI6kw/szNwShewi9oPlq3B9nekqjQmkcv/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39884085529so8343715ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 13:01:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721419282; x=1722024082;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dovYDmlxyJjeuhItE/fiPUxUOKLE0VMXsjbN63JDOhA=;
        b=wSDMKiF1dM5RqgmFMcVxcFWbz3fHDAXmsCDfyX0qMdsR7To/nf6Rlqkf+jyrXcBgoy
         qsNuA46gSYRBTsfTR+uhi7yb9yGFKCpNwzWKKCtkesWAvwMjVIoMYAeTmwmZIicRfARO
         6Os4A0cu50B9PifY6NNVhHToX4GUoLXhOymJmWx8JtYrusTxU8AJXrkoZMAGY1YBTt+l
         HRUAIVSvt9cSlat25bfX5eIhbIPpmE9jE7ElvxLKh2H1Wq9kRkz/D4IRNgIaHDT5t5Lb
         aJtp1dKmdVUIfI0cvaROk/HOmjE3Qeu6h1MFX3+NxvV14DPrNcmw3XBg/QtpG9R88eid
         Y+3A==
X-Forwarded-Encrypted: i=1; AJvYcCVIoxCWZVNrx/t14WC6eDzWqlma5IKytPSpxG5XQonV+fI0W5JirV9S87krueHmG2FbcdITGZ82BzECSgxYPPPTva6ILovFJ4RnZmCQ
X-Gm-Message-State: AOJu0YxdH4LB9ThyIzg5c5+cqBwmm6f/hKmBOEtCJAubvN0jPdMNoJcv
	vH9iVGuiysUOjRhG020iMvMzBTqdypf4VXXSm15WXOKlMRChGztWvZ1jVy4dzQDMbs41VNbgLvp
	8w8LH8d0P24L09RLJVY8CYlD3qyeuiPy+nH2We/HkP9S0wikbNyF2s4A=
X-Google-Smtp-Source: AGHT+IFxuYL0cY77FqP8wEtKHRdbGqJTbyhbKA1qpJXS29yHwDVtTM9hIsEM9XtFc9oCE2jRbQ24U+vQjV7NtQpUZ0n4TH5wae5b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c28:b0:395:fa9a:318e with SMTP id
 e9e14a558f8ab-398e17ab520mr686005ab.0.1721419282525; Fri, 19 Jul 2024
 13:01:22 -0700 (PDT)
Date: Fri, 19 Jul 2024 13:01:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d8474e061d9f28be@google.com>
Subject: [syzbot] [mm?] possible deadlock in mmap_read_lock
From: syzbot <syzbot+c0f0941337ade4c26ed1@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3fe121b62282 Add linux-next specific files for 20240712
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1769e695980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98dd8c4bab5cdce
dashboard link: https://syzkaller.appspot.com/bug?extid=c0f0941337ade4c26ed1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8c6fbf69718d/disk-3fe121b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/39fc7e43dfc1/vmlinux-3fe121b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0a78e70e4b4e/bzImage-3fe121b6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c0f0941337ade4c26ed1@syzkaller.appspotmail.com


============================================
WARNING: possible recursive locking detected
6.10.0-rc7-next-20240712-syzkaller #0 Not tainted
--------------------------------------------
mount/4518 is trying to acquire lock:
ffff88801d2b1498 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock+0x1c/0x60 include/linux/mmap_lock.h:144

but task is already holding lock:
ffff88801d2b1498 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:144 [inline]
ffff88801d2b1498 (&mm->mmap_lock){++++}-{3:3}, at: exit_mmap+0x159/0xc80 mm/mmap.c:3396

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&mm->mmap_lock);
  lock(&mm->mmap_lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

1 lock held by mount/4518:
 #0: ffff88801d2b1498 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:144 [inline]
 #0: ffff88801d2b1498 (&mm->mmap_lock){++++}-{3:3}, at: exit_mmap+0x159/0xc80 mm/mmap.c:3396

stack backtrace:
CPU: 1 UID: 0 PID: 4518 Comm: mount Not tainted 6.10.0-rc7-next-20240712-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_deadlock_bug+0x483/0x620 kernel/locking/lockdep.c:3034
 check_deadlock kernel/locking/lockdep.c:3086 [inline]
 validate_chain+0x15e2/0x5920 kernel/locking/lockdep.c:3888
 __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5199
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
 down_read+0xb1/0xa40 kernel/locking/rwsem.c:1526
 mmap_read_lock+0x1c/0x60 include/linux/mmap_lock.h:144
 unmap_single_vma+0x2a0/0x330 mm/memory.c:1832
 unmap_vmas+0x3cc/0x5f0 mm/memory.c:1904
 exit_mmap+0x264/0xc80 mm/mmap.c:3412
 __mmput+0x115/0x390 kernel/fork.c:1347
 exit_mm+0x220/0x310 kernel/exit.c:571
 do_exit+0x9b2/0x27f0 kernel/exit.c:869
 do_group_exit+0x207/0x2c0 kernel/exit.c:1031
 __do_sys_exit_group kernel/exit.c:1042 [inline]
 __se_sys_exit_group kernel/exit.c:1040 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1040
 x64_sys_call+0x26c3/0x26d0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd19a876a90
Code: Unable to access opcode bytes at 0x7fd19a876a66.
RSP: 002b:00007ffd90b476e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fd19a967860 RCX: 00007fd19a876a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00007fd19a967860 R08: 00007ffd90b47560 R09: 00007ffd90b47640
R10: 00007ffd90b475a0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fd19a96b658 R15: 0000000000000001
 </TASK>
mount (4518) used greatest stack depth: 23680 bytes left


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

