Return-Path: <linux-kernel+bounces-236544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C098A91E3C4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 468CC1F2316C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E10716EC12;
	Mon,  1 Jul 2024 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KtK/jnJe"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A1516EB72
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719846836; cv=none; b=cdtlGv/WSsn1ZVg1fcLnPEGO3cYneWLox6x5Jv8rNVqjSedeKWGnTZJJZ5jHg0fXcHAIdKPvwKZmezvR7xo6iU3chdq5AyHZe4N0dsiRkmjHJZpXPONOfFgsU38ZK5eYSAKhLbMQOYhHjHL3zvmbVj7lsG2LPQ4UQC9INpKsluA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719846836; c=relaxed/simple;
	bh=7qcE8lPjIwP/SjTN6Lj8p4iqpk99LwTwXiVLS/aMuW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XWGOXyWo4QPw4xOT8BZm7r6S5BFaxJbVI6cH75GNWY3BZAR2QnVHefLQGp1oZ2emk1SLGj6ExEscPbSeNEx4GmUE18w9RSmBJPqsX+QkR4QhSYOcTU5+aIqEEH1XVmq7AgEpeUhGIFcbVqTrwaUnHibDteYPYRGVI5TZ61ZMv6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=KtK/jnJe; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3762abfe005so11701445ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 08:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1719846834; x=1720451634; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jdlYna21mfTMWUTr17RbNLs/+Rxw0E+v4uLW3lEJDTY=;
        b=KtK/jnJe7ZLoIxkdjmhb2zN2c+lbLsVg8iQmCL4Y1pOn99YLgYVOYzgCtqbNxXBG05
         CUrn0TW/Q0S3O/uwLMKNvWA1JIQoJ15lju/O3GcgSHpEVpSITLLqlsHgBp9I9AQRnCy2
         Mhl2MyatMh/XSi6j01hGNCRyAJGjfrVtBDpepK26w0xDVfw+W08Mw8R2XUj9kddHrfvl
         AsoK9GTpC6UwTAKiW0GDqgIv/BCrduJN8a25rPU60gRs7hxqA8+EKJC7lojB0FCYQNwU
         DQMrIFpINCIKapOuQYsJ9Jk92WQRwzFMxusUhqk+UYKH2NHx32GK1FhdnQ0haJB9UAWi
         cP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719846834; x=1720451634;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jdlYna21mfTMWUTr17RbNLs/+Rxw0E+v4uLW3lEJDTY=;
        b=ZpXYW+MltisVoKTg9LaveXZsEFTCAYnd2rj0EcojgEWAkX73KB4wjnLR4q1Y1cxTxe
         RN7lGbzwXZUkwbL9OM4w3O3N8mXaK8MN9vT6is3Glfj3zD5LBzae3pIaAjZFG7Q1mth5
         URASbV+rpQO1wVCbGYF8gX1TlU8oR92n5fEJhEDvMwBaFnxekiadkkxcWjm+J2E9mfih
         Suxqcz8vUpGY4s+oX3c7mLHc0ufGKBgwkq8ekMAkrWXRW3fgUS3pRUGB0XjoKTydLptN
         yzeyYxEn6F+tNtdOxQsmBD7qyK3acJuiyGvrEjea+pPhdUaHFzCm9ZmaYmG0GQcgQqnR
         X0GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZNDpFN8SIbZmol1ALf1FocI9akuWFfZiF3z8ngUkDO6oVmZyxt3mcoAKCKVO9ia9grEgksj8iyBuASAUVJyNGHABlD5fSdc2N62+9
X-Gm-Message-State: AOJu0YwDwofHaNNkvgx4lzTGUN/66DGihhq3rzM1GwCVI3nODq8KYEqX
	d0hBCZx/S//BR1wVYpTXHxOnirr5ZDCCRmhTnSY+8OMuyYvnmAHotnxGi5Q18t0=
X-Google-Smtp-Source: AGHT+IG2LEJBd8JPWcoRaUn0j0oZYGN9rVJ4rCzlNxSPtRcLCAiwIU7nt3Q1UdnZDR0nCbvGg3/B4A==
X-Received: by 2002:a05:6e02:1a26:b0:375:873a:aa99 with SMTP id e9e14a558f8ab-37cd31b6d36mr81916185ab.25.1719846833763;
        Mon, 01 Jul 2024 08:13:53 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-37ad4370c90sm19136545ab.69.2024.07.01.08.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 08:13:53 -0700 (PDT)
