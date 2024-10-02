Return-Path: <linux-kernel+bounces-347381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9AB98D1E8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A55C8B23F85
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94561E631B;
	Wed,  2 Oct 2024 11:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Txg87ZnA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BD215D1
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 11:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866953; cv=none; b=O5mRPB5sqwkba4/EtzVJPJoDEE88R5t0ytSZ16HF3nG1Gwl0YPu1ipp0j4XKLUEUwmiZED05apHhFBpGZo8d7vgk9p2IkzzcB7fngXrFAdzAu9hB4fIeu2T4HeUcpw+BJIlgsoX8m/7/4pLNBfw1tyjelgm1MlRKH3ppJN2Jtrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866953; c=relaxed/simple;
	bh=9j2BeEGbLd2/42+mKnTsM3XBzovb8J2sED2Thy2UDJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isnJYPa7zntUwumT3IvHS8tW4xaYcbl0zgCeExB0/PdzJgPmb1UA06yu0xhGNJDbEiNJO54HpHLNsrywWdSza5CT0mcyXNQttOcbJMsPpmTU391srRxoVhWMsM8KCQo9NyIsNPHwgXY9/Fy8xmJGoEoYw4CSCEhChOxE5IJ74NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Txg87ZnA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BA9C4CECD;
	Wed,  2 Oct 2024 11:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727866951;
	bh=9j2BeEGbLd2/42+mKnTsM3XBzovb8J2sED2Thy2UDJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Txg87ZnAx6t5DXL/Bltm0vLfwCEHLrh/euzGIVbfeKqbTdzNiE9c79d2B+EHvZSdN
	 1xfoTFJqC8p8qVrzINEdSMyqttcWPT7ybgt60O3o+MHUmKKGDh9oqiNmkQhTvmAuko
	 Rd6v12h7BjtWhNv1373RveOh1hFU1p3r6M5pj2kKkPuFKPM8MfpvwUYH/qEAvQJkiq
	 aq9cUB6AN1ZvwI7VLe/9isEOyGDM+FFht5FftNMt5/RaQheEdjMEYEr1dogqcpllBz
	 mL0KV/fAEcDkvqIN0TEjZ2vI9ZzpnrXWC2z0T4tvCZzJ2jbejT7G3NEImUNAhrvU8O
	 Hcd2wD7/xLHew==
Date: Wed, 2 Oct 2024 13:02:28 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jocelyn Falempe <jfalempe@redhat.com>
Cc: Yao Zi <ziyao@disroot.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, dri-devel@lists.freedesktop.org, 
	linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] drm/meson: Support drm_panic
Message-ID: <20241002-vengeful-vivacious-salamander-cdc9f7@houat>
References: <20241001210403.43535-2-ziyao@disroot.org>
 <20241001210403.43535-3-ziyao@disroot.org>
 <28bd30a6-127d-48f0-8e32-703ebd8f69b6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="owesevwxs64vyreh"
Content-Disposition: inline
In-Reply-To: <28bd30a6-127d-48f0-8e32-703ebd8f69b6@linaro.org>


--owesevwxs64vyreh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

+ Jocelyn

On Wed, Oct 02, 2024 at 09:59:57AM GMT, Neil Armstrong wrote:
> > diff --git a/drivers/gpu/drm/meson/meson_plane.c b/drivers/gpu/drm/meso=
n/meson_plane.c
> > index b43ac61201f3..b2def784c00d 100644
> > --- a/drivers/gpu/drm/meson/meson_plane.c
> > +++ b/drivers/gpu/drm/meson/meson_plane.c
> > @@ -20,6 +20,8 @@
> >   #include <drm/drm_framebuffer.h>
> >   #include <drm/drm_gem_atomic_helper.h>
> >   #include <drm/drm_gem_dma_helper.h>
> > +#include <drm/drm_gem_framebuffer_helper.h>
> > +#include <drm/drm_panic.h>
> >   #include "meson_plane.h"
> >   #include "meson_registers.h"
> > @@ -419,10 +421,49 @@ static void meson_plane_atomic_disable(struct drm=
_plane *plane,
> >   	priv->viu.osd1_enabled =3D false;
> >   }
> > +static int meson_plane_get_scanout_buffer(struct drm_plane *plane,
> > +					  struct drm_scanout_buffer *sb)
> > +{
> > +	struct meson_plane *meson_plane =3D to_meson_plane(plane);
> > +	struct meson_drm *priv =3D meson_plane->priv;
> > +	struct drm_framebuffer *fb;
> > +
> > +	if (!meson_plane->enabled)
> > +		return -ENODEV;
> > +
> > +	if (priv->viu.osd1_afbcd) {
> > +		if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXM)) {
>=20
> This should be meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)
>=20
> You should call:
>=20
> 			if (priv->afbcd.ops) {
> 				priv->afbcd.ops->reset(priv);
> 				priv->afbcd.ops->disable(priv);
> 			}

I'm not sure it's a good idea. This code is run in the panic path, and
it comes with strict requirements that these functions don't have.

It'll be incredibly easy to add a sleeping call or a lock in there.

On a more fundamental level, I'm not sure we should be disableing AFBC
at all. Do we even have the guarantee that the buffer is large enough to
hold XRGB8888 pixels?

Maxime

--owesevwxs64vyreh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZv0oPwAKCRAnX84Zoj2+
drdoAYDUbD1TVzoD+vFsR/eZbWvIGzpO8oTzWhSg6rnB+ndSUhyUNF7jPYk6mlWQ
f0WykIcBgP6bb96gVvv8ODlkA5LKqj/JuphXpiLFhHc4hHZruUeOGcwCa1iSYoyg
0iDapEKO1A==
=l1k1
-----END PGP SIGNATURE-----

--owesevwxs64vyreh--

