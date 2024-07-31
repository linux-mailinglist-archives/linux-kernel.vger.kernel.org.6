Return-Path: <linux-kernel+bounces-268827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0B49429F4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CF19B23144
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326831AAE15;
	Wed, 31 Jul 2024 09:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="T+HjJsTA"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E39450E2
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 09:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722417030; cv=none; b=WWRQuZ35vq/NOZLvyK8mNYPoyoTmAHf1Cay1+g6xlwjafaF9/aCbnB45zz2V75k4PBzsnrcmwIp0NBepCfcLEF0uFCwKNr+WpG1poxlyNmCNwWe/RpipR/dOrGp6lklbN2Pa5LFfM/w5kMbbwtbQD5oru2qgrGSSCDQNaozKxuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722417030; c=relaxed/simple;
	bh=0/B1vroUMwnqkrbO8sl00h0OjVolqYIQEJg7gm8TK5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLJtNSzn54n8GNCIKSLSmzf0Uem23M7OjhL3oYnpuCDTjnhRrpfDF/Vn+zvoj5pnu9e2xdDc8QOZ2H+x214OWYa8pMtkidoqmzAlSTGyTusNj+obK1tYGjdHokE0ZVMzZTQCo+hDQLR5rKgLZqWHkktGb5mAnfXuGpOTuJSxmFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=T+HjJsTA; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7ab76558a9so128545166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 02:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1722417026; x=1723021826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ijOTzuRIOMmG+h5LVKuKJQXoOZVvJtAJjmCzcOSUiH4=;
        b=T+HjJsTAz3Eu+db5F0DjBI0mNsLxpLG3lhYj94gBKaGZuCGOS4dKV5x+sAyg1LhIne
         WmWDZgaGgNagTydcUmZIQuXUOwLIvhxNIo5sZV+LH4UNrQ50PU0XFrNHky3vXVzQAGyS
         yvJAkmvT6NDfJRpN3N7k0hw+ThKNxtRH70Mu/Cui+gtUWuYlIyZCIVCVwWB4GjJhP+Xl
         Ek6Lq9cJcaOtikqvizXaDhLzWIeMEQq6dQfAHgdu0P75XupLNBJODi7MzwFChlX3lGWF
         xGONTFw6PnPsJzpIO/MvHyRIONCICQqAIrxz/KquSvjgiqgJOAlctba9jXZLskjk6S8H
         X04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722417026; x=1723021826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijOTzuRIOMmG+h5LVKuKJQXoOZVvJtAJjmCzcOSUiH4=;
        b=JrHj8XB03ZvvJyaBz79dGuKg1xnPk0d/aJbmilLgHDEbpIXiM4l1fsZqmEeWYLkB2P
         evuPUHwFjVjGNnm4HaqI/FKlLHETXeweAFz0uENDBC5ERSeTWiYUIJK+OUJkdCzjzgaV
         cIfp6A3srmnvirUKlm7MlyzlEBmCP1zs7S7OvN1311vwOq2OLvqbjrh1cAooAd3JnNIT
         5uQDJRDXsCnAy9IawGZ8lGecxo6onz9sEue6aw+Q38wONRpTw67H/INeGDubvNIASWTm
         ouMCXVxywwQ1VT8IaXODRSioonKaka8i+J/ttTpWZS5xl0AT6ufCOwJlgFbhCl68mo9G
         u/oA==
X-Forwarded-Encrypted: i=1; AJvYcCXzww3q5t8COqIUL2cKqLjSwwVH3uHiDWL0e2dyTOwuE9VmVtQCkRYM2uAjjAWngyn1EdeFZhZnP+fsXrnOuYWZODc6WxLmJ0jAn6kF
X-Gm-Message-State: AOJu0YyZJ9k2HjnG26k1ErgvTMkVLhiIbiAOxzRiZUjFxZQhivfF4KCp
	Jh5jkBTE0z/idgTG1PVYFm9aWefuOkc5+nvL5bk8ruOVSngF94X7tBZF7JRi8Cs=
X-Google-Smtp-Source: AGHT+IGikWLXIJIaE4CmCXfEuZWd5ZNEpN6IVupp6lojcIdRgu5YY+FYQIt0irFhkeky7KnOMAYmQg==
X-Received: by 2002:a17:907:c70c:b0:a7a:ab1a:2d79 with SMTP id a640c23a62f3a-a7d85a58481mr335830166b.29.1722417025618;
        Wed, 31 Jul 2024 02:10:25 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb02b3sm741388466b.189.2024.07.31.02.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 02:10:25 -0700 (PDT)
Date: Wed, 31 Jul 2024 11:10:24 +0200
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
Subject: Re: [PATCH v4 01/13] riscv: Move cpufeature.h macros into their own
 header
Message-ID: <20240731-bdb567812a741c94a2c5d38a@orel>
References: <20240731072405.197046-1-alexghiti@rivosinc.com>
 <20240731072405.197046-2-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731072405.197046-2-alexghiti@rivosinc.com>

On Wed, Jul 31, 2024 at 09:23:53AM GMT, Alexandre Ghiti wrote:
> asm/cmpxchg.h will soon need riscv_has_extension_unlikely() macros and
> then needs to include asm/cpufeature.h which introduces a lot of header
> circular dependencies.

The includes of asm/cpufeature.h don't look well maintained. I don't think
it needs asm/errno.h and it should have linux/threads.h,
linux/percpu-defs.h, and linux/kconfig.h.

