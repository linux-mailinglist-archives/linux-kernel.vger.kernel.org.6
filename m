Return-Path: <linux-kernel+bounces-221319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 233A190F1D9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 17:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9768528284B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 15:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AA413E043;
	Wed, 19 Jun 2024 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aP9V8V93"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEFA13D525
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 15:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718809982; cv=none; b=Lobr0+ceAxojOBHBGuDibTTu653U4SCDFVMeVl+Bbauvtz0uDaDgy4h2mDxfPQ4O7aiGCVNKFfJy8OhYV3Ar2G0IdNu743u0Lo0DNz2rhyySZB48U7DUCNoH1rNMCrjl/o8CVJgjm9wq9H8PBRXq6Rcmriot8+IiW0XwlMVDrzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718809982; c=relaxed/simple;
	bh=Mxc4rK4TJIkZCGE+xd1WM7yRd9sAbJnrRNYLqrY8cFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWerlI7DTbtQqQ3lDAN20979w/Dwn0mWQaZc9IOWx7ats7mhY8BgOnEaUeTfxAu6FV6EwdN/TeuoIo5Odr07MgNETtUQgGo7x/99o3vX90rfvmrSdYv5PnRiqWv6XIVjziWfIM6ECawyb24MEL/0NhxcN40jpd0g/uFwSz37lzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=aP9V8V93; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5b97a9a9b4bso3213457eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718809978; x=1719414778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QlJ0YGq/uQqUf811AzhVaKREy5VQopM9S0iNxCm0jic=;
        b=aP9V8V93Oa2xSFZYh3UyV99w3I1U4G1BoZcOucVOShcBSX4OEZVxoXoFAI+/cWr3ym
         D2K1qyyg2efy5MLMW/hNZJvw5Q2w1+Fr9FBcTgmnYJZsPRfPIUE9mcQmDsb4+uMXh/WM
         738GxHT9tVAq8ePHzOHIV1VZf9GzaEuctekEN6bwzMQft6Otf3Mh8q34DLxxgDmotbw/
         DZE/cfobGF8bAL04/sAnIzkc3wNtRBV7/T5FVQU1sqGAU1cxnuaABykw+/ZSDOaV0o6P
         nzz/baqJ5cZQpxxzFFgtfArBszSathxvUwjBudiJmq10ANhUIqatFP3Xjx5unXt8njXn
         KpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718809978; x=1719414778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QlJ0YGq/uQqUf811AzhVaKREy5VQopM9S0iNxCm0jic=;
        b=H/wuS0Fh99/+mPsP14Fq3vNoClIyeBBIMqoyE3+pg3CUdHR4mguJiQ/ctvdXHxF4G/
         xrx0lVA7SAhzh59U/B2f8Y8hhyPkLhvttv4hZ3iOYbeDB4JEJ8gxVj7MQm2wHiw8FG6B
         A7ogXO66qpR6z6rZZGAcrMBAn3ETXFNbqNSVIazBFFSkfLsiX9a5XuqTxwfxANX0E7kB
         p87Kx1fS4tiLgKtGj6dlPRWAMPpJYFOxlbJxW8+RCLXA3ZQgkrO9S8rrTGCGdlu4GAeU
         CXAaYvY85PPJJ3WIvMfOsHvM3Q8VmKXeKombOGR5x430jRvGPzy69AWly/n5WOiYuOS8
         UWBw==
X-Forwarded-Encrypted: i=1; AJvYcCVlEky566AoRAOZLcEmesRRiBOA0Z8TUjrsytiMcWTwTSBDJpUhUXckXlgHiCgMpZAiW+mhhwKTUbNq8V91BYl0apjTrR/YZHFL13lq
X-Gm-Message-State: AOJu0YwHXjFQU/9qaWWuJnMncSjucSli9eqwuvnC4B+HvqsE6UoOaAH2
	Sp3HIa9LVCZM3r3PTArXAongARolUPdCTlWRezbov6k1faMM+gpBSPDEUNX+iPk=
