Return-Path: <linux-kernel+bounces-288057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D57953284
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B53E1C2590A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9249E1B32C2;
	Thu, 15 Aug 2024 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DepSNArb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBF61B1506
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 14:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730696; cv=none; b=sRTJG+DPmfTmpbUhcuam1KkITxpRbnFKR3IKFaKI09LpcaFU18dLtsnPJ7bhr5ryxf5rxuVNQRpjvCUhiPZj7dTxN2CCbkP99KLTvNXhlOOEOdQdM11avcv4P18CzwS574xqjdnTMXDVVPnymOC78YPAiIZv6jPCHlBoCh8knj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730696; c=relaxed/simple;
	bh=9wBRif8u3KQqdmKtTCFDYwDvc05ue+hKUHHLMXPQ+sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qmt6kcfKawAEzItAQcwjSRkrU1q/7rz8oCvXsnC+zUDHxzoiaIrMgrYqTD/olU7Pf7lHv34wPFNWSfqRysY7+iUfwiey8mRTGng26ANCJANkaQGg2MVub2VFO68u7ak4DBpE9hHVanXCwpL3VSoP6/RX//FXseFaQf4tCvXVz7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DepSNArb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723730693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o1VeUmzh/uoFzMQziuwAE8gO4OkZoUZ7P6/8d0nwKLk=;
	b=DepSNArbfK6Vc9jH9jOsMnTn4gqF+mpDCsd/2nmn9lPUh3P/HpXq1fpAGImU9bApqyJTof
	dv4jGdteMtcwPBdKBml/nAXo/ZhWPpVOymAqTNn9TQeJTWg2AmQVhAL8kT1Pvl2iwHzNnc
	+mESzrHTlKHpU34x/WLJZwR5cu4Wneo=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-fj9JOPfyPZOYdn1B27lV_A-1; Thu, 15 Aug 2024 10:04:52 -0400
X-MC-Unique: fj9JOPfyPZOYdn1B27lV_A-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-201f27cdafcso4281835ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 07:04:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723730691; x=1724335491;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o1VeUmzh/uoFzMQziuwAE8gO4OkZoUZ7P6/8d0nwKLk=;
        b=tJ218moFu2nN7XyHc9gxmgpweV/ALkl9zIw8Ll55NdcXMR58sUzg+mVwd39PmqtWs/
         OY5weiyq6XZJstP5qq1bNWVLCLYdmQcTuwOcegyF9TDi5MbETOxQaJI/5YDGVey4IO5Z
         uIOSqR+NMnZQkEeTo57otboYSFuP/E51SfJ7tVsRDkZskkoD/o4EdImu6Ws/PNoaNYsP
         PblX3+ZJDZBez7Bq4XXmgUhppHUPp1vblm4Q7OTXfC9ZgkeGeSxZzudMM52fp9AWiZjT
         u160IwqTWkc0fDKBBe4VF9RzeES6au/vdwXt0xyipoYO3M71V9GtVgQHVPFRJIAct5Ui
         pNVA==
X-Forwarded-Encrypted: i=1; AJvYcCVz2+apxxXQTbP2l+IlaIhg1WdiDdnTjbXajyfDg0OYD57lj4254Eleji+FWLzKRz+PqhwnhS6clJBl1xrTMReXvm/nmC7tWPAws+R0
X-Gm-Message-State: AOJu0YzDyFIcZa8WU75eC4i9OJQd+9VRvuO82yYqyBD/2SncPMZJ4WyI
	VT/iK8NpkxvBAVzbeeheZz67K05p4whZnJbuS9MLgeS3H5kWvSK2nixYo0ug93u7XslohO/wfpx
	BOuUEbXQhOmTct1rix6pna2pNfqUzna+sbsxbxC1B1XysMBNHntQnrYkS8myq1Q==
X-Received: by 2002:a17:902:ce12:b0:202:cb:cd52 with SMTP id d9443c01a7336-20200cbce4emr5936915ad.21.1723730690011;
        Thu, 15 Aug 2024 07:04:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMstqlVCsHH3cnCvGEGSZLKl4bqQLKDZZAZv1C0f5Pe3ITA+LT6nVFeRM6bDtEZ78KV+LuOA==
X-Received: by 2002:a17:902:ce12:b0:202:cb:cd52 with SMTP id d9443c01a7336-20200cbce4emr5935965ad.21.1723730688871;
        Thu, 15 Aug 2024 07:04:48 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ccd6f3e3b9sm498687173.88.2024.08.15.07.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 07:04:48 -0700 (PDT)
Date: Thu, 15 Aug 2024 08:04:47 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian
 <kevin.tian@intel.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix incorrect domain ID in context
 flush helper
