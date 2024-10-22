Return-Path: <linux-kernel+bounces-376400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1419AB0DD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0F61C22570
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872661A0BFF;
	Tue, 22 Oct 2024 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dxD0oiz9"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6FE1A0B05
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729607425; cv=none; b=F/2CE4g923dXe4L1gl/Tyk0LhYdeyrVAxS4XM6vxyDIY2PQHfEKNbgRLSX2njY7Hhmhp/wg2+0vEk7kS48GJh6EYFFzMhPoIdL3s38SsMRLWrS7LkuXYNaJyOizM59HhjiUF352xwZ6zH4jVX+lGhJdcslF+YPv/vAyD+y8dzz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729607425; c=relaxed/simple;
	bh=k0amHKO6MIntAv5M0SzgajpPonlLOfoo6JXAgIJwIcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d/z2/7pMiHAti2QUcFFxjJh2dStY0munYuZnL+73VqjTryo+Qp+1oQbq+FWnvhUGS0yPIkWyV2FcfW6KI2R0XgGW3Zq1t89//cQLeP82K0dq+EK4CGWvyOTUMmbjZW9NxwtfaecIQbKN/5XMzckn2p9HpD1lxF+gHlC/TEIXsx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dxD0oiz9; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539fe02c386so6585623e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 07:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729607422; x=1730212222; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lp8dKdoQIA1w+n8BQQ++9JKmCC1EPM5x54cAk4kCfAY=;
        b=dxD0oiz9LyM1aQJsdGs40S3JMA2qPgD2/JQ7ZMyj94fko05moG8Qv4HBxitSEzLkfi
         HDNhSwM7vdUtXWEgkZGmGuAWf4NJDJabaneGwKYb9jvGfwRh68yZZjwb8fcvYzcqz+Bv
         bQxwx+8PsSw5jjTZzbaLbYKYZl92sNCoXetmJuqmJNy3El5fO/UBuP0Ha/icowXc8+j3
         6mb/pTp1EwEvTwthbCGhc3t0R0qsau8UXktrs1SuwaqRW8wD1M2ozqpRRiKbjkxa0Dge
         bMjzzcXykX977ET/m385NVJXxZyL+NLJcOsNN5ubTYPThfQzLsHsVYv5PGD84a0KrSzd
         8exQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729607422; x=1730212222;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lp8dKdoQIA1w+n8BQQ++9JKmCC1EPM5x54cAk4kCfAY=;
        b=C+oDcDqBdoiD9DR2woDDGTf8FfEK5fN3so6k/A+a5j92blbTtDV/JOsvsY3is9k10R
         R/Qj3lgn5m9viz3RG2Po1os/ygkh5DgiN1AndY1G9V57KKiNKnR/Ml0KDAcUTkpXACIt
         hcW5fTiB0oBoqt/9MdBjWNLrMYrt3SuBaUBrznv2Ne6AbrpAzqQ/978n8wTmQ0+UY/mH
         5mNY/vb7zPNF3gGU898ZX9ImY3ksoxxE1ax4SV+qCQ/dsn3qMTGhqleLko5oVBmdWB44
         yjS1fI+Md2q69Mr0o+TVGJTfSeCikX/FesCZOqf6EAcD1dEa6bY9W4j2/NziiLvKSLf2
         9hgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBqIeezceQrC/YLt3eNVSABvUi4Riq+oftlIQCvO03OvTFvQvc9MROAcgZwb8LfhZoVjGTe5usmwThj5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1nehaSqgv8nYZkHqjQ/zBeZYLt5YeSjHiTl2A3xVm26uGmbTG
	CHzaZZgJpZS0jRrMxQiOWe/tFxdvGeGqOwBuxmZ1ouvAQXUeS2iTtyukTgGIj6zVPsdEqgT5RsP
	iDic7o3IQXQdIri8pbXKigHoibH8lJgC7qCC+PQ==
X-Google-Smtp-Source: AGHT+IEmsgyC/7BPZ0DVAIPPJOMrKuG0dVpOFVN4k5ykLXaGddAjQf1rjB9Wpg/JrSZFFy9ylzXvbFdWuCjJSeysOhI=
X-Received: by 2002:a05:6512:3d22:b0:539:ea18:437d with SMTP id
 2adb3069b0e04-53b13181fd5mr1172054e87.25.1729607422263; Tue, 22 Oct 2024
 07:30:22 -0700 (PDT)
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
In-Reply-To: <20241018135343.GA1914429@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Tue, 22 Oct 2024 22:30:10 +0800
Message-ID: <CABQgh9Hd0QCfEtVcMyXG+=KHuZdGGUA=kk5iL_ysOzfOpLh=-w@mail.gmail.com>
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

On Fri, 18 Oct 2024 at 21:53, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Wed, Oct 16, 2024 at 12:25:03PM -0300, Jason Gunthorpe wrote:
> > > > smmu-v3 needs some more fixing to move that
> > > > arm_smmu_master_enable_sva() logic into domain attachment.
> > >
> > > Will think about this, Thanks Jason
> >
> > Can you test it if a patch is made?
>
> Here it is:
>
> https://github.com/jgunthorpe/linux/commits/smmuv3_nesting/
>
> fa1528253d2210 iommu: Remove IOMMU_DEV_FEAT_SVA
> 5675560a272cf5 iommu/vt-d: Check if SVA is supported when attaching the SVA domain
> 94bc2b9525b508 iommu/arm-smmu-v3: Put iopf enablement in the domain attach path
>
> Let me know..

With these patches, do we still need ops->user_pasid_table?

if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) {
                attach_handle = iommu_attach_handle_get(dev->iommu_group,
                                fault->prm.pasid, 0);

// is attach_handle expected effect value here?
                if (IS_ERR(attach_handle)) {
                        const struct iommu_ops *ops = dev_iommu_ops(dev);

                        if (!ops->user_pasid_table)
                                return NULL;
                        /*
                         * The iommu driver for this device supports user-
                         * managed PASID table. Therefore page faults for
                         * any PASID should go through the NESTING domain
                         * attached to the device RID.
                         */
                        attach_handle = iommu_attach_handle_get(
                                        dev->iommu_group, IOMMU_NO_PASID,
                                        IOMMU_DOMAIN_NESTED);

Now I still need set ops->user_pasid_table, since attach_handle can not
return from the first iommu_attach_handle_get with fault->prm.pasid = 1,
but the second iommu_attach_handle_get with  IOMMU_NO_PASID,
suppose it is not expected?

Thanks

