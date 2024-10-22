Return-Path: <linux-kernel+bounces-376330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DB39AA353
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A64F28428E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6899519DFA2;
	Tue, 22 Oct 2024 13:37:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681171C27
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 13:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729604271; cv=none; b=e4ZlrkCYFUkXGp04DzUkemOj6P8CbDxBDr3i/MObrBw5E/vOIs3INTTU67EYO44SlQ+jhg+Ae8ZghL+FB01oDjyZOL0EboPFyDUFqglDd1zhp0IMg288S9d8Gbo5/nyDeiZbNm0icGV5Jk/PnZToknWRCQ5av46r8za+lscq830=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729604271; c=relaxed/simple;
	bh=zsljSX+ReEHiwevouw+xqoLHzpP22pzX2BcC7uRcizE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cG18u6vHoJz0JRrPDA1EDrjcRvGn1sb49UOZAGGU2MGS+uvjg8c8v6D8rwyatXmUhPMCD4j4/+ZLUQgIXTTolJM1KoxEOY1/wKl11WztnsYfggWaVgvnZNblckaJVshauWCoqZHAExZr7R7fZf6Hex6zyW89uR4f+ykWLZUse/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B248497;
	Tue, 22 Oct 2024 06:38:17 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87FCF3F73B;
	Tue, 22 Oct 2024 06:37:44 -0700 (PDT)
Date: Tue, 22 Oct 2024 14:37:41 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oleg@redhat.com,
	tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
	kees@kernel.org, wad@chromium.org, rostedt@goodmis.org,
	arnd@arndb.de, ardb@kernel.org, broonie@kernel.org,
	rick.p.edgecombe@intel.com, leobras@redhat.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/3] arm64: entry: Convert to generic entry
Message-ID: <Zxeqpa7n1r03KV7t@J2N7QTR9R3>
References: <20240629085601.470241-1-ruanjinjie@huawei.com>
 <ZxEsZBvsirXJz2dT@J2N7QTR9R3.cambridge.arm.com>
 <2cc049fe-8f1a-0829-d879-d89278027be6@huawei.com>
 <ZxejvAmccYMTa4P1@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxejvAmccYMTa4P1@J2N7QTR9R3>

On Tue, Oct 22, 2024 at 02:08:12PM +0100, Mark Rutland wrote:
> On Tue, Oct 22, 2024 at 08:07:54PM +0800, Jinjie Ruan wrote:
> > On 2024/10/17 23:25, Mark Rutland wrote:
> > > There's also some indirection that I don't think is necessary *and*
> > > hides important ordering concerns and results in mistakes. In
> > > particular, note that before this series, enter_from_kernel_mode() calls
> > > the (instrumentable) MTE checks *after* all the necessary lockdep+RCU
> > > management is performed by __enter_from_kernel_mode():
> > > 
> > > 	static void noinstr enter_from_kernel_mode(struct pt_regs *regs)
> > > 	{
> > > 	        __enter_from_kernel_mode(regs);
> > > 		mte_check_tfsr_entry();
> > > 		mte_disable_tco_entry(current);
> > > 	}
> > > 
> > > ... whereas after this series is applied, those MTE checks are placed in
> > > arch_enter_from_kernel_mode(), which irqentry_enter() calls *before* the
> > > necessary lockdep+RCU management. That is broken.
> > > 
> > > It would be better to keep that explicit in the arm64 entry code with
> > > arm64-specific wrappers, e.g.
> > > 
> > > 	static noinstr irqentry_state_t enter_from_kernel_mode(struct pt_regs *regs)
> > > 	{
> > > 		irqentry_state_t state = irqentry_enter(regs);
> > > 		mte_check_tfsr_entry();
> > > 		mte_disable_tco_entry(current);
> > > 
> > > 		return state;
> > > 	}
> > 
> > Hi, Mark, It seems that there is a problem for
> > arm64_preempt_schedule_irq() when wrap irqentry_exit() with
> > exit_to_kernel_mode().
> > 
> > The arm64_preempt_schedule_irq() is about PREEMPT_DYNAMIC and preempt
> > irq which is the raw_irqentry_exit_cond_resched() in generic code called
> > by irqentry_exit().
> > 
> > Only __el1_irq() call arm64_preempt_schedule_irq(), but when we switch
> > all exit_to_kernel_mode() to arm64-specific one that wrap
> > irqentry_exit(), not only __el1_irq() but also el1_abort(), el1_pc(),
> > el1_undef() etc. will try to reschedule by calling
> > arm64_preempt_schedule_irq() similar logic.
> 
> Yes, the generic entry code will preempt any context where an interrupt
> *could* have been taken from.
> 
> I'm not sure it actually matters either way; I believe that the generic
> entry code was written this way because that's what x86 did, and
> checking for whether interrupts are enabled in the interrupted context
> is cheap.
> 
> I's suggest you first write a patch to align arm64's entry code with the
> generic code, by removing the call to arm64_preempt_schedule_irq() from
> __el1_irq(), and adding a call to arm64_preempt_schedule_irq() in
> __exit_to_kernel_mode(), e.g.
> 
> | static __always_inline void __exit_to_kernel_mode(struct pt_regs *regs)
> | {
> | 	...
> | 	if (interrupts_enabled(regs)) {
> | 		...
> | 		if (regs->exit_rcu) {
> | 			...
> | 		}
> | 		...
> | 		arm64_preempt_schedule_irq();
> | 		...
> | 	} else {
> | 		...
> | 	}
> | }
> 
> That way the behaviour and structure will be more aligned with the
> generic code, and with that as an independent patch it will be easier to
> review/test/bisect/etc.
> 
> This change will have at least two key impacts:
> 
> (1) We'll preempt even without taking a "real" interrupt. That
>     shouldn't result in preemption that wasn't possible before, 
>     but it does change the probability of preempting at certain points,
>     and might have a performance impact, so probably warrants a
>     benchmark.
> 
> (2) We will not preempt when taking interrupts from a region of kernel
>     code where IRQs are enabled but RCU is not watching, matching the
>     behaviour of the generic entry code.
> 
>     This has the potential to introduce livelock if we can ever have a
>     screaming interrupt in such a region, so we'll need to go figure out
>     whether that's actually a problem.
> 
>     Having this as a separate patch will make it easier to test/bisect
>     for that specifically.

Looking some more, the pseudo-NMI DAIF check in
arm64_preempt_schedule_irq() is going to be a problem, becuase the
IRQ/NMI path manages DAIF distinctly from all other exception handlers.

I suspect we'll need to factor that out more in the generic entry code.

Mark.

