Return-Path: <linux-kernel+bounces-559348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC69A5F28B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0910B3B7551
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58711FAC5A;
	Thu, 13 Mar 2025 11:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DC+olOoG"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4041EF09A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865878; cv=none; b=Dl/jD9PTvyAOzGgngjDkdRctLU+paB9dyAzU4v0hhH0kEUYnqq0vWNtJ2Ijli1z7oziiceTuMKJFZtwif1koVuSheI2kxHp5h9jQgewD4vOJg8yeHytbn57YCBorpSSubTVrwilRyYi8NsmTRChrzXEdtpYAOdf4Tworwd0XFAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865878; c=relaxed/simple;
	bh=XRTY655dIngzAF2DwXGoaNeiIgEIW/corEhwZ7QyTSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lD0vTJ9+/Ok84yloqflQ69vqx0/wlYcqSE+iJZjlakQIIFDhJ55X1Frzi5o32MtDpn0uaCDE7GlRbUVxWKQDYATrLqutNtf8KgwLAFK19g+1zwOoSVCQnom6E72Ac+cpETPaY8QusxCwGYj5YKouax3Lmu2aOlO+ZYF591ylPz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DC+olOoG; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5499bd3084aso854349e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 04:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741865874; x=1742470674; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U/hZNyk3FnLmtk+RTmIh0V6qLpvWt9D8PxddCh4fi2I=;
        b=DC+olOoGkhgrb+m5I8ymNk2RhG/a61y3detbxJaeH6GJh8I/BRc/WYnmixAp02b5jo
         PCORkTvVkg+iFFwgAXyvQVLPKC3gFpSvtoHidvlsAbGY5KYZ+P3aIKD+NDNVt0u4wU4w
         7lDtYPuww0dUnUWGUIpztj0gmxsxfdckas73vHC83HiFw9qR1qzbYTEy1vmpIBH01u6E
         6Knlxez6F/Tzz6DgSANxRE4l/DJb9/tYR+C+nB7vCQGlIdauJOEfs9c2o+ESoRB0TUsl
         zEG462STKwpU0QwVhqEd/qe+4plambVN+YLRFdspQFNZyV1I7R/af2XRcAI6nDU4hbZ0
         2KeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741865874; x=1742470674;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/hZNyk3FnLmtk+RTmIh0V6qLpvWt9D8PxddCh4fi2I=;
        b=i//6PuguFDzqsybyXcxCY0T55oWYiTkfyrWboJmP+2XUKYEnenVudYxagr/svqVbg1
         IYmllQLMISe9X08IE1/Gl1Uhc1Q5zcxDDspqFZW2EuXeHPFeUtKk8UY0PwCUsUAZp3Jo
         7K2B5lQLGQwAPNPDPvKGdGl2piJFo42GoEJT3UPuwV2eebbFdFLXwscOuUJSVOSzjFeO
         qRzj4OPlrL4pNdu4pFdnAW47AUFpr/NVPzIScL6dlAl1OdDlbjmBDFz/RZOAQ4oYEGpt
         xddKxP1lmEq5Oc/LJq3dr1ng8VWSpbGaSa2Pkf9Z4EMvQKSzZAQGZ7KWayBDDfw9gCNQ
         JeBg==
X-Forwarded-Encrypted: i=1; AJvYcCU2sexj3n0Iu2p5oV++6zyteZGayvYwIAgWACv8PQAH+6MyqBcvopMYqwWQirRpsAgBeFffXP5U2WXQMlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEwO1Vfoveyp7O6LHF9C+JXWL76m6E/HVYUjDpdMVAQHowtmqq
	Oa0eqSn7en6oUhn6U2hkem9uIX4qWKuW/87Oa6wIjAV7tMYInfleyglPdIBdpVOiJi4bNXM6R7+
	VUDnfwDGyk0GxKonv/EbdwhoqinOyD4A45o87oip4/kDZbliEi7CYOSkJ
X-Gm-Gg: ASbGncu9KtqK0BDjm/ciIKz+VFbyPQxRDpc2H3vDMvd1yym220hvPO1ApTwP5jinoGr
	z+MBKiIsz0uqHstBtKdwswCPKTF9VuNFeKPu+qhRLe6cfK8RhJX/5oTkdcw6osjdxNic2I/zf5t
	SoJeo3dOOHYHcNp7UEARJ5HhNFjg==
X-Google-Smtp-Source: AGHT+IEVeX3DL8aAU1/pUqW0JRPL1IxMHo/zktSBoyn9/DMNX7UDpOqlqvW/c6IGvfHeiG0vaZTZk+5KpcI3nTdrQy8=
X-Received: by 2002:a05:6512:3dab:b0:545:3032:91fd with SMTP id
 2adb3069b0e04-54990e3eda2mr11224671e87.16.1741865874317; Thu, 13 Mar 2025
 04:37:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313051953.4064532-1-baolu.lu@linux.intel.com>
 <CABQgh9HKaDyDQXGB5ZEGg5q4a9ak_8OB9XQ+TpUNcZd_ZMeCAQ@mail.gmail.com>
 <CABQgh9G=7q+FQ0ECZ60UjawgkAM2aeNEb6hXgndEv8S9_4CuPw@mail.gmail.com> <b85990db-41f4-41cc-ab5c-0b952becdde7@linux.intel.com>
