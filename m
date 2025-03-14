Return-Path: <linux-kernel+bounces-560674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 888EEA607FE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 05:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEE6C17C534
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 04:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1398D7346D;
	Fri, 14 Mar 2025 04:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dJEr1XxT"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AF62D052
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 04:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741925110; cv=none; b=fNnHFVwo6wac0/dKLbYTLwskg5Olwg85sFedizNxRLiBwgfW2/8Aq0ntGTzEiXuk69Mmf1kV/hdUwbjATIBTrySttmF7qBDLHat4o8xXri92QuoIvgqP2dSav5CFF3qnaka2mnXfBBx62kWoMp+8yGQBPAVTPTnLwbAraMl8/os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741925110; c=relaxed/simple;
	bh=XU7FdM3Ffg6QP05RRUEg+NX4qxvK9dQAgJRWFzfE7Os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bbsz810zi7TkMAg9IBs1muZ1oSw6G9qMqSlur+TZzZpLnxXuM+KOwJXn8GhwLkm+mJS5Lwwbt/xi1cp+g5WIRRptMonxHU8iom2N515U6xLSLo1mJch67f2bvgYRljX3O4RYGG/jku8mcWXs8eFS3Z0D6YIQ8y1+qe/nv/IWJ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dJEr1XxT; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30bf1d48843so15334761fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 21:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741925104; x=1742529904; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h//ATjia85HEojScqbuknPiD1067XRlRwJ315LGwuuA=;
        b=dJEr1XxTsCPKjxXwIY+4g5Cs1iC/BlSouK6eYURejuy0/IkalHbN+ClTHJwbPYNWms
         5Mrg64vo5EdAz2qdExI74gTX+GERqoLCRRWUqbPLZu8wrfG/DQBI2t3S7SQH73eeSslz
         uKvqvuf4YehAWVLK2/GH/Twtey+PINtEUnV1H+0/ctU9Qs1NmprXHD6RA4iPFPGXsEBs
         kYHdH5MNTxBx3qW4lRCUAVVtP+WB3doPuFOp/zN/l5g3Pm+A7jFWiQTqgMMIn+BF2D4y
         ke3pI4dRHrolRllOV+PjPSbsJAHgg38qXKgqZEQrRqtbGy4QkwSOcLXbTqjVqglUkFYi
         ZOUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741925104; x=1742529904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h//ATjia85HEojScqbuknPiD1067XRlRwJ315LGwuuA=;
        b=ec3pSX/2/i8A0TkXxRQaiwKODxHOZKi4aQCFGYlWi1l930v3Fn2oE08NtVoc2e+lIo
         Uj9dygjh4UIiMSKn0u9xkpnpxuk0K3ICRZ4Y/IWZYM4qiFkrhOrf4XRmg2TLvUCAPqE2
         GcNswdMxWvnmQhB1ptwjSI2DCCNSPWUW8nNM6v9Z2/bJbRC5TCeQEhtAYOK86TvH2fU7
         FxMLa0+3j+kbIUS6z/cjPib41Z3W7yoiVSH4XoLKNVDMO2QkAkdQkDHnk6WMqx9D69LY
         kijpr8Njbt7lqUuDNYx96FbKcmgTp8IBEHUJJ8/4j1rtoVvakJuyuzolr4kfm1eH1YsP
         Tt3w==
X-Forwarded-Encrypted: i=1; AJvYcCUJwWsg/7uTSUCF1+J6HcN0DImRwpf27xKMty0MSyPuEBhsTJg139daBui3OatOHIdlkfMfyPSXkDE+JHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4cdogU4TZ2w6TAxdi6Ilk8at7yvtFYccbC5VRMMr/mbsAQTLj
	wtMFDXTRGXuOFlNrhhpmJ1EP2ph1P5+wsmz53yARdXDTUJK5fsxnbwYKGOMpzvpSqaBtP3fm515
	yqM4Jtxq6E8OUmCzcnN1Zp41mRUECpqVWyk/Dh9VAPGUN1h662LjQL84n
