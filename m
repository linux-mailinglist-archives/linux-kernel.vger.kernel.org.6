Return-Path: <linux-kernel+bounces-540167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D17D5A4AEB8
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 03:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53ED1169920
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 02:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D9535973;
	Sun,  2 Mar 2025 02:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RC+Gcd6k"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C631DA21;
	Sun,  2 Mar 2025 02:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740881949; cv=none; b=BBX85K84x8YX7dx7+4q41O5DUHPQ6W9/uaFDRNBcRM3rPUlSV1/H2nqEn27Jy6KvzNxsW2w/tB9XGK895w7M5qmvpgReJSQKqz2d/6Zg5C9vWlLEmSBhFYQRNzHlCN2TV2zOWdIv6e1t6CO8+W6WlYsheIZX7VzXtrzKzB0VsCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740881949; c=relaxed/simple;
	bh=Q3jk66jHAAXQHX/Py7DUzr/pfHIcKPy2OogvHy2RdHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bS/zxNPAyJ060UW7zM/McTOTjZQPmJ2OVEBbo0qsiTIhW6GZdYVjVUpaHLZv1tOKWH+UuTPr6kGMWN3cSUIa+WdDjPVaAd7IpG9Msf2ADv4RDbMwuH8okbZ5i3OyzRAUAJx8o9MY75IJpvcm5cyVj3XCDqNJAPJtDpk3FQFOHQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RC+Gcd6k; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e89a2501a0so25674806d6.1;
        Sat, 01 Mar 2025 18:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740881946; x=1741486746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oPjKRzzKrglUg+fYVwz0cgQwVYZBInp7nhcExhwtF6w=;
        b=RC+Gcd6keQSrtNLgcPfe8WBNYHr1XX09KmkXGYP9yOtroy9JIk3ubFEIyWeybUGE5V
         mw/itx8F6imxYlsxgDXwngY86yTjLJq69oYyEYsHXfdAYNNcR1t59yTrK+63GnZaWg4C
         KejcHzYwP0EVC/wWFL0VVxD82s1+mrs7e3uvRrHbZWedkdIpTv82pRwndMmjvt34MRU8
         onJWBF4sp27EHRF3E1aCKAr/SQhdDiIzk/TVxMuZxBw0+K0jbvrtssKB6xljGcLyxTWD
         LQK1FuFsGjc3m34rLNJTIXtuHcA+Q6XVRCyUXZWjuEP9Q9ndjkupZhK6e7Bz3X8zx9Cz
         /VAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740881946; x=1741486746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPjKRzzKrglUg+fYVwz0cgQwVYZBInp7nhcExhwtF6w=;
        b=fIsgUa7rZLrVtb4QvXR/u5WywJw1XuaomndNi0zE29Lz0/s3nri09Y2Fsvo57Jihht
         uEEfx/9xV4xW8UsujSWUU9huNnrdYSwvxmFDjcIwOUtiq9xvGuzYlj2dFtFXpGPvVRg4
         6p/hGo+uonGdRV5Q/FzgbiCzG9Na8ixPu8PfdZTbepgYEKM6cq/Oab/2ifbbC59SaG2c
         aJG+5vWEFNMpGQjUHrV3a+rF8LpbScOOK61QFJCRv9QiTv6Uaih/dDsNkDh+5QLXj0It
         XSNSz/FOEseiUW4yUMzNKvgPB98jc4gYb7ESG7gMUBPBgBkPj0BaCKqTarZz6aoXkuV4
         zBAQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1OkQPZ2JI/n6pn+cf0rx6E70kDZ9JZNA/bYOAeJbY8qpl8iXoXFCNOTleGaj0DtsnpaZToaUajDnrs+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVm2Rfpx/ocenGesnDkaygvBF8b1J9ItIYdXG63YTZNtuc10cG
	mHIGsb/b7vJabJhXP0PP05kAlJSVVlWWBSGe2wcOx3nTcxvqRz6I
X-Gm-Gg: ASbGnctv8HtI+vbR9LmyFfC06o1am2e27lssEgEgdPcFoHCYAbrHqs0/M5mDN7RR76C
	T6jVtZIGJtmwAFsRGxPQoVc0lGFOPtjBuVcayrDOV8YKeZ3UybljPGimTCrviqNYjVTv4C+ckhg
	rFbTjHMG/CCaZdsgVNfyPLB2qFSkSYVHXU7GR0C3kvnS9EIeGREl+2XTEXW9Z/jJ5I43JBw0JAK
	a5xZB0xJNnnw0uJ83gbBYXNuGjtNDlHYbgx4xvDglT0Fz2Y9IpLAU/jx8Vx+EBZZARhaTmoetH/
	Uk6evFZAdth2M3+vcrRm
