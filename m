Return-Path: <linux-kernel+bounces-263042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EB493D040
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E673D1C2137F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B432139D19;
	Fri, 26 Jul 2024 09:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fN2lxhqZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA031B27D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 09:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721985320; cv=none; b=EXe55gZNPmK+E7BWrL8LJBD6/F75JnaG1Is+pL9peqCyqgTB0dcfSMg3UC+oegQr4uOovJGJKwTpjyvFV/f3zVNOXj1nW9/rIWufYUuU1rBiLszg+9zFq748MvvUl5+jFVQtreFbSzzeg8eT0Mc9wWD5AWIDruvNKlFqFoSJi9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721985320; c=relaxed/simple;
	bh=+3KipAdMkz7ouFwoVTO6+S2BvdR0gdeKjK0jxXgcjbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/E+CJV3QLViKbw2D4QMcbfIt5Y7TulPA0StGIKGMcxPRSiZ+VYErXTCS+HmOAPw0JjLm/5wINkcRvu52Et08iLp+IxHC2d8/9u/a1mOfrLIWK4CEkd9ZbvRXjZNUusXLKdQ5TAYNq4AG9T9D6rssKiK/GNsryPYYsK1HPkSg+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fN2lxhqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656DEC32782;
	Fri, 26 Jul 2024 09:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721985319;
	bh=+3KipAdMkz7ouFwoVTO6+S2BvdR0gdeKjK0jxXgcjbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fN2lxhqZMltcJSpjkLy8AERAvzZJgDp0ep4xz254tTsfSMyjfu7ENe9LwQHyt1W/p
	 8EL2Q0+You1AWHiueEniRGZhfcY9UYLYOSavjINOgPsWq5/204CxiqqyMtF8OIwbOw
	 F52zp7CY9SwKONNwAAa/HqolPUevOu02vsbyYzSXzB5nU6U6Q01ejsr+qwIKW7UXnX
	 QDnBExtTi2/0WuBQs+OBTe//7SNU5CLv2alPzgW+WbCWVqKUsqdTaLkmFjupJYZC9i
	 VTm3I5okaeD0hhuIeqQg6O/UHCa9irDtt4i8l8xX5Vjq2c/acPzRwXUb7OrCNoALkg
	 o0lErYRwnOLyg==
Date: Fri, 26 Jul 2024 11:15:17 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
	Tejas Vipin <tejasvipin76@gmail.com>, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/mipi-dsi: Change multi functions to use quiet
 member of mipi_dsi_multi_context
Message-ID: <20240726-cerise-civet-of-reverence-ebeb9d@houat>
References: <20240724122447.284165-1-tejasvipin76@gmail.com>
 <20240724122447.284165-3-tejasvipin76@gmail.com>
 <877cdakdq9.fsf@intel.com>
 <20240725-psychedelic-benevolent-muskrat-c7fd57@houat>
 <CAD=FV=WbXdnM4or3Ae+nYoQW1Sce0jP6FWtCHShsALuEFNhiww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="brdy5362wmxxqwhw"
Content-Disposition: inline
In-Reply-To: <CAD=FV=WbXdnM4or3Ae+nYoQW1Sce0jP6FWtCHShsALuEFNhiww@mail.gmail.com>


