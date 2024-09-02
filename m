Return-Path: <linux-kernel+bounces-310825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D16F39681AF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62083282A5A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB14185B68;
	Mon,  2 Sep 2024 08:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DeBXiyC4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y4MVeBj5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FDC17A5BD
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725265574; cv=none; b=hxzBdY8nv6l9AbVyXUYUbueyfH8W5bOHbNib5PE2wooYgAl8w5k4W5ppL88h9pnOQVvWsc9OHrB0wt8sEeDBnOSxZbCmYu1HBBQvQ8qWl2Xt7Rl6bMYA8C12bUcAFiYKtgcV9+MZm54LrBqer9ysUMgMRiGyP/mVpwMLnZtc2Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725265574; c=relaxed/simple;
	bh=nmBl9sAHM51BZJE4rFRSUamfaIahwDY3T+X4Ktf45lM=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h1ZHPaEq5FGJq2JrdA6vt7I1Dd32Vy8ON8jXEK8lpmgoBTK4FGAouA3x545NIA3njg1rthniGj4mdZBtZ1VXTu1fSbJbD9/BY6GXN6GVqLnj8PounrZfyVOJB1fH13wcwMbwJk6Af6Y3QE46IzXBA5TGTcYdkjet2eG/5rPE23g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DeBXiyC4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y4MVeBj5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725265571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eF3PvzqmwhOKgO+9ni5+AK2f9itfVksLzdm/qhifh6I=;
	b=DeBXiyC4ZxrYXXWnKTV3MGdOeArOSdWxEMcAWa8H8TBRxdj7N8AiXTlO82qjNACX86YwZB
	Myhfc7MHSgRKA8NdyFLiEQQcv+98ABUs4Y5F5XcQakOwQbJ1eQErVmJIVZSpn/iUKtbtB2
	EDSeugzvMCxjUFYYmAfw5zqRfUe4Fbpy+Ovz66RbaenWQpklKsGZ0LbVPl2ZqCeQdEVEjd
	UB28/YLCz/7OyIE2hF4rA0wZglOhVxlRGbmd598e1eKUrM31Q6T6/Ucg+6i8GUHxlXkIz5
	WprGhsPBpNlEbv62eBknXLVvMEeHPvaKlRKIM5e4KGk26PeNVK+Z0Hdfxvwrmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725265571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eF3PvzqmwhOKgO+9ni5+AK2f9itfVksLzdm/qhifh6I=;
	b=y4MVeBj5OeAiajLIaOFICxqRQDiGFdtf/hSu2l3RC5UdNdTVpPCWyPkgv2zenQE0r+MKud
	T6DZd3UAHUtX/bAA==
To: syzbot <syzbot+6d392a44667baa45bb5a@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 x86@kernel.org, linux-mm@kvack.org
Subject: Re: [syzbot] [kernel?] KCSAN: data-race in pcpu_alloc_noprof /
 pcpu_balance_workfn (2)
In-Reply-To: <000000000000d47d440620d54f15@google.com>
References: <000000000000d47d440620d54f15@google.com>
Date: Mon, 02 Sep 2024 10:26:10 +0200
Message-ID: <87le0a797h.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 29 2024 at 09:53, syzbot wrote:

Cc-: x86 folks. Just because something happens on x86 does not mean it's
     an x86 problem

Cc+: mm folks. It's entirely clear where this belongs to:

> read-write to 0xffffffff88bb27ac of 4 bytes by task 3354 on cpu 0:
>  pcpu_update_empty_pages mm/percpu.c:602 [inline]

No?

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    d5d547aa7b51 Merge tag 'random-6.11-rc6-for-linus' of git:..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=164c067b980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6fafac02e339cc84
> dashboard link: https://syzkaller.appspot.com/bug?extid=6d392a44667baa45bb5a
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/e636aa58c364/disk-d5d547aa.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f5ecd0d96afa/vmlinux-d5d547aa.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/fe7d474f148f/bzImage-d5d547aa.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+6d392a44667baa45bb5a@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KCSAN: data-race in pcpu_alloc_noprof / pcpu_balance_workfn
>
> read-write to 0xffffffff88bb27ac of 4 bytes by task 3354 on cpu 0:
>  pcpu_update_empty_pages mm/percpu.c:602 [inline]
>  pcpu_chunk_populated mm/percpu.c:1531 [inline]
>  pcpu_balance_populated mm/percpu.c:2062 [inline]
>  pcpu_balance_workfn+0x94e/0xa60 mm/percpu.c:2212
>  process_one_work kernel/workqueue.c:3231 [inline]
>  process_scheduled_works+0x483/0x9a0 kernel/workqueue.c:3312
>  worker_thread+0x526/0x6e0 kernel/workqueue.c:3389
>  kthread+0x1d1/0x210 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> read to 0xffffffff88bb27ac of 4 bytes by task 6821 on cpu 1:
>  pcpu_alloc_noprof+0x9a7/0x10c0 mm/percpu.c:1894
>  bpf_map_alloc_percpu+0xad/0x210 kernel/bpf/syscall.c:466
>  prealloc_init+0x19f/0x470 kernel/bpf/hashtab.c:341
>  htab_map_alloc+0x630/0x8e0 kernel/bpf/hashtab.c:576
>  map_create+0x83c/0xb90 kernel/bpf/syscall.c:1333
>  __sys_bpf+0x667/0x7a0 kernel/bpf/syscall.c:5692
>  __do_sys_bpf kernel/bpf/syscall.c:5817 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5815 [inline]
>  __x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5815
>  x64_sys_call+0x2625/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:322
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> value changed: 0x00000001 -> 0x00000004
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 UID: 0 PID: 6821 Comm: syz.4.1651 Not tainted 6.11.0-rc5-syzkaller-00081-gd5d547aa7b51 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
> ==================================================================
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

