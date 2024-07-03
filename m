Return-Path: <linux-kernel+bounces-239021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9800D9254FA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 09:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13D101F25F20
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 07:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D200813958C;
	Wed,  3 Jul 2024 07:59:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E3C13791F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 07:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719993545; cv=none; b=mn8iW8QSfmtLrZIiQBsEITVP6wHiehqHkhNl9Qp8q2tY+TFMv/aKknWUeqc5T2QgUuu1Pp6Y1RloCkh+KjWL0LbFKG8byfYqxSYXwXMLjRRANmEaVdGHx32tzziAiLrUDZl29keBgdlu3S6sX9KcHE8BiX5Pq8fg96VfI+613Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719993545; c=relaxed/simple;
	bh=ctwAXw63syGVsiHuw0ufkQ8ZHLQHFEJy8pvxsdX9RdQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EuxXjtfMW+HSkSKWZNgQVG5BdODzr3YTtj8MHkAzeNne+74eg1hsByif250G5VR5iuRieYuW7TF5eLmQYAbemTSftNpsqV9Z+wTeveFREguSHO303eNU8uD7O19ABc02ib+oyumv3oju/XnKu4HhWqsITLjJAU9rGyxrxKAvmIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f3d2fd6ad6so580682139f.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 00:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719993543; x=1720598343;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g5sRen1boiDRBnVM1/vjjXqoEqZQkJQ//9Z2zKOkZLg=;
        b=lB49JFVw52oHNiF+fm1SNZvLRt7/Pm/FFjkA7Wmf8PJLQj1W3LpgaLYnOUViyinHyQ
         pP+l4+ZWjIxlzqGfn2BnxSwnYcd6mnowtuow6Zwy+TAnQMJOn/6sJqLhFSzOsFr1A6Il
         be8zKODt7b1GaTVwBsvUAatTo/2QS4MvcgRDzOaTuVu3Saw3JMYJre8r92nQYEa8TS74
         q2zvEYsv1Kd9jFw3CME9BKsVa1XfjaSXImz6hitz37+4ZLPJIOwuF1tlLG7NsM95vH/V
         M5+9Z2kJkrrQez3Ijj3Kzh8+icpMcwf9um9WAHDbFenR1BYvWRMs3WXxYrEVtaxxBpu4
         Omfw==
X-Gm-Message-State: AOJu0YymCbg1yDhyTuT5TBCEgJGLvFoIF8oBpkmo+L2AYo1s74hDLTaj
	tzkJABpgWBRZa8K5GCNY2nWu9y0twU57rBtXUfVu+q7TMkjFKn2YFZ86fybyTSO1IkoRLphYrBV
	7KNgpHw0oL7oJfacPb3r6N0AEBWCNJPCHKSFWON2sZp71NosXPK2loDE=
X-Google-Smtp-Source: AGHT+IEyQ0jo0NZZ7/qwzTXqOTitt7dSWt7El2ekAvOYCjV8jYSaUF5fiWKx+mPo2NBzj7Vo4omBba8aMNt8+hevCeEOyCXvh6K0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1614:b0:7f3:d924:8618 with SMTP id
 ca18e2360f4ac-7f62ed69089mr70984039f.0.1719993542917; Wed, 03 Jul 2024
 00:59:02 -0700 (PDT)
