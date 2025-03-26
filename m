Return-Path: <linux-kernel+bounces-577237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 872E8A71A57
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D1BC189856A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4861EA7D9;
	Wed, 26 Mar 2025 15:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgbxCAQ7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEED18B0F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743002709; cv=none; b=RVZDS0BtNOsVb/VUppiIxQpNyAyHrEJ6aY690bLxzaHlaWp5An67+7XJz9zBzVAzU5QxKAMhrlCycMEG33FDRjogkl2gEKcT7ZwwXm76EYaqgz807R2zk3LNFSNmJKIyE2vW/fYsnBH0WX5Qq1Z/niM3s2b4hNN4BSOTD0jzc1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743002709; c=relaxed/simple;
	bh=kt+LdfFip12WDLC5j3cmKeWc4UoHGSmUrB0AJQ2jWlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jom1XGuQNHWBn9LoTSlGhGONT7ZkL/cs5DGbmSW33UiDJET+vk4MMLbRH55fnu8WhBqqeUZBQ8kR8iNiJMlDMudF2kojenhaLGklYxgMs5BNhzGUu3EF+5NMQa/eIHngD69iSuqxQZpR3Z2Js1Shz737XgpgC42b4hr9b/hQxVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgbxCAQ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F1BC4CEE2;
	Wed, 26 Mar 2025 15:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743002709;
	bh=kt+LdfFip12WDLC5j3cmKeWc4UoHGSmUrB0AJQ2jWlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NgbxCAQ7jAuOweaU4SDrahAdnPPPj3DFEv1JhosQrZBqWEqbSNE4mBoYVpo9puiR4
	 joKzu5ydeMX+xHvWvCBngu7uRMQE8nuaVRobr0il5yv8JLhOdaUs93WWGfXqOYHFBR
	 g2s0pQgXfL7ZoQzX/OjF6FQd0LaANruirSUGw0OSl3MuI0LirP3G9bliGQK9qvXvo9
	 a3e+/UB0ySWusYu1fM2vQdCf0pvaV16el8ipvn327JvFvCyBef9AYccS8bpdZpV9/T
	 sD+0sKi7WG0G854sZZgjcRweX/QRio7lpsQmQwkYjC4JYrN86z93MrAwPZbi3MBEpB
	 I35ka/GuhhBVQ==
Date: Wed, 26 Mar 2025 16:25:01 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Anusha Srivatsa <asrivats@redhat.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 1/5] drm/panel: Add new helpers for refcounted panel
 allocatons
Message-ID: <20250326-illegal-vicugna-of-reverence-e4c3d1@houat>
References: <20250325-b4-panel-refcounting-v1-0-4e2bf5d19c5d@redhat.com>
 <20250325-b4-panel-refcounting-v1-1-4e2bf5d19c5d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w5aflokbiw5fdb7n"
Content-Disposition: inline
In-Reply-To: <20250325-b4-panel-refcounting-v1-1-4e2bf5d19c5d@redhat.com>


--w5aflokbiw5fdb7n
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/5] drm/panel: Add new helpers for refcounted panel
 allocatons
MIME-Version: 1.0

On Tue, Mar 25, 2025 at 01:24:08PM -0400, Anusha Srivatsa wrote:
> Introduce reference counted allocations for panels to avoid
> use-after-free. The patch adds the macro devm_drm_bridge_alloc()
> to allocate a new refcounted panel. Followed the documentation for
> drmm_encoder_alloc() and devm_drm_dev_alloc and other similar
> implementations for this purpose.
>=20
> Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
> ---
>  drivers/gpu/drm/drm_panel.c | 25 +++++++++++++++++++++++++
>  include/drm/drm_panel.h     | 22 ++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index c627e42a7ce70459f50eb5095fffc806ca45dabf..bdeab5710ee324dc1742fbc77=
582250960556308 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c
> @@ -355,6 +355,31 @@ struct drm_panel *of_drm_find_panel(const struct dev=
ice_node *np)
>  }
>  EXPORT_SYMBOL(of_drm_find_panel);
> =20
> +void *__devm_drm_panel_alloc(struct device *dev, size_t size, size_t off=
set,
> +			     const struct drm_panel_funcs *funcs,
> +			     int connector_type)
> +{
> +	void *container;
> +	struct drm_panel *panel;
> +
> +	if (!funcs) {
> +		dev_warn(dev, "Missing funcs pointer\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	container =3D devm_kzalloc(dev, size, GFP_KERNEL);
> +	if (!container)
> +		return ERR_PTR(-ENOMEM);
> +
> +	panel =3D container + offset;
> +	panel->funcs =3D funcs;
> +
> +	drm_panel_init(panel, dev, funcs, connector_type);
> +
> +	return container;
> +}
> +EXPORT_SYMBOL(__devm_drm_panel_alloc);
> +
>  /**
>   * of_drm_get_panel_orientation - look up the orientation of the panel t=
hrough
>   * the "rotation" binding from a device tree node
> diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
> index a9c042c8dea1a82ef979c7a68204e0b55483fc28..63fb1dbe15a0556e7484bc187=
37a6b1f4c208b0c 100644
> --- a/include/drm/drm_panel.h
> +++ b/include/drm/drm_panel.h
> @@ -28,6 +28,7 @@
>  #include <linux/errno.h>
>  #include <linux/list.h>
>  #include <linux/mutex.h>
> +#include <linux/kref.h>
> =20
>  struct backlight_device;
>  struct dentry;
> @@ -268,6 +269,27 @@ struct drm_panel {
>  	bool enabled;
>  };
> =20
> +void *__devm_drm_panel_alloc(struct device *dev, size_t size, size_t off=
set,
> +			     const struct drm_panel_funcs *funcs,
> +			     int connector_type);
> +
> +/**
> + * devm_drm_panel_alloc - Allocate and initialize an refcounted panel
> + * @dev: struct device of the panel device
> + * @type: the type of the struct which contains struct &drm_panel
> + * @member: the name of the &drm_panel within @type
> + * @funcs: callbacks for this panel
> + * @connector_type: connector type of the driver
> + * The returned refcount is initialised to 1

There's not returned refcount. What is returned is a pointer to the
container structure. You should mention that the reference count is
initialized to 1, and will be given back automatically through a devm
action.

Iirc, Luca had a similar mention in his series, if you need inspiration.

> + * Returns:
> + * Pointer to new panel, or ERR_PTR on failure.

It doesn't return a pointer to the new panel, but to the structure
containing the panel.

Maxime

--w5aflokbiw5fdb7n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZ+QcTAAKCRDj7w1vZxhR
xR34AP0VPzR1Vh27yHyFY3AMWW8VIZce+7PEjB5diAGv7vXl2wEAi2DiPaz0gmCJ
srThpK1ea4mhDs7YEH9HpYH/+BcEggc=
=UONS
-----END PGP SIGNATURE-----

--w5aflokbiw5fdb7n--

