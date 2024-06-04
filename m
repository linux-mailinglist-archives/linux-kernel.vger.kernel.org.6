Return-Path: <linux-kernel+bounces-200180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B1B8FAC80
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1B321F21A33
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 07:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37111411E5;
	Tue,  4 Jun 2024 07:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B+tFdWwK"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C75D14037C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 07:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717487310; cv=none; b=KEe5bEj4jdW7d/MWOfqks+/42S6KRcxi5cCbtGTlBpNqbzTRiX9E825k1mVnW+4J6IJJJZUbUHXlAc8wkKDF5iDaqeaqNRLgjruJgImxlQFZg9x/2Qx1twY92GvmdKtKIcyDf30ydmpsGpHvNWiBpMeLBOWJzqCKgO/y7rHeGig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717487310; c=relaxed/simple;
	bh=vCitIq86zHiouZSAKcvxwEFguJ/k1OQJuGOVFY1W6dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1JBfhXQyi4fdhcYH12uvbiAw6kTbmf48Xwthc0gOoqY78T6ugb4FVO4OzOlhnt4NU1QC7mso2Pb8rvqJdM52vLbtZxDT08K2t8MfpJBjC2Lbj0x/Lb+xESnbopQQO+RD0CoxW7BX3SQQmN19V2uIPbKc9KdDx1gsMX5FrJ7BcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B+tFdWwK; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52b894021cbso4642462e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 00:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717487307; x=1718092107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OlJzONumJ7hGmF7Lx8HSrbgepz7pi58FM6gnNMiUIJU=;
        b=B+tFdWwK/H9uAblUEOeZv2eExnYxrp0T/KPeEGwiaPb/mvOMr2J9VnxnOL/q3x67Fq
         wJaj2N1BIKesVNl4fXox8mOh8zOVI3bBLhPDAl8MTNx16uVjjRtqSbTa2Xe8+8vfDAZY
         q831llwPD7KCb2ADyHxjwvc4dHTJeKsvSYjmk+xA503z5K47NIuq6kxn8Vd5l4v26Jcz
         F9b6Hd4dDxIrM734oa+17qfQdFjAq+zfqh0We8MIIQ4u7LEArhvekw9SGkYkQzk1xVSj
         9m2+7TE3IcgTxwa+MDpEfSTu6KHhxonvceofK3wkL1Jxe+xeGk3mLZ4WHCCBf8VhJFum
         rIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717487307; x=1718092107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlJzONumJ7hGmF7Lx8HSrbgepz7pi58FM6gnNMiUIJU=;
        b=VO2XHpMchiVTbJiRvIoWCXPk5ST3Zn/BH+5W1Dug7WwpwuKy1AiitGU2J+9Un3yc2v
         ex1H58YmCldFBH7zkcwdYBQ8WG3T2ZR74u42X2uVFbh5RqOnq4QFAHHfrAoQRX2s1BFy
         2HhDCy9h/OI6zl0JbdRUuArHocM9BWwaj3VpfaFOjuUjTPY05BTE8gHyEsHUcZ7o2qej
         qyDRwO8coxcmB2XUcZu3D0dIEi/TKjNclcwN5cN4D6Q3g3fhryZ+9ERNa54ohzHTg54U
         pf8mIN66wzn++En4YEVS9XV7NY42QR2SW54kVYfUY9d/uMo0OEGB21MLTOPIx1vNHp2R
         OTUw==
X-Forwarded-Encrypted: i=1; AJvYcCVaoHX38b1/1jCpmYKtAU9i8g33/RLbvuIingbuTVQNIPV7T8aXz15k7xWJNbIKgSOC/L5DbqFg1Ix40oWdcKmEiMKYxpuGILsZ7Ea4
X-Gm-Message-State: AOJu0YyfLyTQfba1V2cVG1lxZzXMVfU9ccB9fK9msjOvMUA+r8AI2iWW
	IhQFCIMWszMSQ7kveHhXPDE/lBo8J3LvavLVgvNEYixiWKxrRzKqGKQ3aF47mJc=
X-Google-Smtp-Source: AGHT+IGqL1YJgziLvhDKlAs/q9qv00KwD6G0YPzlvyHwSRHM2CF7Ig4MUCHZdylu6wx8bzJ0XpEuCQ==
X-Received: by 2002:a19:9110:0:b0:52b:8417:fa95 with SMTP id 2adb3069b0e04-52b896b6e1emr6758126e87.41.1717487306746;
        Tue, 04 Jun 2024 00:48:26 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ba4c99cb8sm142098e87.62.2024.06.04.00.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 00:48:25 -0700 (PDT)
Date: Tue, 4 Jun 2024 10:48:23 +0300
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
Subject: Re: [PATCH v2 06/22] drm/msm: Use iommu_paging_domain_alloc()
Message-ID: <zm65wqngmcji4t4ox6ak7il7p5beup6a2yidytp376gbxkfq2w@duieucwqwj6r>
References: <20240604015134.164206-1-baolu.lu@linux.intel.com>
 <20240604015134.164206-7-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604015134.164206-7-baolu.lu@linux.intel.com>

On Tue, Jun 04, 2024 at 09:51:18AM +0800, Lu Baolu wrote:
> The domain allocated in msm_iommu_new() is for the @dev. Replace
> iommu_domain_alloc() with iommu_paging_domain_alloc() to make it explicit.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/gpu/drm/msm/msm_iommu.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Thank you!

> 
> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
> index d5512037c38b..2a94e82316f9 100644
> --- a/drivers/gpu/drm/msm/msm_iommu.c
> +++ b/drivers/gpu/drm/msm/msm_iommu.c
> @@ -407,10 +407,13 @@ struct msm_mmu *msm_iommu_new(struct device *dev, unsigned long quirks)
>  	struct msm_iommu *iommu;
>  	int ret;
>  
> -	domain = iommu_domain_alloc(dev->bus);
> -	if (!domain)
> +	if (!device_iommu_mapped(dev))
>  		return NULL;
>  
> +	domain = iommu_paging_domain_alloc(dev);
> +	if (IS_ERR(domain))
> +		return ERR_CAST(domain);
> +
>  	iommu_set_pgtable_quirks(domain, quirks);
>  
>  	iommu = kzalloc(sizeof(*iommu), GFP_KERNEL);
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

