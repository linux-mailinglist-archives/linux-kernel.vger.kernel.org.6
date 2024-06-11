Return-Path: <linux-kernel+bounces-209608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1C790385B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C81EBB23328
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF15C178375;
	Tue, 11 Jun 2024 10:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Vsd3mMsu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="B+lpaBY+"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70A5178364;
	Tue, 11 Jun 2024 10:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718100351; cv=none; b=Oc6Qnd922iEbW7O5CshgpXTFnGEL5LtZ0AQ11fSFZCAv/FKmwtK6Z0jloFUrlG4HbqP83f7L+jCB24ZjCOlrrLa5lC01uRZDpsj4m1bQWgliu4XBifx+/sdaTANtVgkQIES1sYGstlJKcdXSr9kDsnTIbpDJT8mEUm0cD2X504Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718100351; c=relaxed/simple;
	bh=Efn05NVXQ8LL12SEOgebkSabzxCq2BMNBnhaIh464Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LzQhZdruymaHkpoiAmPPQynmOZbuxutSsW5wrz5k0VVu8jJoXUCRzqvQOTau0XWJ0EHAbBKYZYQYq+hMePYja7Npm4UdkD4ko4zJatK2aC7+/68mhYZ2cnaXF3CifVQNUB1i0swqPVtBH1xw9Dn+5It0baUogfBg9b0h4uY7gcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Vsd3mMsu; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=B+lpaBY+ reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1718100348; x=1749636348;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IpeC1QAyGp7/ecmPqLy+8ePCuBDPCsaQb8tByibuhG4=;
  b=Vsd3mMsuvLcrMtLCGYuG5BlsfKvEUCycM7BYMtK1ln/NGBC42K/dn9Cm
   2LWZRdcpM5OIoC/k2jkErTY31knN9qOdwkDQjRdImQwvq8QqPU3xK3rTO
   i06UnZXrKjZbcgDuof1r8RJMkDfhv0Mm7TIqC052rE+UXKQ3Pv7iMkwlw
   pYCiZ7eAgbisa/h7dZ+W6jSSb9EQJkI49p7DqflPmBcvtcMPWlPmKPWPi
   JpLv4rFKRhr7TVSXjI9YJezN49eWSeAAfyIBEJA1mcMStHZviWNuX0tHe
   jERpGGKXfWZw5Go7ZAs+uSFGCqHIq5Oy4oLei9RjwMQfcTsKga3/A2AjB
   A==;
X-CSE-ConnectionGUID: 1P99VBzoRRaTc8rrIT8Wsw==
X-CSE-MsgGUID: vPHOmii7R1+khm3rIbi4Rg==
X-IronPort-AV: E=Sophos;i="6.08,229,1712613600"; 
   d="scan'208";a="37329397"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 11 Jun 2024 12:05:39 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 468ED163947;
	Tue, 11 Jun 2024 12:05:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1718100335;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=IpeC1QAyGp7/ecmPqLy+8ePCuBDPCsaQb8tByibuhG4=;
	b=B+lpaBY+5PQduUy26+YMD3o23CtOQFLQsz5x6J4Bt41aIzZw2yep1fBN9tF4XmrU3x84Mg
	AT+P7LWVDCPZxxfSli8hNWh3rI/T6pF0nxH4eRTMuuBfxQUR2sDYTFaZm+POUCx7MliTn/
	Zk8kcDj0RolsedtKYfgHMw2sCKl7Qpm0xwZY6OMG8hx0HZU1sJE/U4cbPXcw21aKB8XDZk
	qz1GdbGMnMIZmC3+1B1p+wnnQ1DbexlkunLL8axoxwTmxPH15a/m1LQMkhDeQNITQVDGBr
	ThRuSVUFwwBuLkocjKXqSSzlo/T2uccWpUxv/PQmDfgsLQMiOJt6DwcYtG6evg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>, linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/9] arm64: dts: imx8: add basic lvds and lvds2 subsystem
Date: Tue, 11 Jun 2024 12:05:35 +0200
Message-ID: <5792284.DvuYhMxLoT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240610-imx8qm-dts-usb-v2-1-788417116fb1@nxp.com>
References: <20240610-imx8qm-dts-usb-v2-0-788417116fb1@nxp.com> <20240610-imx8qm-dts-usb-v2-1-788417116fb1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi Frank,

Am Montag, 10. Juni 2024, 22:46:18 CEST schrieb Frank Li:
> Add basic lvds and lvds2 subsystem for imx8qm an imx8qxp.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8-ss-lvds0.dtsi |  63 +++++++++++++
>  arch/arm64/boot/dts/freescale/imx8-ss-lvds1.dtsi | 114 +++++++++++++++++=
++++++
>  2 files changed, 177 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-lvds0.dtsi b/arch/arm6=
4/boot/dts/freescale/imx8-ss-lvds0.dtsi
> new file mode 100644
> index 0000000000000..55fd60446ad21
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-lvds0.dtsi
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0-only and MIT
> +
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +lvds0_subsys: bus@56240000 {
> +	compatible =3D "simple-bus";
> +	#address-cells =3D <1>;
> +	#size-cells =3D <1>;
> +	ranges =3D <0x56240000 0x0 0x56240000 0x10000>;
> +
> +	qm_lvds0_lis_lpcg: qxp_mipi1_lis_lpcg: clock-controller@56243000 {
> +		compatible =3D "fsl,imx8qxp-lpcg";
> +		reg =3D <0x56243000 0x4>;
> +		#clock-cells =3D <1>;
> +		clock-output-names =3D "mipi1_lis_lpcg_ipg_clk";
> +		power-domains =3D <&pd IMX_SC_R_MIPI_1>;
> +	};
> +
> +	qm_lvds0_pwm_lpcg: qxp_mipi1_pwm_lpcg: clock-controller@5624300c {
> +		compatible =3D "fsl,imx8qxp-lpcg";
> +		reg =3D <0x5624300c 0x4>;
> +		#clock-cells =3D <1>;
> +		clock-output-names =3D "mipi1_pwm_lpcg_clk",
> +				     "mipi1_pwm_lpcg_ipg_clk",
> +				     "mipi1_pwm_lpcg_32k_clk";
> +		power-domains =3D <&pd IMX_SC_R_MIPI_1_PWM_0>;
> +	};
> +
> +	qm_lvds0_i2c0_lpcg: qxp_mipi1_i2c0_lpcg: clock-controller@56243010 {
> +		compatible =3D "fsl,imx8qxp-lpcg";
> +		reg =3D <0x56243010 0x4>;
> +		#clock-cells =3D <1>;
> +		clock-output-names =3D "mipi1_i2c0_lpcg_clk",
> +				     "mipi1_i2c0_lpcg_ipg_clk";
> +		power-domains =3D <&pd IMX_SC_R_MIPI_1_I2C_0>;
> +	};
> +
> +	qm_pwm_lvds0: qxp_pwm_mipi_lvds1: pwm@56244000 {
> +		compatible =3D "fsl,imx8qxp-pwm", "fsl,imx27-pwm";
> +		reg =3D <0x56244000 0x1000>;
> +		clock-names =3D "ipg", "per";
> +		assigned-clocks =3D <&clk IMX_SC_R_MIPI_1_I2C_0 IMX_SC_PM_CLK_PER>;

Is IMX_SC_R_MIPI_1_I2C_0 actually correct? I would have assumed
it's IMX_SC_R_MIPI_1_PWM_0.

> +		assigned-clock-rates =3D <24000000>;
> +		#pwm-cells =3D <3>;
> +		power-domains =3D <&pd IMX_SC_R_MIPI_1_PWM_0>;
> +		status =3D "disabled";
> +	};
> +
> +	qm_i2c0_lvds0: qxp_i2c0_mipi_lvds1: i2c@56246000 {
> +		compatible =3D "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
> +		reg =3D <0x56246000 0x1000>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		interrupts =3D <8>;
> +		clock-names =3D "per", "ipg";
> +		assigned-clocks =3D <&clk IMX_SC_R_MIPI_1_I2C_0 IMX_SC_PM_CLK_PER>;
> +		assigned-clock-rates =3D <24000000>;
> +		power-domains =3D <&pd IMX_SC_R_MIPI_1_I2C_0>;
> +		status =3D "disabled";
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-lvds1.dtsi b/arch/arm6=
4/boot/dts/freescale/imx8-ss-lvds1.dtsi
> new file mode 100644
> index 0000000000000..12ae4f48e1e1c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-lvds1.dtsi

This is only for imx8qm, no?

It maybe makes sense to rename this file to imx8qm-ss-lvds1.dtsi

Best regards,
Alexander

> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: GPL-2.0-only and MIT
> +
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +lvds1_subsys: bus@57240000 {
> +	compatible =3D "simple-bus";
> +	interrupt-parent =3D <&irqsteer_lvds1>;
> +	#address-cells =3D <1>;
> +	#size-cells =3D <1>;
> +	ranges =3D <0x57240000 0x0 0x57240000 0x10000>;
> +
> +	irqsteer_lvds1: interrupt-controller@57240000 {
> +		compatible =3D "fsl,imx8qm-irqsteer", "fsl,imx-irqsteer";
> +		reg =3D <0x57240000 0x1000>;
> +		interrupts =3D <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-controller;
> +		interrupt-parent =3D <&gic>;
> +		#interrupt-cells =3D <1>;
> +		clocks =3D <&lvds1_lis_lpcg IMX_LPCG_CLK_4>;
> +		clock-names =3D "ipg";
> +		power-domains =3D <&pd IMX_SC_R_LVDS_1>;
> +		fsl,channel =3D <0>;
> +		fsl,num-irqs =3D <32>;
> +	};
> +
> +	lvds1_lis_lpcg: clock-controller@57243000 {
> +		compatible =3D "fsl,imx8qxp-lpcg";
> +		reg =3D <0x57243000 0x4>;
> +		#clock-cells =3D <1>;
> +		clocks =3D <&lvds_ipg_clk>;
> +		clock-indices =3D <IMX_LPCG_CLK_4>;
> +		clock-output-names =3D "lvds1_lis_lpcg_ipg_clk";
> +		power-domains =3D <&pd IMX_SC_R_LVDS_1>;
> +	};
> +
> +	lvds1_pwm_lpcg: clock-controller@5724300c {
> +		compatible =3D "fsl,imx8qxp-lpcg";
> +		reg =3D <0x5724300c 0x4>;
> +		#clock-cells =3D <1>;
> +		clocks =3D <&clk IMX_SC_R_LVDS_1_PWM_0 IMX_SC_PM_CLK_PER>,
> +			 <&lvds_ipg_clk>;
> +		clock-indices =3D <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> +		clock-output-names =3D "lvds1_pwm_lpcg_clk",
> +				     "lvds1_pwm_lpcg_ipg_clk";
> +		power-domains =3D <&pd IMX_SC_R_LVDS_1_PWM_0>;
> +	};
> +
> +	lvds1_i2c0_lpcg: clock-controller@57243010 {
> +		compatible =3D "fsl,imx8qxp-lpcg";
> +		reg =3D <0x57243010 0x4>;
> +		#clock-cells =3D <1>;
> +		clocks =3D <&clk IMX_SC_R_LVDS_1_I2C_0 IMX_SC_PM_CLK_PER>,
> +			 <&lvds_ipg_clk>;
> +		clock-indices =3D <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> +		clock-output-names =3D "lvds1_i2c0_lpcg_clk",
> +				     "lvds1_i2c0_lpcg_ipg_clk";
> +		power-domains =3D <&pd IMX_SC_R_LVDS_1_I2C_0>;
> +	};
> +
> +	lvds1_i2c1_lpcg: clock-controller@57243014 {
> +		compatible =3D "fsl,imx8qxp-lpcg";
> +		reg =3D <0x57243014 0x4>;
> +		#clock-cells =3D <1>;
> +		clocks =3D <&clk IMX_SC_R_LVDS_1_I2C_0 IMX_SC_PM_CLK_PER>,
> +			 <&lvds_ipg_clk>;
> +		clock-indices =3D <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> +		clock-output-names =3D "lvds1_i2c1_lpcg_clk",
> +				     "lvds1_i2c1_lpcg_ipg_clk";
> +		power-domains =3D <&pd IMX_SC_R_LVDS_1_I2C_0>;
> +	};
> +
> +	pwm_lvds1: pwm@57244000 {
> +		compatible =3D "fsl,imx8qxp-pwm", "fsl,imx27-pwm";
> +		reg =3D <0x57244000 0x1000>;
> +		clocks =3D <&lvds1_pwm_lpcg IMX_LPCG_CLK_4>,
> +			 <&lvds1_pwm_lpcg IMX_LPCG_CLK_0>;
> +		clock-names =3D "ipg", "per";
> +		assigned-clocks =3D <&clk IMX_SC_R_LVDS_1_PWM_0 IMX_SC_PM_CLK_PER>;
> +		assigned-clock-rates =3D <24000000>;
> +		#pwm-cells =3D <3>;
> +		power-domains =3D <&pd IMX_SC_R_LVDS_1_PWM_0>;
> +		status =3D "disabled";
> +	};
> +
> +	i2c0_lvds1: i2c@57246000 {
> +		compatible =3D "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
> +		reg =3D <0x57246000 0x1000>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		interrupts =3D <8>;
> +		clocks =3D <&lvds1_i2c0_lpcg IMX_LPCG_CLK_0>,
> +			 <&lvds1_i2c0_lpcg IMX_LPCG_CLK_4>;
> +		clock-names =3D "per", "ipg";
> +		assigned-clocks =3D <&clk IMX_SC_R_LVDS_1_I2C_0 IMX_SC_PM_CLK_PER>;
> +		assigned-clock-rates =3D <24000000>;
> +		power-domains =3D <&pd IMX_SC_R_LVDS_1_I2C_0>;
> +		status =3D "disabled";
> +	};
> +
> +	i2c1_lvds1: i2c@57247000 {
> +		compatible =3D "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
> +		reg =3D <0x57247000 0x1000>;
> +		interrupts =3D <9>;
> +		clocks =3D <&lvds1_i2c1_lpcg IMX_LPCG_CLK_0>,
> +			 <&lvds1_i2c1_lpcg IMX_LPCG_CLK_4>;
> +		clock-names =3D "per", "ipg";
> +		assigned-clocks =3D <&clk IMX_SC_R_LVDS_1_I2C_0 IMX_SC_PM_CLK_PER>;
> +		assigned-clock-rates =3D <24000000>;
> +		power-domains =3D <&pd IMX_SC_R_LVDS_1_I2C_0>;
> +		status =3D "disabled";
> +	};
> +};
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



