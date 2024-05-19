Return-Path: <linux-kernel+bounces-183051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C64338C93D5
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 10:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD35A1C20A0B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 08:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A081803E;
	Sun, 19 May 2024 08:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DtK4O20s"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F91175AB
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 08:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716106597; cv=none; b=h+7SX4GK2BF4XFdM9dQWVq6DQpRt5rq56TS+qw6l0vFE+INUsHLFVwcnVOVqDo5xAZSoa3BKaXTK16QYjt1myE4AiXj6Ry3SDxYsQLkBwvU/vATy+XfBnRaDTVlQlMUzvymZLqAZbjLMsKyiw9PMf7tTPiQZi3CRsJ4wC/XQuac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716106597; c=relaxed/simple;
	bh=5GvvJGAyZf8QY6YNoSOkE8KDWtNj13Zl8SY6VB7LWdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQFIKJLj16W5Y/teoXV+9tPv/Cmj7o0FzWCkM86hpWlufZ4CvVvWOLpaxvamWmnpqrFiCId5vOfCp+9DJSwcaEbEGg2ok3MWtEYfe3LRYdOoL1ibnHo4t8biF51q65zvdtpmnhR9K9PxgB2saL4vKtt6JsOh1JMu2ZTQ2i7GRGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DtK4O20s; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51f1bf83f06so4061806e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 01:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716106593; x=1716711393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nqscv5hPY4OsF6W8djpNx/MqPGz0oq15EeGyLjqSwyg=;
        b=DtK4O20sNPzadCuNXxRkmcfQIBGaGvB+09EpOcQ7DDEVKmjWUh/Mg2mkK0Zno7tLp4
         s8kPOzAJQSeYuJT2UzgnFzXsVAS62EDhGRimyrZaFNyj4c0ItjqM4eStKgLkVs/a49hR
         tSj+UbU0NlAoBtUTsu78ruoip0vqVtF5H4Tjeo+oQca8fkJ/948Q9iQgaXVOgNICkTE+
         fqFVxibByv0aojrXW0nI3SfEJj361lWCeKdtHMTE8AVxMymMIKLBoCVoJzqtzmFHzn3a
         rWi8ky7Zd8oYUFmB3bmInmBSIEmtGfEiYfFDLN2G+zJOJu6E7LX8vqpVhVS932OkBVcH
         /eiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716106593; x=1716711393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqscv5hPY4OsF6W8djpNx/MqPGz0oq15EeGyLjqSwyg=;
        b=tgfNMKWc/iF2p9W4S8EKNi8eVakmCB+Uryhy0ygc/rl4jsxf07CPnrT0EEYzrRTQKH
         FayyifmAgruJ3sRxv3pCpAweLo+18H3RcHAE25drs1MHIuiQb4w6EsLczpL33HkjejmC
         eqCFublHHszB2twbdSYRSNfnOw4U/lfRKgiTCxxpm52wEDEeAavlW07hnBAKNz+bwDyg
         jK7J3yJGWlYN5SyP0BC64Oqd8Cj93TKuI7JSJCZu9T65J0HH/89Suo0Y2/lfLviUivA8
         MQNbsKQT0KBZbVDHXq/NMv0/54HbxpIPOXmGnWL/8mC+ZpqCu+3z7TFTKf2I8V71x4AS
         DJJw==
X-Forwarded-Encrypted: i=1; AJvYcCUNWEMt+0n2GGUGPf/HV/R9aKPyCouSgnjjfFrNlNXjUOcN0wIDpdGXzN8sY0HVytzSU3DFhDpsDJ0GLCH/xkwQzzdKzpRy9HROlq3R
X-Gm-Message-State: AOJu0Yzk/hWJaCp2V/pXOqp44TUDvxF+hNdXdjUtKpqFofbizDUaNzl2
	TSs7m2zPj7DImfmrclP6X3zl88LfzBGbJn0HtGeSUwVSs9r6QcvJln7LaXMKspL/axSl6gApiZc
	p
X-Google-Smtp-Source: AGHT+IFRGaG2cgRyfRkJRXqkedyOipsI0+xvINvklLqDqBRjRxo9DNXLPfaP4ViVN92ReZ3cfEXEYA==
X-Received: by 2002:ac2:4c55:0:b0:51f:4165:9305 with SMTP id 2adb3069b0e04-5221007016dmr19852722e87.55.1716106592716;
        Sun, 19 May 2024 01:16:32 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f39d31aasm3904344e87.283.2024.05.19.01.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 01:16:32 -0700 (PDT)
Date: Sun, 19 May 2024 11:16:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Kiarash Hajian <kiarash8112hajian@gmail.com>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] drm/msm/a6xx: request memory region
Message-ID: <4susqladik7qzknlggchehmfyzeaccc7j27jtpvgrfm4pc7bqk@weiwasipz674>
References: <20240512-msm-adreno-memory-region-v4-1-3881a64088e6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240512-msm-adreno-memory-region-v4-1-3881a64088e6@gmail.com>

