Return-Path: <linux-kernel+bounces-559275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA5EA5F1A5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70F903ABEA4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FA0265CD2;
	Thu, 13 Mar 2025 10:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ppwTBLzy"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755BE1EEA28
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741863489; cv=none; b=ItJnngLNlDaBEvCfpLYcsoF5ZmBMDeeA/3THHhXhUTXz6y6AWZJwG76mtD3m2yuOoqVNdAd2bx3f3HjT3B8d1o5zGXes314qSFuhFp0QTyr6PY/FSc2j+pPaRRTayINWmZtnNSVEGYA0se9OxISHKFdStxTrVWTV2Eh2i3GTx90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741863489; c=relaxed/simple;
	bh=18a6aB3ysXITDtqLaWnoSIFBLyGi0m4WbEg/Q5ny3J8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MW8RQpUAiPXU1goRBQzCAdqrbXZxeYZENRQarXTYbrIEAsn5iGJMSC2/wzobIBx7+rvHkVi4FYa8gsmBW0IleoyVj/ZA0dU61N7ZznAdSjj4vHjG9UaXfIEOEu+z3tRDphnoEszCtwvdHWvxiQGZPErEF38ekGzR20KyhpqMr4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ppwTBLzy; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5499c8fa0f3so929776e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 03:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741863485; x=1742468285; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nfraL4ls4afXFZxrK0JTl5qc8dinoEXS1gCWnzcYrdw=;
        b=ppwTBLzyMxYid5s8zTeEXZxUPAT7IcLxAEnffnqr5YpcWGbqkgPzQInDHejUtQDZEP
         n9c+sxcFV0M9geU4Y6wPJZ3gQEW1f5hAoKAW2qy8VLHapIsKw1+M8DTXm6jtGIRtP9zz
         k7xXpUna04h2pH4L5SJ9jV3kMylJ/wXUqFu60kPlG3ibxvttIx5ISWdc3IYyy70zqTd8
         X7HeSwSBLI58gXNLefGdf1X5aRPafiVOSkaY6EXnJG2E+YLUqdee2xgTBt+ervoUCen/
         IEYobEwLmdf5MufXfnDS2x4SB+Ow/GdzYJVuM7tCyZ2Ld70habVcOKzz4/MS2Kk+XEQr
         M4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741863485; x=1742468285;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nfraL4ls4afXFZxrK0JTl5qc8dinoEXS1gCWnzcYrdw=;
        b=cmo1HNzyXy3CEKwh49Lcveo6v9QVvz1/qF2mWhJyTa0VTpG1ISeRhgiExH/vUrgVGO
         03jMkrNK3ki1IMBzvpj0W3Ln7jVuR/6v6Y+DXWBH8Dsp7gCqRmk4Ldo/q6KPqEZVAuPM
         erwb/AeyN1d8rKUkRVxEkCzfYLMyxATZ+ScWeoHAHKM+Du2Xl3uOk01wzI6WWeBUEgsR
         N2G6wEif/Zfiw7foZ9gOWW8Z+dQodRWDp2YN47hmxevP/CRrzcOChVpEhYXo/Y2Azhxz
         F9w9UhCreaCDrtr9MB/896LSWn5QLGUcQsnIWlNnkV45/tihRCNKOyY1+/S60Y89jinH
         A/GA==
X-Forwarded-Encrypted: i=1; AJvYcCXos8KvJsTr5+/t92a3x7Z+sakjL96CCpUOtCtgcmIRhoxodNZLMeLU/dJPHq4014ccdQYL1+lq81As2hs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0hv4SjtJAEZ8a8lmFQ3yo2f63J49UJZliPiBEWIqBCsd7uj36
	H7pBjqV/PgcYOa3LJsiPGKVHEcdApplBmEPuhjziLJZ0tDf0ZVxtAaKpPgkhekqS86W83lKkZQ7
	B2QOBYzS6hjio5ZzWbEcbp/oyPKhArS0m7ymh/w==
X-Gm-Gg: ASbGnctTDOiYsMk75qBH/qSHhZE9fG8TYotuApdribJVIke8OKmThh0HkWfxJ7rW2lQ
	Vi1WWLhx6LLqIQPtplMr7xM4Npod+/AE5n1BuXL/gwLQIQC3l2Bi1C7H70hczH3F/rnCeO5vn7+
	p5SK5eX7IdG4nYL/lYaTnN2YwosB0tUGg=
X-Google-Smtp-Source: AGHT+IFnBWuCgWpM4+ZNcUZn/hTAnsFOuA7LoK2vMek+02/ml9yd7xOrqc8RyImF6BLtOSo2zjib5D/ShTEGIZst4OQ=
X-Received: by 2002:a05:6512:ad1:b0:545:48c:6352 with SMTP id
 2adb3069b0e04-549910cc141mr9841158e87.43.1741863485303; Thu, 13 Mar 2025
 03:58:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313051953.4064532-1-baolu.lu@linux.intel.com> <CABQgh9HKaDyDQXGB5ZEGg5q4a9ak_8OB9XQ+TpUNcZd_ZMeCAQ@mail.gmail.com>
