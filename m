Return-Path: <linux-kernel+bounces-303432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C88960BFA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6DE81C2301B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390F61C4EDD;
	Tue, 27 Aug 2024 13:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lVaA8eoK"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7742F1C4EC3
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 13:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724765058; cv=none; b=EX4+chZllb54ml9D22gGXxAlSm/j/zmR5d08Om8h7KCLRVVv+PmlEtdnxbiEilrXQ8ZVqur3e9ZX3hFssCDi8FipUBIl3r5WfmZD6lytA94W2ufNW2coe2HRcvxTM0m6IGOMSIv1rqf6SahSQGJXzbBW3MJOtrYUEEbjoSiFWAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724765058; c=relaxed/simple;
	bh=r9WmCFRu07kKYrGje8ym8SwAHLCwsBUMCgcWuUb2Cp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jK3hqmI8jbOqAkJ/iYVu4fkFO2QxuG7mvAzbr0J26MdHGA5RXuOTqz4sRZmob555KOYlFq9bjg++fmnH/aTX8nDG90D6tNyx70KfZ/y89PnJAv9WtW9SGdd/Vp+Q8G+ZebhDjBE5TezZfxfbSJzyDgh3iYh9oNFE2Exhoxkoj00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lVaA8eoK; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 259D61C0006;
	Tue, 27 Aug 2024 13:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724765053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gUxO98kREyq2Dv1HtZo0CIxCjyQ/xlXo+yetlw0Nwrc=;
	b=lVaA8eoKe8FP8fayNh2Xr+2aoq09JfcOnki2XHLZgY1oL8Ofpnb1fS8vhDYtHIY/d4BUz2
	mWPaH7hzWHNsSAyeljkL1RXmkqjVe+tsMY90zEm/OgJ48C3g7zcoHCfaQZvwatSvFnBHOw
	60HghVmKX9Ti4Ola2HTDZlFLQkGh8TyRmNJTTIXyWCtSwRhBpjhfMhs5NhP9ZsZG3vNp3n
	R4rakP8ox1vCxDoA9zJoK7XVJHBxYx97b9axP8Z44lcAo8Q8lJCmApkgE+sZwe11OEwCVB
	9LjsH63kaOD8qWOZXqqNCcmIfra71E9c10dwLzXajs5H3lrUPJGEgItJ242BBw==
Date: Tue, 27 Aug 2024 15:24:10 +0200
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	arthurgrillo@riseup.net, linux-kernel@vger.kernel.org,
	jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
	thomas.petazzoni@bootlin.com, seanpaul@google.com,
	nicolejadeyee@google.com
Subject: Re: [PATCH v2 1/6] drm/vkms: Switch to managed for connector
Message-ID: <Zs3TeoUwn3iO7oBs@louis-chauvet-laptop>
Mail-Followup-To: Maxime Ripard <mripard@kernel.org>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	arthurgrillo@riseup.net, linux-kernel@vger.kernel.org,
	jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
	thomas.petazzoni@bootlin.com, seanpaul@google.com,
	nicolejadeyee@google.com
References: <20240827-google-vkms-managed-v2-0-f41104553aeb@bootlin.com>
 <20240827-google-vkms-managed-v2-1-f41104553aeb@bootlin.com>
 <20240827-dynamic-acoustic-guillemot-ddde49@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240827-dynamic-acoustic-guillemot-ddde49@houat>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 27/08/24 - 15:15, Maxime Ripard a écrit :
> Hi,
> 
> On Tue, Aug 27, 2024 at 11:57:36AM GMT, Louis Chauvet wrote:
> > The current VKMS driver uses non-managed function to create connectors. It
> > is not an issue yet, but in order to support multiple devices easily,
> > convert this code to use drm and device managed helpers.
> > 
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > ---
> >  drivers/gpu/drm/vkms/vkms_drv.h    |  1 -
> >  drivers/gpu/drm/vkms/vkms_output.c | 22 ++++++++++++----------
> >  2 files changed, 12 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> > index 5e46ea5b96dc..9a3c6c34d1f6 100644
> > --- a/drivers/gpu/drm/vkms/vkms_drv.h
> > +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> > @@ -99,7 +99,6 @@ struct vkms_crtc_state {
> >  struct vkms_output {
> >  	struct drm_crtc crtc;
> >  	struct drm_encoder encoder;
> > -	struct drm_connector connector;
> >  	struct drm_writeback_connector wb_connector;
> >  	struct hrtimer vblank_hrtimer;
> >  	ktime_t period_ns;
> > diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> > index 5ce70dd946aa..4fe6b88e8081 100644
> > --- a/drivers/gpu/drm/vkms/vkms_output.c
> > +++ b/drivers/gpu/drm/vkms/vkms_output.c
> > @@ -3,11 +3,11 @@
> >  #include "vkms_drv.h"
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_edid.h>
> > +#include <drm/drm_managed.h>
> >  #include <drm/drm_probe_helper.h>
> >  
> >  static const struct drm_connector_funcs vkms_connector_funcs = {
> >  	.fill_modes = drm_helper_probe_single_connector_modes,
> > -	.destroy = drm_connector_cleanup,
> >  	.reset = drm_atomic_helper_connector_reset,
> >  	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> >  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> > @@ -50,7 +50,7 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
> >  {
> >  	struct vkms_output *output = &vkmsdev->output;
> >  	struct drm_device *dev = &vkmsdev->drm;
> > -	struct drm_connector *connector = &output->connector;
> > +	struct drm_connector *connector;
> >  	struct drm_encoder *encoder = &output->encoder;
> >  	struct drm_crtc *crtc = &output->crtc;
> >  	struct vkms_plane *primary, *cursor = NULL;
> > @@ -80,8 +80,15 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
> >  	if (ret)
> >  		return ret;
> >  
> > -	ret = drm_connector_init(dev, connector, &vkms_connector_funcs,
> > -				 DRM_MODE_CONNECTOR_VIRTUAL);
> > +	connector = drmm_kzalloc(dev, sizeof(*connector), GFP_KERNEL);
> > +	if (!connector) {
> > +		DRM_ERROR("Failed to allocate connector\n");
> > +		ret = -ENOMEM;
> > +		goto err_connector;
> > +	}
> > +
> 
> I think it would be worth explaining why you need to move to a separate
> allocation for the connector now.
> 
> Maxime

Hi,

This is in preparation for ConfigFS implementation, as the number of 
connector/encoders/crtc/planes... will be dynamic, we need to have 
separate alloaction.

If I add this paragraph in the commit message, is it sufficient?

	A specific allocation for the connector is not strictly necessary 
	at this point, but in order to implement dynamic configuration of 
	VKMS (configFS), it will be easier to have one allocation per 
	connector.

(same for encoder & CRTC)

Thanks,
Louis Chauvet

