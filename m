Return-Path: <linux-kernel+bounces-559736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578AFA5F8D0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC7D13A57FA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22D5268681;
	Thu, 13 Mar 2025 14:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FThduapB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBB2267F5C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876940; cv=none; b=tof0fJ3ALvP0IM8weFgYKhdP8s3wWFNXyjl83QVopWeBQMgRJFhWoRij5E8u1gYY38HUhRitXviB32MUQDh7mI4+gRuCnFrUbGdx+iCrwNQXSbxL1Cg89cawhlA7rqb3PSuIRj0cJQGpRIETipfF934ZUxzd04tEXNddmN9ITgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876940; c=relaxed/simple;
	bh=6dpJeyLN21oQG4oE0dG/l6v4eRgwx6mxRl3Myz7KDZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOvUqzC9rTqOP6CRM+kT909tTMu2vHnb95zc+6P9Fa4eH7Byzj9O+7QQyVymDIUUoLgwq4kOEOYP1WenKcqZiS09eghfbLlaCoTHUHdroU8088dXun4CI5AIq2eaD96RskMW8g4FvOo2iYZDikV8drOKt6r6uEWEnpzpkzhdgLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FThduapB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2993FC4CEE5;
	Thu, 13 Mar 2025 14:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741876937;
	bh=6dpJeyLN21oQG4oE0dG/l6v4eRgwx6mxRl3Myz7KDZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FThduapBGbRyh3/xQxSUHags2TA2PPc0P3PLGau0imU26/c60VKrAr0nooOUMTe3c
	 1QtVgKznPTvQVpPNW6MJ3rbmRY28jNNiuSPauFv4ncWMbcMjGDgI2tpqT4ymqH9gEu
	 G7SzsDXuO6X8IuZ3mmnuKr3v/4UJi3hX9hHjkyGzU1ULhTiOUERzfdKasdDvS2AenS
	 ql0AXncyCIZwb2AdNFTXV/NONVjjB+ot4iLnz1G9VElr8NLALLakiEdlA28qZkDxqw
	 SUEttWjW311v4nvtNOM1bTNTvqs3FZtLbj3E+AJtYWqMU4oDM0Cm7vfKwvdH+4TaTQ
	 QPK0d3skFI2/g==
Date: Thu, 13 Mar 2025 15:42:15 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Anusha Srivatsa <asrivats@redhat.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] drm/panel: Add new helpers for refcounted panel
 allocatons
Message-ID: <20250313-feathered-peach-okapi-b32f9d@houat>
References: <20250312-drm-panel-v1-0-e99cd69f6136@redhat.com>
 <20250312-drm-panel-v1-1-e99cd69f6136@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4vtgk7bl5mhaj45p"
Content-Disposition: inline
In-Reply-To: <20250312-drm-panel-v1-1-e99cd69f6136@redhat.com>


--4vtgk7bl5mhaj45p
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC 1/2] drm/panel: Add new helpers for refcounted panel
 allocatons
MIME-Version: 1.0

Hi Anusha,

In addition to the feedback Luca already provided, I have a few comments

On Wed, Mar 12, 2025 at 08:54:42PM -0400, Anusha Srivatsa wrote:
> Introduce reference counted allocations for panels to avoid
> use-after-free. The patch adds the macro devm_drm_bridge_alloc()
> to allocate a new refcounted panel. Followed the documentation for
> drmm_encoder_alloc() and devm_drm_dev_alloc and other similar
> implementations for this purpose.
>=20
> Also adding drm_panel_get() and drm_panel_put() to suitably
> increment and decrement the refcount
>=20
> Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
> ---
>  drivers/gpu/drm/drm_panel.c | 50 ++++++++++++++++++++++++++++++++++++++
>  include/drm/drm_panel.h     | 58 +++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 108 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index c627e42a7ce70459f50eb5095fffc806ca45dabf..b55e380e4a2f7ffd940c207e8=
41c197d85113907 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c
> @@ -79,6 +79,7 @@ EXPORT_SYMBOL(drm_panel_init);
>   */
>  void drm_panel_add(struct drm_panel *panel)
>  {
> +	drm_panel_get(panel);
>  	mutex_lock(&panel_lock);
>  	list_add_tail(&panel->list, &panel_list);
>  	mutex_unlock(&panel_lock);
> @@ -96,6 +97,7 @@ void drm_panel_remove(struct drm_panel *panel)
>  	mutex_lock(&panel_lock);
>  	list_del_init(&panel->list);
>  	mutex_unlock(&panel_lock);
> +	drm_panel_put(panel);
>  }
>  EXPORT_SYMBOL(drm_panel_remove);

I think these two should be added as a separate patch, with some
additional comment on why it's needed (because we store a pointer in the
panel list).

> =20
> @@ -355,6 +357,54 @@ struct drm_panel *of_drm_find_panel(const struct dev=
ice_node *np)
>  }
>  EXPORT_SYMBOL(of_drm_find_panel);
> =20
> +/* Internal function (for refcounted panels) */
> +void __drm_panel_free(struct kref *kref)
> +{
> +	struct drm_panel *panel =3D container_of(kref, struct drm_panel, refcou=
nt);
> +	void *container =3D ((void *)panel) - panel->container_offset;
> +
> +	kfree(container);
> +}
> +EXPORT_SYMBOL(__drm_panel_free);
> +
> +static void drm_panel_put_void(void *data)
> +{
> +	struct drm_panel *panel =3D (struct drm_panel *)data;
> +
> +	drm_panel_put(panel);
> +}
> +
> +void *__devm_drm_panel_alloc(struct device *dev, size_t size, size_t off=
set,
> +			     const struct drm_panel_funcs *funcs)
> +{
> +	void *container;
> +	struct drm_panel *panel;
> +	int err;
> +
> +	if (!funcs) {
> +		dev_warn(dev, "Missing funcs pointer\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	container =3D kzalloc(size, GFP_KERNEL);
> +	if (!container)
> +		return ERR_PTR(-ENOMEM);
> +
> +	panel =3D container + offset;
> +	panel->container_offset =3D offset;
> +	panel->funcs =3D funcs;
> +	kref_init(&panel->refcount);
> +
> +	err =3D devm_add_action_or_reset(dev, drm_panel_put_void, panel);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	drm_panel_init(panel, dev, funcs, panel->connector_type);
> +
> +	return container;
> +}
> +EXPORT_SYMBOL(__devm_drm_panel_alloc);

Similarly, here, I think we'd need to split that some more. Ideally, we
should have a series of patches doing

1: Adding that allocation function you have right now, but using
   devm_kzalloc

2: Adding the reference counting to drm_panel, with drm_panel_get /
   drm_panel_put and the devm_action to put the reference in
   __devm_drm_panel_alloc()

3: Adding X patches to add calls to drm_bridge_get/drm_bridge_put
   everywhere it's needed, starting indeed by
   drm_panel_add/drm_panel_put. We don't have to do all of them in that
   series though. of_drm_find_panel though will probably merit a series
   of its own, given we'd have to fix all its callers too.

4: Convert some panels to the new allocation function. You already did
   that with panel_simple so there's nothing to change yet, but once we
   agree on the API we should mass convert all the panels.

Maxime

--4vtgk7bl5mhaj45p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZ9LuxgAKCRDj7w1vZxhR
xSRgAQCno5eoDe+xyhVEei0/Ps82ZZhNj1CsmAZx5K/86MEOaQEAzEUc18v3gy35
monod6iGrJugTyHpZo+jVW5lOddsRQI=
=+pVU
-----END PGP SIGNATURE-----

--4vtgk7bl5mhaj45p--

