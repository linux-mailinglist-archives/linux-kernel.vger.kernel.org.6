Return-Path: <linux-kernel+bounces-436349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8F29E84C3
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 12:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ECB81884A1F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 11:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA07114600D;
	Sun,  8 Dec 2024 11:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SklojseZ"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE94313C9C7
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 11:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733658372; cv=none; b=jDfI0z4dRRYfbqGbFhXW8StP34pQli4kdtQXGyI8qAK8/0pIxJ57LyNK+Kh4CYGPz9jjJyQiMxHe714yCqmWZmtdGA7yE6z2cYuGmybI0+7nuDTABu8FIlTnB2S8Bfw2Qg0i1C7Crhj6T3viR0lPcvjbVCw5pqTVGojViJI+Rwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733658372; c=relaxed/simple;
	bh=gCJ9K0vVEM1bdOv/MxVVUMq7iV6w4INzuUJuJ1og6SU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMFeAKTroxewjMifyVhSzwHIHIibfXPr1Pd4gI0PUxjTGUYV3owHegp9NHmIUd3NIJCdpwEKDk5a0Ip0OXTKUe9GpQNVHbfP3ZlWelDahtzt9Te9OIsDj5cXSF17Vls8JIJCWEnCONkuT7O5okOfvbYc+/gaYNFztoRkQqSHi/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SklojseZ; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5401c52000fso254135e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 03:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733658369; x=1734263169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IfA+EW7HYbS2f5B0n2A9Kj+SC/+mY9Ybrf2J4xK35QU=;
        b=SklojseZfNgHiaaE5jnOrk2qYngvl8oVtCzIvY83qH/SgKvAwMtumKFm1QTtHB2huL
         oegSYIhfG8jnF87CD+vRRQmTwiAj4cr0T0n0EqUuDe9tB4zQyd2u6caH1U72slTGDhxr
         0KvmTVtW+i26jB7vPO9MzvoFOP6vVtGYktoOntOlCiG6wwvnfGJVRihh3TGpPeFJJtNg
         mJp263DmhWaIbz0E7Jl1KmEtmPXBWqGFh1Zhq19BspeovlbGeatLqI8u3TiQYBz9bYNl
         CBZOtVslNu/bqk1wUeSj66LFdopptokysIB0nfcK7UBsXapog0X7XKxIuxuxrOd1/QvL
         MoFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733658369; x=1734263169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfA+EW7HYbS2f5B0n2A9Kj+SC/+mY9Ybrf2J4xK35QU=;
        b=AsRl/pPgYRFy/g9/NIVTkcebpk2vUbId8HklvKr3pizgWy+6U2fYUOSr6yu+ZEVU+/
         yyEdhHpGNbsohHNr4gzLjCsV9dQV8sLmYFXMVy/w8fAxkiJKdfLuo2RSgY/1RtgttCSv
         bQ7IDvH8wn3sbw2fgfmuv++GLsSGan43K8Lytt22qf3DtBlMC8tq4bsJMiZH/idU8Lka
         dETtvqosD6zWTqPNlCvz2249UZ4jLYunjMJEKTSPmProIVeR/GW/KLb6ShXRZcYH5A3n
         oXiwLAwx7jo24H3FJAcV2AcemWvRyu4V4v4CDj6ZTZx8k2ivL2q/xhodEEZfQoCx7wC0
         qkXA==
X-Forwarded-Encrypted: i=1; AJvYcCU01Ta1tzIS2dFNijL3yAOj95ttYEsuM4Rttt03qtt4uyHCJvsRbfvhh2EYRnQCFhIo92YCiaTwPW/1zYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcy0PjsjLt8C/Zj8XylKPQM18LzgR5+vZ35lN1RdaDWm0EhVF5
	TPrwY6TjBR4c6nbUFMLWbZJGrIS+IWybovpsC32sy6+YIx45QGqKoE6a9RHbZdc=
X-Gm-Gg: ASbGncte/rDSfblXHJnJW9+BahRBbmHNlG2Bk5KwiVxz2p0M5PMkUggha1B289s3Rx7
	Zdn+Wo4HmXZLaaQC/B/KEoagN45HLFWpoUKQLVo8yLwlOHULOZMT6w/W+Ud9GA+oLfCXSQVAo0C
	gJBFCt8v3jrwHd6E7FRft+/U/clkL4f+AJRrDpjHX463F3mFumF/v6zBEHBqnlbQRYtNnlUMrCl
	5TZND4QwsRUDFtthPAWw5uZU/QVZSycrI793jA27pgQQEc6BcIr5ptlwg5N2r1X+19TSKXrrHkR
	CFJT6q8dkHusrW1zJx4iX7FWz526Og==
