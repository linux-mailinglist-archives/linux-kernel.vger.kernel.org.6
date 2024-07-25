Return-Path: <linux-kernel+bounces-261932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A982593BDF3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB5C21C21CC9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 08:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF168171E5A;
	Thu, 25 Jul 2024 08:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7bSXh2Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40901741D4
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721896123; cv=none; b=hAfZQ5LwpCj7sqj8n6coYAUzUcAtCbODKPheyaL9rozYN5lUoSbyAEBKUzHEJOIvBvR40BrKW0lAuZpNHpedxlwUg8RhV0JYcpfe+22T4X5EMxXKY+w2/xebNPCg7zOaaqIcmrPQo9hMAslNwMAli7otTXEUuNDjr74DO/HZMvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721896123; c=relaxed/simple;
	bh=R+MoQiq0ezXB3XUgzyXzBvBtjpK07hHk3p2j78N9lh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n074zfbEA8mLL3Xzb6P20CMst+ycHt6t/yvzIoWH6s2slxMTk/FTuUoAV29JrKJnuE76Ts+KoIP6dmEKCVelIMnu/K+S0YSMhufabox3V0a9HV9npU8MSXyWV+tqsLTX+o9kHdrBt4kKute+LTO3WfXi5CZmafFdF1eOvE9am54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7bSXh2Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83CD9C32786;
	Thu, 25 Jul 2024 08:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721896122;
	bh=R+MoQiq0ezXB3XUgzyXzBvBtjpK07hHk3p2j78N9lh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E7bSXh2QEpeFLrgo50q77a7Qc+a2y5K4KYSSMnartGgIIq5vN6vsVWubYTfWhdvMd
	 Hb6DjsEEDIDysBiAcJgPmyZJN7Ft7TC0exOylfaP3DY2G7JoqMvGptcWtZ8wizpWgv
	 TXEWbX5gMf5WG2ZoIYoea+4jhkR+CCrEZSW9WPBbKdjt9hpKYGVAfNTbEsWkNAMTll
	 bIxpPK0z6nRrQPKivW0wGqdcizSMc4JajpVFdpskDVhyKf63dMsQy7s0wNV1qzuJXh
	 Gu2mmhFSwZD6XkpRRoCmhPqH7UFATGBsU5aBLTalkqY9S7bwvtbg2cq0sQ+CMpzxwJ
	 RnTMyouDUfTRw==
Date: Thu, 25 Jul 2024 10:28:39 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Tejas Vipin <tejasvipin76@gmail.com>, 
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, dianders@chromium.org, airlied@gmail.com, 
	daniel@ffwll.ch, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/mipi-dsi: Change multi functions to use quiet
 member of mipi_dsi_multi_context
Message-ID: <20240725-psychedelic-benevolent-muskrat-c7fd57@houat>
References: <20240724122447.284165-1-tejasvipin76@gmail.com>
 <20240724122447.284165-3-tejasvipin76@gmail.com>
 <877cdakdq9.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="r2kg2p45e23w6s6x"
Content-Disposition: inline
In-Reply-To: <877cdakdq9.fsf@intel.com>


--r2kg2p45e23w6s6x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 06:32:14PM GMT, Jani Nikula wrote:
> On Wed, 24 Jul 2024, Tejas Vipin <tejasvipin76@gmail.com> wrote:
> > Changes all the multi functions to check if the current context requires
> > errors to be printed or not using the quiet member.
> >
> > Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> > ---
> >  drivers/gpu/drm/drm_mipi_dsi.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_=
dsi.c
> > index a471c46f5ca6..cbb77342d201 100644
> > --- a/drivers/gpu/drm/drm_mipi_dsi.c
> > +++ b/drivers/gpu/drm/drm_mipi_dsi.c
> > @@ -814,6 +814,8 @@ void mipi_dsi_generic_write_multi(struct mipi_dsi_m=
ulti_context *ctx,
> >  	ret =3D mipi_dsi_generic_write(dsi, payload, size);
> >  	if (ret < 0) {
> >  		ctx->accum_err =3D ret;
> > +		if (ctx->quiet)
> > +			return;
> >  		dev_err(dev, "sending generic data %*ph failed: %d\n",
> >  			(int)size, payload, ctx->accum_err);
>=20
> A maintainability nitpick. Imagine someone wishing to add some more
> error handling here. Or something else after the block.
>=20
> IMO the dev_err() should be wrapped in if (!ctx->quiet) instead of
> adding an early return.
>=20
> Ditto everywhere.

I'm not even sure why we need that parameter in the first place.

Like, what's the expected use of that parameter? Is it supposed to be
set in users of that function?

If so, wouldn't it prevent any sort of meaningful debugging if some
drivers set it and some don't?

It looks to me like you're reimplementing drm.debug.

Maxime

--r2kg2p45e23w6s6x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZqIMtwAKCRAnX84Zoj2+
dlgKAYCM7vThWWKXhQ8H0+codSU+dOKiX3sOnmy+JtM314VYoUeoIkOL/T5in0rI
XydYT+0BgKduy10xN7iJHLlze+TRKqBWe42kHDIufi1CXCQgHpWfKDiDlyEAVJsS
b625L4kCgg==
=LDgv
-----END PGP SIGNATURE-----

--r2kg2p45e23w6s6x--

