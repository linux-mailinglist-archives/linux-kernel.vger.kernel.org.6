Return-Path: <linux-kernel+bounces-196471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A85B68D5CB7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F141F27972
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4786B145A00;
	Fri, 31 May 2024 08:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xa8AoZWH"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A06145346
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 08:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717144210; cv=none; b=PIVT5/EPlkgVLGlS5nTAivhxBxEUmiL0bSDtp35YozlRn5B3i9LZzgL18Dx+O9pRfGDSRcts7qD8TJUuYRcrEaTvQAt4+7bSkp5X2cBQv0RaAz6BkorcflTvLGtlzTAiAVm0glmn3Ntc4jz5TSBdXil9DWZYRoNGM8MenyAn4WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717144210; c=relaxed/simple;
	bh=JwEvemvtK/1wTfGHg6yJ3qXXIAH7p/eOW9e9F+pMgE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCg1JQarqj/iFZsTnHcKHPwXIoMmXS48fXjkEGScYuy2c9/mdaa/lOv9myd5khDZ75TJPAPqyakfnkgYPgH2UiHFAWnjXfWq/qxzjTfeweu/QsYDrUjeiRqg9yJdW+Ox2MliOMACkmB50bSr3fB64vSk5l7IZ+5EpvY7iJGb1Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xa8AoZWH; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e6f33150bcso18740081fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 01:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717144206; x=1717749006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HcAJw5T3D3kyswsNGvVslEG9tp9kD/iRcABuGT3i7lY=;
        b=Xa8AoZWHkP5lPgqj+ViPE2iTOG7SGWE/g6EbHs5Rp/2eIfgGqzrp1e7sBOSprExQCi
         RBqoFBLAS/AVbxmUjSS+emGRy/pbN8j45lVCIp287CfPDkfVSr0fkoydRYf4dWTIcITF
         kXS5ddbzUhAyndj9+a7kQkpLs1ee19tN14R6+CjugmEaC59M01suilaDX4+YzHx6l7US
         dF8Qu8G+3jgLjZ3QcYv5AtmnZKmVETyl298BlCoNjkL9bewDD3BpZcIkHO249NFNntQ7
         XmXFWDhjlKun76B+tR66TaV4yKknOcHdNU7y+1sbKlywNwSmDbV3dXHc5PKePz7GYwQW
         9CtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717144206; x=1717749006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcAJw5T3D3kyswsNGvVslEG9tp9kD/iRcABuGT3i7lY=;
        b=VeXp/aa8iMilcpA3aRsj0xKyPp9OrgKxynAXhbbiVcQ/pxzDZm24GLIQfMsIvo/Lai
         ZlkcWZY6m83i52cWQSc8lr5EGKDtAmSdjWV7zE74doGjEv6LPqKkAB0lSpOihFglqZn/
         WGgS5uvFCYv5mZmLh/nDO2sd6JT2dPJ9AjEWgwkuliozPwecELyM77f+Bt9nnZldIBuD
         LapewLyWw5CgsVfYUdcuCKFifgKQ6nb8dPovRWrgWfQ/8cUoaG1l6LTKGMEeioK2c57k
         UpMLysJ1aXawMJ83B+Brkq0K6LAueW1pMDR8xXCG69ugLQrO86xr9HMEvZSne4l781X/
         48Ug==
X-Forwarded-Encrypted: i=1; AJvYcCXEQUUoQvestGdXGUYbJQqqqXmogdNJxdgDu1BH/IlfMUG6xSmnYHixqk0eKU+bSB6CVSLZczNVFjSFFLq+12CyvB6UVH2mSkz68hZI
X-Gm-Message-State: AOJu0YysotOQE8N6AVxbh2Jqn7axSZguz8SKSrTJyVwrJEkSQ5EYYfNV
	FC9tw9C7jHvBP/yIeCGQeQIlxpPl/9zhUYUcWm//ypJUPItlDcfjO0Cpu1Wo86M=
X-Google-Smtp-Source: AGHT+IF3eVe9jEydIDWHlerWPOn8og1StxlgIvlxcfACNv4BlCP8zs9gy4BRbJwlet+sV0prmpPQJA==
X-Received: by 2002:ac2:4d92:0:b0:52b:3f91:fa62 with SMTP id 2adb3069b0e04-52b8958c003mr794238e87.30.1717144205906;
        Fri, 31 May 2024 01:30:05 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d8974esm253556e87.256.2024.05.31.01.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 01:30:04 -0700 (PDT)
