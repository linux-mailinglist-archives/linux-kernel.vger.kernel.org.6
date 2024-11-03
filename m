Return-Path: <linux-kernel+bounces-393772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8DA9BA50B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 11:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42AC01C20D7D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 10:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DFB15E5CA;
	Sun,  3 Nov 2024 10:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cmFNHepM"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191C22572
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 10:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730629064; cv=none; b=qQk0FyX7r1qfalj3QNqPtIEyCCps5hQGRtjd6JTWK/pdXfk7jbfc+jZvx7sDYcikYBdIxALmfP/GKU6HMrqd/k2RsMxuhz2+oS3HyLNx3AFp9okdMx/80joyYyqO/LrqlNdV1wuv6q2DS6LXTcD60rzkEZtlLBC0i6TduHvzcJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730629064; c=relaxed/simple;
	bh=UFulZFWoijiXm5yYrF9wrgmnyadS5rWO7QxakdYEkwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cmf2M0K8fpfIfG5i/KdYB22iShQmLsSeM02H+wbuvrv3EPdcVB4sTiPBLq8i461gtw/qP8vI/3UesENGfj1MTcrz3eDHmD9gy7CGV4djaCZ0t6kpM504CF9CItyOjnKrum38tIbsrlKGLbvnGuoS5eRALq1dUw0WlcHikn20rfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cmFNHepM; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53b34ed38easo3153374e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 02:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730629060; x=1731233860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HEWGy8Irz+K8Ck9b6ZQ1iscCkML+uKI/NC/3Hun2bfg=;
        b=cmFNHepMqy1INPUv+iTxbN42lNi72R04g18cEmWytMOdFBV0D+zLPOKwI/C0cmvAFz
         HL7lVogVKoTgBTOGyZ8S4Ew66Br152Vx2pZc7SE+3qziA06aCIl0jcjhNU/wSYoPUlNe
         PAdsu2713vKWcHN4F3oLVltPXF74OJxRo2s5BQm88bGNLFTTxh6DVA56tk/Zu3Z8OGbE
         SMVI5H2OMzZs72ghIUIYBsL23BsapKH5LXRZK6cJj8NjrdS+asziwtSGEW9D0ZYnfb/X
         Qsk5kFj0NycIxx6u6OA4J0rfmsH65OAuWajQAPozFod25/vjxfXmNmN9FJ26SveTv63G
         A+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730629060; x=1731233860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEWGy8Irz+K8Ck9b6ZQ1iscCkML+uKI/NC/3Hun2bfg=;
        b=S9n108BjAB89jJWwi03GxioiEq5UndTFIphKvQpSAPYlmSutGsH8bTIrsCeA+0Q646
         VUhMzZUsxumzvRpRrA1GfmFNJ/abY3zCdWFFdIFMqvWfvB4zCxy1nMyFSJDlFb7wtPcC
         Hu6nbtSL+tgtUlZ9vnKw1xkW1g3/XS7BW9x7k2Hb7jTDV6JfozKwTNqhDJ4M630LEEq0
         niCpDTRBMjAKvgNg30IQcyRIe7745Y1dYhivqCC+MMZXH0fT1oZIZ+jc5ImjXMEpRM6e
         QOAeoIKaNtaARlfhjrbP9r7TvSQjAe6MQl4tj8DG8L/l57F5Nx5GV/CSND8GgRK0Yesd
         edFw==
X-Forwarded-Encrypted: i=1; AJvYcCWueSqymyFksRKPEKDPPjbxuqqIrhziOBkT8OzysjCk5+tWS9drwVQ+ys443iP+Ki1F29rU5k6SbyDNAG8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5l1IkegVEzX/hCWDfl8mNp9r02RHGJmqCGENyzEu+TwJe5PDu
	34+VZMyk5+QvHwYyx6heyABai+SEjGBPGcA/3nUhing482aJX+lXF+vyP6Kllv0=
X-Google-Smtp-Source: AGHT+IHBG8YkHjgRT6qtmdjwMf7m6wBA9J4QNlIirwwjqQQSyS4GZi4NKcuCIyYrAH4xCl0ejvyMpg==
X-Received: by 2002:a05:6512:2341:b0:536:554a:24c2 with SMTP id 2adb3069b0e04-53b348c8978mr14540234e87.13.1730629059988;
        Sun, 03 Nov 2024 02:17:39 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bc9c796sm1257243e87.105.2024.11.03.02.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 02:17:38 -0800 (PST)
