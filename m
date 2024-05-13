Return-Path: <linux-kernel+bounces-177241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 301968C3BCB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45411F2156C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F057146D45;
	Mon, 13 May 2024 07:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kpyU3Ajh"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11631465B3
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 07:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715584521; cv=none; b=nylye+S4B1tctuyiX3nr23CV7cZxGaYcPpuJX3VqmWPtvn1mgQ3aepa2Y44+FR7ZufRyvAxrlAYLGIoUZAQgOy8Zu3hdX7svRJeRsxLAZJ+mtYYO4WUu/bdtlNoKueZzXtG2Pfb2zdN76VGirU2+DrHUyoN/HkmwjDWkY5VWCFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715584521; c=relaxed/simple;
	bh=/ZpEaqgb9Jtcgtj2fF9gvjSgj6i1Sc6LVV+GLeETmvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWl4MnaqORgbBp0dVtyyeY056qT9pscXo2ihhmEGxGQD1+8NGumD9BUlg6sTYvBcnqDuMX8OxHE2Vryq6YDfyJuzH40+r8zFHyovB6OLbgqxbOXkJXrqetJ6KQhSK2bGFGxKX3Pz4MzYKSolTAzuAj4kBWmnfordLIdTiFO0/xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kpyU3Ajh; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A6ECA240009;
	Mon, 13 May 2024 07:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715584516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S312a6OoiTmc4Vqd0NFOI4xTJ4yE4d2EsK29VtTpuEQ=;
	b=kpyU3AjhQsXFn4HRN6HUX499PSF1tF5NyM7ASlpe39NrJoefSQC1nrM3uHCTLgNjxneCPJ
	7MO1DkryEGBifAcK7hgjtk4DxgPEsV7wdvJycQZGld5R/81C8G+DMtKRMpVVKsrv0LCTY+
	m+IshQUwR1JmbovO6NJGGTT8gtX8/KYa0PS2eg+4c1Lgp0gb9uAd8XpJiiuHiwGpaqmG5F
	Tt3oAgYfyKOE7zNw03sLovnfIiTVm8MFRckREob7m+b2k5EsmVPkGNRnna9aH85PBAq8kZ
	AnGuxHYQKHkuiI6UKyWhGH5lza3mbQGc6gHTBP/N6roPzSu89Qv7AiUi/3lVqg==
Date: Mon, 13 May 2024 09:15:13 +0200
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
Subject: Re: [PATCH v6 07/17] drm/vkms: Update pixels accessor to support
 packed and multi-plane formats.
Message-ID: <ZkG-AYWvyA1QOLHZ@localhost.localdomain>
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
 <20240409-yuv-v6-7-de1c5728fd70@bootlin.com>
 <20240422140757.576e363b.pekka.paalanen@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240422140757.576e363b.pekka.paalanen@collabora.com>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 22/04/24 - 14:07, Pekka Paalanen a écrit :
