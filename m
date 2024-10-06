Return-Path: <linux-kernel+bounces-352589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E43DC992120
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 22:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BC2EB21270
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 20:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358F018B49F;
	Sun,  6 Oct 2024 20:29:24 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205FB3A8F0
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 20:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728246563; cv=none; b=CKfymGVT75dQTpEFJTs24iqXUxJdi7DPJCmiT3i9dx/5IpDU0Ot5IvVmLkcIo7r4lRJNjWgou3jgh52S3JCpzqPnhB8QdIG8Hd94Y81bRBsdl8t9hWGUU7apn37bsD/7DvfwC8GW/DpKOULNag3qI/EFouX6fk8Jqqp4TnKdnyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728246563; c=relaxed/simple;
	bh=iYfwJstBaVu5MTqnq9X5NFMNs2X86vai3ZG2KmwCRj0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qIAiKePJ5P25MOBO+CCCHruwb0qcm2nELwd2boJVB+V8NPxU2BwDu2n4ZKAmuLGPySs/LyuY2gyu8kwAybNu/oCeBwqIWZdhGTV4U1xeO3GKfG2aTO5SjL6UG1geSiQgczCw7Xn60Oouzmj6BuSR81hFjGP8SIhhtuqd+fGFnRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a1a969fabfso49386395ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 13:29:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728246561; x=1728851361;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7CleT7+sNlz+JT2qm4E26adZvKV7aCEN7kRiObhKhaA=;
        b=dkQ35jpcDBiuAXK6h7RQnVJr9uF0HBIgy1cbAhJUb0a6Wan9eEwDchWYvOPwOfvNej
         zW2ztdN0EXQ4oKN6Uob3gvYNVW2sKJWqIV91MCg3rgtQBP81nlBiMgxFIDABF4++neJO
         retnmtMlfV9ufzCoEf4ygSL2i0qxJ5F6SDJ4TxYyFyRLD2dRxWc9AxKSdqANftBS9c3Q
         hLsnQCoJdKwZHAXPBaCq+ohk+Ai5rDB0O5rmy11NJR3UXADYDN2Pf47Cl46BPLUupHd7
         IxFShdkvrab3J7IOmsHNPcESoCPgWm4U6pCbv5jX4m74jpPFGcqiAEj29fUn3XjoF/a9
         TmbQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5DMcUu67iBvSarA95aYHmc9Z7cBsV6E6IJI7it9e8rXzBfJtINoGQovWibQWqyr9XCTVKNi7NNp5az/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNlw/PqTDqfTfJnb5za9Ga/bsFz0LLX8D6dABdl/o4Z+bC5zO4
	vnU92Jziq7fDN0uHxwxFUYQuzAtq4cuqkqAgJVhw+KWGbJLhsU5bn6g4mgN4D5W7A7l1mdAbySz
	cvZfI21SfLFBEs30Hled2tRtBSPZyz4y/Ri8mQufzRQaUa6pyTJEWLlo=
X-Google-Smtp-Source: AGHT+IF4i4b8/3f2LFyDUymacx9KOWwPSyM3kKwHDoZB/O4Ytr7hm4su/P4nKq1tZ6KT12vS8CZuVyObogeUIVA7Xja1PWqBW21/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1447:b0:39f:5efe:ae73 with SMTP id
 e9e14a558f8ab-3a375978e7bmr79657355ab.5.1728246561280; Sun, 06 Oct 2024
 13:29:21 -0700 (PDT)
