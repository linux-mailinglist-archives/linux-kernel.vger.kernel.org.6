Return-Path: <linux-kernel+bounces-258090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4AD938357
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 06:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01A8C281515
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 04:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444A63D71;
	Sun, 21 Jul 2024 04:48:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211321FBA
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 04:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721537285; cv=none; b=IA7xtRWPLterW2JvqLJ3x86DhewGREn22smlSqY94paDargALUq2xZ74w00Pal/xVWt6HkI2FTJn8a3Yn8jSC5TPbk7xbqnrdFPDYKyZUvaMAodAE2xMs9sOnYWygVANjLL/BgDHLjGYGwz/BMQoCy488lnjTiaoXe4CFSlEDYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721537285; c=relaxed/simple;
	bh=1jGX0kTPJOX5u/R7VxAseKW+qfM8In7Vv+MKa+BCvKw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=n+TdcKZTqhun9cQn+XJOORyA2lkldwm21+bkJYAf9kadSlike6jXT8CLgRLVyoXKKVQLCqGhzJMtlNVhp33CZ/cUeNZgAMtefkEB2Hv/UAjYxCDmUpmbNbpoejvwVDmYx+ZBgeudhA3em+phi1w2KTdJLY4nZfvSL3+TpzGMGVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-386540d8c90so44275225ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 21:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721537283; x=1722142083;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Bsvx7kigMiCfDE0UuelQkceC6JMOhP+WeBaWbyg5W8=;
        b=R/90qceQJJMs3IzDDk7yEU4GHYXXdNZeZLJpntu7XgAu78soBbDcJu7UCRtZjt6Mmq
         6z3oZDbPWvLvxPc7y7Sp+ZcTBIbvLxkOhzzlR7d6dw0XkuSrMGAPXDhWJlncdluqR+4o
         FCeblFK2mLOMYBYYYSELDvt+/P2hgWSxMeuEwdZHkiQFcqdahldldPFHCv/VK7TsnSEF
         jKn/sgns6vQJwFiWr/ANwz5dPBg1FaWpNQrwwL+r98qAHZ6XT46SlUddCpryKWSpIP2b
         DAS9VvyazY7pUyRov/HPAt4vNyv+baQbbrMCiB0nvE1I7EvjUhQA6ZcPcfX+WxhwUea7
         PXTw==
X-Forwarded-Encrypted: i=1; AJvYcCW+QTwnvv1ZPw7qmDVEX3UyZBo3PVnrcrUyrHnhJdb6F7OvzYsbFsc/adwo1lLYJA49tym2y7RjOHobU4cIY2ZUvnerrDToefWPCPFd
X-Gm-Message-State: AOJu0Yx/dMWhy6ftgJaAXGxOPs3VbM9n8Y3wlIlNx7KeolxndQcV3BtU
	Qc7tII4ouGXWx9kgEPfPriE78Vtv9yOHh21WtQ+GJrPCpm7IDKDA5rAnyyUXerut1qBYD4Fka3V
	kfRjhK4q9FZguqKi9FKHc1RefLV4A6KnvjcqSh4UMfINtI2hnoao57YU=
X-Google-Smtp-Source: AGHT+IG/6gJ5juajPNZ+R9a7M+r4qj62i1j+0yYa8dtJlGllFKzr2mmOzVV6NGj5EB8CXtdxFFEyv3iBlFN4PrWsTao1QoqDlZHI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c6:b0:398:b1d3:7c9d with SMTP id
 e9e14a558f8ab-398e6f78362mr4200955ab.3.1721537283263; Sat, 20 Jul 2024
 21:48:03 -0700 (PDT)
