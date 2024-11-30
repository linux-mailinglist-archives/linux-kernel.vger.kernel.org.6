Return-Path: <linux-kernel+bounces-426140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 326639DEF6C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 09:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB38C163611
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 08:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A9B14AD24;
	Sat, 30 Nov 2024 08:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WfgLUXrX"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3667B1C6A3
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 08:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732956839; cv=none; b=qIdhTUHFSnorWdFmbDXLfksT4/jr+qd6GDEOrn0wmjOTJVd9HhnADnPV8ZBUdQ4OwvUZ6N0LDBWMmSzW8zYzYq071CgnSPTOpdVeuJoTdBmmR81DGslil20spfYtHKUa6gQVwwCHztxrvpOUSX7szyeWKwMHGOYkoN/pacKyopQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732956839; c=relaxed/simple;
	bh=LaYYxSHYkkGIa9+XmxXjHduCKjrPxWMW6pZfXAZfioQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HISBqQMUNdDdUVc0bEVYOdLqkQ+nSPreXNXB2C2bdWn4f235Z+tY7l92kpvQUtJp0gHDcOAEdV4j2SDnvFQwZNEKucQYca+r/Wic3hd/1+bL3eJ83YHd+63OKnVEUIS+TVvRX8VeECbzxXTRNG7tm/YDRmbjFwQZsXLYLkXNmn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WfgLUXrX; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53de035ea13so2577565e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 00:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732956835; x=1733561635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MCRiyMdK31NndjkRy/3fWARIEqrVAn7I6TcjbFNOugw=;
        b=WfgLUXrXwV9BamX679xe1eFt39FGt20Jl/K8Lph86s7nbncsxMuJZMFejpweDvVFqP
         Bq/dFBEOq3uAeoggmPFqoZ5gKDOgLgtTZ18mPuhhASOjvMcLNCPBFvNvc1QyfOBm0oXq
         C8QyjPowkv/LhriWgcSMaHxre25rwjKyDAJn3pKme/7hl8rEDnyb/cBqD22rZ+Bgu+vt
         YaQuX0hAtorT/mCxROJK67G/BkXV27bZrDBgGmZf9p07GvLzgHofZaRRyTua747uKuFN
         Rthajy98psaWG0IFm3xnvktrbJF4EjtfuRJ8up95z1si1fiCH6TLqyO/4MWTCevYsoO1
         Tyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732956835; x=1733561635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCRiyMdK31NndjkRy/3fWARIEqrVAn7I6TcjbFNOugw=;
        b=SkUGGefPF3R4IMkCzwM2ENO6X7n5/EaBPUOaZ+ot212kIsJqI8cySvFtGYuXVq79lo
         CTCivIk+lgicQH16f4v9HFjWmuRgScX8v4d9rmkkzzGYaoMn4pc68MAedip/A2gfET64
         hWs3yUfgJ/uN25FI/tipR1SnwpGR5iY/7bLeXvoNSwIhAj2GQhDBjiv3c3vtmbsmYjSt
         jXZLvqxMmQH8fq/aynLkkpXB2+cpQOPAGZ9j6uNx5LAvxCiUZuf7If1/xVyIao8sAI/m
         9uRROxE/rccyTh1ihsWD8kpR8fN+meRD+iKfr/VXSaM0YHZE3YQdGnY3/sY9xL6wkBgA
         u8vw==
X-Forwarded-Encrypted: i=1; AJvYcCUyRC5E9Hc//enKadEkXDLY+0886jjzV5J3LZseRVSquAoSgHpdQdXLtzMkuGptmBjBLectkd/ezGygSLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDa9vETYSlCDMByfJEqKR/kUiv/zGtrcFIJDo7XWXOwMVdL8X3
	S5ZdX9efEw+YYBoj/VZdy74zJB+oFgOlBpBoCTV+2pgGyIy7Qmy/gN9E/Gbji6U=
X-Gm-Gg: ASbGncvnyH+fdlphcQizPnkBowSasy5M2dquLwQwcmk9uvUL6+QbfhFut+YbVvbGzsc
	Cf7d4Oz+DxEicfj/a1KFqwlpaGa4b0tt3KKQogZZpm6jb7J/+hQ0greW2tRhKJqikzcMfuNOkOo
	kDp+/u/IjaqRXqyAs0Bvz+/L4ve0/rBAJsjbGWl1x0E39ZPtynKNL69LLTNm0ZNNvaIH+5uQlJc
	OBBA/r8JZFnbcXUXovC50/GjeGnBT1e7VE04TgMRIW5Xb9RowjcLbJwZlJVMNW+5hNKU76TaMFa
	suh1CAjXzUUB7vjFIRqmNoMGzhv3Wg==
