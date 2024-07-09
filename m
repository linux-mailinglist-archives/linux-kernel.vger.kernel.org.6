Return-Path: <linux-kernel+bounces-246490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9BE92C29C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEFED1F23743
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8007815B116;
	Tue,  9 Jul 2024 17:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dOjzDEUf"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5A11B86F4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 17:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720546607; cv=none; b=uYaYoT1CTIA/UeQ22xUZRd63U6IthPBZJWidtNpj+6I45kPkdzK4r4kHpG4P7po7Giesd76l+i48Fy/ShSGkljIOPmHZ/cQIOGDa61rnkG2RTKsgCG9cv30NocpMnpwT9sCdxWgR4oVK7wxfcdtF21T+UuPKJklQatAselyoxzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720546607; c=relaxed/simple;
	bh=ybUpRykbhepziN9syApY4S0KNYPzhQzyVpqfFsxbFkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ToebmOkyrWa8T5z74ae4QrUEjOkXFw/UHn/6XEjhI7ocKGom8yeg5coUhjFmrFCBTt845dGNbhc2KnoHGJ1uqpvCoNHOoY+CpZ2NmruGHFSTLpfQjO7w+Nz88iEputofV1HZ2lxU22Qjc8awLJV9yuYrmC4f621VtkyPTvx1pF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dOjzDEUf; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-447f0d20592so13015671cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 10:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720546605; x=1721151405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3ktxBVI1f7SCZNiJbmLEe3WqbtU8UsAv3DUj8UortQs=;
        b=dOjzDEUfHei7tFOTN2iDhLFIsxQfSKBU7YN++x09ZoFprzt0bwVqduq9O4tIn7lEtx
         rte38R+Es2e6nB8QlZ1BjI4fNLtIBZiinnjZTupxko8qX4LW69K+B4YSk8msiDu4ROkI
         D2vOJXIfRiylG7OXdTEshrYn9/8bLS1p2+HOM5CotimFeaNcW8L7TDLD+N7QSLQR1ktL
         bFr3RC5vNXvcNxvOiGl95LcZPdBdQhfKmVh2yFHmLYW1DN1gaKdMfv1Ds/xHmw0rgqx1
         tSsH0y8aJI0CpjjXkRYJ6LRdorChX4zwgORo2glzKbc9M9/96FtEgGNU04KTSjXUccqt
         tqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720546605; x=1721151405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ktxBVI1f7SCZNiJbmLEe3WqbtU8UsAv3DUj8UortQs=;
        b=wMiWcXlssNmav/NEkkcpA/8+37leyF0zVPdCMM7CV05m2XZ2vI9j5ZyBvztkTWpzNj
         TeuETbS20+lTFfvnLyeCzBR4g/3BI32zt/qNeLN/NbB9kw+BL+xS651OD7oiaNGET1CF
         IE2Fh8RfIqgieUzsnW6Cu42djWDcbHxmaLXb3Ac0sz58lY4ClwfDfoV/qDxGHp8VLbJI
         r4Qko9ouAebVXT0gpwvpDDdMjOcafkX90wBiHHcTpmTkFaeHpGQaiQOTh2Is9gdQJkO3
         oguZgOCzRnOgw7eNNRZ46iTFeLSaXvA1RZ8mUqDxA9zM+XxszgDGvSMtHO+QLnJFtYAp
         8l/A==
X-Forwarded-Encrypted: i=1; AJvYcCWR7ITS/DkVDTj5k+ROViaVXwBbG1W/uTBNl4ag8c0njpsIFwaSqPgEE6Gy/bTpC056vjO9EfWENbIQzbKYlX32ASZc3G+SPmj5KOta
X-Gm-Message-State: AOJu0YwwN0sgwPL3R/TEHDJsIb8aQkXJjFzi+DyVPxJcDKdjk+75zznq
	y8SrWOdOOIejRNa9IUKx62AHS2tXUMeHoSjY5w0EDaZCoSbkppVURPfZjWaU0pc=
X-Google-Smtp-Source: AGHT+IEey3aVdoUnVEY9s9+wQwMkPK21WmHGPGMn7kqGKdsDHciJdWQY/uQZYPc75ra9uDqujYUDpg==
X-Received: by 2002:ad4:5d6e:0:b0:6b5:7ee:1d79 with SMTP id 6a1803df08f44-6b61bce1891mr38703216d6.26.1720546604791;
        Tue, 09 Jul 2024 10:36:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61c40e5e7sm10084406d6.72.2024.07.09.10.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 10:36:43 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sRElf-002kZ7-8R;
	Tue, 09 Jul 2024 14:36:43 -0300
Date: Tue, 9 Jul 2024 14:36:43 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 07/10] iommufd: Fault-capable hwpt
 attach/detach/replace
Message-ID: <20240709173643.GI14050@ziepe.ca>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
 <20240616061155.169343-8-baolu.lu@linux.intel.com>
 <Zn8oZ80p0p1bHgBC@ziepe.ca>
 <7421b923-0bd6-4c9d-81e6-07d954085171@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7421b923-0bd6-4c9d-81e6-07d954085171@linux.intel.com>

On Mon, Jul 01, 2024 at 01:55:12PM +0800, Baolu Lu wrote:
> On 2024/6/29 5:17, Jason Gunthorpe wrote:
> > On Sun, Jun 16, 2024 at 02:11:52PM +0800, Lu Baolu wrote:
> > > +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
> > > +{
> > > +	struct device *dev = idev->dev;
> > > +	int ret;
> > > +
> > > +	/*
> > > +	 * Once we turn on PCI/PRI support for VF, the response failure code
> > > +	 * should not be forwarded to the hardware due to PRI being a shared
> > > +	 * resource between PF and VFs. There is no coordination for this
> > > +	 * shared capability. This waits for a vPRI reset to recover.
> > > +	 */
> > > +	if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
> > > +		return -EINVAL;
> > I don't quite get this remark, isn't not supporting PRI on VFs kind of
> > useless? What is the story here?
> 
> This remark is trying to explain why attaching an iopf-capable hwpt to a
> VF is not supported for now. The PCI sepc (section 10.4.2.1) states that
> a response failure will disable the PRI on the function. But for PF/VF
> case, the PRI is a shared resource, therefore a response failure on a VF
> might cause iopf on other VFs to malfunction. So, we start from simple
> by not allowing it.

You are talking about IOMMU_PAGE_RESP_FAILURE ?

But this is bad already, something like SVA could trigger
IOMMU_PAGE_RESP_FAILURE on a VF without iommufd today. Due to memory
allocation failure in iommu_report_device_fault()

And then we pass in code from userspace and blindly cast it to
enum iommu_page_response_code ?

Probably we should just only support IOMMU_PAGE_RESP_SUCCESS/INVALID
from userspace and block FAILURE entirely. Probably the VMM should
emulate FAILURE by disabling PRI on by changing to a non PRI domain.

And this subtle uABI leak needs a fix:

		iopf_group_response(group, response.code);

response.code and enum iommu_page_response_code are different
enums, and there is no range check. Need a static assert at least and
a range check. Send a followup patch please

Jason

