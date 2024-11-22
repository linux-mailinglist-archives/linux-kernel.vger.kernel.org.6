Return-Path: <linux-kernel+bounces-417605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C49D99D5688
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 01:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42E631F236C4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 00:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF98A50;
	Fri, 22 Nov 2024 00:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LlxZxPb1"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6263C0C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 00:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732233941; cv=none; b=SqJPRNHAZ3nSNdQ/fo2i6tML3+C9qUncV8AiSefLboKBaNMG78+qHnujvwAtNkIRuyHBHspTHjV0LW1IPadUasju6Qr0Isnr1wDinW22QxtJZKugKMT+enMygTjtjYuG9hGa5QxXLJt+IFpBQI2bB27zuVL1EKURdmUuaF7AqWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732233941; c=relaxed/simple;
	bh=g3qyTejlxBsm7CcUloGJMGfZgM/UjN7NBBtoVLDD+CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzdTB5bAVR2pZTlMaUPHbbPtxPR40yTDoAmecHeIaeICRQeez4hZyDn/C1SuLfX39D1b+b5J+EIrs9z6tv6buFOOcyNmC/pbauY4tDpaIPYnvEeSHeJEaY9RnSWHPGf471rX2daRi/VBsiXCJHzfVLkaBadbeoaTt6OUKXNeWi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LlxZxPb1; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539d9fffea1so1480262e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 16:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732233937; x=1732838737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1KAyJQfZm0CmYLeM6T1KNFUS7Aq70PuFpi7a8qa4S44=;
        b=LlxZxPb1Rt8I2WwAyk+RMQ6UvpB8IzUcQvd9ScCza0LZTquBS6HnbvLElpnmcyanv8
         YzvXmwgJdJOlVO3KaGsV6zrPUvPsv88kQE36Ei2tIGGQ7/sKuc+atlUvDZvVKOnlZNrD
         hIk7Z55MeeFebpqIUt9bO5I0Jyj2KUNmzNdcC4xlzeOsBG96pM6h9//1zBZ7xlRQi5hH
         7sPjk6SOVLyLzsbEuCF4Od+H7NNWkjTPxFBK8VWFuHAZ2Vy21PT4UtGvzsNzRvV35iDv
         0Aaelw/PFBpB8XWb76cLaWMAac/XaN6980HFG7agH2HRnLhs8Zqzuao9Z/CZJhdLnz86
         NVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732233937; x=1732838737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KAyJQfZm0CmYLeM6T1KNFUS7Aq70PuFpi7a8qa4S44=;
        b=ivpCdzqv4Z8c9mrHvqDCuBpzOpVchla42fNdBRGD1NUgUxnsAjwoVm4tsxzBR4cjTO
         uYLR5dKAXgkPaHNB2FQPnXF0dCtKmvSHuzL9ftFydJV3Ud59KAGl2OyevWt8zjN6sHoN
         7dz0wW8JEn5SEyKntlHy7HoMb2027DdhxMir7deaUpll0OwQi8uX+4sRMaMEg5m/5MSu
         zVDd26mtt7ADvNKi08BCalX2BwswYVP8poicyU2UKPvPYOLesGp8B+XU+nzy2FK8+9nG
         OlPhe/Gab39NQzxb6ehgTW5tsqwjAJVWA/q3o2in2ZeoXKsoLSdvmzJAHRd5dlYtXbsS
         jBKw==
X-Forwarded-Encrypted: i=1; AJvYcCXXlA0g8OvRI2FYKWlgarnHvkU9r3GejO0Anzs8z7kvIlPspweY+ezBUMkQnZTf7nr+Noscfqs7tUed2m4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9tPlGTZgwB9+eRxIkLRBdvyz+thlrYRfq58dOYtNL6RqquEe8
	jyVLf6sqHsr5OBIlKLssfYQB/H/vWFd9KE2HOfcfvcx5juPYD1ANUc2tng53c1c=
