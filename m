Return-Path: <linux-kernel+bounces-294252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7DE958B3F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4610328223B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5554F4595B;
	Tue, 20 Aug 2024 15:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dg83hMdC"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412FE28FA
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 15:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167692; cv=none; b=YVslY6jhcG4Rm3p1XLizWqm7e/JuTiBfoKx4VlWJqQmE8faUbFh2/6zrhojey2bb1Ap7Y+4ZxlenWKoMRbLE+6VZ1LG7ZFtbYNjF7EFpMd5k+7D18xCmcgYxUlM8jsVz6NOz0vy4XbXUU19keq3F4LP7Fz2GyMMRYVdWFSmFOww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167692; c=relaxed/simple;
	bh=QisRogbx/78IeUKIcfE+Bug9EkdmEbP9FOBzpxyN1vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H5hW94AJlBL0IL7bPlxsJDJW4i/aKHQZWaJMb6T7RZb6Liw8Jhu6M7mDAESinbN48lXq1JhTsMWKIVbzLHer/OIQDTLRF6rTDWv3Y/MWgV4eYDNSicgkrPjFWj2AjXZk4z669PXRTEeq/A4jFa8whzD4OtoQOYDBTjUT6M8OfkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dg83hMdC; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42ab97465c8so6673325e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724167688; x=1724772488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLja7U6slSTOMGBcSoZ/i5FaagZbUM5mV8xORy86o7M=;
        b=dg83hMdCiyW4z50Km+T7k+LMPfrmp0xy/RqSRo/Ov1ABhx7KZoGRSh/FtyVjcPTL17
         q8ht66qTaZsd5Yj8HqiyxxPuUd3yscSQAJ+XHVA+26cWWAbblBxJLfeA7+x9NcKwocOk
         lpJ8Jt0TJ21aj2/rmGGPIv0O1BUtqV/67SKGQVkjxA6jXTsKjLEyWSywuArJiMdOb79n
         iGhhNfAVfX6vEG7HGiOvK7mF1WoLgiFi/MJyIR18vRh5+NIO0o1EmvHiHBDl3ijuZ18f
         lkC/cXOzJPZ1ODDrn8gi2UzwfVmazw3fcaNItGBRgVFyG545ifXdF7Dwg/+m57D5yRH0
         67kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724167688; x=1724772488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLja7U6slSTOMGBcSoZ/i5FaagZbUM5mV8xORy86o7M=;
        b=Rzj2P7oelBJ/Ry2nkm0avJY/3iPr5cXcwNPo8xOrikvpl0jELkYPIPE1nqgclh6UEI
         WHuBRSrVy7IBx95Kih1GSxQBDhwqKXTmJ6kMpkcxZMb1bF7TL2OZRK12fv+y7wp/eGgx
         VxlEj4ygkPWTEB0xM3vFa2EoLvUrwp4e0ijzaNW/YNWcFpSKn90lcSHHZuphHNBVnPqY
         DBhTzCl5OCUjbAX4bFFsspd+57Yy+4Ro6SKg+r71XLHJTwYUOiaVDfzOp3rQRbK4kIm+
         gsZtJSWdkwTKq6kWEQJy8SGSkP72XMsGlOKcmsXQmseEIEQdS/vQIERZCb5tfdEP1myO
         72BA==
X-Forwarded-Encrypted: i=1; AJvYcCVnSln1iwRzgLncTRklcKwghKNIT+64d3Wgp6LAGvR82DXcrPYAI5D+hP+mFl+U4aenmME5G33O6NlcOI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgAVRprPcJKcUKUrPl1odRnQLghZOAyRljVJ4gdF3p8PNzb+TI
	0iQtum69nHnffpV1D3Lr2sPwGOuGn6UFZ2f5ivLZd4Zku/WEZaRU
