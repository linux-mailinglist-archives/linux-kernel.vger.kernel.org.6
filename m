Return-Path: <linux-kernel+bounces-519729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEDEA3A11E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50069188B89D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1135326B968;
	Tue, 18 Feb 2025 15:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CkvDRe0Q"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC4426B09B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739892377; cv=none; b=DFCQ3R+V3EZX+IteLGG9F8yrD+I9I26EGe9Z8yphtI7hMe6/Q/KNa6TsMjP7Ll978dJbLzGuQMiFqIJ7ekxlcBKXUcAlvsJqOupMz+QGlqETgSPWidEV1Mn9ARmbsfAkYRzYR8YRswW2kQ2T+45BbOPhoXbpKoDov1wY5IISAgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739892377; c=relaxed/simple;
	bh=MCi6w4bTzGOR3Wha/BNrzSMV7m4Lutseslj+c3YlFwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gE4mI+LxP/rEgC1XWRwRfICxurcgXE4lN1tcKHnOQ4GOslv3T36xIwYP108ZyN+M7GzsEcWFxacu9NnS3cm3j2fIapfQVpLZpWYi4JbdtJSnRrOUnM9NNCa77viR5f/61qjTlJJ5VLvvmWUK0LmotbeNJiRUyJEdbuqutpwoxhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CkvDRe0Q; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54298ec925bso7620891e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 07:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739892372; x=1740497172; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m5Ga61njTpPCrxXTVKsM0RIsYFLUCCHcjVUbSQ/1z+4=;
        b=CkvDRe0Q44YblgTpVCC/qRLYPBxQ4ncsti3WQNJnbkn/og4BdMrzELBQnh8rcIidhm
         4i7irmXSg9wf6zthrmPa3D6jWIdl5SLWuCS4wR0xyc3gOh0kZO6x0NAo3TSlhvMsAUHq
         nes4VPX1jwURNhpNC2YFbcQQnAyvjKBn2NJQCVbwxhQuiQ72mfUBWYKtSoFTyl7N2IHB
         pJIk03MWvHm6bniQoiOF4d5QEyC7kC4huUk70Na+XBmuGRwOsP0D16bx0GQeEIH+HK76
         xYEpWque9mX66dFXF7r1D4Lmhg2GKbpzAUZas7rAu5Igj+M/y8Ekza9fOjb8IqjAZF6F
         rC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739892372; x=1740497172;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m5Ga61njTpPCrxXTVKsM0RIsYFLUCCHcjVUbSQ/1z+4=;
        b=cQZociqEpkRB5flln7BRpSz7qZt0IclVMstKJ6DyJsHV/rC8FTOaIc0tJebFwPP/iV
         qX9qKmqlqK/6X0FNsDM9Z21TWTzIexJzCkUnF6a3sGGSRWjyVTWGMA3zPMnpBDkb4643
         ZajFgDsSmHMF+yAmuYt3STmFqkSQWrvwF8W7eTqEW3JrMAwTyXUJMYHvGt0VDy6zbCqk
         FLz0K63JV+Pby+0FDOq8gYbTeuBAsv+gFcwP6WFmEFBDweAxxOM5DOYWT/y7aXfYWJWI
         SzbVxWGri0IDG8lmTtslplGWCAJZSxs79Ty9NgmujRZFVQ496G8wM+F3VTUHdjLPbay6
         TSyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1ptkAgJH+5uAtSxG1eUUBswVnVhSWOh2HwMF/VivOQFa/+XQxoTLmpvbhjDSfZHjK63yShVpKcm8UUW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSFFZNwo6XzqH0FZ1Qi2WbwUA4hmzW3OcbTzD0S8rSkTU/CBRW
	UvSj3IgowsKkN2WwZdMZNhWHRNnyTahVbM7SFYQI/ku8sA1XaI1/uD2vCzyp0/fdePmFz2fVRJY
	3t6amdJh47jJWnEmZ3BNXwP94joV8Hn2zldyf6A==
X-Gm-Gg: ASbGncsoDGZXqmVy6Mo7kBIoCsnlpLUPrb3EsYydvIZvXBWoN21eEvbfZCivP7wMT2s
	MFnaC66Rclm07CUMbQSv1MmKRoZKhfXx9I06kfrrHRj2lbNFHZ1hEKV8oml+Y3PoMyQlqHgiKUC
	aDtg==
X-Google-Smtp-Source: AGHT+IH8pCmfi2PSTZAmBnxMxqqDtBr16ztofGPEUCTYq3P+aAdcKiiIKWURTu/8bUMDz3tTznp1CLomuFw6HzeMo+c=
X-Received: by 2002:a05:6512:1194:b0:545:102f:8788 with SMTP id
 2adb3069b0e04-5452fe485d4mr4931866e87.19.1739892371858; Tue, 18 Feb 2025
 07:26:11 -0800 (PST)
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
 <59998dcc-9452-4efd-be69-d95754217633@linux.intel.com> <20250218135751.GH3696814@ziepe.ca>
In-Reply-To: <20250218135751.GH3696814@ziepe.ca>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Tue, 18 Feb 2025 23:25:59 +0800
X-Gm-Features: AWEUYZlCViN7Fq8OiDjDAR35ARLZ8ZNefZPCAbiMMiPjkQC6-Y46tHYfRJj5JAg
Message-ID: <CABQgh9F8BJr_bkEQD6s6DSsLw2jwpgq-p73YL=439_WwH8P5zw@mail.gmail.com>
Subject: Re: [PATCH 00/12] iommu: Remove IOMMU_DEV_FEAT_SVA/_IOPF
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
	Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi, Jason

