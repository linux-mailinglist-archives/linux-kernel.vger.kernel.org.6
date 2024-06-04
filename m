Return-Path: <linux-kernel+bounces-201102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFD08FB987
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C16A9283BBC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DB4148855;
	Tue,  4 Jun 2024 16:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mjnjANRX"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65198225CF
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717519911; cv=none; b=TV8J2lJuuK8tMDcy0AiCLR/6p0VBId2oXmmv7PfXAk4AIUWceWwE7Y+pNFK1X1PfqjrIMwek9lxrkx7p422kgMUI92Gip+B8Dko90GXd6u54PCR+KRlACwaGlINm267sFqzYUIBoKGzEyuTA2NO0lt8YSfMiayrfSHAUORIqnOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717519911; c=relaxed/simple;
	bh=/gbhEWGwhC/N9t3ZntrfKjb94teayzC5Ct4eUgtvJyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAb6b9XceWae4FgGk9c47IjVLRl994jqK/SHoAYEJ17at975r9BSsfVRMMC9p117hwtbvj7VA9PLHw8ZIewWGDHb/uJ6tyc0Aj69fW8Y370RrJdRrreCxvyPQyN0flnO8yifQf6Oiug2QzJKYDL/uBjiRwk6TLNG90f7d/w3iFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mjnjANRX; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-794ba2d4d82so258359985a.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 09:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1717519908; x=1718124708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rHa4rdBij7iNJpe66g86f477UY9nlCjL0qAGcR/g8E0=;
        b=mjnjANRXZzIJiJnslRWqn3WsM3RfBVwCqK98KUBQe6h3/IkYHs1d1w2Xk/qN5RjGPb
         tBb1CQf84XEUVZNahwQBHTiq4ekZHv5Nk0ClroIV3nLYwOfSB5FQ8cpYqzsjvSEfgIIW
         XYRxbWpLuaiFky9tXBjqw7pbwDRznLz7ie3B7CQTLVycOo4NS5C4wsSQKNCTVEucroVc
         xK/ybtjne+qXDbu6nI4cDxGAbE//w990WRl1XQNU0wgxNeib1Wzf0Eb1NiyVuG24cOEG
         Xo5BZspLhgQz+QnSMXf55WhnESkGoS72WekXB+vTNSHZ97oZ3MYxlR0W+ZCSxBy2/TWI
         ShQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717519908; x=1718124708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHa4rdBij7iNJpe66g86f477UY9nlCjL0qAGcR/g8E0=;
        b=P5lwMCjnFZsElYVSaX+SGxZa+8yJLOc9Ebpo2z/MLECVvmXrx2U0SmFDvuvPJ9o6k1
         U2vpOpizPIFA0kgAGBg6Gu0pt+SWJVMLxvVxvad5q3EW4ZWtIdzdf5p+hQ8bWBpGMSKs
         CQmItVUKJ6/T0FvRJOOh1vEioN0/64e+0ZcqWfgRV1kbYoc+n2YuETF01bY4h4MG2T5o
         S2n+vUP56O6xZhGbd/aksH71hjxKjjHSTK/pb3OF1+Qe8RoYi73aj49A/u+OM8+LF4iT
         egIfJgTOFIhV40XVp5gXXpZu7J6id/qPQowt5quevJGL0Vq+QbJpfBYxzoznEFx5fImY
         AOkw==
X-Forwarded-Encrypted: i=1; AJvYcCXufXAFlzQrV7DM6amuQS6wLOjfVUzK3HP0qd+4g1O3ZZf70U8sU+1MWTzIsB9PSskdWYWuv4kydNgOjTwIXhUz9+ikqpCw7jMCOLNu
X-Gm-Message-State: AOJu0YyDvizMZkq8ugdTfR8p1KjI1t0DQrU9ZQnpYlTy1gS1Jbu00V7B
	EI7oKz9jEEW9jBhB2jZv79k9QuNcYD4tQwp7yK1YZKes9gF8SLzPtVpSzAjAq9Y=
X-Google-Smtp-Source: AGHT+IGwn1k8sp+tDvJPbmVwjnFqtNhVBCqRYzi+miJGltF4eG+Bl2fD0Av2bC2c9STAhnkW1l81RA==
X-Received: by 2002:a05:6214:3906:b0:6af:c6bc:bdc2 with SMTP id 6a1803df08f44-6afc6bcc442mr50551886d6.28.1717519908248;
        Tue, 04 Jun 2024 09:51:48 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6af3d644efbsm29212786d6.19.2024.06.04.09.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 09:51:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sEXNx-002u7o-KW;
	Tue, 04 Jun 2024 13:51:45 -0300
Date: Tue, 4 Jun 2024 13:51:45 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alex Williamson <alex.williamson@redhat.com>, mst@redhat.com,
	Jason Wang <jasowang@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>, iommu@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/22] iommufd: Use iommu_user_domain_alloc()
Message-ID: <20240604165145.GD21513@ziepe.ca>
References: <20240604015134.164206-1-baolu.lu@linux.intel.com>
 <20240604015134.164206-3-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604015134.164206-3-baolu.lu@linux.intel.com>

On Tue, Jun 04, 2024 at 09:51:14AM +0800, Lu Baolu wrote:
> Replace iommu_domain_alloc() with iommu_user_domain_alloc().
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommufd/hw_pagetable.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
> index 33d142f8057d..ada05fccb36a 100644
> --- a/drivers/iommu/iommufd/hw_pagetable.c
> +++ b/drivers/iommu/iommufd/hw_pagetable.c
> @@ -127,21 +127,11 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
>  	hwpt_paging->ioas = ioas;
>  	hwpt_paging->nest_parent = flags & IOMMU_HWPT_ALLOC_NEST_PARENT;
>  
> -	if (ops->domain_alloc_user) {
> -		hwpt->domain = ops->domain_alloc_user(idev->dev, flags, NULL,
> -						      user_data);
                                                     ^^^^^^^^^^^^

> -		if (IS_ERR(hwpt->domain)) {
> -			rc = PTR_ERR(hwpt->domain);
> -			hwpt->domain = NULL;
> -			goto out_abort;
> -		}
> -		hwpt->domain->owner = ops;
> -	} else {
> -		hwpt->domain = iommu_domain_alloc(idev->dev->bus);
> -		if (!hwpt->domain) {
> -			rc = -ENOMEM;
> -			goto out_abort;
> -		}
> +	hwpt->domain = iommu_user_domain_alloc(idev->dev, flags);
> +	if (IS_ERR(hwpt->domain)) {

Where did the user_data go???

If you are going to wrapper the op function then all the args need to
be provided.

I'm not sure there is value in having vfio and vdpa call this
variation since they won't pass a user_data or flags?

Do you imagine there will ever be a difference between what
domain_alloc_user(dev, 0, NULL, NULL) returns from
domain_alloc_paging(dev) ?

That seems like questionable driver behavior to me.

Jason