X-Gm-Gg: ASbGncvWjWOGQh95//5QgIuhYruX31i3VM5u3BetG9xxuZTe1jrFGQ2opXRGs0VP+Gf
	FTAos+2uGoGwKSYg/4QR4LQJCeYS47gCty4IiKV8TzwYzsGhwFcYgG++7ZEgfmi9lo4MBaNuzd0
	vb4PpGG9J4p5VOgnmMoWq79Cq23A==
X-Google-Smtp-Source: AGHT+IH+6Ak42L7Q+3G3rk/KoaIGmKV0+96j6H68eEIV5uqgLh6/zhd3gN2T37mcOBFNf/ch/w9xuC3da1CZk34tKc0=
X-Received: by 2002:a05:651c:1a0a:b0:30b:ef3d:88bb with SMTP id
 38308e7fff4ca-30c4a8e52femr3174581fa.32.1741925103879; Thu, 13 Mar 2025
 21:05:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313051953.4064532-1-baolu.lu@linux.intel.com>
 <CABQgh9HKaDyDQXGB5ZEGg5q4a9ak_8OB9XQ+TpUNcZd_ZMeCAQ@mail.gmail.com>
 <CABQgh9G=7q+FQ0ECZ60UjawgkAM2aeNEb6hXgndEv8S9_4CuPw@mail.gmail.com>
 <b85990db-41f4-41cc-ab5c-0b952becdde7@linux.intel.com> <CABQgh9FGS4aug9aRH4ddgwStpVpEAOKMmJ_aDHcdYrUR3eLSOg@mail.gmail.com>
In-Reply-To: <CABQgh9FGS4aug9aRH4ddgwStpVpEAOKMmJ_aDHcdYrUR3eLSOg@mail.gmail.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Fri, 14 Mar 2025 12:04:52 +0800
X-Gm-Features: AQ5f1JpbGhPHF3BB0AZ3jd2ZvOtpiI9SVmgWjv3sWTyjDpPVVEZSzTxjIevp0G4
Message-ID: <CABQgh9H=415-V3qfFBn4PuCyuHO5cO_i4vnPTuxBZ9bkSU+eXQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] iommu: Remove IOMMU_DEV_FEAT_SVA/_IOPF
To: Baolu Lu <baolu.lu@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Vinod Koul <vkoul@kernel.org>, Fenghua Yu <fenghuay@nvidia.com>, 
	Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Mar 2025 at 19:37, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
