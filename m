Return-Path: <linux-kernel+bounces-423626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA98A9DAA9F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B1FF28187D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB3E1FF7C3;
	Wed, 27 Nov 2024 15:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ML4RfZJt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD521FF7A8
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 15:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732720757; cv=none; b=mZvAREDjMj0qaZOC5dddHGZsJoR37AnE+hQcpE7Je1NQbr+f9igw24YEwRrN0yoC+rk867Xhxpt3gG3YyhKys2PQKj+xoHy+Pd9L7KT+dEnTLdT/YQtPissgLFb+y0+YQhOffLs7pWk2mQ+FfS/gFRTrK2fcZIkJ0pLWwZ3IF1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732720757; c=relaxed/simple;
	bh=PDP6M3iB3HkWPpxiPD4WO5+rYWAXmQLYqVob4tX5ZfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmMO7OEb3FTU7mSfFAN6H6t0ztWknK4OiBLq5Nf0cmGZuap8+Jx6GsT4AGJ162Ak9tsYKnyEChuwBy+EOGODOtBrjPVYY65mDxx/aQ4ax+IN2MutvULK1c8yos62t+qvmdGnpPA8R6voiyYjisMmsmWoOxrdZk4eq9Db14e1cO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ML4RfZJt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA03C4CECC;
	Wed, 27 Nov 2024 15:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732720757;
	bh=PDP6M3iB3HkWPpxiPD4WO5+rYWAXmQLYqVob4tX5ZfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ML4RfZJtLjYbrhikhSpSD64w/JN4lUN8mBDRWtBnj4M3W538OaPiGZaFwKY75GKw0
	 zDNgorJNgHk0l2bpgM6zNOVVNqRp3eB/C3MRtmpuwg0b5JAw+BrGm9TT02o26dfahH
	 DnyxZe5GMGNH178wmj3oTouDk6sZjRrf7wYMQKbO9b8pnf/8TbiCtYWG6N7y5yxRYJ
	 pRXjVFklXiPNEsUh8HAZ37ceDp0peViePmPtuqIWI+bdlad0uoUBoHPd2E05g1YH7T
	 M1Dj7SRIG1Ivsbw8IppIPnwEe9fFE7Dy0cRLlewcbHxx1cT/Togp4TNPbcLJ1HQT8T
	 pMM9n4DzNuU5Q==
Date: Wed, 27 Nov 2024 16:19:14 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
	=?utf-8?B?TWHDrXJh?= Canal <mairacanal@riseup.net>, Haneen Mohammed <hamohammed.sa@gmail.com>, 
	Melissa Wen <melissa.srw@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Simona Vetter <simona.vetter@ffwll.ch>, 
	thomas.petazzoni@bootlin.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] drm/vkms: Switch to dynamic allocation for CRTC
Message-ID: <20241127-fennec-of-magic-spirit-bcfcc5@houat>
References: <20241122-b4-vkms-allocated-v2-0-ff7bddbf0bfb@bootlin.com>
 <20241122-b4-vkms-allocated-v2-3-ff7bddbf0bfb@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="kztmkcguwyxpegsy"
Content-Disposition: inline
In-Reply-To: <20241122-b4-vkms-allocated-v2-3-ff7bddbf0bfb@bootlin.com>


--kztmkcguwyxpegsy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 3/4] drm/vkms: Switch to dynamic allocation for CRTC
MIME-Version: 1.0

Hi,

On Fri, Nov 22, 2024 at 05:35:11PM +0100, Louis Chauvet wrote:
> specific allocation for the CRTC is not strictly necessary at this point,
> but in order to implement dynamic configuration of VKMS (configFS), it
> will be easier to have one allocation per CRTC.
>=20
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>

This one should probably be split further, there's several things going
on right now.

