Return-Path: <linux-kernel+bounces-277356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E9E949FAB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 847291C21488
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 06:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEFD19DF8B;
	Wed,  7 Aug 2024 06:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="AljFx5ES";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="L5baFq61"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B7E19D8A3;
	Wed,  7 Aug 2024 06:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723011008; cv=none; b=EpLCGIlJH9N+juW40oeigOA2NYktyxMxB/cQz92D1FD4bFapvcnMWQF6sLYgtCZeWp4ClHtZxFPlGfmDrUiDMxHR38OV90iW9aJfN9ofZ4890r0DYW3RqkwBKmhvKvqE+3oScq/ksJm6eTsbmUdUOQ4fSsyJsAN6XoJgrfby+8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723011008; c=relaxed/simple;
	bh=xYUq4mJv1M0iJFlQw49Ia19hd83rz3/8znS2az1pk+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iOHrS0MmmK7qXhTvqF1uxa3EYp6tQNj2DIS76WTm3VpYVM3Jci9OKXkUtJaMexYp7WOgrs64uOIdyxnwXwo4rk8dQ+njO9vhoayzCvXFnTlGfWMRc+ma1holnDe1cHVVa8YIeORr45lypbHbqubiH1SXSfTEWjzNeF7iUVma2ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=AljFx5ES; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=L5baFq61 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723011004; x=1754547004;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ri6YVzAWj9lpW/HRkVGmES5Sunj5DDspxGsXPucqkdk=;
  b=AljFx5ESmIa5BoAoV4V6/7wsIFDhezNO4gKJrXoXvwRxmpoSSkGuefms
   SwXTOrrK23mMiFO4ReHGmESSnDpV1jevbA38dWvVbGpHlB+TefBC4U/bA
   Km9rSQkJ5C+hTjrGdkNm28BBVQO0AV7/lGizTYuILN+D01vS9ziv2O726
   ATua6PN9HhtYCv+1ytpYrRIYfvB+Bt5kGk43Mu96L+VXowKMe2eDzBq/x
   33K1hUtvbiY+QL9gPDZHueUi1n6bTaO5FFlnUPLTEQuN+kYVNOIlfl01G
   fo8T9eLFNAueS+IfALEXB0vvPIUb8cwfcU5oim+QXRFTwZXGN1Bbnp+YE
   Q==;
X-CSE-ConnectionGUID: GJUOMnAjTXGOzXlPkvTTJg==
X-CSE-MsgGUID: j8ctx7BhTm+2MgvhlHS0ig==
X-IronPort-AV: E=Sophos;i="6.09,269,1716242400"; 
   d="scan'208";a="38281790"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 07 Aug 2024 08:09:55 +0200
X-CheckPoint: {66B30FB3-32-CFE9415D-C7159436}
X-MAIL-CPID: A584B594B3F10A6F26740B41B93F4F54_1
X-Control-Analysis: str=0001.0A782F1F.66B30FB4.0021,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5692A16362E;
	Wed,  7 Aug 2024 08:09:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723010991;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Ri6YVzAWj9lpW/HRkVGmES5Sunj5DDspxGsXPucqkdk=;
	b=L5baFq617Qqdkkg5X0otVD1ulhjOxU3qcTcCuCMrXrnvCzoytJvsL0qyGyCSYVvHpm74cG
	zzLVisQRyJ4dGMx8o9Dne0hjr02x7itvXVuqLMsmMe0qGoe/U0rptYNkkjdYLSQWXDOvNQ
	oH/W3Y7KIE408X+wqxq5tHSb6jAYQFfDoKRXSnCtfZw2dqU2KqHRvLE5MY83Rl/hJUT/f2
	OvWfhElj8WiOhYdAJMCY+Th1UyxDuVqG5hslH1cJ5mvnx6dGfpl6ufmQrdAyFLpNj1JkHF
	HLWsQFkYK/Pn8CzMhqHvN6PS3ATjP6hSiKXVmgacH16BMKupURA/6c6VK65lwg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 9/9] arm64: dts: imx8mm-phygate: fix typo pinctrcl-0
Date: Wed, 07 Aug 2024 08:09:52 +0200
Message-ID: <2744927.mvXUDI8C0e@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240805-fsl_dts_warning-v1-9-055653dd5c96@nxp.com>
References: <20240805-fsl_dts_warning-v1-0-055653dd5c96@nxp.com> <20240805-fsl_dts_warning-v1-9-055653dd5c96@nxp.com>
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

Am Montag, 5. August 2024, 17:49:51 CEST schrieb Frank Li:
> Fix typo pinctrcl-0 with pinctrl-0.
> Fix below warning:
>=20
> arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtb: gpi=
o@30220000: 'pinctrl-0' is a dependency of 'pinctrl-names'
>         from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-co=
nsumer.yaml#
> arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtb: uar=
t4_rs485_en: $nodename:0: 'uart4_rs485_en' does not match '^(hog-[0-9]+|.+-=
hog(-[0-9]+)?)$
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dtso | =
2 +-
>  arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtso | =
2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-r=
s232.dtso b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs23=
2.dtso
> index f246b0ba6af29..ce197266262a5 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dt=
so
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dt=
so
> @@ -22,7 +22,7 @@
> =20
>  &gpio3 {
>  	pinctrl-names =3D "default";
> -	pinctrcl-0 =3D <&pinctrl_gpio3_hog>;
> +	pinctrl-0 =3D <&pinctrl_gpio3_hog>;
> =20

I think this commit should contain a Fixes tag.

best regards,
Alexander

>  	uart4_rs485_en {
>  		gpio-hog;
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-r=
s485.dtso b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs48=
5.dtso
> index 67508ca14276f..f2a7811f1b9f2 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dt=
so
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dt=
so
> @@ -23,7 +23,7 @@
> =20
>  &gpio3 {
>  	pinctrl-names =3D "default";
> -	pinctrcl-0 =3D <&pinctrl_gpio3_hog>;
> +	pinctrl-0 =3D <&pinctrl_gpio3_hog>;
> =20
>  	uart4_rs485_en {
>  		gpio-hog;
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



