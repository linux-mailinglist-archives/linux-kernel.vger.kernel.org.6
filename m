Return-Path: <linux-kernel+bounces-555565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBE5A5B9AB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 08:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D7F1893FDF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 07:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DED221D87;
	Tue, 11 Mar 2025 07:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jf88mcdk"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C3221ADA0
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 07:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741677739; cv=none; b=g34bhE4eaIxb8J+yRhC0eUDeqSS8Zz95JFixXY7HgeH70WrF18ehF+9wgST9EUbwPI7XoNv1mXBnv3ut2jvKJIhSJNI2oQFpCVbuqZaPyQq+Ra1UzgH4uRo/n2pr4+AmeZSU4jBje6uEPjqDORJwZPDQYcCVJttwJcGAhgRLtUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741677739; c=relaxed/simple;
	bh=A/zgvG4tcMyh5JCbd0v4U7uD9NDLhEQx/G76Rqzs7fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDe0G7fEna/QTGakoS4EVXr4gTcOKKuj2OXvSiQcCishXI3fprIxWXw3YhtzLG6nMFNJqfaTtU86fTaCYWbFH+G+2Z45xxl4mcr1mEreMYPY4zIcvBjMm8EG/u0t27+b7p4YdFALx09fS3f8vPQpJWWhkhHFEnCsSZqfklCEFVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jf88mcdk; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-391342fc0b5so4316230f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 00:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741677734; x=1742282534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=76PI8U0C3grhZ+WuGPDq/YmQnaoHPH4xWIdsOpqhIzo=;
        b=jf88mcdkrXgaaDzlbYLnaBb4T4n2aVKnjvG1A9Uss/uCz+bqcS7+9dauNc11+qQHaW
         2XUzGy1a6KUhZY8lK6M8nNL3T+9ZgZpobvT1HdWGbcMUoYphvFGstjh+i/a/oNRCnhIR
         dVZ0CTH5ksdYY/CdxXGkYleJV8bkH+ycndSDLCSgD+sXXoeckzs9+Zii2ma/0lXYU6QQ
         Ow0SC3uCDIEaAbDXjekoQtkpxikiknhUppUGsUGz7gG3aNT0pi/X8kmBjmge3fYEBWW8
         lGIDnU1ahYP1f0sTi0DGLLNamJE6vFIQCVl2MCc3gkq47tydI/PjILTbJFvpgeohccUW
         XpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741677734; x=1742282534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76PI8U0C3grhZ+WuGPDq/YmQnaoHPH4xWIdsOpqhIzo=;
        b=CoR6VpanisUKaPl4Fzh4JYlystm5ibKjW7zIMdLyLIT6yXfr61JQVjM0rFROOJ1tdB
         Uad4utxJnbIwCu7uVdo69l9F/Pv9A4rnCOdZwNBRn8pUuMud5HpPMjqieOJnXx19Kjj3
         cTNBbFEtL/SpKM5Hf0YGTnCZw6sln/7GXyt4xAXyzgMCOz9GFhlDhIaCx1xrSEuAoTNd
         8Ot61T6U8dfZ0e6pfLU3zgnvIjoVL7v7hgbivNwpudbX2QLA+bmJ5XSRCOdT0YTt3FIO
         Gz5MsJyz63cG58tpJQSfW0yC8TlnRcNC2SOhMp/RoAmI3IZXw978SRaQWjB1DL+weTi8
         BJsw==
X-Forwarded-Encrypted: i=1; AJvYcCUK1penMGDGOxoTZcGxDuNABOHmXdl65ETgjLJ/ruoDgd3Uf/t4FNLhoTDv3dGynoLekAlcULRpTKqdxf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Ib6INL8vvsDDnYzwPFrIlgeTTAu+CB0UdWiv4U5DclEfSHO1
	/CuEXVB5ZKKAgreNW2SF94Oy4VhHkckV37NDvoSCG5bbIeXxjYRy85s5cXT2IGA=
X-Gm-Gg: ASbGncsjR599jipU4PYUTKdYbHgmiT50KoM2Guh5lmabOFEvqVirbkHZ6BacrXrNw8k
	/fjx6f++B2vEzfXyDYvVWhaVNbcaHJJK9QTUoOhUsRvQfhzdMmmeZzmE13QdHT6d1mgp6e5iwes
	NFT2nxmFUf+iHf1bRhYnpCBvp4DDFxHoTNkkwuC0lvnvA69aWKY/PvE69pnzrq54U1noJJEG/Rh
	xWBHHoLbWbN5ryYC2vChSQ8UuDKi7F3fnYcP2k0axB8udYmpa+Sf1hAOoS5oiTmCmXIua+PnEmV
	w7SHv+I6heq+q2Rb2N4moJ0MSY7SOBUaJfTN5u9FcA==