X-Google-Smtp-Source: AGHT+IEx47LPXGtMN2Qdi7Jr7coC2oOjlkSQj8nWEB8aPxjot+Y8yYG2w+3Vfwe9hD23gXbIU0gAVQ==
X-Received: by 2002:a05:6512:1256:b0:53e:94f8:bb30 with SMTP id 2adb3069b0e04-53e94f8bbedmr1548267e87.24.1733658368723;
        Sun, 08 Dec 2024 03:46:08 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e3a9ca138sm491814e87.132.2024.12.08.03.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 03:46:07 -0800 (PST)
Date: Sun, 8 Dec 2024 13:46:05 +0200
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
Subject: Re: [PATCH 24/45] drm/msm/dp: abstract out the dp_display stream
 helpers to accept a panel
Message-ID: <f2gpfrvzuib6rkrltubnlqkjknjdezalr6bqxaacsihkwxt5ij@n2zakzxkv2ao>
References: <20241205-dp_mst-v1-0-f8618d42a99a@quicinc.com>
 <20241205-dp_mst-v1-24-f8618d42a99a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205-dp_mst-v1-24-f8618d42a99a@quicinc.com>

On Thu, Dec 05, 2024 at 08:31:55PM -0800, Abhinav Kumar wrote:
> Currently the dp_display bridge helpers, in particular the
> dp_display_enable()/dp_display_disable() use the cached panel.
> To be able to re-use these helpers for MST use-case abstract the
> helpers to use the panel which is passed in to them.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 96 ++++++++++++++++++++++++++-----------
>  drivers/gpu/drm/msm/dp/dp_display.h |  8 ++++
>  2 files changed, 75 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 1dfc82211c50bb4ed239f9730b91c33c4897c78f..e169cd22db960c0c30707ddbe6a79999dc2a273d 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -868,7 +868,8 @@ static int msm_dp_display_prepare(struct msm_dp_display_private *dp)
>  	return rc;
>  }
>  
> -static int msm_dp_display_enable(struct msm_dp_display_private *dp)
> +static int msm_dp_display_enable(struct msm_dp_display_private *dp,
> +				 struct msm_dp_panel *msm_dp_panel)
>  {
>  	int rc = 0;
>  	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
> @@ -879,7 +880,7 @@ static int msm_dp_display_enable(struct msm_dp_display_private *dp)
>  		return 0;
>  	}
>  
> -	rc = msm_dp_ctrl_on_stream(dp->ctrl, dp->panel, dp->max_stream);
> +	rc = msm_dp_ctrl_on_stream(dp->ctrl, msm_dp_panel, dp->max_stream);
>  	if (!rc)
>  		msm_dp_display->power_on = true;
>  
> @@ -925,20 +926,21 @@ static void msm_dp_display_audio_notify_disable(struct msm_dp_display_private *d
>  	msm_dp_display->audio_enabled = false;
>  }
>  
> -static int msm_dp_display_disable(struct msm_dp_display_private *dp)
> +static int msm_dp_display_disable(struct msm_dp_display_private *dp,
> +				  struct msm_dp_panel *msm_dp_panel)
>  {
>  	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
>  
>  	if (!msm_dp_display->power_on)
>  		return 0;
>  
> -	msm_dp_ctrl_clear_vsc_sdp_pkt(dp->ctrl, dp->panel);
> +	msm_dp_ctrl_clear_vsc_sdp_pkt(dp->ctrl, msm_dp_panel);
>  
>  	/* dongle is still connected but sinks are disconnected */
>  	if (dp->link->sink_count == 0)
>  		msm_dp_ctrl_psm_config(dp->ctrl);
>  
> -	msm_dp_ctrl_stream_clk_off(dp->ctrl, dp->panel);
> +	msm_dp_ctrl_stream_clk_off(dp->ctrl, msm_dp_panel);
>  
>  	msm_dp_ctrl_off_link(dp->ctrl);
>  
> @@ -1607,7 +1609,7 @@ void msm_dp_display_atomic_prepare(struct msm_dp *dp)
>  	mutex_unlock(&msm_dp_display->event_mutex);
>  }
>  
> -void msm_dp_display_atomic_enable(struct msm_dp *dp)
> +void msm_dp_display_enable_helper(struct msm_dp *dp, struct msm_dp_panel *msm_dp_panel)
>  {
>  	int rc = 0;
>  
> @@ -1620,16 +1622,14 @@ void msm_dp_display_atomic_enable(struct msm_dp *dp)
>  
>  	mutex_lock(&msm_dp_display->event_mutex);
>  
> -	msm_dp_display_set_stream_info(dp, msm_dp_display->panel, 0, 0, 0, 0, 0);
> -

Why? You have added it few patches ago.

>  	if (dp->prepared) {
> -		rc = msm_dp_display_enable(msm_dp_display);
> +		rc = msm_dp_display_enable(msm_dp_display, msm_dp_panel);
>  		if (rc)
>  			DRM_ERROR("DP display enable failed, rc=%d\n", rc);
>  		rc = msm_dp_display_post_enable(dp);
>  		if (rc) {
>  			DRM_ERROR("DP display post enable failed, rc=%d\n", rc);
> -			msm_dp_display_disable(msm_dp_display);
> +			msm_dp_display_disable(msm_dp_display, msm_dp_panel);
>  		}
>  	}
>  
> @@ -1640,14 +1640,25 @@ void msm_dp_display_atomic_enable(struct msm_dp *dp)
>  	mutex_unlock(&msm_dp_display->event_mutex);
>  }
>  
> -void msm_dp_display_atomic_disable(struct msm_dp *dp)
> +void msm_dp_display_atomic_enable(struct msm_dp *msm_dp)
> +{
> +	struct msm_dp_display_private *msm_dp_display;
> +
> +	msm_dp_display = container_of(msm_dp, struct msm_dp_display_private, msm_dp_display);
> +
> +	msm_dp_display_set_stream_info(msm_dp, msm_dp_display->panel, 0, 0, 0, 0, 0);
> +
> +	msm_dp_display_enable_helper(msm_dp, msm_dp_display->panel);
> +}
> +
> +void msm_dp_display_disable_helper(struct msm_dp *dp, struct msm_dp_panel *msm_dp_panel)
>  {
>  	struct msm_dp_display_private *msm_dp_display;
>  
>  	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
>  
>  	if (msm_dp_display->max_stream > DEFAULT_STREAM_COUNT)
> -		msm_dp_ctrl_push_vcpf(msm_dp_display->ctrl, msm_dp_display->panel);
> +		msm_dp_ctrl_push_vcpf(msm_dp_display->ctrl, msm_dp_panel);
>  	else
>  		msm_dp_ctrl_push_idle(msm_dp_display->ctrl);
>  
> @@ -1658,21 +1669,30 @@ void msm_dp_display_atomic_disable(struct msm_dp *dp)
>  	}
>  }
>  
> -static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
> +void msm_dp_display_atomic_disable(struct msm_dp *msm_dp)
>  {
> -	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
> +	struct msm_dp_display_private *msm_dp_display;
>  
> -	if (!msm_dp_display->prepared) {
> -		drm_dbg_dp(dp->drm_dev, "Link already setup, return\n");
> +	msm_dp_display = container_of(msm_dp, struct msm_dp_display_private, msm_dp_display);
> +
> +	msm_dp_display_disable_helper(msm_dp, msm_dp_display->panel);
> +}
> +
> +static void msm_dp_display_unprepare(struct msm_dp_display_private *msm_dp_display_priv)
> +{
> +	struct msm_dp *msm_dp = &msm_dp_display_priv->msm_dp_display;
> +
> +	if (!msm_dp->prepared) {
> +		drm_dbg_dp(msm_dp->drm_dev, "Link already setup, return\n");
>  		return;
>  	}
>  
> -	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
> +	pm_runtime_put_sync(&msm_dp->pdev->dev);
>  
> -	msm_dp_display->prepared = false;
> +	msm_dp->prepared = false;
>  }
>  
> -void msm_dp_display_atomic_post_disable(struct msm_dp *dp)
> +void msm_dp_display_atomic_post_disable_helper(struct msm_dp *dp, struct msm_dp_panel *msm_dp_panel)
>  {
>  	u32 state;
>  	struct msm_dp_display_private *msm_dp_display;
> @@ -1691,7 +1711,7 @@ void msm_dp_display_atomic_post_disable(struct msm_dp *dp)
>  
>  	msm_dp_display_audio_notify_disable(msm_dp_display);
>  
> -	msm_dp_display_disable(msm_dp_display);
> +	msm_dp_display_disable(msm_dp_display, msm_dp_panel);
>  
>  	state =  msm_dp_display->hpd_state;
>  	if (state == ST_DISCONNECT_PENDING) {
> @@ -1699,25 +1719,32 @@ void msm_dp_display_atomic_post_disable(struct msm_dp *dp)
>  		msm_dp_display->hpd_state = ST_DISCONNECTED;
>  	}
>  
> -	msm_dp_display_unprepare(msm_dp_display);
> -

Please split refactoring to a separate patch.

>  	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", dp->connector_type);
>  
>  	mutex_unlock(&msm_dp_display->event_mutex);
>  }
>  
> -void msm_dp_display_mode_set(struct msm_dp *dp,
> -			     const struct drm_display_mode *mode,
> -			     const struct drm_display_mode *adjusted_mode)
> +void msm_dp_display_atomic_post_disable(struct msm_dp *msm_dp)
>  {
>  	struct msm_dp_display_private *msm_dp_display;
> -	struct msm_dp_panel *msm_dp_panel;
>  
> -	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
> -	msm_dp_panel = msm_dp_display->panel;
> +	msm_dp_display = container_of(msm_dp, struct msm_dp_display_private, msm_dp_display);
> +
> +	msm_dp_display_atomic_post_disable_helper(msm_dp, msm_dp_display->panel);
> +
> +	msm_dp_display_unprepare(msm_dp_display);
> +}
> +
> +void msm_dp_display_mode_set_helper(struct msm_dp *msm_dp,
> +				    const struct drm_display_mode *mode,
> +				    const struct drm_display_mode *adjusted_mode,
> +				    struct msm_dp_panel *msm_dp_panel)
> +{
> +	struct msm_dp_display_private *msm_dp_display;
>  
> +	msm_dp_display = container_of(msm_dp, struct msm_dp_display_private, msm_dp_display);
>  
> -	msm_dp_display_set_mode(dp, adjusted_mode, msm_dp_panel);
> +	msm_dp_display_set_mode(msm_dp, adjusted_mode, msm_dp_panel);
>  
>  	/* populate wide_bus_support to different layers */
>  	msm_dp_display->ctrl->wide_bus_en =
> @@ -1726,6 +1753,17 @@ void msm_dp_display_mode_set(struct msm_dp *dp,
>  		msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420 ? false : msm_dp_display->wide_bus_supported;
>  }
>  
> +void msm_dp_display_mode_set(struct msm_dp *msm_dp,
> +			     const struct drm_display_mode *mode,
> +			     const struct drm_display_mode *adjusted_mode)
> +{
> +	struct msm_dp_display_private *msm_dp_display;
> +
> +	msm_dp_display = container_of(msm_dp, struct msm_dp_display_private, msm_dp_display);
> +
> +	msm_dp_display_mode_set_helper(msm_dp, mode, adjusted_mode, msm_dp_display->panel);
> +}
> +
>  void msm_dp_bridge_hpd_enable(struct drm_bridge *bridge)
>  {
>  	struct msm_dp_bridge *msm_dp_bridge = to_dp_bridge(bridge);
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
> index 258c240de580b634c05cf5895a8e52160449eba1..2b23f2bf7535d3fd513d40a8411a1903fcd560b0 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.h
> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
> @@ -56,5 +56,13 @@ enum drm_mode_status msm_dp_display_mode_valid(struct msm_dp *dp,
>  int msm_dp_display_set_stream_info(struct msm_dp *dp,
>  				   struct msm_dp_panel *panel, u32 strm_id,
>  				   u32 start_slot, u32 num_slots, u32 pbn, int vcpi);
> +void msm_dp_display_enable_helper(struct msm_dp *msm_dp, struct msm_dp_panel *msm_dp_panel);
> +void msm_dp_display_disable_helper(struct msm_dp *msm_dp, struct msm_dp_panel *msm_dp_panel);
> +void msm_dp_display_mode_set_helper(struct msm_dp *msm_dp,
> +				    const struct drm_display_mode *mode,
> +				    const struct drm_display_mode *adjusted_mode,
> +				    struct msm_dp_panel *msm_dp_panel);
> +void msm_dp_display_atomic_post_disable_helper(struct msm_dp *msm_dp,
> +					       struct msm_dp_panel *msm_dp_panel);
>  
>  #endif /* _DP_DISPLAY_H_ */
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

