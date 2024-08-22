Return-Path: <linux-kernel+bounces-296664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCDF95AD6C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96D271F22BF1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95FF139D1B;
	Thu, 22 Aug 2024 06:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="F/MJAXZq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Eb9fOXSN"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172854D8DA;
	Thu, 22 Aug 2024 06:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724308043; cv=none; b=JQz1I8OPo+fwDyLSWzbW3i6X7Nvs9SeadQZwHUBUSGS6as0p3eSAQ2G5+oWo73We1r3YXXryKcdc6nlMa/58hQ3Ijleh/mvzlpue5mWp/7mU8F4s0CuuuLM7WQeN9TJ4ilM3ZK7aiw6VXM3StnzPlv0qhrIlpaHhLct/LmUrZxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724308043; c=relaxed/simple;
	bh=uBGm6Ifs3K8nuFiyt/nYEi6Qqazl+LydZKWkjeJKr6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MNXHB8H7qHCO0TR6DshdfweaLfHJf/50VZl5inm/TQsCh5lm6BEzP8Nx5+oa1wtltLfIBPZiVtcLK4szv1dQXO5HEq37YpMJTJ3XZFdvqTeurAKbcdx9aaalq9o/DMCMNhpySSALf2FFpaqxxxERq8OvH5H0AxIYwuLzIrWSuhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=F/MJAXZq; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Eb9fOXSN reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1724308041; x=1755844041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n6zBJYAkFgr5Yz2Do7fXkQfBwV+eNYvaHOT+eyBCSpc=;
  b=F/MJAXZq38fXqkztaUOEHWCAvIIh0b7TBComGsoU8TuuXSB6Z4s++T80
   9RLmm5VIclW3pDUeJCWajarlPmG/rpphkWEi0xkqLwT+llszm6+bY2BwW
   WSe36w2kz9LRw7bihGoTQy6LkwisND29OJh22Dz24p4LPzhooG3z+TLoo
   /ZorbBVAQChRt+kiN2mziVDJETiOuRdUaUUaYbKOTXXsbA+fWCzCC2yC2
   FSuKzLvPZ8JD5yVEKXUNbLA3sie9JPUYUXMozWHihzG7h8a/zJq7rA4tu
   21ktdbbmNt1u5eL7FKFc5fWKmjxBREdTUikszStcVch66nNHVDcTzwR+f
   A==;
X-CSE-ConnectionGUID: xoPlkXWMSjGw9VYVeR7bQg==
X-CSE-MsgGUID: KN3ap6lHQmugQP2BguzbSA==
X-IronPort-AV: E=Sophos;i="6.10,166,1719871200"; 
   d="scan'208";a="38527705"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 22 Aug 2024 08:27:18 +0200
X-CheckPoint: {66C6DA46-1D-C661815F-E221238E}
X-MAIL-CPID: C27AF2356205DD104C960F97E82F03C1_1
X-Control-Analysis: str=0001.0A782F1B.66C6DA46.010A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 262A01673D1;
	Thu, 22 Aug 2024 08:27:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1724308034;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=n6zBJYAkFgr5Yz2Do7fXkQfBwV+eNYvaHOT+eyBCSpc=;
	b=Eb9fOXSN5WjUFIoc3VatLS+OQ4KUe9AI0XS4PSc/rJylWj5Cl5S6oBmr8Ka0RyQkiXWB1j
	DvIzEnqv9Hakh+sO77QRihJmVEVlxvq8mxd6Y8pklQoSCMuUEmP3oWFkHoSsB+2b/cUPug
	kHD9jyHxNF8foLyrqhNM6svQKJEdEuKMV/5T7E2PobA4sab5iT/8Gd9MvasK66B2V9G9tR
	o9njWcQHkeCDN3YRNeIdrRunRiRj60AhH5vrRwZiNGwpCqxKwT7vdegNHtitCmUZcKVKpI
	AfEcUokvqIwDmCnNBEU0DW3/9qq3u7fpROZ0SqN7CRx4uMRgL5JW8Dzd8StskQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8mp-evk: Add native HDMI output
Date: Thu, 22 Aug 2024 08:27:12 +0200
Message-ID: <3830047.kQq0lBPeGt@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240822033318.753724-1-victor.liu@nxp.com>
References: <20240822033318.753724-1-victor.liu@nxp.com>
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

Am Donnerstag, 22. August 2024, 05:33:18 CEST schrieb Liu Ying:
> J17 on i.MX8mp EVK base board is a HDMI type A connector.
> It connects with i.MX8mp HDMI PHY.  Add support for it.
>=20
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 46 ++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/bo=
ot/dts/freescale/imx8mp-evk.dts
> index 938347704136..f118fe8ab5ac 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> @@ -56,6 +56,18 @@ memory@40000000 {
>  		      <0x1 0x00000000 0 0xc0000000>;
>  	};
> =20
> +	native-hdmi-connector {

Is there a non-nativ HDMI connector? If not this is somewhat misleading.

> +		compatible =3D "hdmi-connector";
> +		label =3D "HDMI OUT";
> +		type =3D "a";
> +
> +		port {
> +			hdmi_out: endpoint {

That's an input port of the HDMI connector. It should be called hdmi_in or =
similar.
Right now it's connecting 'hdmi_out' and 'hdmi_tx_out' which looks confusin=
g.

Best regards,
Alexander

> +				remote-endpoint =3D <&hdmi_tx_out>;
> +			};
> +		};
> +	};
> +
>  	pcie0_refclk: pcie0-refclk {
>  		compatible =3D "fixed-clock";
>  		#clock-cells =3D <0>;
> @@ -408,6 +420,28 @@ &flexcan2 {
>  	status =3D "disabled";/* can2 pin conflict with pdm */
>  };
> =20
> +&hdmi_pvi {
> +	status =3D "okay";
> +};
> +
> +&hdmi_tx {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_hdmi>;
> +	status =3D "okay";
> +
> +	ports {
> +		port@1 {
> +			hdmi_tx_out: endpoint {
> +				remote-endpoint =3D <&hdmi_out>;
> +			};
> +		};
> +	};
> +};
> +
> +&hdmi_tx_phy {
> +	status =3D "okay";
> +};
> +
>  &i2c1 {
>  	clock-frequency =3D <400000>;
>  	pinctrl-names =3D "default";
> @@ -604,6 +638,10 @@ &lcdif1 {
>  	status =3D "okay";
>  };
> =20
> +&lcdif3 {
> +	status =3D "okay";
> +};
> +
>  &micfil {
>  	#sound-dai-cells =3D <0>;
>  	pinctrl-names =3D "default";
> @@ -858,6 +896,14 @@ MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16	0x140
>  		>;
>  	};
> =20
> +	pinctrl_hdmi: hdmigrp {
> +		fsl,pins =3D <
> +			MX8MP_IOMUXC_HDMI_DDC_SCL__HDMIMIX_HDMI_SCL	0x1c2
> +			MX8MP_IOMUXC_HDMI_DDC_SDA__HDMIMIX_HDMI_SDA	0x1c2
> +			MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC		0x10
> +		>;
> +	};
> +
>  	pinctrl_hog: hoggrp {
>  		fsl,pins =3D <
>  			MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD		0x40000010
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



