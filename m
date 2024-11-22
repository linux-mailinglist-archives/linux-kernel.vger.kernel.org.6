Return-Path: <linux-kernel+bounces-417714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB22C9D5842
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 03:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B3DC1F23702
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 02:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A38C70816;
	Fri, 22 Nov 2024 02:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yNvECwqk"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C18230988
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 02:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732242101; cv=none; b=C1FxwdmhFDqfuy3Oq4Je7czoIG7d3IQGpmqgbC7Y2FlJJDTRBP2w0cALKJyLAK4esK1t15kaun9SZVfbxxVdJHUNNvj3MIDaMHL0aV8Tz/1DI25fedPSLpJWPsujmYVZOiyNG17CpW5SJnwp/t0X9Adx27mbFixErAsAv9TcjXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732242101; c=relaxed/simple;
	bh=5ir6bwQ8rsQHyPnUBlO5QLpvc00b4k9hFDzVZxmoemE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwCXHSPuU4hCcu353wKTR1WC8m4R4RFy5cEI+ez6MVBAwsak3wnZjkXORTBhbgtE/983uWa+kS4cc4IxA5LVkv7/+mQMnLnwHVk2y8KtH7m7njbvZAtIr2CqAU+JIe8+alkQeW/LOH6iqM0OCmjQTQmPUZhHIG71O21SMOL5svo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yNvECwqk; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539f1292a9bso1887460e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732242097; x=1732846897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZuZAUTXWUhfecAqQ9mrx5GiCXr4CTmpOjOFqvF1P6Q=;
        b=yNvECwqkpBTY5ChqiTa836VukI+x2YOea/s3b1FbcLklnVJotGCCkohH1N1ZFSDl0X
         aUKODFl3bh4zc6CUqlmqm7NrIttgLr4Tws27Nxm/kC9jdDCS81jJZV5JRZ8WKEUT6ypz
         E98hE0eOF7m+x3yCB4vH4EfI/3GFVLA4JWytAwLka8Orl0VlLk4/9Sj+JNO4bC4BvK04
         1RYOhqLiBF6MUU+tKwKi17n3hJq24oBRf9XzkAu/gA3bZxjvoV3cM4975Ef9UX76neUK
         73a18Jy+4agBLUkFBS+0t8QQ7hfUzwiwl+ALnExeLSNPJllc2kgE6V7Vzphub1CHLdtL
         p9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732242097; x=1732846897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZuZAUTXWUhfecAqQ9mrx5GiCXr4CTmpOjOFqvF1P6Q=;
        b=JiRjTUAXY+q4biPmMwwMCnkWKLfpKuxLRZ4Juy6nSilI9YNr76IvNvaR3V6Xn6dnfy
         EuVQr7V5xQLkhLgaiQ03ioa+s9ZC6mwWYdZSWmqO2uUzrGPmjEX1Tbc4OXgyR2jkBqxU
         OoRed2J13Oz7xX+GXvks8j8h8yBoBCI6+cxe9M4I8AkharzsZINIdzdnrjsW4tNw0QT4
         0LYo+xiUnklyGc+TiK17e1g8DAxM2idf1oCCCLgqZIEIFPmz6BU+I0g9hEF94EgXK0DB
         RUS/P6nsioJPWgfJnd77nDeNgiJE/6Wa5GR2E33BzciiooWW4T5cZWXm7MKPcv3HNwuH
         Pzxg==
X-Forwarded-Encrypted: i=1; AJvYcCV7FhwobpOqeu4QVaQ5ZAl/+wb5TgOKr/zfZO6srPykNkkMv4Tkm4+GCrDtYqvUe7l/8mfe3YWFgVxCeCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE2dAHaEaNjc2RLBR8HPwvSolTefCNJIYVfvHLKEwBLlnBGgIP
	4tcsH+J4y8/ZzLBYUzN9+qU9TergYDB8f73q5/vn8zsHKQxwZCgcVxOpZEO7E6E=
X-Gm-Gg: ASbGncvCDZwi5lxqaPMCpBSDKdNJWDHXHvW5Zb6qhABdx6IL/4O4fr7jB3MHBJq2xVf
	mEmvpDDxzbpSgFw+NSHl0yyr+pEApG7xABY/Bgv7qXaq0vQrATWnqpmuaBezjZfGo0uBk87YbYZ
	8I2qlHKloqTivnlXNqkUo6JkZ8oRdtLcWaEZDKK+1BRc5UO4VDI2vd3hEppblGZlT04aZjc2TTI
	mjGCtZ+jGEOENjuhdeofUlp/0+H0Ktv6ITC4FRSPX1Du02wwF16eEmshulzIy8cJKzrluy7x0lp
	+q8FZ/bxldkqpsxZu+RYhgSpyoFN1w==
X-Google-Smtp-Source: AGHT+IFNd2YzLTQpbV3Q61XUgusZ89fOWerYp2aFl2Xogi7WXwMBqvj+iOFt9Sh8aplJfX2ZgvTVdQ==
X-Received: by 2002:a05:6512:1111:b0:53d:d576:da05 with SMTP id 2adb3069b0e04-53dd576db55mr51458e87.34.1732242097440;
        Thu, 21 Nov 2024 18:21:37 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2da7589sm136062e87.58.2024.11.21.18.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 18:21:36 -0800 (PST)
Date: Fri, 22 Nov 2024 04:21:33 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, liangjian010@huawei.com, 
	chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com, 
	shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 drm-dp 5/5] drm/hisilicon/hibmc: add dp module in hibmc
Message-ID: <mdz2qe2lksowfzwxd5wfdynrsdsyzwjyism6qb5zozk2yb5tx5@zqghgeogothb>
References: <20241118142805.3326443-1-shiyongbang@huawei.com>
 <20241118142805.3326443-6-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118142805.3326443-6-shiyongbang@huawei.com>

On Mon, Nov 18, 2024 at 10:28:05PM +0800, Yongbang Shi wrote:
> From: baihan li <libaihan@huawei.com>
> 
> To support DP interface displaying in hibmc driver. Add
> a encoder and connector for DP modual.
> 
> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
> ChangeLog:
> v3 -> v4:
>   - static inline hibmc_dp_prepare(), suggested by Dmitry Baryshkov.
> ---
>  drivers/gpu/drm/hisilicon/hibmc/Makefile      |   2 +-
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 118 ++++++++++++++++++
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  12 ++
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |   5 +
>  4 files changed, 136 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> 
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/Makefile b/drivers/gpu/drm/hisilicon/hibmc/Makefile
> index 214228052ccf..95a4ed599d98 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/Makefile
> +++ b/drivers/gpu/drm/hisilicon/hibmc/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  hibmc-drm-y := hibmc_drm_drv.o hibmc_drm_de.o hibmc_drm_vdac.o hibmc_drm_i2c.o \
> -	       dp/dp_aux.o dp/dp_link.o dp/dp_hw.o
> +	       dp/dp_aux.o dp/dp_link.o dp/dp_hw.o hibmc_drm_dp.o
>  
>  obj-$(CONFIG_DRM_HISI_HIBMC) += hibmc-drm.o
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> new file mode 100644
> index 000000000000..603d6b198a54
> --- /dev/null
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> @@ -0,0 +1,118 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright (c) 2024 Hisilicon Limited.
> +
> +#include <linux/io.h>
> +
> +#include <drm/drm_probe_helper.h>
> +#include <drm/drm_simple_kms_helper.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_modes.h>
> +#include <drm/drm_drv.h>
> +#include <drm/drm_edid.h>
> +
> +#include "hibmc_drm_drv.h"
> +#include "dp/dp_hw.h"
> +
> +static int hibmc_dp_connector_get_modes(struct drm_connector *connector)
> +{
> +	int count;
> +
> +	count = drm_add_modes_noedid(connector, connector->dev->mode_config.max_width,
> +				     connector->dev->mode_config.max_height);
> +	drm_set_preferred_mode(connector, 1024, 768); // temporary implementation

Ideally this should be mentioned in the commit message.

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

No .detect / .detect_ctx ? No HPD support? Is it being targeted the DP
or eDP cases?

> +};
> +
> +static inline int hibmc_dp_prepare(struct hibmc_dp *dp, struct drm_display_mode *mode)
> +{
> +	int ret;
> +
> +	hibmc_dp_display_en(dp, false);
> +
> +	ret = hibmc_dp_mode_set(dp, mode);
> +	if (ret)
> +		drm_err(dp->drm_dev, "hibmc dp mode set failed: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static void hibmc_dp_encoder_enable(struct drm_encoder *drm_encoder,
> +				    struct drm_atomic_state *state)
> +{
> +	struct hibmc_dp *dp = container_of(drm_encoder, struct hibmc_dp, encoder);
> +	struct drm_display_mode *mode = &drm_encoder->crtc->state->mode;
> +
> +	if (hibmc_dp_prepare(dp, mode))
> +		return;
> +
> +	hibmc_dp_display_en(dp, true);
> +}
> +
> +static void hibmc_dp_encoder_disable(struct drm_encoder *drm_encoder,
> +				     struct drm_atomic_state *state)
> +{
> +	struct hibmc_dp *dp = container_of(drm_encoder, struct hibmc_dp, encoder);
> +
> +	hibmc_dp_display_en(dp, false);
> +}
> +
> +static const struct drm_encoder_helper_funcs hibmc_dp_encoder_helper_funcs = {
> +	.atomic_enable = hibmc_dp_encoder_enable,
> +	.atomic_disable = hibmc_dp_encoder_disable,
> +};
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
> +	ret = hibmc_dp_hw_init(&priv->dp);
> +	if (ret) {
> +		drm_err(dev, "hibmc dp hw init failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	hibmc_dp_display_en(&priv->dp, false);
> +
> +	encoder->possible_crtcs = drm_crtc_mask(crtc);
> +	ret = drmm_encoder_init(dev, encoder, NULL, DRM_MODE_ENCODER_TMDS, NULL);
> +	if (ret) {
> +		drm_err(dev, "init dp encoder failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	drm_encoder_helper_add(encoder, &hibmc_dp_encoder_helper_funcs);
> +
> +	ret = drm_connector_init(dev, connector, &hibmc_dp_conn_funcs,
> +				 DRM_MODE_CONNECTOR_DisplayPort);
> +	if (ret) {
> +		drm_err(dev, "init dp connector failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	drm_connector_helper_add(connector, &hibmc_dp_conn_helper_funcs);
> +
> +	drm_connector_attach_encoder(connector, encoder);
> +
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index 9f9b19ea0587..39fd8c5c8227 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> @@ -27,6 +27,10 @@
>  #include "hibmc_drm_drv.h"
>  #include "hibmc_drm_regs.h"
>  
> +#define HIBMC_DP_HOST_SERDES_CTRL		0x1f001c
> +#define HIBMC_DP_HOST_SERDES_CTRL_VAL		0x8A00
> +#define HIBMC_DP_HOST_SERDES_CTRL_MASK		0x7FFFF
> +
>  DEFINE_DRM_GEM_FOPS(hibmc_fops);
>  
>  static irqreturn_t hibmc_interrupt(int irq, void *arg)
> @@ -116,6 +120,14 @@ static int hibmc_kms_init(struct hibmc_drm_private *priv)
>  		return ret;
>  	}
>  
> +	/* if DP existed, init DP */
> +	if ((readl(priv->mmio + HIBMC_DP_HOST_SERDES_CTRL) &
> +	     HIBMC_DP_HOST_SERDES_CTRL_MASK) == HIBMC_DP_HOST_SERDES_CTRL_VAL) {
> +		ret = hibmc_dp_init(priv);
> +		if (ret)
> +			drm_err(dev, "failed to init dp: %d\n", ret);
> +	}
> +
>  	ret = hibmc_vdac_init(priv);
>  	if (ret) {
>  		drm_err(dev, "failed to init vdac: %d\n", ret);
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> index 42f0ab8f9b5a..d982f1e4b958 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> @@ -20,6 +20,8 @@
>  
>  #include <drm/drm_framebuffer.h>
>  
> +#include "dp/dp_hw.h"
> +
>  struct hibmc_vdac {
>  	struct drm_device *dev;
>  	struct drm_encoder encoder;
> @@ -37,6 +39,7 @@ struct hibmc_drm_private {
>  	struct drm_plane primary_plane;
>  	struct drm_crtc crtc;
>  	struct hibmc_vdac vdac;
> +	struct hibmc_dp dp;
>  };
>  
>  static inline struct hibmc_vdac *to_hibmc_vdac(struct drm_connector *connector)
> @@ -59,4 +62,6 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv);
>  
>  int hibmc_ddc_create(struct drm_device *drm_dev, struct hibmc_vdac *connector);
>  
> +int hibmc_dp_init(struct hibmc_drm_private *priv);
> +
>  #endif
> -- 
> 2.33.0
> 

-- 
With best wishes
Dmitry

