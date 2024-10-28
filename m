Return-Path: <linux-kernel+bounces-384589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3656D9B2C01
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7E91282C04
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF9A1D5CDB;
	Mon, 28 Oct 2024 09:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DVZJ9Jst"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04EB1D9337
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730109057; cv=none; b=qpPpojKLLXWsVbFAMyQoU3d/SnpxYIuHQ156yx7LcI6AVD2/6UlWwnPxgboz6VoidDIIkx3d63s5FJSWLIY3qc4+KZm59+Mjcipe382/rKkwAb7nvW9b3kD45asfjkoC7J7IfJgVLKpHcqBCaKgexKsjiKGNfyBoNhu7cSakvg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730109057; c=relaxed/simple;
	bh=SBCwiqiA0wIJR5927/ow2X6Mxbw3rZUbtOh+5ebrD9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPG9zfdYF59AoWH6VjRxxUxQ6lJ7FLs8I2zJeAxa7C57DxhPTBi/aUTfFZYEz9YhzoiuX/SO34udvbBFiPlGNkICqKbqM/DqB9vYuRqXHDM5azAL8pjVGKLZDiSzyHAoB309WvqeDS5xNGM2slwJE7vCNKKdMz5L72ikujA5KWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DVZJ9Jst; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay6-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::226])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 8A617C24A1
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:50:45 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4F142C0006;
	Mon, 28 Oct 2024 09:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730109038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jVtYITj5PN/Kac3mgIPDKYehHWrOsM6s1bCh8WXYbSI=;
	b=DVZJ9Jst0qwYgxpdSPalIZWo0gqUHiuDHBLl2lQplQWC4AoAi69a+Fz1ntyS90X9z9uqsq
	2ByovW8/wIsOnWbTHumouiZlyjvjPrKeEFYqT+metAPddxNwvl+PWB1ZFlt7xcZCz/0+vO
	Qi6bUJfFGb9sjjQApAFgHYuK+/jJyOF0sQCCEpbA+A1KAPGjeBvfHDHuvKMm5ojEPI5wDZ
	u1Vnyu2Y7/9waewOlwgGg6HtQ+ZmLfSWnouqaDS7/c/DW/MnZ4FkNnX8wKfwct/qt5ejec
	gWlUhFO3pwCooGMxVrTaV4jwgFElhvTZFjRCpSgIzLmydrtnqpmwY3v7c3KZQw==
Date: Mon, 28 Oct 2024 10:50:36 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: =?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	thomas.petazzoni@bootlin.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/vkms: Remove index parameter from init_vkms_output
Message-ID: <Zx9ebAggGouerl4A@fedora>
Mail-Followup-To: =?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	thomas.petazzoni@bootlin.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
References: <20241010-vkms-remove-index-v2-1-6b8d6cfd5a15@bootlin.com>
 <35a5cf2e-caa4-48bf-a5be-3cbae9865f6a@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35a5cf2e-caa4-48bf-a5be-3cbae9865f6a@riseup.net>
X-GND-Sasl: louis.chauvet@bootlin.com