Message-ID: <20240815080447.5d7264df.alex.williamson@redhat.com>
In-Reply-To: <20240815124857.70038-1-baolu.lu@linux.intel.com>
References: <20240815124857.70038-1-baolu.lu@linux.intel.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Aug 2024 20:48:57 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> The helper intel_context_flush_present() is designed to flush all related
> caches when a context entry with the present bit set is modified. It
> currently retrieves the domain ID from the context entry and uses it to
> flush the IOTLB and context caches. This is incorrect when the context
> entry transitions from present to non-present, as the domain ID field is
> cleared before calling the helper.
> 
> Fix it by passing the domain ID programmed in the context entry before the
> change to intel_context_flush_present(). This ensures that the correct
> domain ID is used for cache invalidation.
> 
> Fixes: f90584f4beb8 ("iommu/vt-d: Add helper to flush caches for context change")
> Reported-by: Alex Williamson <alex.williamson@redhat.com>
> Closes: https://lore.kernel.org/linux-iommu/20240814162726.5efe1a6e.alex.williamson@redhat.com/
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.h | 2 +-
>  drivers/iommu/intel/iommu.c | 8 ++++++--
>  drivers/iommu/intel/pasid.c | 7 ++++---
>  3 files changed, 11 insertions(+), 6 deletions(-)

Works for me.  Thanks for the fix.

Tested-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>

> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index b67c14da1240..a969be2258b1 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -1154,7 +1154,7 @@ void cache_tag_flush_range_np(struct dmar_domain *domain, unsigned long start,
>  
>  void intel_context_flush_present(struct device_domain_info *info,
>  				 struct context_entry *context,
> -				 bool affect_domains);
> +				 u16 did, bool affect_domains);
>  
>  #ifdef CONFIG_INTEL_IOMMU_SVM
>  void intel_svm_check(struct intel_iommu *iommu);
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 9ff8b83c19a3..4aa070cf56e7 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1944,6 +1944,7 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
>  {
>  	struct intel_iommu *iommu = info->iommu;
>  	struct context_entry *context;
> +	u16 did;
>  
>  	spin_lock(&iommu->lock);
>  	context = iommu_context_addr(iommu, bus, devfn, 0);
> @@ -1952,10 +1953,11 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
>  		return;
>  	}
>  
> +	did = context_domain_id(context);
>  	context_clear_entry(context);
>  	__iommu_flush_cache(iommu, context, sizeof(*context));
>  	spin_unlock(&iommu->lock);
> -	intel_context_flush_present(info, context, true);
> +	intel_context_flush_present(info, context, did, true);
>  }
>  
>  static int domain_setup_first_level(struct intel_iommu *iommu,
> @@ -4249,6 +4251,7 @@ static int context_flip_pri(struct device_domain_info *info, bool enable)
>  	struct intel_iommu *iommu = info->iommu;
>  	u8 bus = info->bus, devfn = info->devfn;
>  	struct context_entry *context;
> +	u16 did;
>  
>  	spin_lock(&iommu->lock);
>  	if (context_copied(iommu, bus, devfn)) {
> @@ -4261,6 +4264,7 @@ static int context_flip_pri(struct device_domain_info *info, bool enable)
>  		spin_unlock(&iommu->lock);
>  		return -ENODEV;
>  	}
> +	did = context_domain_id(context);
>  
>  	if (enable)
>  		context_set_sm_pre(context);
> @@ -4269,7 +4273,7 @@ static int context_flip_pri(struct device_domain_info *info, bool enable)
>  
>  	if (!ecap_coherent(iommu->ecap))
>  		clflush_cache_range(context, sizeof(*context));
> -	intel_context_flush_present(info, context, true);
> +	intel_context_flush_present(info, context, did, true);
>  	spin_unlock(&iommu->lock);
>  
>  	return 0;
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 5792c817cefa..b51fc268dc84 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -683,6 +683,7 @@ static void device_pasid_table_teardown(struct device *dev, u8 bus, u8 devfn)
>  	struct device_domain_info *info = dev_iommu_priv_get(dev);
>  	struct intel_iommu *iommu = info->iommu;
>  	struct context_entry *context;
> +	u16 did;
>  
>  	spin_lock(&iommu->lock);
>  	context = iommu_context_addr(iommu, bus, devfn, false);
> @@ -691,10 +692,11 @@ static void device_pasid_table_teardown(struct device *dev, u8 bus, u8 devfn)
>  		return;
>  	}
>  
> +	did = context_domain_id(context);
>  	context_clear_entry(context);
>  	__iommu_flush_cache(iommu, context, sizeof(*context));
>  	spin_unlock(&iommu->lock);
> -	intel_context_flush_present(info, context, false);
> +	intel_context_flush_present(info, context, did, false);
>  }
>  
>  static int pci_pasid_table_teardown(struct pci_dev *pdev, u16 alias, void *data)
> @@ -885,10 +887,9 @@ static void __context_flush_dev_iotlb(struct device_domain_info *info)
>   */
>  void intel_context_flush_present(struct device_domain_info *info,
>  				 struct context_entry *context,
> -				 bool flush_domains)
> +				 u16 did, bool flush_domains)
>  {
>  	struct intel_iommu *iommu = info->iommu;
> -	u16 did = context_domain_id(context);
>  	struct pasid_entry *pte;
>  	int i;
>  


