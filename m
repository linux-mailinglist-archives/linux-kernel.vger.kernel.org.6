Return-Path: <linux-kernel+bounces-417611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D409D5699
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 01:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A0BE282D3F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 00:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A184A04;
	Fri, 22 Nov 2024 00:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R83kQtBF"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74754A01
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 00:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732234595; cv=none; b=o0oILWmL37VrraqnLjPumJU+FUURBTUUfiMeHiIqvqwFV5ow3NMVBmenF/DSt8W33wtL+PFX06NNRFZ/eGHlMncVcIpdItM6w49RFBTuEGCPGj/WJwviOSMdxnqrW4E/bI0Gg5gdxaJeW1tgpJYKASAgapZbEmP0sgPvVUevNpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732234595; c=relaxed/simple;
	bh=JlbF7Li8YyKi//xP7+jFYieFIUc4DPF/sUvdjZtUzB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPAnmo+AC3ZmRWleD1yFmq5tgNOYr8LysLf84hAbLM90nQcjOOHNdSlyfhRu79aFsDPZcQ3U6E7z0kVz7EKVNH2M1xhsXpzKbH5J5+cVWrwWVqYnsZF4wShzF8kM8J6Z2ubULBCj70zovEagUDUpEGTgnHusJ2AVAS6SFmDx2/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R83kQtBF; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539fb49c64aso2593264e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 16:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732234591; x=1732839391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cKZxpNEbboMNS8++9aS12zEht9Y65UKuYuRZmpzKiT4=;
        b=R83kQtBFX2oQMX3XRoT3fLt7vTYc9jQgJEAT15cfA5VdxXw0DBeFao+j5pDmUvt8K0
         CZMf8+WwukywCtKMM7yHm0rxQCh8Xu3yq3n+l5fwBjE2NA95/+BIPlmJOF3Kdy7HI/ti
         ulv9PB3kpOzjZ2FgKhHI5ulZ7H8kHi7M5ihLxTjRuZ/Fcrl3h/ZjE3r0LSrSaqVIOHvJ
         7y+U3qqurZkNTB66Mf1tsgKcMBvPISrxSPOk12Dl621cARAUjHRWKwD/QQvyaWT5OC0r
         4hIredagd2q6Ta60B+Hhcdk7FpDqFWxA6c1fm/uwbypBBzQXvm0D2/WWyDvX8kIUHcYH
         5Z+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732234591; x=1732839391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKZxpNEbboMNS8++9aS12zEht9Y65UKuYuRZmpzKiT4=;
        b=cAZy8D/Ua30TevytsQXDiJ/DO/ERVo3DbQrgvw/WS6q4WGKaE1VFSkAMcjWc8ac7VT
         UjnkikNltYj3OgfSbBhaxVatFeXJc85rgGKRAd9FOOtkPutuJ6j2Sh4t0cFr5C9OgQla
         bAnyOxm7me3YrzzrWYmc7U6uEpexz9xV91YnJotEfjl/mTh44v3zJUeCFXtYxbaIcFZS
         EjLrK/+tEXvUBEVSOsqf0sarq4cx7frRNc/37IitChLQRCZsjEaM+Lx6qjuJn7Mhsrdv
         oHrD7cZG1e5/AANAT+Uh2OcBUTCLs+X1OAyceqzO/I+X77ZZmHvK86C9OpFfXKZ0bJwr
         GOMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMqGkVQGvoi7yq8nuXvhdOM7FJoYVlbV+6jnsBOT5c1Tx7CLZpEIHleDUkYCptZ+IZOBD67dvcD3FpqGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcPiOFJa4evl/CA2lFYrdU03fwhrGEWA5u3dD8zwwk8Wc7nYat
	4ABr0zwY2PHVHN763G8D2aMKtxn9xyHKmPD4ukEmPNGI8kHQQL3Gst+Rw32tNsM=
