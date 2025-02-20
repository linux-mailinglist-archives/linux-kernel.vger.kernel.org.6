Return-Path: <linux-kernel+bounces-522888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 916FCA3CFB5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 03:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 750E417DA71
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE181D8DE4;
	Thu, 20 Feb 2025 02:57:27 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01E613A3ED
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740020246; cv=none; b=TM6y6T7ApiE4rlJBd1TVZCgWF0EdckH0ZOGlJi9DOnmt8E1jJM0VcXbPiE0ikG927S0DxOZmp323BpMNMo23PqwMnA9rU3W25pLlFs3o3lkkOVHAbsNLVF6o1pdHEHdXJOGp2uA57BzWrpbG9ZFTjuFLcPK+d/PQnxe9IwfqCQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740020246; c=relaxed/simple;
	bh=vcKXY/WNWx+Khw8HySyRBQWEPDmi02wkn4sOLpUwXNs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cwa6NfFt0kOnZYPc3/qIv5kSzxIygY1LrDOjQDat2fAlGHZJB4yat1R66qk8O9twJ+LJSerVbI62Qp/pGtrFGrP7lVJQYG8DaHpab7wA3OD2/TNL18qI3ko/DBeLsb4r7WwF9gevIOQ9PTxhdzRU7VQYp/pVtS12fAX6oE5KJBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-8555eff9e0dso40677439f.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 18:57:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740020244; x=1740625044;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EyfAMlGMQjx5LN48ZpjdHRckeNLJPm5ErN4jk8qB4TI=;
        b=WWeneXzQBhezyLOna3fXNQZGl72hMrmqcJfDV3izNXxIn/KDth+PPAZV9KFCU+vb/G
         kck0V0G467aJlf49uoSmMTDSIUeAswvlidwxAUCRp9zf01iu/0rnmxMwdWBJlRBiGlXN
         iZqcFv07iB1tXyvKG05/nmUe+b0D8K/ZD5Y2clnPI+kIPIqVipqv2/jpqe7WMRetfuTf
         4Wj7OiaIuQ8M6WnGN6XsSOFplF9gW/F4BiDADyLiHSmet7l1oOH67R5EzJvFJNF91cA5
         TkLWAWUHqdUxE6XsdkH5hTruhzwHAt2s9VeiO/Rl9HkyUQRXe6iR9+uG8pl22gDSKDwH
         CBUg==
X-Forwarded-Encrypted: i=1; AJvYcCUHFjgD5d3ZlqHAFUJI4TBJX7HYskpNNIaA1KcCa3pOz3xU7WY0TfbbzeSwPGE7EbVblOvZ5Js5ma8ZWPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8eLa8p6sBunHckUbg3GT1rXJKMLZZgljw5YY0mom0j8r5JRom
	jJSTE/ymo1ZOZf9dkkuysjau4Q4xhwcA6fPnWAHxWVpuF6c/yvsX2huRAFe7M/uG6dWOraJ5fdu
	OrUX4V/Yfg/xc2ZyagXXkbGTZCoLcYjVzMXKsOFNDe1VuWl9QIx4OD0c=
X-Google-Smtp-Source: AGHT+IEm/tpciC90VM7o3nj8o2gTg1fi7q6x+kaQRDpSdVr5V3YYWNq8t1Y7Io2zf+rsrenPS5R5Zm7yqUQ2BrGuNCpPcGEjYBVy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0a:b0:3cf:bc71:94ef with SMTP id
 e9e14a558f8ab-3d28092c1a7mr169695305ab.17.1740020243784; Wed, 19 Feb 2025
 18:57:23 -0800 (PST)
