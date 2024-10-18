Return-Path: <linux-kernel+bounces-371178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6939A376B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02A271F21EA1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4C115FA92;
	Fri, 18 Oct 2024 07:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Qg+V1dlE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="A5vezJ58"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034E91514C9;
	Fri, 18 Oct 2024 07:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729237281; cv=none; b=uUwI47d0E6bI+LyNFvrNpVcA+82lvCFwdhTCZOfAHjZURU6dR2TqyKtR/O8pyh3mttu/JN35W7pJQpPXBQKEC5ezQA3TLD2IVR6yI2juyC5iVIFTOhlgF+nffh2VAPDBna1XR+UCV/SUnCbY3JKrqx3iwN0iB00rZkh6A6hlAV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729237281; c=relaxed/simple;
	bh=kJJb+9+gvxgl+O4Q1Dlj/U2lQhq8hK7p6SFgPAYZe9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UdshNB/DBABO0HXPnXxLqRRp42uyKauTyqTVgwShuaDFsixQFbPFyGeysxkKEZS4Pi6/z5EeFtL0KLhkeNa6WCz/hsx0OaYy8JZkk0u4pzqXUN9bnxwCNr30OprbrweisV4k1Z0fCKTPrauvlzYBfT+8N5qSI4LvPPNRyr16G3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Qg+V1dlE; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=A5vezJ58 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1729237279; x=1760773279;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7CJ/y+7WtdFv9s7kRyjk4o6RfcgvWIF9H/8Zc6HTNCs=;
  b=Qg+V1dlEKZ69UXxfRrSh4oAY9279dGGyQp4RDokpPSPWQhd/1assHKID
   vlkqp3Mjs/6FVh+I8o4Yr+oGTDnj4wOKJoCbh0SBGwSzPx8NayA19IFIU
   ztfG68uoqm0UWg7Y7KUpAQyzsPxz6FWN/F0Biq48CKJnLeultQf9KTgzi
   BzRwIpuzTsUqhJ5rncpc6dObXgYW9oF/7BNno4+ucq03nyeIV1VdVkyL9
   aE8zemK7FtMg4ILkoSPxwJNDZ+lrnNrcE9b0P2h5TiYJAUnMEFvb6FI6s
   cRTGLYWTbn4ekszaW7lmCxhwExfpUPfAj9cWgoUpxMGgwYMTZzqu8iD5N
   A==;
X-CSE-ConnectionGUID: urIKLa/HRiqZcUgrcvqZFA==
X-CSE-MsgGUID: SY6XoutYT7iowEnEPbMmtw==
X-IronPort-AV: E=Sophos;i="6.11,213,1725314400"; 
   d="scan'208";a="39535062"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 18 Oct 2024 09:41:16 +0200
X-CheckPoint: {6712111C-29-65F98A6A-FADAF7F3}
X-MAIL-CPID: 7642140A76B7BABC054D44A6F64FB81D_5
X-Control-Analysis: str=0001.0A682F28.6712111D.0022,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2878716806F;
	Fri, 18 Oct 2024 09:41:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1729237272;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7CJ/y+7WtdFv9s7kRyjk4o6RfcgvWIF9H/8Zc6HTNCs=;
	b=A5vezJ58xi3an0iZ0JXp06Bb7Zf24EuNaLVpcSe8ZeP+aNsDX6mKou87N5xcKkxRu1UVyW
	aZt1oA5xZIpKoQpiESTCK9MbpNiHlzPgrY98l3ggLmLlwvfBDxaefkejnNT6m7rmCLpG/P
	zj6UE4fbcZpVinaqU2NCxJ91x1IX+qWxwrSz1+yCUHkeNDlxnTaXdXVWItO3FpXcY5Rtja
	O7OVuXZYC2baTELvSN9ysCaLDS32oQ9BAkHDr+207McKaCGOhLxujZMTvFg7k7LGgOxb0w
	HFDbRl+Gt/1cYp6YHKcdF/R4XtFADWeVWgc1UcwC020kw8xS9vxFq9N9h41Nsw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, marex@denx.de, stefan@agner.ch, dmitry.baryshkov@linaro.org, Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH 1/5] arm64: dts: imx8mp-kontron-bl-osm-s: Add HDMI connector
Date: Fri, 18 Oct 2024 09:41:08 +0200
Message-ID: <864627577.0ifERbkFSE@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20241018064813.2750016-2-victor.liu@nxp.com>
References: <20241018064813.2750016-1-victor.liu@nxp.com> <20241018064813.2750016-2-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Am Freitag, 18. Oktober 2024, 08:48:09 CEST schrieb Liu Ying:
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
>  .../dts/freescale/imx8mp-kontron-bl-osm-s.dts | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-kontron-bl-osm-s.dts b/=
arch/arm64/boot/dts/freescale/imx8mp-kontron-bl-osm-s.dts
> index 0eb9e726a9b8..445bf5a46c6a 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-kontron-bl-osm-s.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-kontron-bl-osm-s.dts
> @@ -23,6 +23,17 @@ extcon_usbc: usbc {
>  		id-gpios =3D <&gpio1 10 GPIO_ACTIVE_HIGH>;
>  	};
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
>  	leds {
>  		compatible =3D "gpio-leds";
> =20
> @@ -168,6 +179,14 @@ &hdmi_tx {
>  	pinctrl-0 =3D <&pinctrl_hdmi>;
>  	ddc-i2c-bus =3D <&i2c2>;
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