X-Google-Smtp-Source: AGHT+IGrdEuBUkRKtS239DYTHqorXLkacSTFcSVvkbaNWolaWYlbaQEuA1xg/Dhtk3D1fi/XT3FAXQ==
X-Received: by 2002:a05:6214:1bc9:b0:6e6:5d61:4f00 with SMTP id 6a1803df08f44-6e8a0c7da89mr139365716d6.4.1740881946305;
        Sat, 01 Mar 2025 18:19:06 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c3b67458e0sm5920285a.57.2025.03.01.18.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 18:19:05 -0800 (PST)
Date: Sun, 2 Mar 2025 10:18:42 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Zixian Zeng <sycamoremoon376@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@outlook.com>, Alexandre Ghiti <alex@ghiti.fr>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, sophgo@lists.linux.dev, chao.wei@sophgo.com, 
	xiaoguang.xing@sophgo.com
Subject: Re: [PATCH v2] riscv: sophgo: dts: Add spi controller for SG2042
Message-ID: <fllmh65x7ke4sfolxbdod73fx3fm45w7gy7x4pgamxnbhztjvk@wqd56dzxaa37>
References: <20250228-sfg-spi-v2-1-8bbf23b85d0e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228-sfg-spi-v2-1-8bbf23b85d0e@gmail.com>

On Fri, Feb 28, 2025 at 08:40:23PM +0800, Zixian Zeng wrote:
> Add spi controllers for SG2042.
> 
> SG2042 uses the upstreamed Synopsys DW SPI IP.
> 
> Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
> ---
> For this spi controller patch, only bindings are included.
> This is tested on milkv-pioneer board. Using driver/spi/spidev.c
> for creating /dev/spidevX.Y and tools/spi/spidev_test for testing
> functionality.

I wonder whether this patch is tested (or at least can be
tested), as I am not sure there are pins for spi or any
onboard device on existing SG2042 board.

> ---
> Changes in v2:
> - rebase v1 to sophgo/master(github.com/sophgo/linux.git).
> - order properties in device node.
> - remove unevaluated properties `clock-frequency`.
> - set default status to disable.
> - Link to v1: https://lore.kernel.org/r/20250228-sfg-spi-v1-1-b989aed94911@gmail.com
> ---
>  .../riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts |  8 +++++++
>  arch/riscv/boot/dts/sophgo/sg2042.dtsi             | 28 ++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> index be596d01ff8d33bcdbe431d9731a55ee190ad5b3..c43a807af2f827b5267afe5e4fdf6e9e857dfa20 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> +++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> @@ -72,6 +72,14 @@ &uart0 {
>  	status = "okay";
>  };
>  
> +&spi0 {
> +	status = "okay";
> +};
> +
> +&spi1 {
> +	status = "okay";
> +};
> +
>  / {
>  	thermal-zones {
>  		soc-thermal {
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> index e62ac51ac55abd922b5ef796ba8c2196383850c4..500645147b1f8ed0a08ad3cafb38ea79cf57d737 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> @@ -545,5 +545,33 @@ sd: mmc@704002b000 {
>  				      "timer";
>  			status = "disabled";
>  		};
> +
> +		spi0: spi@7040004000 {
> +			compatible = "snps,dw-apb-ssi";
> +			reg = <0x70 0x40004000 0x00 0x1000>;

> +			clocks = <&clkgen GATE_CLK_APB_SPI>,
> +					<&clkgen GATE_CLK_SYSDMA_AXI>;

Is the sysdma axi clock for the this device. IIRC is APB interface.

Also, Are these clock aligned? If not, use space to align the two
clocks. You also need to add the clock-names here.

> +			interrupt-parent = <&intc>;
> +			interrupts = <110 IRQ_TYPE_LEVEL_HIGH>;

> +			#address-cells = <0x01>;
> +			#size-cells = <0x00>;
> +			num-cs = <0x02>;

Just use decimal number, no hex there.

> +			resets = <&rstgen RST_SPI0>;
> +			status = "disabled";
> +		};
> +
> +		spi1: spi@7040005000 {
> +			compatible = "snps,dw-apb-ssi";
> +			reg = <0x70 0x40005000 0x00 0x1000>;

> +			clocks = <&clkgen GATE_CLK_APB_SPI>,
> +					<&clkgen GATE_CLK_SYSDMA_AXI>;

The same as above.

> +			interrupt-parent = <&intc>;
> +			interrupts = <111 IRQ_TYPE_LEVEL_HIGH>;

> +			#address-cells = <0x01>;
> +			#size-cells = <0x00>;
> +			num-cs = <0x02>;

The same as above.

> +			resets = <&rstgen RST_SPI1>;
> +			status = "disabled";
> +		};
>  	};
>  };
> 
> ---
> base-commit: aa5ee7180ec41bb77c3e327e95d119f2294babea
> change-id: 20250228-sfg-spi-e3f2aeca09ab
> 
> Best regards,
> -- 
> Zixian Zeng <sycamoremoon376@gmail.com>
> 

