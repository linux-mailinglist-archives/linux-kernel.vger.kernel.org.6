Return-Path: <linux-kernel+bounces-377534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308D29AC02A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 062D9B24609
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCC61547D5;
	Wed, 23 Oct 2024 07:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="qHDwvzxU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="HjRos3+J"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0A9EAC5;
	Wed, 23 Oct 2024 07:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729668455; cv=none; b=FD/pTByrNKZt/rxOBkPtRIgvZ0bnpexDkUnJouxv+wjmSH3w34RE1wE3z8c1Pq6JFr7/u38LwEycfGhWlSZN/a+aMk+iKMGAgNJU6D9iyn5ccVQIGmnTgPqAwPjIshVC72OMIITDrfVyg1vBP6+97B4omT/K+BEFW8V3J1DVzRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729668455; c=relaxed/simple;
	bh=UOdGmteuDF17WaDKUsAm9bMSO1DRsXO+5b96m5laO4g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MaUWlHO8JDgVhE27QiXwKGWD3Nj7U4p7817W846r1RAdObc7DUvNS8o9IQSk93em/R+Qt1Uomet6aIJojWgdLmHcsoJTvVlFILEbSixyrtO3MBhaO/8i9eAskyrPV2uc753JVoQTQ4jHO1yQk39JfvtEX80zmojVNIfa2AjRyrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=qHDwvzxU; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=HjRos3+J reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1729668451; x=1761204451;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=8QvoeAYq84HcWFFGcAF42FU7PXi0chXEy68ubmj3kl8=;
  b=qHDwvzxURovGLoPvWg+1nfZx6SLzICxvmuamhWBip2VLlsihVOr31LvT
   CJ3+gdf5m/xTcOEV5sv201bJrFyqMatGev0ZXCW45ivj8D4afa+wfKEVi
   nvDY41OB+rfuT6ZLpYJrVb/UvoVUPRCTr4YploRp04Nu6Kvv5Bu84cH0A
   +bpXmEN2YeH2lv+qfuzIN1CzcHI9hGJu8Kum2Cer+yR61DVCAs0t1/kMn
   0RDNY4e0WjuAa9pWnLL2WdcOHCqtJWot36f69D2xQKUe3CNbq2imN9Kz0
   peuc+pKPSspAitZBDd3WE0hqwXuhEd2V+R10YLhiIRysdcGPkOY8ncCcY
   A==;
X-CSE-ConnectionGUID: rDH59LECStGuVPIcPtvpUw==
X-CSE-MsgGUID: glc2ETSXSCusCZzvvITlUw==
X-IronPort-AV: E=Sophos;i="6.11,225,1725314400"; 
   d="scan'208";a="39615366"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 23 Oct 2024 09:27:28 +0200
X-CheckPoint: {6718A560-36-8E59014-E6F31237}
X-MAIL-CPID: 69246EAEBA9715DF528DC60B9732E311_1
X-Control-Analysis: str=0001.0A682F28.6718A561.000F,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 96700161479;
	Wed, 23 Oct 2024 09:27:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1729668444; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8QvoeAYq84HcWFFGcAF42FU7PXi0chXEy68ubmj3kl8=;
	b=HjRos3+JIqRURrrlHtwap8O7c9iftlfAa/6SI48kI10SmsVrpT8gJh3SBk2i6pZD69s0cW
	NClUuq19LuLN0LSPXLMmnM5nT/Uhr9gGPs9S9zPNpON1WuyuDClgAe/frWL3htYHSlzFsq
	ijX2FkP8Y1/3LLubC7SLR+5ad7ph74BJJ1tX3KF6iq8WSfeDues3BEfQByxiKeaPg8HNQm
	YdHaHXcSMj5WTV+oZKFnxgZWe3w8XcSbwkNc0trkUpDhba1sgylqsVH5LKS3XT3NL1zSGE
	UWaR5FPGItWmquCWPNWhOuj0/jIfbxFO+2sSte0In712T1bAg0iGtHUrTm9XmA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "open list:TQ SYSTEMS BOARD & DRIVER SUPPORT" <linux@ew.tq-group.com>, "open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 1/1] arm64: dts: freescale: mba8mx: remove undocument 'data-lanes' at panel
Date: Wed, 23 Oct 2024 09:27:23 +0200
Message-ID: <4606074.LvFx2qVVIh@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20241022202342.1263766-1-Frank.Li@nxp.com>
References: <20241022202342.1263766-1-Frank.Li@nxp.com>
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

thanks for your patch.

Am Dienstag, 22. Oktober 2024, 22:23:41 CEST schrieb Frank Li:
> 'data-lanes' is port0 of lvds bridge. Needn't set it for simple panel. Fix
> below CHECK_DTBS warning:
>=20
> arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx-lvds-tm070jvhg33.dtb:
>    panel-lvds: port:endpoint: Unevaluated properties are not allowed ('da=
ta-lanes' was unexpected)
>        from schema $id: http://devicetree.org/schemas/display/panel/panel=
=2Dsimple.yaml#
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>

> ---
> I have not such hardware to test.
> Alexander Stein:
> 	Can you help check it?

I noticed myself already. This patch fixes the warning.

Best regards,
Alexander

> ---
>  arch/arm64/boot/dts/freescale/mba8mx.dtsi | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/mba8mx.dtsi b/arch/arm64/boot/=
dts/freescale/mba8mx.dtsi
> index c60c7a9e54aff..3d26b6981c06f 100644
> --- a/arch/arm64/boot/dts/freescale/mba8mx.dtsi
> +++ b/arch/arm64/boot/dts/freescale/mba8mx.dtsi
> @@ -100,7 +100,6 @@ panel: panel-lvds {
> =20
>  		port {
>  			panel_in_lvds: endpoint {
> -				data-lanes =3D <1 2 3 4>;
>  				remote-endpoint =3D <&lvds_bridge_out>;
>  			};
>  		};
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



