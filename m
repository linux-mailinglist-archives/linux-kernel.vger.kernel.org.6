Return-Path: <linux-kernel+bounces-258242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A99493856F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 18:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B89B6B20C60
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 16:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19EE1684A2;
	Sun, 21 Jul 2024 16:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="V6UYB0c2"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A261662EA
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721577725; cv=none; b=qiZYPgE4pOIqFkdTSZSz8dFKnePHVxqZoSUfHLg4RkTF+5voakXLqbeJpKFpvk0cA4hVJ9GH7wfhyY9svNq7QXQGYLuu3iKwFD6YwCNtAUVHIcx8XpIA+jVbkcjM+A6ZYgybrEpBOlci07XB9oKYkmnFMJzaD8brr9ztkW5uy2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721577725; c=relaxed/simple;
	bh=PxfBtdbN6Fosubkm7qmUFS0wpuMFqZgr3xgG1/3gMik=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OmJr0wfN9uFZ27mvwUgyzl37EJRvfbndk6zm2KiNHFPN9OCBIrxGc67RdBDG9d4YA/If1b43y98ks7veATQzc0eH/78OW1oljDnAwLH0sGhIxQsxyaiUntqe1RGtzyNNd+oS27Aj+toqhL+jm5v3Ja6qDpRVrNadGcq6Mn2YLsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=V6UYB0c2; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AF89A3F429
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 16:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1721577720;
	bh=tzD4G7bqh5TVJf3QFh6TBIh6jpL+x3lpERZwIORhlZY=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=V6UYB0c2MURRbwy/3VEbMxUFFxT4NeDfm4GvMFijpUOczPgPWzJ2OB3/BHpMyFpTx
	 Qu8i958kJ13SDt73d05+U4Ua8yRVl4g+g3Zyw3RoJRrz6LZYjxkyywMOrkxOWtB59r
	 3MtbZwqrTXLEiPpNi/IjkRxrWhyGx6MvjRv352T8EFoPZFhOjCpiPdssg6g5UxLMxi
	 zc8+FglNzm+inZt0btPEW5xFUHdUvRjqlf5RmD5S/N0Xp3+AYa/6XS6S42Z/gMCb8F
	 VAvzCEdCRnAcrhqCaoQlQKndGECNNjb4tKOrvr6daPSfSYh7wB+6ZgS7heetm4OCc4
	 xN4rGNJGKgfzQ==
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-44b181a4edaso58806101cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 09:02:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721577719; x=1722182519;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tzD4G7bqh5TVJf3QFh6TBIh6jpL+x3lpERZwIORhlZY=;
        b=Jk1rOL5veUnf3m+tKhAdjidmL/usf4BynrOMjEhZveL22Q3onx9zb5qdlk1iV1t7QJ
         Y+MU3IxGB98ptagSHSqGc49Y9ITa0+A+BByz7Yc+S1H20RliPgJDnME5abziA6x9g7K8
         X6h4iV6BnABUKZ4AEcUPAnN1XTnvXe5VDHmH4LL+F1myDAnWKfWo1MKKs85E2eNheINc
         YAAjXk+S9HX42EX618gYqtic638sjrIw3SOc/9Cp32ojiLdt/c7uUfzM3Qwr8vYWWgnV
         1t2BZ+ryoXPmg3u1r6ysE3f1QPbbl1BYaj42aHVYDdM+eXu4LavXe686Su+WRnof2sSk
         Ij0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW0StJhiT0uDU9ap5jv09dyXFOqghau/33rt8hsy8xsHMWUzFwAJTNjz3NO+sip0MpdlFw+e7kGCLJdPNtpF9h6pTdJ/eynFOVEfcQj
X-Gm-Message-State: AOJu0YzzQvvsZWEExAk6nR6sXz45R7GYqVlfqCwNoclfYd1/oaD4AEpl
	elAZLip1hySYe9xo4oAu8MbUlcJ3qF1YLnqkGlQ8rf8Xf/qP2D0X+BWezbsRMDFrXlwvBuu2HQp
	mROxfO6QuPxXOdJefLfidFGxAYVM8Nyc6f8j5jcyxqrIedXdtbtVkIIwNWEsg09XoGbWHyla2vh
	XocAw/ljiYuROPhBSbwC/xNIkeSbhYa7YECYCGn4eMfyHurkxcR74d
X-Received: by 2002:a05:622a:148a:b0:447:f6ca:b23 with SMTP id d75a77b69052e-44fa584e00dmr86189641cf.26.1721577719423;
        Sun, 21 Jul 2024 09:01:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy3RBTEJERaYfS8uwMmlBGb8o8tj1sTDPaOS2yPcFwqUTcWzgoKnw5EolNVsLDZ3WjZyZf27YhuUE6vQK7AAI=
