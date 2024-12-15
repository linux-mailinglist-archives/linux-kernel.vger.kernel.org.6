Return-Path: <linux-kernel+bounces-446311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 070F09F2271
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 07:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6694F18868DC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 06:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409251802B;
	Sun, 15 Dec 2024 06:56:22 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387902F56
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 06:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734245781; cv=none; b=lHtD92PvKNeCTKdR+TDXzZlCuGCseKFWXmAL8XmPs18sQJ3AmAybGFizomcVXdgLoToKkeOvApFYkU4RBVcR+MDsOjK0ZPDgLGMuS4KMcKkNXQI9qnr2exhiNUSdnB0dKk56tN56gk6aYXuR5ksGzjlA6IP5JIh1Z8LdfN1pHC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734245781; c=relaxed/simple;
	bh=/b39DB2wUDkEzkULeDwV1DaCnXUC1uS3yWrdSZi0vX8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FJTmCiN4G5kwLDkeuQpw0DZU4a71guWEivxqed5YIKGXMLu1ppLs9g7fA4aVGrRbz2tDDBciBy8uKOWSmYSz8O/qGvdgExtQAE8TlZcf7wo26UXXPztaabnw6InIJuZ83xJQWnE0cwDzyUNZI45+DHhpCsxaay8Oarq2ao64PyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-83e5dd390bfso366003139f.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 22:56:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734245779; x=1734850579;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GQL3vJdZhzaq4q5jC3R54yCo/SVa59Q8hQ9ZR6nOLmU=;
        b=JsLvFNqR6NeG1KmVv9udCzP2t6rMAYpcnSAQvG3sq51MpGjyiQ/KNqpifIUXyGyebc
         ErlnwHlG0VIJwOQBdb35vafx479q1WJl1yNeaCRj/iQsTqblWBbSAFjhBMpP8J3/v4H2
         VS2PEunFCMkCf/UCP6NoT/fEBMLW5oBlVwRrVHZBBv9L4ctDwEaKsLnQCN8AAPkavKYk
         G24+C1qiHdMZI1Ki3ZzV9bfz2doccfDj2cshcq0c4foQ2Y5pkxnpo2d0QB03c+t6nY9/
         c27sQyDiF4VVOMzi2mP1odv0GBWxXhMmJMtuM7W8Evlm5FOOLvmpLUH9WoIRAb1Abms+
         itJA==
X-Forwarded-Encrypted: i=1; AJvYcCWPVBOCk3hCkXt8zG9kIbVCLhcuwnTrnViAeW2XRSgl4JmuFVTmZaFtpjr36K5Qv+O4U5j4Ff7ubRvsXKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx45clYyhqMGfGdHqigCZV7ySelE/9dGaT1f5PgrrnTLCNH1Aia
	eanGgEm6WFsZDUcwt41mg0iutudCesdxSdztX3puZe0MGP1U2BVn34D1eR2BHKg8zY9CB9c/G+l
	qy4omh0YbRXgrjb8ndG8AKg5Up6qcn6VMfTdSNU9bYwMOuVzbbdhPzyw=
X-Google-Smtp-Source: AGHT+IGSwiAgYvN8dTadK8I9n2LmdSnaHVaudySkR41xnRpF7e2nnfOO0Hn/RpCwwlK5cgMtFRjN0sqZJ0jQyuCu2Ha7tbDJyFdk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:238a:b0:3a7:e1c3:11f5 with SMTP id
 e9e14a558f8ab-3b02adcc3acmr75200985ab.6.1734245779364; Sat, 14 Dec 2024
 22:56:19 -0800 (PST)
