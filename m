Return-Path: <linux-kernel+bounces-251531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDB89305F6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 16:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DEC61F21D4C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 14:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053AE13049E;
	Sat, 13 Jul 2024 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="LEnr1jW5"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C769130487
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720881570; cv=none; b=Utn9CUdEXiG+YfDjd+sM4j0lKF11MgpOeJAYRRohydDJQV05SkTzdAMnfJkGZlI4OtI+sUOwwL7HiLQe1f6SlxZhcAcl0BdJYS4N8v5g4mueHa7qblHpD9NK+VZm9Mlp811r9xr2aaifjcqaN+NDYVDYpeLZcMkcqhLrrqBIv04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720881570; c=relaxed/simple;
	bh=hSL3ylWhrWWrbzCCfdGj8HpUINustjf4DWUCp8WizN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J6IxcVBbD7T/4UXq11uplbTj+igHzWFXkF5P7qWirOLS2Ka7BOpmsHxiB/GdBUe1WV1QrWGH0VBF2Zlc6Umif9X3ACrITY02D+aBpndsmhEk3CNnXKjWZJscljAuU4pR2BP40SiZ6yqaFVH69fqHqa2KuDojetwfg1K3Uvwl6Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=LEnr1jW5; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kV+SSyx+9HJELw34ZnUa/2cDqZg4Fggj08sK9vje9Ew=; b=LEnr1jW5mEVF3O4z4mUUVdO3cS
	NY80vy6KWenKZxc3CYNWYNXWhn4YKLKbtkS/XuiTUIiwQntL0w41HbwlrXzTAiKdmiCd99CN18lYz
	Zr4hKR8CWWyGvMwGlGdPNw0bTmbL1SxZRVsVMf4rTSUd2DKY06ymdNJEXfIYKjZ7ddLmuyPDcDAMU
	u85tT5yO1sWp3etKRbqPxynOBDPml/tBYeZqAfKLNuvv8BC+K6edeI6NuT+oJwzrk+04vB3ajZdI5
	WZ+hyNp6liKltlQBT6iDFqk4u2XTxCDowk9p5rym8pXjI15PwC2BmQaPrFmUlvrPpeY3Lcm04g+eP
	WFDlWzsw==;
Received: from [187.36.213.55] (helo=[192.168.1.212])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sSdtp-00EkZA-1H; Sat, 13 Jul 2024 16:38:57 +0200
Message-ID: <99be1782-0235-4418-adbf-cd80d8b28d7a@igalia.com>
Date: Sat, 13 Jul 2024 11:38:47 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/17] drm/vkms: Add typedef and documentation for
 pixel_read and pixel_write functions
To: Louis Chauvet <louis.chauvet@bootlin.com>,
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, rdunlap@infradead.org,
 arthurgrillo@riseup.net, Jonathan Corbet <corbet@lwn.net>,
 pekka.paalanen@haloniitty.fi
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
 thomas.petazzoni@bootlin.com, seanpaul@google.com, marcheu@google.com,
 nicolejadeyee@google.com, Pekka Paalanen <pekka.paalanen@collabora.com>
References: <20240516-yuv-v8-0-cf8d6f86430e@bootlin.com>
 <20240516-yuv-v8-4-cf8d6f86430e@bootlin.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Autocrypt: addr=mcanal@igalia.com; keydata=
 xjMEZIsaeRYJKwYBBAHaRw8BAQdAGU6aY8oojw61KS5rGGMrlcilFqR6p6ID45IZ6ovX0h3N
 H01haXJhIENhbmFsIDxtY2FuYWxAaWdhbGlhLmNvbT7CjwQTFggANxYhBDMCqFtIvFKVRJZQ
 hDSPnHLaGFVuBQJkixp5BQkFo5qAAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQNI+cctoYVW5u
 GAEAwpaC5rI3wD8zqETKwGVoXd6+AbmGfZuVD40xepy7z/8BAM5w95/oyPsHUqOsg/xUTlNp
 rlbhA+WWoaOXA3XgR+wCzjgEZIsaeRIKKwYBBAGXVQEFAQEHQGoOK0jgh0IorMAacx6WUUWb
 s3RLiJYWUU6iNrk5wWUbAwEIB8J+BBgWCAAmFiEEMwKoW0i8UpVEllCENI+cctoYVW4FAmSL
 GnkFCQWjmoACGwwACgkQNI+cctoYVW6cqwD/Q9R98msvkhgRvi18fzUPFDwwogn+F+gQJJ6o
 pwpgFkAA/R2zOfla3IT6G3SBoV5ucdpdCpnIXFpQLbmfHK7dXsAC
