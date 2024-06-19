Return-Path: <linux-kernel+bounces-220920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CBD90E928
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ECA42855F9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29EE139CE9;
	Wed, 19 Jun 2024 11:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PfWd1mW/"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1BD80BF2
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 11:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718795989; cv=none; b=cT6jHeDGZk0G0LwhbFd5AHfdjxfo5szfpC0GaTtQYbi4+R3rB5Zt257VFjhakaKH8Rl8fOJsN5p20ttXgfoL+3WfUzluHcVj6G77ZgCitfFHfJiI3LBf40lMC3fL03JU9wQPcJmbCTsSWNju4SzlNNnBbmmOqBwrjGJXVJ8p6hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718795989; c=relaxed/simple;
	bh=MJAuoNo26CY9rnBM3Te4bCUU4S/R2FXk1XzR5ajd9s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AeJedtH4nYeaBEv3SO0e0dopvmvcItSdUAADpirtKZhRATTl297hHnbUY3tPl2nE/n42FgU9fyuCNO0uuI5GrZvmOo7C4TbAPURTkEvQi+AimjCtHySPN92L00Y6o1757b8wGI8IAajazm14kuZbsiti61j6ldpyZH2JdBNCK/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PfWd1mW/; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Z9JjQ6WiTHxkbEqzJwakWLkRiv6q9JNW7PPfhu16cxY=; b=PfWd1mW/QThGIz8kGhTQBz2llb
	XJToVQfo012zxzSOz4K90uIpjbCIiNtfxAmsDtMm9fGKtf3K7G1BersviFiATBsasevhNWBa95unH
	FpHwwC4ojudFi3pOi3Y5pFewCc8cRnVZV+4cWtTv2cd46e1EttrVI6SLUcJNlkhczx4HUgmso9f9f
	3BkcKsf6Wc7Gmbwhp4Bqqxj6LfFHtEoJJcgIN3ofBKbM90n/ke4LqH63u+SThMjD4loXfH7A160mx
	njbM7FQGvY50Ux+4abPv5M/jloVN2uSdXsY/R7s23lATNEeb1T03ZcLJg6phN0kWZAGIO5Lm1xZvv
	NSddbuZw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJtLk-00000007L5Z-3IBZ;
	Wed, 19 Jun 2024 11:19:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6DB37300561; Wed, 19 Jun 2024 13:19:36 +0200 (CEST)
Date: Wed, 19 Jun 2024 13:19:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org,
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
	elver@google.com, glider@google.com, nogikh@google.com,
	tarasmadan@google.com
Subject: Re: [PATCH v2 1/4] x86/entry: Remove unwanted instrumentation in
 common_interrupt()
Message-ID: <20240619111936.GK31592@noisy.programming.kicks-ass.net>
References: <cover.1718092070.git.dvyukov@google.com>
 <3f9a1de9e415fcb53d07dc9e19fa8481bb021b1b.1718092070.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f9a1de9e415fcb53d07dc9e19fa8481bb021b1b.1718092070.git.dvyukov@google.com>

On Tue, Jun 11, 2024 at 09:50:30AM +0200, Dmitry Vyukov wrote:
> common_interrupt() and friends call kvm_set_cpu_l1tf_flush_l1d(),
> which is not marked as noinstr nor __always_inline.
> So compiler outlines it and adds instrumentation to it.
> Since the call is inside of instrumentation_begin/end(),
> objtool does not warn about it.
> 
> The manifestation is that KCOV produces spurious coverage
> in kvm_set_cpu_l1tf_flush_l1d() in random places because
> the call happens when preempt count is not yet updated
> to say that we are in an interrupt.

So I'm reading spurious here, but the next patch trips BUG, them very
much not the same thing. Which is it?

> Mark kvm_set_cpu_l1tf_flush_l1d() as __always_inline and move
> out of instrumentation_begin/end() section.
> It only calls __this_cpu_write() which is already safe to call
> in noinstr contexts.
> 
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Reviewed-by: Alexander Potapenko <glider@google.com>
> Fixes: 6368558c3710 ("x86/entry: Provide IDTENTRY_SYSVEC")
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: syzkaller@googlegroups.com

