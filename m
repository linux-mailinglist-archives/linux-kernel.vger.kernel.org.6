Return-Path: <linux-kernel+bounces-434690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 814209E69D3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C4D6188212C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867461E2007;
	Fri,  6 Dec 2024 09:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QJQOadGi"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA401CCB4B
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 09:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733476295; cv=none; b=dGm3Fqy9qiSJ3vjTeSk1DhUOBTUep5l72Aw0dHri3uNbotZ/pBKGJdlKha+zdQiZ2vIXOaR6C3b3pv6VqoU6NnrJ0/uH7At7bm8Y2Sp1CMjHFPCmVpbs9wiLqe4p9F9eRHDHjswGjGXEWvfprot6p18O0sRqZsis4g5WKT9ny0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733476295; c=relaxed/simple;
	bh=6M08CRkQabxHBoAsSW3P1gq61tbOPrB76R21u7g+EHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jeGz7RhSFK7A8KyhXQwc5fMEmJA+iV8KL6cfugTy1I7xid+PXq6t6MJKBEDhEDy+u8JmyUeaj9ldpNEDhrQNfJbBwrF0r2aw9gE7I9+F4VloX5O9F4Qk4+vWo3NQYGrM57ncY/ho77Y9t6UX/wkHw40dHJmvPDKtZrbX5AieH8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QJQOadGi; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53e23fb807dso1546330e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 01:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733476292; x=1734081092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T8gpX618iMkRwGuO0MNBjOsaC1WUlIK8H0NQRZoPtiI=;
        b=QJQOadGi/4h+Cehd4XhKLjGl/DDeBB0WANpIdgUiWbC0Nce7j+hrsq5k6rNDvNYWVM
         PDzgMBaWn9/A3EiZKrA1fjJhohc9wSIol856z479jSMZnx8ztGTPxakMi6367jqP1bA4
         4g3Gp+Z8oF8ApyjSNQaRnGVDHfqzyHcLiioP4Dmq5AiUvDV+jtyNu+ffznyjvn3TfcQb
         UvvoftmJ6EgkLigJk4VyDX8ICKdEU/iop/z2PEqr1Wr51w3c3UH/Ks90PKRJemLxrooX
         uGnlVjrU53V9Xr2OIbmK755FG1trJrm8fVzpPg0wmo1AQpcXDQc1m8CPJtwAZSBgBloa
         +arQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733476292; x=1734081092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8gpX618iMkRwGuO0MNBjOsaC1WUlIK8H0NQRZoPtiI=;
        b=FujlvJpCH7hLHPd70dyz2gq0LcyxRNzSvztQyIQwisKkO5fc/3buQ+bsK3fIiPI4kg
         ZeZCYaMFWuIOV04beBe12VmyDCnyPLjjqcXPU5hVQ3OJKnazCji5sAERzy9Zac96LcmS
         sZyvS5jOUsNezubV9JM6mkan5/oJZ67zOTp8WVIT8HqVvWcA6iim7W3ELF21q3gjMmCf
         NvOhDQRCFMIsA1nuM3VMBbHIIB6tgc+9JuaXiuWrAOCIvkFlTj2yI0jLAFDVwOF7Sh94
         cJPveHltG9FzgJx09/olrBZ/PpnZB0W6ThJUguVZKIl4dX/u6tWSk4RUw6CPd/gBZsb4
         11zw==
X-Forwarded-Encrypted: i=1; AJvYcCUX9jXkq07ezRMu9ANgw9GL3wAh5+P7sI2QFXIyn0oAZWADsW+JwCAyScFPf3a9VpqXMw37OPrN1V3FefY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws04XzYzd7TIOl21/Frr4v9wNVbIpo0vbuLObXTW7FBkn2lMCv
	Bc9CqYWi3cKeKEvt6laq5m44ClRcliHqtYKou7hCTGrUYXN89kdGNeoFZT+jMe4=
X-Gm-Gg: ASbGncuElPqELpCk2aP7CbMNV7yDwR9ONflQvsmlrO6rCGVSIPbVb0yymNtHwf5epU1
	4Qt3UhMUVNw5vphK/ebaW/5ATIiDFuXSzVNnH3jv2Cl3hB5Rvj0oH8gBERwx+Ibo0dyytOJNhkr
	ePTAaqfJ4cFlDVI+cEMi7SC65u5xATBAmHALNXR40djkoms4KAQUxOMhM7iwsQ1LOmbJWr/WsSJ
	jt87eB5CAV/0pyoaSEOmM6loFwF6sef95cpBL6XjhsGx4S99o0YyMebpTL3qYJi7zXY8GHFihG6
	eFiyy+dI4u8DCLRBdwPZdLeRYf8Nyg==
X-Google-Smtp-Source: AGHT+IGNi8p6tF7mI10HM7W5wGLN6DaQZ+XRjtGNfF7C+qKH+cNm/VA+lU/O/GtzKadPV+/qvj5+wQ==
X-Received: by 2002:a05:6512:2316:b0:53d:f712:53ce with SMTP id 2adb3069b0e04-53e2c2b18f8mr560342e87.7.1733476292070;
        Fri, 06 Dec 2024 01:11:32 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229c1ef2sm442949e87.186.2024.12.06.01.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 01:11:30 -0800 (PST)
Date: Fri, 6 Dec 2024 11:11:28 +0200
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
Subject: Re: [PATCH 10/45] drm/msm/dp: move the pixel clock control to its
 own API
