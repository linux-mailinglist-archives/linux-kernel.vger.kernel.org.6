Return-Path: <linux-kernel+bounces-185476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 570C78CB550
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 23:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EC2928222D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 21:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E983814B07D;
	Tue, 21 May 2024 21:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ErXBbYls"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F8A14A0A9
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 21:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716326050; cv=none; b=QbQI6jjKQEPSVgpDpc8RJO1GYPlD4waA55XOvBlhMxArb33ongpVEJceR/j/KPeJoNZY1qn5XZRFPIhOkcCy3N3iuzK1NdRnXWYEyqE2v/q0q+AvgAcPBTFa5i0rEQRQAP/zQCSt0/UI1N/2WTHQ7B+Bt3LXu1pEvUAE4aDVhmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716326050; c=relaxed/simple;
	bh=Mw86AyN+I2OBhvRHivwIKJ8rShff7rX0ZwEqwDKQ30Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUp5gOIH8DIZvPPYGH8NcINbmyYLc/uRxEUotXm8rhH78otACWYfhaK9f3xoo3aParvdkt5fhP+PLO0Lko3j78IBjcOBHV8i+emDf10NxFZPBI5n9EEOljzIKNVMbfpBPIg1IGS7mk+r/TDCE/NSgpgPixljUQKTcDbHgATHjdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ErXBbYls; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5206a5854adso4964113e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 14:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716326046; x=1716930846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3BKL5E/kEakFsQ/pM5Hc/hEwUaNwFbFzK8TTSCgHOFg=;
        b=ErXBbYlshfyl2evm5pOEWATnjbJ46i8EtfBmj3fkCe5qM5moBLTZMhUb3DF6uZkyP9
         eREEjTYmZbBLqQz8YH9CXg3cFA2yCzJE7VXwN39yAmLJUINjqPkIRhmbKlyLhKNoV3Zj
         GIMvyBtEwwM6yWEreVmALPxU6rqGw63zadQvl9Fpbv95UbVVPJDGQU9dFtXvDE/3+aVQ
         4iKud7HPXHlzWNXCZTbDeQhR9eXZxMqcMDAZb8wvUPsXgYLHD/6v9C0LKTJCniicsFqv
         x8kvq5+2o6EdKJo5rSjRz15p8qF6QctnH3AmA+GiU4WP8VUKcgFF4GW73iTaxseOieOF
         0GwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716326046; x=1716930846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BKL5E/kEakFsQ/pM5Hc/hEwUaNwFbFzK8TTSCgHOFg=;
        b=jZ2z55HS+yCv5s9fIisLO4W9HIAJPWoDBGNbMpw0QG0/L4vTKLV7kCxxXzlKmwut3H
         YOsLh2RNJEpYMurT5AlVEK2vdN9MhE3wkkSp05HCS1IGEAEdy0bD4f+BxsQv7212oOCg
         1AHgQqCl13tzzzxrVUe9iTDftZ84TF9xZJ33kgqP4wj8QL+hkm097sdcxEbbdQk4vg6M
         PcEwmAXljkF6I5qpuKREgwHE5gEFmywXKVXcGfl68fIEdcdKwUCEXQKrV3tAvbH50s5c
         cUvEvy/vAvXtRhsWOBI/A3KyvqWIEk++hckj4Y63iZNy3SHT7CORxIbittX5R/ftTJdb
         bnpw==
X-Forwarded-Encrypted: i=1; AJvYcCWpjWQrKjhBaZlut3X6JH11k0qfnHfxUtiey4kUzPPM2oMNsJ7D0dQeow3zUXYKvutVu0QOW5PgAagMHv8f6nnXHrBYvLlLzaHAelS5
X-Gm-Message-State: AOJu0YywZI0A30sUW1GuLb9trK66SWyhl5+jKOIUVKdtXC0gJGP/+ywB
	dh9cdmJkEJvKMNWlb17CyI+rmVw/2bJLz++US6wzvegmeFBStN9PUDRaRU4Dq44=
X-Google-Smtp-Source: AGHT+IESMSyzDCwonKOC8ex6l3hhF18lxRCtHFGXFWpoRPpr9gosEw2WI2xVtZiv8+cDQJ8eFA9zMQ==
X-Received: by 2002:ac2:47fa:0:b0:51c:1d6b:5171 with SMTP id 2adb3069b0e04-52210279d07mr18260818e87.56.1716326045604;
        Tue, 21 May 2024 14:14:05 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5239137ccd3sm2568151e87.26.2024.05.21.14.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 14:14:05 -0700 (PDT)
