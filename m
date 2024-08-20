Return-Path: <linux-kernel+bounces-293870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0840A958601
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A0541F240A4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8739518E75E;
	Tue, 20 Aug 2024 11:42:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CD518E74F
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 11:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724154135; cv=none; b=cg4tQ1ONBbpy7663qudXtk7zytqd5HZTghoI5vOSXjEnxGO0PAdYzeYjFC6aQPpIdaRLsPU/SvOauFwIRjUc2xYl+TzjHXghI47XFFsGI78lg+cxHpYZ/6ghartFu2CtL/dnlKZ7JjdFVas0DT+3YWocqm08i20eRP22b/TpQek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724154135; c=relaxed/simple;
	bh=KW3sUY5SFmPr5/j0wKszVuVVLqTZjHtMph0oPyZSxj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=u65Aitrt2GfCOemfRPayE5mRFzQMjTa6hm4m/pDO4dvNNiRF7FmE41Ii2KNDh4TmAcEaMn7Bz5zO/1TG+uODprjamnTNt4EQUfp/uhpP9fGifaffsB2kRozaLw6RcgYM65ZA+OcDRgZny+FsgVoT4aXfguESJLfvDFCivoLIPQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B573ADA7;
	Tue, 20 Aug 2024 04:42:37 -0700 (PDT)
Received: from [10.57.70.240] (unknown [10.57.70.240])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 205673F73B;
	Tue, 20 Aug 2024 04:42:02 -0700 (PDT)
Message-ID: <1ce09739-14a4-42a2-b5c9-66fdc72ae999@arm.com>
Date: Tue, 20 Aug 2024 13:41:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] entry: Add some arch funcs to support arm64 to use
 generic entry
To: Jinjie Ruan <ruanjinjie@huawei.com>
References: <20240629085601.470241-1-ruanjinjie@huawei.com>
 <20240629085601.470241-2-ruanjinjie@huawei.com>
Content-Language: en-GB
Cc: catalin.marinas@arm.com, will@kernel.org, oleg@redhat.com,
 tglx@linutronix.de, peterz@infradead.org, luto@kernel.org, kees@kernel.org,
 wad@chromium.org, rostedt@goodmis.org, arnd@arndb.de, ardb@kernel.org,
 broonie@kernel.org, mark.rutland@arm.com, rick.p.edgecombe@intel.com,
 leobras@redhat.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <20240629085601.470241-2-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/06/2024 10:55, Jinjie Ruan wrote:
> Add some arch functions to support arm64 to use generic entry, which do not
> affect existing architectures that use generic entry:
>
>  - arch_prepare/post_report_syscall_entry/exit().
>
>  - arch_enter_from_kernel_mode(), arch_exit_to_kernel_mode_prepare().
>
>  - arch_irqentry_exit_need_resched() to support architecture-related
>    need_resched() check logic.
>
> Also make syscall_exit_work() not static and move report_single_step() to
> thread_info.h, which can be used by arm64 later.
>
> x86 and Riscv compilation test ok after this patch.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> v3:
> - Make the arch funcs not use __weak as Thomas suggested.
> - Make arch_forget_syscall() folded in arch_post_report_syscall_entry().
> - __always_inline -> inline.
> - Move report_single_step() to thread_info.h for arm64
> - Add Suggested-by.
> - Update the commit message.
>
> v2:
> - Fix a bug that not call arch_post_report_syscall_entry() in
>   syscall_trace_enter() if ptrace_report_syscall_entry() return not zero.
> - Update the commit message.
> ---
>  include/linux/entry-common.h | 90 ++++++++++++++++++++++++++++++++++++
>  include/linux/thread_info.h  | 13 ++++++
>  kernel/entry/common.c        | 37 +++++++--------
>  3 files changed, 122 insertions(+), 18 deletions(-)
>
> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index b0fb775a600d..2aea23ca9d66 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -290,6 +290,94 @@ static __always_inline void arch_exit_to_user_mode(void);
>  static __always_inline void arch_exit_to_user_mode(void) { }
>  #endif
>  
> +/**
> + * arch_enter_from_kernel_mode - Architecture specific check work.

Maybe those comments could be expanded to be closer to the existing
ones, like arch_enter_from_user_mode()? It would help if they were more
specific as to where they are called (especially the *report_syscall*
ones) and how they are expected to be used.

> + */
> +static inline void arch_enter_from_kernel_mode(struct pt_regs *regs);
> +
> +#ifndef arch_enter_from_kernel_mode
> +static inline void arch_enter_from_kernel_mode(struct pt_regs *regs) { }
> +#endif
> +
> +/**
> + * arch_exit_to_kernel_mode_prepare - Architecture specific final work before
> + *				      exit to kernel mode.
> + */
> +static inline void arch_exit_to_kernel_mode_prepare(struct pt_regs *regs);

Any reason to suffix this function with "prepare"? Just
arch_exit_to_kernel_mode() seems appropriate (symmetric with
arch_enter_from_kernel_mode()).

> +
> +#ifndef arch_exit_to_kernel_mode_prepare
> +static inline void arch_exit_to_kernel_mode_prepare(struct pt_regs *regs) { }
> +#endif
> +
> +/**
> + * arch_prepare_report_syscall_entry - Architecture specific work before
> + *			               report_syscall_entry().
> + */
> +static inline unsigned long arch_prepare_report_syscall_entry(struct pt_regs *regs);