X-Google-Smtp-Source: AGHT+IG7KBJ1TK+wrNLlXtyn2rRtL79GkKoGictFWHUDR6SqwLtrLEiVjNVm1gvu6aw6ngxV7zgOqQ==
X-Received: by 2002:a05:600c:19c9:b0:428:151b:e8e with SMTP id 5b1f17b1804b1-429ed79c7a5mr104676605e9.10.1724167687717;
        Tue, 20 Aug 2024 08:28:07 -0700 (PDT)
Received: from fedora.. ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded71ed8sm200596095e9.31.2024.08.20.08.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 08:28:07 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: louis.chauvet@bootlin.com
Cc: airlied@gmail.com,
	arthurgrillo@riseup.net,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	hamohammed.sa@gmail.com,
	jeremie.dautheribes@bootlin.com,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mairacanal@riseup.net,
	marcheu@google.com,
	melissa.srw@gmail.com,
	miquel.raynal@bootlin.com,
	mripard@kernel.org,
	nicolejadeyee@google.com,
	rodrigosiqueiramelo@gmail.com,
	seanpaul@google.com,
	thomas.petazzoni@bootlin.com,
	tzimmermann@suse.de,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH RFC 1/6] drm/vkms: Properly extract vkms_formats header
Date: Tue, 20 Aug 2024 17:28:02 +0200
Message-ID: <20240820152803.2805-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240814-google-split-headers-v1-1-51712f088f5d@bootlin.com>
References: <20240814-google-split-headers-v1-1-51712f088f5d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Louis,

Thanks for refactoring this, it make things a bit easier to find.

I already reviewed this series on your GitHub fork, but I'm adding the missing
fixes here as well so we can discusse them in the right forum.

Since these patches only move code around, I wonder if it'd make sense to merge
them before the complex changes, like configfs.

For reference, I already rebased them on top drm-misc-next as part of my review
work:
https://github.com/JoseExposito/linux/commits/patch-vkms-header-refactor/

It is easy to do, but the decision to rebase or not depends on how much it
impacts the other series you are trying to get merged. I'll leave that up to you
and the maintainers.

> The vkms_format.h header was already separated from vkms_drv.h, but some
> function were missing. Move those function in vkms_format.h.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>

Reviewed-by: José Expósito <jose.exposito89@gmail.com>

> ---
>  drivers/gpu/drm/vkms/vkms_drv.h     | 74 +---------------------------------
>  drivers/gpu/drm/vkms/vkms_formats.c |  3 ++
>  drivers/gpu/drm/vkms/vkms_formats.h | 80 ++++++++++++++++++++++++++++++++++++-
>  3 files changed, 84 insertions(+), 73 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index 8f6c9e67e671..0db443924a15 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -12,6 +12,8 @@
>  #include <drm/drm_encoder.h>
>  #include <drm/drm_writeback.h>
>  
> +#include "vkms_formats.h"
> +

A general thought about includes to comment on. While including vkms_drv.h from
any other header or source file should be fine, including other vkms_*.h headers
could lead to circular dependencies if included from the wrong file.
Commenting on this becase, when I rebased this series on top of drm-misc-next, I
hit a few compiler errors due to circular dependencies.

I think that forward declaring always (if possible) could be a good approach.
Also, patch 5/6 of this series removes this include and I guess it is because
you found the same issues I did. What do you think about forward declaring when
possible?


On a different topic: The structures moved to vkms_formats.h are used in
vkms_composer.c, so, even though it compiles as it is, it'd be nice to add this
include in vkms_composer.c as well.