X-Google-Smtp-Source: AGHT+IEW2arMDWGqYZ1mh73vhp8aH4A2JUPywHSwLMM0QAhe/TE1+vmLynKojA+Q9JDxHrSsDsIweA==
X-Received: by 2002:a05:6512:280e:b0:53d:e50a:7031 with SMTP id 2adb3069b0e04-53df00c6063mr8808918e87.3.1732956835260;
        Sat, 30 Nov 2024 00:53:55 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df646f2cesm695508e87.121.2024.11.30.00.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 00:53:53 -0800 (PST)
Date: Sat, 30 Nov 2024 10:53:51 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: heiko@sntech.de, robh@kernel.org, conor+dt@kernel.org, 
	algea.cao@rock-chips.com, rfoss@kernel.org, devicetree@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, sebastian.reichel@collabora.com, 
	dri-devel@lists.freedesktop.org, hjc@rock-chips.com, kever.yang@rock-chips.com, 
	linux-rockchip@lists.infradead.org, vkoul@kernel.org, andy.yan@rock-chips.com, krzk+dt@kernel.org, 
	linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de
Subject: Re: [PATCH v1 06/10] drm/bridge: analogix_dp: Add support for phy
 configuration.
Message-ID: <twhosvpoyafo472gqsblpvxmuewe2lkqufxabp2q7o636uinfm@unzyfv2pchqn>
References: <20241127075157.856029-1-damon.ding@rock-chips.com>
 <20241127075157.856029-7-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127075157.856029-7-damon.ding@rock-chips.com>

