Return-Path: <linux-kernel+bounces-395133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B539BB8F1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 518FB1F21ED4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A851BDA95;
	Mon,  4 Nov 2024 15:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="kVzrRKxl"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0498B3B791
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 15:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733978; cv=none; b=H4iCtG/zjL9fGIe/5DDPmY+9MjLWf2rewHQ0UFOaPF1nZ58tRsMSFfXymCDabZxnOGBNqf2pRwzbzOYK/EfZnLaC0drVq89coGdqabybgIFqGILGtbvi9ogf2tKAQ1tbIzp+5cxTlYiLlvrfUrN1simsslx2HJ+fLSFTftq2h7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733978; c=relaxed/simple;
	bh=CtoZUHAkaZDFFBjdZ9IJcA40bV8tZE+w4HbODT1BmmY=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E5ReF1B3vH9w+meQkmMTEtN+WkhRAfm879GHMhbfHrJPAnWR1zzX967cB/5X21GpD33w4FLbRJnh8YWBbYO1ee54oSRWExt/X7NBtCTXquWmluRXM8i0J702kU40bNfI8/l4mSZWv7PLQa73HIhIZ0pehkBYJd6VKL7TYjQgAWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=kVzrRKxl; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F024D3F2A9
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 15:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1730733967;
	bh=nLr3ejFwtoxSfGD1Ta6KgkGyD7K+B1kTs0x5zuGkEZk=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=kVzrRKxlsAvcQ3jCLNGGtXvEV5QYknKX2pgQ2w2m4AZV5GQso5vCArh3wQzjsquac
	 ZAYJGg2JJjLAc6gVntmxz7MXeGyeIn3phYGCud1GeEdHUPaayHPC8byy5QITjXu8JZ
	 YysEpPIAPQArKSTZz/CKTmLUw7rQyVf4JtlyxqhuvOZF1uwONYla3d2beEqAau9qGC
	 3Y5r/ORdwVxziQKCcDVTGDrGAo6BcnryvBS6KYh6wAG8evWjuvGi6hcDcPNrqH8BGX
	 jbOZ3Y+hOj3Pu0XYFnSLUTIKFeTfUFiQ2V6a7OZ2TGFhgLAplN3mljlbYYeiaIZlB0
	 5qq4aMga/BmdQ==
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-2892ea5bf68so3418464fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 07:26:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730733967; x=1731338767;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nLr3ejFwtoxSfGD1Ta6KgkGyD7K+B1kTs0x5zuGkEZk=;
        b=XbDlx0nmqCyXeaFlFsQGrglHGaBt3FcLC6j0vXE7Qp0ks6LReYqxZqsF/4jNJb9TD6
         kQvvMrVWBQbA7SqAQUeqdOFfKtCqtSsZbn0bjOq5c8Zbo8sV8Drr0yhPWW8QyQzoV9g/
         7a/OiWGp7OrIFJNdtsfuLnihpFpPCLx+qoBrI8e9IWc7PQSf5SaxPCoOMrlgU+2x8NPR
         jhAEdiasOes/d+1EdnBQyw82mSxPMx4XtyrmZl4laYviL1ISbMgyp3v3yIuQlqxNXUAS
         y6BbAII7Jk/GowQbwp/LWltYDlPLpArZNKj0/y43larMbuS+KiWlOPdE/8w1sLWIfPNf
         cfPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzO8tYZCd9SrCUsICn69UfPMqhCpra1P5reijKsqXE283dnxDKIOSRYk4hK6BLtxydK0v4w7Rt6cd/Yx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlkTl6gNW4dMESWpXtutTvY5NfoG2NanGKb7FyBYce1w2GQ/EO
	U2zgEb7k4odqCqmuYCCOm2Md6ez5MsZsP5FD/ziwaFJYLKovXasOIOVQQMK84yHF+iXGc3gTe5A
	hHibH8VgD1+5H+6Rp8OciHx3JcUR5sjc5IEzT3/zc3uXuO2VfYGUEAWtzk5y14Pm6eQCn0S0yLG
	huQGtUADXcoP8irxB2Jjg7MQ6rcniwFnT3AFn5siG0Rv+NtQCFHflN
X-Received: by 2002:a05:6870:288b:b0:288:9adc:3670 with SMTP id 586e51a60fabf-2949f014f50mr9303472fac.29.1730733966806;
        Mon, 04 Nov 2024 07:26:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFI6nEYtynrseYyifqqJ8kASO1RznklWY9IpKRVpE1rUdJvI3XiQYgw4TZWQo4G/Mik6kNigtEeGNqK5f7LQ4I=
