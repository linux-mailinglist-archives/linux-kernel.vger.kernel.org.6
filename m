Return-Path: <linux-kernel+bounces-518692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FE7A39356
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 07:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4561D17053D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 06:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2721B21B4;
	Tue, 18 Feb 2025 06:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oWus5Q8e"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E4C10E5
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 06:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739859242; cv=none; b=nlsjPehJ5CINly3d0hJMmaSFAiPSGdf3LH5ofdlsaKkd875fJcKSD3s+ovmotiQinK9MBURrxRQEKXV2OlR+xReoUS0jsRvOobD34Tf0/epvh4/VQP+yVIbbXoHllDd9O+BF4ptvmKHP1egXE0WI/VAuME+4abRz7FQiIKdM4Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739859242; c=relaxed/simple;
	bh=hVcy4H2IEVB+XHFMWtYRRE56ZgToGhgyvhsDwymurh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MXi86J3bH6PC9aPvelN9MVqCvA5lPxUZlhY7z5Nv3Rk8bvpa7YlyPDhpLloCRbeG6dU6VJl+iDJQaN6OzG0iaTWGe1iGX9T8WRWJiwk4U4DPbrIO7a7SPIPbL7RdqcpFVWHmfugPiziTzyN4RxiXn0Em5mr/atbXDdM/f3pbCJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oWus5Q8e; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30738a717ffso45334721fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 22:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739859238; x=1740464038; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nEc4icc+V5ZPPfKvc/Cq3TepJhiS7Md9sMuuln31gC4=;
        b=oWus5Q8eL1FwXLFuvgCp6mD2asgYVMZw9LAH3ySjK+axI93yeKu6kPEovwns9c3BDR
         To2aDzzb0DhXRmJll4N5PIqYoQHYNNmwWuHiC8PMCO3CckoUAgYsFM1qKBZ5XDciN1NI
         eD6lH5+bcURNLJYKSNw2hx9bL9BARxTIbLkOYKUvJidvi+KRFRV/cPNkPg3rWlh0UvxO
         pHd1xt9Shtl/ls7GWSyqhuz0TSTAbEezk7qL2xuW17gVo6AUaVSEAxLwVMRkxgNPTUre
         6pOA/iTDaB1ZOoyQSFHSF9mgD3oRZGyGhiZULVAAFNxwvOyqm8kHvImQgR62KB9JEm50
         f9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739859238; x=1740464038;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nEc4icc+V5ZPPfKvc/Cq3TepJhiS7Md9sMuuln31gC4=;
        b=owYFHo6I983wOCgHR+WTKp3x31Hz69f1E75ycQMT3vuoU92XMOpYZNSAqVCygphvj1
         NQw7YI8EYL+vNvwvcuKpgkrHzRrI8S1JkKISu7rYcFigY1YxZ3RxbpuNrfJQ+FfT2yrY
         paBBL2VGM1Rf9K3BBXt7qhoT77avRNNnvDYv+JatcP9Jefe1NsP6O5ZtuDC1H7OOIYSx
         ndLGSgGNHpoV8OWOXiQUswRnjcvijJub0p0P7+YTEC7NYGHX8fzceqEFEd0K/hhyXzRt
         gbhCIjZH5hcZKJStzPmAN23OTn/DETyB6dgIT2tzzfKNq3ZieIvN+/3n3Aowa000YQx9
         JvSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwz66BMLe111IKJ/DHYoBythWBVJaOnGIbxlFQPAM308iIO/Q2fhjqKmuUi3sPEPardfP8lss7Kuzacq4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh0kxUuICbHjg6kxQodDk2hFJQVWrPH8EHqA2dwJ3rD06x8rb/
	bxvAaUzwZmgsVi7HKrb90xfFz/+kGJ2htqnrWiht/l9TDYtUPDIDOiKYs64d5aDU+RKs3icw9a6
	GU7ph6SwF/GmJbiM+IU5N+XVypqDM0mdHndnA5w==
X-Gm-Gg: ASbGncu2I+JuZjVWnR0H5uFyHnAl+cA8oZUi7Kt/n56S7Ci+F+ji9KEo+ywRtUbHWpi
	COHg4pJRT3WrgdSIKj68IodV+iCaSMOtBwurxcWZ5J4GAKqMCTZl+gaIU+bw/JQspf9zT5DZ+qN
	heRg==