> On Tue, 09 Apr 2024 15:25:25 +0200
> Louis Chauvet <louis.chauvet@bootlin.com> wrote:
> 
> > Introduce the usage of block_h/block_w to compute the offset and the
> > pointer of a pixel. The previous implementation was specialized for
> > planes with block_h == block_w == 1. To avoid confusion and allow easier
> > implementation of tiled formats. It also remove the usage of the
> > deprecated format field `cpp`.
> > 
> > Introduce the plane_index parameter to get an offset/pointer on a
> > different plane.
> > 
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > ---
> >  drivers/gpu/drm/vkms/vkms_formats.c | 110 ++++++++++++++++++++++++++++--------
> >  1 file changed, 87 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> > index 69cf9733fec5..9a1400ad4db6 100644
> > --- a/drivers/gpu/drm/vkms/vkms_formats.c
> > +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> > @@ -10,22 +10,43 @@
> >  #include "vkms_formats.h"
> >  
> >  /**
> > - * pixel_offset() - Get the offset of the pixel at coordinates x/y in the first plane
> > + * packed_pixels_offset() - Get the offset of the block containing the pixel at coordinates x/y
> >   *
> >   * @frame_info: Buffer metadata
> >   * @x: The x coordinate of the wanted pixel in the buffer
> >   * @y: The y coordinate of the wanted pixel in the buffer
> > + * @plane_index: The index of the plane to use
> > + * @offset: The returned offset inside the buffer of the block
> > + * @rem_x,@rem_y: The returned coordinate of the requested pixel in the block
> >   *
> > - * The caller must ensure that the framebuffer associated with this request uses a pixel format
> > - * where block_h == block_w == 1.
> > - * If this requirement is not fulfilled, the resulting offset can point to an other pixel or
> > - * outside of the buffer.
> > + * As some pixel formats store multiple pixels in a block (DRM_FORMAT_R* for example), some
> > + * pixels are not individually addressable. This function return 3 values: the offset of the
> > + * whole block, and the coordinate of the requested pixel inside this block.
> > + * For example, if the format is DRM_FORMAT_R1 and the requested coordinate is 13,5, the offset
> > + * will point to the byte 5*pitches + 13/8 (second byte of the 5th line), and the rem_x/rem_y
> > + * coordinates will be (13 % 8, 5 % 1) = (5, 0)
> > + *
> > + * With this function, the caller just have to extract the correct pixel from the block.
> >   */
> > -static size_t pixel_offset(const struct vkms_frame_info *frame_info, int x, int y)
> > +static void packed_pixels_offset(const struct vkms_frame_info *frame_info, int x, int y,
> > +				 int plane_index, int *offset, int *rem_x, int *rem_y)
> >  {
> >  	struct drm_framebuffer *fb = frame_info->fb;
> > +	const struct drm_format_info *format = frame_info->fb->format;
> > +	/* Directly using x and y to multiply pitches and format->ccp is not sufficient because
> > +	 * in some formats a block can represent multiple pixels.
> > +	 *
> > +	 * Dividing x and y by the block size allows to extract the correct offset of the block
> > +	 * containing the pixel.
> > +	 */
> >  
> > -	return fb->offsets[0] + (y * fb->pitches[0]) + (x * fb->format->cpp[0]);
> > +	int block_x = x / drm_format_info_block_width(format, plane_index);
> > +	int block_y = y / drm_format_info_block_height(format, plane_index);
> > +	*rem_x = x % drm_format_info_block_width(format, plane_index);
> > +	*rem_y = y % drm_format_info_block_height(format, plane_index);
> > +	*offset = fb->offsets[plane_index] +
> > +		  block_y * fb->pitches[plane_index] +
> > +		  block_x * format->char_per_block[plane_index];
> 
> I started thinking... is
> 
> +		  block_y * fb->pitches[plane_index] +
> 
> correct, or should it be
> 
> +		  y * fb->pitches[plane_index] +
> 
> ?

The documentation is not very clear about that:

       	 * @pitches: Line stride per buffer. For userspace created object this
       	 * is copied from drm_mode_fb_cmd2.

If I look at the drm_mode_fb_cmd2, there is this documentation:

       	/** @pitches: Pitch (aka. stride) in bytes, one per plane. */

For me, I interpret "stride" as it is used in matrix calculation, where it
means "the number of bytes between two number adjacent verticaly"
(&matrix[x,y] + stride == &matrix[x,y+1]).

So in a graphic context, I interpret a stride as the number of byte to
reach the next line of blocks (as pixels can not always be accessed
individually).

So, for me, buffer_size_in_byte >= stride * number_of_lines.

> I'm looking at drm_format_info_min_pitch() which sounds like it should
> be the latter? Because of
>
>         return DIV_ROUND_UP_ULL((u64)buffer_width * info->char_per_block[plane],
>                             drm_format_info_block_width(info, plane) *
>                             drm_format_info_block_height(info, plane));
>
> in drm_format_info_min_pitch().

This function doesn't make sense to me. I can't understand how it could
work.

If I consider the X0L2 format, with block_h == block_w == 2,
char_per_block = 8, and a framebuffer of 1 * 10 pixels, the result of
drm_format_info_min_pitch is 2.

However, for this format and this framebuffer, I think the stride should
be at least 8 bytes (the buffer is "1 block width").

If pitch equals 2 (as suggested by the test), it implies that
height * pitch is not valid for calculating the minimum size of the buffer
(in our case, 10 * 2 = 20 bytes, but the minimum framebuffer size should
be 5 blocks * 8 bytes_per_block = 40 bytes). And I don't understand what
the 2 represents in this context.
Is it the number of pixels on a line (which is strange, because pitch 
should be in byte)? The width in byte of the first line, but by using the 
"byte per pixel" value (which make no sense when using block formats)?

If pitch equals 8 (as I would expect), height * pitch is not optimal (but
at least sufficient to contain the entire framebuffer), and height * pitch
/ block_h is optimal (which is logical, because height/block_h is the 
number of block per columns).

> Btw. maybe this should check that the result is not negative (e.g. due
> to overflow)? Or does that even work since signed overflow is undefined
> behavior (UB) and compilers may assume UB does not happen, causing the
> check to be eliminated as dead code?
>
> Otherwise this patch looks ok to me.
> 
> 
> Thanks,
> pq
> 

[...]

--
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

