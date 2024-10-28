Return-Path: <linux-kernel+bounces-384577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B379B2BE3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C3A41F21A9E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F0D1CDA36;
	Mon, 28 Oct 2024 09:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bqMzkzhc"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722B018FDA5
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730109043; cv=none; b=MkszBbmSVoWq9xu8Wg/wgZxNTiyLl4eAHwksT/BPI8yYM/t+WGF3VIzUa6XHLF5JNK9kh9ytC+WjxtMf3RLtuv6xNwHO5JCzEfhXYhlGWqdmLNLot5gsnVmxj26fRJfYDrqFYz5XjowUf7N3lVIlSz4Vyznil0YSBnfBBM9BXvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730109043; c=relaxed/simple;
	bh=WagtCrwZ5DyShqDuJFktukVvJCjMqzUn/uvOVyfs04I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdHNM+ISNuEaFQarFwYh5YZwnpUe0L6LBOyX8v14TQCLvFfUYOXRtUEi57ANVmccrc12Dmh+SBVZhG6PZW1bu/i7OC2PNOkv61TAuYC4bEVTOh10hEYrsSVlKwQs5fhvG7tU6gIEn5QCa7u3xvX9IYecYZ3EES6YsLBFiwC47SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bqMzkzhc; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D544740005;
	Mon, 28 Oct 2024 09:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730109038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=78K+iLIzfiylCTrYyfF1jUhg5Pq48Ff6e2WXFMZxP6k=;
	b=bqMzkzhcf1yhJtGuCyLSQWwWohHxCC/yiVm1RLAtptYKFNEOOZBf1Sn6tWb3bGIY22fJsk
	AlFtJVLbdCRfZYDSU/AnlNODAmJ4yM7+p8OwOkiK0C4ri264mD4bk/BaB1BqwejdV8GbLf
	HUS3vdbfneTyDOCiEYUIA40OcSVdr62F96xZu8+F5tBgM4bRCxQlA30RggB5JhyxooyP+t
	IJ+w6jW01iJbdDrIoAMF2ELzUDb7AmYEhBqqBr+pfzxoXaQS1MuxSrDuUluJSQ9/pv1EWw
	hn7gS9/ltbBACzCchjFffoer1MeCTNwsy0KOFjqtfcShJRg6G6fvjNvBSrsFqQ==
Date: Mon, 28 Oct 2024 10:50:36 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: =?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	arthurgrillo@riseup.net, linux-kernel@vger.kernel.org,
	jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
	thomas.petazzoni@bootlin.com, seanpaul@google.com,
	nicolejadeyee@google.com
Subject: Re: [PATCH v2 2/3] drm/vkms: Add a macro for write_line functions
Message-ID: <Zx9ebKnJF6_vL4i9@fedora>
Mail-Followup-To: =?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	arthurgrillo@riseup.net, linux-kernel@vger.kernel.org,
	jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
	thomas.petazzoni@bootlin.com, seanpaul@google.com,
	nicolejadeyee@google.com
References: <20240814-writeback_line_by_line-v2-0-36541c717569@bootlin.com>
 <20240814-writeback_line_by_line-v2-2-36541c717569@bootlin.com>
 <2af1f9b4-0bc8-4585-ba13-d3b97e25845f@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2af1f9b4-0bc8-4585-ba13-d3b97e25845f@riseup.net>
X-GND-Sasl: louis.chauvet@bootlin.com

