Return-Path: <linux-kernel+bounces-523468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD29A3D72B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E2AA3A73B0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3091F2C5F;
	Thu, 20 Feb 2025 10:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lD4PLTS6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751201F12E0;
	Thu, 20 Feb 2025 10:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048280; cv=none; b=S7Wiu6hpTcWdpuPimLBOyy9rn9ucX9d5yO0dAbS9SRkp3u5MELSCjqajKA6tvTZ3e+Uho0c3uEbpjh0Ozmg7mOb9yeYV/SZ0RigyBxYBvMfeSrsdCjBbbzRfHks7F+IjW0RpcK5CKpHEhBiGQQxcK7VPf59B6RDf0Wj4N/wN0KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048280; c=relaxed/simple;
	bh=QdnLOdbwze+Z7nnS8Qtd6HFKQsNPKg5feItWdZjhzQA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXj3yc90DsGbEHi96cK5Z0XDQ4VKrFFEQuIKOBo7iBRUmWOdcFls7tWQhdEK3JE/FS0d1DUyAVeqGwdOz6NhUnbQ8BSDzwxKnCp/hJKZcj2/Wd95A+QYqLS0dRBmEjnqxyOss9YVSvptXZGYaulezv3SWrRpuU1MPzvPjA2ptgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lD4PLTS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7011DC4CED1;
	Thu, 20 Feb 2025 10:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740048280;
	bh=QdnLOdbwze+Z7nnS8Qtd6HFKQsNPKg5feItWdZjhzQA=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=lD4PLTS6TudaxomaNN8h8s3GiOhqP866T58KA3NBmnusi3JHYJaPw+7rYilrrUm92
	 Pxi8qN2d+vNtBLsS89hhAqtKIlq5gwdvjNMkqXeUgelIvdNOCXodBFf9AcHBglowPe
	 +YZUlBU95iY1bKHNRnBo0KcOm68zWO27s8TV5DdvmN1R1GlB+finU8rMsECM0NVoWC
	 4YVnTADNfRQAzDx32cdbvDM6NJB9HHNlHIL/abGCGUc0Lf1cE5vjBqiulXQ+5k4UMa
	 zK5sYVEvRxO2pJIqRBhcTgNNxHe/JMgPC+7zWRiFEaN/PCDG5Z+kkLaNKw0aeEBzS2
	 5frI9Tj9VoR3Q==
Date: Thu, 20 Feb 2025 11:44:37 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, Marek Vasut <marex@denx.de>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Louis Chauvet <louis.chauvet@bootlin.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 2/4] drm/atomic-helper: Introduce
 drm_atomic_helper_reset_crtc()
Message-ID: <20250220-wooden-robin-of-discussion-6a36f1@houat>
References: <20250203145824.155869-1-herve.codina@bootlin.com>
 <20250203145824.155869-3-herve.codina@bootlin.com>
 <Z7XfnPGDYspwG42y@phenom.ffwll.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="sazin6zoxnxaivny"
Content-Disposition: inline
In-Reply-To: <Z7XfnPGDYspwG42y@phenom.ffwll.local>


--sazin6zoxnxaivny
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 2/4] drm/atomic-helper: Introduce
 drm_atomic_helper_reset_crtc()
MIME-Version: 1.0

On Wed, Feb 19, 2025 at 02:41:48PM +0100, Simona Vetter wrote:
> On Mon, Feb 03, 2025 at 03:58:21PM +0100, Herve Codina wrote:
> > drm_atomic_helper_reset_crtc() allows to reset the CRTC active outputs.
> >=20
> > This resets all active components available between the CRTC and
> > connectors.
> >=20
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  drivers/gpu/drm/drm_atomic_helper.c | 41 +++++++++++++++++++++++++++++
> >  include/drm/drm_atomic_helper.h     |  2 ++
> >  2 files changed, 43 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_=
atomic_helper.c
> > index 8ed186ddaeaf..cac807df8a86 100644
> > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > @@ -3363,6 +3363,47 @@ int drm_atomic_helper_disable_all(struct drm_dev=
ice *dev,
> >  }
> >  EXPORT_SYMBOL(drm_atomic_helper_disable_all);
> > =20
> > +/**
> > + * drm_atomic_helper_reset_crtc - reset the active outputs of a CRTC
> > + * @crtc: DRM CRTC
> > + * @ctx: lock acquisition context
> > + *
> > + * Reset the active outputs by indicating that connectors have changed.
> > + * This implies a reset of all active components available between the=
 CRTC and
> > + * connectors.
>=20
> I think you definitely want a
>=20
> 	Note: This relies on resetting &drm_crtc_state.connectors_changed.
> 	For drivers which optimize out unnecessary modesets this will
> 	result in a no-op commit, achieving nothing.
>=20
> > + *
> > + * Returns:
> > + * 0 on success or a negative error code on failure.
> > + */
> > +int drm_atomic_helper_reset_crtc(struct drm_crtc *crtc,
> > +				 struct drm_modeset_acquire_ctx *ctx)
>=20
> So this is pretty close to DP drivers doing link-retraining when
> reconnecting a cable. Would be really nice if that could also be rolled
> out there where it fits, and maybe augment the documentation accordingly
> so that dp helpers point at this?

Given that the patch is already merged, Herve, could you send a
subsequent patch fixing up the doc at least?

Thanks,
Maxime

--sazin6zoxnxaivny
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ7cHkQAKCRAnX84Zoj2+
ds+MAYC/BR2Vx1K17429juM8mK9tjDBY052YeH/htYIsXGKrjlYjXJQltCijsjUy
8UXjzd4Bf0fCEBXGfd5yCPGkDfvBf+HeZb6Ea5OLwgJv0KXBLfAONIF8FT8gojhx
0PoxTPpBUw==
=iyS/
-----END PGP SIGNATURE-----

--sazin6zoxnxaivny--

