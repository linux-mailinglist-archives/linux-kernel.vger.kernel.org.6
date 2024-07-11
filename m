Return-Path: <linux-kernel+bounces-249695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC1A92EEAA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9A11C21A08
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C5916DC1E;
	Thu, 11 Jul 2024 18:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WDZu3iFy"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417D186AFA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 18:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720721853; cv=none; b=J2XJ+yrvs29nAaY4edNYjqNjM1RpXhkqio6/mJ/Vk6Y+i+A2Jzo+51RwEfOKdMT0I9kOR37Fo1H0MBKHyxUCSFbiTg//AZWqqgrBqxsE9gDkN3yFZxhr+YDEyBDDALND0rNpX6w1uRX+eaemJuLCt6ePO9yx0dzHl6n7+PKBbpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720721853; c=relaxed/simple;
	bh=iuMBBhYlCOjZOpIFYeaHzJHApG0BTYNilpVypGgywA0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GaD1GIWLktHK3GajWqb1yGvwl0exfvAO8xpPN4BLwifsUgBuzI/SPpdN7MEd+PfFUIGCDgeIRfN99NHiY6DEux9huxO6MbV85f5DdFDkJBFt9ZoXAd5uISxstJAevvAWMGCvl+LXyIFR1kZ2xgwtdpTxkcQjBaoQdrOGnbPrp3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WDZu3iFy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.49.54] (c-73-118-245-227.hsd1.wa.comcast.net [73.118.245.227])
	by linux.microsoft.com (Postfix) with ESMTPSA id DEE8620B7165;
	Thu, 11 Jul 2024 11:17:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DEE8620B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1720721851;
	bh=+z283ws4ObwqjiEHX5vgO9Pe10pByZ7UcBYqlb7oBbU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=WDZu3iFyrQV0MTbppIIc3oSSkU+Hzv9GeME6W3cIBGcs2UmDHqkha/4CHbTmO0fGi
	 cjXFejIs99CBCeeWf8HKRuWsQxoGAHAgANj9ArJAyB1xhGJwgejJ5Hg1HU5rBvWjZd
	 sl0r5tmfoZld6dcw79CAE7UXnqA/p6e6feqVeBnY=
Message-ID: <0e665ec4-2449-4140-b1ad-41ae01bf3592@linux.microsoft.com>
Date: Thu, 11 Jul 2024 11:17:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, Leon Romanovsky <leonro@nvidia.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH 2/2] dma: Add IOMMU static calls with clear default ops
To: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <98d1821780028434ff55b5d2f1feea287409fbc4.1720693745.git.leon@kernel.org>
 <f2b699aea8fff5589a674da2a567fd593ed2d386.1720693745.git.leon@kernel.org>
Content-Language: en-US
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <f2b699aea8fff5589a674da2a567fd593ed2d386.1720693745.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/11/2024 3:38 AM, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Most of the IOMMU drivers are using the same DMA operations, which are
> default ones implemented in drivers/iomem/dma-iomem.c. So it makes sense

s/iomem/iommu?

> to properly set them as a default with direct call without need to
> perform function pointer dereference.
> 
> During system initialization, the IOMMU driver can set its own DMA and
> in such case, the default DMA operations will be overridden.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  MAINTAINERS               |  1 +
>  drivers/iommu/dma-iommu.c | 24 +++++++-------
>  include/linux/iommu-dma.h | 50 +++++++++++++++++++++++++++++
>  kernel/dma/iommu.h        | 67 +++++++++++++++++++++++++++++++++++++++
>  kernel/dma/mapping.c      |  9 +++---
>  5 files changed, 134 insertions(+), 17 deletions(-)
>  create mode 100644 include/linux/iommu-dma.h
>  create mode 100644 kernel/dma/iommu.h
> 

<snip>

