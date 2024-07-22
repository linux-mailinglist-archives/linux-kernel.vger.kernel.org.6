Return-Path: <linux-kernel+bounces-259049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F200939079
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 16:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D6D2821B5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 14:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E7816DC28;
	Mon, 22 Jul 2024 14:19:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA221D555
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 14:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721657946; cv=none; b=nSUF/GdzIKAS4ODs6wy26TMHWKKZNxU5NM28ZDN1rFUEYRPqzpyQIYEVz7dGK576O6cP34f7RT7Li6Wj1XJtjQCaKQvJqlHUCFfadkQobwEVHrkVzkHDEYHtc3F+en8OH6bhfqQyBRaT6jquXfjcEpO3L3qLaDxIGR4nPK+X9/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721657946; c=relaxed/simple;
	bh=2VwCmV3I9NoDC3q88QymeLDI8pBPKzd/6SCjkM9qU0E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FMpY0d/BOjWXb+CZnmex+gsOgw/WBVhLv7p6o1+e0METVUpAiUB55Xu1Shrrl4UfZ26xPtWkcThLZAotwljX2X2Te+LcaKIZSVO5YZKievv9kUBQA3rR9QmdIn6In6zCFaMz+387p/0bbkUvH2kQ1ZRsndjztsV4NF9nVx6AllU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3982257ab28so52640725ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 07:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721657943; x=1722262743;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SbzQSr707BWIYw7DbEXayhE+sy/kNVF1Fdw5RINtKMg=;
        b=sX7X836O8PefiDxzwxREVB4Poehud5rq8WVos58s6C3g+jpMMsLmtYapodQtPywPNx
         ajAjbSYtM+XxJLb3oP6rJICgQfnZCaTckx5C4zOL2Zu7fXDJpqEsrP64ibzfks9gH1ik
         JhlsJ+F49xmycHn/XIOXF+MUqyU4kT39ossDtxdwww0eaMafC9NvA6393L982LLFl+VV
         BVIlzv4RVjbd9UMplzuHger78S6PbwHB5cOkSH67wL1hUYHB/XxdibFQh85PSbYUTmiR
         1Y3lCSimIrGOE+TuTf+T0W65hOITnIEgsyEZ16h1SiAPsdrtK6gGF0IXMe39il4HwTMN
         2W0g==
X-Forwarded-Encrypted: i=1; AJvYcCVdqb2xq4btgxz/b4rQ9db1jxoCZeF3Rj1VAcA3xkCwqGC7EIR9Nn0EizPvfpghzSe2tz05GPhBHrvu1+L9JGd6f2kmtWKERQQOZ/YY
X-Gm-Message-State: AOJu0YzfYV69saHZjsCZOiiENnEPQyrtU2V4nqWZvPeunc6N2VLNum3M
	R+JCeJtE+PE9jQX2uQ+K+sYwv/OpUKzNS9hna8/RnnF9hoSTL5g0nLQhXPX8hlqz3mskXsEc/2A
	9ODqsCHDic8iUQj9ejzklgtyn3Tkc22m/gZVIj/+/GC/elBtdXx6zRX8=
X-Google-Smtp-Source: AGHT+IFubWpFKUrx6LueiwrD3ypMsFrPhaEkPSux7iQqpnUGiNZM4uME7La15eRKS4U0vq5H0pXh7v7qXA6G8VMDgmWHFmry0wdD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c1:b0:396:1fc1:7034 with SMTP id
 e9e14a558f8ab-398e19960demr4693505ab.0.1721657943572; Mon, 22 Jul 2024
 07:19:03 -0700 (PDT)
Date: Mon, 22 Jul 2024 07:19:03 -0700
In-Reply-To: <20240722094810.4193-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000026d737061dd6bae0@google.com>
Subject: Re: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free Read in bq_xmit_all
From: syzbot <syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in __cpu_map_flush