Date: Fri, 31 May 2024 11:30:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
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
Message-ID: <nxd4bnlpu75fdpbehufdorl43ehwkhshah3q5dqjktqfy74yco@55vueuzpaakn>
References: <20240529053250.91284-1-baolu.lu@linux.intel.com>
 <20240529053250.91284-7-baolu.lu@linux.intel.com>
 <jd7df7jshswukstxwbfoxuswyltyemdmkx272i5mpldlfsk4t7@ad36olyvmw27>
 <960bfc23-22b3-48d1-baa6-2707767875c5@linux.intel.com>
 <CAA8EJppZU5yy4g85oMWzV_O9Qo91-Cr6d+W9Rz+K+mS6tfU8kw@mail.gmail.com>
 <dda59cd5-b227-4f42-a7f2-b9fe03e1b020@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dda59cd5-b227-4f42-a7f2-b9fe03e1b020@linux.intel.com>

On Fri, May 31, 2024 at 09:57:54AM +0800, Baolu Lu wrote:
> On 5/30/24 3:58 PM, Dmitry Baryshkov wrote:
> > On Thu, 30 May 2024 at 04:59, Baolu Lu<baolu.lu@linux.intel.com>  wrote:
> > > On 5/29/24 4:21 PM, Dmitry Baryshkov wrote:
> > > > On Wed, May 29, 2024 at 01:32:36PM +0800, Lu Baolu wrote:
> > > > > The domain allocated in msm_iommu_new() is for the @dev. Replace
> > > > > iommu_domain_alloc() with iommu_paging_domain_alloc() to make it explicit.
> > > > > 
> > > > > Update msm_iommu_new() to always return ERR_PTR in failure cases instead
> > > > > of NULL.
> > > > Please don't mix unrelated changes, because ...
> > > > 
> > > > > Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> > > > > ---
> > > > >    drivers/gpu/drm/msm/msm_iommu.c | 8 ++++----
> > > > >    1 file changed, 4 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
> > > > > index d5512037c38b..f7e28d4b5f62 100644
> > > > > --- a/drivers/gpu/drm/msm/msm_iommu.c
> > > > > +++ b/drivers/gpu/drm/msm/msm_iommu.c
> > > > > @@ -407,9 +407,9 @@ struct msm_mmu *msm_iommu_new(struct device *dev, unsigned long quirks)
> > > > >       struct msm_iommu *iommu;
> > > > >       int ret;
> > > > > 
> > > > > -    domain = iommu_domain_alloc(dev->bus);
> > > > > -    if (!domain)
> > > > > -            return NULL;
> > > > > +    domain = iommu_paging_domain_alloc(dev);
> > > > > +    if (IS_ERR(domain))
> > > > > +            return ERR_CAST(domain);
> > > > > 
> > > > >       iommu_set_pgtable_quirks(domain, quirks);
> > > > > 
> > > > > @@ -441,7 +441,7 @@ struct msm_mmu *msm_iommu_gpu_new(struct device *dev, struct msm_gpu *gpu, unsig
> > > > >       struct msm_mmu *mmu;
> > > > > 
> > > > >       mmu = msm_iommu_new(dev, quirks);
> > > > > -    if (IS_ERR_OR_NULL(mmu))
> > > > > +    if (IS_ERR(mmu))
> > > > >               return mmu;
> > > > NAK, not having an IOMMU is a poor but legit usecase for some of devices
> > > > which don't have IOMMU support yet (for example because of the buggy
> > > > implementation for which we were not able to get all the hooks in).
> > > > 
> > > > Please don't break compatibility for existing platforms.
> > > Sure. I will remove this line of change. Though I have no idea in which
> > > case msm_iommu_new() could return NULL after this patch.
> > So, even without this chunk you are going to break the no-IOMMU case.
> > Please don't. This will result in a regression report and a revert.
> > 
> > Instead please provide a way for the existing drivers to continue
> > working. For example, something like:
> > 
> > if (IS_ERR(mmu) && ERR_PTR(mmu) == -ENODEV))
> >      return NULL;
> 
> Oh I see. msm_iommu_new() returning NULL indicates a no-IOMMU case,
> right? So perhaps we can make it explicit like below?
> 
>         if (!device_iommu_mapped(dev))
>                 return NULL;
> 
>         domain = iommu_paging_domain_alloc(dev);
>         if (IS_ERR(domain))
>                 return ERR_CAST(domain);

Yes, this should work, thank you.

-- 
With best wishes
Dmitry

