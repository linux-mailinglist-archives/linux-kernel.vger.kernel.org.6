Return-Path: <linux-kernel+bounces-339178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33912986118
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56FB41C267C2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7645C1885AA;
	Wed, 25 Sep 2024 13:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Jo7edg6r"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5670A79E5
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727272474; cv=none; b=RwDSo2eY7rx6QjsBkYAvX57JmYhT3fPPMWNjc8wLHX8P6ttaGgyOi3y/9BwHXAOi0nHKQNYgR35Y7eSZ+1icONtxwDKu5JHWMfPysi/Ur4yJdleVTxv00a25pwyoByv/0glsP9D2QHsmhajthI/6T1BZta94JfFNOrO75kdnDE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727272474; c=relaxed/simple;
	bh=bCNm6tNHTnPIrqzXiu0mJ3ZC8e374AVY1ZDQqx3gxA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkjUT31o+SwwYCw7D5OsvTAEwM7wo0vBL2BkoVoM6K5jixfE4FqDScY6VUobUnmeK4L/5Q6psQHPHCuj7AfZu/CfeMFHnKhrErN3/5hu8h2XLFph1mkEqvMX4UoHbyk63dskRrSfmNjtjA9+A7IbX0c6Hjv9hBmrHyOE/TET12A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Jo7edg6r; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8d2b24b7a8so190204266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 06:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1727272469; x=1727877269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sNB/FTWMXFgC6FNYR/I4iwVpyab2JktNBpcKO0l//4w=;
        b=Jo7edg6rI7oUSd7vt5T36OBPO8NXtHFmWV7LWLIfvmN67E+DDCk67Bx+hAR0HL8zCk
         A9iJwFX7ilSPp1NK31EJmTJUO9hFKWRQzEhMkN6rWBH0cpHDO4QUuurp4znor5sZpw0T
         JAhZZ9piXnobu+FYZYyFGu+raq97ygut7hej6n7+kRSZzAA/C43J34o7ExeMTTjBc6eA
         AG4DAlJ9qlEhXNeozFQyeQQ3bm07M05vOuz/nlZUvS/jftEqE9T7CYBynGvpwXCIAK4M
         Z0PnknuSGOt9tV79q9FfF5F8oX2Rm91Y7c4/hyz5A4MJIz1ERr/0Dz+jZmzMV50vXyHq
         4HoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727272469; x=1727877269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNB/FTWMXFgC6FNYR/I4iwVpyab2JktNBpcKO0l//4w=;
        b=aggu3qEDcqfBEsLkeCsMNvSpGgWBXQvYuOdA72l8bHiNWpmZhRqIl7SvRCgLM7TOj3
         n3B1swdG2w/icoopN8tIv6FIsGSILtR4sbqSi3Ih0Y44h4k4EIPUyC8FTiJn0nPsDVvR
         qgOCYHAQ5NNbo4bHVkurPafEZ1o8/moGO98uxEKL0VOU1ZrGaNe9NGv6JKFPQH/68rPW
         EBMYbTKeuOqKXPOFeXZXafAs4uBc38FMsXY25I4M4ZYnaW2r0uV8nro1zkH2IuJ3SdJn
         rmzEUlh2Faj638/qiSmYo65xxLvQ/Y48xTeUkqx+JIvFt9zhX9Ee1fhA+VvJdQPBnNAo
         HsLw==
X-Forwarded-Encrypted: i=1; AJvYcCW5SGuAAMeOwAVo2meindqH5GqRryMn5Ls6L3r8ggqbPMHbVrzUl/+jBYYdTcv7EceyMRpJVzM2JFplNo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YybjT5mvVObYA/az9rCQrgCCQ4RjK9zqjYYNCyntF4Fu1sb1JZ0
	Yo8nxd53r24oUeHhm2Ru0lYlSGzZvNnNxMROoTkNgYFQwMdNYR5LTgKzQpnGFqY=