Message-ID: <ccb669ad-be56-4dbd-ad9c-851a94b933eb@sifive.com>
Date: Mon, 1 Jul 2024 10:13:50 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] RISC-V: Detect unaligned vector accesses supported
To: Jesse Taube <jesse@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Evan Green <evan@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>,
 Charlie Jenkins <charlie@rivosinc.com>, Xiao Wang <xiao.w.wang@intel.com>,
 Andy Chiu <andy.chiu@sifive.com>, Eric Biggers <ebiggers@google.com>,
 Greentime Hu <greentime.hu@sifive.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>,
 Costa Shulyupin <costa.shul@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
 Anup Patel <apatel@ventanamicro.com>, Zong Li <zong.li@sifive.com>,
 Sami Tolvanen <samitolvanen@google.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Erick Archer <erick.archer@gmx.com>, Joel Granados <j.granados@samsung.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20240625005001.37901-1-jesse@rivosinc.com>
 <20240625005001.37901-7-jesse@rivosinc.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <20240625005001.37901-7-jesse@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jesse,

On 2024-06-24 7:49 PM, Jesse Taube wrote:
> Run a unaligned vector access to test if the system supports
> vector unaligned access. Add the result to a new key in hwprobe.
> This is useful for usermode to know if vector misaligned accesses are
> supported and if they are faster or slower than equivalent byte accesses.
> 
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> V1 -> V2:

You are missing the "---" here, so the changelog is leaking into the commit message.

