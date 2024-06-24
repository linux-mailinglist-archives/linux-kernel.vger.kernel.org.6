Return-Path: <linux-kernel+bounces-226602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 520009140D0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 05:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFB891F22FD0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 03:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A92E8BE5;
	Mon, 24 Jun 2024 03:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="SeAud3hX"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C3C525E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 03:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719199434; cv=none; b=q1iw96wl7NAZOi2YQjzslv0wW/sA5BTmU+H16a2tm6+qyEpdNx2wqDQUCQh2BXTQkLyGs/j8Of4vSNwVsLC9uGAKPjG6FrD5G2b+AMZzYMkHonh3dRVnBb4VAFK05Aw5aRxENjONOkDJozRtz6y3Ak+iTKObtEk4xkweA+ooJDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719199434; c=relaxed/simple;
	bh=lZcEMmty7YYc4yV+0jbs+lDLlGoNtN5lfaDIS8gEpg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhruyGH2fidVk71p6C2K5TFMKOLNckhUIxVVRUIrpEHBkSkjPurHwpw8dTepTcaeI3Jdj32rqXMKs14HEwh59G41WcGTeGFC2djg8oXbW5/gjzK62HyPaKSZ/AqvVxTYK1HXv9om9FCJMXrQ7fSTOzQrkk3qRYz1qZ+Ph8/cAI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=SeAud3hX; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-700a6853664so1047373a34.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 20:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719199431; x=1719804231; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3FWaEUeTMDHJoELxY+ZgcV9lMMpnHL5SsFDjxF9/VXs=;
        b=SeAud3hXL/2RdDm/2wUpJBK6M3s7uu9cwnvnKvHvYYCR6Yy4RqtG3kcHy4Zmd3copI
         uoKhf71ysYu/EZZvrnFgAKfUH8GA/HF2W5xFyOypEXoBVYS4VEeJTFBuHje/jBe3wn/G
         m8Wo3vR2VI5lfqZztjgtfxQUJrBuolu1kEcyH8HIXlPJjuEi993UewgOP+gPsoyTt3sq
         lxEacv3CuJy5tNIP4hiTZobEUZT4JTLzguJmMJEGcvNY71+v8pJ7hnvbezyyjPXeT1Ys
         lkiXoKo4oYXLt33qi8I8x/DEimROdL/elSiFoyO/JT/ARciMj98Yvzc4TupK4EDNtYyK
         g5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719199431; x=1719804231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FWaEUeTMDHJoELxY+ZgcV9lMMpnHL5SsFDjxF9/VXs=;
        b=AZa5NW1ElouQ6cKPqT7celo3v9z2KKoFEOhVnMoY8TNspSP76gkZzAN8r3SdM/YBxr
         gVlt026ylZEIeWhfKZEm5lGKRKtOXXsS3tErpgbh4cDE2I5yGlZPiCmssFYz5+dOkWxy
         5gmxVOOfdDDdfMgTfQ10Et49Is9q/yP//MrcgZy7VwlyBGrW4ktgmDOisBGV3NIsmAFU
         EgLVBm+h3wSFg1K+1E1hg9u0Wepfa+oLOyi2wDXO2qQHLH6Ffa3NGvnvTSsoLUMMBmog
         HzPvbGxSKhXnGmN+5OEbW5gUAabWcWPo/YwFcf2C/fgJMteoW6sfftYHxGa/UnD51u9J
         n8Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWugUK4yrgCfMFmVn+Uk7rsnN1sFeILzbTBA8WUic9JFh519wjRDiwkijcEnzjtgxOwmLIpOOUTGQ8M7RgtEUY5lg2aDkXqhF14AkHc
X-Gm-Message-State: AOJu0YyAg72+mV+RN6QKlOu8IDootCNCP4dAtGHvbV2KYhGkdYrlSiIW
	H3qxCKUd+1mmJrGRlo3ZilBn3wD2G4mEvZYCygoXybi9UkbKJRtJdKWoJPe5wlQ=
X-Google-Smtp-Source: AGHT+IE+osSaSeirW6Qbfg0AmVximTUoIwMN39FxDLs9j+BLB3XcDNJN4I4yZNiCnV4rh4f1rTSaSg==
X-Received: by 2002:a05:6830:4428:b0:6fb:9752:4d3a with SMTP id 46e09a7af769-700afa03484mr4199879a34.24.1719199430755;
        Sun, 23 Jun 2024 20:23:50 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:e283:b00b:36c9:cbf5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716bb040d0esm3811211a12.79.2024.06.23.20.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 20:23:49 -0700 (PDT)