X-Google-Smtp-Source: AGHT+IGBnxV3A4fhFUnb/sWJwgjsPIGI3fMQv4R99e7iyC/siM8fZi3MPJJb3XWXEOOrUXjgAuq2qG6TbZLfomOye2s=
X-Received: by 2002:a05:6512:238a:b0:544:fd8:7911 with SMTP id
 2adb3069b0e04-5452fe5809dmr4413315e87.21.1739859237942; Mon, 17 Feb 2025
 22:13:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
 <CABQgh9FMy7oVt9+enSpJxXvkux+czMFqbsPZVgmBV+rFWWvhGA@mail.gmail.com>
 <20250214125600.GA3696814@ziepe.ca> <CABQgh9FQYe46hfjcs+o6GfLaS7OfSqrmvXUzOKd6PRK8oBF8Jw@mail.gmail.com>
 <d578bf4c-f475-42bf-9cb8-21941fc7af88@linux.intel.com> <CABQgh9EG3gjtw19qvr7OhxKmR8E6+xwBf9b3=WPNrXRc-m9DjQ@mail.gmail.com>
 <59998dcc-9452-4efd-be69-d95754217633@linux.intel.com>
In-Reply-To: <59998dcc-9452-4efd-be69-d95754217633@linux.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Tue, 18 Feb 2025 14:13:46 +0800
X-Gm-Features: AWEUYZl1Rez6pOagZuYfJjoOHu3GPR0mT83Dre02yBKbeel0GOt3_-q28p2n_SQ
Message-ID: <CABQgh9H8KOr9M6pBgtC=zT_buuc+qWZc8345Qd8sZVqsLmiFNw@mail.gmail.com>
Subject: Re: [PATCH 00/12] iommu: Remove IOMMU_DEV_FEAT_SVA/_IOPF
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Fenghua Yu <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Vinod Koul <vkoul@kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Feb 2025 at 11:00, Baolu Lu <baolu.lu@linux.intel.com> wrote:
>
> On 2/15/25 19:35, Zhangfei Gao wrote:
> > On Sat, 15 Feb 2025 at 18:09, Baolu Lu<baolu.lu@linux.intel.com> wrote:
> >> On 2/15/25 16:11, Zhangfei Gao wrote:
> >>> It does not relate to multi devices, one device also happens when user
> >>> page fault triggers.
> >>>
> >>> iopf_queue_remove_device is called.
> >>> rcu_assign_pointer(param->fault_param, NULL);
> >>>
> >>> call trace
> >>> [  304.961312] Call trace:
> >>> [  304.961314]  show_stack+0x20/0x38 (C)
> >>> [  304.961319]  dump_stack_lvl+0xc0/0xd0
> >>> [  304.961324]  dump_stack+0x18/0x28
> >>> [  304.961327]  iopf_queue_remove_device+0xb0/0x1f0
> >>> [  304.961331]  arm_smmu_remove_master_domain+0x204/0x250
> >>> [  304.961336]  arm_smmu_attach_commit+0x64/0x100
> >>> [  304.961338]  arm_smmu_attach_dev_nested+0x104/0x1a8
> >>> [  304.961340]  __iommu_attach_device+0x2c/0x110
> >>> [  304.961343]  __iommu_device_set_domain.isra.0+0x78/0xe0
> >>> [  304.961345]  __iommu_group_set_domain_internal+0x78/0x160
> >>> [  304.961347]  iommu_replace_group_handle+0x9c/0x150
> >>> [  304.961350]  iommufd_fault_domain_replace_dev+0x88/0x120
> >>> [  304.961353]  iommufd_device_do_replace+0x190/0x3c0
> >>> [  304.961355]  iommufd_device_change_pt+0x270/0x688
> >>> [  304.961357]  iommufd_device_replace+0x20/0x38
> >>> [  304.961359]  vfio_iommufd_physical_attach_ioas+0x30/0x78
> >>> [  304.961363]  vfio_df_ioctl_attach_pt+0xa8/0x188
> >>> [  304.961366]  vfio_device_fops_unl_ioctl+0x310/0x990
> >>>
> >>>
> >>> When page fault triggers:
> >>>
> >>> [ 1016.383578] ------------[ cut here ]-----------
> >>> [ 1016.388184] WARNING: CPU: 35 PID: 717 at
> >>> drivers/iommu/io-pgfault.c:231 iommu_report_device_fault+0x2c8/0x470
> >> It's likely that iopf_queue_add_device() was not called for this device.
> > iopf_queue_add_device is called, but quickly iopf_queue_remove_device
> > is called during guest bootup.
> > Then fault_param is set to NULL.
> >
> > arm_smmu_attach_commit
> > arm_smmu_remove_master_domain
> > // newly added in the first patch
> >         if (master_domain) {
> >                    if (master_domain->using_iopf)
>
> It seems the above check is incorrect. We only need to disable iopf when
> an iopf-capable domain is about to be removed. Will the following
> additional change make any difference?
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 28e67a9e3861..9b9ef738d070 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2822,7 +2822,7 @@ static void arm_smmu_remove_master_domain(struct
> arm_smmu_master *master,
>          spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
>
>          if (master_domain) {
> -               if (master_domain->using_iopf)
> +               if (domain->iopf_handler)
>                          arm_smmu_disable_iopf(master);
>                  kfree(master_domain);
>          }

Yes, good idea, using this can solve the issue.

Thanks

