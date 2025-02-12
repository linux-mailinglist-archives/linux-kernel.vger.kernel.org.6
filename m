Return-Path: <linux-kernel+bounces-510237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA5AA31A25
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 01:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A86F3A7B29
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B498823A6;
	Wed, 12 Feb 2025 00:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="phcgS0Tn"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EF8360
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 00:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739318851; cv=none; b=KOeLxB2//bbv6v0rSkR2P7/gIqggouo3/uvDtybmFYf5dHpRlj4O6TcN0X0JWH+yFR2qVatkPqQNeg2xeRPSt4kSAcaRaTYke8410+QnujgCoagXF/Ai5m2KM7+6cdXvPzowhcYn0upm/oG0YmTMs3XLKffQ8pVRjVKFijT7TUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739318851; c=relaxed/simple;
	bh=VWebKF0DiemAQq9Im6QLCJUBLm+i3WVGnbbbpbF+uyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpGU5RgjCpSOu2jhowTw6wxUVRwxckdwcm6o0bPFBy4Mg/36pMk4Q7ZpUbZvUQt9fX/Ie5TsMHdmdCGEx4nStK1g/NuMyVKyvnlESv1sL0+OI+82lLIZKpmghs2ad+6GXJLWEODB/SD9OKng3mB7gw/x7vz7KbjWOQRKqCsmg8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=phcgS0Tn; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5450b91da41so2618421e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 16:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739318847; x=1739923647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rSvVq0Q4byuw3K4FZfEe4v2n2HhjFTVAI/WWeumGLwM=;
        b=phcgS0Tncg8ycUqMgcRckbRcisrRPk8uIse4zhkKsL39M1KkIZ303ofg5JKkuQzN5N
         BGCRV0S8OPy35D5UJORU2r/KqJ+KJL0OMGRscIP4HMWF/NScdkxpWlp2RlrgxIGIuPCL
         gfYuAVRxIWP0G3rgvnVv8n9D/lnzLszeREiMBc+wGrqZ4oN6zU7J4rZeVWP44gAsXj5w
         6cjACuPN04CIQBvgeBgXp1dsFlLvr/A3kt+zDNS0Le07xd0xGMUCzeqht3vioV+5xOqu
         87CBkkFFfHgqpydiuWasYdhFShaq4mH6trchJ4eRLrCZKH2JAtsRrxY3VWATjri13Spl
         U0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739318847; x=1739923647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSvVq0Q4byuw3K4FZfEe4v2n2HhjFTVAI/WWeumGLwM=;
        b=XxBUsJdB1W+XBGQOuumXnSSPDSa6I6AR+sKNb8K4OjwhwOzfo/KEbxXC7bmaqsc162
         3LSVaVUYGFTuspO+ayUECveKhbPoVcbfwwFu/uI3qeDKzRJe1a66y1jQcyMXfQLo20Ug
         3udXISqfhkwB/ygJ+PQCoruJP8mIG/g/t6uBqcJG/ox2o4HcV3NCeFIqA2zN38g053Yu
         f0+wmRxxZ7MAbprSA6pTCSaneZZNrhzwrnPEAAcrEWhRK1cqSetRau/6sSOyDennFcwz
         11oz0sF2lxYkV3oL94+9evU5wahYV9T4KHZg+2CAjO6tfbQlOsHI2HfMDW4E1aCyoxTt
         NoxA==
X-Forwarded-Encrypted: i=1; AJvYcCWecnI0P+NuQSZ9iEeR6qG61Oc2bUXJA0bKSsIdkzI/fuI9s0HMqQ4nISlJhNKrH6lK0VJbYDlFk/3CgSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRsmH2g5muLsSvTOxVEjg2DyxKPWyDCQlJUnquEhop0gVwm4Mh
	NBuOVyjGubOnA6baa6k6jIdXq9+rZoqoSJdO5f6aM7EKQxrfZPceI6/lvlrHSHA=
X-Gm-Gg: ASbGncug71elVezPK2keDoMnfEU7DpYBb39yTZDMLQov1LxcOSa0a4eWVgUvqLox5LB
	X/9Ifgpc6LNqdVvgDWr6PDuJ4EyFCvpibBjvXyhI1V+VhPfoFxFW+EfgAcX9gOLE0F6Gj5xj6KZ
	zuDXdsXO5DAIA6Uf8+jESPzSEfLmw76bItlgYRRL7/Tch0GITZdY4FeCe/thGqWdJsKmaDziMBg
	w7BB/3AL/P7pqfVAZ+7RgEmDE2NjyBnzpL4Rifzj+otb7OMV1E29jdJm32AJS/8+nosfobXYFQe
	MyzK7Wj4WvrCtZc637OiaSeU/yFE9W602qLbwdiycXOsmihGkJ/LxwsHzxP+WhuI2HvyqRk=
X-Google-Smtp-Source: AGHT+IEYSYjM6e26W3BebaqVj9AEp0qCBuSkwbasndm6u40vD94b8fZ5bLT2RmF5vB9zoS1z8G6pdw==
X-Received: by 2002:a05:6512:745:b0:545:c08:e193 with SMTP id 2adb3069b0e04-5451810fe44mr196032e87.27.1739318847359;
        Tue, 11 Feb 2025 16:07:27 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5450bb646a5sm808177e87.146.2025.02.11.16.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 16:07:26 -0800 (PST)
Date: Wed, 12 Feb 2025 02:07:23 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongxing Mou <quic_yongmou@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: Allocate the number of LMs based on
 max_mixer_width to support 4 streams MST case
Message-ID: <zri44j6baegrcxmnac3o7ujtrlm2ybhon4hq3ondvdbcqfhpa2@zjxcprel7zv7>
References: <20250211-dp_lm-v1-1-deeca9ac9bd9@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211-dp_lm-v1-1-deeca9ac9bd9@quicinc.com>

On Tue, Feb 11, 2025 at 06:37:43PM +0800, Yongxing Mou wrote:
> In 2x2 mst case, each 2k monitor will use 2 lms, but dpu_8_4 only have
> 6 lms, so let 2k only use one lm to support such case.

DisplayPort MST is not supported. Please work with Abhinav to get it
into his patch. Also it's LM and LMs.

> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>

This list of SoBs doesn't make sense.

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 5172ab4dea995a154cd88d05c3842d7425fc34ce..e8846bf8edc5f9b2b3b7f093e4d5aad75de53da1 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -677,7 +677,8 @@ static struct msm_display_topology dpu_encoder_get_topology(
>  	else if (!dpu_kms->catalog->caps->has_3d_merge)
>  		topology.num_lm = 1;
>  	else
> -		topology.num_lm = (mode->hdisplay > MAX_HDISPLAY_SPLIT) ? 2 : 1;
> +		topology.num_lm = (mode->hdisplay > dpu_kms->catalog->caps->max_mixer_width) ?
> +				   2 : 1;

Please extend commit message to describe how your change affects other
platforms.

>  
>  	if (crtc_state->ctm)
>  		topology.num_dspp = topology.num_lm;
> 
> ---
> base-commit: df5d6180169ae06a2eac57e33b077ad6f6252440
> change-id: 20250211-dp_lm-8f8ef15f5955
> 
> Best regards,
> -- 
> Yongxing Mou <quic_yongmou@quicinc.com>
> 

-- 
With best wishes
Dmitry