>  - Add Kconfig options
>  - Add insn_is_vector
>  - Add handle_vector_misaligned_load
>  - Fix build
>  - Seperate vector from scalar misaligned access
>  - This patch was almost completely rewritten
> V2 -> V3:
>  - Fixed CONFIG_ in Kconfig
>  - Fixed check_vector_unaligned_access_emulated leaving
>      vector_misaligned_access as unknown.
>  - Remove local_irq_enable
>  - Remove RISCV_DETECT_VECTOR_UNALIGNED_ACCESS
>  - Remove RISCV_VEC_UNALIGNED_ACCESS_UNSUPPORTED
> ---
>  arch/riscv/Kconfig                         |  35 ++++++
>  arch/riscv/include/asm/cpufeature.h        |   5 +
>  arch/riscv/include/asm/entry-common.h      |  11 --
>  arch/riscv/include/asm/hwprobe.h           |   2 +-
>  arch/riscv/include/asm/vector.h            |   1 +
>  arch/riscv/include/uapi/asm/hwprobe.h      |   5 +
>  arch/riscv/kernel/Makefile                 |   4 +-
>  arch/riscv/kernel/sys_hwprobe.c            |  35 ++++++
>  arch/riscv/kernel/traps_misaligned.c       | 120 ++++++++++++++++++++-
>  arch/riscv/kernel/unaligned_access_speed.c |   9 +-
>  arch/riscv/kernel/vector.c                 |   2 +-
>  11 files changed, 209 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 34d24242e37a..ffbe0fdd7fb3 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -717,12 +717,26 @@ config THREAD_SIZE_ORDER
>  	  Specify the Pages of thread stack size (from 4KB to 64KB), which also
>  	  affects irq stack size, which is equal to thread stack size.
>  
> +config RISCV_MISALIGNED
> +	bool
> +	help
> +	  Embed support for detecting and emulating misaligned
> +	  scalar or vector loads and stores.
> +
>  config RISCV_SCALAR_MISALIGNED
>  	bool
> +	select RISCV_MISALIGNED
>  	select SYSCTL_ARCH_UNALIGN_ALLOW
>  	help
>  	  Embed support for emulating misaligned loads and stores.
>  
> +config RISCV_VECTOR_MISALIGNED
> +	bool
> +	select RISCV_MISALIGNED
> +	depends on RISCV_ISA_V
> +	help
> +	  Enable detecting support for vector misaligned loads and stores.
> +
>  choice
>  	prompt "Unaligned Accesses Support"
>  	default RISCV_PROBE_UNALIGNED_ACCESS
> @@ -774,6 +788,27 @@ config RISCV_EFFICIENT_UNALIGNED_ACCESS
>  
>  endchoice
>  
> +choice
> +	prompt "Vector unaligned Accesses Support"
> +	depends on RISCV_ISA_V
> +	default RISCV_PROBE_VECTOR_UNALIGNED_ACCESS
> +	help
> +	  This determines the level of support for vector unaligned accesses. This
> +	  information is used by the kernel to perform optimizations. It is also
> +	  exposed to user space via the hwprobe syscall. The hardware will be
> +	  probed at boot by default.
> +
> +config RISCV_PROBE_VECTOR_UNALIGNED_ACCESS
> +	bool "Probe speed of vector unaligned accesses"
> +	select RISCV_VECTOR_MISALIGNED
> +	help
> +	  During boot, the kernel will run a series of tests to determine the
> +	  speed of vector unaligned accesses if they are supported. This probing
> +	  will dynamically determine the speed of vector unaligned accesses on
> +	  the underlying system if they are supported.
> +
> +endchoice
> +
>  endmenu # "Platform type"
>  
>  menu "Kernel features"
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
> index 0ed7d99c14dd..f25f56f9bfaa 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -45,6 +45,11 @@ static inline bool unaligned_ctl_available(void)
>  }
>  #endif
>  
> +bool check_vector_unaligned_access_emulated_all_cpus(void);
> +#if defined(CONFIG_RISCV_VECTOR_MISALIGNED)
> +DECLARE_PER_CPU(long, vector_misaligned_access);
> +#endif
> +
>  #if defined(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)
>  DECLARE_STATIC_KEY_FALSE(fast_unaligned_access_speed_key);
>  
> diff --git a/arch/riscv/include/asm/entry-common.h b/arch/riscv/include/asm/entry-common.h
> index 0a4e3544c877..7b32d2b08bb6 100644
> --- a/arch/riscv/include/asm/entry-common.h
> +++ b/arch/riscv/include/asm/entry-common.h
> @@ -25,18 +25,7 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
>  void handle_page_fault(struct pt_regs *regs);
>  void handle_break(struct pt_regs *regs);
>  
> -#ifdef CONFIG_RISCV_SCALAR_MISALIGNED
>  int handle_misaligned_load(struct pt_regs *regs);
>  int handle_misaligned_store(struct pt_regs *regs);
> -#else
> -static inline int handle_misaligned_load(struct pt_regs *regs)
> -{
> -	return -1;
> -}
> -static inline int handle_misaligned_store(struct pt_regs *regs)
> -{
> -	return -1;
> -}
> -#endif
>  
>  #endif /* _ASM_RISCV_ENTRY_COMMON_H */
> diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
> index 150a9877b0af..ef01c182af2b 100644
> --- a/arch/riscv/include/asm/hwprobe.h
> +++ b/arch/riscv/include/asm/hwprobe.h
> @@ -8,7 +8,7 @@
>  
>  #include <uapi/asm/hwprobe.h>
>  
> -#define RISCV_HWPROBE_MAX_KEY 7
> +#define RISCV_HWPROBE_MAX_KEY 8
>  
>  static inline bool riscv_hwprobe_key_is_valid(__s64 key)
>  {
> diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
> index be7d309cca8a..99b0f91db9ee 100644
> --- a/arch/riscv/include/asm/vector.h
> +++ b/arch/riscv/include/asm/vector.h
> @@ -21,6 +21,7 @@
>  
>  extern unsigned long riscv_v_vsize;
>  int riscv_v_setup_vsize(void);
> +bool insn_is_vector(u32 insn_buf);
>  bool riscv_v_first_use_handler(struct pt_regs *regs);
>  void kernel_vector_begin(void);
>  void kernel_vector_end(void);
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
> index 023b7771d1b7..2fee870e41bb 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -75,6 +75,11 @@ struct riscv_hwprobe {
>  #define		RISCV_HWPROBE_MISALIGNED_MASK		(7 << 0)
>  #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE	6
>  #define RISCV_HWPROBE_KEY_MISALIGNED_PERF	7
> +#define RISCV_HWPROBE_KEY_VEC_MISALIGNED_PERF	8
> +#define		RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN		0
> +#define		RISCV_HWPROBE_VEC_MISALIGNED_SLOW		2
> +#define		RISCV_HWPROBE_VEC_MISALIGNED_FAST		3
> +#define		RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED	4

We are spelling out "SCALAR" in the fixes series here[1], so for consistency we
should spell out "VECTOR" as well.

Regards,
Samuel

[1]: https://lore.kernel.org/linux-riscv/20240627172238.2460840-2-evan@rivosinc.com/


