Return-Path: <linux-kernel+bounces-512090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 466D6A333EA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B533C1675EB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 00:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6950B179BD;
	Thu, 13 Feb 2025 00:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WV4uuY6Y"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F27535951
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 00:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739405908; cv=none; b=eUmgPb2JSrtFWPL0LOFxsaxBusbuD9NF4ceiH3PaXSoLc31Q3nUm9QzHzYBaG3O9UxuBnqR88KPdIV1UIAB42pwBXj3kMJiaouZ0DT6/nWdw6MwHNBxRQb64T8Kxbe/5tkgPMRM/vrwY8YSQWeGLbghX1KlqRqgxoG7YdaUqJDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739405908; c=relaxed/simple;
	bh=eeo81TLl+NrulkZxb+gAEcW0C1qMa9U8FP29Vzfxab4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsiqJvgtCFj4Q4KjW92EmI+L6I5cjWTRKoi/fC83Sq1+aNet+3jzpOcIlyGJIEhOCll3EETbDL/QQi1AP17xq8eDvDSIQHwc9vSOh/Etju3FZTT4xCIwdnKYC/0+ZS1HE2nqTIv5sGnL3BzOnkdP/IfyUFuvpOEWlybFRsTVfjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WV4uuY6Y; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30761be8fa8so3224771fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739405904; x=1740010704; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NYwMl8hYId1dHgVixRuFQX5UO/e6ftwN7SI4dVqr4nw=;
        b=WV4uuY6YAdV7hVb731C9oY7JedLlKVgdB0Wkx8dzduLmhyszcgQK3sTSCwLLDr+/sF
         ykG39OA/v+B+Uyq8TWD+tdxVVFulYLrsaRPBAOvPe0GuSDL8bYS/Nk7R3JCSKXzMWPSJ
         4UsfugzkCwKkN6nI1s1owVTP+snfnArl8RHs4wJkaRSNdQF/nW5q2AAqup7WWyR+puc1
         an+tyhu/Hq6l/dz3mUI1YF9VaI/edzmKrIy8nvObxeWVJinZZmbethcHKIjVnOPl4lau
         BacRxZc9zZWR9liZTubPHZ5fwn16tpj8J7gTKpBL5bzUS7x0COuxnxJzDrekrdZRKaRP
         W2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739405904; x=1740010704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYwMl8hYId1dHgVixRuFQX5UO/e6ftwN7SI4dVqr4nw=;
        b=o5lX/YgdD5mxQ2lCtFgMYwyqwNZ85Jv2FBbHM4beeHcvPO2pf3oKVHYB6rtkMEGPCo
         F+ynSR6g9aGmCx3XE4H3Z5eSlIPCTzvtCo6RObBC9neVnw3AjJK4A58rBHtMJ1cTb5ZF
         WSCBoMdI0RqdaM7I/R3jaY5eD74MNhhogGHIoxmxCujfvhV8wjiBWdIp2+3u8XaWBcoX
         I3JKxrf1Pw9LJ1kIB8CXDFEQx27KGKP3zpCw0++GhmJaz1fFcPTxny5IbxOudGG1MRZt
         ptYJt+QrFbkkfeP/6sYJodYeYTRrp66JlLvZvITyFULl5rDwnDCiP3OculY5gFAmWovT
         WwTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxV/cEfHe7oz/fv2UzbG8ndq4/A7IzBMF5F8+gdlQ8ohXAfhI5MqieRJFhEQrF1H2JEcGZoCeI/M8Pvp4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw12Fiy9+rVYmYKCmF0Ex66BQVVXCQv1/7P0FKOE78R+EQPgdAF
	dqXjDnmBK52Io9JAvqWyjoloqz9hIm418PvqVOhosHim5YDHOw6k2wrQ2oYdIdg=
X-Gm-Gg: ASbGnctb3GwGPvsNugwjuZsFfixVfE4PgFidiGDnm3ylGGk5xhdO57Zv3EfypTIX5BW
	rHkzZLZ7XP3XQptZkYhNLKbmk2tp9ghzkzdyTycM/mMsFpCajG4EprSKaVBdW8EI7+JE19S1J2d
	Le/v9MUwraZqA69w/jlMsrBH8y9XXF5XNz0/JhoR2UEXW22n0PqKHenFqctBokC09ODiiO18Blu
	DIwCEekIHBKLKLhP4g2bqB+oCepMWHKdoUYAQDeQ4Gjz99CCAFntQfpr7oAFpnxijeUCrkwm/ic
	xEdUduYsjxMWgvqz2wtHW5doFnHOjEWF9oaqx+HONcalVqYB1PVirpA6WhwyvPeJZbFhzNM=
