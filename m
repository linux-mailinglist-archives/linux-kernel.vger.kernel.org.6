Return-Path: <linux-kernel+bounces-277879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBD694A796
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2F8EB22074
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B426D1E672E;
	Wed,  7 Aug 2024 12:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nMYtuIaQ"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FBF1E2861
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 12:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723033036; cv=none; b=N1RYZisHaleWSL0PC8dTNvdFZLSxp3oQV6CvAOZ/GY8kzpNqrT3YqObC8fLPZxRaCxTukFOvP+2EGQO6SM3fjEA5TVkx6DsRkNrePDQmakkCxtmfwd/fr+7JqUuZ0DZEW0LKHQZYd9IxOtWMpeMfS/WHZs+pGbuRsFcnaP2W36Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723033036; c=relaxed/simple;
	bh=FIlVj6Sse0FxgT4tPlHHo/z//Fy3UvwKu0v9S+ye0uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nha1m1odlihL3UXuxr4tKEw3joLAozp5jJ/Slwh3fswBOqmO1phwSBbS428c0nBy/cLt4iEqGt7hMFh3RdsekwKFJmPG3YgmMz5EFe/f2n6Q9KLxDO/fkk5o3utierEwU3kHk+5jqRlVjmR2e1Z5fv5Mqb1sp5z6YbCh8dk/490=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nMYtuIaQ; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6b7b349a98aso10890726d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 05:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723033034; x=1723637834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r9aYfmnTgp8VccaVsoIgM6Nd0JM4AIFNu3GuM0vIyKg=;
        b=nMYtuIaQDOU6SbgANcvHRU7KgY9Jv7B0xknZ/qA22uaf5UNUkjj2gKAoHi8h2ggguM
         z05p85JXmosjzalxyrmVhUsekEZKuzuDeX9bjiyOi0B3NmVvriHc59c7UTi6IP9icc8M
         TzKFypBNcvONz+xQBX2BlTMbgQsSS82CUo5YXgijQVyM2AH7RS9jJXi3/cE2VI1XvglP
         WAHtGY4TK/otM33kghPfQjDgRINI81/ArRuIOoMB6OA4Sfi7n/YoEpf/TXprQUdmw2/p
         BUb0Biezs/a1NATAVEg+Ff6zc1MGzwvbUjtD4+x3h7dlpBvyEr+yHeMZts2QCdEBmlkO
         LD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723033034; x=1723637834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9aYfmnTgp8VccaVsoIgM6Nd0JM4AIFNu3GuM0vIyKg=;
        b=BMET1mBNVHwzoOKGoLOYicLTC7g0RTMTCCdSUqX+xjHYqdRKCzln/YrJGJ0PLaOgEs
         1/L55RSPkQkhnxOdeEarAo7Xkw+IfikTc6XkL1P1uYrpf7ggqMdDpBT5nw8yRQzIIGhI
         OLbuR1UufAjyxmnhm95haZRLf7k05+n2jtEeozi/sFhxI750OzOtAppMToDmAdnkNB+b
         5Q4aD8BWgDcN0OjaFqWJt3clyAfm5B+3tCLCAalolRqxp86oxpNxbKjOeRUJJzj7HzPs
         j/ZTd6Kc6uYWt6M5WlkmlvamvVJUWGdcMXZced/PRE7yS0xfDeJvbd+0mpvl51KAyOqn
         OK8w==
X-Forwarded-Encrypted: i=1; AJvYcCVL0v/xobQEv8S5SuPqWmkvQ0VEmySdBU0YQXI7pbWV8hPAD5bAI9k5NnzTDmJAzpI1kQQBUS79b6LfdmLmHGOv1TPnXg7vq2O7wF3o
X-Gm-Message-State: AOJu0YxNOePcYV3HATUwCz5Sx+3YofIj0w3ZYZ+3Y/fYm7AEBN7BzmmM
	1jyDPS75j19FyauG2IJHL6+csZZMeFD3/8v91bw4f6LlovK1sohR0QBsOpbUcEo=
X-Google-Smtp-Source: AGHT+IHhsaoe3pLaUBrbRcWvTT69L3kXjKkj4dSPaadCCQjbpgMTzV3yG93DN8+PNDKRYlUt15eyDQ==
X-Received: by 2002:a05:6214:5405:b0:6b5:d9ef:d576 with SMTP id 6a1803df08f44-6bb98379a5amr202476736d6.12.1723033033682;
        Wed, 07 Aug 2024 05:17:13 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c86baa8sm56066246d6.118.2024.08.07.05.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 05:17:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sbfbM-001m4K-2a;
	Wed, 07 Aug 2024 09:17:12 -0300
Date: Wed, 7 Aug 2024 09:17:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] iommu/vt-d: Prepare for global static identity
 domain
Message-ID: <20240807121712.GD8473@ziepe.ca>
References: <20240806023941.93454-1-baolu.lu@linux.intel.com>
 <20240806023941.93454-5-baolu.lu@linux.intel.com>
 <20240806171236.GM676757@ziepe.ca>
 <9aa9e93e-915e-4c6d-9adb-b7d5facdf3bc@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9aa9e93e-915e-4c6d-9adb-b7d5facdf3bc@linux.intel.com>

