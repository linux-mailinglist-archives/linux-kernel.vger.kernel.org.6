Return-Path: <linux-kernel+bounces-304548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 548B89621A3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D455A283DBF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E3D158DCA;
	Wed, 28 Aug 2024 07:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="A4tt0Y36"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF8515747A
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 07:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724831254; cv=none; b=ZfYeq4HVjUwBsm3i5xvNdxhsYxwiQnIBbnmCTxczgfbi0K+45iWR38j+TPUrEoxcn/7cKQlJDE7DNttm0BSQzVtqROjZBaZ8brEoGvXXN6mUnIMNoXaYDDkHtZJB0Vu1u8DpnMYmoH048VdMyxK4hSZOvByCSyEIC8aRY7D8r/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724831254; c=relaxed/simple;
	bh=Rwtd+CIwYha98ZxaPGySKJ36IxJt+VFHlilRv3Vfwfo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jKcSI1zo2THLhzd65ILPshohf3Noo4gZwsQbVDNhnc2ToKxysPubyAb7+uNlmjVOcqte/j57zzynKqvKPJ7vv4aJjRJiDIlRygPA5c/IFjf5l7lszTgoF32K73nsaEfd5dhnxaZeNS5JYlch7GQ93m1wU1+OQZBPIRikOiskFdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=A4tt0Y36; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5D86440007;
	Wed, 28 Aug 2024 07:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724831250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qWrlTCWWGOIyj8nUZEHFjDyckZYNn8zv+mKR4yA6aq0=;
	b=A4tt0Y36w7BFNx5+H9xP7FvSxfcbjc3oat9uYCEsw2DzkOKtFTqOygG+R1qpdwinv7LJpt
	SI+BXX1Vg/o15ia0FBq0gmjNTam799te6yOpG9Da1GL0r4I36dYrwvOqEtA2OafW1GPaOM
	rXZ5YBX0qxnAZfrbvbpv97m4WpeTc/2+dhZ71mL+QszIiiT8dBop+MAtG0BEKsb3T7sobn
	7ZsMpy7vj2h5pmXXWN4q8AvdrkqmWPo+WSuTYbFnVn58nx/t6jWrqOWeZtv8nzvQRYUKrL
	xPCYHjbef3HDOWeJDGVIj026pi5ttsgVLlavk5vgcohZzkqnB5TBz8nh4KLb+g==
Date: Wed, 28 Aug 2024 09:47:28 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: vigneshr@ti.com, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, richard@nod.at, alvinzhou@mxic.com.tw,
 leoyu@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: Re: [PATCH v3 1/1] mtd: spinand: Add flags for the Plane Select bit
Message-ID: <20240828094728.583dc7c5@xps-13>
In-Reply-To: <20240828062131.1491580-2-linchengming884@gmail.com>
References: <20240828062131.1491580-1-linchengming884@gmail.com>
	<20240828062131.1491580-2-linchengming884@gmail.com>
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

Hi Cheng,

linchengming884@gmail.com wrote on Wed, 28 Aug 2024 14:21:31 +0800:

> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
>=20
> Add support for Macronix serial NAND flash with a two-plane structure.
>=20
> Add the SPINAND_HAS_PP_PLANE_SELECT_BIT flag for serial NAND flash
> that require inserting the Plane Select bit into the column address
> during the write_to_cache operation.
>=20
> Add the SPINAND_HAS_READ_PLANE_SELECT_BIT flag for serial NAND flash
> that require inserting the Plane Select bit into the column address
> during the read_from_cache operation.
>=20
> Macronix serial NAND flash with a two-plane structure requires insertion
> of the Plane Select bit into the column address during the write_to_cache
> operation.
>=20
> Additionally, for MX35{U,F}2G14AC and MX35LF2GE4AB, insertion of the
> Plane Select bit into the column address is required during the
> read_from_cache operation.
>=20
> Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
> ---
>  drivers/mtd/nand/spi/core.c     |  6 ++++++
>  drivers/mtd/nand/spi/macronix.c | 17 ++++++++++-------
>  include/linux/mtd/spinand.h     |  2 ++
>  3 files changed, 18 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index e0b6715e5dfe..49f2d66c3a9c 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -386,6 +386,9 @@ static int spinand_read_from_cache_op(struct spinand_=
device *spinand,
>  	else
>  		rdesc =3D spinand->dirmaps[req->pos.plane].rdesc_ecc;
> =20
> +	if (spinand->flags & SPINAND_HAS_READ_PLANE_SELECT_BIT)
> +		column |=3D req->pos.plane << fls(nanddev_page_size(nand));
> +
>  	while (nbytes) {
>  		ret =3D spi_mem_dirmap_read(rdesc, column, nbytes, buf);
>  		if (ret < 0)
> @@ -460,6 +463,9 @@ static int spinand_write_to_cache_op(struct spinand_d=
evice *spinand,
>  	else
>  		wdesc =3D spinand->dirmaps[req->pos.plane].wdesc_ecc;
> =20
> +	if (spinand->flags & SPINAND_HAS_PP_PLANE_SELECT_BIT)
> +		column |=3D req->pos.plane << fls(nanddev_page_size(nand));

Please separate the core changes and the macronix changes.
1. Add support for the flag in the core (and the include)
2. Use the flag in Macronix driver.

> +
>  	while (nbytes) {
>  		ret =3D spi_mem_dirmap_write(wdesc, column, nbytes, buf);
>  		if (ret < 0)
> diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macro=
nix.c
> index 3f9e9c572854..a531cc8121ff 100644
> --- a/drivers/mtd/nand/spi/macronix.c
> +++ b/drivers/mtd/nand/spi/macronix.c
> @@ -118,7 +118,8 @@ static const struct spinand_info macronix_spinand_tab=
le[] =3D {
>  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>  					      &write_cache_variants,
>  					      &update_cache_variants),
> -		     SPINAND_HAS_QE_BIT,
> +		     SPINAND_HAS_QE_BIT | SPINAND_HAS_PP_PLANE_SELECT_BIT |
> +			 SPINAND_HAS_READ_PLANE_SELECT_BIT,

Alignment:	     ^



...

> @@ -263,7 +266,7 @@ static const struct spinand_info macronix_spinand_tab=
le[] =3D {
>  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>  					      &write_cache_variants,
>  					      &update_cache_variants),
> -		     SPINAND_HAS_QE_BIT,
> +		     SPINAND_HAS_QE_BIT | SPINAND_HAS_PP_PLANE_SELECT_BIT,
>  		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
>  				     mx35lf1ge4ab_ecc_get_status)),
>  	SPINAND_INFO("MX35UF2G24AD-Z4I8",
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index 5c19ead60499..cec451e7c71c 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -312,6 +312,8 @@ struct spinand_ecc_info {
> =20
>  #define SPINAND_HAS_QE_BIT		BIT(0)
>  #define SPINAND_HAS_CR_FEAT_BIT		BIT(1)
> +#define SPINAND_HAS_PP_PLANE_SELECT_BIT		BIT(2)
> +#define SPINAND_HAS_READ_PLANE_SELECT_BIT		BIT(3)

Do you think we can have the PP plane select bit without the read plane
select bit? I'd use a single flag for now.

> =20
>  /**
>   * struct spinand_ondie_ecc_conf - private SPI-NAND on-die ECC engine st=
ructure


Thanks,
Miqu=C3=A8l

