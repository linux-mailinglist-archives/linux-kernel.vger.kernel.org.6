Return-Path: <linux-kernel+bounces-526188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE19A3FBAC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6BB7865245
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E411BC09A;
	Fri, 21 Feb 2025 16:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uONGNCj4"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3B51CCEE0
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740155140; cv=none; b=Urg8gC9UmZQO+gTLxWzbye1GmUT7m3YkiUv40hy2QmlkSMmpuhBFzgV/l1bTy4uurbSnq4ur8J+CzKw3Jq2KXByYQX1U2USsQbfyBahtr0lQf96eai8pEWkD/cvZvhYIlm7Sl1xGntqSCEVMmEVXRAk7KldBe3kojuzWFizAcaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740155140; c=relaxed/simple;
	bh=aEE25AXlSTLbdefl+4KfStMhcPWUHROG4MtJ6YdtyXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxMPLIC99HRMfGEsSo6RwhBX9vcDJ1pnaSwgVI8ledYSVAgVS+sSZJ38N6hfKFlrFKWXubOZ4WVqE6d1aQ03xLoVnm+g7XBBih+5Z6Va2q4Sd4EggkKWVxEwFazT3Rhobnw8VkGvJ/RCknr5a/srOA21uVWWHW6lJvj8kLoJ0gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uONGNCj4; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30737db1aa9so22093551fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 08:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740155135; x=1740759935; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zVZWunDIG7iJIj75JUGRirS9XvGJ484MyBZ0PrGNwBE=;
        b=uONGNCj41ac2B8P2mvmzdd/ARnUsLyuqie839y0HjM89WmcNlBr16G2aZA/btRb7tw
         h0SfzYAAeMvjPt955MDOG+fmtYepuTJ4xDgQO92LLZTe7IqVQVGmQy0fZHZ38Ij71CD/
         xrTNV1xAAHXo6wpQWZ7ZeSgenWUA2a5x/HEESjaAkUhed2f2QuvvUOVIf3YajAOHFsjw
         JO9Cpd024V4kHLIEHI2f6Y9ualY9+NfwnMDbFmgsEoMoOcs5a1l9HyVqRl8236QQI43I
         A5B5Bh2T/uB1g8HFmkX6EWg8SsCkfOBd2dWVsLc3VaCMFAUURGgJp7HYEnWOYztM4od8
         81QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740155135; x=1740759935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVZWunDIG7iJIj75JUGRirS9XvGJ484MyBZ0PrGNwBE=;
        b=VXHDi0cw/J9D+PNbN0wicGuO8tOmVrFqKNw7vr89G8F5iJdH/j9taN1ose8LGWaqrA
         Oh9EGigUcTG4Y86Y0wETRE1gTSqxnVBzJOhE2at/6W9JT9s6ze2gU8ZGNFWhSf4Fiy11
         CQcXGjUW8Ck1b9JXNJWfip8dNcU/IjWcKYMKnOhR0P3NPJdfpgkzR4OCOWsYjk5SoSUo
         66S2t2qoJ72rc1COiymI0Djd3mM++6tY3kgCOXzLlOPTY4XPufb0KG8nRmNHxWPAl05B
         r12emfvIiQfB/pJ8xI4Mdks36HAvNCbHrkDkiFHVmhUSgG4eTp04WY4M553eTUFnZfQO
         zLig==
X-Forwarded-Encrypted: i=1; AJvYcCVDzAzZrLd7vxHK3RXG3+v3GNA8mW0zy2vjXaiR7wSsncl5L4kHSEdTh9EbH1PN36SbGWd3FyCbsfD3C2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5X28lcd/4npsH1jY5F54q9+MXuEUqsl972pWr38YJheCuWo9V
	dGzvyAy9CjDq1tGjMFLfvAnbDpEnq5XjMGMvbNZKlvZ+dU3Gb/MtfY842+SjWWs=
X-Gm-Gg: ASbGnctM+5oYzauQt+owSSDkHnvyYs5gM39qegJHduiVnCPBuDEJekbE2AkFRvLewda
	dd0W8Uk5jyLwQBZSAY5RvDZc/X5RvD3wj/ofoO98fzc/bAZZaF+ZL8jidUTluCKFhqbD+mZVJDQ
	3Xnwu8tVoFVQBr7r0ngN91RZZsnkE+BBsFBx2BoZ6S8IsIrONVha7xyWUwFWgebXSiMlDTtLOv1
	jSKmZYEn/zrdHtAJWaL8XvIoS8ATEB4NdMlVYP09CoNSdBVV20H2J66PH21pDXpOP5m+34E1Aul
	3B9cjXiDv1ClnxeKnWoUP+UlLbY8mzMMZzszUL8L9N3+U6VkhYAbq1v/ogFUpGE5/kyPSJyGWhi
	c46VswA==
X-Google-Smtp-Source: AGHT+IGwPCQwlJ8n3fHSVoLxs5y3AVSJq/S4VL0YsBEmcH8zygS1KlxAOHXc2+k8N/cIbIZteGkAQQ==
X-Received: by 2002:a2e:300e:0:b0:309:214a:6b16 with SMTP id 38308e7fff4ca-30a598f6c81mr12214571fa.22.1740155134665;
        Fri, 21 Feb 2025 08:25:34 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3091011ed8bsm29249061fa.56.2025.02.21.08.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 08:25:33 -0800 (PST)
Date: Fri, 21 Feb 2025 18:25:31 +0200
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
Subject: Re: [PATCH v3 18/21] drm/msm/dpu: Implement 10-bit color alpha for
 v12.0 DPU
