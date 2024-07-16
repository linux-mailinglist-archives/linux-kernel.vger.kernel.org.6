Return-Path: <linux-kernel+bounces-254088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D899F932EA2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70BCDB224F1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 16:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F55C19F46C;
	Tue, 16 Jul 2024 16:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xngenokp"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D141DFD1
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 16:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721148567; cv=none; b=A5AFW/+hAUg5bAIK1Wx9hfOMFpN/nXyaapk83XyM+BR/fnfCJ2thnmIbOoyxmCtbeSMKr995QiarlWJcicSnC+4Csluz+0std1tzTUvt7nDNXXc/g4Bvrixh/xQEfG/Jkc390ZRNB0lsug4hqdBkk9GBLX4CLTPaopx6CkyVCMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721148567; c=relaxed/simple;
	bh=6zMWW5YrvqqRzGvqRpwyn/zq+H6xS/JVh78xonM0Y7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lS1Q/bGUJBQoqFHM/Ziq8TRIeB2L+hvwwZoe1U+Kh+Y72Ma+lkYKW3p5rO9rtmfAJqqqE1KsDaF4U3F7Z/AoHr0h+17E5kKxjVRd8HK0SUHkM6o63KeF4LZeC9kK5W0r83gfn3ZDWrgYpRThRidgTO3kOKLpRtLJCRTva7L2+Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xngenokp; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2eeb1ba040aso76963901fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 09:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721148563; x=1721753363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=65UHivhWbqamlbWLtwDGoTnNBO4Z+XQXbLxohA6X8UI=;
        b=XngenokppmSl+w6OKH41ckWDBtnzWoPRZV1XbLpNAH70zhnG6XTzvxwyffHtBLbh4g
         3m1YIOTnfa4sD8t5hn6VKkUP4wGpMtmFP4Z5U12JaHGwoCJuEen9DQMv4l3weoEu7Whj
         19v1KMMq6pkrJGvxXRQF2VeO4GC/GobyRmv5XrrgzLcWJRI4za7MHbVC0SL0VZQUmKtP
         pnFhsLGNJrFQGrZK+XWasEioMC3MW33PeCmJvn7qEQGy0tACc/4tkwXu8MRV0xTbDdpo
         lEY7furiel19E+kZNcASbjzXBZlIJxPFesMlAfTLx1xYZWq28MVd2xX+cD77+1jPrbX3
         LsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721148563; x=1721753363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65UHivhWbqamlbWLtwDGoTnNBO4Z+XQXbLxohA6X8UI=;
        b=OsUwcdWww1F2PNcR1g1rFBzAteTs44bSyqZ6+XD3zh1MlJC9fJnpSr54rEFSa3WxP5
         K0BeWINur7M72M26RYfe8pqP/qnqZoreyImdwDA0sN3Odh84wSPgdbvPX2wuwBqmgWHK
         V3gMMcGwUu3LBfGZV8X03sigMI2UxNNv41MJMV3LiHa1X2GT4lQI+gLq/GVCE4u2Ldx3
         ivHQSaD78VT5p/kN9J36n1n9M8/jwDAWhstsSFInnMT0c60Y3/B0y5PmUEMkBwwSOPjv
         iyJpLG8fJM0IzGL/UCikuEP4fi/rjfeytSv+DDX6hdHrVUrqAvotXalMtKmoriZF8Pwd
         dmwg==
X-Forwarded-Encrypted: i=1; AJvYcCWVY6gEVZTkr0MJnPUQ31a0rnAfLYzPa9Q2dxlLEZXykQp22JTb1LqvYE1rG0V7tu0+eE4mrU6vj7XCUaJfLRRNGzgIyOOXq05+6yrY
X-Gm-Message-State: AOJu0Yxg8Hp7/BmuITKmx7ZuzVkxwFvxz6yTHG20TxXCE9I6gOONn5ax
	fjfGvg8W9sEIBkpR6DjqBd6AGHW5GyB7D4db0Uk6IfjT7ASviQm4Au0rmNy+3/E=
X-Google-Smtp-Source: AGHT+IFISfVY1DZpBjx4Wp3ciQ7fxNNvKnRXnv4p72o9tKeFET0doI963w/f62exGm7NboBWy2kYvQ==
X-Received: by 2002:a05:6512:12ce:b0:52e:999b:7c01 with SMTP id 2adb3069b0e04-52edf02b9a6mr2138832e87.48.1721148562872;
        Tue, 16 Jul 2024 09:49:22 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ed24f3b9bsm1179441e87.107.2024.07.16.09.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 09:49:21 -0700 (PDT)
Date: Tue, 16 Jul 2024 19:49:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/msm/adreno: Fix error return if missing firmware-name
Message-ID: <ewrp4snurz4vvo5f5hdipzrndeij35j4h77bybkti2yiexk2gl@utuf7u5g3f4k>
References: <20240716160631.386713-1-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716160631.386713-1-robdclark@gmail.com>

On Tue, Jul 16, 2024 at 09:06:30AM GMT, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> -ENODEV is used to signify that there is no zap shader for the platform,
> and the CPU can directly take the GPU out of secure mode.  We want to
> use this return code when there is no zap-shader node.  But not when
> there is, but without a firmware-name property.  This case we want to
> treat as-if the needed fw is not found.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

