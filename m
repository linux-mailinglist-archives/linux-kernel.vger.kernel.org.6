Return-Path: <linux-kernel+bounces-177203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BB18C3B59
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 08:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36320B20D83
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 06:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D5C41A87;
	Mon, 13 May 2024 06:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="D94ZXrYs"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44798468
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 06:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715581890; cv=none; b=LWCl2CntvV3ehvy5pLnYXkgn3leH+q6jH1SQPqA1KDR+ALjn0ReHIc9ximVuecbXdibrkTsF1obawZNAEAiyuQppbCxx9hAEFIpoKgb5t5MyHy0KCptTokLo1EAs1Ni9gUVcMSSnlFhyAnPo8QW9PBUtW/tW9+h/3N8tSGG8MwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715581890; c=relaxed/simple;
	bh=teoP5Ie0rPmTaLcIaPhr5DO8lyp0/D9rBsJF9A6I4Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhRW5K47+loX94ZEHPKeV6P+CUXTTV9xqxco8lsjA6E3nB6VAMaHztclhzXXJEZW7ZPFiOfmEZE06GjLOQJUMYtXdHhaXov5R2QFKHNy+7P7t+tSgCn8F45Ii5hRapEN58ROAvWeYSafGflt15Y0/5vkUpYUkBF3gVXy0uUxO7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=D94ZXrYs; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 59EABE0009;
	Mon, 13 May 2024 06:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715581879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VfRoAFfC/1PV/3iC+jAvDAhNdr3/rvOcMyIFh+A5RLE=;
	b=D94ZXrYsv0C3e3g1KLqfGtvFsrQmwc5/78CFWP+o/WShVTsybRFJLQ2Pg8IcyaRue3JkDD
	ADn7ebqLAmz7Vp7+YW7qkeNxnjcViTJX/Axrp+LKxIrSwLL/7tKFkOPTZay7DYxJVvmjRD
	GTJYx6SzalaL4eGRfOHLWWAJiDo9w82cXlQxmPREzhtutkYxOgVz0ZLQqoW94GYMX9subN
	P9/Vrw0UhFRyQ1DTmS+dDvXv/+qP1yMNqien+fSxBtV52xpDx17ix3ORlbVZKaAD6fxQ4L
	yD0tsfJHGjbJQ4+s4o5AxK7hZv0yOp+fzv8C2PPeqiyMTzICbVpRlH57N11Teg==
Date: Mon, 13 May 2024 08:31:15 +0200
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Pekka Paalanen <pekka.paalanen@collabora.com>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, rdunlap@infradead.org,
	arthurgrillo@riseup.net, Jonathan Corbet <corbet@lwn.net>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
	thomas.petazzoni@bootlin.com, seanpaul@google.com,
	marcheu@google.com, nicolejadeyee@google.com
Subject: Re: [PATCH v6 03/17] drm/vkms: write/update the documentation for
 pixel conversion and pixel write functions
Message-ID: <ZkGzsyR3U1fhpPqZ@localhost.localdomain>
Mail-Followup-To: Pekka Paalanen <pekka.paalanen@collabora.com>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, rdunlap@infradead.org,
	arthurgrillo@riseup.net, Jonathan Corbet <corbet@lwn.net>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
	thomas.petazzoni@bootlin.com, seanpaul@google.com,
	marcheu@google.com, nicolejadeyee@google.com
References: <20240409-yuv-v6-0-de1c5728fd70@bootlin.com>
 <20240409-yuv-v6-3-de1c5728fd70@bootlin.com>
 <20240422133358.59fb6221.pekka.paalanen@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240422133358.59fb6221.pekka.paalanen@collabora.com>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 22/04/24 - 13:33, Pekka Paalanen a écrit :
> On Tue, 09 Apr 2024 15:25:21 +0200
> Louis Chauvet <louis.chauvet@bootlin.com> wrote:
> 
> > Add some documentation on pixel conversion functions.
> > Update of outdated comments for pixel_write functions.
> > 
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > ---
> >  drivers/gpu/drm/vkms/vkms_composer.c |  7 ++++
> >  drivers/gpu/drm/vkms/vkms_drv.h      | 15 ++++++++-
> >  drivers/gpu/drm/vkms/vkms_formats.c  | 62 ++++++++++++++++++++++++++++++------
> >  3 files changed, 74 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> > index c6d9b4a65809..da0651a94c9b 100644
> > --- a/drivers/gpu/drm/vkms/vkms_composer.c
> > +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> > @@ -189,6 +189,13 @@ static void blend(struct vkms_writeback_job *wb,
> >  
> >  	size_t crtc_y_limit = crtc_state->base.crtc->mode.vdisplay;
> >  
> > +	/*
> > +	 * The planes are composed line-by-line to avoid heavy memory usage. It is a necessary
> > +	 * complexity to avoid poor blending performance.
> > +	 *
> > +	 * The function vkms_compose_row is used to read a line, pixel-by-pixel, into the staging
> > +	 * buffer.
> > +	 */
> >  	for (size_t y = 0; y < crtc_y_limit; y++) {
> >  		fill_background(&background_color, output_buffer);
> >  
> > diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> > index b4b357447292..a86cb537d6aa 100644
> > --- a/drivers/gpu/drm/vkms/vkms_drv.h
> > +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> > @@ -25,6 +25,17 @@
> >  
> >  #define VKMS_LUT_SIZE 256
> >  
> > +/**
> > + * struct vkms_frame_info - structure to store the state of a frame
> > + *
> > + * @fb: backing drm framebuffer
> > + * @src: source rectangle of this frame in the source framebuffer
> > + * @dst: destination rectangle in the crtc buffer
> 
> Are both src and dst using whole pixel units, or is src using 1/65536th
> pixel units?

dst is in whole pixels, src in 1/65536 yes, I will clarify.
 
> Asking because UAPI has src rect in 16.16 fixed-point, IIRC.
> 
> With that clarified:
> 
> Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>

[...]


-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

