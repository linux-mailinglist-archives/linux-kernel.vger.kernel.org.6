Return-Path: <linux-kernel+bounces-384515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1A79B2B24
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD3901C214F3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B1C192D65;
	Mon, 28 Oct 2024 09:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liRLP6S8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E8E8472;
	Mon, 28 Oct 2024 09:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730107007; cv=none; b=Mqiu/e0H6XjyNbRx30zvhcACGizcwOdVG5vXkIS7Te6fgHrYANO4HnnwjkvOzCN7LPj0tIVwsMHzYUNca7MroIsKcLh2QQR1fPE9Akx+4nMipHfUUZsBLfCDyd6wB6I7wEXVFrPlK220ORzCVL+16jEUjmMDK0p+cRpEuSiIxQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730107007; c=relaxed/simple;
	bh=cpowFjQL5ac0sI9lTiCKHPvqkdNL5V66GtX0gY1Wto4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JySexRBgTVV0Iew9hmq7+jZbzYS5RfaumQbhTwJRbWXCquMOQJ8O/axDaZLlagSwG+Q76Pl4j5AEv7aimy64odh3gtLVViVTnaKH9MpqLDObGssP7GGfoWrluK5JChLgwNQxRScruL2Qb27N5KhxpdHYHdQ2gZ6L8E0pgCBKOJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liRLP6S8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49488C4CEC7;
	Mon, 28 Oct 2024 09:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730107006;
	bh=cpowFjQL5ac0sI9lTiCKHPvqkdNL5V66GtX0gY1Wto4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=liRLP6S8dPdHMGGezPquS547M4OGL/QwBBDlg0wvtvrvnMg9YuA9Sib/paBHb/0cZ
	 qm+K+Po8enANPOgYX+p5ZzTbmLr87O8PInA4VXydND4SaeZwg5QBETzAkWtTXsIdMI
	 WPNZ3g/fv5PbVuZ79mMnc9UOzsQ3G3+NcfJ/OFxU82xe95Uvw0Asgs9ELApW/qPD2y
	 ybgGosJ+J1rpXG0ioE79UQV+cE0CUe2YssJHgYO2kHoqvD3up/s/X7CdJUzX6zQ1kk
	 wWv9W4u+h6vg9l+LSLZRmAKkPq/DVkwQD6RlS08KiXPtMmPZjokXw4ADwdaF28EPGv
	 RorCDQdgiwMgA==
Date: Mon, 28 Oct 2024 10:16:38 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Herve Codina <herve.codina@bootlin.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/2] drm: bridge: ti-sn65dsi83: Add error recovery
 mechanism
Message-ID: <20241028-thankful-boar-of-camouflage-3de96c@houat>
References: <20241024095539.1637280-1-herve.codina@bootlin.com>
 <20241024095539.1637280-3-herve.codina@bootlin.com>
 <20241027162350.GA15853@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="3wpjo5aswujp76pt"
Content-Disposition: inline
In-Reply-To: <20241027162350.GA15853@pendragon.ideasonboard.com>


--3wpjo5aswujp76pt
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] drm: bridge: ti-sn65dsi83: Add error recovery
 mechanism
MIME-Version: 1.0