Date: Wed, 22 May 2024 00:14:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: keith <keith.zhao@starfivetech.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com, 
	xingyu.wu@starfivetech.com, p.zabel@pengutronix.de, jack.zhu@starfivetech.com, 
	shengyang.chen@starfivetech.com, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 08/10] drm/vs: add vs drm master driver
Message-ID: <mbkrlg67jtggoqwecu6emymw3hgqoyf5pe55ho2fthq6pgnds2@ml7mbssrdr2x>
References: <20240521105817.3301-1-keith.zhao@starfivetech.com>
 <20240521105817.3301-9-keith.zhao@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521105817.3301-9-keith.zhao@starfivetech.com>

On Tue, May 21, 2024 at 06:58:15PM +0800, keith wrote:
> Add vs DRM master driver for JH7110 SoC
> ADD DMA GEM driver
> 
> Signed-off-by: keith <keith.zhao@starfivetech.com>
> ---
>  drivers/gpu/drm/verisilicon/Makefile |   3 +-
>  drivers/gpu/drm/verisilicon/vs_drv.c | 718 +++++++++++++++++++++++++++
>  2 files changed, 720 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_drv.c
> 
> diff --git a/drivers/gpu/drm/verisilicon/Makefile b/drivers/gpu/drm/verisilicon/Makefile
> index 26a43ca0fd36..88a07a308e31 100644
> --- a/drivers/gpu/drm/verisilicon/Makefile
> +++ b/drivers/gpu/drm/verisilicon/Makefile
> @@ -3,6 +3,7 @@
>  vs_drm-objs := vs_dc_hw.o \
>  		vs_modeset.o \
>  		vs_plane.o \
> -		vs_crtc.o
> +		vs_crtc.o \
> +		vs_drv.o
>  
>  obj-$(CONFIG_DRM_VERISILICON_DC8200) += vs_drm.o
> diff --git a/drivers/gpu/drm/verisilicon/vs_drv.c b/drivers/gpu/drm/verisilicon/vs_drv.c
> new file mode 100644
> index 000000000000..c22fd2199fe2
> --- /dev/null
> +++ b/drivers/gpu/drm/verisilicon/vs_drv.c
> @@ -0,0 +1,718 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 VeriSilicon Holdings Co., Ltd.
> + */
> +#include <linux/clk.h>
> +#include <linux/component.h>
> +#include <linux/of_clk.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/of_device.h>
> +
> +#include <drm/drm_aperture.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_crtc.h>
> +#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_fb_helper.h>
> +#include <drm/drm_fbdev_generic.h>
> +#include <drm/drm_file.h>
> +#include <drm/drm_gem_dma_helper.h>
> +#include <drm/drm_module.h>
> +#include <drm/drm_of.h>
> +#include <drm/drm_probe_helper.h>
> +#include <drm/drm_vblank.h>
> +#include <drm/drm_blend.h>
> +
> +#include "vs_drv.h"
> +#include "vs_crtc.h"
> +#include "vs_plane.h"
> +#include "vs_modeset.h"
> +
> +#define DRV_NAME	"verisilicon"
> +#define DRV_DESC	"Verisilicon DRM driver"
> +#define DRV_DATE	"20230516"
> +#define DRV_MAJOR	1
> +#define DRV_MINOR	0
> +
> +#define FRAC_16_16(mult, div)	 (((mult) << 16) / (div))
> +
> +static const u32 primary_overlay_format[] = {
> +	DRM_FORMAT_RGB565,
> +	DRM_FORMAT_BGR565,
> +	DRM_FORMAT_XRGB8888,
> +	DRM_FORMAT_XBGR8888,
> +	DRM_FORMAT_RGBX8888,
> +	DRM_FORMAT_BGRX8888,
> +	DRM_FORMAT_ARGB8888,
> +	DRM_FORMAT_ABGR8888,
> +	DRM_FORMAT_RGBA8888,
> +	DRM_FORMAT_BGRA8888,
> +	DRM_FORMAT_XRGB4444,
> +	DRM_FORMAT_XBGR4444,
> +	DRM_FORMAT_RGBX4444,
> +	DRM_FORMAT_BGRX4444,
> +	DRM_FORMAT_ARGB4444,
> +	DRM_FORMAT_ABGR4444,
> +	DRM_FORMAT_RGBA4444,
> +	DRM_FORMAT_BGRA4444,
> +	DRM_FORMAT_XRGB1555,
> +	DRM_FORMAT_XBGR1555,
> +	DRM_FORMAT_RGBX5551,
> +	DRM_FORMAT_BGRX5551,
> +	DRM_FORMAT_ARGB1555,
> +	DRM_FORMAT_ABGR1555,
> +	DRM_FORMAT_RGBA5551,
> +	DRM_FORMAT_BGRA5551,
> +	DRM_FORMAT_ARGB2101010,
> +	DRM_FORMAT_ABGR2101010,
> +	DRM_FORMAT_RGBA1010102,
> +	DRM_FORMAT_BGRA1010102,
> +	DRM_FORMAT_YUYV,
> +	DRM_FORMAT_YVYU,
> +	DRM_FORMAT_UYVY,
> +	DRM_FORMAT_VYUY,
> +	DRM_FORMAT_YVU420,
> +	DRM_FORMAT_YUV420,
> +	DRM_FORMAT_NV12,
> +	DRM_FORMAT_NV21,
> +	DRM_FORMAT_NV16,
> +	DRM_FORMAT_NV61,
> +	DRM_FORMAT_P010,
> +};
> +
> +static const u32 cursor_formats[] = {
> +	DRM_FORMAT_ARGB8888
> +};
> +
> +static const u64 format_modifier[] = {
> +	DRM_FORMAT_MOD_LINEAR,
> +	DRM_FORMAT_MOD_INVALID
> +};
> +
> +static const u64 secondary_format_modifiers[] = {
> +	DRM_FORMAT_MOD_LINEAR,
> +	DRM_FORMAT_MOD_INVALID
> +};
> +
> +static const struct vs_plane_primary_info dc_hw_planes_primary[2] = {
> +	{
> +		.id			= PRIMARY_PLANE_0,
> +		.num_formats		= ARRAY_SIZE(primary_overlay_format),
> +		.formats		= primary_overlay_format,
> +		.num_modifiers		= ARRAY_SIZE(format_modifier),
> +		.modifiers		= format_modifier,
> +		.min_width		= 0,
> +		.min_height		= 0,
> +		.max_width		= 4096,
> +		.max_height		= 4096,
> +		.min_scale		= FRAC_16_16(1, 3),
> +		.max_scale		= FRAC_16_16(10, 1),
> +		.rotation		= DRM_MODE_ROTATE_0 |
> +					  DRM_MODE_ROTATE_90 |
> +					  DRM_MODE_ROTATE_180 |
> +					  DRM_MODE_ROTATE_270 |
> +					  DRM_MODE_REFLECT_X |
> +					  DRM_MODE_REFLECT_Y,
> +		.color_encoding		= BIT(DRM_COLOR_YCBCR_BT709) | BIT(DRM_COLOR_YCBCR_BT2020),
> +		.zpos			= 0,

How are these zpos related to the zpos from drm_plane_state?

> +	},
> +	{
> +		.id			= PRIMARY_PLANE_1,
> +		.num_formats		= ARRAY_SIZE(primary_overlay_format),
> +		.formats		= primary_overlay_format,
> +		.num_modifiers		= ARRAY_SIZE(format_modifier),
> +		.modifiers		= format_modifier,
> +		.min_width		= 0,
> +		.min_height		= 0,
> +		.max_width		= 4096,
> +		.max_height		= 4096,
> +		.min_scale		= FRAC_16_16(1, 3),
> +		.max_scale		= FRAC_16_16(10, 1),
> +		.rotation		= DRM_MODE_ROTATE_0 |
> +					  DRM_MODE_ROTATE_90 |
> +					  DRM_MODE_ROTATE_180 |
> +					  DRM_MODE_ROTATE_270 |
> +					  DRM_MODE_REFLECT_X |
> +					  DRM_MODE_REFLECT_Y,
> +		.color_encoding		= BIT(DRM_COLOR_YCBCR_BT709) | BIT(DRM_COLOR_YCBCR_BT2020),
> +		.zpos			= 3,
> +	},
> +};
> +
> +static const struct vs_plane_overlay_info dc_hw_planes_overlay[4] = {
> +	{
> +		.id			= OVERLAY_PLANE_0,
> +		.num_formats		= ARRAY_SIZE(primary_overlay_format),
> +		.formats		= primary_overlay_format,
> +		.num_modifiers		= ARRAY_SIZE(format_modifier),
> +		.modifiers		= format_modifier,
> +		.min_width		= 0,
> +		.min_height		= 0,
> +		.max_width		= 4096,
> +		.max_height		= 4096,
> +		.min_scale		= FRAC_16_16(1, 3),
> +		.max_scale		= FRAC_16_16(10, 1),
> +		.rotation		= DRM_MODE_ROTATE_0 |
> +					  DRM_MODE_ROTATE_90 |
> +					  DRM_MODE_ROTATE_180 |
> +					  DRM_MODE_ROTATE_270 |
> +					  DRM_MODE_REFLECT_X |
> +					  DRM_MODE_REFLECT_Y,
> +		.color_encoding		= BIT(DRM_COLOR_YCBCR_BT709) | BIT(DRM_COLOR_YCBCR_BT2020),
> +		.zpos			= 1,
> +	},
> +	{
> +		.id			= OVERLAY_PLANE_1,
> +		.num_formats		= ARRAY_SIZE(primary_overlay_format),
> +		.formats		= primary_overlay_format,
> +		.num_modifiers		= ARRAY_SIZE(secondary_format_modifiers),
> +		.modifiers		= secondary_format_modifiers,
> +		.min_width		= 0,
> +		.min_height		= 0,
> +		.max_width		= 4096,
> +		.max_height		= 4096,
> +		.min_scale		= DRM_PLANE_NO_SCALING,
> +		.max_scale		= DRM_PLANE_NO_SCALING,
> +		.rotation		= 0,
> +		.color_encoding		= BIT(DRM_COLOR_YCBCR_BT709) | BIT(DRM_COLOR_YCBCR_BT2020),
> +		.zpos			= 2,
> +	},
> +	{
> +		.id			= OVERLAY_PLANE_2,
> +		.num_formats		= ARRAY_SIZE(primary_overlay_format),
> +		.formats		= primary_overlay_format,
> +		.num_modifiers		= ARRAY_SIZE(format_modifier),
> +		.modifiers		= format_modifier,
> +		.min_width		= 0,
> +		.min_height		= 0,
> +		.max_width		= 4096,
> +		.max_height		= 4096,
> +		.min_scale		= FRAC_16_16(1, 3),
> +		.max_scale		= FRAC_16_16(10, 1),
> +		.rotation		= DRM_MODE_ROTATE_0 |
> +					  DRM_MODE_ROTATE_90 |
> +					  DRM_MODE_ROTATE_180 |
> +					  DRM_MODE_ROTATE_270 |
> +					  DRM_MODE_REFLECT_X |
> +					  DRM_MODE_REFLECT_Y,
> +		.color_encoding		= BIT(DRM_COLOR_YCBCR_BT709) | BIT(DRM_COLOR_YCBCR_BT2020),
> +		.zpos			= 4,
> +	},
> +	{
> +		.id			= OVERLAY_PLANE_3,
> +		.num_formats		= ARRAY_SIZE(primary_overlay_format),
> +		.formats		= primary_overlay_format,
> +		.num_modifiers		= ARRAY_SIZE(secondary_format_modifiers),
> +		.modifiers		= secondary_format_modifiers,
> +		.min_width		= 0,
> +		.min_height		= 0,
> +		.max_width		= 4096,
> +		.max_height		= 4096,
> +		.min_scale		= DRM_PLANE_NO_SCALING,
> +		.max_scale		= DRM_PLANE_NO_SCALING,
> +		.rotation		= 0,
> +		.color_encoding		= BIT(DRM_COLOR_YCBCR_BT709) | BIT(DRM_COLOR_YCBCR_BT2020),
> +		.zpos			= 5,
> +	},
> +};
> +
> +static const struct vs_plane_cursor_info dc_hw_planes_cursor[2] = {
> +	{
> +		.id			= CURSOR_PLANE_0,
> +		.num_formats		= ARRAY_SIZE(cursor_formats),
> +		.formats		= cursor_formats,
> +		.min_width		= 32,
> +		.min_height		= 32,
> +		.max_width		= 64,
> +		.max_height		= 64,
> +		.zpos			= 255,
> +	},
> +	{
> +		.id			= CURSOR_PLANE_1,
> +		.num_formats		= ARRAY_SIZE(cursor_formats),
> +		.formats		= cursor_formats,
> +		.min_width		= 32,
> +		.min_height		= 32,
> +		.max_width		= 64,
> +		.max_height		= 64,
> +		.zpos			= 255,
> +	},
> +};
> +
> +static const struct vs_dc_info dc8200_info = {
> +	.name			= "DC8200",
> +	.panel_num		= 2,
> +	.primary_num		= 2,
> +	.overlay_num		= 4,
> +	.cursor_num		= 2,

ARRAY_SIZE would have been better.

> +	.primary		= dc_hw_planes_primary,
> +	.overlay		= dc_hw_planes_overlay,
> +	.cursor			= dc_hw_planes_cursor,
> +	.layer_num		= 6,
> +	.gamma_size		= GAMMA_EX_SIZE,
> +	.gamma_bits		= 12,
> +	.pitch_alignment	= 128,
> +};
> +
> +static int vs_gem_dumb_create(struct drm_file *file, struct drm_device *dev,
> +			      struct drm_mode_create_dumb *args)
> +{
> +	struct vs_drm_device *priv = to_vs_drm_private(dev);
> +	unsigned int pitch = DIV_ROUND_UP(args->width * args->bpp, 8);
> +
> +	args->pitch = ALIGN(pitch, priv->pitch_alignment);
> +	return drm_gem_dma_dumb_create_internal(file, dev, args);
> +}
> +
> +DEFINE_DRM_GEM_FOPS(vs_drm_fops);
> +
> +static struct drm_driver vs_drm_driver = {
> +	.driver_features	= DRIVER_MODESET | DRIVER_ATOMIC | DRIVER_GEM,
> +
> +	DRM_GEM_DMA_DRIVER_OPS_WITH_DUMB_CREATE(vs_gem_dumb_create),
> +
> +	.fops			= &vs_drm_fops,
> +	.name			= DRV_NAME,
> +	.desc			= DRV_DESC,
> +	.date			= DRV_DATE,
> +	.major			= DRV_MAJOR,
> +	.minor			= DRV_MINOR,
> +};
> +
> +static irqreturn_t vs_dc_isr(int irq, void *data)
> +{
> +	struct vs_drm_device *priv = data;
> +	struct vs_dc *dc = &priv->dc;
> +	struct vs_dc_info *dc_info = dc->hw.info;
> +	u32 i;
> +
> +	dc_hw_get_interrupt(&dc->hw);
> +
> +	for (i = 0; i < dc_info->panel_num; i++)
> +		drm_crtc_handle_vblank(&dc->crtc[i]->base);

Is it true that all CRTCs have vblank at the same time?

> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int vs_drm_device_init_res(struct vs_drm_device *priv)
> +{
> +	struct device *dev = priv->base.dev;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	int ret;
> +	struct vs_dc *dc;
> +
> +	dc = &priv->dc;
> +	dc->hw.hi_base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(dc->hw.hi_base))
> +		return PTR_ERR(dc->hw.hi_base);
> +
> +	dc->hw.reg_base = devm_platform_ioremap_resource(pdev, 1);
> +	if (IS_ERR(dc->hw.reg_base))
> +		return PTR_ERR(dc->hw.reg_base);
> +
> +	dc->hw.info = (struct vs_dc_info *)of_device_get_match_data(dev);
> +
> +	ret = devm_clk_bulk_get_all(dev, &priv->clks);
> +	if (ret < 0) {
> +		dev_err(dev, "can't get vout clock, ret=%d\n", ret);
> +		return ret;
> +	}
> +	priv->clk_count = ret;
> +
> +	priv->rsts = devm_reset_control_array_get_shared(dev);
> +	if (IS_ERR(priv->rsts))
> +		return PTR_ERR(priv->rsts);
> +
> +	priv->irq = platform_get_irq(pdev, 0);
> +
> +	/* do not autoenable, will be enabled later */
> +	ret = devm_request_irq(dev, priv->irq, vs_dc_isr, IRQF_NO_AUTOEN, dev_name(dev), priv);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to install irq:%u.\n", priv->irq);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static u32 get_addr_offset(u32 id)
> +{
> +	u32 offset = 0;
> +
> +	switch (id) {
> +	case PRIMARY_PLANE_1:
> +	case OVERLAY_PLANE_1:
> +		offset = 0x04;
> +		break;
> +	case OVERLAY_PLANE_2:
> +		offset = 0x08;
> +		break;
> +	case OVERLAY_PLANE_3:
> +		offset = 0x0C;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return offset;
> +}
> +
> +static int vs_drm_device_crtc_plane_create(struct vs_drm_device *priv)
> +{
> +	struct vs_dc *dc;
> +	struct drm_device *drm_dev;
> +	int i, ret;
> +	struct device_node *port;
> +	struct vs_crtc *crtc;
> +	struct vs_dc_info *dc_info;
> +	struct vs_plane *plane;
> +	struct vs_plane_primary_info *primary_info;
> +	struct vs_plane_overlay_info *overlay_info;
> +	struct vs_plane_cursor_info *cursor_info;
> +
> +	struct device *dev = priv->base.dev;
> +	u32 max_width = 0, max_height = 0;
> +	u32 min_width = 0xffff, min_heigth = 0xffff;
> +	u32 possible_crtc = 0;
> +
> +	dc = &priv->dc;
> +	dc_info = dc->hw.info;
> +	drm_dev = &priv->base;
> +
> +	for (i = 0; i < dc_info->panel_num; i++) {
> +		crtc = vs_crtc_create(drm_dev, dc_info);
> +		if (!crtc) {
> +			drm_err(drm_dev, "Failed to create CRTC.\n");
> +			ret = -ENOMEM;
> +			return ret;
> +		}
> +		crtc->dev = drm_dev->dev;
> +
> +		port = of_graph_get_port_by_id(crtc->dev->of_node, i);
> +		if (!port) {
> +			drm_err(drm_dev, "no port node found for crtc_port%d\n", i);
> +			return -ENOENT;
> +		}
> +
> +		crtc->base.port = port;
> +		dc->crtc[i] = crtc;
> +
> +		of_node_put(port);
> +	}
> +
> +	if (!dc->crtc[0]->base.port || !dc->crtc[1]->base.port) {
> +		drm_err(drm_dev, "no port no crtc mask, fail to create plane\n");
> +		return -ENOENT;
> +	}
> +
> +	for (i = 0; i < dc_info->primary_num; i++) {
> +		primary_info = (struct vs_plane_primary_info *)&dc_info->primary[i];
> +
> +		if (primary_info->id == PRIMARY_PLANE_0)
> +			possible_crtc = drm_crtc_mask(&dc->crtc[0]->base);
> +		else
> +			possible_crtc = drm_crtc_mask(&dc->crtc[1]->base);
> +
> +		plane = vs_plane_primary_create(drm_dev, primary_info,
> +						dc_info->layer_num, possible_crtc);
> +		if (IS_ERR(plane)) {
> +			dev_err(dev, "failed to construct plane\n");
> +			return PTR_ERR(plane);
> +		}
> +
> +		plane->id = primary_info->id;
> +		dc->planes[plane->id].id = primary_info->id;
> +		dc->planes[plane->id].offset = get_addr_offset(primary_info->id);
> +
> +		if (primary_info->id == PRIMARY_PLANE_0)
> +			dc->crtc[0]->base.primary = &plane->base;
> +		else
> +			dc->crtc[1]->base.primary = &plane->base;
> +
> +		min_width = min_t(u32, min_width, primary_info->min_width);
> +		min_heigth = min_t(u32, min_heigth, primary_info->min_height);
> +		/*
> +		 * Note: these values are used for multiple independent things:
> +		 * hw display mode filtering, plane buffer sizes ...
> +		 * Use the combined maximum values here to cover all use cases,
> +		 * and do more specific checking in the respective code paths.
> +		 */
> +		max_width = max_t(u32, max_width, primary_info->max_width);
> +		max_height = max_t(u32, max_height, primary_info->max_height);
> +	}
> +
> +	for (i = 0; i < dc_info->overlay_num; i++) {
> +		overlay_info = (struct vs_plane_overlay_info *)&dc_info->overlay[i];
> +
> +		possible_crtc = drm_crtc_mask(&dc->crtc[0]->base) |
> +				drm_crtc_mask(&dc->crtc[1]->base);
> +
> +		plane = vs_plane_overlay_create(drm_dev, overlay_info,
> +						dc_info->layer_num, possible_crtc);
> +		if (IS_ERR(plane)) {
> +			dev_err(dev, "failed to construct plane\n");
> +			return PTR_ERR(plane);
> +		}
> +
> +		plane->id = overlay_info->id;
> +		dc->planes[plane->id].id = overlay_info->id;
> +		dc->planes[plane->id].offset = get_addr_offset(overlay_info->id);
> +	}
> +
> +	for (i = 0; i < dc_info->cursor_num; i++) {
> +		cursor_info = (struct vs_plane_cursor_info *)&dc_info->cursor[i];
> +
> +		if (cursor_info->id == CURSOR_PLANE_0)
> +			possible_crtc = drm_crtc_mask(&dc->crtc[0]->base);
> +		else
> +			possible_crtc = drm_crtc_mask(&dc->crtc[1]->base);
> +
> +		plane = vs_plane_cursor_create(drm_dev, cursor_info, possible_crtc);
> +		if (IS_ERR(plane)) {
> +			dev_err(dev, "failed to construct plane\n");
> +			return PTR_ERR(plane);
> +		}
> +
> +		plane->id = cursor_info->id;
> +		dc->planes[plane->id].id = cursor_info->id;
> +		dc->planes[plane->id].offset = get_addr_offset(cursor_info->id);
> +
> +		if (cursor_info->id == CURSOR_PLANE_0)
> +			dc->crtc[0]->base.cursor = &plane->base;
> +		else
> +			dc->crtc[1]->base.cursor = &plane->base;
> +		drm_dev->mode_config.cursor_width =
> +			max_t(u32, drm_dev->mode_config.cursor_width,
> +			      cursor_info->max_width);
> +		drm_dev->mode_config.cursor_height =
> +			max_t(u32, drm_dev->mode_config.cursor_height,
> +			      cursor_info->max_height);
> +		}
> +
> +	drm_dev->mode_config.min_width = min_width;
> +	drm_dev->mode_config.min_height = min_heigth;
> +	drm_dev->mode_config.max_width = max_width;
> +	drm_dev->mode_config.max_height = max_height;

I thought that I saw mode_config.min/max being initialized.

> +
> +	if (dc_info->pitch_alignment > priv->pitch_alignment)
> +		priv->pitch_alignment = dc_info->pitch_alignment;
> +
> +	return 0;
> +}
> +
> +static int vs_load(struct vs_drm_device *priv)
> +{
> +	int ret;
> +
> +	ret = clk_bulk_prepare_enable(priv->clk_count, priv->clks);
> +	if (ret)
> +		return ret;
> +
> +	reset_control_deassert(priv->rsts);
> +
> +	ret = dc_hw_init(&priv->dc);
> +	if (ret) {
> +		DRM_ERROR("failed to init DC HW\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int vs_drm_bind(struct device *dev)
> +{
> +	struct vs_drm_device *priv;
> +	int ret;
> +	struct drm_device *drm_dev;
> +
> +	priv = devm_drm_dev_alloc(dev, &vs_drm_driver, struct vs_drm_device, base);
> +	if (IS_ERR(priv))
> +		return PTR_ERR(priv);
> +
> +	priv->pitch_alignment = 64;
> +	drm_dev = &priv->base;
> +	dev_set_drvdata(dev, drm_dev);
> +
> +	ret = dma_set_coherent_mask(drm_dev->dev, DMA_BIT_MASK(40));
> +	if (ret)
> +		return ret;
> +
> +	ret = vs_drm_device_init_res(priv);
> +	if (ret)
> +		return ret;
> +
> +	vs_mode_config_init(drm_dev);
> +
> +	/* Remove existing drivers that may own the framebuffer memory. */
> +	ret = drm_aperture_remove_framebuffers(&vs_drm_driver);
> +	if (ret)
> +		return ret;
> +
> +	ret = vs_drm_device_crtc_plane_create(priv);
> +	if (ret) {
> +		DRM_ERROR("Failed to create ctrc and plane\n");
> +		return ret;
> +	}
> +
> +	ret = vs_load(priv);
> +	if (ret)
> +		return ret;
> +
> +	/* Now try and bind all our sub-components */
> +	ret = component_bind_all(dev, drm_dev);
> +	if (ret) {
> +		ret = -EPROBE_DEFER;
> +		goto unload;
> +	}
> +	ret = drm_vblank_init(drm_dev, drm_dev->mode_config.num_crtc);
> +	if (ret)
> +		goto err_unbind_all;
> +
> +	drm_mode_config_reset(drm_dev);
> +
> +	ret = drmm_kms_helper_poll_init(drm_dev);
> +	if (ret)
> +		goto err_unbind_all;
> +
> +	ret = drm_dev_register(drm_dev, 0);
> +	if (ret)
> +		goto err_unbind_all;
> +
> +	drm_fbdev_generic_setup(drm_dev, 32);
> +
> +	return 0;
> +
> +err_unbind_all:
> +	component_unbind_all(drm_dev->dev, drm_dev);
> +unload:
> +	reset_control_assert(priv->rsts);
> +	clk_bulk_disable_unprepare(priv->clk_count, priv->clks);
> +	return ret;
> +
> +}
> +
> +static void vs_drm_unbind(struct device *dev)
> +{
> +	struct drm_device *drm_dev = dev_get_drvdata(dev);
> +	struct vs_drm_device *priv = to_vs_drm_private(drm_dev);
> +
> +	reset_control_assert(priv->rsts);
> +	clk_bulk_disable_unprepare(priv->clk_count, priv->clks);
> +
> +	drm_dev_unregister(drm_dev);
> +	drm_atomic_helper_shutdown(drm_dev);
> +	component_unbind_all(drm_dev->dev, drm_dev);
> +}
> +
> +static const struct component_master_ops vs_drm_ops = {
> +	.bind = vs_drm_bind,
> +	.unbind = vs_drm_unbind,
> +};
> +
> +static struct platform_driver *drm_sub_drivers[] = {
> +
> +};
> +
> +static struct component_match *vs_add_external_components(struct device *dev)
> +{
> +	struct component_match *match = NULL;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(drm_sub_drivers); ++i) {
> +		struct platform_driver *drv = drm_sub_drivers[i];
> +		struct device *p = NULL, *d;
> +
> +		while ((d = platform_find_device_by_driver(p, &drv->driver))) {
> +			put_device(p);
> +
> +			drm_of_component_match_add(dev, &match, component_compare_of,
> +						   d->of_node);
> +			p = d;
> +		}
> +		put_device(p);

What about just going through the graph connections instead and adding
them?

> +	}
> +
> +	return match ? match : ERR_PTR(-ENODEV);
> +}
> +
> +static int vs_drm_platform_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct component_match *match;
> +
> +	/* all the planes and CRTC would be created in this platform device
> +	 * , so external components are encoder + connector or self-defined

Comma should go to the previous line.

> +	 * encoder.
> +	 */
> +	match = vs_add_external_components(dev);
> +	if (IS_ERR(match))
> +		return PTR_ERR(match);
> +
> +	return component_master_add_with_match(dev, &vs_drm_ops, match);
> +}
> +
> +static int vs_drm_platform_remove(struct platform_device *pdev)
> +{
> +	component_master_del(&pdev->dev, &vs_drm_ops);
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int vs_drm_suspend(struct device *dev)
> +{
> +	return drm_mode_config_helper_suspend(dev_get_drvdata(dev));
> +}
> +
> +static int vs_drm_resume(struct device *dev)
> +{
> +	drm_mode_config_helper_resume(dev_get_drvdata(dev));
> +
> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(vs_drm_pm_ops, vs_drm_suspend, vs_drm_resume);
> +
> +static const struct of_device_id vs_drm_dt_ids[] = {
> +	{ .compatible = "starfive,jh7110-dc8200", .data = &dc8200_info,},
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, vs_drm_dt_ids);
> +
> +static struct platform_driver vs_drm_platform_driver = {
> +	.probe = vs_drm_platform_probe,
> +	.remove = vs_drm_platform_remove,
> +
> +	.driver = {
> +		.name = DRV_NAME,
> +		.of_match_table = vs_drm_dt_ids,
> +		.pm = &vs_drm_pm_ops,
> +	},
> +};
> +
> +static int __init vs_drm_init(void)
> +{
> +	int ret;
> +
> +	ret = platform_register_drivers(drm_sub_drivers, ARRAY_SIZE(drm_sub_drivers));
> +	if (ret)
> +		return ret;
> +
> +	ret = drm_platform_driver_register(&vs_drm_platform_driver);
> +	if (ret)
> +		platform_unregister_drivers(drm_sub_drivers, ARRAY_SIZE(drm_sub_drivers));
> +
> +	return ret;
> +}
> +
> +static void __exit vs_drm_fini(void)
> +{
> +	platform_driver_unregister(&vs_drm_platform_driver);
> +	platform_unregister_drivers(drm_sub_drivers, ARRAY_SIZE(drm_sub_drivers));
> +}
> +
> +late_initcall_sync(vs_drm_init);

Why _sync?

> +module_exit(vs_drm_fini);
> +
> +MODULE_DESCRIPTION("VeriSilicon DRM Driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.27.0
> 

-- 
With best wishes
Dmitry

