Return-Path: <linux-kernel+bounces-555642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BDFA5BAAF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 374A317093F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 08:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7585C22259D;
	Tue, 11 Mar 2025 08:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UAHhs/5U"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320481EB182
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 08:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741681224; cv=none; b=l6QK7JDVo8f4bOKyf7f9RWqlPwBTqBOHwv5DuPrI20LSiVqMvExI6WF9GlBXbM6rg2ShvOG/vu59XtyKT79ateTn3FQ3SOMfsgP2e/hPFJz0zPMv6fG88O0WI41Y4gl9Y5N4eTOpgGBfC8/rOA7TQs6nGO99Xlez5ZCM1yw4v6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741681224; c=relaxed/simple;
	bh=qpe/qHxDtSN44NJQpnHONWC7ecTQQ8UgN8o4ncagqVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrGzHwZhDxrLkCZNj4iXWSrwjV2aIeanE44fZfh0UM93KbTd+Obscqt4ODvCjMRU1F7E6M2l7TFbc3mDVVjqbf7QyuojYIvzB0LAsQL+9tlJZYab048uePHI08t3/xWvKjNJ1cpLL0UpbaA6UsfYXYydPOmBiXy3i3lspida5XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UAHhs/5U; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso8491425e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 01:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741681220; x=1742286020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YZPGTU50Ws38AW0HjS/5KDAyC34WXW4R9Ltnw/jI+eM=;
        b=UAHhs/5UjjaGgA45azt9XkoeKvNxX1Cosg3RJK1C24CNsxOBKl3nbfseM55dQJ9Y0W
         IfeSyas3AlhA3ML8y/qtExLBn1gBZ+Li2Ke+PxbQxSf4qXuSVSJTsIomfc7wXPGWwK5y
         U+YihO3G1NUryLjuBUI6yc+tKuLBBVFLja52UOx+p9oB1R1QLKRJkw41kmddBLN5eSpf
         SZN+CDh/Lg42MW4FB/TEFTJxbAdW9gdTCQ0MVl+lBYFOv2qampe7oxSCshekFQWPeAUT
         6OjL7VUXaubEfWKg/eM/DbjVuTrBEvKMLhyCTrQzn5xmwxk65VnKBskGFlbuHKOvEy/4
         qApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741681220; x=1742286020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZPGTU50Ws38AW0HjS/5KDAyC34WXW4R9Ltnw/jI+eM=;
        b=dmbh9Uu+23cplub9B5etFkd4j3M8+JvIvh8J7kzIR2tywd1AlduQJDkHED0PCGl7z4
         9t8hpVr6uqNUB7y0qy+RF8vI+qMwCOilHoqcb/ebIv9zonRjcFMFEUxkpblyV59gFZJA
         D3Ix/iP4r7hWciVBcYY3w2uMeEqNLn2vNf3pz4Lhn0oTOJyn9maMwSb35AR818ipFRIa
         0y1fjl5AFUqsEsUb7W/OWNg0GgX3Tm4Jjep7iprd4OELrk5pDC70nFMQ0Zq8dG8+l+zO
         BuqP04+djIrq3qOngCQI8J49E7KQYsDV/JMJn7lMAYCwnCbHWaK4eDXcNSbabQIOcCCJ
         sx5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUghCFCVDaAXpEFJAZAKW9ITHpcvJHMM3NGwY34X7/QJ0sueZ0MVF/wC6y2jnkzGezsLbo4uAjPZapOroo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfSviRkqCW3nW57qEr31ICwUdvsVQy+4m9DFYrFMf8QsR+Zw6R
	Am764XdT6pYQta6xoi5sTkTHmBRPXZA8Amyib3jMqm1rPkGoKkxfZ11DzHISaqQ=
X-Gm-Gg: ASbGncv9bUHCY0xRifF8SSvHjQoPkgNVonWFc8xHA6itHRMuafNVL7IfvtXzJxqmY0d
	brXry3bc7yj88llBcglcy4bHMyVJ0tHp3ptJ2gM1yITadFPOpnuKi64+pWnxtmKKlp/wRhdbAug
	4Jb5VIxMmAKq4EXFadZBmcBJZsRJrval44BVPXu2Dhv4uVx+kqX4fB631A8GTgoXGD0fWRQLUDd
	m1WWN606aVR2qF77enAXBslH1VInlve4ZEpxov6RYOoFxilCjsfDRLvy//hgyAEOHydK3iQ9rSD
	1b+3rALjC72PRUHnhuOBRwFszXsbrpOJzyWvoOGegJpODKk8ngoz
