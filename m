Return-Path: <linux-kernel+bounces-211737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A7E905635
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBA8D1F25E8E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADB21DDF6;
	Wed, 12 Jun 2024 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGFxis70"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2235317E90A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 15:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204619; cv=none; b=I7So89EIwRAaraYFb2j8cKrq8/i3iAmMaRxaJBwp64asIaHTv6HDG61JQrSiBcmUk/sTD3j02/1F/3PVhTvmOkyg6/y/1yrc+BfAWRbuICCZiA6gx7OOrqbR76i57XFbwhqfck4a4sK4fNU1j8DVz/zOP/vCC7ZLf/hHcYjK+zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204619; c=relaxed/simple;
	bh=706WUpcGbq+NDKSXOY/snfZFRh0zufY4LPNdKjpG+NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=keNuHTKpuozJSUnxqbLdxC+4EyiiesIGLbzjE+JbX2yRSc0VhGnK4gRSb0RC+aaRV6Vt2SiLO9WThnWUMhH4DPk0qXpHpvOVbw/cy/jNf3Vz1sSheXvhu8Eg2Ef2yYPa4Botx/+tcMcBfmjXWwPGYvBaUWPk3MZBQ2c+gPooO9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGFxis70; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E32EC3277B;
	Wed, 12 Jun 2024 15:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718204618;
	bh=706WUpcGbq+NDKSXOY/snfZFRh0zufY4LPNdKjpG+NA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eGFxis70Mun2y8XB/lI8sWhk6hZyARQ21lXe3kGBkJx8uU6G9AfYakGRVKzAsO/Dr
	 S8AQ84rVedE+4JUcsLy7ja5o42ECjsyFTqEsifadHO833jekYfbQNwDhmtVOHKXIpm
	 L4vJWvdNwobNw3SuN41cgFsxwTptYpnZx3Dw4oS7RZFt8/C/oWWzJ3OXsXHaokTzzj
	 QXyYwsFO1LTW5QwAKbt+dZKM94mgL2ocOf98z7dwmOTU9FodfvzFxArK2JLchaRK/P
	 0Hor4su3LMhL92z2CfZUUKkpNlxYA+uezHBRQIa9HHnN6L5wuh9XfwtVIdzFPuxbtk
	 A9NTkuKoGi5Dg==
Date: Wed, 12 Jun 2024 17:03:34 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, 
	Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Yuran Pereira <yuran.pereira@hotmail.com>, Chris Morgan <macromorgan@hotmail.com>, 
	David Airlie <airlied@gmail.com>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/panel: Avoid warnings w/ panel-simple/panel-edp at
 shutdown
Message-ID: <20240612-lean-intrepid-sponge-bb30e6@houat>
References: <20240611074846.1.Ieb287c2c3ee3f6d3b0d5f49b29f746b93621749c@changeid>
 <ZmljNHteJ9L5EdE9@phenom.ffwll.local>
 <CAD=FV=V4C1AYVqG4gig+SiQr4n_mAPVASxneDDZT1a=7AY3Hzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fib2hj3isyom324o"
Content-Disposition: inline
In-Reply-To: <CAD=FV=V4C1AYVqG4gig+SiQr4n_mAPVASxneDDZT1a=7AY3Hzw@mail.gmail.com>


