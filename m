Return-Path: <linux-kernel+bounces-309243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B33C2966802
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E35701C2351C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4511BAEFB;
	Fri, 30 Aug 2024 17:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W6SLVBr7"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC541B3B34
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 17:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725039121; cv=none; b=TJiLq0YiEDhJrYLSMKUR7QUvzYQg/GFfGcY3HUdvxsFHviFmEAtpcqSluEhqUUrrccEq2AUl5iBA+wIK+9d9xTqxwbvaO9ov8DKNPA59JaszyjEH9/6zhOKkZ0KNekGo2fGWDFIAvw4H7QFuUg5rD8NxEPkZwQce4zwOQrXt+ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725039121; c=relaxed/simple;
	bh=HPuJrzEhBcgOxkqhkjY1hnquaQW7va7gh2nHm9hnBkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5qfAnysj3CxSo4KN2UCC+uLseqRY92t5brK60EQT9MA7IYvRRr8/ojyDhvP2JjIzH+U29LgTf/MKuCz7TmPYD9Cf2ksxlNiwN52qzJkumAh3G93RXokazVSCY2cM8m5lexPzmdq6M3u/f/bHzPs4xMrthK8vdJUxlHZ5HI3XyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W6SLVBr7; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5334adf7249so2845267e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725039118; x=1725643918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oVSYJZ8Ei4cvPl9DgIsE5I78GhgQxtf/dQWxZMnQ4Ag=;
        b=W6SLVBr7uKO4O+NB9uwn1u+zr1KrztW0LxMbLEihK9CgwXy7gier86n14GDvkbbLuk
         pn3X9m9R8lyH/S+W44j900XsVrPDVchYaDRz63UV73jv3VJ9NXqESbo1N/WYTQtnWSiW
         vACiCdAG88gXLTOqpXX5Jf4z+fpmBYPnfcZ4s+HD+U720zpaLWUy4JN25RFn0XpKuGN5
         0NJBkZrbjt9bo3hISgPDrMbAZKH6353vlQqeTHfs22JGLdkteWIjkPupFo06XUVeya9o
         S2p3hp8yDl+nCzrsUMdU0ZpMLl3IppPjRkhXPfwStYHTtH1M1ilrF1n3bbEoXwzTomTF
         gLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725039118; x=1725643918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVSYJZ8Ei4cvPl9DgIsE5I78GhgQxtf/dQWxZMnQ4Ag=;
        b=OxpzYAWDL7wMNA/65BbQw5s+ybPu1hG1P70RdFbDZRVAq40QMif5vcjB2tVQR1SmwC
         WIYzrvbRTsaJpz/4S02FO9vCGQjHtDhFDLmXzdjcdjGTZ0BzAV/sljLuX46iD1OAW/dh
         6ytFdha/BagnN1x4d5F4gxNZ4SlsHB24pc/L0221T1smI2asIocrtQepI8ajcaMwjoqV
         wdi4ecXeE8GkbLE+9rCr54pRM2LOyyYKzS1uFevuybn5GF8uyDtkK8wDGNJePzx/14uL
         9Qip6BMSljsEvwTzHIx2DyhcxMYZkD6HAay6BEIYyyYJBrjEtZsnhUTHXH1/vf6TM9WS
         eAnA==
X-Forwarded-Encrypted: i=1; AJvYcCW4V18S1GcFjZO2vgOotwmZjvPRkgJHpS5KjomO29ZwYKTQCmecDEEdmW/9mW4lRmj41jIBcGdLSl1KAnY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8aQhfD/Yaa4K9Gl+0L6h64ZuyrqxcFuyz0ucYcGI37XI113uH
	DbjUfdQqlOcfX1NfH69dn15Xd4L/+RF/DX3y86atvcEhWhX88bbZBTodztIKQBs=
X-Google-Smtp-Source: AGHT+IFh4H/WWx4Qa+vKO6krpjLgwhrJdZoe1PK4esC7igv3wvWH3VSPKe4yX8cIQPl6dqk5jTsx7Q==
X-Received: by 2002:a05:6512:1251:b0:52b:9c8a:734f with SMTP id 2adb3069b0e04-53546bb2b1fmr2135489e87.50.1725039117000;
        Fri, 30 Aug 2024 10:31:57 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5354079b8f9sm701354e87.46.2024.08.30.10.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 10:31:56 -0700 (PDT)
Date: Fri, 30 Aug 2024 20:31:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, quic_abhinavk@quicinc.com, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, quic_ebharadw@quicinc.com, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Rob Clark <robdclark@chromium.org>
Subject: Re: [PATCH 18/21] drm/msm/dpu: Start frame done timer after encoder
 kickoff
Message-ID: <nj5stynavntbe4neop7b7pul5qm2dns5tfnucxhpvubmbs3dsf@3orpp3swrkey>
References: <20240829-concurrent-wb-v1-0-502b16ae2ebb@quicinc.com>
 <20240829-concurrent-wb-v1-18-502b16ae2ebb@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829-concurrent-wb-v1-18-502b16ae2ebb@quicinc.com>

On Thu, Aug 29, 2024 at 01:48:39PM GMT, Jessica Zhang wrote:
> Create a separate API for starting the encoder frame done timer and call
> it after the encoder kickoff is finished
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    |  4 +++-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 21 ++++++++++++++-------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  1 +
>  3 files changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index c8ef59af444c..daf5f751f584 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -970,8 +970,10 @@ void dpu_crtc_commit_kickoff(struct drm_crtc *crtc)
>  
>  	dpu_vbif_clear_errors(dpu_kms);
>  
> -	drm_for_each_encoder_mask(encoder, crtc->dev, crtc->state->encoder_mask)
> +	drm_for_each_encoder_mask(encoder, crtc->dev, crtc->state->encoder_mask) {
>  		dpu_encoder_kickoff(encoder);
> +		dpu_encoder_start_frame_done_timer(encoder);
> +	}
>  
>  	reinit_completion(&dpu_crtc->frame_done_comp);
>  
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index bde385318018..9d495a186eb8 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -1945,18 +1945,12 @@ bool dpu_encoder_is_valid_for_commit(struct drm_encoder *drm_enc)
>  	return true;
>  }
>  
> -void dpu_encoder_kickoff(struct drm_encoder *drm_enc)
> +void dpu_encoder_start_frame_done_timer(struct drm_encoder *drm_enc)

Docs please. With this fixed and with the reason for the change being
added to the commit message:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>  {
>  	struct dpu_encoder_virt *dpu_enc;
> -	struct dpu_encoder_phys *phys;
>  	unsigned long timeout_ms;
> -	unsigned int i;
>  
> -	DPU_ATRACE_BEGIN("encoder_kickoff");
>  	dpu_enc = to_dpu_encoder_virt(drm_enc);
> -
> -	trace_dpu_enc_kickoff(DRMID(drm_enc));
> -
>  	timeout_ms = DPU_ENCODER_FRAME_DONE_TIMEOUT_FRAMES * 1000 /
>  			drm_mode_vrefresh(&drm_enc->crtc->state->adjusted_mode);
>  

-- 
With best wishes
Dmitry

