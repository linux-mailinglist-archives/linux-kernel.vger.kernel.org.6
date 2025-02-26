Return-Path: <linux-kernel+bounces-533316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 184A0A45843
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF2F516F71A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31EF1DF990;
	Wed, 26 Feb 2025 08:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="a2KIG2mZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="k4b8csBF"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0CB238167;
	Wed, 26 Feb 2025 08:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558617; cv=none; b=JRl8xN3Q8HCeff0STM/Hifa4Aa0XwoYsjgTAOmg3Vm0KF645ONtqBARZ1fNFMipJ8GNY39ks52fvwrKYZhoChhh4aDN/SMhJDXC7yqCualXq12O6FxMWYoOYFaq1ZFeCkyFtebpltYhNuDGCCdgkFuiuytrc7trlNv7xrKk41g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558617; c=relaxed/simple;
	bh=1+mykuRo96bb63Fh3sFe5w2cPWfzGYls8q6WYMHs0po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dANb8sm/T4fNL5tNemaKIQnXzHojs+afLksE/Kpd0efv9d2e1H/wWP76nIsRr9NkzhyyDaC2rR5QyRfOh/32xp3SCNmGyqq5XgN6XAdB467s18X1tQeDVyBXcWBSQcczpgtzPIt+v9PnvQlrx6FamxnqlfWVnE6q7Td0j3zOMwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=a2KIG2mZ; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=k4b8csBF reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1740558612; x=1772094612;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QTp1DwcDw762KDomIRK2976/YjMdtiSjqpoN9MvDBnw=;
  b=a2KIG2mZ9KXzk2kUjzokfDYPEcofv0tvvzkZIlFf8GWhMkkFJduWquV7
   N0GsFcinzvfO0iMBaWlN0f2OIeN9bOm4RFKqrdx6i++vaXbVU5kfzNFuE
   /oH57WjkhmeuNBme9cj7WC2zhOv2NiPWH7xtgFm3gKGc1MHpSxWVaf1C5
   GZrS8bWJeW/ZKFzqGSXODRrwwGOVieTAop0v11BwS/MfcMdiW3i9VdWqA
   W1AHU1x5w0hXqv+OkrqwGGqriqWUIGIMIfmHxjDvgHxTwA2NLUJsNbok5
   I5JybMfhJg1RPUdgxrF/zX5wdswWvx/Q+Q3GFx57KP48n4z/TZzpZKPpZ
   w==;
X-CSE-ConnectionGUID: mnH/OuQLRu6ZleMIQlem2g==
X-CSE-MsgGUID: 7jd0BkKsS/eVEg8don57xg==
X-IronPort-AV: E=Sophos;i="6.13,316,1732575600"; 
   d="scan'208";a="42100428"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 26 Feb 2025 09:30:09 +0100
X-CheckPoint: {67BED111-35-28232521-C0C2250B}
X-MAIL-CPID: 7BEE2FE34E5CA2663E70FFD0064A9E7F_4
X-Control-Analysis: str=0001.0A002114.67BED111.0049,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6E89C168E0D;
	Wed, 26 Feb 2025 09:30:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1740558605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QTp1DwcDw762KDomIRK2976/YjMdtiSjqpoN9MvDBnw=;
	b=k4b8csBFyeNFO8pULNoZ5iEdQxDjDA8ObrojCjEeglCFxvD0zH8hinWyCXxU2aUkTBk2k2
	JRLqwoDkA052+wne1RXCwY8xO8EEyt8PeM2vyA0Z6RLBHAewoGdmO8sSkM2JigdSZ3pecq
	3X4HQUsYs8SvtX1qVdWZ7nvDDD/m4aAgCk50bii/dy8tq9WQ39e3uxkdTgNbiUI3J2mFlm
	jOBdWcAUPGTg/4Rhd8voBj0RXnFeJj7Nsfq23lacJNjlKrsxwYTrz0tN2Gd1/jxQqKRQVk
	Bd0EOloWzEMKJ9IDH5b3VkfkRIlEX/38U0czCNgYGFtN7ICm0L2pwOFTwFXVSg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/1] arm64: dts: imx95: add ref clock for pcie nodes
