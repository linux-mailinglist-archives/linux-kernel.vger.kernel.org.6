Return-Path: <linux-kernel+bounces-287269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E329525B2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 00:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC18F1F24A36
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 22:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA73E15099C;
	Wed, 14 Aug 2024 22:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GdqJB8Bl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC956149C68
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 22:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723674455; cv=none; b=TxqA3G78684691SUBwNQfUgQ9ZbeJc9BKmatX/oWE5AGBVIWXH/gJ2KyG7Jud0xr/q0MvKqzFHla8+TsLFMT+mffeJMzl3wq3f5B5uLARMpakPkQUAG+TkSBieWNUiKKCQLotiyzD2Kx2LjWOse+Gw7qNHVgc9JXBe834J8W9aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723674455; c=relaxed/simple;
	bh=WxId2LvoUbIR/HU8RV62Ck6iciJvrd83qvLCCe9IHtA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=te9Q0LDBIF4AtaH9n7csTeKg8tskVrgRDTA2JM/DHr2XS/RlS8D1gbHWRjR4mfF2ly/uZPGjzbP0bFuTuf4Rq6SSAmg0FXPNXH42/F757nxv5fBUV4JXVacBGJR2amBZpTUG91xIOZjCVhL24nqfQoXOmaNTk9dvqsQybsbI9zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GdqJB8Bl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723674450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AEl+MLJRfedULB1aDJQko5v2A6SsiXNnJ73kd73YG9M=;
	b=GdqJB8BlX5XBP5u6sHqU3bBWWj15YSBqLkinYKWoviqoG+K7QB0VV6SIBZW1Rc9YqOgZHQ
	9p9mOiUEpJ4yQPfQuM4Q9bNkxujlLDkRHeLOYqNooHD8+5LOX1eX711O5ElC5Q67EqxlY6
	A7/4pIt/yweEgU8f5Io0Q9OkLiGjVLg=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-CCXs7o1OOFmWVLFyRIEg0Q-1; Wed, 14 Aug 2024 18:27:29 -0400
X-MC-Unique: CCXs7o1OOFmWVLFyRIEg0Q-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39b3cd1813aso3849895ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 15:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723674449; x=1724279249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AEl+MLJRfedULB1aDJQko5v2A6SsiXNnJ73kd73YG9M=;
        b=Gsox2Oj8P6ncps7oM2k2NYD71J0mRCRtpbTI4mbveadLRipC0aHjlBuxgLUaOQlkuK
         hrrbOVOnGadBQ60QcImQYNq6oyGa18QjY9RsXHFtKJZqpNoxLzOOr0BoZ0Xo7/KowSLN
         uRC380TJilhp1xv+pt7UjmiZKH9PAoUtsPD0FUmoMMqmZqnOqgKCOsUjijswl6D9eajr
         3AD5t9m0GwvIwqOH0DM+Ny+HY953ujtnLUSye7A436hjYN9Pxsk02Zk7OXjlPp+1jbOo
         t4yBPCstzfhM1A9oId5W7gTQc0bNwmo75gCKqN/mpZs9L54DOqXe96Spl5z65KF7mh+k
         Bdsg==
X-Forwarded-Encrypted: i=1; AJvYcCU01KUfK2PGcQHZ4sjvA6Q1qccD3bQ4rEQr/b0+MGYXdb7Ap5AsBxZ1lUdH0uyfifLJXqG4/TYiNJOligLLsOmOBkUc1QJPXg2O19i+
X-Gm-Message-State: AOJu0Yzg1fwtbgrEnia37cuYvxuJMFvFKytqNAg7Ml0uJMW83HAU4/vv
	ma4T02WeXBensvtbHvtMDPRMBwt8eU8LsKuA02sldIgE/uGsDfxz7+BFozAlZu7YI6v1c2k+Hhy
	Qdo2PEMKXeXLS9K+E5pow9vA0IC3oJocS17fpiCCFt2CG/tgevf00cJiIAqpqOw==
