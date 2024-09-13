Return-Path: <linux-kernel+bounces-327482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 247A197768F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 03:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6E7F1F253E3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 01:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52458479;
	Fri, 13 Sep 2024 01:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="135XgVAP"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164C24A07
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 01:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726192335; cv=none; b=Fgv5oSXLaCvpU84jud+J8f61D2EQUjOc6MB1C/XNmoaLlHbq1MSmxqZC76NYQzRJiKtGJqiz6ub7ElUqpDbiRH2fx7czEwaRMP7MLEWOD9+Kp/wt5Ntq1mIItCEUnahKMHyQWOEXlukNA1Rn8Y6WgAvLXZZOV5QdYO38ocV1SwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726192335; c=relaxed/simple;
	bh=AQ/nvfCoQ08ugK2iGVA4aMpTNluorvcCoLYrtwQ4UUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dW0dy7yqj3O4HKKlzyydqORx7yzSM8r0Gm4EnTf7RmDDyIkfMNWiOKpuG6D3adPzUgU2JXKamHZnbeSYD5I8pyLYpR/xZmALYuL0eev9/VFssdMvCWvCJIXNk0U8DgywDXV0JpUWiePfcjVI5AuWcBVI9EE8EEynHOGw9hmy8HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=135XgVAP; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d8fa2ca5b1so394943a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 18:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726192332; x=1726797132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k+ges+VvxmrgdZD6nkY5IuumPBlR6fNV3QrQLoSkcjs=;
        b=135XgVAPWMuJDJ8zR5Xl0SA2gF6aiOhN7EjI/xt1qbCjqYXnkD/QFdkqFFguzaHUdo
         WmSiFgmjMAc4Lq+JTpUE6Km72C+7VmHYpQ5IymeeaAA2/IlAPlG9XTXYzjvGFbonxTJ3
         XycEG6l+sxsENbM/9PSYM0Hv+I4Y8drDzrwkszlibS4luKsLtdwxZtHGLib6IoWPDymg
         yv10avdNu5pAvqR8ZVohv/8ecsfW/ZRGMIxV0NYaBEmBhTQX5Vz7V2Y+Mv0egg4V7/1U
         RRKasKyNuE7TsO/Ya5jMKYjGTxIP7sIkfUIj5pJWOv7P0poPh2hL4FICz6p3IG+GyfrD
         FXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726192332; x=1726797132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+ges+VvxmrgdZD6nkY5IuumPBlR6fNV3QrQLoSkcjs=;
        b=K5shxiW3/EWKC7VsokfDGqwoTFO8uvIOmMnKMFWu5hXlz78QAlPRAb8Yxk4Ua/msJk
         IUYMfLMP48cYq8TOQvzzaVLPSHv3YY5g8UCzau/75IIBhGFXLIpNFZQFx8zeus3GS6rF
         ptp6fv8+T9j4eN+lK2JCdSpfi7AAkS9GDAhJTL+ORe4xKRxC053VHq5a/NU1tBY2pbrW
         cBjZE76+qT3ZVTMRatyZcb8GIYiwigVXAGwHw66MsxtQkoZ/2GnYRXJ43R1ZFFDsUu4O
         4Mz6G/9OtPX+ANiyUkCiZw4ETP/HnOLGGVBa0ggrbmTnMkr2obqpv6q/z4iq5Djk0Yma
         ZN0g==
X-Forwarded-Encrypted: i=1; AJvYcCUIYZy/O1PULCQmLcUWcZF2TSSx00ia1RHMHGHhVHjnY1DR3XD1aJLg9VCn9rPRBK2kFDZnKKhaEN8UQgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhrDkBFDF4wTSEE3UGPrhOZtKp+Gncjri3RQzHQn5kWftzo1Ro
	D8ebkpym/WAV7+VxEjMPf6iuV+GU6vyWklVmnnqxpwjf+8ap5lxXUjM6Qdgf9dI=