The most common naming patterns for such arch helper pairs seems to be
pre/post, so maybe arch_pre_report_syscall_entry()?

> +
> +#ifndef arch_prepare_report_syscall_entry
> +static inline unsigned long arch_prepare_report_syscall_entry(struct pt_regs *regs)
> +{
> +	return 0;
> +}
> +#endif
> +
> +/**
> + * arch_post_report_syscall_entry - Architecture specific work after
> + *			            report_syscall_entry().
> + */
> +static inline void arch_post_report_syscall_entry(struct pt_regs *regs,
> +						  unsigned long saved_reg,
> +						  long ret);
> +
> +#ifndef arch_post_report_syscall_entry
> +static inline void arch_post_report_syscall_entry(struct pt_regs *regs,
> +						  unsigned long saved_reg,
> +						  long ret)
> +{
> +}
> +#endif
> +
> +/**
> + * arch_prepare_report_syscall_exit - Architecture specific work before
> + *			              report_syscall_exit().
> + */
> +static inline unsigned long arch_prepare_report_syscall_exit(struct pt_regs *regs,
> +							     unsigned long work);
> +
> +#ifndef arch_prepare_report_syscall_exit
> +static inline unsigned long arch_prepare_report_syscall_exit(struct pt_regs *regs,
> +							     unsigned long work)
> +{
> +	return 0;
> +}
> +#endif
> +
> +/**
> + * arch_post_report_syscall_exit - Architecture specific work after
> + *			           report_syscall_exit().
> + */
> +static inline void arch_post_report_syscall_exit(struct pt_regs *regs,
> +						 unsigned long saved_reg,
> +						 unsigned long work);
> +
> +#ifndef arch_post_report_syscall_exit
> +static inline void arch_post_report_syscall_exit(struct pt_regs *regs,
> +						 unsigned long saved_reg,
> +						 unsigned long work)
> +{
> +}
> +#endif
> +
> +/**
> + * arch_irqentry_exit_need_resched - Architecture specific need resched function
> + */
> +static inline bool arch_irqentry_exit_need_resched(void);
> +
> +#ifndef arch_irqentry_exit_need_resched
> +static inline bool arch_irqentry_exit_need_resched(void) { return true; }
> +#endif

Nit: the existing arch_* hooks seem to be declared close to the function
they are called from (e.g. arch_enter_from_user_mode() just before
enter_from_user_mode()), maybe we could do the same with those new
hooks, where possible.

> +
>  /**
>   * arch_do_signal_or_restart -  Architecture specific signal delivery function
>   * @regs:	Pointer to currents pt_regs
> @@ -552,4 +640,6 @@ irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs);
>   */
>  void noinstr irqentry_nmi_exit(struct pt_regs *regs, irqentry_state_t irq_state);
>  
> +void syscall_exit_work(struct pt_regs *regs, unsigned long work);
> +
>  #endif
> diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
> index 9ea0b28068f4..062de9666ef3 100644
> --- a/include/linux/thread_info.h
> +++ b/include/linux/thread_info.h
> @@ -55,6 +55,19 @@ enum syscall_work_bit {
>  #define SYSCALL_WORK_SYSCALL_AUDIT	BIT(SYSCALL_WORK_BIT_SYSCALL_AUDIT)
>  #define SYSCALL_WORK_SYSCALL_USER_DISPATCH BIT(SYSCALL_WORK_BIT_SYSCALL_USER_DISPATCH)
>  #define SYSCALL_WORK_SYSCALL_EXIT_TRAP	BIT(SYSCALL_WORK_BIT_SYSCALL_EXIT_TRAP)
> +
> +/*
> + * If SYSCALL_EMU is set, then the only reason to report is when
> + * SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall
> + * instruction has been already reported in syscall_enter_from_user_mode().
> + */
> +static inline bool report_single_step(unsigned long work)
> +{
> +	if (work & SYSCALL_WORK_SYSCALL_EMU)
> +		return false;
> +
> +	return work & SYSCALL_WORK_SYSCALL_EXIT_TRAP;
> +}
>  #endif
>  
>  #include <asm/thread_info.h>
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index 90843cc38588..cd76391ffcb9 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -28,6 +28,7 @@ static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
>  long syscall_trace_enter(struct pt_regs *regs, long syscall,
>  				unsigned long work)
>  {
> +	unsigned long saved_reg;

Nit: could be declared inside the if block.

Kevin

>  	long ret = 0;
>  
>  	/*
> @@ -42,8 +43,10 @@ long syscall_trace_enter(struct pt_regs *regs, long syscall,
>  
>  	/* Handle ptrace */
>  	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
> +		saved_reg = arch_prepare_report_syscall_entry(regs);
>  		ret = ptrace_report_syscall_entry(regs);
> -		if (ret || (work & SYSCALL_WORK_SYSCALL_EMU))
> +		arch_post_report_syscall_entry(regs, saved_reg, ret);
> +		if (ret || work & SYSCALL_WORK_SYSCALL_EMU)
>  			return -1L;
>  	}
>  
> [...]

