Return-Path: <linux-kernel+bounces-174743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346978C1439
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 19:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6645C1C215A9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 17:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98606CDD3;
	Thu,  9 May 2024 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TF90ldq6"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E206BB4C
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 17:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715276529; cv=none; b=N0GtmTlEkQt2MzK3JYMjkH5fp7YrvVQ3XRpCYZbZOhIaG94gFkti5aqsvG3D8n8zcE0WTY2lFk6VM2bQibvlU4SeAewtixnpN4fWXDqlkDyJHhx3oghxXlr12Alm+TPhyrtFeDYSucQQjRK881y78g1thb0hlVLltlvJCnRhubg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715276529; c=relaxed/simple;
	bh=mpzn0QWWFQVXXy2IjU2A/koKU3rAgwSbX8RpcKOfcyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsNFypHd6s4KGxgco7kJ67Sg0hSbBHZY8yxmYNNFOPFFvivznjbX7LKjDxx4dIzrAEBOzzAvASsXP85+JfhX5MR8gdMfHLQ8ftb6VtoJdMRsTyzaivgM3H+cvJ0p3urU2uGNZNzQKObLTAXzX9CYG9uoZ/m2oJbat1VNdI5N4Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TF90ldq6; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-61b62005f38so10933167b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 10:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715276526; x=1715881326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WevGPTgw8EqB15lVD4jdzyFg2kXB80qSvqfKiUoMKg4=;
        b=TF90ldq6PrI99YY8pQ7QNNht8SPdHw7tdEfY/xAlRKrOWVQdIfTMRARLWUeB6fMXZc
         TmZ3KEt0/ytKGROJ4/vH0d+XHP/u40Pqlh/vB+O0IpEZxEL5zrJ0MYAxhBPy1eL4cJrl
         RFGDwsrSYXp+vDZtit+vfqJLbAFg9yceo2T8W6WH1ZrvG5Q+pTAmF2e9rjWoHacg6RK6
         9dmN8ISfnzJXAnyhKbSuYeowLEcxXSVmJDG0lARE970egDjRCEOcQpSSSbZFik0Ti6AE
         HELdOCZsRVW2gF5A1sjnm5V5u5sqZ208sn+wzkh0uZgbNky9M5LGQns4uPSFwgeoC4gR
         orAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715276526; x=1715881326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WevGPTgw8EqB15lVD4jdzyFg2kXB80qSvqfKiUoMKg4=;
        b=VvMN/JoWx2313R69QrdDmPrL2kgK/lrtycJZSA5ghD0tBYCdJ4EDLpKQiqCxxDZk1U
         pqshH382uopCFIB3+CeQ5unFMw1945BD5pithJSSPB/1R+HprSTh5hey+1mqaJeao1zb
         /VRtngVUoK8lhCD/QBnA5GbshgwGwfxYi9ROwHsFKEnoWKoltMyb/8AMI8O1jr229VV2
         q3p9p425KTAcVegCIElNs8/HcT4EbvN0EHfkmDg301YhGVpwramWMbKCClBvVJg+x7dM
         OcSCwd0SBX7OA1pssmJY2pxIpNafEia3vfH2F6qToaozJY7PqN6P/7HM0D+xALtp2mPV
         issg==
X-Forwarded-Encrypted: i=1; AJvYcCXM4WVWB0snLhHRfG4l82B1I+GJjgM/mykzbAGJqmJTRozem+ysDYIro/4iHQkDqRG5M5jRHueUr4pfaFQCs7zdskqSTWqLFlDaKWtn
X-Gm-Message-State: AOJu0YxJn9+G9YEsDzdj+CqOWMGRKfO0n+537Zq2dpvfFOWT32JYYWlP
	dlafkzTRrprJpJcubiMB6Ei9gJzjxsthg/aqhTc3WAlG/zyd/3YhSI2HBpqHJ44=
X-Google-Smtp-Source: AGHT+IFkh/Fvhe1lLQ7P5zisOKMjZcvUkoEW5Lpnj/Em/Y5QOPx8/vuJSiaVYLs/fOF7CMdN+zyviQ==
X-Received: by 2002:a05:690c:6c03:b0:61a:b573:65f4 with SMTP id 00721157ae682-622affc5609mr2466837b3.6.1715276526417;
        Thu, 09 May 2024 10:42:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df569847bsm10554411cf.59.2024.05.09.10.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 10:42:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s57mO-004n27-IQ;
	Thu, 09 May 2024 14:42:04 -0300
Date: Thu, 9 May 2024 14:42:04 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Martin Oliveira <Martin.Oliveira@eideticom.com>,
	Christoph Hellwig <hch@lst.de>,
	Dan Williams <dan.j.williams@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: P2PDMA in Userspace RDMA
Message-ID: <20240509174204.GV4718@ziepe.ca>
References: <fa2d39cf-b0df-4674-979d-b775d5077bce@deltatee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa2d39cf-b0df-4674-979d-b775d5077bce@deltatee.com>

On Thu, May 09, 2024 at 11:31:33AM -0600, Logan Gunthorpe wrote:
> Hi Jason,
> 
> We've become interested again in enabling P2PDMA transactions with
> userspace RDMA and the NVMe CMBs we are already exporting to userspace
> from our previous work.
> 
> Enabling FOLL_PCI_P2PDMA in ib_umem_get is almost a trivial change, but
> there are two issues holding us back.
> 
> The biggest issue is that we disallowed FOLL_LONGTERM with
> FOLL_PCI_P2PDMA out of concern that P2PDMA had the same problem as
> fs-dax.

Yeah, it was not a great outcome of that issue.

> See [1] to review the discussion from 2 years ago. However, in
> trying to understand the problem again, I'm not sure that concern was
> valid. In P2PDMA, unmap_mapping_range() is strictly only called on
> driver unbind when everything is getting torn down[2]. The next thing
> that happens immediately after the unmap is the tear down of the pgmap
> which drops the elevated reference on the pages and waits for all page's
> reference counts to go back to zero. This will effectively wait until
> all longterm pins involving the memory have been released. This can
> cause a hang on unbind but, in your words, its "annoying not critical".

Yes

But you are looking at the code as it is right now, and stuff has been
quitely fixed with the pgmap refcount area since. I think it is
probably good now. IIRC it was pushed over the finish line when the
ZONE_DEVICE/PRIVATE pages were converted to have normal reference
counting.

If p2p is following the new ZONE_DEVICE scheme then it should be fine.

It would be good to read over Alistair's latest series fixing up fsdax
refcounts to see if anything pops out as problematic specifically with
the P2P case.

Otherwise a careful check through is probably all that is needed.

> The other issue we hit when enabling this feature is the check for
> vma_needs_dirty_tracking() in writable_file_mapping_allowed() during the
> gup flow. This hits because the p2pdma code is using the common
> sysfs/kernfs infrastructure to create the VMA which installs a
> page_mkwrite operator()[4] to change the file update time on write. 

Ah.

> I don't think this feature really makes any sense for the P2PDMA
> sysfs file which is really operating as an allocator in userspace --
> the time on the file does not really need to reflect the last write
> of some process that wrote to memory allocated using it. 

Right, you shouldn't have mkwrite for these pages.

Jason

