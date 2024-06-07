Return-Path: <linux-kernel+bounces-205460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 455868FFC5F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7C731F28216
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7251527BC;
	Fri,  7 Jun 2024 06:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="BDsWbsM4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="RxZ88pIN"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A074CB36;
	Fri,  7 Jun 2024 06:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742515; cv=none; b=Nn38ACX6rGyG5MmgWYedDd8gW9IaXXAPuZcq3yQLFKwSnxU/G7Jy4o3mFc3H84MSISNqcK025UEC8z7IZwXTiaFTuvIL/PyOKUJOp6jXTeiXcKBS9u3BIknKQQiFojrjZfAtkVv/UV7gjlw1EMZr0XNSiRueemShGFhS4ELe9O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742515; c=relaxed/simple;
	bh=LqwZ1bRhi1S9fntGwGFdpafnrTl4n75QKDz4c8K5wQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nJ6pT/GeESWkEjzEKHfFUJqADbyivSFQ23UcvUSVrdkq2fT+RoBS0A5UEyuDhMDc7/Sfdf9AYkOLP6fu4ELzKVSzMnw+0ypZKhEzpJyH06qf/WGmhkpxZkcvxmMGd37lKsn6HSm/7lYJ3chMIfApGPsJ5d5NeSwAq5TMxCxSTTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=BDsWbsM4; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=RxZ88pIN reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1717742511; x=1749278511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oDWXk9Ip84mUFg4/ADwA1LpVB7/h3jEawVahgnt2/Uc=;
  b=BDsWbsM4Vl+aoU3JjjVxxGFTA9Ck3IPcvXqHS6OhhgXlz1lXZbsTFU+T
   ElhtUdsiZwXo9kYgXtYuGw9dkYh8+k3tt1lZdaBID8gnSNHTMOj6v7omj
   yflWdg5bvZHHFV7Hv7lYJRC7vUUrbsMfcP+YoSnkGR7WFZSrdCqgAxK0J
   5hoeweGkGyTjAUZNtM+S1wevLftPGrLaQ9z45IV362EwWl/GIyfyHq6sd
   rIGqhDNECGGxet4w0MshSGkYNZeX2btktqLG5chNK3JJz6CPtj69J4Qn1
   QOI98z1zor2uv6YLBac/naV65cdeb61/7hEn508EPWebVSHtOQbx41HBQ
   A==;
X-CSE-ConnectionGUID: 5Kjk5ea1S1+33Ri51/5AbQ==
X-CSE-MsgGUID: aZeO6HILRgmYG2mb3kahhQ==
X-IronPort-AV: E=Sophos;i="6.08,220,1712613600"; 
   d="scan'208";a="37274501"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 07 Jun 2024 08:41:49 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4795E170735;
	Fri,  7 Jun 2024 08:41:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1717742505;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=oDWXk9Ip84mUFg4/ADwA1LpVB7/h3jEawVahgnt2/Uc=;
	b=RxZ88pIN1B/ayw7taFUeqJxc5cTZM3sOiQj3SMST85ctsblSS+DjPwe46dFLcbrKMLdVlb
	HieWJHLTUu0M4ceY19Cmr+tFGXMObSWtDA7fBCS/trj5613nQbAffpVQqa50jLzn6IZC+8
	DXAl4rcjnSe9+cxwEF8OWDCon8pxgQu6ugiN1S4qStOwgqxHoSnS9f/M1Y2uQBPlQdpUll
	qQhuMVUMXOctQnlmiemriQ2VmA0L6ekvaHb3wOl1IDW29ialDhv0dWuKmGxsXJlsiFC0oB
	WCT9QfsQKt+9uh9AXAc6rsqcOrhlTxH0zoZ6O0rInT7rnAVn6c8HrWxyYyeD7w==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>, linux-arm-kernel@lists.infradead.org, Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 2/7] arm64: dts: imx8qm: add mipi subsystem
Date: Fri, 07 Jun 2024 08:41:44 +0200
Message-ID: <6638616.G0QQBjFxQf@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240606-imx8qm-dts-usb-v1-2-565721b64f25@nxp.com>
References: <20240606-imx8qm-dts-usb-v1-0-565721b64f25@nxp.com> <20240606-imx8qm-dts-usb-v1-2-565721b64f25@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi,