Date: Wed, 19 Feb 2025 18:57:23 -0800
In-Reply-To: <000000000000733bf2061ba58c4d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b69a13.050a0220.14d86d.0155.GAE@google.com>
Subject: Re: [syzbot] [kernel?] INFO: rcu detected stall in sys_futex (7)
From: syzbot <syzbot+b66b5182718939fec09b@syzkaller.appspotmail.com>
To: andrealmeid@igalia.com, dave@stgolabs.net, dvhart@infradead.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    6537cfb395f3 Merge tag 'sound-6.14-rc4' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17365ae4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4f6914bcba459be
dashboard link: https://syzkaller.appspot.com/bug?extid=b66b5182718939fec09b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b65ae4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/699131ad8762/disk-6537cfb3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/70eae7bb5752/vmlinux-6537cfb3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b2de8da174e5/bzImage-6537cfb3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b66b5182718939fec09b@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	1-...!: (0 ticks this GP) idle=e2cc/1/0x4000000000000000 softirq=15501/15501 fqs=0
rcu: 	(detected by 0, t=10505 jiffies, g=7317, q=400 ncpus=2)
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 6093 Comm: syz.2.21 Not tainted 6.14.0-rc3-syzkaller-00060-g6537cfb395f3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
RIP: 0010:__lock_acquire+0xaa7/0x3c40 kernel/locking/lockdep.c:5211
Code: 48 83 fb ff 0f 85 03 0a 00 00 c7 84 24 84 00 00 00 01 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 fa 48 c1 ea 03 80 3c 02 00 <0f> 85 c8 28 00 00 48 8b 54 24 30 49 89 1f 48 b8 00 00 00 00 00 fc
RSP: 0018:ffffc90000a18af0 EFLAGS: 00000046
RAX: dffffc0000000000 RBX: fb268dbe5ff7dd64 RCX: ffffffff81966d32
RDX: 1ffff1100619c163 RSI: 0000000000000008 RDI: ffffffff96ec2cc0
RBP: 0000000000000040 R08: 0000000000000000 R09: fffffbfff2dd8598
R10: ffffffff96ec2cc7 R11: 0000000000000001 R12: ffffed100619c15d
R13: ffff888030ce0000 R14: 0000000000000002 R15: ffff888030ce0b18
FS:  00007fe83a63f6c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000400000000600 CR3: 0000000079236000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5851
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
 debug_object_deactivate+0x13b/0x370 lib/debugobjects.c:873
 debug_hrtimer_deactivate kernel/time/hrtimer.c:460 [inline]
 debug_deactivate kernel/time/hrtimer.c:502 [inline]
 __run_hrtimer kernel/time/hrtimer.c:1769 [inline]
 __hrtimer_run_queues+0x47c/0xae0 kernel/time/hrtimer.c:1865
 hrtimer_interrupt+0x392/0x8e0 kernel/time/hrtimer.c:1927
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1038 [inline]
 __sysvec_apic_timer_interrupt+0x10f/0x400 arch/x86/kernel/apic/apic.c:1055
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0x9f/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x31/0x80 kernel/locking/spinlock.c:194
Code: f5 53 48 8b 74 24 10 48 89 fb 48 83 c7 18 e8 a6 f9 3c f6 48 89 df e8 fe 78 3d f6 f7 c5 00 02 00 00 75 23 9c 58 f6 c4 02 75 37 <bf> 01 00 00 00 e8 85 4f 2e f6 65 8b 05 a6 33 aa 74 85 c0 74 16 5b
RSP: 0018:ffffc90003097b88 EFLAGS: 00000246
RAX: 0000000000000002 RBX: ffff88802d0fd290 RCX: 1ffffffff20c4171
RDX: 0000000000000000 RSI: ffffffff8b6ceca0 RDI: ffffffff8bd35480
RBP: 0000000000000283 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff90624f17 R11: 0000000000000002 R12: ffff88802d0fc894
R13: ffff88802d0fd290 R14: ffff88802d0fc880 R15: ffffc90003097be8
 class_raw_spinlock_irqsave_destructor include/linux/spinlock.h:551 [inline]
 try_to_wake_up+0x949/0x1490 kernel/sched/core.c:4214
 wake_up_process kernel/sched/core.c:4463 [inline]
 wake_up_q+0x9c/0x160 kernel/sched/core.c:1075
 futex_wake+0x43e/0x4e0 kernel/futex/waitwake.c:199
 do_futex+0x1e5/0x350 kernel/futex/syscalls.c:107
 __do_sys_futex kernel/futex/syscalls.c:179 [inline]
 __se_sys_futex kernel/futex/syscalls.c:160 [inline]
 __x64_sys_futex+0x1e1/0x4c0 kernel/futex/syscalls.c:160
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe83978cde9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe83a63f0e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 00007fe8399a5fa8 RCX: 00007fe83978cde9
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00007fe8399a5fac
RBP: 00007fe8399a5fa0 R08: 00007fe83a640000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe8399a5fac
R13: 0000000000000000 R14: 00007ffd885fcba0 R15: 00007ffd885fcc88
 </TASK>
rcu: rcu_preempt kthread timer wakeup didn't happen for 10504 jiffies! g7317 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
rcu: 	Possible timer handling issue on cpu=1 timer-softirq=3496
rcu: rcu_preempt kthread starved for 10505 jiffies! g7317 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:I stack:27456 pid:17    tgid:17    ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0xf43/0x5890 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6857
 schedule_timeout+0x124/0x280 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x1eb/0xb00 kernel/rcu/tree.c:2024
 rcu_gp_kthread+0x271/0x380 kernel/rcu/tree.c:2226
 kthread+0x3af/0x750 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