In-Reply-To: <CABQgh9HKaDyDQXGB5ZEGg5q4a9ak_8OB9XQ+TpUNcZd_ZMeCAQ@mail.gmail.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Thu, 13 Mar 2025 18:57:54 +0800
X-Gm-Features: AQ5f1JovvZMXW9DEK2jouMs3ywPla5tfQLVxQ45E7WGPoXzvDONCBJ637fQc5_g
Message-ID: <CABQgh9G=7q+FQ0ECZ60UjawgkAM2aeNEb6hXgndEv8S9_4CuPw@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] iommu: Remove IOMMU_DEV_FEAT_SVA/_IOPF
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
	Fenghua Yu <fenghuay@nvidia.com>, Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Mar 2025 at 17:51, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
>
> Hi, Baolu
>
> On Thu, 13 Mar 2025 at 13:19, Lu Baolu <baolu.lu@linux.intel.com> wrote:
> >
> > The new method for driver fault reporting support relies on the domain
> > to specify a iopf_handler. The driver should detect this and setup the
> > HW when fault capable domains are attached.
> >
> > Move SMMUv3 to use this method and have VT-D validate support during
> > attach so that all three fault capable drivers have a no-op FEAT_SVA and
> > _IOPF. Then remove them.
> >
> > This was initiated by Jason. I'm following up to remove FEAT_IOPF and
> > further clean up.
> >
> > The whole series is also available at github:
> > https://github.com/LuBaolu/intel-iommu/commits/iommu_no_feat-v4
>
> I got an issue on this branch.
>
> Linux 6.14-rc4 + iommu_no_feat-v2
> drivers/pci/quirks.c
> quirk_huawei_pcie_sva will set dma-can-stall first
> arm_smmu_probe_device will check dma-can-stall and set stall_enabled
> accordingly.

This working branch arm_smmu_probe_device is called from pci_bus_add_device
So pci_fixup_device is called first

[ 1121.314405]  arm_smmu_probe_device+0x48/0x450
[ 1121.314410]  __iommu_probe_device+0xc4/0x3c8
[ 1121.314412]  iommu_probe_device+0x40/0x90
[ 1121.314414]  acpi_dma_configure_id+0xb4/0x100
[ 1121.314417]  pci_dma_configure+0xf8/0x108
[ 1121.314421]  really_probe+0x78/0x278
[ 1121.314425]  __driver_probe_device+0x80/0x140
[ 1121.314427]  driver_probe_device+0x48/0x130
[ 1121.314430]  __device_attach_driver+0xc0/0x108
[ 1121.314432]  bus_for_each_drv+0x8c/0xf8
[ 1121.314435]  __device_attach+0x104/0x1a0
[ 1121.314437]  device_attach+0x1c/0x30
[ 1121.314440]  pci_bus_add_device+0xb8/0x1f0
[ 1121.314442]  pci_iov_add_virtfn+0x2ac/0x300
[ 1121.314446]  sriov_enable+0x204/0x468
[ 1121.314447]  pci_enable_sriov+0x20/0x40


>
> This branch
> arm_smmu_probe_device happens first, when dma-can-stall = 0, so
> stall_enabled =0.
> Then drivers/pci/quirks.c: quirk_xxx happens

This not working branch: Linux 6.14-rc6 + iommu_no_feat-v4
arm_smmu_probe_device is called by pci_device_add
Then call pci_bus_add_device -> pci_fixup_device

  215.072859]  arm_smmu_probe_device+0x48/0x450
[  215.072871]  __iommu_probe_device+0xc0/0x468
[  215.072875]  iommu_probe_device+0x40/0x90
[  215.072877]  iommu_bus_notifier+0x38/0x68
[  215.072879]  notifier_call_chain+0x80/0x148
[  215.072886]  blocking_notifier_call_chain+0x50/0x80
[  215.072889]  bus_notify+0x44/0x68
[  215.072896]  device_add+0x580/0x768
[  215.072898]  pci_device_add+0x1e8/0x568
[  215.072906]  pci_iov_add_virtfn+0x198/0x300
[  215.072910]  sriov_enable+0x204/0x468
[  215.072912]  pci_enable_sriov+0x20/0x40

pci_iov_add_virtfn:
pci_device_add(virtfn, virtfn->bus);
pci_bus_add_device(virtfn); -> pci_fixup_device(pci_fixup_final, dev);



>
> Still in checking.
>
> And this branch does not need these two patches, right?
> c7b1397bef3c iommu/arm-smmu-v3: Implement arm_smmu_get_msi_mapping_domain
> 5cd34634a73e iommu/dma: Support MSIs through nested domains
>
> Thanks

