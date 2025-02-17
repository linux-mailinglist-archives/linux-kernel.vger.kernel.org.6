Return-Path: <linux-kernel+bounces-518240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FBAA38C12
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83DB43B288F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B01E236A74;
	Mon, 17 Feb 2025 19:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X6rpn9R4"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D393F22B8BC
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 19:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739819273; cv=none; b=OsmuN583xeWED4zwdD1mSmZpZARDxAkXI/WD7Pz4gV2DcN/uj827MHxGbsZOFdW+NYV8F5YC3nDJ26p7H6JeGqxcugI8403aahCFAtMmxjjzAaOaQWpHjSbuJd+YEpFG1/EY+GwehZiyO5Cme5f0M+MdBBx0fpWnqQaJk6qvbN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739819273; c=relaxed/simple;
	bh=wDoCAtbEmJJG08E/A5bz+I3lGd68ANOK5k7c8qV1X0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=la+cOMi9WuhPafgKB+ayk7hXPrjLmKUF1KRiXJaw6SVnDBgMY7Q3y9FTr1Gc7b7fkLITwDdSRfK5lqixeKIzhv/s8qan6ziNJEYZLs4i9o/IYyCMVjZD8vUR2z9qeJJG+SSQoBTDzZH4WmiVM9/+OIB+DapThVqfFMrZkkHvC4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X6rpn9R4; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30738a717ffso41663941fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739819270; x=1740424070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ObUne2yQMezeKiKaLoIvFCZpEHW3DUQ78CPgFXgb8A=;
        b=X6rpn9R49Vjpq0jaVvzteTRrIWYheZIL/LVbS2UfB9zQ8pi8rDFoC6JSqktjY+IFp4
         Luy71uKLqapYzFcqzFK0q7B+bxis4X4hyiWXPkcIfsflB3umIUnlU23i51mFiFRtI5vC
         pg8b17ivlV5CuxArz7DHTg+TSYdp/NXGCqvhB2gIJEmyFxVGRNHvJihkT1pDWpS8xYTq
         EuzkXE89kusFktslV+Sl04CPAgLmKxiKTq+Kbf9JYUjsWERTgQnJmoUgc8RVr1MoVX5X
         maqDs5+jjBI0BeFXL3QRG4ox1McyvqV2oryOh9ElOorijK7UOs+XSBQi0X8QeYUXbmRo
         ZnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739819270; x=1740424070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ObUne2yQMezeKiKaLoIvFCZpEHW3DUQ78CPgFXgb8A=;
        b=YdM4iC2ILRCQzP3Zod+F9HOqBKMYvb48oprhnNUG3sWqRojbp7y8nCgjSgF32eF/vi
         A65FdKiL+KRbZ4OC+AF4gU0mc3Sqf4bujyCj5F9dYc/e94GXYUlgLH095XgamFK9AX7H
         3YesT7+i+6BZpJh1usFO/98xZ6/jfEO4JAGzdp1j7p0ivRG6xbYoOpZtKHpo3Y61Tfmj
         h9xh2+hekln9TBmm8mUfptJR+CdJj83D8r9TOO9xd5xWc4Ee62I5Fxp0InbQ4Gg6Yt15
         01PL7Mr3M+rOELAZMfrWJUJXux3OQXIaUUIdvPfoEa13zPVWdZ+582LxCr1XdZKxIw2F
         wmnw==
X-Forwarded-Encrypted: i=1; AJvYcCXK4/YOmoKKz53Yrj6ACewhaLoS00Zpou+rmyy/KMf0WRFxViewaQ7Kmum50qAChCWp6ObW146E6izhqfM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws8NyuxBSjQAVxtadiuLycGQBIf/xkvZfnGhGXJMJMv3Smp9Nt
	DF6efIjs5mK3zEFP22MRmBVD/bJwzmcwOv+RtbPWBSU+c7vrDq7mN1BDotqiKe0=
X-Gm-Gg: ASbGncs4LBiSZ0tUg1NUDA7gK/4SDvYyf8mg+YWOAiJsZGLffCcr7lyaqhvnWSnPs3+
	pCrYTHGNWll7nqOESw+rsOFhzB5t85j+Yt2J6+tUquIzPlXBQ/O+x6rxXPXKxnGFdaVIijcXscf
	hMI9IUIsgdS1IE+AlAvL9ItBnR5aSNvsCCDwRMKVuEWpEpLwOzeN7LAmK4Mp1fuiAosdwXRJQzY
	Jua3K/HitDtdUGGebkSnsXDDMXdwAiil9d83RcjTayeXYionbE+ei9OVWeTC7hnh9AybJL1wlFt
	UjVasi6bFWreF0F20kvyRI1MJY+L5aaVYy23MIGD+YFNyIvu62456lhXPzp84ZOYRxI8thY=
X-Google-Smtp-Source: AGHT+IG9DynPxWNwdOmU6ii3AvcgWu++/3DPvh1LUYd7jp9CBTvIMdEBiRwbV324OAhQ4qab/et7NQ==
X-Received: by 2002:a05:6512:308b:b0:545:25c6:d6f5 with SMTP id 2adb3069b0e04-5452fe96673mr2812097e87.53.1739819269896;
        Mon, 17 Feb 2025 11:07:49 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5461ee8341fsm612141e87.133.2025.02.17.11.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 11:07:48 -0800 (PST)
Date: Mon, 17 Feb 2025 21:07:46 +0200
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
	Srini Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 13/16] drm/msm/dpu: Add support for SM8750
Message-ID: <qfbynkd3d5uqlzcgvcsfoi3muoij4ap3kkkwug5yd3ggxbhiic@6epod27ux5ai>
References: <20250217-b4-sm8750-display-v2-0-d201dcdda6a4@linaro.org>
 <20250217-b4-sm8750-display-v2-13-d201dcdda6a4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217-b4-sm8750-display-v2-13-d201dcdda6a4@linaro.org>

On Mon, Feb 17, 2025 at 05:41:34PM +0100, Krzysztof Kozlowski wrote:
> Add DPU version v12.0 support for the Qualcomm SM8750 platform.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v2:
> 1. Add CDM
> ---
>  .../drm/msm/disp/dpu1/catalog/dpu_12_0_sm8750.h    | 496 +++++++++++++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |  29 ++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   1 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   1 +
>  4 files changed, 527 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