On Sun, Oct 27, 2024 at 06:23:50PM +0200, Laurent Pinchart wrote:
> On Thu, Oct 24, 2024 at 11:55:38AM +0200, Herve Codina wrote:
> > In some cases observed during ESD tests, the TI SN65DSI83 cannot recover
> > from errors by itself. A full restart of the bridge is needed in those
> > cases to have the bridge output LVDS signals again.
> >=20
> > The TI SN65DSI83 has some error detection capabilities. Introduce an
> > error recovery mechanism based on this detection.
> >=20
> > The errors detected are signaled through an interrupt. On system where
> > this interrupt is not available, the driver uses a polling monitoring
> > fallback to check for errors. When an error is present, the recovery
> > process is launched.
> >=20
> > Restarting the bridge needs to redo the initialization sequence. This
> > initialization sequence has to be done with the DSI data lanes driven in
> > LP11 state. In order to do that, the recovery process resets the entire
> > pipeline.
> >=20
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  drivers/gpu/drm/bridge/ti-sn65dsi83.c | 128 ++++++++++++++++++++++++++
> >  1 file changed, 128 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/br=
idge/ti-sn65dsi83.c
> > index 96e829163d87..22975b60e80f 100644
> > --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> > +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> > @@ -35,9 +35,12 @@
> >  #include <linux/of_graph.h>
> >  #include <linux/regmap.h>
> >  #include <linux/regulator/consumer.h>
> > +#include <linux/timer.h>
> > +#include <linux/workqueue.h>
> > =20
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_bridge.h>
> > +#include <drm/drm_drv.h> /* DRM_MODESET_LOCK_ALL_BEGIN() need drm_drv_=
uses_atomic_modeset() */
> >  #include <drm/drm_mipi_dsi.h>
> >  #include <drm/drm_of.h>
> >  #include <drm/drm_panel.h>
> > @@ -147,6 +150,9 @@ struct sn65dsi83 {
> >  	struct regulator		*vcc;
> >  	bool				lvds_dual_link;
> >  	bool				lvds_dual_link_even_odd_swap;
> > +	bool				use_irq;
> > +	struct delayed_work		monitor_work;
> > +	struct work_struct		reset_work;
> >  };
> > =20
> >  static const struct regmap_range sn65dsi83_readable_ranges[] =3D {
> > @@ -321,6 +327,92 @@ static u8 sn65dsi83_get_dsi_div(struct sn65dsi83 *=
ctx)
> >  	return dsi_div - 1;
> >  }
> > =20
> > +static int sn65dsi83_reset_pipeline(struct sn65dsi83 *sn65dsi83)
> > +{
> > +	struct drm_device *dev =3D sn65dsi83->bridge.dev;
> > +	struct drm_modeset_acquire_ctx ctx;
> > +	struct drm_atomic_state *state;
> > +	int err;
> > +
> > +	/* Use operation done in drm_atomic_helper_suspend() followed by
> > +	 * operation done in drm_atomic_helper_resume() but without releasing
> > +	 * the lock between suspend()/resume()
> > +	 */
> > +
> > +	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, err);
> > +
> > +	state =3D drm_atomic_helper_duplicate_state(dev, &ctx);
> > +	if (IS_ERR(state)) {
> > +		err =3D PTR_ERR(state);
> > +		goto unlock;
> > +	}
> > +
> > +	err =3D drm_atomic_helper_disable_all(dev, &ctx);
> > +	if (err < 0)
> > +		goto unlock;
> > +
> > +	drm_mode_config_reset(dev);
> > +
> > +	err =3D drm_atomic_helper_commit_duplicated_state(state, &ctx);
>=20
> Committing a full atomic state from a bridge driver in an asynchronous
> way seems quite uncharted territory, and it worries me. It's also a very
> heavyweight, you disable all outputs here, instead of focussing on the
> output connected to the bridge. Can you either implement something more
> local, resetting the bridge only, or create a core helper to handle this
> kind of situation, on a per-output basis ?

I think you can't just shut down the bridge and restart it, since some
require particular power sequences that will only occur if you also shut
down the upstream controller.

So I think we'd need to tear down the CRTC, connector and everything
in between.

I do agree that it needs to be a generic helper though. In fact, it
looks awfully similar to what vc4 and i915 are doing in reset_pipe and
and intel_modeset_commit_pipes, respectively. It looks like a good
opportunity to make it a helper.

Maxime

--3wpjo5aswujp76pt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZx9WdQAKCRAnX84Zoj2+
dlU0AX9oM8QWND/c5jJedY7GC5KGs5tPBWxgQdpkaDgCAkA2xDZe1sujWA6/BpOi
AKivYFIBgOk6f4fkqoalxTQNntOLqoMyo+UGX3d5x7hLpOIfGbWxp9sYQUhuwJEm
WZEELz9SOQ==
=Tvr/
-----END PGP SIGNATURE-----

--3wpjo5aswujp76pt--