X-Gm-Gg: ASbGncv3MJKyMfXP4I6fZPslbKLrZojHQAbpQBzHnOO6uMORw9Po4/yoQLfAGdkh71A
	YXVLAIIMwe9+UuB9y/jQJs+W+nib7BZVEcFoYi2S8HBIbLM7W8f2A7i/Q9Wvzezzkq77aJL9RM+
	av2rU90ZRPMfNLtDbOmBFDF0G5AKlOloc5RiaFXQBFQvPyKUvXrNM5w4YwTg5ylGgzIGqkDKiU1
	XT2UPaIfyS903/BvyqwSJrf84B/3t19Ym3CoiPMk2tAb8K7kGS0d/2lKcyJcjRRIt1y9KvG+RuE
	tLyxJ2GiJDWD6m3Zo5vD6/txsfzQwA==
X-Google-Smtp-Source: AGHT+IG3I7agYfE+lXLVl0nJViza9WZBwUY7lMLfC1kqDU5PNkr9N4Ilw1yFPu1gD/pQOCylnPumOw==
X-Received: by 2002:a05:6512:3406:b0:53d:a4e0:c3ca with SMTP id 2adb3069b0e04-53dd39a4eb0mr480338e87.43.1732234590835;
        Thu, 21 Nov 2024 16:16:30 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd4253c64sm28519e87.107.2024.11.21.16.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 16:16:29 -0800 (PST)
Date: Fri, 22 Nov 2024 02:16:26 +0200
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
Subject: Re: [PATCH v5 6/9] drm/vs: Add CRTC Functions
Message-ID: <hqdjfne4svqbxfr2cojrdd5bvggl3zyucgztbdsqyzhhh7tw5m@2iib5audsluy>
References: <20241120061848.196754-1-keith.zhao@starfivetech.com>
 <20241120061848.196754-7-keith.zhao@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120061848.196754-7-keith.zhao@starfivetech.com>

On Wed, Nov 20, 2024 at 02:18:45PM +0800, keith zhao wrote:
> This commit adds CRTC functions and helper functions
> to the VS DRM subsystem,
> enhancing support for display management and configurations.
> 
> Signed-off-by: keith zhao <keith.zhao@starfivetech.com>
> ---
>  drivers/gpu/drm/verisilicon/Makefile  |   3 +-
>  drivers/gpu/drm/verisilicon/vs_crtc.c | 241 ++++++++++++++++++++++++++
>  drivers/gpu/drm/verisilicon/vs_crtc.h |  42 +++++
>  drivers/gpu/drm/verisilicon/vs_drv.h  |  41 +++++
>  4 files changed, 326 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_crtc.c
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_crtc.h
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_drv.h
> 
> diff --git a/drivers/gpu/drm/verisilicon/Makefile b/drivers/gpu/drm/verisilicon/Makefile
> index 842867dad4cb..37f6a4db2a12 100644
> --- a/drivers/gpu/drm/verisilicon/Makefile
> +++ b/drivers/gpu/drm/verisilicon/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  vs_drm-objs := vs_dc_hw.o \
> -	       vs_modeset.o
> +	       vs_modeset.o \
> +	       vs_crtc.o
>  
>  obj-$(CONFIG_DRM_VERISILICON_DC8200) += vs_drm.o
> diff --git a/drivers/gpu/drm/verisilicon/vs_crtc.c b/drivers/gpu/drm/verisilicon/vs_crtc.c
> new file mode 100644
> index 000000000000..45ce28960e27
> --- /dev/null
> +++ b/drivers/gpu/drm/verisilicon/vs_crtc.c
> @@ -0,0 +1,241 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) VeriSilicon Holdings Co., Ltd.
> + *
> + */
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_atomic.h>
> +#include <drm/drm_vblank.h>
> +#include <drm/drm_print.h>
> +
> +#include "vs_crtc.h"
> +#include "vs_drv.h"
> +
> +static void vs_crtc_atomic_destroy_state(struct drm_crtc *crtc,
> +					 struct drm_crtc_state *state)
> +{
> +	__drm_atomic_helper_crtc_destroy_state(state);
> +	kfree(to_vs_crtc_state(state));
> +}
> +
> +static void vs_crtc_reset(struct drm_crtc *crtc)
> +{
> +	struct vs_crtc_state *state;
> +
> +	if (crtc->state)
> +		vs_crtc_atomic_destroy_state(crtc, crtc->state);
> +
> +	state = kzalloc(sizeof(*state), GFP_KERNEL);
> +	if (!state)
> +		return;
> +
> +	__drm_atomic_helper_crtc_reset(crtc, &state->base);
> +}
> +
> +static struct drm_crtc_state *
> +vs_crtc_atomic_duplicate_state(struct drm_crtc *crtc)
> +{
> +	struct vs_crtc_state *old_state;
> +	struct vs_crtc_state *state;
> +
> +	if (!crtc->state)
> +		return NULL;
> +
> +	old_state = to_vs_crtc_state(crtc->state);
> +
> +	state = kmemdup(old_state, sizeof(*old_state), GFP_KERNEL);
> +		if (!state)
> +			return NULL;
> +
> +	__drm_atomic_helper_crtc_duplicate_state(crtc, &state->base);
> +
> +	return &state->base;
> +}
> +
> +static int vs_crtc_enable_vblank(struct drm_crtc *crtc)
> +{
> +	struct vs_drm_device *priv = to_vs_drm_private(crtc->dev);
> +	struct vs_dc *dc = &priv->dc;
> +
> +	dc_hw_enable_interrupt(&dc->hw);
> +
> +	return 0;
> +}
> +
> +static void vs_crtc_disable_vblank(struct drm_crtc *crtc)
> +{
> +	struct vs_drm_device *priv = to_vs_drm_private(crtc->dev);
> +	struct vs_dc *dc = &priv->dc;
> +
> +	dc_hw_disable_interrupt(&dc->hw);
> +}
> +
> +static const struct drm_crtc_funcs vs_crtc_funcs = {
> +	.set_config		= drm_atomic_helper_set_config,
> +	.page_flip		= drm_atomic_helper_page_flip,
> +	.reset			= vs_crtc_reset,
> +	.atomic_duplicate_state = vs_crtc_atomic_duplicate_state,
> +	.atomic_destroy_state	= vs_crtc_atomic_destroy_state,
> +	.enable_vblank		= vs_crtc_enable_vblank,
> +	.disable_vblank		= vs_crtc_disable_vblank,
> +};
> +
> +static void vs_crtc_atomic_enable(struct drm_crtc *crtc,
> +				  struct drm_atomic_state *state)
> +{
> +	struct vs_drm_device *priv = to_vs_drm_private(crtc->dev);
> +	struct vs_dc *dc = &priv->dc;
> +
> +	struct vs_crtc_state *crtc_state = to_vs_crtc_state(crtc->state);
> +	struct drm_display_mode *mode = &crtc->state->adjusted_mode;
> +	int id;
> +
> +	id = to_vs_display_id(crtc);
> +	if (crtc_state->encoder_type == DRM_MODE_ENCODER_DSI) {
> +		dc_hw_set_out(&dc->hw, OUT_DPI, id);
> +		clk_set_rate(priv->clks[7].clk, mode->clock * 1000);
> +		clk_set_parent(priv->clks[5].clk, priv->clks[7].clk);
> +	} else {
> +		dc_hw_set_out(&dc->hw, OUT_DP, id);
> +		clk_set_parent(priv->clks[4].clk, priv->clks[6].clk);
> +	}

Can this go to the encoder's atomic_enable() instead? Also it would be
nice to have a less magic code here. What are the clocks 4-7?

> +
> +	dc_hw_enable(&dc->hw, id, mode, crtc_state->encoder_type, crtc_state->output_fmt);
> +
> +	enable_irq(priv->irq);
> +
> +	drm_crtc_vblank_on(crtc);
> +}
> +
> +static void vs_crtc_atomic_disable(struct drm_crtc *crtc,
> +				   struct drm_atomic_state *state)
> +{
> +	struct vs_drm_device *priv = to_vs_drm_private(crtc->dev);
> +	struct vs_dc *dc = &priv->dc;
> +	int id;
> +
> +	drm_crtc_vblank_off(crtc);
> +
> +	disable_irq(priv->irq);
> +
> +	id = to_vs_display_id(crtc);
> +	dc_hw_disable(&dc->hw, id);
> +
> +	if (crtc->state->event && !crtc->state->active) {
> +		spin_lock_irq(&crtc->dev->event_lock);
> +		drm_crtc_send_vblank_event(crtc, crtc->state->event);
> +		crtc->state->event = NULL;
> +		spin_unlock_irq(&crtc->dev->event_lock);
> +	}
> +}
> +
> +static void vs_dc_set_gamma(struct vs_dc *dc, struct drm_crtc *crtc,
> +			    struct drm_color_lut *lut, unsigned int size)
> +{
> +	u16 i, r, g, b;
> +	u8 bits, id;
> +
> +	if (size != dc->hw.info->gamma_size) {
> +		drm_err(crtc->dev, "gamma size does not match!\n");
> +		return;
> +	}
> +
> +	id = to_vs_display_id(crtc);
> +
> +	bits = dc->hw.info->gamma_bits;
> +	for (i = 0; i < size; i++) {
> +		r = drm_color_lut_extract(lut[i].red, bits);
> +		g = drm_color_lut_extract(lut[i].green, bits);
> +		b = drm_color_lut_extract(lut[i].blue, bits);
> +		dc_hw_update_gamma(&dc->hw, id, i, r, g, b);
> +
> +		if (i >= dc->hw.info->gamma_size)
> +			return;
> +
> +		dc->hw.gamma[id].gamma[i][0] = r;
> +		dc->hw.gamma[id].gamma[i][1] = g;
> +		dc->hw.gamma[id].gamma[i][2] = b;
> +	}
> +}
> +
> +static void vs_crtc_atomic_begin(struct drm_crtc *crtc,
> +				 struct drm_atomic_state *state)
> +{
> +	struct drm_crtc_state *new_state = drm_atomic_get_new_crtc_state(state,
> +									  crtc);
> +
> +	struct drm_property_blob *blob = new_state->gamma_lut;
> +	struct drm_color_lut *lut;
> +	struct vs_drm_device *priv = to_vs_drm_private(crtc->dev);
> +	struct vs_dc *dc = &priv->dc;
> +	u8 id;
> +
> +	dc_hw_enable_shadow_register(dc, false);
> +
> +	id = to_vs_display_id(crtc);
> +	if (new_state->color_mgmt_changed) {
> +		if (blob && blob->length) {
> +			lut = blob->data;
> +			vs_dc_set_gamma(dc, crtc, lut,
> +					blob->length / sizeof(*lut));
> +			dc_hw_enable_gamma(&dc->hw, id, true);
> +		} else {
> +			dc_hw_enable_gamma(&dc->hw, id, false);
> +		}
> +	}
> +}
> +
> +static void vs_crtc_atomic_flush(struct drm_crtc *crtc,
> +				 struct drm_atomic_state *state)
> +{
> +	struct drm_pending_vblank_event *event = crtc->state->event;
> +	struct vs_drm_device *priv = to_vs_drm_private(crtc->dev);
> +	struct vs_dc *dc = &priv->dc;
> +
> +	if (event) {
> +		WARN_ON(drm_crtc_vblank_get(crtc) != 0);
> +
> +		spin_lock_irq(&crtc->dev->event_lock);
> +		drm_crtc_arm_vblank_event(crtc, event);
> +		crtc->state->event = NULL;
> +		spin_unlock_irq(&crtc->dev->event_lock);
> +	}
> +
> +	dc_hw_enable_shadow_register(dc, true);
> +}
> +
> +static const struct drm_crtc_helper_funcs vs_crtc_helper_funcs = {
> +	.atomic_check = drm_crtc_helper_atomic_check,
> +	.atomic_enable	= vs_crtc_atomic_enable,
> +	.atomic_disable = vs_crtc_atomic_disable,
> +	.atomic_begin	= vs_crtc_atomic_begin,
> +	.atomic_flush	= vs_crtc_atomic_flush,
> +};
> +
> +struct vs_crtc *vs_crtc_create(struct drm_device *drm_dev,
> +			       struct vs_dc_info *info)
> +{
> +	struct vs_crtc *crtc;
> +	int ret;
> +
> +	if (!info)
> +		return NULL;
> +
> +	crtc = drmm_crtc_alloc_with_planes(drm_dev, struct vs_crtc, base, NULL,
> +					   NULL, &vs_crtc_funcs,
> +					   info->name ? info->name : NULL);
> +
> +	drm_crtc_helper_add(&crtc->base, &vs_crtc_helper_funcs);
> +
> +	if (info->gamma_size) {
> +		ret = drm_mode_crtc_set_gamma_size(&crtc->base,
> +						   info->gamma_size);
> +		if (ret)
> +			return NULL;
> +
> +		drm_crtc_enable_color_mgmt(&crtc->base, 0, false,
> +					   info->gamma_size);
> +	}
> +
> +	return crtc;
> +}
> diff --git a/drivers/gpu/drm/verisilicon/vs_crtc.h b/drivers/gpu/drm/verisilicon/vs_crtc.h
> new file mode 100644
> index 000000000000..58aa7a77d94e
> --- /dev/null
> +++ b/drivers/gpu/drm/verisilicon/vs_crtc.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) VeriSilicon Holdings Co., Ltd.
> + */
> +
> +#ifndef __VS_CRTC_H__
> +#define __VS_CRTC_H__
> +
> +#include <drm/drm_crtc.h>
> +#include <drm/drm_crtc_helper.h>

I thought you've commented about removing them.

> +
> +#include "vs_type.h"
> +
> +struct vs_crtc_state {
> +	struct drm_crtc_state base;
> +
> +	u32 output_fmt;
> +	u8 encoder_type;
> +	u8 bpp;
> +};
> +
> +struct vs_crtc {
> +	struct drm_crtc base;
> +	struct device *dev;
> +	u8 index;
> +};

Which modules do need to look into CRTC and CRTC state?

> +
> +static inline u8 to_vs_display_id(struct drm_crtc *crtc)
> +{
> +	return container_of(crtc, struct vs_crtc, base)->index;
> +}
> +
> +struct vs_crtc *vs_crtc_create(struct drm_device *drm_dev,
> +			       struct vs_dc_info *info);
> +
> +static inline struct vs_crtc_state *
> +to_vs_crtc_state(struct drm_crtc_state *state)
> +{
> +	return container_of(state, struct vs_crtc_state, base);
> +}
> +
> +#endif /* __VS_CRTC_H__ */
> diff --git a/drivers/gpu/drm/verisilicon/vs_drv.h b/drivers/gpu/drm/verisilicon/vs_drv.h
> new file mode 100644
> index 000000000000..dc6efb093205
> --- /dev/null
> +++ b/drivers/gpu/drm/verisilicon/vs_drv.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) VeriSilicon Holdings Co., Ltd.
> + */
> +
> +#ifndef __VS_DRV_H__
> +#define __VS_DRV_H__
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/reset.h>
> +
> +#include <drm/drm_fourcc.h>
> +
> +#include "vs_dc_hw.h"
> +
> +/*@pitch_alignment: buffer pitch alignment required by sub-devices.*/
> +struct vs_drm_device {
> +	struct drm_device base;
> +	unsigned int pitch_alignment;

Unused

> +	/* clocks */
> +	unsigned int clk_count;

unused

> +	struct clk_bulk_data	*clks;
> +	struct reset_control	*rsts;

You guess, unused

> +	struct vs_dc dc;
> +	int irq;
> +	struct regmap *dc_syscon_regmap;

and this one too

> +};
> +
> +static inline struct vs_drm_device *
> +to_vs_drm_private(const struct drm_device *dev)
> +{
> +	return container_of(dev, struct vs_drm_device, base);
> +}
> +
> +#ifdef CONFIG_DRM_INNO_STARFIVE_HDMI
> +extern struct platform_driver starfive_hdmi_driver;
> +#endif
> +
> +#endif /* __VS_DRV_H__ */
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

