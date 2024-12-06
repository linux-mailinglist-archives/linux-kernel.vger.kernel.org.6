Return-Path: <linux-kernel+bounces-434665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC46F9E6994
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F6ED2825FD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F4A1E1041;
	Fri,  6 Dec 2024 09:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KPNfTpoa"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EFE18E050
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 09:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733475716; cv=none; b=B47CI7xAuX6knpTACgNdjVCWUYdu9QfGJ8gJTvhxsQCEsKv5lqv4rFTJhMM7lpMChQIorYc4c6htpsyKYq5V/9GGioTJnw2dpySnsuInVqiUOWe4H1COozW5worZKhazWGMTAmaCOhIk2jbHQm/LEVaWRncz93w2ZTqlPlVEEW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733475716; c=relaxed/simple;
	bh=bIxAup2lz0R5xBDAVAzhHfisE8r1P4jcXjhac0PQRls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=go+K7+J3+gdA/QC+xfFC0QtqRZllKKUWd8N0hUIx+AH8dEX/S0n/m586uX7qyIwcbNwieaceMJp7RlFwvgt2c+H0hT1PqLbQ0q7KsC1tyrZilMrvKUhnkgJDloo6w0jUnCVZ6xjnlNlZhfJjhPwLT87L1k9k0Y3m9HNqt6aO7mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KPNfTpoa; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53de8ecafeeso2043555e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 01:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733475713; x=1734080513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ewjfA2zB7MJtvrBmdqkSKX8dAgp3ONrC04bFiltR3uU=;
        b=KPNfTpoauxM9rVly5pjYF/pKPJzg/a/0bLMEqVx/+aKhS9l7LoLt5sR9lfpFr9kE5D
         Yn+ahc2IibSun2dWioDrZWr0Gq1ZXWSOCoezGysm1zV3MI9xoYh+rZFchnGDdVpzCpyV
         RKBH3PQUSgvRYNpe5mlzSmXwZinutbFCVHl/d83cbL1d+78pMgYmU/vfmC1T14Pd54v3
         4Bb05myOhgl58jeJ5peDOFfqBNnaDRKj+IV9b9/m7yg4E67/DoTh4gdOh29gcLhVp7BH
         UUryUqLVoCD+O+7GmHrig2Xbk4cByy2Ax5rqgG8jAtcsx+nTqPLYSZ3mPvVtaCpObCL/
         UJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733475713; x=1734080513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewjfA2zB7MJtvrBmdqkSKX8dAgp3ONrC04bFiltR3uU=;
        b=sp7KyPdtB1U3n+3uicotVFlIerQu2dfF1wYWMkU5JPbOsUmOBzALGjLg7vgdDoJeCg
         v4kNeaT3j31Jqxs1Vg4x166xnhJAZPU6yfAP+m4D1nUJaPTlsUAtBAQtkbgX/lmYPGJA
         jdtYx/ZQjGvVNGsPQa1XN7b6CEoouhzOK/4fxE65ayGvAb/4/0Gfx4aNa2B7dNBsxdLa
         aKK9MCeTT15/WmxlgQrq7fXxjLRrmAmORiyIxl9q8lD6eShXQMvZ1orYJ8KEiFhS/E7F
         o+YylYs5RgmogzQlcsMww2SrP15vObgx9sfu/3/o4/7POb7UYoSG37Zy8AQ1zx21WruV
         4PlA==
X-Forwarded-Encrypted: i=1; AJvYcCVA6X40OjHmL5h0rQRNxGpzELuhdh6ROKKso0q+mlHoDHow9aBqmEV/hmyrJVQM+Jj6rBt3BgYd25p5M20=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHxuM3/3H0r60kTuljQ632pWi2U3nNXwQ7tXsfjE5Nw63d5tQZ
	zBbiKpZ1R/NO+66ELqMpBDW8238EOj+L9f2qcIzdpINmIucFGme5XnzmTa+WbHE=
