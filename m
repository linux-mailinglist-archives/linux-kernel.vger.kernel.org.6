Return-Path: <linux-kernel+bounces-204551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EAF8FF05B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F34B28E00E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89ABA19D093;
	Thu,  6 Jun 2024 15:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yud4c4G8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC79F197513
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 15:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717686395; cv=none; b=n5H3H94KIzSbO9wV0Jx2cdPhsZnBXTPYTrhYBAqM7gKSTf3LARW8+JRGcbSbXgUExNrYy868jAbak84Wp61U/H7rAZ0ccu+zGbRmMXZRqjspIENqOMPyne4W2zYEmyyfczY4i/h0VtJt+iqn5RXWigsza1J3AUjkAMGwh0no9jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717686395; c=relaxed/simple;
	bh=t5xQJkmzKQzOdNcS+FJKDDzMs96fqnEU6mLD06I3cxM=;
	h=Content-Type:Date:Message-Id:Cc:From:To:Subject:References:
	 In-Reply-To; b=h5LTqKoLok1N7ekWtcsB/LrCxCdOMDAnXMS2Ee6yHlzfoSz8Lnq4pP6/luTbvrATxj3VnWNHqSZM/X96eQrhNc7r/7TNHeBO0YoShUrUCg2VD4WghjwJAk7XQkBk4juQL9oJEZyL1pSqORgKwtyYxta8PiJnHGFo6wTbXJ2BMJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yud4c4G8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0488DC2BD10;
	Thu,  6 Jun 2024 15:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717686395;
	bh=t5xQJkmzKQzOdNcS+FJKDDzMs96fqnEU6mLD06I3cxM=;
	h=Date:Cc:From:To:Subject:References:In-Reply-To:From;
	b=Yud4c4G8n2reoXZ4gev4eOF90XOJMKiea9vZJVbueAADAVoWBb+nvL5rJOrR7Ezkd
	 U6GrOrIg2rov/yXVuYmEz22ysYgzj5XppVKU8J4dowaZw7bynyWm97aP2nzqbn1s6s
	 VMIiKqwqIM05C6sB9sASYpOJqpslWF9mif24mDx9r1oLlUNt8Irz8cO05+w830pIBQ
	 XIplwXTNtyg1bPb8O0eZ1WCPLFpke0oEuhYNa/l3J8ISkrMtYlvoFIQhRMuVqQydGz
	 /VmWdAbSFp0PHpmvL5EahTCHDIqF6EZI9LawuGJ2cAHnuT7vOdq2MpVGRAwQ3jVyjM
	 iQks4fxpuciNw==
Content-Type: multipart/signed;
 boundary=48bbdfa44b4d289b745038c01d8a032d6d7c501116f3081de0c010ed1031;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Thu, 06 Jun 2024 17:06:31 +0200
Message-Id: <D1T10API5U80.1OKB56YTFGMTN@kernel.org>
Cc: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>, "Rasmus
 Villemoes" <rasmus.villemoes@prevas.dk>
From: "Michael Walle" <mwalle@kernel.org>
To: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Esben Haabendal"
 <esben@geanix.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: core: add flag for doing optional
 SFDP
