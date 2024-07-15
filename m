Return-Path: <linux-kernel+bounces-252189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0A6930FBD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0F64B2092B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 08:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7D0184136;
	Mon, 15 Jul 2024 08:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BE5yCAoI"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3D118307B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 08:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721032100; cv=none; b=KH7HEjoG9Sjde+JK4BR/KPOPJ0V0HYmHu2B3hiE4ZPb1yGFHjx9ro2haTVQAFaLDmzafFiGFZ3UmZRh5ItKFDZGvcv0UR6EMRhQxg436Gdbuh+u+o1gC+Px0gi21xiyDBe6mcxLju0cKK65jToAPTjmKty09YMtb6SqES+n0n0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721032100; c=relaxed/simple;
	bh=0JPb9Cjxtnj774USyTMOYpYucCBxVNOt5cF+Cej/Y3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/cSJ3zUg5zZJ83POIfo/AxuvLmd7kjm45vP2P/6C9hm7zJOBK3lYnibAgf6gqLA7utk+14Kzrfi/awRWS6DYChJy2DBl4MliYZvVqgdvUoqB2GwiyR419LWdF0witbHIgKucl1baxrM8+YG9L0sb0k94E0T3p6krRA/uJKOfrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BE5yCAoI; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 835131C0007;
	Mon, 15 Jul 2024 08:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721032096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nzPhvUeAKAa6sy366mPvywtGjg+xp3MxMxDZgFXkmVA=;
	b=BE5yCAoIcLY3vyj0tpJJfnbkib4/PCCGApFdp0IWxYTnA0Celqg07xqYJZtYH6ZBSjBxtA
	rlyhQqyy2WzvlTP/owiFsbIdMTLYeSvFgCIhaqsaFNIY1SrQJ7bC98rY9mr27EEgKHp8j/
	cWfdJruCVHGiGwAklX01Omjt0JFrAzzgiHG7AeE5JtgNc1bhEwWumPqPyzhNkovpoFLFcp
	G5/bg1cnQYrrwAkLua9+8Nf2/XY2N3sdCH3qKU1xmYf+DRQAJOKd1Wrgc4jFTgtBDVOuhm
	9rzKCFub7VfNQKiDuUjg/y6WcFeNfAkb07GkdWI4Lgj05EbfQ1nVIuceZd2nwQ==
Date: Mon, 15 Jul 2024 10:28:10 +0200
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
Subject: Re: [PATCH v8 03/17] drm/vkms: write/update the documentation for
 pixel conversion and pixel write functions
Message-ID: <ZpTdmjmJFil27DG1@louis-chauvet-laptop>
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
 <20240516-yuv-v8-3-cf8d6f86430e@bootlin.com>
 <5ef8948e-6c90-4892-bcfa-1d78655025cd@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ef8948e-6c90-4892-bcfa-1d78655025cd@igalia.com>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 13/07/24 - 11:35, Maíra Canal a écrit :
