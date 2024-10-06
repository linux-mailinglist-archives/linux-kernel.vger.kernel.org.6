Return-Path: <linux-kernel+bounces-352490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5636C991FF4
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 19:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFF4D1F216F2
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 17:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C772189BB5;
	Sun,  6 Oct 2024 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="haap6yJs"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3082B18991B
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 17:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728235966; cv=none; b=VLKUn7/tn0CJekISfwQZTVlBqUgNgdHnQMlsjugNwaTObi/pG6bnuj0DMisoxXJIyBWA8fuC6Av3/7G4lESPxsazmdf4ClVX108ER8a+8MKxV/BYA1LfpTOQ8H4jKtUthb7PIW9t61qzyOtf8Ls5VyOiBMCsMZXRwEpc3rfwxfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728235966; c=relaxed/simple;
	bh=T+OrIT0ckx+4DsjdviywOmAPZD7YtHtfPLpn0Xt2Na4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHYAHm9d7hs6yVekx4BlUOVHbD4fGHE5qKCexfFsCsj57SziQBao/pWEWVYhVB7j66/Y65QzWaxbXtcydIvQsqfXMFYAu67rP9mbc3Jo1tSPNXWk//l1bT+sOf4TusPZMKETFAHpb9lYPWPJR3TiDOnKYHd1iLXk83P4lrNeSQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=haap6yJs; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fac787f39fso38155071fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 10:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728235962; x=1728840762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r1NxQI5QV4DE8+i0IvHuqmyv/ESZiy42eqq5jBNAK5E=;
        b=haap6yJs8TclABnAKqNmMXSKnbz3mQaP+h/1Ibw+khZ//8D9Ilw6R6PlNbl0USamS7
         GYPkbLGCPMDt6YV1LVBAtAir8mQ1KlXljVM5ZKblfBuihry+eXg8VBf/+WlLLDJHgIeA
         AokhB/G/mE+huaD38lvkMIWWn4L+V/pEYU5AGyTHR7juO08MXngJu5lBo2vFdLCC7dOa
         7+9vqfp01ysaKVXYOJAYTbu4uRw5OfwgnCiCoBFGVWONUCoZc+KSz6OhxLskyGYIcjB0
         pYX4hCdNmj+QXCXpOc/Of7xHZy87RKBN4aI+9BJqH2/PRkc49SVdFdjdlPRkifQJBTiR
         uNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728235962; x=1728840762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r1NxQI5QV4DE8+i0IvHuqmyv/ESZiy42eqq5jBNAK5E=;
        b=NyuHriHnAqvlqBAD/qSNb8vlL22GYzBx0AhHHGuRXsNs3AN9lJua2wvjYdllQJMAwU
         BQ1ThY1z4zCdzrcUONpyIGwP7PnxhuyBvGXa8dVCDzl7idc86iqgV28bT4bgp/VOHYeF
         2H0P7m/WvmNnzoBd7xAxxbL/1HFFl13hurS8in0sIMZSZjOFZM8KcjzmoBi8aPxn8Gf/
         X8DKuA+ZAYSWQAJIW5rVNEKDfjeCrwvOT0OGscURv003765BNcOQP7M/niKw4o8o87S/
         JaIAf2jsVGGnnI73DSVyzC9mt8uLcdwON7C6zujZYjti9pGVFdCxi3LUSQObZasv6LOT
         D8Bg==
X-Forwarded-Encrypted: i=1; AJvYcCX+5Bsxs2q5WleUWRuszn8WoKHCP9Jo6+6IZQjHJcLR7gma34L/6XdwkbEYn1MbDuLBpsyc3IWuL2pQKVM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3RVxQNKVc+wWBkuWSHiEFruuF+SwEGXojkdTz8Z6o5cWZJfT/
	g/A+YIFS6Mk0eNBQE/AGno6LtqiohbTC41/8MG+tV/S1ywtAvwuZ+PU9vJqlIRM=
X-Google-Smtp-Source: AGHT+IG+QwZQ4OCtQHyqoK1+CJ+GHxPI8u5RieuMZEEdbaGmBdONOTKZQW0bvOywQEuMFL4+NafBXw==
X-Received: by 2002:a05:651c:544:b0:2fa:e658:27a1 with SMTP id 38308e7fff4ca-2faf3c141aamr41730371fa.5.1728235962235;
        Sun, 06 Oct 2024 10:32:42 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00-89ea-67f6-92cd-b49.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:89ea:67f6:92cd:b49])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2faf9b339b0sm5524611fa.124.2024.10.06.10.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 10:32:40 -0700 (PDT)
Date: Sun, 6 Oct 2024 20:32:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jonathan Marek <jonathan@marek.ca>
Cc: freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, 
	"open list:DRM DRIVER for Qualcomm display hardware" <linux-arm-msm@vger.kernel.org>, 
	"open list:DRM DRIVER for Qualcomm display hardware" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] drm/msm/dsi: fix 32-bit signed integer extension in
 pclk_rate calculation
Message-ID: <mk5mrypbeeuzhcmqimck42gnykjwj3yz6ua4npkxymrvho6z7i@dvvrxsafqcxj>
References: <20241005143818.2036-1-jonathan@marek.ca>
 <20241005143818.2036-2-jonathan@marek.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241005143818.2036-2-jonathan@marek.ca>

On Sat, Oct 05, 2024 at 10:38:10AM GMT, Jonathan Marek wrote:
> When (mode->clock * 1000) is larger than (1<<31), int to unsigned long
> conversion will sign extend the int to 64 bits and the pclk_rate value
> will be incorrect.
> 
> Fix this by making the result of the multiplication unsigned.
> 
> Note that above (1<<32) would still be broken and require more changes, but
> its unlikely anyone will need that anytime soon.
> 

Fixes?

> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 1205aa398e445..a98d24b7cb00b 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -550,7 +550,7 @@ static unsigned long dsi_get_pclk_rate(const struct drm_display_mode *mode,
>  {
>  	unsigned long pclk_rate;
>  
> -	pclk_rate = mode->clock * 1000;
> +	pclk_rate = mode->clock * 1000u;
>  
>  	if (dsc)
>  		pclk_rate = dsi_adjust_pclk_for_compression(mode, dsc);
> -- 
> 2.45.1
> 

-- 
With best wishes
Dmitry

