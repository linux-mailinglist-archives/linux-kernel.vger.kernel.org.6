Return-Path: <linux-kernel+bounces-367098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E07499FE96
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 994BAB21410
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 01:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E32614BF8B;
	Wed, 16 Oct 2024 01:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tecAsPLd"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51E7FC0C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 01:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729043931; cv=none; b=Veos+bjOM5QngXh2KMKg8z5JZUOfkkwYA+n37X9sJZHG5PPYR8wGDpBMvkDKLbksf0kw1GmXA1yklK2+tLoRwLVNcc28jrI1ay30MHeGg0K6XNiA4aR1okLO7NS9swx7KKJ1J+lNw3nWzpgO9SA5p45LQX4+dB4WvzGahmrMFdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729043931; c=relaxed/simple;
	bh=dVq8802sNgxsYQrKPhpLGl2Ji48gzebkMI0KMfI8BG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eptjHVXWx57uRvErY6z7USsu4mCkScZr4Ld3IUBFEWeZO1OBaScUXopNz2Xn0R7f4P41r76y13bs82bIdaD1l2cf8oz+0yU2mTHZ/1M3YJNcE3u86SS7iYNGwZuGb/k6j9Zyzqm408L+M9NLlNQhsW+0X/e/cR0MmwodQiySVkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tecAsPLd; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539f53973fdso353601e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 18:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729043928; x=1729648728; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A/rtU2ORxq4VQYJugdVXcy5ZyrAZXc1jQ9TPE/XvnVI=;
        b=tecAsPLd20QZc5wk8fHAvO3DLTbB+lJNu9sxHy6f4GrmlEIqrtCxeuqC73hk8DI159
         5V7WQICOJ2gRoGBhMRrsVA2JNGdBbUcFgi6mSssbx7eweshu+tixhuL06swJpH8c61uR
         03rFQWXUCpYJt7XydnmkfYxTAu43akUa1LLfADEmwCTTpuNUVUNcWc3oWy55Wtr93qb3
         wxYyIVjJxnrw5/9Q9wVhLfE+g2XhKi1W2A4SjSXmBr4USPxaBQInKDrGjJLwFm02ingA
         vGQ1nMUTbIw108isrdMS9HtdsdE3O/cVkec6QAxdlqIZB2I+zKCACKKhhSylNHZ+Uxxw
         wMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729043928; x=1729648728;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A/rtU2ORxq4VQYJugdVXcy5ZyrAZXc1jQ9TPE/XvnVI=;
        b=pR2mK3gkZ9evcthfvTE12yEFkgKY8sqkPFenWb6BEzwRZ52DgHZehvTHEUfR9+BljB
         6jEEn0pg4qJv0DLMM9X3gdieYgRp9Sndn9q78IHo5fvGz0sQu+CxM4t4uGjEXPBRTXCG
         uHMGg5HyOvjhRGJIyOLyBGcDmZ9AFa/NPSbxLFLmST7XYyQ9jq26ulWh3tvk8ya5HVGz
         GV4nqklcbfM93JBWTGVv00ZOYTn4gVCLlhKvdo2sDXwMnWIauBoTtuLF/xr87C1my0F5
         pseEZ4UC4WFiQy3TpI7Q9+/H2C8916NeNiTKAd0rCPx+ooGOfN+wPhSAKrRh8wlku3E0
         8YYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMKycBAZyhu8sTS6Nqsi1Qco8wICJEIb0SYBNng+03wUZeBZVWd8LQColDzwncbFQQVqYxfukUS0qGhzE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb2krV+cV4y9UMlbO1SoQm68DzxjRUWxM6S0mtmjpUti8TCs70
	PF5GG1Kve7BpdYCVI0+Akrpzcv5MhQSD/c+3hhAoEuAXJXfZH+/PZ/GFhOeTKLs1Jnpvr70ycqN
	3+4Byp1iXPDK8eI0BluI8WABrxTdnQtOK+NxPQw==
X-Google-Smtp-Source: AGHT+IEB/XndljAYmvf9daRxR8zUkYMGinPm83aD1j6YhAnINHWEAphdGASnRtu0uajjdc4lTF2hFS3dM0SJE/wV/i4=
X-Received: by 2002:a05:6512:3a94:b0:539:fc1b:36d1 with SMTP id
 2adb3069b0e04-53a03c8fc81mr731316e87.6.1729043927809; Tue, 15 Oct 2024
 18:58:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-8-baolu.lu@linux.intel.com> <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>
 <20241015125420.GK1825128@ziepe.ca>
In-Reply-To: <20241015125420.GK1825128@ziepe.ca>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 16 Oct 2024 09:58:36 +0800
Message-ID: <CABQgh9E+AnuyJgcM9tf1gEOUqcC_QSrA__Xha9sKYZp=NVRwhQ@mail.gmail.com>
Subject: Re: [PATCH v8 07/10] iommufd: Fault-capable hwpt attach/detach/replace
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Oct 2024 at 20:54, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Oct 15, 2024 at 11:19:33AM +0800, Zhangfei Gao wrote:
> > > +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
> > > +{
> > > +       struct device *dev = idev->dev;
> > > +       int ret;
> > > +
> > > +       /*
> > > +        * Once we turn on PCI/PRI support for VF, the response failure code
> > > +        * should not be forwarded to the hardware due to PRI being a shared
> > > +        * resource between PF and VFs. There is no coordination for this
> > > +        * shared capability. This waits for a vPRI reset to recover.
> > > +        */
> > > +       if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
> > > +               return -EINVAL;
> >
> > I am using the SMMUv3 stall feature, and need to forward this to hardware,
> > And now I am hacking to comment this check.
> > Any suggestions?
>
> Are you using PCI SRIOV and stall together?

Only use smmuv3 stall feature.

>
> > > +       mutex_lock(&idev->iopf_lock);
> > > +       /* Device iopf has already been on. */
> > > +       if (++idev->iopf_enabled > 1) {
> > > +               mutex_unlock(&idev->iopf_lock);
> > > +               return 0;
> > > +       }
> > > +
> > > +       ret = iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_IOPF);
> > > +       if (ret)
> > > +               --idev->iopf_enabled;
> > > +       mutex_unlock(&idev->iopf_lock);
> >
> > Also iommu_dev_enable_feature(idev->dev, IOMMU_DEV_FEAT_SVA); is required
> > In thinking how to add it properly.
>
> FEAT_SVA needs to be deleted, not added too.
>
> smmu-v3 needs some more fixing to move that
> arm_smmu_master_enable_sva() logic into domain attachment.

Will think about this, Thanks Jason

>
> Jason

