Return-Path: <linux-kernel+bounces-384579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D863C9B2BE7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96F62282C74
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C441D1E64;
	Mon, 28 Oct 2024 09:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ABLOTn1Y"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6294A1922F2
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730109044; cv=none; b=NRDP6NoVuvctCD5I7HgjisaV6xbx3C0adL9Exs0M3JMbuZniBOjU7/SMRsmNVnhH2RNtUTsepz6TYyNMDyayi0xDlcumSGOfmiX49i79sCPhLy2nIqDH08ZBDcO6BJRWhQXs5PXIQ0xrWy96WZM0oxcbJ3hi2OyGbLeviAMJGw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730109044; c=relaxed/simple;
	bh=Tsx68bZb0UiHcFJeUU5I8O/Enb/NKEC47vguA28iaUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nICQ1tIqPjxGAmQEPR2kROwbbmUC4XiQNi+Cb6aZiGg0yN2de/JObpTsSooeQpTbPew9oXdyjqgF3vBLV5F/+oISwhEIxMnC+gBwgb1VLfam5YEkoAy4jcwnBt3ldx0TqH1YvoCIjz16Z7d9tvZnxK5iNylO14OwBgWtrshWNTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ABLOTn1Y; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7945660006;
	Mon, 28 Oct 2024 09:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730109039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nJZj7f4ZBrIqUobldUKIgUlLz0CxBnX/fhKydAPoS/g=;
	b=ABLOTn1YGbWxlImbh7jhrtivzUMWEuMNzEAZpxoMfkDuHbIuC8VjM/WniYheYB/EmVQcWg
	YJvFd0BcCxAjStl+6IjKL0DhrOFBFy9htH2xLRYYRU41hmiP9ijz/BX1Y4ZQ3tKwyKFFeB
	0vg1FsUCwbJQEvX5h+cXO/d8b7EClN6k4Clqhgx6tpM81fZpT7q2L8LpH416qnCqnCWQeb
	dNVgpIjtXqi9KiW9u51rIksYnqMWBe6yBAXS2RErYVxBkoOgNUbWClA1Hb745Iagq8nurj
	4FaItE56ahMjHmSVOBRZxW9vvBHQd7I+6C+FTO3zE68rDaQujCw+CDHBsYo4bA==
Date: Mon, 28 Oct 2024 10:50:36 +0100
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
	seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com,
	20241007-yuv-v12-0-01c1ada6fec8@bootlin.com
Subject: Re: [PATCH RESEND v2 1/8] drm/vkms: Create helpers macro to avoid
 code duplication in format callbacks
Message-ID: <Zx9ebBWZMKFIyyvf@fedora>
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
	seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com,
	20241007-yuv-v12-0-01c1ada6fec8@bootlin.com
References: <20241007-b4-new-color-formats-v2-0-d47da50d4674@bootlin.com>
 <20241007-b4-new-color-formats-v2-1-d47da50d4674@bootlin.com>
 <eaf964a9-e7ed-4851-a12e-0a23739b715e@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eaf964a9-e7ed-4851-a12e-0a23739b715e@riseup.net>
X-GND-Sasl: louis.chauvet@bootlin.com

