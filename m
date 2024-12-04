Return-Path: <linux-kernel+bounces-431487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 022159E3F11
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FD00B28C07
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2784D20C001;
	Wed,  4 Dec 2024 15:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="HB1iovpU"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3B7205E1C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 15:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733325583; cv=none; b=fCgYAiSD0tcH9tM0fMTQvNsA0nMeSV2nbwwbjMaXOnq9zAzAP5Pqdp1bqKMy7HdDXF0qcFIAnXF2wW6LLb1eSLlINpRD7ho5l/jM29UKB3N8MBj6vEpXGCaMjnOgijTfia1z77FNjpbQUos/F3mRaT2ejRcUndRjxhaA8EC/O/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733325583; c=relaxed/simple;
	bh=rKDCPf8A9rIpjJrOC+5ylAOaezhr016mpWauI4DkMDU=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tv1/50aZT4j9N0H8kKvIlV7/nupwc4+S3hVcJ1PrIvAx09D9c/9+UiWToqI02ZNFblF1mxtN6Bs7StlZPOk0B1SPtClHq+gn37Sry3KvAhfTpFqUhURaLLX80AaRC7r3D2xYnZdCHv4UQxvZMGXnupkgEuJNF4znB/91YkjWkDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=HB1iovpU; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0E7B540C49
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 15:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733325571;
	bh=mT6saqI3kUrpS1by1WPPwkqD7keXMeGTbVJLvZHkNkU=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=HB1iovpUhdyYSP+mSpkG6x/61vpv+abUxfnQwq5GQpPa/GrcAKHa/26g7Uzk0YK4z
	 9RofIy83jhFsXI7tQr2C5T0FFfxEwpHTLrvQ5AmTET3f8EpmgwkMfi4iPBY7clmOBl
	 map6YFqCjuhH0C+ZGNsfqEGD/2yVJ3LWIt6e1sjZZ1+FS9ooDYpUKAmX+dDAHk3sqb
	 sL2kkGFMtSKrOIiQYdCgTOwqd3bNiK9gKnIKwVx+In+3f7RjZWjZZoceAFjXV/1UDP
	 tjU36YRbtnsharZpAQFUjBzLMmgTH6q/AyMy5jC/xND0dzXr/umjnvJQ4p/ewxmlKc
	 dB8jvMDB/+lXA==
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5f1d5f7afd4so794899eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 07:19:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733325569; x=1733930369;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mT6saqI3kUrpS1by1WPPwkqD7keXMeGTbVJLvZHkNkU=;
        b=lFy2abao59AZoYuAiB4A1gjcZ5wyY6qu/e+rwuZR5zKFiwA7uQ7e+MgudZ+3hr/w9S
         nTqmZAvZtscp6RnmnYcR6FDUy3bbs9UtxweI3Rn8Vzp99bQ+VOaZgKhe5lcV/Qk/902v
         JQlvfAnqyNEuwvbncx5eGUZpHu12YNozXZW7ooEOrbi6rqe+Zb5fu74jo7b09+DpJ32v
         LJwloA32M3Z6bwMpVYJB2Oqs3P14BZEJ99gsqSv9NVu9Qfq2l9NDFTMulGei0TqDlqMZ
         vMuq8a/045DMt1kh/u44tfSKgANurP0l/qvRrWJnyCa8bO9xEiVcy1R1gHUFnwr1cjvM
         fd3g==
X-Forwarded-Encrypted: i=1; AJvYcCVp3B3sgXxco0Ul2fhFmtVOvhrSfni1iAdXP1zn8C9rJR/wb652Azc9KMiBVIyHIUPvW1L0E0cbVGRBGkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBRb04vzrYnn6EIth0x44ftOtE8NPflE1GtIh0RuOHuPmNFkj1
	DuzVq52aIurHQfnOZ9p1idyTXkEMqvFCqRgbq/Cvh0Sr42HVxdQf0pc7HWvafgxC84e1Hifx7cm
	dOEiSbgAsRCQ/8fTKT54mw77psN+jm2O6e8FVD9YqgmY0BQAv72/6ewKHL8cOuI//M+oJiQRnu/
	lorMSbbkJMXmZUzLi3VUOPsQQYM/Wwch8dgaXf+JHesVs9Risq4Ges
X-Gm-Gg: ASbGnctVdkX8eLD9VNSlsk0YDsVsaAvQz9Svtn7N/nZx5yU2HNnp0W9LoNtGVBhMwbX
	ccQXzXUj92tErBHbpxxYN5zJ0DRjEaARf2AdZOnsUik7ynC0VBJZrvji9KgtD
