Return-Path: <linux-kernel+bounces-526962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A89D6A405BC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 06:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5697D7ACE7A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 05:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611F01E7C19;
	Sat, 22 Feb 2025 05:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CB+HWFTm"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C2E17C2
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 05:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740203790; cv=none; b=nNumyhBSKwDlTCnuK87L0iWYZDWSNrXsohjg+xACHRWOPMTWg6BcDN47oI8cdk7Lg8nFE1mdyHZ6FInTOcZvtGTdcHO9ZcEVmv3hmCiYR+vMX7Ni/QwX0p601h39qb4+eABWoOhPwPNkyOJP7pxcCY3rFr3u9Acp5IkqavTScz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740203790; c=relaxed/simple;
	bh=O3NgR4jKfoMnuuFwwrk3qJXJdYAiPFNREQJDZxDF33A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+Q+E1CBtLU7gyq/Kn17gtIl296uYCdFeAH3fnprkk3Kh08YX6lntfT7tEAZkgCVSJndGGh88UwO5WS9Y1XR/QBSfrnxAHT7VWT9SCGB2tZebWKw4vqaLoFfIJuiBqtx1W8KmbUYxnUSD82IWNR2RpNLckDZtQGNjLJUN8WGx4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CB+HWFTm; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5461dab4bfdso3363030e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 21:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740203786; x=1740808586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/wsijbHJl+m4Z07fIOon5mVnox9w47z2c7z2iO7SkYI=;
        b=CB+HWFTm2nNYZ/ZwaF8uB/lDs3tgTgUr9ttekqGJy/t0ePHLvnRswkKTShFG3moOrp
         NoRvEA3GQPqhQ6WyYIWFzvELSDe2aUA+5bSZUs55PH+cF6F1o14ohABPf50mGhTeUhYF
         39fEyMepmz1hVFieV07NipCR1odX38Cg4eg2PTCH5FdSZt3aj/oCqFbCVukGQ2QJqRoz
         aaTHwRhAAk7YlKgMxZ4oMYF2k2lmK2mrLgVLjhr1X8hWZmZUvcVcQwUZVQp2xXtglONf
         vVvC8/kJSlUMXJurYMh0AXT9sPV9+dom/bFkQpGtkhD5fc7CAeg3hY1qUNds3as09MXv
         aDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740203786; x=1740808586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wsijbHJl+m4Z07fIOon5mVnox9w47z2c7z2iO7SkYI=;
        b=ESXa0WCtqyWtcGu6nlVXy+zqYmG+bYdR4XSwsnjF/wU4CkIGqWllTatbGVkLIj8Xvn
         rPFKRDJKZmzabnY8cVsKS77CmqJDXCMSJZuZjdmGDEpNESwv9fw3su4J277KZQVrXWR/
         yOZ93kMj8tKh2Vfcqh1jPtHag4574oPYVdlLsjrVUGjeXBKOBMyI0Gb6aUIlN3KlkQxl
         /PnzJdhfv01QHNxMlZqi2ql3xRJboBef42STi43byJ8tJZ5fY4JUPd0JfGJX7EyArnSd
         kzZSV5QpP9mZJi3K7K6rBKR4m6bJ/D5xr/0wj5BJRG+02/PLEzXCGkxC5+edQcv3llOp
         CkrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUorwUqtucu7FTLqak4xmHZ/I67d79wve3oB/ztVL5Cqk6S4RFjEK/AaDrj+9MiK5n5xcYlxsqTwZjGq5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6jEQb0Dj3YsYAMa28Wy4ZLdP5Rq/Au3N5M8YpWZ5K5kN0W7ek
	3z6j/LmOwFNJ8DsFge+zstbTQ4IGI1qLnNcQWk82eqDD9Dyo2mB5VZQ8jzNJBus=