Date: Sun, 23 Jun 2024 20:23:47 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Ard Biesheuvel <ardb@kernel.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v2] riscv: enable HAVE_ARCH_STACKLEAK
Message-ID: <Znjmw469+P1iFRHg@ghost>
References: <20240623235316.2010-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240623235316.2010-1-jszhang@kernel.org>

On Mon, Jun 24, 2024 at 07:53:16AM +0800, Jisheng Zhang wrote:
> Add support for the stackleak feature. Whenever the kernel returns to user
> space the kernel stack is filled with a poison value.
> 
> At the same time, disables the plugin in EFI stub code because EFI stub
> is out of scope for the protection.
> 
> Tested on qemu and milkv duo:
> / # echo STACKLEAK_ERASING > /sys/kernel/debug/provoke-crash/DIRECT
> [   38.675575] lkdtm: Performing direct entry STACKLEAK_ERASING
> [   38.678448] lkdtm: stackleak stack usage:
> [   38.678448]   high offset: 288 bytes
> [   38.678448]   current:     496 bytes
> [   38.678448]   lowest:      1328 bytes
> [   38.678448]   tracked:     1328 bytes
> [   38.678448]   untracked:   448 bytes
> [   38.678448]   poisoned:    14312 bytes
> [   38.678448]   low offset:  8 bytes
> [   38.689887] lkdtm: OK: the rest of the thread stack is properly erased
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
> 
> since v2:
>  - add #include <linux/sizes.h> to fixing compiler error found by
>    Charlie

Thanks!

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

> 
>  arch/riscv/Kconfig                    | 1 +
>  arch/riscv/include/asm/thread_info.h  | 1 +
>  arch/riscv/kernel/entry.S             | 4 ++++
>  drivers/firmware/efi/libstub/Makefile | 3 ++-
>  4 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 0525ee2d63c7..9cbfdffec96c 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -118,6 +118,7 @@ config RISCV
>  	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
>  	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
>  	select HAVE_ARCH_SECCOMP_FILTER
> +	select HAVE_ARCH_STACKLEAK
>  	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
>  	select HAVE_ARCH_TRACEHOOK
>  	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if 64BIT && MMU
> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
> index 5d473343634b..fca5c6be2b81 100644
> --- a/arch/riscv/include/asm/thread_info.h
> +++ b/arch/riscv/include/asm/thread_info.h
> @@ -10,6 +10,7 @@
>  
>  #include <asm/page.h>
>  #include <linux/const.h>
> +#include <linux/sizes.h>
>  
>  /* thread information allocation */
>  #define THREAD_SIZE_ORDER	CONFIG_THREAD_SIZE_ORDER
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 68a24cf9481a..80ff55a26d13 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -130,6 +130,10 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
>  #endif
>  	bnez s0, 1f
>  
> +#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
> +	call	stackleak_erase_on_task_stack
> +#endif
> +
>  	/* Save unwound kernel stack pointer in thread_info */
>  	addi s0, sp, PT_SIZE_ON_STACK
>  	REG_S s0, TASK_TI_KERNEL_SP(tp)
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index 06f0428a723c..3a9521c57641 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -28,7 +28,8 @@ cflags-$(CONFIG_ARM)		+= -DEFI_HAVE_STRLEN -DEFI_HAVE_STRNLEN \
>  				   -DEFI_HAVE_MEMCHR -DEFI_HAVE_STRRCHR \
>  				   -DEFI_HAVE_STRCMP -fno-builtin -fpic \
>  				   $(call cc-option,-mno-single-pic-base)
> -cflags-$(CONFIG_RISCV)		+= -fpic -DNO_ALTERNATIVE -mno-relax
> +cflags-$(CONFIG_RISCV)		+= -fpic -DNO_ALTERNATIVE -mno-relax \
> +				   $(DISABLE_STACKLEAK_PLUGIN)
>  cflags-$(CONFIG_LOONGARCH)	+= -fpie
>  
>  cflags-$(CONFIG_EFI_PARAMS_FROM_FDT)	+= -I$(srctree)/scripts/dtc/libfdt
> -- 
> 2.43.0
> 

