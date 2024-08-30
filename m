Return-Path: <linux-kernel+bounces-308180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C83C965852
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A03341C22E82
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 07:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D93B152169;
	Fri, 30 Aug 2024 07:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aphyiIi+"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251F614D420
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 07:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725002597; cv=none; b=kVanZiTmjcXY9hpAm3kOmiYPDBTl1M3nSQf1N/aspdP7JLuf6ncqdcBLp3Oc3aFKKX5k56/+Z6wJPUiwpdIQOUzKh8y0bycBBD5/mrsVkaLSg5a5f8qpoVYWvq15mzXOG/S4aDEvwR/GVRQr3NCi+Rhyv3XkwB/m4V1Jddv2pOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725002597; c=relaxed/simple;
	bh=CsfdX4VreXREcQKfy2XLKK0cEMjr2ykqIlB67359JCc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OAsHlPs2qdGXoPGpS9R4z+QstIgzej2nLHD5ZfjkBbu7s6MC5ZCjYW7OWaoYVJ99ff4pxCi3fKZFqBU0WJ09EGqLbIO6lLxlLAV/UQHX79YXDqXSqo46SOBy4m5gxi6ScLSigLjawZJ8mAqyT3TplRbDO7Pk3m8Hg+cIL88q2mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aphyiIi+; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F19E2C0007;
	Fri, 30 Aug 2024 07:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725002586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zAVkfF861Ic56JJgiKarCbntV6gkuimBD0QcrSHMWW8=;
	b=aphyiIi+Y4U9NbYfwnDiAHBX/fHSozrnuS5FVh5iOvpCEmHy+IAmmsTOe+AXfuEo5XL4fw
	+LSb6psNvgCxJiRF5bKUq2ZdkoE1Bfd9AWhPTT5J/upls0Y0c8up0P6aZt1teqCkX96uZa
	Ly9AWrsX9CechBwBXnUDexDjc/xhcCjZNxuAzCZQ+w0xDu/HDLKS8u5F5l2EyH4gmkUIJN
	cBVepioFrGYkrIQyct5cW8Eq+0+7yd97Ie10thze/vXJZjiunjlrX4dQP4iOWD4cL8E/DE
	cMl4kVJAvPAtH++rIvOUgk3yaeDzi65ht0i3vLGa/P233QlxgKMCyELfsTjpTQ==
Date: Fri, 30 Aug 2024 09:23:03 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: vigneshr@ti.com, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, richard@nod.at, alvinzhou@mxic.com.tw,
 leoyu@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: Re: [PATCH v4 2/2] mtd: spinand: macronix: Use the flag in Macronix
 driver
Message-ID: <20240830092303.00ca7cc6@xps-13>
In-Reply-To: <20240829032517.1517198-3-linchengming884@gmail.com>
References: <20240829032517.1517198-1-linchengming884@gmail.com>
	<20240829032517.1517198-3-linchengming884@gmail.com>
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

Hi ChengMing,

linchengming884@gmail.com wrote on Thu, 29 Aug 2024 11:25:17 +0800:

> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
>=20
> Macronix serial NAND flash with a two-plane structure requires
> insertion of the Plane Select bit into the column address during
> the write_to_cache operation.
>=20
> Additionally, for MX35{U,F}2G14AC and MX35LF2GE4AB, insertion of
> the Plane Select bit into the column address is required during
> the read_from_cache operation.
>=20

PATH 1 is fine except the commit title, let me explain. Once applied in
the kernel tree, there is no cover letter anymore. So both titles would
be "Add support for the flag" and "Use the flag...", which is really
missing the important information as we don't know what this flag is
for. Furthermore, the fact that we decided to use a flag is an
implementation detail, what is important is the feature: setting the
plane select bit.

Can you please change the first commit title to:

mtd: spinand: Add support for setting plane select bits

and for the second, something like:

mtd: spinand: macronix: Flag parts needing explicit plane select

> Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
> ---
>  drivers/mtd/nand/spi/macronix.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macro=
nix.c
> index 3f9e9c572854..f17cd4a6f4d0 100644
> --- a/drivers/mtd/nand/spi/macronix.c
> +++ b/drivers/mtd/nand/spi/macronix.c
> @@ -118,7 +118,8 @@ static const struct spinand_info macronix_spinand_tab=
le[] =3D {
>  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>  					      &write_cache_variants,
>  					      &update_cache_variants),
> -		     SPINAND_HAS_QE_BIT,
> +		     SPINAND_HAS_QE_BIT | SPINAND_HAS_PP_PLANE_SELECT_BIT |
> +		     SPINAND_HAS_READ_PLANE_SELECT_BIT,

And I know this is not what the normal coding style would ask for, but
I would prefer to have the two plane select bits on the same line if
possible, otherwise on two independent lines, so either:

		QE_BIT |
		PP_SELECT_BIT | READ SELECT_BIT,

or otherwise:

		QE_BIT |
		PP_SELECT_BIT |
		READ SELECT_BIT,

And finally, could we name the former

		SPINAND_HAS_PROG_PLANE_SELECT_BIT

? Because "PP" sounds a little bit too cryptic.

Thanks,
Miqu=C3=A8l

