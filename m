Return-Path: <linux-kernel+bounces-284407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C63DA95009B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C46E2819B3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79B9149007;
	Tue, 13 Aug 2024 08:59:10 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD37515B7;
	Tue, 13 Aug 2024 08:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723539550; cv=none; b=nqLkNmAVeXwis9pbOB5XosHLNHrYcBjhzLyX+spdquCYg4ONR7fPKJe3qnFmqzDdoYph2Q9B409mb6YLQ4PaQYvPNoNvV1w97+HBe2uSHHVqNx2wPTTjret0PqpDg0joVTVGxZqG8/VvNuH59z2rD40QwsPX4569teY787Dqo8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723539550; c=relaxed/simple;
	bh=dpnq0trFccqavqgr70LCuLgsknDOOSbp5PPA9ijbkOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FqYnuVmuK3JOkHoU2+PKrsLp0av6sk8YTjIg5+WUrNh1xNWfT3uZqpj4TzcCLcozyv9gdMOwF4sLxrj2zH8TaDtvGLaEDzmMHG5JiRsbkFaq3bRKSGOA5VSmmhD3OwXoRVdi/6XkwOtpDVKhsgtim6Vn9yUNvLiEzjIx6bLYkL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id A192E1BF207;
	Tue, 13 Aug 2024 08:58:56 +0000 (UTC)
Message-ID: <440ca2a7-9dfb-45cd-8331-a8d0afff47d0@ghiti.fr>
Date: Tue, 13 Aug 2024 10:58:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/10] riscv: Add support for userspace pointer masking
Content-Language: en-US
To: Samuel Holland <samuel.holland@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org
Cc: devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>,
 Conor Dooley <conor@kernel.org>, kasan-dev@googlegroups.com,
 Atish Patra <atishp@atishpatra.org>, Evgenii Stepanov <eugenis@google.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20240625210933.1620802-1-samuel.holland@sifive.com>
 <20240625210933.1620802-5-samuel.holland@sifive.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240625210933.1620802-5-samuel.holland@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Samuel,

