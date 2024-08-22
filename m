Return-Path: <linux-kernel+bounces-297630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE86795BB9F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74D811F266B3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6821CCEC1;
	Thu, 22 Aug 2024 16:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ErMl/PT0"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22811CCB42
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 16:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724343483; cv=none; b=Tc8ER70ZVRBnXExmvxKIu1/2x39JXM+6gFKq+KYO8Vi3OAXCB/HTYDEBKSdI7bpLUVTzRojn0QJjT90Iz1mTuFGpTyJ97iTNmELR3ni2ZgaQS49oU4WmJFh46rEZlzi7lKp5pLHkyAVaqyN15Fbba0D7R4UAqs53yroaeDfGK8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724343483; c=relaxed/simple;
	bh=pzVZClyB/Tio3abHqD3qwB+FNWLpxRxIcAYuvZ9PxoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEceucC1BGvqaSHCKFFPTOHnD5NSEGLqgr++9tPB0uPkd4FjRt12mKgHer3I6uLNMhJVyZzpmR4DzsOpGBk4imaVjAkrPauscxFvOrrnI58zA+gqQ3OYGR0+snSrc889+v1FnWDuK+0IyPk5zCS6MHRRurCNgmY5GZerdS/BszM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ErMl/PT0; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-714263cb074so901484b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724343481; x=1724948281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fw2jQnFKYplOXyWl2+iotSK1aecdZdvMgRYo2XdZaM4=;
        b=ErMl/PT0YOutdQu/tK4s0MN0tuyweMWELAxXPTSoD7aiVIDUsMa7Wh0lOGpcttSx7M
         u22NJPPEQeNUHF0UVTvWzUP5/tQ8lTw8Ul/bjy93D1y3PUbI3HDQNaDuzrHeDC0Sajqj
         PLfM4+MwDyI2MuWTK7gKdIwgMFvCvqhAbaV9UImWxGpu7lmuQLEGyp+BtWP12JZhjanU
         JCnh8Uui/d1ohENImurllQ5Xxsd66ogl0R58SGbACt6TTHEKy5kNGl/2d4WVzjJLEaDe
         qNWMuND1c7adEcOIPvrBmS5XTTp8PYfn8gChhI7subP5ASanjngahamf5mAIgWgfDdsh
         Pj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724343481; x=1724948281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fw2jQnFKYplOXyWl2+iotSK1aecdZdvMgRYo2XdZaM4=;
        b=YiRkrtnIjN2o2AEA3hOgpbGe5t3vJqpGBX2sUodSJzoW8NWoV9k1Mlqroi4+6Y6MpM
         MnbAavKGHkVntRdAu88U7GVsUfygIExmE/28T8Uo7vmgQekRye3/s2+31T2xRm/Y2H5d
         ZYV5+Y1D6nut8iaibFWBoBxaWENYnYaLrtxsGi2gwI/uUgcjv3u+C28qzL0kCTRlGWWa
         ojmTS/R15ZGBRaNpP6Rjig354ajx0HQGhuZf5QgYNtMdYb7NOR58fwrNQTPwEePaV7OQ
         zm2cXfmWPlkfgKVCCC+MPXfGGR/XCTV42JKAPXeoBZfNlhHD+cgOYdFl2m0pjlDFHbOG
         VDLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpt3BCtO/QL430Z/7h3K5EATlSreR9ZLDfh5f+nS7npUmEUkSwk1vysk7PCKMfy2jI+5f2ESOIvAifrhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXk8SZx+zGrkfeBynxFXixQGQFwSQ6ckuTV7sVnNPcDVCU+tx1
	tvFsduUQjUr1KIoffQ/N5C2/qYHxBbEy+q0JWAuFmu/J/u2YsjsDBUJdFJpQO+g=
X-Google-Smtp-Source: AGHT+IGuZxjm5RjDz4gxgtOdv4bxrkYUPOtjFJ+HJu04rbWtzx4ldCQFpMKwqAlGokpUal4t0n5B6w==
X-Received: by 2002:a05:6a20:9f9b:b0:1c4:9ef6:499b with SMTP id adf61e73a8af0-1caeb21cd5fmr2760744637.29.1724343480886;
        Thu, 22 Aug 2024 09:18:00 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:778:8246:31d8:e3fd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9acdb54asm1563295a12.42.2024.08.22.09.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 09:17:59 -0700 (PDT)
Date: Thu, 22 Aug 2024 10:17:56 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Lu Baolu <baolu.lu@linux.intel.com>, andersson@kernel.org, afd@ti.com,
	nm@ti.com, hnagalla@ti.com, b-padhi@ti.com
Cc: Bjorn Andersson <andersson@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	linux-remoteproc@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 1/1] remoteproc: Use iommu_paging_domain_alloc()
Message-ID: <ZsdktJEqR9BOgivK@p14s>
References: <20240812072811.9737-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812072811.9737-1-baolu.lu@linux.intel.com>

Hi Baolu,

Sorry for the late reply, this slipped through the cracks.

On Mon, Aug 12, 2024 at 03:28:11PM +0800, Lu Baolu wrote:
> An iommu domain is allocated in rproc_enable_iommu() and is attached to
> rproc->dev.parent in the same function.
> 
> Use iommu_paging_domain_alloc() to make it explicit.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Link: https://lore.kernel.org/r/20240610085555.88197-13-baolu.lu@linux.intel.com
> ---
>  drivers/remoteproc/remoteproc_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index f276956f2c5c..eb66f78ec8b7 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -109,10 +109,10 @@ static int rproc_enable_iommu(struct rproc *rproc)
>  		return 0;
>  	}
>  
> -	domain = iommu_domain_alloc(dev->bus);
> -	if (!domain) {
> +	domain = iommu_paging_domain_alloc(dev);

I'm a little hesitant here.  Function iommu_domain_alloc() passes NULL two the
second argument of __iommu_domain_alloc() while iommu_paging_domain_alloc()
provides a 'dev'.  I don't have any HW to test on and I am not familiar enough
with the IOMMU subsystem to confidently more forward.

I am asking the Qualcomm (Bjorn and friends) and TI crew (Beleswar, Andrew,
Nishanth and Hari) to test this patch on their IOMMU devices and get back to me
with a "Tested-by".

Thanks,
Mathieu

> +	if (IS_ERR(domain)) {
>  		dev_err(dev, "can't alloc iommu domain\n");
> -		return -ENOMEM;
> +		return PTR_ERR(domain);
>  	}
>  
>  	iommu_set_fault_handler(domain, rproc_iommu_fault, rproc);
> -- 
> 2.34.1
> 