X-Received: by 2002:a05:6e02:1546:b0:398:36c0:7968 with SMTP id e9e14a558f8ab-39d124412abmr55043115ab.6.1723674448863;
        Wed, 14 Aug 2024 15:27:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0XnB3zAv8wIE4zKw7V690F2HnrtkA+wzWRAYAy01bH2r2yleRktwbE5PM1Fe9xVttrUfSjg==
X-Received: by 2002:a05:6e02:1546:b0:398:36c0:7968 with SMTP id e9e14a558f8ab-39d124412abmr55042975ab.6.1723674448610;
        Wed, 14 Aug 2024 15:27:28 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39d1ead55aasm662305ab.13.2024.08.14.15.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 15:27:27 -0700 (PDT)
Date: Wed, 14 Aug 2024 16:27:26 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jacob Pan
 <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] iommu/vt-d: Add helper to flush caches for context
 change
Message-ID: <20240814162726.5efe1a6e.alex.williamson@redhat.com>
In-Reply-To: <20240702130839.108139-7-baolu.lu@linux.intel.com>
References: <20240702130839.108139-1-baolu.lu@linux.intel.com>
	<20240702130839.108139-7-baolu.lu@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hi Baolu,

This appears to be non-functional and breaks device assignment...

On Tue,  2 Jul 2024 21:08:38 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 1f0d6892a0b6..e84b0fdca107 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
...
> @@ -1959,7 +1944,6 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
>  {
>  	struct intel_iommu *iommu = info->iommu;
>  	struct context_entry *context;
> -	u16 did_old;
>  
>  	spin_lock(&iommu->lock);
>  	context = iommu_context_addr(iommu, bus, devfn, 0);
> @@ -1968,24 +1952,10 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
>  		return;
>  	}
>  
> -	did_old = context_domain_id(context);
> -

    static inline int context_domain_id(struct context_entry *c)
    {
            return((c->hi >> 8) & 0xffff);
    }

>  	context_clear_entry(context);

    static inline void context_clear_entry(struct context_entry *context)
    {       
            context->lo = 0;
            context->hi = 0;
    }

>  	__iommu_flush_cache(iommu, context, sizeof(*context));
>  	spin_unlock(&iommu->lock);
> -	iommu->flush.flush_context(iommu,
> -				   did_old,
> -				   (((u16)bus) << 8) | devfn,
> -				   DMA_CCMD_MASK_NOBIT,
> -				   DMA_CCMD_DEVICE_INVL);
> -
> -	iommu->flush.flush_iotlb(iommu,
> -				 did_old,
> -				 0,
> -				 0,
> -				 DMA_TLB_DSI_FLUSH);
> -
> -	__iommu_flush_dev_iotlb(info, 0, MAX_AGAW_PFN_WIDTH);
> +	intel_context_flush_present(info, context, true);
>  }
>  
>  static int domain_setup_first_level(struct intel_iommu *iommu,
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index aabcdf756581..d6623d2c2050 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
...
> +void intel_context_flush_present(struct device_domain_info *info,
> +				 struct context_entry *context,
> +				 bool flush_domains)
> +{
> +	struct intel_iommu *iommu = info->iommu;
> +	u16 did = context_domain_id(context);

Whoops, did is always zero here, intel_context_flush_present() precedes
all callers.

> +	struct pasid_entry *pte;
> +	int i;
> +
> +	/*
> +	 * Device-selective context-cache invalidation. The Domain-ID field
> +	 * of the Context-cache Invalidate Descriptor is ignored by hardware
> +	 * when operating in scalable mode. Therefore the @did value doesn't
> +	 * matter in scalable mode.
> +	 */
> +	iommu->flush.flush_context(iommu, did, PCI_DEVID(info->bus, info->devfn),
                                          ^^^ Bogus
> +				   DMA_CCMD_MASK_NOBIT, DMA_CCMD_DEVICE_INVL);
> +
> +	/*
> +	 * For legacy mode:
> +	 * - Domain-selective IOTLB invalidation
> +	 * - Global Device-TLB invalidation to all affected functions
> +	 */
> +	if (!sm_supported(iommu)) {
> +		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
                                                ^^^ etc...
> +		__context_flush_dev_iotlb(info);
> +
> +		return;
> +	}

Thanks,
Alex