X-Gm-Gg: ASbGncs/lG69yGz+mqAeAFqK1NQU2R6QL/JD8R/2QpndSRdGNb7UP9cEXhjryu3ChXh
	zB/0AvCeoqJxCY8fOii3tN76zelqhNfT6Os1JizBvJ9wdxu3ydT5cOmrzg1g1MgI0lYJXgWDXBZ
	Y51afnH+JiRErpdc+q1bOdrJaUfHW2lUh4wskrV8zYk7lUk8rQcoGGaCDs0cMXAvte8Wy5D4xd1
	Q2Ak7hF0EarWPEFQbfZTuPgRus24xIFRq/NU623T/YgMn5snuv9C0yeFi5OsV0IF7Sp9YMOPo1N
	HzI/7BEZkEu6gjjfeQAGuGvUZE9DKw==
X-Google-Smtp-Source: AGHT+IGIMj4eDI4++nV9lsviqxg12ESwR9WEilZyyjFk+Pe0y3db1ZelPCRJMMwTSxiydGqYm4vhag==
X-Received: by 2002:a05:6512:b9a:b0:53d:d137:d7a4 with SMTP id 2adb3069b0e04-53dd3aac10bmr293144e87.53.1732233937136;
        Thu, 21 Nov 2024 16:05:37 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2445843sm123234e87.19.2024.11.21.16.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 16:05:35 -0800 (PST)
Date: Fri, 22 Nov 2024 02:05:33 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: keith zhao <keith.zhao@starfivetech.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com, 
	william.qiu@starfivetech.com, xingyu.wu@starfivetech.com, kernel@esmil.dk, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	p.zabel@pengutronix.de, changhuang.liang@starfivetech.com, jack.zhu@starfivetech.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/9] drm/vs: Add Hardware Functions for VS DC8200
Message-ID: <kuoayjr6gfwsq3zbdeafmzx3kw27amkhmljlbpk4brgjkizm37@7wwjwg3tckjz>
References: <20241120061848.196754-1-keith.zhao@starfivetech.com>
 <20241120061848.196754-5-keith.zhao@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120061848.196754-5-keith.zhao@starfivetech.com>

On Wed, Nov 20, 2024 at 02:18:43PM +0800, keith zhao wrote:
> This commit introduces hardware-based APIs for
> the VS DRM related to the DC8200

This doesn't describe anything. I've asked to describe the hardware.
Also please don't use phrases as "This commit does this and this". See
Documentation/process/submitting-patches.rst

> 
> Signed-off-by: keith zhao <keith.zhao@starfivetech.com>
> ---
>  MAINTAINERS                            |    1 +
>  drivers/gpu/drm/Kconfig                |    2 +
>  drivers/gpu/drm/Makefile               |    1 +
>  drivers/gpu/drm/verisilicon/Kconfig    |   13 +
>  drivers/gpu/drm/verisilicon/Makefile   |    5 +
>  drivers/gpu/drm/verisilicon/vs_dc_hw.c | 1104 ++++++++++++++++++++++++
>  drivers/gpu/drm/verisilicon/vs_dc_hw.h |  492 +++++++++++
>  drivers/gpu/drm/verisilicon/vs_type.h  |   54 ++
>  8 files changed, 1672 insertions(+)
>  create mode 100644 drivers/gpu/drm/verisilicon/Kconfig
>  create mode 100644 drivers/gpu/drm/verisilicon/Makefile
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_dc_hw.c
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_dc_hw.h
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_type.h
> 

[...]