On 25/06/2024 23:09, Samuel Holland wrote:
> RISC-V supports pointer masking with a variable number of tag bits
> (which is called "PMLEN" in the specification) and which is configured
> at the next higher privilege level.
>
> Wire up the PR_SET_TAGGED_ADDR_CTRL and PR_GET_TAGGED_ADDR_CTRL prctls
> so userspace can request a lower bound on the  number of tag bits and
> determine the actual number of tag bits. As with arm64's
> PR_TAGGED_ADDR_ENABLE, the pointer masking configuration is
> thread-scoped, inherited on clone() and fork() and cleared on execve().
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
> Changes in v2:
>   - Rebase on riscv/linux.git for-next
>   - Add and use the envcfg_update_bits() helper function
>   - Inline flush_tagged_addr_state()
>
>   arch/riscv/Kconfig                 | 11 ++++
>   arch/riscv/include/asm/processor.h |  8 +++
>   arch/riscv/include/asm/switch_to.h | 11 ++++
>   arch/riscv/kernel/process.c        | 99 ++++++++++++++++++++++++++++++
>   include/uapi/linux/prctl.h         |  3 +
>   5 files changed, 132 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index b94176e25be1..8f9980f81ea5 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -505,6 +505,17 @@ config RISCV_ISA_C
>   
>   	  If you don't know what to do here, say Y.
>   
> +config RISCV_ISA_POINTER_MASKING
> +	bool "Smmpm, Smnpm, and Ssnpm extensions for pointer masking"
> +	depends on 64BIT
> +	default y
> +	help
> +	  Add support for the pointer masking extensions (Smmpm, Smnpm,
> +	  and Ssnpm) when they are detected at boot.
> +
> +	  If this option is disabled, userspace will be unable to use
> +	  the prctl(PR_{SET,GET}_TAGGED_ADDR_CTRL) API.
> +
>   config RISCV_ISA_SVNAPOT
>   	bool "Svnapot extension support for supervisor mode NAPOT pages"
>   	depends on 64BIT && MMU
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> index 0838922bd1c8..4f99c85d29ae 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -194,6 +194,14 @@ extern int set_unalign_ctl(struct task_struct *tsk, unsigned int val);
>   #define RISCV_SET_ICACHE_FLUSH_CTX(arg1, arg2)	riscv_set_icache_flush_ctx(arg1, arg2)
>   extern int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long per_thread);
>   
> +#ifdef CONFIG_RISCV_ISA_POINTER_MASKING
> +/* PR_{SET,GET}_TAGGED_ADDR_CTRL prctl */
> +long set_tagged_addr_ctrl(struct task_struct *task, unsigned long arg);
> +long get_tagged_addr_ctrl(struct task_struct *task);
> +#define SET_TAGGED_ADDR_CTRL(arg)	set_tagged_addr_ctrl(current, arg)
> +#define GET_TAGGED_ADDR_CTRL()		get_tagged_addr_ctrl(current)
> +#endif
> +
>   #endif /* __ASSEMBLY__ */
>   
>   #endif /* _ASM_RISCV_PROCESSOR_H */
> diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
> index 9685cd85e57c..94e33216b2d9 100644
> --- a/arch/riscv/include/asm/switch_to.h
> +++ b/arch/riscv/include/asm/switch_to.h
> @@ -70,6 +70,17 @@ static __always_inline bool has_fpu(void) { return false; }
>   #define __switch_to_fpu(__prev, __next) do { } while (0)
>   #endif
>   
> +static inline void envcfg_update_bits(struct task_struct *task,
> +				      unsigned long mask, unsigned long val)
> +{
> +	unsigned long envcfg;
> +
> +	envcfg = (task->thread.envcfg & ~mask) | val;
> +	task->thread.envcfg = envcfg;
> +	if (task == current)
> +		csr_write(CSR_ENVCFG, envcfg);
> +}
> +
>   static inline void __switch_to_envcfg(struct task_struct *next)
>   {
>   	asm volatile (ALTERNATIVE("nop", "csrw " __stringify(CSR_ENVCFG) ", %0",
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index e4bc61c4e58a..dec5ccc44697 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -7,6 +7,7 @@
>    * Copyright (C) 2017 SiFive
>    */
>   
> +#include <linux/bitfield.h>
>   #include <linux/cpu.h>
>   #include <linux/kernel.h>
>   #include <linux/sched.h>
> @@ -171,6 +172,10 @@ void flush_thread(void)
>   	memset(&current->thread.vstate, 0, sizeof(struct __riscv_v_ext_state));
>   	clear_tsk_thread_flag(current, TIF_RISCV_V_DEFER_RESTORE);
>   #endif
> +#ifdef CONFIG_RISCV_ISA_POINTER_MASKING
> +	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SUPM))
> +		envcfg_update_bits(current, ENVCFG_PMM, ENVCFG_PMM_PMLEN_0);
> +#endif

if (IS_ENABLED(CONFIG_RISCV_ISA_POINTER_MASKING) && 
riscv_has_extension_unlikely(RISCV_ISA_EXT_SUPM))


>   }
>   
>   void arch_release_task_struct(struct task_struct *tsk)
> @@ -233,3 +238,97 @@ void __init arch_task_cache_init(void)
>   {
>   	riscv_v_setup_ctx_cache();
>   }
> +
> +#ifdef CONFIG_RISCV_ISA_POINTER_MASKING
> +static bool have_user_pmlen_7;
> +static bool have_user_pmlen_16;
> +
> +long set_tagged_addr_ctrl(struct task_struct *task, unsigned long arg)
> +{
> +	unsigned long valid_mask = PR_PMLEN_MASK;
> +	struct thread_info *ti = task_thread_info(task);
> +	unsigned long pmm;
> +	u8 pmlen;
> +
> +	if (is_compat_thread(ti))
> +		return -EINVAL;
> +
> +	if (arg & ~valid_mask)
> +		return -EINVAL;
> +
> +	pmlen = FIELD_GET(PR_PMLEN_MASK, arg);
> +	if (pmlen > 16) {
> +		return -EINVAL;
> +	} else if (pmlen > 7) {
> +		if (have_user_pmlen_16)
> +			pmlen = 16;
> +		else
> +			return -EINVAL;
> +	} else if (pmlen > 0) {
> +		/*
> +		 * Prefer the smallest PMLEN that satisfies the user's request,
> +		 * in case choosing a larger PMLEN has a performance impact.
> +		 */
> +		if (have_user_pmlen_7)
> +			pmlen = 7;
> +		else if (have_user_pmlen_16)
> +			pmlen = 16;
> +		else
> +			return -EINVAL;
> +	}
> +
> +	if (pmlen == 7)
> +		pmm = ENVCFG_PMM_PMLEN_7;
> +	else if (pmlen == 16)
> +		pmm = ENVCFG_PMM_PMLEN_16;
> +	else
> +		pmm = ENVCFG_PMM_PMLEN_0;
> +
> +	envcfg_update_bits(task, ENVCFG_PMM, pmm);
> +
> +	return 0;
> +}
> +
> +long get_tagged_addr_ctrl(struct task_struct *task)
> +{
> +	struct thread_info *ti = task_thread_info(task);
> +	long ret = 0;
> +
> +	if (is_compat_thread(ti))
> +		return -EINVAL;
> +
> +	switch (task->thread.envcfg & ENVCFG_PMM) {
> +	case ENVCFG_PMM_PMLEN_7:
> +		ret |= FIELD_PREP(PR_PMLEN_MASK, 7);
> +		break;
> +	case ENVCFG_PMM_PMLEN_16:
> +		ret |= FIELD_PREP(PR_PMLEN_MASK, 16);
> +		break;
> +	}


No need for the |=


> +
> +	return ret;
> +}


