Return-Path: <linux-kernel+bounces-337788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9606C984EF3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 01:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75F51C22C56
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 23:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BAE186E3A;
	Tue, 24 Sep 2024 23:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KrXoDrPY"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1F8186E3B
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 23:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727220342; cv=none; b=M5WMvG+OVG0NsGbFC5mWgfUMuZhOrEnlPdEd5g9XmpZHK9Ul18ddhUXFX5ZDjBC94K8tmCnscHQLUR8npyYP9IMByLt0AgQS4r4BSKhjN8U1HWUfXAeYPONavb+iMLFFkOYpivFe4dgZqE25fe5EzCGr+jFKd0F+gxGTIfFJZ20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727220342; c=relaxed/simple;
	bh=XIwShqBuVW6XVlAXjtbWQuTVPzbJgEQ6p8Dgf8TfJgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ET/nJ5Dvx+H/toNVReo7t8yqJiYArB9qBrdoWkIKwfuI0bUmujbAjC4IGuuCcE0msWIw/8qreNigLhFYNdIwsk+vmrlBMb5EJFyq2PhitUwI1PzRcasRPdj7iVkTTq42Vev+aQBs/45/paY4clj/vJHHfu9g/EfJ4FyKgm4fUho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KrXoDrPY; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f75129b3a3so62392521fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 16:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727220338; x=1727825138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d5Wwc/j7Kd/NlR3Xj8Oc5OdD8mZfVErehGoE1BXoduc=;
        b=KrXoDrPYhlBG19D/5sbR3QN3xuizBzj0Yvs5gueYtsh8iyPcIMwSi2rqsMRyUoU7A+
         AXoWUErfjviptC/MFtE8GFayoY8229nGVioKkz3YC0fNHfv8PBZM2kYklJiPytjaFnLj
         YykeOSSaVOMLTbJ6TsghRqqZ9DX+X6w8y27es5PZ1Ilu+4OgJc9/MIbS3sVGsSZRv7Bo
         a90SJXs+n7VzIsKPRRTH1GEEZnbZJJ6Fw8q54jQFcy7z8Kl3jfAOGdTpNZdWgz9gkM/C
         3qdDbw932+kFwQBY/6ddW8BJcDH3VcsqxuQnvWqyc8USJp5+6rSSRbbvwmtQlwb6O1Vm
         rI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727220338; x=1727825138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5Wwc/j7Kd/NlR3Xj8Oc5OdD8mZfVErehGoE1BXoduc=;
        b=ICzywQojAFgu8aIKjqTqdYRK5cdBOL0Lxl4/TK2T/0E1N4TEvHBakAJi3dgoDsUJPc
         sHayzE2EQeEvKDgTf9hLHMt976mvLcJxiR55HEthKVONmNTWj9WVdJsRz6EL4Nw89kE3
         A5WuKVaByzTRx/ZIqhpfuMtLlI4GOsmrxsBty9VKpSng6LVyx6Z8wUB0c+CuuNa1N17D
         UkBb6nPDoBPJmow1ysTen1OtiK5YQsgpKLMrbtdI/LLgncx1Zxq8PDU2BPtXCVPrQeiR
         CYF6YF0odfolT7xlCKGO/FCukVcLSwL4pQibx8ThkI36Z+o1Z7fe91idYKlw7HnjMH0y
         GcKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuRXHsyCYrCPZ7Db6NjyHNTCJqmFNHks5Duz20OkgrAj4VDfXt0BN4KcvPZq4RqcG90SdYqis3dFdsKzU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Aybsuvdonlr9tWMBP0AQ/S+iuylNg3x8aLQdit2xikq3SY6Q
	4xgdLctBIUlb7qQjj42q80pFbPVd6nFNc9NicnjrUVTEzg7RhZ2pJXdNllX7Ekc=
X-Google-Smtp-Source: AGHT+IErsYJZb/9+fEt9XssuASamiPaxtmHUQDk1h71SglBIowclioR5xw+YLXxMNA+DUF09H9FMLQ==
X-Received: by 2002:a05:651c:2220:b0:2f7:4e9b:93e1 with SMTP id 38308e7fff4ca-2f91ca4270amr3930561fa.36.1727220338324;
        Tue, 24 Sep 2024 16:25:38 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f8d289b683sm3401301fa.105.2024.09.24.16.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 16:25:36 -0700 (PDT)
Date: Wed, 25 Sep 2024 02:25:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, quic_abhinavk@quicinc.com, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, quic_ebharadw@quicinc.com, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Rob Clark <robdclark@chromium.org>, Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH v2 14/22] drm/msm/dpu: Require modeset if clone mode
 status changes
Message-ID: <yjfe5wajajeqmcp65kbvcttzgkrsfv5rhkbvqvioqx3rwdn6g6@2h2byk2l2imy>
References: <20240924-concurrent-wb-v2-0-7849f900e863@quicinc.com>
 <20240924-concurrent-wb-v2-14-7849f900e863@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924-concurrent-wb-v2-14-7849f900e863@quicinc.com>

On Tue, Sep 24, 2024 at 03:59:30PM GMT, Jessica Zhang wrote:
> If the clone mode enabled status is changing, a modeset needs to happen
> so that the resources can be reassigned

Sima's comment regarding crtc_state->mode_changed seems to be ignored...

> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index a7850bf844db..f20e44e9fc05 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -1268,6 +1268,8 @@ static int dpu_crtc_atomic_check(struct drm_crtc *crtc,
>  {
>  	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
>  									  crtc);
> +	struct drm_crtc_state *old_crtc_state = drm_atomic_get_old_crtc_state(state,
> +									      crtc);
>  	struct dpu_crtc *dpu_crtc = to_dpu_crtc(crtc);
>  	struct dpu_crtc_state *cstate = to_dpu_crtc_state(crtc_state);
>  
> @@ -1279,6 +1281,8 @@ static int dpu_crtc_atomic_check(struct drm_crtc *crtc,
>  	int rc = 0;
>  
>  	bool needs_dirtyfb = dpu_crtc_needs_dirtyfb(crtc_state);
> +	bool clone_mode_requested = drm_crtc_in_clone_mode(old_crtc_state);
> +	bool clone_mode_enabled = drm_crtc_in_clone_mode(crtc_state);
>  
>  	/* there might be cases where encoder needs a modeset too */
>  	drm_for_each_encoder_mask(drm_enc, crtc->dev, crtc_state->encoder_mask) {
> @@ -1286,6 +1290,10 @@ static int dpu_crtc_atomic_check(struct drm_crtc *crtc,
>  			crtc_state->mode_changed = true;
>  	}
>  
> +	if ((clone_mode_requested && !clone_mode_enabled) ||
> +	    (!clone_mode_requested && clone_mode_enabled))
> +		crtc_state->mode_changed = true;
> +
>  	if (drm_atomic_crtc_needs_modeset(crtc_state)) {
>  		rc = dpu_crtc_assign_resources(crtc, crtc_state);
>  		if (rc < 0)
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

