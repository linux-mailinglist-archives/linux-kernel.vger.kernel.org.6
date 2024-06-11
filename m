Return-Path: <linux-kernel+bounces-209712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BDE9039C3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AF041C219E8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B82B17A93A;
	Tue, 11 Jun 2024 11:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="pyeJevoR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="cMy3t+t2"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0EE14F9EE;
	Tue, 11 Jun 2024 11:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718104475; cv=none; b=VvaZFoSasFLllUXXhaI7kjFUk5fYlNwl1wH50hk99lK/D/Cga7+47qCJGrGM/PbBsOv6nt+P6WW38rcDEZNZgM7fqQy03QxU2xCj4EIeGNoB9iVEC+9UrDLOfiij+mJAk5x5ebri1hPe1NFQLp+dv8oXRi6EALqI5FK5Pj6Z+Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718104475; c=relaxed/simple;
	bh=CkiMqKxPiGR645vdpz18V4Euqo7gdC1GDpwS0frfJ08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AzeKPVbhEvU62hvCChRbGAAoOBIhrYWigtRE4+B0ZcqHutlhDBwIcRQJMbL0pe+B5t6TZl03fq7GvgiwUezzR4GQ3HBpQOGME8x/kqpX5NHUfQ1rzID909dhMia8z0v/uLUo7WSpLd2/A3tlglh31EiTM+vSW0nIXV78/IGuNi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=pyeJevoR; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=cMy3t+t2 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1718104471; x=1749640471;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4PjT/MrSudGoxdl+OLVToOZpc+RsOaj2dmxQ6UUv+H0=;
  b=pyeJevoR5A+9rPWGJz0OEHmiBRPSMXq2dVPh/ewPmSDCDTiSnw2WcU9S
   c3586IkFiV7FaTRm9dJR3XhV5xNe92j/2lislvkU0wLCFaHyfFx9sXiWm
   LjLy5Uv4CJehynLCc80rnDXWeBSj70HOPTEIHa4ak8x3ANn/T7fZdH7Bv
   wQcLiEgisAknfrBbmXBolrPDvOndiTGIEmYCXC0ExxyC1rL7GlQhf3F5B
   C2mKuRA1FgVgP25wO8vP5bPTfk5r7ode+pOJr3Gil0GSRr7ELwmwQHweO
   +E5hyXey6gUCau4mX7jdhARspyzK6SUa00gjhQYb5aWVv2q49vumQpsSv
   g==;
X-CSE-ConnectionGUID: CE35JlwyRz6QaDhcyCEtxg==
X-CSE-MsgGUID: 23UtiwDmR8+YUI0+AI/E6Q==
X-IronPort-AV: E=Sophos;i="6.08,229,1712613600"; 
   d="scan'208";a="37330923"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 11 Jun 2024 13:14:29 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8FC6916372F;
	Tue, 11 Jun 2024 13:14:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1718104464;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4PjT/MrSudGoxdl+OLVToOZpc+RsOaj2dmxQ6UUv+H0=;
	b=cMy3t+t2kqcsAjGSDPgcLesGLRvKqfzy69dRWYhppH/FYAy7q4na2UyjOiBR2dXRFRMsnq
	qgeRYhWh+0T8ez79sWqsr5AtoNxnbQTowCeUdqNLaB3C9Ws8/8K5lsFadlns31nOrz9Qan
	kR42h8wYXIOHoUdvfLR+8iKSAzE0qSGoJlHWybIyQgdDCbh1PGUmlfWSH5MqaM8EeOniDN
	ihIhyOUq10mcg69SDmmsy5uk2l2/Pxea4c2YMDviTtYg+rrcKk4SZIBuWclXKQuj5TGxMm
	xaMFyvAumCv/hcRv6650oKnFqeRalSoNf1mYRbdY3TDyJKN9DFp55CygWvK+Rg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>, linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 3/9] arm64: dts: imx8: add basic mipi subsystem
Date: Tue, 11 Jun 2024 13:14:20 +0200
Message-ID: <13535816.uLZWGnKmhe@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240610-imx8qm-dts-usb-v2-3-788417116fb1@nxp.com>
References: <20240610-imx8qm-dts-usb-v2-0-788417116fb1@nxp.com> <20240610-imx8qm-dts-usb-v2-3-788417116fb1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Am Montag, 10. Juni 2024, 22:46:20 CEST schrieb Frank Li:
> ********************
> Achtung externe E-Mail: =D6ffnen Sie Anh=E4nge und Links nur, wenn Sie wi=
ssen, dass diese aus einer sicheren Quelle stammen und sicher sind. Leiten =
Sie die E-Mail im Zweifelsfall zur Pr=FCfung an den IT-Helpdesk weiter.
> Attention external email: Open attachments and links only if you know tha=
t they are from a secure source and are safe. In doubt forward the email to=
 the IT-Helpdesk to check it.
