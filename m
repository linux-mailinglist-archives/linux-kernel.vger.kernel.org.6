Return-Path: <linux-kernel+bounces-387115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD0A9B4C1D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9D01F23ED3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB244206071;
	Tue, 29 Oct 2024 14:34:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA78C1361
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 14:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730212440; cv=none; b=MQ1oAY223WwC21AakS6kH/HtkARAnlY0vPgglN97UH6BxSi0vG65l4YAwpCxokCNTrCLr3GeGwZ45Cl6gLYA1V8/Lghq23c2LOlIPrfJRF7GcElUy+1ELvRp2MbAMtwOt3c/fLjmfQdBj756WYuTQ40ZRGDLJDH8HuZsnRVt4TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730212440; c=relaxed/simple;
	bh=YLL2DOnemOBKc88nQor3vSq0i9aXBHX+krJlYksMrNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTHQvjwa+YZRk7GpJ1Hbeed3J/Y59/u68LBm4WUEPrQ9tvUA/0RDdcjBX5bLe1CjAtAdJp33mPsiILStUOqdzP0Og9YYIQFaQrjkmSL8Qf4fSmj6hCjGqhEJotLywH6yugE5Gj/r7EWosks+RS9YWosVapdoxlvQ8G/u72xBf3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C78CC13D5;
	Tue, 29 Oct 2024 07:34:26 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD8433F528;
	Tue, 29 Oct 2024 07:33:49 -0700 (PDT)
Date: Tue, 29 Oct 2024 14:33:47 +0000
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
Subject: Re: [PATCH -next v4 02/19] arm64: entry: Refactor the entry and exit
 for exceptions from EL1
Message-ID: <ZyDyS4TT6xgRIN1w@J2N7QTR9R3.cambridge.arm.com>
References: <20241025100700.3714552-1-ruanjinjie@huawei.com>
 <20241025100700.3714552-3-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025100700.3714552-3-ruanjinjie@huawei.com>

On Fri, Oct 25, 2024 at 06:06:43PM +0800, Jinjie Ruan wrote:
> These changes refactor the entry and exit routines for the exceptions
> from EL1. They store the RCU and lockdep state in a struct
> irqentry_state variable on the stack, rather than recording them
> in the fields of pt_regs, since it is safe enough for these context.

In general, please descirbe *why* we want to make the change first, e.g.

| The generic entry code uses irqentry_state_t to track lockdep and RCU
| state across exception entry and return. For historical reasons, arm64
| embeds similar fields within its pt_regs structure.
|
| In preparation for moving arm64 over to the generic entry code, pull
| these fields out of arm64's pt_regs, and use a seperate structure,
| matching the style of the generic entry code.

> Before:
> 	struct pt_regs {
> 		...
> 		u64 lockdep_hardirqs;
> 		u64 exit_rcu;
> 	}
> 
> 	enter_from_kernel_mode(regs);
> 	...
> 	exit_to_kernel_mode(regs);
> 
> After:
> 	typedef struct irqentry_state {
> 		union {
> 			bool    exit_rcu;
> 			bool    lockdep;
> 		};
> 	} irqentry_state_t;
> 
> 	irqentry_state_t state = enter_from_kernel_mode(regs);
> 	...
> 	exit_to_kernel_mode(regs, state);

I don't think this part is necessary.

> 
> No functional changes.
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/arm64/include/asm/ptrace.h  |  11 ++-
>  arch/arm64/kernel/entry-common.c | 129 +++++++++++++++++++------------
>  2 files changed, 85 insertions(+), 55 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
> index 3e5372a98da4..5156c0d5fa20 100644
> --- a/arch/arm64/include/asm/ptrace.h
> +++ b/arch/arm64/include/asm/ptrace.h
> @@ -149,6 +149,13 @@ static inline unsigned long pstate_to_compat_psr(const unsigned long pstate)
>  	return psr;
>  }
>  
> +typedef struct irqentry_state {
> +	union {
> +		bool	exit_rcu;
> +		bool	lockdep;
> +	};
> +} irqentry_state_t;

AFAICT this can be moved directly into arch/arm64/kernel/entry-common.c.

> +
>  /*
>   * This struct defines the way the registers are stored on the stack during an
>   * exception. struct user_pt_regs must form a prefix of struct pt_regs.
> @@ -169,10 +176,6 @@ struct pt_regs {
>  
>  	u64 sdei_ttbr1;
>  	struct frame_record_meta stackframe;
> -
> -	/* Only valid for some EL1 exceptions. */
> -	u64 lockdep_hardirqs;
> -	u64 exit_rcu;
>  };
>  
>  /* For correct stack alignment, pt_regs has to be a multiple of 16 bytes. */
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index c547e70428d3..68a9aecacdb9 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -36,29 +36,36 @@
>   * This is intended to match the logic in irqentry_enter(), handling the kernel
>   * mode transitions only.
>   */
> -static __always_inline void __enter_from_kernel_mode(struct pt_regs *regs)
> +static __always_inline irqentry_state_t __enter_from_kernel_mode(struct pt_regs *regs)
>  {
> -	regs->exit_rcu = false;
> +	irqentry_state_t ret = {
> +		.exit_rcu = false,
> +	};

I realise that the generic entry code calls this 'ret' in
irqentry_enter() and similar, but could we please use 'state'
consistently in the arm64 code?

[...]

>  /*
> @@ -190,9 +199,11 @@ asmlinkage void noinstr asm_exit_to_user_mode(struct pt_regs *regs)
>   * mode. Before this function is called it is not safe to call regular kernel
>   * code, instrumentable code, or any code which may trigger an exception.
>   */
> -static void noinstr arm64_enter_nmi(struct pt_regs *regs)
> +static noinstr irqentry_state_t arm64_enter_nmi(struct pt_regs *regs)
>  {
> -	regs->lockdep_hardirqs = lockdep_hardirqs_enabled();
> +	irqentry_state_t irq_state;

Likewise, please use 'state' rather than 'irq_state'.

In future we should probably have a separate structure for the NMI
paths, and get rid of the union, which would avoid the possiblity of
using mismatched helpers.

Mark.

