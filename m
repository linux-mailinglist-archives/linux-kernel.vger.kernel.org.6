Return-Path: <linux-kernel+bounces-437051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4704C9E8E78
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7CA21634C8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A83215F64;
	Mon,  9 Dec 2024 09:12:29 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BB221571D
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 09:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733735548; cv=none; b=fgtb4R87A0oRMXhuBwbwsmiEtM7FM20IgaNykmRnlCjVVusQI+c/PaLjimkIDA4Ybt1AuGRq30nEMxnYAvNTYI9XCNyvDrFjyPcvPm2Gpq5cH6l+ky85KC9iAL9vGL8XiGQKpkP1eH0u8o4VRR76mM2Xt49eceFDzujsA/+25YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733735548; c=relaxed/simple;
	bh=TM16huw6Qd6qQ1RdtsGnJ8kuukONuhYkdDdCvuHKuYI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Df0yG78u96HaNu8oGZ2DrPMC8XWkZkCQvcDGgFV5akr06+YHforLXQDR3YR8cwgZKBxf6/S+qwRsC6A7sSaXr+y5o3ibLk2mZWt1ku0CefPSu9n5NN5D1HQl48nWmhXsx4LqKYR6kB7rJY2kCdaeUicULuudZRnkBU1XVtnpebM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3a819a4e83dso26209755ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 01:12:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733735546; x=1734340346;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h7LioKTWVgTKETx0+Zi5Iohvh/vJw/MK4uUBuVHxvbY=;
        b=C/AzhGjkIErjvAe0ZS069rtUzbn+aB107ZIOXjToAaEzw1jbKrqGr9Imrcy7YquC4e
         TWY5na+1hN9XX6TNPD/gZiHLWkMmcbyRidwl8jtNj0DUpplq2G2RXKPnMtjX9oencEeD
         GrJCGf2gjKBcJSo9YgGk+IEfLXu7IF23rWaQ1X7oC9C52R2sgUEX7WN3IuCbEHVE3x4c
         bTHZkJmpt0bGIKYm1RmA38aG+AAZm4DUM2qQ4Z40x9q3Gtzl9PDPXSqE9d0r37/EONVB
         FSxzelBOJe0+SU+EkL/9mOf1xIxOyppVDe8NWHO2pmAjvbGFktdUchJdTgzI+9wbo3Ix
         fpmw==
X-Forwarded-Encrypted: i=1; AJvYcCUTFIsGJ0TQkMXns6Yj9q7/zV8NqlSKAQrhKo1p/1zj8vVvITAKnzA4Jhm1+GjLVRUwZY3OmSUfUcb0yjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjyqvHV6LCj5VQBakQaTyCTnpdc9LZid5uyXu2Y9B3CP/G/ffT
	tRrzeoNalnbjGIwhFGX58NpNdLovq2GapNi0Sr5hVB46J8eT1vokRvTbZ58vEGVaGPAOkw6CWn4
	6tAAM3NaS3Du3Xlclt+A5pkxSxN2c/RrsO2iX/UOLFvFZtJtISnD7T2U=
X-Google-Smtp-Source: AGHT+IEMQcMYvJ7a+QpVC8PlUAKj2T7EbLI9dOAjqjNJWhRUw9hRBm9qMkC1Gl1d+A7J9KwvhC6jQaBPVt8CFXPR7KXtZLDJi5Ke
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c05:b0:3a7:e539:c272 with SMTP id
 e9e14a558f8ab-3a811e4d0efmr136484515ab.23.1733735545908; Mon, 09 Dec 2024
 01:12:25 -0800 (PST)
