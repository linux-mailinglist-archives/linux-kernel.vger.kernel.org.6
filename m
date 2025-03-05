Return-Path: <linux-kernel+bounces-547691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C2DA50C6F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAEA8170F66
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB19C254878;
	Wed,  5 Mar 2025 20:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="En37rQEO"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD4F17B50B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 20:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741206358; cv=none; b=tTkLk3UXUhOfUv9OXpFaGPB3qjD/E4ioiwFzJ5B4gmJeA5HS4yT+Ug5Khx48JUoQrdbW2uwWMh0j4J1xdMIUdrFokbHqtFd3ugHfezeQn+n9h4CirzfyPnO9rvJqU02lNhquqkTf9yHCgWjU01cZ6DoUhQLr/ISfahDJTOL9rN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741206358; c=relaxed/simple;
	bh=CcJ4+E0wgeeqOeQo5qyIl4ky+2dfHE48u2dx7THO04s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIMAS31RYpujqZDNqg8rxAK1G33omYMdPCqjmH77ElgW2jsvKKmczZl/w24Cv3KBM1eymDYY1tdcGVdSO2YXnMFFiwXzIKbw8AsEvlASWdtDjXK3cViM172xgEkU6WRnUY69hXzRjD3dLpatcLrrBKspEXTLgZx3+/hLs6TjMAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=En37rQEO; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-307325f2436so71196791fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 12:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741206352; x=1741811152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kRg06xQhteqawCafgfjFLThHRcbbZlFP8XoRNk9svMc=;
        b=En37rQEOwNEnilpaYQrNIKlq+jkUFllj6y3jXSPWfnQZ5jM2Jxqdn6hzuYaKERSOX8
         OsT3xGbLqZ8yfsYEQ3HLyZMioqWtgIeWP/aw8jwO7/GZZj3e5S9nllpAAfv9NdWtBGeJ
         njnB3EOPNN6ggqCVkv6gnlNcZEFluqteOCEIxg9QX7MjiSZUWS2ImCcFn9VXKs6cXkoY
         ZagRRa8EgW3ha1pP6U3u92PzDIQWht+y1g2GSeGx+ZVJ3sqmD2UQ+i2bzMauS+NGlVTA
         iDPo2nfLbPB5FdKFT7uWc1tdX1L9mdELXPeVSsYl+VcJNxb3QAlptddkAP+AR6+jkhjM
         4Z5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741206352; x=1741811152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kRg06xQhteqawCafgfjFLThHRcbbZlFP8XoRNk9svMc=;
        b=PcwaYW58V7jPMoBQmcPoJL1/ol1xY2O5DQIFF4yv4yAFWV+4Imraf21q6sRaeWmyO6
         ifvIQIJmUjZTxT85EsvpsOjw8PpAzdDMtxHCnQvpSIMLdTAz/fgGop3wcPZKMH46PEaQ
         XFFTAV3THRVwxWB0ILZueT0nZ2bojTrSBk8CVRxLvrJbA1gLI9mnlNmBYJYQHKD+NK55
         Sz702MueRSWo3Zc8v5hRvaBI9RnMl8djXa9NUKefLhv8oOGt6+D0nJ/XXzzh9r8imuAz
         Y4yX/pSNYsGHfLhCMPO1MJGwOKRbXs7tLkfenjSd1UcG6+gDRvHVfiovf3H8dvBwyJHd
         HiRw==
X-Forwarded-Encrypted: i=1; AJvYcCUo58EBNxn1g2H7VEzIe73PiS2Gk5CHCm682gZYJ+qqwEsZyLPX8cabjB1Kat0kSSl6r6Oad1b9eYgeX0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT9bkNcKqBzXG7/RhvKUao9kvV7BYGw86kYtMVQm5DaS+mZUFk
	v5+yojSmKremBzb5QyYXDDZsMH+PeiFoORk0jboZs715BKMVo28nXwaNc7aWf5Y=
X-Gm-Gg: ASbGncvLFQd805aEHU1JWzfpBnRHLMhD6ENWMi4+0KgckZutXqjZFVo+1vWg8T8FTRm
	Tx8wtnFNPF/FBYsnCb1MS3zBRIeZgBjKlC8paTRVTtXg1UUdFBjPo00hp18KhBpFfi1I4cKBaKY
	dQMiaVgNK1gnTlHQiFu0FNbCnpfzgxS0zQ64YUXETj4R9q2j/KY2fIKVKtr1HF9YRVc8UjHu4/3
	IAUv3YFwHL/DF6Ce7AHuuSkWP2OHd1xMNWbIT3Gpt+dZvNdiu3a0F/TiH9zZ3QMWYlc7D/d8NrL
	3v6HdIioMzK1V5Z5v4XalROjrNtTLW6UD466x9aRFQS88lcnnqaor4VBRL2S6pqhmXUpImBc/9j
	cJ0N4ZWO5l35vVrw5I6RWuRx9
