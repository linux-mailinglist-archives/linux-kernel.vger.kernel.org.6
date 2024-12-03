Return-Path: <linux-kernel+bounces-429665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A06D9E2080
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC2EBB3F263
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEE21F7549;
	Tue,  3 Dec 2024 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YR0pNFpB"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63731F7091
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 14:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236455; cv=none; b=lhFbKTpHvr9p9Cquf3ntfTn4Q7jWwR4ga/m4MEn/NbYmFnEAknekBzTVJBTbtrrrsJAS+O2M2M4p2BisHqJ5PK18vyJ2QXUsvWdXVBjNsk+e+/HvGb+7ejGX2Qn9KQt4WJct8h3DUrN3RTsxkT7AUvhvIHq+/U/AvPAHbPISJ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236455; c=relaxed/simple;
	bh=pYO9Ik7h6Sy05p7jQh246VoAGtssBLsMf5ZGe5lS1pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onWnnsYtcSXRpDFz6up8qLP48Ttp3ZMr1ZRLoe+ergCcNaOq4TTGORRRikxbp+U3BFb+GF6wZ3Q7ENUjrUAeZkUCBLkU3d4tlcDExUTwDt57oQBA01PMw0IB7mRMjZrIrCxsbmJVSxpo1UErr7nBzdpONkM1chnqBH8fMaEYiB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YR0pNFpB; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53de79c2be4so6732150e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 06:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733236452; x=1733841252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OTwLeT3aQeMpcOp4Q1BFPHKxDtrlDP9yLmVoPEGdsN0=;
        b=YR0pNFpBhbrq1w/uinww+THsp2QGkGLmruULyQT94jyDONQEIKLgLMIC9FhmJcC05j
         TCcymrIN2XjysZHn5D78TWrid9s0/IS6SrJJvSAarALfA0juvfX7j5LP732qlx4sYa2Z
         524T/8piDCt5XVMzFwRiKk58HGCcNTWDjB//kJJpk77FTzpuhjrJ1ZnCD3kDPC5jV7k/
         AYRnO+Pdk3pzq/Uz+rwz89F0UZEZv1YMgIQTFNAoXdYl9Ja8HTwMI0A5fzGE/qGlj8lM
         zKijekm+jd5Umeoo4tkql1tneMvGLV7HV9aMJ1aJWODKdfVlwNve0ehOWavE0a3fDLXt
         FlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733236452; x=1733841252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTwLeT3aQeMpcOp4Q1BFPHKxDtrlDP9yLmVoPEGdsN0=;
        b=QFl537lcS6jPjqlA8GMAxwa7bQ/c1GlyqQ5Fq7wgspp3rHgGLnNCr+kadXyahEPxOo
         Mk0YwNIXJPRWKgqgobpb6GTf5G2IqiyiV/lxt2MVZMKjt/P0YWcZnroRGUCrHZ8l4TNJ
         +oY1hZfNnLEio6hIg1xfHrbakPojojEsTSVB80i8eZA4g9ACZyAqnVUcXNnqLIKEBiA/
         HkbiswRUvu35rmiapJodybR0YZCMWik9YxskiQSWUvxyMZgTJPuilzu22221pz9tnsmN
         ZCW9O/Km06QlFI2umrMaAJ4hG1rqao6vCy3Ufa+9t0pwms58CbrkzUDt0J+5p6+N3boD
         Dh+A==
X-Forwarded-Encrypted: i=1; AJvYcCW9Xn/achw/qn8nESvrOd9CWoscPXeSi6ndYbz+bMiFy3il49L7OZnR660GhzhT54u28+YQJjrqGNm6Gyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS0pJZ/dTshsVuSez6UYPOiF5Td6Xvh2AGfbWUFgGxjyxxfmIV
	jNWQuOLdTdBWJJj9ubfwyAKZ3AWXCCUC+RnEVNw+TWdNgijfwKPKtVmp1ZopJy4=
