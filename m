Return-Path: <linux-kernel+bounces-205447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3BA8FFC17
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C13EB2861D0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A400B14F9CB;
	Fri,  7 Jun 2024 06:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="JTvv5PW0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="N7apqiiH"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF9F4204F;
	Fri,  7 Jun 2024 06:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717741072; cv=none; b=uCE6bl1omp+zeXOi7ErSZcH1e6k1WsGOr4GOI6svu1YnU/yH7lma77H41Ed4gPe5a4IAwnrmEKJ28QEeXcJSO55XemCJgqYQEVpjlCdhfRSAs/0grfGONMXD6huCB6p3kwHRGsOuIQjzQCwFp7VIaJDrfWoEAZkSnl3Vh8evQQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717741072; c=relaxed/simple;
	bh=2JgvIgjIquEs9i/eKxSi+AJCxrhitWDuibgNtQ7ROTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UtuHlWLJl6sYPFT4BINozsYkrsn/k/NTVhp37ZS9gjL39xVE3R3jJkLykqy7k72O6SvHVJ3hqVdd/j4XJZyQBvYgZ3V6dG0QfvnpZzE/d3vFOO92/8we6k9fRK6aZymfuA7DbaWYa30Mf8DYbAVTuR4v6mDtmH0KlmGsdK8ds04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=JTvv5PW0; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=N7apqiiH reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1717741068; x=1749277068;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jgjECblWOM2Wl+EWq3+KIZ+Ee/nKanxwL2aIXhzXS1s=;
  b=JTvv5PW0TqZzwcsYA03VjSkL7KS1VdnrU9ThutnluK1tsb8cwcWDU3D8
   otYM+BrN6VdNWEnjW3rOJoLD33OI6+MeIa4ZEH/HDSYV5NgRPWeRYFxZw
   uZmKUHT9mmsY1Per1GpqLgJFYDnhTre3tlgCpV25oS3M9FeT0X8cnXwkN
   3UbcYeXH6hHLToYRaKea24CXEp+lk7ffX1reubw04ETPvwmNTuW0cAV9A
   qUghq7d8QzGBHcZ7dy1V5jRtmZf91fGRgulIcJy+OSkoOOsA1w8IeSbOu
   DYpDxpAYLoMBExGxD/xnQiONbPaeeIyPjTm+bhR4ZyDa1pDP2DCDXjuyY
   w==;
X-CSE-ConnectionGUID: BR4pfoGUT2ihljEi9lw8/A==
X-CSE-MsgGUID: L+D5Wu4uQxypwVDEyTxNmg==
X-IronPort-AV: E=Sophos;i="6.08,220,1712613600"; 
   d="scan'208";a="37273910"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 07 Jun 2024 08:17:45 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 25A76175636;
	Fri,  7 Jun 2024 08:17:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1717741061;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jgjECblWOM2Wl+EWq3+KIZ+Ee/nKanxwL2aIXhzXS1s=;
	b=N7apqiiH8hepl+ymp4Vg2VxhP0qh6Cdl9lweSbvU+CsWxL2+PI8P42xt3ltk0hOnBD4HBa
	0NXtRyvkW6JvAWAzo6U2fO3kH5PQduMrSNv1tXiwrBM51BJJfNlErvQOK4r/XXBfmw5/AP
	S3H1LabZ7YHryv1K5WSv6Y76Jge7DJxyD4SmJrj0phoDIfdHZ2N4tz0rGqPQMECwwDzGWh
	0iSBiN/CttYelvDD8tpAQ660dDTrNp7a+aKicjjhMdbaqmn2I42EdvM/nQQFzysrOpAKEs
	LkSgwOhI442ndKO6GdgC0zM0DELgmb9Jbpk7BkvhA3EPPOq4TzQqKzIWAsOmOQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>, linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 5/7] arm64: dts: imx8qm-mek: add i2c in mipi[0,1] subsystem
Date: Fri, 07 Jun 2024 08:17:39 +0200
Message-ID: <13531926.dW097sEU6C@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240606-imx8qm-dts-usb-v1-5-565721b64f25@nxp.com>
References: <20240606-imx8qm-dts-usb-v1-0-565721b64f25@nxp.com> <20240606-imx8qm-dts-usb-v1-5-565721b64f25@nxp.com>
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

Am Donnerstag, 6. Juni 2024, 20:46:59 CEST schrieb Frank Li:
> Add i2c node in mipi[0,1] subystem for imx8qm-mek.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 34 ++++++++++++++++++++++=
++++++
>  1 file changed, 34 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/bo=
ot/dts/freescale/imx8qm-mek.dts
> index 80cb834d56bc2..cdcd5993cc69f 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> @@ -388,6 +388,24 @@ &i2c1_lvds1 {
>  	status =3D "okay";
>  };
> =20
> +&i2c0_mipi0 {
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;

These two properties should be part of the .dtsi.

> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_mipi0_lpi2c0>;
> +	clock-frequency =3D <100000>;
> +	status =3D "okay";
> +};
> +
> +&i2c0_mipi1 {
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;

These two properties should be part of the .dtsi.

Best regards,
Alexander

> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_mipi1_lpi2c0>;
> +	clock-frequency =3D <100000>;
> +	status =3D "okay";
> +};
> +
>  &flexcan1 {
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&pinctrl_flexcan1>;
> @@ -660,6 +678,22 @@ IMX8QM_SPI2_CS0_LSIO_GPIO3_IO10		0x21
>  		>;
>  	};
> =20
> +	pinctrl_mipi0_lpi2c0: mipi0_lpi2c0grp {
> +		fsl,pins =3D <
> +			IMX8QM_MIPI_DSI0_I2C0_SCL_MIPI_DSI0_I2C0_SCL      0xc6000020
> +			IMX8QM_MIPI_DSI0_I2C0_SDA_MIPI_DSI0_I2C0_SDA      0xc6000020
> +			IMX8QM_MIPI_DSI0_GPIO0_01_LSIO_GPIO1_IO19         0x00000020
> +		>;
> +	};
> +
> +	pinctrl_mipi1_lpi2c0: mipi1_lpi2c0grp {
> +		fsl,pins =3D <
> +			IMX8QM_MIPI_DSI1_I2C0_SCL_MIPI_DSI1_I2C0_SCL      0xc6000020
> +			IMX8QM_MIPI_DSI1_I2C0_SDA_MIPI_DSI1_I2C0_SDA      0xc6000020
> +			IMX8QM_MIPI_DSI1_GPIO0_01_LSIO_GPIO1_IO23         0x00000020
> +		>;
> +	};
> +
>  	pinctrl_flexspi0: flexspi0grp {
>  		fsl,pins =3D <
>  			IMX8QM_QSPI0A_DATA0_LSIO_QSPI0A_DATA0     0x06000021
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



