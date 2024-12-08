Return-Path: <linux-kernel+bounces-436279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 279339E83DE
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 07:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1D8D188470D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 06:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B0B54279;
	Sun,  8 Dec 2024 06:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HJxxKwbi"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C431EEEB2
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 06:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733639120; cv=none; b=LTo65pPpeLH0qrUTJaKZNyHWsduPoSlVFgseRY4P9ly6LurGTwtAnxs1dfevHNo7rc64OxXFksbW9zkGlVvfPboOyf1qiNmJ0ARWwVkOej66FjtKT6ed12oRxPP+r4zQQFN82gQ3+C1oeANEa2fd8Ytnv7hi7bJlNOWPaRvUsTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733639120; c=relaxed/simple;
	bh=tjPxzmEid0ktMri0N6SNinB0M1uftQA3QuvagWpSqZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gI8gHyZe0v9R0mfiBBH+gses5zaj1rm3rDZy4A9y9+2d98kMiSq7pRkpK6UJ+cpkTl7CH5/eJrOHPV4FSOHIBv9eVES1K43Z0Dml9czr7re7qCEuUrbXhmb0EHDV1Cb6YnUJVBA45+nUA2CXUBKno2r1k5hlWYpYhG+jS4Uza5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HJxxKwbi; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ffc1009a06so28506161fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 22:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733639117; x=1734243917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yv4ZZLZ8246YBWnXODcwZp0cvCag8q8Zfn9GevZqfKI=;
        b=HJxxKwbiDKalBgcNJZsd+GfpBmgwIMG06vbj/MaUa6j+vl+2bM1HKq1OSREHQW/q4e
         5Y6SksRB3o+IEJZgFiqAQ6377i5JyAeSVbxplNJD/tWzyEEGqNNvKqpwEU890xFyhDKk
         hu6lLT9FRYgp1Urf6YC2E20HZkHO7qsoMsBl720fSBFREupFLfMhOOz3yhiRA84YuKHw
         40Ac8SsmGwcrWz/dNQ1LJ+ahs9zRRkfbQs7PYSAIuvoV41GmwhvPk0NhJDpx8rtSOt/O
         jGP19GHDzTbvxJ8NagIU1qK6GW08yT2CxJBU/drqrXzZ0EJVd09l5adjQIMMtrlCf437
         BnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733639117; x=1734243917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yv4ZZLZ8246YBWnXODcwZp0cvCag8q8Zfn9GevZqfKI=;
        b=AokHhuU4iCDyj8XMDC4biM+ASnbKB0P2bV3G3CUkXxXPM0cY1MBStSy1K0w5pT9wEO
         /TiuZvWiQZs27SijatE9s6/J8NTtY+DcZDvTtJOIFoxtYpZd+Gaiv9KRy79LdZ+FObeU
         N3QNQvP74tVpSj1Af/ojdPu4SqIUGoVdkbDyS3cgknbldeCOPOVfCJuUHu1rIce/KsLr
         MwQdwpQSrZzXkwlhLp2E/i4GBaL48CVm3ElARblwKR6eYZx60uENE8gHfrEIpeo5hdQa
         PywjKu+BWM9jQP104SYAKjysgFt+TrPx6bXU2ZNXq076/7VLqvu+V8atc3Q7Atu7yCPY
         OaIg==
X-Forwarded-Encrypted: i=1; AJvYcCU2H+4QSdjXVPYPui55wZDWeDDyorJ74ZDvIh9hbNL8XlaJQXHvYyaG1gJq0m7AwSiLYENV2cRpFB6EETE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpLojPqe6n6Y/x4Ziv6X06oxL+mqzwyFHhmLDzp00mN4rDMg7r
	zmw9uNMK6FBTi0SZWWTf0TJCcImnsAKqqc975GDappYeGunZ0p+1BMevWBg09jk=
X-Gm-Gg: ASbGnct2ScrDT2L0/n2NltQqKqZvP/4jbGfoFp0LqO1eu2Tm7zMhVhZBKXHDPBDXXzF
	sw4vwD/pljV98nWc8zjxnV62gCx6pS3ipJoJAdyjLxCTaA8U1+y/2xJTN7f7czU4cZg7izX93RW
	vYWcIF9vRFrpwoDaA8bP3YohmGJ+gDHh7L7uxghbWMFFZ6eYm+IeYZa8B21uciDV8PnFw/cgnhZ
	oGtPyTv8B6jmQ3J9rFx14tm3HiLeZPHXwnUrBuIjBkbhu9JWaHHubUUNTkN77+8tclUyeJvhVok
	WRTE9c4hpKYHCf05/k5Bins/lDHy6g==
