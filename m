Return-Path: <linux-kernel+bounces-252190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5AA930FBF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60971C20753
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 08:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E1A185081;
	Mon, 15 Jul 2024 08:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HqPXNyt4"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804031849D7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 08:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721032104; cv=none; b=gcxSti97FCXwYz9LMh3stdA3h8L8oiU/GT6NgeGJKkiu2MQXyHJzhqcHcUIhnWpjgiy2LT2E0ZAWxOU/nPR+6aue5NkyN2Dh7G46pDZKvkkIlFtBt3dglDsqJ5eRtzI6PDcbHWg1xz5lKLCI9MEcqaJ36uZeVKhS1EJXquteyUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721032104; c=relaxed/simple;
	bh=cDxwHjTJXEJmuZZJ16wgqs1iHdtXeIOj//CfKmG7O8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooUKyJVGydqHd+05NHALumbcDrLp7ncdWFiWXcKvR6mDTEkFW52cJAlB59asTjeVoU8OUAyleYY1XHK2ROcVxQhLQEPQWUZ0j5/xLq9WNXVnG2fZ1nu4tQnBAgljehP7misLZb/bQLUXBwdFYCrBAj88li6oSQfbjzx5xDhZscg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HqPXNyt4; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0A13DC000C;
	Mon, 15 Jul 2024 08:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721032095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yGc188UpjzG+33fxD7SNC2KQ7T06wKgav19Xcw+WTdQ=;
	b=HqPXNyt4oq66oUA1KngW2Xq2vyQuxKCrK/Zfb1ZxH4igPTYNAqGIp+7njQ32fDs8jm0LXX
	VYWFRHZcGOKRz+ur9qU+pRUppjsW+NmslUb3ss7lliN+j2gRqsqrGfivG0CY3dNGfVMj/j
	nbJQUsyobNSJLoOrbHYcCG00he2O3wgqxOdvBoOEcjD9ItpESj2fzsVM1+feAvl/efSHbO
	EQ3TrPS3CBg0h+5BIDI1tonFosjP/NYjoJfSdrqYslVld1ZS7x5mnKtwhr7qYxxnN2ucxE
	W5+RqlpTxfWOC+iVvBIpgGB40jHEtURRWV1IRMIjs65YVRNMvC8JsvbQa4md9A==
Date: Mon, 15 Jul 2024 10:28:11 +0200
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, rdunlap@infradead.org,
	arthurgrillo@riseup.net, Jonathan Corbet <corbet@lwn.net>,
	pekka.paalanen@haloniitty.fi, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com,
	miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
	seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com,
	Pekka Paalanen <pekka.paalanen@collabora.com>
Subject: Re: [PATCH v8 04/17] drm/vkms: Add typedef and documentation for
 pixel_read and pixel_write functions
Message-ID: <ZpTdmxfqx3ulALk8@louis-chauvet-laptop>
Mail-Followup-To: =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, rdunlap@infradead.org,
	arthurgrillo@riseup.net, Jonathan Corbet <corbet@lwn.net>,
	pekka.paalanen@haloniitty.fi, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com,
	miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
	seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com,
	Pekka Paalanen <pekka.paalanen@collabora.com>
References: <20240516-yuv-v8-0-cf8d6f86430e@bootlin.com>
 <20240516-yuv-v8-4-cf8d6f86430e@bootlin.com>
 <99be1782-0235-4418-adbf-cd80d8b28d7a@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99be1782-0235-4418-adbf-cd80d8b28d7a@igalia.com>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 13/07/24 - 11:38, Maíra Canal a écrit :
> On 5/16/24 10:04, Louis Chauvet wrote:
> > Introduce two typedefs: pixel_read_t and pixel_write_t. It allows the
> > compiler to check if the passed functions take the correct arguments.
> > Such typedefs will help ensuring consistency across the code base in
> > case of update of these prototypes.
> > 
> > Rename input/output variable in a consistent way between read_line and
> > write_line.
> > 
> > A warn has been added in get_pixel_*_function to alert when an unsupported
> > pixel format is requested. As those formats are checked before
> > atomic_update callbacks, it should never happen.
> > 
> > Document for those typedefs.
> > 
> > Reviewed-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>

[...]

> >   /**
> > @@ -265,7 +265,7 @@ void vkms_writeback_row(struct vkms_writeback_job *wb,
> >    *
> >    * @format: DRM_FORMAT_* value for which to obtain a conversion function (see [drm_fourcc.h])
> >    */
> > -void *get_pixel_conversion_function(u32 format)
> > +pixel_read_t get_pixel_read_function(u32 format)
> >   {
> >   	switch (format) {
> >   	case DRM_FORMAT_ARGB8888:
> > @@ -279,7 +279,16 @@ void *get_pixel_conversion_function(u32 format)
> >   	case DRM_FORMAT_RGB565:
> >   		return &RGB565_to_argb_u16;
> >   	default:
> > -		return NULL;
> > +		/*
> > +		 * This is a bug in vkms_plane_atomic_check(). All the supported
> > +		 * format must:
> > +		 * - Be listed in vkms_formats in vkms_plane.c
> > +		 * - Have a pixel_read callback defined here
> > +		 */
> > +		WARN(true,
> > +		     "Pixel format %p4cc is not supported by VKMS planes. This is a kernel bug, atomic check must forbid this configuration.\n",
> > +		     &format);
> 
> Well, if this is a kernel bug, shouldn't we use a BUG_ON()/BUG() macro?

I don't know what is the "rule" for this kind of bug. Yes it is a kernel 
bug, but it is recoverable and I can avoid a full kernel crash by using a 
"do nothing" callback. 

If you prefer I can replace this by:

	pr_err("Pixel format %p4cc is [...]", &format);
	BUG();

and drop the next commit. The kernel will crash if there is a mismatch 
between advertised supported formats and formats listed here.

> Best Regards,
> - Maíra
> 
> >    * @format: DRM_FORMAT_* value for which to obtain a conversion function (see [drm_fourcc.h])
> >    */
> > -void *get_pixel_write_function(u32 format)
> > +pixel_write_t get_pixel_write_function(u32 format)
> >   {
> >   	switch (format) {
> >   	case DRM_FORMAT_ARGB8888:
> > @@ -304,6 +313,15 @@ void *get_pixel_write_function(u32 format)
> >   	case DRM_FORMAT_RGB565:
> >   		return &argb_u16_to_RGB565;
> >   	default:
> > -		return NULL;
> > +		/*
> > +		 * This is a bug in vkms_writeback_atomic_check. All the supported
> > +		 * format must:
> > +		 * - Be listed in vkms_wb_formats in vkms_writeback.c
> > +		 * - Have a pixel_write callback defined here
> > +		 */
> > +		WARN(true,
> > +		     "Pixel format %p4cc is not supported by VKMS writeback. This is a kernel bug, atomic check must forbid this configuration.\n",
> > +		     &format);
> > +		return (pixel_write_t)NULL;

I can do the same here.

Thanks,
Louis Chauvet

[...]

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

