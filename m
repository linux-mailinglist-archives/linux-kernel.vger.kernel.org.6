Return-Path: <linux-kernel+bounces-317040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5C596D882
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0E931F272C0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D966219CC23;
	Thu,  5 Sep 2024 12:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="PaJFUNEw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="HCsUPSZ2"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF15A19C576;
	Thu,  5 Sep 2024 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725539206; cv=none; b=MgKbN2OOibORg/OISb1w2gKkRCBSnWl26pjIG7ng9xJaZ7CbPSIX2Ast7Skka0BE/Ak3UFaMWlfFdQTQ3KtcHGVWiQMjDyxnPqfKSgMYSp+5jaF5zdgpg7P8ygZrjvcLuPONJzdU5H95hD28JI5ch5vvDQVfCG/Gbhxq5R1gBe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725539206; c=relaxed/simple;
	bh=RiyXXEdxTeF6r2/TjbopLC95dGRQJwEktu23cw5zqIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L0D1zMgymkAqY1FU6xlCItUMytAw1+wK99oaVqAFoXuLuWey8IUXNZ+z+kAlN7tyBD2Zcv25OZWP6Op61np2lMdvGmPDKURmU/XX35HEsqQoRpo88K95/yha9RXJX5xIOUHybyaD0R1a+2grxpd/d+bs1fPHFIx2uyQR6FZ0G0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=PaJFUNEw; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=HCsUPSZ2 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1725539204; x=1757075204;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K8wtH04Qg744d9b6oJl2AYoW0C08/7qaOD9mwQJyqKc=;
  b=PaJFUNEw+pHag627UYOadVaSzZMBu2bA9b/SNiW3gP/aZYiywNVsHSxh
   +de1hf5/bNgds+cguRvI9kf+bvxDNOEUu1aidseIEeoQYOqK1u3WkCMGd
   HhkpGz/uG5Tqoh16QLNRXhAOTXcIZ6+CkVFTWbfBX8VII+RfSexW+zpPK
   4KvCHSvc2eE/wgC7q9C4EPIpPxQFhUGMHZ5PQWIajyd5aM7HHiAFTjmkB
   ZoiI0MbCcj8Vg7N5cN94bwDbKvqsnT41XlK3DZhSiQS/qhsl7ZwIocjZg
   iDuV09NKmTnKdLe5qklIKAGMdqWKG4d7nmcdeFtWBjC7puD7gnF013uo4
   Q==;
X-CSE-ConnectionGUID: 8hsUueVWQMKQ3C3NU7oVuA==
X-CSE-MsgGUID: rG5mciRaRDetPLgRbZUHlA==
X-IronPort-AV: E=Sophos;i="6.10,204,1719871200"; 
   d="scan'208";a="38787729"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 05 Sep 2024 14:26:41 +0200
X-CheckPoint: {66D9A381-23-6568578B-E2E34638}
X-MAIL-CPID: 1E08EBBBB2CBD5762ED5A328B4C339EF_3
X-Control-Analysis: str=0001.0A782F17.66D9A382.001B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EDACC161FD0;
	Thu,  5 Sep 2024 14:26:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1725539197;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=K8wtH04Qg744d9b6oJl2AYoW0C08/7qaOD9mwQJyqKc=;
	b=HCsUPSZ298VerucOHmFHfTK80H6tOhFvJwg/CS+f4FWjZ0Fie135lvf5z8miOCCdZ5G+3w
	C5XgbtTpHYCWA5AMvAI3Eo9k3eBgwhQjT0xNyuE8Rh1bjJ3yrGZNAr4KvVoWNd9ZoMy1me
	FqV8QUAZYqS/6VhbW5SIAq2tWF/BJoIrxWR3PVTElcsSmmqK2znjsX1PT3vBjizE+t3edu
	L/tUnLdDQTV3/wBqKUDeR0RHjk0d5lSyoylcMbChKUBW5UQDAQxjR06yBW6HYmH4JAOlWa
	8/imyxK05Sa5ZCnNbmdmYwiCgbxlJWUrjMul/X60W7S8I6vSFmPwqhqrOvjbtQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: Re: [PATCH v2 7/7] arm64: dts: freescale: imx95-19x19-evk: add lpi2c[5, 6] and sub-nodes
Date: Thu, 05 Sep 2024 14:26:36 +0200
Message-ID: <3244531.5fSG56mABF@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240903-imx95-dts-new-v2-7-8ed795d61358@nxp.com>
References: <20240903-imx95-dts-new-v2-0-8ed795d61358@nxp.com> <20240903-imx95-dts-new-v2-7-8ed795d61358@nxp.com>
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

