Return-Path: <linux-kernel+bounces-200592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9058FB22F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A39BB231B3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A2414659E;
	Tue,  4 Jun 2024 12:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UAioSYKN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KNLutEuZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950D7145FFE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 12:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504201; cv=none; b=FwSIu8YCtuBuLq0g8MdeSzJ1/3nNkGlEkpzjRb6gSD/SRTmiX2kHiTVzDmKRAuq+ZaWltbvYgipuwjgvY0xGNX2GfDwGp5iusdWmOykSgI7g5HJif0IXj8UoO2hbFrtasfgDjZ3uY0kUYtM0nbGCX349GktumVP6y2LYpuVBHTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504201; c=relaxed/simple;
	bh=TJOzfauvLNWwPD1dWOEGPJmzSN690CpNCdnKolTpWrk=;
	h=From:To:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=VlXz0Qw/nYYB6rxA/NNLwxPLeUcDwkcpVb1xZDgm1fv1AEYvbc6wPcgdGmn3GF88oBMU2PD2MP/nAiiywVKQNvMXHgNqc5+9e3ptwYZ5O2gLzzUjREoHlR10zuAAdifen054WKrNoY7ZL8R3b1eVRkjWxD56ovFai5adM6aorS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UAioSYKN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KNLutEuZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717504197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=VeELoGITZ8SPTjMDbmFUyhi5ZhPSslQrZweXZ3cin6Q=;
	b=UAioSYKNrGZQWZo/lEGzsYCsn7Cl54IIjl/a2e6UfwN19iy+blEYqZa1+R27o8QBQ2bV37
	M6y5A1M1AUe4CW7dlTCtbySwaJMfrLd3hylAZ9Pp+0sRrdsq/zUE3QXWJRPavMjSx8w7OX
	ebnwBq7uN+7Gw+C5g9tH9MSzBMAG2+RXGyA37YSENSqq4CCQ2gPDzefO6OGLxCpfOSpb37
	/xqMaA1FNBw50ice8gVBOSYjwGOppjDsMq+eBCi+t6M/ovCrPY+ZF2FV7dxSekLsfx8HNk
	e8m1SelECh5DRqr14zao8pyGgG/JWfmoCDgQieNQFmZECiQ6fTapDxT3CNrrbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717504197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=VeELoGITZ8SPTjMDbmFUyhi5ZhPSslQrZweXZ3cin6Q=;
	b=KNLutEuZdppohhq7PVDq7QbvpLqIzYJJBAN+M4LvXz8rVSu4O5hszknh522CiZlg/5dIms
	Ot/rbqJvAIOR0wAw==
To: syzbot <syzbot+558f67d44ad7f098a3de@syzkaller.appspotmail.com>,
 anna-maria@linutronix.de, frederic@kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Subject: Re: [syzbot] [kernel?] BUG: unable to handle kernel NULL pointer
 dereference in __hrtimer_run_queues
In-Reply-To: <000000000000deb5250619f9b5f4@google.com>
Date: Tue, 04 Jun 2024 14:29:57 +0200
Message-ID: <87tti86gca.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jun 03 2024 at 03:22, syzbot wrote:

Cc+ ARM64 folks

Content untrimmed for reference.

