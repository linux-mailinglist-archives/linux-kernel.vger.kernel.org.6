Return-Path: <linux-kernel+bounces-414480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D84309D28BB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9870A281609
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B921CF293;
	Tue, 19 Nov 2024 14:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRd3yB3i"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877BB1CCB35;
	Tue, 19 Nov 2024 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732028335; cv=none; b=WhYbbco0xS53jOhUiQB0vIXFE+7hmvHdTghm9Yyz7F2IrPLJKMr62gQSwih5snsXGpsmUAhHXELoDfQaURS+9GL88fd9hTElm7mx3X74jp/1EQU5VowTtBv8QMwD3xzIemR1D2HBkfrLP7ndG4cKKN/GzSfeg6imAX43W3TpTdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732028335; c=relaxed/simple;
	bh=AQMu8D1A2u8JvQlfcU0JczQ4h3v2dbmioohcLetdP6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tq+coHWA2kePx6/mQeSuMp7PE4cDBDeanonaHNzIb22erFjB696xb1dBB0uRzGrYHZCBtrhIP+4iiafvezJ1f+kXg11L6oP6/jHydb6slmwG9lg6jXjzdUbpiFmcWjQ4GggVvi1p31wY5xyGUYoDW4ef8rQa4WKo+GlyVVEY01Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRd3yB3i; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-431616c23b5so32136845e9.0;
        Tue, 19 Nov 2024 06:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732028332; x=1732633132; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OWnh+ld6zzccC8isWLhmhYDmo6LpVTBN+zj+tQ13tHg=;
        b=VRd3yB3i3GolsGjDVg2pQIag6Nw5nundUgOA4sOlQzysHswOlZEiDGA4muXdLNqeye
         tQG2/7zoQiMTJ73JDTRUCbCT9gRC31G6TNzNLSGogpuTVT0QJzYyc+uqWPpCQduvtnZ+
         A3JrIa08IjdJxczOMjFL0sjkrdVw0ZMfK6Kz6wbuE7cikHt/+eTknepRpa9vaFBbBuDF
         F4vMJxQynODRWvjHZLtMxKQhETUO/zc+kX/O3kevFATZB7ZqohjgEzjKBDuWxbJQXUZi
         aGR5IksctAiDEHFzh2peKaxCtTV5fLEDg4UigGVE4EZ/vijNPLvWiJh3F7KL3xGio6IK
         cbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732028332; x=1732633132;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OWnh+ld6zzccC8isWLhmhYDmo6LpVTBN+zj+tQ13tHg=;
        b=FLMrAfd4KUbqVJ7esWph5P/7UY+WPJqftl8H+7qr9Vp1Sf11R8xb00cTZhJ882s3VM
         L3N3U1IaPCzTFU+KgpgH7O+KP83KpoII7CIAUHi6/3LxeZgl96e6FJa3O6CmQmlYMBpC
         1ILvRDNfOr93KX27DRTRJerJxi3jT45b1E2ynlE0JiCwkCPSw4Dfh/LPN78tzcx0Chox
         yUPY20iiA1b4c5SpEsW5B0vbQBmY7hTgOhKiHMUbj7gGHWwYnc1/7x6v5DnLf9MZvB+N
         kJyONR2UqaAhJVCoWhobC2UevYJ7IMM9E+KNlVV49nOGYVLE0f7FniE/hDJ3nf/3FAjM
         x2iw==
X-Forwarded-Encrypted: i=1; AJvYcCVf34ZR7J6KjiVEqXrkxdibiW6s07XPCagLGjjI0fxRrTVy/heTEToyso0jPxNjEcbWrrQw9EKJUnc=@vger.kernel.org, AJvYcCX+HvkdnHQxskLCu9wn+oROKoEx6w3W1eesiI8SsIhdoT4ysz+3h2FitkB0Rk4PS7gLV/9+uyh18okZ3Lkj@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4vmmvpzbwBaN+b5a/nJyxKLxOc+eOBKqZIg+DKlE1E7PFZjms
	UwxDmhws/PqiNe7uB+VoF2mrRN+qjZBryCmElXhvKzjQMWuY+Ino
