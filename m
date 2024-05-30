Return-Path: <linux-kernel+bounces-195030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C8E8D4689
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB2E283E1F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 07:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521311459EF;
	Thu, 30 May 2024 07:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OYcpfuHv"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80BA143745
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 07:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717055937; cv=none; b=X34Op5RB0tgo+waxGeh3p/93qIlndQ3atOEeGu0TiUkpZTj28DTcxPFl1khXiVe1oiabKRsKZrGEfc6L7OwwhSoAs22RdaY0S2AQlrJrPwimm9bq1/0SnGCmOFAZohMinrR/1B/kiETiL2BKMKxftEBqKfhUusWIbWKMQXNwjQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717055937; c=relaxed/simple;
	bh=lmnS+uhE1B+Xtb3Jn2lTEbYhgqdcwEtClUTNalj/uSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b2l+L9GHzbCN00YSR53D4CfCmB7chF99fKigGOBZkoI5T3XgzsFHt/6JZwyYxrK7H/EHEDna9/Oz6CPBp+wJvxYoTVCjZPwr7qJon+i8eb4yrk6iJ52AwvDtRqHOeC6DNiy/kfN33LfZWRYIDEaQg6lURbsYMNOZeGhjFrcewFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OYcpfuHv; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dfa4ad7f6dfso509800276.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 00:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717055934; x=1717660734; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B+oJ9AQU1WwAFE3BTuASvQX6ynujHPOOLDvZ4IBH4iY=;
        b=OYcpfuHvJsLG9NS5r6X/psJlgl3kfnafKJ0whTUUKQZ0sHiQBy58S7nqpXG2AnmPZw
         ylfWbVNxeDJT6bW/ycY9P/f/gyG+/GswhHvyYpgpudop+17tkiaa4bvKK44zwyMh1wJp
         S+jEAquaum+7hglpejr5aEUDXAJau42VULLimhpTTOpelRBop2bLsldst6B/M2XRON4r
         W5EFVW9aZlRPPYqrPCgb8Tw4QTOX0p3qEIY/K+RHPn0nErIVt+cC82ky+dsJUrWC5mLd
         QZc1XkWwFGf5WhIYAPfd9Je9mHZD5n8zOvQn7Z0Z6hnAgTkFIWnYufFjzufuARqiNn5R
         LG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717055934; x=1717660734;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B+oJ9AQU1WwAFE3BTuASvQX6ynujHPOOLDvZ4IBH4iY=;
        b=tEUHspDgt4+ZTcJvpVQrQdheLtta9n4dtXN1EM26yA7Ck6Qq5fb3hVEz9WN+0XYJJ5
         OBQW5qtAFQqN1Si8pZDZPdznfpoPM1QKGNDNCIvNpeUuzTQqDK2Vj3YYyth9uFp16z6L
         MH/ahMiMz6aN883A9f/elVz0Zh4no0iDfLIS50awcMdn6/RsIKd4RKjCe51UUNiOJ/2a
         vDSJ0tH35sQm5vRTIzezWhegb71wG3C5kAhduPm72EuJue/bekgcSeJ1i40gSbMvQQoz
         CNV8+f2XdYSkc2PSF63fbKwrqa5QD0tSf1rmYuJxupten5k3pciearoxUgh82RjOaMJl
         9/7A==
X-Forwarded-Encrypted: i=1; AJvYcCUnKq83PjxEfqcxROOinjnJ1VQa6PBdT6KC44Pyz/FCxG0XKNRSKMho/YkYEI3+umg1EpVVyHqQN3Gj3wNf+N2zLz6yN/5YmYIun6Y7
X-Gm-Message-State: AOJu0Yx2EME/k3c43wQW3xdxkpep3sx51vqdZTsc4la4qL0QMIATCAMy
	csfRAV6YVnxBHEKP/eWc+3z82A/bOypVJ847s0YczdYVRuiD5k5ODDASJtSQ9u0vUy0II0ikhgI
	2INOJQOhPv0JbFwNgiE46i4ahjhaHXxnYpjeg1Q==