X-Gm-Gg: ASbGncuDmzm+pISt98z4ZOwcSRCL8duv66rw7PxxVrgwC2i2g9UJWkAKCSvrTYZHSwC
	XzhYOfrTEor6Ls8ehxMSWpk1RXEfJrFbTva7z90B3Pe2afGVySsGAiT+OdCSrO+6BTT1MdGvNsm
	XcOBJvcKaqXBsEM6V2/q7KJisVMfMcvCnuQ/y5gLMZeOApuKjNgwxVqWsM4fqTwS/3SD/gtKgrF
	4Ys45l75nCnQPum+QxF5gKNrXZ26L6VGVHCu9QTlsoZ6t28HPt+HjrgfOeUlxyIJzovSMIW21HR
	szgMx6n81G4axhVCLDtGGbMZUOBdGQ==
X-Google-Smtp-Source: AGHT+IEy1sx0BWSMOp5Z7xI7HaeVkaEKc3qbAGcaYeHf/G5vYZpDUtVEJUQzItIhVGsMUW1ZYWXRpw==
X-Received: by 2002:a05:6512:b8e:b0:53d:ed62:e653 with SMTP id 2adb3069b0e04-53e129fdbebmr1839987e87.15.1733236451759;
        Tue, 03 Dec 2024 06:34:11 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df646f097sm1840541e87.161.2024.12.03.06.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 06:34:10 -0800 (PST)
Date: Tue, 3 Dec 2024 16:34:08 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Stephen Boyd <swboyd@chromium.org>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Jessica Zhang <quic_jesszhan@quicinc.com>
Subject: Re: [PATCH 1/3] drm/msm/dp: account for widebus in
 msm_dp_catalog_panel_tpg_enable()
Message-ID: <hwomnwmuak3optjooe6g5szqi77nc7znsfjrxqbxx72nqe3e7k@om2e65vaurov>
References: <20241202-tpg-v1-0-0fd6b518b914@quicinc.com>
 <20241202-tpg-v1-1-0fd6b518b914@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202-tpg-v1-1-0fd6b518b914@quicinc.com>

On Mon, Dec 02, 2024 at 12:41:58PM -0800, Abhinav Kumar wrote:
> Adjust the h_active calculation to account for widebus in tpg.
> 
> Fixes: 757a2f36ab09 ("drm/msm/dp: enable widebus feature for display port")
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_catalog.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
> index b4c8856fb25d..05c8e1996f60 100644
> --- a/drivers/gpu/drm/msm/dp/dp_catalog.c
> +++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
> @@ -1011,9 +1011,21 @@ void msm_dp_catalog_panel_tpg_enable(struct msm_dp_catalog *msm_dp_catalog,
>  	u32 v_sync_width;
>  	u32 hsync_ctl;
>  	u32 display_hctl;
> +	u32 h_sync_width;
> +	u32 h_front_porch;
> +	u32 h_back_porch;
> +	u32 h_active;
> +
> +	h_active = drm_mode->hdisplay;
> +	h_back_porch = drm_mode->htotal - drm_mode->hsync_end;
> +	h_sync_width = drm_mode->htotal - (drm_mode->hsync_start + h_back_porch);

It's at least drm_mode->hsync_end - drm_mode->hsync_start

> +	h_front_porch = drm_mode->hsync_start - drm_mode->hdisplay;
> +
> +	if (msm_dp_catalog->wide_bus_en)
> +		h_active /= 2;
>  
>  	/* TPG config parameters*/
> -	hsync_period = drm_mode->htotal;
> +	hsync_period = h_sync_width + h_back_porch + h_active + h_front_porch;

Is it equivalent to:

hsync_period = drm_mode->htotal;
if (msm_dp_catalog->wide_bus_en)
    hsync_period -= drm_mode->hdisplay / 2;

I think it's simpler to handle.

>  	vsync_period = drm_mode->vtotal;
>  
>  	display_v_start = ((drm_mode->vtotal - drm_mode->vsync_start) *
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

