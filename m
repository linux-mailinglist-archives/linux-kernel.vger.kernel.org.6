Return-Path: <linux-kernel+bounces-435086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA18E9E6F72
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 14:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8305B18871CB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6CA1FCF55;
	Fri,  6 Dec 2024 13:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JoNaGGKc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3933679D2
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 13:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733492699; cv=none; b=INOskwMe2cXHHekAHsUo1++XETLsAKM9sC9yVHugwRMAa3i7HhVAUmpHyvuK631AIc0XsymQezOHMpEvjMdrydVyWjvfAMSLcLMfSBCAQbbzHsHJiz2c/f8VUxm31L/ZkMfyxoOitP9gd/UZIIR/DJ7rGF50Jo6yiKBINSu0Ou4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733492699; c=relaxed/simple;
	bh=5dfFMCVhrMFCBqVtko1r2HqrE2hXt7TN9uW/VPcMmD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPpolnPN5+Ozy76uhNc0yZR0nD1wZVFCoOpXqAYDyxdlTbsW/c24djOhkDUC3jid+2tBpwSubZPOaE3u1X1jED7WIDOSvje2Rm45EfBOZjqtr2b4svCn5fFSOwCdgl4+H+VIv37649n9YWhh1A39qomzES4Oj4h5SOWiobPu8UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JoNaGGKc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD235C4CED1;
	Fri,  6 Dec 2024 13:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733492697;
	bh=5dfFMCVhrMFCBqVtko1r2HqrE2hXt7TN9uW/VPcMmD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JoNaGGKcAAlWxeyAeIrBYFP4C4nRFcIiLKVct/S7lxxr7yLypZ43zH+Q5GKRbzIdF
	 1N47TsQUtWZFXdssgHwArPqVlbGtoisDyJIH+30FJlGG921d2vQZ2LAR5kDgVhkYIZ
	 7OhrjAn2okbaZy2YfX1dQxvney+cVlgvvG/6kVJ8xFaJYQA4b1sdXzryJtkj8OL17+
	 DdEF58REmD1YsXgEbr27c1sBjtJkIG9i1E0cJJv/b6KHu1DydRHpfEuW020aw8pFfK
	 cTM2DY33CT7dzj8CsimZQTbxp3P0/Bt537d6ph1G1pwigfajuPOb9ah3Qb0mY66cXI
	 zYo/7cJPI0SNw==
Date: Fri, 6 Dec 2024 13:44:53 +0000
From: Mark Brown <broonie@kernel.org>
To: Philippe Simons <simons.philippe@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
	"open list:VOLTAGE AND CURRENT REGULATOR FRAMEWORK" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: axp20x: AXP717: set ramp_delay
Message-ID: <50ecb2cc-7fd2-4a72-bd68-05d33269c01e@sirena.org.uk>
References: <20241206123751.981977-1-simons.philippe@gmail.com>
 <2ec677db-2db8-4a74-af76-d8ff1f4b2173@sirena.org.uk>
 <CADomA4-xTcPyFcX_qCYJwoi7y5vfYmzOfF9iO5MKgEzZdpbJCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tCm4Y0tMD0IePRC9"
Content-Disposition: inline
In-Reply-To: <CADomA4-xTcPyFcX_qCYJwoi7y5vfYmzOfF9iO5MKgEzZdpbJCQ@mail.gmail.com>
X-Cookie: Sales tax applies.


--tCm4Y0tMD0IePRC9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2024 at 01:54:39PM +0100, Philippe Simons wrote:
> On Fri, Dec 6, 2024 at 1:48=E2=80=AFPM Mark Brown <broonie@kernel.org> wr=
ote:

> > >  static const struct regulator_desc axp717_regulators[] =3D {
> > > +     AXP_DESC_RANGES_DELAY(AXP717, DCDC1, "dcdc1", "vin1",
> > > +                     AXP717_DCDC_OUTPUT_CONTROL, BIT(0), 640),

> > This doesn't seem to match with the above - ramp_delay is in units of
> > uV/us?

> 15.625 us / 10mV =3D 1.5625 us/mV =3D 0.0015625 us/uV
> 0.0015625^-1 =3D 640 uV/us

Ah, yes - sorry - I typed when I did the calculation.

--tCm4Y0tMD0IePRC9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdS/9UACgkQJNaLcl1U
h9BSHgf+IjXsOS9unA83yS2AEaPrAOO7hN3vhk5gknSH8yMS5RB9VcRimz83OV6m
1z7fNpjokRHM8HwHHE6ZQ2O6nxDpBG5Pj8WGGvt73/oNC7BuSx+VMZT9WQKOWkMZ
TBUobkUSFPBL2LkM/6BJuG1E/4Pl801RFUYoRlAtlkQwh5oCqo3hyR6YEGr6rZAY
Wm4p8Vylro/AVCDB7iw6/IVL8V47SkSUtdkv45XMI70bIQ2eXnj/LKpZmWrjU1Xv
/kN+ZptcaCe5ht2vGmdKqTMzsR3TPEUi2u87+5/WZ5ITRm1elQFgS8MHxDhYGXdZ
Gu6HlheS0wuKmP5VfJNEaN3UhUxtcQ==
=O9kg
-----END PGP SIGNATURE-----

--tCm4Y0tMD0IePRC9--

