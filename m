Return-Path: <linux-kernel+bounces-300415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E49E95E364
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 14:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DA88B21033
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 12:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BA613D28F;
	Sun, 25 Aug 2024 12:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BmziLd9P"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643622562E
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 12:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724589864; cv=none; b=ISVt3jS+sUsZOlpOAPoZ4gA3u4vcmEwbHcg3Sd5eXZAkFwEyE8jJvcmctE3s9hZsvdJK4eOud9a6z5XmVXjD+byaBxpGgJ5fVq9SuTOXg6AUwULKt3rZCw+S9WSPGsGrs+RHY0GQO4ByAS0yShau1gXA8zOA/s661Gm1WKsle9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724589864; c=relaxed/simple;
	bh=uVkJltKZxmKNs6q6Q2xLPTYiGhFZGjSC7P15yDt6R6s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HK75/LAnkvxt+fQcEEwwyrDLSLRJ2y/UVxoKwY35WSrV9ow1E9009CiQZUSf+S4W+HS8Lzc+E/LSg4yAD9oQl/bh5y9HWCdLu/T/WZO/yOA3/CUauAYUhWQ1PNXO09cLOxNVyutH7U7eJiCzgMFInjdXANZqXWJCTDQG+3FSZWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BmziLd9P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724589861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8PuNziSdR0v3r5Vc3Av8TEj4X/kzJ5m0pHfr1sPG2AE=;
	b=BmziLd9PGnhyCZwEVSYMUrQlevL4+OvSP2ZATBYd6OlwC+F7pgb36M+FQs0i2tlJrJY3Hb
	JH+mbnE5t3S771MC86UMl+/lWYV4ndm7ioPU/AC+/xwjVRPeevgFg3crVkTIOzqXeBeeW3
	X14uCU/fsyS6nXlSTTN2UHM1tfsLeDA=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-CcVPp3M2Md2vhabEjXjVEw-1; Sun, 25 Aug 2024 08:44:19 -0400
X-MC-Unique: CcVPp3M2Md2vhabEjXjVEw-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d5537a63dso2063345ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 05:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724589859; x=1725194659;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8PuNziSdR0v3r5Vc3Av8TEj4X/kzJ5m0pHfr1sPG2AE=;
        b=TWrms4G4PW146UOVyYi0Sbs7JjvJIlESr43W4Q2eP2jIVpeGho+mlCYGUyaXiAhrqE
         qroNmw+15L3wG5If79dWH4SppByeiE2kUpoYemgpvYo/2t8OE+zNwzaPnMl79Xlp1MtI
         fFb0wzv6ulNdzWM/uEe+wTKuxvcBDN1xrQfs6uzqVFFZNTlH2L3V9jfVH78yIKgSth5v
         8aw0Alg7Ebdi2E5cj2iWqvrOv7aLEX0idtD1+HOcj64stVkiXJOwQJnNHI54MvXxGm4X
         761vkVYpkzsp1AOtuwmzbGkV3hE8z94tjUA3F6yqpFduWpC7heDzLKMuTsFuabw242O6
         AiJw==
X-Forwarded-Encrypted: i=1; AJvYcCVldhtdCgKvTodTO9+VmmE4GmgcXzOpNoaMZ8PGZcfy9vDyrUVEnactRtKLV7msyIZrP6wzP7+Mb2xdNbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEuK2rq3gysYZyEBVhObApCr+alkSLqN0FgrnBCbGG+bpZdGRs
	K2gd9rgrFoMRwPZNvYOiR7SDEYvKAwglO2UILanL3x+ZvA9xPfC0hkbp9Q6B3GBPYnI4k/8lDzV
	Znvyif8Kq3WTpVVu8uQZ8xjdntefLDQWiEGKQfdsTbZr8Leqbh6d4rRId4QH5Rg==
X-Received: by 2002:a5d:85c5:0:b0:81f:9219:4494 with SMTP id ca18e2360f4ac-82787361826mr398299639f.2.1724589858709;
        Sun, 25 Aug 2024 05:44:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvr6I9mValGQrwjMIaBMFFPdi3LJyna7wdAMSYnJjiSQHE+GL4ooF6CouDntWF9XIilcoHWQ==
X-Received: by 2002:a5d:85c5:0:b0:81f:9219:4494 with SMTP id ca18e2360f4ac-82787361826mr398298639f.2.1724589858132;
        Sun, 25 Aug 2024 05:44:18 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8253d5a9bf1sm226845339f.3.2024.08.25.05.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 05:44:17 -0700 (PDT)
Date: Sun, 25 Aug 2024 06:44:16 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian
 <kevin.tian@intel.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix incorrect domain ID in context
 flush helper
Message-ID: <20240825064416.256db557.alex.williamson@redhat.com>
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

Hi,

Can we please get this merged for v6.11?  This is a significant
regression in VT-d, effectively breaking all vfio use cases and since
we're effectively no longer flushing the VT-d cache for these use
cases, I imagine there's a security issue as well.  Thanks,

Alex

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
> 
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


