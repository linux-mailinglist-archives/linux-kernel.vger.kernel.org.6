Return-Path: <linux-kernel+bounces-226744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2969142F9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABA54283629
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 06:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7825522338;
	Mon, 24 Jun 2024 06:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Twr/7glr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10FE3EA72
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 06:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719211687; cv=none; b=k3MJbeDj/53JN075nQMV2rT4VwScTnRdNyCvvOYGjOVBl3Qlq2KyWIYcnGSPe1W0oeSpTpj8XdtYnfIDCN0c8XD7rE5SoCqgVeenFWYr6jAHQ+DAGJhHwFRFCUYcFjAk1ynXo+Dv/BzLkEZUNOfHTe8ny1UBuQgYcb1I+NchnA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719211687; c=relaxed/simple;
	bh=yZZjg8uFdYDutRQMgy5IN92qFDAN2zkgjfxxih2xAa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bAIaDTvh/ka62cTUPrT225hbiTCrAieRCm/WnjtCYCMQNZKIY5izwy+nkeFDYLs4gJ3H/+BEL1SRgNb/77BF04TUbIG+t+thzW5DdYUtAxXSCZR1Y/wN02mUwmSUfyC/8OIaVssgM4JP5UWRoKnkmmE/da3NzgX6Z6mpsX+u8Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Twr/7glr; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719211686; x=1750747686;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yZZjg8uFdYDutRQMgy5IN92qFDAN2zkgjfxxih2xAa8=;
  b=Twr/7glr771XApP+XpCyUIIQKhdGb04XSKtqiUN89HM0lX902hXb5YlA
   0lgl+lLY2nP1Lu4+ZnjYMJyZyhlnRd8K9oMXZ20yMu40sa/CcIbHt8Kdi
   pDlw5BNNCEQjqP/HW62EsFAe/hXs2of6vQC0OETK1YIvgMn/Pppxdqpsr
   VCNZf3XbUSVHFPI3YTzP5/F31mGX1csRyIsLZRSMnCrqndTPVppXEUzsu
   Zi6zJ5SswlJqnAypSE2vLde+etuHhnSzaFSlQl6I+9XVqz9vFOUAFqI+U
   Uk9yk/nNAxIdFl1p2em9a7SoGC/iTld7CIqKngEBp4mbXubEMH5vjtV/k
   g==;
X-CSE-ConnectionGUID: sorIXhcTTnuF1M54Rv6m/A==
X-CSE-MsgGUID: +SswS1BZRvKvbKG327FADA==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="16290387"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="16290387"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 23:48:05 -0700
X-CSE-ConnectionGUID: Fnj6vH9ZSfWPXe1G/HxLDQ==
X-CSE-MsgGUID: 9sfe8N7wTLKnfUedH0JKCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="43643299"
Received: from hongyuni-mobl.ccr.corp.intel.com (HELO [10.238.1.243]) ([10.238.1.243])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 23:48:03 -0700
Message-ID: <62c71816-64a0-468e-8c90-d7059d040a1f@linux.intel.com>
Date: Mon, 24 Jun 2024 14:47:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] x86/fpu: Remove init_task FPU state dependencies, add
 debugging warning
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc: Andy Lutomirski <luto@amacapital.net>,
 Andrew Morton <akpm@linux-foundation.org>, Dave Hansen <dave@sr71.net>,
 Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Oleg Nesterov <oleg@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Uros Bizjak <ubizjak@gmail.com>, kirill.shutemov@linux.intel.com
References: <20240605083557.2051480-1-mingo@kernel.org>
 <20240605083557.2051480-4-mingo@kernel.org>