Date: Wed, 03 Jul 2024 00:59:02 -0700
In-Reply-To: <20240703072541.643035-2-radoslaw.zielonek@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000244dcc061c53341e@google.com>
Subject: Re: [syzbot] [bpf?] [mm?] INFO: rcu detected stall in sys_clone (8)
From: syzbot <syzbot+c4c6c3dc10cc96bcf723@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, radoslaw.zielonek@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in pipe_write

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 0-...D } 2685 jiffies s: 1749 root: 0x1/.
rcu: blocking rcu_node structures (internal RCU debug):
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 5372 Comm: syz-executor.0 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:native_save_fl arch/x86/include/asm/irqflags.h:32 [inline]
RIP: 0010:arch_local_save_flags arch/x86/include/asm/irqflags.h:67 [inline]
RIP: 0010:arch_local_irq_save arch/x86/include/asm/irqflags.h:103 [inline]
RIP: 0010:lock_acquire+0x17e/0x530 kernel/locking/lockdep.c:5750
Code: 4c 89 fb 48 c1 eb 03 42 80 3c 2b 00 74 08 4c 89 ff e8 d6 a7 86 00 48 c7 84 24 80 00 00 00 00 00 00 00 9c 8f 84 24 80 00 00 00 <42> 80 3c 2b 00 74 08 4c 89 ff e8 c3 a6 86 00 48 8d 5c 24 60 4c 8b
RSP: 0018:ffffc90000007b20 EFLAGS: 00000046
RAX: 0000000000000000 RBX: 1ffff92000000f74 RCX: ffffffff8171b8f4
RDX: 0000000000000000 RSI: ffffffff8bfec3a0 RDI: ffffffff8bfec360
RBP: ffffc90000007c68 R08: ffffffff8f8638ef R09: 1ffffffff1f0c71d
R10: dffffc0000000000 R11: fffffbfff1f0c71e R12: 1ffff92000000f6c
R13: dffffc0000000000 R14: 0000000000000000 R15: ffffc90000007ba0
FS:  0000555559d06480(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c0000ab000 CR3: 000000004ddde000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 advance_sched+0xab/0xca0 net/sched/sch_taprio.c:924
 __run_hrtimer kernel/time/hrtimer.c:1692 [inline]
 __hrtimer_run_queues+0x595/0xd00 kernel/time/hrtimer.c:1756
 hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1818
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x107/0x3a0 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:finish_task_switch+0x1ea/0x870 kernel/sched/core.c:5284
Code: c9 50 e8 c9 cc 0b 00 48 83 c4 08 4c 89 f7 e8 1d 38 00 00 0f 1f 44 00 00 4c 89 f7 e8 b0 ec 13 0a e8 db 58 36 00 fb 48 8b 5d c0 <48> 8d bb f0 15 00 00 48 89 f8 48 c1 e8 03 49 be 00 00 00 00 00 fc
RSP: 0018:ffffc90004d9f608 EFLAGS: 00000286
RAX: 0cc8c24fa40d4e00 RBX: ffff88807b770000 RCX: ffffffff944ba603
RDX: dffffc0000000000 RSI: ffffffff8baac1e0 RDI: ffffffff8bfec3c0
RBP: ffffc90004d9f650 R08: ffffffff8f8638ef R09: 1ffffffff1f0c71d
R10: dffffc0000000000 R11: fffffbfff1f0c71e R12: 1ffff11017287e17
R13: dffffc0000000000 R14: ffff8880b943e340 R15: ffff8880b943f0b8
 context_switch kernel/sched/core.c:5413 [inline]
 __schedule+0x17db/0x4a20 kernel/sched/core.c:6737
 preempt_schedule_common+0x84/0xd0 kernel/sched/core.c:6916
 preempt_schedule+0xe1/0xf0 kernel/sched/core.c:6940
 preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk_64.S:12
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
 _raw_spin_unlock_irqrestore+0x130/0x140 kernel/locking/spinlock.c:194
 spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
 __wake_up_common_lock+0x18c/0x1e0 kernel/sched/wait.c:108
 pipe_write+0x128d/0x1a40 fs/pipe.c:602
 call_write_iter include/linux/fs.h:2108 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa84/0xcb0 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f1049e7cbef
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 b9 80 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 0c 81 02 00 48
RSP: 002b:00007ffd35cde690 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f1049e7cbef
RDX: 000000000000000c RSI: 00007ffd35cde780 RDI: 00000000000000f8
RBP: 00007ffd35cde71c R08: 0000000000000000 R09: 00007f104ab390b0
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000032
R13: 0000000000017c34 R14: 0000000000017c2c R15: 0000000000000004
 </TASK>


Tested on:

commit:         fe46a7dd Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12b491be980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2bf01fac005fe0a9
dashboard link: https://syzkaller.appspot.com/bug?extid=c4c6c3dc10cc96bcf723
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12de23c6980000


