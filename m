Return-Path: <linux-kernel+bounces-258266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A199385A7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 19:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFC7C1C20B4D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 17:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BEC1684B4;
	Sun, 21 Jul 2024 17:29:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2401DFE4
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 17:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721582946; cv=none; b=iInSYY0zacZVOvXUtCCoH/TyxuRALU1ZYEoPTjDSIWA0cWBnargoG8Zlxv2NJq6f14GDMX2xpLzsOzyTCH8CluiYyymasN98BdtrlsXLrhj+wLm0PZVYcCq7ypRK8GYCEYEi6XJk77rwQiWbwEhn3fOyCv+cUg4C72eBXJWP+PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721582946; c=relaxed/simple;
	bh=wtI8h/hFP73t1NFwAhgh7k0k94f7mOQVXAgCZM6oVS0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pO6r4eO9aatmOApnanVxEddYoG9Uol6XEv5EYeSMKiUe0/WVesmZynu4mRnEUHG+2NCJbV8RDrmYqJL1rS4dNng5C0Diqd1xRhNA442tzqFEzl99dELB2FrJTfCUvZTLgT4H+03yREL5p6sFgAqlcWBeAOESZJwTm1SHBb2YFYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39862b50109so33799685ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 10:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721582944; x=1722187744;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LF5iQbbrCfP88oAcOEl5ZzWl38o0V519i/YmILtSMUk=;
        b=IXzHvCOQov7gM9W1JWpaNXVKV6gr8bkjIfRaDI4SvnBSMG4v1hxVN3dUPlQTRL5bXB
         7ZsAOSAdA5oM6rJhqi2qLDLSYWOpDOUxU/lTeiFsDK2lq75iNtMF/c6PZGQRiFW5wIGu
         tVInpJDR2yIKly3SvFmnW0PA0pM5kD+Sc81vAiraTUiB5O+8qhWCCxv8f9PtUDqKQdBw
         EU/BVDKnrR14axpl0bZQ2qiRnWyFoNJSwe9dXBGk4UCimBhMzIvtwbOdtF62i575w5bu
         YJn/CbCYjrKLplDZj5q0vexS/dLbRzFcyrDPZu9Iv5xNrRMYjBzmbeoKi3gVWVwCyIGp
         wI2g==
X-Forwarded-Encrypted: i=1; AJvYcCVorEst8VG1mVmfwMA1j3Bm1c6F1duJG0nvQrsQriptHm+3sxR8PMgknZyOYB53Njdw9dUtN1uTSYvqv9AN1de6GWeT5dfs5hG5+niv
X-Gm-Message-State: AOJu0Yzv124OlXTDFaEimrNGgta8LKQIVMwGaoPz7dfSdhmsV3I3BAjK
	fKnccwbztGcbNPW0fcWzT33RsHrbivWNHWxOgQDROqcA6+cK9FgjRdepRf8hNjKkDYQviSn/fqU
	VnmeIGyXt+k3EnaapbkxBGJH8r3U7cjNUtyJ9wW/WaOUqkHVyyqJ6ILA=
X-Google-Smtp-Source: AGHT+IEpvzV5MS5/w6Dx81YPydffwQh8fOpaZuDJm4M51TRji+lAdI+aPpa5NZX9zBWm64nr7z//6Dd5LSbjS7cHgQnRDUJV/X+l
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3593:b0:4b9:6c10:36a9 with SMTP id
 8926c6da1cb9f-4c23fd100b2mr425237173.1.1721582943962; Sun, 21 Jul 2024
 10:29:03 -0700 (PDT)
