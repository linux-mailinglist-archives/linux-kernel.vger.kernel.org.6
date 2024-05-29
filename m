Return-Path: <linux-kernel+bounces-193720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDB68D3117
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ACC4292807
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E19167D98;
	Wed, 29 May 2024 08:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MVsXj67/"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2214374F6
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716970867; cv=none; b=WZ3e1pgN+NjbRXby6h8qnzkWyjPCt5mewO65XQTgdJAtKMLM9eExf3QWgXjxCeWjcTr6jAWHVom/398tzXUzyavcOta8Va6Ntd8PyNc8R5rcNW5c0Bn9kk9Udl9g5L8sAeSwHgNvgcXw25W1iZ1pbWdHRgiXVYWeeAr1/ksaIzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716970867; c=relaxed/simple;
	bh=GvQlmrtOsIq9NPc29uY9RaT1100f0FwdAhRIUUBDucs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1oNNn0M2w8JMZlcalkvriMco02LHKWhyn/uq1Eyv2dK7wSTlkkoH/aiPRaZTOvMdjpjzmgvUI5CfqBCIYbk6YmIRwHpSa9jxCP0X84EN9zw2aqALITHBmGypPFb0U0L8CEEEjN3BCcU9hrV9rzNKcw7sPIO7AhhptTZQuZCjOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MVsXj67/; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e968e77515so21666081fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 01:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716970864; x=1717575664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NlPH0P994GSLr65I7MtbS6ikre4n5vkaipn9KH2517g=;
        b=MVsXj67/Zcyq6wAYRKctbOnZUCIJsooiFBN/cU7XqJgzQwXJRkGb2wVXhUIc2zuuBT
         9v3W8uDn+1k/QSFnu4qwjcNpGLlQCEeqqkrDS3lk6ODC/nwP3EvMH7quZy6VXdbFGp4J
         o5q6JRIAcVZeRdgdYJkbL3io+r5nrdy0qPnjP2RysAY62xHMtDcHSBDK0c0IHSQ4QDNj
         Rhvw32VheC9/TT71dbsjelN1z0zPLAEjeln0shTzdRZkhA9mCOJJWmVRa6X0Ru+ZesgL
         KmZ4gXVcwSN8qi7eFsemUL7trTP9dLJI8R2LYZDdymXrWBStCy14bbnSR4/wCgOaDgqo
         KITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970864; x=1717575664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NlPH0P994GSLr65I7MtbS6ikre4n5vkaipn9KH2517g=;
        b=Wo4z4dX93h4OMSmgKPUZbP2bZEdYHbPO9kbx37YduayvLCZoQoo1Ta7feTh1qYbpQa
         z43HDT4sf51emEJfOaCHay37rB0Z09w4Y3hO2gISbQbUBX1ZxQnVxZ/bkDz8/4hQSWZi
         7j1hQur3tOiEHfdMi/kwUMuLPbAnm5xKxvNs9Yw1hntdk5FnI3zBUZfX3H5AjXDH/CaV
         Y++pTWzLAAUhIGU9Ng2FVnCFAyHZeNKAZ0GQtIg12XbiwJK/bY8LvsS84jhidzdfBawr
         mwkvzRKlIEhe1qj31WX8tR9ZZseKlKaXQDD9JWASoIyIZkFf0QDBWI10wml00rKy5GKe
         PGzg==
X-Forwarded-Encrypted: i=1; AJvYcCWeuazwCC29AfoLa76qUHmiCiyOpT6tdcRkUv5Zdg7v07u642w1/x+swbdYxe3NXrQ4ghO4gEfI9yEUiVWrcleiqiIF4mcnd7OEqtq4
X-Gm-Message-State: AOJu0YxN22yHxVh800W2g/S4Nu0WrmIQAn1R2C3+XqQEQPyeLcoSU+lD
	U8w+uIkKF+UG3kSyuM80zxsQch/5N96y/cU0k42rr91m4PCuvr9vzNzu7iO0wEo=
X-Google-Smtp-Source: AGHT+IGHFRFnp+MyYG+YuWo3CGNhxr5zVQkELmm+9aSx5PbZeqdQ7lHk7UJdLwxeRsOL0b9TVbrimQ==
X-Received: by 2002:a2e:99c2:0:b0:2df:e0c4:8429 with SMTP id 38308e7fff4ca-2e95b0c22abmr100784511fa.18.1716970864023;
        Wed, 29 May 2024 01:21:04 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bcc48c8sm25085331fa.14.2024.05.29.01.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:21:03 -0700 (PDT)
Date: Wed, 29 May 2024 11:21:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Kalle Valo <kvalo@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Alex Williamson <alex.williamson@redhat.com>, mst@redhat.com, Jason Wang <jasowang@redhat.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, iommu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/20] drm/msm: Use iommu_paging_domain_alloc()
Message-ID: <jd7df7jshswukstxwbfoxuswyltyemdmkx272i5mpldlfsk4t7@ad36olyvmw27>
References: <20240529053250.91284-1-baolu.lu@linux.intel.com>
 <20240529053250.91284-7-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529053250.91284-7-baolu.lu@linux.intel.com>

On Wed, May 29, 2024 at 01:32:36PM +0800, Lu Baolu wrote:
> The domain allocated in msm_iommu_new() is for the @dev. Replace
> iommu_domain_alloc() with iommu_paging_domain_alloc() to make it explicit.
> 
> Update msm_iommu_new() to always return ERR_PTR in failure cases instead
> of NULL.

Please don't mix unrelated changes, because ...

> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/gpu/drm/msm/msm_iommu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
> index d5512037c38b..f7e28d4b5f62 100644
> --- a/drivers/gpu/drm/msm/msm_iommu.c
> +++ b/drivers/gpu/drm/msm/msm_iommu.c
> @@ -407,9 +407,9 @@ struct msm_mmu *msm_iommu_new(struct device *dev, unsigned long quirks)
>  	struct msm_iommu *iommu;
>  	int ret;
>  
> -	domain = iommu_domain_alloc(dev->bus);
> -	if (!domain)
> -		return NULL;
> +	domain = iommu_paging_domain_alloc(dev);
> +	if (IS_ERR(domain))
> +		return ERR_CAST(domain);
>  
>  	iommu_set_pgtable_quirks(domain, quirks);
>  
> @@ -441,7 +441,7 @@ struct msm_mmu *msm_iommu_gpu_new(struct device *dev, struct msm_gpu *gpu, unsig
>  	struct msm_mmu *mmu;
>  
>  	mmu = msm_iommu_new(dev, quirks);
> -	if (IS_ERR_OR_NULL(mmu))
> +	if (IS_ERR(mmu))
>  		return mmu;

NAK, not having an IOMMU is a poor but legit usecase for some of devices
which don't have IOMMU support yet (for example because of the buggy
implementation for which we were not able to get all the hooks in).

Please don't break compatibility for existing platforms.

>  
>  	iommu = to_msm_iommu(mmu);
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