Anyway, the patch is fine,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  arch/x86/include/asm/hardirq.h  | 8 ++++++--
>  arch/x86/include/asm/idtentry.h | 6 +++---
>  2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
> index c67fa6ad098a..6ffa8b75f4cd 100644
> --- a/arch/x86/include/asm/hardirq.h
> +++ b/arch/x86/include/asm/hardirq.h
> @@ -69,7 +69,11 @@ extern u64 arch_irq_stat(void);
>  #define local_softirq_pending_ref       pcpu_hot.softirq_pending
>  
>  #if IS_ENABLED(CONFIG_KVM_INTEL)
> -static inline void kvm_set_cpu_l1tf_flush_l1d(void)
> +/*
> + * This function is called from noinstr interrupt contexts
> + * and must be inlined to not get instrumentation.
> + */
> +static __always_inline void kvm_set_cpu_l1tf_flush_l1d(void)
>  {
>  	__this_cpu_write(irq_stat.kvm_cpu_l1tf_flush_l1d, 1);
>  }
> @@ -84,7 +88,7 @@ static __always_inline bool kvm_get_cpu_l1tf_flush_l1d(void)
>  	return __this_cpu_read(irq_stat.kvm_cpu_l1tf_flush_l1d);
>  }
>  #else /* !IS_ENABLED(CONFIG_KVM_INTEL) */
> -static inline void kvm_set_cpu_l1tf_flush_l1d(void) { }
> +static __always_inline void kvm_set_cpu_l1tf_flush_l1d(void) { }
>  #endif /* IS_ENABLED(CONFIG_KVM_INTEL) */
>  
>  #endif /* _ASM_X86_HARDIRQ_H */
> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
> index d4f24499b256..ad5c68f0509d 100644
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -212,8 +212,8 @@ __visible noinstr void func(struct pt_regs *regs,			\
>  	irqentry_state_t state = irqentry_enter(regs);			\
>  	u32 vector = (u32)(u8)error_code;				\
>  									\
> +	kvm_set_cpu_l1tf_flush_l1d();                                   \
>  	instrumentation_begin();					\
> -	kvm_set_cpu_l1tf_flush_l1d();					\
>  	run_irq_on_irqstack_cond(__##func, regs, vector);		\
>  	instrumentation_end();						\
>  	irqentry_exit(regs, state);					\
> @@ -250,7 +250,6 @@ static void __##func(struct pt_regs *regs);				\
>  									\
>  static __always_inline void instr_##func(struct pt_regs *regs)		\
>  {									\
> -	kvm_set_cpu_l1tf_flush_l1d();					\
>  	run_sysvec_on_irqstack_cond(__##func, regs);			\
>  }									\
>  									\
> @@ -258,6 +257,7 @@ __visible noinstr void func(struct pt_regs *regs)			\
>  {									\
>  	irqentry_state_t state = irqentry_enter(regs);			\
>  									\
> +	kvm_set_cpu_l1tf_flush_l1d();                                   \
>  	instrumentation_begin();					\
>  	instr_##func (regs);						\
>  	instrumentation_end();						\
> @@ -288,7 +288,6 @@ static __always_inline void __##func(struct pt_regs *regs);		\
>  static __always_inline void instr_##func(struct pt_regs *regs)		\
>  {									\
>  	__irq_enter_raw();						\
> -	kvm_set_cpu_l1tf_flush_l1d();					\
>  	__##func (regs);						\
>  	__irq_exit_raw();						\
>  }									\
> @@ -297,6 +296,7 @@ __visible noinstr void func(struct pt_regs *regs)			\
>  {									\
>  	irqentry_state_t state = irqentry_enter(regs);			\
>  									\
> +	kvm_set_cpu_l1tf_flush_l1d();                                   \
>  	instrumentation_begin();					\
>  	instr_##func (regs);						\
>  	instrumentation_end();						\
> -- 
> 2.45.2.505.gda0bf45e8d-goog
> 

