Return-Path: <linux-kernel+bounces-550862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B747EA5650F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 694CA7A33B7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93402214808;
	Fri,  7 Mar 2025 10:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PlLVn32m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE68B213E93;
	Fri,  7 Mar 2025 10:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741342820; cv=none; b=ZBo4gtowDPsoOjVVvMbPuUpll+EwQvjBDJEiOGYcgXDpBhx0zBmZc8h5ELsZjI4tOY6vg3hkxMKPff4ccrrBrT3iFuMNOV0t3bANuFp1qZNqkXyzSqzYLd5g1xhAnJPolIeaMvv+ZKiST4RBbYarmrIWRKGMvK9avOlV3SKUR8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741342820; c=relaxed/simple;
	bh=fyKDOS2LN4gy85cwCDCXl+DX3bKvRRz/kGMjL+QiReY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPb/hf0ikhO5Tr7qQZexyWpF0tR0aRHxHWIIEpyp4qBdRjmd2S2NjU7LMNIwlsX2HznC40991k9PcV6bPR4VTpvukF4PQb7U1Atc2VrH5+SFLW6e46/9I+J88dKQZN8bDzJMlygrstbSCYKvJLaMIDaUYNlsf1n7gd7L/PNjtQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PlLVn32m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4D0C4CED1;
	Fri,  7 Mar 2025 10:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741342820;
	bh=fyKDOS2LN4gy85cwCDCXl+DX3bKvRRz/kGMjL+QiReY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PlLVn32m0yKDATL9pNTHI0A6irsKRsyq2NVOKPDMFrvfehDFPzyZmMKwTtbiqNqSk
	 eSHu5PrwfoBu/l0Wa5CUNUitPrSO8Wfypclz+N146AEc1JktBABpea5inv9lkjdJvc
	 UhzsaUlq6T36JZrJdqnZ7Ja6gr4kQ1SZmfPNMgLixnn7rmQAdQMRKnZcH28lL6GzAX
	 wCm1iZA2pik8N5azgaqDguNL6uyV4BO0FHcOIs3TYH4utfRRMhtaBOe+dyJSnGHbj5
	 2NHpJT3XEq9aF0XSBGWr01AyTqlUPLtaQQ+k9Sty+uXXQJw/nJrOkUA6+cTuS8AMeG
	 76XcWbqe5YqHQ==
Date: Fri, 7 Mar 2025 11:20:17 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
	Melissa Wen <melissa.srw@gmail.com>, =?utf-8?B?TWHDrXJh?= Canal <mairacanal@riseup.net>, 
	Haneen Mohammed <hamohammed.sa@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, rdunlap@infradead.org, 
	arthurgrillo@riseup.net, Jonathan Corbet <corbet@lwn.net>, pekka.paalanen@haloniitty.fi, 
	Simona Vetter <simona@ffwll.ch>, Simona Vetter <simona.vetter@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com, 
	miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, seanpaul@google.com, 
	marcheu@google.com, nicolejadeyee@google.com, linux-doc@vger.kernel.org, 
	Pekka Paalanen <pekka.paalanen@collabora.com>
Subject: Re: [PATCH v16 5/7] drm/vkms: Create KUnit tests for YUV conversions
Message-ID: <20250307-glaring-kiwi-of-teaching-d5ddd4@houat>
References: <20250121-yuv-v16-0-a61f95a99432@bootlin.com>
 <20250121-yuv-v16-5-a61f95a99432@bootlin.com>
 <qwym5wty72f6o4dfz2iduamkpuom6jt5txskknovqxzagruusx@zuytk7awe2uw>
 <Z5dkd3npNtzPWCrP@louis-chauvet-laptop>
 <20250205-pristine-perch-of-abundance-7abac1@houat>
 <Z6OEd329pDNRrL5v@louis-chauvet-laptop>
 <20250219-inventive-micro-parrot-c24846@houat>
 <ce5fb86d-f3bc-4196-9cfd-8af41a83beb1@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dglgkcz5iwfzaztz"
Content-Disposition: inline
In-Reply-To: <ce5fb86d-f3bc-4196-9cfd-8af41a83beb1@bootlin.com>


--dglgkcz5iwfzaztz
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v16 5/7] drm/vkms: Create KUnit tests for YUV conversions
MIME-Version: 1.0

