Return-Path: <linux-kernel+bounces-249810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A3D92F025
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 22:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1ACF1F227FB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F40C19E830;
	Thu, 11 Jul 2024 20:09:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A76149000
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 20:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720728558; cv=none; b=gUbljXSTnD2ZfcVr9gnLDOtiZf3TtqiA9iYUPWpUe9E7fMVRUwV1U4lgSeulAenx51CVDzpSrbcDoLBnxG1va6xDEiL6e63E6EcUtEwAYPDwfzRMU5cBaIvfUr/WXrT8Oc5noT4LuhKsaERteDUA11BEdhB+YYGfbq710LH7qrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720728558; c=relaxed/simple;
	bh=IQEMcvQA4q5UdFL8E3k7bSfozbC0sE/EVwt+B8J4d+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XYVVcMIuDe2sQlZoSr9OEBCtXYuX7wjJ0PcUB5osCb71KiyWwdapTh/xEYzyaL84iFW55hX4j6Hcmegnosg41MH4DbbcAJetdXhtIOVNOL7gc6ra/ZmZnTAfL8p7KtQhxR34KxCRqBmclRdqK6NIwD2+USOnCcdFzayT0HHeD2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAF421007;
	Thu, 11 Jul 2024 13:09:40 -0700 (PDT)
Received: from [10.57.91.215] (unknown [10.57.91.215])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A365E3F762;
	Thu, 11 Jul 2024 13:09:13 -0700 (PDT)
Message-ID: <455ccc97-11bd-456d-92b3-b7c8fe4c8d9a@arm.com>
Date: Thu, 11 Jul 2024 21:08:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dma: Add IOMMU static calls with clear default ops
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <98d1821780028434ff55b5d2f1feea287409fbc4.1720693745.git.leon@kernel.org>
 <f2b699aea8fff5589a674da2a567fd593ed2d386.1720693745.git.leon@kernel.org>
 <28309b7f-9809-452f-95fe-3448c15bdf1b@arm.com>
 <20240711185741.GC1815706@unreal>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240711185741.GC1815706@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-07-11 7:57 pm, Leon Romanovsky wrote:
> On Thu, Jul 11, 2024 at 07:23:20PM +0100, Robin Murphy wrote:
>> On 11/07/2024 11:38 am, Leon Romanovsky wrote:
>>> From: Leon Romanovsky <leonro@nvidia.com>
>>>
>>> Most of the IOMMU drivers are using the same DMA operations, which are
>>> default ones implemented in drivers/iomem/dma-iomem.c. So it makes sense
>>> to properly set them as a default with direct call without need to
>>> perform function pointer dereference.
>>>
>>> During system initialization, the IOMMU driver can set its own DMA and
>>> in such case, the default DMA operations will be overridden.
>>
>> I'm going to guess you don't actually mean "IOMMU drivers" in the usual
>> sense of drivers/iommu/, but rather "arch DMA ops (which often, but not
>> always, involve some sort of IOMMU)."
> 
> Yes, you are right. I used word "drivers" as a general term to describe
> everything that implements their own ->map_page() callback.
> 
>>
>> If so, I'd much rather see this done properly, i.e. hook everything up
>> similarly to dma-direct and be able to drop CONFIG_DMA_OPS for "modern"
>> dma-direct/iommu-dma architectures entirely. Furthermore the implementation
>> here isn't right - not only is it not conceptually appropriate to make
>> iommu-dma responsibile for proxying random arch DMA ops, but in practial
>> terms it's just plain broken, since the architectures which still have their
>> own DMA ops also don't use iommu-dma, so this is essentially disabling the
>> entire streaming DMA API on ARM/PowerPC/etc.
> 
> Sorry but I'm not sure that I understood your reply. Can you please clarify
> what does it mean broken in this context?
> 
> All archs have one of the following options:
> 1. No DMA ops -> for them dma_map_direct() will return True and they
> never will enter into IOMMU path.
> 2. Have DMA ops but without .map_page() -> they will use default IOMMU
> 3. Have DMA ops with .map_page() -> they will use their own implementation

Urgh, sorry, let that instead be a lesson in not adding needless layers 
of indirection that are named as confusingly as possible, then. Seems I 
saw stubs plus static inline wrappers, managed to misread dma_iommu_* 
vs. iommu_dma_*, and jump to the wrong conclusion of what was stubbed 
out, not least since that was the only interpretation in which adding an 
extra layer of inline wrappers would seem necessary in the first place. 
If these dma_iommu_* functions serve no purpose other than to make the 
code even more of a maze of twisty little passages, all alike, then 
please just feed them to a grue instead.

Thanks,
Robin.