On Wed, Aug 07, 2024 at 02:41:39PM +0800, Baolu Lu wrote:
> On 2024/8/7 1:12, Jason Gunthorpe wrote:
> > On Tue, Aug 06, 2024 at 10:39:38AM +0800, Lu Baolu wrote:
> > > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > > index c019fb3b3e78..f37c8c3cba3c 100644
> > > --- a/drivers/iommu/intel/iommu.c
> > > +++ b/drivers/iommu/intel/iommu.c
> > > @@ -1270,6 +1270,9 @@ void domain_update_iotlb(struct dmar_domain *domain)
> > >   	bool has_iotlb_device = false;
> > >   	unsigned long flags;
> > > +	if (!domain)
> > > +		return;
> > > +
> > This seems really strange, maybe wrong..
> > 
> > The only callers that could take advantage are
> > iommu_enable_pci_caps()/iommu_disable_pci_caps()
> 
> Yes.
> 
> When the PCI ATS status changes, the domain attached to the device
> should have its domain->has_iotlb_device flag updated.
> 
> The global static identity domain is a dummy domain without a
> corresponding dmar_domain structure. Consequently, the device's
> info->domain will be NULL. This is why a check is necessary.

I get it, but you can't have ATS turned on at all if you can push the
invalidations. So it seems like something is missing to enforce that
with the identity domains.

> > So I looked at this and, uh, who even reads domain->has_iotlb_device ?
> 
> The has_iotlb_device flag indicates whether a domain is attached to
> devices with ATS enabled. If a domain lacks this flag, no device TBLs
> need to be invalidated during unmap operations. This optimization avoids
> unnecessary looping through all attached devices.

Not any more, that was removed in commit 06792d067989 ("iommu/vt-d:
Cleanup use of iommu_flush_iotlb_psi()")

This compiles, so you should do this instead:

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ad81db026ab236..6549488d1f6bb1 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -492,7 +492,6 @@ void domain_update_iommu_cap(struct dmar_domain *domain)
 		domain->domain.geometry.aperture_end = __DOMAIN_MAX_ADDR(domain->gaw);
 
 	domain->domain.pgsize_bitmap |= domain_super_pgsize_bitmap(domain);
-	domain_update_iotlb(domain);
 }
 
 struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
@@ -1270,32 +1269,6 @@ domain_lookup_dev_info(struct dmar_domain *domain,
 	return NULL;
 }
 
-void domain_update_iotlb(struct dmar_domain *domain)
-{
-	struct dev_pasid_info *dev_pasid;
-	struct device_domain_info *info;
-	bool has_iotlb_device = false;
-	unsigned long flags;
-
-	spin_lock_irqsave(&domain->lock, flags);
-	list_for_each_entry(info, &domain->devices, link) {
-		if (info->ats_enabled) {
-			has_iotlb_device = true;
-			break;
-		}
-	}
-
-	list_for_each_entry(dev_pasid, &domain->dev_pasids, link_domain) {
-		info = dev_iommu_priv_get(dev_pasid->dev);
-		if (info->ats_enabled) {
-			has_iotlb_device = true;
-			break;
-		}
-	}
-	domain->has_iotlb_device = has_iotlb_device;
-	spin_unlock_irqrestore(&domain->lock, flags);
-}
-
 /*
  * The extra devTLB flush quirk impacts those QAT devices with PCI device
  * IDs ranging from 0x4940 to 0x4943. It is exempted from risky_device()
@@ -1332,10 +1305,8 @@ static void iommu_enable_pci_caps(struct device_domain_info *info)
 		info->pasid_enabled = 1;
 
 	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
-	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
+	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT))
 		info->ats_enabled = 1;
-		domain_update_iotlb(info->domain);
-	}
 }
 
 static void iommu_disable_pci_caps(struct device_domain_info *info)
@@ -1350,7 +1321,6 @@ static void iommu_disable_pci_caps(struct device_domain_info *info)
 	if (info->ats_enabled) {
 		pci_disable_ats(pdev);
 		info->ats_enabled = 0;
-		domain_update_iotlb(info->domain);
 	}
 
 	if (info->pasid_enabled) {
@@ -1524,7 +1494,6 @@ static struct dmar_domain *alloc_domain(unsigned int type)
 	domain->nid = NUMA_NO_NODE;
 	if (first_level_by_default(type))
 		domain->use_first_level = true;
-	domain->has_iotlb_device = false;
 	INIT_LIST_HEAD(&domain->devices);
 	INIT_LIST_HEAD(&domain->dev_pasids);
 	INIT_LIST_HEAD(&domain->cache_tags);
@@ -3622,7 +3591,6 @@ static struct dmar_domain *paging_domain_alloc(struct device *dev, bool first_st
 	xa_init(&domain->iommu_array);
 
 	domain->nid = dev_to_node(dev);
-	domain->has_iotlb_device = info->ats_enabled;
 	domain->use_first_level = first_stage;
 
 	/* calculate the address width */
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index b67c14da12408b..e80aed3bc06e61 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -588,7 +588,6 @@ struct dmar_domain {
 	int	nid;			/* node id */
 	struct xarray iommu_array;	/* Attached IOMMU array */
 
-	u8 has_iotlb_device: 1;
 	u8 iommu_coherency: 1;		/* indicate coherency of iommu access */
 	u8 force_snooping : 1;		/* Create IOPTEs with snoop control */
 	u8 set_pte_snp:1;

