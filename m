Return-Path: <linux-kernel+bounces-204404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE2D8FE845
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6AE81C242E8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582E9196C89;
	Thu,  6 Jun 2024 13:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wn8hi4P9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0027196442
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717682346; cv=none; b=SMCDDMGX6v3Zsl7SLj3U0KAPanmarB9+FgkNVsZ0EQ8RnMeAln3RHMR3g8XY3RZ3nPBqWlDLntXzBJZ1QZPuq24sNEyqdOKWxtKqf3gOiG69L3L8AIc9uKUJ6vyzhbdxBVRNWtfrWktUer5mK5/iPdnoQ7G+3Cymg4miu+S6kqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717682346; c=relaxed/simple;
	bh=2Ve9ZFIgEEJtTpjQsDrIZbNhAjC7L4m5KDK2f+Vh7Yg=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=IGmbdN7FrQ1aJflBRAttua6WmPWDZsVL+MxQqBaWy1CYzKTafrT09r4ChqlUfHX1EBAVFFrh2Vw27D3a9S6crdHzVOEPh4wT7MtuBmr+MyOyQzTA7Z9vi6gFQDUWTIr6xFTg7NCZSxtFlvYmc8P3Bi8wi4O4bUcF4sZ7hOFtH6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wn8hi4P9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5B1C4AF09;
	Thu,  6 Jun 2024 13:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717682346;
	bh=2Ve9ZFIgEEJtTpjQsDrIZbNhAjC7L4m5KDK2f+Vh7Yg=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=Wn8hi4P9U2qBFgDuVgEjHlWAwhuILkAUGFbm97IYCmfvDAAorXQ78B9Qqq6+X6k42
	 sKArPhW7tfZQHG/hdqdd8x2sBDkPtzj25rFf4VwhPTSk73sYzbLeJ/N2ejhtOHU0fR
	 kzVR14F3lQWcz2lRrfgQKvYbvwUNN58GAuhu/bthqHFFWoNcSraff8IbhVT4R8TRF1
	 kY8MXOTZZ395Bzigl28E4T6HvlGjdRfacF0VuESvNkWT1pwJaH6Pw2s9a+jCplAzda
	 MvoBF7vcbFlsSTU35w+yysetz2HihXS7olV2kye1vaoXEYGHDPq3cChIMwHESbkC38
	 jZBZpWPGrHnlw==
Content-Type: multipart/signed;
 boundary=40d3332916f6cfb5de41c586af81bc2c52a481e977090dafbcaf8e3348e3;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Thu, 06 Jun 2024 15:59:01 +0200
Message-Id: <D1SZKLZBDDBA.1Z7ZD4UEOX05F@kernel.org>
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: core: add flag for doing optional
 SFDP
Cc: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>, "Rasmus
 Villemoes" <rasmus.villemoes@prevas.dk>
From: "Michael Walle" <mwalle@kernel.org>
To: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Esben Haabendal"
 <esben@geanix.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>
X-Mailer: aerc 0.16.0
References: <20240603-macronix-mx25l3205d-fixups-v2-0-ff98da26835c@geanix.com> <20240603-macronix-mx25l3205d-fixups-v2-1-ff98da26835c@geanix.com> <a379a411-2c9e-4d9d-aa8f-4c4f3463cc27@linaro.org>
In-Reply-To: <a379a411-2c9e-4d9d-aa8f-4c4f3463cc27@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--40d3332916f6cfb5de41c586af81bc2c52a481e977090dafbcaf8e3348e3
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Jun 6, 2024 at 3:31 PM CEST, Tudor Ambarus wrote:
> On 6/3/24 14:09, Esben Haabendal wrote:
> > A dedicated flag for triggering call to
> > spi_nor_sfdp_init_params_deprecated() allows enabling optional SFDP rea=
d
> > and parse, with fallback to legacy flash parameters, without having dua=
l,
> > quad or octal parameters set in the legacy flash parameters.
> >=20
> > With this, spi-nor flash parts without SFDP that is replaced with a
> > different flash NOR flash part that does have SFDP, but shares the same
> > manufacturer and device ID is easily handled.
> >=20
> > Signed-off-by: Esben Haabendal <esben@geanix.com>
> > ---
> >  drivers/mtd/spi-nor/core.c | 3 ++-
> >  drivers/mtd/spi-nor/core.h | 1 +
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> > index 3e1f1913536b..1c4d66fc993b 100644
> > --- a/drivers/mtd/spi-nor/core.c
> > +++ b/drivers/mtd/spi-nor/core.c
> > @@ -2933,7 +2933,8 @@ static void spi_nor_init_params_deprecated(struct=
 spi_nor *nor)
> > =20
> >  	spi_nor_manufacturer_init_params(nor);
> > =20
> > -	if (nor->info->no_sfdp_flags & (SPI_NOR_DUAL_READ |
> > +	if (nor->info->no_sfdp_flags & (SPI_NOR_TRY_SFDP |
>
> I don't like that we update deprecated methods. The solution though is
> elegant.

I actually had the same concern. But currently there is no
non-deprecated way to handle this case, right?

Right now we have the following cases:
 (1) pure SFDP parsing
 (2) non-SFDP flashes with static configuration only
 (3) legacy implementation, where the magic flags decide whether we
     use SFDP

Which case is eventually used depends on the ID of the flash -
assuming there will only be IDs which either fall into (1) *or* (2).
That assumption is clearly wrong :)

I'd propose a new case in spi_nor_init_params()
 (4) try SFDP with a fallback to the static flags from the
     flash_info db.

-michael

--40d3332916f6cfb5de41c586af81bc2c52a481e977090dafbcaf8e3348e3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZmHApRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/jQQgGAsuqjHK9tnVfMizoJMfOwKCWc/YHYfi9P
/XFj/2o3leAtvFU9UaG6P7wRv4SZ8q6EAX4kTKZ6JJn6zIr/yKseuvNNTtENChOi
6ljlYeYbdzELIbsX3+YzBARrFtx/x51cgzQ=
=rQmu
-----END PGP SIGNATURE-----

--40d3332916f6cfb5de41c586af81bc2c52a481e977090dafbcaf8e3348e3--

