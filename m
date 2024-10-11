Return-Path: <linux-kernel+bounces-360977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C66D99A1F7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A12B01C2318D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91DA210C34;
	Fri, 11 Oct 2024 10:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dX6WtH0V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCDF20B1E9;
	Fri, 11 Oct 2024 10:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728643787; cv=none; b=bgNo08Sm/Fp/WjDepgWX4lTsz60f4ot5nleL5KB+a09TIt5unwMOoIpqFi5b9qFxE0jR+1ZR6/kJv8uQxlq2cfxzEefy2ImBoSGeKYjA7tog1TmKT43tjLPcijfmlIKBPPX2pRYLy2bc2MNujfY3Z4t0iCR5iAdvquq9T5clAG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728643787; c=relaxed/simple;
	bh=iGFL206iPeIYfSH1TBbeBoo4QjA57peaFogEpgxvHaY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBXOFlvzwqzATC1vl8p/QEy4GGsrG8tcZard1w0+gsaLlGeVhNoo6vYa+8JPvWrbyb0C6n9svvEg7QLiCGuejzaxRRJOhisB/ndZngQWZqe4TN+D9eO36mH7p0nWLIup1v/D/gZ8R8pTMm1lBnNUxzCFHdeDWddO4wz1v3g2kh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dX6WtH0V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40826C4CEC3;
	Fri, 11 Oct 2024 10:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728643786;
	bh=iGFL206iPeIYfSH1TBbeBoo4QjA57peaFogEpgxvHaY=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=dX6WtH0V6ZNIjt9AkDk0vWgKbSJZxxfDUi0XjFdOBcEdKoll9pOKof+qeG/lBGunA
	 4abGUABlQQs99occU6ANB1zXLrjKpArDtiGj8JhdDTvgJhsJRCbGxfPk9VCtK7n8pT
	 yOO/kYp7XciOLUwDBVj/KQ/xi0IggTYYYsvbR727zhrQO2fHm0q/K/e77av/9OL/BV
	 Xgcf1qdBdyQ2o48/kck0jAcE6ZmuHiLXrplJiyObmnWNpqSv8BZoekO+CWVVJYoILu
	 2vXqrYOsu7zzfrJp6KdRzpmx8gc+f9GUzVV9JaunRqGGqczaQ4sZcgxYQ9D/fqAn+i
	 uvDKEAh44kvxw==
Date: Fri, 11 Oct 2024 12:49:43 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
	Melissa Wen <melissa.srw@gmail.com>, Maaara Canal <mairacanal@riseup.net>, 
	Haneen Mohammed <hamohammed.sa@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Simona Vetter <simona@ffwll.ch>, rdunlap@infradead.org, 
	arthurgrillo@riseup.net, pekka.paalanen@haloniitty.fi, 
	Simona Vetter <simona.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, thomas.petazzoni@bootlin.com, jeremie.dautheribes@bootlin.com, 
	miquel.raynal@bootlin.com, seanpaul@google.com, marcheu@google.com, 
	nicolejadeyee@google.com, Pekka Paalanen <pekka.paalanen@collabora.com>
Subject: Re: [PATCH v12 13/15] drm/vkms: Create KUnit tests for YUV
 conversions
Message-ID: <20241011-shiny-skua-of-authority-998ad3@houat>
References: <20241007-yuv-v12-0-01c1ada6fec8@bootlin.com>
 <20241007-yuv-v12-13-01c1ada6fec8@bootlin.com>
 <20241008-ingenious-calm-silkworm-3e99ba@houat>
 <ZwT6CnyYRKS9QxIS@louis-chauvet-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="ft4zr7lbcug3nly4"
Content-Disposition: inline
In-Reply-To: <ZwT6CnyYRKS9QxIS@louis-chauvet-laptop>


--ft4zr7lbcug3nly4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 08, 2024 at 11:23:22AM GMT, Louis Chauvet wrote:
>=20
> Hi,=20
>=20
> > > + * The YUV color representation were acquired via the colour python =
framework.
> > > + * Below are the function calls used for generating each case.
> > > + *
> > > + * For more information got to the docs:
> > > + * https://colour.readthedocs.io/en/master/generated/colour.RGB_to_Y=
CbCr.html
> > > + */
> > > +static struct yuv_u8_to_argb_u16_case yuv_u8_to_argb_u16_cases[] =3D=
 {
> > > +	/*
> > > +	 * colour.RGB_to_YCbCr(<rgb color in 16 bit form>,
> > > +	 *                     K=3Dcolour.WEIGHTS_YCBCR["ITU-R BT.601"],
> > > +	 *                     in_bits =3D 16,
> > > +	 *                     in_legal =3D False,
> > > +	 *                     in_int =3D True,
> > > +	 *                     out_bits =3D 8,
> > > +	 *                     out_legal =3D False,
> > > +	 *                     out_int =3D True)
> > > +	 */
> >=20
> > We should really detail what the intent and expected outcome is supposed
> > to be here. Relying on a third-party python library call for
> > documentation isn't great.
>
> This was requested by Pekka in the [v2] of this series.

Ok.

> I can add something like this before each tests, but I think having the=
=20
> exact python code used may help people to understand what should be the=
=20
> behavior, and refering to the python code to understand the conversion.

Help, sure. Be the *only* documentation, absolutely not.

Let's turn this around. You run kunit, one of these tests fail:

 - It adds cognitive load to try to identify and make sense of an
   unknown lib.

 - How can we check that the arguments you provided there are the one
   you actually wanted to provide, and you didn't make a typo?

> I can add something like this before each tests to clarify the tested=20
> case:
>=20
> 	Test cases for conversion between YUV BT601 limited range and=20
> 	RGB using the ITU-R BT.601 weights.
>=20
> Or maybe just documenting the structure yuv_u8_to_argb_u16_case:
>=20
> 	@encoding: Encoding used to convert RGB to YUV
> 	@range: Range used to convert RGB to YUV
> 	@n_colors: Count of test colors in this case
> 	@format_pair.name: Name used for this color conversion, used to=20
> 			   clarify the test results
> 	@format_pair.rgb: RGB color tested
> 	@format_pair.yuv: Same color as @format_pair.rgb, but converted to=20
> 			  YUV using @encoding and @range.
>=20
> What do you think?

That it's welcome, but it still doesn't allow to figure out what your
intent was with this test 2 years from now.

Maxime

--ft4zr7lbcug3nly4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZwkCvwAKCRAnX84Zoj2+
dndpAX9qewITSorE5xkloVDv05qqXxzUgriyCrfDgT92WWF0hboSYYYb3XiAXcXI
5WNcUckBgOfu6zX8wo6A2M1haWgW+g/S8IMW8CI6gtjxVhPXutoD1iSMyEo74eXA
ARSWWO4+Vg==
=91dx
-----END PGP SIGNATURE-----

--ft4zr7lbcug3nly4--

