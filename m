Return-Path: <linux-kernel+bounces-222518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B43F7910326
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F4172890D9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 11:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7936C1AC782;
	Thu, 20 Jun 2024 11:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="IaENGWEN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ZtS6t78U"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586421ABCD5;
	Thu, 20 Jun 2024 11:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718883445; cv=none; b=YuE2meFGS3EYN5rgjowdoYH/9OU2Wc46fY0zEZCo3sCJGaGB/hEjwBceCuNNWU8DvjKw1XCxzbCEknicLAoSRv4wLjEdtgRD0zAZXIacFK9IjPgd6ZNsOzxemvjpYIqHPuvAl0nUr3rsFN0K6yZim0A5QjKbEECaGMLNfRq4IVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718883445; c=relaxed/simple;
	bh=qoW0vyk6HZvIQuzlKHMXqNDVBP1cdFn6kO5pF/oldM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lXNgMBcONGbFHljuaxEx6/PRoT01LklI5FJHm5CcyhuPF1j+CkiZDibVfwmLOhlIQY++j98kNNTqD2+bQEPIXJ3YUIWR6rYJsltdnrJE88Q+NewRDSa7mhUJN4/LAiabpoEgF43u0cj3dLQxDaTgSXdwgpaR0vReXaejc3V1Y+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=IaENGWEN; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=ZtS6t78U reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1718883440; x=1750419440;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XsMdtVrVgtV7oMw8vFBN6CYNKuXpTptfGJ0gp07/wv8=;
  b=IaENGWENMjPh+gXPOoA15sx07VR/styddAOodo+rmdTwbQXd1u3zUwc1
   mnKjN8byxBUzzEYYngCr+pCdRtg0JPpBuORqwYzD9A95XrE95ZBeEQQq2
   Ju5YopLs9cwIgoFmqtZ7K+N5hdJAhVBVzbSaa5lh9qCnI5tJ1FGr9DnPY
   FG7fh9ZqQx08wM+jifmbz6Y50aKS6V2CKJyMfSSsuEt+OWKiSixUibrVL
   O4nlmRDlOUgUGA+oS5ZfvL0GV+RrSl6CVLmqvVqhEx/xxz/6W45lo7pYu
   bA6sKNDX926W3nNjCuSd71F3VYcyQdH+75HSmBEQROzqdkKqb0PykjKEH
   A==;
X-CSE-ConnectionGUID: 80Ooz7eQSYShYhVtP4i1tg==
X-CSE-MsgGUID: bZfMWF2hRKe3Ze1DFZItaA==
X-IronPort-AV: E=Sophos;i="6.08,252,1712613600"; 
   d="scan'208";a="37498585"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 20 Jun 2024 13:37:18 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A36AF1617F9;
	Thu, 20 Jun 2024 13:37:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1718883433;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=XsMdtVrVgtV7oMw8vFBN6CYNKuXpTptfGJ0gp07/wv8=;
	b=ZtS6t78URTtXeUlQyBR9u5WP33VzQK7N6Ak8d7PVvVEyCFmUJTRJYBPYGngpHSg8x1ztYK
	BXAJr/oO0L6ZXb4GL5sD7cReyGLMLQKyh/trKBWx5y5w5FxNObU7zasknOzDuQIG5xvTT/
	vASsnyFYSzzodls7KjnzJDpnV/Yr9kNkE5veRio3kEFpfOAvAbS7FQyL41D8TWu52zxlTE
	9iVM2fsVSa2VD/eeyniCmE3BR8uirP1OGptO9ETqPo7AfMKPoaH6EsftOsHfR0ksqYyFms
	zdYRUP6yUC52vjrglCw1zHAVImizl7IT0sEr756rvaVGGpVm4M7MJJH/ESFQmw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: linux-arm-kernel@lists.infradead.org, Adam Ford <aford173@gmail.com>
Cc: aford@beaconembedded.com, Adam Ford <aford173@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, devicetree@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mp: Fix pgc vpu locations
Date: Thu, 20 Jun 2024 13:37:15 +0200
Message-ID: <2295311.iZASKD2KPV@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240619101045.6317-1-aford173@gmail.com>
References: <20240619101045.6317-1-aford173@gmail.com>
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