In all the code above, I'd use a macro for 7 and 16, something like 
PMLEN[7|16]?


> +
> +static bool try_to_set_pmm(unsigned long value)
> +{
> +	csr_set(CSR_ENVCFG, value);
> +	return (csr_read_clear(CSR_ENVCFG, ENVCFG_PMM) & ENVCFG_PMM) == value;
> +}
> +
> +static int __init tagged_addr_init(void)
> +{
> +	if (!riscv_has_extension_unlikely(RISCV_ISA_EXT_SUPM))
> +		return 0;
> +
> +	/*
> +	 * envcfg.PMM is a WARL field. Detect which values are supported.
> +	 * Assume the supported PMLEN values are the same on all harts.
> +	 */
> +	csr_clear(CSR_ENVCFG, ENVCFG_PMM);
> +	have_user_pmlen_7 = try_to_set_pmm(ENVCFG_PMM_PMLEN_7);
> +	have_user_pmlen_16 = try_to_set_pmm(ENVCFG_PMM_PMLEN_16);


Shouldn't this depend on the satp mode? sv57 does not allow 16bits for 
the tag.


> +
> +	return 0;
> +}
> +core_initcall(tagged_addr_init);


Any reason it's not called from setup_arch()? I see the vector extension 
does the same; just wondering if we should not centralize all this early 
extensions decisions in setup_arch() (in my Zacas series, I choose the 
spinlock implementation in setup_arch()).


> +#endif	/* CONFIG_RISCV_ISA_POINTER_MASKING */
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 35791791a879..6e84c827869b 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -244,6 +244,9 @@ struct prctl_mm_map {
>   # define PR_MTE_TAG_MASK		(0xffffUL << PR_MTE_TAG_SHIFT)
>   /* Unused; kept only for source compatibility */
>   # define PR_MTE_TCF_SHIFT		1
> +/* RISC-V pointer masking tag length */
> +# define PR_PMLEN_SHIFT			24
> +# define PR_PMLEN_MASK			(0x7fUL << PR_PMLEN_SHIFT)


I don't understand the need for this shift, can't userspace pass the 
pmlen value directly without worrying about this?


>   
>   /* Control reclaim behavior when allocating memory */
>   #define PR_SET_IO_FLUSHER		57

