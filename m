Return-Path: <linux-kernel+bounces-306233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBE3963BB4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38C051F211E1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 06:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336D3132124;
	Thu, 29 Aug 2024 06:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="sCOJvtPY";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="LANta9lw"
Received: from mx-lax3-2.ucr.edu (mx-lax3-2.ucr.edu [169.235.156.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3011B813
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 06:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724913121; cv=none; b=aa+cXRSP42L9nJKYLVSOt/4eIbJYHJ0sJUnsUpvzOPQDxJyMgY/rZrVWr5SlnGWJdbSvoWEGqXgyXtackb74Sq6hl+56bRtBjPI2PNaSXNOEoLvCl/1Gh++vgnaJI4zVHF2+wVtkjyzd/tU1Ove1PzIbjFGBZNvOp9TQA9iPhV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724913121; c=relaxed/simple;
	bh=QjfWYPIikd/ii1Fa8zTcflQBpDiqkgQ4VWEVSe0197o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=WTETfD7jSPSyYowiV7xGINIyUaszTRIxtXn+ySvwTjBETwFDjf6kgaexxEyCqWMIluk1Ih8h4+jrIQcYbqoZGwkb1amqCWDG8Jjv2U27UKG0bUog4TeXqi5DEgbPYMqWer6PrYHpiA3ZH81rctWUBx7OxZJSI/YsCkZLzAPjDrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=sCOJvtPY; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=LANta9lw; arc=none smtp.client-ip=169.235.156.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724913119; x=1756449119;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=QjfWYPIikd/ii1Fa8zTcflQBpDiqkgQ4VWEVSe0197o=;
  b=sCOJvtPY9wW5sETFWohBPfCUFX8ENN/ZSTSU0GXzxpFPSEgf6pf1cJtO
   i6gNLsLQF5jH+DSnlXtqTmtAosI5+wImw4gnVnjAhQJBlYC/wjRXWUc7n
   NWjRpMJmZyKlVZJ4JI2QDBELk6eac6T3fAzf9uu2ypfIJLBFquULe4sjj
   2/OUDvjItOgZ7BtKBvogkz8hZ4OF67PAcwKTkTz/+Ex93GCRTvHjW6Huo
   Ia/Qd9/+DMfEw2dqGkT3HVUcOBYfxZ7nOZFlZWNPAbNo4nkfv2jnioY4n
   Hh3qOYpa4ox7X1LrhLVc8XDb/0vAfyFpXfw1PKZKNJ+CuWSIzL/sq6MLW
   w==;
X-CSE-ConnectionGUID: 5Qb0TqXaSka5MrttpqnRlw==
X-CSE-MsgGUID: /sPCNSr6RUe9EHTUTUurIg==
Received: from mail-io1-f69.google.com ([209.85.166.69])
  by smtp-lax3-2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 23:31:58 -0700
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82a2058047eso566239f.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 23:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724913117; x=1725517917; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+z5dhkks28EEj5KiiwqWJ5ngMU0TmxNt8rpD60K7Gyk=;
        b=LANta9lwJ072GhUKLqQeotuLXyBRif8mx3NNiApLhve7BkE2JWGP9xmCV3puZdV+xE
         tjpqFT0QIGqRPR0OiSjh3glXsjl8LE6ri8bEWOXVga3WUC1bgmdXZxMXFhp3PnP1huhh
         fgAkZ2duqyR7BCV/2/IONoGjmd0Mf4C7/2qrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724913117; x=1725517917;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+z5dhkks28EEj5KiiwqWJ5ngMU0TmxNt8rpD60K7Gyk=;
        b=sSVF6N6cvTIlyOt4VGiu3zYXmz9kKx4u9TjXRa5x9DGv25l9fUWHFkD2WTWIhE+1wq
         rgHAkfCPeQ7iEki9V1YOQ42JxMZSh3vDP2ww0/GGhbYlOt3VEo186PAvsxpCyVqFP+Zr
         TmeQ4U3fmk8sGciBan0hDSEr0FADwnS06XTxhB/8zt4peYMvrnyCq8d26A56DTKkQ0XT
         EViDfEBUFEkI5lsuj3mLcRTunmkRwA4YgYm8AaWG23TMzEVuz75YpMWAwgBpTjeyu9ls
         xD8dR1IUXq9jhxy3Pl5TThaJdWtokflN1xFAPbtA9NrqLKEqjxcVHCUWMyluq1EfgQOf
         q5vw==
X-Forwarded-Encrypted: i=1; AJvYcCXjJKrAF2QCLbG+kz6N2fcowsH2ON1k/ulL4j+sGhNLE54/nkpYju+wwS/+rD8HlDap9tCe0xt564CzKcU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzdf0W7M5JY5X6y8XMSUP6UfwzcghYL7W8WsD2Mbw+cLfSgKqy
	ZqiI1hq2B0QGheETt6IYlkRoz2R5gT6fs7Ka1ep9USPR1FTsVSEGDCrHoDa74ZEkXCO5xXP+iXc
	LsAhX9B99KpmB7lv2HkB/qNUOdL7RvfNGLCB15EnKBEBt7VcRMWLctLMCfOYCi1OE4sK+OZjiJ8
	PqO7DGenVsbHobdZfq4WW6NpyFFplKCz9l7vFXsw==
X-Received: by 2002:a05:6602:6c13:b0:824:d5ff:6a55 with SMTP id ca18e2360f4ac-82a11098202mr205911239f.16.1724913117418;
        Wed, 28 Aug 2024 23:31:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/mu7EQ9cV/0dNDYpzbUf06WCAk/yUTToZjV9Ycn+hSPdtQocH2LaEJZeTyLkTdS5qwiE+IGUB+x6fp25zwd4=
X-Received: by 2002:a05:6602:6c13:b0:824:d5ff:6a55 with SMTP id
 ca18e2360f4ac-82a11098202mr205908639f.16.1724913117021; Wed, 28 Aug 2024
 23:31:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Juefei Pu <juefei.pu@email.ucr.edu>
Date: Wed, 28 Aug 2024 23:31:46 -0700
Message-ID: <CANikGpfDVGGA+gpRqik5NATXsXUqDa2JAFiVRGCLkPthtq4=Qw@mail.gmail.com>
Subject: BUG: corrupted list in dst_init
To: James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"

Hello,
We found the following issue using syzkaller on Linux v6.10.
The PoC generated by Syzkaller can cause the kernel to report memory
corruption related errors.
The Syzkaller reproducer:
https://gist.github.com/TomAPU/dcbb9b74f4fca8eda50e4ba38c83a364
kernel config:
https://gist.github.com/TomAPU/64f5db0fe976a3e94a6dd2b621887cdd

It seems that the task corrupted is `swapper`, not `syz-executor`. It
seems that there exists a bug in `/dev/sg0`, allowing a program to
tamper the memory without being caught by KASAN.

The report is below:
Syzkaller hit 'BUG: corrupted list in dst_init' bug.

list_add corruption. next->prev should be prev (ffff88802e5f4670), but
was 0000000000000000. (next=ffff88801966a200).
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:31!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:__list_add_valid_or_report+0xca/0xe0 lib/list_debug.c:29
Code: 58 a9 8b e8 d8 00 97 06 0f 0b 48 c7 c7 a0 58 a9 8b e8 ca 00 97
06 0f 0b 48 c7 c7 00 59 a9 8b 4c 89 e6 4c 89 f1 e8 b6 00 97 06 <0f> 0b
48 c7 c7 80 59 a9 8b 4c 89 f6 4c 89 e1 e8 a2 00 97 06 0f 0b
RSP: 0018:ffffc900000076d0 EFLAGS: 00010046
RAX: 0000000000000075 RBX: ffff88801966a208 RCX: ca5f1ee5ed054c00
RDX: 0000000000000102 RSI: 0000000000000102 RDI: 0000000000000000
RBP: ffffc90000007828 R08: ffffffff8172e30c R09: 1ffff92000000e78
R10: dffffc0000000000 R11: fffff52000000e79 R12: ffff88802e5f4670
R13: dffffc0000000000 R14: ffff88801966a200 R15: ffff88802dffb7c0
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f398f4808f0 CR3: 000000000d932000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 __list_add_valid include/linux/list.h:88 [inline]
 __list_add include/linux/list.h:150 [inline]
 list_add include/linux/list.h:169 [inline]
 ref_tracker_alloc+0x1ef/0x480 lib/ref_tracker.c:213
 __netdev_tracker_alloc include/linux/netdevice.h:4038 [inline]
 netdev_hold include/linux/netdevice.h:4067 [inline]
 dst_init+0xea/0x480 net/core/dst.c:52
 dst_alloc+0x157/0x190 net/core/dst.c:93
 ip6_dst_alloc net/ipv6/route.c:344 [inline]
 icmp6_dst_alloc+0x73/0x410 net/ipv6/route.c:3277
 ndisc_send_skb+0x31b/0x11e0 net/ipv6/ndisc.c:489
 addrconf_rs_timer+0x3a3/0x650 net/ipv6/addrconf.c:4039
 call_timer_fn+0xff/0x240 kernel/time/timer.c:1792
 expire_timers kernel/time/timer.c:1843 [inline]
 __run_timers kernel/time/timer.c:2417 [inline]
 __run_timer_base+0x734/0x9a0 kernel/time/timer.c:2428
 run_timer_base kernel/time/timer.c:2437 [inline]
 run_timer_softirq+0xb3/0x160 kernel/time/timer.c:2447
 handle_softirqs+0x272/0x750 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf0/0x1b0 kernel/softirq.c:637
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa0/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x16/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:72 [inline]
RIP: 0010:default_idle+0xb/0x10 arch/x86/kernel/process.c:743
Code: 07 76 e7 48 89 07 49 c7 c0 08 00 00 00 4d 29 c8 4c 01 c7 4c 29
c2 e9 72 ff ff ff cc cc cc cc 66 90 0f 00 2d c7 a4 4e 00 fb f4 <fa> c3
0f 1f 00 e9 eb ff ff ff 66 2e 0f 1f 84 00 00 00 00 00 90 65
RSP: 0018:ffffffff8d807d68 EFLAGS: 000002c2
RAX: ca5f1ee5ed054c00 RBX: ffffffff816928eb RCX: 0000000000006f59
RDX: 0000000000000001 RSI: ffffffff8b4c89c0 RDI: ffffffff8ba956e0
RBP: ffffffff8d807eb8 R08: ffff888063a37d0b R09: 1ffff1100c746fa1
R10: dffffc0000000000 R11: ffffed100c746fa2 R12: 1ffffffff1b00fc6
R13: 1ffffffff1b12778 R14: 0000000000000000 R15: dffffc0000000000
 default_idle_call+0x6e/0xa0 kernel/sched/idle.c:117
 cpuidle_idle_call kernel/sched/idle.c:191 [inline]
 do_idle+0x22b/0x5c0 kernel/sched/idle.c:332
 cpu_startup_entry+0x3d/0x60 kernel/sched/idle.c:430
 rest_init+0x2db/0x300 init/main.c:747
 start_kernel+0x486/0x500 init/main.c:1103
 x86_64_start_reservations+0x26/0x30 arch/x86/kernel/head64.c:507
 x86_64_start_kernel+0x5c/0x60 arch/x86/kernel/head64.c:488
 common_startup_64+0x13e/0x147
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_add_valid_or_report+0xca/0xe0 lib/list_debug.c:29
Code: 58 a9 8b e8 d8 00 97 06 0f 0b 48 c7 c7 a0 58 a9 8b e8 ca 00 97
06 0f 0b 48 c7 c7 00 59 a9 8b 4c 89 e6 4c 89 f1 e8 b6 00 97 06 <0f> 0b
48 c7 c7 80 59 a9 8b 4c 89 f6 4c 89 e1 e8 a2 00 97 06 0f 0b
RSP: 0018:ffffc900000076d0 EFLAGS: 00010046
RAX: 0000000000000075 RBX: ffff88801966a208 RCX: ca5f1ee5ed054c00
RDX: 0000000000000102 RSI: 0000000000000102 RDI: 0000000000000000
RBP: ffffc90000007828 R08: ffffffff8172e30c R09: 1ffff92000000e78
R10: dffffc0000000000 R11: fffff52000000e79 R12: ffff88802e5f4670
R13: dffffc0000000000 R14: ffff88801966a200 R15: ffff88802dffb7c0
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f398f4808f0 CR3: 000000000d932000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0: 76 e7                 jbe    0xffffffe9
   2: 48 89 07             mov    %rax,(%rdi)
   5: 49 c7 c0 08 00 00 00 mov    $0x8,%r8
   c: 4d 29 c8             sub    %r9,%r8
   f: 4c 01 c7             add    %r8,%rdi
  12: 4c 29 c2             sub    %r8,%rdx
  15: e9 72 ff ff ff       jmp    0xffffff8c
  1a: cc                   int3
  1b: cc                   int3
  1c: cc                   int3
  1d: cc                   int3
  1e: 66 90                 xchg   %ax,%ax
  20: 0f 00 2d c7 a4 4e 00 verw   0x4ea4c7(%rip)        # 0x4ea4ee
  27: fb                   sti
  28: f4                   hlt
* 29: fa                   cli <-- trapping instruction
  2a: c3                   ret
  2b: 0f 1f 00             nopl   (%rax)
  2e: e9 eb ff ff ff       jmp    0x1e
  33: 66 2e 0f 1f 84 00 00 cs nopw 0x0(%rax,%rax,1)
  3a: 00 00 00
  3d: 90                   nop
  3e: 65                   gs

