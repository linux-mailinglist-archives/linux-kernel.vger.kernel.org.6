Return-Path: <linux-kernel+bounces-249961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2316292F238
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 00:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE3D282D5B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 22:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26C31A01B3;
	Thu, 11 Jul 2024 22:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="0ErwKLks"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3757712C477
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720737983; cv=none; b=BK386rw82OMK2CZkLOdTKyc/sby48zKqgZ04zT59WKzl7a88FQPj7OZteadAoOjCYubT35Zck3KsM2Kplqi1na3XGOB0Mp63Lyv4zeE+Qpy4S+KsGOPvG0bJs976HxhpvTXSWvn9Zuq2OZa22cgPJX8FqOJcS+waPgQfcdZUsiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720737983; c=relaxed/simple;
	bh=+DTbw7hvrcqGHHwT9fZg8p1y3e+FegzGafsOv1bUMPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/Su4nWxva7QHd71lRIO2QleZefqyfiywdEORlkD8nALFzhYBCZmgoY2ie3R386lWwZr2ilSWE8bbjyTOX3j8adQGbGO1ocr6HQBMgBQTrBSDXpZ+zVPkMCmCP3TiU7xOOpohxUk9ItilkZqronn+iKWN8KUILzER+n8DrBc+DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=0ErwKLks; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5ca9835db95so791841eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 15:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1720737980; x=1721342780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KpeksD67BTgWPizChKokLZMY2TrD6PJb8cnkksJ64DM=;
        b=0ErwKLksM3xcmRb0w54b6JTDs1MLNiZwfbKJUj6XjqbOec+Yy1kXUbUGBK+46ptebD
         ScXszR5Y3LADZHvYHDpJL/BIUjlvJD5wqfnMWap30fzfqxvDRwUvIDZeB+vVLdz3RujU
         czzvh+HXdGwzu+ptPNHKW+gwCa9gfiQfKYVD/580KL753DZM4pbzC0zeiJ/eVn8yGXbr
         1VhLXQPiCkOPaTqrSSmfKXyaUWUuV/Yl0iVTgTdB50ATmu71djrCBSIsbb74MfWLYogy
         8QX4aLDD2Hfu1A8winDqfQCj2+eLKILLDXEvY2VcrV+HqixSoxXWUkjSPGmReO2VaBt7
         AGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720737980; x=1721342780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KpeksD67BTgWPizChKokLZMY2TrD6PJb8cnkksJ64DM=;
        b=FIK4mPvZ03uFy/m+GSqX4b/IHmKdSw1eUu9O4NRvda0b9lJykqe9zjlqNks2B8j0Zx
         npYusQMzcqKLV1VTdMi5zQIwBIx6USqMb+Vlt/JyVlduQDZy5S1Yl8D2EVavhOn7DCgE
         Jg2sEpOoGD4HWqavju5gQJKNL7Z9tIhHIr1q5OtsxDJAoi0VeldU9rbsHkvCvvs+64hS
         Uwd5+VHhDsiapfUnNE7tiURRg/obgX+C0lW+x/UsUXlYiB2eceELO2IxLAoT1OC7wrut
         yKjs8AvicJIwQV3x3nDJBPh740AtIWffmNox93zUXn39I3tYgFZXugUfjlmiBb6FFb0j
         6vsA==
X-Forwarded-Encrypted: i=1; AJvYcCULkfVqFsIitxQYg3kGpnZyX9UlKLj9BPGEAazNqLsOZpKF15THKvLv++vIEgpSNaoQGkpd0sdB8n/sZv1AVGL6am+dtZyuUkJXVDQh
X-Gm-Message-State: AOJu0YwkIsv4Xdirs+0c2ALRi++N2906eWSECsGu5QoHBaWFp8q84mN1
	cu+6JCxVzdV7EIOrk7O78/mADF2LDNIknU9wRX7DXv6HN/kvKkvjIC3MsO9MFbk=
X-Google-Smtp-Source: AGHT+IEnivIHZcXS6Oigg3Jwh5JiT3nb39Uey4egWaq1sNS/RKn4nqnJiTmjgapiyIiXHwTOCvXiWQ==
X-Received: by 2002:a05:6870:b622:b0:24c:59f7:e840 with SMTP id 586e51a60fabf-25eae7da978mr8511817fac.17.1720737980203;
        Thu, 11 Jul 2024 15:46:20 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-77d607d5ea3sm4887940a12.24.2024.07.11.15.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 15:46:19 -0700 (PDT)