On Sun, May 12, 2024 at 05:03:53AM -0400, Kiarash Hajian wrote:
> The driver's memory regions are currently just ioremap()ed, but not
> reserved through a request. That's not a bug, but having the request is
> a little more robust.
> 
> Implement the region-request through the corresponding managed
> devres-function.
> 
> Signed-off-by: Kiarash Hajian <kiarash8112hajian@gmail.com>
> ---
> Changes in v4:
> - Combine v3 commits into a singel commit
> - Link to v3: https://lore.kernel.org/r/20240512-msm-adreno-memory-region-v3-0-0a728ad45010@gmail.com
> 
> Changes in v3:
> - Remove redundant devm_iounmap calls, relying on devres for automatic resource cleanup.
> 
> Changes in v2:
> - update the subject prefix to "drm/msm/a6xx:", to match the majority of other changes to this file.
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 22 +---------------------
>  1 file changed, 1 insertion(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 8bea8ef26f77..cf0b3b3d8f34 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -524,9 +524,6 @@ static void a6xx_gmu_rpmh_init(struct a6xx_gmu *gmu)
>  	uint32_t pdc_address_offset;
>  	bool pdc_in_aop = false;
>  
> -	if (IS_ERR(pdcptr))
> -		goto err;

So, if there is an error, we just continue through? What about the code
that accesses the region afterwards?

If error handling becomes void, then there should be an early return
instead of dropping the error check completely.

> -
>  	if (adreno_is_a650(adreno_gpu) ||
>  	    adreno_is_a660_family(adreno_gpu) ||
>  	    adreno_is_a7xx(adreno_gpu))
> @@ -540,8 +537,6 @@ static void a6xx_gmu_rpmh_init(struct a6xx_gmu *gmu)
>  
>  	if (!pdc_in_aop) {
>  		seqptr = a6xx_gmu_get_mmio(pdev, "gmu_pdc_seq");
> -		if (IS_ERR(seqptr))
> -			goto err;

Same question.

>  	}
>  
>  	/* Disable SDE clock gating */
> @@ -633,12 +628,6 @@ static void a6xx_gmu_rpmh_init(struct a6xx_gmu *gmu)
>  	wmb();
>  
>  	a6xx_rpmh_stop(gmu);
> -
> -err:
> -	if (!IS_ERR_OR_NULL(pdcptr))
> -		iounmap(pdcptr);
> -	if (!IS_ERR_OR_NULL(seqptr))
> -		iounmap(seqptr);
>  }
>  
>  /*
> @@ -1503,7 +1492,7 @@ static void __iomem *a6xx_gmu_get_mmio(struct platform_device *pdev,
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> -	ret = ioremap(res->start, resource_size(res));
> +	ret = devm_ioremap_resource(&pdev->dev, res);
>  	if (!ret) {
>  		DRM_DEV_ERROR(&pdev->dev, "Unable to map the %s registers\n", name);
>  		return ERR_PTR(-EINVAL);
> @@ -1613,13 +1602,11 @@ int a6xx_gmu_wrapper_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
>  	gmu->mmio = a6xx_gmu_get_mmio(pdev, "gmu");
>  	if (IS_ERR(gmu->mmio)) {
>  		ret = PTR_ERR(gmu->mmio);
> -		goto err_mmio;

And this is even worse. See the comment below.

>  	}
>  
>  	gmu->cxpd = dev_pm_domain_attach_by_name(gmu->dev, "cx");
>  	if (IS_ERR(gmu->cxpd)) {
>  		ret = PTR_ERR(gmu->cxpd);
> -		goto err_mmio;
>  	}
>  
>  	if (!device_link_add(gmu->dev, gmu->cxpd, DL_FLAG_PM_RUNTIME)) {
> @@ -1635,7 +1622,6 @@ int a6xx_gmu_wrapper_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
>  	gmu->gxpd = dev_pm_domain_attach_by_name(gmu->dev, "gx");
>  	if (IS_ERR(gmu->gxpd)) {
>  		ret = PTR_ERR(gmu->gxpd);
> -		goto err_mmio;
>  	}
>  
>  	gmu->initialized = true;
> @@ -1645,9 +1631,6 @@ int a6xx_gmu_wrapper_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
>  detach_cxpd:
>  	dev_pm_domain_detach(gmu->cxpd, false);
>  
> -err_mmio:
> -	iounmap(gmu->mmio);
> -

You have dropped the iounmap(). However now the error path should
remain. The put_device() must be called. So fix the label name and just
drop the iounmap().

>  	/* Drop reference taken in of_find_device_by_node */
>  	put_device(gmu->dev);
>  
> @@ -1825,9 +1808,6 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
>  	dev_pm_domain_detach(gmu->cxpd, false);
>  
>  err_mmio:
> -	iounmap(gmu->mmio);
> -	if (platform_get_resource_byname(pdev, IORESOURCE_MEM, "rscc"))
> -		iounmap(gmu->rscc);

Same comment here.

>  	free_irq(gmu->gmu_irq, gmu);
>  	free_irq(gmu->hfi_irq, gmu);
>  
> 
> ---
> base-commit: cf87f46fd34d6c19283d9625a7822f20d90b64a4
> change-id: 20240511-msm-adreno-memory-region-2bcb1c958621
> 
> Best regards,
> -- 
> Kiarash Hajian <kiarash8112hajian@gmail.com>
> 

-- 
With best wishes
Dmitry

