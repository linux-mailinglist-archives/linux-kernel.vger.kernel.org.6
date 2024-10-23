Return-Path: <linux-kernel+bounces-377861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F8C9AC7CD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84B001C2268E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACDF1A7240;
	Wed, 23 Oct 2024 10:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SAxk/Vf+"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E03B1A4E70
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 10:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729678978; cv=none; b=XX3hrHLCyPhnCzO3gyrGNDl1sb4VvEz89xiNlpebGUoBhJzzFM8EQnqvFriZ0ri/8NT46yf2ZIm7i2EpI4Q8kxgAoce0Zxh1qXT/Qm4hh1bDU8cft6oKEFapS2lvNG7CyTLhYNKAuEuHE0w9iMd+OTp4paHgzwXGdSxfZCaZB4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729678978; c=relaxed/simple;
	bh=NS4ilObULb/+LNuO08aUDsktHnNBmiP8ABY85oWc1eI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jyhGGkKmM37NKS3Zr/gUFt7ubvVrFiOrVKy0A8cVSeuQ4X6ap+K5TlLmW/aJmD0+z7Nx0IOAAxRE096WRJFQWy8eXkzByL8K7eO8sTO319iF8HEJu92facEtO2SQQg1rlVcgSjeqAeDkvbf/BOjHxPPsm6cB9DDQFSJS/CTa+lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SAxk/Vf+; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539e13375d3so7320734e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 03:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729678974; x=1730283774; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=it5qqymkWGY0OitCSnqR7X8aXYDfuNSva2WMI6HrQ68=;
        b=SAxk/Vf+erK76Qgbx5Jm8GHpqzDG7THRciZsC3ewNlpU7MWKrzQWDy4YTq9chNHfLE
         G735fuMEC7MitEd27m6RdRLKOUsSTVzF21lZ4KsUhjnhEv/FW3c1aOWiLjuAkSW8u/iX
         EJNxXjD/I/K7OlpogOiHXZHylGs3MWulIlK56TfzUGM4lz8w9yjnvgcrA5uv/CFbNpe1
         FqN13d8ZpdI8ENyk6kZWFbvB/9bN8K+MF5rjTZkkZT9kGDJXj+I5bfJNskBu4zC4dtof
         t2DWAmolQiSAUkWDSyG4GRQozgOMFb9EK96APPzgjwh4Y4Z5RjaTjc4oClv/gXwO/M2+
         OQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729678974; x=1730283774;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=it5qqymkWGY0OitCSnqR7X8aXYDfuNSva2WMI6HrQ68=;
        b=D36Fm3U8kLfDugBMUzb7FBS8BBm0sgud8Z4ccbxPOuVkUM70W8QfOPTrxbSKSoqWa5
         +iWq3jCCu21wi+q/Jzp0aEuts3uS98/bJkO3mouyGccXV4QtXLOifA3aB2dCpRWW3ff1
         m61u6ptNV4GoKvqczsKPAJDo2u5glzOGKo8b2nhxWtxrXiYD72cq3sC1nCZTlbkOwKlu
         vkj99HK9hTzmVQmqkx1cZRanbneNxNkFSpJR4KDeSDAub2w6fTv8uSm7GHyZBcHZuW64
         SipsNnCxWDRa3kJhW2h5e2vwGPLA7LrVmADLUa+6scFh8e0EbyuITlksmDZHjHibKUoX
         /CMA==
X-Forwarded-Encrypted: i=1; AJvYcCVWVL9v5oQE6dYYxRtKxvnHhoEUEjXsJ1UhoIVg/kLUpFDoTsZLHCEINfz9CPW6X23PkRrjJOYjKwwVPz4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz1zDQeu1A2wBe9rU2p7vMqosGxf6B4V+zfcH4U3jj6zJOQGuf
	6yzU+3b+4tvDuf0aDpvSUpd7apwidfXoamX3ZaguTxlIoHDMTq7G6AWh3v1mX8hmgXteBV3a0+0
	AAc1MQq2TOPq1ueWgU2WHu5YfkJryBYD0if0+Gg==