X-Received: by 2002:a05:6820:1e10:b0:5f1:dc89:fa85 with SMTP id 006d021491bc7-5f25b131ff8mr4435711eaf.3.1733325569633;
        Wed, 04 Dec 2024 07:19:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYwLk9Qr3DA7xA9lz+xOHZPQK14U34Jh9h4Le9KlnSbh+Bl4LotmHax0+v3W1xjiGt64wfnRfDdpr4eIKywwE=
X-Received: by 2002:a05:6820:1e10:b0:5f1:dc89:fa85 with SMTP id
 006d021491bc7-5f25b131ff8mr4435690eaf.3.1733325569341; Wed, 04 Dec 2024
 07:19:29 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Dec 2024 15:19:28 +0000
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20241204111424.263055-1-bigunclemax@gmail.com>
References: <20241204111424.263055-1-bigunclemax@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Wed, 4 Dec 2024 15:19:28 +0000
Message-ID: <CAJM55Z-YAMtRN=K5KxCH1+++Xw4uMM_c49z8tGzi3snU+-KrYA@mail.gmail.com>
Subject: Re: [PATCH v1] riscv: dts: thead: Fix TH1520 emmc and shdci clock rate
To: bigunclemax@gmail.com
Cc: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

bigunclemax@ wrote:
> From: Maksim Kiselev <bigunclemax@gmail.com>
>
> In accordance with LicheePi 4A BSP the clock that comes to emmc/sdhci
> is 198Mhz.
>
> But changing from fixed-clock to CLK_EMMC_SDIO leads to increasing input
> clock from 198Mhz to 792Mhz. Because the CLK_EMMC_SDIO is actually 792Mhz.
>
> Therefore calculation of output SDCLK is incorrect now.
> The mmc driver sets the divisor to 4 times larger than it should be
> and emmc/sd works 4 times slower.
>
> This can be confirmed with fio test:
> Sequential read of emmc with fixed 198Mz clock:
> READ: bw=289MiB/s (303MB/s)
>
> Sequential read with CLK_EMMC_SDIO clock:
> READ: bw=82.6MiB/s (86.6MB/s)
>
> Let's fix this issue by providing fixed-factor-clock that divides
> CLK_EMMC_SDIO by 4 for emmc/sd nodes.

Thanks for finding this bug!

However, this feels like a work-around for a bug in the clock driver, and even
if there is a fixed factor divider somewhere this should probably be modelled
by the clock driver. Did you look into the documentation[1] and try to figure
out where eMMC clock comes from and where the /4 is missing?

There is also a vendor tree somewhere with a much more complete clock driver.
Drew do you remember where it is? Maybe it's worth looking at how that driver
models the eMMC clocks.

[1]: https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf

/Emil

>
> Fixes: 03a20182e1e0 ("riscv: dts: thead: change TH1520 mmc nodes to use clock controller")
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> ---
>  arch/riscv/boot/dts/thead/th1520.dtsi | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> index acfe030e803a..6c20965cd10c 100644
> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> @@ -229,6 +229,14 @@ stmmac_axi_config: stmmac-axi-config {
>  		snps,blen = <0 0 64 32 0 0 0>;
>  	};
>
> +	sdhci_clk: sdhci-clock {
> +		compatible = "fixed-factor-clock";
> +		clocks = <&clk CLK_EMMC_SDIO>;
> +		#clock-cells = <0>;
> +		clock-div = <4>;
> +		clock-mult = <1>;
> +	};
> +
>  	soc {
>  		compatible = "simple-bus";
>  		interrupt-parent = <&plic>;
> @@ -328,7 +336,7 @@ emmc: mmc@ffe7080000 {
>  			compatible = "thead,th1520-dwcmshc";
>  			reg = <0xff 0xe7080000 0x0 0x10000>;
>  			interrupts = <62 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&clk CLK_EMMC_SDIO>;
> +			clocks = <&sdhci_clk>;
>  			clock-names = "core";
>  			status = "disabled";
>  		};
> @@ -337,7 +345,7 @@ sdio0: mmc@ffe7090000 {
>  			compatible = "thead,th1520-dwcmshc";
>  			reg = <0xff 0xe7090000 0x0 0x10000>;
>  			interrupts = <64 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&clk CLK_EMMC_SDIO>;
> +			clocks = <&sdhci_clk>;
>  			clock-names = "core";
>  			status = "disabled";
>  		};
> @@ -346,7 +354,7 @@ sdio1: mmc@ffe70a0000 {
>  			compatible = "thead,th1520-dwcmshc";
>  			reg = <0xff 0xe70a0000 0x0 0x10000>;
>  			interrupts = <71 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&clk CLK_EMMC_SDIO>;
> +			clocks = <&sdhci_clk>;
>  			clock-names = "core";
>  			status = "disabled";
>  		};
> --
> 2.45.2
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