Date: Thu, 11 Jul 2024 15:46:17 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Jesse Taube <jesse@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Xiao Wang <xiao.w.wang@intel.com>, Andy Chiu <andy.chiu@sifive.com>,
	Eric Biggers <ebiggers@google.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Anup Patel <apatel@ventanamicro.com>,
	Zong Li <zong.li@sifive.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Erick Archer <erick.archer@gmx.com>,
	Joel Granados <j.granados@samsung.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 5/7] RISC-V: Detect unaligned vector accesses supported
Message-ID: <ZpBgueV/0wMJWPiy@ghost>
References: <20240711215846.834365-1-jesse@rivosinc.com>
 <20240711215846.834365-6-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711215846.834365-6-jesse@rivosinc.com>

On Thu, Jul 11, 2024 at 05:58:44PM -0400, Jesse Taube wrote:
> Run a unaligned vector access to test if the system supports
> vector unaligned access. Add the result to a new key in hwprobe.
> This is useful for usermode to know if vector misaligned accesses are
> supported and if they are faster or slower than equivalent byte accesses.
> 
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> ---
> V1 -> V2:
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
> V3 -> V4:
>  - Spell out _VECTOR_ in macros
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
>  arch/riscv/kernel/unaligned_access_speed.c |  22 ++--
>  arch/riscv/kernel/vector.c                 |   2 +-
>  11 files changed, 213 insertions(+), 29 deletions(-)
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
> index 023b7771d1b7..48b92fb07edf 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -75,6 +75,11 @@ struct riscv_hwprobe {
>  #define		RISCV_HWPROBE_MISALIGNED_MASK		(7 << 0)
>  #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE	6
>  #define RISCV_HWPROBE_KEY_MISALIGNED_PERF	7
> +#define RISCV_HWPROBE_KEY_VECTOR_MISALIGNED_PERF	8
> +#define		RISCV_HWPROBE_VECTOR_MISALIGNED_UNKNOWN		0
> +#define		RISCV_HWPROBE_VECTOR_MISALIGNED_SLOW		2
> +#define		RISCV_HWPROBE_VECTOR_MISALIGNED_FAST		3
> +#define		RISCV_HWPROBE_VECTOR_MISALIGNED_UNSUPPORTED	4
>  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
>  
>  /* Flags */
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 8d4e7d40e42f..5b243d46f4b1 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -62,8 +62,8 @@ obj-y	+= probes/
>  obj-y	+= tests/
>  obj-$(CONFIG_MMU) += vdso.o vdso/
>  
> -obj-$(CONFIG_RISCV_SCALAR_MISALIGNED)	+= traps_misaligned.o
> -obj-$(CONFIG_RISCV_SCALAR_MISALIGNED)	+= unaligned_access_speed.o
> +obj-$(CONFIG_RISCV_MISALIGNED)	+= traps_misaligned.o
> +obj-$(CONFIG_RISCV_MISALIGNED)	+= unaligned_access_speed.o
>  obj-$(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)	+= copy-unaligned.o
>  
>  obj-$(CONFIG_FPU)		+= fpu.o
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
> index e910e2971984..2e3e324bad38 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -194,6 +194,37 @@ static u64 hwprobe_misaligned(const struct cpumask *cpus)
>  }
>  #endif
>  
> +#ifdef CONFIG_RISCV_VECTOR_MISALIGNED
> +static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
> +{
> +	int cpu;
> +	u64 perf = -1ULL;
> +
> +	/* Return if supported or not even if speed wasn't probed */
> +	for_each_cpu(cpu, cpus) {
> +		int this_perf = per_cpu(vector_misaligned_access, cpu);
> +
> +		if (perf == -1ULL)
> +			perf = this_perf;
> +
> +		if (perf != this_perf) {
> +			perf = RISCV_HWPROBE_VECTOR_MISALIGNED_UNKNOWN;
> +			break;
> +		}
> +	}
> +
> +	if (perf == -1ULL)
> +		return RISCV_HWPROBE_VECTOR_MISALIGNED_UNKNOWN;
> +
> +	return perf;
> +}
> +#else
> +static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
> +{
> +	return RISCV_HWPROBE_VECTOR_MISALIGNED_UNKNOWN;
> +}
> +#endif
> +
>  static void hwprobe_one_pair(struct riscv_hwprobe *pair,
>  			     const struct cpumask *cpus)
>  {
> @@ -222,6 +253,10 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
>  		pair->value = hwprobe_misaligned(cpus);
>  		break;
>  
> +	case RISCV_HWPROBE_KEY_VECTOR_MISALIGNED_PERF:
> +		pair->value = hwprobe_vec_misaligned(cpus);
> +		break;
> +
>  	case RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE:
>  		pair->value = 0;
>  		if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOZ))
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
> index 1a1bb41472ea..42eeabfa3d95 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -16,6 +16,7 @@
>  #include <asm/entry-common.h>
>  #include <asm/hwprobe.h>
>  #include <asm/cpufeature.h>
> +#include <asm/vector.h>
>  
>  #define INSN_MATCH_LB			0x3
>  #define INSN_MASK_LB			0x707f
> @@ -322,12 +323,37 @@ union reg_data {
>  	u64 data_u64;
>  };
>  
> -static bool unaligned_ctl __read_mostly;
> -
>  /* sysctl hooks */
>  int unaligned_enabled __read_mostly = 1;	/* Enabled by default */
>  
> -int handle_misaligned_load(struct pt_regs *regs)
> +#ifdef CONFIG_RISCV_VECTOR_MISALIGNED
> +static int handle_vector_misaligned_load(struct pt_regs *regs)
> +{
> +	unsigned long epc = regs->epc;
> +	unsigned long insn;
> +
> +	if (get_insn(regs, epc, &insn))
> +		return -1;
> +
> +	/* Only return 0 when in check_vector_unaligned_access_emulated */
> +	if (*this_cpu_ptr(&vector_misaligned_access) == RISCV_HWPROBE_VECTOR_MISALIGNED_UNKNOWN) {
> +		*this_cpu_ptr(&vector_misaligned_access) = RISCV_HWPROBE_VECTOR_MISALIGNED_UNSUPPORTED;
> +		regs->epc = epc + INSN_LEN(insn);
> +		return 0;
> +	}
> +
> +	/* If vector instruction we don't emulate it yet */
> +	regs->epc = epc;
> +	return -1;
> +}
> +#else
> +static int handle_vector_misaligned_load(struct pt_regs *regs)
> +{
> +	return -1;
> +}
> +#endif
> +
> +static int handle_scalar_misaligned_load(struct pt_regs *regs)
>  {
>  	union reg_data val;
>  	unsigned long epc = regs->epc;
> @@ -435,7 +461,7 @@ int handle_misaligned_load(struct pt_regs *regs)
>  	return 0;
>  }
>  
> -int handle_misaligned_store(struct pt_regs *regs)
> +static int handle_scalar_misaligned_store(struct pt_regs *regs)
>  {
>  	union reg_data val;
>  	unsigned long epc = regs->epc;
> @@ -526,6 +552,86 @@ int handle_misaligned_store(struct pt_regs *regs)
>  	return 0;
>  }
>  
> +int handle_misaligned_load(struct pt_regs *regs)
> +{
> +	unsigned long epc = regs->epc;
> +	unsigned long insn;
> +
> +	if (IS_ENABLED(CONFIG_RISCV_VECTOR_MISALIGNED)) {
> +		if (get_insn(regs, epc, &insn))
> +			return -1;
> +
> +		if (insn_is_vector(insn))
> +			return handle_vector_misaligned_load(regs);
> +	}
> +
> +	if (IS_ENABLED(CONFIG_RISCV_SCALAR_MISALIGNED))
> +		return handle_scalar_misaligned_load(regs);
> +
> +	return -1;
> +}
> +
> +int handle_misaligned_store(struct pt_regs *regs)
> +{
> +	if (IS_ENABLED(CONFIG_RISCV_SCALAR_MISALIGNED))
> +		return handle_scalar_misaligned_store(regs);
> +
> +	return -1;
> +}
> +
> +#ifdef CONFIG_RISCV_VECTOR_MISALIGNED
> +static void check_vector_unaligned_access_emulated(struct work_struct *unused)

