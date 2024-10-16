Return-Path: <linux-kernel+bounces-368307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863E49A0E15
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B345282C0B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D5520E02C;
	Wed, 16 Oct 2024 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BoQkJ0wG"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711BC20B201
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 15:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729092308; cv=none; b=PUwRLoI3g47VWk7oZawT7LitkO1d353+xU9q+IGhmWDW7KmxJ7+oKXx0YmcQ1sijfrR7u4bXIuJ4/DSVFB34Um2BXnXUwHCviMB1kQL9fdiY9wHd2/0WZ6izQhAavVoG4tlx8K+h2OLAM+kzGfeLPOCRPTqKWzTNAk1L4Bsz4aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729092308; c=relaxed/simple;
	bh=Gxz5OaGC+Qadp7iG3WP91/k0Dd/+X8K1vvRHRws4en0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmetAobKvsaXWXXABU/iCiOgbOzD2XWp8EMp3alsFlwxjEObswkpGXKOxci85GMRvI1U/Lrlom9Ss7YEXa/r2vrq6aFd1+SFLng4Va9/bWW2KuUYJIE10Zx+UUh/E4Z9dYfVl8wjbALUGe4jU+kopJj8uDfrkrigDg1MznEgbAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BoQkJ0wG; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-288a990b0abso1715826fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729092305; x=1729697105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CjWIdbx6fjNxmaESEdgFKPth3aWiGnOIhiVNj6cHD48=;
        b=BoQkJ0wG9bqHtvg47LwF2n2J/SaN+RyZZz7yOXr1OgX1UfPtDeAF+psfCem6D7JDcd
         ckrZFKUYWEP4tFo3HrYfK8Vao96sRY/i3CQ+AAezQZgI0w9hIfqacYLC8qAdlrrV/b6u
         bwiWI5vsdlEaeuyo1rI+T9aJiVmkYoETd/iQje1BnreFF6cJPsvWDPhxIU379UicF2xC
         OhtbaBusz7rh5Phb30TYERDHt6WIZ3OqqC1ZzT3stVp2sNEJY/qeAEMseSwL8M9w7W0i
         ERDoZA46GckrW0xjIwiVEtCF/SFU/GN8Cw8byGFVtzKfNng7MOO1RX7fnwN/0AEva2If
         u8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729092305; x=1729697105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjWIdbx6fjNxmaESEdgFKPth3aWiGnOIhiVNj6cHD48=;
        b=S7gG3KFygEjytuih+ZEMpjoupdt6FpjNap+fS6y2IwsOjATA9Xy2QkBRwrV+6fZm76
         x01hZthPkiarCY/U103hq614ZTuvOeXuOL1Ug9HxGxZV4Cuc4PzbTLBBdH8zYacu1TsP
         X9jNSqquFpuIkvA45FGyc2I7AUhxA8vYOCv6ABJEIuvJSoVGj6UV0700q8FHFciQGVAg
         GFRAvJaXEunUHovJ5W1PusH74KpyUREy7Id1BaaUnOuFC2gJUUPo7Jd+k9EVW4lO4EKQ
         imkYZQ4oTrMfMdkZU/D9JUMTKIi7YMz3nze9U5iXNkJb51YrPj3O0f43RgBMPgFRxo2Y
         RQww==
X-Forwarded-Encrypted: i=1; AJvYcCXmUbcDUycmhJnGCtO8o5ux5k6FJQEUfj0teZbJZr/vV+5aEyD5nbZBWxFXWkoe6//RVeg+GAGHMvQr8b4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe7iOwAGTyBlNEa00ULSU5yCBRzXLg+vV0Pa3zy7jllD06EgE8
	B3O4l5bYNe8ZVqr8wDJ2WGBD7wWvhKHoEjoz0CvnrhwRmcpwNoZEhCOrjBJGU7w=
X-Google-Smtp-Source: AGHT+IHTbCtN3v7MBgWhJfsSvvyCftMb1j2RJtvVwpHEyVewjlSFT6OguCcs+kE/GdHA1PbG7MjK2g==
X-Received: by 2002:a05:6871:88a:b0:288:29ae:c981 with SMTP id 586e51a60fabf-288ee1146bcmr3961574fac.43.1729092305303;
        Wed, 16 Oct 2024 08:25:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b136395171sm197633985a.84.2024.10.16.08.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 08:25:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t15tX-0008zC-Tq;
	Wed, 16 Oct 2024 12:25:03 -0300
Date: Wed, 16 Oct 2024 12:25:03 -0300
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
Message-ID: <20241016152503.GB4020792@ziepe.ca>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-8-baolu.lu@linux.intel.com>
 <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>
 <20241015125420.GK1825128@ziepe.ca>
 <CABQgh9E+AnuyJgcM9tf1gEOUqcC_QSrA__Xha9sKYZp=NVRwhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABQgh9E+AnuyJgcM9tf1gEOUqcC_QSrA__Xha9sKYZp=NVRwhQ@mail.gmail.com>

On Wed, Oct 16, 2024 at 09:58:36AM +0800, Zhangfei Gao wrote:
> On Tue, 15 Oct 2024 at 20:54, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Tue, Oct 15, 2024 at 11:19:33AM +0800, Zhangfei Gao wrote:
> > > > +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
> > > > +{
> > > > +       struct device *dev = idev->dev;
> > > > +       int ret;
> > > > +
> > > > +       /*
> > > > +        * Once we turn on PCI/PRI support for VF, the response failure code
> > > > +        * should not be forwarded to the hardware due to PRI being a shared
> > > > +        * resource between PF and VFs. There is no coordination for this
> > > > +        * shared capability. This waits for a vPRI reset to recover.
> > > > +        */
> > > > +       if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
> > > > +               return -EINVAL;
> > >
> > > I am using the SMMUv3 stall feature, and need to forward this to hardware,
> > > And now I am hacking to comment this check.
> > > Any suggestions?
> >
> > Are you using PCI SRIOV and stall together?
> 
> Only use smmuv3 stall feature.

Then isn't to_pci_dev(dev)->is_virtfn == false?

That should only be true with SRIOV

> > FEAT_SVA needs to be deleted, not added too.
> >
> > smmu-v3 needs some more fixing to move that
> > arm_smmu_master_enable_sva() logic into domain attachment.
> 
> Will think about this, Thanks Jason

Can you test it if a patch is made?

Thanks,
Jason

