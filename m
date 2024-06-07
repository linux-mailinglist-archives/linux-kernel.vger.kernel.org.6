Return-Path: <linux-kernel+bounces-205449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AFF8FFC23
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AD691C21263
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87674CB36;
	Fri,  7 Jun 2024 06:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="kXpMafWp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="f5anELor"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4A014F9E1;
	Fri,  7 Jun 2024 06:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717741209; cv=none; b=iV2pNKQ9/kS7gH8njH952gvn2mJ7h1C4y3wy4D5G2l393R53DcTE1u/45ndtZku3LF/rvRETTxQbp+Hz+jElJpZ2jxA38wBqLR7ODEZc35G2+mqGOo6/gl4lsrdhI07p17poQhbR6Cfl/1MiFVDpPMD/fsphc8cNeQJG9YSpy7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717741209; c=relaxed/simple;
	bh=lCB1MCVE67+mUlOQuF+3QwdLl8t7rqouElRMhKyzA/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uJ+DA+IA5LgZr1LQv8M48xv9NO4f7Ok36XqrFyhpQHeI67W60FIXcjOKfF0sKKh7QYnvVQYJnLmeQQbxLPTySpoUXdrCFZM5bxCzBpqhKIJlCTWUb9fPQnacomfJwXkH4tuZazOhQBg2BLfgoOD9/0r9R7mD4Vgbm15zktkLJXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=kXpMafWp; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=f5anELor reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1717741207; x=1749277207;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TYUiCU86NzvfIZ5FU+rR7VsLlWDOutgcrXN8bRA2fvk=;
  b=kXpMafWpgxN/4GJkliS7WY7mLWv5wxcPbp11RWQCkglpOvYcWybE9aKH
   rJLK8VD16yfGT2aWcbBkVzioRoS038A4b5S59ybXfweABlkLEvbDaqVsE
   6uzm97iJ4Vt6oVxxMMedHHNbnPLF+75K4NByp3xuQArCzQHVET/g65PMH
   7L1V60HW7uTV9QTmocV2rDrm4XVNt608FG26ts8kazYt5nvSzqApaDhFu
   cKB2z3sOzZf9yjl1BTjS9dmomNcc++lHc9UP/PmKoGXaqotUE4AgclMrY
   vkw+GueE36wS1ReyMX7RpVMkxhJHV3ddLSAZbiNmAePcNtlsKwTI0uMiW
   w==;
X-CSE-ConnectionGUID: UyQ9L9WXTu6nFkO0h9GhXw==
X-CSE-MsgGUID: ha2elpDeTF2R3K8bNcdWjQ==
X-IronPort-AV: E=Sophos;i="6.08,220,1712613600"; 
   d="scan'208";a="37273943"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 07 Jun 2024 08:20:04 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EFA42175375;
	Fri,  7 Jun 2024 08:19:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1717741200;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TYUiCU86NzvfIZ5FU+rR7VsLlWDOutgcrXN8bRA2fvk=;
	b=f5anELorGarr2XIX+Hic2CSfVCl9z5f8HC0FpGYN0ATmNwP83B4w62EGfBLXhHQJDVBEr6
	wO1yx0i5oEPho3OpWO6u/0gcf6HEW0TYx7T4aZln5Hw+0740SsrYIJN0pjOAcwUrsF9dDC
	VS0Vssab0lmnjKDDvajoAJMYZMnRzC1D7ex/HA498an0eCa7xQvkbmDiIIhicvQkr0S1Ug
	fz9ObpsKavwEQgsjHG1tl2xv0huAGlYZb8ed43u784DTOuvZSDxgLo3u8LNGUlGURX++GU
	iC981xDxmofKa3/2a8Ecve4S/Y8DG4HgAvcTPMv3iy2hwdxCnOYfomQcikDQog==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>, linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 4/7] arm64: dts: imx8qm-mek: add pwm and i2c in lvds subsystem
Date: Fri, 07 Jun 2024 08:19:59 +0200
Message-ID: <2116653.KlZ2vcFHjT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240606-imx8qm-dts-usb-v1-4-565721b64f25@nxp.com>
References: <20240606-imx8qm-dts-usb-v1-0-565721b64f25@nxp.com> <20240606-imx8qm-dts-usb-v1-4-565721b64f25@nxp.com>
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