X-Google-Smtp-Source: AGHT+IHWn8jqCUpUtwn4GZB8DSUWhC0pqZv08o7PmbgCc14pEd89tke9BgPzyPGi5xXBW4hatiPVYSqRFMZI/ea2rj8=
X-Received: by 2002:a25:2e07:0:b0:de5:558c:e9b9 with SMTP id
 3f1490d57ef6-dfa5a5bb588mr1579742276.11.1717055933851; Thu, 30 May 2024
 00:58:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529053250.91284-1-baolu.lu@linux.intel.com>
 <20240529053250.91284-7-baolu.lu@linux.intel.com> <jd7df7jshswukstxwbfoxuswyltyemdmkx272i5mpldlfsk4t7@ad36olyvmw27>
 <960bfc23-22b3-48d1-baa6-2707767875c5@linux.intel.com>
In-Reply-To: <960bfc23-22b3-48d1-baa6-2707767875c5@linux.intel.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 30 May 2024 10:58:42 +0300
Message-ID: <CAA8EJppZU5yy4g85oMWzV_O9Qo91-Cr6d+W9Rz+K+mS6tfU8kw@mail.gmail.com>
Subject: Re: [PATCH 06/20] drm/msm: Use iommu_paging_domain_alloc()
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Yi Liu <yi.l.liu@intel.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Kalle Valo <kvalo@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Alex Williamson <alex.williamson@redhat.com>, mst@redhat.com, 
	Jason Wang <jasowang@redhat.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, iommu@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 May 2024 at 04:59, Baolu Lu <baolu.lu@linux.intel.com> wrote:
>
> On 5/29/24 4:21 PM, Dmitry Baryshkov wrote:
> > On Wed, May 29, 2024 at 01:32:36PM +0800, Lu Baolu wrote:
> >> The domain allocated in msm_iommu_new() is for the @dev. Replace
> >> iommu_domain_alloc() with iommu_paging_domain_alloc() to make it explicit.
> >>
> >> Update msm_iommu_new() to always return ERR_PTR in failure cases instead
> >> of NULL.
> > Please don't mix unrelated changes, because ...
> >
> >> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> >> ---
> >>   drivers/gpu/drm/msm/msm_iommu.c | 8 ++++----
> >>   1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
> >> index d5512037c38b..f7e28d4b5f62 100644
> >> --- a/drivers/gpu/drm/msm/msm_iommu.c
> >> +++ b/drivers/gpu/drm/msm/msm_iommu.c
> >> @@ -407,9 +407,9 @@ struct msm_mmu *msm_iommu_new(struct device *dev, unsigned long quirks)
> >>      struct msm_iommu *iommu;
> >>      int ret;
> >>
> >> -    domain = iommu_domain_alloc(dev->bus);
> >> -    if (!domain)
> >> -            return NULL;
> >> +    domain = iommu_paging_domain_alloc(dev);
> >> +    if (IS_ERR(domain))
> >> +            return ERR_CAST(domain);
> >>
> >>      iommu_set_pgtable_quirks(domain, quirks);
> >>
> >> @@ -441,7 +441,7 @@ struct msm_mmu *msm_iommu_gpu_new(struct device *dev, struct msm_gpu *gpu, unsig
> >>      struct msm_mmu *mmu;
> >>
> >>      mmu = msm_iommu_new(dev, quirks);
> >> -    if (IS_ERR_OR_NULL(mmu))
> >> +    if (IS_ERR(mmu))
> >>              return mmu;
> > NAK, not having an IOMMU is a poor but legit usecase for some of devices
> > which don't have IOMMU support yet (for example because of the buggy
> > implementation for which we were not able to get all the hooks in).
> >
> > Please don't break compatibility for existing platforms.
>
> Sure. I will remove this line of change. Though I have no idea in which
> case msm_iommu_new() could return NULL after this patch.

So, even without this chunk you are going to break the no-IOMMU case.
Please don't. This will result in a regression report and a revert.

Instead please provide a way for the existing drivers to continue
working. For example, something like:

if (IS_ERR(mmu) && ERR_PTR(mmu) == -ENODEV))
    return NULL;



-- 
With best wishes
Dmitry

