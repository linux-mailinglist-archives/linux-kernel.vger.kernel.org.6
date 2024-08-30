Return-Path: <linux-kernel+bounces-309236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A39229667E5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6121228245D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988E11BAECC;
	Fri, 30 Aug 2024 17:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U78Kf8DG"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F5414C585
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 17:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725038583; cv=none; b=RU5Ka7Q85GrySr4XS9z9x1vK+Le5FDBKGIxAALzUqOrW0OOwXSo0SgnBICrPHkGsVLaXK0rNs4AIRBshKDHIRVg9DtLwj2FuRN9khvEs0fzNuIDmdNi8JXGX8zx36slJBtKOsH6HSCRayEDaJh8yfCj/BGBx7r0n87IQ5YbSuaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725038583; c=relaxed/simple;
	bh=h986NzrbMWhvvW4WSnBqgPTrcVQXHbhYX3UqTnuE7Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgvCJ5rR36nHQDgorSfhg7WZIZCVNIkeyQUh+P/s2ccSde6RO6aXaoDEbnpC+wsADCnWWrmNdrXwqdRJpjQBQExMEOYVLcZbwDaX+4NBH5O//JeT3pQjIcNfhTijCWtPHKHU88CNtmeeG+IzWDUtqNaK8tXEYB4Y0f5j1+fIyrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U78Kf8DG; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f50966c478so20825121fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725038580; x=1725643380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JonTUQCBs5ivMCokNBrIZmOlyFwwTNBGJMICc1ZLhJA=;
        b=U78Kf8DG++aRrsq6Gf+Cuvu/6PRKbuMfw1NudnidJNs1/Q9cEkmiNSSoGGZacK3YSi
         Ed4b/zvj/V7O4QZE68/HC4b8kTXBRp1V92ityCN9JZFUFcylcppLFPPWmf1NpVgvobNF
         d7IZH9aJz0P941c3NEMRQcmnoeqcoqgDmN1zsvvO9k16Q9FLUtWi3l/QApjyhiJQIo/Q
         fD04eaVxa+RxK8RZZZ1Tq35HhpEEergOF2yKUwviox820dX2SRzo/LlWuqo18LyIpTI2
         Pyl9KiGGKaT9yNshwsnOMQjG9EKfneSYfL1ByhSZGYmWLSwUa+2+qGjFsuAhqyBMXLO2
         1Y0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725038580; x=1725643380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JonTUQCBs5ivMCokNBrIZmOlyFwwTNBGJMICc1ZLhJA=;
        b=uT/rAGbNoHBwEUM7wECqg3T4CARafK1AgMr1qwWUzKoed91fyZ+56JTXSqZjw0e+bm
         es5AdEYF21DwvtIcZtMnWr26KFjF3fcNPxljIBaw6re0sw2TwbFQqwYrvKXwbC0ctHQ+
         MROlAwPes70Nu6b6ojIZ5g4qqATJXgXhRkcUxXrzxqsRNaSck+kkEAWSWHtUWl13aH4T
         yVDp73PhNv09EO67Wot80wNV1ZU9EywvW/Q0/9/bOjY4CCeqjIpOLHtwNSPUKAOHS2GZ
         QriY07hhoGXCc2gZETE94Ueo3lRHTD8PZywfWiA9hCtKsUDjvYO+a+YtvTJJ044XKEze
         dSQw==
X-Forwarded-Encrypted: i=1; AJvYcCWsjrpFR78prKsQYSb4RXy6erAGXbV7tYAz58ORpn3ak1brrkGfuo1n4gj2crKlK5r9ZQGMK7LSTwXTs9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyJekWYEGSVR8ybrBeB+a+VGDTmM0usM82nAiaLmYC36hNyyIN
	6Cp6Zq81JaSEWpSLCl9J7mivCyJJ0RrfLGmcOUWFy4SwNlQQHrY5jZRQIpp8QnY=
X-Google-Smtp-Source: AGHT+IECxz/qb6Vkma2IUS75Cre/bsH2ReQknO4hqXXTWChfooNaf/Zhku94vdEvgJjNzUn4a2iYPw==
X-Received: by 2002:a2e:b8d1:0:b0:2f6:1d9e:adfa with SMTP id 38308e7fff4ca-2f61e056430mr21468051fa.19.1725038579557;
        Fri, 30 Aug 2024 10:22:59 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f614f379b0sm7692581fa.55.2024.08.30.10.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 10:22:59 -0700 (PDT)
Date: Fri, 30 Aug 2024 20:22:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, quic_abhinavk@quicinc.com, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, quic_ebharadw@quicinc.com, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Rob Clark <robdclark@chromium.org>
Subject: Re: [PATCH 13/21] drm/msm/dpu: Require modeset if clone mode status
 changes
Message-ID: <at6ejhvsqu5r3zdmsd22vtwagyogdb33cazutkkz5xayxsyebn@zravwdqovgaf>
References: <20240829-concurrent-wb-v1-0-502b16ae2ebb@quicinc.com>
 <20240829-concurrent-wb-v1-13-502b16ae2ebb@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829-concurrent-wb-v1-13-502b16ae2ebb@quicinc.com>

On Thu, Aug 29, 2024 at 01:48:34PM GMT, Jessica Zhang wrote:
> If the clone mode enabled status is changing, a modeset needs to happen
> so that the resources can be reassigned
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index 1b0cc899e8c1..99eaaca405a4 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -1306,6 +1306,8 @@ static int dpu_crtc_atomic_check(struct drm_crtc *crtc,
>  	int rc = 0;
>  
>  	bool needs_dirtyfb = dpu_crtc_needs_dirtyfb(crtc_state);
> +	bool clone_mode_requested = drm_crtc_in_clone_mode(crtc->state);

No, use old CRTC state from drm_atomic_state.

> +	bool clone_mode_enabled = drm_crtc_in_clone_mode(crtc_state);
>  
>  	/* there might be cases where encoder needs a modeset too */
>  	drm_for_each_encoder_mask(drm_enc, crtc->dev, crtc_state->encoder_mask) {
> @@ -1313,6 +1315,10 @@ static int dpu_crtc_atomic_check(struct drm_crtc *crtc,
>  			crtc_state->mode_changed = true;
>  	}
>  
> +	if ((clone_mode_requested && !clone_mode_enabled) ||
> +			(!clone_mode_requested && clone_mode_enabled))

PLease align to opening bracket. Drop extra brackets.

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