X-Google-Smtp-Source: AGHT+IEN2XB0JMyRoNcOOMIEkxwPG/sC/2MttP5xrk3hCZHIidjNVZQ908jcPyvYgV8nIcdxOcAZmQ==
X-Received: by 2002:a17:907:7ea1:b0:a75:7a8:d70c with SMTP id a640c23a62f3a-a93a1685e67mr299483066b.4.1727272469391;
        Wed, 25 Sep 2024 06:54:29 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f51e73sm208833666b.72.2024.09.25.06.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 06:54:28 -0700 (PDT)
Date: Wed, 25 Sep 2024 15:54:28 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	andy.chiu@sifive.com, guoren@kernel.org, christoph.muellner@vrull.eu, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, lihangjing@bytedance.com, 
	dengliang.1214@bytedance.com, xieyongji@bytedance.com, chaiwen.cc@bytedance.com
Subject: Re: [PATCH v3 1/2] riscv: process: Introduce idle thread using Zawrs
 extension
Message-ID: <20240925-2acd8d9743cf40b999172b40@orel>
References: <20240925131547.42396-1-luxu.kernel@bytedance.com>
 <20240925131547.42396-2-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925131547.42396-2-luxu.kernel@bytedance.com>

On Wed, Sep 25, 2024 at 09:15:46PM GMT, Xu Lu wrote:
> The Zawrs extension introduces a new instruction WRS.NTO, which will
> register a reservation set and causes the hart to temporarily stall
> execution in a low-power state until a store occurs to the reservation
> set or an interrupt is observed.
> 
> This commit implements new version of idle thread for RISC-V via Zawrs
> extension.
> 
> Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
> Reviewed-by: Hangjing Li <lihangjing@bytedance.com>
> Reviewed-by: Liang Deng <dengliang.1214@bytedance.com>
> Reviewed-by: Wen Chai <chaiwen.cc@bytedance.com>
> ---
>  arch/riscv/Kconfig                 | 10 ++++++++
>  arch/riscv/include/asm/cpuidle.h   | 11 +-------
>  arch/riscv/include/asm/processor.h | 18 +++++++++++++
>  arch/riscv/kernel/cpu.c            |  5 ++++
>  arch/riscv/kernel/process.c        | 41 +++++++++++++++++++++++++++++-
>  5 files changed, 74 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 939ea7f6a228..56cf6000d286 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -23,6 +23,7 @@ config RISCV
>  	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
>  	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
>  	select ARCH_HAS_BINFMT_FLAT
> +	select ARCH_HAS_CPU_FINALIZE_INIT
>  	select ARCH_HAS_CURRENT_STACK_POINTER
>  	select ARCH_HAS_DEBUG_VIRTUAL if MMU
>  	select ARCH_HAS_DEBUG_VM_PGTABLE
> @@ -1153,6 +1154,15 @@ endmenu # "Power management options"
>  
>  menu "CPU Power Management"
>  
> +config RISCV_ZAWRS_IDLE
> +	bool "Idle thread using ZAWRS extensions"
> +	depends on RISCV_ISA_ZAWRS
> +	default y
> +	help
> +		Adds support to implement idle thread using ZAWRS extension.
> +
> +		If you don't know what to do here, say Y.
> +
>  source "drivers/cpuidle/Kconfig"
>  
>  source "drivers/cpufreq/Kconfig"
> diff --git a/arch/riscv/include/asm/cpuidle.h b/arch/riscv/include/asm/cpuidle.h
> index 71fdc607d4bc..94c9ecb46571 100644
> --- a/arch/riscv/include/asm/cpuidle.h
> +++ b/arch/riscv/include/asm/cpuidle.h
> @@ -10,15 +10,6 @@
>  #include <asm/barrier.h>
>  #include <asm/processor.h>
>  
> -static inline void cpu_do_idle(void)
> -{
> -	/*
> -	 * Add mb() here to ensure that all
> -	 * IO/MEM accesses are completed prior
> -	 * to entering WFI.
> -	 */
> -	mb();
> -	wait_for_interrupt();
> -}
> +void cpu_do_idle(void);
>  
>  #endif
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> index efa1b3519b23..d0dcdb7e7392 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -12,6 +12,7 @@
>  
>  #include <vdso/processor.h>
>  
> +#include <asm/insn-def.h>
>  #include <asm/ptrace.h>
>  
>  #define arch_get_mmap_end(addr, len, flags)			\
> @@ -148,6 +149,21 @@ static inline void wait_for_interrupt(void)
>  	__asm__ __volatile__ ("wfi");
>  }
>  
> +static inline void wrs_nto(unsigned long *addr)
> +{
> +	int val;
> +
> +	__asm__ __volatile__(
> +#ifdef CONFIG_64BIT
> +			"lr.d %[p], %[v]\n\t"
> +#else
> +			"lr.w %[p], %[v]\n\t"
> +#endif

val is always 32-bit since it's an int. We should always use lr.w.

> +			ZAWRS_WRS_NTO "\n\t"
> +			: [p] "=&r" (val), [v] "+A" (*addr)

What do 'p' and 'v' represent? If they are pointer and value then they're
backwards. I would just spell them out [val] and [addr].

> +			: : "memory");
> +}
> +
>  extern phys_addr_t dma32_phys_limit;
>  
>  struct device_node;
> @@ -177,6 +193,8 @@ extern int set_unalign_ctl(struct task_struct *tsk, unsigned int val);
>  #define RISCV_SET_ICACHE_FLUSH_CTX(arg1, arg2)	riscv_set_icache_flush_ctx(arg1, arg2)
>  extern int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long per_thread);
>  
> +extern void select_idle_routine(void);
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* _ASM_RISCV_PROCESSOR_H */
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index f6b13e9f5e6c..97a7144fa6cd 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -23,6 +23,11 @@ bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
>  	return phys_id == cpuid_to_hartid_map(cpu);
>  }
>  
> +void __init arch_cpu_finalize_init(void)
> +{
> +	select_idle_routine();
> +}

