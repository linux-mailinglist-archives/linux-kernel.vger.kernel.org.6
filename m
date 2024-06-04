Return-Path: <linux-kernel+bounces-200712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCC08FB3E0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F00BF1F249D7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DB2146A9F;
	Tue,  4 Jun 2024 13:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KprWGFP2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2CE1E49B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717508093; cv=none; b=i3uPYpPYSKWuXw0YiEOcNZLe34I02OxOytmeUZyoc9WZX+YSR9hR9tiewM6paHnIePMb57V6fyN3yOPMK1qMimw7RN5bSg7zpbBD1RiztFtEKWj0fKLmMfm0q2JlZiR3sHVZhtjF2oU/4kkXDe5E+hRgjS7RI/iDUp2ebL+K1tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717508093; c=relaxed/simple;
	bh=2/0eTF3aI16EsyaJVX+S/2Iejcecwnq2sJ9sJCP4F38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESZG442zkFbHt4ios6X5BftlN12p8PX62uA4GoiVvlDfroPo4RGSNVbQeRV9mHGRexfgr0UqpmHvZUnqgYImrsr6P4Rmlr3SNO+biRsESWgkLKHjeSMlfrs2OGqqFcAaDQGCGjMsxpchH/iKlTcBP/XBK7m6Si2vUFLq8bZIG5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KprWGFP2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E210CC2BBFC;
	Tue,  4 Jun 2024 13:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717508093;
	bh=2/0eTF3aI16EsyaJVX+S/2Iejcecwnq2sJ9sJCP4F38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KprWGFP2mXQnQIdQj4aiGoUk651aXXGAtq+8uL4TEcpfDXd88Qj25C8ARr/R0eqJ2
	 hB7A1/EppYcCFxiluxOdmsgwIRBlPL1RI85b4sBEcohum7XsUyqF3syralQmBAgs46
	 QbZjO2qRCEhoZJhjdDSyrgRob7fZQ0FcYfiuJW9JiGMiEmsrziZUicaBFxpLrxyLSY
	 GF3RhdT0ClKNtddIl7eB2Vy5wxuayCxkwZ2jdkbBWQKWT4mgwoIzgCZbeEt6j586s/
	 z5+dc/1ZKcswY0eCaoskCJIm6rouuoqpLEaw+YI0dB5wJ0a/p8c9FrmTstsvd51T2K
	 sK8kJXXl8tXVg==
Date: Tue, 4 Jun 2024 14:34:48 +0100
From: Will Deacon <will@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: syzbot <syzbot+558f67d44ad7f098a3de@syzkaller.appspotmail.com>,
	anna-maria@linutronix.de, frederic@kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [syzbot] [kernel?] BUG: unable to handle kernel NULL pointer
 dereference in __hrtimer_run_queues
Message-ID: <20240604133448.GB20384@willie-the-truck>
References: <000000000000deb5250619f9b5f4@google.com>
 <87tti86gca.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tti86gca.ffs@tglx>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Thomas,

On Tue, Jun 04, 2024 at 02:29:57PM +0200, Thomas Gleixner wrote:
> On Mon, Jun 03 2024 at 03:22, syzbot wrote:
> Cc+ ARM64 folks
> 
> Content untrimmed for reference.

Thanks! I'll trim it now...

> >  __clear_young_dirty_ptes arch/arm64/include/asm/pgtable.h:1311 [inline]
> >  contpte_clear_young_dirty_ptes+0x68/0x128 arch/arm64/mm/contpte.c:389
> >  walk_pmd_range mm/pagewalk.c:143 [inline]
> >  walk_pud_range mm/pagewalk.c:221 [inline]
> >  walk_p4d_range mm/pagewalk.c:256 [inline]
> >  walk_pgd_range+0x4b0/0x8a4 mm/pagewalk.c:293
> >  __walk_page_range+0x178/0x180 mm/pagewalk.c:395
> >  walk_page_range+0x144/0x224 mm/pagewalk.c:521
> >  madvise_free_single_vma+0x134/0x2bc mm/madvise.c:815
> >  madvise_dontneed_free mm/madvise.c:929 [inline]
> >  madvise_vma_behavior+0x1d0/0x790 mm/madvise.c:1046
> >  madvise_walk_vmas+0xbc/0x12c mm/madvise.c:1268
> >  do_madvise+0x160/0x418 mm/madvise.c:1464
> >  __do_sys_madvise mm/madvise.c:1481 [inline]
> >  __se_sys_madvise mm/madvise.c:1479 [inline]
> >  __arm64_sys_madvise+0x24/0x34 mm/madvise.c:1479
> >  __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
> >  invoke_syscall+0x48/0x118 arch/arm64/kernel/syscall.c:48
> >  el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:133
> >  do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:152
> >  el0_svc+0x34/0xf8 arch/arm64/kernel/entry-common.c:712
> >  el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
> >  el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598
> > Code: 54000200 f9400401 b4000141 aa0103e0 (f9400821) 
> > ---[ end trace 0000000000000000 ]---
> > ----------------
> > Code disassembly (best guess):
> >    0:	54000200 	b.eq	0x40  // b.none
> >    4:	f9400401 	ldr	x1, [x0, #8]
> >    8:	b4000141 	cbz	x1, 0x30
> >    c:	aa0103e0 	mov	x0, x1
> > * 10:	f9400821 	ldr	x1, [x1, #16] <-- trapping instruction
> 
> So this is the following code in rb_next():
> 
> >    4:	f9400401 	ldr	x1, [x0, #8]    // Offset 8 in @node
> >    8:	b4000141 	cbz	x1, 0x30
> 	if (node->rb_right) {
> 
> >    c:	aa0103e0 	mov	x0, x1          // Saves node::rb_right
> 		node = node->rb_right;
> 
> > * 10:	f9400821 	ldr	x1, [x1, #16] <-- trapping instruction
> 		while (node->rb_left)
> 
> > x2 : ff7000007f8cf8e8 x1 : 0000000000000080 x0 : 0000000000000080
> 
> which obviously crashes. Now the question is how does the original node
> end up with node::rb_right == 0x80?
> 
> I doubt that this is a hrtimer or rbtree problem. It smells like random
> data corruption caused by whatever. It might not even be an ARM64
> specific issue though the C repro does not trigger on x86...
> 
> Handing it over to Catalin and Will.

I suspect this is a duplicate of:

https://lore.kernel.org/lkml/20240604110119.GA20284@willie-the-truck/

and there's a fix queued in the -mm tree.

Will

