Return-Path: <linux-kernel+bounces-287936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A729952E5A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E72D1C216CE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF33199248;
	Thu, 15 Aug 2024 12:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HcN6IQ3+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D43199234
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 12:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723725278; cv=none; b=I1IBrFr0bdxv6y5g2V3iSHDjy+T8DFAA5v2e+rKnP4b6K7X12+YH69ZSCTxuTwJNabvPBjGjC4YsSk6tbPFy9t5Rqko/Eh/tADiMZ45fj4NTml90Nxpp1HJ4owJwCfy8An7LUHrYvqqqWDbMXXF7k9+uPmS6M26dHRB5MIrFLfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723725278; c=relaxed/simple;
	bh=LNzYxv0wLMZeausbdHI3AeTl1UXTVZvJw90aFrQfGOs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mSDuDWpV+LVbIwWHFRPeAgTle/vL3XlgOQdXd6282YOgIm9IhW18flHftH6tYZdVRPlmRfLggfF1E8wHbpUNZdrBZxSn3W5HdcN3djpm9iDMi/tHaPmKciaNZ4d829V2nGJS3ERlyGkE2on1HdljCNzfAoHYYnchXl37rp5Uu+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HcN6IQ3+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723725275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iQURm0VtOkt6tr0AHUSutMukkCnX4LoAIbMGGNruLHw=;
	b=HcN6IQ3+U4iAoJyZJTS6FO14JUEm7Oa0ZLQT9oF9GzGCy7JqnxczDA+0z/noUmBczMlnH/
	W5vZwyQgsNTxXNJbluIJg22dmFW3zO9rzR1yQZMvnsjgW2jRpcNW+cbavSmxCP3Xyjkbgu
	kkNJIoVZEYNBACm61LgaBHnaZ6exoss=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-Msd6ARscOFmbYqvGBOFFJQ-1; Thu, 15 Aug 2024 08:34:34 -0400
X-MC-Unique: Msd6ARscOFmbYqvGBOFFJQ-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-824cad19812so89695539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 05:34:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723725274; x=1724330074;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iQURm0VtOkt6tr0AHUSutMukkCnX4LoAIbMGGNruLHw=;
        b=h7YgviOfniEjndnIHUO63+FUR4G8gp1xby4xE4WM3bwlKLWJ+TAEy2n3gRNK8+Q9Rb
         yL2Tx9YHE9ySzkjyy0LusWncgTKMewVfcTsjH6zL4lBR70B1dmLhIIa/tL2mZtTjTvY8
         hsOXYLeeZimk0CQ3l4pkC02/U1lI1TLEvYEMi5XXLUhwhLvcsDzO7huZQvucVhp7zz/w
         4R0o07JYLKQZ05OgsIAmddLpl8nEiXbTvWK7s8ex7s8Xj1MDJTZBYJktDADtXkgAZ2dC
         dHROsGyYlCaDIPq9m5g0PESDHW9BPBTAV8Jb31CdYNHj4+tu8WqXlCZQRXo+zES9irpr
         ld6w==
X-Forwarded-Encrypted: i=1; AJvYcCVqzh5U4xl0UQmd6ym7ZSniaSKbyRXUrVsTNQC7l4JWSHi8zPCIQiOpySSlSbwIRpzo9yegCRogR9/Mj3l+Ra7BYtdHCI5IABAyErZO
X-Gm-Message-State: AOJu0YyiYSygtQiorYRG3JUO/hLObDTyYu3rj1+1mqNvEXmCw5lwj9PG
	rEhgqKFN1uPlMvin6O4h//gKlIyZ7lOlWliKxQi7NVUC/D+7aOQzf5YdEX+9/Xe/K/zBDk9xC9D
	4UCR/0qJWtV9fPHV8rR0GR4CFmMQolCQ4Y7ZyYKMgIp8qAD6lLrz+12sNVOKIkg==
X-Received: by 2002:a05:6602:341d:b0:7fb:86c:321 with SMTP id ca18e2360f4ac-824dacda406mr656346839f.1.1723725273873;
        Thu, 15 Aug 2024 05:34:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7xdWX0SQil5/xQT2XqCBEZ74QgWSK4v+8FgpuFPpVMSnxNIOsaPiaZEe4CkoAKD7E9J6PkA==
X-Received: by 2002:a05:6602:341d:b0:7fb:86c:321 with SMTP id ca18e2360f4ac-824dacda406mr656344439f.1.1723725273476;
        Thu, 15 Aug 2024 05:34:33 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ccd6e7cea0sm455937173.8.2024.08.15.05.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 05:34:33 -0700 (PDT)
Date: Thu, 15 Aug 2024 06:34:30 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jacob Pan
 <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] iommu/vt-d: Add helper to flush caches for context
 change
Message-ID: <20240815063430.70ac9b00.alex.williamson@redhat.com>
In-Reply-To: <4ff133f3-e541-4a0f-a72c-ce682720e6df@linux.intel.com>
References: <20240702130839.108139-1-baolu.lu@linux.intel.com>
	<20240702130839.108139-7-baolu.lu@linux.intel.com>
	<20240814162726.5efe1a6e.alex.williamson@redhat.com>
	<4ff133f3-e541-4a0f-a72c-ce682720e6df@linux.intel.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Aug 2024 12:47:58 +0800
