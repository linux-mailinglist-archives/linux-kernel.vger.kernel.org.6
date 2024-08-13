Return-Path: <linux-kernel+bounces-284332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AEE94FFF8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A75C1F2589F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B8A13A888;
	Tue, 13 Aug 2024 08:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="HfSlxtpT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="B+GEqrAI"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075A213A244;
	Tue, 13 Aug 2024 08:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723538270; cv=none; b=VAVKrVe7MXUnsNVX6XCsyr8VAEpWCvx3uTVstg30ZggC1GOqK8moFiw6yfr13kaC6ACfTtMUfoOs0n5gCTKB9l3mlmgwoWg38zDCnD3Lqvf1t1y5yc8gpBHwNvwQ0ao9xUys68rTNq4u18JZr/uXM6QKZdesy4KmCbJvZVq1FO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723538270; c=relaxed/simple;
	bh=W/A37q5YlXfYFBNJvZTzCfRB7wos3cw8EoGDt04L16A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W40C1ycjgGwWW9qtwNpxQXHtfVBjgF+w8FaUHf2Ax4Xq8VywNG/l7EAuM0tV0/MiHCn5S9GoGUhQaLHEW6TiWbb2aSpcbErKK/1IJY17j4obb+50VWy461g5VqHcQDSdY/CLmX8D1VGzbcJN0VB4WkE4mIE4CwyS23GfV8Jz+6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=HfSlxtpT; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=B+GEqrAI reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723538267; x=1755074267;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BDO3WMpA+BbHO480iIBT9Pnt4TB/RAexMksIrBx+Is0=;
  b=HfSlxtpTmL4URHhwbcNJcevqShCOi2dhgLaUu75eLcVaDxurzBu8rQrh
   WjeEqobJeUAqaJRPKi3XDbno6SEUDhEhJ8Lvp+qQooVNteLBsQ1+5dN1y
   VKyHmmOCR0/MjJS2oUUh8eBfJvrOMmr4+Cnuop14g/E2H+N4GBAkFf1se
   Rv3d3J6hGxScVFBl45lxYC4J1z8fR84ViXu7YcX0f8kIs+bDgdhIiqhb4
   F4GBxayrVwDp11SWPJfmVAVtb6k33JszRMyKO2IzvVTfj++ZpbHi88e7Z
   0/YqmW9eLCBrUSgmoBvisSJZ1KF15wbGLasvrk/jYIIi3zV1H6hLo76Ge
   Q==;
X-CSE-ConnectionGUID: zDpcmv8RTGSogfSruOtbfg==
X-CSE-MsgGUID: wgeCdL5VSpeuupeof4bClA==
X-IronPort-AV: E=Sophos;i="6.09,285,1716242400"; 
   d="scan'208";a="38379159"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 13 Aug 2024 10:37:45 +0200
X-CheckPoint: {66BB1B58-47-FF00FE11-F2A862FD}
X-MAIL-CPID: 85157A4D550D10FF1836E2700FFE7FC3_5
X-Control-Analysis: str=0001.0A782F28.66BB1B59.003D,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0907516A3A8;
	Tue, 13 Aug 2024 10:37:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723538260;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BDO3WMpA+BbHO480iIBT9Pnt4TB/RAexMksIrBx+Is0=;
	b=B+GEqrAIIjuoftDnaHMv5LdED18moPVe2aRX2S+BvNkSUsjbbPLjRV0/KtiA7wvmZ2mGHM
	bEzUvWK/+Ki5OsRXIvHj5EIEubczs3QM6Hv6RrvtXtYwpVDdMWgS74Fuvk/rIN0InGlOl2
	Us6s5w4se9coOqXclWkQQSH3VokG9iAGXtMYQRLxRFWjq3yp7JKv2y/ATgpp+tUYgkpd4W
	uzZCIPOWLN6dFD5Ig6wbtg68xqwWHvocI/3Gm/eT1yXXARP+DXuxUxULVlbh8gJT8cQe+W
	AAtzMfKMcmmcEgQqTpIY7qqlgg7rn1HO9YCglsiDk9EQLMdJhE6G5P2Gf0SASA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Gregor Herburger <gregor.herburger@ew.tq-group.com>, Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux@ew.tq-group.com, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 11/17] arm64: dts: fsl-lx2160a-tqmlx2160a: change "vcc" to "vdd" for hub*
Date: Tue, 13 Aug 2024 10:37:42 +0200
Message-ID: <3239392.5fSG56mABF@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240813-imx_warning-v1-11-3494426aea09@nxp.com>
References: <20240813-imx_warning-v1-0-3494426aea09@nxp.com> <20240813-imx_warning-v1-11-3494426aea09@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Am Dienstag, 13. August 2024, 06:35:06 CEST schrieb Frank Li:
> According to binging doc usb/ti,usb8041.yaml and in
> drivers/usb/misc/onboard_usb_dev.h
>=20
> ti_tusb8041_data =3D { .supply_names =3D { "vdd" },};
>=20
> It should vdd-supply instead vcc-supply.
>=20
> Fixes: 04b77e0124ef ("arm64: dts: freescale: add fsl-lx2160a-mblx2160a bo=
ard")
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Thanks.

Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dts | 4 +=
+--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx216=
0a.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dts
> index da0f58e26b9aa..f6a4f8d543015 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dts
> @@ -320,7 +320,7 @@ hub_2_0: hub@1 {
>  		reg =3D <1>;
>  		peer-hub =3D <&hub_3_0>;
>  		reset-gpios =3D <&gpioex1 0 GPIO_ACTIVE_LOW>;
> -		vcc-supply =3D <&reg_vcc3v3>;
> +		vdd-supply =3D <&reg_vcc3v3>;
>  	};
> =20
>  	hub_3_0: hub@2 {
> @@ -328,7 +328,7 @@ hub_3_0: hub@2 {
>  		reg =3D <2>;
>  		peer-hub =3D <&hub_2_0>;
>  		reset-gpios =3D <&gpioex1 0 GPIO_ACTIVE_LOW>;
> -		vcc-supply =3D <&reg_vcc3v3>;
> +		vdd-supply =3D <&reg_vcc3v3>;
>  	};
>  };
> =20
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



