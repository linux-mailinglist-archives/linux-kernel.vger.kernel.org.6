Return-Path: <linux-kernel+bounces-577241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4483CA71A5D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3923A3A7E10
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C7C1F3BB3;
	Wed, 26 Mar 2025 15:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxHxZUcv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C341F2B8B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 15:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743002903; cv=none; b=QOpH9EHjqYkr9nNphdvEBPZQo3w5/wATCoRKk1kBsVo8vpQy5j1qtGGojWzwratAgC6d4x8W03sBeXwH1aqwigc740nifcoBTRMqh3tQ+5wiyYg3FanFkyo2K6rDidowteOxV9fYa27OyVN92VueDjXVOKNKCtWoadm3Y5gmh/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743002903; c=relaxed/simple;
	bh=+iTDM1up9bQyibbW8Bm0+4EO+vdNAR+vKU9j9w34kYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=feKpHdpzzEdgwVggDKHppeD+mqUzLvuNxsz1W5lk5Ao8HjN+Xq+Lu8R1ArYmQ91cClo7xJZnBsnIfSI1USWNSYYGQA4Vupj47yzsGs2cMY9LO0B3NDsbattu/bnacav08P3cmBmc6xOdgm7i/NATV+e54B3S1qE7ww7q+NIF6fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxHxZUcv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94415C4CEED;
	Wed, 26 Mar 2025 15:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743002902;
	bh=+iTDM1up9bQyibbW8Bm0+4EO+vdNAR+vKU9j9w34kYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SxHxZUcvd0c+VlPOSawUfFkduDYadlR37K+FMQHCAZy/++rzWlaixMcDoJGDdDANs
	 CzS18JGEuldUJe6AsKytDKVwHQ9xt4Ep9Ey3h+dr2vqvz9pC3hXoz9Cayui9SEH5L5
	 AFRxbWeruM0yX6xgmQnjFL/wH1VGWmzFlRqR8nVOcVRAKZqIqM/F7T6bwXhEd/QGJq
	 y5+vQWyYB+j+f/m0OmBGTHaLnadR4kBT6F2ZANgmrruC4DxuPV6cdMjXv0iYkkvd2t
	 jtriA0FWrU2cxJXwwCSHz1hd3ZxKSuhPmNmy4J8Nn6f5b6wK4TWFONJQp00YE4qN8S
	 GaKuqQjiwu2pw==
Date: Wed, 26 Mar 2025 16:28:20 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Anusha Srivatsa <asrivats@redhat.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 2/5] drm/panel: Add refcount support
Message-ID: <20250326-persimmon-parrot-of-glamour-f31fdb@houat>
References: <20250325-b4-panel-refcounting-v1-0-4e2bf5d19c5d@redhat.com>
 <20250325-b4-panel-refcounting-v1-2-4e2bf5d19c5d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="35mfar5h62wtrpdj"
Content-Disposition: inline
In-Reply-To: <20250325-b4-panel-refcounting-v1-2-4e2bf5d19c5d@redhat.com>


--35mfar5h62wtrpdj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/5] drm/panel: Add refcount support
MIME-Version: 1.0

On Tue, Mar 25, 2025 at 01:24:09PM -0400, Anusha Srivatsa wrote:
> Allocate panel via reference counting.
> Add _get() and _put() helper functions
> to ensure panel allocations are refcounted.
> Avoid use after free by ensuring panel is
> valid and can be usable till the last reference
> is put. This avoids use-after-free
>=20
> Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
> ---
>  drivers/gpu/drm/drm_panel.c | 65 +++++++++++++++++++++++++++++++++++++++=
+++++-
>  include/drm/drm_panel.h     | 19 ++++++++++++-
>  2 files changed, 82 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index bdeab5710ee324dc1742fbc77582250960556308..079c3c666a2ddc99a0051d1a3=
c9ba65d986dd003 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c
> @@ -355,24 +355,87 @@ struct drm_panel *of_drm_find_panel(const struct de=
vice_node *np)
>  }
>  EXPORT_SYMBOL(of_drm_find_panel);
> =20
> +static void __drm_panel_free(struct kref *kref)
> +{
> +	struct drm_panel *panel =3D container_of(kref, struct drm_panel, refcou=
nt);
> +
> +	kfree(panel->container);
> +}
> +
> +/**
> + * drm_panel_get - Acquire a panel reference
> + * @panel: DRM panel
> + *
> + * This function increments the panel's refcount.
> + *
> + */
> +struct drm_panel *drm_panel_get(struct drm_panel *panel)
> +{
> +	if (!panel)
> +		return panel;
> +
> +	kref_get(&panel->refcount);
> +
> +	return panel;
> +}

This should be exported

> +/**
> + * drm_panel_put - Release a panel reference
> + * @panel: DRM panel
> + *
> + * This function decrements the panel's reference count and frees the
> + * object if the reference count drops to zero.
> + */
> +struct drm_panel *drm_panel_put(struct drm_panel *panel)
> +{
> +	if (!panel)
> +		return panel;
> +
> +	kref_put(&panel->refcount, __drm_panel_free);
> +
> +	return panel;
> +}

Ditto,

> +/**
> + * drm_bridge_put_void - wrapper to drm_bridge_put() taking a void point=
er
> + *
> + * @data: pointer to @struct drm_bridge, cast to a void pointer
> + *
> + * Wrapper of drm_bridge_put() to be used when a function taking a void
> + * pointer is needed, for example as a devm action.
> + */
> +static void drm_panel_put_void(void *data)
> +{
> +	struct drm_panel *panel =3D (struct drm_panel *)data;
> +
> +	drm_panel_put(panel);
> +}

You can drop the documentation on that one.

Looks good otherwise,
Maxime

--35mfar5h62wtrpdj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZ+QdEwAKCRDj7w1vZxhR
xYQOAP9w3MTmVHhd861+uBbT6ku5QPjuAF8QKp2uW930Xg0/ngEA8+IQLZq8MDQH
cJZsh0JTE1RLVLeeQTyRMOo8NM6g5wk=
=WCTM
-----END PGP SIGNATURE-----

--35mfar5h62wtrpdj--