Baolu Lu <baolu.lu@linux.intel.com> wrote:

> On 2024/8/15 6:27, Alex Williamson wrote:
> > Hi Baolu,  
> 
> Hi Alex,
> 
> > This appears to be non-functional and breaks device assignment...  
> 
> Yes. This is broken. Thanks for pointing it out.
> 
> Perhaps I can fix it by passing domain id to the helper? Something like
> below:

Hi Baolu,

Yes, I did a similar quick fix to prove this was the issue.  Thanks,

Alex

> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 01002ae2a091..b3b295e60626 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -1152,7 +1152,7 @@ void cache_tag_flush_range_np(struct dmar_domain 
> *domain, unsigned long start,
> 
>   void intel_context_flush_present(struct device_domain_info *info,
>   				 struct context_entry *context,
> -				 bool affect_domains);
> +				 u16 did, bool affect_domains);
> 
>   #ifdef CONFIG_INTEL_IOMMU_SVM
>   void intel_svm_check(struct intel_iommu *iommu);
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 159da629349c..34006b6e89eb 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1903,6 +1903,7 @@ static void domain_context_clear_one(struct 
> device_domain_info *info, u8 bus, u8
>   {
>   	struct intel_iommu *iommu = info->iommu;
>   	struct context_entry *context;
> +	u16 did;
> 
>   	spin_lock(&iommu->lock);
>   	context = iommu_context_addr(iommu, bus, devfn, 0);
> @@ -1911,10 +1912,11 @@ static void domain_context_clear_one(struct 
> device_domain_info *info, u8 bus, u8
>   		return;
>   	}
> 
> +	did = context_domain_id(context);
>   	context_clear_entry(context);
>   	__iommu_flush_cache(iommu, context, sizeof(*context));
>   	spin_unlock(&iommu->lock);
> -	intel_context_flush_present(info, context, true);
> +	intel_context_flush_present(info, context, did, true);
>   }
> 
>   static int domain_setup_first_level(struct intel_iommu *iommu,
> @@ -4077,6 +4079,7 @@ static int context_flip_pri(struct 
> device_domain_info *info, bool enable)
>   	struct intel_iommu *iommu = info->iommu;
>   	u8 bus = info->bus, devfn = info->devfn;
>   	struct context_entry *context;
> +	u16 did;
> 
>   	spin_lock(&iommu->lock);
>   	if (context_copied(iommu, bus, devfn)) {
> @@ -4089,6 +4092,7 @@ static int context_flip_pri(struct 
> device_domain_info *info, bool enable)
>   		spin_unlock(&iommu->lock);
>   		return -ENODEV;
>   	}
> +	did = context_domain_id(context);
> 
>   	if (enable)
>   		context_set_sm_pre(context);
> @@ -4097,7 +4101,7 @@ static int context_flip_pri(struct 
> device_domain_info *info, bool enable)
> 
>   	if (!ecap_coherent(iommu->ecap))
>   		clflush_cache_range(context, sizeof(*context));
> -	intel_context_flush_present(info, context, true);
> +	intel_context_flush_present(info, context, did, true);
>   	spin_unlock(&iommu->lock);
> 
>   	return 0;
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 5792c817cefa..b51fc268dc84 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -683,6 +683,7 @@ static void device_pasid_table_teardown(struct 
> device *dev, u8 bus, u8 devfn)
>   	struct device_domain_info *info = dev_iommu_priv_get(dev);
>   	struct intel_iommu *iommu = info->iommu;
>   	struct context_entry *context;
> +	u16 did;
> 
>   	spin_lock(&iommu->lock);
>   	context = iommu_context_addr(iommu, bus, devfn, false);
> @@ -691,10 +692,11 @@ static void device_pasid_table_teardown(struct 
> device *dev, u8 bus, u8 devfn)
>   		return;
>   	}
> 
> +	did = context_domain_id(context);
>   	context_clear_entry(context);
>   	__iommu_flush_cache(iommu, context, sizeof(*context));
>   	spin_unlock(&iommu->lock);
> -	intel_context_flush_present(info, context, false);
> +	intel_context_flush_present(info, context, did, false);
>   }
> 
>   static int pci_pasid_table_teardown(struct pci_dev *pdev, u16 alias, 
> void *data)
> @@ -885,10 +887,9 @@ static void __context_flush_dev_iotlb(struct 
> device_domain_info *info)
>    */
>   void intel_context_flush_present(struct device_domain_info *info,
>   				 struct context_entry *context,
> -				 bool flush_domains)
> +				 u16 did, bool flush_domains)
>   {
>   	struct intel_iommu *iommu = info->iommu;
> -	u16 did = context_domain_id(context);
>   	struct pasid_entry *pte;
>   	int i;
> 
> Thanks,
> baolu
> 