X-Google-Smtp-Source: AGHT+IFeMMh1MCvYS1yX1hUJEbWMiIeodyR3LLOeXWWow0gzjafVlyBklU57KB2trj16/I1ogvctnA==
X-Received: by 2002:a05:6358:9886:b0:19f:4c1b:f0fe with SMTP id e5c5f4694b2df-1a1fd45a708mr299401955d.18.1718809976550;
        Wed, 19 Jun 2024 08:12:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abc0719fsm613804685a.83.2024.06.19.08.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 08:12:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJwzW-004nFq-WF;
	Wed, 19 Jun 2024 12:12:55 -0300
Date: Wed, 19 Jun 2024 12:12:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alex Williamson <alex.williamson@redhat.com>, mst@redhat.com,
	Jason Wang <jasowang@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath10k@lists.infradead.org, ath11k@lists.infradead.org,
	iommu@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 15/21] iommu/vt-d: Add helper to allocate paging domain
Message-ID: <20240619151254.GI1091770@ziepe.ca>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
 <20240610085555.88197-16-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610085555.88197-16-baolu.lu@linux.intel.com>

On Mon, Jun 10, 2024 at 04:55:49PM +0800, Lu Baolu wrote:
> The domain_alloc_user operation is currently implemented by allocating a
> paging domain using iommu_domain_alloc(). This is because it needs to fully
> initialize the domain before return. Add a helper to do this to avoid using
> iommu_domain_alloc().
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 87 +++++++++++++++++++++++++++++++++----
>  1 file changed, 78 insertions(+), 9 deletions(-)

It seems Ok, but I have some small thoughts

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 2e9811bf2a4e..ccde5f5972e4 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -3633,6 +3633,79 @@ static struct iommu_domain blocking_domain = {
>  	}
>  };
>  
> +static int iommu_superpage_capability(struct intel_iommu *iommu, bool first_stage)
> +{
> +	if (!intel_iommu_superpage)
> +		return 0;
> +
> +	if (first_stage)
> +		return cap_fl1gp_support(iommu->cap) ? 2 : 1;
> +
> +	return fls(cap_super_page_val(iommu->cap));
> +}
> +
> +static struct dmar_domain *paging_domain_alloc(struct device *dev, bool first_stage)
> +{
> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> +	struct intel_iommu *iommu = info->iommu;
> +	struct dmar_domain *domain;
> +	int addr_width;
> +
> +	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
> +	if (!domain)
> +		return ERR_PTR(-ENOMEM);
> +
> +	INIT_LIST_HEAD(&domain->devices);
> +	INIT_LIST_HEAD(&domain->dev_pasids);
> +	INIT_LIST_HEAD(&domain->cache_tags);
> +	spin_lock_init(&domain->lock);
> +	spin_lock_init(&domain->cache_lock);
> +	xa_init(&domain->iommu_array);

You should probably split more, with an 'alloc struct dmar_domain'
function that can be used by SVA and others too.

> +	domain->nid = dev_to_node(dev);
> +	domain->has_iotlb_device = info->ats_enabled;
> +	domain->use_first_level = first_stage;
> +
> +	/* calculate the address width */
> +	addr_width = agaw_to_width(iommu->agaw);
> +	if (addr_width > cap_mgaw(iommu->cap))
> +		addr_width = cap_mgaw(iommu->cap);
> +	domain->gaw = addr_width;
> +	domain->agaw = iommu->agaw;
> +	domain->max_addr = __DOMAIN_MAX_ADDR(addr_width);
> +
> +	/* iommu memory access coherency */
> +	domain->iommu_coherency = iommu_paging_structure_coherency(iommu);
> +
> +	/* pagesize bitmap */
> +	domain->domain.pgsize_bitmap = SZ_4K;
> +	domain->iommu_superpage = iommu_superpage_capability(iommu, first_stage);
> +	domain->domain.pgsize_bitmap |= domain_super_pgsize_bitmap(domain);

Then some of this stuff is really just paging only. Like
SVA/identity/etc don't have pgszie and other things.

Jason

