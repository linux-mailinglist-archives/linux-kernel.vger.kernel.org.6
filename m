Return-Path: <linux-kernel+bounces-294948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A204B9594AF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 08:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D143B23EFF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 06:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2A516EB42;
	Wed, 21 Aug 2024 06:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="QqVosuxT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="nTnSnz19"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15EC79CD;
	Wed, 21 Aug 2024 06:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724221945; cv=none; b=DtoHw8nmZo8l/Mi5qCa5GXPrkIFlgkIy2uyuVUVMWhSWR69Qi2UEkMUlBt0vOjxsc3Oe23kBlC9jZSylRU/9F2TXmgtSG4llnixL4gCj+qGz7S9HOGxRCTz844+r+spY/EoZz7k6GTFK6a12HC9FXvyJBoT9Oo6QMjBpAAiohyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724221945; c=relaxed/simple;
	bh=ubO7FYYGu3Hp/dnVJdRu7ROouFe6eV53mIzjSwW6CZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MP8FzdeCr70Jxi+k1ChF2JQ888Aa9fYtgPeIWEIOqWWshz6W+ftOf2gCmKU9Jyd1BraJcCx61sOsturgyCD2vxKGPXIEFPNTyacUicj2USdiFTTQVaqcGQ5/ZhknNG2kopQT2ZtxGQBVHr+YUfqyFzcInKHuVBxGcl1pdqToK/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=QqVosuxT; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=nTnSnz19 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1724221942; x=1755757942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4/ehOcDT1TfhJyhpORScIzM0CaaeNczPyVM302So5TI=;
  b=QqVosuxTRq0JlyBlkX11oahtC9j29rdIEkWh6C1ShxKhEtWrkCcP8BE1
   TyjrUjLtWYUtcANbUUHp5qPS/r+sxbK6W9hsaH3ATeBn8l4E/Rx9uJtUo
   ObMzWko4x7a3j7V/SyLdJkkP9J0f4vIh3xU6ndD1w7jaa5ZFWIktYqk8Q
   8BaAzz+YoS1nkp1PY4sN79Gv1BKMxIZFoAo6d1FscWG9zTBSl+SYp2x42
   ZjKxN3LPdX2DC0SMWh47zmg0SGoXQRBI9xEhipckvU7wdnrna+nnkSwJU
   NYFMD2whxwjb7qXjO2+4IdNQtKdViZlzcCWZE99+d3EPJrwxtS6DQ26an
   g==;
X-CSE-ConnectionGUID: jYq/U/DzQz2tnwO4WwI6Wg==
X-CSE-MsgGUID: jcd+9XZYSe2xgqKmArv8Vg==
X-IronPort-AV: E=Sophos;i="6.10,164,1719871200"; 
   d="scan'208";a="38503970"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 21 Aug 2024 08:32:13 +0200
X-CheckPoint: {66C589ED-18-6568578B-E2E34638}
X-MAIL-CPID: 771695C08205E4FCECCC211BFF4AE35B_3
X-Control-Analysis: str=0001.0A782F19.66C589ED.011B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7D24D163E9E;
	Wed, 21 Aug 2024 08:32:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1724221929;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4/ehOcDT1TfhJyhpORScIzM0CaaeNczPyVM302So5TI=;
	b=nTnSnz19vLHbPEireDaDtlEzHdquqGghDGI4f7KavXjgRwzWigHRfHs0UhRtnsAr30ydjU
	ogrR4qrzuRTHj93/05xMfXWzWzxshs7TscrIm2DtjAtnUKMD2EqoMWhROxgL2a3Yi6cF0w
	SKCmJPMfQo5udUNXn0Hhap0CDKnzpVDQT8INnpUyBK3uXAg/9c0ZkMU7MtorhA4QeLwffn
	EUib8jLUG3Uc026ST8cHS+EFMtomVs9DFZyAUofvOOH/aADtNmRleIQFeWE0zu1Ao534Q1
	UDr+psuNUDE1Vc+1rNmvq8qsZq7AnhBJhjJFPLl62gpK10mXvXP+c/BxSLGjBg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: Re: [PATCH 1/3] arm64: dts: freescale: imx93-11x11-evk: enable fsl, ext-reset-output for wdog3
Date: Wed, 21 Aug 2024 08:32:06 +0200
Message-ID: <2954135.e9J7NaK4W3@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240820-imx93-wdog-v1-1-5dafda0d4319@nxp.com>
References: <20240820-imx93-wdog-v1-0-5dafda0d4319@nxp.com> <20240820-imx93-wdog-v1-1-5dafda0d4319@nxp.com>
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

Am Dienstag, 20. August 2024, 17:02:39 CEST schrieb Peng Fan (OSS):
> From: Peng Fan <peng.fan@nxp.com>
>=20
> The WDOG_B is connected to external PMIC, so set "fsl,ext-reset-output"
> to enable triggering PMIC reset.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm=
64/boot/dts/freescale/imx93-11x11-evk.dts
> index 60eb64761392..fb93ae654a2b 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> @@ -485,6 +485,7 @@ &usdhc2 {
>  };
> =20
>  &wdog3 {
> +	fsl,ext-reset-output;

The MX93_PAD_WDOG_ANY__WDOG1_WDOG_ANY pinctrl is missing, no?
Same for the other boards.

Best regards,
Alexander

>  	status =3D "okay";
>  };
> =20
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