X-Google-Smtp-Source: AGHT+IEGBtbida/nkyz2iSc/ztiC9h+P0x7PpqIb2FckqspMzJVGwE6/YlJrL2BX/gLygIxkY5XDvw==
X-Received: by 2002:a2e:b8c8:0:b0:309:bc3:3a56 with SMTP id 38308e7fff4ca-3090db47b6bmr5792721fa.0.1739405904383;
        Wed, 12 Feb 2025 16:18:24 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-309100c691fsm388161fa.5.2025.02.12.16.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 16:18:23 -0800 (PST)
Date: Thu, 13 Feb 2025 02:18:20 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, liangjian010@huawei.com, 
	chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com, 
	shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 drm-dp 5/7] drm/hisilicon/hibmc: Get link status and
 dpcd caps
Message-ID: <yiaq5suivzbgjzc2q5pjxwmfmwaqdhg6of3nn44wirmer3g62w@ytvgyr4h773l>
References: <20250210144959.100551-1-shiyongbang@huawei.com>
 <20250210144959.100551-6-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210144959.100551-6-shiyongbang@huawei.com>

On Mon, Feb 10, 2025 at 10:49:57PM +0800, Yongbang Shi wrote:
> From: Baihan Li <libaihan@huawei.com>
> 
> Prepare the hibmc_dp_get_foo() functions for debugfs using in
> next patch. We also add dpcd's if statement in link training process,
> because we have the dpcd.

Unrelated, split to a separate patch.