X-Gm-Gg: ASbGncue3NvfenAtgovyr9eO/ze6gnRTitdzjIXyTMdrRgiUoenP1fxOeTvV/osBJTX
	/bD/Pr9ZGvhSwDmqguM+xieIfS+ozkXqAdtmXpb/c4laSOvrwN1aShrJYJa+svtgzIRj0raFphe
	oYLqU5Q8Vv+LlRGQTYkgkJXkDDmeGYqxfH91RBn0TlUxlBuxbJ2qBHJ8AhmBpyYcbgvUkW86fya
	VdbhJ76WymCmv7mz/tBuuIlAX+fLZq0uFgVYCCMWMqFnV+NaJ7tOt4uk/3NVaDgKADghzP4m6eW
	JBdeNTZd414LN0E/n0CzpjHRoK2Z6bwiqSxL2OIvu8LZJN+mhTUHIBNHNJdKsP5AAqJDrXuZ/CX
	dueuPnQ==
X-Google-Smtp-Source: AGHT+IERXF+h+SL+TWajfLF7a7ZiaSXc9K+sjfaCyneAWSficlXzmZRf63WGU+DaKdIjP8Flz5wBAA==
X-Received: by 2002:a05:6512:280b:b0:545:bb6:8e41 with SMTP id 2adb3069b0e04-54838f5b913mr2295487e87.52.1740203785936;
        Fri, 21 Feb 2025 21:56:25 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f10cc28sm2845601e87.201.2025.02.21.21.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 21:56:24 -0800 (PST)
Date: Sat, 22 Feb 2025 07:56:22 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, liangjian010@huawei.com, 
	chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com, 
	shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 drm-dp 7/8] drm/hisilicon/hibmc: Enable this hot plug
 detect of irq feature
Message-ID: <reqpxlbvlz5qssgy6gbjuou33h4zevo4xeztqbsr4keehplyhx@utv22a5ihohx>
References: <20250222025102.1519798-1-shiyongbang@huawei.com>
 <20250222025102.1519798-8-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222025102.1519798-8-shiyongbang@huawei.com>

On Sat, Feb 22, 2025 at 10:51:00AM +0800, Yongbang Shi wrote:
> From: Baihan Li <libaihan@huawei.com>
> 
> Enable HPD feature and add its isr and event function. Add a drm client
> dev and realized the hotplug callback in it.

What for? There should be no need to add a separate drm client just for
the hotplug.