Date: Sat, 14 Dec 2024 22:56:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675e7d93.050a0220.37aaf.00f3.GAE@google.com>
Subject: [syzbot] [kernel?] WARNING: locking bug in sched_balance_rq
From: syzbot <syzbot+2d4ccc03d6c11f23901e@syzkaller.appspotmail.com>
To: andrealmeid@igalia.com, dave@stgolabs.net, dvhart@infradead.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f92f4749861b Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1414ccdf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fee25f93665c89ac
dashboard link: https://syzkaller.appspot.com/bug?extid=2d4ccc03d6c11f23901e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d03a74cd09e9/disk-f92f4749.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1b7f97b83a3f/vmlinux-f92f4749.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d2eac1365a6a/bzImage-f92f4749.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2d4ccc03d6c11f23901e@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 1 PID: 6423 at kernel/locking/lockdep.c:232 hlock_class kernel/locking/lockdep.c:232 [inline]
WARNING: CPU: 1 PID: 6423 at kernel/locking/lockdep.c:232 check_wait_context kernel/locking/lockdep.c:4850 [inline]
WARNING: CPU: 1 PID: 6423 at kernel/locking/lockdep.c:232 __lock_acquire+0x564/0x2100 kernel/locking/lockdep.c:5176
Modules linked in:
CPU: 1 UID: 0 PID: 6423 Comm: syz.4.108 Not tainted 6.13.0-rc2-syzkaller-00031-gf92f4749861b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:hlock_class kernel/locking/lockdep.c:232 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4850 [inline]
RIP: 0010:__lock_acquire+0x564/0x2100 kernel/locking/lockdep.c:5176
Code: 00 00 83 3d 71 f3 9e 0e 00 75 23 90 48 c7 c7 00 96 0a 8c 48 c7 c6 00 99 0a 8c e8 f7 62 e5 ff 48 ba 00 00 00 00 00 fc ff df 90 <0f> 0b 90 90 90 31 db 48 81 c3 c4 00 00 00 48 89 d8 48 c1 e8 03 0f
RSP: 0018:ffffc9000c4fed70 EFLAGS: 00010046
RAX: 0fbe9254beddb100 RBX: 00000000000018d8 RCX: ffff88801f353c00
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000000c18d8 R08: ffffffff81600a42 R09: 1ffff110170e519a
R10: dffffc0000000000 R11: ffffed10170e519b R12: ffff88801f3546c4
R13: 0000000000000005 R14: 1ffff11003e6a8e5 R15: ffff88801f354728
FS:  0000555590c7c500(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3030dff8 CR3: 0000000028c98000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
 raw_spin_rq_lock_nested+0xb0/0x140 kernel/sched/core.c:606
 raw_spin_rq_lock kernel/sched/sched.h:1514 [inline]
 _raw_spin_rq_lock_irqsave kernel/sched/sched.h:1534 [inline]
 rq_lock_irqsave kernel/sched/sched.h:1799 [inline]
 sched_balance_rq+0x4dcd/0x8620 kernel/sched/fair.c:11733
 sched_balance_newidle+0x6ba/0xfd0 kernel/sched/fair.c:12795
 balance_fair+0x44/0x70 kernel/sched/fair.c:8744
 prev_balance kernel/sched/core.c:5995 [inline]
 pick_next_task kernel/sched/core.c:6145 [inline]
 __schedule+0x2a3f/0x4c30 kernel/sched/core.c:6709
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6848
 futex_wait_queue+0x14e/0x1d0 kernel/futex/waitwake.c:370
 __futex_wait+0x17f/0x320 kernel/futex/waitwake.c:669
 futex_wait+0x101/0x360 kernel/futex/waitwake.c:697
 do_futex+0x33b/0x560 kernel/futex/syscalls.c:102
 __do_sys_futex kernel/futex/syscalls.c:179 [inline]
 __se_sys_futex+0x3f9/0x480 kernel/futex/syscalls.c:160
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0823d7ff19
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeba872b88 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 00007ffeba872ca0 RCX: 00007f0823d7ff19
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f0823f4616c
RBP: 00007f0823f4616c R08: 7fffffffffffffff R09: 00007ffeba872e6f
R10: 00007ffeba872c90 R11: 0000000000000246 R12: 0000000000026d66
R13: 00007ffeba872c90 R14: 0000000000000032 R15: 0000000000026d34
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

