Return-Path: <linux-kernel+bounces-384591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B32809B2C04
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D65711C21F24
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440171DA0ED;
	Mon, 28 Oct 2024 09:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KJYtdqqW"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB591D1302
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730109058; cv=none; b=lrWrYJkj8LaC9n3/oAVkbsFXlpxiOoUPJfL0T2Hr8MxJU1KXAxl+g3+l5ZHXQTNTcZktYX8GYIUgr1MPB3eomkZM8+/s9UOjor2G4N4rAO5OCz+VL1BvVWuElm1PBCg3fIC2m3W+tivJYoJZYMsmEtxNCOJEgoEwht3b2nfW6+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730109058; c=relaxed/simple;
	bh=pEpLQyOtqsi2BE3Zwt7IXabIsc/i0fnuQ1kzKBJIYIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djIxw+7b3boQ0cFl9hSel1rVHq0jCw7ux4eZSIwF9lu0CccI4TATum4dSX4AHZzZRdgh15CQrdIPymxJGwjyoljQwsERoAgDvNle3L9pegDKFtStQkxVYDi4CU7IjRzHXTsx7jcg3xGQBjauoh5gZB2TtzGST7KB2/6csB8jRTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KJYtdqqW; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 7A015C24A3
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:50:48 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 20C59C0008;
	Mon, 28 Oct 2024 09:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730109041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7fe/FH3bSXs2d9VlwNT8lNakpyNbunni3I361WgJSR4=;
	b=KJYtdqqWi6McbqL6m43h2XEi5KaAbT5fKIYEzjCVrXX9Sx25BOqgaM1ilPKxAUZ5apG9Jc
	UNYESFq7bK8q1igDTv/09ksGU82e9e8dJ2k63wpP1ALjEEjkbyVciDRy0kJaH2TjxASKhR
	ZWjGYqIdbuo4U1whl36Zhs8dNw1AIgkhnM4cYauMIUAClJfhVU34L8Ok25dSicgrruuZx6
	6bpnMSAmy9D0k0M4AU8x5gpY1p0h7awzbOHBmtR8YWSEA/H7izfevweFpyVIccg9TdwlgR
	Hnpd/WMB2DTzF0Nfnsa8j5vE4JZDOnO5FYJrX/btx/Wr0YIjKnPcbQP+LBkuGQ==
Date: Mon, 28 Oct 2024 10:50:38 +0100
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
Message-ID: <Zx9ebhtU9XjJIAk6@fedora>
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
 <0b595d86-dbb5-43ae-9eb4-5f611013f6e8@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b595d86-dbb5-43ae-9eb4-5f611013f6e8@riseup.net>
X-GND-Sasl: louis.chauvet@bootlin.com

On 26/10/24 - 11:29, Maíra Canal wrote:
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
> > + * @function_name: Function name to generate > + * @pixel_name: temporary pixel name used in the @__VA_ARGS__ parameters
> 
> s/temporary/Temporary
> 
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
> 
> s/u8/u16

Thanks,
Louis Chauvet
 
> Best Regard,
> - Maíra
> 
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

