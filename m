Return-Path: <linux-kernel+bounces-172953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF558BF939
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB7961C21C3D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC06671B44;
	Wed,  8 May 2024 09:06:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0AD54668
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 09:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715159183; cv=none; b=JcEk+l6D66u37b3sXL1Avy7+QH7W/loDbULU3ksN7C/PV3YaG7OuIqcJm3SZ9U+2o3S3aHdtzAIpgh4wL8zgwrRHablwAJzDgZdU38JTSvlwRu5KL0DEW4WHw4SuVY1zN/cN3xpgR1iRzggtNQSsootaAIIj/L2KlOP3HdAJeRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715159183; c=relaxed/simple;
	bh=bC2HOa0hmlB0z8GE5RN9GNjjJs2cr+lYi9zUmkSj1cY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nT7O8Aah7Ym1hmXyh4a5G5dnar3SEahCHZgwuXj3zohFYIUad1HKANBeRqgzyTWCLMvRtIq7ABqPM7QVlS+onpXhTWzI2JLI4hmrT8ub8Levod6xhOhDRT1kyRt71KEzN3PNVR5IBs7sCCwHVm4lom04NKUdmXDKWghfEfjZdhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B40161063;
	Wed,  8 May 2024 02:06:46 -0700 (PDT)
Received: from [10.57.67.194] (unknown [10.57.67.194])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E2363F6A8;
	Wed,  8 May 2024 02:06:19 -0700 (PDT)
Message-ID: <b5592a14-4add-42a4-89aa-e9a54ed7123c@arm.com>
Date: Wed, 8 May 2024 10:06:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] mm: move highest_order() and next_order() out of the
 THP config
Content-Language: en-GB
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, david@redhat.com, ioworker0@gmail.com,
 wangkefeng.wang@huawei.com, ying.huang@intel.com, 21cnbao@gmail.com,
 shy828301@gmail.com, ziy@nvidia.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1714978902.git.baolin.wang@linux.alibaba.com>
 <d9c0ac9df6f6e6176b09fc1ae58146ec4f8d73f5.1714978902.git.baolin.wang@linux.alibaba.com>
 <9576c979-8a11-48e2-aec4-646acf0d8e26@arm.com>
 <2fcd6dfc-21b7-4e3f-9741-8f0d23d2da5f@linux.alibaba.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <2fcd6dfc-21b7-4e3f-9741-8f0d23d2da5f@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/05/2024 03:13, Baolin Wang wrote:
> 
> 
> On 2024/5/7 18:21, Ryan Roberts wrote:
>> On 06/05/2024 09:46, Baolin Wang wrote:
>>> Move highest_order() and next_order() out of the CONFIG_TRANSPARENT_HUGEPAGE
>>> macro, which can be common functions to be used.
>>
>> Sorry if I haven't kept up with the discussion, but why is this needed? I
>> wouldn't expect a need to iterate over orders if THP is compile-time disabled
>> because we will never try to allocate THP?
> 
> Cause I don't want to add some dummy functions to avoid building errors if
> CONFIG_TRANSPARENT_HUGEPAGE is not enabled in patch 6. Another thought is that
> the pagecache can also allocate a large folio even when THP is not enabled, so
> these helpers may be used in the future (not sure though).

OK, I'll admit I haven't looked at the latter patches yet - I'd like to conclude
on the interface and mapping/alignment strategy first.

But it wasn't necessary to access these functions for the anon/private case
without CONFIG_TRANSPARENT_HUGEPAGE, so I'm wondering why it's needed for shmem
case. I would expect that they don't need to be defined at all.

> 
> Anyway, I also have no strong perference for this patch, below dummy functions
> can also work for me:
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index c15bebb2cf53..7aa802ee2ce5 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -586,6 +586,16 @@ static inline bool thp_migration_supported(void)
>  {
>         return false;
>  }
> +
> +static inline int highest_order(unsigned long orders)
> +{
> +        return 0;
> +}
> +
> +static inline int next_order(unsigned long *orders, int prev)
> +{
> +        return 0;
> +}
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */


