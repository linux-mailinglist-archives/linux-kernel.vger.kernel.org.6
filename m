Return-Path: <linux-kernel+bounces-526191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0130A3FB5C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31D317ADCEC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47206286298;
	Fri, 21 Feb 2025 16:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WH0rQvea"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D581F1DE4E5
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740155183; cv=none; b=ecdf5VfGs53aMqWLgVuhIIlazOnn8wxgxhpdlaprMcUcM5qLrgroQr6zGIOGTUmTQUgcAXaFPpLUPs/PyYs275BnUT7hGMtqXkFHhYYyGt0pxOIgJVF8HtfYmlJroxF9AljPoAAzWX8y7WM5iTTPmM9Y0iFiVBbWJjg+iSr2yW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740155183; c=relaxed/simple;
	bh=sUJGDV0444vBYzd10XMCRP2yozVGS5BHshZAiO3ClcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcffgRAmr+1awbcGJAJckWTWL/0FG60alPHv3Ccmw1WpYbYBM0p+OuZ2q5SjsLvd+fMWcbtH4Zgf4R9errlE0ONKTfF7oGrihIiP6r3HGLt9cG/vB56S8zYyoJeFTjxkmYt65hh8SnI2iQI6HXNE6hHBY/vuGTqVM+WDnu6XH68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WH0rQvea; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54622829175so2083280e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 08:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740155180; x=1740759980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xjL5HnyHIkjOW/V091xA7OYPeED0xOIXslkPMlUBUug=;
        b=WH0rQveaqBoIBU8Y+UcS00X+xyibjRIPzhiLQnFS2+lnsZiUm7flhIFJoObLlei5q3
         IjdQ5HWZbIoc2R2GjZCCJtqLoFEZ9AMIXPwz7VK8EJZBRoafwBcIQbnpfDQR9cD8W+qz
         +rffsymLzxC9+uFObFdq+/i60sNPSm2BAoZ+kaIPklnZXSSuSXE0Ugg6JZkUJDKZJyDR
         Uu9V+jbTjKRBvbhIgecfyXg+fk2QSOyj+0LkU75rLC4iil9iB8bUcLONHQtuid92xCQD
         fkWqdqx/gflamomxA8D87anYSJpXF9j+BnmLEwyd2mhmM/F5yI8bCVN3yEQkZi3EatKl
         GTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740155180; x=1740759980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjL5HnyHIkjOW/V091xA7OYPeED0xOIXslkPMlUBUug=;
        b=sSSSAeFTvkRHG356hkRtZg+6HAqr21EGAT7AtrzHUPg/PJl4gMlZRZpGQAtTwWpg0D
         KIqGafFD43vmvmzaUjRbs4o8DgfBi3C2BwovE3QWY4cI9eiGNOQnMkQU4dyU1m2e9qmS
         eksgpSa1wbnu/99a3/EfT+ohpzmkQU1RyrT2XC+tiTaLmktS5Rr7rwK+mHNMb8DBQh9Y
         gjhyKngHncH08xGU/7wcCLONdngo+VMuw1zoB9JooaY6zK0gyHvunNmuEtp/QFtHqer6
         iBO4hHZLYwhckEfJwOtFJfXFWFvb9jJqjyWLfzxzY345/TOPSHIa6yhiojaeuGS9e7ql
         XH4g==
X-Forwarded-Encrypted: i=1; AJvYcCX6wpmS5n0qe/JtTYZGIQafJm384ii4gtqBiSMHZE+Gw8gk9o9EW3FEB+nqPKf1QLiNKqar298gFi26aZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFlSB/bPnK+Qk8lalz7ZeaEn/fN9mCNkQZgCWpOLt1FzvPLAMY
	5jnzD31pLjIAQmn3Pk4jT1u2cW8WbHTZk64bJ5e2qPVnsgooNIHe0onGanj3/SE=
X-Gm-Gg: ASbGnct33Lmez3BfJpkcTk+pGIvpwHw7n+7PYO4xdLcyKSjEOczkMIX72bsFr8ulEso
	ollY2jEDsc/bd12wIJ9FKFYN9DFT4v0j9cRfM+07hzOJdZh+z7yr/vWVAjiGlcIqRwpfBpua6XX
	pjye/eUKROlu3E/oViZZYmQFsSx7qdLhqYIt64Eo0d5A+i9EJKuq6tpVKbLg/cgFm0Op5dENrkM
	SHAZsGt2f71EBC3zl5B18VJ4D+CT37p/ExeCDwPprC73bTLMXQCTanF2B3ReiLq5H6dp9ZTIKcy
	hq6DL/4E3UqdkpTFlyR7zhOo9ypkehoidW/hR/vHM9U8giJ9wfpmNkNAFkZBOZdmCW/nnrUNOEJ
	/KhGXRQ==
X-Google-Smtp-Source: AGHT+IGFPBqQwJN5a48M/xNQBTDNxvZTEjIAW3PFsBL+6h3O4OdEk1slnuoUOVeOHEYt968uLpwuBg==
X-Received: by 2002:a05:6512:31cf:b0:545:a5e:b4ef with SMTP id 2adb3069b0e04-5483913ae13mr1829559e87.16.1740155179895;
        Fri, 21 Feb 2025 08:26:19 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30921a593f6sm25579171fa.65.2025.02.21.08.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 08:26:18 -0800 (PST)
Date: Fri, 21 Feb 2025 18:26:16 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Krishna Manikandan <quic_mkrishn@quicinc.com>, 
	Jonathan Marek <jonathan@marek.ca>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, Rob Clark <robdclark@chromium.org>
Subject: Re: [PATCH v3 19/21] drm/msm/dpu: Implement CTL_PIPE_ACTIVE for
 v12.0 DPU
Message-ID: <5rlcxx7pcu32hz3r4qufqcq2jzk2z4g2ep7reecpm2kksttwyi@66p2u4nwfzx6>
References: <20250221-b4-sm8750-display-v3-0-3ea95b1630ea@linaro.org>
 <20250221-b4-sm8750-display-v3-19-3ea95b1630ea@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221-b4-sm8750-display-v3-19-3ea95b1630ea@linaro.org>

On Fri, Feb 21, 2025 at 04:24:29PM +0100, Krzysztof Kozlowski wrote:
> v12.0 DPU on SM8750 comes with new CTL_PIPE_ACTIVE register for
> selective activation of pipes, which replaces earlier
> dpu_hw_ctl_setup_blendstage() code path for newer devices.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v3:
> 1. New patch, split from previous big DPU v12.0.
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    |  9 +++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c |  3 +++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c  | 29 +++++++++++++++++++++++++++--
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h  |  8 ++++++++
>  4 files changed, 47 insertions(+), 2 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Minot nit below

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> index 43a254cf57da571e2ec8aad38028477652f9283c..3e0bdd1100ebb0d302a852ceeaf8af86835e69a1 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> @@ -40,6 +40,7 @@
>  #define   CTL_INTF_FLUSH                0x110
>  #define   CTL_CDM_FLUSH                0x114
>  #define   CTL_PERIPH_FLUSH              0x128
> +#define   CTL_PIPE_ACTIVE               0x12C

lowercase hex, please.

>  #define   CTL_INTF_MASTER               0x134
>  #define   CTL_DSPP_n_FLUSH(n)           ((0x13C) + ((n) * 4))
>  

-- 
With best wishes
Dmitry