On Wed, Feb 19, 2025 at 02:35:14PM +0100, Louis Chauvet wrote:
>=20
>=20
> Le 19/02/2025 =E0 11:15, Maxime Ripard a =E9crit=A0:
> > On Wed, Feb 05, 2025 at 04:32:07PM +0100, Louis Chauvet wrote:
> > > On 05/02/25 - 09:55, Maxime Ripard wrote:
> > > > On Mon, Jan 27, 2025 at 11:48:23AM +0100, Louis Chauvet wrote:
> > > > > On 26/01/25 - 18:06, Maxime Ripard wrote:
> > > > > > On Tue, Jan 21, 2025 at 11:48:06AM +0100, Louis Chauvet wrote:
> > > > > > > +static struct yuv_u8_to_argb_u16_case yuv_u8_to_argb_u16_cas=
es[] =3D {
> > > > > > > +	/*
> > > > > > > +	 * colour.RGB_to_YCbCr(<rgb color in 16 bit form>,
> > > > > > > +	 *                     K=3Dcolour.WEIGHTS_YCBCR["ITU-R BT.6=
01"],
> > > > > > > +	 *                     in_bits =3D 16,
> > > > > > > +	 *                     in_legal =3D False,
> > > > > > > +	 *                     in_int =3D True,
> > > > > > > +	 *                     out_bits =3D 8,
> > > > > > > +	 *                     out_legal =3D False,
> > > > > > > +	 *                     out_int =3D True)
> > > > > > > +	 *
> > > > > > > +	 * Test cases for conversion between YUV BT601 full range a=
nd RGB
> > > > > > > +	 * using the ITU-R BT.601 weights.
> > > > > > > +	 */
> > > > > >=20
> > > > > > What are the input and output formats?
> > > > > >=20
> > > > > > Ditto for all the other tests.
> > > > >=20
> > > > > There is no really "input" and "output" format, they are referenc=
e values
> > > > > for conversion, you should be able to use it in both direction. T=
hey are
> > > > > generated by RGB_to_YCbCr (RGB input, YUV output) just because it=
 was
> > > > > easier to create the colors from RGB values.
> > > >=20
> > > > RGB and YUV aren't formats, they are color models. XRGB8888 is a fo=
rmat.
> > > > NV12 is a format.
> > > >=20
> > > > > If you think we should specify what is was used as input and outp=
ut to
> > > > > generate those values, I can modify the comment to:
> > > > >=20
> > > > > 	Tests cases for color conversion generated by converting RGB
> > > > > 	values to YUV BT601 full range using the ITU-R BT.601 weights.
> > > >=20
> > > > My point is that those comments should provide a way to reimplement=
 the
> > > > test from scratch, and compare to the actual implementation. It's u=
seful
> > > > when you have a test failure and start to wonder if the implementat=
ion
> > > > or the test is at fault.
> > > >=20
> > > > By saying only RGB and YUV, you can't possibly do that.
> > >=20
> > > I understand your concern, but I believe there might be a slight
> > > misunderstanding. The table in question stores reference values for
> > > specific color models, not formats. Therefore, it doesn't specify any
> > > particular format like XRGB8888 or NV12.
> > >=20
> > > To clarify this, I can rename the format_pair struct to value_pair. T=
his
> > > should make it clearer that we are dealing with color model values ra=
ther
> > > than formats.
> > >=20
> > > If you want to test a specific format conversion, such as
> > > YUV420_to_argbu16, you would need to follow a process like this:
> > >=20
> > > 	// Recreate a YUV420 data
> > > 	plane_1[0] =3D test_case.yuv.y
> > > 	plane_2[0] =3D test_case.yuv.u
> > > 	plane_2[1] =3D test_case.yuv.v
> > >=20
> > > 	// convertion to test from YUV420 format to argb_u16
> > > 	rgb_u16 =3D convert_YUV420_to_argbu16(plane_1, plane_2)
> > >=20
> > > 	// ensure the conversion is valid
> > > 	assert_eq(rgb_u16, test_case.rgb)
> > >=20
> > > The current test is not performing this kind of format conversion.
> > > Instead, it verifies that for given (y, u, v) values, the correct (r,=
 g,
> > > b, a) values are obtained.
> >=20
> > You already stated that you check for the A, R, G, and B components. On
> > how many bits are the values you are comparing stored? The YUV values
> > you are comparing are stored on how many bits for each channel? With
> > subsampling?
> >=20
> > If you want to compare values, you need to encode a given color into
> > bits, and the way that encoding is done is what the format is about.
> >=20
> > You might not compare the memory layout but each component individually,
> > but it's still a format.
>=20
> Sorry, I think I misunderstood what a format really is.

Ultimately, a format is how a given "color value" is stored. How many
bits will you use? If you have an unaligned number of bits, how many
bits of padding you'll use, where the padding is? If there's multiple
bytes, what's the endianness?

The answer to all these questions is "the format", and that's why
there's so many of them.

> But even with this explanation, I don't understand well what you ask
> me to change. Is this better:
>=20
> The values are computed by converting RGB values, with each component sto=
red
> as u16, to YUV values, with each component stored as u8. The conversion is
> done from RGB full range to YUV BT601 full range using the ITU-R BT.601
> weights.
>=20
> TBH, I do not understand what you are asking for exactly. Can you please
> give the sentence you expect directly?

The fourcc[1] code for the input and output format would be nice. And if
you can't, an ad-hoc definition of the format, answering the questions I
mentionned earlier (and in the previous mail for YUV). I'm really
surprised about the RGB component values being stored on 16 bits though.
It's super unusual, to the point where it's almost useless for us to
test, and we should probably use 8 bits values.

Maxime

1: https://elixir.bootlin.com/linux/v6.13.5/source/include/uapi/drm/drm_fou=
rcc.h#L486

--dglgkcz5iwfzaztz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZ8rIYQAKCRDj7w1vZxhR
xVzYAP9rRdEBKDBlAzEO5IQ1wUe25zP0DvxADvh+2MUptKjhLwD/f2BADYXMpWD3
0/KaWjAiO2qVPZFDjmh6kZqIV7772Qk=
=sXNv
-----END PGP SIGNATURE-----

--dglgkcz5iwfzaztz--