X-Google-Smtp-Source: AGHT+IF0T6uCuKPW4cmR1KWx5OtI4Jr0uqhH6tH+7c2IYER/0RP4xNsmD56xV4MalnbRwrGn21IQsg==
X-Received: by 2002:a05:600c:3542:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-43d01bdbc01mr39267425e9.10.1741681220315;
        Tue, 11 Mar 2025 01:20:20 -0700 (PDT)
Received: from linaro.org ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfb7ae4sm16893786f8f.5.2025.03.11.01.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 01:20:19 -0700 (PDT)
Date: Tue, 11 Mar 2025 10:20:18 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	laurentiu.tudor1@dell.com, johan@kernel.org
Subject: Re: [PATCH v1 2/2] drm/msm/dp: Introduce link training per-segment
 for LTTPRs
Message-ID: <Z8/yQsiaPtJHKBUl@linaro.org>
References: <20250310211039.29843-1-alex.vinarskis@gmail.com>
 <20250310211039.29843-3-alex.vinarskis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310211039.29843-3-alex.vinarskis@gmail.com>

On 25-03-10 22:05:52, Aleksandrs Vinarskis wrote:
> DisplayPort requires per-segment link training when LTTPR are switched
> to non-transparent mode, starting with LTTPR closest to the source.
> Only when each segment is trained individually, source can link train
> to sink.
> 
> Implement per-segment link traning when LTTPR(s) are detected, to
> support external docking stations. On higher level, changes are:
> 
> *  Pass phy being trained down to all required helpers
> *  Run CR, EQ link training per phy
> *  Set voltage swing, pre-emphasis levels per phy
> 
> This ensures successful link training both when connected directly to
> the monitor (single LTTPR onboard most X1E laptops) and via the docking
> station (at least two LTTPRs). This does not address/resolve underlying
> mainlink initialization issues.
> 
> Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 136 +++++++++++++++++++---------
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |   2 +-
>  drivers/gpu/drm/msm/dp/dp_display.c |   4 +-
>  3 files changed, 98 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index d8633a596f8d..20f07ef46ef3 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -79,6 +79,8 @@ struct msm_dp_ctrl_private {
>  	struct msm_dp_link *link;
>  	struct msm_dp_catalog *catalog;
>  
> +	int *lttpr_count;
> +
>  	struct phy *phy;
>  
>  	unsigned int num_core_clks;
> @@ -1034,7 +1036,8 @@ static int msm_dp_ctrl_set_vx_px(struct msm_dp_ctrl_private *ctrl,
>  	return 0;
>  }
>  
> -static int msm_dp_ctrl_update_vx_px(struct msm_dp_ctrl_private *ctrl)
> +static int msm_dp_ctrl_update_phy_vx_px(struct msm_dp_ctrl_private *ctrl,
> +					enum drm_dp_phy dp_phy)
>  {
>  	struct msm_dp_link *link = ctrl->link;
>  	int ret = 0, lane, lane_cnt;
> @@ -1075,8 +1078,12 @@ static int msm_dp_ctrl_update_vx_px(struct msm_dp_ctrl_private *ctrl)
>  
>  	drm_dbg_dp(ctrl->drm_dev, "sink: p|v=0x%x\n",
>  			voltage_swing_level | pre_emphasis_level);
> -	ret = drm_dp_dpcd_write(ctrl->aux, DP_TRAINING_LANE0_SET,
> -					buf, lane_cnt);
> +
> +	int reg = dp_phy == DP_PHY_DPRX ?
> +			    DP_TRAINING_LANE0_SET :
> +			    DP_TRAINING_LANE0_SET_PHY_REPEATER(dp_phy);
> +
> +	ret = drm_dp_dpcd_write(ctrl->aux, reg, buf, lane_cnt);
>  	if (ret == lane_cnt)
>  		ret = 0;
>  
> @@ -1084,10 +1091,13 @@ static int msm_dp_ctrl_update_vx_px(struct msm_dp_ctrl_private *ctrl)
>  }
>  
>  static bool msm_dp_ctrl_train_pattern_set(struct msm_dp_ctrl_private *ctrl,
> -		u8 pattern)
> +		u8 pattern, enum drm_dp_phy dp_phy)
>  {
>  	u8 buf;
>  	int ret = 0;
> +	int reg = dp_phy == DP_PHY_DPRX ?
> +			    DP_TRAINING_PATTERN_SET :
> +			    DP_TRAINING_PATTERN_SET_PHY_REPEATER(dp_phy);
>  
>  	drm_dbg_dp(ctrl->drm_dev, "sink: pattern=%x\n", pattern);
>  
> @@ -1096,7 +1106,7 @@ static bool msm_dp_ctrl_train_pattern_set(struct msm_dp_ctrl_private *ctrl,
>  	if (pattern && pattern != DP_TRAINING_PATTERN_4)
>  		buf |= DP_LINK_SCRAMBLING_DISABLE;
>  
> -	ret = drm_dp_dpcd_writeb(ctrl->aux, DP_TRAINING_PATTERN_SET, buf);
> +	ret = drm_dp_dpcd_writeb(ctrl->aux, reg, buf);
>  	return ret == 1;
>  }
>  
> @@ -1115,12 +1125,16 @@ static int msm_dp_ctrl_read_link_status(struct msm_dp_ctrl_private *ctrl,
>  }
>  
>  static int msm_dp_ctrl_link_train_1(struct msm_dp_ctrl_private *ctrl,
> -			int *training_step)
> +			int *training_step, enum drm_dp_phy dp_phy)
>  {
> +	int delay_us;
>  	int tries, old_v_level, ret = 0;
>  	u8 link_status[DP_LINK_STATUS_SIZE];
>  	int const maximum_retries = 4;
>  
> +	delay_us = drm_dp_read_clock_recovery_delay(ctrl->aux,
> +		ctrl->panel->dpcd, dp_phy, false);
> +
>  	msm_dp_catalog_ctrl_state_ctrl(ctrl->catalog, 0);
>  
>  	*training_step = DP_TRAINING_1;
> @@ -1129,18 +1143,19 @@ static int msm_dp_ctrl_link_train_1(struct msm_dp_ctrl_private *ctrl,
>  	if (ret)
>  		return ret;
>  	msm_dp_ctrl_train_pattern_set(ctrl, DP_TRAINING_PATTERN_1 |
> -		DP_LINK_SCRAMBLING_DISABLE);
> +		DP_LINK_SCRAMBLING_DISABLE, dp_phy);
>  
> -	ret = msm_dp_ctrl_update_vx_px(ctrl);
> +	msm_dp_link_reset_phy_params_vx_px(ctrl->link);
> +	ret = msm_dp_ctrl_update_phy_vx_px(ctrl, dp_phy);
>  	if (ret)
>  		return ret;
>  
>  	tries = 0;
>  	old_v_level = ctrl->link->phy_params.v_level;
>  	for (tries = 0; tries < maximum_retries; tries++) {
> -		drm_dp_link_train_clock_recovery_delay(ctrl->aux, ctrl->panel->dpcd);
> +		fsleep(delay_us);
>  
> -		ret = msm_dp_ctrl_read_link_status(ctrl, link_status);
> +		ret = drm_dp_dpcd_read_phy_link_status(ctrl->aux, dp_phy, link_status);
>  		if (ret)
>  			return ret;
>  
> @@ -1161,7 +1176,7 @@ static int msm_dp_ctrl_link_train_1(struct msm_dp_ctrl_private *ctrl,
>  		}
>  
>  		msm_dp_link_adjust_levels(ctrl->link, link_status);
> -		ret = msm_dp_ctrl_update_vx_px(ctrl);
> +		ret = msm_dp_ctrl_update_phy_vx_px(ctrl, dp_phy);
>  		if (ret)
>  			return ret;
>  	}
> @@ -1213,21 +1228,31 @@ static int msm_dp_ctrl_link_lane_down_shift(struct msm_dp_ctrl_private *ctrl)
>  	return 0;
>  }
>  
> -static void msm_dp_ctrl_clear_training_pattern(struct msm_dp_ctrl_private *ctrl)
> +static void msm_dp_ctrl_clear_training_pattern(struct msm_dp_ctrl_private *ctrl,
> +					       enum drm_dp_phy dp_phy)
>  {
> -	msm_dp_ctrl_train_pattern_set(ctrl, DP_TRAINING_PATTERN_DISABLE);
> -	drm_dp_link_train_channel_eq_delay(ctrl->aux, ctrl->panel->dpcd);
> +	int delay_us;
> +
> +	msm_dp_ctrl_train_pattern_set(ctrl, DP_TRAINING_PATTERN_DISABLE, dp_phy);
> +
> +	delay_us = drm_dp_read_channel_eq_delay(ctrl->aux,
> +		ctrl->panel->dpcd, dp_phy, false);
> +	fsleep(delay_us);
>  }
>  
>  static int msm_dp_ctrl_link_train_2(struct msm_dp_ctrl_private *ctrl,
> -			int *training_step)
> +			int *training_step, enum drm_dp_phy dp_phy)
>  {
> +	int delay_us;
>  	int tries = 0, ret = 0;
>  	u8 pattern;
>  	u32 state_ctrl_bit;
>  	int const maximum_retries = 5;
>  	u8 link_status[DP_LINK_STATUS_SIZE];
>  
> +	delay_us = drm_dp_read_channel_eq_delay(ctrl->aux,
> +		ctrl->panel->dpcd, dp_phy, false);
> +
>  	msm_dp_catalog_ctrl_state_ctrl(ctrl->catalog, 0);
>  
>  	*training_step = DP_TRAINING_2;
> @@ -1247,12 +1272,12 @@ static int msm_dp_ctrl_link_train_2(struct msm_dp_ctrl_private *ctrl,
>  	if (ret)
>  		return ret;
>  
> -	msm_dp_ctrl_train_pattern_set(ctrl, pattern);
> +	msm_dp_ctrl_train_pattern_set(ctrl, pattern, dp_phy);
>  
>  	for (tries = 0; tries <= maximum_retries; tries++) {
> -		drm_dp_link_train_channel_eq_delay(ctrl->aux, ctrl->panel->dpcd);
> +		fsleep(delay_us);
>  
> -		ret = msm_dp_ctrl_read_link_status(ctrl, link_status);
> +		ret = drm_dp_dpcd_read_phy_link_status(ctrl->aux, dp_phy, link_status);
>  		if (ret)
>  			return ret;
>  
> @@ -1262,7 +1287,7 @@ static int msm_dp_ctrl_link_train_2(struct msm_dp_ctrl_private *ctrl,
>  		}
>  
>  		msm_dp_link_adjust_levels(ctrl->link, link_status);
> -		ret = msm_dp_ctrl_update_vx_px(ctrl);
> +		ret = msm_dp_ctrl_update_phy_vx_px(ctrl, dp_phy);
>  		if (ret)
>  			return ret;
>  
> @@ -1271,10 +1296,32 @@ static int msm_dp_ctrl_link_train_2(struct msm_dp_ctrl_private *ctrl,
>  	return -ETIMEDOUT;
>  }
>  
> +static int msm_dp_ctrl_link_train_1_2(struct msm_dp_ctrl_private *ctrl,
> +				      int *training_step, enum drm_dp_phy dp_phy)
> +{
> +	int ret;
> +
> +	ret = msm_dp_ctrl_link_train_1(ctrl, training_step, dp_phy);
> +	if (ret) {
> +		DRM_ERROR("link training #1 on phy %d failed. ret=%d\n", dp_phy, ret);
> +		return ret;
> +	}
> +	drm_dbg_dp(ctrl->drm_dev, "link training #1 on phy %d successful\n", dp_phy);
> +
> +	ret = msm_dp_ctrl_link_train_2(ctrl, training_step, dp_phy);
> +	if (ret) {
> +		DRM_ERROR("link training #2 on phy %d failed. ret=%d\n", dp_phy, ret);
> +		return ret;
> +	}
> +	drm_dbg_dp(ctrl->drm_dev, "link training #2 on phy %d successful\n", dp_phy);
> +
> +	return 0;
> +}
> +
>  static int msm_dp_ctrl_link_train(struct msm_dp_ctrl_private *ctrl,
>  			int *training_step)
>  {
> -	int ret = 0;
> +	int ret = 0, i;
>  	const u8 *dpcd = ctrl->panel->dpcd;
>  	u8 encoding[] = { 0, DP_SET_ANSI_8B10B };
>  	u8 assr;
> @@ -1286,8 +1333,6 @@ static int msm_dp_ctrl_link_train(struct msm_dp_ctrl_private *ctrl,
>  	link_info.rate = ctrl->link->link_params.rate;
>  	link_info.capabilities = DP_LINK_CAP_ENHANCED_FRAMING;
>  
> -	msm_dp_link_reset_phy_params_vx_px(ctrl->link);
> -
>  	msm_dp_aux_link_configure(ctrl->aux, &link_info);
>  
>  	if (drm_dp_max_downspread(dpcd))
> @@ -1302,23 +1347,29 @@ static int msm_dp_ctrl_link_train(struct msm_dp_ctrl_private *ctrl,
>  				&assr, 1);
>  	}
>  
> -	ret = msm_dp_ctrl_link_train_1(ctrl, training_step);
> +	for (i = *ctrl->lttpr_count - 1; i >= 0; i--) {
> +		enum drm_dp_phy dp_phy = DP_PHY_LTTPR(i);
> +
> +		ret = msm_dp_ctrl_link_train_1_2(ctrl, training_step, dp_phy);
> +		msm_dp_ctrl_clear_training_pattern(ctrl, dp_phy);
> +
> +		if (ret)
> +			break;
> +	}
> +
>  	if (ret) {
> -		DRM_ERROR("link training #1 failed. ret=%d\n", ret);
> +		DRM_ERROR("link training of LTTPR(s) failed. ret=%d\n", ret);
>  		goto end;
>  	}
>  
> -	/* print success info as this is a result of user initiated action */
> -	drm_dbg_dp(ctrl->drm_dev, "link training #1 successful\n");
> -
> -	ret = msm_dp_ctrl_link_train_2(ctrl, training_step);
> +	ret = msm_dp_ctrl_link_train_1_2(ctrl, training_step, DP_PHY_DPRX);
>  	if (ret) {
> -		DRM_ERROR("link training #2 failed. ret=%d\n", ret);
> +		DRM_ERROR("link training on sink failed. ret=%d\n", ret);
>  		goto end;
>  	}
>  
>  	/* print success info as this is a result of user initiated action */
> -	drm_dbg_dp(ctrl->drm_dev, "link training #2 successful\n");
> +	drm_dbg_dp(ctrl->drm_dev, "link training on sink successful\n");
>  
>  end:
>  	msm_dp_catalog_ctrl_state_ctrl(ctrl->catalog, 0);
> @@ -1636,7 +1687,7 @@ static int msm_dp_ctrl_link_maintenance(struct msm_dp_ctrl_private *ctrl)
>  	if (ret)
>  		goto end;
>  
> -	msm_dp_ctrl_clear_training_pattern(ctrl);
> +	msm_dp_ctrl_clear_training_pattern(ctrl, DP_PHY_DPRX);
>  
>  	msm_dp_catalog_ctrl_state_ctrl(ctrl->catalog, DP_STATE_CTRL_SEND_VIDEO);
>  
> @@ -1660,7 +1711,7 @@ static bool msm_dp_ctrl_send_phy_test_pattern(struct msm_dp_ctrl_private *ctrl)
>  		return false;
>  	}
>  	msm_dp_catalog_ctrl_send_phy_pattern(ctrl->catalog, pattern_requested);
> -	msm_dp_ctrl_update_vx_px(ctrl);
> +	msm_dp_ctrl_update_phy_vx_px(ctrl, DP_PHY_DPRX);
>  	msm_dp_link_send_test_response(ctrl->link);
>  
>  	pattern_sent = msm_dp_catalog_ctrl_read_phy_pattern(ctrl->catalog);
> @@ -1902,7 +1953,7 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl)
>  			}
>  
>  			/* stop link training before start re training  */
> -			msm_dp_ctrl_clear_training_pattern(ctrl);
> +			msm_dp_ctrl_clear_training_pattern(ctrl, DP_PHY_DPRX);
>  		}
>  
>  		rc = msm_dp_ctrl_reinitialize_mainlink(ctrl);
> @@ -1926,7 +1977,7 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl)
>  		 * link training failed
>  		 * end txing train pattern here
>  		 */
> -		msm_dp_ctrl_clear_training_pattern(ctrl);
> +		msm_dp_ctrl_clear_training_pattern(ctrl, DP_PHY_DPRX);
>  
>  		msm_dp_ctrl_deinitialize_mainlink(ctrl);
>  		rc = -ECONNRESET;
> @@ -1997,7 +2048,7 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train
>  		msm_dp_ctrl_link_retrain(ctrl);
>  
>  	/* stop txing train pattern to end link training */
> -	msm_dp_ctrl_clear_training_pattern(ctrl);
> +	msm_dp_ctrl_clear_training_pattern(ctrl, DP_PHY_DPRX);
>  
>  	/*
>  	 * Set up transfer unit values and set controller state to send
> @@ -2207,7 +2258,7 @@ static int msm_dp_ctrl_clk_init(struct msm_dp_ctrl *msm_dp_ctrl)
>  
>  struct msm_dp_ctrl *msm_dp_ctrl_get(struct device *dev, struct msm_dp_link *link,
>  			struct msm_dp_panel *panel,	struct drm_dp_aux *aux,
> -			struct msm_dp_catalog *catalog,
> +			struct msm_dp_catalog *catalog, int *lttpr_count,
>  			struct phy *phy)
>  {
>  	struct msm_dp_ctrl_private *ctrl;
> @@ -2242,12 +2293,13 @@ struct msm_dp_ctrl *msm_dp_ctrl_get(struct device *dev, struct msm_dp_link *link
>  	init_completion(&ctrl->video_comp);
>  
>  	/* in parameters */
> -	ctrl->panel    = panel;
> -	ctrl->aux      = aux;
> -	ctrl->link     = link;
> -	ctrl->catalog  = catalog;
> -	ctrl->dev      = dev;
> -	ctrl->phy      = phy;
> +	ctrl->panel       = panel;
> +	ctrl->aux         = aux;
> +	ctrl->link        = link;
> +	ctrl->catalog     = catalog;
> +	ctrl->dev         = dev;
> +	ctrl->phy         = phy;
> +	ctrl->lttpr_count = lttpr_count;
>  
>  	ret = msm_dp_ctrl_clk_init(&ctrl->msm_dp_ctrl);
>  	if (ret) {
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
> index b7abfedbf574..3fb45b138b31 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
> @@ -27,7 +27,7 @@ irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl);
>  void msm_dp_ctrl_handle_sink_request(struct msm_dp_ctrl *msm_dp_ctrl);
>  struct msm_dp_ctrl *msm_dp_ctrl_get(struct device *dev, struct msm_dp_link *link,
>  			struct msm_dp_panel *panel,	struct drm_dp_aux *aux,
> -			struct msm_dp_catalog *catalog,
> +			struct msm_dp_catalog *catalog, int *lttpr_count,
>  			struct phy *phy);
>  
>  void msm_dp_ctrl_reset_irq_ctrl(struct msm_dp_ctrl *msm_dp_ctrl, bool enable);
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 2edbc6adfde5..5fcc5951797b 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -108,6 +108,7 @@ struct msm_dp_display_private {
>  	struct msm_dp_event event_list[DP_EVENT_Q_MAX];
>  	spinlock_t event_lock;
>  
> +	int lttpr_count;
>  	u8 lttpr_common_caps[DP_LTTPR_COMMON_CAP_SIZE];
>  
>  	bool wide_bus_supported;
> @@ -397,7 +398,7 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
>  	if (rc)
>  		goto end;
>  
> -	msm_dp_display_lttpr_init(dp, dpcd);
> +	dp->lttpr_count = msm_dp_display_lttpr_init(dp, dpcd);
>  
>  	rc = msm_dp_panel_read_sink_caps(dp->panel, dp->lttpr_common_caps, connector);
>  	if (rc)
> @@ -798,6 +799,7 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
>  
>  	dp->ctrl = msm_dp_ctrl_get(dev, dp->link, dp->panel, dp->aux,
>  			       dp->catalog,
> +			       &dp->lttpr_count,
>  			       phy);
>  	if (IS_ERR(dp->ctrl)) {
>  		rc = PTR_ERR(dp->ctrl);
> -- 
> 2.45.2
> 

