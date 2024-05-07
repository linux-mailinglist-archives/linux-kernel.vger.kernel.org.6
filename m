Return-Path: <linux-kernel+bounces-170819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D038BDC75
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71B031C21D03
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 07:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391A313C3FA;
	Tue,  7 May 2024 07:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W2hHWxXD"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CBC13BAC3
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 07:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715067081; cv=none; b=LJY4FgaSgWDpCDekMuIthXDdyFzSMVU35AwNV8QU2tnfqLSiqkqWYrshqxC5x5V0QvQbsrnToycUV81WRnNtdizuyW9DiriJ+s/jkwOhB75Ce86pS3wqKIJjC+dnrkn3NeLKzG5jS54pG5WyvzuH7GH1VWmo6QG6Q3kio9Htz5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715067081; c=relaxed/simple;
	bh=KBDLtEBYt7DBX+CTDDeyBaMAe3X2ghmRW4PFkXcMS9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=il9d5EDCgMQUw2wtMymGshXzfgG5FEU7dSbOsuJav2SaIaPllQEUj/2K3DPgYPrl7GeZXy3YWoR1Jke/dXUinHvA6+eyef5XuBsJJQ5ZfpfG7iZxu+iBr9bbk30pJDYV9DtcL2zWCq9eiAIMjK80WlcnOczXlA6E7Ii2ojgZMaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W2hHWxXD; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-572aad902baso10436a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 00:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715067078; x=1715671878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmvUSPF9NLdKwnRj3AKR4GurwZOdKRkhI6zjFH5eUHs=;
        b=W2hHWxXDNDT4MURGMdKYKFbN5mBJKhCOwtQR/VM8RF95DraKt1uj+u6P2+LaSNRSfG
         VMqx9Xx7iaHecn5I/U5h4GaG5IoiUzDCDQmDY/73zO7FSMtNxcBMxr8F/gKTLM7HZB89
         g7JLgfL68fIVm8eJDpcms0JmPkFGd16hTwd46JKjKSaSYKdYyF6LMzCnmu+KmuTdpoUr
         7g+XJjaueA8lPhA065QpwcyWVRhbCr3TKeeNa760R+rK8V7sSrXrz3iCrhLX9kpKRp25
         G2/Al3LD8Kh53d51qPhPcDO0XjwvOdG+Q6mRASSL+TIR1YDTBFNseKHmR/7UdsJgs6ML
         cgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715067078; x=1715671878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmvUSPF9NLdKwnRj3AKR4GurwZOdKRkhI6zjFH5eUHs=;
        b=klPgoQrzbNqzgCzsmVZkcniQeQq4m79lHtx4RyqMxZ4zRIPTGn2FEvwa6ZDa6Z/qTc
         3M4Yl4p9R4VcQFOMiswnI5ptFd64wO2gZsBIk9PH7Nv44bY7Xt5uhzSWieowRTDwodly
         8fLMTmm/pj3U4jBxq/VSG+T2jG1TM4jTvPCCcssiG+3D7NVFSlASa7jfYdhpZLCLoked
         39MGv2lC+TtkGG18/WDDYB7r1P/1LZJrUGjMKukyPEoIDzq0RGLXRDJlkFJ664L1JK0e
         xZ5G85P3xWPRSaoSrd7+IWi0km2qjTHBrYifrqYww2kCM6Q9CuLEQ28SI/fiQcdsdHUY
         /K1Q==
X-Gm-Message-State: AOJu0YwXxa0ZPkA7zClgH/mqMObAgUJWja9M4BDLnP96GC/+XeXGOnk1
	CBb6UMo6g9dkE4D4efNT1vWASjfl3x5LxABHWe52cFzVD67JrDrNSqSfeIaTF6WF6d5YK9rVdpE
	mA5P9OlQ7MGtBJFI9hypyGYmOc4hMowDYGgJ8
X-Google-Smtp-Source: AGHT+IGQZSlsjw7uuDsJIcANnt+RRPLu2NSiSFAcQK1pdWdPtWppC60ebjOLnnU/CkzIzKrfOhf3FIuGeJ8nQj+S8HU=
X-Received: by 2002:aa7:d0d9:0:b0:573:8b4:a0a6 with SMTP id
 4fb4d7f45d1cf-57313156605mr82751a12.5.1715067077628; Tue, 07 May 2024
 00:31:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkJfYOoJZZnXioMsaHNHVj8e77Ch8UqKhNcR_UrzU9tJUKoSg@mail.gmail.com>