On Wed, Nov 27, 2024 at 03:51:53PM +0800, Damon Ding wrote:
> Add support to configurate link rate, lane count, voltage swing and
> pre-emphasis with phy_configure(). It is helpful in application scenarios
> where analogix controller is mixed with the phy of other vendors.
> 
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> ---
>  .../drm/bridge/analogix/analogix_dp_core.c    |  4 +-
>  .../drm/bridge/analogix/analogix_dp_core.h    |  2 +
>  .../gpu/drm/bridge/analogix/analogix_dp_reg.c | 90 +++++++++++++++++++
>  3 files changed, 94 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 6f10d88a34c5..7624ed13cdbf 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -1672,7 +1672,7 @@ EXPORT_SYMBOL_GPL(analogix_dp_probe);
>  
>  int analogix_dp_suspend(struct analogix_dp_device *dp)
>  {
> -	phy_power_off(dp->phy);
> +	analogix_dp_phy_power_off(dp);

Why?

>  
>  	if (dp->plat_data->power_off)
>  		dp->plat_data->power_off(dp->plat_data);
> @@ -1696,7 +1696,7 @@ int analogix_dp_resume(struct analogix_dp_device *dp)
>  	if (dp->plat_data->power_on)
>  		dp->plat_data->power_on(dp->plat_data);
>  
> -	phy_power_on(dp->phy);
> +	analogix_dp_phy_power_on(dp);

Why?

>  
>  	analogix_dp_init_dp(dp);
>  
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> index 774d11574b09..a76079d61768 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> @@ -232,5 +232,7 @@ int analogix_dp_send_psr_spd(struct analogix_dp_device *dp,
>  			     struct dp_sdp *vsc, bool blocking);
>  ssize_t analogix_dp_transfer(struct analogix_dp_device *dp,
>  			     struct drm_dp_aux_msg *msg);
> +void analogix_dp_phy_power_on(struct analogix_dp_device *dp);
> +void analogix_dp_phy_power_off(struct analogix_dp_device *dp);
>  
>  #endif /* _ANALOGIX_DP_CORE_H */
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> index 3afc73c858c4..809bb0c72d18 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> @@ -11,6 +11,7 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
> +#include <linux/phy/phy.h>
>  
>  #include <drm/bridge/analogix_dp.h>
>  
> @@ -513,10 +514,27 @@ void analogix_dp_enable_sw_function(struct analogix_dp_device *dp)
>  void analogix_dp_set_link_bandwidth(struct analogix_dp_device *dp, u32 bwtype)
>  {
>  	u32 reg;
> +	int ret;
>  
>  	reg = bwtype;
>  	if ((bwtype == DP_LINK_BW_2_7) || (bwtype == DP_LINK_BW_1_62))
>  		writel(reg, dp->reg_base + ANALOGIX_DP_LINK_BW_SET);
> +
> +	if (dp->phy) {
> +		union phy_configure_opts phy_cfg = {0};
> +
> +		phy_cfg.dp.lanes = dp->link_train.lane_count;

You can drop this, .set_lanes is false.

> +		phy_cfg.dp.link_rate =
> +			drm_dp_bw_code_to_link_rate(dp->link_train.link_rate) / 100;
> +		phy_cfg.dp.set_lanes = false;
> +		phy_cfg.dp.set_rate = true;
> +		phy_cfg.dp.set_voltages = false;

You don't need to set those to false, it's cleared by = {0};

> +		ret = phy_configure(dp->phy, &phy_cfg);
> +		if (ret && ret != -EOPNOTSUPP) {
> +			dev_err(dp->dev, "%s: phy_configure() failed: %d\n", __func__, ret);
> +			return;
> +		}
> +	}
>  }
>  
>  void analogix_dp_get_link_bandwidth(struct analogix_dp_device *dp, u32 *bwtype)
> @@ -530,9 +548,24 @@ void analogix_dp_get_link_bandwidth(struct analogix_dp_device *dp, u32 *bwtype)
>  void analogix_dp_set_lane_count(struct analogix_dp_device *dp, u32 count)
>  {
>  	u32 reg;
> +	int ret;
>  
>  	reg = count;
>  	writel(reg, dp->reg_base + ANALOGIX_DP_LANE_COUNT_SET);
> +
> +	if (dp->phy) {
> +		union phy_configure_opts phy_cfg = {0};
> +
> +		phy_cfg.dp.lanes = dp->link_train.lane_count;
> +		phy_cfg.dp.set_lanes = true;
> +		phy_cfg.dp.set_rate = false;
> +		phy_cfg.dp.set_voltages = false;

Likewise

> +		ret = phy_configure(dp->phy, &phy_cfg);
> +		if (ret && ret != -EOPNOTSUPP) {
> +			dev_err(dp->dev, "%s: phy_configure() failed: %d\n", __func__, ret);
> +			return;
> +		}
> +	}
>  }
>  
>  void analogix_dp_get_lane_count(struct analogix_dp_device *dp, u32 *count)
> @@ -546,10 +579,39 @@ void analogix_dp_get_lane_count(struct analogix_dp_device *dp, u32 *count)
>  void analogix_dp_set_lane_link_training(struct analogix_dp_device *dp)
>  {
>  	u8 lane;
> +	int ret;
>  
>  	for (lane = 0; lane < dp->link_train.lane_count; lane++)
>  		writel(dp->link_train.training_lane[lane],
>  		       dp->reg_base + ANALOGIX_DP_LN0_LINK_TRAINING_CTL + 4 * lane);
> +
> +	if (dp->phy) {
> +		union phy_configure_opts phy_cfg = {0};
> +
> +		for (lane = 0; lane < dp->link_train.lane_count; lane++) {
> +			u8 training_lane = dp->link_train.training_lane[lane];
> +			u8 vs, pe;
> +
> +			vs = (training_lane & DP_TRAIN_VOLTAGE_SWING_MASK) >>
> +			     DP_TRAIN_VOLTAGE_SWING_SHIFT;
> +			pe = (training_lane & DP_TRAIN_PRE_EMPHASIS_MASK) >>
> +			     DP_TRAIN_PRE_EMPHASIS_SHIFT;
> +			phy_cfg.dp.voltage[lane] = vs;
> +			phy_cfg.dp.pre[lane] = pe;
> +		}
> +
> +		phy_cfg.dp.lanes = dp->link_train.lane_count;
> +		phy_cfg.dp.link_rate =
> +			drm_dp_bw_code_to_link_rate(dp->link_train.link_rate) / 100;

You can drop these two.

> +		phy_cfg.dp.set_lanes = false;
> +		phy_cfg.dp.set_rate = false;
> +		phy_cfg.dp.set_voltages = true;
> +		ret = phy_configure(dp->phy, &phy_cfg);
> +		if (ret && ret != -EOPNOTSUPP) {
> +			dev_err(dp->dev, "%s: phy_configure() failed: %d\n", __func__, ret);
> +			return;
> +		}
> +	}
>  }
>  
>  u32 analogix_dp_get_lane_link_training(struct analogix_dp_device *dp, u8 lane)
> @@ -1053,3 +1115,31 @@ ssize_t analogix_dp_transfer(struct analogix_dp_device *dp,
>  
>  	return -EREMOTEIO;
>  }
> +
> +void analogix_dp_phy_power_on(struct analogix_dp_device *dp)
> +{
> +	int ret;
> +
> +	ret = phy_set_mode(dp->phy, PHY_MODE_DP);
> +	if (ret) {
> +		dev_err(dp->dev, "%s: phy_set_mode() failed: %d\n", __func__, ret);
> +		return;
> +	}
> +
> +	ret = phy_power_on(dp->phy);
> +	if (ret) {
> +		dev_err(dp->dev, "%s: phy_power_on() failed: %d\n", __func__, ret);

There is already a dev_err() call in phy_power_on().

> +		return;
> +	}
> +}
> +
> +void analogix_dp_phy_power_off(struct analogix_dp_device *dp)
> +{
> +	int ret;
> +
> +	ret = phy_power_off(dp->phy);
> +	if (ret) {
> +		dev_err(dp->dev, "%s: phy_power_off() failed: %d\n", __func__, ret);

There is already a dev_err() call in phy_power_off().

> +		return;
> +	}
> +}
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

-- 
With best wishes
Dmitry

