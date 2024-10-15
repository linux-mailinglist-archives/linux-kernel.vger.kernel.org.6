Return-Path: <linux-kernel+bounces-365827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6435A99EA6F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2399D287E8D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8B81C07DF;
	Tue, 15 Oct 2024 12:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lf3FvcE+"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0993E1C07D9
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 12:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728996864; cv=none; b=kDINPyKH8Z4yiGMJrAso1djvvCJiSTnYqwkSWK61utR+dwBVExio2CTd6Vc2EXxhQ3Ow4yx6ceCiXuK8K5QgmwX9WywKbySXd/lSp/v7n0zXo3s/JKXRZOrzoPexiwsb1qJKet+Ie+uITvOQoY/im5jIOpAM5jjoE76019RNMMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728996864; c=relaxed/simple;
	bh=i4IXolkJjiswk2VvQqrP3XoASrWnqInKJYEPGAho1LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4Ec899wsf4xceRQHaK8gFskIia1zNICf+LniXLJhGN3NTSE4YAgZDB0AaK5gntSbj2QChH5sI9JA9iQwGbUsvMR+ZDKjuIus97sMR1P0YTskzg0BC4D3xwOUvnMJyhnlzI3eG+qSKVn4O+RwYqbYdjH/PO8wL8r/55NCA4X1wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lf3FvcE+; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b1363c7977so60525585a.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 05:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728996862; x=1729601662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GXrdlSFMUk7+CH9DKGI8Zx5IfrY4LnBclgt58OvS+5w=;
        b=lf3FvcE+j85GWqdS1fXbcwdsGwIIjTrcFpsMT6ZnNJ2WD+TpL8V/k9vWUvOQje/zTj
         3WtTdbtfZUQfSgiKG1z2FnihYrpoP0xPtLfo68YxZhCM2pD2o5ArH9stC3356EcAbJje
         zujZcKEHBzgR/LitfMWuvmd2/Xbc27ubiFNzFTqceqE/8MeumH58nc8Gq/lxbmF5dPGe
         UPx61wTukjUiVOm74vbzOexKArzvVKq7ZZebcDlhcN3qfuobukGTZazj9IP3hzS4e42J
         3JP8ed7sJcKSknYZFUDo2/19GsbK9ysym6Spi4VtRSxWvEHIMaGLMdLO2yZE5PZxcfQq
         DxLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728996862; x=1729601662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXrdlSFMUk7+CH9DKGI8Zx5IfrY4LnBclgt58OvS+5w=;
        b=hqVXfsPsPhaQrtIbpe4DdUb8pA5J3MyvjYwuAt0BmBHgNmbZg9wG960KVTF7CX3NtD
         JNUxi+8BfyZY+yMuD0O7tmbIM7xd/jNiAtu+UC1mScxdRaFRTfEcfVCQbCjtyi3lSBVQ
         bKonVBzyLcl/zBCsCSWmc4vmp4R4S3sFmh/gvBgJRW7TgsGV3Lwr7AoWlUHH6SEaKhoc
         8ObMWD6JSJEhmedVmY6kfc9AfeSpfyLv38UBST90vbda0eqYeuychsHLIN6NMYGfedH1
         YgKxH3AfmmVqtMw6DxTMrdJmIrolxKqOWCIrNgJEAeYRJn/wrwVOKqbzfFAk3FRkYA3d
         HGmw==
X-Forwarded-Encrypted: i=1; AJvYcCXHjaNqNOjYEmW5Fp8nL0GS+v9XTGi84rhK08cby1Wx80fyxd02Ek0lr2do375E5xJ2xT1omZo1bPLgEEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVRdi6xMBpbW0SD/kGNumPRJzhJ2QpP0T04MX2W91tQfC5Mq19
	rlCNWFxae3PZJ3jazTD5lYl5Qq4K/h8medZZjG7svP6RHIo0cRmrte9ee5Q50EVCjO9AD6BupTA
	V
X-Google-Smtp-Source: AGHT+IEY7UaOsHtqws8kw4oYjkjQT/STsmKzQC1Y7WlXbDI4yfdqKavj7rrCgoa2GhsXIWLphKj2jg==
X-Received: by 2002:a05:620a:1a03:b0:7a9:bf33:c174 with SMTP id af79cd13be357-7b1417cac1amr47266685a.16.1728996861913;
        Tue, 15 Oct 2024 05:54:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b136167139sm68208785a.26.2024.10.15.05.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 05:54:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t0h48-00D49x-If;
	Tue, 15 Oct 2024 09:54:20 -0300
Date: Tue, 15 Oct 2024 09:54:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v8 07/10] iommufd: Fault-capable hwpt
 attach/detach/replace
Message-ID: <20241015125420.GK1825128@ziepe.ca>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-8-baolu.lu@linux.intel.com>
 <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>

On Tue, Oct 15, 2024 at 11:19:33AM +0800, Zhangfei Gao wrote:
> > +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
> > +{
> > +       struct device *dev = idev->dev;
> > +       int ret;
> > +
> > +       /*
> > +        * Once we turn on PCI/PRI support for VF, the response failure code
> > +        * should not be forwarded to the hardware due to PRI being a shared
> > +        * resource between PF and VFs. There is no coordination for this
> > +        * shared capability. This waits for a vPRI reset to recover.
> > +        */
> > +       if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
> > +               return -EINVAL;
> 
> I am using the SMMUv3 stall feature, and need to forward this to hardware,
> And now I am hacking to comment this check.
> Any suggestions?

Are you using PCI SRIOV and stall together?

> > +       mutex_lock(&idev->iopf_lock);
> > +       /* Device iopf has already been on. */
> > +       if (++idev->iopf_enabled > 1) {
> > +               mutex_unlock(&idev->iopf_lock);
> > +               return 0;
> > +       }
> > +
> > +       ret = iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_IOPF);
> > +       if (ret)
> > +               --idev->iopf_enabled;
> > +       mutex_unlock(&idev->iopf_lock);
> 
> Also iommu_dev_enable_feature(idev->dev, IOMMU_DEV_FEAT_SVA); is required
> In thinking how to add it properly.

FEAT_SVA needs to be deleted, not added too.

smmu-v3 needs some more fixing to move that
arm_smmu_master_enable_sva() logic into domain attachment.

Jason