Am Dienstag, 3. September 2024, 09:17:52 CEST schrieb Peng Fan (OSS):
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Add LPI2C[5,6] and the gpio expander subnodes.
> Since we are at here, also add the alias for all lpi2c and gpio nodes.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 69 +++++++++++++++++=
++++++
>  1 file changed, 69 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm=
64/boot/dts/freescale/imx95-19x19-evk.dts
> index 5101cd171e09..6086cb7fa5a0 100644
> --- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> @@ -22,6 +22,19 @@ / {
>  	compatible =3D "fsl,imx95-19x19-evk", "fsl,imx95";
> =20
>  	aliases {
> +		gpio0 =3D &gpio1;
> +		gpio1 =3D &gpio2;
> +		gpio2 =3D &gpio3;
> +		gpio3 =3D &gpio4;
> +		gpio4 =3D &gpio5;
> +		i2c0 =3D &lpi2c1;
> +		i2c1 =3D &lpi2c2;
> +		i2c2 =3D &lpi2c3;
> +		i2c3 =3D &lpi2c4;
> +		i2c4 =3D &lpi2c5;
> +		i2c5 =3D &lpi2c6;
> +		i2c6 =3D &lpi2c7;
> +		i2c7 =3D &lpi2c8;

This seems to be something for the SoC imx95.dtsi, no?

Best regards,
Alexander

>  		mmc0 =3D &usdhc1;
>  		mmc1 =3D &usdhc2;
>  		serial0 =3D &lpuart1;
> @@ -241,6 +254,42 @@ i2c4_gpio_expander_21: gpio@21 {
>  	};
>  };
> =20
> +&lpi2c5 {
> +	clock-frequency =3D <100000>;
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_lpi2c5>;
> +	status =3D "okay";
> +
> +	i2c5_pcal6408: gpio@21 {
> +		compatible =3D "nxp,pcal6408";
> +		reg =3D <0x21>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		vcc-supply =3D <&reg_3p3v>;
> +	};
> +};
> +
> +&lpi2c6 {
> +	clock-frequency =3D <100000>;
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_lpi2c6>;
> +	status =3D "okay";
> +
> +	i2c6_pcal6416: gpio@21 {
> +		compatible =3D "nxp,pcal6416";
> +		reg =3D <0x21>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-controller;
> +		#interrupt-cells =3D <2>;
> +		interrupt-parent =3D <&gpio4>;
> +		interrupts =3D <28 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&pinctrl_pcal6416>;
> +		vcc-supply =3D <&reg_3p3v>;
> +	};
> +};
> +
>  &lpi2c7 {
>  	clock-frequency =3D <1000000>;
>  	pinctrl-names =3D "default";
> @@ -427,6 +476,20 @@ IMX95_PAD_GPIO_IO31__LPI2C4_SCL			0x40000b9e
>  		>;
>  	};
> =20
> +	pinctrl_lpi2c5: lpi2c5grp {
> +		fsl,pins =3D <
> +			IMX95_PAD_GPIO_IO22__LPI2C5_SDA			0x40000b9e
> +			IMX95_PAD_GPIO_IO23__LPI2C5_SCL			0x40000b9e
> +		>;
> +	};
> +
> +	pinctrl_lpi2c6: lpi2c6grp {
> +		fsl,pins =3D <
> +			IMX95_PAD_GPIO_IO02__LPI2C6_SDA			0x40000b9e
> +			IMX95_PAD_GPIO_IO03__LPI2C6_SCL			0x40000b9e
> +		>;
> +	};
> +
>  	pinctrl_lpi2c7: lpi2c7grp {
>  		fsl,pins =3D <
>  			IMX95_PAD_GPIO_IO08__LPI2C7_SDA			0x40000b9e
> @@ -446,6 +509,12 @@ IMX95_PAD_GPIO_IO35__HSIOMIX_TOP_PCIE2_CLKREQ_B		0x4=
000031e
>  		>;
>  	};
> =20
> +	pinctrl_pcal6416: pcal6416grp {
> +		fsl,pins =3D <
> +			IMX95_PAD_CCM_CLKO3__GPIO4_IO_BIT28			0x31e
> +		>;
> +	};
> +
>  	pinctrl_pdm: pdmgrp {
>  		fsl,pins =3D <
>  			IMX95_PAD_PDM_CLK__AONMIX_TOP_PDM_CLK				0x31e
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