Date: Sat, 20 Jul 2024 21:48:03 -0700
In-Reply-To: <20240721032833.168011-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003c9dd1061dbaa236@google.com>
Subject: Re: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free Read in bq_xmit_all
From: syzbot <syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in bq_flush_to_queue

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 6250 Comm: syz.0.140 Not tainted 6.10.0-syzkaller-11185-g2c9b3512402e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:bq_flush_to_queue+0x44/0x610 kernel/bpf/cpumap.c:675
Code: df e8 b0 d8 d6 ff 49 8d 5e 50 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 d6 cd 39 00 48 8b 2b 48 89 e8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 0f 85 1d 05 00 00 44 8b 65 00 4d 8d 6e 58 4c
RSP: 0018:ffffc90000007a80 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88807e7fb910 RCX: ffff888020138000
RDX: 0000000000000101 RSI: 0000000000000000 RDI: ffff88807e7fb8c0
RBP: 0000000000000000 R08: ffffffff895fbdfa R09: 1ffffffff1f5d135
R10: dffffc0000000000 R11: fffffbfff1f5d136 R12: 0000000000000001
R13: ffffc900030277c0 R14: ffff88807e7fb8c0 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2ca5ffff CR3: 0000000049242000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 __cpu_map_flush+0x5d/0xd0 kernel/bpf/cpumap.c:767
 xdp_do_check_flushed+0x136/0x240 net/core/filter.c:4304
 __napi_poll+0xe4/0x490 net/core/dev.c:6774
 napi_poll net/core/dev.c:6840 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:6962
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:unwind_next_frame+0x677/0x2a00 arch/x86/kernel/unwind_orc.c:495
Code: 24 08 48 c7 c0 6c 55 bb 8f 48 29 c3 48 c7 c1 a8 75 2c 90 48 c1 fb 02 4c 8d 3c 5b 4d 01 ff 49 01 cf 0f 84 82 00 00 00 49 89 ee <e8> f4 34 52 00 49 8d 6f 04 49 8d 5f 05 48 89 e8 48 c1 e8 03 42 0f
RSP: 0018:ffffc900030272a8 EFLAGS: 00000286
RAX: ffffffff81410c9e RBX: 0000000000000000 RCX: ffffffff903ce67e
RDX: 0000000000000000 RSI: ffffffff81eac064 RDI: ffffffff81eabf32
RBP: 1ffff92000604e70 R08: ffffffff81410c60 R09: ffffc90003027470
R10: 0000000000000003 R11: ffffffff817ee9a0 R12: ffffffff8fc64b50
R13: dffffc0000000000 R14: 1ffff92000604e70 R15: ffffffff903ce67e
 arch_stack_walk+0x151/0x1b0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2235 [inline]
 slab_free mm/slub.c:4464 [inline]
 kmem_cache_free+0x145/0x350 mm/slub.c:4539
 vma_lock_free kernel/fork.c:455 [inline]
 __vm_area_free+0xe0/0x110 kernel/fork.c:511
 remove_vma mm/mmap.c:146 [inline]
 exit_mmap+0x645/0xc80 mm/mmap.c:3365
 __mmput+0x115/0x380 kernel/fork.c:1343
 exit_mm+0x220/0x310 kernel/exit.c:566
 do_exit+0x9b2/0x27f0 kernel/exit.c:864
 do_group_exit+0x207/0x2c0 kernel/exit.c:1026
 get_signal+0x16a1/0x1740 kernel/signal.c:2917
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f389ef75b59
Code: Unable to access opcode bytes at 0x7f389ef75b2f.
RSP: 002b:00007f389fd440f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007f389f105f68 RCX: 00007f389ef75b59
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f389f105f68
RBP: 00007f389f105f60 R08: 00007f389fd446c0 R09: 00007f389fd446c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f389f105f6c
R13: 000000000000000b R14: 00007ffd4ff20a20 R15: 00007ffd4ff20b08
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bq_flush_to_queue+0x44/0x610 kernel/bpf/cpumap.c:675
Code: df e8 b0 d8 d6 ff 49 8d 5e 50 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 d6 cd 39 00 48 8b 2b 48 89 e8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 0f 85 1d 05 00 00 44 8b 65 00 4d 8d 6e 58 4c
RSP: 0018:ffffc90000007a80 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88807e7fb910 RCX: ffff888020138000
RDX: 0000000000000101 RSI: 0000000000000000 RDI: ffff88807e7fb8c0
RBP: 0000000000000000 R08: ffffffff895fbdfa R09: 1ffffffff1f5d135
R10: dffffc0000000000 R11: fffffbfff1f5d136 R12: 0000000000000001
R13: ffffc900030277c0 R14: ffff88807e7fb8c0 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2ca5ffff CR3: 0000000049242000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	e8 b0 d8 d6 ff       	call   0xffd6d8b5
   5:	49 8d 5e 50          	lea    0x50(%r14),%rbx
   9:	48 89 d8             	mov    %rbx,%rax
   c:	48 c1 e8 03          	shr    $0x3,%rax
  10:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1)
  15:	74 08                	je     0x1f
  17:	48 89 df             	mov    %rbx,%rdi
  1a:	e8 d6 cd 39 00       	call   0x39cdf5
  1f:	48 8b 2b             	mov    (%rbx),%rbp
  22:	48 89 e8             	mov    %rbp,%rax
  25:	48 c1 e8 03          	shr    $0x3,%rax
* 29:	42 0f b6 04 38       	movzbl (%rax,%r15,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	0f 85 1d 05 00 00    	jne    0x553
  36:	44 8b 65 00          	mov    0x0(%rbp),%r12d
  3a:	4d 8d 6e 58          	lea    0x58(%r14),%r13
  3e:	4c                   	rex.WR


Tested on:

commit:         2c9b3512 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16870195980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4925140c45a2a50
dashboard link: https://syzkaller.appspot.com/bug?extid=707d98c8649695eaf329
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

