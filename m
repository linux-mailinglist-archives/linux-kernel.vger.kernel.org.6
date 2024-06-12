Return-Path: <linux-kernel+bounces-211146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33801904DAD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C10EBB2785A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6913E16C862;
	Wed, 12 Jun 2024 08:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyB3uyaw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A546716C843
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179753; cv=none; b=YptccKCbp0pntclPjS/W8BpooV6eb4jG0z/zc9MxJNMwDHNfXen4dSgBRJ3EJasnIueH7L4aYIYe6anBBTbR+I7FKwePP/PGLjbZW0567XeSe9ZAQUJjDo+P0dy53BUrOnyVwfadCOqiDs73D29PRhWdsYceNV2P/uhrM+mi8NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179753; c=relaxed/simple;
	bh=qIdC5+lu1SEknjJJ51GXyfiihZ8p/z6UgJF+gLxllbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXwPrsKgASHFf6NG2IQMmQs6h3hnDBis5Iz6YpsWaYqiffXh2yjB1iMKXTnZZgZHJ2ERVmVFPq3W/yKuDrdsGvCdr/GDtrTiWSsOIWz3N8gK4KOL3uvJYH6xhDEy3Sas8Cc6ck4zZx5suavkB8d+7/JL+4cJwZ1cEdfmIfagol4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyB3uyaw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3688C3277B;
	Wed, 12 Jun 2024 08:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718179753;
	bh=qIdC5+lu1SEknjJJ51GXyfiihZ8p/z6UgJF+gLxllbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GyB3uyawlYEjuE7xWe8gQxWLQJQZujpIg4lDjU1YaRJHiCJPrLWNWVWRMpVGtfr0S
	 9UnBlSpAA4iuHCbJkGh9wXfZuWMb9DH6hbjSuAxDURlNmtx3IwE/qqjpJ7/9KhHVlv
	 L5i/87ODm7q10P7s+kC6MTi5RH7Zhso85iAfodl22jM9A+yUqIm+UAVOGr26Kae2DU
	 1qQ8A7QsQZTDWhQMhuQt2gyZnjQOAymuDqH+9Fi1JzU97Z8Z3sVsFV3EGM93J+4dND
	 N8epbjclFpWzONEmcKbjZY5B3jnb/zBFcVnFfGyAow9HpoqIpe9FmwQKwiHhwGUO1/
	 00HuDV+f3SD8g==
Date: Wed, 12 Jun 2024 10:09:10 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, 
	Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Yuran Pereira <yuran.pereira@hotmail.com>, Chris Morgan <macromorgan@hotmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panel: Avoid warnings w/ panel-simple/panel-edp at
 shutdown
Message-ID: <20240612-garnet-condor-from-saturn-1c51bb@houat>
References: <20240611074846.1.Ieb287c2c3ee3f6d3b0d5f49b29f746b93621749c@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="avglh3oymnxtl4ps"
Content-Disposition: inline
In-Reply-To: <20240611074846.1.Ieb287c2c3ee3f6d3b0d5f49b29f746b93621749c@changeid>


--avglh3oymnxtl4ps
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 11, 2024 at 07:48:51AM GMT, Douglas Anderson wrote:
> At shutdown if you've got a _properly_ coded DRM modeset driver then
> you'll get these two warnings at shutdown time:
>=20
>   Skipping disable of already disabled panel
>   Skipping unprepare of already unprepared panel
>=20
> These warnings are ugly and sound concerning, but they're actually a
> sign of a properly working system. That's not great.
>=20
> It's not easy to get rid of these warnings. Until we know that all DRM
> modeset drivers used with panel-simple and panel-edp are properly
> calling drm_atomic_helper_shutdown() or drm_helper_force_disable_all()
> then the panel drivers _need_ to disable/unprepare themselves in order
> to power off the panel cleanly. However, there are lots of DRM modeset
> drivers used with panel-edp and panel-simple and it's hard to know
> when we've got them all. Since the warning happens only on the drivers
> that _are_ updated there's nothing to encourage broken DRM modeset
> drivers to get fixed.
>=20
> In order to flip the warning to the proper place, we need to know
> which modeset drivers are going to shutdown properly. Though ugly, do
> this by creating a list of everyone that shuts down properly. This
> allows us to generate a warning for the correct case and also lets us
> get rid of the warning for drivers that are shutting down properly.
>=20
> Maintaining this list is ugly, but the idea is that it's only short
> term. Once everyone is converted we can delete the list and call it
> done. The list is ugly enough and adding to it is annoying enough that
> people should push to make this happen.
>=20
> Implement this all in a shared "header" file included by the two panel
> drivers that need it. This avoids us adding an new exports while still
> allowing the panel drivers to be modules. The code waste should be
> small and, as per above, the whole solution is temporary.
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> I came up with this idea to help us move forward since otherwise I
> couldn't see how we were ever going to fix panel-simple and panel-edp
> since they're used by so many DRM Modeset drivers. It's a bit ugly but
> I don't hate it. What do others think?

I don't think it's the right approach, even more so since we're so close
now to having it in every driver.

I ran the coccinelle script we started with, and here are the results:

=2E/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c:1640:25-39: ERROR: KMS driver vmw_p=
ci_driver is missing shutdown implementation
=2E/drivers/gpu/drm/kmb/kmb_drv.c:621:30-49: ERROR: KMS driver kmb_platform=
_driver is missing shutdown implementation
=2E/drivers/gpu/drm/tiny/arcpgu.c:422:30-52: ERROR: KMS driver arcpgu_platf=
orm_driver is missing shutdown implementation

Looking at the drivers by hand, it seems consistent.

Moving forward, I think having a collection of coccinelle scripts that
we ask new driver authors to run or put them in CI somehow would be a
better path. We have other similar candidates that can't really be dealt
with any other way, like not using drmm_ memory allocations, or not
using drm_dev_enter / drm_dev_exit.

Maxime

--avglh3oymnxtl4ps
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZmlXpQAKCRDj7w1vZxhR
xfYZAQCNE0EYHn2MLwCjQYIeOxpucznvCNyoclGbKw4F8J5smAD+NH27g4lOaipv
my3B4MclOH8NfBxWWBvKnT/LhTn1PAI=
=T2jV
-----END PGP SIGNATURE-----

--avglh3oymnxtl4ps--

