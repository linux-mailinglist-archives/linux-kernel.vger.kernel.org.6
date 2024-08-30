Return-Path: <linux-kernel+bounces-307937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C376965538
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF01D1F242CB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 02:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330DF86AFA;
	Fri, 30 Aug 2024 02:22:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096997BB14
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 02:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724984525; cv=none; b=Hfxa8ltZzy6OXpi7H8Ar9dKLIthaw6/QxZCoOfjSpDDmkhWGpYjWYL98PSNk0m766m1TET9DqY/Ccy+mx3LtRBDhHDtCkr9FPAuoZ1xVBfk068d4a7WhhvMrtLCQp8xlg33OzHGTkvmWwXyExgfyO7Ve8h3ccvw775YmENLcxwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724984525; c=relaxed/simple;
	bh=rukMmeZUJ9uCjNj4kQDhSJXEbJiyYuVVwFQe3p80C5g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fxPr0insx/Fny1xcHkqHtTpX4rFc9wiGGEHaAk0jX94itahM0pbx+kbGKhJQXyOrLAog4X13IU2NNJkHM9R0ZOBthqnc61hzQ2/Voroq1xWFONvecC8EhSbhfIahs88d2LLDZUdShqhG7nLMW177SabytIQR2P1jxVS7n86jv2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f99a9111fso143661639f.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 19:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724984523; x=1725589323;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ahNV3TqL4He6Y4KJ52Bnq2rVDd+I+GfrLHQvehGZJQs=;
        b=FaTA2Qmz2N5zERFmlunmfoXOxVWtMYRoh4hNLfHapuFqXv4d6Nv6sMfGe5IdJVQy4h
         VozHb3CrGWOd/BN6wGmaH9YXxt4f+KiTLZ+ApN4qv7S/uMtSvdsvXZ2QuR93zZKkaE1f
         aQ/woxSb8P02Z3fn7Eu2b39ZCVjJuLaPhPeTSCORnaVbHqWtkdPI6C9azkHhlm1VEhfY
         SGQ4XZl8yrogM/BQysdr9VIyFOmRnjR7IGXQjXCBwsvT5ytMKAe+fIX97jpXrNZYo3gh
         kNth2gzZC1ulB2ohML5J5kkP+IQ/jszHH1KHwlZ5St4BHdb8HmBUnzl7nUELu8TjrfWy
         Tn/w==
X-Gm-Message-State: AOJu0YyvKj+eSQb8n8hgP+TIRVPsrxgb8/w5/CLoyQ26E06d/4fI7SL7
	eKjwXB2F74NneKvwJOeU6BXoicdmLXAZRqHhZ3wXUsn70EYflvjthnql96EO1MdyVRN0vJBJfNT
	NJ0jfU2sq1r8gSN79qQVxQeNCwE7cSLwg+wBnsV/Dl/BLte8IgN1eyts=
X-Google-Smtp-Source: AGHT+IFqJINSrBCcLZLCsUNxcdb81vpihaMF/Pe4n1RXxk64LcPbeiFbJ0o7hz/D462NmxToPvUX1MYrHUjP9X49NqyY8dk+HLp0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8720:b0:4bf:2453:3a48 with SMTP id
 8926c6da1cb9f-4d017edce7cmr30213173.5.1724984523041; Thu, 29 Aug 2024
 19:22:03 -0700 (PDT)