In-Reply-To: <CAEkJfYOoJZZnXioMsaHNHVj8e77Ch8UqKhNcR_UrzU9tJUKoSg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 7 May 2024 09:31:03 +0200
Message-ID: <CANn89iLFvGd+=YCbzm==fA3Q0dj=FC-gTZy3kVJ0DTpZ5hZC8w@mail.gmail.com>
Subject: Re: [Linux kernel bug] general protection fault in nexthop_is_blackhole
To: Sam Sun <samsun1006219@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 9:00=E2=80=AFAM Sam Sun <samsun1006219@gmail.com> wr=
ote:
>
> Dear developers and maintainers,
>
> We encountered a general protection fault in function
> nexthop_is_blackhole. It was tested against the latest upstream linux
> (tag 6.9-rc7). C repro and kernel config are attached to this email.
> Kernel crash log is listed below.

This is another reiserfs bug, please let's not be mistaken.

We have dozens of syzbot reports about reiserfs.

Thank you.

> ```
> general protection fault, probably for non-canonical address
> 0xdffffc0080008015: 0000 [#1] PREEMPT SMP KASAN NOPTI
> KASAN: probably user-memory-access in range
> [0x00000004000400a8-0x00000004000400af]
> CPU: 1 PID: 7959 Comm: kworker/u8:2 Not tainted 6.9.0-rc6 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> Workqueue: ipv6_addrconf addrconf_dad_work
> RIP: 0010:nexthop_is_blackhole+0x23/0x2a0 include/net/nexthop.h:370
> Code: 00 00 00 0f 1f 40 00 55 41 57 41 56 53 48 89 fb 49 bf 00 00 00
> 00 00 fc ff df e8 58 c1 b6 f7 4c 8d 73 66 4c 89 f0 48 c1 e8 03 <42> 8a
> 04 38 84 c0 0f 85 17 02 00 00 41 0f b6 2e 31 ff 89 ee e8 44
> RSP: 0018:ffffc900001d81f8 EFLAGS: 00010203
> RAX: 0000000080008015 RBX: 0000000400040048 RCX: ffff88801cbfa500
> RDX: 0000000080000101 RSI: 0000000000000000 RDI: 0000000400040048
> RBP: ffffc900001d8398 R08: ffffffff89d8fd23 R09: 0000000000000021
> R10: ffffc900001d84c0 R11: fffffbfff2273299 R12: ffff88807857e800
> R13: 1ffff1100f0afd0c R14: 00000004000400ae R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff8880be400000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fa8a2420630 CR3: 00000000264f6000 CR4: 0000000000750ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  <IRQ>
>  __find_rr_leaf+0x521/0x890 net/ipv6/route.c:817
>  find_rr_leaf net/ipv6/route.c:861 [inline]
>  rt6_select net/ipv6/route.c:896 [inline]
>  fib6_table_lookup+0x56f/0xbb0 net/ipv6/route.c:2193
>  ip6_pol_route+0x272/0x1580 net/ipv6/route.c:2229
>  pol_lookup_func include/net/ip6_fib.h:614 [inline]
>  fib6_rule_lookup+0x571/0x780 net/ipv6/fib6_rules.c:116
>  ip6_route_input_lookup net/ipv6/route.c:2298 [inline]
>  ip6_route_input+0x839/0xd10 net/ipv6/route.c:2594
>  ip6_rcv_finish net/ipv6/ip6_input.c:77 [inline]
>  NF_HOOK include/linux/netfilter.h:314 [inline]
>  ipv6_rcv+0x1dc/0x200 net/ipv6/ip6_input.c:310
>  __netif_receive_skb_one_core net/core/dev.c:5544 [inline]
>  __netif_receive_skb+0x1dc/0x640 net/core/dev.c:5658
>  process_backlog+0x361/0x790 net/core/dev.c:5987
>  __napi_poll+0xca/0x480 net/core/dev.c:6638
>  napi_poll net/core/dev.c:6707 [inline]
>  net_rx_action+0x7c0/0x10a0 net/core/dev.c:6822
>  __do_softirq+0x272/0x734 kernel/softirq.c:554
>  do_softirq+0xfe/0x1b0 kernel/softirq.c:455
>  </IRQ>
>  <TASK>
>  __local_bh_enable_ip+0x18a/0x1c0 kernel/softirq.c:382
>  local_bh_enable include/linux/bottom_half.h:33 [inline]
>  rcu_read_unlock_bh include/linux/rcupdate.h:851 [inline]
>  __dev_queue_xmit+0x1d13/0x3a60 net/core/dev.c:4368
>  neigh_output include/net/neighbour.h:542 [inline]
>  ip6_finish_output2+0xfcf/0x1600 net/ipv6/ip6_output.c:137
>  ip6_finish_output+0x3c8/0x7f0 net/ipv6/ip6_output.c:222
>  NF_HOOK include/linux/netfilter.h:314 [inline]
>  ndisc_send_skb+0xa39/0xf40 net/ipv6/ndisc.c:509
>  addrconf_dad_completed+0x734/0xc60 net/ipv6/addrconf.c:4358
>  addrconf_dad_work+0xd82/0x16b0
>  process_one_work kernel/workqueue.c:3254 [inline]
>  process_scheduled_works+0x9c9/0x14a0 kernel/workqueue.c:3335
>  worker_thread+0x85c/0xd50 kernel/workqueue.c:3416
>  kthread+0x2ed/0x390 kernel/kthread.c:388
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:nexthop_is_blackhole+0x23/0x2a0 include/net/nexthop.h:370
> Code: 00 00 00 0f 1f 40 00 55 41 57 41 56 53 48 89 fb 49 bf 00 00 00
> 00 00 fc ff df e8 58 c1 b6 f7 4c 8d 73 66 4c 89 f0 48 c1 e8 03 <42> 8a
> 04 38 84 c0 0f 85 17 02 00 00 41 0f b6 2e 31 ff 89 ee e8 44
> RSP: 0018:ffffc900001d81f8 EFLAGS: 00010203
>
> RAX: 0000000080008015 RBX: 0000000400040048 RCX: ffff88801cbfa500
> RDX: 0000000080000101 RSI: 0000000000000000 RDI: 0000000400040048
> RBP: ffffc900001d8398 R08: ffffffff89d8fd23 R09: 0000000000000021
> R10: ffffc900001d84c0 R11: fffffbfff2273299 R12: ffff88807857e800
> R13: 1ffff1100f0afd0c R14: 00000004000400ae R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff8880be400000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fa8a2420630 CR3: 00000000264f6000 CR4: 0000000000750ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> ----------------
> Code disassembly (best guess), 1 bytes skipped:
>    0: 00 00                 add    %al,(%rax)
>    2: 0f 1f 40 00           nopl   0x0(%rax)
>    6: 55                   push   %rbp
>    7: 41 57                 push   %r15
>    9: 41 56                 push   %r14
>    b: 53                   push   %rbx
>    c: 48 89 fb             mov    %rdi,%rbx
>    f: 49 bf 00 00 00 00 00 movabs $0xdffffc0000000000,%r15
>   16: fc ff df
>   19: e8 58 c1 b6 f7       callq  0xf7b6c176
>   1e: 4c 8d 73 66           lea    0x66(%rbx),%r14
>   22: 4c 89 f0             mov    %r14,%rax
>   25: 48 c1 e8 03           shr    $0x3,%rax
> * 29: 42 8a 04 38           mov    (%rax,%r15,1),%al <-- trapping instruc=
tion
>   2d: 84 c0                 test   %al,%al
>   2f: 0f 85 17 02 00 00     jne    0x24c
>   35: 41 0f b6 2e           movzbl (%r14),%ebp
>   39: 31 ff                 xor    %edi,%edi
>   3b: 89 ee                 mov    %ebp,%esi
>   3d: e8                   .byte 0xe8
>   3e: 44                   rex.R
> ```
> If you have any questions, please contact us.
>
> Reported by Yue Sun <samsun1006219@gmail.com>
> Reported by xingwei lee <xrivendell7@gmail.com>
>
> Best Regards,
> Yue

