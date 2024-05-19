Return-Path: <linux-kernel+bounces-183068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC918C9413
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 10:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E86C1C20BC8
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 08:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DB62576B;
	Sun, 19 May 2024 08:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="utL5Gnzr"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3989D17580
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 08:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716107986; cv=none; b=IevVL/QzgCh67J2SIXAh52U5zo1k850vGhhFUGrDYxtsy1NByejXxCrlsZKUIw8F15K3BQbd0dgpCkRX8ym/Wi0QavFnHqy6PhA0Eb8athUOLkzk0i8GJERSl8i3lWXTZ42Evs85jwtrNc9tsW1PqIenN+2cCev+N+asZ3xEqXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716107986; c=relaxed/simple;
	bh=Kg3YX6ii6Indv1+t4Rh29tADMsvqWwP3yWdw78z0LO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlMyeXZW/uZbMr641UrH4iZWSBV8aq8kEfef/63m2G8BPhYOnqoI8tGWRsej4LTfCopsr/VyFv9YsAfCA5pdWd59saiW1xJNhtTMtsnEiNghNrLBW9AiGhMLLah8+JeqzmF51qxw8Q6jTv4cty8NR108L3jCyb27DKDz+mvHWZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=utL5Gnzr; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e1fa824504so23791431fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 01:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716107983; x=1716712783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wINRsVYOfc9e8SdgZRbrSE/ek9LX88q64lK0ONVJskM=;
        b=utL5GnzrdmA5YirwGSS2B7C7qx9bs8AIq/33RBAoV/UUuRYYuJaiGb49/P/aoT21FP
         HZ4sr1Sf8H9PXL4bu4E+esevHoQ98v61q/MunYs2FyGyvMr6N8GwWbFUsBSOCtSvSBnc
         2LMZIOhzyVXHj2i5J4Yheg+HhOwe4BbxnJbapgyjTj9LTUILSbdff72zPIzVFjzN42T6
         yXHnOhw7SO07ypwfrgurKmVoc65kVolCGiJGUl8wT6IBDNj4bcC04v5WGvroGpwnmkiB
         BxIwAlZXR2KmRcYtJwLP8DNCh2DDjUNDIPWI4c3Le75JFbJLQmYO7hIJOAVZPYUMYaff
         gZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716107983; x=1716712783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wINRsVYOfc9e8SdgZRbrSE/ek9LX88q64lK0ONVJskM=;
        b=uJshxFKofWssOkgRHA/U7NqK01X9rjGJyey6RyyKY95pIk5sG7+hNx1n88/X7+PBgx
         bonNvDXVvaoAHpIRvrJA65L7M3FiEW8XB54+uEY34+jWqeSfrihzJL70M+JdFu2nqW9G
         mcgY0YL0SXbTAvghYcLmJtEptonIAYroonqJCXlfrPQm8Of6kjrxd/pNljBlHDL9g5OI
         1MZjKT8iNAGcKtJ2Kqtnlc91G0XqDfN4PAIyhpOIuRqk/VAqVeVynPTL7W55Lt3bbP1x
         4qUcQwY6ti7zdlOBSEiEEmlg/MuRJ/QARbdkgi+oweddyvhbH8a21E8OEeN1VgNHlLFZ
         F32A==
X-Forwarded-Encrypted: i=1; AJvYcCVLfO5LMSIwL0vyfUggU4B8dSehWVa4Dvjq2+TUTeGJjNBGT2swNFoRQHkCgUw8t/BfQGGSWlPzJ0ZBEMl159/sRhlOVilUr366aRUG
X-Gm-Message-State: AOJu0YxJkv1k1N8ZBrXpiha3Z5o2w16aYrQxyxXUb8E7LdFOX+c7g9xY
	MnQY7MDftaHQFMZXHJlxC+FrL4DuEwVGhxVUjPideKK/1rKvOCxtf74tHdMBph8=
X-Google-Smtp-Source: AGHT+IFI6PXjXa5dIVUKDoC56AXg8GLn15W3jSRDWvlVXmFTkJPr2Sj8InmpAqQX1jsCJ0QL5wMf+w==
X-Received: by 2002:ac2:520a:0:b0:51f:1e8e:f7d5 with SMTP id 2adb3069b0e04-5220fc6d51bmr17374319e87.35.1716107983501;
        Sun, 19 May 2024 01:39:43 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d8d70sm3840903e87.226.2024.05.19.01.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 01:39:43 -0700 (PDT)
Date: Sun, 19 May 2024 11:39:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	seanpaul@chromium.org, swboyd@chromium.org, dianders@chromium.org, 
	quic_jesszhan@quicinc.com, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] drm/msm: switch msm_kms to use
 msm_iommu_disp_new()
Message-ID: <gfmxslhxpokhwsbnxucd4od2kdqldelrysl6gd2tmgb3dfx6bs@gku27mrctqfh>
References: <20240517233801.4071868-1-quic_abhinavk@quicinc.com>
 <20240517233801.4071868-5-quic_abhinavk@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517233801.4071868-5-quic_abhinavk@quicinc.com>

On Fri, May 17, 2024 at 04:37:59PM -0700, Abhinav Kumar wrote:
> Switch msm_kms to use msm_iommu_disp_new() so that the newly
> registered fault handler will kick-in during any mmu faults.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/msm_kms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
> index 62c8e6163e81..1859efbbff1d 100644
> --- a/drivers/gpu/drm/msm/msm_kms.c
> +++ b/drivers/gpu/drm/msm/msm_kms.c
> @@ -181,7 +181,7 @@ struct msm_gem_address_space *msm_kms_init_aspace(struct drm_device *dev)
>  	else
>  		iommu_dev = mdss_dev;
>  
> -	mmu = msm_iommu_new(iommu_dev, 0);
> +	mmu = msm_iommu_disp_new(iommu_dev, 0);
>  	if (IS_ERR(mmu))
>  		return ERR_CAST(mmu);

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Note to myself: make mdp4 use msm_kms_init_aspace().

-- 
With best wishes
Dmitry