X-Google-Smtp-Source: AGHT+IHSlBLk0S83wm+5RZnogzP4oUfDRPvMnigWOthmmvnTrPqpN9jwiZcT3cwHLQu70zUFj7sVT87cHsqqjLDYfWw=
X-Received: by 2002:a05:6512:308a:b0:536:56d8:24b4 with SMTP id
 2adb3069b0e04-53b1a30c28cmr1039048e87.5.1729678974140; Wed, 23 Oct 2024
 03:22:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-8-baolu.lu@linux.intel.com> <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>
 <20241015125420.GK1825128@ziepe.ca> <CABQgh9E+AnuyJgcM9tf1gEOUqcC_QSrA__Xha9sKYZp=NVRwhQ@mail.gmail.com>
 <20241016152503.GB4020792@ziepe.ca> <20241018135343.GA1914429@nvidia.com>
 <CABQgh9Hd0QCfEtVcMyXG+=KHuZdGGUA=kk5iL_ysOzfOpLh=-w@mail.gmail.com> <20241022145257.GB864191@nvidia.com>
In-Reply-To: <20241022145257.GB864191@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 23 Oct 2024 18:22:42 +0800
Message-ID: <CABQgh9E4XE6G7cK6_77ZsXgvfdOfa4rXXU2VUVxkqRd01tG+Rw@mail.gmail.com>
Subject: Re: [PATCH v8 07/10] iommufd: Fault-capable hwpt attach/detach/replace
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Oct 2024 at 22:53, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Tue, Oct 22, 2024 at 10:30:10PM +0800, Zhangfei Gao wrote:
> > On Fri, 18 Oct 2024 at 21:53, Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > On Wed, Oct 16, 2024 at 12:25:03PM -0300, Jason Gunthorpe wrote:
> > > > > > smmu-v3 needs some more fixing to move that
> > > > > > arm_smmu_master_enable_sva() logic into domain attachment.
> > > > >
> > > > > Will think about this, Thanks Jason
> > > >
> > > > Can you test it if a patch is made?
> > >
> > > Here it is:
> > >
> > > https://github.com/jgunthorpe/linux/commits/smmuv3_nesting/
> > >
> > > fa1528253d2210 iommu: Remove IOMMU_DEV_FEAT_SVA
> > > 5675560a272cf5 iommu/vt-d: Check if SVA is supported when attaching the SVA domain
> > > 94bc2b9525b508 iommu/arm-smmu-v3: Put iopf enablement in the domain attach path
> > >
> > > Let me know..
> >
> > With these patches, do we still need ops->user_pasid_table?
>
> It makes no change - you need user_pasid_table to make
> IOMMU_DOMAIN_NESTED work.
>
> If you aren't using IOMMU_DOMAIN_NESTED you shouldn't need it.

OK, I misunderstood.

Then with user_pasid_table=1
both with these patches and without patches, user page fault is OK.

>
> > if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) {
> >                 attach_handle = iommu_attach_handle_get(dev->iommu_group,
> >                                 fault->prm.pasid, 0);
> >
> > // is attach_handle expected effect value here?
> >                 if (IS_ERR(attach_handle)) {
> >                         const struct iommu_ops *ops = dev_iommu_ops(dev);
> >
> >                         if (!ops->user_pasid_table)
> >                                 return NULL;
> >                         /*
> >                          * The iommu driver for this device supports user-
> >                          * managed PASID table. Therefore page faults for
> >                          * any PASID should go through the NESTING domain
> >                          * attached to the device RID.
> >                          */
> >                         attach_handle = iommu_attach_handle_get(
> >                                         dev->iommu_group, IOMMU_NO_PASID,
> >                                         IOMMU_DOMAIN_NESTED);
> >
> > Now I still need set ops->user_pasid_table, since attach_handle can not
> > return from the first iommu_attach_handle_get with fault->prm.pasid = 1,
> > but the second iommu_attach_handle_get with  IOMMU_NO_PASID,
> > suppose it is not expected?
>
> The second handle_get will always fail unless you are using
> IOMMU_DOMAIN_NESTED in userspace with iommufd.
>
> What testing are you doing exactly?

I am testing vsva based on Nico's iommufd_viommu_p2-v3 branch,
which requires IOMMU_DOMAIN_NESTED in user space with iommufd.

About the three patches
1. Tested host sva, OK
2. Simply tested vsva on guests, OK, will do more tests.

Thanks

