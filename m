Return-Path: <linux-kernel+bounces-271219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 824CD944B32
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 330F71F224D5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B95C17084F;
	Thu,  1 Aug 2024 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="GYHJ8Inj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="R/X/Ba3l"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064611CA81
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 12:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722515065; cv=none; b=oNsudA+OZVJvQBgkPol0IfjNMUztD+uPP4vVfL5Vh3MFgeKGytmz+sp4q2sAIuaqgWOHQr2nbkm66qhYNt3aPOp+F3dH34zqhufG/NxJ0Ila7hifCcVZTsLLDvBBn8i1DMk+sOtLLP+Z9Bqz9q6y6JasonY1dQ7JA9h9tx8BGo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722515065; c=relaxed/simple;
	bh=vNnaXYdIuORBs84i1qmjV+yMJwAjh2LYvZ3FkoMSE+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qR/No/cFiwx46oDX0ng9mzJSH04Uwc0DeZ5DwBF6c6CqQJ5koE2u3zmvputLb1sIq17qFgaOcZ/G56evkBubshiNqZSDH1zs2xdktWJPBE2aze650R3OaCOYq9nGVFrq0Tuo++lc9Bkxzw9VfYOQ6fgYhPznb9qrTAgJqP+n45w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=GYHJ8Inj; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=R/X/Ba3l reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1722515062; x=1754051062;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4Edi3d3y1GCSfDDNLxe+86RqW3hGIUB+NFjNqh7Asms=;
  b=GYHJ8InjkcwuaqgIUYQUqhVYGRb6oXt9b72AGNmPwxMsnt73N6tNC/s7
   2Wzge8+lleEfb4GsjPKamdlbJqcKKT2U8RsTWj5K0K9KoVa32V7hItUrJ
   7lf3GBvjyNVz8I5Xwc116rwqrW9OWUlo2u9ePm/JT8a9NuMDU0m3u7kbq
   DHC0mToJ7wGus3hi/Uf7bRdVk9jD51fePu/TQDN9egohLwYK+LzOMJH1K
   RnvUp+TIp0VDo//Bvl8bQFGr5vdlw6cauBk2rwBIeKTZadzBg17qKiqIv
   dtXNQJqjpbAZPtmINhe85hzf1OM416gheTwkQ84oZnsjf620zAWYw9fPg
   A==;
X-CSE-ConnectionGUID: VHGJl9vtQ7WP8mqBMssTHA==
X-CSE-MsgGUID: vfkU7GO3TsSXEj8/S8z9mw==
X-IronPort-AV: E=Sophos;i="6.09,254,1716242400"; 
   d="scan'208";a="38197656"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 01 Aug 2024 14:24:19 +0200
X-CheckPoint: {66AB7E73-1A-E8EE7C4B-C1098986}
X-MAIL-CPID: DEBEDEDA394C2436DE9E9A30FB8DAE5B_5
X-Control-Analysis: str=0001.0A782F26.66AB7E74.002C,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7C911161531;
	Thu,  1 Aug 2024 14:24:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1722515055;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4Edi3d3y1GCSfDDNLxe+86RqW3hGIUB+NFjNqh7Asms=;
	b=R/X/Ba3lJPIp7nSK+bTtsYaxkeVQ5fnMt+7KYUBUFrwcDIX77009Chc3r6kxlc009uIRiU
	FN7m7j+kl4CFxrhBUZT37uiQcMZxIJbt6ocyIyfhpnaqO+WZTI1wQtihdSe6l+UUDxUH8f
	GYrZmlmAnOfr+0bOntE5v/GuN7e0q/txoSghOefNl3hm6MaicZVSFhQ68jLk6++L/TE6MS
	WyFVll9qmr8klYM6UnekCIlrqbtfzxPhQC3/Yel/rUFhdD32Xt6baxYQZcbEovARvx0aFm
	XwBP5NCdfwmynzRDPmgk4JPrVY3NDfiw/WLtddlZzryQG7U5qb3RogF1IHqJBg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: vkoul@kernel.org, kishon@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, Xu Yang <xu.yang_2@nxp.com>
Cc: jun.li@nxp.com, xu.yang_2@nxp.com, linux-phy@lists.infradead.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] phy: fsl-imx8mq-usb: fix tuning parameter name
Date: Thu, 01 Aug 2024 14:24:15 +0200
Message-ID: <14458406.uLZWGnKmhe@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240801110136.1031689-1-xu.yang_2@nxp.com>
References: <20240801110136.1031689-1-xu.yang_2@nxp.com>
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

Am Donnerstag, 1. August 2024, 13:01:36 CEST schrieb Xu Yang:
> According to fsl,imx8mq-usb-phy.yaml, this tuning parameter should be
> fsl,phy-pcs-tx-deemph-3p5db-attenuation-db.
>=20
> Fixes: c971874a89e1 ("phy: fsl-imx8mq-usb: fix tuning parameter name")

Maybe you accidently selected the wrong commit here. I think this should be
=46ixes: 63c85ad0cd811 ("phy: fsl-imx8mp-usb: add support for phy tuning")

Best regards,
Alexander

> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
>=20
> ---
> Changes in v2:
>  - add fixes
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



