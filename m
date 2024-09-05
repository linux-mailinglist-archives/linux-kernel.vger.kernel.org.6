Return-Path: <linux-kernel+bounces-317003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 708B196D824
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 273E71F23980
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BCF19AD8D;
	Thu,  5 Sep 2024 12:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="GvRbIcAu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="cqLFhe4x"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BB8198A15;
	Thu,  5 Sep 2024 12:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538699; cv=none; b=C0PwAW+Iy4WWNBOqPVdk3HnTqiHdmelc/ThL/oU4ihuWFCZWq8QLZaYaCUoNELRZkyDe14s45y8nxIUa3ZMamjRg+QXF24YdVZLX3GewnffsjS7baEKMLqAlLphcXYWbHEtwFJbmq8r/3p0ePybvQxOfu0YiBgQs3gogFjSk1jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538699; c=relaxed/simple;
	bh=OU9khEplSXIPZvW9YQW/kvPNsg3xOvy2fLqNBZtfO68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g+axVXesyhlOq61k4f4YeatAj03loEKUuHxHuibLz1i+xFpbuh45puhc8H5uBw0trKkOoY9/tQ6d6j+usopxTr2tNwvXKy4mWqi+PX8nvJPQD20a8NpjXOWzURKSPqD6ni32gNHJPE/dOPb40c1yd57xS4LQ4t9RtBSChPZNcSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=GvRbIcAu; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=cqLFhe4x reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1725538696; x=1757074696;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NDxfANTOSF3Gqj/jX4uANi4UICSv0g4HgY7ZY918h7U=;
  b=GvRbIcAuiIle8LDQbkeMxyM7KgH9DEHDm705bGrrokhgEaGNfVfLWddh
   uv77cN7gvISJZgJgqHrduQW6WpIPhIdQaZDTyJntRjQhDtpdAgzIFOby9
   ryqUSsJRkDlfGiq5/Shs3kI+DA82kaJ//BYKtUAkDr6JiF8Z/bU1boTkT
   OuchpcLfTfBKhlmQUu/MQXhsIpRZb3+qBo++gdAD5XacF3lQwry4Ua9sW
   5Pk2Lb6GIiNf+ug+icPXMZB1+U0FMYcJu+p+Dsb2RRvQg/C7bxRb2cDT/
   cwGf1Ib5o5sBPr9kDp+aAj3ODo+nDg9PZm3/RNj8UR4wDT8bSe6DbL4Cn
   w==;
X-CSE-ConnectionGUID: i7nCo4KJT0KmFXKOpBGsmg==
X-CSE-MsgGUID: jTc9RNZ+TjiT4moshVTTLw==
X-IronPort-AV: E=Sophos;i="6.10,204,1719871200"; 
   d="scan'208";a="38787541"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 05 Sep 2024 14:18:08 +0200
X-CheckPoint: {66D9A180-7-E520F13A-D17B83D9}
X-MAIL-CPID: BE149099F5842D0D7886CFAB60102631_2
X-Control-Analysis: str=0001.0A782F23.66D9A180.00AC,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 754BD16ABF3;
	Thu,  5 Sep 2024 14:18:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1725538684;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=NDxfANTOSF3Gqj/jX4uANi4UICSv0g4HgY7ZY918h7U=;
	b=cqLFhe4xTz7mmpxEfHbUyKsiWANnAzEBjLS3gI+ytMVesMfVNW6K8k8gd/HO55TMzv2CJR
	lESX+8bba6lLbt7w4lhBeisQyX2UCFbO5rN4Ia6XO3XAnaKDjhJXSI22tDwVKyMGVepQAa
	RYdQ3QEOn67qGo+TLGQqGIBfMllvcK+yKoD19+IWBLaso/qCtlNF1E5Y9zrRvM32AZMqFg
	iJSM25OLI4S/grqzty1GR+9RKEX23rijag2WI8jNmn0gN0SE3V4aUriBuM+H23h5mrpNB0
	O6PZwXzOPZB+RIYPNT9jVqmRcY12WMuPURTaf+19ggUkogbXBBVKUDLXWBc+uQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: Re: [PATCH v2 2/7] arm64: dts: freescale: imx95: add bbm/misc/syspower scmi nodes
Date: Thu, 05 Sep 2024 14:18:00 +0200
Message-ID: <22416715.EfDdHjke4D@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240903-imx95-dts-new-v2-2-8ed795d61358@nxp.com>
References: <20240903-imx95-dts-new-v2-0-8ed795d61358@nxp.com> <20240903-imx95-dts-new-v2-2-8ed795d61358@nxp.com>
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

Am Dienstag, 3. September 2024, 09:17:47 CEST schrieb Peng Fan (OSS):
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Add SYS Power, BBM and MISC nodes under SCMI firmware node.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Looks good.
Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>

> ---
>  arch/arm64/boot/dts/freescale/imx95.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/d=
ts/freescale/imx95.dtsi
> index 7880d3efbd7e..314a45e82c38 100644
> --- a/arch/arm64/boot/dts/freescale/imx95.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
> @@ -301,6 +301,10 @@ scmi_devpd: protocol@11 {
>  				#power-domain-cells =3D <1>;
>  			};
> =20
> +			scmi_sys_power: protocol@12 {
> +				reg =3D <0x12>;
> +			};
> +
>  			scmi_perf: protocol@13 {
>  				reg =3D <0x13>;
>  				#power-domain-cells =3D <1>;
> @@ -320,6 +324,13 @@ scmi_iomuxc: protocol@19 {
>  				reg =3D <0x19>;
>  			};
> =20
> +			scmi_bbm: protocol@81 {
> +				reg =3D <0x81>;
> +			};
> +
> +			scmi_misc: protocol@84 {
> +				reg =3D <0x84>;
> +			};
>  		};
>  	};
> =20
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



