Return-Path: <linux-kernel+bounces-331431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BA397ACD8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E8AE281ABB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6979157485;
	Tue, 17 Sep 2024 08:29:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C7614A60D
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 08:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726561771; cv=none; b=dnKA7GZt1efHgrk1D2eORqbhGb6iRwK/fsqVNGyZSA5LOyBK09KyUAP/hVDuquKc0KFCDL8wNANU0LIpTyj71mNRVzaQoytEHKYhIX5dxZ4cz2AUVwvXiS+vSfMAeYSD2LYFMuw5Q01gr2EKks1FGNWddZ8O3E1GaIxhr8ibP/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726561771; c=relaxed/simple;
	bh=E6cIJy2A9q6rPSC5VcMS0webAb5YKKZtWPJKQGfBFYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z9z0Vp/SgJtN1SCgQxGcttSMSp5m0yzIna8f6Ck9+CNQm4NjYlJS8vqTKLVgVTRvY6Laj85PPgf1hXBT3dThNCT2leUkAbj5HZoQva0EMbt+E15MqMnPy4bTbNKHn/ToTPGuRWlK/EGub1AG8rqoIaW6gDogBBAZEF9BTrLkaHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20FB8DA7;
	Tue, 17 Sep 2024 01:29:58 -0700 (PDT)
Received: from [10.57.83.157] (unknown [10.57.83.157])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF11E3F66E;
	Tue, 17 Sep 2024 01:29:26 -0700 (PDT)
Message-ID: <bde86cb8-fe30-4747-b3a7-cc40d0850f10@arm.com>
Date: Tue, 17 Sep 2024 09:29:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Compute mTHP order efficiently
To: Dev Jain <dev.jain@arm.com>, Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, david@redhat.com, anshuman.khandual@arm.com,
 baohua@kernel.org, hughd@google.com, ioworker0@gmail.com,
 wangkefeng.wang@huawei.com, baolin.wang@linux.alibaba.com, gshan@redhat.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240913091902.1160520-1-dev.jain@arm.com>
 <ZugxqJ-CjEi5lEW_@casper.infradead.org>
 <091f517d-e7dc-4c10-b1ac-39658f31f0ed@arm.com>
Content-Language: en-GB
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <091f517d-e7dc-4c10-b1ac-39658f31f0ed@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/09/2024 04:55, Dev Jain wrote:
> 
> On 9/16/24 18:54, Matthew Wilcox wrote:
>> On Fri, Sep 13, 2024 at 02:49:02PM +0530, Dev Jain wrote:
>>> We use pte_range_none() to determine whether contiguous PTEs are empty
>>> for an mTHP allocation. Instead of iterating the while loop for every
>>> order, use some information, which is the first set PTE found, from the
>>> previous iteration, to eliminate some cases. The key to understanding
>>> the correctness of the patch is that the ranges we want to examine
>>> form a strictly decreasing sequence of nested intervals.
>> This is a lot more complicated.  Do you have any numbers that indicate
>> that it's faster?  Yes, it's fewer memory references, but you've gone
>> from a simple linear scan that's easy to prefetch to an exponential scan
>> that might confuse the prefetchers.
> 
> I do have some numbers, I tested with a simple program, and also used
> ktime API, with the latter, enclosing from "order = highest_order(orders)"
> till "pte_unmap(pte)" (enclosing the entire while loop), a rough average
> estimate is that without the patch, it takes 1700 ns to execute, with the
> patch, on an average it takes 80 - 100ns less. I cannot think of a good
> testing program...
> 
> For the prefetching thingy, I am still doing a linear scan, and in each
> iteration, with the patch, the range I am scanning is going to strictly
> lie inside the range I would have scanned without the patch. Won't the
> compiler and the CPU still do prefetching, but on a smaller range; where
> does the prefetcher get confused? I confess, I do not understand this
> very well.
> 

A little history on this; My original "RFC v2" for mTHP included this
optimization [1], but Yu Zhou suggested dropping it to keep things simple, which
I did. Then at v8, DavidH suggested we could benefit from this sort of
optimization, but we agreed to do it later as a separate change [2]:

"""
>> Comment: Likely it would make sense to scan only once and determine the
>> "largest none range" around that address, having the largest suitable order
>> in mind.
>
> Yes, that's how I used to do it, but Yu Zhou requested simplifying to this,
> IIRC. Perhaps this an optimization opportunity for later?

Yes, definetly.
"""

Dev independently discovered this opportunity while reading the code, and I
pointed him to the history, and suggested it would likely be worthwhile to send
a patch.

My view is that I don't see how this can harm performance; in the common case,
when a single order is enabled, this is essentially the same as before. But when
there are multiple orders enabled, we are now just doing a single linear scan of
the ptes rather than multiple scans. There will likely be some stack accesses
interleved, but I'd be gobsmacked if the prefetchers can't tell the difference
between the stack and other areas of memory.

Perhaps some perf numbers would help; I think the simplest way to gather some
numbers would be to create a microbenchmark to allocate a large VMA, then fault
in single pages at a given stride (say, 1 every 128K), then enable 1M, 512K,
256K, 128K and 64K mTHP, then memset the entire VMA. It's a bit contrived, but
this patch will show improvement if the scan is currently a significant portion
of the page fault.

If the proposed benchmark shows an improvement, and we don't see any regression
when only enabling 64K, then my vote would be to accept the patch.

[1] https://lore.kernel.org/linux-mm/20230414130303.2345383-7-ryan.roberts@arm.com/
[2]
https://lore.kernel.org/linux-mm/ca649aad-7b76-4c6d-b513-26b3d58f8e68@redhat.com/

Thanks,
Ryan

