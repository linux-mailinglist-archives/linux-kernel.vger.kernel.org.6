Return-Path: <linux-kernel+bounces-271082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 607C5944947
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B6B9281B58
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7657183CB6;
	Thu,  1 Aug 2024 10:26:57 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669A2446A1
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 10:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722508017; cv=none; b=JVHML6HSYev0oTNgizpPYoE785Y6wycyUnw0RPOLCKji0hxy5C0O2GN590v34ubzHyCtKCsk2o6k3CyZJ50R2NH8oDew/iyy1MOBiR+0zJ8DG+VU0bUimXqszfQDmJvMtb1uaQvBiiDqhz79tLB/4+EFUhLAIZhHealRBXkcEFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722508017; c=relaxed/simple;
	bh=AVQ7+qzvEX4A1xCKww7iGI34/XcxbgUlHKq2B8R0BAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HnPq5s/E/6GOEgD5uE9qeSW8fcyZ0rg3LawQ1kBBEAjoLOFHG1r5bTUOY7md4upr5QgYS+V4UMRs+5y2HH7cj7Bn6oEd09jgOacueHnb5M0GXWAekpRBxALRHBBo8rh8Q5BcPull1apF0iD4wyHHHG53EeABmvEu47XzMxRN3gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id CA3EB1BF209;
	Thu,  1 Aug 2024 10:26:45 +0000 (UTC)
Message-ID: <e935d5a3-1754-422c-aa92-08977ab9c929@ghiti.fr>
Date: Thu, 1 Aug 2024 12:26:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] riscv: Omit optimized string routines when using
 KASAN
Content-Language: en-US
To: Samuel Holland <samuel.holland@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org
Cc: Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org
References: <20240801033725.28816-1-samuel.holland@sifive.com>
 <20240801033725.28816-2-samuel.holland@sifive.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240801033725.28816-2-samuel.holland@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Samuel,

On 01/08/2024 05:36, Samuel Holland wrote:
> The optimized string routines are implemented in assembly, so they are
> not instrumented for use with KASAN. Fall back to the C version of the
> routines in order to improve KASAN coverage. This fixes the
> kasan_strings() unit test.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
>   arch/riscv/include/asm/string.h | 2 ++
>   arch/riscv/kernel/riscv_ksyms.c | 3 ---
>   arch/riscv/lib/Makefile         | 2 ++
>   arch/riscv/lib/strcmp.S         | 1 +
>   arch/riscv/lib/strlen.S         | 1 +
>   arch/riscv/lib/strncmp.S        | 1 +
>   arch/riscv/purgatory/Makefile   | 2 ++
>   7 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/include/asm/string.h b/arch/riscv/include/asm/string.h
> index a96b1fea24fe..5ba77f60bf0b 100644
> --- a/arch/riscv/include/asm/string.h
> +++ b/arch/riscv/include/asm/string.h
> @@ -19,6 +19,7 @@ extern asmlinkage void *__memcpy(void *, const void *, size_t);
>   extern asmlinkage void *memmove(void *, const void *, size_t);
>   extern asmlinkage void *__memmove(void *, const void *, size_t);
>   
> +#if !(defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS))


We do not support KASAN_SW_TAGS so there is no need for this #ifdef.


>   #define __HAVE_ARCH_STRCMP
>   extern asmlinkage int strcmp(const char *cs, const char *ct);
>   
> @@ -27,6 +28,7 @@ extern asmlinkage __kernel_size_t strlen(const char *);
>   
>   #define __HAVE_ARCH_STRNCMP
>   extern asmlinkage int strncmp(const char *cs, const char *ct, size_t count);
> +#endif
>   
>   /* For those files which don't want to check by kasan. */
>   #if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)
> diff --git a/arch/riscv/kernel/riscv_ksyms.c b/arch/riscv/kernel/riscv_ksyms.c
> index a72879b4249a..5ab1c7e1a6ed 100644
> --- a/arch/riscv/kernel/riscv_ksyms.c
> +++ b/arch/riscv/kernel/riscv_ksyms.c
> @@ -12,9 +12,6 @@
>   EXPORT_SYMBOL(memset);
>   EXPORT_SYMBOL(memcpy);
>   EXPORT_SYMBOL(memmove);
> -EXPORT_SYMBOL(strcmp);
> -EXPORT_SYMBOL(strlen);
> -EXPORT_SYMBOL(strncmp);
>   EXPORT_SYMBOL(__memset);
>   EXPORT_SYMBOL(__memcpy);
>   EXPORT_SYMBOL(__memmove);
> diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
> index 2b369f51b0a5..8eec6b69a875 100644
> --- a/arch/riscv/lib/Makefile
> +++ b/arch/riscv/lib/Makefile
> @@ -3,9 +3,11 @@ lib-y			+= delay.o
>   lib-y			+= memcpy.o
>   lib-y			+= memset.o
>   lib-y			+= memmove.o
> +ifeq ($(CONFIG_KASAN_GENERIC)$(CONFIG_KASAN_SW_TAGS),)
>   lib-y			+= strcmp.o
>   lib-y			+= strlen.o
>   lib-y			+= strncmp.o
> +endif
>   lib-y			+= csum.o
>   ifeq ($(CONFIG_MMU), y)
>   lib-$(CONFIG_RISCV_ISA_V)	+= uaccess_vector.o
> diff --git a/arch/riscv/lib/strcmp.S b/arch/riscv/lib/strcmp.S
> index 687b2bea5c43..542301a67a2f 100644
> --- a/arch/riscv/lib/strcmp.S
> +++ b/arch/riscv/lib/strcmp.S
> @@ -120,3 +120,4 @@ strcmp_zbb:
>   .option pop
>   #endif
>   SYM_FUNC_END(strcmp)
> +EXPORT_SYMBOL(strcmp)
> diff --git a/arch/riscv/lib/strlen.S b/arch/riscv/lib/strlen.S
> index 8ae3064e45ff..962983b73251 100644
> --- a/arch/riscv/lib/strlen.S
> +++ b/arch/riscv/lib/strlen.S
> @@ -131,3 +131,4 @@ strlen_zbb:
>   #endif
>   SYM_FUNC_END(strlen)
>   SYM_FUNC_ALIAS(__pi_strlen, strlen)
> +EXPORT_SYMBOL(strlen)
> diff --git a/arch/riscv/lib/strncmp.S b/arch/riscv/lib/strncmp.S
> index aba5b3148621..0f359ea2f55b 100644
> --- a/arch/riscv/lib/strncmp.S
> +++ b/arch/riscv/lib/strncmp.S
> @@ -136,3 +136,4 @@ strncmp_zbb:
>   .option pop
>   #endif
>   SYM_FUNC_END(strncmp)
> +EXPORT_SYMBOL(strncmp)
> diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
> index f11945ee2490..fb9c917c9b45 100644
> --- a/arch/riscv/purgatory/Makefile
> +++ b/arch/riscv/purgatory/Makefile
> @@ -1,7 +1,9 @@
>   # SPDX-License-Identifier: GPL-2.0
>   
>   purgatory-y := purgatory.o sha256.o entry.o string.o ctype.o memcpy.o memset.o
> +ifeq ($(CONFIG_KASAN_GENERIC)$(CONFIG_KASAN_SW_TAGS),)
>   purgatory-y += strcmp.o strlen.o strncmp.o
> +endif
>   
>   targets += $(purgatory-y)
>   PURGATORY_OBJS = $(addprefix $(obj)/,$(purgatory-y))


With the removal of KASAN_SW_TAGS, you can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

And since I have this testsuite in my CI, I gave it a try and it works so:

Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex




