Return-Path: <linux-kernel+bounces-271262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B31F944BC0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8539DB25783
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8104D1A01B7;
	Thu,  1 Aug 2024 12:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="JD+n8Gz/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ReeR2HcB"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D114819AD87
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 12:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722516827; cv=none; b=JrSeBnRkUSVIWTgX7yiRsrKApKemRcu5B60WTwczbmJA7+JmRLcWwGWwvclk+p2b+qqsl9hP0ZhbM86byL0m9AIy1gWaNfLN0pZkDLKLm/T9praWq8VdCojx8ZBimz4TMaFLd2meEgPC1bfunvnbfc+SlpbZquModOKt0N9vXBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722516827; c=relaxed/simple;
	bh=v9BU2Ym8itRRayZMc51Ys/qzHezRUayDzP4dpbmnsUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fg28cudedGRQJoiJzPf4PgGn8h8IPYGZWnxnjiBPo0NPlELdRNhoa9H0YDmmOH+OT6axqYKCDqhK5KsZiv2K2EpB7fZjrzTaU0MywdRkj7F2daBzISWdKgDZenvDl5taQugW4I7rVmvx3LaWakp3wbqDSzLVj3mXYDada4jo1wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=JD+n8Gz/; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=ReeR2HcB reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1722516824; x=1754052824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JO4+VX3RecD7tvJ/44espFD0o4ZVH+vHrUDyMVyNI2c=;
  b=JD+n8Gz/RH4jda/+WGk+unHKqPuhaGPKovwMqdA3pVhyY8ut9LgiU3Ux
   UtBzqebTbdx1sUMrrDMa55uiqMzZhqDz2pRcUb2Nn9d27A3vWdB9Q39Cc
   4SBCPUj5shwAgztIoblCUagVqHI3j+UcEw2mpDxWvVcFX4ITgdj9J6qlT
   g6SH76NvRM/EfBgB5OVou9K0HxV58+eMc6So7L4gMWOKrBJVFNrDdbjL7
   NS4nsr3NLS8uhS8Jr4D2eq10el6A6piFo5yrvAI9TOu+sNxqpfjlxMTW2
   c6uD6XEouBLaVDqINf0zivZRKds1NZ5uWaNQ/immMVYnggk2YWPABimih
   g==;
X-CSE-ConnectionGUID: R4jLy6u6Q72g/1BWXl0zkA==
X-CSE-MsgGUID: 4vwozDPUTTi1Xt55UQjKYg==
X-IronPort-AV: E=Sophos;i="6.09,254,1716242400"; 
   d="scan'208";a="38198538"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 01 Aug 2024 14:53:41 +0200
X-CheckPoint: {66AB8555-F-E8EE7C4B-C1098986}
X-MAIL-CPID: 42072174400B03E93173B808A0A42CB1_5
X-Control-Analysis: str=0001.0A782F24.66AB8556.0014,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 27B99165FF9;
	Thu,  1 Aug 2024 14:53:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1722516817;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=JO4+VX3RecD7tvJ/44espFD0o4ZVH+vHrUDyMVyNI2c=;
	b=ReeR2HcBCaIrVbwR1ZsZwOoFsn52E5tJ7o/atRp4D6AxRBJQUGAAvQVUCZkFlv85oWJdY7
	oAJSx4X1Hb2GgFb8q7DxP2+yCp67Z2GIxyjmVSW9Un++zJtIAzPFLk8BxljZ76ZYNogMhJ
	U2VOBEQfHTjws4TNwzS8Pyn18jonFiY76sKRfM2rc78sJ+cBUPFWCt+e6iUhsVRglOfMZg
	QmF2DgKwCA7/bmOjx+zD0OAScg8oYCv8YavAcumMFJISDnlN20Q0tUMKQ9HgDiwcyEhqXj
	FKaAIM0UauoUydPIho1rfnI+aNO0BIEqxLlAO0KBLDwStkCW8sTfvPAEmfYaUQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: vkoul@kernel.org, kishon@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, Xu Yang <xu.yang_2@nxp.com>
Cc: jun.li@nxp.com, xu.yang_2@nxp.com, linux-phy@lists.infradead.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] phy: fsl-imx8mq-usb: fix tuning parameter name
Date: Thu, 01 Aug 2024 14:53:36 +0200
Message-ID: <4195136.aeNJFYEL58@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240801124642.1152838-1-xu.yang_2@nxp.com>
References: <20240801124642.1152838-1-xu.yang_2@nxp.com>
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

Am Donnerstag, 1. August 2024, 14:46:42 CEST schrieb Xu Yang:
> According to fsl,imx8mq-usb-phy.yaml, this tuning parameter should be
> fsl,phy-pcs-tx-deemph-3p5db-attenuation-db.
>=20
> Fixes: 63c85ad0cd81 ("phy: fsl-imx8mp-usb: add support for phy tuning")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

Look good to me:
Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>

> ---
> Changes in v2:
>  - add fixes
> Changes in v3:
>  - correct fixes commit
> ---
>  drivers/phy/freescale/phy-fsl-imx8mq-usb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c b/drivers/phy/fre=
escale/phy-fsl-imx8mq-usb.c
> index 0b9a59d5b8f0..adc6394626ce 100644
> --- a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
> +++ b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
> @@ -176,7 +176,7 @@ static void imx8m_get_phy_tuning_data(struct imx8mq_u=
sb_phy *imx_phy)
>  		imx_phy->comp_dis_tune =3D
>  			phy_comp_dis_tune_from_property(imx_phy->comp_dis_tune);
> =20
> -	if (device_property_read_u32(dev, "fsl,pcs-tx-deemph-3p5db-attenuation-=
db",
> +	if (device_property_read_u32(dev, "fsl,phy-pcs-tx-deemph-3p5db-attenuat=
ion-db",
>  				     &imx_phy->pcs_tx_deemph_3p5db))
>  		imx_phy->pcs_tx_deemph_3p5db =3D PHY_TUNE_DEFAULT;
>  	else
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



