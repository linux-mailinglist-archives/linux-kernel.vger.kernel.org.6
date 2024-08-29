Return-Path: <linux-kernel+bounces-306591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC549640E8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C2032845C3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5259318E020;
	Thu, 29 Aug 2024 10:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vzb61wKO"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08BB18CBE5
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 10:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926023; cv=none; b=s2gI6PuJiqdDfL3JO5Bcry5TYXbLZhqsEjifMpzmP6NkUNEIQQBTUxiCJuj4tQs8zRCBVt3DKp/3u35Yp7kmTTjiKyVw1J0fn+prRmXOp67yPIRJZLwW6qUuftweiAZehVaeQmSFH0AI59wZhAQskAPWR4lreOVPQ4IeeioDxnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926023; c=relaxed/simple;
	bh=ZuoDD44tNeycvKn5O9iVYZj0plCcUDqFpueY5KbJbX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=at9YYPUbFMq91Wc946ixXF5c9BtZ8/OrvYeTRupHYgw3TJdvrESjLOOL8G429jiiUSVB78u8JloKoJVBtbOHGyOe7WQ42rTqvy1lXx8MqysJlMyKkdKZnICnCkcf2XZNqQoJz1kS2JeWz3ahmRGETIBZ1knQRwARLNhGkuIlsLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vzb61wKO; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-533461323cdso617631e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724926019; x=1725530819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p4m4sFOZMDTMX82iw7f1HhdQ6KEhLtr+hrPhztMpqLI=;
        b=vzb61wKOL/tdMQ+oG9V7e/Ya+sqvSsHLuVzdIV+gMVyKUOC2AAuhKfdLxNou49sabT
         DvALHBVLEnz5jIeLV4zBX4f8j4mHTM5P3KPBLqmnKI88tU9i8lGdGvvdMDM7dxqNcgUU
         dvw5ZzgsAjEZ6dt5xy3K+hhfZmIWIW6w1nwVimre2gd4J7X+L0gQAANTY0HHwQkE/FRF
         PIusHC1dC7+pQSYyQNaYy4DrOQfubvvQUDQP5pMTvOtRhn+QiyLbhBzy3usvbG/jT/b6
         a4lbykPtpBytW6ISMNcqBIfYn/1gD0Oc5yca40CZsDGRxOoPW0p0+zcdfiI0KAzkMWlt
         vl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724926019; x=1725530819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4m4sFOZMDTMX82iw7f1HhdQ6KEhLtr+hrPhztMpqLI=;
        b=HkOyTHGdhnWliTkuncMUrx9sOA89neoT3P5qk8zBtz2N4nGk/XoDqQF3w4GT63hJ8n
         Ov+y/WBwA8xUoYQxNs2EGZT6tjDjIZFUg1PHpSFQ7a1B+09j3/chE7PnChshNPZpXHjF
         vTNBxD6dzS5qdlaz9b91D0dY75Ls57y89mWGPx/sO4Hm93pGiOlrbfzjTfcsN1vYuwz+
         pcfGWLFuts9zPsCSczopIZCYuCRHNnPU55367fr9wFyzPlF1kCcGLZAuhLBywEiNv2s/
         DbjDdqPPH5b2SC24iTYfGfo07Z2znQjdaVBvqj91gea9o4zJf6aQZh+tbwVR55PhmZlH
         ThrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVM94Tl/XU5HKoo1Xaml0Bz751JfYZIYvQxOH6g50xXxvuoRlUluzaUhnMjQp/knya4oFwS5uU6GyWLipE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK+D3rPOzBWWYeOWGJyd9cN/DJZSBnTWGqbIvI/hRJyDcIkPtQ
	hy2n0yLt8aw6iQLRXutOz1KAKB180pHgCzt2cm0NVzCkVVxkdTiVUqj2GPZ8cPY=
X-Google-Smtp-Source: AGHT+IEAyzzgG0+l2SSqg3XbyWi54g9EJHgJyEiWmSeAfTXoSsLIi75kAP68EXftAzwcFS197Ifz8Q==
X-Received: by 2002:a05:6512:3f0a:b0:533:460c:e42f with SMTP id 2adb3069b0e04-5353e5449b2mr1408030e87.4.1724926018326;
        Thu, 29 Aug 2024 03:06:58 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-535408593d5sm112334e87.306.2024.08.29.03.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:06:57 -0700 (PDT)
Date: Thu, 29 Aug 2024 13:06:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run, 
	marijn.suijten@somainline.org, airlied@gmail.com, daniel@ffwll.ch, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] drm/msm: Use
 devm_platform_ioremap_resource_byname()
Message-ID: <6k6hghic2ay277jg5tddihqal2i2fta2aam2du6dbjqq4whcjh@lilojqbwgnsx>
References: <20240828084849.2527115-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828084849.2527115-1-ruanjinjie@huawei.com>

On Wed, Aug 28, 2024 at 04:48:49PM GMT, Jinjie Ruan wrote:
> platform_get_resource_byname() and devm_ioremap_resource() can be
> replaced by devm_platform_ioremap_resource_byname(), which can
> simplify the code logic a bit, No functional change here.

NAK.

platform_get_resource_byname gets mdss_pdev, while devm_ function
uses pdev->dev. Passing mdss_pdev to
devm_platform_ioremap_resource_byname() means that the resource will get
lifetime management attached to the lifecycle of the other driver.

> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/gpu/drm/msm/msm_io_utils.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_io_utils.c b/drivers/gpu/drm/msm/msm_io_utils.c
> index afedd61c3e28..6f7933f01ae6 100644
> --- a/drivers/gpu/drm/msm/msm_io_utils.c
> +++ b/drivers/gpu/drm/msm/msm_io_utils.c
> @@ -54,13 +54,7 @@ void __iomem *msm_ioremap_mdss(struct platform_device *mdss_pdev,
>  			       struct platform_device *pdev,
>  			       const char *name)
>  {
> -	struct resource *res;
> -
> -	res = platform_get_resource_byname(mdss_pdev, IORESOURCE_MEM, name);
> -	if (!res)
> -		return ERR_PTR(-EINVAL);
> -
> -	return devm_ioremap_resource(&pdev->dev, res);
> +	return devm_platform_ioremap_resource_byname(mdss_pdev, name);
>  }
>  
>  static void __iomem *_msm_ioremap(struct platform_device *pdev, const char *name,
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