--brdy5362wmxxqwhw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 25, 2024 at 10:12:46AM GMT, Doug Anderson wrote:
> On Thu, Jul 25, 2024 at 1:28=E2=80=AFAM Maxime Ripard <mripard@kernel.org=
> wrote:
> >
> > On Wed, Jul 24, 2024 at 06:32:14PM GMT, Jani Nikula wrote:
> > > On Wed, 24 Jul 2024, Tejas Vipin <tejasvipin76@gmail.com> wrote:
> > > > Changes all the multi functions to check if the current context req=
uires
> > > > errors to be printed or not using the quiet member.
> > > >
> > > > Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> > > > ---
> > > >  drivers/gpu/drm/drm_mipi_dsi.c | 20 ++++++++++++++++++++
> > > >  1 file changed, 20 insertions(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_m=
ipi_dsi.c
> > > > index a471c46f5ca6..cbb77342d201 100644
> > > > --- a/drivers/gpu/drm/drm_mipi_dsi.c
> > > > +++ b/drivers/gpu/drm/drm_mipi_dsi.c
> > > > @@ -814,6 +814,8 @@ void mipi_dsi_generic_write_multi(struct mipi_d=
si_multi_context *ctx,
> > > >     ret =3D mipi_dsi_generic_write(dsi, payload, size);
> > > >     if (ret < 0) {
> > > >             ctx->accum_err =3D ret;
> > > > +           if (ctx->quiet)
> > > > +                   return;
> > > >             dev_err(dev, "sending generic data %*ph failed: %d\n",
> > > >                     (int)size, payload, ctx->accum_err);
> > >
> > > A maintainability nitpick. Imagine someone wishing to add some more
> > > error handling here. Or something else after the block.
> > >
> > > IMO the dev_err() should be wrapped in if (!ctx->quiet) instead of
> > > adding an early return.
> > >
> > > Ditto everywhere.
> >
> > I'm not even sure why we need that parameter in the first place.
> >
> > Like, what's the expected use of that parameter? Is it supposed to be
> > set in users of that function?
> >
> > If so, wouldn't it prevent any sort of meaningful debugging if some
> > drivers set it and some don't?
> >
> > It looks to me like you're reimplementing drm.debug.
>=20
> I can explain how we got here and maybe you can explain how it should
> be designed differently.
>=20
> 1. The majority of MIPI panels drivers just have a pile of commands
> that need to be sent during panel init time. Each time you send a
> command it technically can fail but it's very unlikely. In order to
> make things debuggable in the unlikely case of failure, you want a
> printout about which command failed. In order to avoid massive numbers
> of printouts in each driver you want the printout in the core. This is
> the impetus behind the "_multi" functions that were introduced
> recently and I think most people who have looked at converted drivers
> are pretty pleased. The functions are readable/non-bloated but still
> check for errors and print messages in the right place.
>
> 2. As Tejas was adding more "_multi" variants things were starting to
> feel a bit awkward. Dmitry proposed [1] that maybe the answer was that
> we should work to get rid of the non-multi variants and then we don't
> need these awkward wrappers.

Makes sense to me so far

> 3. The issue with telling everyone to use the "_multi" variants is
> that they print the error message for you. While this is the correct
> default behavior and the correct behavior for the vast majority of
> users, I can imagine there being a legitimate case where a driver
> might not want error messages printed.

That's the part I disagree with actually. I don't think that message
printing is a driver's decision, but a context one. Users might want to
increase / decrease the log levels, but drivers shouldn't and just
provide a consistent behaviour there.

> I don't personally know of a case, but in my experience there's always
> some case where you're dealing with weird hardware and the driver
> knows that a command has a high chance of failure. Maybe the driver
> will retry or maybe it'll detect /handle the error, but the idea is
> that the driver wouldn't want a printout.

Then we'll address it when the time comes and we're sure what we're
actually trying to fix. And even that theoretical scenario might just
disappear when the printk threaded printing work is done.

> Said another way: I think of the errors of these MIPI initialization
> functions a lot like errors allocating memory. By default kmalloc()
> reports an error so all drivers calling kmalloc() don't need to print,
> but if your driver specifically knows that an allocation failure is
> likely and it knows how to handle it then it can pass a flag to tell
> the core kernel not to print.
>=20
>=20
> So I guess options are:
>=20
> a) Accept what Tejas is doing here as reasonable.

I don't think it's unreasonable, however I do think it's an API that has
no current users and will just lead to inconsistencies in the drivers,
without any benefit at the moment.

> b) Don't accept what Tejas is doing here and always keep the "_multi"
> functions as wrappers.
>=20
> c) Declare that, since there are no known cases where we want to
> suppress the error printouts, that suppressing the error printouts is
> a "tomorrow" problem. We transition everyone to _multi but don't
> provide a way to suppress the printouts.

That's my preferred solution.

Maxime

--brdy5362wmxxqwhw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZqNpHAAKCRAnX84Zoj2+
dlvFAX44yEW+u4GoCcKUC7TqYWqzzB3Aax+bdjws1zuvZVj8u4gTbQUAzshPV6z5
oimFS/gBgMY5MhscZDqIk+IguVW40pD1pI4nnug0O54UOzjmNvezWyWsuxx9moZy
zwYBFtCqIw==
=YWm7
-----END PGP SIGNATURE-----

--brdy5362wmxxqwhw--