Same comment about the unused. On the next version you can add:

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

> +{
> +	long *mas_ptr = this_cpu_ptr(&vector_misaligned_access);
> +	unsigned long tmp_var;
> +
> +	*mas_ptr = RISCV_HWPROBE_VECTOR_MISALIGNED_UNKNOWN;
> +
> +	kernel_vector_begin();
> +	__asm__ __volatile__ (
> +		".balign 4\n\t"
> +		".option push\n\t"
> +		".option arch, +zve32x\n\t"
> +		"       vsetivli zero, 1, e16, m1, ta, ma\n\t"	// Vectors of 16b
> +		"       vle16.v v0, (%[ptr])\n\t"		// Load bytes
> +		".option pop\n\t"
> +		: : [ptr] "r" ((u8 *)&tmp_var + 1) : "v0");
> +	kernel_vector_end();
> +
> +	if (*mas_ptr == RISCV_HWPROBE_VECTOR_MISALIGNED_UNKNOWN)
> +		*mas_ptr = RISCV_HWPROBE_VECTOR_MISALIGNED_SLOW;
> +}
> +
> +bool check_vector_unaligned_access_emulated_all_cpus(void)
> +{
> +	int cpu;
> +
> +	if (!has_vector()) {
> +		for_each_online_cpu(cpu)
> +			per_cpu(vector_misaligned_access, cpu) = RISCV_HWPROBE_VECTOR_MISALIGNED_UNSUPPORTED;
> +		return false;
> +	}
> +
> +	schedule_on_each_cpu(check_vector_unaligned_access_emulated);
> +
> +	for_each_online_cpu(cpu)
> +		if (per_cpu(vector_misaligned_access, cpu)
> +		    == RISCV_HWPROBE_VECTOR_MISALIGNED_SLOW)
> +			return false;
> +
> +	return true;
> +}
> +#else
> +bool check_vector_unaligned_access_emulated_all_cpus(void)
> +{
> +	return false;
> +}
> +#endif
> +
> +#ifdef CONFIG_RISCV_SCALAR_MISALIGNED
> +
> +static bool unaligned_ctl __read_mostly;
> +
>  static void check_unaligned_access_emulated(struct work_struct *unused)
>  {
>  	int cpu = smp_processor_id();
> @@ -574,3 +680,9 @@ bool unaligned_ctl_available(void)
>  {
>  	return unaligned_ctl;
>  }
> +#else
> +bool check_unaligned_access_emulated_all_cpus(void)
> +{
> +	return false;
> +}
> +#endif
> diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
> index a9a6bcb02acf..24b8883a23f0 100644
> --- a/arch/riscv/kernel/unaligned_access_speed.c
> +++ b/arch/riscv/kernel/unaligned_access_speed.c
> @@ -19,7 +19,8 @@
>  #define MISALIGNED_BUFFER_ORDER get_order(MISALIGNED_BUFFER_SIZE)
>  #define MISALIGNED_COPY_SIZE ((MISALIGNED_BUFFER_SIZE / 2) - 0x80)
>  
> -DEFINE_PER_CPU(long, misaligned_access_speed);
> +DEFINE_PER_CPU(long, misaligned_access_speed) = RISCV_HWPROBE_MISALIGNED_UNKNOWN;
> +DEFINE_PER_CPU(long, vector_misaligned_access) = RISCV_HWPROBE_VECTOR_MISALIGNED_UNSUPPORTED;
>  
>  #ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
>  static cpumask_t fast_misaligned_access;
> @@ -259,23 +260,24 @@ static int check_unaligned_access_speed_all_cpus(void)
>  	kfree(bufs);
>  	return 0;
>  }
> +#else /* CONFIG_RISCV_PROBE_UNALIGNED_ACCESS */
> +static int check_unaligned_access_speed_all_cpus(void)
> +{
> +	return 0;
> +}
> +#endif
>  
>  static int check_unaligned_access_all_cpus(void)
>  {
> -	bool all_cpus_emulated = check_unaligned_access_emulated_all_cpus();
> +	bool all_cpus_emulated;
> +
> +	all_cpus_emulated = check_unaligned_access_emulated_all_cpus();
> +	check_vector_unaligned_access_emulated_all_cpus();
>  
>  	if (!all_cpus_emulated)
>  		return check_unaligned_access_speed_all_cpus();
>  
>  	return 0;
>  }
> -#else /* CONFIG_RISCV_PROBE_UNALIGNED_ACCESS */
> -static int check_unaligned_access_all_cpus(void)
> -{
> -	check_unaligned_access_emulated_all_cpus();
> -
> -	return 0;
> -}
> -#endif
>  
>  arch_initcall(check_unaligned_access_all_cpus);
> diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
> index 682b3feee451..821818886fab 100644
> --- a/arch/riscv/kernel/vector.c
> +++ b/arch/riscv/kernel/vector.c
> @@ -66,7 +66,7 @@ void __init riscv_v_setup_ctx_cache(void)
>  #endif
>  }
>  
> -static bool insn_is_vector(u32 insn_buf)
> +bool insn_is_vector(u32 insn_buf)
>  {
>  	u32 opcode = insn_buf & __INSN_OPCODE_MASK;
>  	u32 width, csr;
> -- 
> 2.45.2
> 

