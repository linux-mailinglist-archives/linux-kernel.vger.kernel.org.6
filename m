Return-Path: <linux-kernel+bounces-559723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB29A5F896
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9B619C5A71
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501D5268FDA;
	Thu, 13 Mar 2025 14:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTfRH0T6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E6D267F4D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876487; cv=none; b=QDBDRdbC+MqvZV2RFzuudtncIVD6mTlx2vRPpYtUub3Rmoiu/WGHLX4/f5oWJrUgqO0Z2OSg/j6WdiUdnPIz32IjKPUAzDsYIQklGAgi07K4nFCC0tR8dXR4e+HahB61862BVw6ow8P80oi7TvxOQx0yPwOqpIZLYMb+cGnoSK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876487; c=relaxed/simple;
	bh=4K9tzoTtsP7BAI3B6cdLbG/K3RYZzOAO85EJfhQyad8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzBBINOtuIbj1IcDSOcNgbERw6XaJ2fxMZN/eAOMqKuSEmdv7dXsYGwVDcUs/JVjB4eHnGNoQByUiuO55nRdS2SS2QltCgup/bi/HffpeLNVcEO/vj+wZOwoINIKfR7ZrXqW/I1Zx0Q0USz3Ae61VuyvUIwZAiRdxQ310XeC6tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTfRH0T6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE564C4CEEB;
	Thu, 13 Mar 2025 14:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741876487;
	bh=4K9tzoTtsP7BAI3B6cdLbG/K3RYZzOAO85EJfhQyad8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pTfRH0T6OKHomu6IanaWZ2qglSzsYxgg0HiLa/4qRR/pbRm/XaQH5zuz+HTko7gLq
	 LsKRSjwgd2cGbV35vsUNH790ot/mSKFyDw5M9oBEVX2l5AMKtBvHduvs+qg80Pu2+7
	 RPvn6e+PczMCDUTBkdC6AOmlBoiSWSkbwefhzFwG0iv27I/w5eMiU1h27RVfx6UXAJ
	 ru6b/vvdiK8Lgez9/kWStynD+bPOHbMQ4+otxApA2rsXOYmUhNXzJuK5jWFE6U2aeH
	 3lLnwMg+c5g0Zythzmmh3zxyttYBWWhpjdCbOxe6e6LclCqfnELafCb7VWv5QfjSpp
	 4y71Z2nLB4/lA==
Date: Thu, 13 Mar 2025 15:34:44 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Anusha Srivatsa <asrivats@redhat.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] drm/panel: Add new helpers for refcounted panel
 allocatons
Message-ID: <20250313-enlightened-shrewd-skunk-b6ed72@houat>
References: <20250312-drm-panel-v1-0-e99cd69f6136@redhat.com>
 <20250312-drm-panel-v1-1-e99cd69f6136@redhat.com>
 <20250313110944.1c1f7e4e@booty>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2ate5ne4iejyiwlh"
Content-Disposition: inline
In-Reply-To: <20250313110944.1c1f7e4e@booty>


--2ate5ne4iejyiwlh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC 1/2] drm/panel: Add new helpers for refcounted panel
 allocatons
MIME-Version: 1.0

On Thu, Mar 13, 2025 at 11:09:44AM +0100, Luca Ceresoli wrote:
> Hello Anusha,
>=20
> On Wed, 12 Mar 2025 20:54:42 -0400
> Anusha Srivatsa <asrivats@redhat.com> wrote:
>=20
> > Introduce reference counted allocations for panels to avoid
> > use-after-free. The patch adds the macro devm_drm_bridge_alloc()
> > to allocate a new refcounted panel. Followed the documentation for
> > drmm_encoder_alloc() and devm_drm_dev_alloc and other similar
> > implementations for this purpose.
> >=20
> > Also adding drm_panel_get() and drm_panel_put() to suitably
> > increment and decrement the refcount
> >=20
> > Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
>=20
> I'm very happy to see the very first step of the panel rework mentioned
> by Maxime see the light! :-)
>=20
> This patch looks mostly good to me, and the similarity with my bridge
> refcounting work is by itself reassuring.
>=20
> I have a few notes, one is relevant and the others are minor details,
> see below.
>=20
> In the Subject line: s/allocatons/allocations/
>=20
> [...]
>=20
> > +void *__devm_drm_panel_alloc(struct device *dev, size_t size, size_t o=
ffset,
> > +			     const struct drm_panel_funcs *funcs)
> > +{
> > +	void *container;
> > +	struct drm_panel *panel;
> > +	int err;
> > +
> > +	if (!funcs) {
> > +		dev_warn(dev, "Missing funcs pointer\n");
> > +		return ERR_PTR(-EINVAL);
> > +	}
> > +
> > +	container =3D kzalloc(size, GFP_KERNEL);
> > +	if (!container)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	panel =3D container + offset;
> > +	panel->container_offset =3D offset;
> > +	panel->funcs =3D funcs;
> > +	kref_init(&panel->refcount);
> > +
> > +	err =3D devm_add_action_or_reset(dev, drm_panel_put_void, panel);
> > +	if (err)
> > +		return ERR_PTR(err);
> > +
> > +	drm_panel_init(panel, dev, funcs, panel->connector_type);
>=20
> panel->connector_type here is uninitialized. You are passing
> panel->connector_type to drm_panel_init(), which will then copy it into
> panel->connector_type itself.

Yeah, we need to have the connector type as a parameter.

Maxime

--2ate5ne4iejyiwlh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZ9LtBAAKCRDj7w1vZxhR
xYMCAQCVGbMderUCo19/lZEwItzpHYd9ffnbQ7OXbu9onz68zwEAhS/0Ln7m5ePp
bVFGwvzvZZ65R983T9RMp3zR8bo9sws=
=nzmg
-----END PGP SIGNATURE-----

--2ate5ne4iejyiwlh--