Am Mittwoch, 19. Juni 2024, 12:10:44 CEST schrieb Adam Ford:
> The various pgv_vpu nodes have a mismatch between the value after
> the @ symbol and what is referenced by 'reg' so reorder the nodes
> to align.
>=20
> Fixes: df680992dd62 ("arm64: dts: imx8mp: add vpu pgc nodes")
> Suggested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Thanks for the patch.
Reviewd-by: Alexander Stein <alexander.stein@ew.tq-group.com>

>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/=
dts/freescale/imx8mp.dtsi
> index 3576d2b89b43..ee0c864f27e8 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -838,6 +838,12 @@ pgc_gpumix: power-domain@7 {
>  						assigned-clock-rates =3D <800000000>, <400000000>;
>  					};
> =20
> +					pgc_vpumix: power-domain@8 {
> +						#power-domain-cells =3D <0>;
> +						reg =3D <IMX8MP_POWER_DOMAIN_VPUMIX>;
> +						clocks =3D <&clk IMX8MP_CLK_VPU_ROOT>;
> +					};
> +
>  					pgc_gpu3d: power-domain@9 {
>  						#power-domain-cells =3D <0>;
>  						reg =3D <IMX8MP_POWER_DOMAIN_GPU3D>;
> @@ -853,6 +859,28 @@ pgc_mediamix: power-domain@10 {
>  							 <&clk IMX8MP_CLK_MEDIA_APB_ROOT>;
>  					};
> =20
> +					pgc_vpu_g1: power-domain@11 {
> +						#power-domain-cells =3D <0>;
> +						power-domains =3D <&pgc_vpumix>;
> +						reg =3D <IMX8MP_POWER_DOMAIN_VPU_G1>;
> +						clocks =3D <&clk IMX8MP_CLK_VPU_G1_ROOT>;
> +					};
> +
> +					pgc_vpu_g2: power-domain@12 {
> +						#power-domain-cells =3D <0>;
> +						power-domains =3D <&pgc_vpumix>;
> +						reg =3D <IMX8MP_POWER_DOMAIN_VPU_G2>;
> +						clocks =3D <&clk IMX8MP_CLK_VPU_G2_ROOT>;
> +
> +					};
> +
> +					pgc_vpu_vc8000e: power-domain@13 {
> +						#power-domain-cells =3D <0>;
> +						power-domains =3D <&pgc_vpumix>;
> +						reg =3D <IMX8MP_POWER_DOMAIN_VPU_VC8000E>;
> +						clocks =3D <&clk IMX8MP_CLK_VPU_VC8KE_ROOT>;
> +					};
> +
>  					pgc_hdmimix: power-domain@14 {
>  						#power-domain-cells =3D <0>;
>  						reg =3D <IMX8MP_POWER_DOMAIN_HDMIMIX>;
> @@ -890,33 +918,6 @@ pgc_ispdwp: power-domain@18 {
>  						reg =3D <IMX8MP_POWER_DOMAIN_MEDIAMIX_ISPDWP>;
>  						clocks =3D <&clk IMX8MP_CLK_MEDIA_ISP_ROOT>;
>  					};
> -
> -					pgc_vpumix: power-domain@19 {
> -						#power-domain-cells =3D <0>;
> -						reg =3D <IMX8MP_POWER_DOMAIN_VPUMIX>;
> -						clocks =3D <&clk IMX8MP_CLK_VPU_ROOT>;
> -					};
> -
> -					pgc_vpu_g1: power-domain@20 {
> -						#power-domain-cells =3D <0>;
> -						power-domains =3D <&pgc_vpumix>;
> -						reg =3D <IMX8MP_POWER_DOMAIN_VPU_G1>;
> -						clocks =3D <&clk IMX8MP_CLK_VPU_G1_ROOT>;
> -					};
> -
> -					pgc_vpu_g2: power-domain@21 {
> -						#power-domain-cells =3D <0>;
> -						power-domains =3D <&pgc_vpumix>;
> -						reg =3D <IMX8MP_POWER_DOMAIN_VPU_G2>;
> -						clocks =3D <&clk IMX8MP_CLK_VPU_G2_ROOT>;
> -					};
> -
> -					pgc_vpu_vc8000e: power-domain@22 {
> -						#power-domain-cells =3D <0>;
> -						power-domains =3D <&pgc_vpumix>;
> -						reg =3D <IMX8MP_POWER_DOMAIN_VPU_VC8000E>;
> -						clocks =3D <&clk IMX8MP_CLK_VPU_VC8KE_ROOT>;
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



