Return-Path: <linux-kernel+bounces-218657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D50590C35A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 08:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74F691C22A63
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 06:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AAF1E53A;
	Tue, 18 Jun 2024 06:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="OLIdqPLF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="aay66l+r"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9349E1D9535;
	Tue, 18 Jun 2024 06:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718691351; cv=none; b=BURXV24yCpT4n6uNp136yheHgo2uz4/zM1sAvY0lxvUXIAjMl6QJGTZkNebIacK8YuY4bNqYjz5HSEJyG6SUwQDDOSTVssO6AhGsqcM12fgeOorVVIUdEN57AUcjw8WSCFu3qGdG8wquYhyXE0G+T8s9FPARLu/+knORjFpZloU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718691351; c=relaxed/simple;
	bh=NYu7HmNaUXvKxLQBShfSo7YY2rt3DR0kHagqqDYAtfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fyoRZgHQh7BBtjSTZEwIhYv17lADhQKrxuqAUg1pDZtUonBXNS2nzPquX/6KfOXB71vOWhQ04V8D5sowvO7esOZpaPrqYwbsCj9UxEgxfJrZblbqD4TAfYdOlbcuEHspTXV0C1jYa917AISEuntXOb5zsEBjOachtjv4RbS1+d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=OLIdqPLF; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=aay66l+r reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1718691348; x=1750227348;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j0CT5+u8v+Tt5ly5F8d6KLAmQFfq4ACni1Ma8+3IMes=;
  b=OLIdqPLFRueluqZ5KhR3+ILqcQpfjTHUsxaEs38xb/IxhSquT43+cY8i
   nyovEDkGpd/IaEsFQvT0SXFJAIrDkT/N9yFBqg7B4h+hMbARakr/tqNPe
   7qEnAMfVlRb/p7kkVHWRq6EEd8VqzpOuk63NCCqqALb8UkeozOC0EgUI7
   lcvJgATPB2YawH3EXsvCdDASYlKGQlkUY92BkemH6z3kfUEJ3MF3N3dbM
   a6tPaE73Yy7sMyG/UfiF5uMVyelEzA2Sdh8xKmqsnYi7/D/2VamxbWfI5
   MC04RT75uo7vE0P8cdTNHscZIRhOlr5K02p5cTD+wguM7TSod2idnY2Xt
   Q==;
X-CSE-ConnectionGUID: uSJ4tK8CTSuWQAuRdEbI8A==
X-CSE-MsgGUID: h3c3S3bTTlqWutSMcG/7qw==
X-IronPort-AV: E=Sophos;i="6.08,246,1712613600"; 
   d="scan'208";a="37439566"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 18 Jun 2024 08:15:45 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 70990165E7E;
	Tue, 18 Jun 2024 08:15:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1718691340;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=j0CT5+u8v+Tt5ly5F8d6KLAmQFfq4ACni1Ma8+3IMes=;
	b=aay66l+rtmKWsmSR8PlojeyltfrnzJEs4Ojsh0PwJU1Qw0Hd5biwloAj5kYTFP2wfInCif
	BSBRBzYq3NOP+iO3toNNNhJYaV3VHGieJsAvCWePli5t/fhKDFz3A5oj3sZRgVIreHYBxT
	E6esHFpiFfZyenRu+WLY5jjs/ksYP5Cqng1DVM8nbpIn+asucWmCziml3AG762nLFoaMqf
	CpXiTMOZ7D/pYCG7+UhbxxcIk0/HU+X/Y5lJ0HEGhX5N4Ys6Vm7jScokiYloabfnjoD96h
	WKpPjzf/f/cKL7XSca6KYLQZ2e9Wfp9Zfwiom7UOneetaC6M6rR2zjn8LyNrBA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: linux-arm-kernel@lists.infradead.org, Adam Ford <aford173@gmail.com>
Cc: aford@beaconembedded.com, marex@denx.de, Adam Ford <aford173@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, Marco Felsch <m.felsch@pengutronix.de>, devicetree@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mp: Fix pgc_mlmix location
Date: Tue, 18 Jun 2024 08:15:41 +0200
Message-ID: <5814494.DvuYhMxLoT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240617223952.1899201-1-aford173@gmail.com>
References: <20240617223952.1899201-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi Adam,

