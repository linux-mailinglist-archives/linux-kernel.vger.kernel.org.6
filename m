Return-Path: <linux-kernel+bounces-384584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9C09B2BF9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D4DEB23FCB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6211D6188;
	Mon, 28 Oct 2024 09:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Wa5cEUK4"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE551D1F7E
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730109047; cv=none; b=V0zuc1zLW8F0wifM4PKyPKx70Qt1mB7V3iF6I6tQvKbRmJ8SH4kZkermsQi6PFUu7rVt9pwui7ALYWbQacsPorIRMPpvj1G4QoWLH8UyjCRQUbLou1WODKRlMEj+1Ru75ZaI57sFtEq2dvZlgXKyUWI+CXjgJRvOlQRtmFaRz3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730109047; c=relaxed/simple;
	bh=h8ece4YIyKquhoiOR1Jyr5OuaGpq5ixN9nozBfcVDNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZFzsK9I0DjgdIZKH13o/56dkyOtd0dvh+8G9P5wQpHtC62XbIzizJXfsS7iBfuSPXxyzrNuD/Yihx/eO4bJrLRl78ZusaNrlyCJ0ZC0G/3OTqJaW9Zj4ZB9A2qYA2nS8r/mdKTdQ5LEAGBn4er0hhZzRIVdoLZFA24lhMHa+pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Wa5cEUK4; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 23EF3E0007;
	Mon, 28 Oct 2024 09:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730109038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hbsfqPI/+Pq0sVsIDMdySlzGdjH2/Ya3VyVTgeSvFyE=;
	b=Wa5cEUK4rELTUuRoJFNkvcp9ZM959c5x73lKCnMLrVVHcTogtVkwqBmXezMIJoHyYn666v
	fNz80L9Njj/GQQkvRkj71/D0o0L8M2Fo2jEImxODvNc4bB/PZXS1chXGeZlwsMVB4f7nZx
	Dz9TtODIZC+RRw3nEwyRtt0WBBfuGLnXa5/o23JrU2v3z2t8cUFsWPYP+1kPUET2kxiwS7
	2IW7pDLTUYa84jqndr1yjn8ILxkcLJmCgYRTlclpPnrabWKr35YA2DmLDjzGKaN6bl+AxF
	M00Vm1BgmrMW/pbLUflJiIhZ/cjNZCiNzdQkAcav+/14F58X0fgTlAIJKgQIOg==
Date: Mon, 28 Oct 2024 10:50:35 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: =?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net,
	linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com,
	miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
	seanpaul@google.com, nicolejadeyee@google.com,
	20241010-vkms-remove-index-v2-1-6b8d6cfd5a15@bootlin.com
Subject: Re: [PATCH v4 1/5] drm/vkms: Switch to managed for connector
Message-ID: <Zx9eazl8s7o6Mx-T@fedora>
Mail-Followup-To: =?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net,
	linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com,
	miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
	seanpaul@google.com, nicolejadeyee@google.com,
	20241010-vkms-remove-index-v2-1-6b8d6cfd5a15@bootlin.com
References: <20241010-google-vkms-managed-v4-0-ed04a62ad2e3@bootlin.com>
 <20241010-google-vkms-managed-v4-1-ed04a62ad2e3@bootlin.com>
 <575323aa-d322-4d03-8343-15aaaa955437@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <575323aa-d322-4d03-8343-15aaaa955437@riseup.net>
X-GND-Sasl: louis.chauvet@bootlin.com

On 26/10/24 - 12:29, Maíra Canal wrote:
> Hi Louis,
> 
> On 10/10/24 14:39, Louis Chauvet wrote:
> > The current VKMS driver uses non-managed function to create connectors. It
> > is not an issue yet, but in order to support multiple devices easily,
> > convert this code to use drm and device managed helpers.
> > 
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > ---
> >   drivers/gpu/drm/vkms/vkms_output.c | 19 +++++++------------
> >   1 file changed, 7 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> > index 5128aa3b2eb6..8f7a05b73e1d 100644
> > --- a/drivers/gpu/drm/vkms/vkms_output.c
> > +++ b/drivers/gpu/drm/vkms/vkms_output.c
> > @@ -3,11 +3,11 @@
> >   #include "vkms_drv.h"
> >   #include <drm/drm_atomic_helper.h>
> >   #include <drm/drm_edid.h>
> > +#include <drm/drm_managed.h>
> >   #include <drm/drm_probe_helper.h>
> >   static const struct drm_connector_funcs vkms_connector_funcs = {
> >   	.fill_modes = drm_helper_probe_single_connector_modes,
> > -	.destroy = drm_connector_cleanup,
> >   	.reset = drm_atomic_helper_connector_reset,
> >   	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> >   	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> > @@ -70,17 +70,17 @@ int vkms_output_init(struct vkms_device *vkmsdev)
> >   			if (IS_ERR(overlay)) {
> >   				DRM_DEV_ERROR(dev->dev, "Failed to init vkms plane\n");
> >   				ret = PTR_ERR(overlay);
> > -				goto err_crtc;
> > +				goto err_connector;
> 
> Why did you renamed err_crtc to err_connector? I think err_crtc looks
> correct.

I rename it many times during my work, it was never clear for me if 
"err_crtc" is about an error during the CRTC initialization or a label to 
clean the crtc.

If for you err_crtc is correct (ie err_<thing> means "cleanup <thing>"), I 
will switch to this pattern.

Thanks,
Louis Chauvet
 
> Best Regards,
> - Maíra
> 
> >   			}
> >   			overlay->base.possible_crtcs = drm_crtc_mask(crtc);
> >   		}
> >   	}
> > -	ret = drm_connector_init(dev, connector, &vkms_connector_funcs,
> > -				 DRM_MODE_CONNECTOR_VIRTUAL);
> > +	ret = drmm_connector_init(dev, connector, &vkms_connector_funcs,
> > +				  DRM_MODE_CONNECTOR_VIRTUAL, NULL);
> >   	if (ret) {
> >   		DRM_ERROR("Failed to init connector\n");
> > -		goto err_crtc;
> > +		goto err_connector;
> >   	}
> >   	drm_connector_helper_add(connector, &vkms_conn_helper_funcs);
> > @@ -89,7 +89,7 @@ int vkms_output_init(struct vkms_device *vkmsdev)
> >   			       DRM_MODE_ENCODER_VIRTUAL, NULL);
> >   	if (ret) {
> >   		DRM_ERROR("Failed to init encoder\n");
> > -		goto err_encoder;
> > +		return ret;
> >   	}
> >   	encoder->possible_crtcs = drm_crtc_mask(crtc);
> > @@ -111,12 +111,7 @@ int vkms_output_init(struct vkms_device *vkmsdev)
> >   err_attach:
> >   	drm_encoder_cleanup(encoder);
> > -
> > -err_encoder:
> > -	drm_connector_cleanup(connector);
> > -
> > -err_crtc:
> > +err_connector:
> >   	drm_crtc_cleanup(crtc);
> > -
> >   	return ret;
> >   }
> > 

