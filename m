Return-Path: <linux-kernel+bounces-225391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A148A913017
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 00:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294DA1F262CE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 22:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3461117C23C;
	Fri, 21 Jun 2024 22:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="HXM3+qjX"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B2617C20E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 22:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719007849; cv=none; b=iwe39kdMakyB48PuAA/q7bwqcIti2poyXmb5lS+XNQVRIRfkq6icgEoAtw+ggMVKyLfe7+lc6H4Lf89Pwv5eKJiExPAJI3/lHNUTyiq+Ann9+4qGe+qeaQh1FFl4p08MqNMph5PeRCbtynAFinwGIXrHELbzO7kAvfQEE5YM+9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719007849; c=relaxed/simple;
	bh=ZEyjg1DGdHfvMHVyn3oiXgYoAsPB9kPjfgjytYscvC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bchzGZ9F5fWc3ojbkM8aEe+KtHVfR4MPgYMKN0icpj+T/W2vLGXR3QwmngfzhvylkVbelrR28mOfM+Yk/h4FcR/fWPcGfW7qIAvJQEI2u2idPQdnjPm9fQn/FCi7FNO7qxm88vN0hdoLn7COpIMUdx37qbMiWIVHrDKdbcVm/Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=HXM3+qjX; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-70346ae2c43so2417576a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719007846; x=1719612646; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W6zNTGp1aTwOtvLdnUXPrvSqBQrllJdVcW2FVVgDB5g=;
        b=HXM3+qjXxtXZ59+HmVscZ/hJS6if3zHHfXT84Pi+RsoH+Vteq9ece+6LBs+pm4XXDN
         ZqN5p91ivkN4iEO2UWDal+H9R/nkwhF0mnrNCZegFNcKlXvD6q+7wyRPnyXVge7W0HIx
         vG8rGq8j+Mq3qFbRKFaYO0RHGB5NYVAA4r+g5dafKAZbK8smEUBlUV63fPJHD61+BNZQ
         RxLqQvVIcISTeoWD1MsVcsPqDM+IpX1wtkws2YOeDnlInOjMIOlDMHE1x/PQRogVHsFL
         IhDVGv0Sd0oGzHWkaA6tpLOWLK+V105PqUmeputuqWPzU4aUBjR5qVSIZaP1Ab3tQta3
         JSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719007846; x=1719612646;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W6zNTGp1aTwOtvLdnUXPrvSqBQrllJdVcW2FVVgDB5g=;
        b=iHmdnbPCfXZmuQAw8CMFY21mytJ6xfBZkTIK9eWV2iVHkFiUpzCRs72fzTxc1cxh59
         3Tn70oqgF11Q3FlbwvAnWYy23C1r08AQis2n1BOMlIBPDon9+XiHhvUlAeHwFOt75G2A
         cRYUhJFEScmZpn9vDQ48EU0anLFa6utbjHDKmSS8PxAPLMMvIyDseKnxszTF5pmshYMy
         gQuFTdfCdDtL03G7EMe3dzyDbmjEwYhPcTO9X1D+X5uI6DavDX7rXuddu8K15aKAJeEa
         6NmjzLL5gI/0OAMvz8Q7qiG/Jr3BCB3Y/Vi0AIvA1YIEhJs09lDMuO1RF+4/U6x/Goxl
         N3yg==
X-Forwarded-Encrypted: i=1; AJvYcCWI2lzW7fp3+0BjRPItsYVjl48G3+EXzM3bcc6yO+t6jf1nDTgphY2UjVVb4ysjCeNgPBpUBM6q/nkjjZWaU43dHbKj0SvnzDTAjNHA
X-Gm-Message-State: AOJu0YyZvcYzK7RzVSI2YTOGw6oM7r3WMOeWH06VrO8RYNypfv+5I9nf
	j558AY9I2+eq8CWwdxNzs2QGNSm1P/1mTryCIba4TrgQ2m7eM0H61eqGOzSNAk4=
X-Google-Smtp-Source: AGHT+IFodC/KHmQCg2O0jJBVOPuXhUN5lF51VkVlsO14ggFbC93W0YN4q838joM1PZnjh/NG3CSEVg==
X-Received: by 2002:a17:902:e84d:b0:1f9:f906:9082 with SMTP id d9443c01a7336-1fa04a42126mr12275615ad.7.1719007845678;
        Fri, 21 Jun 2024 15:10:45 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:e8dd:a296:71d5:2490])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb5e030dsm18868865ad.218.2024.06.21.15.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 15:10:45 -0700 (PDT)
Date: Fri, 21 Jun 2024 15:10:42 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Ard Biesheuvel <ardb@kernel.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH] riscv: enable HAVE_ARCH_STACKLEAK
Message-ID: <ZnX6YtFGfXd0ixwR@ghost>
References: <20240617123029.723-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240617123029.723-1-jszhang@kernel.org>

On Mon, Jun 17, 2024 at 08:30:29PM +0800, Jisheng Zhang wrote:
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
>  arch/riscv/Kconfig                    | 1 +
>  arch/riscv/kernel/entry.S             | 4 ++++
>  drivers/firmware/efi/libstub/Makefile | 3 ++-
>  3 files changed, 7 insertions(+), 1 deletion(-)
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

When this is selected, stackleak.h include
arch/riscv/include/asm/thread_info.h without sizes.h and I hit:

./arch/riscv/include/asm/thread_info.h:30:33: error: ‘SZ_4K’ undeclared here (not in a function)
   30 | #define OVERFLOW_STACK_SIZE     SZ_4K
      |                                 ^~~~~

Adding "#include <linux/sizes.h>" to thread_info.h resolves the issue.
I am testing this based on 6.10-rc4. Did you encounter this?

- Charlie

>  	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
>  	select HAVE_ARCH_TRACEHOOK
>  	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if 64BIT && MMU
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
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

