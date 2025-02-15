Return-Path: <linux-kernel+bounces-516182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34695A36DC9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 12:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4A231892F58
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 11:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC7D1A83F2;
	Sat, 15 Feb 2025 11:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TvTAN91d"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A99919F42F
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 11:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739619354; cv=none; b=h+gIvdjmYiW2UanpCCZpIxAmaXNx2mcofMMv4urqQWV7mmrf5Ud4UxXgo9+JaoN9w2fhglBUdvlZxA3vredh6gvMsmwBkT5kjDui5BU5S+rRYylJJjJuN/U5+Xdze1EIRbsj9AuNrkrzr0NTZgBFU0/pR/IicOoYFoVy8JYiEb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739619354; c=relaxed/simple;
	bh=Ci0+XLq+d9rZIvFoN72FJTBWdzTfmnvxyaM9qpi7TnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SpeYmbbawJb0f2k37e76i6d2XQ/8wwnu4bRug/Jha88qeCu7C1Jj6H+x+ISl6sDLy1BO4n/yPVgvBz6zevrxyhoppkNahtolFMyvp/Zg30lwAy1woWihezopLQGniI/8W3ETemNGPXITxwyWjSnfR92v/1MAjy3h2oVxwrwuxl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TvTAN91d; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5453153782aso334538e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 03:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739619350; x=1740224150; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GWKV3bPvJoEC6CwCkO5EJJnYQ2m33vdhaH2jkHmFW3k=;
        b=TvTAN91d/XC4kXSGHpPwfBLQLNRgHjoY5dg0J6M1tBKsQ3UycOKUr52611ZO2irOMH
         ZxzI02fqHNhrGtdjpWFp/uWHNpKTgsXUUullpFolVwHTDi5uGFt12Hegr2tlu6Z6AH6u
         VjxOqw3iwnoVhsPcvAmcp0gW2HjeDnGoiWIWySsiBFkn3BhW5vBdaI97TIwZ+dauLeKo
         gvSjlpVewmdNqvpQ3Dmia8tSo3YlgxvZCTVGTwnNCROp+fT5iPurC79P5iljvjss1XcY
         FSC8yLb66ostwb6xokNMC2ZKhTexggLcgdwkyc9rB2N49bs9INO/vdJyIbe2mAxxfAnn
         4wbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739619350; x=1740224150;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GWKV3bPvJoEC6CwCkO5EJJnYQ2m33vdhaH2jkHmFW3k=;
        b=TIqq6hVurMjoeftRPUABKxZKbjF9WF3l/jRS1IOrgS3K2IDuJAHrtF5Wlq/rtApet9
         6R+2gYNOqTZSzehPjtW3+7th7CLHhnD612ZY38OKqnJP3OVGEVHuT2I4XZOKpJC9jfyw
         8KrRiAGeWADMvYzde/iKbMJOW4pdhY4hokY4rpT6iC8E3EvJ4RBdvlyzudnHFADOfMhR
         EzLO1ohHEcs3gMF6y9+BGWpTVXzX5iKkymb5ggEhuQ0S2nHb3zfE3pILw0Gl+75kYdJV
         nKVfkPBr5pqOg1009krfkYpJ7jdS4he7i2seEjprc+S+4A3TMvSrMd2LNyCcnZjA2BvH
         XkSw==
X-Forwarded-Encrypted: i=1; AJvYcCXtokyxMUb+p9LBoxz/ouqkvac9rx9wpOr7GRPJpvjUiywwJzW8thSIswhzDDt8w92jUzECCfHz3K3S1B8=@vger.kernel.org
X-Gm-Message-State: AOJu0YybYLycfSo+QM/815O9SFItHXmrapanm3XtvrarzYG98j78hRN/
	Qg3eyTVBIhvgbcxFuNyqxtmuo00enLVeq1+Jza4sdFM18qVcT18qp0QKW8hbR76JhSnO9QGK0W7
	DH7J4xf16TWivYIZew5WIIlhGorL4MPsdX+86K4FI0Ujys7K2bGF+EEEH
X-Gm-Gg: ASbGncvKS2EX0szlLI2iaQqB7kJ8LTG9tAlJ1f9jZXeCaT/eGicR9oIKPqFDZ/ClHum
	fxnsYXK/iUWaKKUyLFez9uctWR9pzOi+W/NJV/CN4VnTifjYjUtg/0rRPeW02J/eSaJBHrATCFS
	IBZw==
