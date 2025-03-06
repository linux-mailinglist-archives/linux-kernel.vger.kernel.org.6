Return-Path: <linux-kernel+bounces-548318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93362A54351
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3CAF7A7DDF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 07:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84D21A8F79;
	Thu,  6 Mar 2025 07:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuqElGty"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1239A1A7262
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 07:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741245019; cv=none; b=iTeEHH9gbvrDAg9+fHfjCbNdV/fVOst+7q8pOx+IzUfWyZ9TRTXN8ImZB5oZ4kdi5zXXfRO0BDTS+Lr2p3T7/YzMYztIsPZJYvrV5pIDJPlNp+KO7Jk62RIIKUIt/F867IZcyBSykjOfKMWU+D4oQl5CTC/uimtvLOQ8XDIi09M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741245019; c=relaxed/simple;
	bh=uLVKQD758EUg7Bo+dpC2xCHWzH3049GVfgk/d5pPfqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZoJKqNDOkoj/uIDAVdMkchrxMI7PPuVjoONSUgNZYx7aVnRYIYOk9t6ZrhaYHpnVJyTob/DrYuIp1oclBkUWz6uyp1hWgExUqWSCH/OiitO7Ze8q5x6uESOYv/Iw20+xUdpuKyLgRwR7NNgqK/zXuRUPSjv+LqCiGXM/O7rVw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuqElGty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8879FC4CEE4;
	Thu,  6 Mar 2025 07:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741245018;
	bh=uLVKQD758EUg7Bo+dpC2xCHWzH3049GVfgk/d5pPfqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZuqElGtySpnV76JQM6BL7UC7PMl1NZrXQdii8R2nl738rgghN8/r2jNj3wmvcE80r
	 7QaSxP2OHN12tdUR/ndi3dd6z3v1mdnexaOo1Ar45FUDqeRwQEn4F/9UWiSlFTC1Gi
	 un8WN6BBUXnlLMUt+RCHtPkXn8g/tpnFq5+uaIpEuUs1rmEgeEm52Tc+0O95UDohNt
	 Oy2VT0UXc4nW9P8tj33EDFQVDNQKR7P0Btd1srFi4dYTLeOfG4Vy4Cm7kbvDwxn/i8
	 2zFe4f82V00q3Q17TbfnBs76nxhim0omT+y5PdO4g0R/InEaIJi62orMuv4pTaibDP
	 0uGl/jlEhQ+Wg==
Date: Thu, 6 Mar 2025 08:10:16 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Andy Yan <andyshrk@163.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Douglas Anderson <dianders@chromium.org>, Herve Codina <herve.codina@bootlin.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Simona Vetter <simona.vetter@ffwll.ch>
Subject: Re: [PATCH v5 04/16] drm/atomic: Introduce helper to lookup
 connector by encoder
Message-ID: <20250306-able-wonderful-saluki-aacd1d@houat>
References: <20250304-bridge-connector-v5-0-aacf461d2157@kernel.org>
 <20250304-bridge-connector-v5-4-aacf461d2157@kernel.org>
 <5180089f.a640.19566290538.Coremail.andyshrk@163.com>
 <20250305-ruddy-nightingale-of-wealth-db100a@houat>
 <mqh4wedfokuta2tmyctoi6jrzol7mqzm27nj3ylu6yj2vjy22j@mexke5x2o7a2>
 <7c1c61e7.10e1.19569067029.Coremail.andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="pmuiqbf7dxpe77sp"
Content-Disposition: inline
In-Reply-To: <7c1c61e7.10e1.19569067029.Coremail.andyshrk@163.com>


--pmuiqbf7dxpe77sp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 04/16] drm/atomic: Introduce helper to lookup
 connector by encoder
MIME-Version: 1.0

On Thu, Mar 06, 2025 at 09:16:24AM +0800, Andy Yan wrote:
>=20
> Hi Maxime and Dmitry:
>=20
> At 2025-03-06 04:13:53, "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org> =
wrote:
> >On Wed, Mar 05, 2025 at 02:19:36PM +0100, Maxime Ripard wrote:
> >> Hi Andy,
> >>=20
> >> On Wed, Mar 05, 2025 at 07:55:19PM +0800, Andy Yan wrote:
> >> > At 2025-03-04 19:10:47, "Maxime Ripard" <mripard@kernel.org> wrote:
> >> > >With the bridges switching over to drm_bridge_connector, the direct
> >> > >association between a bridge driver and its connector was lost.
> >> > >
> >> > >This is mitigated for atomic bridge drivers by the fact you can acc=
ess
> >> > >the encoder, and then call drm_atomic_get_old_connector_for_encoder=
() or
> >> > >drm_atomic_get_new_connector_for_encoder() with drm_atomic_state.
> >> > >
> >> > >This was also made easier by providing drm_atomic_state directly to=
 all
