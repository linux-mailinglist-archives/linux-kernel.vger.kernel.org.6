Return-Path: <linux-kernel+bounces-248869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A26F92E2F5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BDD61C2196C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D39C1552E1;
	Thu, 11 Jul 2024 09:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTAh+PNI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CE4653
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 09:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720688569; cv=none; b=m9fgxe9p9WRoCdQMbm8hHUsQR/j1MNehuRupct9q2fi4OXoZX1eGYbW/bxC9wRm7dCXHjgs7VSkPGa7NBIJRFwaOqOmVKOVxWM4oA00dL5/nJd6rVjZ5ZQUwkGE0DgZZg/ZO5p4vN8RctYvMA6iQ/oT01+/t6oI2pbQSrYC4mRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720688569; c=relaxed/simple;
	bh=i9vhBcgM+kslb9tjmXIu2Ni6MbJN5bXv00H5799sU0s=;
	h=Content-Type:Date:Message-Id:From:To:Subject:Cc:References:
	 In-Reply-To; b=sGpzidFdrtdeuey3stTEEFFkIzy01HKIqKEEGtekOwMm0lOxRu4cYNsUZV0ea/8x4Zxx8dupL1YHPAu5zZcuGyLcpAWk4W6KH9RUCrt15zeX2E6JvLq25SlEweTGwXGqTZOT6j89qiT+4F8Y8AGXU8CVws9jGeXFBmYGWb3qFQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTAh+PNI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB79FC116B1;
	Thu, 11 Jul 2024 09:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720688569;
	bh=i9vhBcgM+kslb9tjmXIu2Ni6MbJN5bXv00H5799sU0s=;
	h=Date:From:To:Subject:Cc:References:In-Reply-To:From;
	b=UTAh+PNIC8oY2FsfTnf13lwV6IGg52xwu2XhBlvpDWKHAELQ6uOEUflhyzwxLBdQb
	 QAeB6ERxKJ6MpgeHvvylrW2/5F6Y/r6FBDCcIK14tVFHvtBNkhByO/jZT2uY1u99a7
	 Rvy0FHkqKlf46XNLdvGjQRkpQO+P0gNiLw8DYFNXpGNEQqKXMVKxdEuKgkUg3Xyg6p
	 4v4CJBszwfZhi2+pgyCjJmoAdAcmE+576rhm9OwSmXkn35aTeqpb1IY/ul30vspeAa
	 YaIIwy9SAiXDT0GscOQ4Sj+wp5ngtfOYSVO7RNOWGKxDzkq/lLpBslF5SNArK9J5r6
	 tBEjb9064M+jw==
Content-Type: multipart/signed;
 boundary=fe1ae7df5776f1f2d791dc960f71a027ee6121d702749e13e956e1272f1d;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Thu, 11 Jul 2024 11:02:39 +0200
Message-Id: <D2ML6RG09T38.RZU3CCH0XD9I@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Esben Haabendal" <esben@geanix.com>
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: core: add flag for doing optional
 SFDP
Cc: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Pratyush Yadav"
 <pratyush@kernel.org>, "Miquel Raynal" <miquel.raynal@bootlin.com>,
 "Richard Weinberger" <richard@nod.at>, "Vignesh Raghavendra"
 <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, "Rasmus Villemoes"
 <rasmus.villemoes@prevas.dk>
X-Mailer: aerc 0.16.0
References: <20240603-macronix-mx25l3205d-fixups-v2-0-ff98da26835c@geanix.com> <20240603-macronix-mx25l3205d-fixups-v2-1-ff98da26835c@geanix.com> <a379a411-2c9e-4d9d-aa8f-4c4f3463cc27@linaro.org> <D1SZKLZBDDBA.1Z7ZD4UEOX05F@kernel.org> <871q413x72.fsf@geanix.com>
In-Reply-To: <871q413x72.fsf@geanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--fe1ae7df5776f1f2d791dc960f71a027ee6121d702749e13e956e1272f1d
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Esben,

> > I actually had the same concern. But currently there is no
> > non-deprecated way to handle this case, right?
> >
> > Right now we have the following cases:
> >  (1) pure SFDP parsing
> >  (2) non-SFDP flashes with static configuration only
> >  (3) legacy implementation, where the magic flags decide whether we
> >      use SFDP
>
> Actually, in the code we have two variants of 2.
>
> (2a) non-SFDP flashes with SPI_NOR_SKIP_SFDP set
> (2b) non-SFDP flashes without SPI_NOR_SKIP_SFDP and with none of the
>      DUAL/QUAD/OCTAL read bits set

Isn't (2b) my case (3)? The SPI_NOR_SKIP_SFDP flag was intended to
be for flashes we know for a fact, there are no SFDP tables.

I'm looking at spi_nor_init_params(). Maybe I'm missing something?

-michael

> These almost handled the same way. But
> spi_nor_manufacturer_init_params() is only called for 2b, and not for
> 2a.
>
> Is this desired behavior, or something that we want to align?
>
> > Which case is eventually used depends on the ID of the flash -
> > assuming there will only be IDs which either fall into (1) *or* (2).
> > That assumption is clearly wrong :)
> >
> > I'd propose a new case in spi_nor_init_params()
> >  (4) try SFDP with a fallback to the static flags from the
> >      flash_info db.
>
> /Esben


--fe1ae7df5776f1f2d791dc960f71a027ee6121d702749e13e956e1272f1d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZo+fsRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/h1MAF7BL/jDkLdqERlyUh+I/4t+kL1NUWGFmhu
bS97ljXW9gaw1lviFreW1tMzWHMxWysVAX9f66V0w0fvkut5oECvJRvE51x/yrW1
Zib+7kOeztZN5UtkOvyZwIM33p0xpxdO4SA=
=G+o7
-----END PGP SIGNATURE-----

--fe1ae7df5776f1f2d791dc960f71a027ee6121d702749e13e956e1272f1d--