X-Google-Smtp-Source: AGHT+IHpxAncgrnL4ALrjetV1ziQLeJlcqXChyQIooItqRdevyNiOEaTJs5Dyo8WU/a2A84bNO/4SA==
X-Received: by 2002:a05:6000:1564:b0:38d:d666:5457 with SMTP id ffacd0b85a97d-39132da24cfmr13958644f8f.42.1741677734190;
        Tue, 11 Mar 2025 00:22:14 -0700 (PDT)
Received: from linaro.org ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e1d67sm17233831f8f.74.2025.03.11.00.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 00:22:13 -0700 (PDT)
Date: Tue, 11 Mar 2025 09:22:11 +0200
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
Subject: Re: [PATCH v1 1/2] drm/msm/dp: Fix support of LTTPR handling
Message-ID: <Z8/ko76QAGPE46R/@linaro.org>
References: <20250310211039.29843-1-alex.vinarskis@gmail.com>
 <20250310211039.29843-2-alex.vinarskis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310211039.29843-2-alex.vinarskis@gmail.com>

On 25-03-10 22:05:51, Aleksandrs Vinarskis wrote:
> Take into account LTTPR capabilities when selecting maximum allowed
> link rate, number of data lines. Initialize LTTPR before
> msm_dp_panel_read_sink_caps, as
> a) Link params computation need to take into account LTTPR's caps
> b) It appears DPTX shall (re)read DPRX caps after LTTPR detection
> 
> Return lttpr_count to prepare for per-segment link training.
> 
> Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 31 +++++++++++++++++++----------
>  drivers/gpu/drm/msm/dp/dp_panel.c   | 30 +++++++++++++++++++---------
>  drivers/gpu/drm/msm/dp/dp_panel.h   |  2 ++
>  3 files changed, 44 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index bbc47d86ae9e..2edbc6adfde5 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -108,6 +108,8 @@ struct msm_dp_display_private {
>  	struct msm_dp_event event_list[DP_EVENT_Q_MAX];
>  	spinlock_t event_lock;
>  
> +	u8 lttpr_common_caps[DP_LTTPR_COMMON_CAP_SIZE];
> +
>  	bool wide_bus_supported;
>  
>  	struct msm_dp_audio *audio;
> @@ -367,17 +369,21 @@ static int msm_dp_display_send_hpd_notification(struct msm_dp_display_private *d
>  	return 0;
>  }
>  
> -static void msm_dp_display_lttpr_init(struct msm_dp_display_private *dp)
> +static int msm_dp_display_lttpr_init(struct msm_dp_display_private *dp, u8 *dpcd)
>  {
> -	u8 lttpr_caps[DP_LTTPR_COMMON_CAP_SIZE];
> -	int rc;
> +	int rc, lttpr_count;
>  
> -	if (drm_dp_read_lttpr_common_caps(dp->aux, dp->panel->dpcd, lttpr_caps))
> -		return;
> +	if (drm_dp_read_lttpr_common_caps(dp->aux, dpcd, dp->lttpr_common_caps))
> +		return 0;
>  
> -	rc = drm_dp_lttpr_init(dp->aux, drm_dp_lttpr_count(lttpr_caps));
> -	if (rc)
> -		DRM_ERROR("failed to set LTTPRs transparency mode, rc=%d\n", rc);
> +	lttpr_count = drm_dp_lttpr_count(dp->lttpr_common_caps);
> +	rc = drm_dp_lttpr_init(dp->aux, lttpr_count);
> +	if (rc) {
> +		DRM_ERROR("fialed to set LTTPRs transparency mode, rc=%d\n", rc);

Nitpick: failed

With that fixed, LGTM:

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> +		return 0;
> +	}
> +
> +	return lttpr_count;
>  }
>  
>  static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
> @@ -385,12 +391,17 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
>  	struct drm_connector *connector = dp->msm_dp_display.connector;
>  	const struct drm_display_info *info = &connector->display_info;
>  	int rc = 0;
> +	u8 dpcd[DP_RECEIVER_CAP_SIZE];
>  
> -	rc = msm_dp_panel_read_sink_caps(dp->panel, connector);
> +	rc = drm_dp_read_dpcd_caps(dp->aux, dpcd);
>  	if (rc)
>  		goto end;
>  
> -	msm_dp_display_lttpr_init(dp);
> +	msm_dp_display_lttpr_init(dp, dpcd);
> +
> +	rc = msm_dp_panel_read_sink_caps(dp->panel, dp->lttpr_common_caps, connector);
> +	if (rc)
> +		goto end;
>  
>  	msm_dp_link_process_request(dp->link);
>  
> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
> index 92415bf8aa16..f41b4cf7002e 100644
> --- a/drivers/gpu/drm/msm/dp/dp_panel.c
> +++ b/drivers/gpu/drm/msm/dp/dp_panel.c
> @@ -45,9 +45,12 @@ static void msm_dp_panel_read_psr_cap(struct msm_dp_panel_private *panel)
>  	}
>  }
>  
> -static int msm_dp_panel_read_dpcd(struct msm_dp_panel *msm_dp_panel)
> +static int msm_dp_panel_read_dpcd(struct msm_dp_panel *msm_dp_panel,
> +				  const u8 lttpr_common_caps[DP_LTTPR_COMMON_CAP_SIZE])
>  {
>  	int rc;
> +	int max_sink_lanes, max_source_lanes, max_lttpr_lanes;
> +	int max_sink_rate, max_source_rate, max_lttpr_rate;
>  	struct msm_dp_panel_private *panel;
>  	struct msm_dp_link_info *link_info;
>  	u8 *dpcd, major, minor;
> @@ -64,16 +67,24 @@ static int msm_dp_panel_read_dpcd(struct msm_dp_panel *msm_dp_panel)
>  	major = (link_info->revision >> 4) & 0x0f;
>  	minor = link_info->revision & 0x0f;
>  
> -	link_info->rate = drm_dp_max_link_rate(dpcd);
> -	link_info->num_lanes = drm_dp_max_lane_count(dpcd);
> +	max_source_lanes = msm_dp_panel->max_dp_lanes;
> +	max_source_rate = msm_dp_panel->max_dp_link_rate;
>  
> -	/* Limit data lanes from data-lanes of endpoint property of dtsi */
> -	if (link_info->num_lanes > msm_dp_panel->max_dp_lanes)
> -		link_info->num_lanes = msm_dp_panel->max_dp_lanes;
> +	max_sink_lanes = drm_dp_max_lane_count(dpcd);
> +	max_sink_rate = drm_dp_max_link_rate(dpcd);
> +
> +	max_lttpr_lanes = drm_dp_lttpr_max_lane_count(lttpr_common_caps);
> +	max_lttpr_rate = drm_dp_lttpr_max_link_rate(lttpr_common_caps);
>  
> +	if (max_lttpr_lanes)
> +		max_sink_lanes = min(max_sink_lanes, max_lttpr_lanes);
> +	if (max_lttpr_rate)
> +		max_sink_rate = min(max_sink_rate, max_lttpr_rate);
> +
> +	/* Limit data lanes from data-lanes of endpoint property of dtsi */
> +	link_info->num_lanes = min(max_sink_lanes, max_source_lanes);
>  	/* Limit link rate from link-frequencies of endpoint property of dtsi */
> -	if (link_info->rate > msm_dp_panel->max_dp_link_rate)
> -		link_info->rate = msm_dp_panel->max_dp_link_rate;
> +	link_info->rate = min(max_sink_rate, max_source_rate);
>  
>  	drm_dbg_dp(panel->drm_dev, "version: %d.%d\n", major, minor);
>  	drm_dbg_dp(panel->drm_dev, "link_rate=%d\n", link_info->rate);
> @@ -109,6 +120,7 @@ static u32 msm_dp_panel_get_supported_bpp(struct msm_dp_panel *msm_dp_panel,
>  }
>  
>  int msm_dp_panel_read_sink_caps(struct msm_dp_panel *msm_dp_panel,
> +	const u8 lttpr_common_caps[DP_LTTPR_COMMON_CAP_SIZE],
>  	struct drm_connector *connector)
>  {
>  	int rc, bw_code;
> @@ -125,7 +137,7 @@ int msm_dp_panel_read_sink_caps(struct msm_dp_panel *msm_dp_panel,
>  	drm_dbg_dp(panel->drm_dev, "max_lanes=%d max_link_rate=%d\n",
>  		msm_dp_panel->max_dp_lanes, msm_dp_panel->max_dp_link_rate);
>  
> -	rc = msm_dp_panel_read_dpcd(msm_dp_panel);
> +	rc = msm_dp_panel_read_dpcd(msm_dp_panel, lttpr_common_caps);
>  	if (rc) {
>  		DRM_ERROR("read dpcd failed %d\n", rc);
>  		return rc;
> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
> index 4906f4f09f24..d89e17a9add5 100644
> --- a/drivers/gpu/drm/msm/dp/dp_panel.h
> +++ b/drivers/gpu/drm/msm/dp/dp_panel.h
> @@ -7,6 +7,7 @@
>  #define _DP_PANEL_H_
>  
>  #include <drm/msm_drm.h>
> +#include <drm/display/drm_dp_helper.h>
>  
>  #include "dp_aux.h"
>  #include "dp_link.h"
> @@ -49,6 +50,7 @@ int msm_dp_panel_init_panel_info(struct msm_dp_panel *msm_dp_panel);
>  int msm_dp_panel_deinit(struct msm_dp_panel *msm_dp_panel);
>  int msm_dp_panel_timing_cfg(struct msm_dp_panel *msm_dp_panel);
>  int msm_dp_panel_read_sink_caps(struct msm_dp_panel *msm_dp_panel,
> +		const u8 lttpr_common_caps[DP_LTTPR_COMMON_CAP_SIZE],
>  		struct drm_connector *connector);
>  u32 msm_dp_panel_get_mode_bpp(struct msm_dp_panel *msm_dp_panel, u32 mode_max_bpp,
>  			u32 mode_pclk_khz);
> -- 
> 2.45.2
> 

