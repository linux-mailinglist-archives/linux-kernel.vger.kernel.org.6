Return-Path: <linux-kernel+bounces-546906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE69A5006B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA19D188A378
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A943724886B;
	Wed,  5 Mar 2025 13:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ke/EMZff"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEE9244EAB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 13:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741180780; cv=none; b=l9uDTVTfS4uDRvPpGA8aAfrx1ZFibQQzaNKSGumA8hWoOVGL/cQ42VuSe6O2XGnJRkLbpgl3c7CnEeTTCOdOrpshkiCrWhIJ9lxUmf/dCS/SrZxhGcAxXDsU11aipFHQjDzaoIINH4+PqGMJVHJsbLSbuYjJaziAn5ZBuJ3G5Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741180780; c=relaxed/simple;
	bh=uUcip3fKJSxZyPCqVra0oNKUJGKwfrSvm7odqYGRqN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=goA1IHvfWb8k5aSBEHi0omovtfZAvfwj+436XNzM3lkS150UkL83tFyoBF7vTtXIyJtaokBgu0qECoGZoX4ioMpSbPurlEKNHq1X9MHQjZzdBDRHymOqwnrptzVcH9X23lOSlttKZp5zAPml6VdXXu1uUN83nEUUpVHSNSGFT/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ke/EMZff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C4FC4CEE2;
	Wed,  5 Mar 2025 13:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741180779;
	bh=uUcip3fKJSxZyPCqVra0oNKUJGKwfrSvm7odqYGRqN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ke/EMZfffV37DTQxmqDEtUkslsq4r5mZnIFPo5jdkcKqH8lhKdMT/TKoc1SipxdLP
	 cECENYNK5R9AjnCRov985p3pINnhDK7YkosIji80i6cHONxlLZ8hwHbnU8Sp16IMru
	 ckuWbBkMVaHFX9pMPHlNpfng7xlcIEZT/73vUejo3VpvzqgwAN8OgSNs5mbvsUcNpi
	 0Tm0lwwuBSQqNaLmKUbBENtva7l+YrmBTS184iVpQQm72hryWmfxRBucrO1KrDtE5P
	 6qkZKF1s7XOS5wo9Ro6zWV4BJ0DafE1Cq8jxG4ivGkP3BMiescZJlqXCnmtVIilfyt
	 QQk3UeSvGcDnw==
Date: Wed, 5 Mar 2025 14:19:36 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Andy Yan <andyshrk@163.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	Herve Codina <herve.codina@bootlin.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Simona Vetter <simona.vetter@ffwll.ch>
Subject: Re: [PATCH v5 04/16] drm/atomic: Introduce helper to lookup
 connector by encoder
Message-ID: <20250305-ruddy-nightingale-of-wealth-db100a@houat>
References: <20250304-bridge-connector-v5-0-aacf461d2157@kernel.org>
 <20250304-bridge-connector-v5-4-aacf461d2157@kernel.org>
 <5180089f.a640.19566290538.Coremail.andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="swpzczajl46ap5ux"
Content-Disposition: inline
In-Reply-To: <5180089f.a640.19566290538.Coremail.andyshrk@163.com>


--swpzczajl46ap5ux
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 04/16] drm/atomic: Introduce helper to lookup
 connector by encoder
MIME-Version: 1.0

Hi Andy,

