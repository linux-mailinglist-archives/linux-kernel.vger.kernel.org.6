Return-Path: <linux-kernel+bounces-176843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 868248C35D7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 11:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF19F1F2145F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 09:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D213E1BF47;
	Sun, 12 May 2024 09:19:31 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A724F14F98
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 09:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715505571; cv=none; b=DqZP/yKYPAePBmcDbuMqXMUwaUtR6kiUojT0LSmer0y0SssXlSRx5cUEQy6c0ZWKKxrBuTFnLvikwDV06jpRLOH/05skalitQ8LV87LOQjP7jKmwuThs7Wsfl2lo7lQWOm9XnYXvp1mzuIj5W9Ci1woZsLWJaye2w9LmTD698Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715505571; c=relaxed/simple;
	bh=QO91RSnrSXaAqxAIRTPHoz5o/hE/g+e7owD74VtKY5s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=evBr6DxssQANxWON5Wd/noPJAsBXLGQlMj9/a35SoPSGNUiznwECP5AgScYwv+cd/epu2iuTpugdVI0/qnUcstZLVU2uj6X8ExxqqI7tCdHlhZs8JA3nISaTNEhnGkR4Y7NUvZD928PLzanoLKnP6dReOakiNNnHcWDpLlTmqbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7ddf08e17e4so293011739f.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 02:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715505569; x=1716110369;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jroFDH8JKMEtXPxybPME7NsU4uCcfXlDldXJgcos6kE=;
        b=AyYjTHM+GNc/Escnj4Ng+UeFbhUzOCu2xfiHH4P6rZ6U9so6KYLPzK0rt+Z9G/4ZKa
         3RKGiRWfi+j09VGyIKcbc7RDbpdCMPHfk0wZw1kJC+LhLBaizCwUEP4l0BEa3sqpIknb
         WNYGHMA2RvJQ7vv6894BHSWwQ0ygbckToGCbYldfyyCPdEfvvJtWuG5xdCTUkXWRbOP5
         OIilWoItQocBN/KUfJKP5JZpdhvu/r5Dv/VkttAX6UaCFr56SydrSm06K6dPLZaEzjIt
         8A/jx6Up5/y51j7KYkT2xShtXrPUgXe0PLFRMfbWrmDi7U/PivYZB2vyRfP6+7YNPL5q
         XAxw==
X-Forwarded-Encrypted: i=1; AJvYcCW9ASY8d9MBk5slg6oXFp2SRTt4fhmPLQNag86Dz3sQFuhSw61OpiBoy7BcgIUGhNtfxZkMO/ESu9YECSCPM0OaVRovumEl97b29Zl6
X-Gm-Message-State: AOJu0Yyww43Sf5oebB3Xts63M0Djl8LSYgP2an1obwyWXuID3Ee/jlvG
	iCcgXo2U7xwIjiIsZlNVPskcbq2nF8vCnTaxmYoE7PBiUqOjx89+K2Xjh8WTc3fMJnwd9CDIWq9
	n6FYxHStXkc7uUL1yXGh2S+E+dQSo2VNAc9WkXQUgDI3KWGRclNpfKFA=
X-Google-Smtp-Source: AGHT+IGhmC8U+grV1HiuET0iHrwpFXRzmgba1iNyXryV4GYmVKD2HJ/p7bKZXDP+PYcZ0fOXEEo1KEBObKgMNnSXdlt5LJtXWR3S
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:35aa:b0:488:6017:abb6 with SMTP id
 8926c6da1cb9f-48955bbbacdmr729072173.2.1715505568809; Sun, 12 May 2024
 02:19:28 -0700 (PDT)
