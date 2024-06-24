Return-Path: <linux-kernel+bounces-227629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6105F9154B7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 840811C21757
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2041519DF42;
	Mon, 24 Jun 2024 16:48:23 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF712F24
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 16:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719247702; cv=none; b=a7mYZOJ78E4WPILSPNX8uGZtdhF6eVsADmGRhelaxEW828gUtZK4iNQ2KixFa8rit26XqqMyuy2efPYCbOfP8Q/QmITh9wgrhwe4ZTrkyOypXlINsr/uDFMopF7R121qfZub/RVnYZKofwQc4N9LUTNgG8YSDF0u7+nxSwv+Zpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719247702; c=relaxed/simple;
	bh=6/puZW9ESulFXCcGFcPYU/1U0jBX+zaUUNxByq+TKrI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=m9DoiyZErPPYLO0m7+Z9hC7UzlgJCvWLzJF9UT2KMLIqUos200zHWO80alqlfsgKkcVpZINH7lbq91ZxJxdWrFhe+QkZTfIfmI5Nrf8v/7TTLxTtTL+4x3SYu0q+kb8aQBgxjJ64+5o+kcZfG4oZGr5GlHRJYPAe5+ETIcGSiV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-37623e47362so60231965ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719247700; x=1719852500;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5KGnMYgQ0FwW2GL2AlsrA1DGANOTOl6nsumMDrX6kzw=;
        b=nZxw8o8tQ9vujvTLV9w9HA+KemV06Bs1lPIEOSSlSWOJKVTsCnsdO6saRNJLvXmBul
         yUFM2NWpTuiPurvE40ZambImzwGvDZ/p1WX4woTUhqtJ/U/O9qWo1RmIO1zbnYKLEKQj
         dnjal78YFDYMJtprphmczN5mAdgSgi40il8ynERLCAxnOEalA9dFX3pxJH56nTWBKTu2
         nodF19vPAOI/s5ag5uzn82Qy5eY7k+glqixQYTAnxpBYa8rqDD1bSS7xrXC6Nxh/zNo/
         Eo02A7FGJZbXP6B6J3e2jyTyo/ifuPTdYCxyRDpz3OVKPK037mkzwsoapZPNu7wgkrZA
         D5rA==
X-Forwarded-Encrypted: i=1; AJvYcCWbpqADKNI5QLcTUUI3C/N/GqVmyV+wIwbntrNecD+NcwmB7YWoMpsyy7kmh7Vl/ExhUFfN0QuG9xxPgTUYMJpdDUTUzl/SVGnSSUIv
X-Gm-Message-State: AOJu0Yy+4SP2YHDmyktPJiQTX3ZXHEhLp85sSAwTeZPUMctj0wGPGV2b
	mqZHIEuHQBlUPq2ayqRTpdh2lci0md6geGg7QgMevmjsBg5Edrn1lMee3P+VjI0sXoqXPZ2DxRk
	xi7YTWAURZGZcrP2Gf8FIQ5lrjfUTEbdqkvgPiKt0nnGBmPSChg8mRa4=
X-Google-Smtp-Source: AGHT+IFMQVz2rzwuYfSXe976jQr7ccTKKPl3QhgieSQPHAni4XAzBRfCV/2pN9py+8U22ryjxc+djuKSoz/uBSx5TSjVY2/rt3Z9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:138c:b0:374:70ae:e86e with SMTP id
 e9e14a558f8ab-3763b377a27mr7307435ab.6.1719247700175; Mon, 24 Jun 2024
 09:48:20 -0700 (PDT)
