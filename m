Return-Path: <linux-kernel+bounces-175834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B91DE8C25EA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 15:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B6F3280F12
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902E612C481;
	Fri, 10 May 2024 13:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lsOhKKn5"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF69B127E05
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 13:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715348360; cv=none; b=OsVEydQSLTpVInZyGyeBzryJQwfku1+sn85NZzWrLGp/eTvyN5EuhteVxf3Ohs4wRRsHiPg1HBXJcycxGDVadqM5CTRukmwXsw5x3/gUFO8g4iElkAgrh7vZn5el9VJ2W9da0Ja5dshp9HHc2mGt3W2nTzW7AxKxUzEaysw8hDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715348360; c=relaxed/simple;
	bh=S3PWVcPLr1dX8LF8lbNqL9BTLtoY8MY8E4uSnFJY7DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQ1LKNth4ztpkGacqNdFPTJ+hg/AhXD/72Y/RB8n40pt+LDeqUxwDrz8meMvTVUOg2aLYpvQAU8PQDuxbs3wY/iQHUzs7t2Ypvt7AE4QP8UBzz1dUaPghu91mgRKHWwaz/zm1+re5ocwP3zlFQ3JTwBblp67jdYSWc6LZv8PsP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lsOhKKn5; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-43de92e234dso20696701cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 06:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715348358; x=1715953158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S+RTUECXr8LV6dsVCr+XO/1bNGoM61WJWMM3wIZuHWM=;
        b=lsOhKKn5dS0rwiGVdKbtJsA+mFJKW5LJkqQ+kHHbvbNrQWav6TQ0wxC9Sjx/bmCxk4
         lhkyXwAUAfG09AG2XaDJvjS6fImU7tGX4PT4ttGBt6IxbK1gF6iASnZBrFPePAmSaZO7
         vQtLDTuU/IYxT+Gcd77jcijpRWEb/zyxZ4blpsaJT3PU88zD4kAYHCDRKExRm7+6B4xP
         0/y8ocPINYMGn9i+O5aI6qIGNvxvNOYd8A68t33dWfawMzs5bM2C51i/rRHiD5CjB3i8
         tidhoq3tEsOtLBmnRvDXqhmcAceaxXKdJM1wP/JGSdbq8R9fdg2RlTf6fctro5yoeCMj
         3WzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715348358; x=1715953158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+RTUECXr8LV6dsVCr+XO/1bNGoM61WJWMM3wIZuHWM=;
        b=mFBXF+5hqY4Zf8O1/rR2CaL9vHVc1HnSxoiKWwiE5Mdg/MWMHj4lGQ8+U1P5BKivj/
         fTqRbqWPIpyw3hwDOlg+oti9GEtflNtm9rMpLT5VCGU3XfPGB8TIIzvrJFhQDeDlQtoQ
         HEjq+d2c9VtyQEjnQ8nfBmGbKRca/9t9SftpnTPbLq2qvQPgpTWnmvGDKYHLI84BFxYZ
         ms6rQIRlsLiMNHyEPQCOw+mdKeN8n3yJMJmg8Co5oxNcHpjLkAbFl7hxJaQYC8Gi411a
         UfF7OnphybZ1ckq8p1v+V+RliZjFRJ2KihYpG40WT2i5bXKIkQ026Rg+aTR8nHYrpIcE
         AsjA==
X-Forwarded-Encrypted: i=1; AJvYcCXz74JKD5+B6UILuCF0eMl5RMj2AJ7kf81I8SG4CDRduXGmNW/rWvlCQ1aMv/QdOWZPsBC46WrSlhJR7Oe7Ex/nWvbO1XvaPX0PuSFq
X-Gm-Message-State: AOJu0YxUrhwafRcPrzbpuEIMNiWlkkkmfLR+UCcRG8DWiMcyolIIxicC
	ZH9JJwa4vZafFQrAuzcIJ+07MzHcurNlEUi4SOObCFap8iJNcQj+95zUZd76LO0=
X-Google-Smtp-Source: AGHT+IH6Xw8gGuqZr95qyqNM0r9axJP/CbWZNxoYFGO4ShQvgevQy0mPDi2AqZ8yxbLD2P81pSHTKA==
X-Received: by 2002:a05:622a:1988:b0:439:baf4:619a with SMTP id d75a77b69052e-43dec29796emr107215871cf.22.1715348357837;
        Fri, 10 May 2024 06:39:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df569ba65sm21354511cf.70.2024.05.10.06.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 06:39:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s5QSy-006Cvp-GK;
	Fri, 10 May 2024 10:39:16 -0300
Date: Fri, 10 May 2024 10:39:16 -0300
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
Subject: Re: [PATCH v5 6/9] iommufd: Fault-capable hwpt attach/detach/replace
Message-ID: <20240510133916.GX4718@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-7-baolu.lu@linux.intel.com>
 <20240508001840.GO4718@ziepe.ca>
 <065cfc43-b164-4817-9be7-8f37585742ec@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <065cfc43-b164-4817-9be7-8f37585742ec@linux.intel.com>

On Fri, May 10, 2024 at 11:20:01AM +0800, Baolu Lu wrote:
> On 5/8/24 8:18 AM, Jason Gunthorpe wrote:
> > On Tue, Apr 30, 2024 at 10:57:07PM +0800, Lu Baolu wrote:
> > > diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
> > > index 13125c0feecb..6357229bf3b4 100644
> > > --- a/drivers/iommu/iommufd/fault.c
> > > +++ b/drivers/iommu/iommufd/fault.c
> > > @@ -15,6 +15,124 @@
> > >   #include "../iommu-priv.h"
> > >   #include "iommufd_private.h"
> > > +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
> > > +{
> > > +	int ret;
> > > +
> > > +	if (idev->iopf_enabled)
> > > +		return 0;
> > > +
> > > +	ret = iommu_dev_enable_feature(idev->dev, IOMMU_DEV_FEAT_IOPF);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	idev->iopf_enabled = true;
> > > +
> > > +	return 0;
> > > +}
> > I would greatly prefer we remove this from the drivers :\ I guess it
> > is Ok for now
> > 
> > Doesn't this need a counter? We can have many fault capable PASIDs?
> > That will get changed in the PASID series?
> 
> Okay, let's design this more gracefully after the PASID interfaces are
> landed. For now, we assume that the device driver will do this.

Well, for now to work the device drivers do still need these calls.

I'm trying to get them into NOPs in the drivers so we can remove this.

Jason

