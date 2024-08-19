Return-Path: <linux-kernel+bounces-291753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F04956662
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E10A1C217F1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832B715B98D;
	Mon, 19 Aug 2024 09:10:31 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7EB148FE0
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058630; cv=none; b=OzNCbU/ncaeAwNVUlfPRjxHv00BWvYMXs5pGU+BgM1YZgTLmJ0HxdxlX4gFVgJsSzrUqcuRyWf3ha4mwiz8Pl1U7OJDaMnLA9Yw7qGeBva0BEA3bEPpvX/hp6r6S3QlyuH0Sk2jbEw0vPtuLQ7+jIiUbVBF23QmFmarzEtc5e9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058630; c=relaxed/simple;
	bh=nEj/YFIGm8eK+dTa7ygvoKczPSn9mI5BN100Qe5qm2Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=npqVb0l3zSd5o0lwYeTPBfgAJDjDDaV5/HbYw1P1coE/vM6TFcYt9BQYDBgk6Xy5jZtKmQIcgUgbjir59K24uC7P6s5nOH0UHSvRxL80OZ6NCuszog2420nj+VaX/b6NugU0SXwqmbFrCUnP+18JYSCMcTIWCA1SZrid/ydf/eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f99189f5fso434411739f.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 02:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724058628; x=1724663428;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1vpVlGc58WFW+ZQEvE1fLbpOOn/glAJvhg8siNWvHro=;
        b=m4AKoubqrupeNu7C76JK1wE1xx/mZYGPRivsr8+09bTaBS9AkOElevkx+tgW04ore5
         JTCiYCLv2Ysoi9NY8nbqbn/xJKCgdWdergUAcvK+RvTL3YdVCSRNVESftAXHrT8p2oQP
         SOzC/pS9Vvdc8wd+HMaUGspcGDGvB1KLEDT5nyXLKmvSCS9dcnOG7mLQ4U0otIUilicO
         +IhgizydM1LQmCdHUf0y1y5rU41M81W8auiSXisuVr6Tfk7NHohvYvXiA1Xx4jegr8AV
         mQGkr864hPsTyWC64sNn1l1ON3ZiTUXQGvmBOmdY5YNO/Lj71KdSwnb5mP22QPr29b3U
         rVcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbgr3bXACxBz98ZOuWXSWHFdqjB1LsjxM7sux3DwsbZco/tjj0YAvyPRAg5uuqNYKQm0xWi98lCb2o1/WWDMJPSVWpsOFlSRJtOjwW
X-Gm-Message-State: AOJu0YzIAJQ1psMb6LwfRG2PJGf1EisX2k8+yLX3ZfM8kO20oURB7blS
	QKv4IiCj9WXQtr8lCAQFroKWS9F4/QV7hCydvE7VgRSCHejWzxNNUasRybP2IBGO/5s2Uo5My5L
	cA5n1vMIfSt5Sbqysk4mbcfanxMJv+1jdMoCmoWaIwCY2LRWF6nKRiCE=
X-Google-Smtp-Source: AGHT+IEDUCF6Bu8jtizjXxoWuOJbglWYNw3x3Mn1MpFYS+TC3U6Zb/Lg8WN9LN2Tea7OCApR/nydyI6OqpV8LgedG3svMNuvQrLN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1989:b0:39d:1236:a9c0 with SMTP id
 e9e14a558f8ab-39d26cdfe29mr8146445ab.1.1724058628315; Mon, 19 Aug 2024
 02:10:28 -0700 (PDT)