> 
> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h |  3 ++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c   | 15 ++++++++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h   |  3 ++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c | 39 ++++++++++++++++----
>  4 files changed, 52 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
> index d613da8b544c..8eb1659c7685 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
> @@ -26,6 +26,9 @@ struct hibmc_link_status {
>  struct hibmc_link_cap {
>  	u8 link_rate;
>  	u8 lanes;
> +	int rx_dpcd_revision;
> +	bool is_tps3;
> +	bool is_tps4;
>  };
>  
>  struct hibmc_dp_link {
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> index 8adace0befde..5e889c377117 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> @@ -227,6 +227,21 @@ int hibmc_dp_mode_set(struct hibmc_dp *dp, struct drm_display_mode *mode)
>  	return 0;
>  }
>  
> +u8 hibmc_dp_get_link_rate(struct hibmc_dp *dp)
> +{
> +	return dp->dp_dev->link.cap.link_rate;
> +}
> +
> +u8 hibmc_dp_get_lanes(struct hibmc_dp *dp)
> +{
> +	return dp->dp_dev->link.cap.lanes;
> +}
> +
> +int hibmc_dp_get_dpcd(struct hibmc_dp *dp)
> +{
> +	return dp->dp_dev->link.cap.rx_dpcd_revision;
> +}
> +
>  static const struct hibmc_dp_color_raw g_rgb_raw[] = {
>  	{CBAR_COLOR_BAR, 0x000, 0x000, 0x000},
>  	{CBAR_WHITE,     0xfff, 0xfff, 0xfff},
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> index 621a0a1d7eb7..823544b8008b 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> @@ -54,6 +54,9 @@ struct hibmc_dp {
>  int hibmc_dp_hw_init(struct hibmc_dp *dp);
>  int hibmc_dp_mode_set(struct hibmc_dp *dp, struct drm_display_mode *mode);
>  void hibmc_dp_display_en(struct hibmc_dp *dp, bool enable);
> +int hibmc_dp_get_dpcd(struct hibmc_dp *dp);
> +u8 hibmc_dp_get_link_rate(struct hibmc_dp *dp);
> +u8 hibmc_dp_get_lanes(struct hibmc_dp *dp);
>  void hibmc_dp_set_cbar(struct hibmc_dp *dp, const struct hibmc_dp_cbar_cfg *cfg);
>  
>  #endif
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c
> index 4a99a9b7e3c4..39345fc78c06 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c
> @@ -7,6 +7,7 @@
>  #include "dp_comm.h"
>  #include "dp_reg.h"
>  #include "dp_serdes.h"
> +#include "dp_config.h"
>  
>  #define HIBMC_EQ_MAX_RETRY 5
>  
> @@ -42,11 +43,7 @@ static int hibmc_dp_link_training_configure(struct hibmc_dp_dev *dp)
>  		return ret >= 0 ? -EIO : ret;
>  	}
>  
> -	ret = drm_dp_read_dpcd_caps(dp->aux, dp->dpcd);
> -	if (ret)
> -		drm_err(dp->dev, "dp aux read dpcd failed, ret: %d\n", ret);
> -
> -	return ret;
> +	return 0;
>  }
>  
>  static int hibmc_dp_link_set_pattern(struct hibmc_dp_dev *dp, int pattern)
> @@ -189,15 +186,17 @@ static int hibmc_dp_link_training_cr(struct hibmc_dp_dev *dp)
>  	bool level_changed;
>  	u32 voltage_tries;
>  	u32 cr_tries;
> +	u32 max_cr;
>  	int ret;
>  
>  	/*
>  	 * DP 1.4 spec define 10 for maxtries value, for pre DP 1.4 version set a limit of 80
>  	 * (4 voltage levels x 4 preemphasis levels x 5 identical voltage retries)
>  	 */
> +	max_cr = dp->link.cap.rx_dpcd_revision >= DP_DPCD_REV_14 ? 10 : 80;
>  
>  	voltage_tries = 1;
> -	for (cr_tries = 0; cr_tries < 80; cr_tries++) {
> +	for (cr_tries = 0; cr_tries < max_cr; cr_tries++) {
>  		drm_dp_link_train_clock_recovery_delay(dp->aux, dp->dpcd);
>  
>  		ret = drm_dp_dpcd_read_link_status(dp->aux, lane_status);
> @@ -234,7 +233,7 @@ static int hibmc_dp_link_training_cr(struct hibmc_dp_dev *dp)
>  		voltage_tries = level_changed ? 1 : voltage_tries + 1;
>  	}
>  
> -	drm_err(dp->dev, "dp link training clock recovery 80 times failed\n");
> +	drm_err(dp->dev, "dp link training clock recovery %u times failed\n", max_cr);
>  	dp->link.status.clock_recovered = false;
>  
>  	return 0;
> @@ -244,9 +243,17 @@ static int hibmc_dp_link_training_channel_eq(struct hibmc_dp_dev *dp)
>  {
>  	u8 lane_status[DP_LINK_STATUS_SIZE] = {0};
>  	u8 eq_tries;
> +	int tps;
>  	int ret;
>  
> -	ret = hibmc_dp_link_set_pattern(dp, DP_TRAINING_PATTERN_2);
> +	if (dp->link.cap.is_tps4)
> +		tps = DP_TRAINING_PATTERN_4;
> +	else if (dp->link.cap.is_tps3)
> +		tps = DP_TRAINING_PATTERN_3;
> +	else
> +		tps = DP_TRAINING_PATTERN_2;
> +
> +	ret = hibmc_dp_link_set_pattern(dp, tps);
>  	if (ret)
>  		return ret;
>  
> @@ -313,11 +320,27 @@ static int hibmc_dp_link_downgrade_training_eq(struct hibmc_dp_dev *dp)
>  	return hibmc_dp_link_reduce_rate(dp);
>  }
>  
> +static void hibmc_dp_update_caps(struct hibmc_dp_dev *dp)
> +{
> +	dp->link.cap.rx_dpcd_revision = dp->dpcd[DP_DPCD_REV];
> +
> +	dp->link.cap.is_tps3 = (dp->dpcd[DP_DPCD_REV] >= DP_DPCD_REV_13) &&
> +			       (dp->dpcd[DP_MAX_LANE_COUNT] & DP_TPS3_SUPPORTED);
> +	dp->link.cap.is_tps4 = (dp->dpcd[DP_DPCD_REV] >= DP_DPCD_REV_14) &&
> +			       (dp->dpcd[DP_MAX_DOWNSPREAD] & DP_TPS4_SUPPORTED);
> +}
> +
>  int hibmc_dp_link_training(struct hibmc_dp_dev *dp)
>  {
>  	struct hibmc_dp_link *link = &dp->link;
>  	int ret;
>  
> +	ret = drm_dp_read_dpcd_caps(dp->aux, dp->dpcd);
> +	if (ret)
> +		drm_err(dp->dev, "dp aux read dpcd failed, ret: %d\n", ret);
> +
> +	hibmc_dp_update_caps(dp);
> +
>  	while (true) {
>  		ret = hibmc_dp_link_training_cr_pre(dp);
>  		if (ret)
> -- 
> 2.33.0
> 

-- 
With best wishes
Dmitry