>  #define XRES_MIN    10
>  #define YRES_MIN    10
>  
> @@ -43,29 +45,6 @@ struct vkms_frame_info {
>  	unsigned int rotation;
>  };
>  
> -struct pixel_argb_u16 {
> -	u16 a, r, g, b;
> -};
> -
> -struct line_buffer {
> -	size_t n_pixels;
> -	struct pixel_argb_u16 *pixels;
> -};
> -
> -struct vkms_writeback_job;
> -/**
> - * typedef pixel_write_line_t - These functions are used to read a pixel line from a
> - * struct pixel_argb_u16 buffer, convert it and write it in the @wb job.
> - *
> - * @wb: the writeback job to write the output of the conversion
> - * @in_pixels: Source buffer containing the line to convert
> - * @count: The width of a line
> - * @x_start: The x (width) coordinate in the destination plane
> - * @y_start: The y (height) coordinate in the destination plane
> - */
> -typedef void (*pixel_write_line_t)(struct vkms_writeback_job *wb,
> -			      struct pixel_argb_u16 *in_pixels, int count, int x_start,
> -			      int y_start);
>  
>  struct vkms_writeback_job {
>  	struct iosys_map data[DRM_FORMAT_MAX_PLANES];
> @@ -73,53 +52,10 @@ struct vkms_writeback_job {
>  	pixel_write_line_t pixel_write;
>  };
>  
> -/**
> - * enum pixel_read_direction - Enum used internaly by VKMS to represent a reading direction in a
> - * plane.
> - */
> -enum pixel_read_direction {
> -	READ_BOTTOM_TO_TOP,
> -	READ_TOP_TO_BOTTOM,
> -	READ_RIGHT_TO_LEFT,
> -	READ_LEFT_TO_RIGHT
> -};
>  
>  struct vkms_plane_state;
>  
> -/**
> - * typedef pixel_read_line_t - These functions are used to read a pixel line in the source frame,
> - * convert it to `struct pixel_argb_u16` and write it to @out_pixel.
> - *
> - * @plane: plane used as source for the pixel value
> - * @x_start: X (width) coordinate of the first pixel to copy. The caller must ensure that x_start
> - * is non-negative and smaller than @plane->frame_info->fb->width.
> - * @y_start: Y (height) coordinate of the first pixel to copy. The caller must ensure that y_start
> - * is non-negative and smaller than @plane->frame_info->fb->height.
> - * @direction: direction to use for the copy, starting at @x_start/@y_start
> - * @count: number of pixels to copy
> - * @out_pixel: pointer where to write the pixel values. They will be written from @out_pixel[0]
> - * (included) to @out_pixel[@count] (excluded). The caller must ensure that out_pixel have a
> - * length of at least @count.
> - */
> -typedef void (*pixel_read_line_t)(const struct vkms_plane_state *plane, int x_start,
> -				  int y_start, enum pixel_read_direction direction, int count,
> -				  struct pixel_argb_u16 out_pixel[]);
>  
> -/**
> - * struct conversion_matrix - Matrix to use for a specific encoding and range
> - *
> - * @matrix: Conversion matrix from yuv to rgb. The matrix is stored in a row-major manner and is
> - * used to compute rgb values from yuv values:
> - *     [[r],[g],[b]] = @matrix * [[y],[u],[v]]
> - *   OR for yvu formats:
> - *     [[r],[g],[b]] = @matrix * [[y],[v],[u]]
> - *  The values of the matrix are signed fixed-point values with 32 bits fractional part.
> - * @y_offset: Offset to apply on the y value.
> - */
> -struct conversion_matrix {
> -	s64 matrix[3][3];
> -	int y_offset;
> -};
>  
>  /**
>   * struct vkms_plane_state - Driver specific plane state
> @@ -140,12 +76,6 @@ struct vkms_plane {
>  	struct drm_plane base;
>  };
>  
> -struct vkms_color_lut {
> -	struct drm_color_lut *base;
> -	size_t lut_length;
> -	s64 channel_value2index_ratio;
> -};
> -
>  /**
>   * struct vkms_crtc_state - Driver specific CRTC state
>   *
> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> index 65fdd3999441..5ab84801d8da 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.c
> +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> @@ -6,9 +6,12 @@
>  #include <drm/drm_blend.h>
>  #include <drm/drm_rect.h>
>  #include <drm/drm_fixed.h>
> +#include <drm/drm_fourcc.h>
> +#include <drm/drm_framebuffer.h>
>  
>  #include <kunit/visibility.h>
>  
> +#include "vkms_drv.h"
>  #include "vkms_formats.h"
>  
>  /**
> diff --git a/drivers/gpu/drm/vkms/vkms_formats.h b/drivers/gpu/drm/vkms/vkms_formats.h
> index 852ab9a4cee5..62b06bc26e79 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.h
> +++ b/drivers/gpu/drm/vkms/vkms_formats.h
> @@ -3,7 +3,85 @@
>  #ifndef _VKMS_FORMATS_H_
>  #define _VKMS_FORMATS_H_
>  
> -#include "vkms_drv.h"
> +#include <drm/drm_color_mgmt.h>
> +
> +struct vkms_plane_state;
> +struct vkms_writeback_job;
> +
> +struct pixel_argb_u16 {
> +	u16 a, r, g, b;
> +};
> +
> +/**
> + * typedef pixel_write_line_t - These functions are used to read a pixel line from a
> + * struct pixel_argb_u16 buffer, convert it and write it in the @wb_job.
> + *
> + * @wb: the writeback job to write the output of the conversion
> + * @in_pixels: Source buffer containing the line to convert
> + * @count: The width of a line
> + * @x_start: The x (width) coordinate in the destination plane
> + * @y_start: The y (height) coordinate in the destination plane
> + */
> +typedef void (*pixel_write_line_t)(struct vkms_writeback_job *wb,
> +				   struct pixel_argb_u16 *in_pixels, int count, int x_start,
> +				   int y_start);
> +
> +struct line_buffer {
> +	size_t n_pixels;
> +	struct pixel_argb_u16 *pixels;
> +};
> +
> +/**
> + * enum pixel_read_direction - Enum used internaly by VKMS to represent a reading direction in a
> + * plane.
> + */
> +enum pixel_read_direction {
> +	READ_BOTTOM_TO_TOP,
> +	READ_TOP_TO_BOTTOM,
> +	READ_RIGHT_TO_LEFT,
> +	READ_LEFT_TO_RIGHT
> +};
> +
> +/**
> + * struct conversion_matrix - Matrix to use for a specific encoding and range
> + *
> + * @matrix: Conversion matrix from yuv to rgb. The matrix is stored in a row-major manner and is
> + * used to compute rgb values from yuv values:
> + *     [[r],[g],[b]] = @matrix * [[y],[u],[v]]
> + *   OR for yvu formats:
> + *     [[r],[g],[b]] = @matrix * [[y],[v],[u]]
> + *  The values of the matrix are signed fixed-point values with 32 bits fractional part.
> + * @y_offset: Offset to apply on the y value.
> + */
> +struct conversion_matrix {
> +	s64 matrix[3][3];
> +	int y_offset;
> +};
> +
> +struct vkms_color_lut {
> +	struct drm_color_lut *base;
> +	size_t lut_length;
> +	s64 channel_value2index_ratio;
> +};
> +
> +/**
> + * typedef pixel_read_line_t - These functions are used to read a pixel line in the source frame,
> + * convert it to `struct pixel_argb_u16` and write it to @out_pixel.
> + *
> + * @plane: plane used as source for the pixel value
> + * @x_start: X (width) coordinate of the first pixel to copy. The caller must ensure that x_start
> + * is non-negative and smaller than @plane->frame_info->fb->width.
> + * @y_start: Y (height) coordinate of the first pixel to copy. The caller must ensure that y_start
> + * is non-negative and smaller than @plane->frame_info->fb->height.
> + * @direction: direction to use for the copy, starting at @x_start/@y_start
> + * @count: number of pixels to copy
> + * @out_pixel: pointer where to write the pixel values. They will be written from @out_pixel[0]
> + * (included) to @out_pixel[@count] (excluded). The caller must ensure that out_pixel have a
> + * length of at least @count.
> + */
> +typedef void (*pixel_read_line_t)(const struct vkms_plane_state *plane, int x_start,
> +				  int y_start, enum pixel_read_direction direction, int count,
> +				  struct pixel_argb_u16 out_pixel[]);
>  
>  pixel_read_line_t get_pixel_read_line_function(u32 format);

