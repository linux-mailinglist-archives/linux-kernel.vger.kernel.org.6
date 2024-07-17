Return-Path: <linux-kernel+bounces-255330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 669D1933F40
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8CE31F22691
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB31181B9A;
	Wed, 17 Jul 2024 15:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="jtRixJCi"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59D0180A77
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 15:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721228905; cv=none; b=lT/YTj0ZXcUBoNxmGukYUPF4pAfTo8nn+Rd2An36iZ4t7gIfsp8F9jQt++VqxTiHGGi6IexQL3Mp5f/NBT1C+IJ+5LC8H4NuJimwHPWOymYuuONT/hnDx4Pf063dM1AIXc8PEjAKTMvGqomjxdpxsh6tKqQDovuhnO9V1iN1/rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721228905; c=relaxed/simple;
	bh=6HNIyxMK51KSlAtR/kdKM7bK0ZA6cQviwa2OKaVTJKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qg4vK+McOazZbMOl5cJAu1yXJsSfvYsE8iOg1sTC6DhzAH4TNq+kNYpZFXYAiC68v/YHP0x3LTIxaNnXzB6C9UikhnbluQeaJyHqjJ8JqGBDKVOBaSjgiNcF8JAYSel/v8RBEZeVgV1SdNL2XzkO5jGKhFgtuoo93ZFQpaTiD+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=jtRixJCi; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-79f0c08aa45so471337385a.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 08:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1721228901; x=1721833701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fi/isgE1Pm11CKabZ9tWJMK8UbnuSiqX86ntuw4zABo=;
        b=jtRixJCi+tKZwN68o/uDHg/0lfEguRr+XaK5UL6rk8Qy4LK0ZHQ8ifoBZ1/CTGg+1f
         Q2J37wd1cmsSicK/W52MfNX8fYOODPlOLIvQQ3xRAxc8WXNPOcbzz0dP399cCr+12iq6
         2t17/xhzdaGFvXhXW73vjoUffx36NVGW2IEcDzex/ztqlojCkQsm+u6vsJWEP7JSSyqF
         og/1IQ816HUxeQQK5xKawVKR7/2qkW+taVJCb1JlrF7manonbwca0EFlwa4WSk65Vb5Y
         Dc3ct7q3EcUY8wFO6WeRIYb+otd6z9+i/0nICmOgoNK1NzUxAAcabXndfTPJOslGmtBw
         mY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721228901; x=1721833701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fi/isgE1Pm11CKabZ9tWJMK8UbnuSiqX86ntuw4zABo=;
        b=WoH11oYCRSRz07RfIiY7JbtWNuYnAFszT2yqoXhCKh5+wCxWiqVecNyMJhmKIAAM54
         3d7S2hqEmKttrKobYG0x5uDeCbFEmHkS3R0xDALECy/JPXogJ1IL4bPCtP3S9cDX1l46
         uOXXZKf3IZWOoKpEWQKCqz1jJbsT6WxKn+7bpADB+O8SLEUFbdRybVQpjYggDasQ8Mdg
         CfpaY76W372n90RfB1h23y7RqqDq7mkX37cV/EaiF4oCdiq0HSoXS8NdYa0oxyxxFKfH
         Pd1vvJWnRNyzIPGM5Tq21z2lLhw/8p/blNvO6SQ5nILYD4YLk4M3NJCzlk2eBGZ1W7gv
         KcmA==
X-Forwarded-Encrypted: i=1; AJvYcCWZCLrvQj+nO2O6HqoXYerOakSf/db8b740GOfYca6xUZNkwVQNNEqrubUQaSqiZ69YWJPbw+VKbdhVLpizQnFBcOoUPyirOXs9uWAG
X-Gm-Message-State: AOJu0YzqX57ay+4IJOJtTQfCjAV6rb4cRIsUVUmu5/CXlgM2atoluJ9R
	4aQ0Vw0OmsuIA8It3hksDg4KfG3URymJ90o9gahzTef/+mx77kre7X0TWqi50dQ=
X-Google-Smtp-Source: AGHT+IG7uixuMZnaEeCwSoRYkGiPDewVPpgv/wPaPtJXzxlNiA262oRzJeKASnxaYhL4f7oonG9SEA==
X-Received: by 2002:a05:620a:390b:b0:79f:d80:5930 with SMTP id af79cd13be357-7a1874e0770mr251887185a.52.1721228901252;
        Wed, 17 Jul 2024 08:08:21 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160c65924sm412147385a.73.2024.07.17.08.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 08:08:20 -0700 (PDT)
Date: Wed, 17 Jul 2024 10:08:19 -0500
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
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 01/11] riscv: Implement cmpxchg32/64() using Zacas
Message-ID: <20240717-8f0afff97de3095badf4fc4e@orel>
References: <20240717061957.140712-1-alexghiti@rivosinc.com>
 <20240717061957.140712-2-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717061957.140712-2-alexghiti@rivosinc.com>