thanks for the patch.
What are your plans regarding imx8xqp? This memory region
has dual use on imx8qxp mipi/lvds0. I would prefer
imx8-ss-mipi.dtsi with common parts and a imx8qm-ss-mipi.dtsi
adding/modifying imx8qm specific things. I'll send my current WIP
as a response to this.

Best regards,
Alexander

Am Donnerstag, 6. Juni 2024, 20:46:56 CEST schrieb Frank Li:
> Add irqstear, pwm and i2c in mipi subsystem.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8qm-ss-mipi.dtsi | 286 ++++++++++++++++=
++++++
>  arch/arm64/boot/dts/freescale/imx8qm.dtsi         |   1 +
>  2 files changed, 287 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-mipi.dtsi b/arch/arm=
64/boot/dts/freescale/imx8qm-ss-mipi.dtsi
> new file mode 100644
> index 0000000000000..bd18468923e52
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-mipi.dtsi
> @@ -0,0 +1,286 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +/ {
> +	dsi_ipg_clk: clock-dsi-ipg {
> +		compatible =3D "fixed-clock";
> +		#clock-cells =3D <0>;
> +		clock-frequency =3D <120000000>;
> +		clock-output-names =3D "dsi_ipg_clk";
> +	};
> +
> +	mipi_pll_div2_clk: clock-mipi-div2-pll {
> +		compatible =3D "fixed-clock";
> +		#clock-cells =3D <0>;
> +		clock-frequency =3D <432000000>;
> +		clock-output-names =3D "mipi_pll_div2_clk";
> +	};
> +
> +	mipi0_subsys: bus@56220000 {
> +		compatible =3D "simple-bus";
> +		interrupt-parent =3D <&irqsteer_mipi0>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		ranges =3D <0x56220000 0x0 0x56220000 0x10000>;
> +
> +		irqsteer_mipi0: interrupt-controller@56220000 {
> +			compatible =3D "fsl,imx-irqsteer";

compatible =3D "fsl,imx8qxp-irqsteer", "fsl,imx-irqsteer" or even
compatible =3D "fsl,imx8qm-irqsteer", "fsl,imx-irqsteer". Please refer to [=
1].

[1] https://lore.kernel.org/all/20240528071141.92003-1-alexander.stein@ew.t=
q-group.com/

> +			reg =3D <0x56220000 0x1000>;
> +			interrupts =3D <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			interrupt-parent =3D <&gic>;
> +			#interrupt-cells =3D <1>;
> +			clocks =3D <&mipi0_lis_lpcg IMX_LPCG_CLK_0>;
> +			clock-names =3D "ipg";
> +			power-domains =3D <&pd IMX_SC_R_MIPI_0>;
> +			fsl,channel =3D <0>;
> +			fsl,num-irqs =3D <32>;
> +		};
> +
> +		mipi0_lis_lpcg: clock-controller@56223000 {
> +			compatible =3D "fsl,imx8qxp-lpcg";
> +			reg =3D <0x56223000 0x4>;
> +			#clock-cells =3D <1>;
> +			clocks =3D <&dsi_ipg_clk>;
> +			clock-indices =3D <IMX_LPCG_CLK_0>;
> +			clock-output-names =3D "mipi0_lis_lpcg_ipg_clk";
> +			power-domains =3D <&pd IMX_SC_R_MIPI_0>;
> +		};
> +
> +		mipi0_pwm_lpcg: clock-controller@5622300c {
> +			compatible =3D "fsl,imx8qxp-lpcg";
> +			reg =3D <0x5622300c 0x4>;
> +			#clock-cells =3D <1>;
> +			clocks =3D <&clk IMX_SC_R_MIPI_0_PWM_0 IMX_SC_PM_CLK_PER>,
> +				 <&dsi_ipg_clk>;
> +			clock-indices =3D <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> +			clock-output-names =3D "mipi0_pwm_lpcg_clk",
> +					     "mipi0_pwm_lpcg_ipg_clk";
> +			power-domains =3D <&pd IMX_SC_R_MIPI_0_PWM_0>;
> +		};
> +
> +		mipi0_i2c0_lpcg_ipg_clk: clock-controller@56223014 {
> +			compatible =3D "fsl,imx8qxp-lpcg";
> +			reg =3D <0x56223014 0x4>;
> +			#clock-cells =3D <1>;
> +			clocks =3D <&mipi0_i2c0_lpcg_ipg_s_clk IMX_LPCG_CLK_0>;
> +			clock-indices =3D <IMX_LPCG_CLK_0>;
> +			clock-output-names =3D "mipi0_i2c0_lpcg_ipg_clk";
> +			power-domains =3D <&pd IMX_SC_R_MIPI_0_I2C_0>;
> +		};
> +
> +		mipi0_i2c0_lpcg_ipg_s_clk: clock-controller@56223018 {
> +			compatible =3D "fsl,imx8qxp-lpcg";
> +			reg =3D <0x56223018 0x4>;
> +			#clock-cells =3D <1>;
> +			clocks =3D <&dsi_ipg_clk>;
> +			clock-indices =3D <IMX_LPCG_CLK_0>;
> +			clock-output-names =3D "mipi0_i2c0_lpcg_ipg_s_clk";
> +			power-domains =3D <&pd IMX_SC_R_MIPI_0_I2C_0>;
> +		};
> +
> +		mipi0_i2c0_lpcg_clk: clock-controller@5622301c {
> +			compatible =3D "fsl,imx8qxp-lpcg";
> +			reg =3D <0x5622301c 0x4>;
> +			#clock-cells =3D <1>;
> +			clocks =3D <&clk IMX_SC_R_MIPI_0_I2C_0 IMX_SC_PM_CLK_MISC2>;
> +			clock-indices =3D <IMX_LPCG_CLK_0>;
> +			clock-output-names =3D "mipi0_i2c0_lpcg_clk";
> +			power-domains =3D <&pd IMX_SC_R_MIPI_0_I2C_0>;
> +		};
> +
> +		mipi0_i2c1_lpcg_ipg_clk: clock-controller@56223024 {
> +			compatible =3D "fsl,imx8qxp-lpcg";
> +			reg =3D <0x56223024 0x4>;
> +			#clock-cells =3D <1>;
> +			clocks =3D <&mipi0_i2c1_lpcg_ipg_s_clk IMX_LPCG_CLK_0>;
> +			clock-indices =3D <IMX_LPCG_CLK_0>;
> +			clock-output-names =3D "mipi0_i2c1_lpcg_ipg_clk";
> +			power-domains =3D <&pd IMX_SC_R_MIPI_0_I2C_1>;
> +		};
> +
> +		mipi0_i2c1_lpcg_clk: clock-controller@5622302c {
> +			compatible =3D "fsl,imx8qxp-lpcg";
> +			reg =3D <0x5622302c 0x4>;
> +			#clock-cells =3D <1>;
> +			clocks =3D <&clk IMX_SC_R_MIPI_0_I2C_1 IMX_SC_PM_CLK_MISC2>;
> +			clock-indices =3D <IMX_LPCG_CLK_0>;
> +			clock-output-names =3D "mipi0_i2c1_lpcg_clk";
> +			power-domains =3D <&pd IMX_SC_R_MIPI_0_I2C_1>;
> +		};
> +
> +		mipi0_i2c1_lpcg_ipg_s_clk: clock-controller@56223028 {
> +			compatible =3D "fsl,imx8qxp-lpcg";
> +			reg =3D <0x56223028 0x4>;
> +			#clock-cells =3D <1>;
> +			clocks =3D <&dsi_ipg_clk>;
> +			clock-indices =3D <IMX_LPCG_CLK_0>;
> +			clock-output-names =3D "mipi0_i2c1_lpcg_ipg_s_clk";
> +			power-domains =3D <&pd IMX_SC_R_MIPI_0_I2C_1>;
> +		};
> +
> +		pwm_mipi0: pwm@56224000 {
> +			compatible =3D "fsl,imx8qxp-pwm", "fsl,imx27-pwm";
> +			reg =3D <0x56224000 0x1000>;
> +			clocks =3D <&mipi0_pwm_lpcg IMX_LPCG_CLK_4>,
> +				 <&mipi0_pwm_lpcg IMX_LPCG_CLK_0>;
> +			clock-names =3D "ipg", "per";
> +			assigned-clocks =3D <&clk IMX_SC_R_MIPI_0_PWM_0 IMX_SC_PM_CLK_PER>;
> +			assigned-clock-rates =3D <24000000>;
> +			#pwm-cells =3D <3>;
> +			power-domains =3D <&pd IMX_SC_R_MIPI_0_PWM_0>;
> +			status =3D "disabled";
> +		};
> +
> +		i2c0_mipi0: i2c@56226000 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			compatible =3D "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
> +			reg =3D <0x56226000 0x1000>;
> +			interrupts =3D <8>;
> +			clocks =3D <&mipi0_i2c0_lpcg_clk IMX_LPCG_CLK_0>,
> +				 <&mipi0_i2c0_lpcg_ipg_clk IMX_LPCG_CLK_0>;
> +			clock-names =3D "per", "ipg";
> +			assigned-clocks =3D <&mipi0_i2c0_lpcg_clk IMX_LPCG_CLK_0>;
> +			assigned-clock-rates =3D <24000000>;
> +			power-domains =3D <&pd IMX_SC_R_MIPI_0_I2C_0>;
> +			status =3D "disabled";
> +		};
> +	};
> +
> +	mipi1_subsys: bus@57220000 {
> +		compatible =3D "simple-bus";
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		ranges =3D <0x57220000 0x0 0x57220000 0x10000>;
> +
> +		irqsteer_mipi1: interrupt-controller@57220000 {
> +			compatible =3D "fsl,imx-irqsteer";
> +			reg =3D <0x57220000 0x1000>;
> +			interrupts =3D <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			interrupt-parent =3D <&gic>;
> +			#interrupt-cells =3D <1>;
> +			clocks =3D <&mipi1_lis_lpcg IMX_LPCG_CLK_0>;
> +			clock-names =3D "ipg";
> +			power-domains =3D <&pd IMX_SC_R_MIPI_1>;
> +			fsl,channel =3D <0>;
> +			fsl,num-irqs =3D <32>;
> +		};
> +
> +		mipi1_lis_lpcg: clock-controller@57223000 {
> +			compatible =3D "fsl,imx8qxp-lpcg";
> +			reg =3D <0x57223000 0x4>;
> +			#clock-cells =3D <1>;
> +			clocks =3D <&dsi_ipg_clk>;
> +			clock-indices =3D <IMX_LPCG_CLK_0>;
> +			clock-output-names =3D "mipi1_lis_lpcg_ipg_clk";
> +			power-domains =3D <&pd IMX_SC_R_MIPI_1>;
> +		};
> +
> +		mipi1_pwm_lpcg: clock-controller@5722300c {
> +			compatible =3D "fsl,imx8qxp-lpcg";
> +			reg =3D <0x5722300c 0x4>;
> +			#clock-cells =3D <1>;
> +			clocks =3D <&clk IMX_SC_R_MIPI_1_PWM_0 IMX_SC_PM_CLK_PER>,
> +				 <&dsi_ipg_clk>;
> +			clock-indices =3D <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> +			clock-output-names =3D "mipi1_pwm_lpcg_clk",
> +					     "mipi1_pwm_lpcg_ipg_clk";
> +			power-domains =3D <&pd IMX_SC_R_MIPI_1_PWM_0>;
> +		};
> +
> +		mipi1_i2c0_lpcg_clk: clock-controller@5722301c {
> +			compatible =3D "fsl,imx8qxp-lpcg";
> +			reg =3D <0x5722301c 0x4>;
> +			#clock-cells =3D <1>;
> +			clocks =3D <&clk IMX_SC_R_MIPI_1_I2C_0 IMX_SC_PM_CLK_MISC2>;
> +			clock-indices =3D <IMX_LPCG_CLK_0>;
> +			clock-output-names =3D "mipi1_i2c0_lpcg_clk";
> +			power-domains =3D <&pd IMX_SC_R_MIPI_1_I2C_0>;
> +		};
> +
> +		mipi1_i2c0_lpcg_ipg_clk: clock-controller@57223014 {
> +			compatible =3D "fsl,imx8qxp-lpcg";
> +			reg =3D <0x57223014 0x4>;
> +			#clock-cells =3D <1>;
> +			clocks =3D <&mipi1_i2c0_lpcg_ipg_s_clk IMX_LPCG_CLK_0>;
> +			clock-indices =3D <IMX_LPCG_CLK_0>;
> +			clock-output-names =3D "mipi1_i2c0_lpcg_ipg_clk";
> +			power-domains =3D <&pd IMX_SC_R_MIPI_1_I2C_0>;
> +		};
> +
> +		mipi1_i2c0_lpcg_ipg_s_clk: clock-controller@57223018 {
> +			compatible =3D "fsl,imx8qxp-lpcg";
> +			reg =3D <0x57223018 0x4>;
> +			#clock-cells =3D <1>;
> +			clocks =3D <&dsi_ipg_clk>;
> +			clock-indices =3D <IMX_LPCG_CLK_0>;
> +			clock-output-names =3D "mipi1_i2c0_lpcg_ipg_s_clk";
> +			power-domains =3D <&pd IMX_SC_R_MIPI_1_I2C_0>;
> +		};
> +
> +		mipi1_i2c1_lpcg_ipg_clk: clock-controller@57223024 {
> +			compatible =3D "fsl,imx8qxp-lpcg";
> +			reg =3D <0x57223024 0x4>;
> +			#clock-cells =3D <1>;
> +			clocks =3D <&mipi1_i2c1_lpcg_ipg_s_clk IMX_LPCG_CLK_0>;
> +			clock-indices =3D <IMX_LPCG_CLK_0>;
> +			clock-output-names =3D "mipi1_i2c1_lpcg_ipg_clk";
> +			power-domains =3D <&pd IMX_SC_R_MIPI_1_I2C_1>;
> +		};
> +
> +		mipi1_i2c1_lpcg_ipg_s_clk: clock-controller@57223028 {
> +			compatible =3D "fsl,imx8qxp-lpcg";
> +			reg =3D <0x57223028 0x4>;
> +			#clock-cells =3D <1>;
> +			clocks =3D <&dsi_ipg_clk>;
> +			clock-indices =3D <IMX_LPCG_CLK_0>;
> +			clock-output-names =3D "mipi1_i2c1_lpcg_ipg_s_clk";
> +			power-domains =3D <&pd IMX_SC_R_MIPI_1_I2C_1>;
> +		};
> +
> +		mipi1_i2c1_lpcg_clk: clock-controller@5722302c {
> +			compatible =3D "fsl,imx8qxp-lpcg";
> +			reg =3D <0x5722302c 0x4>;
> +			#clock-cells =3D <1>;
> +			clocks =3D <&clk IMX_SC_R_MIPI_1_I2C_1 IMX_SC_PM_CLK_MISC2>;
> +			clock-indices =3D <IMX_LPCG_CLK_0>;
> +			clock-output-names =3D "mipi1_i2c1_lpcg_clk";
> +			power-domains =3D <&pd IMX_SC_R_MIPI_1_I2C_1>;
> +		};
> +
> +		pwm_mipi1: pwm@57224000 {
> +			compatible =3D "fsl,imx8qxp-pwm", "fsl,imx27-pwm";
> +			reg =3D <0x57224000 0x1000>;
> +			clocks =3D <&mipi1_pwm_lpcg IMX_LPCG_CLK_4>,
> +				 <&mipi1_pwm_lpcg IMX_LPCG_CLK_0>;
> +			clock-names =3D "ipg", "per";
> +			assigned-clocks =3D <&clk IMX_SC_R_MIPI_1_PWM_0 IMX_SC_PM_CLK_PER>;
> +			assigned-clock-rates =3D <24000000>;
> +			#pwm-cells =3D <3>;
> +			power-domains =3D <&pd IMX_SC_R_MIPI_1_PWM_0>;
> +			status =3D "disabled";
> +		};
> +
> +		i2c0_mipi1: i2c@57226000 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			compatible =3D "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
> +			reg =3D <0x57226000 0x1000>;
> +			interrupts =3D <8>;
> +			interrupt-parent =3D <&irqsteer_mipi1>;
> +			clocks =3D <&mipi1_i2c0_lpcg_clk IMX_LPCG_CLK_0>,
> +				 <&mipi1_i2c0_lpcg_ipg_clk IMX_LPCG_CLK_0>;
> +			clock-names =3D "per", "ipg";
> +			assigned-clocks =3D <&mipi1_i2c0_lpcg_clk IMX_LPCG_CLK_0>;
> +			assigned-clock-rates =3D <24000000>;
> +			power-domains =3D <&pd IMX_SC_R_MIPI_1_I2C_0>;
> +			status =3D "disabled";
> +		};
> +	};
> +};
> +
> diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/=
dts/freescale/imx8qm.dtsi
> index 9f29fe4589668..846b95be22bbe 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> @@ -577,3 +577,4 @@ clk_spdif1_rx: clock-spdif1-rx {
>  #include "imx8qm-ss-lsio.dtsi"
>  #include "imx8qm-ss-audio.dtsi"
>  #include "imx8qm-ss-lvds.dtsi"
> +#include "imx8qm-ss-mipi.dtsi"
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



