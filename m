Return-Path: <linux-kernel+bounces-377448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B4E9ABF00
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F28551F220FC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 06:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30DB14A0AA;
	Wed, 23 Oct 2024 06:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="EP4qw4nV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Sw3Czixc"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790D113BC11;
	Wed, 23 Oct 2024 06:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729665553; cv=none; b=Af0FGdmrymLoPxI06wjyA5av5sM8wi3ObZLc7z2P7y+RzQleczUdL+ZEhKpGEDBClW25XTcWTnRSMX02vIVf78G63MASlRA63GrVc38PRLhTnDwpZYSYavtpQhRtDjBNFcC6Jcs+kaaIlFEXSyoR0Kvvs7A0cIq2RNUwLzc3GRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729665553; c=relaxed/simple;
	bh=POr1g1VqlX+4xaivNXimN/kFzFTozi2nSedP7QYbjBs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gAIouSRHtWhCCTvd2o09S6I40v/aCUTNryPjfIdPSDKu4pN+dAEpdzou+rLBKTV+An+8R5lpdtgm2/+JpDE8TaL+D5DfMKf7+LvsTF3NiJgqGqzoljHNuBkb4DY1G7QYgly1+/sVm9NmCXeFqZYHwvo7ecy/YPNiBU8u7mEarg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=EP4qw4nV; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Sw3Czixc reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1729665548; x=1761201548;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=kpC1wm6LiYWbeZzmhAhSx38T1JvEqKunCgEsbj3mwVc=;
  b=EP4qw4nVqL5L1jJfhCoPBDO+C1mMsYjwJzGqm8DXrukqfFd/GHsggi2C
   b9ZBmcxaP+6IcVVuuDnYvufZVUdmrGyMvntv2r2dT0rXpZwk5viCqALcd
   EuOrmzGXIs8NiGzvtcD+NkyPwdpPayZevkgOlW1HWK2wX0gM9701WtRfn
   ZcCHvTef0zvwZKEWwAxldsObTfmxA1XNKXYyY8ium1Zhoj55/+WHTO15Y
   q8P9Exzf4TZ/QL3za05s2KUz51rSBN5b0PRoQizRWJqgkpJr/O2WbAmve
   wha82ImUeKKYEb7d+WZaPpmoHqHnnL4sr/j/1S7A8jdahfTchyeA/EsRL
   w==;
X-CSE-ConnectionGUID: uMuOCO7jSDq0cTp/f1tiWA==
X-CSE-MsgGUID: +85O2+aJQIuqXIrYJCKHlw==
X-IronPort-AV: E=Sophos;i="6.11,225,1725314400"; 
   d="scan'208";a="39613512"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 23 Oct 2024 08:38:59 +0200
X-CheckPoint: {67189A03-42-21611FC3-DAD22B0C}
X-MAIL-CPID: 3DF068884F7016846A61C68DC0685252_4
X-Control-Analysis: str=0001.0A682F1E.67189A04.0007,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4CBB01633CA;
	Wed, 23 Oct 2024 08:38:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1729665535; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kpC1wm6LiYWbeZzmhAhSx38T1JvEqKunCgEsbj3mwVc=;
	b=Sw3CzixcaponCg79WEqX0wInmRGaC3pb5U2SC73kcpE2+M+cRWzZMytRtn0jFIPnCphlWR
	6IIODEdXjD9aFtCAjmf5Nj9lr+MdljkYTEkMaaETspiII3SbKkPbwQtvZLMQGBhRWePhq+
	Z9+V9MHlsqSbpqoUIci2ISJRTKUZTvaw4PCw1BLA0l3Ah3stRS+L/tIiA4SKL+oy3EpSrX
	cFJKdshwnqCxuX1P9fadNw09OYqpOCgWNrHh5gvfWlDlOU/BrkmivrD+oX+qNIjcp/WXbL
	vOzuRV5S565ABxtgVxiBSrbNKg2lBWBZ+ChNOnRV8Z2S7ocb1qGpBDws95SNHQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, "open list:TQ SYSTEMS BOARD & DRIVER SUPPORT" <linux@ew.tq-group.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 1/1] arm64: dts: imx8: move samsung, burst-clock-frequency to imx8mn and imx8mm mba8mx board file
