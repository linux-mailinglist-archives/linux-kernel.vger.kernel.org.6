Return-Path: <linux-kernel+bounces-369031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C32249A17FB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 03:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EDF0287580
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 01:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344611E517;
	Thu, 17 Oct 2024 01:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uoAg7Q5G"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB21A2D
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 01:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729129474; cv=none; b=N1gR4zLD/Lhf40RsIOzQXDgrLWRyQL5EGoNq84oFneL2Uqdc8QjvqeYl+QQEPF/UJhuIsV9CwBEITUMTjad94EAPpgyhHV1B8M7XBbUs5svx2mYReKQAg5V2YXVYBs9YSr6VWstBociNVlANGTQHFW8zzdTf2GoDr/9+u5RmLvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729129474; c=relaxed/simple;
	bh=2+pnXpEJ3Ejed6zS36rBiZimXMhI+VQNS2H6P//GnIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f6q5KMKh/gSt06CZkSDwMtELXbh/sqPZ9K9usvgaM2gBz3OPUoBWUcg07DhTawnQJnlZJq5nhQrOExjkbrIbH8b72GsckAWTDTmGmbW1CiKhVnJ/GdBkdHDc3vZy4/cKRe++r1mP6pQU2es0a3W/2zSTl138Suh2mVmpu6pZLOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uoAg7Q5G; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539e59dadebso626524e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 18:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729129469; x=1729734269; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bOLME2vkiS4WulapUGeKy8qBzIm8BZ3xRNuJKUmClTw=;
        b=uoAg7Q5GOesefggL/sil0B4rzHSvF6K+wn0kUOH/RD8nytmi1kAuuP+B08gIGqnT2z
         ox8kP6V6z17GvP2G4lHbhj77qh304wM5jBb3SnUnUw4Qo90Gr8uOUlFNqWb1OyFQgcPP
         VYtESDTQme1HtdQkiVQNy6vc2KabpVIFcWs1hist2Z+NusFLxKexLKnBdXmaydD3MGpZ
         f2oFgZlJuc5Rgxc0aDm5/xU/eg+7EihhC3KudlXgT9VqkYYd3lZqpCa9LI4HMpNpFBPq
         omQnEvYHm6aOfWh1UOk9YZpdhaEl/7VhpZTDfa6nohq9N64Ug//e9RbDzhw2OfAEs8fu
         N8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729129469; x=1729734269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bOLME2vkiS4WulapUGeKy8qBzIm8BZ3xRNuJKUmClTw=;
        b=MP4wtJkf3ahcY6DKW7GPNaSMXYCh3JU60c+EnIoMzFy2KtdzLxUy+LhZiFvwui9Csl
         /iPomBZzvwPuvrJ/x7po40PYaUeH4KXxgIu1gXKt0r7vBdp8/WkuBVXO4CZB+EdKmdfw
         e+QklWPyrpaeHAeoG01g0o/sI+oO0Rz0AVuIS46AFYR++iYrRxhIikFXQbWANcOLGl1Z
         j3IQ1K2pStwoOPAOD62396hvW/24SIreIH7dChCW/uddQ9sDP1OguP5g1/1JVsu3v22a
         ISwOSMf4vVSMZDHwTwNvJVHY/jwaGj0F5M3kJeADiHbwHuwpPm+KECrgI7QqAzYorgOE
         Tolw==
X-Forwarded-Encrypted: i=1; AJvYcCUmL8c4S1qvqTFOA7ODK4VEIPc441RnGl/yWcTactCyGLrqMLlZLGgF+39IiTpZSIi+i8e6ThlmdEoaFZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1bu9h9vOesMuwbjkQD6pskn2i6pbsAKrZthP67wiMBM4Tc0SZ
	ycutUwbnqXIYBzjsaJ39QysQ+lOPPFQj+c0lO5H9E+Gh6Nck6TCnxVGpVDc3BTkoBHHpxdFWPjZ
	cKmXipCHNaGutDhjru7zgI1m8pZUNbSRzJJOOyA==
X-Google-Smtp-Source: AGHT+IGqvkXfSOamlQfTibVlHYj9ChYt1KAqdmYe0Mwzkkqn6GXfzsT96yxwcBZHy6+yoP+eA8EwacKcwppzcsWH1y0=
X-Received: by 2002:a05:6512:124c:b0:539:e333:181f with SMTP id
 2adb3069b0e04-53a03f04762mr4004850e87.10.1729129469334; Wed, 16 Oct 2024
 18:44:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-8-baolu.lu@linux.intel.com> <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>
 <20241015125420.GK1825128@ziepe.ca> <CABQgh9E+AnuyJgcM9tf1gEOUqcC_QSrA__Xha9sKYZp=NVRwhQ@mail.gmail.com>
 <20241016152503.GB4020792@ziepe.ca>
In-Reply-To: <20241016152503.GB4020792@ziepe.ca>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Thu, 17 Oct 2024 09:44:18 +0800
Message-ID: <CABQgh9FCJcOa0G0Kj__NUm-Q8C9uH4ud04XcHv+3c48T2qEnug@mail.gmail.com>
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

On Wed, 16 Oct 2024 at 23:25, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Oct 16, 2024 at 09:58:36AM +0800, Zhangfei Gao wrote:
> > On Tue, 15 Oct 2024 at 20:54, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Tue, Oct 15, 2024 at 11:19:33AM +0800, Zhangfei Gao wrote:
> > > > > +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
> > > > > +{
> > > > > +       struct device *dev = idev->dev;
> > > > > +       int ret;
> > > > > +
> > > > > +       /*
> > > > > +        * Once we turn on PCI/PRI support for VF, the response failure code
> > > > > +        * should not be forwarded to the hardware due to PRI being a shared
> > > > > +        * resource between PF and VFs. There is no coordination for this
> > > > > +        * shared capability. This waits for a vPRI reset to recover.
> > > > > +        */
> > > > > +       if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
> > > > > +               return -EINVAL;
> > > >
> > > > I am using the SMMUv3 stall feature, and need to forward this to hardware,
> > > > And now I am hacking to comment this check.
> > > > Any suggestions?
> > >
> > > Are you using PCI SRIOV and stall together?
> >
> > Only use smmuv3 stall feature.
>
> Then isn't to_pci_dev(dev)->is_virtfn == false?
>
> That should only be true with SRIOV

Do you mean
if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn == false)
    return -EINVAL;

This is fine

>
> > > FEAT_SVA needs to be deleted, not added too.
> > >
> > > smmu-v3 needs some more fixing to move that
> > > arm_smmu_master_enable_sva() logic into domain attachment.
> >
> > Will think about this, Thanks Jason
>
> Can you test it if a patch is made?

Yes, sure.

Thanks