In-Reply-To: <20240516-yuv-v8-4-cf8d6f86430e@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/16/24 10:04, Louis Chauvet wrote:
> Introduce two typedefs: pixel_read_t and pixel_write_t. It allows the
> compiler to check if the passed functions take the correct arguments.
> Such typedefs will help ensuring consistency across the code base in
> case of update of these prototypes.
> 
> Rename input/output variable in a consistent way between read_line and
> write_line.
> 
> A warn has been added in get_pixel_*_function to alert when an unsupported
> pixel format is requested. As those formats are checked before
> atomic_update callbacks, it should never happen.
> 
> Document for those typedefs.
> 
> Reviewed-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>   drivers/gpu/drm/vkms/vkms_drv.h     |  23 ++++++-
>   drivers/gpu/drm/vkms/vkms_formats.c | 124 +++++++++++++++++++++---------------
>   drivers/gpu/drm/vkms/vkms_formats.h |   4 +-
>   drivers/gpu/drm/vkms/vkms_plane.c   |   2 +-
>   4 files changed, 95 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index 212f4ab6a71f..b1542b83b090 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -53,12 +53,31 @@ struct line_buffer {
>   	struct pixel_argb_u16 *pixels;
>   };
>   
> +/**
> + * typedef pixel_write_t - These functions are used to read a pixel from a
> + * &struct pixel_argb_u16, convert it in a specific format and write it in the @dst_pixels
> + * buffer.
> + *
> + * @out_pixel: destination address to write the pixel
> + * @in_pixel: pixel to write
> + */
> +typedef void (*pixel_write_t)(u8 *out_pixel, struct pixel_argb_u16 *in_pixel);
> +
>   struct vkms_writeback_job {
>   	struct iosys_map data[DRM_FORMAT_MAX_PLANES];
>   	struct vkms_frame_info wb_frame_info;
> -	void (*pixel_write)(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel);
> +	pixel_write_t pixel_write;
>   };
>   
> +/**
> + * typedef pixel_read_t - These functions are used to read a pixel in the source frame,
> + * convert it to `struct pixel_argb_u16` and write it to @out_pixel.
> + *
> + * @in_pixel: pointer to the pixel to read
> + * @out_pixel: pointer to write the converted pixel
> + */
> +typedef void (*pixel_read_t)(u8 *in_pixel, struct pixel_argb_u16 *out_pixel);
> +
>   /**
>    * struct vkms_plane_state - Driver specific plane state
>    * @base: base plane state
> @@ -69,7 +88,7 @@ struct vkms_writeback_job {
>   struct vkms_plane_state {
>   	struct drm_shadow_plane_state base;
>   	struct vkms_frame_info *frame_info;
> -	void (*pixel_read)(u8 *src_buffer, struct pixel_argb_u16 *out_pixel);
> +	pixel_read_t pixel_read;
>   };
>   
>   struct vkms_plane {
> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> index f157c43da4d6..6b3e17374b19 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.c
> +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> @@ -75,7 +75,7 @@ static int get_x_position(const struct vkms_frame_info *frame_info, int limit, i
>    * They are used in the vkms_compose_row() function to handle multiple formats.
>    */
>   
> -static void ARGB8888_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
> +static void ARGB8888_to_argb_u16(u8 *in_pixel, struct pixel_argb_u16 *out_pixel)
>   {
>   	/*
>   	 * The 257 is the "conversion ratio". This number is obtained by the
> @@ -83,48 +83,48 @@ static void ARGB8888_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixe
>   	 * the best color value in a pixel format with more possibilities.
>   	 * A similar idea applies to others RGB color conversions.
>   	 */
> -	out_pixel->a = (u16)src_pixels[3] * 257;
> -	out_pixel->r = (u16)src_pixels[2] * 257;
> -	out_pixel->g = (u16)src_pixels[1] * 257;
> -	out_pixel->b = (u16)src_pixels[0] * 257;
> +	out_pixel->a = (u16)in_pixel[3] * 257;
> +	out_pixel->r = (u16)in_pixel[2] * 257;
> +	out_pixel->g = (u16)in_pixel[1] * 257;
> +	out_pixel->b = (u16)in_pixel[0] * 257;
>   }
>   
> -static void XRGB8888_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
> +static void XRGB8888_to_argb_u16(u8 *in_pixel, struct pixel_argb_u16 *out_pixel)
>   {
>   	out_pixel->a = (u16)0xffff;
> -	out_pixel->r = (u16)src_pixels[2] * 257;
> -	out_pixel->g = (u16)src_pixels[1] * 257;
> -	out_pixel->b = (u16)src_pixels[0] * 257;
> +	out_pixel->r = (u16)in_pixel[2] * 257;
> +	out_pixel->g = (u16)in_pixel[1] * 257;
> +	out_pixel->b = (u16)in_pixel[0] * 257;
>   }
>   
> -static void ARGB16161616_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
> +static void ARGB16161616_to_argb_u16(u8 *in_pixel, struct pixel_argb_u16 *out_pixel)
>   {
> -	u16 *pixels = (u16 *)src_pixels;
> +	u16 *pixel = (u16 *)in_pixel;
>   
> -	out_pixel->a = le16_to_cpu(pixels[3]);
> -	out_pixel->r = le16_to_cpu(pixels[2]);
> -	out_pixel->g = le16_to_cpu(pixels[1]);
> -	out_pixel->b = le16_to_cpu(pixels[0]);
> +	out_pixel->a = le16_to_cpu(pixel[3]);
> +	out_pixel->r = le16_to_cpu(pixel[2]);
> +	out_pixel->g = le16_to_cpu(pixel[1]);
> +	out_pixel->b = le16_to_cpu(pixel[0]);
>   }
>   
> -static void XRGB16161616_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
> +static void XRGB16161616_to_argb_u16(u8 *in_pixel, struct pixel_argb_u16 *out_pixel)
>   {
> -	u16 *pixels = (u16 *)src_pixels;
> +	u16 *pixel = (u16 *)in_pixel;
>   
>   	out_pixel->a = (u16)0xffff;
> -	out_pixel->r = le16_to_cpu(pixels[2]);
> -	out_pixel->g = le16_to_cpu(pixels[1]);
> -	out_pixel->b = le16_to_cpu(pixels[0]);
> +	out_pixel->r = le16_to_cpu(pixel[2]);
> +	out_pixel->g = le16_to_cpu(pixel[1]);
> +	out_pixel->b = le16_to_cpu(pixel[0]);
>   }
>   
> -static void RGB565_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
> +static void RGB565_to_argb_u16(u8 *in_pixel, struct pixel_argb_u16 *out_pixel)
>   {
> -	u16 *pixels = (u16 *)src_pixels;
> +	u16 *pixel = (u16 *)in_pixel;
>   
>   	s64 fp_rb_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(31));
>   	s64 fp_g_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(63));
>   
> -	u16 rgb_565 = le16_to_cpu(*pixels);
> +	u16 rgb_565 = le16_to_cpu(*pixel);
>   	s64 fp_r = drm_int2fixp((rgb_565 >> 11) & 0x1f);
>   	s64 fp_g = drm_int2fixp((rgb_565 >> 5) & 0x3f);
>   	s64 fp_b = drm_int2fixp(rgb_565 & 0x1f);
> @@ -168,12 +168,12 @@ void vkms_compose_row(struct line_buffer *stage_buffer, struct vkms_plane_state
>   
>   /*
>    * The following functions take one &struct pixel_argb_u16 and convert it to a specific format.
> - * The result is stored in @dst_pixels.
> + * The result is stored in @out_pixel.
>    *
>    * They are used in vkms_writeback_row() to convert and store a pixel from the src_buffer to
>    * the writeback buffer.
>    */
> -static void argb_u16_to_ARGB8888(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
> +static void argb_u16_to_ARGB8888(u8 *out_pixel, struct pixel_argb_u16 *in_pixel)
>   {
>   	/*
>   	 * This sequence below is important because the format's byte order is
> @@ -185,43 +185,43 @@ static void argb_u16_to_ARGB8888(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel
>   	 * | Addr + 2 | = Red channel
>   	 * | Addr + 3 | = Alpha channel
>   	 */
> -	dst_pixels[3] = DIV_ROUND_CLOSEST(in_pixel->a, 257);
> -	dst_pixels[2] = DIV_ROUND_CLOSEST(in_pixel->r, 257);
> -	dst_pixels[1] = DIV_ROUND_CLOSEST(in_pixel->g, 257);
> -	dst_pixels[0] = DIV_ROUND_CLOSEST(in_pixel->b, 257);
> +	out_pixel[3] = DIV_ROUND_CLOSEST(in_pixel->a, 257);
> +	out_pixel[2] = DIV_ROUND_CLOSEST(in_pixel->r, 257);
> +	out_pixel[1] = DIV_ROUND_CLOSEST(in_pixel->g, 257);
> +	out_pixel[0] = DIV_ROUND_CLOSEST(in_pixel->b, 257);
>   }
>   
> -static void argb_u16_to_XRGB8888(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
> +static void argb_u16_to_XRGB8888(u8 *out_pixel, struct pixel_argb_u16 *in_pixel)
>   {
> -	dst_pixels[3] = 0xff;
> -	dst_pixels[2] = DIV_ROUND_CLOSEST(in_pixel->r, 257);
> -	dst_pixels[1] = DIV_ROUND_CLOSEST(in_pixel->g, 257);
> -	dst_pixels[0] = DIV_ROUND_CLOSEST(in_pixel->b, 257);
> +	out_pixel[3] = 0xff;
> +	out_pixel[2] = DIV_ROUND_CLOSEST(in_pixel->r, 257);
> +	out_pixel[1] = DIV_ROUND_CLOSEST(in_pixel->g, 257);
> +	out_pixel[0] = DIV_ROUND_CLOSEST(in_pixel->b, 257);
>   }
>   
> -static void argb_u16_to_ARGB16161616(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
> +static void argb_u16_to_ARGB16161616(u8 *out_pixel, struct pixel_argb_u16 *in_pixel)
>   {
> -	u16 *pixels = (u16 *)dst_pixels;
> +	u16 *pixel = (u16 *)out_pixel;
>   
> -	pixels[3] = cpu_to_le16(in_pixel->a);
> -	pixels[2] = cpu_to_le16(in_pixel->r);
> -	pixels[1] = cpu_to_le16(in_pixel->g);
> -	pixels[0] = cpu_to_le16(in_pixel->b);
> +	pixel[3] = cpu_to_le16(in_pixel->a);
> +	pixel[2] = cpu_to_le16(in_pixel->r);
> +	pixel[1] = cpu_to_le16(in_pixel->g);
> +	pixel[0] = cpu_to_le16(in_pixel->b);
>   }
>   
> -static void argb_u16_to_XRGB16161616(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
> +static void argb_u16_to_XRGB16161616(u8 *out_pixel, struct pixel_argb_u16 *in_pixel)
>   {
> -	u16 *pixels = (u16 *)dst_pixels;
> +	u16 *pixel = (u16 *)out_pixel;
>   
> -	pixels[3] = 0xffff;
> -	pixels[2] = cpu_to_le16(in_pixel->r);
> -	pixels[1] = cpu_to_le16(in_pixel->g);
> -	pixels[0] = cpu_to_le16(in_pixel->b);
> +	pixel[3] = 0xffff;
> +	pixel[2] = cpu_to_le16(in_pixel->r);
> +	pixel[1] = cpu_to_le16(in_pixel->g);
> +	pixel[0] = cpu_to_le16(in_pixel->b);
>   }
>   
> -static void argb_u16_to_RGB565(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
> +static void argb_u16_to_RGB565(u8 *out_pixel, struct pixel_argb_u16 *in_pixel)
>   {
> -	u16 *pixels = (u16 *)dst_pixels;
> +	u16 *pixel = (u16 *)out_pixel;
>   
>   	s64 fp_rb_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(31));
>   	s64 fp_g_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(63));
> @@ -234,7 +234,7 @@ static void argb_u16_to_RGB565(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
>   	u16 g = drm_fixp2int(drm_fixp_div(fp_g, fp_g_ratio));
>   	u16 b = drm_fixp2int(drm_fixp_div(fp_b, fp_rb_ratio));
>   
> -	*pixels = cpu_to_le16(r << 11 | g << 5 | b);
> +	*pixel = cpu_to_le16(r << 11 | g << 5 | b);
>   }
>   
>   /**
> @@ -265,7 +265,7 @@ void vkms_writeback_row(struct vkms_writeback_job *wb,
>    *
>    * @format: DRM_FORMAT_* value for which to obtain a conversion function (see [drm_fourcc.h])
>    */
> -void *get_pixel_conversion_function(u32 format)
> +pixel_read_t get_pixel_read_function(u32 format)
>   {
>   	switch (format) {
>   	case DRM_FORMAT_ARGB8888:
> @@ -279,7 +279,16 @@ void *get_pixel_conversion_function(u32 format)
>   	case DRM_FORMAT_RGB565:
>   		return &RGB565_to_argb_u16;
>   	default:
> -		return NULL;
> +		/*
> +		 * This is a bug in vkms_plane_atomic_check(). All the supported
> +		 * format must:
> +		 * - Be listed in vkms_formats in vkms_plane.c
> +		 * - Have a pixel_read callback defined here
> +		 */
> +		WARN(true,
> +		     "Pixel format %p4cc is not supported by VKMS planes. This is a kernel bug, atomic check must forbid this configuration.\n",
> +		     &format);

Well, if this is a kernel bug, shouldn't we use a BUG_ON()/BUG() macro?

Best Regards,
- Maíra

> +		return (pixel_read_t)NULL;
>   	}
>   }
>   
> @@ -290,7 +299,7 @@ void *get_pixel_conversion_function(u32 format)
>    *
>    * @format: DRM_FORMAT_* value for which to obtain a conversion function (see [drm_fourcc.h])
>    */
> -void *get_pixel_write_function(u32 format)
> +pixel_write_t get_pixel_write_function(u32 format)
>   {
>   	switch (format) {
>   	case DRM_FORMAT_ARGB8888:
> @@ -304,6 +313,15 @@ void *get_pixel_write_function(u32 format)
>   	case DRM_FORMAT_RGB565:
>   		return &argb_u16_to_RGB565;
>   	default:
> -		return NULL;
> +		/*
> +		 * This is a bug in vkms_writeback_atomic_check. All the supported
> +		 * format must:
> +		 * - Be listed in vkms_wb_formats in vkms_writeback.c
> +		 * - Have a pixel_write callback defined here
> +		 */
> +		WARN(true,
> +		     "Pixel format %p4cc is not supported by VKMS writeback. This is a kernel bug, atomic check must forbid this configuration.\n",
> +		     &format);
> +		return (pixel_write_t)NULL;
>   	}
>   }
> diff --git a/drivers/gpu/drm/vkms/vkms_formats.h b/drivers/gpu/drm/vkms/vkms_formats.h
> index cf59c2ed8e9a..3ecea4563254 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.h
> +++ b/drivers/gpu/drm/vkms/vkms_formats.h
> @@ -5,8 +5,8 @@
>   
>   #include "vkms_drv.h"
>   
> -void *get_pixel_conversion_function(u32 format);
> +pixel_read_t get_pixel_read_function(u32 format);
>   
> -void *get_pixel_write_function(u32 format);
> +pixel_write_t get_pixel_write_function(u32 format);
>   
>   #endif /* _VKMS_FORMATS_H_ */
> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> index 21b5adfb44aa..10e9b23dab28 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> @@ -125,7 +125,7 @@ static void vkms_plane_atomic_update(struct drm_plane *plane,
>   	drm_rect_rotate(&frame_info->rotated, drm_rect_width(&frame_info->rotated),
>   			drm_rect_height(&frame_info->rotated), frame_info->rotation);
>   
> -	vkms_plane_state->pixel_read = get_pixel_conversion_function(fmt);
> +	vkms_plane_state->pixel_read = get_pixel_read_function(fmt);
>   }
>   
>   static int vkms_plane_atomic_check(struct drm_plane *plane,
> 