> 
> So move the riscv_has_extension_XXX() macros into their own header which
> prevents such circular dependencies by including a restricted number of
> headers.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/cpufeature-macros.h | 66 ++++++++++++++++++++++
>  arch/riscv/include/asm/cpufeature.h        | 56 +-----------------
>  2 files changed, 67 insertions(+), 55 deletions(-)
>  create mode 100644 arch/riscv/include/asm/cpufeature-macros.h
> 
> diff --git a/arch/riscv/include/asm/cpufeature-macros.h b/arch/riscv/include/asm/cpufeature-macros.h
> new file mode 100644
> index 000000000000..c5f0bf75e026
> --- /dev/null
> +++ b/arch/riscv/include/asm/cpufeature-macros.h
> @@ -0,0 +1,66 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright 2022-2024 Rivos, Inc
> + */
> +
> +#ifndef _ASM_CPUFEATURE_MACROS_H
> +#define _ASM_CPUFEATURE_MACROS_H
> +
> +#include <asm/hwcap.h>
> +#include <asm/alternative-macros.h>
> +
> +#define STANDARD_EXT		0
> +
> +bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, unsigned int bit);
> +#define riscv_isa_extension_available(isa_bitmap, ext)	\
> +	__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_##ext)
> +
> +static __always_inline bool __riscv_has_extension_likely(const unsigned long vendor,
> +							 const unsigned long ext)
> +{
> +	asm goto(ALTERNATIVE("j	%l[l_no]", "nop", %[vendor], %[ext], 1)
> +	:
> +	: [vendor] "i" (vendor), [ext] "i" (ext)
> +	:
> +	: l_no);
> +
> +	return true;
> +l_no:
> +	return false;
> +}
> +
> +static __always_inline bool __riscv_has_extension_unlikely(const unsigned long vendor,
> +							   const unsigned long ext)
> +{
> +	asm goto(ALTERNATIVE("nop", "j	%l[l_yes]", %[vendor], %[ext], 1)
> +	:
> +	: [vendor] "i" (vendor), [ext] "i" (ext)
> +	:
> +	: l_yes);
> +
> +	return false;
> +l_yes:
> +	return true;
> +}
> +
> +static __always_inline bool riscv_has_extension_unlikely(const unsigned long ext)
> +{
> +	compiletime_assert(ext < RISCV_ISA_EXT_MAX, "ext must be < RISCV_ISA_EXT_MAX");
> +
> +	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
> +		return __riscv_has_extension_unlikely(STANDARD_EXT, ext);
> +
> +	return __riscv_isa_extension_available(NULL, ext);
> +}
> +
> +static __always_inline bool riscv_has_extension_likely(const unsigned long ext)
> +{
> +	compiletime_assert(ext < RISCV_ISA_EXT_MAX, "ext must be < RISCV_ISA_EXT_MAX");
> +
> +	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
> +		return __riscv_has_extension_likely(STANDARD_EXT, ext);
> +
> +	return __riscv_isa_extension_available(NULL, ext);
> +}
> +
> +#endif

nit: Add the /* _ASM_CPUFEATURE_MACROS_H */ here.

> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
> index 45f9c1171a48..c991672bb401 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -11,6 +11,7 @@
>  #include <asm/hwcap.h>
>  #include <asm/alternative-macros.h>

I think asm/alternative-macros.h can be dropped now.

>  #include <asm/errno.h>
> +#include <asm/cpufeature-macros.h>
>  
>  /*
>   * These are probed via a device_initcall(), via either the SBI or directly
> @@ -103,61 +104,6 @@ extern const size_t riscv_isa_ext_count;
>  extern bool riscv_isa_fallback;
>  
>  unsigned long riscv_isa_extension_base(const unsigned long *isa_bitmap);
> -
> -#define STANDARD_EXT		0
> -
> -bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, unsigned int bit);
> -#define riscv_isa_extension_available(isa_bitmap, ext)	\
> -	__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_##ext)
> -
> -static __always_inline bool __riscv_has_extension_likely(const unsigned long vendor,
> -							 const unsigned long ext)
> -{
> -	asm goto(ALTERNATIVE("j	%l[l_no]", "nop", %[vendor], %[ext], 1)
> -	:
> -	: [vendor] "i" (vendor), [ext] "i" (ext)
> -	:
> -	: l_no);
> -
> -	return true;
> -l_no:
> -	return false;
> -}
> -
> -static __always_inline bool __riscv_has_extension_unlikely(const unsigned long vendor,
> -							   const unsigned long ext)
> -{
> -	asm goto(ALTERNATIVE("nop", "j	%l[l_yes]", %[vendor], %[ext], 1)
> -	:
> -	: [vendor] "i" (vendor), [ext] "i" (ext)
> -	:
> -	: l_yes);
> -
> -	return false;
> -l_yes:
> -	return true;
> -}
> -
> -static __always_inline bool riscv_has_extension_unlikely(const unsigned long ext)
> -{
> -	compiletime_assert(ext < RISCV_ISA_EXT_MAX, "ext must be < RISCV_ISA_EXT_MAX");
> -
> -	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
> -		return __riscv_has_extension_unlikely(STANDARD_EXT, ext);
> -
> -	return __riscv_isa_extension_available(NULL, ext);
> -}
> -
> -static __always_inline bool riscv_has_extension_likely(const unsigned long ext)
> -{
> -	compiletime_assert(ext < RISCV_ISA_EXT_MAX, "ext must be < RISCV_ISA_EXT_MAX");
> -
> -	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
> -		return __riscv_has_extension_likely(STANDARD_EXT, ext);
> -
> -	return __riscv_isa_extension_available(NULL, ext);
> -}
> -
>  static __always_inline bool riscv_cpu_has_extension_likely(int cpu, const unsigned long ext)
>  {
>  	compiletime_assert(ext < RISCV_ISA_EXT_MAX, "ext must be < RISCV_ISA_EXT_MAX");
> -- 
> 2.39.2
> 
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew

