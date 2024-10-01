Return-Path: <linux-kernel+bounces-346054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C031C98BECA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77E8B1F223B6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F1D1A073B;
	Tue,  1 Oct 2024 14:00:19 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD282AF17
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 14:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791218; cv=none; b=SvMQpgS4zfvy6QECTj11KI5ACpwDC13kU1aKia0R441XtCFApgiGlRyWaNZvREKKQHZeVUjJPNpePDIqoWVNwQNwRzsFwwQEh7IeVE79nbfG7YSTELoqhuiw7klukhdMg/lF7CU3i0mYBH/OiywWQwNnGldR6U4W65tGx9zBamI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791218; c=relaxed/simple;
	bh=c6bkCprnVGxCzbSLQ6VUnR5hthIg+fEnn5lhuFHtn94=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ar8yI6Kgm2+JscUkKLC9mMvWHft87VOwSe1s86XcqkubuA0tuMrS25yGQ/7ZKVPSUXV+5GKispfthgkTZ/+BJHQbceCRvT2RjfV6Se1xzSlpLQU0uOpWAz8IwgkGXrMYuL6tionhpVVw65/PctJavZHo2FYogv8wLD7MPB7HnKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7541E20003;
	Tue,  1 Oct 2024 14:00:06 +0000 (UTC)
Message-ID: <87666751-24c3-4c91-a2ce-689731526539@ghiti.fr>
Date: Tue, 1 Oct 2024 16:00:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [riscv?] riscv/fixes test error: kernel panic: Kernel
 stack overflow
Content-Language: en-US
To: syzbot <syzbot+ba9eac24453387a9d502@syzkaller.appspotmail.com>,
 aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, syzkaller-bugs@googlegroups.com
References: <000000000000eb301906222aadc2@google.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <000000000000eb301906222aadc2@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

On 15/09/2024 18:09, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    7c1e5b9690b0 riscv: Disable preemption while handling PR_R..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
> console output: https://syzkaller.appspot.com/x/log.txt?x=1618e900580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c79e90d7b2f5b364
> dashboard link: https://syzkaller.appspot.com/bug?extid=ba9eac24453387a9d502
> compiler:       riscv64-linux-gnu-gcc (Debian 12.2.0-13) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: riscv64
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/a741b348759c/non_bootable_disk-7c1e5b96.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/71b65c326093/vmlinux-7c1e5b96.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/4110f50eed32/Image-7c1e5b96.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ba9eac24453387a9d502@syzkaller.appspotmail.com
>
>   s11: ff60000011ee5b20 t3 : ffffffffffffffff t4 : fffffffef12c91f0
>   t5 : ffffffff89655e40 t6 : 1fec0000023dcb6d
> status: 0000000200000100 badaddr: ff20000000087fe8 cause: 000000000000000f
> Kernel panic - not syncing: Kernel stack overflow
> CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.11.0-rc2-syzkaller-g7c1e5b9690b0 #0
> Hardware name: riscv-virtio,qemu (DT)
> Call Trace:
> [<ffffffff80010216>] dump_backtrace+0x2e/0x3c arch/riscv/kernel/stacktrace.c:130
> [<ffffffff85edbd86>] show_stack+0x34/0x40 arch/riscv/kernel/stacktrace.c:136
> [<ffffffff85f3735e>] __dump_stack lib/dump_stack.c:93 [inline]
> [<ffffffff85f3735e>] dump_stack_lvl+0x108/0x196 lib/dump_stack.c:119
> [<ffffffff85f37408>] dump_stack+0x1c/0x24 lib/dump_stack.c:128
> [<ffffffff85edc94a>] panic+0x388/0x806 kernel/panic.c:348
> [<ffffffff8000fcee>] handle_bad_stack+0xe4/0x10c arch/riscv/kernel/traps.c:427
> [<ffffffff8022b788>] __bfs_backwards kernel/locking/lockdep.c:1843 [inline]
> [<ffffffff8022b788>] check_irq_usage+0x1d6/0x1466 kernel/locking/lockdep.c:2803
> SMP: stopping secondary CPUs
> Rebooting in 86400 seconds..
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
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


So this one should be fixed by 
https://lore.kernel.org/all/20240917150328.59831-1-alexghiti@rivosinc.com/T/


