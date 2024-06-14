Return-Path: <linux-kernel+bounces-215295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD099090C6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC623282D38
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A99C197A95;
	Fri, 14 Jun 2024 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpFq6UCC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55218192B8F;
	Fri, 14 Jun 2024 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718383907; cv=none; b=B4LmFz6WdbxatcA/Ktt/IJnr2HgnCfNNg8QoIRlMeZ/Vsu+axXdAKdzTr987OhetzIJ5i1daGXfm2MgltPeKA0nai7sDyco8vgi+HcjRTAOBolKC2ouyQd+zObQ/3/3NGTtIl+lYpWfYPuOc7KGB301gXUMgfsbbFA9ZS9X4XrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718383907; c=relaxed/simple;
	bh=fPlz7/O4CHKldDLCxbpg3ui9wtblMgB3TXnLBn0vSI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l801Rwft44lIalZOt+gT1av2H9JI48NGgFErXYueja3KlP4kvw2w9SYERe/YoNxBLWufC9H2uiM/bBG77fQISLS5tcbVVWnbhLZ4alU31B9GGKkNfN4RUO+pP+FYuN+KzEg7jq56JnySgT1gUDqeKlzwyhGgVkR3A1uwaeculw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpFq6UCC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29068C2BD10;
	Fri, 14 Jun 2024 16:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718383907;
	bh=fPlz7/O4CHKldDLCxbpg3ui9wtblMgB3TXnLBn0vSI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CpFq6UCC7cqq4TL2Q4voaO/eWCDtFrzYqrhpIB1METf7ygd32ZxG5reEb08aI2/2l
	 EOxJV0ZJspzfFvIBXYmPTqrYT27w3rTiKkm+0qK4iCpyuG7O8YAUweHKhCa8wqWvjd
	 cjod0053tLA2spwX/oQuoY0BJCQ8ikbCbbKxI3lw3enf1LhXAA6RU9YT5281LMbTRV
	 BM47sjqNEhDV2l7quJAsEP4p/QiQyrdWTMeDPgyTL6Vqsm+ScmxescTGkW2jxGxXvb
	 /Uf4o81uIhzqasU0dnRZVZ0nFTzxCL9yCWfUrzi+KZa3C2Rw0AIU1tMb3tNPV6KEG3
	 lW5zitAlFmhCw==
Date: Fri, 14 Jun 2024 17:51:43 +0100
From: Mark Brown <broonie@kernel.org>
To: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Russell King <linux@armlinux.org.uk>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Chancel Liu <chancel.liu@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
	Michael Ellerman <mpe@ellerman.id.au>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [Patch v2 1/2] ASoC: fsl: Add i2s and pcm drivers for LPC32xx
 CPUs
Message-ID: <Zmx1H5MyjWvoRdwz@finisterre.sirena.org.uk>
References: <20240611094810.27475-1-piotr.wojtaszczyk@timesys.com>
 <Zmgor8accyAiUkUO@finisterre.sirena.org.uk>
 <CAG+cZ06B+AexqvwZtNP5FX50AmghAFLa=1ebxmKLvMoyVJ529w@mail.gmail.com>
 <Zmxy-xA3YDU06Eht@finisterre.sirena.org.uk>
 <CAG+cZ05KomezPn0bAuZWrfO=rbyLdCU8_Xx11oEihUaD97gF8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7aeyEfJwNjSnCeXl"
Content-Disposition: inline
In-Reply-To: <CAG+cZ05KomezPn0bAuZWrfO=rbyLdCU8_Xx11oEihUaD97gF8w@mail.gmail.com>
X-Cookie: Your love life will be... interesting.


--7aeyEfJwNjSnCeXl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 06:46:46PM +0200, Piotr Wojtaszczyk wrote:
> On Fri, Jun 14, 2024 at 6:42=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:
> > On Fri, Jun 14, 2024 at 06:24:50PM +0200, Piotr Wojtaszczyk wrote:

> > > Ok. Later I will add a sound card driver to phytec3250 board which us=
es
> > > arch/arm/configs/lpc32xx_defconfig config file so that the COMPILE_TE=
ST
> > > won't be needed.

> > Why would a defconfig affect the Kconfig?

> I guess when lpc32xx_defconfig enables the SND_SOC_FSL_LPC3XXX then the
> COMPILE_TEST won't be needed or does it?

The whole point of COMPILE_TEST is to allow the driver to be covered
when people aren't building for whatever specific platform would
actually use it.

--7aeyEfJwNjSnCeXl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZsdR4ACgkQJNaLcl1U
h9CNrQf/QOGnPQlIqhyNGJmHt+OTyAKxvU02FdwW1IOOW6yQBj4UO9d4k7nblhEn
F7Vtbh6YUxU664IKdVLn2n6JwvOzBu2sPuLmm0JQgsZnlOB23KNWgw7yoZdgPL9m
tKbUe6KCBHoMU/LJe+m2nm9qhAlTXlL4Uf1xgJQ3TK9c2neuko0efOtWy97OE8Oc
PxHGfc5fFxAjEtnOQq47Nj0/fKCzXF3HLOseOx+KibzpUMgVZJTdVilroWPHOGXa
u9aMHOWsdypZIO6rRaAjhslOpENc0zW4+v4gaWtRD8mmsiKzvQuZTB6zo/vMTTfA
GUx5oQKpFeCMxaFkBGj6dCVLbitmgQ==
=r/9i
-----END PGP SIGNATURE-----

--7aeyEfJwNjSnCeXl--

