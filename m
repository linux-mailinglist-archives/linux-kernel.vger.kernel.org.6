Return-Path: <linux-kernel+bounces-387150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 344B09B4CA3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D62291C22B9C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DF7192589;
	Tue, 29 Oct 2024 14:52:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEF51714DF
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730213555; cv=none; b=uvXOJ2VBdyPngNUeAKqZQ3Bq/1mv5z1ryAi7igTchhR3lhTjWQ7HE8j2IZepUhBT/soCcvzw54HkplmPJa3RaoqofYaMg0e3QaAlkRpeBk2Y4KKbzpqLxMCsnBLhIfO5JxV2zE3OqSIRBVvPXgVaa034G6l3v2TeVw7EI5mHSdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730213555; c=relaxed/simple;
	bh=B5qDVdMZjYfgM+Ve78sgbPZp7770ctxdJi3kml9MYOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2BLs+REoaA7GHt7VfhPB3vFCDON1RtXD4wNQFmFwBKqYUC052OcoDIPiavapZHIk3PWVJ/VX6Mb3FM1ssdDICqRQ41mldAcHRWPKkfGVSjc9AInMTwbCiuvT7ITLaZvdWCVU3JZNaPAVV4vIyaCQKw8uDPGnUJkvBfUAW+mPIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FBD313D5;
	Tue, 29 Oct 2024 07:53:02 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BB213F73B;
	Tue, 29 Oct 2024 07:52:24 -0700 (PDT)
Date: Tue, 29 Oct 2024 14:52:22 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: oleg@redhat.com, linux@armlinux.org.uk, will@kernel.org,
	catalin.marinas@arm.com, sstabellini@kernel.org, maz@kernel.org,
	tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
	kees@kernel.org, wad@chromium.org, akpm@linux-foundation.org,
	samitolvanen@google.com, arnd@arndb.de, ojeda@kernel.org,
	rppt@kernel.org, hca@linux.ibm.com, aliceryhl@google.com,
	samuel.holland@sifive.com, paulmck@kernel.org, aquini@redhat.com,
	petr.pavlu@suse.com, viro@zeniv.linux.org.uk,
	rmk+kernel@armlinux.org.uk, ardb@kernel.org,
	wangkefeng.wang@huawei.com, surenb@google.com,
	linus.walleij@linaro.org, yangyj.ee@gmail.com, broonie@kernel.org,
	mbenes@suse.cz, puranjay@kernel.org, pcc@google.com,
	guohanjun@huawei.com, sudeep.holla@arm.com,
	Jonathan.Cameron@huawei.com, prarit@redhat.com, liuwei09@cestc.cn,
	dwmw@amazon.co.uk, oliver.upton@linux.dev,
	kristina.martsenko@arm.com, ptosi@google.com, frederic@kernel.org,
	vschneid@redhat.com, thiago.bauermann@linaro.org,
	joey.gouly@arm.com, liuyuntao12@huawei.com, leobras@redhat.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH -next v4 06/19] arm64: entry: Move
 arm64_preempt_schedule_irq() into exit_to_kernel_mode()
Message-ID: <ZyD2pk285YeVmZTm@J2N7QTR9R3.cambridge.arm.com>
References: <20241025100700.3714552-1-ruanjinjie@huawei.com>
 <20241025100700.3714552-7-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025100700.3714552-7-ruanjinjie@huawei.com>

On Fri, Oct 25, 2024 at 06:06:47PM +0800, Jinjie Ruan wrote:
> Move arm64_preempt_schedule_irq() into exit_to_kernel_mode(), so not
> only __el1_irq() but also every time when kernel mode irq return,
> there is a chance to reschedule.

We use exit_to_kernel_mode() for every non-NMI exception return to the
kernel, not just IRQ returns.

> As Mark pointed out, this change will have the following key impact:
> 
>     "We'll preempt even without taking a "real" interrupt. That
>     shouldn't result in preemption that wasn't possible before,
>     but it does change the probability of preempting at certain points,
>     and might have a performance impact, so probably warrants a
>     benchmark."

For anyone following along at home, I said that at:

  https://lore.kernel.org/linux-arm-kernel/ZxejvAmccYMTa4P1@J2N7QTR9R3/

... and there I specifically said:

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

[...]

> +#ifdef CONFIG_PREEMPT_DYNAMIC
> +DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
> +#define need_irq_preemption() \
> +	(static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
> +#else
> +#define need_irq_preemption()	(IS_ENABLED(CONFIG_PREEMPTION))
> +#endif
> +
> +static void __sched arm64_preempt_schedule_irq(void)
> +{
> +	if (!need_irq_preemption())
> +		return;
> +
> +	/*
> +	 * Note: thread_info::preempt_count includes both thread_info::count
> +	 * and thread_info::need_resched, and is not equivalent to
> +	 * preempt_count().
> +	 */
> +	if (READ_ONCE(current_thread_info()->preempt_count) != 0)
> +		return;
> +
> +	/*
> +	 * DAIF.DA are cleared at the start of IRQ/FIQ handling, and when GIC
> +	 * priority masking is used the GIC irqchip driver will clear DAIF.IF
> +	 * using gic_arch_enable_irqs() for normal IRQs. If anything is set in
> +	 * DAIF we must have handled an NMI, so skip preemption.
> +	 */
> +	if (system_uses_irq_prio_masking() && read_sysreg(daif))
> +		return;
> +
> +	/*
> +	 * Preempting a task from an IRQ means we leave copies of PSTATE
> +	 * on the stack. cpufeature's enable calls may modify PSTATE, but
> +	 * resuming one of these preempted tasks would undo those changes.
> +	 *
> +	 * Only allow a task to be preempted once cpufeatures have been
> +	 * enabled.
> +	 */
> +	if (system_capabilities_finalized())
> +		preempt_schedule_irq();
> +}
> +
>  /*
>   * Handle IRQ/context state management when exiting to kernel mode.
>   * After this function returns it is not safe to call regular kernel code,
> @@ -72,6 +114,8 @@ static noinstr irqentry_state_t enter_from_kernel_mode(struct pt_regs *regs)
>  static void noinstr exit_to_kernel_mode(struct pt_regs *regs,
>  					irqentry_state_t state)
>  {
> +	arm64_preempt_schedule_irq();

This is broken; exit_to_kernel_mode() is called for any non-NMI return
excpetion return to the kernel, and this doesn't check that interrupts
were enabled in the context the exception was taken from.

This will preempt in cases where we should not, e.g. if we WARN() in a section with
IRQs disabled.

Mark.