> ********************
>=20
> Add basic mipi subsystem for imx8qm and imx8qxp.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8-ss-mipi0.dtsi | 138 +++++++++++++++++=
++++++
>  arch/arm64/boot/dts/freescale/imx8-ss-mipi1.dtsi | 138 +++++++++++++++++=
++++++
>  2 files changed, 276 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-mipi0.dtsi b/arch/arm6=
4/boot/dts/freescale/imx8-ss-mipi0.dtsi
> new file mode 100644
> index 0000000000000..6b56315e8c434
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-mipi0.dtsi
> @@ -0,0 +1,138 @@
> +// SPDX-License-Identifier: GPL-2.0-only and MIT
> +
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +mipi0_subsys: bus@56220000 {
> +	compatible =3D "simple-bus";
> +	interrupt-parent =3D <&irqsteer_mipi0>;
> +	#address-cells =3D <1>;
> +	#size-cells =3D <1>;
> +	ranges =3D <0x56220000 0x0 0x56220000 0x10000>;
> +
> +	irqsteer_mipi0: interrupt-controller@56220000 {
> +		compatible =3D "fsl,imx8qxp-irqsteer", "fsl,imx-irqsteer";
> +		reg =3D <0x56220000 0x1000>;
> +		interrupts =3D <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-controller;
> +		interrupt-parent =3D <&gic>;
> +		#interrupt-cells =3D <1>;
> +		clocks =3D <&mipi0_lis_lpcg IMX_LPCG_CLK_0>;
> +		clock-names =3D "ipg";
> +		power-domains =3D <&pd IMX_SC_R_MIPI_0>;
> +		fsl,channel =3D <0>;
> +		fsl,num-irqs =3D <32>;
> +	};
> +
> +	mipi0_lis_lpcg: clock-controller@56223000 {
> +		compatible =3D "fsl,imx8qxp-lpcg";
> +		reg =3D <0x56223000 0x4>;
> +		#clock-cells =3D <1>;
> +		clocks =3D <&dsi_ipg_clk>;
> +		clock-indices =3D <IMX_LPCG_CLK_0>;

That's LPCG_DI_LVDS_LPCG_0 for imx8qxp, no? So clock-indices and
clock-output-names should be split similar to patch.

> +		clock-output-names =3D "mipi0_lis_lpcg_ipg_clk";
> +		power-domains =3D <&pd IMX_SC_R_MIPI_0>;
> +	};
> +
> +	mipi0_pwm_lpcg: clock-controller@5622300c {
> +		compatible =3D "fsl,imx8qxp-lpcg";
> +		reg =3D <0x5622300c 0x4>;
> +		#clock-cells =3D <1>;
> +		clocks =3D <&clk IMX_SC_R_MIPI_0_PWM_0 IMX_SC_PM_CLK_PER>,
> +			 <&dsi_ipg_clk>;
> +		clock-indices =3D <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> +		clock-output-names =3D "mipi0_pwm_lpcg_clk",
> +				     "mipi0_pwm_lpcg_ipg_clk";

That's LPCG_DI_MIPI_LPCG_12, no? imx8qm RM Rev 0 just lists one clock.
Also it's different on imx8qxp.

> +		power-domains =3D <&pd IMX_SC_R_MIPI_0_PWM_0>;
> +	};
> +
> +	mipi0_i2c0_lpcg_ipg_clk: clock-controller@56223014 {
> +		compatible =3D "fsl,imx8qxp-lpcg";
> +		reg =3D <0x56223014 0x4>;
> +		#clock-cells =3D <1>;
> +		clocks =3D <&mipi0_i2c0_lpcg_ipg_s_clk IMX_LPCG_CLK_0>;

Just 0 instead of IMX_LPCG_CLK_0.

> +		clock-indices =3D <IMX_LPCG_CLK_0>;
> +		clock-output-names =3D "mipi0_i2c0_lpcg_ipg_clk";
> +		power-domains =3D <&pd IMX_SC_R_MIPI_0_I2C_0>;
> +	};
> +
> +	mipi0_i2c0_lpcg_ipg_s_clk: clock-controller@56223018 {
> +		compatible =3D "fsl,imx8qxp-lpcg";
> +		reg =3D <0x56223018 0x4>;
> +		#clock-cells =3D <1>;
> +		clocks =3D <&dsi_ipg_clk>;
> +		clock-indices =3D <IMX_LPCG_CLK_0>;
> +		clock-output-names =3D "mipi0_i2c0_lpcg_ipg_s_clk";
> +		power-domains =3D <&pd IMX_SC_R_MIPI_0_I2C_0>;
> +	};
> +
> +	mipi0_i2c0_lpcg_clk: clock-controller@5622301c {
> +		compatible =3D "fsl,imx8qxp-lpcg";
> +		reg =3D <0x5622301c 0x4>;
> +		#clock-cells =3D <1>;
> +		clocks =3D <&clk IMX_SC_R_MIPI_0_I2C_0 IMX_SC_PM_CLK_MISC2>;
> +		clock-indices =3D <IMX_LPCG_CLK_0>;
> +		clock-output-names =3D "mipi0_i2c0_lpcg_clk";
> +		power-domains =3D <&pd IMX_SC_R_MIPI_0_I2C_0>;
> +	};
> +
> +	mipi0_i2c1_lpcg_ipg_clk: clock-controller@56223024 {
> +		compatible =3D "fsl,imx8qxp-lpcg";
> +		reg =3D <0x56223024 0x4>;
> +		#clock-cells =3D <1>;
> +		clocks =3D <&mipi0_i2c1_lpcg_ipg_s_clk IMX_LPCG_CLK_0>;
> +		clock-indices =3D <IMX_LPCG_CLK_0>;
> +		clock-output-names =3D "mipi0_i2c1_lpcg_ipg_clk";
> +		power-domains =3D <&pd IMX_SC_R_MIPI_0_I2C_1>;
> +	};
> +
> +	mipi0_i2c1_lpcg_clk: clock-controller@5622302c {
> +		compatible =3D "fsl,imx8qxp-lpcg";
> +		reg =3D <0x5622302c 0x4>;
> +		#clock-cells =3D <1>;
> +		clocks =3D <&clk IMX_SC_R_MIPI_0_I2C_1 IMX_SC_PM_CLK_MISC2>;
> +		clock-indices =3D <IMX_LPCG_CLK_0>;
> +		clock-output-names =3D "mipi0_i2c1_lpcg_clk";
> +		power-domains =3D <&pd IMX_SC_R_MIPI_0_I2C_1>;
> +	};
> +
> +	mipi0_i2c1_lpcg_ipg_s_clk: clock-controller@56223028 {
> +		compatible =3D "fsl,imx8qxp-lpcg";
> +		reg =3D <0x56223028 0x4>;

Order nodes by base address please.

> +		#clock-cells =3D <1>;
> +		clocks =3D <&dsi_ipg_clk>;
> +		clock-indices =3D <IMX_LPCG_CLK_0>;
> +		clock-output-names =3D "mipi0_i2c1_lpcg_ipg_s_clk";
> +		power-domains =3D <&pd IMX_SC_R_MIPI_0_I2C_1>;
> +	};
> +
> +	pwm_mipi0: pwm@56224000 {
> +		compatible =3D "fsl,imx8qxp-pwm", "fsl,imx27-pwm";
> +		reg =3D <0x56224000 0x1000>;
> +		clocks =3D <&mipi0_pwm_lpcg IMX_LPCG_CLK_4>,
> +			 <&mipi0_pwm_lpcg IMX_LPCG_CLK_0>;

I don't think that's correct. IMX_LPCG_CLK_4 evaluates to 16.
'mipi0_pwm_lpcg' only has 2 clocks, so you should use just '1' and '0'.

> +		clock-names =3D "ipg", "per";
> +		assigned-clocks =3D <&clk IMX_SC_R_MIPI_0_PWM_0 IMX_SC_PM_CLK_PER>;
> +		assigned-clock-rates =3D <24000000>;
> +		#pwm-cells =3D <3>;
> +		power-domains =3D <&pd IMX_SC_R_MIPI_0_PWM_0>;
> +		status =3D "disabled";
> +	};
> +
> +	i2c0_mipi0: i2c@56226000 {
> +		compatible =3D "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
> +		reg =3D <0x56226000 0x1000>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		interrupts =3D <8>;
> +		clocks =3D <&mipi0_i2c0_lpcg_clk IMX_LPCG_CLK_0>,
> +			 <&mipi0_i2c0_lpcg_ipg_clk IMX_LPCG_CLK_0>;

Just use 0 instead of IMX_LPCG_CLK_0.

> +		clock-names =3D "per", "ipg";
> +		assigned-clocks =3D <&mipi0_i2c0_lpcg_clk IMX_LPCG_CLK_0>;
> +		assigned-clock-rates =3D <24000000>;
> +		power-domains =3D <&pd IMX_SC_R_MIPI_0_I2C_0>;
> +		status =3D "disabled";
> +	};
> +};
> +
> diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-mipi1.dtsi b/arch/arm6=
4/boot/dts/freescale/imx8-ss-mipi1.dtsi
> new file mode 100644
> index 0000000000000..5b1f08e412b24
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-mipi1.dtsi