X-Mailer: aerc 0.16.0
References: <20240603-macronix-mx25l3205d-fixups-v2-0-ff98da26835c@geanix.com> <20240603-macronix-mx25l3205d-fixups-v2-1-ff98da26835c@geanix.com> <a379a411-2c9e-4d9d-aa8f-4c4f3463cc27@linaro.org> <D1SZKLZBDDBA.1Z7ZD4UEOX05F@kernel.org> <48719b0f-1a7f-47f9-948a-c981a0a29b41@linaro.org>
In-Reply-To: <48719b0f-1a7f-47f9-948a-c981a0a29b41@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--48bbdfa44b4d289b745038c01d8a032d6d7c501116f3081de0c010ed1031
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Jun 6, 2024 at 4:52 PM CEST, Tudor Ambarus wrote:
> On 6/6/24 14:59, Michael Walle wrote:
> > On Thu Jun 6, 2024 at 3:31 PM CEST, Tudor Ambarus wrote:
> >> On 6/3/24 14:09, Esben Haabendal wrote:
> >>> A dedicated flag for triggering call to
> >>> spi_nor_sfdp_init_params_deprecated() allows enabling optional SFDP r=
ead
> >>> and parse, with fallback to legacy flash parameters, without having d=
ual,
> >>> quad or octal parameters set in the legacy flash parameters.
> >>>
> >>> With this, spi-nor flash parts without SFDP that is replaced with a
> >>> different flash NOR flash part that does have SFDP, but shares the sa=
me
> >>> manufacturer and device ID is easily handled.
> >>>
> >>> Signed-off-by: Esben Haabendal <esben@geanix.com>
> >>> ---
> >>>  drivers/mtd/spi-nor/core.c | 3 ++-
> >>>  drivers/mtd/spi-nor/core.h | 1 +
> >>>  2 files changed, 3 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> >>> index 3e1f1913536b..1c4d66fc993b 100644
> >>> --- a/drivers/mtd/spi-nor/core.c
> >>> +++ b/drivers/mtd/spi-nor/core.c
> >>> @@ -2933,7 +2933,8 @@ static void spi_nor_init_params_deprecated(stru=
ct spi_nor *nor)
> >>> =20
> >>>  	spi_nor_manufacturer_init_params(nor);
> >>> =20
> >>> -	if (nor->info->no_sfdp_flags & (SPI_NOR_DUAL_READ |
> >>> +	if (nor->info->no_sfdp_flags & (SPI_NOR_TRY_SFDP |
> >>
> >> I don't like that we update deprecated methods. The solution though is
> >> elegant.
> >=20
> > I actually had the same concern. But currently there is no
> > non-deprecated way to handle this case, right?
> >=20
> > Right now we have the following cases:
> >  (1) pure SFDP parsing
> >  (2) non-SFDP flashes with static configuration only
> >  (3) legacy implementation, where the magic flags decide whether we
> >      use SFDP
> >=20
> > Which case is eventually used depends on the ID of the flash -
> > assuming there will only be IDs which either fall into (1) *or* (2).
> > That assumption is clearly wrong :)
> >=20
> > I'd propose a new case in spi_nor_init_params()
> >  (4) try SFDP with a fallback to the static flags from the
> >      flash_info db.
> >=20
>
> that's not that bad, but I would avoid doing it if it's not common. You
> also have to update the core a bit, you can't use no_sfdp_flags &
> TRY_SFDP, it's misleading. Does it worth it?

IMHO no_sfdp_flags is the correct place (maybe TRY_SFDP is wrong,
maybe SFDP_FALLBACK?) because the flash is first treated like in
case (2). Then SFDP is tried based on that flag. Is it worth it? I
don't know, Esben is doing the development here ;) So up to him.

> I won't oppose too much, but to me it feels that we're trying to keep
> alive a dead man.

Maybe, but we'd have a readily solution if we face a similar
problem in the future. I'm really not sure, how many flashes there
are, but I think these magic bits (which tells the legacy
implementation to try SFDP) will mask quite a few of these.
I.e. in an ideal world where we could finally drop case (3) and
you'd need to split the flashes between case (1) or (2), I think
there will be quite some in (4).

-michael

--48bbdfa44b4d289b745038c01d8a032d6d7c501116f3081de0c010ed1031
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZmHQeBIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/hHwgGAywOWh3khxUUBqo9KpBYthNWyTwg5r+JC
QA2h6D760/WVfmcw3eos2/NR2VaD7UbnAYClrniZd4iKs+P3e7UCcwIUApI2SWvo
BQnsunTQYn1An7jxuUEtvWHBVYB5Mj4rGXM=
=2+Ya
-----END PGP SIGNATURE-----

--48bbdfa44b4d289b745038c01d8a032d6d7c501116f3081de0c010ed1031--