X-Google-Smtp-Source: AGHT+IH2igfHOVrUcwm15I+fRdARSXaJ9scT/icVaqEvzm4ixqZPt1r7D2xXlWpCKacfeYnL+qEhcw==
X-Received: by 2002:a05:600c:58cb:b0:431:15f1:421d with SMTP id 5b1f17b1804b1-432f57fba53mr30841035e9.16.1732028331385;
        Tue, 19 Nov 2024 06:58:51 -0800 (PST)
Received: from fedora ([213.94.25.69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da265907sm204858065e9.13.2024.11.19.06.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 06:58:50 -0800 (PST)
Date: Tue, 19 Nov 2024 15:58:49 +0100
From: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: airlied@gmail.com, arthurgrillo@riseup.net, corbet@lwn.net,
	dri-devel@lists.freedesktop.org, hamohammed.sa@gmail.com,
	helen.koike@collabora.com, jeremie.dautheribes@bootlin.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com, mairacanal@riseup.net,
	marcheu@google.com, melissa.srw@gmail.com,
	miquel.raynal@bootlin.com, mripard@kernel.org,
	nicolejadeyee@google.com, pekka.paalanen@haloniitty.fi,
	rdunlap@infradead.org, rodrigosiqueiramelo@gmail.com,
	seanpaul@google.com, simona.vetter@ffwll.ch, simona@ffwll.ch,
	thomas.petazzoni@bootlin.com, tzimmermann@suse.de
Subject: Re: [PATCH v13 5/9] drm/vkms: Update pixels accessor to support
 packed and multi-plane formats.
Message-ID: <ZzynqW4NNheEE8_L@fedora>
References: <20241031-yuv-v13-5-bd5463126faa@bootlin.com>
 <20241118171037.2847-1-jose.exposito89@gmail.com>
 <Zzt2l0hZpKp4mniY@louis-chauvet-laptop>
 <Zzt4PiTRqwmikMnm@fedora>
 <Zzt64tbs3TZ-7nUo@louis-chauvet-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zzt64tbs3TZ-7nUo@louis-chauvet-laptop>

On Mon, Nov 18, 2024 at 06:35:30PM +0100, Louis Chauvet wrote:
> On 18/11/24 - 18:24, José Expósito wrote:
> > On Mon, Nov 18, 2024 at 06:17:11PM +0100, Louis Chauvet wrote:
> > > On 18/11/24 - 18:10, José Expósito wrote:
> > > > > Introduce the usage of block_h/block_w to compute the offset and the
> > > > > pointer of a pixel. The previous implementation was specialized for
> > > > > planes with block_h == block_w == 1. To avoid confusion and allow easier
> > > > > implementation of tiled formats. It also remove the usage of the
> > > > > deprecated format field `cpp`.
> > > > > 
> > > > > Introduce the plane_index parameter to get an offset/pointer on a
> > > > > different plane.
> > > > > 
> > > > > Acked-by: Maíra Canal <mairacanal@riseup.net>
> > > > > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > > > > ---
> > > > >  drivers/gpu/drm/vkms/vkms_formats.c | 114 ++++++++++++++++++++++++++++--------
> > > > >  1 file changed, 91 insertions(+), 23 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> > > > > index 06aef5162529..7f932d42394d 100644
> > > > > --- a/drivers/gpu/drm/vkms/vkms_formats.c
> > > > > +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> > > > > @@ -10,22 +10,46 @@
> > > > >  #include "vkms_formats.h"
> > > > >  
> > > > >  /**
> > > > > - * pixel_offset() - Get the offset of the pixel at coordinates x/y in the first plane
> > > > > + * packed_pixels_offset() - Get the offset of the block containing the pixel at coordinates x/y
> > > > >   *
> > > > >   * @frame_info: Buffer metadata
> > > > >   * @x: The x coordinate of the wanted pixel in the buffer
> > > > >   * @y: The y coordinate of the wanted pixel in the buffer
> > > > > + * @plane_index: The index of the plane to use
> > > > > + * @offset: The returned offset inside the buffer of the block
> > > > 
> > > > The previous function (pixel_offset) returned a size_t for the offset rather
> > > > than an int. Do you know if we are safe using an int in this case?
> > > 
> > > I think I used int everywhere because it may avoid strange issues with 
> > > implicit casting and negative number. I don't remember exactly where, but 
> > > Pekka suggested it.
> > 
> > Ah! Good to know. For the record, I ran locally the IGT tests and
> > perform some manual testing and I found no issues.
> > 
> > > > > + * @rem_x: The returned X coordinate of the requested pixel in the block
> > > > > + * @rem_y: The returned Y coordinate of the requested pixel in the block
> > > > >   *
> > > > > - * The caller must ensure that the framebuffer associated with this request uses a pixel format
> > > > > - * where block_h == block_w == 1.
> > > > > - * If this requirement is not fulfilled, the resulting offset can point to an other pixel or
> > > > > - * outside of the buffer.
> > > > > + * As some pixel formats store multiple pixels in a block (DRM_FORMAT_R* for example), some
> > > > > + * pixels are not individually addressable. This function return 3 values: the offset of the
> > > > > + * whole block, and the coordinate of the requested pixel inside this block.
> > > > > + * For example, if the format is DRM_FORMAT_R1 and the requested coordinate is 13,5, the offset
> > > > > + * will point to the byte 5*pitches + 13/8 (second byte of the 5th line), and the rem_x/rem_y
> > > > > + * coordinates will be (13 % 8, 5 % 1) = (5, 0)
> > > > > + *
> > > > > + * With this function, the caller just have to extract the correct pixel from the block.
> > > > >   */
> > > > > -static size_t pixel_offset(const struct vkms_frame_info *frame_info, int x, int y)
> > > > > +static void packed_pixels_offset(const struct vkms_frame_info *frame_info, int x, int y,
> > > > > +				 int plane_index, int *offset, int *rem_x, int *rem_y)
> > > > >  {
> > > > >  	struct drm_framebuffer *fb = frame_info->fb;
> > > > > +	const struct drm_format_info *format = frame_info->fb->format;
> > > > > +	/* Directly using x and y to multiply pitches and format->ccp is not sufficient because
> > > > > +	 * in some formats a block can represent multiple pixels.
> > > > > +	 *
> > > > > +	 * Dividing x and y by the block size allows to extract the correct offset of the block
> > > > > +	 * containing the pixel.
> > > > > +	 */
> > > > >  
> > > > > -	return fb->offsets[0] + (y * fb->pitches[0]) + (x * fb->format->cpp[0]);
> > > > > +	int block_x = x / drm_format_info_block_width(format, plane_index);
> > > > > +	int block_y = y / drm_format_info_block_height(format, plane_index);
> > > > > +	int block_pitch = fb->pitches[plane_index] * drm_format_info_block_height(format,
> > > > > +										  plane_index);
> > > > > +	*rem_x = x % drm_format_info_block_width(format, plane_index);
> > > > > +	*rem_y = y % drm_format_info_block_height(format, plane_index);
> > > > > +	*offset = fb->offsets[plane_index] +
> > > > > +		  block_y * block_pitch +
> > > > > +		  block_x * format->char_per_block[plane_index];
> > > > >  }
> > > > >  
> > > > >  /**
> > > > > @@ -35,30 +59,71 @@ static size_t pixel_offset(const struct vkms_frame_info *frame_info, int x, int
> > > > >   * @frame_info: Buffer metadata
> > > > >   * @x: The x (width) coordinate inside the plane
> > > > >   * @y: The y (height) coordinate inside the plane
> > > > > + * @plane_index: The index of the plane
> > > > > + * @addr: The returned pointer
> > > > > + * @rem_x: The returned X coordinate of the requested pixel in the block
> > > > > + * @rem_y: The returned Y coordinate of the requested pixel in the block
> > > > >   *
> > > > > - * Takes the information stored in the frame_info, a pair of coordinates, and
> > > > > - * returns the address of the first color channel.
> > > > > - * This function assumes the channels are packed together, i.e. a color channel
> > > > > - * comes immediately after another in the memory. And therefore, this function
> > > > > - * doesn't work for YUV with chroma subsampling (e.g. YUV420 and NV21).
> > > > > + * Takes the information stored in the frame_info, a pair of coordinates, and returns the address
> > > > > + * of the block containing this pixel and the pixel position inside this block.
> > > > >   *
> > > > > - * The caller must ensure that the framebuffer associated with this request uses a pixel format
> > > > > - * where block_h == block_w == 1, otherwise the returned pointer can be outside the buffer.
> > > > > + * See @packed_pixel_offset for details about rem_x/rem_y behavior.
> > > > 
> > > > Missing "s" in the name of the function. Should read "@packed_pixels_offset".
> > > 
> > > Thanks!
> > > 
> > > > >   */
> > > > > -static void *packed_pixels_addr(const struct vkms_frame_info *frame_info,
> > > > > -				int x, int y)
> > > > > +static void packed_pixels_addr(const struct vkms_frame_info *frame_info,
> > > > > +			       int x, int y, int plane_index, u8 **addr, int *rem_x,
> > > > > +			       int *rem_y)
> > > > >  {
> > > > > -	size_t offset = pixel_offset(frame_info, x, y);
> > > > > +	int offset;
> > > > >  
> > > > > -	return (u8 *)frame_info->map[0].vaddr + offset;
> > > > > +	packed_pixels_offset(frame_info, x, y, plane_index, &offset, rem_x, rem_y);
> > > > > +	*addr = (u8 *)frame_info->map[0].vaddr + offset;
> > > > >  }
> > > > >  
> > > > > -static void *get_packed_src_addr(const struct vkms_frame_info *frame_info, int y)
> > > > > +/**
> > > > > + * packed_pixels_addr_1x1() - Get the pointer to the block containing the pixel at the given
> > > > > + * coordinates
> > > > > + *
> > > > > + * @frame_info: Buffer metadata
> > > > > + * @x: The x (width) coordinate inside the plane
> > > > > + * @y: The y (height) coordinate inside the plane
> > > > > + * @plane_index: The index of the plane
> > > > > + * @addr: The returned pointer
> > > > > + *
> > > > > + * This function can only be used with format where block_h == block_w == 1.
> > > > > + */
> > > > > +static void packed_pixels_addr_1x1(const struct vkms_frame_info *frame_info,
> > > > > +				   int x, int y, int plane_index, u8 **addr)
> > > > > +{
> > > > > +	int offset, rem_x, rem_y;
> > > > 
> > > > Nitpick, but it'd be nice if packed_pixels_offset() could take NULLs in
> > > > the output values so we avoid declaring unused variables here and when
> > > > calling packed_pixels_addr().
> > > 
> > > It is not a trivial change, and as I want this series to be merged I will 
> > > send the v14 without it. But if I have the time I will send a new 
> > > patch/series with this cleanup, thanks for the suggestion.
> > 
> > That works for me, we can always fix it in a follow up... Specially since
> > 2 other series depend on this one :)
> 
> As the series is completly reviewed/acked, how long do I need to 
> wait after the v14 before commiting on drm-misc-next? I plan to send the 
> v14 today/tomorrow morning with your changes.

Thanks for sending v14, I checked very quickly the patches and my sugestions
were fixed.

I can't answer this question, but all patches have been reviewed/tested by at
least 2 people, plus you are the only maintainer of the driver now.
I think that, if in a few days there are no complains, this series should be
ready to be merged.

Maybe Maíra, as the previous maintainer, can give you some advice. I have
never maintained a driver, so I'm not sure what are the best practices.

Jose

> Thanks,
> Louis Chauvet
>  
> > Jose
> >  
> > > > > +
> > > > > +	WARN_ONCE(drm_format_info_block_width(frame_info->fb->format,
> > > > > +					      plane_index) != 1,
> > > > > +		"%s() only support formats with block_w == 1", __func__);
> > > > > +	WARN_ONCE(drm_format_info_block_height(frame_info->fb->format,
> > > > > +					       plane_index) != 1,
> > > > > +		"%s() only support formats with block_h == 1", __func__);
> > > > > +
> > > > > +	packed_pixels_offset(frame_info, x, y, plane_index, &offset, &rem_x,
> > > > > +			     &rem_y);
> > > > > +	*addr = (u8 *)frame_info->map[0].vaddr + offset;
> > > > > +}
> > > > > +
> > > > > +static void *get_packed_src_addr(const struct vkms_frame_info *frame_info, int y,
> > > > > +				 int plane_index)
> > > > >  {
> > > > >  	int x_src = frame_info->src.x1 >> 16;
> > > > >  	int y_src = y - frame_info->rotated.y1 + (frame_info->src.y1 >> 16);
> > > > > +	u8 *addr;
> > > > > +	int rem_x, rem_y;
> > > > > +
> > > > > +	WARN_ONCE(drm_format_info_block_width(frame_info->fb->format, plane_index) != 1,
> > > > > +		  "%s() only support formats with block_w == 1", __func__);
> > > > > +	WARN_ONCE(drm_format_info_block_height(frame_info->fb->format, plane_index) != 1,
> > > > > +		  "%s() only support formats with block_h == 1", __func__);
> > > > >  
> > > > > -	return packed_pixels_addr(frame_info, x_src, y_src);
> > > > > +	packed_pixels_addr(frame_info, x_src, y_src, plane_index, &addr, &rem_x, &rem_y);
> > > > > +
> > > > > +	return addr;
> > > > >  }
> > > > >  
> > > > >  static int get_x_position(const struct vkms_frame_info *frame_info, int limit, int x)
> > > > > @@ -152,14 +217,14 @@ void vkms_compose_row(struct line_buffer *stage_buffer, struct vkms_plane_state
> > > > >  {
> > > > >  	struct pixel_argb_u16 *out_pixels = stage_buffer->pixels;
> > > > >  	struct vkms_frame_info *frame_info = plane->frame_info;
> > > > > -	u8 *src_pixels = get_packed_src_addr(frame_info, y);
> > > > > +	u8 *src_pixels = get_packed_src_addr(frame_info, y, 0);
> > > > >  	int limit = min_t(size_t, drm_rect_width(&frame_info->dst), stage_buffer->n_pixels);
> > > > >  
> > > > >  	for (size_t x = 0; x < limit; x++, src_pixels += frame_info->fb->format->cpp[0]) {
> > > > >  		int x_pos = get_x_position(frame_info, limit, x);
> > > > >  
> > > > >  		if (drm_rotation_90_or_270(frame_info->rotation))
> > > > > -			src_pixels = get_packed_src_addr(frame_info, x + frame_info->rotated.y1)
> > > > > +			src_pixels = get_packed_src_addr(frame_info, x + frame_info->rotated.y1, 0)
> > > > >  				+ frame_info->fb->format->cpp[0] * y;
> > > > >  
> > > > >  		plane->pixel_read(src_pixels, &out_pixels[x_pos]);
> > > > > @@ -250,7 +315,10 @@ void vkms_writeback_row(struct vkms_writeback_job *wb,
> > > > >  {
> > > > >  	struct vkms_frame_info *frame_info = &wb->wb_frame_info;
> > > > >  	int x_dst = frame_info->dst.x1;
> > > > > -	u8 *dst_pixels = packed_pixels_addr(frame_info, x_dst, y);
> > > > > +	u8 *dst_pixels;
> > > > > +	int rem_x, rem_y;
> > > > > +
> > > > > +	packed_pixels_addr(frame_info, x_dst, y, 0, &dst_pixels, &rem_x, &rem_y);
> > > > >  	struct pixel_argb_u16 *in_pixels = src_buffer->pixels;
> > > > >  	int x_limit = min_t(size_t, drm_rect_width(&frame_info->dst), src_buffer->n_pixels);
> > > > >  
> > > > > 