In-Reply-To: <b85990db-41f4-41cc-ab5c-0b952becdde7@linux.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Thu, 13 Mar 2025 19:37:42 +0800
X-Gm-Features: AQ5f1JoM8Zh1ZUvw-XcVqUQ3LTtLV3rJja-hFJr1UeEwd5WFKqaNVHE78o7C_2I
Message-ID: <CABQgh9FGS4aug9aRH4ddgwStpVpEAOKMmJ_aDHcdYrUR3eLSOg@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] iommu: Remove IOMMU_DEV_FEAT_SVA/_IOPF
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
	Fenghua Yu <fenghuay@nvidia.com>, Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Mar 2025 at 19:20, Baolu Lu <baolu.lu@linux.intel.com> wrote:
>
> On 2025/3/13 18:57, Zhangfei Gao wrote:
> > On Thu, 13 Mar 2025 at 17:51, Zhangfei Gao<zhangfei.gao@linaro.org> wrote:
> >> Hi, Baolu
> >>
> >> On Thu, 13 Mar 2025 at 13:19, Lu Baolu<baolu.lu@linux.intel.com> wrote:
> >>> The new method for driver fault reporting support relies on the domain
> >>> to specify a iopf_handler. The driver should detect this and setup the
> >>> HW when fault capable domains are attached.
> >>>
> >>> Move SMMUv3 to use this method and have VT-D validate support during
> >>> attach so that all three fault capable drivers have a no-op FEAT_SVA and
> >>> _IOPF. Then remove them.
> >>>
> >>> This was initiated by Jason. I'm following up to remove FEAT_IOPF and
> >>> further clean up.
> >>>
> >>> The whole series is also available at github:
> >>> https://github.com/LuBaolu/intel-iommu/commits/iommu_no_feat-v4
> >> I got an issue on this branch.
> >>
> >> Linux 6.14-rc4 + iommu_no_feat-v2
> >> drivers/pci/quirks.c
> >> quirk_huawei_pcie_sva will set dma-can-stall first
> >> arm_smmu_probe_device will check dma-can-stall and set stall_enabled
> >> accordingly.
> > This working branch arm_smmu_probe_device is called from pci_bus_add_device
> > So pci_fixup_device is called first
> >
> > [ 1121.314405]  arm_smmu_probe_device+0x48/0x450
> > [ 1121.314410]  __iommu_probe_device+0xc4/0x3c8
> > [ 1121.314412]  iommu_probe_device+0x40/0x90
> > [ 1121.314414]  acpi_dma_configure_id+0xb4/0x100
> > [ 1121.314417]  pci_dma_configure+0xf8/0x108
> > [ 1121.314421]  really_probe+0x78/0x278
> > [ 1121.314425]  __driver_probe_device+0x80/0x140
> > [ 1121.314427]  driver_probe_device+0x48/0x130
> > [ 1121.314430]  __device_attach_driver+0xc0/0x108
> > [ 1121.314432]  bus_for_each_drv+0x8c/0xf8
> > [ 1121.314435]  __device_attach+0x104/0x1a0
> > [ 1121.314437]  device_attach+0x1c/0x30
> > [ 1121.314440]  pci_bus_add_device+0xb8/0x1f0
> > [ 1121.314442]  pci_iov_add_virtfn+0x2ac/0x300
> > [ 1121.314446]  sriov_enable+0x204/0x468
> > [ 1121.314447]  pci_enable_sriov+0x20/0x40
> >
> >
> >> This branch
> >> arm_smmu_probe_device happens first, when dma-can-stall = 0, so
> >> stall_enabled =0.
> >> Then drivers/pci/quirks.c: quirk_xxx happens
> > This not working branch: Linux 6.14-rc6 + iommu_no_feat-v4
> > arm_smmu_probe_device is called by pci_device_add
> > Then call pci_bus_add_device -> pci_fixup_device
> >
> >    215.072859]  arm_smmu_probe_device+0x48/0x450
> > [  215.072871]  __iommu_probe_device+0xc0/0x468
> > [  215.072875]  iommu_probe_device+0x40/0x90
> > [  215.072877]  iommu_bus_notifier+0x38/0x68
> > [  215.072879]  notifier_call_chain+0x80/0x148
> > [  215.072886]  blocking_notifier_call_chain+0x50/0x80
> > [  215.072889]  bus_notify+0x44/0x68
> > [  215.072896]  device_add+0x580/0x768
> > [  215.072898]  pci_device_add+0x1e8/0x568
> > [  215.072906]  pci_iov_add_virtfn+0x198/0x300
> > [  215.072910]  sriov_enable+0x204/0x468
> > [  215.072912]  pci_enable_sriov+0x20/0x40
> >
> > pci_iov_add_virtfn:
> > pci_device_add(virtfn, virtfn->bus);
> > pci_bus_add_device(virtfn); -> pci_fixup_device(pci_fixup_final, dev);
>
> This probably is not caused by this patch series. Can you please have a
> try with the next branch of iommu tree? Or the latest linux-next tree?
>
> https://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git


Ok, will try.

Though still not finding which patch caused the problem, will do more
investigation.

The issue is arm_smmu_probe_device is changed
from
pci_bus_add_device(virtfn); -> pci_fixup_device(pci_fixup_final, dev);
to
pci_device_add(virtfn, virtfn->bus) ->  pci_fixup_device(pci_fixup_header, dev);

And the issue can be solved by
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa250, quirk_huawei_pcie_sva);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0xa250, quirk_huawei_pcie_sva);

Thanks