X-Received: by 2002:a05:622a:148a:b0:447:f6ca:b23 with SMTP id
 d75a77b69052e-44fa584e00dmr86189071cf.26.1721577718950; Sun, 21 Jul 2024
 09:01:58 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 21 Jul 2024 11:01:58 -0500
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240721133633.47721-17-lasse.collin@tukaani.org>
References: <20240721133633.47721-1-lasse.collin@tukaani.org> <20240721133633.47721-17-lasse.collin@tukaani.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Sun, 21 Jul 2024 11:01:58 -0500
Message-ID: <CAJM55Z_2=aChNSbzEHvvAu66ypZHvUKJSmtaNX63OEA5U-811g@mail.gmail.com>
Subject: Re: [PATCH v2 16/16] riscv: boot: add Image.xz support
To: Lasse Collin <lasse.collin@tukaani.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Sam James <sam@gentoo.org>, linux-kernel@vger.kernel.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Jules Maselbas <jmaselbas@zdiv.net>, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Lasse Collin wrote:
> The Image.* targets existed for other compressors already. Bootloader
> support is needed for decompression.
>
> This is for CONFIG_EFI_ZBOOT=n. With CONFIG_EFI_ZBOOT=y, XZ was already
> available.
>
> Comparision with Linux 6.10 RV64GC tinyconfig (in KiB):
>
>     1027 Image
>      594 Image.gz
>      541 Image.zst
>      510 Image.lzma
>      474 Image.xz
>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Jules Maselbas <jmaselbas@zdiv.net>
> Cc: linux-riscv@lists.infradead.org
> Signed-off-by: Lasse Collin <lasse.collin@tukaani.org>

Looks good to me, thanks.

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> ---
>  arch/riscv/Kconfig       | 1 +
>  arch/riscv/Makefile      | 6 ++++--
>  arch/riscv/boot/Makefile | 3 +++
>  3 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 736457a5898a..ef6a603b80c5 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -153,6 +153,7 @@ config RISCV
>  	select HAVE_KERNEL_LZO if !XIP_KERNEL && !EFI_ZBOOT
>  	select HAVE_KERNEL_UNCOMPRESSED if !XIP_KERNEL && !EFI_ZBOOT
>  	select HAVE_KERNEL_ZSTD if !XIP_KERNEL && !EFI_ZBOOT
> +	select HAVE_KERNEL_XZ if !XIP_KERNEL && !EFI_ZBOOT
>  	select HAVE_KPROBES if !XIP_KERNEL
>  	select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
>  	select HAVE_KRETPROBES if !XIP_KERNEL
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 6fe682139d2e..d469db9f46f4 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -159,6 +159,7 @@ boot-image-$(CONFIG_KERNEL_LZ4)		:= Image.lz4
>  boot-image-$(CONFIG_KERNEL_LZMA)	:= Image.lzma
>  boot-image-$(CONFIG_KERNEL_LZO)		:= Image.lzo
>  boot-image-$(CONFIG_KERNEL_ZSTD)	:= Image.zst
> +boot-image-$(CONFIG_KERNEL_XZ)		:= Image.xz
>  ifdef CONFIG_RISCV_M_MODE
>  boot-image-$(CONFIG_ARCH_CANAAN)	:= loader.bin
>  endif
> @@ -183,12 +184,12 @@ endif
>  vdso-install-y			+= arch/riscv/kernel/vdso/vdso.so.dbg
>  vdso-install-$(CONFIG_COMPAT)	+= arch/riscv/kernel/compat_vdso/compat_vdso.so.dbg
>
> -BOOT_TARGETS := Image Image.gz Image.bz2 Image.lz4 Image.lzma Image.lzo Image.zst loader loader.bin xipImage vmlinuz.efi
> +BOOT_TARGETS := Image Image.gz Image.bz2 Image.lz4 Image.lzma Image.lzo Image.zst Image.xz loader loader.bin xipImage vmlinuz.efi
>
>  all:	$(notdir $(KBUILD_IMAGE))
>
>  loader.bin: loader
> -Image.gz Image.bz2 Image.lz4 Image.lzma Image.lzo Image.zst loader xipImage vmlinuz.efi: Image
> +Image.gz Image.bz2 Image.lz4 Image.lzma Image.lzo Image.zst Image.xz loader xipImage vmlinuz.efi: Image
>
>  $(BOOT_TARGETS): vmlinux
>  	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
> @@ -225,6 +226,7 @@ define archhelp
>    echo  '  Image.lzma	- Compressed kernel image (arch/riscv/boot/Image.lzma)'
>    echo  '  Image.lzo	- Compressed kernel image (arch/riscv/boot/Image.lzo)'
>    echo  '  Image.zst	- Compressed kernel image (arch/riscv/boot/Image.zst)'
> +  echo  '  Image.xz	- Compressed kernel image (arch/riscv/boot/Image.xz)'
>    echo  '  vmlinuz.efi	- Compressed EFI kernel image (arch/riscv/boot/vmlinuz.efi)'
>    echo  '		  Default when CONFIG_EFI_ZBOOT=y'
>    echo  '  xipImage	- Execute-in-place kernel image (arch/riscv/boot/xipImage)'
> diff --git a/arch/riscv/boot/Makefile b/arch/riscv/boot/Makefile
> index 869c0345b908..710a5f6caf96 100644
> --- a/arch/riscv/boot/Makefile
> +++ b/arch/riscv/boot/Makefile
> @@ -65,6 +65,9 @@ $(obj)/Image.lzo: $(obj)/Image FORCE
>  $(obj)/Image.zst: $(obj)/Image FORCE
>  	$(call if_changed,zstd)
>
> +$(obj)/Image.xz: $(obj)/Image FORCE
> +	$(call if_changed,xzkern)
> +
>  $(obj)/loader.bin: $(obj)/loader FORCE
>  	$(call if_changed,objcopy)
>
> --
> 2.45.2
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