Date: Thu, 29 Aug 2024 19:22:03 -0700
In-Reply-To: <20240830015132.1265088-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bd469d0620dd41cc@google.com>
Subject: Re: [syzbot] [net?] WARNING in hsr_fill_frame_info
From: syzbot <syzbot+3d602af7549af539274e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in send_hsr_supervision_frame

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.11.0-rc5-syzkaller-g1b5fe53681d9-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:send_hsr_supervision_frame+0x3a/0xcc0 net/hsr/hsr_device.c:292
Code: ec 40 48 89 54 24 38 49 89 f7 49 89 fd 48 bb 00 00 00 00 00 fc ff df e8 b4 26 fc f5 48 89 d9 49 8d 5d 18 48 89 d8 48 c1 e8 03 <80> 3c 08 00 74 12 48 89 df e8 68 69 63 f6 48 b9 00 00 00 00 00 fc
RSP: 0018:ffffc90000a18a68 EFLAGS: 00010206
RAX: 0000000000000003 RBX: 0000000000000018 RCX: dffffc0000000000
RDX: 0000000000000100 RSI: ffffc90000a18b40 RDI: 0000000000000000
RBP: ffffc90000a18bb0 R08: ffffffff8b96c883 R09: 1ffffffff26e6908
R10: dffffc0000000000 R11: ffffffff8b976550 R12: ffff88807bcf6ed8
R13: 0000000000000000 R14: ffff88807bcf6cf0 R15: ffffc90000a18b40
FS:  0000000000000000(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055673127c950 CR3: 000000000e734000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 hsr_proxy_announce+0x23a/0x4c0 net/hsr/hsr_device.c:433
 call_timer_fn+0x18e/0x650 kernel/time/timer.c:1792
 expire_timers kernel/time/timer.c:1843 [inline]
 __run_timers kernel/time/timer.c:2417 [inline]
 __run_timer_base+0x66a/0x8e0 kernel/time/timer.c:2428
 run_timer_base kernel/time/timer.c:2437 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2447
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
RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:92 [inline]
RIP: 0010:acpi_safe_halt+0x21/0x30 drivers/acpi/processor_idle.c:112
Code: 90 90 90 90 90 90 90 90 90 65 48 8b 04 25 00 d7 03 00 48 f7 00 08 00 00 00 75 10 66 90 0f 00 2d 85 d3 b2 00 f3 0f 1e fa fb f4 <fa> c3 cc cc cc cc 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
RSP: 0018:ffffc900001a7d08 EFLAGS: 00000246
RAX: ffff888018280000 RBX: ffff88801caa1064 RCX: 000000000007d0d9
RDX: 0000000000000001 RSI: ffff88801caa1000 RDI: ffff88801caa1064
RBP: 000000000003a678 R08: ffff8880b9337c7b R09: 1ffff11017266f8f
R10: dffffc0000000000 R11: ffffffff8bb74cf0 R12: ffff88801a3fc000
R13: 0000000000000000 R14: 0000000000000001 R15: ffffffff8f0df120
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
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:send_hsr_supervision_frame+0x3a/0xcc0 net/hsr/hsr_device.c:292
Code: ec 40 48 89 54 24 38 49 89 f7 49 89 fd 48 bb 00 00 00 00 00 fc ff df e8 b4 26 fc f5 48 89 d9 49 8d 5d 18 48 89 d8 48 c1 e8 03 <80> 3c 08 00 74 12 48 89 df e8 68 69 63 f6 48 b9 00 00 00 00 00 fc
RSP: 0018:ffffc90000a18a68 EFLAGS: 00010206
RAX: 0000000000000003 RBX: 0000000000000018 RCX: dffffc0000000000
RDX: 0000000000000100 RSI: ffffc90000a18b40 RDI: 0000000000000000
RBP: ffffc90000a18bb0 R08: ffffffff8b96c883 R09: 1ffffffff26e6908
R10: dffffc0000000000 R11: ffffffff8b976550 R12: ffff88807bcf6ed8
R13: 0000000000000000 R14: ffff88807bcf6cf0 R15: ffffc90000a18b40
FS:  0000000000000000(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055673127c950 CR3: 000000000e734000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	ec                   	in     (%dx),%al
   1:	40                   	rex
   2:	48 89 54 24 38       	mov    %rdx,0x38(%rsp)
   7:	49 89 f7             	mov    %rsi,%r15
   a:	49 89 fd             	mov    %rdi,%r13
   d:	48 bb 00 00 00 00 00 	movabs $0xdffffc0000000000,%rbx
  14:	fc ff df
  17:	e8 b4 26 fc f5       	call   0xf5fc26d0
  1c:	48 89 d9             	mov    %rbx,%rcx
  1f:	49 8d 5d 18          	lea    0x18(%r13),%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1) <-- trapping instruction
  2e:	74 12                	je     0x42
  30:	48 89 df             	mov    %rbx,%rdi
  33:	e8 68 69 63 f6       	call   0xf66369a0
  38:	48                   	rex.W
  39:	b9 00 00 00 00       	mov    $0x0,%ecx
  3e:	00 fc                	add    %bh,%ah


Tested on:

commit:         1b5fe536 Merge tag 'execve-v6.11-rc6' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17aa067b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8605cd35ddc8ff3c
dashboard link: https://syzkaller.appspot.com/bug?extid=3d602af7549af539274e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=113ddf93980000


