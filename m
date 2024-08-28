Return-Path: <linux-kernel+bounces-304632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD89B9622F9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65F3D285DDD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCA615C151;
	Wed, 28 Aug 2024 09:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HZr3+rFa"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3D115A849
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724836064; cv=none; b=dDEL+rwwTS7Glnr224Uvk2Xi3gW+RNRF/X1dGQ0oLmI0EzKBmB1NmRiEX3WcT8ozJz7rQzKtbUBZvsBefm0rcGL9t2VcuDJYVhCRw3joTB+LPVqUEt4GK88kKf4SJhKu2HjFERAgOycWtt0vaXrRzA6Yy1VgUapCPdUEuTAQy9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724836064; c=relaxed/simple;
	bh=EKyC33cDFQACdKdFn9YBTnMhr5pOWML1YgTKMjs3SAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/k/4SvhzmlQYICTOy5k9IoqhXsH70vxgujlibW8faPqENJr8HV7/qDd53nw0Vfz/GGA+hWE+2xwSAasq/xKHVNHn9SxGqMT5JF4IU5ugaaJc2AIDfxTSQ773w3/DLzLlHAP1gDrovQh2hTKL/66vXRGQO/XEUfW4gHP0261XVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HZr3+rFa; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B26A1FF80C;
	Wed, 28 Aug 2024 09:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724836060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zz6DLvfJRS+oja0Jh65Ow9R3+OFipp+nRBopAIUquPU=;
	b=HZr3+rFaDgZ5jLlvkG6vFKp1SByVaSvFBelAgXt08tU5mG4/H/gAQTI9tfZDUJWVwCsFSO
	55nczXRDdOqnvocUxWkzX3bkDUhly3QGbJ6KurDCZlB1VDTRFCL53iM4YxZx6mlh/uhueX
	EtGrQd8udFMfI8a59FXURw2jQ8Y/maYGDIEMPXjiua/Eh9uDkx+sJA1MrmgFx9Ogciv/z5
	l7bCXfqr2vho0rhY0bsyu0kczITsmpTlHECPU2AP5gg1m69SAnIzU3nV1u3O1wEbj0csQu
	G7zMS4zC5Vp7GO9pXRMXCh5VIoSRKP+yH9GQcDE8WQJ5vY7aFfkXCvoyoM6hOg==
Date: Wed, 28 Aug 2024 11:07:37 +0200
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>,
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
Subject: Re: [PATCH RFC 11/15] drm: writeback: Add drm_writeback_connector
 cleanup
Message-ID: <Zs7o2REyQuVrlmbo@louis-chauvet-laptop>
Mail-Followup-To: Jani Nikula <jani.nikula@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
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
References: <20240814-google-remove-crtc-index-from-parameter-v1-0-6e179abf9fd4@bootlin.com>
 <20240814-google-remove-crtc-index-from-parameter-v1-11-6e179abf9fd4@bootlin.com>
 <20240827-solid-adorable-coucal-c3e0d1@houat>
 <Zs3z7tx4dMBfY_DX@louis-chauvet-laptop>
 <87a5gxyrhc.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a5gxyrhc.fsf@intel.com>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 28/08/24 - 11:35, Jani Nikula a écrit :