X-Gm-Gg: ASbGncsS1Q50ZvhAglwTjNDy12/Yt/lG4LnURsoGNp9GxSSHBbciC+yuKQ2kG8yTnyW
	7xb8pTdR17uDMaaucoxCLYzQKfcqeGZeZbl33AXUJ1vgt4jHpco6UBWyjbOCT8Ips/czbn17HcB
	NKA3HJmRCLymR5ez/Y/kbNEWux9Pwb0N5LOCygnnwazy41qJTcK2Y9SGhVoP8vgiOMBBWueQj35
	ij6e+sQCX5mbnjoJ5+jXNcDswHXsL1blP98siYIEbJQGvU2r7NqwnN/qJEbATVSQrdyVh9HhtQy
	DQPcmhaExNAeky9GK6mxtFmhT71CBA==
X-Google-Smtp-Source: AGHT+IHewBkomdVnD/xM5P6dyFTA0maIFSMrnI7aNDtbE1FGcJmiheT1aRvkMYU1aVoO3cS20XGa/A==
X-Received: by 2002:a05:6512:1055:b0:53e:2628:3c24 with SMTP id 2adb3069b0e04-53e2c2effd3mr603786e87.47.1733475712650;
        Fri, 06 Dec 2024 01:01:52 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e2cd847c2sm124389e87.161.2024.12.06.01.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 01:01:51 -0800 (PST)
Date: Fri, 6 Dec 2024 11:01:48 +0200
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
Subject: Re: [PATCH 06/45] drm/msm/dp: remove dp_display's dp_mode and use
 dp_panel's instead
Message-ID: <rjhv2modyvb2py4z6ve7i3xqu6ezrz7op7r6ygldbhydbvrtha@32bkl37jwol3>
References: <20241205-dp_mst-v1-0-f8618d42a99a@quicinc.com>
 <20241205-dp_mst-v1-6-f8618d42a99a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205-dp_mst-v1-6-f8618d42a99a@quicinc.com>

On Thu, Dec 05, 2024 at 08:31:37PM -0800, Abhinav Kumar wrote:
> dp_display caches the current display mode and then passes it onto
> the panel to be used for programming the panel params. Remove this
> two level passing and directly populated the panel's dp_display_mode
> instead.

Remove both and use the one from crtc_state?

> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 46 ++++++++++++++++---------------------
>  1 file changed, 20 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 052db80c6a365f53c2c0a37d3b69ea2b627aea1f..4bd85ae754429333aa423c985368344cd03c7752 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -90,7 +90,6 @@ struct msm_dp_display_private {
>  	struct msm_dp_panel   *panel;
>  	struct msm_dp_ctrl    *ctrl;
>  
> -	struct msm_dp_display_mode msm_dp_mode;
>  	struct msm_dp msm_dp_display;
>  
>  	/* wait for audio signaling */
> @@ -1436,10 +1435,13 @@ bool msm_dp_needs_periph_flush(const struct msm_dp *msm_dp_display,
>  bool msm_dp_wide_bus_available(const struct msm_dp *msm_dp_display)
>  {
>  	struct msm_dp_display_private *dp;
> +	struct msm_dp_panel *dp_panel;
>  
>  	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>  
> -	if (dp->msm_dp_mode.out_fmt_is_yuv_420)
> +	dp_panel = dp->panel;
> +
> +	if (dp_panel->msm_dp_mode.out_fmt_is_yuv_420)
>  		return false;
>  
>  	return dp->wide_bus_supported;
> @@ -1501,10 +1503,6 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
>  	bool force_link_train = false;
>  
>  	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
> -	if (!msm_dp_display->msm_dp_mode.drm_mode.clock) {
> -		DRM_ERROR("invalid params\n");
> -		return;
> -	}
>  
>  	if (dp->is_edp)
>  		msm_dp_hpd_plug_handle(msm_dp_display, 0);
> @@ -1516,13 +1514,6 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
>  		return;
>  	}
>  
> -	rc = msm_dp_display_set_mode(dp, &msm_dp_display->msm_dp_mode);
> -	if (rc) {
> -		DRM_ERROR("Failed to perform a mode set, rc=%d\n", rc);
> -		mutex_unlock(&msm_dp_display->event_mutex);
> -		return;
> -	}
> -
>  	state =  msm_dp_display->hpd_state;
>  
>  	if (state == ST_CONNECTED && !dp->power_on) {
> @@ -1599,37 +1590,40 @@ void msm_dp_bridge_mode_set(struct drm_bridge *drm_bridge,
>  	struct msm_dp *dp = msm_dp_bridge->msm_dp_display;
>  	struct msm_dp_display_private *msm_dp_display;
>  	struct msm_dp_panel *msm_dp_panel;
> +	struct msm_dp_display_mode msm_dp_mode;

No need to allocate it on stack just to copy it later on. Please write
the data directly to a proper location from the beginning.

>  
>  	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
>  	msm_dp_panel = msm_dp_display->panel;
>  
> -	memset(&msm_dp_display->msm_dp_mode, 0x0, sizeof(struct msm_dp_display_mode));
> +	memset(&msm_dp_mode, 0x0, sizeof(struct msm_dp_display_mode));
>  
>  	if (msm_dp_display_check_video_test(dp))
> -		msm_dp_display->msm_dp_mode.bpp = msm_dp_display_get_test_bpp(dp);
> +		msm_dp_mode.bpp = msm_dp_display_get_test_bpp(dp);
>  	else /* Default num_components per pixel = 3 */
> -		msm_dp_display->msm_dp_mode.bpp = dp->connector->display_info.bpc * 3;
> +		msm_dp_mode.bpp = dp->connector->display_info.bpc * 3;
>  
> -	if (!msm_dp_display->msm_dp_mode.bpp)
> -		msm_dp_display->msm_dp_mode.bpp = 24; /* Default bpp */
> +	if (!msm_dp_mode.bpp)
> +		msm_dp_mode.bpp = 24; /* Default bpp */

The msm_dp_mode.bpp gets rewritten by msm_dp_panel_init_panel_info()
after being set here. Is this code part redundant?

>  
> -	drm_mode_copy(&msm_dp_display->msm_dp_mode.drm_mode, adjusted_mode);
> +	drm_mode_copy(&msm_dp_mode.drm_mode, adjusted_mode);
>  
> -	msm_dp_display->msm_dp_mode.v_active_low =
> -		!!(msm_dp_display->msm_dp_mode.drm_mode.flags & DRM_MODE_FLAG_NVSYNC);
> +	msm_dp_mode.v_active_low =
> +		!!(msm_dp_mode.drm_mode.flags & DRM_MODE_FLAG_NVSYNC);
>  
> -	msm_dp_display->msm_dp_mode.h_active_low =
> -		!!(msm_dp_display->msm_dp_mode.drm_mode.flags & DRM_MODE_FLAG_NHSYNC);
> +	msm_dp_mode.h_active_low =
> +		!!(msm_dp_mode.drm_mode.flags & DRM_MODE_FLAG_NHSYNC);
>  
> -	msm_dp_display->msm_dp_mode.out_fmt_is_yuv_420 =
> +	msm_dp_mode.out_fmt_is_yuv_420 =
>  		drm_mode_is_420_only(&dp->connector->display_info, adjusted_mode) &&
>  		msm_dp_panel->vsc_sdp_supported;
>  
> +	msm_dp_display_set_mode(dp, &msm_dp_mode);
> +
>  	/* populate wide_bus_support to different layers */
>  	msm_dp_display->ctrl->wide_bus_en =
> -		msm_dp_display->msm_dp_mode.out_fmt_is_yuv_420 ? false : msm_dp_display->wide_bus_supported;
> +		msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420 ? false : msm_dp_display->wide_bus_supported;
>  	msm_dp_display->catalog->wide_bus_en =
> -		msm_dp_display->msm_dp_mode.out_fmt_is_yuv_420 ? false : msm_dp_display->wide_bus_supported;
> +		msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420 ? false : msm_dp_display->wide_bus_supported;
>  }
>  
>  void msm_dp_bridge_hpd_enable(struct drm_bridge *bridge)
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