Oops: general protection fault, probably for non-canonical address 0xe3fffb24000bcbe2: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: maybe wild-memory-access in range [0x1ffff920005e5f10-0x1ffff920005e5f17]
CPU: 1 PID: 11356 Comm: syz.0.2720 Not tainted 6.10.0-rc6-syzkaller-01399-g605c96997d89 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:__cpu_map_flush+0x42/0xd0
Code: e8 33 dd d6 ff 4c 89 f0 48 c1 e8 03 42 80 3c 38 00 74 08 4c 89 f7 e8 8d b2 39 00 49 8b 1e 4c 39 f3 74 77 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 6f b2 39 00 4c 8b 23 48 8d 7b c0
RSP: 0018:ffffc90000a18b10 EFLAGS: 00010206
RAX: 03ffff24000bcbe2 RBX: 1ffff920005e5f10 RCX: ffff88807b34da00
RDX: 0000000080000100 RSI: 0000000000000000 RDI: ffffc90002f2f800
RBP: dffffc0000000000 R08: ffffffff895a503a R09: 1ffffffff1f5969d
R10: dffffc0000000000 R11: fffffbfff1f5969e R12: ffffc90002f2f800
R13: ffffc90002f2f7c0 R14: ffffc90002f2f800 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f14a6b06030 CR3: 0000000027bec000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
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
RIP: 0010:account_kernel_stack+0x289/0x3f0 kernel/fork.c:540
Code: 4d e8 db ea 3e 00 48 8b 5c 24 08 4d 85 f6 75 10 e8 cc ea 3e 00 49 83 fc 38 75 15 e9 09 01 00 00 e8 bc ea 3e 00 fb 49 83 fc 38 <0f> 84 f9 00 00 00 e8 ac ea 3e 00 49 83 c4 08 e9 2d fe ff ff e8 9e
RSP: 0018:ffffc90002f2f9c0 EFLAGS: 00000293
RAX: ffffffff81573ae4 RBX: ffff88806d454020 RCX: ffff88807b34da00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90002f2fa88 R08: ffffffff81573ab6 R09: 1ffffffff1f5969d
R10: dffffc0000000000 R11: fffffbfff1f5969e R12: 0000000000000000
R13: ffffc90002f2fa00 R14: 0000000000000200 R15: ffffc90002f2fa20
 exit_task_stack_account+0x2a/0x340 kernel/fork.c:554
 do_exit+0x1cfa/0x27e0 kernel/exit.c:917
 do_group_exit+0x207/0x2c0 kernel/exit.c:1025
 get_signal+0x16a1/0x1740 kernel/signal.c:2909
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x360 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f14a6975b59
Code: Unable to access opcode bytes at 0x7f14a6975b2f.
RSP: 002b:00007f14a77350f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007f14a6b05f68 RCX: 00007f14a6975b59
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f14a6b05f68
RBP: 00007f14a6b05f60 R08: 00007f14a77356c0 R09: 00007f14a77356c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f14a6b05f6c
R13: 000000000000000b R14: 00007ffc7a3935b0 R15: 00007ffc7a393698
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__cpu_map_flush+0x42/0xd0
Code: e8 33 dd d6 ff 4c 89 f0 48 c1 e8 03 42 80 3c 38 00 74 08 4c 89 f7 e8 8d b2 39 00 49 8b 1e 4c 39 f3 74 77 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 6f b2 39 00 4c 8b 23 48 8d 7b c0
RSP: 0018:ffffc90000a18b10 EFLAGS: 00010206
RAX: 03ffff24000bcbe2 RBX: 1ffff920005e5f10 RCX: ffff88807b34da00
RDX: 0000000080000100 RSI: 0000000000000000 RDI: ffffc90002f2f800
RBP: dffffc0000000000 R08: ffffffff895a503a R09: 1ffffffff1f5969d
R10: dffffc0000000000 R11: fffffbfff1f5969e R12: ffffc90002f2f800
R13: ffffc90002f2f7c0 R14: ffffc90002f2f800 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f14a6b06030 CR3: 000000000e132000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	e8 33 dd d6 ff       	call   0xffd6dd38
   5:	4c 89 f0             	mov    %r14,%rax
   8:	48 c1 e8 03          	shr    $0x3,%rax
   c:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1)
  11:	74 08                	je     0x1b
  13:	4c 89 f7             	mov    %r14,%rdi
  16:	e8 8d b2 39 00       	call   0x39b2a8
  1b:	49 8b 1e             	mov    (%r14),%rbx
  1e:	4c 39 f3             	cmp    %r14,%rbx
  21:	74 77                	je     0x9a
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 6f b2 39 00       	call   0x39b2a8
  39:	4c 8b 23             	mov    (%rbx),%r12
  3c:	48 8d 7b c0          	lea    -0x40(%rbx),%rdi


Tested on:

commit:         605c9699 bpf: relax zero fixed offset constraint on KF..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13e810a1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8defeae77515c9b1
dashboard link: https://syzkaller.appspot.com/bug?extid=707d98c8649695eaf329
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