> On Tue, 27 Aug 2024, Louis Chauvet <louis.chauvet@bootlin.com> wrote:
> > Le 27/08/24 - 16:33, Maxime Ripard a écrit :
> >> Hi,
> >> 
> >> On Wed, Aug 14, 2024 at 04:36:33PM GMT, Louis Chauvet wrote:
> >> > Currently drm_writeback_connector are created by
> >> > drm_writeback_connector_init or drm_writeback_connector_init_with_encoder.
> >> > Both of the function uses drm_connector_init and drm_encoder_init, but
> >> > there is no way to properly clean those structure from outside.
> >> > 
> >> > This patch introduce the new function drm_writeback_connector_cleanup to
> >> > allow a proper cleanup.
> >> > 
> >> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> >> > ---
> >> >  drivers/gpu/drm/drm_writeback.c | 10 ++++++++++
> >> >  include/drm/drm_writeback.h     | 11 +++++++++++
> >> >  2 files changed, 21 insertions(+)
> >> > 
> >> > diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
> >> > index a031c335bdb9..505a4eb40f93 100644
> >> > --- a/drivers/gpu/drm/drm_writeback.c
> >> > +++ b/drivers/gpu/drm/drm_writeback.c
> >> > @@ -184,6 +184,7 @@ int drm_writeback_connector_init(struct drm_device *dev,
> >> >  	drm_encoder_helper_add(&wb_connector->encoder, enc_helper_funcs);
> >> >  
> >> >  	wb_connector->encoder.possible_crtcs = possible_crtcs;
> >> > +	wb_connector->managed_encoder = true;
> >> >  
> >> >  	ret = drm_encoder_init(dev, &wb_connector->encoder,
> >> >  			       &drm_writeback_encoder_funcs,
> >> > @@ -290,6 +291,15 @@ int drm_writeback_connector_init_with_encoder(struct drm_device *dev,
> >> >  }
> >> >  EXPORT_SYMBOL(drm_writeback_connector_init_with_encoder);
> >> >  
> >> > +void drm_writeback_connector_cleanup(struct drm_writeback_connector *wb_connector)
> >> > +{
> >> > +	drm_connector_cleanup(&wb_connector->base);
> >> > +	drm_property_blob_put(wb_connector->pixel_formats_blob_ptr);
> >> > +	if (wb_connector->managed_encoder)
> >> > +		drm_encoder_cleanup(&wb_connector->encoder);
> >> > +}
> >> > +EXPORT_SYMBOL(drm_writeback_connector_cleanup);
> >> > +
> >> >  int drm_writeback_set_fb(struct drm_connector_state *conn_state,
> >> >  			 struct drm_framebuffer *fb)
> >> >  {
> >> > diff --git a/include/drm/drm_writeback.h b/include/drm/drm_writeback.h
> >> > index 17e576c80169..e651c0c0c84c 100644
> >> > --- a/include/drm/drm_writeback.h
> >> > +++ b/include/drm/drm_writeback.h
> >> > @@ -35,6 +35,15 @@ struct drm_writeback_connector {
> >> >  	 */
> >> >  	struct drm_encoder encoder;
> >> >  
> >> > +	/**
> >> > +	 * @managed_encoder: Sets to true if @encoder was created by drm_writeback_connector_init()
> >> > +	 *
> >> > +	 * If the user used drm_writeback_connector_init_with_encoder() to create the connector,
> >> > +	 * @encoder is not valid and not managed by drm_writeback_connector. This fields allows
> >> > +	 * the drm_writeback_cleanup() function to properly destroy the encoder if needed.
> >> > +	 */
> >> > +	bool managed_encoder;
> >> > +
> >> 
> >> I think we should rather create drmm_writeback_connector variants,
> >> and make both deprecated in favor of these new functions.
> >
> > Hi,
> >
> > I can try to do it. If I understand correctly, you want to create two 
> > functions like this? 
> >
> > 	int drmm_writeback_connector_init([...]) {
> > 		/* drmm and alloc as we want to let drm core to manage this 
> > 		   encoder, no need to store it in drm_writeback_connector 
> > 		   */
> > 		enc = drmm_plain_encoder_alloc(...);
> >
> > 		return drmm_writeback_connector_init_with_encoder([...], enc);
> > 	}
> >
> > 	int drmm_writeback_connector_init_with_encoder([...], enc) {
> > 		con = drmm_connector_init([...]);
> >
> > 		drm_connector_attach_encoder(enc, con);
> >
> > 		/* Needed for pixel_formats_blob_ptr, base is already 
> > 		   managed by drmm_connector_init. Maybe cleaning 
> > 		   job_queue is also needed? */
> > 		drmm_add_action_or_reset([...], &drm_writeback_connector_cleanup)
> > 	}
> 
> Why add two variants, when you can have one and pass NULL for encoder?
> We have the _init_with_encoder variant only because nobody bothered to
> clean up existing call sites.

I just followed the existing code, but yes, I can make only one function 
and create the encoder if the pointer is NULL.
 
> Side note, I'd still like to be able to pass driver's own allocated
> connector instead of having writeback midlayer force it on you.

I just checked, it seems non-trivial to make this change and I don't feel 
confident to change this much the drm core.

Louis Chauvet

> BR,
> Jani.
> 
> 
> >
> > Louis Chauvet
> >  
> >> Maxime
> >
> >
> 
> -- 
> Jani Nikula, Intel