Message-ID: <4y2nj6qxbbp7etuweoyarcg7vpbyemparzclj7ulb46rxk7k3s@s6wjrjebuc3g>
References: <20250221-b4-sm8750-display-v3-0-3ea95b1630ea@linaro.org>
 <20250221-b4-sm8750-display-v3-18-3ea95b1630ea@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221-b4-sm8750-display-v3-18-3ea95b1630ea@linaro.org>

On Fri, Feb 21, 2025 at 04:24:28PM +0100, Krzysztof Kozlowski wrote:
> v12.0 DPU on SM8750 comes with 10-bit color alpha.  Add register
> differences and new implementations of setup_alpha_out,
> setup_border_color and so one for this.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v3:
> 1. New patch, split from previous big DPU v12.0.
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c  | 20 +++++---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c | 84 +++++++++++++++++++++++++++++--
>  2 files changed, 94 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index b9fe3a7343d54f6f8b5aad7982928d5fc728bd61..7a35939ece180c15898b2eaa2f1f451767c741ae 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -319,15 +319,21 @@ static bool dpu_crtc_get_scanout_position(struct drm_crtc *crtc,
>  	return true;
>  }
>  
> -static void _dpu_crtc_setup_blend_cfg(struct dpu_crtc_mixer *mixer,
> -		struct dpu_plane_state *pstate, const struct msm_format *format)
> +static void _dpu_crtc_setup_blend_cfg(const struct dpu_hw_ctl *ctl,
> +				      struct dpu_crtc_mixer *mixer,
> +				      struct dpu_plane_state *pstate,
> +				      const struct msm_format *format)
>  {
>  	struct dpu_hw_mixer *lm = mixer->hw_lm;
>  	uint32_t blend_op;
> -	uint32_t fg_alpha, bg_alpha;
> +	uint32_t fg_alpha, bg_alpha, max_alpha;
>  
>  	fg_alpha = pstate->base.alpha >> 8;
> -	bg_alpha = 0xff - fg_alpha;
> +	if (ctl->mdss_ver->core_major_ver < 12)
> +		max_alpha = 0xff;
> +	else
> +		max_alpha = 0x3ff;

So, CTL is passed only to get struct dpu_mdss_version? It can either be
passed directly or fetched via dpu_kms->catalog->mdss_ver

> +	bg_alpha = max_alpha - fg_alpha;
>  
>  	/* default to opaque blending */
>  	if (pstate->base.pixel_blend_mode == DRM_MODE_BLEND_PIXEL_NONE ||
> @@ -337,7 +343,7 @@ static void _dpu_crtc_setup_blend_cfg(struct dpu_crtc_mixer *mixer,
>  	} else if (pstate->base.pixel_blend_mode == DRM_MODE_BLEND_PREMULTI) {
>  		blend_op = DPU_BLEND_FG_ALPHA_FG_CONST |
>  			DPU_BLEND_BG_ALPHA_FG_PIXEL;
> -		if (fg_alpha != 0xff) {
> +		if (fg_alpha != max_alpha) {
>  			bg_alpha = fg_alpha;
>  			blend_op |= DPU_BLEND_BG_MOD_ALPHA |
>  				    DPU_BLEND_BG_INV_MOD_ALPHA;
> @@ -348,7 +354,7 @@ static void _dpu_crtc_setup_blend_cfg(struct dpu_crtc_mixer *mixer,
>  		/* coverage blending */
>  		blend_op = DPU_BLEND_FG_ALPHA_FG_PIXEL |
>  			DPU_BLEND_BG_ALPHA_FG_PIXEL;
> -		if (fg_alpha != 0xff) {
> +		if (fg_alpha != max_alpha) {
>  			bg_alpha = fg_alpha;
>  			blend_op |= DPU_BLEND_FG_MOD_ALPHA |
>  				    DPU_BLEND_FG_INV_MOD_ALPHA |
> @@ -482,7 +488,7 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
>  
>  		/* blend config update */
>  		for (lm_idx = 0; lm_idx < cstate->num_mixers; lm_idx++) {
> -			_dpu_crtc_setup_blend_cfg(mixer + lm_idx, pstate, format);
> +			_dpu_crtc_setup_blend_cfg(ctl, mixer + lm_idx, pstate, format);
>  
>  			if (bg_alpha_enable && !format->alpha_enable)
>  				mixer[lm_idx].mixer_op_mode = 0;
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
> index 3bfb61cb83672dca4236bdbbbfb1e442223576d2..75bf3521b03c8e243ccfe1fc226aa71f23b296df 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
> @@ -19,12 +19,20 @@
>  
>  /* These register are offset to mixer base + stage base */
>  #define LM_BLEND0_OP                     0x00
> +
> +/* <v12 DPU with offset to mixer base + stage base */
>  #define LM_BLEND0_CONST_ALPHA            0x04
>  #define LM_FG_COLOR_FILL_COLOR_0         0x08
>  #define LM_FG_COLOR_FILL_COLOR_1         0x0C

lowercase hex

>  #define LM_FG_COLOR_FILL_SIZE            0x10
>  #define LM_FG_COLOR_FILL_XY              0x14
>  
> +/* >= v12 DPU */
> +#define LM_BORDER_COLOR_0_V12		0x1C

lowercase hex

> +#define LM_BORDER_COLOR_1_V12		0x20
> +
> +/* >= v12 DPU with offset to mixer base + stage base */
> +#define LM_BLEND0_CONST_ALPHA_V12	0x08

This doesn't seem to be aligned properly

>  #define LM_BLEND0_FG_ALPHA               0x04
>  #define LM_BLEND0_BG_ALPHA               0x08
>  

-- 
With best wishes
Dmitry

