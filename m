Return-Path: <linux-kernel+bounces-225326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0C2912F1F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 23:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7585B247EE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 21:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4038517C7A0;
	Fri, 21 Jun 2024 21:02:25 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB8817C200
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 21:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719003744; cv=none; b=g++cTfU+SNLnSTnw45+EF0KaSXJiEw3O0fByRCCl2GwDJAR6/Vhf/qNjcoWucA1KQwIA0Y6tG8cz+0aLveob83ObtAzS6oI5Y2aOWGNZ3JdGTdLSbOxqRtCBcieT1y5DbbrfMyzBTw4lHBahkBgttlXoZtZwIGh90QKk2ZLmIaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719003744; c=relaxed/simple;
	bh=xxan4YzsN2OGTJ+4BERon1rpvvV+mWZN0iLfUl2vvt0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WlUQ8lhK3WYO1MX+r0M/Lp3szoQ3cqaY07hDVaiRpTc5BVonjkYVnGziDgoOAlLOVfcWJttBh7qFvmiVd9YQNI5HOfufSKkzASvW0ndPfpU7YgIlw2+70AGlPt1CvTNYpOW6goNmkPl0Oftj8W3qIzR6U1L8dgyZ/KZHYoRjIno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7ebf00251b9so261779639f.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719003742; x=1719608542;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qpCCV7cceL621t9sxO3MRr+c4hrzR+1a37Oq8uziCOo=;
        b=SCMCWAxdokdFCO+5YYMavDtCceZzN7vuFYlKcRdX6KgA0jho6TZR51Fl8Qiymnr6EE
         B07RxQV2AzTiqvj2FflPLaOn4OHgoIG34d4bhFrSu6b79OO5Ee2+cyrrmOtEZQQgHyZ7
         NrZOklEWzWBPu0nH4mneF7tF4w30uCMcJko5xGF8l+GwUtv6qoMYxFfr3dy8iTF76vCD
         0ukzyz5Bx3BH11/rqBon+R3dZUsv+/S+cqRmWE6XvqQvGGHWY064wc6BWLxQB0BixgXU
         KxNjH3cFCoTuy5Xp24vNZrBUocso2bKH8OD4Oxm3jKO/xu18RztSZ7PHrf8HcSV6E5lN
         rFpA==
X-Forwarded-Encrypted: i=1; AJvYcCXjGDsU04lo8ttjm7glkovZPZQtlY0xS7EM3RsFRJHwqrrfVlpkR1FMVWVunx9xN97WlKqqkFsgtTuQy2PmjOxUM/t5RY8/FaZOvg8j
X-Gm-Message-State: AOJu0Yw2/QYMdQ8DjStiZOewOC1xA/2K6jURmZl8a9cL/7OXHuIlEHfw
	wOFU/4lUYdA2bsBPkhfwieFU2icIrCxWVLk7gGcY5x+blKCjqEe/fz3Dmvq669AK63wfOvXV5y4
	NAssOi18oxXeInY7ACUWwgu9uhrlbloebogAK2xWSMmXSmikkh3tP1ig=
X-Google-Smtp-Source: AGHT+IGoY/E3LSjbEypLMJygS4kkfPm3Mwl+Y44oMzp7ubzoJtGt6bofoi7qgjh6BOInzvw4Q9BT8r2/zc6Kq6pt4IMFGQ6PA7it
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:34a8:b0:4b9:662a:ca3e with SMTP id
 8926c6da1cb9f-4b9abe64f1fmr727443173.1.1719003742285; Fri, 21 Jun 2024
 14:02:22 -0700 (PDT)
Date: Fri, 21 Jun 2024 14:02:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006d4e02061b6cbf22@google.com>
Subject: [syzbot] [kernel?] WARNING: locking bug in sched_core_balance
From: syzbot <syzbot+14641d8d78cc029add8a@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2ccbdf43d5e7 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17c092b6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa0ce06dcc735711
dashboard link: https://syzkaller.appspot.com/bug?extid=14641d8d78cc029add8a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/27e64d7472ce/disk-2ccbdf43.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e1c494bb5c9c/vmlinux-2ccbdf43.xz
kernel image: https://storage.googleapis.com/syzbot-assets/752498985a5e/bzImage-2ccbdf43.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+14641d8d78cc029add8a@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 1 PID: 0 at kernel/locking/lockdep.c:232 hlock_class kernel/locking/lockdep.c:232 [inline]
WARNING: CPU: 1 PID: 0 at kernel/locking/lockdep.c:232 check_wait_context kernel/locking/lockdep.c:4773 [inline]
WARNING: CPU: 1 PID: 0 at kernel/locking/lockdep.c:232 __lock_acquire+0x573/0x1fd0 kernel/locking/lockdep.c:5087
Modules linked in:
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:hlock_class kernel/locking/lockdep.c:232 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4773 [inline]
RIP: 0010:__lock_acquire+0x573/0x1fd0 kernel/locking/lockdep.c:5087
Code: 00 00 83 3d ee 11 3b 0e 00 75 23 90 48 c7 c7 20 ba ca 8b 48 c7 c6 c0 bc ca 8b e8 78 e4 e5 ff 48 ba 00 00 00 00 00 fc ff df 90 <0f> 0b 90 90 90 31 db 48 81 c3 c4 00 00 00 48 89 d8 48 c1 e8 03 0f
RSP: 0018:ffffc900001a76f0 EFLAGS: 00010046
RAX: 07ded2e0bb41d000 RBX: 00000000000016f0 RCX: ffff888017ae0000
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000005 R08: ffffffff81585822 R09: fffffbfff1c39994
R10: dffffc0000000000 R11: fffffbfff1c39994 R12: 0000000000000001
R13: ffff888017ae0000 R14: 0000000000000005 R15: ffff888017ae0b28
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32e3f000 CR3: 0000000059698000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
 raw_spin_rq_lock_nested+0xb0/0x140 kernel/sched/core.c:567
 raw_spin_rq_lock kernel/sched/sched.h:1406 [inline]
 raw_spin_rq_lock_irq kernel/sched/sched.h:1412 [inline]
 sched_core_balance+0xfa6/0x1180 kernel/sched/core.c:6422
 do_balance_callbacks kernel/sched/core.c:5051 [inline]
 __balance_callbacks+0x18a/0x280 kernel/sched/core.c:5105
 finish_lock_switch kernel/sched/core.c:5161 [inline]
 finish_task_switch+0x1d3/0x870 kernel/sched/core.c:5280
 context_switch kernel/sched/core.c:5411 [inline]
 __schedule+0x17f0/0x4a20 kernel/sched/core.c:6745
 schedule_idle+0x53/0x90 kernel/sched/core.c:6863
 do_idle+0x56a/0x5d0 kernel/sched/idle.c:360
 cpu_startup_entry+0x42/0x60 kernel/sched/idle.c:430
 start_secondary+0x100/0x100 arch/x86/kernel/smpboot.c:313
 common_startup_64+0x13e/0x147
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