Date: Sun, 12 May 2024 02:19:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000a13ee06183e4464@google.com>
Subject: [syzbot] [mm?] INFO: rcu detected stall in validate_mm (3)
From: syzbot <syzbot+a941018a091f1a1f9546@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lstoakes@gmail.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    dccb07f2914c Merge tag 'for-6.9-rc7-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13f6734c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7144b4fe7fbf5900
dashboard link: https://syzkaller.appspot.com/bug?extid=a941018a091f1a1f9546
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10306760980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=138c8970980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e1fea5a49470/disk-dccb07f2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5f7d53577fef/vmlinux-dccb07f2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/430b18473a18/bzImage-dccb07f2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a941018a091f1a1f9546@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P17678/1:b..l
rcu: 	(detected by 1, t=10502 jiffies, g=36541, q=38 ncpus=2)
task:syz-executor952 state:R  running task     stack:28968 pid:17678 tgid:17678 ppid:5114   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0xf15/0x5d00 kernel/sched/core.c:6746
 preempt_schedule_irq+0x51/0x90 kernel/sched/core.c:7068
 irqentry_exit+0x36/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:88 [inline]
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:122 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:129 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:161 [inline]
RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
RIP: 0010:kasan_check_range+0xc7/0x1a0 mm/kasan/generic.c:189
Code: 83 c0 08 48 39 d0 0f 84 be 00 00 00 48 83 38 00 74 ed 48 8d 50 08 eb 0d 48 83 c0 01 48 39 c2 0f 84 8d 00 00 00 80 38 00 74 ee <48> 89 c2 b8 01 00 00 00 48 85 d2 74 1e 41 83 e2 07 49 39 d1 75 0a
RSP: 0018:ffffc900031ef850 EFLAGS: 00000202
RAX: fffffbfff2949b78 RBX: fffffbfff2949b79 RCX: ffffffff8ac92249
RDX: fffffbfff2949b79 RSI: 0000000000000004 RDI: ffffffff94a4dbc0
RBP: fffffbfff2949b78 R08: 0000000000000001 R09: fffffbfff2949b78
R10: ffffffff94a4dbc3 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000000300 R15: 0000000000000000
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_inc include/linux/atomic/atomic-instrumented.h:435 [inline]
 mt_validate_nulls+0x5e9/0x9e0 lib/maple_tree.c:7550
 mt_validate+0x3148/0x4390 lib/maple_tree.c:7599
 validate_mm+0x9c/0x4b0 mm/mmap.c:288
 mmap_region+0x1478/0x2760 mm/mmap.c:2934
 do_mmap+0x8ae/0xf10 mm/mmap.c:1385
 vm_mmap_pgoff+0x1ab/0x3c0 mm/util.c:573
 ksys_mmap_pgoff+0x7d/0x5b0 mm/mmap.c:1431
 __do_sys_mmap arch/x86/kernel/sys_x86_64.c:86 [inline]
 __se_sys_mmap arch/x86/kernel/sys_x86_64.c:79 [inline]
 __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:79
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f305228c143
RSP: 002b:00007ffdd7b4fc18 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: fffffffffffff000 RCX: 00007f305228c143
RDX: 0000000000000000 RSI: 0000000000021000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 00000000ffffffff R09: 0000000000000000
R10: 0000000000020022 R11: 0000000000000246 R12: 00007ffdd7b4fe70
R13: ffffffffffffffc0 R14: 0000000000001000 R15: 0000000000000000
 </TASK>
rcu: rcu_preempt kthread starved for 10533 jiffies! g36541 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:28736 pid:16    tgid:16    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0xf15/0x5d00 kernel/sched/core.c:6746
 __schedule_loop kernel/sched/core.c:6823 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6838
 schedule_timeout+0x136/0x2a0 kernel/time/timer.c:2582
 rcu_gp_fqs_loop+0x1eb/0xb00 kernel/rcu/tree.c:1663
 rcu_gp_kthread+0x271/0x380 kernel/rcu/tree.c:1862
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 1 PID: 17676 Comm: syz-executor952 Not tainted 6.9.0-rc7-syzkaller-00012-gdccb07f2914c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:__raw_spin_unlock_irq include/linux/spinlock_api_smp.h:160 [inline]
RIP: 0010:_raw_spin_unlock_irq+0x29/0x50 kernel/locking/spinlock.c:202
Code: 90 f3 0f 1e fa 53 48 8b 74 24 08 48 89 fb 48 83 c7 18 e8 6a 98 8c f6 48 89 df e8 c2 14 8d f6 e8 ed 98 b5 f6 fb bf 01 00 00 00 <e8> b2 4f 7e f6 65 8b 05 b3 88 24 75 85 c0 74 06 5b c3 cc cc cc cc
RSP: 0018:ffffc9000321fcf0 EFLAGS: 00000202
RAX: 0000000003959e61 RBX: ffff88801c3d0940 RCX: 1ffffffff1f3e279
RDX: 0000000000000000 RSI: ffffffff8b0cae00 RDI: 0000000000000001
RBP: ffff88801c3d0d40 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff8f9f5657 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000021 R14: ffff88801c3d0940 R15: ffff88801c3d0940
FS:  00007f305221e6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f305221de40 CR3: 000000002dcec000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 </IRQ>
 <TASK>
 spin_unlock_irq include/linux/spinlock.h:401 [inline]
 get_signal+0x1e3e/0x2710 kernel/signal.c:2914
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x14a/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xdc/0x260 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f305228c107
Code: 14 25 28 00 00 00 75 05 48 83 c4 28 c3 e8 31 1b 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 <0f> 05 48 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89
RSP: 002b:00007f305221e238 EFLAGS: 00000246
RAX: 00000000000000ca RBX: 00007f305230f318 RCX: 00007f305228c109
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f305230f318
RBP: 00007f305230f310 R08: 00007f305221e6c0 R09: 00007f305221e6c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f30522dc278
R13: 000000000000006e R14: 00007ffdd7b4fb90 R15: 00007ffdd7b4fc78
 </TASK>
sched: RT throttling activated


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