Date: Wed, 26 Feb 2025 09:30:01 +0100
Message-ID: <2979558.e9J7NaK4W3@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20250225170802.2671972-1-Frank.Li@nxp.com>
References: <20250225170802.2671972-1-Frank.Li@nxp.com>
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

Am Dienstag, 25. Februar 2025, 18:08:02 CET schrieb Frank Li:
> Add "ref" clock for i.MX95's pcie and fix below CHECK_DTBS warnings:
> arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: pcie@4c300000: clock-n=
ames: ['pcie', 'pcie_bus', 'pcie_phy', 'pcie_aux'] is too short
> 	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie.yaml
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change from v2 - v3
> - fix typo 1000000
>=20
> change from v1 - v2
> - rebase to dt/dt64
> - add clock 100mhz
> ---
>  arch/arm64/boot/dts/freescale/imx95.dtsi | 25 ++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/d=
ts/freescale/imx95.dtsi
> index 51625bc9154ec..9bb26b466a061 100644
> --- a/arch/arm64/boot/dts/freescale/imx95.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
> @@ -291,6 +291,13 @@ sai5_mclk: clock-sai-mclk5 {
>  		clock-output-names =3D "sai5_mclk";
>  	};
> =20
> +	clk_sys100m: clock-sys100m {
> +		compatible =3D "fixed-clock";
> +		#clock-cells =3D <0>;
> +		clock-frequency =3D <100000000>;
> +		clock-output-names =3D "clk_sys100m";
> +	};
> +

Where does this clock come from? Does this origin on board-level?

Best regards,
Alexander

>  	osc_24m: clock-24m {
>  		compatible =3D "fixed-clock";
>  		#clock-cells =3D <0>;
> @@ -1595,6 +1602,14 @@ usb3_dwc3: usb@4c100000 {
>  			};
>  		};
> =20
> +		hsio_blk_ctl: syscon@4c0100c0 {
> +			compatible =3D "nxp,imx95-hsio-blk-ctl", "syscon";
> +			reg =3D <0x0 0x4c0100c0 0x0 0x1>;
> +			#clock-cells =3D <1>;
> +			clocks =3D <&clk_sys100m>;
> +			power-domains =3D <&scmi_devpd IMX95_PD_HSIO_TOP>;
> +		};
> +
>  		usb3_phy: phy@4c1f0040 {
>  			compatible =3D "fsl,imx95-usb-phy", "fsl,imx8mp-usb-phy";
>  			reg =3D <0x0 0x4c1f0040 0x0 0x40>,
> @@ -1633,8 +1648,9 @@ pcie0: pcie@4c300000 {
>  			clocks =3D <&scmi_clk IMX95_CLK_HSIO>,
>  				 <&scmi_clk IMX95_CLK_HSIOPLL>,
>  				 <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
> -				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
> -			clock-names =3D "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
> +				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>,
> +				 <&hsio_blk_ctl 0>;
> +			clock-names =3D "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "ref";
>  			assigned-clocks =3D<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
>  					 <&scmi_clk IMX95_CLK_HSIOPLL>,
>  					 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
> @@ -1706,8 +1722,9 @@ pcie1: pcie@4c380000 {
>  			clocks =3D <&scmi_clk IMX95_CLK_HSIO>,
>  				 <&scmi_clk IMX95_CLK_HSIOPLL>,
>  				 <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
> -				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
> -			clock-names =3D "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
> +				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>,
> +				 <&hsio_blk_ctl 0>;
> +			clock-names =3D "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "ref";
>  			assigned-clocks =3D<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
>  					 <&scmi_clk IMX95_CLK_HSIOPLL>,
>  					 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