Am Dienstag, 18. Juni 2024, 00:39:51 CEST schrieb Adam Ford:
> The pgc_mlmix shows a power-domain@24, but the reg value is
> IMX8MP_POWER_DOMAIN_MLMIX which is set to 4.
>=20
> The stuff after the @ symbol should match the stuff referenced
> by 'reg' so reorder the pgc_mlmix so it to appear as power-domain@4.

Taking a look this mismatch seems to be also true for:
* IMX8MP_POWER_DOMAIN_VPUMIX
* IMX8MP_POWER_DOMAIN_VPU_G1
* IMX8MP_POWER_DOMAIN_VPU_G2
* IMX8MP_POWER_DOMAIN_VPU_VC8000E

Would you mind fixing them as well?

Despite that, for this patch:
Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Thanks and best regards,
Alexander

> Fixes: 834464c8504c ("arm64: dts: imx8mp: add mlmix power domain")
> Fixes: 4bedc468b725 ("arm64: dts: imx8mp: Add NPU Node")
>=20
> Signed-off-by: Adam Ford <aford173@gmail.com>
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/=
dts/freescale/imx8mp.dtsi
> index b92abb5a5c53..3576d2b89b43 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -789,6 +789,23 @@ pgc_usb2_phy: power-domain@3 {
>  						reg =3D <IMX8MP_POWER_DOMAIN_USB2_PHY>;
>  					};
> =20
> +					pgc_mlmix: power-domain@4 {
> +						#power-domain-cells =3D <0>;
> +						reg =3D <IMX8MP_POWER_DOMAIN_MLMIX>;
> +						clocks =3D <&clk IMX8MP_CLK_ML_AXI>,
> +							 <&clk IMX8MP_CLK_ML_AHB>,
> +							 <&clk IMX8MP_CLK_NPU_ROOT>;
> +						assigned-clocks =3D <&clk IMX8MP_CLK_ML_CORE>,
> +								  <&clk IMX8MP_CLK_ML_AXI>,
> +								  <&clk IMX8MP_CLK_ML_AHB>;
> +						assigned-clock-parents =3D <&clk IMX8MP_SYS_PLL1_800M>,
> +									 <&clk IMX8MP_SYS_PLL1_800M>,
> +									 <&clk IMX8MP_SYS_PLL1_800M>;
> +						assigned-clock-rates =3D <800000000>,
> +								       <800000000>,
> +								       <300000000>;
> +					};
> +
>  					pgc_audio: power-domain@5 {
>  						#power-domain-cells =3D <0>;
>  						reg =3D <IMX8MP_POWER_DOMAIN_AUDIOMIX>;
> @@ -900,23 +917,6 @@ pgc_vpu_vc8000e: power-domain@22 {
>  						reg =3D <IMX8MP_POWER_DOMAIN_VPU_VC8000E>;
>  						clocks =3D <&clk IMX8MP_CLK_VPU_VC8KE_ROOT>;
>  					};
> -
> -					pgc_mlmix: power-domain@24 {
> -						#power-domain-cells =3D <0>;
> -						reg =3D <IMX8MP_POWER_DOMAIN_MLMIX>;
> -						clocks =3D <&clk IMX8MP_CLK_ML_AXI>,
> -							 <&clk IMX8MP_CLK_ML_AHB>,
> -							 <&clk IMX8MP_CLK_NPU_ROOT>;
> -						assigned-clocks =3D <&clk IMX8MP_CLK_ML_CORE>,
> -								  <&clk IMX8MP_CLK_ML_AXI>,
> -								  <&clk IMX8MP_CLK_ML_AHB>;
> -						assigned-clock-parents =3D <&clk IMX8MP_SYS_PLL1_800M>,
> -									 <&clk IMX8MP_SYS_PLL1_800M>,
> -									 <&clk IMX8MP_SYS_PLL1_800M>;
> -						assigned-clock-rates =3D <800000000>,
> -								       <800000000>,
> -								       <300000000>;
> -					};
>  				};
>  			};
>  		};
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