On 26/10/24 - 12:22, Maíra Canal wrote:
> Hi Louis,
> 
> On 10/10/24 14:27, Louis Chauvet wrote:
> > VKMS currently supports only one CRTC, so it make no sense to have this
> > index configurable. To avoid issues, replace this hardcoded index by
> > drm_crtc_mask when applicable.
> > 
> > There is no need to manually set a crtc mask on primary and cursor plane
> > as it is automatically set by drmm_crtc_alloc_with_planes.
> > 
> > In addition, this will remove the use of an uninitialized structure in
> > vkms_add_overlay_plane. This currently works by chance because two things:
> > - vkms_plane_init always set a possible_crtcs value, so the problematic
> >    branch is never used;
> > - drm_crtc_mask on an kzalloc'd drm_crtc returns BIT(0), and the VKMS CRTC
> >    always have this id.
> > 
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > ---
> > Changes in v2:
> > - Applied comments from José
> > - Link to v1: https://lore.kernel.org/r/20240906-vkms-remove-index-v1-1-3cfedd8ccb2f@bootlin.com
> > ---
> >   drivers/gpu/drm/vkms/vkms_drv.c    |  2 +-
> >   drivers/gpu/drm/vkms/vkms_drv.h    |  8 ++----
> >   drivers/gpu/drm/vkms/vkms_output.c | 54 ++++++++++++++------------------------
> >   drivers/gpu/drm/vkms/vkms_plane.c  |  4 +--
> >   4 files changed, 24 insertions(+), 44 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> > index 2d1e95cb66e5..0f6805b9fe7b 100644
> > --- a/drivers/gpu/drm/vkms/vkms_drv.c
> > +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> > @@ -174,7 +174,7 @@ static int vkms_modeset_init(struct vkms_device *vkmsdev)
> >   	dev->mode_config.preferred_depth = 0;
> >   	dev->mode_config.helper_private = &vkms_mode_config_helpers;
> > -	return vkms_output_init(vkmsdev, 0);
> > +	return vkms_output_init(vkmsdev);
> >   }
> >   static int vkms_create(struct vkms_config *config)
> > diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> > index 672fe191e239..036101ee4ea1 100644
> > --- a/drivers/gpu/drm/vkms/vkms_drv.h
> > +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> > @@ -212,21 +212,17 @@ int vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
> >    * vkms_output_init() - Initialize all sub-components needed for a VKMS device.
> >    *
> >    * @vkmsdev: VKMS device to initialize
> > - * @index: CRTC which can be attached to the planes. The caller must ensure that
> > - *	   @index is positive and less or equals to 31.
> >    */
> > -int vkms_output_init(struct vkms_device *vkmsdev, int index);
> > +int vkms_output_init(struct vkms_device *vkmsdev);
> >   /**
> >    * vkms_plane_init() - Initialize a plane
> >    *
> >    * @vkmsdev: VKMS device containing the plane
> >    * @type: type of plane to initialize
> > - * @index: CRTC which can be attached to the plane. The caller must ensure that
> > - *	   @index is positive and less or equals to 31.
> >    */
> >   struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
> > -				   enum drm_plane_type type, int index);
> > +				   enum drm_plane_type type);
> >   /* CRC Support */
> >   const char *const *vkms_get_crc_sources(struct drm_crtc *crtc,
> > diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> > index 0a5a185aa0b0..5128aa3b2eb6 100644
> > --- a/drivers/gpu/drm/vkms/vkms_output.c
> > +++ b/drivers/gpu/drm/vkms/vkms_output.c
> > @@ -32,29 +32,14 @@ static const struct drm_connector_helper_funcs vkms_conn_helper_funcs = {
> >   	.get_modes    = vkms_conn_get_modes,
> >   };
> > -static int vkms_add_overlay_plane(struct vkms_device *vkmsdev, int index,
> > -				  struct drm_crtc *crtc)
> > -{
> > -	struct vkms_plane *overlay;
> > -
> > -	overlay = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_OVERLAY, index);
> > -	if (IS_ERR(overlay))
> > -		return PTR_ERR(overlay);
> > -
> > -	if (!overlay->base.possible_crtcs)
> > -		overlay->base.possible_crtcs = drm_crtc_mask(crtc);
> > -
> > -	return 0;
> > -}
> > -
> > -int vkms_output_init(struct vkms_device *vkmsdev, int index)
> > +int vkms_output_init(struct vkms_device *vkmsdev)
> >   {
> >   	struct vkms_output *output = &vkmsdev->output;
> >   	struct drm_device *dev = &vkmsdev->drm;
> >   	struct drm_connector *connector = &output->connector;
> >   	struct drm_encoder *encoder = &output->encoder;
> >   	struct drm_crtc *crtc = &output->crtc;
> > -	struct vkms_plane *primary, *cursor = NULL;
> > +	struct vkms_plane *primary, *overlay, *cursor = NULL;
> >   	int ret;
> >   	int writeback;
> >   	unsigned int n;
> > @@ -65,34 +50,37 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
> >   	 * The overlay and cursor planes are not mandatory, but can be used to perform complex
> >   	 * composition.
> >   	 */
> > -	primary = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_PRIMARY, index);
> > +	primary = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_PRIMARY);
> >   	if (IS_ERR(primary))
> >   		return PTR_ERR(primary);
> > -	if (vkmsdev->config->overlay) {
> > -		for (n = 0; n < NUM_OVERLAY_PLANES; n++) {
> > -			ret = vkms_add_overlay_plane(vkmsdev, index, crtc);
> > -			if (ret)
> > -				return ret;
> > -		}
> > -	}
> > -
> >   	if (vkmsdev->config->cursor) {
> > -		cursor = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_CURSOR, index);
> > +		cursor = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_CURSOR);
> >   		if (IS_ERR(cursor))
> >   			return PTR_ERR(cursor);
> >   	}
> > -	/* [1]: Allocation of a CRTC, its index will be BIT(0) = 1 */
> >   	ret = vkms_crtc_init(dev, crtc, &primary->base, &cursor->base);
> >   	if (ret)
> >   		return ret;
> > +	if (vkmsdev->config->overlay) {
> > +		for (n = 0; n < NUM_OVERLAY_PLANES; n++) {
> > +			overlay = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_OVERLAY);
> > +			if (IS_ERR(overlay)) {
> > +				DRM_DEV_ERROR(dev->dev, "Failed to init vkms plane\n");
> > +				ret = PTR_ERR(overlay);
> > +				goto err_crtc;
> > +			}
> > +			overlay->base.possible_crtcs = drm_crtc_mask(crtc);
> > +		}
> > +	}
> > +
> >   	ret = drm_connector_init(dev, connector, &vkms_connector_funcs,
> >   				 DRM_MODE_CONNECTOR_VIRTUAL);
> >   	if (ret) {
> >   		DRM_ERROR("Failed to init connector\n");
> > -		goto err_connector;
> > +		goto err_crtc;
> >   	}
> >   	drm_connector_helper_add(connector, &vkms_conn_helper_funcs);
> > @@ -103,11 +91,7 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
> >   		DRM_ERROR("Failed to init encoder\n");
> >   		goto err_encoder;
> >   	}
> > -	/*
> > -	 * This is a hardcoded value to select crtc for the encoder.
> > -	 * BIT(0) here designate the first registered CRTC, the one allocated in [1]
> > -	 */
> > -	encoder->possible_crtcs = BIT(0);
> > +	encoder->possible_crtcs = drm_crtc_mask(crtc);
> >   	ret = drm_connector_attach_encoder(connector, encoder);
> >   	if (ret) {
> > @@ -131,7 +115,7 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
> >   err_encoder:
> >   	drm_connector_cleanup(connector);
> > -err_connector:
> > +err_crtc:
> >   	drm_crtc_cleanup(crtc);
> 
> Do we really need `drm_crtc_cleanup`? We are allocating the CRTC with
> `drmm_crtc_init_with_planes`.

I agree, I'll check the previous discussions I've had on the mailing list, 
I have a little doubt that someone asked me to re-add this cleaning at 
some point.

Thanks,
Louis Chauvet

> The rest looks fine to me.
>
> Best Regards,
> - Maíra
> 
> >   	return ret;
> > diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> > index e5c625ab8e3e..ad137c9a75f5 100644
> > --- a/drivers/gpu/drm/vkms/vkms_plane.c
> > +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> > @@ -198,12 +198,12 @@ static const struct drm_plane_helper_funcs vkms_plane_helper_funcs = {
> >   };
> >   struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
> > -				   enum drm_plane_type type, int index)
> > +				   enum drm_plane_type type)
> >   {
> >   	struct drm_device *dev = &vkmsdev->drm;
> >   	struct vkms_plane *plane;
> > -	plane = drmm_universal_plane_alloc(dev, struct vkms_plane, base, 1 << index,
> > +	plane = drmm_universal_plane_alloc(dev, struct vkms_plane, base, 0,
> >   					   &vkms_plane_funcs,
> >   					   vkms_formats, ARRAY_SIZE(vkms_formats),
> >   					   NULL, type, NULL);
> > 
> > ---
> > base-commit: 33c255312660653cf54f8019896b5dca28e3c580
> > change-id: 20240906-vkms-remove-index-3a6e04c38e02
> > 
> > Best regards,