--fib2hj3isyom324o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 07:49:31AM GMT, Doug Anderson wrote:
> Hi,
>=20
> On Wed, Jun 12, 2024 at 1:58=E2=80=AFAM Daniel Vetter <daniel@ffwll.ch> w=
rote:
> >
> > On Tue, Jun 11, 2024 at 07:48:51AM -0700, Douglas Anderson wrote:
> > > At shutdown if you've got a _properly_ coded DRM modeset driver then
> > > you'll get these two warnings at shutdown time:
> > >
> > >   Skipping disable of already disabled panel
> > >   Skipping unprepare of already unprepared panel
> > >
> > > These warnings are ugly and sound concerning, but they're actually a
> > > sign of a properly working system. That's not great.
> > >
> > > It's not easy to get rid of these warnings. Until we know that all DRM
> > > modeset drivers used with panel-simple and panel-edp are properly
> > > calling drm_atomic_helper_shutdown() or drm_helper_force_disable_all()
> > > then the panel drivers _need_ to disable/unprepare themselves in order
> > > to power off the panel cleanly. However, there are lots of DRM modeset
> > > drivers used with panel-edp and panel-simple and it's hard to know
> > > when we've got them all. Since the warning happens only on the drivers
> > > that _are_ updated there's nothing to encourage broken DRM modeset
> > > drivers to get fixed.
> > >
> > > In order to flip the warning to the proper place, we need to know
> > > which modeset drivers are going to shutdown properly. Though ugly, do
> > > this by creating a list of everyone that shuts down properly. This
> > > allows us to generate a warning for the correct case and also lets us
> > > get rid of the warning for drivers that are shutting down properly.
> > >
> > > Maintaining this list is ugly, but the idea is that it's only short
> > > term. Once everyone is converted we can delete the list and call it
> > > done. The list is ugly enough and adding to it is annoying enough that
> > > people should push to make this happen.
> > >
> > > Implement this all in a shared "header" file included by the two panel
> > > drivers that need it. This avoids us adding an new exports while still
> > > allowing the panel drivers to be modules. The code waste should be
> > > small and, as per above, the whole solution is temporary.
> > >
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > > I came up with this idea to help us move forward since otherwise I
> > > couldn't see how we were ever going to fix panel-simple and panel-edp
> > > since they're used by so many DRM Modeset drivers. It's a bit ugly but
> > > I don't hate it. What do others think?
> >
> > I think it's terrible :-)
>=20
> Well, we're in agreement. It is terrible. However, in my opinion it's
> still a reasonable way to move forward.
>=20
>=20
> > Why does something like this now work?
> >
> > drm_panel_shutdown_fixup(panel)
> > {
> >         /* if you get warnings here, fix your main drm driver to call
> >          * drm_atomic_helper_shutdown()
> >          */
> >         if (WARN_ON(panel->enabled))
> >                 drm_panel_disable(panel);
> >
> >         if (WARN_ON(panel->prepared))
> >                 drm_panel_unprepare(panel);
> > }
> >
> > And then call that little helper in the relevant panel drivers? Also fe=
el
> > free to bikeshed the name and maybe put a more lengthly explainer into =
the
> > kerneldoc for that ...
> >
> > Or am I completely missing the point here?
>=20
> The problem is that the ordering is wrong, I think. Even if the OS was
> calling driver shutdown functions in the perfect order (which I'm not
> convinced about since panels aren't always child "struct device"s of
> the DRM device), the OS should be calling panel shutdown _before_
> shutting down the DRM device. That means that with your suggestion:
>=20
> 1. Shutdown starts and panel is on.
>=20
> 2. OS calls panel shutdown call, which prints warnings because panel
> is still on.
>=20
> 3. OS calls DRM driver shutdown call, which prints warnings because
> someone else turned the panel off.
>=20
> :-P
>=20
> Certainly if I goofed and the above is wrong then let me know--I did
> my experiments on this many months ago and didn't try repeating them
> again now.
>=20
> In any case, the only way I could figure out around this was some sort
> of list. As mentioned in the commit message, it's super ugly and
> intended to be temporary. Once we solve all the current in-tree
> drivers, I'd imagine that long term for new DRM drivers this kind of
> thing would be discovered during bringup of new boards. Usually during
> bringup of new boards EEs measure timing signals and complain if
> they're not right. If some EE cared and said we weren't disabling the
> panel correctly at shutdown time then we'd know there was a problem.

Based on a discussion we had today With Sima on IRC, I think there's
another way forward.

We were actually discussing refcount'ing the panels to avoid lifetime
issues. It would require some API overhaul to have a function to
allocate the drm_panel structure and init'ing the refcount, plus some to
get / put the references.

Having this refcount would mean that we also get a release function now,
called when the panel is free'd.

Could we warn if the panel is still prepared/enabled and is about to be
freed?

It would require to switch panel-simple and panel-edp to that new API,
but it should be easy enough.

Maxime

--fib2hj3isyom324o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZmm4xgAKCRDj7w1vZxhR
xV9DAP97um/MW9/cNpVyoRNyslgtaVeJw0pCd1ceNf4lsZolEgD/drvM2ZaMe2h0
86o1GqmQAJE1yfQ5yawsYLcaptlDIgY=
=Clr1
-----END PGP SIGNATURE-----

--fib2hj3isyom324o--

