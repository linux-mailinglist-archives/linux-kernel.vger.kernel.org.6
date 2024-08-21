Return-Path: <linux-kernel+bounces-295713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BCE95A06C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11B311F23A66
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246071B250A;
	Wed, 21 Aug 2024 14:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="o2/UQo7p"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC694364D6
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 14:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724251912; cv=none; b=agrZpcWDaSd290Nl0JGQP1KCSbqIZ9yecThyD0yQPS0XRnmkhakhLrT/PL5Sbx2tCfRBqagkl8FNw6izQoyAQVCebA0Q7ZEjK0lRqAFycTcBKzwPH8CEmG5Az3UtwW4YvZxcphFyt5Af3lo4zHClSALnIdhJOzg4UZrubFujn28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724251912; c=relaxed/simple;
	bh=+/iqDUdNtBZcdvep0mmLMlp3fOL2oTvyuwkykFcr7G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7yuFlGNS57XwPzrtrRcaAT33wyoReTj5MLiqX727Rd6dlI1Ikste8EoZUVBYVkVFI5YSVAmEdanfwfYJ6+d7/dpAmou1A1CO/8zZpGhW6pEjBnzcE5r7LHY4vzykCjHfhPGZSNzH4J9914uSqgNeggZGxvpxyuDAlduHz+yoyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=o2/UQo7p; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5beb6ea9ed6so7057512a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 07:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1724251908; x=1724856708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/9z45COXiOa8Ur7PNvfAex0dKJEUmq0VNfjSEwtXU3g=;
        b=o2/UQo7p9dIUxAnHK9wbKh3q046P1airZkEc439nFPm0hmyty2Ie65gkVxobl+3qrR
         hoKweGcv2NgYZf8QAVqNTFkzQZE89ZRLkbMdlNtc0YNPefpb5dpt2O5lVNNIquPR8NBj
         1BKXlo9h9bnvfabE4kaKLhsZAnDjFqujlR3hjhjFmGCatpGh0Vno5e1fUehbIdbd3siw
         BNMPQHXgPYNGdE+g6KRMT8ecgj86em+rjiZ1BoKib0fo/ZljdUdaqF8aQ1k0N6bIraT+
         H1Bh/F8vvePOpxqjubOsYOBnyM3oP7oJvoMbjgoUVbKXe2svoLc6tQ3F6f0lOQ5nZ/FQ
         D/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724251908; x=1724856708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9z45COXiOa8Ur7PNvfAex0dKJEUmq0VNfjSEwtXU3g=;
        b=Pkz0iBEfk23ioQX8siRCiN/MxTQvRWjgPGC+dlr2fKuIKazuanoz7hq33fMkyikV+4
         n29o/qPRfeLefmnWjYLfVxrKY8XuX9Bh5ZH9Mmhw/aB99uakmfyU+mDIzlslcbtm9Zau
         JBcPOqLwGTJ3WiNaVk+LfmajS/OXOJl32v3tKWzow3Hti6I7pVHMhZWsJm+EIV+CT7V0
         3uVoHsBKGL/sRPmMKDxllQVRhryIBDQnCHTG2FhlZCgfEpUL7mFcaq2WZzR7QQUuly3a
         7qBOPiwjP2+Vt8ABsyTHfHi9IZzkFa4ibT4XIjEhAwYSSzze0iTjBDd82jnp9gxP0Euh
         yoUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFDCrPh7hRyNK/zHq0hexZiJnePf6yb2Y6ig2/az8mhJGzi6aPkThtMsa3mqzipiu3xNmnSY+HRzH3aSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmZUt9UzqXrEV+ercgotQLeQgarmS24oj7tSyEXsmtMsMjVCaL
	nxbB6P1aAhsQHJ2V53Xawd5rvJvLXLunh9Do50JTYaCdQiuHaBpS2zQOei0Q//o=
X-Google-Smtp-Source: AGHT+IFaIncl/DtJadX96lKhBGv1TThBKGu6LlRSGCmIs0kZEeAJeyIHSe6bPyWgF2jtKC9PjY8pKQ==
X-Received: by 2002:a17:906:c149:b0:a77:dd1c:6273 with SMTP id a640c23a62f3a-a866f136a88mr179111066b.12.1724251907406;
        Wed, 21 Aug 2024 07:51:47 -0700 (PDT)