This is only for imx8qm, no?

It maybe makes sense to rename this file to imx8qm-ss-mipi1.dtsi

Best regards,
Alexander

> @@ -0,0 +1,138 @@
> +// SPDX-License-Identifier: GPL-2.0-only and MIT
> +
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +mipi1_subsys: bus@57220000 {
> +	compatible =3D "simple-bus";
> +	interrupt-parent =3D <&irqsteer_mipi1>;
> +	#address-cells =3D <1>;
> +	#size-cells =3D <1>;
> +	ranges =3D <0x57220000 0x0 0x57220000 0x10000>;
> +
> +	irqsteer_mipi1: interrupt-controller@57220000 {
> +		compatible =3D "fsl,imx8qm-irqsteer", "fsl,imx-irqsteer";
> +		reg =3D <0x57220000 0x1000>;
> +		interrupts =3D <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-controller;
> +		interrupt-parent =3D <&gic>;
> +		#interrupt-cells =3D <1>;
> +		clocks =3D <&mipi1_lis_lpcg IMX_LPCG_CLK_0>;
> +		clock-names =3D "ipg";
> +		power-domains =3D <&pd IMX_SC_R_MIPI_1>;
> +		fsl,channel =3D <0>;
> +		fsl,num-irqs =3D <32>;
> +	};
> +
> +	mipi1_lis_lpcg: clock-controller@57223000 {
> +		compatible =3D "fsl,imx8qxp-lpcg";
> +		reg =3D <0x57223000 0x4>;
> +		#clock-cells =3D <1>;
> +		clocks =3D <&dsi_ipg_clk>;
> +		clock-indices =3D <IMX_LPCG_CLK_0>;
> +		clock-output-names =3D "mipi1_lis_lpcg_ipg_clk";
> +		power-domains =3D <&pd IMX_SC_R_MIPI_1>;
> +	};
> +
> +	mipi1_pwm_lpcg: clock-controller@5722300c {
> +		compatible =3D "fsl,imx8qxp-lpcg";
> +		reg =3D <0x5722300c 0x4>;
> +		#clock-cells =3D <1>;
> +		clocks =3D <&clk IMX_SC_R_MIPI_1_PWM_0 IMX_SC_PM_CLK_PER>,
> +			 <&dsi_ipg_clk>;
> +		clock-indices =3D <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> +		clock-output-names =3D "mipi1_pwm_lpcg_clk",
> +				     "mipi1_pwm_lpcg_ipg_clk";
> +		power-domains =3D <&pd IMX_SC_R_MIPI_1_PWM_0>;
> +	};
> +
> +	mipi1_i2c0_lpcg_clk: clock-controller@5722301c {
> +		compatible =3D "fsl,imx8qxp-lpcg";
> +		reg =3D <0x5722301c 0x4>;
> +		#clock-cells =3D <1>;
> +		clocks =3D <&clk IMX_SC_R_MIPI_1_I2C_0 IMX_SC_PM_CLK_MISC2>;
> +		clock-indices =3D <IMX_LPCG_CLK_0>;
> +		clock-output-names =3D "mipi1_i2c0_lpcg_clk";
> +		power-domains =3D <&pd IMX_SC_R_MIPI_1_I2C_0>;
> +	};
> +
> +	mipi1_i2c0_lpcg_ipg_clk: clock-controller@57223014 {
> +		compatible =3D "fsl,imx8qxp-lpcg";
> +		reg =3D <0x57223014 0x4>;
> +		#clock-cells =3D <1>;
> +		clocks =3D <&mipi1_i2c0_lpcg_ipg_s_clk IMX_LPCG_CLK_0>;
> +		clock-indices =3D <IMX_LPCG_CLK_0>;
> +		clock-output-names =3D "mipi1_i2c0_lpcg_ipg_clk";
> +		power-domains =3D <&pd IMX_SC_R_MIPI_1_I2C_0>;
> +	};
> +
> +	mipi1_i2c0_lpcg_ipg_s_clk: clock-controller@57223018 {
> +		compatible =3D "fsl,imx8qxp-lpcg";
> +		reg =3D <0x57223018 0x4>;
> +		#clock-cells =3D <1>;
> +		clocks =3D <&dsi_ipg_clk>;
> +		clock-indices =3D <IMX_LPCG_CLK_0>;
> +		clock-output-names =3D "mipi1_i2c0_lpcg_ipg_s_clk";
> +		power-domains =3D <&pd IMX_SC_R_MIPI_1_I2C_0>;
> +	};
> +
> +	mipi1_i2c1_lpcg_ipg_clk: clock-controller@57223024 {
> +		compatible =3D "fsl,imx8qxp-lpcg";
> +		reg =3D <0x57223024 0x4>;
> +		#clock-cells =3D <1>;
> +		clocks =3D <&mipi1_i2c1_lpcg_ipg_s_clk IMX_LPCG_CLK_0>;
> +		clock-indices =3D <IMX_LPCG_CLK_0>;
> +		clock-output-names =3D "mipi1_i2c1_lpcg_ipg_clk";
> +		power-domains =3D <&pd IMX_SC_R_MIPI_1_I2C_1>;
> +	};
> +
> +	mipi1_i2c1_lpcg_ipg_s_clk: clock-controller@57223028 {
> +		compatible =3D "fsl,imx8qxp-lpcg";
> +		reg =3D <0x57223028 0x4>;
> +		#clock-cells =3D <1>;
> +		clocks =3D <&dsi_ipg_clk>;
> +		clock-indices =3D <IMX_LPCG_CLK_0>;
> +		clock-output-names =3D "mipi1_i2c1_lpcg_ipg_s_clk";
> +		power-domains =3D <&pd IMX_SC_R_MIPI_1_I2C_1>;
> +	};
> +
> +	mipi1_i2c1_lpcg_clk: clock-controller@5722302c {
> +		compatible =3D "fsl,imx8qxp-lpcg";
> +		reg =3D <0x5722302c 0x4>;
> +		#clock-cells =3D <1>;
> +		clocks =3D <&clk IMX_SC_R_MIPI_1_I2C_1 IMX_SC_PM_CLK_MISC2>;
> +		clock-indices =3D <IMX_LPCG_CLK_0>;
> +		clock-output-names =3D "mipi1_i2c1_lpcg_clk";
> +		power-domains =3D <&pd IMX_SC_R_MIPI_1_I2C_1>;
> +	};
> +
> +	pwm_mipi1: pwm@57224000 {
> +		compatible =3D "fsl,imx8qxp-pwm", "fsl,imx27-pwm";
> +		reg =3D <0x57224000 0x1000>;
> +		clocks =3D <&mipi1_pwm_lpcg IMX_LPCG_CLK_4>,
> +			 <&mipi1_pwm_lpcg IMX_LPCG_CLK_0>;
> +		clock-names =3D "ipg", "per";
> +		assigned-clocks =3D <&clk IMX_SC_R_MIPI_1_PWM_0 IMX_SC_PM_CLK_PER>;
> +		assigned-clock-rates =3D <24000000>;
> +		#pwm-cells =3D <3>;
> +		power-domains =3D <&pd IMX_SC_R_MIPI_1_PWM_0>;
> +		status =3D "disabled";
> +	};
> +
> +	i2c0_mipi1: i2c@57226000 {
> +		compatible =3D "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
> +		reg =3D <0x57226000 0x1000>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		interrupts =3D <8>;
> +		interrupt-parent =3D <&irqsteer_mipi1>;
> +		clocks =3D <&mipi1_i2c0_lpcg_clk IMX_LPCG_CLK_0>,
> +			 <&mipi1_i2c0_lpcg_ipg_clk IMX_LPCG_CLK_0>;
> +		clock-names =3D "per", "ipg";
> +		assigned-clocks =3D <&mipi1_i2c0_lpcg_clk IMX_LPCG_CLK_0>;
> +		assigned-clock-rates =3D <24000000>;
> +		power-domains =3D <&pd IMX_SC_R_MIPI_1_I2C_0>;
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