Message-ID: <mqreu34au5g6yfogb2ijv7f2yx76fqoba2n3kljioagrfe2ilz@skoljluurawr>
References: <20241205-dp_mst-v1-0-f8618d42a99a@quicinc.com>
 <20241205-dp_mst-v1-10-f8618d42a99a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205-dp_mst-v1-10-f8618d42a99a@quicinc.com>

On Thu, Dec 05, 2024 at 08:31:41PM -0800, Abhinav Kumar wrote:
> Enable/Disable of DP pixel clock happens in multiple code paths
> leading to code duplication. Move it into individual helpers so that
> the helpers can be called wherever necessary.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 76 ++++++++++++++++++++++------------------
>  1 file changed, 41 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index 0bed85b5c8e8133ffa8c74d5de22668905396d09..118f5ed83e464f9f27f813eb39624f9c3189f5ac 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -1698,6 +1698,30 @@ static bool msm_dp_ctrl_send_phy_test_pattern(struct msm_dp_ctrl_private *ctrl)
>  	return success;
>  }
>  
> +static int msm_dp_ctrl_stream_clk_on(struct msm_dp_ctrl_private *ctrl, unsigned long pixel_rate)
> +{
> +	int ret;
> +
> +	ret = clk_set_rate(ctrl->pixel_clk, pixel_rate * 1000);
> +	if (ret) {
> +		DRM_ERROR("Failed to set pixel clock rate. ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	if (ctrl->stream_clks_on) {
> +		drm_dbg_dp(ctrl->drm_dev, "pixel clks already enabled\n");
> +	} else {
> +		ret = clk_prepare_enable(ctrl->pixel_clk);
> +		if (ret) {
> +			DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
> +			return ret;
> +		}
> +		ctrl->stream_clks_on = true;
> +	}
> +
> +	return ret;
> +}
> +
>  static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl,
>  						struct msm_dp_panel *msm_dp_panel)
>  {
> @@ -1724,22 +1748,7 @@ static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl
>  	}
>  
>  	pixel_rate = msm_dp_panel->msm_dp_mode.drm_mode.clock;
> -	ret = clk_set_rate(ctrl->pixel_clk, pixel_rate * 1000);
> -	if (ret) {
> -		DRM_ERROR("Failed to set pixel clock rate. ret=%d\n", ret);
> -		return ret;
> -	}
> -
> -	if (ctrl->stream_clks_on) {
> -		drm_dbg_dp(ctrl->drm_dev, "pixel clks already enabled\n");
> -	} else {
> -		ret = clk_prepare_enable(ctrl->pixel_clk);
> -		if (ret) {
> -			DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
> -			return ret;
> -		}
> -		ctrl->stream_clks_on = true;
> -	}
> +	ret = msm_dp_ctrl_stream_clk_on(ctrl, pixel_rate);
>  
>  	msm_dp_ctrl_send_phy_test_pattern(ctrl);
>  
> @@ -1999,21 +2008,10 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
>  
>  	drm_dbg_dp(ctrl->drm_dev, "pixel_rate=%lu\n", pixel_rate);
>  
> -	ret = clk_set_rate(ctrl->pixel_clk, pixel_rate * 1000);
> +	ret = msm_dp_ctrl_stream_clk_on(ctrl, pixel_rate);
>  	if (ret) {
> -		DRM_ERROR("Failed to set pixel clock rate. ret=%d\n", ret);
> -		goto end;
> -	}
> -
> -	if (ctrl->stream_clks_on) {
> -		drm_dbg_dp(ctrl->drm_dev, "pixel clks already enabled\n");
> -	} else {
> -		ret = clk_prepare_enable(ctrl->pixel_clk);
> -		if (ret) {
> -			DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
> -			goto end;
> -		}
> -		ctrl->stream_clks_on = true;
> +		DRM_ERROR("failed to enable stream pixel clk\n");
> +		return ret;
>  	}
>  
>  	/*
> @@ -2041,10 +2039,21 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
>  	drm_dbg_dp(ctrl->drm_dev,
>  		"mainlink %s\n", mainlink_ready ? "READY" : "NOT READY");
>  
> -end:
>  	return ret;
>  }
>  
> +static void msm_dp_ctrl_stream_clk_off(struct msm_dp_ctrl *msm_dp_ctrl)

At least this should come right after msm_dp_ctrl_stream_clk_on().

> +{
> +	struct msm_dp_ctrl_private *ctrl;
> +
> +	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
> +
> +	if (ctrl->stream_clks_on) {
> +		clk_disable_unprepare(ctrl->pixel_clk);
> +		ctrl->stream_clks_on = false;
> +	}
> +}
> +
>  void msm_dp_ctrl_clear_vsc_sdp_pkt(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *dp_panel)
>  {
>  	struct msm_dp_ctrl_private *ctrl;
> @@ -2115,10 +2124,7 @@ void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl)
>  
>  	msm_dp_catalog_ctrl_reset(ctrl->catalog);
>  
> -	if (ctrl->stream_clks_on) {
> -		clk_disable_unprepare(ctrl->pixel_clk);
> -		ctrl->stream_clks_on = false;
> -	}
> +	msm_dp_ctrl_stream_clk_off(msm_dp_ctrl);
>  
>  	dev_pm_opp_set_rate(ctrl->dev, 0);
>  	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