Date: Mon, 24 Jun 2024 09:48:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000733bf2061ba58c4d@google.com>
Subject: [syzbot] [kernel?] INFO: rcu detected stall in sys_futex (7)
From: syzbot <syzbot+b66b5182718939fec09b@syzkaller.appspotmail.com>
To: andrealmeid@igalia.com, dave@stgolabs.net, dvhart@infradead.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    66cc544fd75c Merge tag 'dmaengine-fix-6.10' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16beff56980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f413acf5b1eb4093
dashboard link: https://syzkaller.appspot.com/bug?extid=b66b5182718939fec09b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/47e71dc016ab/disk-66cc544f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a291e2654ce5/vmlinux-66cc544f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fcc76e4e2724/bzImage-66cc544f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b66b5182718939fec09b@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	(detected by 1, t=10502 jiffies, g=53573, q=135 ncpus=2)
rcu: All QSes seen, last rcu_preempt kthread activity 10502 (4295010993-4295000491), jiffies_till_next_fqs=1, root ->qsmask 0x0
rcu: rcu_preempt kthread starved for 10502 jiffies! g53573 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:27680 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0xf15/0x5d00 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6837
 schedule_timeout+0x136/0x2a0 kernel/time/timer.c:2581
 rcu_gp_fqs_loop+0x1eb/0xb00 kernel/rcu/tree.c:2000
 rcu_gp_kthread+0x271/0x380 kernel/rcu/tree.c:2202
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 1 PID: 10159 Comm: syz-executor.3 Not tainted 6.10.0-rc4-syzkaller-00164-g66cc544fd75c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:finish_task_switch.isra.0+0x220/0xcc0 kernel/sched/core.c:5282
Code: a9 0a 00 00 44 8b 0d 37 1f 86 0e 45 85 c9 0f 85 c0 01 00 00 48 89 df e8 ae f8 ff ff e8 69 db 36 00 fb 65 48 8b 1d 40 89 a5 7e <48> 8d bb f8 15 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1
RSP: 0018:ffffc9000360f810 EFLAGS: 00000206
RAX: 0000000000527977 RBX: ffff888058c49e00 RCX: 1ffffffff1fc7f31
RDX: 0000000000000000 RSI: ffffffff8b2caf60 RDI: ffffffff8b8ff400
RBP: ffffc9000360f858 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff8fe43c17 R11: 0000000000000000 R12: ffff8880b933f938
R13: ffff888058c4da00 R14: 0000000000000000 R15: ffff8880b933ebc0
FS:  00005555718eb480(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd86d7b00c0 CR3: 0000000024a24000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 </IRQ>
 <TASK>
 context_switch kernel/sched/core.c:5411 [inline]
 __schedule+0xf1d/0x5d00 kernel/sched/core.c:6745
 preempt_schedule_irq+0x51/0x90 kernel/sched/core.c:7067
 irqentry_exit+0x36/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:preempt_count_sub+0x63/0x160 kernel/sched/core.c:5909
Code: 56 13 85 c9 75 1b 65 8b 05 b2 4e a6 7e 89 c2 81 e2 ff ff ff 7f 39 d3 7f 17 81 fb fe 00 00 00 76 71 f7 db 65 01 1d 95 4e a6 7e <5b> c3 cc cc cc cc 90 e8 f1 2d 22 03 85 c0 74 51 48 c7 c0 d4 6e e4
RSP: 0018:ffffc9000360fad8 EFLAGS: 00000257
RAX: 0000000000000001 RBX: 00000000ffffffff RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff8b2caf60 RDI: 0000000000000001
RBP: ffffed100b1893c0 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff8fe43c17 R11: 0000000000000000 R12: ffff888058c49e2c
R13: ffff888058c49e00 R14: ffffffff81815241 R15: dffffc0000000000
 __schedule_loop kernel/sched/core.c:6823 [inline]
 schedule+0xf1/0x350 kernel/sched/core.c:6837
 futex_wait_queue+0xfc/0x1f0 kernel/futex/waitwake.c:370
 __futex_wait+0x291/0x3c0 kernel/futex/waitwake.c:669
 futex_wait+0xe9/0x380 kernel/futex/waitwake.c:697
 do_futex+0x22b/0x350 kernel/futex/syscalls.c:102
 __do_sys_futex kernel/futex/syscalls.c:179 [inline]
 __se_sys_futex kernel/futex/syscalls.c:160 [inline]
 __x64_sys_futex+0x1e1/0x4c0 kernel/futex/syscalls.c:160
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd86d67d0a9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd5114c5a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 000000000009ad9c RCX: 00007fd86d67d0a9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007fd86d7b405c
RBP: 000000000009adce R08: 00007fd86e428080 R09: 0000000c00000000
R10: 00007ffd5114c690 R11: 0000000000000246 R12: 00007ffd5114c690
R13: 00007fd86d7b405c R14: 0000000000000032 R15: 00007ffd5114c6b0
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

