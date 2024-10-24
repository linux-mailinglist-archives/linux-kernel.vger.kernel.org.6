Return-Path: <linux-kernel+bounces-380021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CC39AE779
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B47F71C21103
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687D81E7C08;
	Thu, 24 Oct 2024 14:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWSVnsYK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6781E2009;
	Thu, 24 Oct 2024 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729778766; cv=none; b=SXqr4fZ6R+MJlEAxqKijZxgd84yX+sV5JboDewYmIsKRXydGf05VkCh79obtHPYeY3C+78hsEpPHif6evTg4qfNHGdpWE62LYHN+3HpQJUVGCHpPsRqHDPFJR3KAvfxR2P/6d6O/SHiGX1i1j3nPbJpOBrTyyS8I5BbyLI5EF8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729778766; c=relaxed/simple;
	bh=UqM6Z34E+/K+S+SxZRTtlXPQ0ZdBLSakhVgd6bJmUqM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ck6TVfYBu5sGPZ6ZaGhtpoAR1ZxFtb0hZvYNkieHN/NbgAlmXUsOLZ+zsVxneqMckh0APA+HJZrYO3JouavpMdyKPfWOl9AFJUwu0mIqJNfMLvxeSA7Qa+A1OBj83iopqUyTuARZ+jmxSvKfh97/TGy0yavHHAnzGS4qydkZ//w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWSVnsYK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A58C4CECC;
	Thu, 24 Oct 2024 14:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729778766;
	bh=UqM6Z34E+/K+S+SxZRTtlXPQ0ZdBLSakhVgd6bJmUqM=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=AWSVnsYKK9O/yPvErdiTcdH3hjVq5fpl40AxNXggq3RH8elow7SkzmyvIoF7t1bLN
	 MKJIfJGa0o4pPjs4/mosmK5QSMyI+jcWowubSHxrBGrcD3Nat2tm6tSGEBLCT06mCT
	 fmcmk1L+becoisluJQWDYSHNseFS1PZWGO6Y8BD3YnH2cQW2QXqiTmZh5RJPd5vtyP
	 K55c4s7ezXWGC4b+l0jLOUFyi9LF9euF89lPYxjlxjtkEbJhZN/ySHNT1jJOq54qYP
	 vJdBTFHjqAiJPLcwcLCf8J7qEGI2nno0lrH6v6ewqnB5MCvi/C2SgQMTqoyYvccLZ2
	 mBvVhrDdGcaKA==
Date: Thu, 24 Oct 2024 16:06:03 +0200
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
Message-ID: <20241024-illustrious-puma-of-superiority-d24a4d@houat>
References: <20241007-yuv-v12-0-01c1ada6fec8@bootlin.com>
 <20241007-yuv-v12-13-01c1ada6fec8@bootlin.com>
 <20241008-ingenious-calm-silkworm-3e99ba@houat>
 <ZwT6CnyYRKS9QxIS@louis-chauvet-laptop>
 <20241011-shiny-skua-of-authority-998ad3@houat>
 <Zwk2RSgfV75LVLpR@louis-chauvet-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="q6c53od3b6prp5tw"
Content-Disposition: inline
In-Reply-To: <Zwk2RSgfV75LVLpR@louis-chauvet-laptop>


--q6c53od3b6prp5tw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v12 13/15] drm/vkms: Create KUnit tests for YUV
 conversions
MIME-Version: 1.0