Date: Sun, 3 Nov 2024 12:17:35 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, liangjian010@huawei.com, 
	chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com, 
	shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 drm-dp 4/4] drm/hisilicon/hibmc: add dp module in hibmc
Message-ID: <nsqu4c6f2lv43sye3a7b2wqmqejutswcmtatuit4qzovdru733@bjbuwcmy65iu>
References: <20241101105028.2177274-1-shiyongbang@huawei.com>
 <20241101105028.2177274-5-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101105028.2177274-5-shiyongbang@huawei.com>

On Fri, Nov 01, 2024 at 06:50:28PM +0800, Yongbang Shi wrote:
> From: baihan li <libaihan@huawei.com>
> 
> To support DP interface displaying in hibmc driver. Add
> a encoder and connector for DP modual.
> 
> Signed-off-by: baihan li <libaihan@huawei.com>
> Signed-off-by: yongbang shi <shiyongbang@huawei.com>
> ---
> ChangeLog:
> v2 -> v3:
>   - fix build errors reported by kernel test robot <lkp@intel.com>
>     Closes: https://lore.kernel.org/oe-kbuild-all/202410251136.1m7BlR68-lkp@intel.com/
> v1 -> v2:
>   - deleting struct dp_mode and dp_mode_cfg function, suggested by Dmitry Baryshkov.
>   - modifying drm_simple_encoder_init function, suggested by Dmitry Baryshkov.
>   - refactoring struct hibmc_connector, suggested by Dmitry Baryshkov.
>   - withdrawing the modification in hibmc_kms_init, suggested by Dmitry Baryshkov.
>   v1:https://lore.kernel.org/all/20240930100610.782363-1-shiyongbang@huawei.com/
> ---
>  drivers/gpu/drm/hisilicon/hibmc/Makefile      |   2 +-
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 128 ++++++++++++++++++
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  16 +++
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |  21 +--
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c   |  41 +++---
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c  |  20 +--
>  6 files changed, 188 insertions(+), 40 deletions(-)
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
> index 000000000000..1e0f2ef39ba6
> --- /dev/null
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> @@ -0,0 +1,128 @@
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
> +static int hibmc_dp_prepare(struct hibmc_dp *dp, struct drm_display_mode *mode)

