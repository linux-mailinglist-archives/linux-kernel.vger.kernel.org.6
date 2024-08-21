Return-Path: <linux-kernel+bounces-294653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D999590DD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 01:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72252B2309F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 23:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69451C824A;
	Tue, 20 Aug 2024 23:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kvSjZdu6"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE46B18C906
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 23:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724195081; cv=none; b=RYYV1oXyDggZ1aLeiLRFCM5JPCg96cS2TnOlXdesAScmu2K03zZBnn2vmHbyAQvmeVNYIWFHnf0ppUouS6HeCblOVqaMl9rxafXNxqcueCW5qA6Gy1Y/azybbLgDCw4QV1V+8EqTGnhVhWov1vkiGeKH2tnnOQH6B9Y3+n8UqQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724195081; c=relaxed/simple;
	bh=EATt0tCRzljWphvcXmBRRwS+xNaSSQAgbXjkkdb157Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GfesGcqg7IZg99ESDS60rOrSYjb8gGIGJWnIh8ykDJRSqFzB/M/nCqKwd7cGMXUzOCSj66jiD3Hosf2NQzDKMJzhR580DVuGODevFw2rWz8Llfq5sweHdLaysyqrdJ0JYm9YCViuAPL+upFE3/lYnfdSLQ+MoldVm3//ZUYD7BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kvSjZdu6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-0403QTC. (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3D1FD20B7165;
	Tue, 20 Aug 2024 16:04:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3D1FD20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1724195079;
	bh=D6zEqy376/OShhmuon6epP+P07be+GAy/DybGw8HGwc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kvSjZdu6M9XzNBlSR6m94fselW1qjr/8b0WSC6V/u1vt/uOsovMsZcooYzlptpFoK
	 0tEP7km3aLaqGRNw8N6murAFH2xzyC+U8aosBGMiomFiXbZcq4tYRO+ss+HM+rWG7s
	 Lp5kXYovmMTwmatOF2DkNYTNzCRN94dIuGs6qTdY=
Date: Tue, 20 Aug 2024 16:04:37 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Tina Zhang <tina.zhang@intel.com>, Kevin Tian <kevin.tian@intel.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] iommu/vt-d: Introduce batched cache invalidation
Message-ID: <20240820160437.76fb4d34@DESKTOP-0403QTC.>
In-Reply-To: <8da6a9b6-01f4-4c4f-9619-148fdb3828d0@linux.intel.com>
References: <20240815065221.50328-1-tina.zhang@intel.com>
	<20240815065221.50328-5-tina.zhang@intel.com>
	<20240816093846.40dbd623@DESKTOP-0403QTC.>
	<afec1d30-4bb3-4d39-9ff1-eb8ecb26bed3@linux.intel.com>
	<20240819084056.298a9924@DESKTOP-0403QTC.>
	<8da6a9b6-01f4-4c4f-9619-148fdb3828d0@linux.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Baolu,

On Tue, 20 Aug 2024 10:06:05 +0800
Baolu Lu <baolu.lu@linux.intel.com> wrote:

> On 8/19/24 11:40 PM, Jacob Pan wrote:
> > On Sat, 17 Aug 2024 11:28:21 +0800
> > Baolu Lu<baolu.lu@linux.intel.com>  wrote:
> >   
> >> On 2024/8/17 0:38, Jacob Pan wrote:  
> >>> On Thu, 15 Aug 2024 14:52:21 +0800
> >>> Tina Zhang<tina.zhang@intel.com>  wrote:
> >>>      
> >>>> @@ -270,7 +343,8 @@ static void cache_tag_flush_iotlb(struct
> >>>> dmar_domain *domain, struct cache_tag * u64 type =
> >>>> DMA_TLB_PSI_FLUSH;
> >>>>    	if (domain->use_first_level) {
> >>>> -		qi_flush_piotlb(iommu, tag->domain_id,
> >>>> tag->pasid, addr, pages, ih);
> >>>> +		qi_batch_add_piotlb(iommu, tag->domain_id,
> >>>> tag->pasid, addr,
> >>>> +				    pages, ih,
> >>>> domain->qi_batch); return;
> >>>>    	}
> >>>>    
> >>>> @@ -287,7 +361,8 @@ static void cache_tag_flush_iotlb(struct
> >>>> dmar_domain *domain, struct cache_tag * }
> >>>>    
> >>>>    	if (ecap_qis(iommu->ecap))
> >>>> -		qi_flush_iotlb(iommu, tag->domain_id, addr | ih,
> >>>> mask, type);
> >>>> +		qi_batch_add_iotlb(iommu, tag->domain_id, addr |
> >>>> ih, mask, type,
> >>>> +				   domain->qi_batch);
> >>>>        
> >>> If I understand this correctly, IOTLB flush maybe deferred until
> >>> the batch array is full, right? If so, is there a security gap
> >>> where callers think the mapping is gone after the call returns?  
> >> No. All related caches are flushed before function return. A domain
> >> can have multiple cache tags. Previously, we sent individual cache
> >> invalidation requests to hardware. This change combines all
> >> necessary invalidation requests into a single batch and raise them
> >> to hardware together to make it more efficient.  
> > I was looking at the code below, if the index does not reach
> > QI_MAX_BATCHED_DESC_COUNT. There will be no flush after
> > cache_tag_flush_iotlb() returns, right?  
> 
> No. qi_batch_flush_descs() is called explicitly before return.
I see, cache_tag_flush_iotlb() is really just adding descriptors to the
batch. Not doing any flush for most cases. IMHO, the name is a little
confusing.

Thanks,

Jacob