Am Donnerstag, 6. Juni 2024, 20:46:58 CEST schrieb Frank Li:
> Add pwm[0,1] and i2c[0,1] in lvds subsystem.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 92 ++++++++++++++++++++++=
++++++
>  1 file changed, 92 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/bo=
ot/dts/freescale/imx8qm-mek.dts
> index dbd478af2e474..80cb834d56bc2 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> @@ -93,6 +93,42 @@ rsc_table1: memory@901ff000 {
>  		};
>  	};
> =20
> +	lvds_backlight0: backlight-lvds0 {
> +		compatible =3D "pwm-backlight";
> +		pwms =3D <&pwm_lvds0 0 100000 0>;
> +
> +		brightness-levels =3D < 0  1  2  3  4  5  6  7  8  9
> +				     10 11 12 13 14 15 16 17 18 19
> +				     20 21 22 23 24 25 26 27 28 29
> +				     30 31 32 33 34 35 36 37 38 39
> +				     40 41 42 43 44 45 46 47 48 49
> +				     50 51 52 53 54 55 56 57 58 59
> +				     60 61 62 63 64 65 66 67 68 69
> +				     70 71 72 73 74 75 76 77 78 79
> +				     80 81 82 83 84 85 86 87 88 89
> +				     90 91 92 93 94 95 96 97 98 99
> +				    100>;
> +		default-brightness-level =3D <80>;
> +	};
> +
> +	lvds_backlight1: backlight-lvds1 {
> +		compatible =3D "pwm-backlight";
> +		pwms =3D <&pwm_lvds1 0 100000 0>;
> +
> +		brightness-levels =3D < 0  1  2  3  4  5  6  7  8  9
> +				     10 11 12 13 14 15 16 17 18 19
> +				     20 21 22 23 24 25 26 27 28 29
> +				     30 31 32 33 34 35 36 37 38 39
> +				     40 41 42 43 44 45 46 47 48 49
> +				     50 51 52 53 54 55 56 57 58 59
> +				     60 61 62 63 64 65 66 67 68 69
> +				     70 71 72 73 74 75 76 77 78 79
> +				     80 81 82 83 84 85 86 87 88 89
> +				     90 91 92 93 94 95 96 97 98 99
> +				    100>;
> +		default-brightness-level =3D <80>;
> +	};
> +
>  	reg_usdhc2_vmmc: usdhc2-vmmc {
>  		compatible =3D "regulator-fixed";
>  		regulator-name =3D "SD1_SPWR";
> @@ -334,6 +370,24 @@ wm8960: audio-codec@1a {
>  	};
>  };
> =20
> +&i2c1_lvds0 {
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;

These two properties should be part of the .dtsi.

> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_lvds0_lpi2c1>;
> +	clock-frequency =3D <100000>;
> +	status =3D "okay";
> +};
> +
> +&i2c1_lvds1 {
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;

These two properties should be part of the .dtsi.

Best regards,
Alexander

> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_lvds1_lpi2c1>;
> +	clock-frequency =3D <100000>;
> +	status =3D "okay";
> +};
> +
>  &flexcan1 {
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&pinctrl_flexcan1>;
> @@ -449,6 +503,18 @@ &fec2 {
>  	status =3D "okay";
>  };
> =20
> +&pwm_lvds0 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_pwm_lvds0>;
> +	status =3D "okay";
> +};
> +
> +&pwm_lvds1 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_pwm_lvds1>;
> +	status =3D "okay";
> +};
> +
>  &usdhc1 {
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&pinctrl_usdhc1>;
> @@ -675,6 +741,32 @@ IMX8QM_M41_GPIO0_01_DMA_UART3_TX			0x06000020
>  		>;
>  	};
> =20
> +	pinctrl_lvds0_lpi2c1: lvds0lpi2c1grp {
> +		fsl,pins =3D <
> +			IMX8QM_LVDS0_I2C1_SCL_LVDS0_I2C1_SCL	0xc600004c
> +			IMX8QM_LVDS0_I2C1_SDA_LVDS0_I2C1_SDA	0xc600004c
> +		>;
> +	};
> +
> +	pinctrl_lvds1_lpi2c1: lvds1lpi2c1grp {
> +		fsl,pins =3D <
> +			IMX8QM_LVDS1_I2C1_SCL_LVDS1_I2C1_SCL	0xc600004c
> +			IMX8QM_LVDS1_I2C1_SDA_LVDS1_I2C1_SDA	0xc600004c
> +		>;
> +	};
> +
> +	pinctrl_pwm_lvds0: pwmlvds0grp {
> +		fsl,pins =3D <
> +			IMX8QM_LVDS0_GPIO00_LVDS0_PWM0_OUT		0x00000020
> +		>;
> +	};
> +
> +	pinctrl_pwm_lvds1: pwmlvds1grp {
> +		fsl,pins =3D <
> +			IMX8QM_LVDS1_GPIO00_LVDS1_PWM0_OUT		0x00000020
> +		>;
> +	};
> +
>  	pinctrl_sai0: sai0grp {
>  		fsl,pins =3D <
>  			IMX8QM_SPI0_CS1_AUD_SAI0_TXC				0x0600004c
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