Date: Sun, 06 Oct 2024 13:29:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6702f321.050a0220.49194.04e3.GAE@google.com>
Subject: [syzbot] [mm?] [usb?] INFO: rcu detected stall in kswapd (3)
From: syzbot <syzbot+bcc7fa5044343fc35941@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e32cde8d2bd7 Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1460a3d0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=286b31f2cf1c36b5
dashboard link: https://syzkaller.appspot.com/bug?extid=bcc7fa5044343fc35941
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1570339f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1260a3d0580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-e32cde8d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9c681f5609bc/vmlinux-e32cde8d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/00b4d54de1d9/bzImage-e32cde8d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bcc7fa5044343fc35941@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-0): P76/1:b..l
rcu: 	(detected by 0, t=10502 jiffies, g=21325, q=180 ncpus=1)
task:kswapd0         state:R  running task     stack:21424 pid:76    tgid:76    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:6997
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lru_gen_shrink_node mm/vmscan.c:4957 [inline]
RIP: 0010:shrink_node+0x36c0/0x3de0 mm/vmscan.c:5937
Code: 49 8d 9c 24 c8 f9 ff ff 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 80 3c 08 00 74 08 48 89 df e8 03 6e 26 00 4c 8b 2b <49> 8d 84 24 10 fa ff ff 48 89 44 24 38 4c 89 ef e8 fb 88 fe ff 84
RSP: 0018:ffffc90000e477a0 EFLAGS: 00000246
RAX: 1ffff11002624000 RBX: ffff888013120000 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000002
RBP: ffffc90000e47a50 R08: ffffffff81d81eb7 R09: 1ffffffff2858b00
R10: dffffc0000000000 R11: fffffbfff2858b01 R12: ffff888013120638
R13: ffff88804fab4000 R14: 0000000000000002 R15: 0000000000000000
 kswapd_shrink_node mm/vmscan.c:6765 [inline]
 balance_pgdat mm/vmscan.c:6957 [inline]
 kswapd+0x1ca3/0x3700 mm/vmscan.c:7226
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: rcu_preempt kthread timer wakeup didn't happen for 10499 jiffies! g21325 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
rcu: 	Possible timer handling issue on cpu=0 timer-softirq=12782
rcu: rcu_preempt kthread starved for 10500 jiffies! g21325 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:I stack:26352 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_timeout+0x1be/0x310 kernel/time/timer.c:2615
 rcu_gp_fqs_loop+0x2df/0x1330 kernel/rcu/tree.c:2045
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:2247
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 0 UID: 0 PID: 5313 Comm: syz-executor407 Not tainted 6.12.0-rc1-syzkaller-00031-ge32cde8d2bd7 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:xas_store+0xf9/0x1890 lib/xarray.c:847
Code: 83 e6 03 31 ff e8 07 6e d4 f5 48 89 d8 48 83 e0 03 74 1d e8 19 69 d4 f5 48 8b 44 24 60 48 83 c4 78 5b 41 5c 41 5d 41 5e 41 5f <5d> c3 cc cc cc cc 48 89 df 48 85 db 48 89 5c 24 10 0f 84 af 00 00
RSP: 0018:ffffc9000b4e78f0 EFLAGS: 00000282
RAX: 0000000000000000 RBX: 1ffff9200169cf27 RCX: ffff88803c872440
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 1ffff9200169cf27 R08: ffffffff8bc07289 R09: 0000000000000000
R10: ffffc9000b4e7940 R11: fffff5200169cf2b R12: dffffc0000000000
R13: 1ffff9200169cf20 R14: ffffc9000b4e7920 R15: ffffc9000b4e7938
FS:  00007f32942b66c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f329436f363 CR3: 000000001e2ca000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 </IRQ>
 <TASK>
 __xa_erase+0x135/0x220 lib/xarray.c:1511
 sock_devmem_dontneed+0x37b/0x740 net/core/sock.c:1089
 sk_setsockopt+0x73c/0x33b0 net/core/sock.c:1280
 do_sock_setsockopt+0x2fb/0x720 net/socket.c:2325
 __sys_setsockopt+0x1a2/0x250 net/socket.c:2352
 __do_sys_setsockopt net/socket.c:2361 [inline]
 __se_sys_setsockopt net/socket.c:2358 [inline]
 __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2358
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f329430cf69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 1f 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f32942b6238 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00007f32943941a8 RCX: 00007f329430cf69
RDX: 0000000000000050 RSI: 0000000000000001 RDI: 0000000000000003
RBP: 00007f32943941a0 R08: 0000000000000010 R09: 00007f32942b66c0
R10: 0000000020000000 R11: 0000000000000246 R12: 00007f32943941ac
R13: 0000000000000016 R14: 00007ffc9990f2c0 R15: 00007ffc9990f3a8
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