X-Google-Smtp-Source: AGHT+IFmT7EnM/tzZTKB/n17kU1Vh7+oIWehWOZ3dkuaCJUW35/szLNpsWIhcyOaJMg4WyTaTYUnzA==
X-Received: by 2002:a05:651c:2208:b0:30b:d156:9e93 with SMTP id 38308e7fff4ca-30bd7ae91aamr19898841fa.25.1741206352448;
        Wed, 05 Mar 2025 12:25:52 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30b866f3630sm21014931fa.0.2025.03.05.12.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 12:25:51 -0800 (PST)
Date: Wed, 5 Mar 2025 22:25:50 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, liangjian010@huawei.com, 
	chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com, 
	shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 drm-dp 7/8] drm/hisilicon/hibmc: Enable this hot plug
 detect of irq feature
Message-ID: <3ylvvfee5yekzunxctsmqrk2rw6awyvgryl6nhzprgrlvjsknt@mgabeirg3s2r>
References: <20250305112647.2344438-1-shiyongbang@huawei.com>
 <20250305112647.2344438-8-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305112647.2344438-8-shiyongbang@huawei.com>

On Wed, Mar 05, 2025 at 07:26:46PM +0800, Yongbang Shi wrote:
> From: Baihan Li <libaihan@huawei.com>
> 
> Add HPD interrupt enable functions in drm framework. Add link reset
> process to reset link status when a new connector pulgged in. Because the
> connected VGA connector would make driver can't get the userspace
> call, adding detect_ctx in vga connector to make HPD active userspace.
> 
> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
> ChangeLog:
> v3 -> v4:
>   - add link reset of rates and lanes in pre link training process, suggested by Dmitry Baryshkov.
>   - add vdac detect and connected/disconnected status to enable HPD process, suggested by Dmitry Baryshkov.
>   - remove a drm_client, suggested by Dmitry Baryshkov.
>   - fix build errors reported by kernel test robot <lkp@intel.com>
>     Closes: https://lore.kernel.org/oe-kbuild-all/202502231304.BCzV4Y8D-lkp@intel.com/
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
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    | 36 +++++++++++++++++++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  5 +++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c  |  3 ++
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 33 +++++++++++++++++
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |  2 ++
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c  |  3 ++
>  7 files changed, 83 insertions(+)
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
> index ce7cb07815b2..8f0daec7d174 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> @@ -189,6 +189,36 @@ int hibmc_dp_hw_init(struct hibmc_dp *dp)
>  	return 0;
>  }
>  
> +void hibmc_dp_enable_int(struct hibmc_dp *dp)
> +{
> +	struct hibmc_dp_dev *dp_dev = dp->dp_dev;
> +
> +	writel(HIBMC_DP_INT_ENABLE, dp_dev->base + HIBMC_DP_INTR_ENABLE);
> +}
> +
> +void hibmc_dp_disable_int(struct hibmc_dp *dp)
> +{
> +	struct hibmc_dp_dev *dp_dev = dp->dp_dev;
> +
> +	writel(0, dp_dev->base + HIBMC_DP_INTR_ENABLE);
> +	writel(HIBMC_DP_INT_RST, dp_dev->base + HIBMC_DP_INTR_ORIGINAL_STATUS);
> +}
> +
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
> @@ -227,6 +257,12 @@ int hibmc_dp_mode_set(struct hibmc_dp *dp, struct drm_display_mode *mode)
>  	return 0;
>  }
>  
> +void hibmc_dp_reset_link(struct hibmc_dp *dp)
> +{
> +	dp->dp_dev->link.status.clock_recovered = false;
> +	dp->dp_dev->link.status.channel_equalized = false;
> +}
> +
>  static const struct hibmc_dp_color_raw g_rgb_raw[] = {
>  	{CBAR_COLOR_BAR, 0x000, 0x000, 0x000},
>  	{CBAR_WHITE,     0xfff, 0xfff, 0xfff},
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> index 83a53dae8012..665f5b166dfb 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> @@ -49,11 +49,16 @@ struct hibmc_dp {
>  	void __iomem *mmio;
>  	struct drm_dp_aux aux;
>  	struct hibmc_dp_cbar_cfg cfg;
> +	u32 irq_status;
>  };
>  
>  int hibmc_dp_hw_init(struct hibmc_dp *dp);
>  int hibmc_dp_mode_set(struct hibmc_dp *dp, struct drm_display_mode *mode);
>  void hibmc_dp_display_en(struct hibmc_dp *dp, bool enable);
>  void hibmc_dp_set_cbar(struct hibmc_dp *dp, const struct hibmc_dp_cbar_cfg *cfg);
> +void hibmc_dp_reset_link(struct hibmc_dp *dp);
> +void hibmc_dp_hpd_cfg(struct hibmc_dp *dp);
> +void hibmc_dp_enable_int(struct hibmc_dp *dp);
> +void hibmc_dp_disable_int(struct hibmc_dp *dp);
>  
>  #endif
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c
> index f6e722d063de..54a09e7565ec 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c
> @@ -45,6 +45,9 @@ static int hibmc_dp_link_training_configure(struct hibmc_dp_dev *dp)
>  	if (ret)
>  		drm_err(dp->dev, "dp aux read dpcd failed, ret: %d\n", ret);
>  
> +	dp->link.cap.link_rate = dp->dpcd[DP_MAX_LINK_RATE];
> +	dp->link.cap.lanes = 0x2;
> +
>  	return ret;
>  }
>  
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> index a7f611e82f73..31f1e8970265 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> @@ -13,6 +13,8 @@
>  #include "hibmc_drm_drv.h"
>  #include "dp/dp_hw.h"
>  
> +#define DP_MASKED_SINK_HPD_PLUG_INT	BIT(2)
> +
>  static int hibmc_dp_connector_get_modes(struct drm_connector *connector)
>  {
>  	struct hibmc_dp *dp = to_hibmc_dp(connector);
> @@ -39,6 +41,8 @@ static int hibmc_dp_late_register(struct drm_connector *connector)
>  {
>  	struct hibmc_dp *dp = to_hibmc_dp(connector);
>  
> +	hibmc_dp_enable_int(dp);
> +
>  	return drm_dp_aux_register(&dp->aux);
>  }
>  
> @@ -47,6 +51,8 @@ static void hibmc_dp_early_unregister(struct drm_connector *connector)
>  	struct hibmc_dp *dp = to_hibmc_dp(connector);
>  
>  	drm_dp_aux_unregister(&dp->aux);
> +
> +	hibmc_dp_disable_int(dp);
>  }
>  
>  static const struct drm_connector_funcs hibmc_dp_conn_funcs = {
> @@ -98,6 +104,31 @@ static const struct drm_encoder_helper_funcs hibmc_dp_encoder_helper_funcs = {
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
> +		hibmc_dp_hpd_cfg(&priv->dp);
> +	} else {
> +		drm_dbg_dp(&priv->dev, "HPD OUT isr occur!\n");
> +		hibmc_dp_reset_link(&priv->dp);
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
>  int hibmc_dp_init(struct hibmc_drm_private *priv)
>  {
>  	struct drm_device *dev = &priv->dev;
> @@ -138,5 +169,7 @@ int hibmc_dp_init(struct hibmc_drm_private *priv)
>  
>  	drm_connector_attach_encoder(connector, encoder);
>  
> +	connector->polled = DRM_CONNECTOR_POLL_HPD;
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
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
> index 05e19ea4c9f9..e8a527ede854 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c

Separate commit, please. It concerns your VGA connector, not the DP
connector.

LGTM otherwise.

> @@ -60,6 +60,7 @@ static void hibmc_connector_destroy(struct drm_connector *connector)
>  static const struct drm_connector_helper_funcs
>  	hibmc_connector_helper_funcs = {
>  	.get_modes = hibmc_connector_get_modes,
> +	.detect_ctx = drm_connector_helper_detect_from_ddc,
>  };
>  
>  static const struct drm_connector_funcs hibmc_connector_funcs = {
> @@ -127,5 +128,7 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv)
>  
>  	drm_connector_attach_encoder(connector, encoder);
>  
> +	connector->polled = DRM_CONNECTOR_POLL_CONNECT | DRM_CONNECTOR_POLL_DISCONNECT;
> +
>  	return 0;
>  }
> -- 
> 2.33.0
> 

-- 
With best wishes
Dmitry