X-Google-Smtp-Source: AGHT+IG2ZanLdLem/NUYAdInqYRRfqsc0iX2f/JGJquLApX32cXtS2V3Cr9a879h0s7MYWnv4kMFzg==
X-Received: by 2002:a17:90b:1e4c:b0:2d3:dd48:992c with SMTP id 98e67ed59e1d1-2dbb9e47099mr1670673a91.23.1726192332239;
        Thu, 12 Sep 2024 18:52:12 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9d953a6sm407052a91.56.2024.09.12.18.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 18:52:11 -0700 (PDT)
Date: Thu, 12 Sep 2024 18:52:09 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>,
	Conor Dooley <conor@kernel.org>, kasan-dev@googlegroups.com,
	Atish Patra <atishp@atishpatra.org>,
	Evgenii Stepanov <eugenis@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v4 04/10] riscv: Add support for userspace pointer masking
Message-ID: <ZuOayQEfZZeDWW7b@ghost>
References: <20240829010151.2813377-1-samuel.holland@sifive.com>
 <20240829010151.2813377-5-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829010151.2813377-5-samuel.holland@sifive.com>

On Wed, Aug 28, 2024 at 06:01:26PM -0700, Samuel Holland wrote:
> RISC-V supports pointer masking with a variable number of tag bits
> (which is called "PMLEN" in the specification) and which is configured
> at the next higher privilege level.
> 
> Wire up the PR_SET_TAGGED_ADDR_CTRL and PR_GET_TAGGED_ADDR_CTRL prctls
> so userspace can request a lower bound on the number of tag bits and
> determine the actual number of tag bits. As with arm64's
> PR_TAGGED_ADDR_ENABLE, the pointer masking configuration is
> thread-scoped, inherited on clone() and fork() and cleared on execve().
> 
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>

