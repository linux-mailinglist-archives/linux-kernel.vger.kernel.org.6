Return-Path: <linux-kernel+bounces-554571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB59A59A10
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BE543AA497
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C936422D4F4;
	Mon, 10 Mar 2025 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b="QAvzpGjK"
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4D21C68B6
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741620904; cv=pass; b=YE6kuN8j0P7YZe+P7Z88W3t6Iuu2GEdcy1dDKBJ9fIlDpI0mVQ5HmA1fTugtJIyl7tG5K66KaT6eBJ140utXIKkG3aufZldb7ZJ4BuJ75eW+3qKhqgDUqEYKli659iSd656joqDjkYfruhaA9WiMEb4YaBFyxkIMFeKDWP6I7NQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741620904; c=relaxed/simple;
	bh=Nx555+NtSDzXz90QOuxjrITiDLAiiZFLg+hfDKtRm5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JxVShEdO+HTjIUWE7sxwnEaL4KQaO2HApC3pXP+VlnH99yQ3+m4qL/MTdundPJcdY3RjGatkHMOdhnqN/o3xTDw6pUEtMIu/9mfkIG+Qv6sU9yp1/4dQgkMMApO52e8+18f/jgNhBZ+9/gep80na1m6lE4Ray+UAKBS/2iJmEgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b=QAvzpGjK; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741620879; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DzrekeHXCnD07yLLuY9kF+sth2UjlCNk1s4871aVms+4GuRthn3JEvdxKgxfzhK86oZN9tYQfOOr1lctAG3C8BXNlGtD/0PXLonNfc5Re6jMkXHSZA5dfp1EK296TxYgR8SVRuzm2uTXGyD8M17dNwdLazp0DE4vUNn0vOE3ToM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741620879; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fKGYjqu4Ev4SqaAEdORO3V9LqmGHctq0CSPM/977IfQ=; 
	b=NmOrwpT6AAtoZP/TrXyYOBgChsgLjxIZSqYOTj2kLm8PrTfQoFNQMDecXKoKob5fLRfl//k6lsMrc7zwohpl7RrCCE6Spdbv/8RN32yI04udiOTGDWTNocaVnmOr4f1Cow9NajLBj2MGjtCHkkyrCrYzHRprOcleMUyJ8ecC9vA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
	dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741620879;
	s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=fKGYjqu4Ev4SqaAEdORO3V9LqmGHctq0CSPM/977IfQ=;
	b=QAvzpGjK9VnN7UqGBMBTo+N83eYP0pmKLVdfSpxGEldWGMlefXxFCAdtRaa/uv7j
	n/QO+HCaIe+qZhGDy/ljjHKyoVgrv0e9G47YaMSVGKg24OBWLRHicomssfyk9qT9+7T
	lHsYJ6dz1rt9hmjwuFZfgnPR2TGdg+m8JGmt9tSM=
Received: by mx.zohomail.com with SMTPS id 1741620876294195.17720317390024;
	Mon, 10 Mar 2025 08:34:36 -0700 (PDT)
Message-ID: <ec151d39-2cb2-4f67-a23a-dafc421fff75@collabora.com>
Date: Mon, 10 Mar 2025 12:34:30 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/4] drm/panfrost: Support ARM_64_LPAE_S1 page table
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 robh@kernel.org, steven.price@arm.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
References: <20250226183043.140773-1-ariel.dalessandro@collabora.com>
 <20250226183043.140773-4-ariel.dalessandro@collabora.com>
 <20250227155539.59944e18@collabora.com>
Content-Language: en-US
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
In-Reply-To: <20250227155539.59944e18@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hi Boris,

On 2/27/25 11:55 AM, Boris Brezillon wrote:
> On Wed, 26 Feb 2025 15:30:42 -0300
> Ariel D'Alessandro <ariel.dalessandro@collabora.com> wrote:
> 
>> @@ -642,8 +713,15 @@ struct panfrost_mmu *panfrost_mmu_ctx_create(struct panfrost_device *pfdev)
>>   		.iommu_dev	= pfdev->dev,
>>   	};
>>   
>> -	mmu->pgtbl_ops = alloc_io_pgtable_ops(ARM_MALI_LPAE, &mmu->pgtbl_cfg,
>> -					      mmu);
>> +	if (panfrost_has_hw_feature(pfdev, HW_FEATURE_AARCH64_MMU)) {
>> +		fmt = ARM_64_LPAE_S1;
>> +		mmu->enable = mmu_lpae_s1_enable;
>> +	} else {
>> +		fmt = ARM_MALI_LPAE;
>> +		mmu->enable = mmu_mali_lpae_enable;
>> +	}
> 
> How about we stick to the legacy pgtable format for all currently
> supported GPUs, and make this an opt-in property attached to the
> compatible. This way, we can progressively move away from the legacy
> format once enough testing has been done, while allowing support for
> GPUs that can't use the old format because the cachability/shareability
> configuration is too limited.

Indeed, that's a better way to go.

Specifically, what you mean is: keep the same compatible string and add 
a new property to the `panfrost_compatible` private data for that 
specific variant? E.g.

In drivers/gpu/drm/panfrost/panfrost_drv.c:
```
struct panfrost_compatible mediatek_mt8188_data
[...]
{ .compatible = "mediatek,mt8188-mali", .data = &mediatek_mt8188_data },
```

Thanks,

-- 
Ariel D'Alessandro
Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK 
Registered in England & Wales, no. 5513718