> ---
>  drivers/gpu/drm/vkms/vkms_crtc.c      | 32 +++++++++++++++++------------=
---
>  drivers/gpu/drm/vkms/vkms_drv.h       |  9 +++++----
>  drivers/gpu/drm/vkms/vkms_output.c    | 26 +++++++++++++++-----------
>  drivers/gpu/drm/vkms/vkms_writeback.c | 17 +++++++++--------
>  4 files changed, 46 insertions(+), 38 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms=
_crtc.c
> index ace8d293f7da611110c1e117b6cf2f3c9e9b4381..d014dec117e7d4ec7e9e38037=
a4a4cb4bc6be4ca 100644
> --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> @@ -84,9 +84,7 @@ static bool vkms_get_vblank_timestamp(struct drm_crtc *=
crtc,
>  				      int *max_error, ktime_t *vblank_time,
>  				      bool in_vblank_irq)
>  {
> -	struct drm_device *dev =3D crtc->dev;
> -	struct vkms_device *vkmsdev =3D drm_device_to_vkms_device(dev);
> -	struct vkms_output *output =3D &vkmsdev->output;
> +	struct vkms_output *output =3D drm_crtc_to_vkms_output(crtc);
>  	struct drm_vblank_crtc *vblank =3D drm_crtc_vblank_crtc(crtc);
> =20
>  	if (!READ_ONCE(vblank->enabled)) {
> @@ -279,25 +277,29 @@ static void vkms_crtc_destroy_workqueue(struct drm_=
device *dev,
>  	destroy_workqueue(vkms_out->composer_workq);
>  }
> =20
> -int vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
> -		   struct drm_plane *primary, struct drm_plane *cursor)
> +struct vkms_output *vkms_crtc_init(struct drm_device *dev, struct drm_pl=
ane *primary,
> +				   struct drm_plane *cursor)
>  {
> -	struct vkms_output *vkms_out =3D drm_crtc_to_vkms_output(crtc);
> +	struct vkms_output *vkms_out;
> +	struct drm_crtc *crtc;
>  	int ret;
> =20
> -	ret =3D drmm_crtc_init_with_planes(dev, crtc, primary, cursor,
> -					 &vkms_crtc_funcs, NULL);
> -	if (ret) {
> -		DRM_ERROR("Failed to init CRTC\n");
> -		return ret;
> +	vkms_out =3D drmm_crtc_alloc_with_planes(dev, struct vkms_output, crtc,
> +					       primary, cursor,
> +					       &vkms_crtc_funcs, NULL);
> +	if (IS_ERR(vkms_out)) {
> +		DRM_DEV_ERROR(dev->dev, "Failed to init CRTC\n");
> +		return vkms_out;
>  	}
> =20
> +	crtc =3D &vkms_out->crtc;
> +
>  	drm_crtc_helper_add(crtc, &vkms_crtc_helper_funcs);
> =20
>  	ret =3D drm_mode_crtc_set_gamma_size(crtc, VKMS_LUT_SIZE);
>  	if (ret) {
>  		DRM_ERROR("Failed to set gamma size\n");
> -		return ret;
> +		return ERR_PTR(ret);
>  	}
> =20
>  	drm_crtc_enable_color_mgmt(crtc, 0, false, VKMS_LUT_SIZE);
> @@ -307,12 +309,12 @@ int vkms_crtc_init(struct drm_device *dev, struct d=
rm_crtc *crtc,
> =20
>  	vkms_out->composer_workq =3D alloc_ordered_workqueue("vkms_composer", 0=
);
>  	if (!vkms_out->composer_workq)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
> =20
>  	ret =3D drmm_add_action_or_reset(dev, vkms_crtc_destroy_workqueue,
>  				       vkms_out);
>  	if (ret)
> -		return ret;
> +		return ERR_PTR(ret);
> =20
> -	return ret;
> +	return vkms_out;
>  }
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_=
drv.h
> index 19fd99b8e506c4454d7878b67f692a0441c22665..fbe7de67fb9c6a6a6964d71b4=
52b9a3ce573e0f8 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -214,7 +214,6 @@ struct vkms_config {
>  struct vkms_device {
>  	struct drm_device drm;
>  	struct platform_device *platform;
> -	struct vkms_output output;
>  	const struct vkms_config *config;
>  };
> =20
> @@ -241,8 +240,9 @@ struct vkms_device {
>   * @primary: primary plane to attach to the CRTC
>   * @cursor: plane to attach to the CRTC
>   */
> -int vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
> -		   struct drm_plane *primary, struct drm_plane *cursor);
> +struct vkms_output *vkms_crtc_init(struct drm_device *dev,
> +				   struct drm_plane *primary,
> +				   struct drm_plane *cursor);

You also need to update the doc.

Maxime

--kztmkcguwyxpegsy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ0c4cgAKCRAnX84Zoj2+
duemAX92vtHSUEQ3IsVnAEqPNEcZCn5Y/hzSZ5XcpkcT6jZtGSKiIryldM0Hn0uu
6+gTwrABgOp1wBbdQYVRUGvd+JQtdOfnbgwir+4gF8+1K20IdrQ9iCgjbLPMvMR0
kSi0PgJGzg==
=heCp
-----END PGP SIGNATURE-----

--kztmkcguwyxpegsy--

