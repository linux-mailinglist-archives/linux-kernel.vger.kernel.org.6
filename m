Return-Path: <linux-kernel+bounces-387154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C18769B4CAC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 580DDB21960
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4CD1917F9;
	Tue, 29 Oct 2024 14:55:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FCE1865E3
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730213723; cv=none; b=qcF78J7UhIl9NVrqklUd9wtvomawyxpiVMBQaNtYnWU0IugSZqd4uIZxlWPycwhQB0X/WGqllOWjjkvFpbdL7f+QWTUNy+5aowb7FLuYiHHw+pE1iLMzXcKyBGQnB3Yk4QZ1GEhl+Zdkd+yzvBjffMOES8uKqJk4HEct1qDXS8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730213723; c=relaxed/simple;
	bh=JlHXvgJnGEb453sEyMOjk4NNisDcclyj4gbBCMCxsMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWrVrwmP0uTWcPGNn7b+yteVnFO2pkmqANigRgPuKqFImYHl+cR2DF3YZ79kXqkC2FVDe0L6rfdVFD4Qe3kv+lAqEZ0jalJvCaEYw8u6rr4lFlmz/IZ9TpkiaFzfz3bzbX45L/51NbgVpnF+kvFgC5lWbwzJ3CMHWjowy7XO810=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA2C313D5;
	Tue, 29 Oct 2024 07:55:50 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B12463F73B;
	Tue, 29 Oct 2024 07:55:12 -0700 (PDT)
Date: Tue, 29 Oct 2024 14:55:10 +0000
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
Subject: Re: [PATCH -next v4 07/19] arm64: entry: Call
 arm64_preempt_schedule_irq() only if irqs enabled
Message-ID: <ZyD3TiU1Dk_zYsXE@J2N7QTR9R3.cambridge.arm.com>
References: <20241025100700.3714552-1-ruanjinjie@huawei.com>
 <20241025100700.3714552-8-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025100700.3714552-8-ruanjinjie@huawei.com>

On Fri, Oct 25, 2024 at 06:06:48PM +0800, Jinjie Ruan wrote:
> Only if irqs are enabled when the interrupt trapped, there may be
> a chance to reschedule after the interrupt has been handled, so move
> arm64_preempt_schedule_irq() into regs_irqs_disabled() check false
> if block.
> 
> As Mark pointed out, this change will have the following key impact:
> 
>     "We will not preempt when taking interrupts from a region of kernel
>     code where IRQs are enabled but RCU is not watching, matching the
>     behaviour of the generic entry code.
> 
>     This has the potential to introduce livelock if we can ever have a
>     screaming interrupt in such a region, so we'll need to go figure out
>     whether that's actually a problem.
> 
>     Having this as a separate patch will make it easier to test/bisect
>     for that specifically."
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

This should be folded into the prior patch.

Mark.

> ---
>  arch/arm64/kernel/entry-common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index e0380812d71e..b57f6dc66115 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -114,8 +114,6 @@ static void __sched arm64_preempt_schedule_irq(void)
>  static void noinstr exit_to_kernel_mode(struct pt_regs *regs,
>  					irqentry_state_t state)
>  {
> -	arm64_preempt_schedule_irq();
> -
>  	mte_check_tfsr_exit();
>  
>  	lockdep_assert_irqs_disabled();
> @@ -129,6 +127,8 @@ static void noinstr exit_to_kernel_mode(struct pt_regs *regs,
>  			return;
>  		}
>  
> +		arm64_preempt_schedule_irq();
> +
>  		trace_hardirqs_on();
>  	} else {
>  		if (state.exit_rcu)
> -- 
> 2.34.1
> 

