Return-Path: <linux-kernel+bounces-371180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A97119A3774
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BE0CB23FE4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BBA1898FB;
	Fri, 18 Oct 2024 07:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="eHURhya2";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="KYUiEjmD"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542E7188903;
	Fri, 18 Oct 2024 07:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729237320; cv=none; b=QRNpkMPWixGlUaUtBwQH2lAvT9ZFQDHJrzBJqWIaRvYMg5vJTo2LvYAjBZ0Gq5LZCxDKJ3m5C1hIHBaLGNqnj164doJmG1c+PVbxXj58BYr/nQeOiOc9dkEn4h9mBgQpChdjWkMs50ZPS3fskQGm9aLDCGZK6xy+ibTzA3BrPsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729237320; c=relaxed/simple;
	bh=bQ0kffL0W9yYZooU4PIVyxqHqdXbjGqjFTukajNLZT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C2/MKTeJSBybfN3iFjn8NAYzrObdRZ5udEd7k50kd1AhYPo1qmUoeMDtHeVSTarGkI/qEKNXIZw5cXfRXH73qSZLubTBR8er54149/1kvTbbjdrUZfejGX4G2Qqf85EJDG4/ZSiAgzXhcT7u1OhwlRFQA5Vgx6QuUOOxXET/Nl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=eHURhya2; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=KYUiEjmD reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1729237318; x=1760773318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GTYHCV2IcBd0xtopUr2yV5NfEZy3fDfq239jjxc9ssQ=;
  b=eHURhya2ivLojoUeGL/ug3o5YYrH1NT6GZKd88AhslD4Ix2qQekRvCP1
   hxorsTQ12sbmNg89HON876/kJIaXZCFn2LowV68UPGWB8vdziXkus/TeH
   THFMwNB/PyTO8pI4IpBbUeoU20i+oEpKgaqToZkkROURmgajY4wcPlli6
   MZIeRJuCNDX93CqgRoIC0H9MtcWOPn8Aecz14Am+x1ufTq3WfxT43MrYz
   4cho7+9kZv86mkHEgdJSPJYb9P7t24X5J7lk3tpTVELIvVDSbdHFegwdP
   gj9EK7N4COMtnAz5IEEe93TKM03Ah3aklVak7G18DpQL67OEia6cBD9P0
   g==;
X-CSE-ConnectionGUID: JDvEIM/JTvyg9kRHgFH8Lw==
X-CSE-MsgGUID: gsg2AY9iT3K8jCMjjxfJ4A==
X-IronPort-AV: E=Sophos;i="6.11,213,1725314400"; 
   d="scan'208";a="39535090"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 18 Oct 2024 09:41:56 +0200
X-CheckPoint: {67121144-16-BD84CFBF-E7C15A70}
X-MAIL-CPID: DDF101AC2D2D066EB06111F8D38943D0_3
X-Control-Analysis: str=0001.0A682F26.67121144.007E,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8F7D0170261;
	Fri, 18 Oct 2024 09:41:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1729237311;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=GTYHCV2IcBd0xtopUr2yV5NfEZy3fDfq239jjxc9ssQ=;
	b=KYUiEjmDXQTfDhwZj94YwgGMTYGbP9sNMRgGLlLz2pZKVVWcWcdJsxm3YDZToP3e3Ixf2L
	5rnnT7+vcdaLhO0T4vJM/k09aurI98KVdRQPQ0gikv955efXVM/0ItgV56F9r3ys+FcLeZ
	Iit3G+pr6lbsIJjXXxOL1beiKYTbkLvZS2KcVXFt5kgRhTNoyVGeCJJbl//8lJCsq/3vbd
	Kk4mHYHIQLmjLl1eKmlgbXJrepGYOLVZtsP2iQuyrpCgbVl8Gw+KxBTVmH4vVh70It1rZq
	M/mTDM8ko+BczKgC9EkGYu6u6bu9QmZnEN35BUzKUWjAKF4XGyobPmSfkVcRMA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, marex@denx.de, stefan@agner.ch, dmitry.baryshkov@linaro.org, Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH 3/5] arm64: dts: imx8mp-msc-sm2s-ep1: Add HDMI connector
Date: Fri, 18 Oct 2024 09:41:50 +0200
Message-ID: <15311928.tv2OnDr8pf@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20241018064813.2750016-4-victor.liu@nxp.com>
References: <20241018064813.2750016-1-victor.liu@nxp.com> <20241018064813.2750016-4-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Am Freitag, 18. Oktober 2024, 08:48:11 CEST schrieb Liu Ying:
> Add a HDMI connector to connect with i.MX8MP HDMI TX output.
> This is a preparation for making the i.MX8MP LCDIF driver use
> drm_bridge_connector which requires the DRM_BRIDGE_ATTACH_NO_CONNECTOR
> flag.  With that flag, the DW HDMI bridge core driver would
> try to attach the next bridge which is the HDMI connector.
>=20
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

Looks similar to imx8mp-tqma8mpql-mba8mpxl.dts, so:
Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>

> ---
>  .../dts/freescale/imx8mp-msc-sm2s-ep1.dts     | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts b/arch=
/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
> index 83194ea7cb81..b776646a258a 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
> @@ -15,6 +15,17 @@ / {
>  		     "avnet,sm2s-imx8mp-14N0600E", "avnet,sm2s-imx8mp",
>  		     "fsl,imx8mp";
> =20
> +	hdmi-connector {
> +		compatible =3D "hdmi-connector";
> +		type =3D "a";
> +
> +		port {
> +			hdmi_in: endpoint {
> +				remote-endpoint =3D <&hdmi_tx_out>;
> +			};
> +		};
> +	};
> +
>  	reg_vcc_3v3_audio: 3v3-audio-regulator {
>  		compatible =3D "regulator-fixed";
>  		regulator-name =3D "VCC_3V3_AUD";
> @@ -54,6 +65,14 @@ &hdmi_tx {
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&pinctrl_hdmi>;
>  	status =3D "okay";
> +
> +	ports {
> +		port@1 {
> +			hdmi_tx_out: endpoint {
> +				remote-endpoint =3D <&hdmi_in>;
> +			};
> +		};
> +	};
>  };
> =20
>  &hdmi_tx_phy {
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