inline at the calling site

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
> +void hibmc_dp_uninit(struct hibmc_drm_private *priv)
> +{
> +	hibmc_dp_hw_uninit(&priv->dp);
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
> +	hibmc_dp_hw_uninit(&priv->dp);
> +
> +	return ret;
> +}
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index 9f9b19ea0587..f98ac94a18b9 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> @@ -27,6 +27,10 @@
>  #include "hibmc_drm_drv.h"
>  #include "hibmc_drm_regs.h"
>  
> +#define DP_HOST_SERDES_CTRL		0x1f001c
> +#define DP_HOST_SERDES_CTRL_VAL		0x8A00
> +#define DP_HOST_SERDES_CTRL_MASK	0x7FFFE
> +
>  DEFINE_DRM_GEM_FOPS(hibmc_fops);
>  
>  static irqreturn_t hibmc_interrupt(int irq, void *arg)
> @@ -116,6 +120,14 @@ static int hibmc_kms_init(struct hibmc_drm_private *priv)
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
> @@ -239,6 +251,7 @@ static int hibmc_hw_init(struct hibmc_drm_private *priv)
>  
>  static int hibmc_unload(struct drm_device *dev)
>  {
> +	struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
>  	struct pci_dev *pdev = to_pci_dev(dev->dev);
>  
>  	drm_atomic_helper_shutdown(dev);
> @@ -247,6 +260,9 @@ static int hibmc_unload(struct drm_device *dev)
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
> index 6b566f3aeecb..1b78d313a6c2 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> @@ -19,10 +19,12 @@
>  #include <linux/i2c.h>
>  
>  #include <drm/drm_framebuffer.h>
> +#include "dp/dp_hw.h"
>  
> -struct hibmc_connector {
> -	struct drm_connector base;
> -
> +struct hibmc_vdac {
> +	struct drm_device *dev;
> +	struct drm_encoder encoder;
> +	struct drm_connector connector;
>  	struct i2c_adapter adapter;
>  	struct i2c_algo_bit_data bit_data;
>  };
> @@ -35,13 +37,13 @@ struct hibmc_drm_private {
>  	struct drm_device dev;
>  	struct drm_plane primary_plane;
>  	struct drm_crtc crtc;
> -	struct drm_encoder encoder;
> -	struct hibmc_connector connector;
> +	struct hibmc_dp dp;
> +	struct hibmc_vdac vdac;

Please separate hibmc_vdac and hibmc_dp-related changes into separate patches.

>  };
>  
> -static inline struct hibmc_connector *to_hibmc_connector(struct drm_connector *connector)
> +static inline struct hibmc_vdac *to_hibmc_vdac(struct drm_connector *connector)
>  {
> -	return container_of(connector, struct hibmc_connector, base);
> +	return container_of(connector, struct hibmc_vdac, connector);
>  }
>  
>  static inline struct hibmc_drm_private *to_hibmc_drm_private(struct drm_device *dev)
> @@ -57,6 +59,9 @@ void hibmc_set_current_gate(struct hibmc_drm_private *priv,
>  int hibmc_de_init(struct hibmc_drm_private *priv);
>  int hibmc_vdac_init(struct hibmc_drm_private *priv);
>  
> -int hibmc_ddc_create(struct drm_device *drm_dev, struct hibmc_connector *connector);
> +int hibmc_ddc_create(struct drm_device *drm_dev, struct hibmc_vdac *connector);
> +
> +int hibmc_dp_init(struct hibmc_drm_private *priv);
> +void hibmc_dp_uninit(struct hibmc_drm_private *priv);
>  
>  #endif
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c
> index e6e48651c15c..99b3b77b5445 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c
> @@ -25,8 +25,8 @@
>  
>  static void hibmc_set_i2c_signal(void *data, u32 mask, int value)
>  {
> -	struct hibmc_connector *hibmc_connector = data;
> -	struct hibmc_drm_private *priv = to_hibmc_drm_private(hibmc_connector->base.dev);
> +	struct hibmc_vdac *vdac = data;
> +	struct hibmc_drm_private *priv = to_hibmc_drm_private(vdac->connector.dev);
>  	u32 tmp_dir = readl(priv->mmio + GPIO_DATA_DIRECTION);
>  
>  	if (value) {
> @@ -45,8 +45,8 @@ static void hibmc_set_i2c_signal(void *data, u32 mask, int value)
>  
>  static int hibmc_get_i2c_signal(void *data, u32 mask)
>  {
> -	struct hibmc_connector *hibmc_connector = data;
> -	struct hibmc_drm_private *priv = to_hibmc_drm_private(hibmc_connector->base.dev);
> +	struct hibmc_vdac *vdac = data;
> +	struct hibmc_drm_private *priv = to_hibmc_drm_private(vdac->connector.dev);
>  	u32 tmp_dir = readl(priv->mmio + GPIO_DATA_DIRECTION);
>  
>  	if ((tmp_dir & mask) != mask) {
> @@ -77,22 +77,21 @@ static int hibmc_ddc_getscl(void *data)
>  	return hibmc_get_i2c_signal(data, I2C_SCL_MASK);
>  }
>  
> -int hibmc_ddc_create(struct drm_device *drm_dev,
> -		     struct hibmc_connector *connector)
> +int hibmc_ddc_create(struct drm_device *drm_dev, struct hibmc_vdac *vdac)
>  {
> -	connector->adapter.owner = THIS_MODULE;
> -	snprintf(connector->adapter.name, I2C_NAME_SIZE, "HIS i2c bit bus");
> -	connector->adapter.dev.parent = drm_dev->dev;
> -	i2c_set_adapdata(&connector->adapter, connector);
> -	connector->adapter.algo_data = &connector->bit_data;
> -
> -	connector->bit_data.udelay = 20;
> -	connector->bit_data.timeout = usecs_to_jiffies(2000);
> -	connector->bit_data.data = connector;
> -	connector->bit_data.setsda = hibmc_ddc_setsda;
> -	connector->bit_data.setscl = hibmc_ddc_setscl;
> -	connector->bit_data.getsda = hibmc_ddc_getsda;
> -	connector->bit_data.getscl = hibmc_ddc_getscl;
> -
> -	return i2c_bit_add_bus(&connector->adapter);
> +	vdac->adapter.owner = THIS_MODULE;
> +	snprintf(vdac->adapter.name, I2C_NAME_SIZE, "HIS i2c bit bus");
> +	vdac->adapter.dev.parent = drm_dev->dev;
> +	i2c_set_adapdata(&vdac->adapter, vdac);
> +	vdac->adapter.algo_data = &vdac->bit_data;
> +
> +	vdac->bit_data.udelay = 20;
> +	vdac->bit_data.timeout = usecs_to_jiffies(2000);
> +	vdac->bit_data.data = vdac;
> +	vdac->bit_data.setsda = hibmc_ddc_setsda;
> +	vdac->bit_data.setscl = hibmc_ddc_setscl;
> +	vdac->bit_data.getsda = hibmc_ddc_getsda;
> +	vdac->bit_data.getscl = hibmc_ddc_getscl;
> +
> +	return i2c_bit_add_bus(&vdac->adapter);
>  }
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
> index 409c551c92af..05e19ea4c9f9 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
> @@ -24,11 +24,11 @@
>  
>  static int hibmc_connector_get_modes(struct drm_connector *connector)
>  {
> -	struct hibmc_connector *hibmc_connector = to_hibmc_connector(connector);
> +	struct hibmc_vdac *vdac = to_hibmc_vdac(connector);
>  	const struct drm_edid *drm_edid;
>  	int count;
>  
> -	drm_edid = drm_edid_read_ddc(connector, &hibmc_connector->adapter);
> +	drm_edid = drm_edid_read_ddc(connector, &vdac->adapter);
>  
>  	drm_edid_connector_update(connector, drm_edid);
>  
> @@ -51,9 +51,9 @@ static int hibmc_connector_get_modes(struct drm_connector *connector)
>  
>  static void hibmc_connector_destroy(struct drm_connector *connector)
>  {
> -	struct hibmc_connector *hibmc_connector = to_hibmc_connector(connector);
> +	struct hibmc_vdac *vdac = to_hibmc_vdac(connector);
>  
> -	i2c_del_adapter(&hibmc_connector->adapter);
> +	i2c_del_adapter(&vdac->adapter);
>  	drm_connector_cleanup(connector);
>  }
>  
> @@ -93,20 +93,20 @@ static const struct drm_encoder_helper_funcs hibmc_encoder_helper_funcs = {
>  int hibmc_vdac_init(struct hibmc_drm_private *priv)
>  {
>  	struct drm_device *dev = &priv->dev;
> -	struct hibmc_connector *hibmc_connector = &priv->connector;
> -	struct drm_encoder *encoder = &priv->encoder;
> +	struct hibmc_vdac *vdac = &priv->vdac;
> +	struct drm_encoder *encoder = &vdac->encoder;
>  	struct drm_crtc *crtc = &priv->crtc;
> -	struct drm_connector *connector = &hibmc_connector->base;
> +	struct drm_connector *connector = &vdac->connector;
>  	int ret;
>  
> -	ret = hibmc_ddc_create(dev, hibmc_connector);
> +	ret = hibmc_ddc_create(dev, vdac);
>  	if (ret) {
>  		drm_err(dev, "failed to create ddc: %d\n", ret);
>  		return ret;
>  	}
>  
>  	encoder->possible_crtcs = drm_crtc_mask(crtc);
> -	ret = drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_DAC);
> +	ret = drmm_encoder_init(dev, encoder, NULL, DRM_MODE_ENCODER_DAC, NULL);
>  	if (ret) {
>  		drm_err(dev, "failed to init encoder: %d\n", ret);
>  		return ret;
> @@ -117,7 +117,7 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv)
>  	ret = drm_connector_init_with_ddc(dev, connector,
>  					  &hibmc_connector_funcs,
>  					  DRM_MODE_CONNECTOR_VGA,
> -					  &hibmc_connector->adapter);
> +					  &vdac->adapter);
>  	if (ret) {
>  		drm_err(dev, "failed to init connector: %d\n", ret);
>  		return ret;
> -- 
> 2.33.0
> 

-- 
With best wishes
Dmitry