On Fri, Oct 11, 2024 at 04:29:25PM +0200, Louis Chauvet wrote:
> On 11/10/24 - 12:49, Maxime Ripard wrote:
> > On Tue, Oct 08, 2024 at 11:23:22AM GMT, Louis Chauvet wrote:
> > >=20
> > > Hi,=20
> > >=20
> > > > > + * The YUV color representation were acquired via the colour pyt=
hon framework.
> > > > > + * Below are the function calls used for generating each case.
> > > > > + *
> > > > > + * For more information got to the docs:
> > > > > + * https://colour.readthedocs.io/en/master/generated/colour.RGB_=
to_YCbCr.html
> > > > > + */
> > > > > +static struct yuv_u8_to_argb_u16_case yuv_u8_to_argb_u16_cases[]=
 =3D {
> > > > > +	/*
> > > > > +	 * colour.RGB_to_YCbCr(<rgb color in 16 bit form>,
> > > > > +	 *                     K=3Dcolour.WEIGHTS_YCBCR["ITU-R BT.601"],
> > > > > +	 *                     in_bits =3D 16,
> > > > > +	 *                     in_legal =3D False,
> > > > > +	 *                     in_int =3D True,
> > > > > +	 *                     out_bits =3D 8,
> > > > > +	 *                     out_legal =3D False,
> > > > > +	 *                     out_int =3D True)
> > > > > +	 */
> > > >=20
> > > > We should really detail what the intent and expected outcome is sup=
posed
> > > > to be here. Relying on a third-party python library call for
> > > > documentation isn't great.
> > >
> > > This was requested by Pekka in the [v2] of this series.
> >=20
> > Ok.
> >=20
> > > I can add something like this before each tests, but I think having t=
he=20
> > > exact python code used may help people to understand what should be t=
he=20
> > > behavior, and refering to the python code to understand the conversio=
n.
> >=20
> > Help, sure. Be the *only* documentation, absolutely not.
> >=20
> > Let's turn this around. You run kunit, one of these tests fail:
> >=20
> >  - It adds cognitive load to try to identify and make sense of an
> >    unknown lib.
> >=20
> >  - How can we check that the arguments you provided there are the one
> >    you actually wanted to provide, and you didn't make a typo?
> >=20
> > > I can add something like this before each tests to clarify the tested=
=20
> > > case:
> > >=20
> > > 	Test cases for conversion between YUV BT601 limited range and=20
> > > 	RGB using the ITU-R BT.601 weights.
> > >=20
> > > Or maybe just documenting the structure yuv_u8_to_argb_u16_case:
> > >=20
> > > 	@encoding: Encoding used to convert RGB to YUV
> > > 	@range: Range used to convert RGB to YUV
> > > 	@n_colors: Count of test colors in this case
> > > 	@format_pair.name: Name used for this color conversion, used to=20
> > > 			   clarify the test results
> > > 	@format_pair.rgb: RGB color tested
> > > 	@format_pair.yuv: Same color as @format_pair.rgb, but converted to=
=20
> > > 			  YUV using @encoding and @range.
> > >=20
> > > What do you think?
> >=20
> > That it's welcome, but it still doesn't allow to figure out what your
> > intent was with this test 2 years from now.
>=20
> I don't really understand what you want to add. Can you explain what you=
=20
> expect here? Did you mean you want a description like this above the test=
=20
> function?

I want, for each test case, to have a documentation of what case it's
testing and what the test should expect.

So, for the first one, something like:

/*
 * Test the conversion of full range, BT601-encoded, YUVXXX pixel to
 * ARGBXXXX, for various colors. This has been generated using:
 *
 * colour.RGB_to_YCbCR(...)
 */

And there's other things you need to document. Like, it seems that you
sometimes pass different values for in_legal and out_legal, and that's
not clear to me.

It also that you uses a matrix for NV12 but are converting a different
format. This needs to be documented.

Finally, You should be documented why you are checking that the colors
difference is less than 257, and not exactly equal.

Maxime

--q6c53od3b6prp5tw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZxpURwAKCRAnX84Zoj2+
dpnIAYCtzV3UTGshXlT1ay9Ij6pdu3hWrR1lndrGKgCB1XEnKmy4881AJuppJ99z
FdyPjl8Bf1/NExIEJ9JOwZpOUbCdkop0YSn90LSIqkHC97ab1CPRsC0EIJOtrseB
NAvTbA189Q==
=mQrx
-----END PGP SIGNATURE-----

--q6c53od3b6prp5tw--

