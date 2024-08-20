Return-Path: <linux-kernel+bounces-294051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8162958849
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E92FA1C210AB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FA5190679;
	Tue, 20 Aug 2024 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RNK5O+ZB"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18333189F3F
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724161918; cv=none; b=liJeLNUmy6vjAMhQQT0MpJ/QyvpA6loI95fKjA4jNzF4MPcTaJt7Y/q0MAItoQsL96uvlv1g+va+5HzbZdUZW+hAiXIXyFwf/FKve9CgVAHjBWpt43qQ0EkCTBkz1QpUNYH4ytUFUYBNVOuf1loK3h4PuyfTsrCG9PQ4Q6z5s9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724161918; c=relaxed/simple;
	bh=97OqfwoT8bEFm+agkfbPwaf/JyVQpFAXVsk7wW7MwcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsbiPZ9yJ/PdQ6QIAGGz9hVZMyuPvVnam1i+k11z95pTpjOasgw9VeaFGs760bkJE2TjBvnPpW94Jiu+7y3InX+X5QSuAAI9FryEhGheUdsJ70dWNB3sE7WRmhUZqS9L7h8UHKUZx6roAu7SSxv7wfzm7CfFHxNnkLwwarbkJUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RNK5O+ZB; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-451b7e1d157so35997591cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1724161916; x=1724766716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iPMBqKgTvu/q/t3NJNOvrEVL1q4BW88uaiAwCMNkjIY=;
        b=RNK5O+ZBAhXaOvZFfMv0aieHUXhu6esXAVkMXHwvXJglYgLMWjrk2L9FYv5U76Ylt/
         QuWQFAYhv3Apfd8yVGnhf0RCgnbaRXeEPuvjulsOczRs2sy7mIsF57PfvTTjgnh6dgxF
         b9HtAiskd7fPjEgxreMFkK1g8z2b4exP4XlnR5aG7vxpoupeDRHcvqVew5F/uLXoW9ir
         ZrKQLRr3pfE171ZQ0juZ5GMbZ66yrl62TlRbxZJZbCFirxlBdXzneNUYjgiE6c66Nmwi
         6IFYVq4Q9Oc2yGGuS+CK8GTkBrPVgyjZEC66GVb/R0DPV/OQiSyJ0kOfEJpMqzLGnLd/
         rsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724161916; x=1724766716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPMBqKgTvu/q/t3NJNOvrEVL1q4BW88uaiAwCMNkjIY=;
        b=FrZJAfwOGyHPtj18I4+SGCMFwijH5ghZCzQkiJDVm1pfOH3gYFWoo8RTdhqexkY81p
         XzJ6iG6iXxAMBJx64FSgETLvZ6mxRtOcyYN274WEAQ9eBk3Dz4JK+f8RkZXiQbdINN27
         hCmAo+WdOFZWeLVUlcoS3TDvDCOtvfit1ocNSx8T/H5iDiUEBfebFttLSDgHLfwLYXrx
         E7cuHG3B0LX0bxxcXGAxI4jgIPzgpInrrU0V4XaNt0bIXfI4VYDTVOrUhfIrZqxx29Hb
         d1aImYEL3uqZfy+yeIfq2Q4vDqwpVmO3F80szlnvgnMmj1bIVFDsMhmYYCwY/2Lhc7VX
         F15A==
X-Forwarded-Encrypted: i=1; AJvYcCWfKgXGwHj7zCoDajF4mtSZe4tmL5dJ6KV0xoB5HPti0KXRQPCUIcUgnrqIG9EKjtWchCaSvxStXAhZCwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVZOoK+P5qPxOrn8F0e8DO/piwx4EaM6jkGpWQLTQeNIgxGHT4
	BlmpFMTfClvgVbnsTFbMLcBW7CvutmrmzcXHae2cbNp8UJh8mwtWkDmAemHrJHs=
X-Google-Smtp-Source: AGHT+IE8l4btvL7gxpv9mQUEjr4ul3TSWB5MNmKj7f4Jk9Pj3F1VoaUwJFVfS7skgn4lp6UUwD3NCQ==
X-Received: by 2002:a05:622a:1f13:b0:446:5ac5:f9dd with SMTP id d75a77b69052e-4537420d824mr161727411cf.14.1724161915910;
        Tue, 20 Aug 2024 06:51:55 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454e904ff81sm5792571cf.35.2024.08.20.06.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 06:51:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sgPH7-002VqE-VD;
	Tue, 20 Aug 2024 10:51:53 -0300
Date: Tue, 20 Aug 2024 10:51:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Move PCI PASID enablement to probe path
Message-ID: <20240820135153.GW3468552@ziepe.ca>
References: <20240816104945.97160-1-baolu.lu@linux.intel.com>
 <6650ce02-ac85-4cb6-941c-cc7e8b6effc4@amd.com>
 <92b55591-e106-4366-ba5b-0588af50770f@linux.intel.com>
 <635b24b7-632d-4046-b82e-6ac6976686c9@amd.com>
 <0e807eec-ce51-42e2-9290-dc90c4210888@linux.intel.com>
 <20240819123400.GU3468552@ziepe.ca>
 <4d9c1513-8062-4594-a06a-c9f179abdaab@linux.intel.com>
 <72e59734-431e-4eb4-b27c-44eefab3dcb0@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72e59734-431e-4eb4-b27c-44eefab3dcb0@amd.com>

On Tue, Aug 20, 2024 at 02:00:08PM +0530, Vasant Hegde wrote:

> > Some architectures, including VT-d non-scalable mode, doesn't support
> > ATS translation and translated requests when it is working in the
> > IDENTITY domain mode. 

ARM has a similar issue.

ATS enablement should be done when the domain is attached in those
cases.

Arguably you don't want to turn ATS on anyhow for pure IDENTITY with
no PASID because it is just pointless.

> In that case, probably PCI ATS still need to be
> > disabled when such domain is attached and re-enabled when the domain is
> > detached.
> 
> Does it make sense to move both PASID/PRI enablement to probe() path? something
> like below :

It makes sense.

I don't see any ordering restriction in the PCI specification.

Notice that PASID does have a specific called out restriction:

	/*
	 * Note that PASID must be enabled before, and disabled after ATS:
	 * PCI Express Base 4.0r1.0 - 10.5.1.3 ATS Control Register
	 *
	 *   Behavior is undefined if this bit is Set and the value of the PASID
	 *   Enable, Execute Requested Enable, or Privileged Mode Requested bits
	 *   are changed.
	 */

> [I am assuming ops->dev_enable_feat() interface is going away]

Is the plan
 
>   - Enable device side PASID/PRI during ops->probe_device()

Yes

>   - In device attach path (ops->attach_dev()), depending on IOMMU, device and
> domain capability configure the features like PASID, IOPF and ATS. That means
> ATS enablement is still done at attach device path.

From a PCI perspective only ATS can be changed at this point..

The SW construct of IOPF can be changed during domain attachment.

Everything that is PF-only must be setup during probe_device only
otherwise SRIOV VFs will be broken insome cases.

See
https://lore.kernel.org/all/0-v1-0fb4d2ab6770+7e706-ats_vf_jgg@nvidia.com/
for this concept applied to ATS.

This means probe_device() has to do:

 - ATS properties 
 - PRI
 - PASID properties

At a minimum.

It would be nice if the iommu core code did this setup in one place
immediately after calling probe_device() but before attaching a
domain.

There is no particularly good reason to have this coded in all the
iommu drivers.

Jason