> syzbot found the following issue on:
>
> HEAD commit:    4a4be1ad3a6e Revert "vfs: Delete the associated dentry whe..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1422a73c980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bd6024aedb15e15c
> dashboard link: https://syzkaller.appspot.com/bug?extid=558f67d44ad7f098a3de
> compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15583162980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c1b514980000
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-4a4be1ad.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/75957361122b/vmlinux-4a4be1ad.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/6c766b0ec377/Image-4a4be1ad.gz.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+558f67d44ad7f098a3de@syzkaller.appspotmail.com
>
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000090
> Mem abort info:
>   ESR = 0x0000000096000006
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x06: level 2 translation fault
> Data abort info:
>   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
>   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> user pgtable: 4k pages, 52-bit VAs, pgdp=000000004605bb80
> [0000000000000090] pgd=08000000464ee003, p4d=08000000472aa003, pud=08000000471b8003, pmd=0000000000000000
> Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 0 PID: 3192 Comm: syz-executor607 Not tainted 6.10.0-rc1-syzkaller-00027-g4a4be1ad3a6e #0
> Hardware name: linux,dummy-virt (DT)
> pstate: 204000c9 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : rb_next+0x1c/0x54 lib/rbtree.c:505
> lr : rb_erase_cached include/linux/rbtree.h:124 [inline]
> lr : timerqueue_del+0x38/0x70 lib/timerqueue.c:57
> sp : ffff800080003e70
> x29: ffff800080003e70 x28: 0000000000000000 x27: fff000007f8cf780
> x26: 0000000000000001 x25: 00000000000000c0 x24: 0000001f0198bc90
> x23: fff000007f8cf780 x22: fff000007f8cf7e0 x21: fff000007f8cf780
> x20: fff000007f8cf7e0 x19: ffff800088c3bd60 x18: 0000000000000000
> x17: fff07ffffd319000 x16: ffff800080000000 x15: 0000ffffef309d38
> x14: 00000000000003bb x13: 0000000000000000 x12: ffff8000825e0028
> x11: 0000000000000001 x10: 0000000000000200 x9 : 0000000000200000
> x8 : 0008000000000000 x7 : ff7ffffffffffbff x6 : 00000000019a23f5
> x5 : fff07ffffd319000 x4 : 000000000a2dca90 x3 : ffff800088c3bd60
> x2 : ff7000007f8cf8e8 x1 : 0000000000000080 x0 : 0000000000000080
> Call trace:
>  rb_next+0x1c/0x54 lib/rbtree.c:505
>  __remove_hrtimer kernel/time/hrtimer.c:1118 [inline]
>  __run_hrtimer kernel/time/hrtimer.c:1667 [inline]
>  __hrtimer_run_queues+0x104/0x1bc kernel/time/hrtimer.c:1751
>  hrtimer_interrupt+0xe8/0x244 kernel/time/hrtimer.c:1813
>  timer_handler drivers/clocksource/arm_arch_timer.c:674 [inline]
>  arch_timer_handler_phys+0x2c/0x44 drivers/clocksource/arm_arch_timer.c:692
>  handle_percpu_devid_irq+0x84/0x130 kernel/irq/chip.c:942
>  generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
>  handle_irq_desc kernel/irq/irqdesc.c:691 [inline]
>  generic_handle_domain_irq+0x2c/0x44 kernel/irq/irqdesc.c:747
>  gic_handle_irq+0x40/0xc4 drivers/irqchip/irq-gic.c:370
>  call_on_irq_stack+0x24/0x4c arch/arm64/kernel/entry.S:889
>  do_interrupt_handler+0x80/0x84 arch/arm64/kernel/entry-common.c:310
>  __el1_irq arch/arm64/kernel/entry-common.c:536 [inline]
>  el1_interrupt+0x34/0x64 arch/arm64/kernel/entry-common.c:551
>  el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:556
>  el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:594
>  __clear_young_dirty_ptes arch/arm64/include/asm/pgtable.h:1311 [inline]
>  contpte_clear_young_dirty_ptes+0x68/0x128 arch/arm64/mm/contpte.c:389
>  walk_pmd_range mm/pagewalk.c:143 [inline]
>  walk_pud_range mm/pagewalk.c:221 [inline]
>  walk_p4d_range mm/pagewalk.c:256 [inline]
>  walk_pgd_range+0x4b0/0x8a4 mm/pagewalk.c:293
>  __walk_page_range+0x178/0x180 mm/pagewalk.c:395
>  walk_page_range+0x144/0x224 mm/pagewalk.c:521
>  madvise_free_single_vma+0x134/0x2bc mm/madvise.c:815
>  madvise_dontneed_free mm/madvise.c:929 [inline]
>  madvise_vma_behavior+0x1d0/0x790 mm/madvise.c:1046
>  madvise_walk_vmas+0xbc/0x12c mm/madvise.c:1268
>  do_madvise+0x160/0x418 mm/madvise.c:1464
>  __do_sys_madvise mm/madvise.c:1481 [inline]
>  __se_sys_madvise mm/madvise.c:1479 [inline]
>  __arm64_sys_madvise+0x24/0x34 mm/madvise.c:1479
>  __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
>  invoke_syscall+0x48/0x118 arch/arm64/kernel/syscall.c:48
>  el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:133
>  do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:152
>  el0_svc+0x34/0xf8 arch/arm64/kernel/entry-common.c:712
>  el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
>  el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598
> Code: 54000200 f9400401 b4000141 aa0103e0 (f9400821) 
> ---[ end trace 0000000000000000 ]---
> ----------------
> Code disassembly (best guess):
>    0:	54000200 	b.eq	0x40  // b.none
>    4:	f9400401 	ldr	x1, [x0, #8]
>    8:	b4000141 	cbz	x1, 0x30
>    c:	aa0103e0 	mov	x0, x1
> * 10:	f9400821 	ldr	x1, [x1, #16] <-- trapping instruction

So this is the following code in rb_next():

>    4:	f9400401 	ldr	x1, [x0, #8]    // Offset 8 in @node
>    8:	b4000141 	cbz	x1, 0x30
	if (node->rb_right) {

>    c:	aa0103e0 	mov	x0, x1          // Saves node::rb_right
		node = node->rb_right;

> * 10:	f9400821 	ldr	x1, [x1, #16] <-- trapping instruction
		while (node->rb_left)

> x2 : ff7000007f8cf8e8 x1 : 0000000000000080 x0 : 0000000000000080

which obviously crashes. Now the question is how does the original node
end up with node::rb_right == 0x80?

I doubt that this is a hrtimer or rbtree problem. It smells like random
data corruption caused by whatever. It might not even be an ARM64
specific issue though the C repro does not trigger on x86...

Handing it over to Catalin and Will.

Thanks,

	tglx