>
> On Thu, 13 Mar 2025 at 19:20, Baolu Lu <baolu.lu@linux.intel.com> wrote:
> >
> > On 2025/3/13 18:57, Zhangfei Gao wrote:
> > > On Thu, 13 Mar 2025 at 17:51, Zhangfei Gao<zhangfei.gao@linaro.org> wrote:
> > >> Hi, Baolu
> > >>
> > >> On Thu, 13 Mar 2025 at 13:19, Lu Baolu<baolu.lu@linux.intel.com> wrote:
> > >>> The new method for driver fault reporting support relies on the domain
> > >>> to specify a iopf_handler. The driver should detect this and setup the
> > >>> HW when fault capable domains are attached.
> > >>>
> > >>> Move SMMUv3 to use this method and have VT-D validate support during
> > >>> attach so that all three fault capable drivers have a no-op FEAT_SVA and
> > >>> _IOPF. Then remove them.
> > >>>
> > >>> This was initiated by Jason. I'm following up to remove FEAT_IOPF and
> > >>> further clean up.
> > >>>
> > >>> The whole series is also available at github:
> > >>> https://github.com/LuBaolu/intel-iommu/commits/iommu_no_feat-v4
> > >> I got an issue on this branch.
> > >>
> > >> Linux 6.14-rc4 + iommu_no_feat-v2
> > >> drivers/pci/quirks.c
> > >> quirk_huawei_pcie_sva will set dma-can-stall first
> > >> arm_smmu_probe_device will check dma-can-stall and set stall_enabled
> > >> accordingly.
> > > This working branch arm_smmu_probe_device is called from pci_bus_add_device
> > > So pci_fixup_device is called first
> > >
> > > [ 1121.314405]  arm_smmu_probe_device+0x48/0x450
> > > [ 1121.314410]  __iommu_probe_device+0xc4/0x3c8
> > > [ 1121.314412]  iommu_probe_device+0x40/0x90
> > > [ 1121.314414]  acpi_dma_configure_id+0xb4/0x100
> > > [ 1121.314417]  pci_dma_configure+0xf8/0x108
> > > [ 1121.314421]  really_probe+0x78/0x278
> > > [ 1121.314425]  __driver_probe_device+0x80/0x140
> > > [ 1121.314427]  driver_probe_device+0x48/0x130
> > > [ 1121.314430]  __device_attach_driver+0xc0/0x108
> > > [ 1121.314432]  bus_for_each_drv+0x8c/0xf8
> > > [ 1121.314435]  __device_attach+0x104/0x1a0
> > > [ 1121.314437]  device_attach+0x1c/0x30
> > > [ 1121.314440]  pci_bus_add_device+0xb8/0x1f0
> > > [ 1121.314442]  pci_iov_add_virtfn+0x2ac/0x300
> > > [ 1121.314446]  sriov_enable+0x204/0x468
> > > [ 1121.314447]  pci_enable_sriov+0x20/0x40
> > >
> > >
> > >> This branch
> > >> arm_smmu_probe_device happens first, when dma-can-stall = 0, so
> > >> stall_enabled =0.
> > >> Then drivers/pci/quirks.c: quirk_xxx happens
> > > This not working branch: Linux 6.14-rc6 + iommu_no_feat-v4
> > > arm_smmu_probe_device is called by pci_device_add
> > > Then call pci_bus_add_device -> pci_fixup_device
> > >
> > >    215.072859]  arm_smmu_probe_device+0x48/0x450
> > > [  215.072871]  __iommu_probe_device+0xc0/0x468
> > > [  215.072875]  iommu_probe_device+0x40/0x90
> > > [  215.072877]  iommu_bus_notifier+0x38/0x68
> > > [  215.072879]  notifier_call_chain+0x80/0x148
> > > [  215.072886]  blocking_notifier_call_chain+0x50/0x80
> > > [  215.072889]  bus_notify+0x44/0x68
> > > [  215.072896]  device_add+0x580/0x768
> > > [  215.072898]  pci_device_add+0x1e8/0x568
> > > [  215.072906]  pci_iov_add_virtfn+0x198/0x300
> > > [  215.072910]  sriov_enable+0x204/0x468
> > > [  215.072912]  pci_enable_sriov+0x20/0x40
> > >
> > > pci_iov_add_virtfn:
> > > pci_device_add(virtfn, virtfn->bus);
> > > pci_bus_add_device(virtfn); -> pci_fixup_device(pci_fixup_final, dev);
> >
> > This probably is not caused by this patch series. Can you please have a
> > try with the next branch of iommu tree? Or the latest linux-next tree?
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
>
>
> Ok, will try.
>
> Though still not finding which patch caused the problem, will do more
> investigation.
>
> The issue is arm_smmu_probe_device is changed
> from
> pci_bus_add_device(virtfn); -> pci_fixup_device(pci_fixup_final, dev);
> to
> pci_device_add(virtfn, virtfn->bus) ->  pci_fixup_device(pci_fixup_header, dev);

Update:

This sequence change  is caused by
bcb81ac6ae3c iommu: Get DT/ACPI parsing into the proper probe path

The probe is put in earlier so we have to make fixup earlier as well.
DECLARE_PCI_FIXUP_FINAL -> DECLARE_PCI_FIXUP_HEADER

Thanks

>
> And the issue can be solved by
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa250, quirk_huawei_pcie_sva);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0xa250, quirk_huawei_pcie_sva);
>
> Thanks