Date: Wed, 23 Oct 2024 08:38:53 +0200
Message-ID: <6096263.lOV4Wx5bFT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20241022220429.1281129-1-Frank.Li@nxp.com>
References: <20241022220429.1281129-1-Frank.Li@nxp.com>
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

thanks for the patch.

Am Mittwoch, 23. Oktober 2024, 00:04:29 CEST schrieb Frank Li:
> Move 'samsung,burst-clock-frequency' and 'samsung,esc-clock-frequency'
> properties to i.MX8MN and i.MX8MM mba8mx board file. These properties are
> not applicable to i.MX8MQ MIPI DSI, which uses the compatible string
> 'fsl,imx8mq-nwl-dsi'. The properties are only valid for i.MX8MM and i.MX8=
MN
> devices with the compatible string 'fsl,imx8mm-mipi-dsim', as described in
> samsung,mipi-dsim.yaml.
>=20
> Fix warning:
> /arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx-lvds-tm070jvhg33.dtb=
: dsi@30a00000:
>     Unevaluated properties are not allowed ('ports', 'samsung,burst-clock=
=2Dfrequency', 'samsung,esc-clock-frequency' were unexpected)
>         from schema $id: http://devicetree.org/schemas/display/bridge/nwl=
=2Ddsi.yaml#
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>

> ---
>  arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dts | 5 +++++
>  arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dts | 5 +++++
>  arch/arm64/boot/dts/freescale/mba8mx.dtsi                 | 5 -----
>  3 files changed, 10 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dts b/=
arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dts
> index 01b632b220dc7..b941c8c4f7bb4 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dts
> @@ -75,6 +75,11 @@ expander2: gpio@27 {
>  	};
>  };
> =20
> +&mipi_dsi {
> +	samsung,burst-clock-frequency =3D <891000000>;
> +	samsung,esc-clock-frequency =3D <20000000>;
> +};
> +
>  &pcie_phy {
>  	fsl,refclk-pad-mode =3D <IMX8_PCIE_REFCLK_PAD_INPUT>;
>  	fsl,clkreq-unsupported;
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dts b/=
arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dts
> index 433d8bba44255..dc94d73f7106c 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dts
> @@ -64,6 +64,11 @@ expander2: gpio@27 {
>  	};
>  };
> =20
> +&mipi_dsi {
> +	samsung,burst-clock-frequency =3D <891000000>;
> +	samsung,esc-clock-frequency =3D <20000000>;
> +};
> +
>  &sai3 {
>  	assigned-clocks =3D <&clk IMX8MN_CLK_SAI3>;
>  	assigned-clock-parents =3D <&clk IMX8MN_AUDIO_PLL1_OUT>;
> diff --git a/arch/arm64/boot/dts/freescale/mba8mx.dtsi b/arch/arm64/boot/=
dts/freescale/mba8mx.dtsi
> index 3d26b6981c06f..58e3865c28895 100644
> --- a/arch/arm64/boot/dts/freescale/mba8mx.dtsi
> +++ b/arch/arm64/boot/dts/freescale/mba8mx.dtsi
> @@ -317,11 +317,6 @@ lvds_bridge_out: endpoint {
>  	};
>  };
> =20
> -&mipi_dsi {
> -	samsung,burst-clock-frequency =3D <891000000>;
> -	samsung,esc-clock-frequency =3D <20000000>;
> -};
> -
>  &mipi_dsi_out {
>  	data-lanes =3D <1 2 3 4>;
>  	remote-endpoint =3D <&lvds_bridge_in>;
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