Date: Sun, 21 Jul 2024 10:29:03 -0700
In-Reply-To: <20240721163635.2486-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d3a01d061dc54329@google.com>
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
CPU: 1 PID: 6059 Comm: syz.0.51 Not tainted 6.10.0-rc6-syzkaller-01399-g605c96997d89 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:bq_flush_to_queue+0x44/0x610 kernel/bpf/cpumap.c:675
Code: df e8 50 dc d6 ff 49 8d 5e 50 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 a6 b1 39 00 48 8b 2b 48 89 e8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 0f 85 1d 05 00 00 44 8b 65 00 4d 8d 6e 58 4c
RSP: 0018:ffffc90000a18a80 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8880652a4290 RCX: ffff888073870000
RDX: 0000000080000101 RSI: 0000000000000010 RDI: ffff8880652a4240
RBP: 0000000000000000 R08: ffffffff895a503a R09: 1ffffffff1f5969d
R10: dffffc0000000000 R11: fffffbfff1f5969e R12: 0000000000000002
R13: ffffc900037d7820 R14: ffff8880652a4240 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b33b5ffff CR3: 000000000e132000 CR4: 00000000003506f0
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
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:194
Code: 9c 8f 44 24 20 42 80 3c 23 00 74 08 4c 89 f7 e8 1e d9 6c f6 f6 44 24 21 02 75 52 41 f7 c7 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> e3 79 d9 f5 65 8b 05 34 b3 77 74 85 c0 74 43 48 c7 04 24 0e 36
RSP: 0018:ffffc900037d7580 EFLAGS: 00000206
RAX: 35c09d964b24e400 RBX: 1ffff920006faeb4 RCX: ffffffff8172d8aa
RDX: dffffc0000000000 RSI: ffffffff8bcabb40 RDI: 0000000000000001
RBP: ffffc900037d7610 R08: ffffffff92f875b7 R09: 1ffffffff25f0eb6
R10: dffffc0000000000 R11: fffffbfff25f0eb7 R12: dffffc0000000000
R13: 1ffff920006faeb0 R14: ffffc900037d75a0 R15: 0000000000000246
 __debug_check_no_obj_freed lib/debugobjects.c:998 [inline]
 debug_check_no_obj_freed+0x561/0x580 lib/debugobjects.c:1019
 slab_free_hook mm/slub.c:2163 [inline]
 slab_free mm/slub.c:4438 [inline]
 kmem_cache_free+0x10f/0x350 mm/slub.c:4513
 vma_lock_free kernel/fork.c:453 [inline]
 __vm_area_free+0xe0/0x110 kernel/fork.c:509
 remove_vma mm/mmap.c:146 [inline]
 exit_mmap+0x645/0xc80 mm/mmap.c:3365
 __mmput+0x115/0x3c0 kernel/fork.c:1346
 exit_mm+0x220/0x310 kernel/exit.c:567
 do_exit+0x9aa/0x27e0 kernel/exit.c:863
 do_group_exit+0x207/0x2c0 kernel/exit.c:1025
 get_signal+0x16a1/0x1740 kernel/signal.c:2909
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x360 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1530b75b59
Code: Unable to access opcode bytes at 0x7f1530b75b2f.
RSP: 002b:00007f153197b0f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007f1530d05f68 RCX: 00007f1530b75b59
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f1530d05f68
RBP: 00007f1530d05f60 R08: 00007f153197b6c0 R09: 00007f153197b6c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f1530d05f6c
R13: 000000000000000b R14: 00007ffd94c0c0d0 R15: 00007ffd94c0c1b8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bq_flush_to_queue+0x44/0x610 kernel/bpf/cpumap.c:675
Code: df e8 50 dc d6 ff 49 8d 5e 50 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 a6 b1 39 00 48 8b 2b 48 89 e8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 0f 85 1d 05 00 00 44 8b 65 00 4d 8d 6e 58 4c
RSP: 0018:ffffc90000a18a80 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8880652a4290 RCX: ffff888073870000
RDX: 0000000080000101 RSI: 0000000000000010 RDI: ffff8880652a4240
RBP: 0000000000000000 R08: ffffffff895a503a R09: 1ffffffff1f5969d
R10: dffffc0000000000 R11: fffffbfff1f5969e R12: 0000000000000002
R13: ffffc900037d7820 R14: ffff8880652a4240 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b33b5ffff CR3: 000000000e132000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	e8 50 dc d6 ff       	call   0xffd6dc55
   5:	49 8d 5e 50          	lea    0x50(%r14),%rbx
   9:	48 89 d8             	mov    %rbx,%rax
   c:	48 c1 e8 03          	shr    $0x3,%rax
  10:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1)
  15:	74 08                	je     0x1f
  17:	48 89 df             	mov    %rbx,%rdi
  1a:	e8 a6 b1 39 00       	call   0x39b1c5
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

commit:         605c9699 bpf: relax zero fixed offset constraint on KF..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=146d0ae6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8defeae77515c9b1
dashboard link: https://syzkaller.appspot.com/bug?extid=707d98c8649695eaf329
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