Is there a reason we need to do this at arch_cpu_finalize_init() time?
This seems like the type of thing we have typically done at the bottom of
setup_arch().

> +
>  /*
>   * Returns the hart ID of the given device tree node, or -ENODEV if the node
>   * isn't an enabled and valid RISC-V hart node.
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index e4bc61c4e58a..77769965609e 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -15,6 +15,7 @@
>  #include <linux/tick.h>
>  #include <linux/ptrace.h>
>  #include <linux/uaccess.h>
> +#include <linux/static_call.h>
>  
>  #include <asm/unistd.h>
>  #include <asm/processor.h>
> @@ -35,11 +36,49 @@ EXPORT_SYMBOL(__stack_chk_guard);
>  
>  extern asmlinkage void ret_from_fork(void);
>  
> -void noinstr arch_cpu_idle(void)
> +static __cpuidle void default_idle(void)
> +{
> +	/*
> +	 * Add mb() here to ensure that all
> +	 * IO/MEM accesses are completed prior
> +	 * to entering WFI.
> +	 */
> +	mb();
> +	wait_for_interrupt();
> +}
> +
> +static __cpuidle void wrs_idle(void)
> +{
> +	/*
> +	 * Add mb() here to ensure that all
> +	 * IO/MEM accesses are completed prior
> +	 * to entering WRS.NTO.
> +	 */
> +	mb();
> +	wrs_nto(&current_thread_info()->flags);
> +}
> +
> +DEFINE_STATIC_CALL_NULL(riscv_idle, default_idle);
> +
> +void __cpuidle cpu_do_idle(void)
> +{
> +	static_call(riscv_idle)();
> +}
> +
> +void __cpuidle arch_cpu_idle(void)

Switching the section of this from '.noinstr.text' to 'cpuidle.text'
should probably be a separate patch.

>  {
>  	cpu_do_idle();
>  }
>  
> +void __init select_idle_routine(void)
> +{
> +	if (IS_ENABLED(CONFIG_RISCV_ZAWRS_IDLE) &&
> +			riscv_has_extension_likely(RISCV_ISA_EXT_ZAWRS))
> +		static_call_update(riscv_idle, wrs_idle);
> +	else
> +		static_call_update(riscv_idle, default_idle);

Do we need this 'else'? Can't we set the default at DEFINE_STATIC_CALL*
time?

> +}
> +
>  int set_unalign_ctl(struct task_struct *tsk, unsigned int val)
>  {
>  	if (!unaligned_ctl_available())
> -- 
> 2.20.1
>

Thanks,
drew