X-Google-Smtp-Source: AGHT+IGa1+MAojS5l8TzrI/MuTB4uRPj9iAMmq7CXItu4qXq8cd0Vcz5ffDdDRwGNtUlkqf4/FMk3g==
X-Received: by 2002:a05:6512:691:b0:53e:1ee1:25b3 with SMTP id 2adb3069b0e04-53e2c2bc74dmr2506384e87.27.1733639116847;
        Sat, 07 Dec 2024 22:25:16 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54019f8afdesm246135e87.165.2024.12.07.22.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 22:25:15 -0800 (PST)
Date: Sun, 8 Dec 2024 08:25:13 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Stephen Boyd <swboyd@chromium.org>, 
	Chandan Uddaraju <chandanu@codeaurora.org>, Guenter Roeck <groeck@chromium.org>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vara Reddy <quic_varar@quicinc.com>, Rob Clark <robdclark@chromium.org>, 
	Tanmay Shah <tanmay@codeaurora.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 38/45] drm/msm: initialize DRM MST encoders for DP
 controllers
Message-ID: <ce67owjhtxwa3oy6fmmkmosqzzojny2ajofjjnk3lessly7t2b@artmywxh6hzq>
References: <20241205-dp_mst-v1-0-f8618d42a99a@quicinc.com>
 <20241205-dp_mst-v1-38-f8618d42a99a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205-dp_mst-v1-38-f8618d42a99a@quicinc.com>

On Thu, Dec 05, 2024 at 08:32:09PM -0800, Abhinav Kumar wrote:
> Initiliaze a DPMST encoder for each  MST capable DP controller
> and the number of encoders it supports depends on the number
> of streams it supports. Replace the opencoded instances of max_stream
> with the newly introduced API to centralize the usage.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  2 ++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     | 23 ++++++++++++++++++++++-
>  drivers/gpu/drm/msm/dp/dp_display.c         | 26 +++++++++++++++++++++-----
>  drivers/gpu/drm/msm/msm_drv.h               | 14 ++++++++++++++

Split into two commits

