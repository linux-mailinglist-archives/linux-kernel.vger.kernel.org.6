Return-Path: <linux-kernel+bounces-248925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D4B92E3ED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A4B328165F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4756B157491;
	Thu, 11 Jul 2024 09:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjUl7Uzb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829B315747C;
	Thu, 11 Jul 2024 09:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720691922; cv=none; b=uIbfBMmGDYayGa+6OmOi195EFy4sbZPGFnorJeBd0NbQHEJinHJa9cNw2D+YI5u6lTuRh0JMLYkltGulxhapMKTFXfoX5OgDLj/IFw5RnfUVv1a9B/1H/nmqatQcGy5QDUEUqwWtkOsL+3Reh1EHaVDlLFfKlmcuKksAjIP2oWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720691922; c=relaxed/simple;
	bh=WuvcPyYCPZVdObRzkt1wRjrxvRBYyt8oPc8M1YvBhVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GR3l3lT9JGYC3oN04gq6HcwX0vzVzBAbQQiwV/flVkhszYRlSEkwGtUu5CJDt/2FOhvF+3u5/zgjzmSV9KQoQ7V1UMrxpwezCAM6VGWCKy8Q0zaAwN0z1nzjNCs+7CmUaOP1fh0kqXMWbD9SNbG2uvgZE3MhwwOFBbBSx14ssdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjUl7Uzb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B68C116B1;
	Thu, 11 Jul 2024 09:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720691922;
	bh=WuvcPyYCPZVdObRzkt1wRjrxvRBYyt8oPc8M1YvBhVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fjUl7UzbTkgcD0Civgq2Uxe04S1u/b2s/CouNh2KieybTTl/KucwfS3DvVk/9bw6s
	 rx26o1bt0Ua9bmgwSefq3HyJAPZkdTdd0vDQ053QjgqP2uz5juuvweRlmwtyaxS2Sl
	 XoqaIkWf9Y4SPs4YL8+82EvPZyOJUscsGyEx1elWOlPohA5xqJMOc2y05BkbFtfs6S
	 72wgve9PkMUu/qF2QDn3QBJNOJfV25IQa9ktYi3U7+r0PDopXyfhTBms6Xgc3TKV42
	 MC8lowyAZwxe95VnPCIAyZm5gK/nOlXnaC3XfrghD/+y6Vys7qtIpJ6FLWHUP9bKIh
	 JuFdcwI7la6HA==
Date: Thu, 11 Jul 2024 10:58:34 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Manikandan.M@microchip.com, Hari.PrasathGE@microchip.com,
	andrzej.hajda@intel.com, neil.armstrong@linaro.org,
	rfoss@kernel.org, Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com,
	daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux@armlinux.org.uk,
	Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, arnd@arndb.de, Jason@zx2c4.com,
	palmer@rivosinc.com, mpe@ellerman.id.au, rdunlap@infradead.org,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] drm/bridge: add Microchip DSI controller support for
 sam9x7 SoC series
Message-ID: <20240711-freezing-decrease-4807d5d62f2a@spud>
References: <20240704084837.168075-1-manikandan.m@microchip.com>
 <20240704084837.168075-3-manikandan.m@microchip.com>
 <9ef5a1ba-e404-46e0-8513-5fffbfb5618b@kernel.org>
 <aeaeb5d4-5e55-4a7a-bce7-fa207ebf0616@microchip.com>
 <4c1b7af7-e53c-492a-9c41-40cad78f7666@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EWu0S0GtGVx/Ra1x"
Content-Disposition: inline
In-Reply-To: <4c1b7af7-e53c-492a-9c41-40cad78f7666@kernel.org>


--EWu0S0GtGVx/Ra1x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 11:05:37AM +0200, Krzysztof Kozlowski wrote:
> On 11/07/2024 10:30, Manikandan.M@microchip.com wrote:
> > Hi Krzysztof,
> >=20
> > On 04/07/24 4:27 pm, Krzysztof Kozlowski wrote:
> >> EXTERNAL EMAIL: Do not click links or open attachments unless you know=
 the content is safe
> >>
> >> On 04/07/2024 10:48, Manikandan Muralidharan wrote:
> >>> Add the Microchip's DSI controller wrapper driver that uses
> >>> the Synopsys DesignWare MIPI DSI host controller bridge.
> >>>
> >>> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> >>> ---
> >>
> >>
> >> ...
> >>
> >>> +
> >>> +#define HSTT(_maxfreq, _c_lp2hs, _c_hs2lp, _d_lp2hs, _d_hs2lp)      =
 \
> >>> +{                                    \
> >>> +     .maxfreq =3D _maxfreq,            \
> >>> +     .timing =3D {                     \
> >>> +             .clk_lp2hs =3D _c_lp2hs,  \
> >>> +             .clk_hs2lp =3D _c_hs2lp,  \
> >>> +             .data_lp2hs =3D _d_lp2hs, \
> >>> +             .data_hs2lp =3D _d_hs2lp, \
> >>> +     }                               \
> >>> +}
> >>> +
> >>> +struct hstt hstt_table[] =3D {
> >>
> >> So more globals? No.
> >=20
> > In the sam9x7 datasheet, the high speed transition time for data and
> > clock lane at different freq for the DSI controller ranges are tabulated
> > with constant values.
> > I referred other similar platforms for the functionality and found=20
> > similar way of implementation,  only a few had equations to derive the=
=20
> > low power and high speed timings.I am not able to come up with a more=
=20
> > efficient method. If there is something I am missing, please suggest.
> > TIA
>=20
> Yeah, this should not be a global. Nothing above suggests it.

I think what Krzysztof is suggesting here is use of the static
keyword...

>=20
> BTW, no W=3D1 clang warnings? Are you sure?
>=20
> Best regards,
> Krzysztof
>=20

--EWu0S0GtGVx/Ra1x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZo+sygAKCRB4tDGHoIJi
0gtxAQD5lJOy/q4aES6K9CjXBUSnOWaI63qOFMdQ616WHgo78wD9FOHchUgSltnR
kDI6geXp0AJKzlBkFd7UwEarIdbUJAc=
=Ikhe
-----END PGP SIGNATURE-----

--EWu0S0GtGVx/Ra1x--