> ---
> 
> Changes in v4:
>  - Switch IS_ENABLED back to #ifdef to fix riscv32 build
> 
> Changes in v3:
>  - Rename CONFIG_RISCV_ISA_POINTER_MASKING to CONFIG_RISCV_ISA_SUPM,
>    since it only controls the userspace part of pointer masking
>  - Use IS_ENABLED instead of #ifdef when possible
>  - Use an enum for the supported PMLEN values
>  - Simplify the logic in set_tagged_addr_ctrl()
> 
> Changes in v2:
>  - Rebase on riscv/linux.git for-next
>  - Add and use the envcfg_update_bits() helper function
>  - Inline flush_tagged_addr_state()
> 
>  arch/riscv/Kconfig                 | 11 ++++
>  arch/riscv/include/asm/processor.h |  8 +++
>  arch/riscv/include/asm/switch_to.h | 11 ++++
>  arch/riscv/kernel/process.c        | 91 ++++++++++++++++++++++++++++++
>  include/uapi/linux/prctl.h         |  3 +
>  5 files changed, 124 insertions(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 0f3cd7c3a436..817437157138 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -512,6 +512,17 @@ config RISCV_ISA_C
>  
>  	  If you don't know what to do here, say Y.
>  
> +config RISCV_ISA_SUPM
> +	bool "Supm extension for userspace pointer masking"
> +	depends on 64BIT
> +	default y
> +	help
> +	  Add support for pointer masking in userspace (Supm) when the
> +	  underlying hardware extension (Smnpm or Ssnpm) is detected at boot.
> +
> +	  If this option is disabled, userspace will be unable to use
> +	  the prctl(PR_{SET,GET}_TAGGED_ADDR_CTRL) API.
> +
>  config RISCV_ISA_SVNAPOT
>  	bool "Svnapot extension support for supervisor mode NAPOT pages"
>  	depends on 64BIT && MMU
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> index 586e4ab701c4..5c4d4fb97314 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -200,6 +200,14 @@ extern int set_unalign_ctl(struct task_struct *tsk, unsigned int val);
>  #define RISCV_SET_ICACHE_FLUSH_CTX(arg1, arg2)	riscv_set_icache_flush_ctx(arg1, arg2)
>  extern int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long per_thread);
>  
> +#ifdef CONFIG_RISCV_ISA_SUPM
> +/* PR_{SET,GET}_TAGGED_ADDR_CTRL prctl */
> +long set_tagged_addr_ctrl(struct task_struct *task, unsigned long arg);
> +long get_tagged_addr_ctrl(struct task_struct *task);
> +#define SET_TAGGED_ADDR_CTRL(arg)	set_tagged_addr_ctrl(current, arg)
> +#define GET_TAGGED_ADDR_CTRL()		get_tagged_addr_ctrl(current)
> +#endif
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* _ASM_RISCV_PROCESSOR_H */
> diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
> index 9685cd85e57c..94e33216b2d9 100644
> --- a/arch/riscv/include/asm/switch_to.h
> +++ b/arch/riscv/include/asm/switch_to.h
> @@ -70,6 +70,17 @@ static __always_inline bool has_fpu(void) { return false; }
>  #define __switch_to_fpu(__prev, __next) do { } while (0)
>  #endif
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
>  static inline void __switch_to_envcfg(struct task_struct *next)
>  {
>  	asm volatile (ALTERNATIVE("nop", "csrw " __stringify(CSR_ENVCFG) ", %0",
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index e4bc61c4e58a..f39221ab5ddd 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -7,6 +7,7 @@
>   * Copyright (C) 2017 SiFive
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/cpu.h>
>  #include <linux/kernel.h>
>  #include <linux/sched.h>
> @@ -171,6 +172,10 @@ void flush_thread(void)
>  	memset(&current->thread.vstate, 0, sizeof(struct __riscv_v_ext_state));
>  	clear_tsk_thread_flag(current, TIF_RISCV_V_DEFER_RESTORE);
>  #endif
> +#ifdef CONFIG_RISCV_ISA_SUPM
> +	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SUPM))
> +		envcfg_update_bits(current, ENVCFG_PMM, ENVCFG_PMM_PMLEN_0);
> +#endif
>  }
>  
>  void arch_release_task_struct(struct task_struct *tsk)
> @@ -233,3 +238,89 @@ void __init arch_task_cache_init(void)
>  {
>  	riscv_v_setup_ctx_cache();
>  }
> +
> +#ifdef CONFIG_RISCV_ISA_SUPM
> +enum {
> +	PMLEN_0 = 0,
> +	PMLEN_7 = 7,
> +	PMLEN_16 = 16,
> +};
> +
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
> +	/*
> +	 * Prefer the smallest PMLEN that satisfies the user's request,
> +	 * in case choosing a larger PMLEN has a performance impact.
> +	 */
> +	pmlen = FIELD_GET(PR_PMLEN_MASK, arg);
> +	if (pmlen == PMLEN_0)
> +		pmm = ENVCFG_PMM_PMLEN_0;
> +	else if (pmlen <= PMLEN_7 && have_user_pmlen_7)
> +		pmm = ENVCFG_PMM_PMLEN_7;
> +	else if (pmlen <= PMLEN_16 && have_user_pmlen_16)
> +		pmm = ENVCFG_PMM_PMLEN_16;
> +	else
> +		return -EINVAL;
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
> +		ret = FIELD_PREP(PR_PMLEN_MASK, PMLEN_7);
> +		break;
> +	case ENVCFG_PMM_PMLEN_16:
> +		ret = FIELD_PREP(PR_PMLEN_MASK, PMLEN_16);
> +		break;
> +	}
> +
> +	return ret;
> +}
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
> +
> +	return 0;
> +}
> +core_initcall(tagged_addr_init);
> +#endif	/* CONFIG_RISCV_ISA_SUPM */
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 35791791a879..6e84c827869b 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -244,6 +244,9 @@ struct prctl_mm_map {
>  # define PR_MTE_TAG_MASK		(0xffffUL << PR_MTE_TAG_SHIFT)
>  /* Unused; kept only for source compatibility */
>  # define PR_MTE_TCF_SHIFT		1
> +/* RISC-V pointer masking tag length */
> +# define PR_PMLEN_SHIFT			24
> +# define PR_PMLEN_MASK			(0x7fUL << PR_PMLEN_SHIFT)
>  
>  /* Control reclaim behavior when allocating memory */
>  #define PR_SET_IO_FLUSHER		57
> -- 
> 2.45.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