>  4 files changed, 59 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> index 92b5ee390788d16e85e195a664417896a2bf1cae..618a5b6f8222882ed8c972a78a26f8c25ca389a8 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> @@ -28,6 +28,7 @@
>   * @h_tile_instance:    Controller instance used per tile. Number of elements is
>   *                      based on num_of_h_tiles
>   * @is_cmd_mode		Boolean to indicate if the CMD mode is requested
> + * @stream_id		stream id for which the interface needs to be acquired
>   * @vsync_source:	Source of the TE signal for DSI CMD devices
>   */
>  struct msm_display_info {
> @@ -35,6 +36,7 @@ struct msm_display_info {
>  	uint32_t num_of_h_tiles;
>  	uint32_t h_tile_instance[MAX_H_TILES_PER_DISPLAY];
>  	bool is_cmd_mode;
> +	int stream_id;
>  	enum dpu_vsync_source vsync_source;
>  };
>  
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index 8b251f87a0520da0807b9b7aed17493990e41627..359de04abf4bbead3daa5e8b357a3c34216e3e65 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -636,7 +636,8 @@ static int _dpu_kms_initialize_displayport(struct drm_device *dev,
>  	struct msm_display_info info;
>  	bool yuv_supported;
>  	int rc;
> -	int i;
> +	int i, stream_id;
> +	int stream_cnt;
>  
>  	for (i = 0; i < ARRAY_SIZE(priv->dp); i++) {
>  		if (!priv->dp[i])
> @@ -659,6 +660,26 @@ static int _dpu_kms_initialize_displayport(struct drm_device *dev,
>  			DPU_ERROR("modeset_init failed for DP, rc = %d\n", rc);
>  			return rc;
>  		}
> +
> +		stream_cnt = msm_dp_get_mst_max_stream(priv->dp[i]);

Is there any reason for this not being a part of the DPU catalog? DPU
can support required number of DPMST streams even if DP doesn't

> +
> +		if (stream_cnt > 1) {
> +			for (stream_id = 0; stream_id < stream_cnt; stream_id++) {
> +				info.stream_id = stream_id;
> +				encoder = dpu_encoder_init(dev, DRM_MODE_ENCODER_DPMST, &info);
> +				if (IS_ERR(encoder)) {
> +					DPU_ERROR("encoder init failed for dp mst display\n");
> +					return PTR_ERR(encoder);
> +				}
> +
> +				rc = msm_dp_mst_bridge_init(priv->dp[i], encoder);
> +				if (rc) {
> +					DPU_ERROR("dp mst bridge %d init failed, %d\n",
> +						  stream_id, rc);
> +					continue;
> +				}
> +			}
> +		}
>  	}
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 80df79a7c2077d49184cdeb7b801bf0699ff4ece..eafec9ab4f83cb44e861687e7550748b4d9b7ece 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -432,7 +432,8 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
>  	if (rc)
>  		goto end;
>  
> -	if (dp->max_stream <= DEFAULT_STREAM_COUNT || !msm_dp_panel_read_mst_cap(dp->panel)) {
> +	if (msm_dp_get_mst_max_stream(dp_display) <= DEFAULT_STREAM_COUNT ||
> +	    !msm_dp_panel_read_mst_cap(dp->panel)) {
>  		rc = msm_dp_panel_read_edid(dp->panel, connector);
>  		if (rc)
>  			goto end;
> @@ -457,7 +458,8 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
>  	 */
>  	msm_dp_link_psm_config(dp->link, &dp->panel->link_info, false);
>  
> -	if (dp->max_stream > DEFAULT_STREAM_COUNT && msm_dp_panel_read_mst_cap(dp->panel))
> +	if (msm_dp_get_mst_max_stream(dp_display) > DEFAULT_STREAM_COUNT &&
> +	    msm_dp_panel_read_mst_cap(dp->panel))
>  		msm_dp_display_mst_init(dp);
>  
>  	msm_dp_link_reset_phy_params_vx_px(dp->link);
> @@ -977,7 +979,7 @@ static int msm_dp_display_enable(struct msm_dp_display_private *dp,
>  
>  	drm_dbg_dp(dp->drm_dev, "sink_count=%d\n", dp->link->sink_count);
>  
> -	rc = msm_dp_ctrl_on_stream(dp->ctrl, msm_dp_panel, dp->max_stream);
> +	rc = msm_dp_ctrl_on_stream(dp->ctrl, msm_dp_panel, msm_dp_get_mst_max_stream(&dp->msm_dp_display));
>  
>  	return rc;
>  }
> @@ -1444,6 +1446,20 @@ static int msm_dp_display_get_connector_type(struct platform_device *pdev,
>  	return connector_type;
>  }
>  
> +int msm_dp_get_mst_max_stream(const struct msm_dp *dp_display)
> +{
> +	struct msm_dp_display_private *dp_priv;
> +
> +	dp_priv = container_of(dp_display, struct msm_dp_display_private, msm_dp_display);
> +
> +	return dp_priv->max_stream;
> +}
> +
> +int msm_dp_mst_bridge_init(struct msm_dp *dp_display, struct drm_encoder *encoder)
> +{
> +	return msm_dp_mst_drm_bridge_init(dp_display, encoder);
> +}
> +
>  static int msm_dp_display_probe(struct platform_device *pdev)
>  {
>  	int rc = 0;
> @@ -1745,12 +1761,12 @@ void msm_dp_display_disable_helper(struct msm_dp *dp, struct msm_dp_panel *msm_d
>  		return;
>  	}
>  
> -	if (msm_dp_display->max_stream > DEFAULT_STREAM_COUNT)
> +	if (msm_dp_get_mst_max_stream(dp) > DEFAULT_STREAM_COUNT)
>  		msm_dp_ctrl_push_vcpf(msm_dp_display->ctrl, msm_dp_panel);
>  	else
>  		msm_dp_ctrl_push_idle(msm_dp_display->ctrl);
>  
> -	if (msm_dp_display->max_stream > DEFAULT_STREAM_COUNT) {
> +	if (msm_dp_get_mst_max_stream(dp) > DEFAULT_STREAM_COUNT) {
>  		msm_dp_ctrl_mst_stream_channel_slot_setup(msm_dp_display->ctrl,
>  							  msm_dp_display->max_stream);
>  		msm_dp_ctrl_mst_send_act(msm_dp_display->ctrl);
> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> index 1616a4682795f6b9b30cc0bef2baf448ccc62bc0..12b50a797772f574122481cd8a1c7c88aacb8250 100644
> --- a/drivers/gpu/drm/msm/msm_drv.h
> +++ b/drivers/gpu/drm/msm/msm_drv.h
> @@ -372,6 +372,10 @@ bool msm_dp_needs_periph_flush(const struct msm_dp *dp_display,
>  			       const struct drm_display_mode *mode);
>  bool msm_dp_wide_bus_available(const struct msm_dp *dp_display);
>  
> +int msm_dp_get_mst_max_stream(const struct msm_dp *dp_display);
> +
> +int msm_dp_mst_bridge_init(struct msm_dp *dp_display, struct drm_encoder *encoder);
> +
>  #else
>  static inline int __init msm_dp_register(void)
>  {
> @@ -388,6 +392,16 @@ static inline int msm_dp_modeset_init(struct msm_dp *dp_display,
>  	return -EINVAL;
>  }
>  
> +static inline int msm_dp_get_mst_max_stream(struct msm_dp *dp_display)
> +{
> +	return -EINVAL;
> +}
> +
> +int msm_dp_mst_bridge_init(struct msm_dp *dp_display, struct drm_encoder *encoder)
> +{
> +	return -EINVAL;
> +}
> +
>  static inline void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp_display)
>  {
>  }
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