On Wed, Jul 17, 2024 at 08:19:47AM GMT, Alexandre Ghiti wrote:
> This adds runtime support for Zacas in cmpxchg operations.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/Kconfig               | 17 +++++++++++++++++
>  arch/riscv/Makefile              |  3 +++
>  arch/riscv/include/asm/cmpxchg.h | 26 +++++++++++++++++++++++---
>  3 files changed, 43 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 05ccba8ca33a..1caaedec88c7 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -596,6 +596,23 @@ config RISCV_ISA_V_PREEMPTIVE
>  	  preemption. Enabling this config will result in higher memory
>  	  consumption due to the allocation of per-task's kernel Vector context.
>  
> +config TOOLCHAIN_HAS_ZACAS
> +	bool
> +	default y
> +	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64ima_zacas)
> +	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32ima_zacas)
> +	depends on AS_HAS_OPTION_ARCH
> +
> +config RISCV_ISA_ZACAS
> +	bool "Zacas extension support for atomic CAS"
> +	depends on TOOLCHAIN_HAS_ZACAS
> +	default y
> +	help
> +	  Enable the use of the Zacas ISA-extension to implement kernel atomic
> +	  cmpxchg operations when it is detected at boot.
> +
> +	  If you don't know what to do here, say Y.
> +
>  config TOOLCHAIN_HAS_ZBB
>  	bool
>  	default y
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 06de9d365088..9fd13d7a9cc6 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -85,6 +85,9 @@ endif
>  # Check if the toolchain supports Zihintpause extension
>  riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZIHINTPAUSE) := $(riscv-march-y)_zihintpause
>  
> +# Check if the toolchain supports Zacas
> +riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZACAS) := $(riscv-march-y)_zacas
> +
>  # Remove F,D,V from isa string for all. Keep extensions between "fd" and "v" by
>  # matching non-v and non-multi-letter extensions out with the filter ([^v_]*)
>  KBUILD_CFLAGS += -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64ima)fd([^v_]*)v?/\1\2/')
> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> index 808b4c78462e..5d38153e2f13 100644
> --- a/arch/riscv/include/asm/cmpxchg.h
> +++ b/arch/riscv/include/asm/cmpxchg.h
> @@ -9,6 +9,7 @@
>  #include <linux/bug.h>
>  
>  #include <asm/fence.h>
> +#include <asm/alternative.h>
>  
>  #define __arch_xchg_masked(sc_sfx, prepend, append, r, p, n)		\
>  ({									\
> @@ -134,21 +135,40 @@
>  	r = (__typeof__(*(p)))((__retx & __mask) >> __s);		\
>  })
>  
> -#define __arch_cmpxchg(lr_sfx, sc_sfx, prepend, append, r, p, co, o, n)	\
> +#define __arch_cmpxchg(lr_sfx, sc_cas_sfx, prepend, append, r, p, co, o, n)	\

I'd either not bother renaming sc_sfx or also rename it in _arch_cmpxchg.

>  ({									\
> +	__label__ no_zacas, end;					\
>  	register unsigned int __rc;					\
>  									\
> +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZACAS)) {			\
> +		asm goto(ALTERNATIVE("j %[no_zacas]", "nop", 0,		\
> +				     RISCV_ISA_EXT_ZACAS, 1)		\
> +			 : : : : no_zacas);				\
> +									\
> +		__asm__ __volatile__ (					\
> +			prepend						\
> +			"	amocas" sc_cas_sfx " %0, %z2, %1\n"	\
> +			append						\
> +			: "+&r" (r), "+A" (*(p))			\
> +			: "rJ" (n)					\
> +			: "memory");					\
> +		goto end;						\
> +	}								\
> +									\
> +no_zacas:								\
>  	__asm__ __volatile__ (						\
>  		prepend							\
>  		"0:	lr" lr_sfx " %0, %2\n"				\
>  		"	bne  %0, %z3, 1f\n"				\
> -		"	sc" sc_sfx " %1, %z4, %2\n"			\
> +		"	sc" sc_cas_sfx " %1, %z4, %2\n"			\
>  		"	bnez %1, 0b\n"					\
>  		append							\
>  		"1:\n"							\
>  		: "=&r" (r), "=&r" (__rc), "+A" (*(p))			\
>  		: "rJ" (co o), "rJ" (n)					\
>  		: "memory");						\
> +									\
> +end:;									\
>  })
>  
>  #define _arch_cmpxchg(ptr, old, new, sc_sfx, prepend, append)		\
> @@ -156,7 +176,7 @@
>  	__typeof__(ptr) __ptr = (ptr);					\
>  	__typeof__(*(__ptr)) __old = (old);				\
>  	__typeof__(*(__ptr)) __new = (new);				\
> -	__typeof__(*(__ptr)) __ret;					\
> +	__typeof__(*(__ptr)) __ret = (old);				\

Is this just to silence some compiler warnings? Can we point out
whatever the reason is in the commit message?

>  									\
>  	switch (sizeof(*__ptr)) {					\
>  	case 1:								\
> -- 
> 2.39.2
>

Thanks,
drew

