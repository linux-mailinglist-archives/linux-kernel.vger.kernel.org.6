Return-Path: <linux-kernel+bounces-369765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D869D9A2251
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA9B41C22426
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 12:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A891DD54C;
	Thu, 17 Oct 2024 12:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="avnITiSE"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721C81D31A8
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 12:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729168541; cv=none; b=BHOXaiBaUKKJvgXgmp8JV9oHPpe5nHicOxpe2ji3gNUlzhcHcSCkG8qP66bJGijG6yZmT8UA3eJ3lHWCfFcnxXNTLNP44ATWX5OL/d7ZrcwnJzfKhH9mzwvogRrTGwjBLeOEnu0h4zYGgMIcJzb/AFvvhYlQVwPGYSF3iJD55Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729168541; c=relaxed/simple;
	bh=stgROs37qwDGESBufWBachz+WHBFXWh4SvTQfT/sml0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WkA28OlXuCwqFXG4hgWLihCieEZUgGEwPXyx2OybCvVoCjynCl+4+NLRShixfhuFPWaCk9Q6ON89qf9dLAedldpS0XsMP33fknEin7EXU5VCCX2NZIqQ6Xdqvbi3+4mHusRM1wsTww7pi86wUenN2FZXghjJWqvmQZCiDlnc7Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=avnITiSE; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539f72c913aso1106512e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 05:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729168536; x=1729773336; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kM7OrfRTdZQrTofk4LGSXNvpUV7LDhsGRtxbKPLtBSM=;
        b=avnITiSEpTXcPDbCEm4fG5RSzHTnvQSFPVvhP+AfnyqjqOKhWh0jqCYPRIq7hFAoJK
         50H5LTYUHWbklWRtKjx5naFhPQYRhnHqhjjgMWU+CNnLEvtZsQbJGP3rmmELgJvtOpiE
         V4UAgvkUZFeCSo7thHe3CidJ8a5sgOJ7NNmsLma2mI2rp5woyYhpDR4tm1zN9r+D9hU3
         OmMUMovz7u8soHg8mWK0tjVz5vEtVfoH0RQEwmN8nSwG32IchANBnkT/n7ExCGc+gyvp
         J3HCXE6cgQyCrXY8S4SdZ0ihjHKqPY+HgMMTqUabq0cyBwHx/pFTZWlsQ++b0VAUTOU4
         iF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729168536; x=1729773336;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kM7OrfRTdZQrTofk4LGSXNvpUV7LDhsGRtxbKPLtBSM=;
        b=XxR8tt3/H8HcNQrtQHDxQKlXMeIBIUutA2/gt2lU2dvpBNhYz2UZoIGYOKTWNPDaAq
         touXXbSO1Aqi7aUCJIA3Pn+zo2JDS/5QlUYTd9QFPsXzG3M2TM/njGlARVGCuKRYcnIJ
         gJmY3ztLhpGrrzhGAEmixkLauN9CpeLVhaSKF5KoL0FtWKmpcy03sOz0/fyDQQQDZO6s
         3C2CHqqkGiHg+x56WBzgPQ99T92FZI/WBv2RSTsNXxqC5FtKb3GYWLV3Qzs6ilsT19g2
         LEbnBXZwSIXbflZbBpSvdj5TKOwflQ2mh5zGOIVNkHoVfKcrAyFSCF1Mj/e66qXfZTOV
         v2yw==
X-Forwarded-Encrypted: i=1; AJvYcCXOPJltk3VYAI8zbvAcL/ggotUMAWi0yUC+0S6AXXEYiiBM10l+/Wp7bBUu8EC/3/6LayGUeR46HkRUcbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFoacdzczXNvAYCVQj+Mx3JjNIRhcAyy94jHMa9y+j2jiGqL6e
	lvSsYYz8wc/xwGRwbe/m0nP/cDcI9JLzXGSaLWURUZqyMNb4b2sl40LOhbx7kHTD13Kr2ChicsT
	q/ibpqkNjSsBORQ/7c2fYZZ5zUeJDmPhSb4YseQ==
