Return-Path: <linux-kernel+bounces-372861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AEA9A4E7E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 16:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A06287654
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 14:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1051D219E4;
	Sat, 19 Oct 2024 14:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wpdZuGeE"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE624CB2B
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 14:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729346813; cv=none; b=R+1WTtP0o5/TSHkT4342IpVylqPI+1tvvJkikII+olznBfr8Migxxp3uEImkAzON2uI8l5dBCxFPTVOC7f4jQc/cFu1r7uMxbz3Q7y4UtuJXvxzHV9O1437aeLUM9LmIEgFPFZ19QPKsdetdicU8KGc6pmeLMRqQF5VY8vYZGwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729346813; c=relaxed/simple;
	bh=MU2HYpJpI14q3K6hfWXONBmeoCMmBkd2yy4UelpGylo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFqpia5MtEBv7sR72hRif2uBTkhVQGKEZHNVCCvlrksgpReIDxNC8m73gmUVOuBBZ8+xilzlbl9Z2Kp4IZUOOfGP07N9+XQ2/vpfPMOHbkHwTRs/n382vhawnPDgPSdMUgIEGDfM/iZ1H3eYCUrJ1tk9TYL91nSDyRPnXKsxM0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wpdZuGeE; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb59652cb9so30612601fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 07:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729346809; x=1729951609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uZX3L8vj0+pZ3viwMUU5rczwa59QJIn6phjkq4UGtpg=;
        b=wpdZuGeECuYWuEX0P22zEIoydaVT+tH8XQTywBLvPXmVbrvZqFLbapvoIKHPMm28Eo
         eCYpBm/fBF3bgH+SzZLVskC1Ju3gshyFl1Z77uj/RTOy/C+iEQZXCqZ9EbKAvCAmkwYz
         8Y6azOWc2G4Syp8w4tk5tDSWKNavloOnnhYgBISglcy+cIvhyH72qmgPjsyJQ4veCnS0
         z58NdAyTZ5okhKPwZhC9rtJbdyMVuKgnn3/F8hVVBIcYsywuWYXKCjlpO2Js4mapYF4f
         qccUMP4yUGtEbtmsRPZPJMw0T0k03LK51ANSAhhaRllUHBnGIt+p/n5xMxFKib0rRUrH
         dF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729346809; x=1729951609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZX3L8vj0+pZ3viwMUU5rczwa59QJIn6phjkq4UGtpg=;
        b=caqgq7Qra3ZmpOedEPuygSBftjRAGtX0LdSGK47paMH7FFu9QR+Rk/glf1Y5vjSGBG
         bKX37fyrTJAW0BNOURiDrgt5RXK3Ttt/UlDgXRqCa+9XMZQrQiRxAS8nSYfBOmKs6WZ0
         uvNn9ebM5OZwVetM4dTEHxunkGkMJoscLGf3JQFOKy4VZ5Zs9rfgEUQDApxEgo+4TkxB
         qJwksw7Nbs9wFguti0l6MIt/+oo+O5p8zs0lciomC0VA8vgApRsO0gaaA/tqldQR3zvw
         TiZmjbmPdI/ajQ1W8k+RP21+oeBvyBrTvXooFq+fMVo3NeV0GDGjJ7WuxConuJ7j1wVU
         3VXg==
X-Forwarded-Encrypted: i=1; AJvYcCXAPmiShfuWlt0UICCQgjKWo4jS6UVATbsLzQwQVBRHVF5HrZgQjzHXdjNr/ifXhLWpujLE7tCG85wml/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnr0UjOUFCDUIjDP21Fvg939REHYHFOutOTT8cjfisE+4XjoKY
	yfr4nbX4vjOSFyzWKzh1+jekVncvOTzA9wVkdQZEX6Zkr+mXRpniOHFXBeBYQfA=
X-Google-Smtp-Source: AGHT+IFnKepQrt3KjstKwoxDrbwPp3YtLP62lKS2Z/Xn6PX8nRZiXrbbNPjqK0PsayIqYwEjyqpqmg==
X-Received: by 2002:a2e:b8cb:0:b0:2fb:656b:4c8e with SMTP id 38308e7fff4ca-2fb8320f626mr28703751fa.42.1729346808455;
        Sat, 19 Oct 2024 07:06:48 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb809b2faasm5274891fa.46.2024.10.19.07.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 07:06:47 -0700 (PDT)
Date: Sat, 19 Oct 2024 17:06:45 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: shiyongbang <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, liangjian010@huawei.com, 
	chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com, 
	shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH drm-dp 4/4] drm/hisilicon/hibmc: add dp module in hibmc
Message-ID: <xeemxeld4cqpx47kzb5qqsawk7mu5kje6r7n335dhe2s7ynw6m@eaiowriiilgr>
References: <20240930100610.782363-1-shiyongbang@huawei.com>
 <20240930100610.782363-5-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930100610.782363-5-shiyongbang@huawei.com>

On Mon, Sep 30, 2024 at 06:06:10PM +0800, shiyongbang wrote:
> From: baihan li <libaihan@huawei.com>
> 
> To support DP interface displaying in hibmc driver. Add
> a encoder and connector for DP modual.
> 
> Signed-off-by: baihan li <libaihan@huawei.com>
> ---
>  drivers/gpu/drm/hisilicon/hibmc/Makefile      |   2 +-
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 195 ++++++++++++++++++
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  17 +-
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |   5 +
>  4 files changed, 217 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> 
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/Makefile b/drivers/gpu/drm/hisilicon/hibmc/Makefile
> index 693036dfab52..8cf74e0d4785 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/Makefile
> +++ b/drivers/gpu/drm/hisilicon/hibmc/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  hibmc-drm-y := hibmc_drm_drv.o hibmc_drm_de.o hibmc_drm_vdac.o hibmc_drm_i2c.o \
> -	       dp/dp_aux.o dp/dp_link.o dp/dp_kapi.o
> +	       dp/dp_aux.o dp/dp_link.o dp/dp_kapi.o hibmc_drm_dp.o
>  
>  obj-$(CONFIG_DRM_HISI_HIBMC) += hibmc-drm.o
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> new file mode 100644
> index 000000000000..7a50f1d81aac
> --- /dev/null
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> @@ -0,0 +1,195 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <linux/io.h>
> +
> +#include <drm/drm_probe_helper.h>
> +#include <drm/drm_simple_kms_helper.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_drv.h>
> +#include <drm/drm_edid.h>
> +
> +#include "hibmc_drm_drv.h"
> +#include "dp/dp_kapi.h"
> +
> +static int hibmc_dp_connector_get_modes(struct drm_connector *connector)
> +{
> +	int count;
> +
> +	count = drm_add_modes_noedid(connector, connector->dev->mode_config.max_width,
> +				     connector->dev->mode_config.max_height);
> +	drm_set_preferred_mode(connector, 800, 600); /* default 800x600 */

What? Please parse EDID instead.

> +
> +	return count;
> +}
> +
> +static const struct drm_connector_helper_funcs hibmc_dp_conn_helper_funcs = {
> +	.get_modes = hibmc_dp_connector_get_modes,
> +};
> +
> +static const struct drm_connector_funcs hibmc_dp_conn_funcs = {
> +	.reset = drm_atomic_helper_connector_reset,
> +	.fill_modes = drm_helper_probe_single_connector_modes,
> +	.destroy = drm_connector_cleanup,
> +	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> +	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> +};
> +
> +static void dp_mode_cfg(struct drm_device *dev, struct dp_mode *dp_mode,
> +			struct drm_display_mode *mode)
> +{
> +	dp_mode->field_rate = drm_mode_vrefresh(mode);
> +	dp_mode->pixel_clock = mode->clock / 1000; /* 1000: khz to hz */
> +
> +	dp_mode->h_total = mode->htotal;
> +	dp_mode->h_active = mode->hdisplay;
> +	dp_mode->h_blank = mode->htotal - mode->hdisplay;
> +	dp_mode->h_front = mode->hsync_start - mode->hdisplay;
> +	dp_mode->h_sync = mode->hsync_end - mode->hsync_start;
> +	dp_mode->h_back = mode->htotal - mode->hsync_end;
> +
> +	dp_mode->v_total = mode->vtotal;
> +	dp_mode->v_active = mode->vdisplay;
> +	dp_mode->v_blank = mode->vtotal - mode->vdisplay;
> +	dp_mode->v_front = mode->vsync_start - mode->vdisplay;
> +	dp_mode->v_sync = mode->vsync_end - mode->vsync_start;
> +	dp_mode->v_back = mode->vtotal - mode->vsync_end;

No need to copy the bits around. Please use drm_display_mode directly.

> +
> +	if (mode->flags & DRM_MODE_FLAG_PHSYNC) {
> +		drm_info(dev, "horizontal sync polarity: positive\n");
> +		dp_mode->h_pol = 1;
> +	} else if (mode->flags & DRM_MODE_FLAG_NHSYNC) {
> +		drm_info(dev, "horizontal sync polarity: negative\n");
> +		dp_mode->h_pol = 0;
> +	} else {
> +		drm_err(dev, "horizontal sync polarity: unknown or not set\n");
> +	}
> +
> +	if (mode->flags & DRM_MODE_FLAG_PVSYNC) {
> +		drm_info(dev, "vertical sync polarity: positive\n");
> +		dp_mode->v_pol = 1;
> +	} else if (mode->flags & DRM_MODE_FLAG_NVSYNC) {
> +		drm_info(dev, "vertical sync polarity: negative\n");

No spamming, use DRM debugging macros.

> +		dp_mode->v_pol = 0;
> +	} else {
> +		drm_err(dev, "vertical sync polarity: unknown or not set\n");
> +	}
> +}
> +
> +static int dp_prepare(struct hibmc_dp *dp, struct drm_display_mode *mode)
> +{
> +	struct dp_mode dp_mode = {0};
> +	int ret;
> +
> +	hibmc_dp_display_en(dp, false);
> +
> +	dp_mode_cfg(dp->drm_dev, &dp_mode, mode);
> +	ret = hibmc_dp_mode_set(dp, &dp_mode);
> +	if (ret)
> +		drm_err(dp->drm_dev, "hibmc dp mode set failed: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static void dp_enable(struct hibmc_dp *dp)
> +{
> +	hibmc_dp_display_en(dp, true);
> +}
> +
> +static void dp_disable(struct hibmc_dp *dp)
> +{
> +	hibmc_dp_display_en(dp, false);
> +}
> +
> +static int hibmc_dp_hw_init(struct hibmc_drm_private *priv)
> +{
> +	int ret;
> +
> +	ret = hibmc_dp_kapi_init(&priv->dp);
> +	if (ret)
> +		return ret;
> +
> +	hibmc_dp_display_en(&priv->dp, false);
> +
> +	return 0;
> +}
> +
> +static void hibmc_dp_hw_uninit(struct hibmc_drm_private *priv)
> +{
> +	hibmc_dp_kapi_uninit(&priv->dp);
> +}

Inline all these one-line wrappers, they serve no purpose.

> +
> +static void hibmc_dp_encoder_enable(struct drm_encoder *drm_encoder,
> +				    struct drm_atomic_state *state)
> +{
> +	struct hibmc_dp *dp = container_of(drm_encoder, struct hibmc_dp, encoder);
> +	struct drm_display_mode *mode = &drm_encoder->crtc->state->mode;
> +
> +	if (dp_prepare(dp, mode))
> +		return;
> +
> +	dp_enable(dp);
> +}
> +
> +static void hibmc_dp_encoder_disable(struct drm_encoder *drm_encoder,
> +				     struct drm_atomic_state *state)
> +{
> +	struct hibmc_dp *dp = container_of(drm_encoder, struct hibmc_dp, encoder);
> +
> +	dp_disable(dp);
> +}
> +
> +static const struct drm_encoder_helper_funcs hibmc_dp_encoder_helper_funcs = {
> +	.atomic_enable = hibmc_dp_encoder_enable,
> +	.atomic_disable = hibmc_dp_encoder_disable,
> +};
> +
> +void hibmc_dp_uninit(struct hibmc_drm_private *priv)
> +{
> +	hibmc_dp_hw_uninit(priv);
> +}
> +
> +int hibmc_dp_init(struct hibmc_drm_private *priv)
> +{
> +	struct drm_device *dev = &priv->dev;
> +	struct drm_crtc *crtc = &priv->crtc;
> +	struct hibmc_dp *dp = &priv->dp;
> +	struct drm_connector *connector = &dp->connector;
> +	struct drm_encoder *encoder = &dp->encoder;
> +	int ret;
> +
> +	dp->mmio = priv->mmio;
> +	dp->drm_dev = dev;
> +
> +	ret = hibmc_dp_hw_init(priv);
> +	if (ret) {
> +		drm_err(dev, "dp hw init failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	encoder->possible_crtcs = drm_crtc_mask(crtc);
> +	ret = drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_TMDS);

I think drm_simple_foo interfaces are being deprecated. Please copy
required code into the driver instead.

> +	if (ret) {
> +		drm_err(dev, "init dp encoder failed: %d\n", ret);
> +		goto err_init;
> +	}
> +
> +	drm_encoder_helper_add(encoder, &hibmc_dp_encoder_helper_funcs);
> +
> +	ret = drm_connector_init(dev, connector, &hibmc_dp_conn_funcs,
> +				 DRM_MODE_CONNECTOR_DisplayPort);
> +	if (ret) {
> +		drm_err(dev, "init dp connector failed: %d\n", ret);
> +		goto err_init;
> +	}
> +
> +	drm_connector_helper_add(connector, &hibmc_dp_conn_helper_funcs);
> +
> +	drm_connector_attach_encoder(connector, encoder);
> +
> +	return 0;
> +
> +err_init:
> +	hibmc_dp_hw_uninit(priv);
> +
> +	return ret;
> +}
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index 9f9b19ea0587..c90a8db021b0 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> @@ -93,6 +93,10 @@ static const struct drm_mode_config_funcs hibmc_mode_funcs = {
>  
>  static int hibmc_kms_init(struct hibmc_drm_private *priv)
>  {
> +#define DP_HOST_SERDES_CTRL		0x1f001c
> +#define DP_HOST_SERDES_CTRL_VAL		0x8A00
> +#define DP_HOST_SERDES_CTRL_MASK	0x7FFFE
> +

#defines outside of the function body.

>  	struct drm_device *dev = &priv->dev;
>  	int ret;
>  
> @@ -116,10 +120,17 @@ static int hibmc_kms_init(struct hibmc_drm_private *priv)
>  		return ret;
>  	}
>  
> +	/* if DP existed, init DP */
> +	if ((readl(priv->mmio + DP_HOST_SERDES_CTRL) &
> +	     DP_HOST_SERDES_CTRL_MASK) == DP_HOST_SERDES_CTRL_VAL) {
> +		ret = hibmc_dp_init(priv);
> +		if (ret)
> +			drm_err(dev, "failed to init dp: %d\n", ret);
> +	}
> +
>  	ret = hibmc_vdac_init(priv);
>  	if (ret) {
>  		drm_err(dev, "failed to init vdac: %d\n", ret);
> -		return ret;

Why?

>  	}
>  
>  	return 0;
> @@ -239,6 +250,7 @@ static int hibmc_hw_init(struct hibmc_drm_private *priv)
>  
>  static int hibmc_unload(struct drm_device *dev)
>  {
> +	struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
>  	struct pci_dev *pdev = to_pci_dev(dev->dev);
>  
>  	drm_atomic_helper_shutdown(dev);
> @@ -247,6 +259,9 @@ static int hibmc_unload(struct drm_device *dev)
>  
>  	pci_disable_msi(to_pci_dev(dev->dev));
>  
> +	if (priv->dp.encoder.possible_crtcs)
> +		hibmc_dp_uninit(priv);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> index 6b566f3aeecb..aa79903fe022 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> @@ -19,6 +19,7 @@
>  #include <linux/i2c.h>
>  
>  #include <drm/drm_framebuffer.h>
> +#include "dp/dp_kapi.h"
>  
>  struct hibmc_connector {
>  	struct drm_connector base;
> @@ -37,6 +38,7 @@ struct hibmc_drm_private {
>  	struct drm_crtc crtc;
>  	struct drm_encoder encoder;
>  	struct hibmc_connector connector;

It seems this needs to be refactored too, to separate VGA connector /
encoder / CRTC to a child struct.

> +	struct hibmc_dp dp;
>  };
>  
>  static inline struct hibmc_connector *to_hibmc_connector(struct drm_connector *connector)
> @@ -59,4 +61,7 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv);
>  
>  int hibmc_ddc_create(struct drm_device *drm_dev, struct hibmc_connector *connector);
>  
> +int hibmc_dp_init(struct hibmc_drm_private *priv);
> +void hibmc_dp_uninit(struct hibmc_drm_private *priv);
> +
>  #endif
> -- 
> 2.33.0
> 

-- 
With best wishes
Dmitry

