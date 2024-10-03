Return-Path: <linux-kernel+bounces-349076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D44198F07A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAC142837E1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7F819CC04;
	Thu,  3 Oct 2024 13:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aC5Bd2/d"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0918819B3F9
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 13:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727962408; cv=none; b=MMXBdY5w0zFKaGymlaGa0ZTG18pu6uc0ybXFVOd/yNE1CHxoAYLsRcMOu9DYnc51/WtZbgTP7pRu4SSboCpyCBlBN0PKtICtKYvMUQLsziSkctAcWW+rdjpYAz1IYZ2JF6i2RvFMNmpw0s07F7w64TXxw4nDT+DEsCHvgCM11H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727962408; c=relaxed/simple;
	bh=ru5EfHEC2xYx7sJrFNE6UgCz7R3Tdiv5uWDzLygWL3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPZBUSv/czPHK//IiKsnwJ0zg9VZggXHZZWZVI9I6HFfuRJxR2pL8RgVbb1VuwUrrlYEw7rUIXXnnoKPkhhAH61+dMFbayHFG1/LclN/MhfU3n+goWbFj4t+2Gpo4nKXE8TyQWPnOvwuEXX4+Zb/0jfwZUrJrreZyYlyTviEDsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=aC5Bd2/d; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6c5acb785f2so5661946d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 06:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1727962405; x=1728567205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8dQ/gk58hUlGStzLPNPz+tqcQ3+D0/hVEA8eHIyZCn0=;
        b=aC5Bd2/dhJf9fKs2BqfXGibi0Rb4Paggm5wxNHOi+8dgkaKZl3sYSoajE8lr7P57r5
         CZsVfdN+KptxetJ8VkdW4U6EhvcgPubogkttCVRdzmcDLFUnrmDZ3zgJhLslJOaZTxMT
         v437LvvpyTQTkG2QNdYV4ophc2M38YjG1kuufs1gHYh+Np/zRPG0rN1JCFu6bXBU52SH
         G9aaSliwRdB9v44X/TGeS1mR5Ok+3CRSKGk5tYJnaV3K0oqzBpo4+YdR2br98+J7+VUw
         SRwxiBmPdGZMWZmYAFrhRyCtiqQGE0IRLgQHKBPMTdNazzJ7r4ibjNBE/XV1xzfB4kjM
         4koQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727962405; x=1728567205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dQ/gk58hUlGStzLPNPz+tqcQ3+D0/hVEA8eHIyZCn0=;
        b=e5QcnA/mRwqsj7diEpYtZeXT/HO4u08g2b12M92fIfGdd7eZU/jUjiRAqZIeADuARB
         5vVxYyiLbegPZJN10gxNZaIulZvxHMCCDItVsYKxdEH6fKj65Dh+WXmR56ysKGWIalZ0
         UMnj/u/7AKtyZ0vbQhURu11SpfyQT+lE4wPl1NmwP59ZWGzGrwlcZsRlxBv6b6V8MQKu
         +pGV0RFqD8OGXGTUyOaOdWKgWJZGqgJn9NSbw6rBeV9mkJJavVLrWawLPVG55vNM/ykv
         OslT2VmzFPEb/UKodGLhRxfTDTXxX/88LKyRM2bXNmDGA1JA+sAkoYFjnskRioFeEpRz
         1RxQ==
X-Gm-Message-State: AOJu0YyX9Aq27iJJ/7BuuNeUecH/5Mt9w31gJRxwXxAr2jZ3riMkpZKO
	IBnFVJ08tcLJFcl4iCcFmJdOPNL9/5xw24a7GjPQ5lpqMR3wcjtOZobJYLkIyLY=
X-Google-Smtp-Source: AGHT+IHs6HB9tlbYAhVev9UHmvUhD6mUcL6pLiiMeMpBirOjKBi5OGNhsG7hwNB7h9ua6MEKwvVLvw==
X-Received: by 2002:a05:6214:450c:b0:6cb:3644:7ee1 with SMTP id 6a1803df08f44-6cb81a1066emr94967236d6.28.1727962404750;
        Thu, 03 Oct 2024 06:33:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb9359bad5sm6515846d6.5.2024.10.03.06.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 06:33:24 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1swLxL-00ASUf-OH;
	Thu, 03 Oct 2024 10:33:23 -0300
Date: Thu, 3 Oct 2024 10:33:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: James Gowans <jgowans@amazon.com>
Cc: linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Mike Rapoport <rppt@kernel.org>,
	"Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
	iommu@lists.linux.dev, Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Alexander Graf <graf@amazon.de>, anthony.yznaga@oracle.com,
	steven.sistare@oracle.com, nh-open-source@amazon.com,
	"Saenz Julienne, Nicolas" <nsaenz@amazon.es>
Subject: Re: [RFC PATCH 11/13] iommu: Add callback to restore persisted
 iommu_domain
Message-ID: <20241003133323.GB2456194@ziepe.ca>
References: <20240916113102.710522-1-jgowans@amazon.com>
 <20240916113102.710522-12-jgowans@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916113102.710522-12-jgowans@amazon.com>

On Mon, Sep 16, 2024 at 01:31:00PM +0200, James Gowans wrote:
> diff --git a/drivers/iommu/iommufd/serialise.c b/drivers/iommu/iommufd/serialise.c
> index 9519969bd201..baac7d6150cb 100644
> --- a/drivers/iommu/iommufd/serialise.c
> +++ b/drivers/iommu/iommufd/serialise.c
> @@ -139,7 +139,14 @@ static int rehydrate_iommufd(char *iommufd_name)
>  		    area->node.last = *iova_start + *iova_len - 1;
>  		    interval_tree_insert(&area->node, &ioas->iopt.area_itree);
>  	    }
> -	    /* TODO: restore link from ioas to hwpt. */
> +	    /*
> +	     * Here we should do something to associate struct iommufd_device with the
> +	     * ictx, then get the iommu_ops via dev_iommu_ops(), and call the new
> +	     * .domain_restore callback to get the struct iommu_domain.
> +	     * Something like:
> +	     * hwpt->domain = ops->domain_restore(dev, persistent_id);
> +	     * Hand wavy - the details allude me at the moment...
> +	     */
>  	}

The core code should request a iommu_domain handle for the
pre-existing translation very early on, it should not leave the device
in some weird NULL domain state. I have been trying hard to eliminate
that.

The special domain would need to remain attached and some protocol
would be needed to carefully convey that past vfio to iommufd,
including inhibiting attaching a blocked domain in VFIO
startup. Including blocking FLRs from VFIO and rejecting attaches to
other non-VFIO drivers.

This is a twisty complicated path, it needs some solid definition of
what the lifecycle of this special domain is, and some sensible exits
if userspace isn't expecting/co-operating with the hand over, or it
crashes while doing this..

> @@ -576,6 +578,9 @@ struct iommu_ops {
>  	struct iommu_domain *(*domain_alloc_sva)(struct device *dev,
>  						 struct mm_struct *mm);
>  
> +	struct iommu_domain *(*domain_restore)(struct device *dev,
> +			unsigned long persistent_id);
> +

Why do we need an ID? There is only one persistent domain per device,
right?

This may need PASID, at least Intel requires the hypervisor to handle
PASID domains, and they would need to persist as well.

Jason

