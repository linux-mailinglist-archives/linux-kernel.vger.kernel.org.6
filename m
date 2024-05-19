Return-Path: <linux-kernel+bounces-183072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3908C9428
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 11:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A29D2816F6
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 09:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07502BAF1;
	Sun, 19 May 2024 09:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RlXQ9+tN"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED2322089
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 09:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716109295; cv=none; b=tfQ3pNMclrT8VQVO8ihLh5E9d5DTYvm2gQJ8bQcGHRD5pw1jE8b4IoxiL7AM3vGWwTSPxKY91z61nUrN/olLwVARL3aG7hhvA47VP5RFlq9WZ4VZa4BiJ9ZkazCjIMp9ZaD8Oz5QsfoWF0HaloYrXkBukJvZdgDNML50dUkD8Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716109295; c=relaxed/simple;
	bh=J9hb1EieOotdwy6le5SRNSVIHsPXMfQxPpMua98WyyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DitqSXjSovdKlNgbQ5WLSzlTVVNkTHPy6f2mAsd3ypxZaqatwSoEnbmGsi8LPCN17Jv2KIGCYHKHgcTdJp/Equm8+Sy/IwGNT8jAsoQxQdehTO2R1us69RtlcGwf1yzlacg3MwHdOOacBwIk+An9P5pFAcarHm/+ddzpv3IfcW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RlXQ9+tN; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5238b5c07efso2193985e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 02:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716109291; x=1716714091; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6YSot/x5cFZB8ewE8eTJgK6YVMXZ1880kiMw+EZFqIk=;
        b=RlXQ9+tNX1a9f4udPndiHg1o1P0B5tnuNgjR0hNhBQPHtTbyX2UI/BYBGZntY7V0Hh
         NzobHhAznrhaE+EJJc3KOjf0S3blrWkbxqQf1b2Uf7vzKvrEOoG2UjMr+XOIcdfG21SK
         cANkdE3SWC8eK6JG6vfdhz4soGpP0xgF8BX3jRl3wcvbvlEY71gAuY+F/WRczxwcB3WW
         r/N1RDx29pxo1A514VxrxNzknNC+3vm5G3igzsqFiDfmOmFawOucOq21LMYjOpcxbPmf
         KJ3fCTgKhaL9+CP8jxcwrB/CvypXtZhPM/KjiT9S2JH/wEaU1x4FmeJV04gKtaRSNQNJ
         GHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716109291; x=1716714091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YSot/x5cFZB8ewE8eTJgK6YVMXZ1880kiMw+EZFqIk=;
        b=WYV21PbN6IIB/8ZtJyfOdxmMUk78md53DReroTSURGSByGNCLxboO9GsrDU5vYY2Sq
         Xuz+laRdjXOp2NXqtInQq9hkwtPynYOFua9ZIrsYKkk+gxq2Jox5afcrA6E2PA+QG7Qk
         TMz94iC8vc3ka578mU0t24IZwTNLKOFWqKmcq4RtKUsq/+lqGBqkdomUT/YKLTYVuzQx
         H5lbHVIJdM8CA6zqfJAdiwQbEsWZX91ItCNRiVsw2GW6IDF/PyHbe9ubT9h+iS275nLi
         VOzuHotfSnnMei8OQIbGUo0WjRSS4O0YnTrbzUe86kPXPU7ribnZY7BHJ8KSLj2J9+we
         /vYw==
X-Forwarded-Encrypted: i=1; AJvYcCUeYK7oO1u5ajgYjaFwuiW/wrlwD3gnJdmtpCRdiGAQdEqrvR2sZ3Fb3wQ6znJJ0qnUpiCijbUneAdSZjWfc54VMwNMyqAb/+B/qk6g
X-Gm-Message-State: AOJu0Yx4BYAQ6r6v5PSLpk+Kr3fnZIyTX+J6MqF0RIB1s4UR58Y3IP0y
	L4ETJTwYtJ0go5pC06YNeQI76AHbu/pa6umjFeoJ8RT1TB2ez/VERzlxkbD1uE0=
X-Google-Smtp-Source: AGHT+IHo2lG2QfN3wSHOdCTPeob4sZG4UUob2G1FAI+cUqka9doJg1KkF/LYr2/BlXVeJ+LSz1LbtQ==
X-Received: by 2002:a05:6512:131d:b0:523:6354:881e with SMTP id 2adb3069b0e04-523635488aemr12970576e87.39.1716109291007;
        Sun, 19 May 2024 02:01:31 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f35ad584sm3859393e87.21.2024.05.19.02.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 02:01:30 -0700 (PDT)
Date: Sun, 19 May 2024 12:01:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>, 
	Nikita Travkin <nikita@trvn.ru>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Andersson <quic_bjorande@quicinc.com>, 
	Connor Abbott <cwabbott0@gmail.com>, Ruan Jinjie <ruanjinjie@huawei.com>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/msm/adreno: Check for zap node availability
Message-ID: <zqncrzat2adqwdbvtjzrropwvfmhplmhv72mzv2nbhbgg54byk@wbpgofmqpjtn>
References: <20240517195021.8873-1-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517195021.8873-1-robdclark@gmail.com>

On Fri, May 17, 2024 at 12:50:19PM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> This should allow disabling the zap node via an overlay, for slbounce.
> 
> Suggested-by: Nikita Travkin <nikita@trvn.ru>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

