Return-Path: <linux-kernel+bounces-369726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE12A9A21D1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2751F2659F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 12:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4231DCB31;
	Thu, 17 Oct 2024 12:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KijUx08A"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6EA1DC1B0
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 12:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729166723; cv=none; b=OkHJixu9yRJX/YrffcY88tricR0D/yH18CuBx9oqTVsAsKdkGgzncaqSmib4+4h9rEykcimSEl+K8i+5iVQegDGGU5evi3d2c8MdxM0jki543o77Z1vzCWoudr1op1FR0eXtbIBgJSaBZZ+KTsngPEo7F7S4vKERnsly2elpcEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729166723; c=relaxed/simple;
	bh=9Ou2IPV+fUYVUZFwDwpHsxjEEQ10P3Z4LAfWFwq7vtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hG6WeqHtBMVLAAF6AZTKex4laeWpaT2vWL1ge7V3UghjSxMv0xRkgFZPF6hrC8OMG3P+fPCpkAN1k1hXP8KzZVzoEXb8S53k3kTRXktVWM0lfW5yzcXIuVTFFnz6B4XDIVG4nLbAucLRRvXzHlkuSg2yFBqqwMfwKZJ4FY67svk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KijUx08A; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b1343e8042so91248885a.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 05:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729166719; x=1729771519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WqYmbfPGoH8bApHw169OlytcN5sSb6v9X/QNj/xnHLY=;
        b=KijUx08AlHYtHrA2jgOdifSWEYiLQFzyY36aeC4rTOpydkvadY+Cz0WdivVZZXRGdD
         XhDdBduzP5EiezyHilXhun2+QX6fQ6C38zgyovR4CpWqd7lgpse0lztR95Hs7Ziz0zgP
         Of1ue2F55X8DtoB4lS3BnYZSw4/Zyu0/zYEdFz1Bc3xmOm06j6C5+jN7IDO596y3Ezpt
         WOEOsMKmuncHYprqDM6SCTNS30FHx1PVqt3TMX2kBRH9bpKMO/Ur/5TEwG8nUwG6CRb1
         XiUNuEXp+8D/fWjLwhWPQPkzh1bmUnlHgEzmrzIT9Q/+one2so1zKdrchSe3uI8EM4JE
         j+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729166719; x=1729771519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqYmbfPGoH8bApHw169OlytcN5sSb6v9X/QNj/xnHLY=;
        b=kB9qLr8jgVnwn+fxQUEeexcNPtSdj71IGqN6mXXxy0BANGYkcAif5sFPeAhn8WNEzp
         DW+ajHbHhfpW/iYV/EITSnd9Mt3J0eRuOXZ5Yb+mkU5QQtIyYPf/zC3/L/FY/1EUOSvR
         MfOLG3QazS6K/d5rITEQHp7HHgkYUfsBdm9DA4M+49w3hRI4NsnApoCnrcVbC0JGbhwz
         NgogrhxJeq8M6OWi96e1/KTip/9HAeL8itTsErzDpxA0pQqvOG+EiKDmrLA0ytDlCxhi
         5hyI1DAZVih8LVSQD5m5ljymvh5V9lfMu4wHhvNU41mzLxcnAjGwlSis5T1e1QbE3sxx
         mopw==
X-Forwarded-Encrypted: i=1; AJvYcCXlKlWoix/qeQoGEMon1c/JE9i62p8xSVfw6dGb9jW1Zcv0dvhkOEhTlr8TmIc60Y0nd/I8dnaACSztJQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo2D4RpXSkCa9kn48witgHZSuCdqCrrp6CTEeyisvnXT6q/O6P
	7cRPKNRvCnzTFHSo5jMb60gJ99BzLbfnyGQjzIKceg6AqjTVRhdiuX5+Z93332U=
X-Google-Smtp-Source: AGHT+IEPtt04l70kN6bicB55lZv2cm4Yf4rIE4G65war3hf5YJH+Qt48rYAG8z4yCn6t9Q2qUjjXgg==
X-Received: by 2002:a05:620a:44c5:b0:7a9:ab71:f820 with SMTP id af79cd13be357-7b1417a24ddmr959080985a.4.1729166719151;
        Thu, 17 Oct 2024 05:05:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1424ba332sm223436285a.81.2024.10.17.05.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 05:05:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t1PFm-003iH2-4Y;
	Thu, 17 Oct 2024 09:05:18 -0300
Date: Thu, 17 Oct 2024 09:05:18 -0300
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
Message-ID: <20241017120518.GI4020792@ziepe.ca>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-8-baolu.lu@linux.intel.com>
 <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>
 <20241015125420.GK1825128@ziepe.ca>
 <CABQgh9E+AnuyJgcM9tf1gEOUqcC_QSrA__Xha9sKYZp=NVRwhQ@mail.gmail.com>
 <20241016152503.GB4020792@ziepe.ca>
 <CABQgh9FCJcOa0G0Kj__NUm-Q8C9uH4ud04XcHv+3c48T2qEnug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABQgh9FCJcOa0G0Kj__NUm-Q8C9uH4ud04XcHv+3c48T2qEnug@mail.gmail.com>

On Thu, Oct 17, 2024 at 09:44:18AM +0800, Zhangfei Gao wrote:
> On Wed, 16 Oct 2024 at 23:25, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Wed, Oct 16, 2024 at 09:58:36AM +0800, Zhangfei Gao wrote:
> > > On Tue, 15 Oct 2024 at 20:54, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > >
> > > > On Tue, Oct 15, 2024 at 11:19:33AM +0800, Zhangfei Gao wrote:
> > > > > > +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
> > > > > > +{
> > > > > > +       struct device *dev = idev->dev;
> > > > > > +       int ret;
> > > > > > +
> > > > > > +       /*
> > > > > > +        * Once we turn on PCI/PRI support for VF, the response failure code
> > > > > > +        * should not be forwarded to the hardware due to PRI being a shared
> > > > > > +        * resource between PF and VFs. There is no coordination for this
> > > > > > +        * shared capability. This waits for a vPRI reset to recover.
> > > > > > +        */
> > > > > > +       if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
> > > > > > +               return -EINVAL;
> > > > >
> > > > > I am using the SMMUv3 stall feature, and need to forward this to hardware,
> > > > > And now I am hacking to comment this check.
> > > > > Any suggestions?
> > > >
> > > > Are you using PCI SRIOV and stall together?
> > >
> > > Only use smmuv3 stall feature.
> >
> > Then isn't to_pci_dev(dev)->is_virtfn == false?
> >
> > That should only be true with SRIOV
> 
> Do you mean
> if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn == false)
>     return -EINVAL;
>
> This is fine

No, I mean on your test system you are not using SRIOV so all your PCI
devices will have is_virtfn == false and the above if shouldn't be a
problem. is_virtfn indicates the PCI device is a SRIOV VF.

Your explanation for your problem doesn't really make sense, or there
is something wrong someplace else to get a bogus is_virtfn..

If you are doing SRIOV with stall, then that is understandable.

Jason

