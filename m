Return-Path: <linux-kernel+bounces-303401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FB8960B93
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A741E1F21BFD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B081BAED5;
	Tue, 27 Aug 2024 13:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ftb70ojq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F3519DF60
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 13:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764552; cv=none; b=lLgyqW88Iku+QDHDf6r7defqdkALZ87Ol6RQJwB97/Bc0Rb83a1Tf+TKitWBnklCsZ+2zxQcrFLQiBGwJVmVYSGQCR2wbYaCPUhXmmlwzwPAqCUGP4lktk0wP7E1+/lm6wA1nNSPgwdJiE2acMs3KZLHJwG5XapmZJu2U9Ap53M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764552; c=relaxed/simple;
	bh=D23zuocXZqUjo7IpJ+JfE57T8hPk8Zxdo5HWhXEbNXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHY0KOOW47vJIVIKoq/e0yKXwgXtx8ASmN7Dl6eLcu2dX/zC5n/VR9Ltkf8sPIdupww9kWekVpd5IxHO92aBTG8rtgXf465zWcH7Engn+8BuA3Rw4Pg7IWCdLr9tdevAcd+jdYn3Op5KZ3VXNI5aD1VOBs4vfPutjTmwDtv8t4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ftb70ojq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71B8C61042;
	Tue, 27 Aug 2024 13:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724764552;
	bh=D23zuocXZqUjo7IpJ+JfE57T8hPk8Zxdo5HWhXEbNXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ftb70ojq/Bx5i3eIwH8rMEXF1B/BVsE1hJfGMk/rpBZLe4txbxPpef2kpsnK7c4iu
	 kmpHKkAOJ0I3TIXoUyBGcla/SoObzl4EE+s8iBp0obesitFpFLNa46TIRROSDp+HKm
	 cPRMd+YXlT+Qqm4qDXvWAL2ICjMAyG5Uf0UtE+EleAwvDMPr6w2cgWCSeOBWorfz7R
	 1OotpgP9wKkR6ZyCQtvl2WX1CQUrBmkzqOy+hI05oO6FHFF2hN8Ow7rKCRRvwFWrWJ
	 F6sVmZy/IABYwsR/xNeFfd4z+zAxx0YJlDr0+EAk5R3OUEsG+3kd6ojzxfrT99gBcj
	 EC3OXd35lNsjw==
Date: Tue, 27 Aug 2024 15:15:49 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
	Melissa Wen <melissa.srw@gmail.com>, =?utf-8?B?TWHDrXJh?= Canal <mairacanal@riseup.net>, 
	Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net, 
	linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
	thomas.petazzoni@bootlin.com, seanpaul@google.com, nicolejadeyee@google.com
Subject: Re: [PATCH v2 1/6] drm/vkms: Switch to managed for connector
Message-ID: <20240827-dynamic-acoustic-guillemot-ddde49@houat>
References: <20240827-google-vkms-managed-v2-0-f41104553aeb@bootlin.com>
 <20240827-google-vkms-managed-v2-1-f41104553aeb@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="vrglarcftye54dnb"
Content-Disposition: inline
In-Reply-To: <20240827-google-vkms-managed-v2-1-f41104553aeb@bootlin.com>


--vrglarcftye54dnb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 27, 2024 at 11:57:36AM GMT, Louis Chauvet wrote:
> The current VKMS driver uses non-managed function to create connectors. It
> is not an issue yet, but in order to support multiple devices easily,
> convert this code to use drm and device managed helpers.
>=20
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/vkms/vkms_drv.h    |  1 -
>  drivers/gpu/drm/vkms/vkms_output.c | 22 ++++++++++++----------
>  2 files changed, 12 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_=
drv.h
> index 5e46ea5b96dc..9a3c6c34d1f6 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -99,7 +99,6 @@ struct vkms_crtc_state {
>  struct vkms_output {
>  	struct drm_crtc crtc;
>  	struct drm_encoder encoder;
> -	struct drm_connector connector;
>  	struct drm_writeback_connector wb_connector;
>  	struct hrtimer vblank_hrtimer;
>  	ktime_t period_ns;
> diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vk=
ms_output.c
> index 5ce70dd946aa..4fe6b88e8081 100644
> --- a/drivers/gpu/drm/vkms/vkms_output.c
> +++ b/drivers/gpu/drm/vkms/vkms_output.c
> @@ -3,11 +3,11 @@
>  #include "vkms_drv.h"
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_edid.h>
> +#include <drm/drm_managed.h>
>  #include <drm/drm_probe_helper.h>
> =20
>  static const struct drm_connector_funcs vkms_connector_funcs =3D {
>  	.fill_modes =3D drm_helper_probe_single_connector_modes,
> -	.destroy =3D drm_connector_cleanup,
>  	.reset =3D drm_atomic_helper_connector_reset,
>  	.atomic_duplicate_state =3D drm_atomic_helper_connector_duplicate_state,
>  	.atomic_destroy_state =3D drm_atomic_helper_connector_destroy_state,
> @@ -50,7 +50,7 @@ int vkms_output_init(struct vkms_device *vkmsdev, int i=
ndex)
>  {
>  	struct vkms_output *output =3D &vkmsdev->output;
>  	struct drm_device *dev =3D &vkmsdev->drm;
> -	struct drm_connector *connector =3D &output->connector;
> +	struct drm_connector *connector;
>  	struct drm_encoder *encoder =3D &output->encoder;
>  	struct drm_crtc *crtc =3D &output->crtc;
>  	struct vkms_plane *primary, *cursor =3D NULL;
> @@ -80,8 +80,15 @@ int vkms_output_init(struct vkms_device *vkmsdev, int =
index)
>  	if (ret)
>  		return ret;
> =20
> -	ret =3D drm_connector_init(dev, connector, &vkms_connector_funcs,
> -				 DRM_MODE_CONNECTOR_VIRTUAL);
> +	connector =3D drmm_kzalloc(dev, sizeof(*connector), GFP_KERNEL);
> +	if (!connector) {
> +		DRM_ERROR("Failed to allocate connector\n");
> +		ret =3D -ENOMEM;
> +		goto err_connector;
> +	}
> +

I think it would be worth explaining why you need to move to a separate
allocation for the connector now.

Maxime

--vrglarcftye54dnb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZs3RhAAKCRAnX84Zoj2+
dp6mAX4oTq8+wGRS/+ubo/twHMugq+86ZPxe6xrYcFPBoHukpI9H6UgmsopfjZQK
50YOzzsBgPwpwaRq6xKl9k12Va7BPJvDRl4JTQ427SCWr7ftzbNFzedITGFCM/jG
0Xldo5f41Q==
=1hkH
-----END PGP SIGNATURE-----

--vrglarcftye54dnb--