> >> > >atomic hooks bridges can implement.
> >> > >
> >> > >However, bridge drivers don't have a way to access drm_atomic_state
> >> > >outside of the modeset path, like from the hotplug interrupt path o=
r any
> >> > >interrupt handler.
> >> > >
> >> > >Let's introduce a function to retrieve the connector currently assi=
gned
> >> > >to an encoder, without using drm_atomic_state, to make these driver=
s'
> >> > >life easier.
> >> > >
> >> > >Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >> > >Co-developed-by: Simona Vetter <simona.vetter@ffwll.ch>
> >> > >Signed-off-by: Maxime Ripard <mripard@kernel.org>
> >> > >---
> >> > > drivers/gpu/drm/drm_atomic.c | 45 ++++++++++++++++++++++++++++++++=
++++++++++++
> >> > > include/drm/drm_atomic.h     |  3 +++
> >> > > 2 files changed, 48 insertions(+)
> >> > >
> >> > >diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_ato=
mic.c
> >> > >index 9ea2611770f43ce7ccba410406d5f2c528aab022..b926b132590e78f8d41=
d48eb4da4bccf170ee236 100644
> >> > >--- a/drivers/gpu/drm/drm_atomic.c
> >> > >+++ b/drivers/gpu/drm/drm_atomic.c
> >> > >@@ -985,10 +985,55 @@ drm_atomic_get_new_connector_for_encoder(cons=
t struct drm_atomic_state *state,
> >> > >=20
> >> > > 	return NULL;
> >> > > }
> >> > > EXPORT_SYMBOL(drm_atomic_get_new_connector_for_encoder);
> >> > >=20
> >> > >+/**
> >> > >+ * drm_atomic_get_connector_for_encoder - Get connector currently =
assigned to an encoder
> >> > >+ * @encoder: The encoder to find the connector of
> >> > >+ * @ctx: Modeset locking context
> >> > >+ *
> >> > >+ * This function finds and returns the connector currently assigne=
d to
> >> > >+ * an @encoder.
> >> > >+ *
> >> > >+ * Returns:
> >> > >+ * The connector connected to @encoder, or an error pointer otherw=
ise.
> >> > >+ * When the error is EDEADLK, a deadlock has been detected and the
> >> > >+ * sequence must be restarted.
> >> > >+ */
> >> > >+struct drm_connector *
> >> > >+drm_atomic_get_connector_for_encoder(const struct drm_encoder *enc=
oder,
> >> > >+				     struct drm_modeset_acquire_ctx *ctx)
> >> > >+{
> >> > >+	struct drm_connector_list_iter conn_iter;
> >> > >+	struct drm_connector *out_connector =3D ERR_PTR(-EINVAL);
> >> > >+	struct drm_connector *connector;
> >> > >+	struct drm_device *dev =3D encoder->dev;
> >> > >+	int ret;
> >> > >+
> >> > >+	ret =3D drm_modeset_lock(&dev->mode_config.connection_mutex, ctx);
> >> > >+	if (ret)
> >> > >+		return ERR_PTR(ret);
> >> >=20
> >> > It seems that this will cause a deadlock when called from a hotplug
> >> > handling path, I have a WIP DP diver[0], which suggested by Dmitry to
> >> > use this API from a &drm_bridge_funcs.detect callback to get the
> >> > connector, as detect is called by drm_helper_probe_detect, which will
> >> > hold connection_mutex first, so the deaklock happens:
> >> >
> >> > drm_helper_probe_detect(struct drm_connector *connector,
> >> >                         struct drm_modeset_acquire_ctx *ctx,
> >> >                         bool force)
> >> > {
> >> >         const struct drm_connector_helper_funcs *funcs =3D connector=
->helper_private;
> >> >         struct drm_device *dev =3D connector->dev;
> >> >         int ret;
> >> >=20
> >> >         if (!ctx)
> >> >                 return drm_helper_probe_detect_ctx(connector, force);
> >> >=20
> >> >         ret =3D drm_modeset_lock(&dev->mode_config.connection_mutex,=
 ctx);
> >> >         if (ret)
> >> >                 return ret;
> >> >=20
> >> >         if (funcs->detect_ctx)
> >> >                 ret =3D funcs->detect_ctx(connector, ctx, force);
> >> >         else if (connector->funcs->detect)
> >> >                 ret =3D connector->funcs->detect(connector, force);
> >> >         else
> >> >                 ret =3D connector_status_connected;
> >> >=20
> >> >         if (ret !=3D connector->status)
> >> >                 connector->epoch_counter +=3D 1;
> >> >=20
> >> > So I wonder can we let drm_bridge_funcs.detect pass a connector for
> >> > this case ?
> >>=20
> >> Do you actually see a deadlock occurring? AFAIK, drm_modeset_lock is
> >> fine with reentrancy from the same context, so it should work just fin=
e.
> >
> >Andy, that probably means that you should use .detect_ctx() and pass the
> >context to drm_atomic_get_connector_for_encoder().
>=20
> Unfortunately, the drm_bridge_funcs does not have a .detect_ctx()  versio=
n .
> The call chain is:
>  drm_helper_probe_detect=20
>  --> drm_bridge_connector_detect(struct drm_connector *connector, bool fo=
rce)
> --> drm_bridge_funcs.detect(bridge)
> The ctx got dropped when drm_helper_probe_detect call  drm_bridge_connect=
or_detect
> The connector got dropped  when connector call it's bridege.detect
>=20
> So I think the simplest solution is to have drm_bridge_funcs.detect
> directly pass the connector

I don't disagree on principle, but I think a better first step would be
to provide a detect_ctx hook to bridges.

Maxime

--pmuiqbf7dxpe77sp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ8lKUwAKCRAnX84Zoj2+
dplLAYD0PNkWx2P6tT36ZQI4vktBQwh+kmk3ttmeVB9ObjGZ8/Ms2eFWQgF1Tab2
YpCqetIBf1d2P+PGirdlb8kkIk1NEfgOc5tRF1cL5rlFnGcXwQnyWpVG8AHTe9BF
dODqm7D1ig==
=n2MU
-----END PGP SIGNATURE-----

--pmuiqbf7dxpe77sp--