Received: from localhost (cst2-173-13.cust.vodafone.cz. [31.30.173.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c6ac5sm918850266b.18.2024.08.21.07.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 07:51:47 -0700 (PDT)
Date: Wed, 21 Aug 2024 16:51:45 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Andrea Parri <parri.andrea@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v5 13/13] riscv: Add qspinlock support
Message-ID: <20240821-ec1ec92842570050429621d1@orel>
References: <20240818063538.6651-1-alexghiti@rivosinc.com>
 <20240818063538.6651-14-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240818063538.6651-14-alexghiti@rivosinc.com>

On Sun, Aug 18, 2024 at 08:35:38AM GMT, Alexandre Ghiti wrote:
> In order to produce a generic kernel, a user can select
> CONFIG_COMBO_SPINLOCKS which will fallback at runtime to the ticket
> spinlock implementation if Zabha or Ziccrse are not present.
> 
> Note that we can't use alternatives here because the discovery of
> extensions is done too late and we need to start with the qspinlock
> implementation because the ticket spinlock implementation would pollute
> the spinlock value, so let's use static keys.
> 
> This is largely based on Guo's work and Leonardo reviews at [1].
> 
> Link: https://lore.kernel.org/linux-riscv/20231225125847.2778638-1-guoren@kernel.org/ [1]
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  .../locking/queued-spinlocks/arch-support.txt |  2 +-
>  arch/riscv/Kconfig                            | 34 ++++++++++++++
>  arch/riscv/include/asm/Kbuild                 |  4 +-
>  arch/riscv/include/asm/spinlock.h             | 47 +++++++++++++++++++
>  arch/riscv/kernel/setup.c                     | 37 +++++++++++++++
>  include/asm-generic/qspinlock.h               |  2 +
>  include/asm-generic/ticket_spinlock.h         |  2 +
>  7 files changed, 126 insertions(+), 2 deletions(-)
>  create mode 100644 arch/riscv/include/asm/spinlock.h
> 
> diff --git a/Documentation/features/locking/queued-spinlocks/arch-support.txt b/Documentation/features/locking/queued-spinlocks/arch-support.txt
> index 22f2990392ff..cf26042480e2 100644
> --- a/Documentation/features/locking/queued-spinlocks/arch-support.txt
> +++ b/Documentation/features/locking/queued-spinlocks/arch-support.txt
> @@ -20,7 +20,7 @@
>      |    openrisc: |  ok  |
>      |      parisc: | TODO |
>      |     powerpc: |  ok  |
> -    |       riscv: | TODO |
> +    |       riscv: |  ok  |
>      |        s390: | TODO |
>      |          sh: | TODO |
>      |       sparc: |  ok  |
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index ef55ab94027e..201d0669db7f 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -79,6 +79,7 @@ config RISCV
>  	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
>  	select ARCH_WANTS_NO_INSTR
>  	select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
> +	select ARCH_WEAK_RELEASE_ACQUIRE if ARCH_USE_QUEUED_SPINLOCKS

Hi Alex,

Did you get a chance to experiment this as suggested by Andrea?

>  	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
>  	select BUILDTIME_TABLE_SORT if MMU
>  	select CLINT_TIMER if RISCV_M_MODE
> @@ -488,6 +489,39 @@ config NODES_SHIFT
>  	  Specify the maximum number of NUMA Nodes available on the target
>  	  system.  Increases memory reserved to accommodate various tables.
>  
> +choice
> +	prompt "RISC-V spinlock type"
> +	default RISCV_COMBO_SPINLOCKS
> +
> +config RISCV_TICKET_SPINLOCKS
> +	bool "Using ticket spinlock"
> +
> +config RISCV_QUEUED_SPINLOCKS
> +	bool "Using queued spinlock"
> +	depends on SMP && MMU && NONPORTABLE
> +	select ARCH_USE_QUEUED_SPINLOCKS
> +	help
> +	  The queued spinlock implementation requires the forward progress
> +	  guarantee of cmpxchg()/xchg() atomic operations: CAS with Zabha or
> +	  LR/SC with Ziccrse provide such guarantee.
> +
> +	  Select this if and only if Zabha or Ziccrse is available on your
> +	  platform, RISCV_QUEUED_SPINLOCKS must not be selected for platforms
> +	  without one of those extensions.
> +
> +	  If unsure, select RISCV_COMBO_SPINLOCKS, which will use qspinlocks
> +	  when supported and otherwise ticket spinlocks.
> +
> +config RISCV_COMBO_SPINLOCKS
> +	bool "Using combo spinlock"
> +	depends on SMP && MMU
> +	select ARCH_USE_QUEUED_SPINLOCKS
> +	help
> +	  Embed both queued spinlock and ticket lock so that the spinlock
> +	  implementation can be chosen at runtime.
> +
> +endchoice
> +
>  config RISCV_ALTERNATIVE
>  	bool
>  	depends on !XIP_KERNEL
> diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
> index 5c589770f2a8..1c2618c964f0 100644
> --- a/arch/riscv/include/asm/Kbuild
> +++ b/arch/riscv/include/asm/Kbuild
> @@ -5,10 +5,12 @@ syscall-y += syscall_table_64.h
>  generic-y += early_ioremap.h
>  generic-y += flat.h
>  generic-y += kvm_para.h
> +generic-y += mcs_spinlock.h
>  generic-y += parport.h
> -generic-y += spinlock.h
>  generic-y += spinlock_types.h
> +generic-y += ticket_spinlock.h
>  generic-y += qrwlock.h
>  generic-y += qrwlock_types.h
> +generic-y += qspinlock.h
>  generic-y += user.h
>  generic-y += vmlinux.lds.h
> diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
> new file mode 100644
> index 000000000000..e5121b89acea
> --- /dev/null
> +++ b/arch/riscv/include/asm/spinlock.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __ASM_RISCV_SPINLOCK_H
> +#define __ASM_RISCV_SPINLOCK_H
> +
> +#ifdef CONFIG_RISCV_COMBO_SPINLOCKS
> +#define _Q_PENDING_LOOPS	(1 << 9)
> +
> +#define __no_arch_spinlock_redefine
> +#include <asm/ticket_spinlock.h>
> +#include <asm/qspinlock.h>
> +#include <asm/jump_label.h>
> +
> +/*
> + * TODO: Use an alternative instead of a static key when we are able to parse
> + * the extensions string earlier in the boot process.
> + */
> +DECLARE_STATIC_KEY_TRUE(qspinlock_key);
> +
> +#define SPINLOCK_BASE_DECLARE(op, type, type_lock)			\
> +static __always_inline type arch_spin_##op(type_lock lock)		\
> +{									\
> +	if (static_branch_unlikely(&qspinlock_key))			\
> +		return queued_spin_##op(lock);				\
> +	return ticket_spin_##op(lock);					\
> +}

I guess there were still a couple questions on the kernel size impact of
this.

> +
> +SPINLOCK_BASE_DECLARE(lock, void, arch_spinlock_t *)
> +SPINLOCK_BASE_DECLARE(unlock, void, arch_spinlock_t *)
> +SPINLOCK_BASE_DECLARE(is_locked, int, arch_spinlock_t *)
> +SPINLOCK_BASE_DECLARE(is_contended, int, arch_spinlock_t *)
> +SPINLOCK_BASE_DECLARE(trylock, bool, arch_spinlock_t *)
> +SPINLOCK_BASE_DECLARE(value_unlocked, int, arch_spinlock_t)
> +
> +#elif defined(CONFIG_RISCV_QUEUED_SPINLOCKS)
> +
> +#include <asm/qspinlock.h>
> +
> +#else
> +
> +#include <asm/ticket_spinlock.h>
> +
> +#endif
> +
> +#include <asm/qrwlock.h>
> +
> +#endif /* __ASM_RISCV_SPINLOCK_H */
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index a2cde65b69e9..438e4f6ad2ad 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -244,6 +244,42 @@ static void __init parse_dtb(void)
>  #endif
>  }
>  
> +#if defined(CONFIG_RISCV_COMBO_SPINLOCKS)
> +DEFINE_STATIC_KEY_TRUE(qspinlock_key);
> +EXPORT_SYMBOL(qspinlock_key);
> +#endif
> +
> +static void __init riscv_spinlock_init(void)
> +{
> +	char *using_ext = NULL;
> +
> +	if (IS_ENABLED(CONFIG_RISCV_TICKET_SPINLOCKS)) {
> +		pr_info("Ticket spinlock: enabled\n");
> +		return;
> +	}
> +
> +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA) &&
> +	    IS_ENABLED(CONFIG_RISCV_ISA_ZACAS) &&
> +	    riscv_isa_extension_available(NULL, ZABHA) &&
> +	    riscv_isa_extension_available(NULL, ZACAS)) {
> +		using_ext = "using Zabha";
> +	} else if (riscv_isa_extension_available(NULL, ZICCRSE)) {
> +		using_ext = "using Ziccrse";
> +	}
> +#if defined(CONFIG_RISCV_COMBO_SPINLOCKS)
> +	else {
> +		static_branch_disable(&qspinlock_key);
> +		pr_info("Ticket spinlock: enabled\n");
> +		return;
> +	}
> +#endif
> +
> +	if (!using_ext)
> +		pr_err("Queued spinlock without Zabha or Ziccrse");
> +	else
> +		pr_info("Queued spinlock %s: enabled\n", using_ext);
> +}
> +
>  extern void __init init_rt_signal_env(void);
>  
>  void __init setup_arch(char **cmdline_p)
> @@ -297,6 +333,7 @@ void __init setup_arch(char **cmdline_p)
>  	riscv_set_dma_cache_alignment();
>  
>  	riscv_user_isa_enable();
> +	riscv_spinlock_init();
>  }
>  
>  bool arch_cpu_is_hotpluggable(int cpu)
> diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
> index 0655aa5b57b2..bf47cca2c375 100644
> --- a/include/asm-generic/qspinlock.h
> +++ b/include/asm-generic/qspinlock.h
> @@ -136,6 +136,7 @@ static __always_inline bool virt_spin_lock(struct qspinlock *lock)
>  }
>  #endif
>  
> +#ifndef __no_arch_spinlock_redefine
>  /*
>   * Remapping spinlock architecture specific functions to the corresponding
>   * queued spinlock functions.
> @@ -146,5 +147,6 @@ static __always_inline bool virt_spin_lock(struct qspinlock *lock)
>  #define arch_spin_lock(l)		queued_spin_lock(l)
>  #define arch_spin_trylock(l)		queued_spin_trylock(l)
>  #define arch_spin_unlock(l)		queued_spin_unlock(l)
> +#endif
>  
>  #endif /* __ASM_GENERIC_QSPINLOCK_H */
> diff --git a/include/asm-generic/ticket_spinlock.h b/include/asm-generic/ticket_spinlock.h
> index cfcff22b37b3..325779970d8a 100644
> --- a/include/asm-generic/ticket_spinlock.h
> +++ b/include/asm-generic/ticket_spinlock.h
> @@ -89,6 +89,7 @@ static __always_inline int ticket_spin_is_contended(arch_spinlock_t *lock)
>  	return (s16)((val >> 16) - (val & 0xffff)) > 1;
>  }
>  
> +#ifndef __no_arch_spinlock_redefine
>  /*
>   * Remapping spinlock architecture specific functions to the corresponding
>   * ticket spinlock functions.
> @@ -99,5 +100,6 @@ static __always_inline int ticket_spin_is_contended(arch_spinlock_t *lock)
>  #define arch_spin_lock(l)		ticket_spin_lock(l)
>  #define arch_spin_trylock(l)		ticket_spin_trylock(l)
>  #define arch_spin_unlock(l)		ticket_spin_unlock(l)
> +#endif
>  
>  #endif /* __ASM_GENERIC_TICKET_SPINLOCK_H */
> -- 
> 2.39.2
>
 
The patch looks good to me, so

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

It'd still be good to hear more about ARCH_WEAK_RELEASE_ACQUIRE and the
kernel size though.

Thanks,
drew