On 26/10/24 - 11:58, Maíra Canal wrote:
> Hi Louis,
> 
> On 07/10/24 13:46, Louis Chauvet wrote:
> > The callback functions for line conversion are almost identical for
> > some format. The generic READ_LINE macro generate all the required
> > boilerplate to process a line.
> > 
> > Two overrides of this macro have been added to avoid duplication of
> > the same arguments every time.
> > 
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > ---
> >   drivers/gpu/drm/vkms/vkms_formats.c | 163 +++++++++++++-----------------------
> >   1 file changed, 58 insertions(+), 105 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> > index f9841b8000c4..8f1bcca38148 100644
> > --- a/drivers/gpu/drm/vkms/vkms_formats.c
> > +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> > @@ -292,6 +292,58 @@ VISIBLE_IF_KUNIT struct pixel_argb_u16 argb_u16_from_yuv888(u8 y, u8 channel_1,
> >   }
> >   EXPORT_SYMBOL_IF_KUNIT(argb_u16_from_yuv888);
> > +/**
> > + * READ_LINE() - Generic generator for a read_line function which can be used for format with one
> > + * plane and a block_h == block_w == 1.
> > + *
> > + * @function_name: Function name to generate
> > + * @pixel_name: temporary pixel name used in the @__VA_ARGS__ parameters
> > + * @pixel_type: Used to specify the type you want to cast the pixel pointer
> > + * @callback: Callback to call for each pixels. This fonction should take @__VA_ARGS__ as parameter
> > + *            and return a pixel_argb_u16
> > + * @__VA_ARGS__: Argument to pass inside the callback. You can use @pixel_name to access current
> > + *  pixel.
> > + */
> > +#define READ_LINE(function_name, pixel_name, pixel_type, callback, ...)				\
> > +static void function_name(const struct vkms_plane_state *plane, int x_start,			\
> > +			      int y_start, enum pixel_read_direction direction, int count,	\
> > +			      struct pixel_argb_u16 out_pixel[])				\
> > +{												\
> > +	struct pixel_argb_u16 *end = out_pixel + count;						\
> > +	int step = get_block_step_bytes(plane->frame_info->fb, direction, 0);			\
> > +	u8 *src_pixels;										\
> > +												\
> > +	packed_pixels_addr_1x1(plane->frame_info, x_start, y_start, 0, &src_pixels);		\
> > +												\
> > +	while (out_pixel < end) {								\
> > +		pixel_type *(pixel_name) = (pixel_type *)src_pixels;				\
> > +		*out_pixel = (callback)(__VA_ARGS__);						\
> > +		out_pixel += 1;									\
> > +		src_pixels += step;								\
> > +	}											\
> > +}
> > +
> > +/**
> > + * READ_LINE_ARGB8888() - Generic generator for ARGB8888 formats.
> > + * The pixel type used is u8, so pixel_name[0]..pixel_name[n] are the n components of the pixel.
> > + *
> > + * @function_name: Function name to generate
> > + * @pixel_name: temporary pixel to use in @a, @r, @g and @b parameters
> > + * @a, @r, @g, @b: value of each channel
> > + */
> > +#define READ_LINE_ARGB8888(function_name, pixel_name, a, r, g, b) \
> > +	READ_LINE(function_name, pixel_name, u8, argb_u16_from_u8888, a, r, g, b)
> > +/**
> > + * READ_LINE_ARGB16161616() - Generic generator for ARGB16161616 formats.
> > + * The pixel type used is u8, so pixel_name[0]..pixel_name[n] are the n components of the pixel.
> > + *
> > + * @function_name: Function name to generate
> > + * @pixel_name: temporary pixel to use in @a, @r, @g and @b parameters
> > + * @a, @r, @g, @b: value of each channel
> > + */
> > +#define READ_LINE_16161616(function_name, pixel_name, a, r, g, b) \
> > +	READ_LINE(function_name, pixel_name, u16, argb_u16_from_u16161616, a, r, g, b)
> > +
> >   /*
> >    * The following functions are read_line function for each pixel format supported by VKMS.
> >    *
> > @@ -378,118 +430,19 @@ static void R4_read_line(const struct vkms_plane_state *plane, int x_start,
> >   	Rx_read_line(plane, x_start, y_start, direction, count, out_pixel);
> >   }
> > -static void R8_read_line(const struct vkms_plane_state *plane, int x_start,
> > -			 int y_start, enum pixel_read_direction direction, int count,
> > -			 struct pixel_argb_u16 out_pixel[])
> > -{
> > -	struct pixel_argb_u16 *end = out_pixel + count;
> > -	u8 *src_pixels;
> > -	int step = get_block_step_bytes(plane->frame_info->fb, direction, 0);
> > -
> > -	packed_pixels_addr_1x1(plane->frame_info, x_start, y_start, 0, &src_pixels);
> > -
> > -	while (out_pixel < end) {
> > -		*out_pixel = argb_u16_from_gray8(*src_pixels);
> > -		src_pixels += step;
> > -		out_pixel += 1;
> > -	}
> > -}
> > -
> > -static void ARGB8888_read_line(const struct vkms_plane_state *plane, int x_start, int y_start,
> > -			       enum pixel_read_direction direction, int count,
> > -			       struct pixel_argb_u16 out_pixel[])
> > -{
> > -	struct pixel_argb_u16 *end = out_pixel + count;
> > -	u8 *src_pixels;
> > -
> > -	packed_pixels_addr_1x1(plane->frame_info, x_start, y_start, 0, &src_pixels);
> > -
> > -	int step = get_block_step_bytes(plane->frame_info->fb, direction, 0);
> > -
> > -	while (out_pixel < end) {
> > -		u8 *px = (u8 *)src_pixels;
> > -		*out_pixel = argb_u16_from_u8888(px[3], px[2], px[1], px[0]);
> > -		out_pixel += 1;
> > -		src_pixels += step;
> > -	}
> > -}
> > -
> > -static void XRGB8888_read_line(const struct vkms_plane_state *plane, int x_start, int y_start,
> > -			       enum pixel_read_direction direction, int count,
> > -			       struct pixel_argb_u16 out_pixel[])
> > -{
> > -	struct pixel_argb_u16 *end = out_pixel + count;
> > -	u8 *src_pixels;
> > -
> > -	packed_pixels_addr_1x1(plane->frame_info, x_start, y_start, 0, &src_pixels);
> > -
> > -	int step = get_block_step_bytes(plane->frame_info->fb, direction, 0);
> > -
> > -	while (out_pixel < end) {
> > -		u8 *px = (u8 *)src_pixels;
> > -		*out_pixel = argb_u16_from_u8888(255, px[2], px[1], px[0]);
> > -		out_pixel += 1;
> > -		src_pixels += step;
> > -	}
> > -}
> > -
> > -static void ARGB16161616_read_line(const struct vkms_plane_state *plane, int x_start,
> > -				   int y_start, enum pixel_read_direction direction, int count,
> > -				   struct pixel_argb_u16 out_pixel[])
> > -{
> > -	struct pixel_argb_u16 *end = out_pixel + count;
> > -	u8 *src_pixels;
> > -
> > -	packed_pixels_addr_1x1(plane->frame_info, x_start, y_start, 0, &src_pixels);
> > -
> > -	int step = get_block_step_bytes(plane->frame_info->fb, direction, 0);
> > -
> > -	while (out_pixel < end) {
> > -		u16 *px = (u16 *)src_pixels;
> > -		*out_pixel = argb_u16_from_u16161616(px[3], px[2], px[1], px[0]);
> > -		out_pixel += 1;
> > -		src_pixels += step;
> > -	}
> > -}
> > -
> > -static void XRGB16161616_read_line(const struct vkms_plane_state *plane, int x_start,
> > -				   int y_start, enum pixel_read_direction direction, int count,
> > -				   struct pixel_argb_u16 out_pixel[])
> > -{
> > -	struct pixel_argb_u16 *end = out_pixel + count;
> > -	u8 *src_pixels;
> > -
> > -	packed_pixels_addr_1x1(plane->frame_info, x_start, y_start, 0, &src_pixels);
> > -	int step = get_block_step_bytes(plane->frame_info->fb, direction, 0);
> > +READ_LINE_ARGB8888(XRGB8888_read_line, px, 255, px[2], px[1], px[0])
> > -	while (out_pixel < end) {
> > -		__le16 *px = (__le16 *)src_pixels;
> > -		*out_pixel = argb_u16_from_le16161616(cpu_to_le16(0xFFFF), px[2], px[1], px[0]);
> 
> I just compile the whole series and I saw the warning:
> 
> drivers/gpu/drm/vkms/vkms_formats.c:226:30: warning: unused function
> 'argb_u16_from_le16161616' [-Wunused-function]
>   226 | static struct pixel_argb_u16 argb_u16_from_le16161616(__le16 a,
> __le16 r, __le16 g, __le16 b)
>       |                              ^~~~~~~~~~~~~~~~~~~~~~~~
> 1 warning generated.

Thanks, I will fix it for the v2!

In addition I will also fix the missing le/be managment in the macro, 
thanks!

Thanks,
Louis Chauvet
 
> Best Regards,
> - Maíra
> 
> > -		out_pixel += 1;
> > -		src_pixels += step;
> > -	}
> > -}
> > +READ_LINE_ARGB8888(ARGB8888_read_line, px, px[3], px[2], px[1], px[0])
> > -static void RGB565_read_line(const struct vkms_plane_state *plane, int x_start,
> > -			     int y_start, enum pixel_read_direction direction, int count,
> > -			     struct pixel_argb_u16 out_pixel[])
> > -{
> > -	struct pixel_argb_u16 *end = out_pixel + count;
> > -	u8 *src_pixels;
> > -	packed_pixels_addr_1x1(plane->frame_info, x_start, y_start, 0, &src_pixels);
> > +READ_LINE_16161616(ARGB16161616_read_line, px, px[3], px[2], px[1], px[0]);
> > +READ_LINE_16161616(XRGB16161616_read_line, px, 0xFFFF, px[2], px[1], px[0]);
> > -	int step = get_block_step_bytes(plane->frame_info->fb, direction, 0);
> > +READ_LINE(RGB565_read_line, px, __le16, argb_u16_from_RGB565, px)
> > -	while (out_pixel < end) {
> > -		__le16 *px = (__le16 *)src_pixels;
> > +READ_LINE(R8_read_line, px, u8, argb_u16_from_gray8, *px)
> > -		*out_pixel = argb_u16_from_RGB565(px);
> > -		out_pixel += 1;
> > -		src_pixels += step;
> > -	}
> > -}
> >   /*
> >    * This callback can be used for YUV formats where U and V values are
> > 