X-Google-Smtp-Source: AGHT+IH4WJKolhUJPprqECOsvSWy5mgerznZLfFjdhTs0fsqDZ0hzHkE+rz7FwoNqJnQZ8jgoGMGTXT1t5RYO39n54k=
X-Received: by 2002:a05:6512:3085:b0:539:e873:6e6 with SMTP id
 2adb3069b0e04-53a03f82439mr5602333e87.43.1729168536304; Thu, 17 Oct 2024
 05:35:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-8-baolu.lu@linux.intel.com> <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>
 <20241015125420.GK1825128@ziepe.ca> <CABQgh9E+AnuyJgcM9tf1gEOUqcC_QSrA__Xha9sKYZp=NVRwhQ@mail.gmail.com>
 <20241016152503.GB4020792@ziepe.ca> <CABQgh9FCJcOa0G0Kj__NUm-Q8C9uH4ud04XcHv+3c48T2qEnug@mail.gmail.com>
 <20241017120518.GI4020792@ziepe.ca>
In-Reply-To: <20241017120518.GI4020792@ziepe.ca>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Thu, 17 Oct 2024 20:35:24 +0800
Message-ID: <CABQgh9EnEqDKkxg3VUgjSqBzz27h8B3Ct4w=A0vR6JK=d7fXHQ@mail.gmail.com>
Subject: Re: [PATCH v8 07/10] iommufd: Fault-capable hwpt attach/detach/replace
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 17 Oct 2024 at 20:05, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Oct 17, 2024 at 09:44:18AM +0800, Zhangfei Gao wrote:
> > On Wed, 16 Oct 2024 at 23:25, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Wed, Oct 16, 2024 at 09:58:36AM +0800, Zhangfei Gao wrote:
> > > > On Tue, 15 Oct 2024 at 20:54, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > > >
> > > > > On Tue, Oct 15, 2024 at 11:19:33AM +0800, Zhangfei Gao wrote:
> > > > > > > +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
> > > > > > > +{
> > > > > > > +       struct device *dev = idev->dev;
> > > > > > > +       int ret;
> > > > > > > +
> > > > > > > +       /*
> > > > > > > +        * Once we turn on PCI/PRI support for VF, the response failure code
> > > > > > > +        * should not be forwarded to the hardware due to PRI being a shared
> > > > > > > +        * resource between PF and VFs. There is no coordination for this
> > > > > > > +        * shared capability. This waits for a vPRI reset to recover.
> > > > > > > +        */
> > > > > > > +       if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
> > > > > > > +               return -EINVAL;
> > > > > >
> > > > > > I am using the SMMUv3 stall feature, and need to forward this to hardware,
> > > > > > And now I am hacking to comment this check.
> > > > > > Any suggestions?
> > > > >
> > > > > Are you using PCI SRIOV and stall together?
> > > >
> > > > Only use smmuv3 stall feature.
Sorry, this is not correct

> > >
> > > Then isn't to_pci_dev(dev)->is_virtfn == false?
> > >
> > > That should only be true with SRIOV
> >
> > Do you mean
> > if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn == false)
> >     return -EINVAL;
> >
> > This is fine
>
> No, I mean on your test system you are not using SRIOV so all your PCI
> devices will have is_virtfn == false and the above if shouldn't be a
> problem. is_virtfn indicates the PCI device is a SRIOV VF.
>
> Your explanation for your problem doesn't really make sense, or there
> is something wrong someplace else to get a bogus is_virtfn..
>
> If you are doing SRIOV with stall, then that is understandable.

Yes, you are right
 I am using SRIOV vf and stall feature, so is_virtfn == true

Our ACC devices are fake pci endpoint devices which supports stall,
And they also supports sriov

So I have to ignore the limitation.

Thanks