> On 5/16/24 10:04, Louis Chauvet wrote:
> > Add some documentation on pixel conversion functions.
> > Update of outdated comments for pixel_write functions.
> > 
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> > ---
> >   drivers/gpu/drm/vkms/vkms_composer.c |  7 ++++
> >   drivers/gpu/drm/vkms/vkms_drv.h      | 15 ++++++++-
> >   drivers/gpu/drm/vkms/vkms_formats.c  | 62 ++++++++++++++++++++++++++++++------
> >   3 files changed, 74 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> > index c6d9b4a65809..da0651a94c9b 100644
> > --- a/drivers/gpu/drm/vkms/vkms_composer.c
> > +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> > @@ -189,6 +189,13 @@ static void blend(struct vkms_writeback_job *wb,
> >   
> >   	size_t crtc_y_limit = crtc_state->base.crtc->mode.vdisplay;
> >   
> > +	/*
> > +	 * The planes are composed line-by-line to avoid heavy memory usage. It is a necessary
> > +	 * complexity to avoid poor blending performance.
> > +	 *
> > +	 * The function vkms_compose_row is used to read a line, pixel-by-pixel, into the staging
> 
> Nit: I know it's not kerneldoc, but I'd be glad if you use
> vkms_compose_row()
> 
> > +	 * buffer.
> > +	 */
> >   	for (size_t y = 0; y < crtc_y_limit; y++) {
> >   		fill_background(&background_color, output_buffer);
> >   
> > diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> > index b4b357447292..212f4ab6a71f 100644
> > --- a/drivers/gpu/drm/vkms/vkms_drv.h
> > +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> > @@ -25,6 +25,17 @@
> >   
> >   #define VKMS_LUT_SIZE 256
> >   
> > +/**
> > + * struct vkms_frame_info - structure to store the state of a frame
> 
> s/structure/Structure
> 
> > + *
> > + * @fb: backing drm framebuffer
> > + * @src: source rectangle of this frame in the source framebuffer, stored in 16.16 fixed-point form
> > + * @dst: destination rectangle in the crtc buffer, stored in whole pixel units
> > + * @map: see drm_shadow_plane_state@data
> > + * @rotation: rotation applied to the source.
> > + *
> > + * @src and @dst should have the same size modulo the rotation.
> > + */
> >   struct vkms_frame_info {
> >   	struct drm_framebuffer *fb;
> >   	struct drm_rect src, dst;
> > @@ -49,9 +60,11 @@ struct vkms_writeback_job {
> >   };
> >   
> >   /**
> > - * vkms_plane_state - Driver specific plane state
> > + * struct vkms_plane_state - Driver specific plane state
> >    * @base: base plane state
> >    * @frame_info: data required for composing computation
> > + * @pixel_read: function to read a pixel in this plane. The creator of a vkms_plane_state must
> 
> s/vkms_plane_state/struct vkms_plane_state
> 
> > + * ensure that this pointer is valid
> 
> Note: "If the @argument description has multiple lines, the continuation
> of the description should start at the same column as the previous
> line:" [1]
> 
> [1] https://docs.kernel.org/doc-guide/kernel-doc.html#function-parameters
> 
> >    */
> >   struct vkms_plane_state {
> >   	struct drm_shadow_plane_state base;
> > diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> > index d597c48452ac..f157c43da4d6 100644
> > --- a/drivers/gpu/drm/vkms/vkms_formats.c
> > +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> > @@ -9,6 +9,18 @@
> >   
> >   #include "vkms_formats.h"
> >   
> > +/**
> > + * pixel_offset() - Get the offset of the pixel at coordinates x/y in the first plane
> > + *
> > + * @frame_info: Buffer metadata
> > + * @x: The x coordinate of the wanted pixel in the buffer
> > + * @y: The y coordinate of the wanted pixel in the buffer
> > + *
> > + * The caller must ensure that the framebuffer associated with this request uses a pixel format
> > + * where block_h == block_w == 1.
> > + * If this requirement is not fulfilled, the resulting offset can point to an other pixel or
> > + * outside of the buffer.
> > + */
> >   static size_t pixel_offset(const struct vkms_frame_info *frame_info, int x, int y)
> >   {
> >   	struct drm_framebuffer *fb = frame_info->fb;
> > @@ -16,18 +28,22 @@ static size_t pixel_offset(const struct vkms_frame_info *frame_info, int x, int
> >   	return fb->offsets[0] + (y * fb->pitches[0]) + (x * fb->format->cpp[0]);
> >   }
> >   
> > -/*
> > - * packed_pixels_addr - Get the pointer to pixel of a given pair of coordinates
> > +/**
> > + * packed_pixels_addr() - Get the pointer to the block containing the pixel at the given
> > + * coordinates
> >    *
> >    * @frame_info: Buffer metadata
> > - * @x: The x(width) coordinate of the 2D buffer
> > - * @y: The y(Heigth) coordinate of the 2D buffer
> > + * @x: The x (width) coordinate inside the plane
> > + * @y: The y (height) coordinate inside the plane
> >    *
> >    * Takes the information stored in the frame_info, a pair of coordinates, and
> >    * returns the address of the first color channel.
> >    * This function assumes the channels are packed together, i.e. a color channel
> >    * comes immediately after another in the memory. And therefore, this function
> >    * doesn't work for YUV with chroma subsampling (e.g. YUV420 and NV21).
> > + *
> > + * The caller must ensure that the framebuffer associated with this request uses a pixel format
> > + * where block_h == block_w == 1, otherwise the returned pointer can be outside the buffer.
> >    */
> >   static void *packed_pixels_addr(const struct vkms_frame_info *frame_info,
> >   				int x, int y)
> > @@ -52,6 +68,13 @@ static int get_x_position(const struct vkms_frame_info *frame_info, int limit, i
> >   	return x;
> >   }
> >   
> > +/*
> > + * The following functions take pixel data from the buffer and convert them to the format
> > + * ARGB16161616 in out_pixel.
> 
> I believe it is @out_pixel.

Thanks for the review!

Yes it @out_pixel, I will fix those nits for the next iteration.

Thanks,
Louis Chauvet
 
> The content seems great to me, only those minor nits.
> 
> Best Regards,
> - Maíra
> 

[...]

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

