Return-Path: <linux-kernel+bounces-249987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DAA92F2A9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 01:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80B51282DC1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 23:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C933215ADAF;
	Thu, 11 Jul 2024 23:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gxFeEsnp"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEBE13D8A7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 23:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720741055; cv=none; b=TYK/iZ3xSy8uu2dosRZYism+qn4NjjqsdEQTVQfMvM059G0PTo7uerKVhdRYZDf2b0+YoxKfNpT5A0lkXSUwGFMf2GxUJOYbxjZa8Bg0v0Z7XfWYz1kUyWxFzops/SNMyvhYihjQ6AZsfLPVGxvbg7/cd+epb3UHgnrmOqTU48s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720741055; c=relaxed/simple;
	bh=2nqbbEAsVwbmaZoW7HNnsobSTISWs4X9BhTkCvVZ4rI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMb0LDotEu6+V/ZeBLxzNKh537xg6HHc84P2ize0okDwnmi0mx95mHm3bopfNYBHRgqs5AQCZDENcMCr+f0jBJmL51edW2PHbXdLQN1Asho6Ce2UlxPgkYXvQpu76sn5r3TXwA5dBua3jh2XC8KKW7X4vwMSov2K2CwI3HcXO48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gxFeEsnp; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e03a6c1741eso1492988276.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 16:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720741052; x=1721345852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X+KdXhfnlGfYruNnuxczBUgWH1eqq9zVhnZGK1VHbw0=;
        b=gxFeEsnpdEfpCdyKvD4iIO2o5pIA5Tr08Eb2ZJrPelQk8Qw1EvLw2HrKIO4hVwSk0L
         oBIWpKiBA+llmFcvaStLz8Xeg2agz8D/x0fi2pLGWkBwvSFP6szO+4i9t0nZTp6CDA+e
         ZOECcT9avr09yRucYDC7Jt6+/s6kVb4wvRQo/T1HEO0dg4jbE5fHI0M1vTZxCoPUzhYj
         0pc9Gl4PCPI/dRdPe/rDxRI+i8B7Bmyh33SmtShAeyszAV6duv4yVuzfYptJ2EUpBmOx
         4y03JHjrxC/PAsmBRmwl5CluwD+MlsIbUTsalA44Ax02i9bQmO8ccOs0IAaLPK8FfvuK
         2XcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720741052; x=1721345852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+KdXhfnlGfYruNnuxczBUgWH1eqq9zVhnZGK1VHbw0=;
        b=bKeeNHyvimCRF59rzUn5PhAAaFhQeiW7REUd5Pfs6wiz+FyJvUxLRAvHETEUDTagG6
         dNQfngbxhMcwn3xfb09IRKQVTqL0rdBXvsDUbpFWxK2k8+vL8kl07SEs8jabSQOXRX4o
         nCQKENgqtoPFgnuTYZZTdbdf7/jvyV4pL7NJC5znk/peF2rc9MRljyOjk+XXkC/k1diM
         uZVvyppqK9BBOd86NjflTz42o/0zMUxr7EzWkBjngrTzPiRBPHcyXYIJAmyr4lRrfp/u
         WBvYHGooSldQLMg0uJeLU2xDI69DBg/Z2WZ4lv5VNTf4SGPKFusVH3kqKpcr88AGfMwf
         JkhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSYj16h0fTvGMwB8DS3OHKkV8PcxP1Olyc5IpRILv/R63JvkTOBEaHktV4DFfOWs8G8xeiiG229f230I4ZdHZoi5n3bxZytrHz3jzL
X-Gm-Message-State: AOJu0YxbvkyMx4iLhRq7Clm09svZwy4A1RlY/JpLYzqx0x5FHJo+fqLb
	mpIxZ7F1NgjV2So86qIzXTuhETP5NHdzfICuMjoOKg1KJZl0X9sBvpdJFL5Fv5g=
X-Google-Smtp-Source: AGHT+IE2w1iEvTJQgL110JqQwHO+CGC/PXq7/sUcslpRneSFJpeAVANOPh84CWfAbXtIrXm5qsA1pg==
X-Received: by 2002:a25:9902:0:b0:e03:a248:7dd3 with SMTP id 3f1490d57ef6-e041b061cb3mr11759264276.23.1720741052384;
        Thu, 11 Jul 2024 16:37:32 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61b9d606csm30110476d6.36.2024.07.11.16.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 16:37:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sS3Lu-00FSPx-5b;
	Thu, 11 Jul 2024 20:37:30 -0300
Date: Thu, 11 Jul 2024 20:37:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] iommu: Convert response code from failure to invalid
Message-ID: <20240711233730.GT14050@ziepe.ca>
References: <20240710083341.44617-1-baolu.lu@linux.intel.com>
 <20240710083341.44617-4-baolu.lu@linux.intel.com>
 <BN9PR11MB5276EC68D1BBB52C9E6DDE558CA42@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276EC68D1BBB52C9E6DDE558CA42@BN9PR11MB5276.namprd11.prod.outlook.com>

On Wed, Jul 10, 2024 at 09:56:34AM +0000, Tian, Kevin wrote:
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> > Sent: Wednesday, July 10, 2024 4:34 PM
> > 
> > In the iopf deliver path, iommu_report_device_fault() currently responds
> > a code of "Response Failure" to the hardware if it can't find a suitable
> > iopf-capable domain where the page faults should be handled. The Response
> > Failure is defined in PCI spec (section 10.4.2.1) as a catastrophic error,
> > and the device will disable PRI for the function.
> > 
> > Failing to dispatch a set of fault messages is not a catastrophic error
> > and the iommu core has no code to recover the PRI once it is disabled.
> > 
> > Replace it with a response code of "Invalid Response".
> > 
> > Fixes: b554e396e51c ("iommu: Make iopf_group_response() return void")
> > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > ---
> >  drivers/iommu/io-pgfault.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
> > index cd679c13752e..b8270ee5dcdb 100644
> > --- a/drivers/iommu/io-pgfault.c
> > +++ b/drivers/iommu/io-pgfault.c
> > @@ -229,7 +229,7 @@ void iommu_report_device_fault(struct device *dev,
> > struct iopf_fault *evt)
> >  err_abort:
> >  	dev_warn_ratelimited(dev, "iopf with pasid %d aborted\n",
> >  			     fault->prm.pasid);
> > -	iopf_group_response(group, IOMMU_PAGE_RESP_FAILURE);
> > +	iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
> >  	if (group == &abort_group)
> >  		__iopf_free_group(group);
> >  	else
> 
> this doesn't match the spec words on the use of INVALID:
> 
>   One or more pages within the associated PRG do not exist or
>   requests access privilege(s) that cannot be granted. Unless the
>   page mapping associated with the Function is altered, re-issuance
>   of the associated request will never result in success.
> 
> this situation is not related to the permission of page mapping. Instead
> it's a global problem applying to all functions submitting page requests
> at this moment.
> 
> Though using FAILURE affects more functions sharing the PRI interface,
> it also proactively avoids adding more in-fly requests to worsen the
> low memory situation.
> 
> So none of the options looks perfect to me, but the existing code
> responding FAILURE is more aligned to the spec?

Yeah, I don't know what to do here either, I guess the system is going
to explode if you OOM during this stage.

If it is some problem we'd probably have to preallocate this memory in
a pool and rate limite the number of PRIs we allow open at once, using
INVALID to create some back pressure. Seems wild.

Lets keep it as FAILURE for now, or at least it can be rediscussed
another time.

Jason

