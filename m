Return-Path: <linux-kernel+bounces-270892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A759446B1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EE261C2099D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D7016E89C;
	Thu,  1 Aug 2024 08:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="UYtmAWEc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="SS5wm3pI"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95007157A55
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 08:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722501332; cv=none; b=VVLqKAAqpRE9tt/MqgkY0Ueg8U94gSOzTtFMMi+3ZCSnsGcIBq/NYV2yJ1eE1OKwK+GuFjyzpKpwkhI7nqz894Yq1J8Q4qUq2/1e/zk8sx3C4fQc2uFJydnRPGmw3+jyCbuhQG8JJ+tkvjjQxi5+7La40L41ZwMQQsE9Xbr8cGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722501332; c=relaxed/simple;
	bh=s5cu1q2+ZQtA9fPTEFQQgsSNqAwMloYk1udsdbOntZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qJfhrO8PfG4YbI2T6XCDkyxPSGMfHsof89/K368I9RSG//0oTVTJ041YxVee8dpDOLgZsxGD4EmF2xb1ZL7M7HRBJueKdeMIpe9B9DSj3WKXMVK5LBhz4as9UlNERDr8UdOvih+IfSe2VQjHVdeVUrN80ZGrrizhUA/bmt4GYaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=UYtmAWEc; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=SS5wm3pI reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1722501329; x=1754037329;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e2z2XK6Q2ktr4OcaidIWXvGR/XpR94af8Q5pcDbFQ28=;
  b=UYtmAWEc2hxL29N9UWu+FX7vf+wn3zWPjtd4CQLeauIJEBJdmjuR9usw
   hr/AW5Rbtt33RmMH8x3bWlu593lE6Sn3Ig1gRaErIB0mXwQXBB3OyrEpe
   9moKWaV4cXGAQEvAAvggK0s2xI+JuD2ERbysMlXvZObV6fBbhVnZCQa7c
   Q8+MOi8O4WbPSzUC8dyMKC5gZkBKBC7KvCqnndpED0vJcClEbdXENub8g
   pN846S+s6875HiI63l1W/NiTJius5gX/aFpXuCHyil7zkyW+k4xcjzmtB
   8S2aueg8ejXysRFZvJ9LxW8ySCa2uvsYv7uLvfgze+r430/IkSXydi1Wd
   Q==;
X-CSE-ConnectionGUID: tCTULouRR8iw2dDlX5uW3w==
X-CSE-MsgGUID: wOK98NYFTW2+gIrxHtOQQQ==
X-IronPort-AV: E=Sophos;i="6.09,254,1716242400"; 
   d="scan'208";a="38191023"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 01 Aug 2024 10:35:20 +0200
X-CheckPoint: {66AB48C8-24-2D4D5AC2-F2EAEA09}
X-MAIL-CPID: 25B8214773C672C9B011DFACE12BA7A9_3
X-Control-Analysis: str=0001.0A782F1B.66AB48C9.002D,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E0CA01656CA;
	Thu,  1 Aug 2024 10:35:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1722501316;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=e2z2XK6Q2ktr4OcaidIWXvGR/XpR94af8Q5pcDbFQ28=;
	b=SS5wm3pIEqH5lkOGgxtNTaa1Mlt7GIP/o5fFB9NN0abWohsWtg4JDhJWJPkzDNiuOHphRL
	KGAXBoa7LcEHTRxyXhEEP0zBjwQoPBOrJG9jp3+CHiGpzWZmb3ufr8zdH6xRY27L2ov4ZA
	2zTllFbMTz3fqv+86CppDfk/Qlvk75FC1Dm0CE+5SjbkXhGDNk6UAM0lWyzF12N9NW9F8a
	ya4DbAWjdV1tUCRqP2utQPc3o/mtQhZosEwGxgWUFV9kR6F12le+LZdvj9WsLWZKfSQXxc
	T3wH2lNUHmDdWJGlAo7/sRzf7w1K1W9iFz5O69LvJ0XaW4SJ9reKLerpkCE0Pg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: vkoul@kernel.org, kishon@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, Xu Yang <xu.yang_2@nxp.com>
Cc: jun.li@nxp.com, xu.yang_2@nxp.com, linux-phy@lists.infradead.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: fsl-imx8mq-usb: fix tuning parameter name
Date: Thu, 01 Aug 2024 10:35:15 +0200
Message-ID: <5802707.GXAFRqVoOG@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240801065716.3819399-1-xu.yang_2@nxp.com>
References: <20240801065716.3819399-1-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Am Donnerstag, 1. August 2024, 08:57:16 CEST schrieb Xu Yang:
> According to fsl,imx8mq-usb-phy.yaml, this tuning parameter should be
> fsl,phy-pcs-tx-deemph-3p5db-attenuation-db.

Should this include a Fixes tag?

Best regards,
Alexander

> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
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



