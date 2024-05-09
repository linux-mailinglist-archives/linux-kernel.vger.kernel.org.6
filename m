Return-Path: <linux-kernel+bounces-174242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D14288C0C0D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 09:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C9AF284ECF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 07:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9511494D9;
	Thu,  9 May 2024 07:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OX6tjU7k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739142747D
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 07:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715240416; cv=none; b=Jde+WXezxs6GIyzdGibIwkanNd4QnhrTT2dnUUc7a0Q7ERQ3WMy2fm6VD1iNjDvISTBaeHXSloexEGCvmYshsPnwEPv72NEDQMAi3WDI4ArNFPrQMTRaJCvlWI9yHPFkHbmasbqL4X8K/Bm7sLx7WeCab4q92SuNRj7JOM2CJSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715240416; c=relaxed/simple;
	bh=yzJlvEP6EPeyVWNOBhOkHxYozpxhkCLY09/TTdV6+cE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bT3ufyw0xLpLnTJurMheqLKIGp/m06kunmArSlkJcJcn6WsAyLrD1ccufidT7iJtcqVVV/ULe9HwhdeZMUsOWEsF9cAjeloVAhQ07qXg1dqB6Sefb/FOkpD9hOKUldv2C430aKIN2cOKppcEr0Stll7JpXSg1tob4r7iJXXSxF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OX6tjU7k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1463FC4AF07
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 07:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715240416;
	bh=yzJlvEP6EPeyVWNOBhOkHxYozpxhkCLY09/TTdV6+cE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OX6tjU7kbRupzn/1DgRF/4+EPO+bSy4pUQcX7huZZ80pyX6t1GkyXdFPoLPfwl0Zx
	 M2cucwR82XKrRWW2tJqJnOVuzfeUNOkjW8J6HWd/C3s/6YQU9zRRoTVwK/iVm4THNQ
	 xhbHOrtso8iBHcyjzzv7A3fufJOpbzKLcgl8PrCHEuA247vaeUwn6zv9pQ4/wLRGZP
	 Gxr1cV0r2kWfh7tT97szxdgTKA3jF6ZlaK7HlRa/Y2a8m9eLPftt7UEjimBqwEUM0r
	 Jei3jb6lgD7O96qfZ4DGmZL2IKhQ3Tatk3wRdkewa9T2UgG3LUo3v7LlaGrfnF4e0w
	 Ec+XcCJsAE3xw==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51f45104ef0so537111e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 00:40:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUipyzmkisvqM+yaWELB3TRsS9xLm7OmUFWI4gnA12EHHUznr8Hj4CcwBKkRe/TFQx6gw4RxzcEnhns1+8/HodDbnV3k0yDdPtjgS6V
X-Gm-Message-State: AOJu0YzzTKJL2H8+oZpruoQ6/iHWbgMNQPMrDxN0pvU7597E+hiAB4xE
	shOOwD2+O5JyxlfsJIH7Sm+hOsxeiAk08hhIQTJmH9c9kuIAF5WwNP8f5av3zhwPzETdbqYpgxC
	5VlaS/pRzxwuR+OwVXt/PD2f2b1M=
X-Google-Smtp-Source: AGHT+IHoxCV6i7T4XTVJNNw0o8lBtSlgZpO4LspzYKigkwmqilUfZq0Hiwz+mywlWqe1siJO2orEYe/2lOUQneQ69lw=
X-Received: by 2002:ac2:592d:0:b0:516:d692:5e0b with SMTP id
 2adb3069b0e04-5217cc45778mr2873222e87.54.1715240414406; Thu, 09 May 2024
 00:40:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509013727.648600-1-samuel.holland@sifive.com>
In-Reply-To: <20240509013727.648600-1-samuel.holland@sifive.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 9 May 2024 09:39:59 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFfWKh-oM8q11eEF94mPOENHxW+fdvkYLSbUDs0ZG8Sow@mail.gmail.com>
Message-ID: <CAMj1kXFfWKh-oM8q11eEF94mPOENHxW+fdvkYLSbUDs0ZG8Sow@mail.gmail.com>
Subject: Re: [PATCH] ARM: Do not select ARCH_HAS_KERNEL_FPU_SUPPORT
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, 
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>, kernel test robot <lkp@intel.com>, Andrew Davis <afd@ti.com>, 
	Arnd Bergmann <arnd@arndb.de>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Eric DeVolder <eric.devolder@oracle.com>, Rob Herring <robh@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 May 2024 at 03:37, Samuel Holland <samuel.holland@sifive.com> wrote:
>
> On 32-bit ARM, conversions between `double` and `long long` require
> runtime library support. Since the kernel does not currently provide
> this library support, the amdgpu driver fails to build:
>
>   ERROR: modpost: "__aeabi_l2d" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
>   ERROR: modpost: "__aeabi_d2ulz" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
>
> As Arnd reports, there are likely no 32-bit ARM platforms which can use
> the amdgpu driver anyway, due to lack of features like 64-bit
> prefetchable BARs. Since amdgpu is currently the only real user of
> ARCH_HAS_KERNEL_FPU_SUPPORT, drop support for this option instead of
> bothering to implement the library functions.
>
> Fixes: 12624fe2d707 ("ARM: implement ARCH_HAS_KERNEL_FPU_SUPPORT")

This commit is not in mainline yet. Could we just drop the original
patch instead?

> Reported-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
> Closes: https://lore.kernel.org/lkml/87wmp4oo3y.fsf@linaro.org/
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202404042327.jRpt81kP-lkp@intel.com/
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
>  arch/arm/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index b1751c2cab87..b14aed3a17ab 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -15,7 +15,6 @@ config ARM
>         select ARCH_HAS_FORTIFY_SOURCE
>         select ARCH_HAS_KEEPINITRD
>         select ARCH_HAS_KCOV
> -       select ARCH_HAS_KERNEL_FPU_SUPPORT if KERNEL_MODE_NEON
>         select ARCH_HAS_MEMBARRIER_SYNC_CORE
>         select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>         select ARCH_HAS_PTE_SPECIAL if ARM_LPAE
> --
> 2.44.0
>