Content-Language: en-US
From: "Ning, Hongyu" <hongyu.ning@linux.intel.com>
In-Reply-To: <20240605083557.2051480-4-mingo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/5 16:35, Ingo Molnar wrote:
> init_task's FPU state initialization was a bit of a hack:
> 
> 		__x86_init_fpu_begin = .;
> 		. = __x86_init_fpu_begin + 128*PAGE_SIZE;
> 		__x86_init_fpu_end = .;
> 
> But the init task isn't supposed to be using the FPU in any case,
> so remove the hack and add in some debug warnings.
> 
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Uros Bizjak <ubizjak@gmail.com>
> Link: https://lore.kernel.org/r/ZgaNs1lC2Y+AnRG4@gmail.com
> ---
>   arch/x86/include/asm/processor.h |  6 +++++-
>   arch/x86/kernel/fpu/core.c       | 12 +++++++++---
>   arch/x86/kernel/fpu/init.c       |  5 ++---
>   arch/x86/kernel/fpu/xstate.c     |  3 ---
>   arch/x86/kernel/vmlinux.lds.S    |  4 ----
>   5 files changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 249c5fa20de4..ed8981866f4d 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -504,7 +504,11 @@ struct thread_struct {
>   #endif
>   };
>   
> -#define x86_task_fpu(task) ((struct fpu *)((void *)task + sizeof(*task)))
> +#ifdef CONFIG_X86_DEBUG_FPU
> +extern struct fpu *x86_task_fpu(struct task_struct *task);
> +#else
> +# define x86_task_fpu(task) ((struct fpu *)((void *)task + sizeof(*task)))
> +#endif
>   
>   /*
>    * X86 doesn't need any embedded-FPU-struct quirks:
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index 0ccabcd3bf62..fdc3b227800d 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -51,6 +51,15 @@ static DEFINE_PER_CPU(bool, in_kernel_fpu);
>    */
>   DEFINE_PER_CPU(struct fpu *, fpu_fpregs_owner_ctx);
>   
> +#ifdef CONFIG_X86_DEBUG_FPU
> +struct fpu *x86_task_fpu(struct task_struct *task)
> +{
> +	WARN_ON_ONCE(task == &init_task);
> +
> +	return (void *)task + sizeof(*task);
> +}
> +#endif
> +
>   /*
>    * Can we use the FPU in kernel mode with the
>    * whole "kernel_fpu_begin/end()" sequence?
> @@ -591,10 +600,8 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
>   	 * This is safe because task_struct size is a multiple of cacheline size.
>   	 */
>   	struct fpu *dst_fpu = (void *)dst + sizeof(*dst);
> -	struct fpu *src_fpu = x86_task_fpu(current);
>   
>   	BUILD_BUG_ON(sizeof(*dst) % SMP_CACHE_BYTES != 0);
> -	BUG_ON(!src_fpu);
>   
>   	/* The new task's FPU state cannot be valid in the hardware. */
>   	dst_fpu->last_cpu = -1;
> @@ -657,7 +664,6 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
>   	if (update_fpu_shstk(dst, ssp))
>   		return 1;
>   
> -	trace_x86_fpu_copy_src(src_fpu);
>   	trace_x86_fpu_copy_dst(dst_fpu);
>   
>   	return 0;
> diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
> index 11aa31410df2..53580e59e5db 100644
> --- a/arch/x86/kernel/fpu/init.c
> +++ b/arch/x86/kernel/fpu/init.c
> @@ -38,7 +38,7 @@ static void fpu__init_cpu_generic(void)
>   	/* Flush out any pending x87 state: */
>   #ifdef CONFIG_MATH_EMULATION
>   	if (!boot_cpu_has(X86_FEATURE_FPU))
> -		fpstate_init_soft(&x86_task_fpu(current)->fpstate->regs.soft);
> +		;
>   	else
>   #endif
>   		asm volatile ("fninit");
> @@ -164,7 +164,7 @@ static void __init fpu__init_task_struct_size(void)
>   	 * Subtract off the static size of the register state.
>   	 * It potentially has a bunch of padding.
>   	 */
> -	task_size -= sizeof(x86_task_fpu(current)->__fpstate.regs);
> +	task_size -= sizeof(union fpregs_state);
>   
>   	/*
>   	 * Add back the dynamically-calculated register state
> @@ -209,7 +209,6 @@ static void __init fpu__init_system_xstate_size_legacy(void)
>   	fpu_kernel_cfg.default_size = size;
>   	fpu_user_cfg.max_size = size;
>   	fpu_user_cfg.default_size = size;
> -	fpstate_reset(x86_task_fpu(current));
>   }
>   
>   /*
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 90b11671e943..1f37da22ddbe 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -844,9 +844,6 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
>   	if (err)
>   		goto out_disable;
>   
> -	/* Reset the state for the current task */
> -	fpstate_reset(x86_task_fpu(current));
> -
>   	/*
>   	 * Update info used for ptrace frames; use standard-format size and no
>   	 * supervisor xstates:
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index 226244a894da..3509afc6a672 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -170,10 +170,6 @@ SECTIONS
>   		/* equivalent to task_pt_regs(&init_task) */
>   		__top_init_kernel_stack = __end_init_stack - TOP_OF_KERNEL_STACK_PADDING - PTREGS_SIZE;
>   
> -		__x86_init_fpu_begin = .;
> -		. = __x86_init_fpu_begin + 128*PAGE_SIZE;
> -		__x86_init_fpu_end = .;
> -
>   #ifdef CONFIG_X86_32
>   		/* 32 bit has nosave before _edata */
>   		NOSAVE_DATA

Hi,

we've hit x86/fpu related WARNING and NULL pointer issue during KVM/QEMU 
VM booting with latest linux-next kernel, bisect results show it's 
related to this commit, would you take a look?

detailed description in https://bugzilla.kernel.org/show_bug.cgi?id=218980