> +
> +struct dc_hw {
> +	enum dc_hw_out		out[DC_DISPLAY_NUM];
> +	void __iomem		*hi_base;
> +	void __iomem		*reg_base;
> +	struct dc_hw_plane_reg	reg[DC_LAYER_NUM];
> +
> +	struct dc_hw_gamma	gamma[DC_DISPLAY_NUM];
> +	struct vs_dc_info	*info;
> +};
> +
> +struct vs_dc_plane {
> +	enum dc_hw_plane_id id;
> +	u32 offset;
> +};
> +
> +struct vs_dc {
> +	struct vs_crtc		*crtc[DC_DISPLAY_NUM];

"Not defined here. Please drop and add when it is actually defined.",
this was in v4.

> +	struct dc_hw		hw;
> +
> +	struct vs_dc_plane	planes[PLANE_NUM];
> +};
> +
> +int dc_hw_init(struct vs_dc *dc);
> +void dc_hw_disable_plane(struct vs_dc *dc, u8 id);
> +void dc_hw_update_cursor(struct dc_hw *hw, u8 id, dma_addr_t dma_addr,
> +			 u32 crtc_w, u32 crtc_x, u32 crtc_y,
> +			 s32 hotspot_x, int32_t hotspot_y);
> +void dc_hw_disable_cursor(struct dc_hw *hw, u8 id);
> +void dc_hw_update_gamma(struct dc_hw *hw, u8 id, u16 index,
> +			u16 r, u16 g, u16 b);
> +void dc_hw_enable_gamma(struct dc_hw *hw, u8 id, bool enable);
> +void dc_hw_enable(struct dc_hw *hw, int id, struct drm_display_mode *mode,
> +		  u8 encoder_type, u32 output_fmt);
> +void dc_hw_disable(struct dc_hw *hw, int id);
> +void dc_hw_enable_interrupt(struct dc_hw *hw);
> +void dc_hw_disable_interrupt(struct dc_hw *hw);
> +void dc_hw_get_interrupt(struct dc_hw *hw, u8 *status);
> +void dc_hw_enable_shadow_register(struct vs_dc *dc, bool enable);
> +void dc_hw_set_out(struct dc_hw *hw, enum dc_hw_out out, u8 id);
> +void dc_hw_commit(struct dc_hw *hw);
> +void dc_plane_hw_update_format_colorspace(struct vs_dc *dc, u32 format,
> +					  enum drm_color_encoding encoding, u8 id, bool is_yuv);
> +void dc_plane_hw_update_address(struct vs_dc *dc, u8 id, u32 format, dma_addr_t *dma_addr,
> +				struct drm_framebuffer *drm_fb, struct drm_rect *src);
> +void dc_plane_hw_update_format(struct vs_dc *dc, u32 format, enum drm_color_encoding encoding,
> +			       unsigned int rotation, bool visible, unsigned int zpos,
> +			       u8 id, u8 display_id);
> +void dc_plane_hw_update_scale(struct vs_dc *dc, struct drm_rect *src, struct drm_rect *dst,
> +			      u8 id, u8 display_id, unsigned int rotation);
> +void dc_plane_hw_update_blend(struct vs_dc *dc, u16 alpha, u16 pixel_blend_mode,
> +			      u8 id, u8 display_id);
> +
> +#endif /* __VS_DC_HW_H__ */
> diff --git a/drivers/gpu/drm/verisilicon/vs_type.h b/drivers/gpu/drm/verisilicon/vs_type.h
> new file mode 100644
> index 000000000000..e9c4ef3cacd6
> --- /dev/null
> +++ b/drivers/gpu/drm/verisilicon/vs_type.h
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) VeriSilicon Holdings Co., Ltd.
> + */
> +
> +#ifndef __VS_TYPE_H__
> +#define __VS_TYPE_H__
> +
> +enum drm_plane_type;
> +
> +struct vs_plane_data {
> +	unsigned int num_formats;
> +	const u32 *formats;
> +	u8 num_modifiers;
> +	const u64 *modifiers;
> +	unsigned int min_width;
> +	unsigned int min_height;
> +	unsigned int max_width;
> +	unsigned int max_height;
> +	unsigned int rotation;
> +	unsigned int blend_mode;
> +	unsigned int color_encoding;
> +	int min_scale; /* 16.16 fixed point */
> +	int max_scale; /* 16.16 fixed point */
> +	u8   zpos;
> +};

Doesn't seem to be used in this patch. I think in v4 I've already asked
to drop everything (data types, fields, defines) that are not used by
_this_ patch. Readd them later, as required.

> +
> +struct vs_plane_info {
> +	u32 id;
> +	const struct vs_plane_data *data;
> +	enum drm_plane_type type;
> +};
> +
> +struct vs_dc_info {
> +	const char *name;
> +
> +	u8 panel_num;
> +
> +	/* planes */
> +	u8 plane_num;
> +
> +	u8 layer_num;
> +	u8 primary_num;
> +	u8 overlay_num;
> +	u8 cursor_num;
> +	const struct vs_plane_info *info;
> +	/* 0 means no gamma LUT */
> +	u16 gamma_size;
> +	u8 gamma_bits;
> +
> +	u16 pitch_alignment;
> +};
> +
> +#endif /* __VS_TYPE_H__ */
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