Date: Mon, 09 Dec 2024 01:12:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6756b479.050a0220.a30f1.0196.GAE@google.com>
Subject: [syzbot] [mm?] INFO: rcu detected stall in mas_preallocate (2)
From: syzbot <syzbot+882589c97d51a9de68eb@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, jannh@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    feffde684ac2 Merge tag 'for-6.13-rc1-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10b08020580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
dashboard link: https://syzkaller.appspot.com/bug?extid=882589c97d51a9de68eb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e8a8df980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3bb09093023b/disk-feffde68.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9e37e48dc48a/vmlinux-feffde68.xz
kernel image: https://storage.googleapis.com/syzbot-assets/36b46b3a6421/bzImage-feffde68.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+882589c97d51a9de68eb@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	(detected by 0, t=17825 jiffies, g=10505, q=929 ncpus=2)
rcu: All QSes seen, last rcu_preempt kthread activity 11791 (4294964533-4294952742), jiffies_till_next_fqs=1, root ->qsmask 0x0
rcu: rcu_preempt kthread starved for 11791 jiffies! g10505 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:25784 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x1850/0x4c30 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6848
 schedule_timeout+0x15a/0x290 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x2df/0x1330 kernel/rcu/tree.c:2045
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:2247
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 6002 Comm: syz-executor Not tainted 6.13.0-rc1-syzkaller-00025-gfeffde684ac2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:__sanitizer_cov_trace_cmp8+0x0/0x90 kernel/kcov.c:293
Code: 10 48 89 74 0a 18 4c 89 44 0a 20 c3 cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 4c 8b 04 24 65 48 8b 0c 25 00 d6 03 00 65 8b 05 70 61
RSP: 0018:ffffc90000a18c98 EFLAGS: 00000046
RAX: ffffffff8bcbfbf7 RBX: ffff88805d8d6340 RCX: ffff88803141bc00
RDX: 0000000000010000 RSI: ffff88805d8d6340 RDI: ffff88805d8d6340
RBP: 1ffff1100bb1ac68 R08: ffffffff818d04c0 R09: 1ffffffff20328be
R10: dffffc0000000000 R11: fffffbfff20328bf R12: ffff8880b872c9d0
R13: ffff8880b872c9d0 R14: ffff88805d8d6340 R15: ffff88805d8d6340
FS:  000055557e00b500(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f29e4db6bd0 CR3: 00000000622f2000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 timerqueue_add+0x4b/0x290 lib/timerqueue.c:38
 enqueue_hrtimer+0x1b2/0x3c0 kernel/time/hrtimer.c:1084
 __run_hrtimer kernel/time/hrtimer.c:1756 [inline]
 __hrtimer_run_queues+0x6cb/0xd30 kernel/time/hrtimer.c:1803
 hrtimer_interrupt+0x403/0xa40 kernel/time/hrtimer.c:1865
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1038 [inline]
 __sysvec_apic_timer_interrupt+0x110/0x420 arch/x86/kernel/apic/apic.c:1055
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:mas_wr_store_type+0x2a/0x16c0 lib/maple_tree.c:4212
Code: 55 41 57 41 56 41 55 41 54 53 48 81 ec c8 00 00 00 49 89 fe 49 bc 00 00 00 00 00 fc ff df e8 ad 78 d8 f5 4c 89 f0 48 c1 e8 03 <48> 89 84 24 80 00 00 00 42 80 3c 20 00 74 08 4c 89 f7 e8 5f 60 43
RSP: 0018:ffffc900031174c0 EFLAGS: 00000a02
RAX: 1ffff92000622ec4 RBX: 0000000000000000 RCX: ffff88803141bc00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc90003117620
RBP: ffffc900031176f0 R08: ffffffff8bc6b87c R09: ffffffff8bc761f0
R10: 0000000000000005 R11: ffff88803141bc00 R12: dffffc0000000000
R13: ffffc90003117620 R14: ffffc90003117620 R15: dffffc0000000000
 mas_preallocate+0x27d/0x8d0 lib/maple_tree.c:5540
 vma_iter_prealloc mm/vma.h:349 [inline]
 __mmap_new_vma mm/vma.c:2349 [inline]
 __mmap_region+0x1b89/0x2cd0 mm/vma.c:2456
 mmap_region+0x1d0/0x2c0 mm/mmap.c:1347
 do_mmap+0x8f0/0x1000 mm/mmap.c:496
 vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:580
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa71757ff53
Code: f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 41 89 ca 41 f7 c1 ff 0f 00 00 75 14 b8 09 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 25 c3 0f 1f 40 00 48 c7 c0 a8 ff ff ff 64 c7
RSP: 002b:00007ffedb7e9bc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: fffffffffffff000 RCX: 00007fa71757ff53
RDX: 0000000000000000 RSI: 0000000000801000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 00000000ffffffff R09: 0000000000000000
R10: 0000000000020022 R11: 0000000000000246 R12: 00007ffedb7e9c30
R13: ffffffffffffffc0 R14: 0000000000001000 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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