Date: Mon, 19 Aug 2024 02:10:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001d12d4062005aea1@google.com>
Subject: [syzbot] [mm?] INFO: rcu detected stall in do_vmi_munmap (2)
From: syzbot <syzbot+036af2f0c7338a33b0cd@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e5fa841af679 Merge tag 'pull-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14f87d83980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=92c0312151c4e32e
dashboard link: https://syzkaller.appspot.com/bug?extid=036af2f0c7338a33b0cd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ff935f32a733/disk-e5fa841a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0ae3bccf47f7/vmlinux-e5fa841a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5a480809c9ec/bzImage-e5fa841a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+036af2f0c7338a33b0cd@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P17446/1:b..l
rcu: 	(detected by 1, t=10502 jiffies, g=99157, q=379 ncpus=2)
task:modprobe        state:R  running task     stack:24784 pid:17446 tgid:17446 ppid:7127   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x17ae/0x4a10 kernel/sched/core.c:6529
 preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:6851
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:check_kcov_mode kernel/kcov.c:193 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x37/0x70 kernel/kcov.c:216
Code: 00 d7 03 00 65 8b 15 90 4c 70 7e 81 e2 00 01 ff 00 74 11 81 fa 00 01 00 00 75 35 83 b9 1c 16 00 00 00 74 2c 8b 91 f8 15 00 00 <83> fa 02 75 21 48 8b 91 00 16 00 00 48 8b 32 48 8d 7e 01 8b 89 fc
RSP: 0018:ffffc9001789f2b8 EFLAGS: 00000246
RAX: ffffffff8ba3ad11 RBX: 0000000000000001 RCX: ffff88806d760000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000004
RBP: ffffc9001789f4b0 R08: ffffffff8ba3ad02 R09: ffffffff8ba3ac4c
R10: 0000000000000003 R11: ffff88806d760000 R12: ffffc9001789f428
R13: 0000000000000001 R14: ffff888063baba00 R15: ffff888063baba08
 mas_data_end lib/maple_tree.c:1453 [inline]
 mt_validate+0x511/0x4aa0 lib/maple_tree.c:7583
 validate_mm+0xe7/0x530 mm/mmap.c:329
 __split_vma+0xa69/0xc30 mm/mmap.c:2511
 do_vmi_align_munmap+0x388/0x18c0 mm/mmap.c:2663
 do_vmi_munmap+0x261/0x2f0 mm/mmap.c:2830
 mmap_region+0x72f/0x2090 mm/mmap.c:2881
 do_mmap+0x8f9/0x1010 mm/mmap.c:1468
 vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:588
 ksys_mmap_pgoff+0x4f1/0x720 mm/mmap.c:1514
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f176367bb74
RSP: 002b:00007ffec4ffdad8 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007ffec4ffdb18 RCX: 00007f176367bb74
RDX: 0000000000000005 RSI: 0000000000123000 RDI: 00007f176340b000
RBP: 00007ffec4ffe270 R08: 0000000000000000 R09: 0000000000028000
R10: 0000000000000812 R11: 0000000000000246 R12: 00007f17636575c0
R13: 00007ffec4ffe2f8 R14: 0000000000027f38 R15: 0000000000000000
 </TASK>
rcu: rcu_preempt kthread starved for 10447 jiffies! g99157 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:26448 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x17ae/0x4a10 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_timeout+0x1be/0x310 kernel/time/timer.c:2581
 rcu_gp_fqs_loop+0x2df/0x1330 kernel/rcu/tree.c:2034
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:2236
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.11.0-rc3-syzkaller-00279-ge5fa841af679 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:92 [inline]
RIP: 0010:acpi_safe_halt+0x21/0x30 drivers/acpi/processor_idle.c:112
Code: 90 90 90 90 90 90 90 90 90 65 48 8b 04 25 00 d7 03 00 48 f7 00 08 00 00 00 75 10 66 90 0f 00 2d 95 07 9b 00 f3 0f 1e fa fb f4 <fa> c3 cc cc cc cc 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
RSP: 0018:ffffc900001a7d08 EFLAGS: 00000246
RAX: ffff888017af0000 RBX: ffff88801b6ee064 RCX: 0000000007bf5161
RDX: 0000000000000001 RSI: ffff88801b6ee000 RDI: ffff88801b6ee064
RBP: 000000000003a678 R08: ffff8880b9337c7b R09: 1ffff11017266f8f
R10: dffffc0000000000 R11: ffffffff8bae3ce0 R12: ffff88801836f800
R13: 0000000000000000 R14: 0000000000000001 R15: ffffffff8eecad60
FS:  0000000000000000(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f45db1b035b CR3: 00000000634fc000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 </IRQ>
 <TASK>
 acpi_idle_enter+0xe4/0x140 drivers/acpi/processor_idle.c:702
 cpuidle_enter_state+0x112/0x480 drivers/cpuidle/cpuidle.c:267
 cpuidle_enter+0x5d/0xa0 drivers/cpuidle/cpuidle.c:388
 call_cpuidle kernel/sched/idle.c:155 [inline]
 cpuidle_idle_call kernel/sched/idle.c:230 [inline]
 do_idle+0x375/0x5d0 kernel/sched/idle.c:326
 cpu_startup_entry+0x42/0x60 kernel/sched/idle.c:424
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