On Tue, 18 Feb 2025 at 21:57, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Feb 18, 2025 at 10:57:30AM +0800, Baolu Lu wrote:
> > > > > [  304.961340]  __iommu_attach_device+0x2c/0x110
> > > > > [  304.961343]  __iommu_device_set_domain.isra.0+0x78/0xe0
> > > > > [  304.961345]  __iommu_group_set_domain_internal+0x78/0x160
> > > > > [  304.961347]  iommu_replace_group_handle+0x9c/0x150
> > > > > [  304.961350]  iommufd_fault_domain_replace_dev+0x88/0x120
> > > > > [  304.961353]  iommufd_device_do_replace+0x190/0x3c0
> > > > > [  304.961355]  iommufd_device_change_pt+0x270/0x688
> > > > > [  304.961357]  iommufd_device_replace+0x20/0x38
> > > > > [  304.961359]  vfio_iommufd_physical_attach_ioas+0x30/0x78
> > > > > [  304.961363]  vfio_df_ioctl_attach_pt+0xa8/0x188
> > > > > [  304.961366]  vfio_device_fops_unl_ioctl+0x310/0x990
> > > > >
> > > > >
> > > > > When page fault triggers:
> > > > >
> > > > > [ 1016.383578] ------------[ cut here ]-----------
> > > > > [ 1016.388184] WARNING: CPU: 35 PID: 717 at
> > > > > drivers/iommu/io-pgfault.c:231 iommu_report_device_fault+0x2c8/0x470
> > > > It's likely that iopf_queue_add_device() was not called for this device.
> > > iopf_queue_add_device is called, but quickly iopf_queue_remove_device
> > > is called during guest bootup.
> > > Then fault_param is set to NULL.
> > >
> > > arm_smmu_attach_commit
> > > arm_smmu_remove_master_domain
> > > // newly added in the first patch
> > >         if (master_domain) {
> > >                    if (master_domain->using_iopf)
> >
> > It seems the above check is incorrect. We only need to disable iopf when
> > an iopf-capable domain is about to be removed. Will the following
> > additional change make any difference?
>
> The check looks right, it should only disable if it was enabled? The
> refcounting is what keep track of the 'about to be removed' and it
> should  be that using_iopf and domain->iopf_handler are mostly the
> same.
>
> Hmm, I think the issue is related to nested
>
> to_smmu_domain_devices() returns the S2 parent for the nesting domain
> always
>
> Which means the smmu_domain->devices list (on the s2) will end up with
> two entries for the same SID during the replace operation at VM boot,
> one with faulting and one without.
>
> I think that arm_smmu_remove_master_domain() will end up removing the
> wrong master_domain because arm_smmu_find_master_domain() can't tell
> the two apart.
>
> When I wrote this there was no nested and the list devices list was
> unique to each domain, so everything inside was the same.
>
> Like below?
>
> Jason
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index b14f1d0ee7076b..dc8708b414468e 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2710,10 +2710,9 @@ static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
>         pci_disable_pasid(pdev);
>  }
>
> -static struct arm_smmu_master_domain *
> -arm_smmu_find_master_domain(struct arm_smmu_domain *smmu_domain,
> -                           struct arm_smmu_master *master,
> -                           ioasid_t ssid, bool nested_ats_flush)
> +static struct arm_smmu_master_domain *arm_smmu_find_master_domain(
> +       struct arm_smmu_domain *smmu_domain, struct iommu_domain *domain,
> +       struct arm_smmu_master *master, ioasid_t ssid, bool nested_ats_flush)
>  {
>         struct arm_smmu_master_domain *master_domain;
>
> @@ -2722,6 +2721,7 @@ arm_smmu_find_master_domain(struct arm_smmu_domain *smmu_domain,
>         list_for_each_entry(master_domain, &smmu_domain->devices,
>                             devices_elm) {
>                 if (master_domain->master == master &&
> +                   master_domain->domain == domain &&
>                     master_domain->ssid == ssid &&
>                     master_domain->nested_ats_flush == nested_ats_flush)
>                         return master_domain;
> @@ -2812,8 +2812,8 @@ static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
>                 nested_ats_flush = to_smmu_nested_domain(domain)->enable_ats;
>
>         spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> -       master_domain = arm_smmu_find_master_domain(smmu_domain, master, ssid,
> -                                                   nested_ats_flush);
> +       master_domain = arm_smmu_find_master_domain(smmu_domain, domain, master,
> +                                                   ssid, nested_ats_flush);
>         if (master_domain) {
>                 list_del(&master_domain->devices_elm);
>                 if (master->ats_enabled)
> @@ -2889,6 +2889,7 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
>                 master_domain = kzalloc(sizeof(*master_domain), GFP_KERNEL);
>                 if (!master_domain)
>                         return -ENOMEM;
> +               master_domain->domain = new_domain;
>                 master_domain->master = master;
>                 master_domain->ssid = state->ssid;
>                 if (new_domain->type == IOMMU_DOMAIN_NESTED)
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 5653d7417db7d9..fe6b88affa4a60 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -907,6 +907,11 @@ void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
>  struct arm_smmu_master_domain {
>         struct list_head devices_elm;
>         struct arm_smmu_master *master;
> +       /*
> +        * For nested domains the master_domain is threaded onto the S2 parent,
> +        * this points to the IOMMU_DOMAIN_NESTED to disambiguate the masters.
> +        */
> +       struct iommu_domain *domain;
>         ioasid_t ssid;
>         bool nested_ats_flush : 1;
>         bool using_iopf : 1;

I have tested it, and it solved the issue.

Thanks

