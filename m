Return-Path: <linux-kernel+bounces-295574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F55959E7A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0E1D1C217E3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B2C19ABB0;
	Wed, 21 Aug 2024 13:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fXXcHn2g"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F9D199FC9
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724246233; cv=none; b=Au46hUwX7nO0Xlpk5Pyhqb/gp5xMZklFV31lhhRbExPyFWEmUYBlCYm6aFtLFI9tHDdeWVysFY5mDh3M4BbZmArllNtamMFjVWTIsDbtbYaVqEN38jKC1V5PTQsbSnNLG1cK6qzX1fByD0GBEn730tQ1c87tbmD6uGlox+hwdIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724246233; c=relaxed/simple;
	bh=WdKigC3v8C4uAS7PGrJiYWrzDKdprf8IJzEtjwcwDVA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jsKvIkdyNoYpImYxQ2TumYhtoSYYawnbVegM4XVCbHy5W60EEYGMM7+2ZUmM2xLla1zX+j8jSOmIHspLagqusikoOkaDcOho7S0xDbR9JoyiW4HQ9HD+3g3lxPIgu7sRnGuJOBiRR4bRz9DVt4yYWRjuFY2A4S6x0KBKmB3GswA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fXXcHn2g; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3AB3E20005;
	Wed, 21 Aug 2024 13:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724246224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=73Nm2/B6Xncs9FJB0DOzH6zeQokM4Em13F0I7ljPHns=;
	b=fXXcHn2gIugic7xh1nOsHGSipjV/eZsPTSSdYFu2WBJTKdZU6SnEJ5isbZNahpQzYN76/Z
	7QBFaWy/tD9SdS5dNUTyWzUZDz75GgXfeppWsiFwh0YYW4Pdpkf1xyM5F2xROTic9+yJAC
	KuwGvrHs6YLqrBDjvx32q824+9/+DJakx+mnCsHr6KGF1+CmRChP7qeOZU5AgV4f5cl4Zb
	KlIwm+DolrprINxDhAahGjoljdXS7ff4PDsF2bBAIgZ8KiN4U9uARYwPxuAl/zHuKC19cf
	rnci6p9kSn0vz0UNk9iHzMqtoUeJO96NP6+61c1dn9on3ouymaKTsFxQIhOljQ==
Date: Wed, 21 Aug 2024 15:17:01 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Alexander Dahl <ada@thorsis.com>
Cc: linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91)
 SoC support), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] mtd: nand: raw: atmel: Add message on DMA usage
Message-ID: <20240821151701.6bde9aba@xps-13>
In-Reply-To: <20240821120517.330868-1-ada@thorsis.com>
References: <20240821120517.330868-1-ada@thorsis.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Alexander,

ada@thorsis.com wrote on Wed, 21 Aug 2024 14:05:16 +0200:

> Like for other atmel drivers (serial, crypto, mmc, =E2=80=A6), too.
>=20
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
>  drivers/mtd/nand/raw/atmel/nand-controller.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/n=
and/raw/atmel/nand-controller.c
> index dc75d50d52e8..9e6dea2cf140 100644
> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> @@ -2051,6 +2051,8 @@ static int atmel_nand_controller_init(struct atmel_=
nand_controller *nc,
>  		nc->dmac =3D dma_request_channel(mask, NULL, NULL);
>  		if (!nc->dmac)
>  			dev_err(nc->dev, "Failed to request DMA channel\n");
> +		dev_info(nc->dev, "using %s for DMA transfers\n",
> +			 dma_chan_name(nc->dmac));


The message here would be misleading if !nc->dmac.

>  	}
> =20
>  	/* We do not retrieve the SMC syscon when parsing old DTs. */
>=20
> base-commit: 47ac09b91befbb6a235ab620c32af719f8208399


Thanks,
Miqu=C3=A8l