X-Received: by 2002:a05:6870:288b:b0:288:9adc:3670 with SMTP id
 586e51a60fabf-2949f014f50mr9303458fac.29.1730733966540; Mon, 04 Nov 2024
 07:26:06 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 4 Nov 2024 07:26:06 -0800
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20241102000843.1301099-12-samuel.holland@sifive.com>
References: <20241102000843.1301099-1-samuel.holland@sifive.com> <20241102000843.1301099-12-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Mon, 4 Nov 2024 07:26:06 -0800
Message-ID: <CAJM55Z-caGvqZXDTtbj0LknAJVgj1s5_p0SaN3kJog1950L0yg@mail.gmail.com>
Subject: Re: [PATCH 11/11] riscv: dts: starfive: jh7100: Use physical memory
 ranges for DMA
To: Samuel Holland <samuel.holland@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Samuel Holland wrote:
> JH7100 provides a physical memory region which is a noncached alias of
> normal cacheable DRAM. Now that Linux can apply PMAs by selecting
> between aliases of a physical memory region, any page of DRAM can be
> marked as noncached for use with DMA, and the preallocated DMA pool is
> no longer needed. This allows portable kernels to boot on JH7100 boards.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
>  arch/riscv/Kconfig.errata                     | 19 ------------
>  .../boot/dts/starfive/jh7100-common.dtsi      | 30 ++++---------------
>  2 files changed, 6 insertions(+), 43 deletions(-)
>
> diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
> index 2806ed7916c7..fc2c7fb2caff 100644
> --- a/arch/riscv/Kconfig.errata
> +++ b/arch/riscv/Kconfig.errata
> @@ -53,25 +53,6 @@ config ERRATA_SIFIVE_CIP_1200
>
>  	  If you don't know what to do here, say "Y".
>
> -config ERRATA_STARFIVE_JH7100
> -	bool "StarFive JH7100 support"
> -	depends on ARCH_STARFIVE
> -	depends on !DMA_DIRECT_REMAP
> -	depends on NONPORTABLE
> -	select DMA_GLOBAL_POOL

Hi Samuel,

Thank you for working on this!

The JH7100 still need the RISCV_NONSTANDARD_CACHE_OPS from the sifive-ccache
driver for streaming DMA, so if I just remove the 3 lines above instead of the
whole ERRATE_STARFIVE_JH7110 (and enable RISCV_ISA_SVPBMT) this series works on
my Starlight board.

> -	select RISCV_DMA_NONCOHERENT
> -	select RISCV_NONSTANDARD_CACHE_OPS
> -	select SIFIVE_CCACHE
> -	default n
> -	help
> -	  The StarFive JH7100 was a test chip for the JH7110 and has
> -	  caches that are non-coherent with respect to peripheral DMAs.
> -	  It was designed before the Zicbom extension so needs non-standard
> -	  cache operations through the SiFive cache controller.
> -
> -	  Say "Y" if you want to support the BeagleV Starlight and/or
> -	  StarFive VisionFive V1 boards.
> -
>  config ERRATA_THEAD
>  	bool "T-HEAD errata"
>  	depends on RISCV_ALTERNATIVE
> diff --git a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
> index ae1a6aeb0aea..34885fe40e2d 100644
> --- a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
> @@ -9,8 +9,14 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/leds/common.h>
>  #include <dt-bindings/pinctrl/pinctrl-starfive-jh7100.h>
> +#include <dt-bindings/riscv/physical-memory.h>
>
>  / {
> +	riscv,physical-memory-regions =
> +		<0x00 0x00000000 0x40 0x00000000 (PMA_RW | PMA_IO) 0x0>,
> +		<0x00 0x80000000 0x08 0x00000000 (PMA_RWXA | PMA_NONCOHERENT_MEMORY) 0x0>,
> +		<0x10 0x00000000 0x08 0x00000000 (PMA_RWX | PMA_NONCACHEABLE_MEMORY | PMR_ALIAS(1)) 0x0>;
> +

The size and placement of the DMA pool was kind of arbitrary but the above is
a feature of the SoC, so should be moved to jh7100.dtsi instead.

>  	aliases {
>  		mmc0 = &sdio0;
>  		mmc1 = &sdio1;
> @@ -42,30 +48,6 @@ led-ack {
>  		};
>  	};
>
> -	reserved-memory {
> -		#address-cells = <2>;
> -		#size-cells = <2>;
> -		ranges;
> -
> -		dma-reserved@fa000000 {
> -			reg = <0x0 0xfa000000 0x0 0x1000000>;
> -			no-map;
> -		};
> -
> -		linux,dma@107a000000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x10 0x7a000000 0x0 0x1000000>;
> -			no-map;
> -			linux,dma-default;
> -		};
> -	};
> -
> -	soc {
> -		dma-ranges = <0x00 0x80000000 0x00 0x80000000 0x00 0x7a000000>,
> -			     <0x00 0xfa000000 0x10 0x7a000000 0x00 0x01000000>,
> -			     <0x00 0xfb000000 0x00 0xfb000000 0x07 0x85000000>;
> -	};
> -
>  	wifi_pwrseq: wifi-pwrseq {
>  		compatible = "mmc-pwrseq-simple";
>  		reset-gpios = <&gpio 37 GPIO_ACTIVE_LOW>;
> --
> 2.45.1
>

