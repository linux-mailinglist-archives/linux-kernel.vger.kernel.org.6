Return-Path: <linux-kernel+bounces-515605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76165A3669A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 20:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D134E3AA790
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742CD1D86F6;
	Fri, 14 Feb 2025 19:58:27 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146D61C84D3
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 19:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739563106; cv=none; b=GJRJBfu9gdpgEQtcqQ+KCFR6x/tedYBlgj+ikZkByBemlZ1UK4L0//qMt+zM9kl1zyWzjLURTKZ5WVVKOcJn/T13FsvC1shsYpgke7QzlibmLbGAWZJbTh+coJ3/sgehoosyjALAcRlotn/C7amaja5ZHoEvN3sAPgUdZ7IZVzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739563106; c=relaxed/simple;
	bh=u62DfdFPqMOlpW/t8+oq41SSN+rRR0Fo+yB1gLtmVTg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cQ+tipux8T5QgOdeGuxFp9wLDUgwi9w/31OOxD8CfZ/AG+z13wn50/4AlyuHkM8AwLVIYywBfRy2S4OQk1o3W1WzsVHaJ5U69I4xZ4sjqlOQw6U6g5rNcpTivnAuUpjuKe+Dt2QDrBq0WIiMJdJZvROgCrExhgVcPUAXYadbARE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d19ef3c791so6199895ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:58:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739563104; x=1740167904;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KqRQoSZnv/gGJuddlBS17e372/f1y6XChurYxkkRb/0=;
        b=U+z2Z1i+VBTKsF3T3/7yESQryE22XVvCt24I6z1RBbY8gXah1v1GzVmalRsf45blfA
         b/D856WwVZorpl8Nbc1FaWl1ytfTmuysZoGUCttv02c5WVwMQaIEfETqGNKWP0ra/P5e
         MjHxJyVNLKd6l/U0fWSwZWEnp4haR2djvk+lvw4m3+1qBFGLACZ/5GN0QeIYYFAtOfXQ
         Q4tovrfCDCW5JecqadgChsTclPbmjx+yO5k47ytjqRz3EwD75DsChEoRhpKdguKuJ4Gp
         lM0vyy9D0HWL4Y7121s901ku4e7IZnfAvZL7H4FfJKEpbJVgq1LxfgHH0D1Vcf8ZQzmJ
         3yXA==
X-Forwarded-Encrypted: i=1; AJvYcCXs0n7TB6ssA0lmjPIiHkQu9kOqm/JwlgaRf20YPxRJZ9DAL5CABrc6/wqkHG7c5CG0j6FemPnLnq7inDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjqOH9+EAzbRkaJZuC4PwIrDm8b8lKzYO75yqeiol12FuM6eF4
	iuzsjv3R3DlzgE4xXopJjnKlG26nPaY+WH+nNkNIBNDnIu4Wj6kcSP0FTEXr/UNV416ZvF1yyBC
	BCEOBm1jGYINH8mTJHm5uHeomL/3vOzl662Bt6NeTp1a4o4YJuvB8W0I=
X-Google-Smtp-Source: AGHT+IGP+y+URfIXFQWIDNemuujA9KX5PGz9DGIndOumem3fjQhb9WPsHzLG5fjIrgCwKsG4MPSkfQ2o9/KYy4ogK+G27ypi6WxE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8b:b0:3d1:5f67:f0e6 with SMTP id
 e9e14a558f8ab-3d281e01fb8mr4135775ab.1.1739563104232; Fri, 14 Feb 2025
 11:58:24 -0800 (PST)
Date: Fri, 14 Feb 2025 11:58:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67afa060.050a0220.21dd3.0051.GAE@google.com>
Subject: [syzbot] [block?] BUG: corrupted list in loop_process_work
From: syzbot <syzbot+c104904eeb2c0edbdb06@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, zhaoyang.huang@unisoc.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c674aa7c289e Add linux-next specific files for 20250212
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=125063f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a0fd539126ae5541
dashboard link: https://syzkaller.appspot.com/bug?extid=c104904eeb2c0edbdb06
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=158a3bdf980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e18aa4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cc5b357d26d3/disk-c674aa7c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/11dcf272a27b/vmlinux-c674aa7c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4e487b1c1c6e/bzImage-c674aa7c.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4ea41e9eae4d/mount_0.gz

The issue was bisected to:

commit 3bee991f2b68175c828dc3f9c26367fe1827319a
Author: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
Date:   Fri Feb 7 09:19:42 2025 +0000

    loop: release the lo_work_lock before queue_work

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=161029b0580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=151029b0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=111029b0580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c104904eeb2c0edbdb06@syzkaller.appspotmail.com
Fixes: 3bee991f2b68 ("loop: release the lo_work_lock before queue_work")

list_add double add: new=ffff88807fe21c70, prev=ffff88807fe21c70, next=ffff888024c29160.
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:37!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 12 Comm: kworker/u8:1 Not tainted 6.14.0-rc2-next-20250212-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Workqueue: loop0 loop_workfn
RIP: 0010:__list_add_valid_or_report+0xa4/0x130 lib/list_debug.c:35
Code: f7 74 11 b0 01 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc 48 c7 c7 40 e5 60 8c 4c 89 fe 4c 89 e2 4c 89 f1 e8 fd 88 35 fc 90 <0f> 0b 48 c7 c7 40 e3 60 8c e8 ee 88 35 fc 90 0f 0b 48 c7 c7 e0 e3
RSP: 0018:ffffc90000117628 EFLAGS: 00010046
RAX: 0000000000000058 RBX: 1ffff1100ffc438e RCX: 89e05f8d6ffcb000
RDX: 0000000000000000 RSI: 0000000080000001 RDI: 0000000000000000
RBP: 1ffff1100498522d R08: ffffffff819f562c R09: 1ffff92000022e60
R10: dffffc0000000000 R11: fffff52000022e61 R12: ffff88807fe21c70
R13: dffffc0000000000 R14: ffff888024c29160 R15: ffff88807fe21c70
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff4b64ffe00 CR3: 000000007cfa4000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_add_valid include/linux/list.h:88 [inline]
 __list_add include/linux/list.h:150 [inline]
 list_add_tail include/linux/list.h:183 [inline]
 loop_process_work+0x1f96/0x21c0 drivers/block/loop.c:1977
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3317
 worker_thread+0x870/0xd30 kernel/workqueue.c:3398
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_add_valid_or_report+0xa4/0x130 lib/list_debug.c:35
Code: f7 74 11 b0 01 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc 48 c7 c7 40 e5 60 8c 4c 89 fe 4c 89 e2 4c 89 f1 e8 fd 88 35 fc 90 <0f> 0b 48 c7 c7 40 e3 60 8c e8 ee 88 35 fc 90 0f 0b 48 c7 c7 e0 e3
RSP: 0018:ffffc90000117628 EFLAGS: 00010046
RAX: 0000000000000058 RBX: 1ffff1100ffc438e RCX: 89e05f8d6ffcb000
RDX: 0000000000000000 RSI: 0000000080000001 RDI: 0000000000000000
RBP: 1ffff1100498522d R08: ffffffff819f562c R09: 1ffff92000022e60
R10: dffffc0000000000 R11: fffff52000022e61 R12: ffff88807fe21c70
R13: dffffc0000000000 R14: ffff888024c29160 R15: ffff88807fe21c70
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff4b64ffe00 CR3: 000000007cfa4000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