On Wed, Mar 05, 2025 at 07:55:19PM +0800, Andy Yan wrote:
> At 2025-03-04 19:10:47, "Maxime Ripard" <mripard@kernel.org> wrote:
> >With the bridges switching over to drm_bridge_connector, the direct
> >association between a bridge driver and its connector was lost.
> >
> >This is mitigated for atomic bridge drivers by the fact you can access
> >the encoder, and then call drm_atomic_get_old_connector_for_encoder() or
> >drm_atomic_get_new_connector_for_encoder() with drm_atomic_state.
> >
> >This was also made easier by providing drm_atomic_state directly to all
> >atomic hooks bridges can implement.
> >
> >However, bridge drivers don't have a way to access drm_atomic_state
> >outside of the modeset path, like from the hotplug interrupt path or any
> >interrupt handler.
> >
> >Let's introduce a function to retrieve the connector currently assigned
> >to an encoder, without using drm_atomic_state, to make these drivers'
> >life easier.
> >
> >Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >Co-developed-by: Simona Vetter <simona.vetter@ffwll.ch>
> >Signed-off-by: Maxime Ripard <mripard@kernel.org>
> >---
> > drivers/gpu/drm/drm_atomic.c | 45 +++++++++++++++++++++++++++++++++++++=
+++++++
> > include/drm/drm_atomic.h     |  3 +++
> > 2 files changed, 48 insertions(+)
> >
> >diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> >index 9ea2611770f43ce7ccba410406d5f2c528aab022..b926b132590e78f8d41d48eb=
4da4bccf170ee236 100644
> >--- a/drivers/gpu/drm/drm_atomic.c
> >+++ b/drivers/gpu/drm/drm_atomic.c
> >@@ -985,10 +985,55 @@ drm_atomic_get_new_connector_for_encoder(const str=
uct drm_atomic_state *state,
> >=20
> > 	return NULL;
> > }
> > EXPORT_SYMBOL(drm_atomic_get_new_connector_for_encoder);
> >=20
> >+/**
> >+ * drm_atomic_get_connector_for_encoder - Get connector currently assig=
ned to an encoder
> >+ * @encoder: The encoder to find the connector of
> >+ * @ctx: Modeset locking context
> >+ *
> >+ * This function finds and returns the connector currently assigned to
> >+ * an @encoder.
> >+ *
> >+ * Returns:
> >+ * The connector connected to @encoder, or an error pointer otherwise.
> >+ * When the error is EDEADLK, a deadlock has been detected and the
> >+ * sequence must be restarted.
> >+ */
> >+struct drm_connector *
> >+drm_atomic_get_connector_for_encoder(const struct drm_encoder *encoder,
> >+				     struct drm_modeset_acquire_ctx *ctx)
> >+{
> >+	struct drm_connector_list_iter conn_iter;
> >+	struct drm_connector *out_connector =3D ERR_PTR(-EINVAL);
> >+	struct drm_connector *connector;
> >+	struct drm_device *dev =3D encoder->dev;
> >+	int ret;
> >+
> >+	ret =3D drm_modeset_lock(&dev->mode_config.connection_mutex, ctx);
> >+	if (ret)
> >+		return ERR_PTR(ret);
>=20
> It seems that this will cause a deadlock when called from a hotplug
> handling path, I have a WIP DP diver[0], which suggested by Dmitry to
> use this API from a &drm_bridge_funcs.detect callback to get the
> connector, as detect is called by drm_helper_probe_detect, which will
> hold connection_mutex first, so the deaklock happens:
>
> drm_helper_probe_detect(struct drm_connector *connector,
>                         struct drm_modeset_acquire_ctx *ctx,
>                         bool force)
> {
>         const struct drm_connector_helper_funcs *funcs =3D connector->hel=
per_private;
>         struct drm_device *dev =3D connector->dev;
>         int ret;
>=20
>         if (!ctx)
>                 return drm_helper_probe_detect_ctx(connector, force);
>=20
>         ret =3D drm_modeset_lock(&dev->mode_config.connection_mutex, ctx);
>         if (ret)
>                 return ret;
>=20
>         if (funcs->detect_ctx)
>                 ret =3D funcs->detect_ctx(connector, ctx, force);
>         else if (connector->funcs->detect)
>                 ret =3D connector->funcs->detect(connector, force);
>         else
>                 ret =3D connector_status_connected;
>=20
>         if (ret !=3D connector->status)
>                 connector->epoch_counter +=3D 1;
>=20
> So I wonder can we let drm_bridge_funcs.detect pass a connector for
> this case ?

Do you actually see a deadlock occurring? AFAIK, drm_modeset_lock is
fine with reentrancy from the same context, so it should work just fine.

Maxime

--swpzczajl46ap5ux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ8hPYwAKCRAnX84Zoj2+
dlISAX9IzUqQRgmBpac6NY2GFcBApzcX0XTidMOueOq9iTJ3KjxnHpDoikIhaDmE
xcEoNC4BgJH+7PLIZw8CgFImq8uR7i9TUPBxbtwN9MImQ+TX/iZYojF3mKnCAFpU
mqDbDDu98g==
=XqhQ
-----END PGP SIGNATURE-----

--swpzczajl46ap5ux--