On 26/10/24 - 12:08, Maíra Canal wrote:
> Hi Louis,
> 
> On 14/08/24 05:42, Louis Chauvet wrote:
> > As stated in [2], the write_line functions are very similar and force code
> 
> Where is [2]?
> 
> > duplication. This patch add a macro to avoid code repetition.
> > 
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > ---
> >   drivers/gpu/drm/vkms/vkms_formats.c | 107 ++++++++++--------------------------
> >   1 file changed, 30 insertions(+), 77 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> > index d1309f6d307f..a25cdf656d8a 100644
> > --- a/drivers/gpu/drm/vkms/vkms_formats.c
> > +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> > @@ -654,6 +654,31 @@ static void argb_u16_to_RGB565(u8 *out_pixel, const struct pixel_argb_u16 *in_pi
> >   	*pixel = cpu_to_le16(r << 11 | g << 5 | b);
> >   }
> > +/**
> > + * WRITE_LINE() - Generic generator for write_line functions
> > + *
> > + * This generator can only be used for format with only one plane and block_w == block_h == 1
> > + *
> > + * @function_name: Name to use for the generated function
> > + * @conversion_function: Fonction to use for the conversion from argb_u16 to the required format.
> 
> s/Fonction/Function
> 
> > + */
> > +#define WRITE_LINE(function_name, conversion_function)					\
> > +static void function_name(struct vkms_writeback_job *wb,				\
> > +			  struct pixel_argb_u16 *src_pixels, int count, int x_start,	\
> > +			  int y_start)							\
> > +{											\
> > +	u8 *dst_pixels;									\
> > +											\
> > +	packed_pixels_addr_1x1(&wb->wb_frame_info, x_start, y_start, 0, &dst_pixels);	\
> > +											\
> > +	while (count) {									\
> > +		(conversion_function)(dst_pixels, src_pixels);				\
> > +		dst_pixels += wb->wb_frame_info.fb->format->char_per_block[0];		\
> > +		src_pixels += 1;							\
> > +		count--;								\
> 
> Just a nit: What do you think about this loop?
> 
> for (; count > 0; src_pixels++, count--)
> 
> It doesn't really matter what option you pick.

I take this version, a bit shorter and not less explicit, thanks!

Thanks,
Louis Chauvet
 
> Best Regards,
> - Maíra
> 
> > +	}										\
> > +}
> > +
> >   /*
> >    * The following functions are write_line function for each pixel format supported by VKMS.
> >    *
> > @@ -667,85 +692,13 @@ static void argb_u16_to_RGB565(u8 *out_pixel, const struct pixel_argb_u16 *in_pi
> >    * [1]: https://lore.kernel.org/dri-devel/d258c8dc-78e9-4509-9037-a98f7f33b3a3@riseup.net/
> >    */
> > -static void ARGB8888_write_line(struct vkms_writeback_job *wb,
> > -				struct pixel_argb_u16 *src_pixels, int count, int x_start,
> > -				int y_start)
> > -{
> > -	u8 *dst_pixels;
> > +WRITE_LINE(ARGB8888_write_line, argb_u16_to_ARGB8888)
> > +WRITE_LINE(XRGB8888_write_line, argb_u16_to_XRGB8888)
> > -	packed_pixels_addr_1x1(&wb->wb_frame_info, x_start, y_start, 0, &dst_pixels);
> > +WRITE_LINE(ARGB16161616_write_line, argb_u16_to_ARGB16161616)
> > +WRITE_LINE(XRGB16161616_write_line, argb_u16_to_XRGB16161616)
> > -	while (count) {
> > -		argb_u16_to_ARGB8888(dst_pixels, src_pixels);
> > -		dst_pixels += wb->wb_frame_info.fb->format->char_per_block[0];
> > -		src_pixels += 1;
> > -		count--;
> > -	}
> > -}
> > -
> > -static void XRGB8888_write_line(struct vkms_writeback_job *wb,
> > -				struct pixel_argb_u16 *src_pixels, int count, int x_start,
> > -				int y_start)
> > -{
> > -	u8 *dst_pixels;
> > -
> > -	packed_pixels_addr_1x1(&wb->wb_frame_info, x_start, y_start, 0, &dst_pixels);
> > -
> > -	while (count) {
> > -		argb_u16_to_XRGB8888(dst_pixels, src_pixels);
> > -		dst_pixels += wb->wb_frame_info.fb->format->char_per_block[0];
> > -		src_pixels += 1;
> > -		count--;
> > -	}
> > -}
> > -
> > -static void ARGB16161616_write_line(struct vkms_writeback_job *wb,
> > -				    struct pixel_argb_u16 *src_pixels, int count, int x_start,
> > -				    int y_start)
> > -{
> > -	u8 *dst_pixels;
> > -
> > -	packed_pixels_addr_1x1(&wb->wb_frame_info, x_start, y_start, 0, &dst_pixels);
> > -
> > -	while (count) {
> > -		argb_u16_to_ARGB16161616(dst_pixels, src_pixels);
> > -		dst_pixels += wb->wb_frame_info.fb->format->char_per_block[0];
> > -		src_pixels += 1;
> > -		count--;
> > -	}
> > -}
> > -
> > -static void XRGB16161616_write_line(struct vkms_writeback_job *wb,
> > -				    struct pixel_argb_u16 *src_pixels, int count, int x_start,
> > -				    int y_start)
> > -{
> > -	u8 *dst_pixels;
> > -
> > -	packed_pixels_addr_1x1(&wb->wb_frame_info, x_start, y_start, 0, &dst_pixels);
> > -
> > -	while (count) {
> > -		argb_u16_to_XRGB16161616(dst_pixels, src_pixels);
> > -		dst_pixels += wb->wb_frame_info.fb->format->char_per_block[0];
> > -		src_pixels += 1;
> > -		count--;
> > -	}
> > -}
> > -
> > -static void RGB565_write_line(struct vkms_writeback_job *wb,
> > -			      struct pixel_argb_u16 *src_pixels, int count, int x_start,
> > -			      int y_start)
> > -{
> > -	u8 *dst_pixels;
> > -
> > -	packed_pixels_addr_1x1(&wb->wb_frame_info, x_start, y_start, 0, &dst_pixels);
> > -
> > -	while (count) {
> > -		argb_u16_to_RGB565(dst_pixels, src_pixels);
> > -		dst_pixels += wb->wb_frame_info.fb->format->char_per_block[0];
> > -		src_pixels += 1;
> > -		count--;
> > -	}
> > -}
> > +WRITE_LINE(RGB565_write_line, argb_u16_to_RGB565)
> >   /**
> >    * get_pixel_read_function() - Retrieve the correct read_line function for a specific
> > 

