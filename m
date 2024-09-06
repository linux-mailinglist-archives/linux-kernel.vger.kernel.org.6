Return-Path: <linux-kernel+bounces-318833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEF796F3FF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B5A31F24C16
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204281CC150;
	Fri,  6 Sep 2024 12:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6DAVZKw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809411C8FC7;
	Fri,  6 Sep 2024 12:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725624408; cv=none; b=S2xtwMaH2B1RlV0wQZDJ9so7wFEI33k38fKClA/S97YYurpSPYOamWB6sd0EmS/Zar775W/8af9CC7Z8FCOyrJuB8ZuJa4HJEAizHWjzChIqm1zIA8Sevd3HU3r2gdH1NcTdhKxNF5BbTXQrPeg+l9QbYKuOWKOQajJ2Ji2JMOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725624408; c=relaxed/simple;
	bh=tD4tsZt9ld3Gft6zrgTvMfi2YHAaykUrGQ+Py1+ed+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gaQYXQnkijAdWkTzMWnUcbYU2OxULYrgR6xKyyXeSjQNJx3A0wOtpirjOzx9X6JIsQKwUJXWPX5OzsyXX34bdFJgVMbcJ9Kv8LhBSjKJVAi5J/gsK8HyYT0KU6We0kFZtbW7pZHtewXEUfD08BwRxrt36OZ5kF2QehKYED7MlU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6DAVZKw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37CDC4CEC4;
	Fri,  6 Sep 2024 12:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725624408;
	bh=tD4tsZt9ld3Gft6zrgTvMfi2YHAaykUrGQ+Py1+ed+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V6DAVZKwauEcOsWYLzycyTUk1E7WyhZ7AP+5cpRkgn64ynaAjrGhR/B+s9sTaUA7W
	 YjnZEY+WWH3pbuhOQ5/HjFtXLpZBWMcsLggUzkV8yh6gzB/ZwRaLWY+idqRrM3bl/u
	 xbOnsXswrqZW6h8ejL7hWCpc4KosPKpHVmk9Em+C22cg9adnR5zxPk4rLqKumDXLUb
	 QFk7f0bLjKt7xhu77C9oPUYFiDEswY9xx4u1qF1t+CJrT6Z48cwbKvwkVZKp3j+aeh
	 kl5cMoe6RGMx4xH2vvkYCjR8iQ+olIFQ5Aj5IAiv+SykXokx4gro/8LwrhDkiaqpGD
	 eVegVyTlRSGrA==
Date: Fri, 6 Sep 2024 14:06:44 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: Adam Ford <aford173@gmail.com>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, 
	arm-soc <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Schrempf Frieder <frieder.schrempf@kontron.de>, Dominique MARTINET <dominique.martinet@atmark-techno.com>, 
	"robh@kernel.org" <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: i.MX8MP IMX-LCDIF Underrun Question(s)
Message-ID: <20240906-fiery-polar-otter-5fc83f@houat>
References: <CAHCN7xLL4hrTK1OqsqUa78cdp9ZcG0sC+cO5QKC3x_Y9-QVzSA@mail.gmail.com>
 <PAXPR04MB84592996FD8101BC0CF9E366889E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="kgmq37ughxbfbzck"
Content-Disposition: inline
In-Reply-To: <PAXPR04MB84592996FD8101BC0CF9E366889E2@PAXPR04MB8459.eurprd04.prod.outlook.com>


--kgmq37ughxbfbzck
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 06, 2024 at 08:03:38AM GMT, Peng Fan wrote:
> > Subject: i.MX8MP IMX-LCDIF Underrun Question(s)
> >=20
> > I have been testing various settings on the HDMI out of the i.MX8MP.
> >=20
> > I noticed that sometimes my monitor would not sync, but sometimes it
> > would on the same resolution/refresh rate.  Frieder noted the LCDIF
> > was sometimes underflowing, so read up on it a little bit.
> >=20
> > In the comments of the LCDIF driver, it's noted:
> >     Set FIFO Panic watermarks, low 1/3, high 2/3 .
> >=20
> > However, in the downstream kernels, NXP changes the threshold to
> > 1/2 and 3/4 on the LCDIF that drives the HDMI, while leaving the other
> > LCDIF interfaces at the default.
> >=20
> > When I increased the threshold to 1/2 and 3/4, it appeared that several
> > resolutions that my monitor was struggling to sync started working,
> > and it appeared to sync faster.  I don't have an HDMI analyzer, so I
> > cannot verify much beyond knowing if my monitor can or cannot sync.
>=20
> You mean the two?
>         thres-low  =3D <1 2>;             /* (FIFO * 1 / 2) */           =
                            =20
>         thres-high =3D <3 4>;             /* (FIFO * 3 / 4) */
> >=20
> > Could the threshold and underrun cause this monitor intermittent issue,
> > or would this be something else?
>=20
> The threshold could cause display flicker if the value could not satisfy
> the bandwidth.
>=20
> >=20
> > Does it make sense to have a flag or device tree option to override the
> > default thresholds to change the panic level?
>=20
> I think it would be good to have a property as above.
>=20
> + DT maintainer to comment.

Why do you think it's something that should be tuned as a
per-platform/board basis?

If it's something that needs to be adjusted based on the resolution,
then it should always be done in the driver, and that has nothing to do
in the DT.

Maxime

--kgmq37ughxbfbzck
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZtrwTQAKCRAnX84Zoj2+
dnzLAX4rhFRO43e3DD4r6oFOZJyV23z7kMCa7UfEGx6/wR3e/M078YeCcLAGflcJ
9mVa7GQBfRNe758fFWPYVXaC04cNwEziGFzaRP+8PMXwpDYsYfFsgbMtbgDbq63+
RFmXQY/SyA==
=1WaJ
-----END PGP SIGNATURE-----

--kgmq37ughxbfbzck--

