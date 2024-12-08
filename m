Return-Path: <linux-kernel+bounces-436345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 352FF9E84B1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 12:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14140164FD4
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 11:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402C9146A72;
	Sun,  8 Dec 2024 11:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D+bfxCX4"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8005A4D5
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 11:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733657967; cv=none; b=FeJSfdLPJckn4rkevdxucZMxZXletoO/znovyrIEOLbtjL4M6gRq0QwgbBlCL1UshGun7qahRKCGqPv/zieuDsCstLP9nBDVUmkqTyum2/E4no5UzwuICKiN1mprQ1HeFwNUPTUT+oC+RfFq3b/i8InJHWW9K1RXnn+nJOtc/eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733657967; c=relaxed/simple;
	bh=jQk/Q7ElUFDJ8+2z16EsiGL4/k6YTUMKj3wkKJkf2G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqtYrgrvx/gLC9ilnwwL3NaB8KWJPHIUovX9Dmf2gbqqpxYvGtD31HIR6RngtRIWUmOW2gAoKMcW0genFX3Ml21S1ODQx8+Myb7z8WvwzSUVHArAZRHiig8cDEg3H8GqR/ycY08kiPh0DZqG+RdileJi3zsLa46ZBB1RxaCUFDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D+bfxCX4; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5401bd6cdb7so298160e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 03:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733657963; x=1734262763; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W9morjBPw/QOjQQuL/hx7w1FC0q/DCLfzZD9bWcXHsg=;
        b=D+bfxCX4WQMLLCHwzT43hp0Sm07dB8/0QFiLz6E6cDknd0cjLwNUyur6wZVx7mu02b
         EkxPVGbCRShkHOFyerrZZzeyGRLnxUt8tg7xulpXdQa2DWgUd0GUfPjP+JqtWnXnVLqq
         /gYLAa+v5idTTqoYRDyjDpGLkte545CZ/MP3wb9QIOfMj1alLNjV/bcGqygZS3XBEJMr
         1MXAloKa0F/BPYa5W5bbRlwUhKzcKeQiFKrqmLFmgRRDlvghPoMfEBAE8Zuj9BP6gOdC
         kb5nsPZJ8DAg9hGevjVP9wIrp7p9ld3VdTfo3MHBR1SOrHao8/INeeNnfdoMKNeBBEkK
         OL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733657963; x=1734262763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9morjBPw/QOjQQuL/hx7w1FC0q/DCLfzZD9bWcXHsg=;
        b=hOTNPl3n1NXT2t+Gx7KqzMR/c7hKmH/vbznbpTU1n6j1f4/bdKLO0fvQIkf2WB4tN2
         Yk7Ah/R3/1RhB0tfR9Dbcz4rp+aTGiT2h82F4UipybLZbk/Cox8ekX3yShDeGUDk4vO9
         J0GJZIHKIGvJBW3G0UmoHC7OlvW4fVAkRkC8ed6vMHCbTd7nSJn9Oi7kRNQREB80aLOM
         Zk6SEDrZoe/U/qjqVNUK9ywmyvxcOWmfZIEoFPkltq2frKuGZfmEoWadkpnPzXxs3yVw
         afUlDVkDwqP6zELl1Fgz4v+cqxvuv9UjHpywyHu8s5j4rrF+SGKXG8VVb6o5XobfHHEJ
         EwIA==
X-Forwarded-Encrypted: i=1; AJvYcCVuraxubd0lGYdZmalf0u5GCKD4y9wmQiTu7cgca6HKea2Ap8SZXpN90c8I0JhIWKSU1daaoK1/DBSvydk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNm0UcCzRUUtbTgf7c7suiOPrH/ZNhAUsMWzRIfiM+EpLpdSK9
	qiSCLaJir3MxCDUMFvXEGEmx2J5XhmHI7HhvayAnY/TPZD7JfIhgRucuMjGHhXg=
X-Gm-Gg: ASbGncvqdPjys1fKt5nmddcaKXHjgUkwsx/XtUtva0eOwV+1BxuS/EBHIlDuExv1QCy
	yAhF1cx+LEWfNeiO3sLrCN16spAq2GT3I2IqbRsLrh8PsLLy5n6YNoM/0GSf0jcJFmb8HvsM0q6
	3US7bclA4c10/ajDYGw5+PMn8X0efMu2pliJOJW0GWDgC7FwdS8jk3gyERkpqdvP/Trl8rO3Adx
	NkLtd4Ldg0VRnEcVUAZ6gGiWPwlQoSgOLTBCsNY5YFgHyxBSoVji2qeSMeYBcyBWuBhjiDH+7AU
	+aV4dwEzVJXQ/6Nn2Avdl8ZFFmo8EQ==
X-Google-Smtp-Source: AGHT+IEmYeJ2ZQRN84qHuhel52Yb+lkGV4iCWlUilYcgQ5pTjCo0FNpG1AeVpIwExJma9YYEjfC7yQ==
X-Received: by 2002:a05:6512:3dac:b0:540:1d37:e6c with SMTP id 2adb3069b0e04-5401d371124mr371746e87.30.1733657962669;
        Sun, 08 Dec 2024 03:39:22 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e36421f61sm680978e87.137.2024.12.08.03.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 03:39:21 -0800 (PST)
Date: Sun, 8 Dec 2024 13:39:18 +0200
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
Subject: Re: [PATCH 15/45] drm/msm/dp: convert dp_display_set_mode() to use
 dp_panel argument
Message-ID: <zw4np7nvrd627wvrdveisnfuyep5vp7rmrxm4vnmpmqiz7enev@uarpgh753fyc>
References: <20241205-dp_mst-v1-0-f8618d42a99a@quicinc.com>
 <20241205-dp_mst-v1-15-f8618d42a99a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205-dp_mst-v1-15-f8618d42a99a@quicinc.com>

On Thu, Dec 05, 2024 at 08:31:46PM -0800, Abhinav Kumar wrote:
> Convert dp_display_set_mode() to use the dp_panel passed to it
> as an argument rather than the cached one in dp_display_private.

Why?

> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 60 ++++++++++++++++++-------------------
>  1 file changed, 30 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index b506159191184a2a2c83d0735260ac040a33be98..5fa6c003cf6c51eae77573549a555a00dc33f476 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -798,16 +798,38 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
>  }
>  
>  static int msm_dp_display_set_mode(struct msm_dp *msm_dp_display,
> -			       struct msm_dp_display_mode *mode)
> +				   const struct drm_display_mode *adjusted_mode,
> +				   struct msm_dp_panel *msm_dp_panel)
>  {
> -	struct msm_dp_display_private *dp;
> +	struct msm_dp_display_mode msm_dp_mode;
>  
> -	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
> +	memset(&msm_dp_mode, 0x0, sizeof(struct msm_dp_display_mode));
> +
> +	if (msm_dp_display_check_video_test(msm_dp_display))
> +		msm_dp_mode.bpp = msm_dp_display_get_test_bpp(msm_dp_display);
> +	else /* Default num_components per pixel = 3 */
> +		msm_dp_mode.bpp = msm_dp_panel->connector->display_info.bpc * 3;
> +
> +	if (!msm_dp_mode.bpp)
> +		msm_dp_mode.bpp = 24; /* Default bpp */
> +
> +	drm_mode_copy(&msm_dp_mode.drm_mode, adjusted_mode);
> +
> +	msm_dp_mode.v_active_low =
> +		!!(msm_dp_mode.drm_mode.flags & DRM_MODE_FLAG_NVSYNC);
> +
> +	msm_dp_mode.h_active_low =
> +		!!(msm_dp_mode.drm_mode.flags & DRM_MODE_FLAG_NHSYNC);
> +
> +	msm_dp_mode.out_fmt_is_yuv_420 =
> +		drm_mode_is_420_only(&msm_dp_display->connector->display_info, adjusted_mode) &&
> +		msm_dp_panel->vsc_sdp_supported;
> +
> +	drm_mode_copy(&msm_dp_panel->msm_dp_mode.drm_mode, &msm_dp_mode.drm_mode);
> +	msm_dp_panel->msm_dp_mode.bpp = msm_dp_mode.bpp;
> +	msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420 = msm_dp_mode.out_fmt_is_yuv_420;
> +	msm_dp_panel_init_panel_info(msm_dp_panel);
>  
> -	drm_mode_copy(&dp->panel->msm_dp_mode.drm_mode, &mode->drm_mode);
> -	dp->panel->msm_dp_mode.bpp = mode->bpp;
> -	dp->panel->msm_dp_mode.out_fmt_is_yuv_420 = mode->out_fmt_is_yuv_420;
> -	msm_dp_panel_init_panel_info(dp->panel);
>  	return 0;
>  }
>  
> @@ -1662,34 +1684,12 @@ void msm_dp_display_mode_set(struct msm_dp *dp,
>  {
>  	struct msm_dp_display_private *msm_dp_display;
>  	struct msm_dp_panel *msm_dp_panel;
> -	struct msm_dp_display_mode msm_dp_mode;
>  
>  	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
>  	msm_dp_panel = msm_dp_display->panel;
>  
> -	memset(&msm_dp_mode, 0x0, sizeof(struct msm_dp_display_mode));
> -
> -	if (msm_dp_display_check_video_test(dp))
> -		msm_dp_mode.bpp = msm_dp_display_get_test_bpp(dp);
> -	else /* Default num_components per pixel = 3 */
> -		msm_dp_mode.bpp = dp->connector->display_info.bpc * 3;
> -
> -	if (!msm_dp_mode.bpp)
> -		msm_dp_mode.bpp = 24; /* Default bpp */
> -
> -	drm_mode_copy(&msm_dp_mode.drm_mode, adjusted_mode);
> -
> -	msm_dp_mode.v_active_low =
> -		!!(msm_dp_mode.drm_mode.flags & DRM_MODE_FLAG_NVSYNC);
> -
> -	msm_dp_mode.h_active_low =
> -		!!(msm_dp_mode.drm_mode.flags & DRM_MODE_FLAG_NHSYNC);
> -
> -	msm_dp_mode.out_fmt_is_yuv_420 =
> -		drm_mode_is_420_only(&dp->connector->display_info, adjusted_mode) &&
> -		msm_dp_panel->vsc_sdp_supported;
>  
> -	msm_dp_display_set_mode(dp, &msm_dp_mode);
> +	msm_dp_display_set_mode(dp, adjusted_mode, msm_dp_panel);
>  
>  	/* populate wide_bus_support to different layers */
>  	msm_dp_display->ctrl->wide_bus_en =
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