X-Google-Smtp-Source: AGHT+IHwSYAZC5CwjRpFYyBiSqR0sK1FpBP8Yk5w2sAiYtZY0gHXngaY4LcBKuFQd7HHYoA0EWP5G/v7vRNNBL7KWXo=
X-Received: by 2002:a05:6512:ba6:b0:545:f4b:ed66 with SMTP id
 2adb3069b0e04-5452fe56d7emr909583e87.21.1739619350484; Sat, 15 Feb 2025
 03:35:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
 <CABQgh9FMy7oVt9+enSpJxXvkux+czMFqbsPZVgmBV+rFWWvhGA@mail.gmail.com>
 <20250214125600.GA3696814@ziepe.ca> <CABQgh9FQYe46hfjcs+o6GfLaS7OfSqrmvXUzOKd6PRK8oBF8Jw@mail.gmail.com>
 <d578bf4c-f475-42bf-9cb8-21941fc7af88@linux.intel.com>
In-Reply-To: <d578bf4c-f475-42bf-9cb8-21941fc7af88@linux.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Sat, 15 Feb 2025 19:35:39 +0800
X-Gm-Features: AWEUYZlvK8a7ONBBadH8VVaSYChy_w4QHfiKgPqrTgWgJopiUVoF2zbjBT2p1uA
Message-ID: <CABQgh9EG3gjtw19qvr7OhxKmR8E6+xwBf9b3=WPNrXRc-m9DjQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] iommu: Remove IOMMU_DEV_FEAT_SVA/_IOPF
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Fenghua Yu <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Vinod Koul <vkoul@kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 15 Feb 2025 at 18:09, Baolu Lu <baolu.lu@linux.intel.com> wrote:
>
> On 2/15/25 16:11, Zhangfei Gao wrote:
> > It does not relate to multi devices, one device also happens when user
> > page fault triggers.
> >
> > iopf_queue_remove_device is called.
> > rcu_assign_pointer(param->fault_param, NULL);
> >
> > call trace
> > [  304.961312] Call trace:
> > [  304.961314]  show_stack+0x20/0x38 (C)
> > [  304.961319]  dump_stack_lvl+0xc0/0xd0
> > [  304.961324]  dump_stack+0x18/0x28
> > [  304.961327]  iopf_queue_remove_device+0xb0/0x1f0
> > [  304.961331]  arm_smmu_remove_master_domain+0x204/0x250
> > [  304.961336]  arm_smmu_attach_commit+0x64/0x100
> > [  304.961338]  arm_smmu_attach_dev_nested+0x104/0x1a8
> > [  304.961340]  __iommu_attach_device+0x2c/0x110
> > [  304.961343]  __iommu_device_set_domain.isra.0+0x78/0xe0
> > [  304.961345]  __iommu_group_set_domain_internal+0x78/0x160
> > [  304.961347]  iommu_replace_group_handle+0x9c/0x150
> > [  304.961350]  iommufd_fault_domain_replace_dev+0x88/0x120
> > [  304.961353]  iommufd_device_do_replace+0x190/0x3c0
> > [  304.961355]  iommufd_device_change_pt+0x270/0x688
> > [  304.961357]  iommufd_device_replace+0x20/0x38
> > [  304.961359]  vfio_iommufd_physical_attach_ioas+0x30/0x78
> > [  304.961363]  vfio_df_ioctl_attach_pt+0xa8/0x188
> > [  304.961366]  vfio_device_fops_unl_ioctl+0x310/0x990
> >
> >
> > When page fault triggers:
> >
> > [ 1016.383578] ------------[ cut here ]-----------
> > [ 1016.388184] WARNING: CPU: 35 PID: 717 at
> > drivers/iommu/io-pgfault.c:231 iommu_report_device_fault+0x2c8/0x470
>
> It's likely that iopf_queue_add_device() was not called for this device.

iopf_queue_add_device is called, but quickly iopf_queue_remove_device
is called during guest bootup.
Then fault_param is set to NULL.

arm_smmu_attach_commit
arm_smmu_remove_master_domain
// newly added in the first patch
       if (master_domain) {
                  if (master_domain->using_iopf)
                          arm_smmu_disable_iopf(master); ->
iopf_queue_remove_device
                  kfree(master_domain);
          }

As a comparison, without this patchset, only iopf_queue_add_device is
called, not call iopf_queue_remove_device

Thanks

