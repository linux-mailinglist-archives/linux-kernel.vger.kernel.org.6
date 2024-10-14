Return-Path: <linux-kernel+bounces-363025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E9299BCE8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 02:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 303C62815A8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 00:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19034A1C;
	Mon, 14 Oct 2024 00:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BhtFMgb7"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E5A139B
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 00:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728865227; cv=none; b=ISQKmdvUukkcAFNMM27cd11+LJo62fm6QVuLghNasDVXajigA+w3Bo3AUTf1Cbo0k4UkrLfushrCvgFQk8NAi5wT+wn0nkByctAqAhkibIxkWCFhn+BkQSMJnJVcohibyu7Nd2WgIX8yNneLo6bYfeKD4D9BTOYQgQ8QGIZGlVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728865227; c=relaxed/simple;
	bh=TSWE3+hHTSQYkf7R4SSBSmq3Z/rmGPfVFVt5BBlpWlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoorfTIMUoPdjgUUY6ilbSlXroBHTAWc4O9lvuAhaTraspHdGZwI0YOrszFTxXMferW3IeTCgp/z8tF6vvz7nXEOgcPDUgV9+jWYwh7ShR+mWcxF3y4k2ud1uqnpCJzbUYWTsrd6qpwSn3l8oDavhvE9hTSwr3S/COs5ef/MGeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BhtFMgb7; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb4ec17f5cso3271641fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 17:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728865223; x=1729470023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=swd9SOpmUHVcicvma+OufGb4RDFxiOnKh6x1UILpxe0=;
        b=BhtFMgb7puk4b8eKNa7n2JCYTGUuFQVdK7kc3yXbTCnMJ1TFLn90HdzPBTyqDmTbEO
         Jl9rdp159b3g0Lw9bzAexCc8dRtM7W7EFlQlrj1ruJxUEnnXIkNmjU4w9MaRPG0/k1RY
         6qPfmeAB0MTMYxRXWt/BoVxUYho/Be/24moZQ06mlpAc9ECk8A6jdsgQvALazCFqTaL+
         K1+qu40YoLd/51Huc1HewB3PnUSIV514791rAOdW96EXosi223BljIIUH3rHMfGR6Qv6
         tvhHB3ffXeBEjXmnhH+cTO0KowpVYfp3vxDxV6pS5drJq0s1gZpuNgQ/fGQHVBINX1E4
         t3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728865223; x=1729470023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swd9SOpmUHVcicvma+OufGb4RDFxiOnKh6x1UILpxe0=;
        b=T21sdbGRJHtv4c6m3WKXWSv2PWrrxn7X7SReovWMUniFAJZjJ7q3zQRAd8wGEzOcP6
         isOrlZY4hkqAKduMeo8bEpN+vlPZPGlscA86ZqgwSdncmdnP6qKMgUkGPcH2qQXy9OIO
         JdwjkN4TlLku0ZgSxOLzdCf8VPkPP48bES/kpW7c44bjWvtqa238122LO2aXwbs/EJaF
         6x1NXfkCNAjy3JcSyfneMKs3T3NEFUu0DOpKhpeZb4Dn7Fk6G01UXT02JXFkB9z6q7ER
         CJ+k5eQf0cC1pmQVH+xRh+M/3EtCuxpZmWJYNwpm4sg2j3G1FEuCpfr+aH0FDiteY844
         fmfg==
X-Forwarded-Encrypted: i=1; AJvYcCXs+rxxPwTOh3PrTAsrzLXaqgj8o55zyyr3H3NZydk0zvlgBMzlqB+vhqUipCVTMTddFFdplD4lGJC5P90=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNczEjnRK5+h9aVEmWbXOgOLKrrtVnwIvI7J0vyKclMeAJGOKl
	P0s93XXySIIuTMgIDMbp70M+bjawhx+a4OnyIOYwPpfoOcgUcEcfkHugBBGm5LI=
X-Google-Smtp-Source: AGHT+IGjRsmqSYQFY+6zoTW+yfBoQhD0tYy9X1EZBeZeH5UdHQqVss0BDD8UraLZ7HffqL/AYWBRQQ==
X-Received: by 2002:a2e:4e01:0:b0:2fb:5035:11e6 with SMTP id 38308e7fff4ca-2fb50351533mr4455441fa.36.1728865223272;
        Sun, 13 Oct 2024 17:20:23 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb48a13d11sm4121121fa.53.2024.10.13.17.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 17:20:21 -0700 (PDT)
Date: Mon, 14 Oct 2024 03:20:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, quic_abhinavk@quicinc.com, Rob Clark <robdclark@chromium.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/msm/dpu: don't always activate merge_3d block
Message-ID: <kah73euzauizsxvcrgmfsatshfe4pytgb7xe5iprtajg7abhsv@l7jdcxza5gd2>
References: <20241011-merge3d-fix-v2-1-2082470f573c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011-merge3d-fix-v2-1-2082470f573c@quicinc.com>

On Fri, Oct 11, 2024 at 10:25:13AM -0700, Jessica Zhang wrote:
> Only enable the merge_3d block for the video phys encoder when the 3d
> blend mode is not *_NONE since there is no need to activate the merge_3d
> block for cases where merge_3d is not needed.
> 
> Fixes: 3e79527a33a8 ("drm/msm/dpu: enable merge_3d support on sm8150/sm8250")
> Suggested-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
> Changes in v2:
> - Added more detailed commit message
> - Link to v1: https://lore.kernel.org/r/20241009-merge3d-fix-v1-1-0d0b6f5c244e@quicinc.com
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

LGTM now. Please clarify, is there any dependency between this patch and
[1]

[1] https://lore.kernel.org/dri-devel/20241009-mode3d-fix-v1-1-c0258354fadc@quicinc.com/

> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> index ba8878d21cf0e1945a393cca806cb64f03b16640..c5e27eeaff0423a69fad98122ffef7e041fbc68e 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> @@ -302,7 +302,7 @@ static void dpu_encoder_phys_vid_setup_timing_engine(
>  	intf_cfg.stream_sel = 0; /* Don't care value for video mode */
>  	intf_cfg.mode_3d = dpu_encoder_helper_get_3d_blend_mode(phys_enc);
>  	intf_cfg.dsc = dpu_encoder_helper_get_dsc(phys_enc);
> -	if (phys_enc->hw_pp->merge_3d)
> +	if (intf_cfg.mode_3d && phys_enc->hw_pp->merge_3d)
>  		intf_cfg.merge_3d = phys_enc->hw_pp->merge_3d->idx;
>  
>  	spin_lock_irqsave(phys_enc->enc_spinlock, lock_flags);
> 
> ---
> base-commit: a20a91fb1bfac5d05ec5bcf9afe0c9363f6c8c93
> change-id: 20240828-merge3d-fix-1a8d005e3277
> 
> Best regards,
> -- 
> Jessica Zhang <quic_jesszhan@quicinc.com>
> 

-- 
With best wishes
Dmitry