> 
> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
> ChangeLog:
> v2 -> v3:
>   - remove mdelay(100) hpd function in ISR, suggested by Dmitry Baryshkov.
>   - remove enble_display in ISR, suggested by Dmitry Baryshkov.
>   - change drm_kms_helper_connector_hotplug_event() to
>     drm_connector_helper_hpd_irq_event(), suggested by Dmitry Baryshkov.
>   - move macros to dp_reg.h, suggested by Dmitry Baryshkov.
>   - remove struct irqs, suggested by Dmitry Baryshkov.
>   - split this patch into two parts, suggested by Dmitry Baryshkov.
>   - add a drm client dev to handle HPD event.
> v1 -> v2:
>   - optimizing the description in commit message, suggested by Dmitry Baryshkov.
>   - add mdelay(100) comments, suggested by Dmitry Baryshkov.
>   - deleting display enable in hpd event, suggested by Dmitry Baryshkov.
> ---
>  .../gpu/drm/hisilicon/hibmc/dp/dp_config.h    |  1 +
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    | 22 +++++++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  6 ++
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 61 +++++++++++++++++++
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |  2 +
>  5 files changed, 92 insertions(+)
> 
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h
> index c5feef8dc27d..08f9e1caf7fc 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h
> @@ -16,5 +16,6 @@
>  #define HIBMC_DP_SYNC_EN_MASK		0x3
>  #define HIBMC_DP_LINK_RATE_CAL		27
>  #define HIBMC_DP_SYNC_DELAY(lanes)	((lanes) == 0x2 ? 86 : 46)
> +#define HIBMC_DP_INT_ENABLE		0xc
>  
>  #endif
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> index a921b98dbf50..b2116395b8dd 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> @@ -182,6 +182,7 @@ int hibmc_dp_hw_init(struct hibmc_dp *dp)
>  	/* int init */
>  	writel(0, dp_dev->base + HIBMC_DP_INTR_ENABLE);
>  	writel(HIBMC_DP_INT_RST, dp_dev->base + HIBMC_DP_INTR_ORIGINAL_STATUS);
> +	writel(HIBMC_DP_INT_ENABLE, dp_dev->base + HIBMC_DP_INTR_ENABLE);
>  	/* rst */
>  	writel(HIBMC_DP_DPTX_RST, dp_dev->base + HIBMC_DP_DPTX_RST_CTRL);
>  	/* clock enable */
> @@ -190,6 +191,21 @@ int hibmc_dp_hw_init(struct hibmc_dp *dp)
>  	return 0;
>  }
>  
> +void hibmc_dp_hpd_cfg(struct hibmc_dp *dp)
> +{
> +	struct hibmc_dp_dev *dp_dev = dp->dp_dev;
> +
> +	hibmc_dp_reg_write_field(dp_dev, HIBMC_DP_AUX_REQ, HIBMC_DP_CFG_AUX_SYNC_LEN_SEL, 0x0);
> +	hibmc_dp_reg_write_field(dp_dev, HIBMC_DP_AUX_REQ, HIBMC_DP_CFG_AUX_TIMER_TIMEOUT, 0x1);
> +	hibmc_dp_reg_write_field(dp->dp_dev, HIBMC_DP_AUX_REQ, HIBMC_DP_CFG_AUX_MIN_PULSE_NUM, 0x9);
> +	writel(HIBMC_DP_HDCP, dp_dev->base + HIBMC_DP_HDCP_CFG);
> +	writel(0, dp_dev->base + HIBMC_DP_INTR_ENABLE);
> +	writel(HIBMC_DP_INT_RST, dp_dev->base + HIBMC_DP_INTR_ORIGINAL_STATUS);
> +	writel(HIBMC_DP_INT_ENABLE, dp_dev->base + HIBMC_DP_INTR_ENABLE);
> +	writel(HIBMC_DP_DPTX_RST, dp_dev->base + HIBMC_DP_DPTX_RST_CTRL);
> +	writel(HIBMC_DP_CLK_EN, dp_dev->base + HIBMC_DP_DPTX_CLK_CTRL);
> +}
> +
>  void hibmc_dp_display_en(struct hibmc_dp *dp, bool enable)
>  {
>  	struct hibmc_dp_dev *dp_dev = dp->dp_dev;
> @@ -228,6 +244,12 @@ int hibmc_dp_mode_set(struct hibmc_dp *dp, struct drm_display_mode *mode)
>  	return 0;
>  }
>  
> +void hibmc_dp_reset_link(struct hibmc_dp *dp)
> +{
> +	dp->dp_dev->link.status.clock_recovered = false;
> +	dp->dp_dev->link.status.channel_equalized = false;

Could you please point out, where the link rate and number of lanes are
reset?

> +}
> +
>  static const struct hibmc_dp_color_raw g_rgb_raw[] = {
>  	{CBAR_COLOR_BAR, 0x000, 0x000, 0x000},
>  	{CBAR_WHITE,     0xfff, 0xfff, 0xfff},
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> index 83a53dae8012..a55d66d53966 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> @@ -11,6 +11,7 @@
>  #include <drm/drm_connector.h>
>  #include <drm/drm_print.h>
>  #include <drm/display/drm_dp_helper.h>
> +#include <drm/drm_client.h>
>  
>  struct hibmc_dp_dev;
>  
> @@ -49,11 +50,16 @@ struct hibmc_dp {
>  	void __iomem *mmio;
>  	struct drm_dp_aux aux;
>  	struct hibmc_dp_cbar_cfg cfg;
> +	u32 irq_status;
> +	u32 hpd_status;
> +	struct drm_client_dev client;
>  };
>  
>  int hibmc_dp_hw_init(struct hibmc_dp *dp);
>  int hibmc_dp_mode_set(struct hibmc_dp *dp, struct drm_display_mode *mode);
>  void hibmc_dp_display_en(struct hibmc_dp *dp, bool enable);
>  void hibmc_dp_set_cbar(struct hibmc_dp *dp, const struct hibmc_dp_cbar_cfg *cfg);
> +void hibmc_dp_reset_link(struct hibmc_dp *dp);
> +void hibmc_dp_hpd_cfg(struct hibmc_dp *dp);
>  
>  #endif
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> index a7f611e82f73..40a3ebb8ac4b 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> @@ -9,10 +9,13 @@
>  #include <drm/drm_modes.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_edid.h>
> +#include <drm/drm_client.h>
>  
>  #include "hibmc_drm_drv.h"
>  #include "dp/dp_hw.h"
>  
> +#define DP_MASKED_SINK_HPD_PLUG_INT	BIT(2)
> +
>  static int hibmc_dp_connector_get_modes(struct drm_connector *connector)
>  {
>  	struct hibmc_dp *dp = to_hibmc_dp(connector);
> @@ -98,6 +101,58 @@ static const struct drm_encoder_helper_funcs hibmc_dp_encoder_helper_funcs = {
>  	.atomic_disable = hibmc_dp_encoder_disable,
>  };
>  
> +irqreturn_t hibmc_dp_hpd_isr(int irq, void *arg)
> +{
> +	struct drm_device *dev = (struct drm_device *)arg;
> +	struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
> +	int idx;
> +
> +	if (!drm_dev_enter(dev, &idx))
> +		return -ENODEV;
> +
> +	if (priv->dp.irq_status & DP_MASKED_SINK_HPD_PLUG_INT) {
> +		drm_dbg_dp(&priv->dev, "HPD IN isr occur!\n");
> +		priv->dp.hpd_status = 1;
> +	} else {
> +		drm_dbg_dp(&priv->dev, "HPD OUT isr occur!\n");
> +		priv->dp.hpd_status = 0;
> +	}
> +
> +	if (dev->registered)
> +		drm_connector_helper_hpd_irq_event(&priv->dp.connector);
> +
> +	drm_dev_exit(idx);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int hibmc_dp_hpd_event(struct drm_client_dev *client)
> +{
> +	struct hibmc_dp *dp = container_of(client, struct hibmc_dp, client);
> +	struct hibmc_drm_private *priv = to_hibmc_drm_private(dp->drm_dev);
> +	struct drm_display_mode *mode = &priv->crtc.state->adjusted_mode;
> +	int ret;
> +
> +	if (dp->hpd_status) {
> +		hibmc_dp_hpd_cfg(&priv->dp);
> +		ret = hibmc_dp_prepare(dp, mode);
> +		if (ret)
> +			return ret;
> +
> +		hibmc_dp_display_en(dp, true);
> +	} else {
> +		hibmc_dp_display_en(dp, false);
> +		hibmc_dp_reset_link(&priv->dp);
> +	}

If I understand this correctly, you are using a separate drm_client to
enable and disable the link & display. Why is it necessary? Existing
drm_clients and userspace compositors use drm framework, they should be
able to turn the display on and off as required.

> +
> +	return 0;
> +}
> +
> +static const struct drm_client_funcs hibmc_dp_client_funcs = {
> +	.hotplug = hibmc_dp_hpd_event,
> +	.unregister = drm_client_release,
> +};
> +
>  int hibmc_dp_init(struct hibmc_drm_private *priv)
>  {
>  	struct drm_device *dev = &priv->dev;
> @@ -138,5 +193,11 @@ int hibmc_dp_init(struct hibmc_drm_private *priv)
>  
>  	drm_connector_attach_encoder(connector, encoder);
>  
> +	ret = drm_client_init(dev, &dp->client, "hibmc-DP-HPD", &hibmc_dp_client_funcs);
> +	if (ret)
> +		return ret;
> +
> +	drm_client_register(&dp->client);
> +
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> index bc89e4b9f4e3..daed1330b961 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> @@ -71,4 +71,6 @@ int hibmc_dp_init(struct hibmc_drm_private *priv);
>  
>  void hibmc_debugfs_init(struct drm_connector *connector, struct dentry *root);
>  
> +irqreturn_t hibmc_dp_hpd_isr(int irq, void *arg);
> +
>  #endif
> -- 
> 2.33.0
> 

-- 
With best wishes
Dmitry

