Return-Path: <linux-kernel+bounces-331485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7BD97AD66
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFA2D1F22095
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4BF16A949;
	Tue, 17 Sep 2024 08:54:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34F5168491
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 08:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726563291; cv=none; b=lRTzVgh3kjkiQnyk59DOt8pbh7MphHSoBJYu2g2RSauCtwN7ESOdfMg4TlvPx4AXKiEXoRnkOOjp+6F4SbqBOk8crikslU58Rdt/CbyJE74IZx6NxMKc99lPacpfyg6QbsFkC40i/urH+iXOm6oV22Rasn4KsW4gVe7G7p7oEYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726563291; c=relaxed/simple;
	bh=gAJE28Kqt2b+UUVotcQlngScjXETTh58EDig3Mv524E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LpX/5tvOv2vtgh2WO6pondLZ2FXPr1iESLX1HUJz5qxCYBXukYQ6IfDYhprY+wo60JOs5CstEt5Ty9ifHGlf1ipYwE8+GRGIYr2lX1Bip8eWooJbdWUCL9EUdWUKx7iyvh/UePA1+RK6kg7z7WjsKdLZk7uLCwIDmjr9QFLHx64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61199FEC;
	Tue, 17 Sep 2024 01:55:18 -0700 (PDT)
Received: from [10.57.83.157] (unknown [10.57.83.157])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45A263F64C;
	Tue, 17 Sep 2024 01:54:47 -0700 (PDT)
Message-ID: <b49a9f8d-b871-4164-98a8-fda70a789f30@arm.com>
Date: Tue, 17 Sep 2024 09:54:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Compute mTHP order efficiently
Content-Language: en-GB
To: Barry Song <baohua@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, Matthew Wilcox <willy@infradead.org>,
 akpm@linux-foundation.org, david@redhat.com, anshuman.khandual@arm.com,
 hughd@google.com, ioworker0@gmail.com, wangkefeng.wang@huawei.com,
 baolin.wang@linux.alibaba.com, gshan@redhat.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240913091902.1160520-1-dev.jain@arm.com>
 <ZugxqJ-CjEi5lEW_@casper.infradead.org>
 <091f517d-e7dc-4c10-b1ac-39658f31f0ed@arm.com>
 <bde86cb8-fe30-4747-b3a7-cc40d0850f10@arm.com>
 <CAGsJ_4ysXDAzODPkmeuaEAJnXFofxdVYvsdNcyN-xjER+rjMzQ@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4ysXDAzODPkmeuaEAJnXFofxdVYvsdNcyN-xjER+rjMzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/09/2024 09:44, Barry Song wrote:
> On Tue, Sep 17, 2024 at 4:29 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 17/09/2024 04:55, Dev Jain wrote:
>>>
>>> On 9/16/24 18:54, Matthew Wilcox wrote:
>>>> On Fri, Sep 13, 2024 at 02:49:02PM +0530, Dev Jain wrote:
>>>>> We use pte_range_none() to determine whether contiguous PTEs are empty
>>>>> for an mTHP allocation. Instead of iterating the while loop for every
>>>>> order, use some information, which is the first set PTE found, from the
>>>>> previous iteration, to eliminate some cases. The key to understanding
>>>>> the correctness of the patch is that the ranges we want to examine
>>>>> form a strictly decreasing sequence of nested intervals.
>>>> This is a lot more complicated.  Do you have any numbers that indicate
>>>> that it's faster?  Yes, it's fewer memory references, but you've gone
>>>> from a simple linear scan that's easy to prefetch to an exponential scan
>>>> that might confuse the prefetchers.
>>>
>>> I do have some numbers, I tested with a simple program, and also used
>>> ktime API, with the latter, enclosing from "order = highest_order(orders)"
>>> till "pte_unmap(pte)" (enclosing the entire while loop), a rough average
>>> estimate is that without the patch, it takes 1700 ns to execute, with the
>>> patch, on an average it takes 80 - 100ns less. I cannot think of a good
>>> testing program...
>>>
>>> For the prefetching thingy, I am still doing a linear scan, and in each
>>> iteration, with the patch, the range I am scanning is going to strictly
>>> lie inside the range I would have scanned without the patch. Won't the
>>> compiler and the CPU still do prefetching, but on a smaller range; where
>>> does the prefetcher get confused? I confess, I do not understand this
>>> very well.
>>>
>>
>> A little history on this; My original "RFC v2" for mTHP included this
>> optimization [1], but Yu Zhou suggested dropping it to keep things simple, which
>> I did. Then at v8, DavidH suggested we could benefit from this sort of
>> optimization, but we agreed to do it later as a separate change [2]:
>>
>> """
>>>> Comment: Likely it would make sense to scan only once and determine the
>>>> "largest none range" around that address, having the largest suitable order
>>>> in mind.
>>>
>>> Yes, that's how I used to do it, but Yu Zhou requested simplifying to this,
>>> IIRC. Perhaps this an optimization opportunity for later?
>>
>> Yes, definetly.
>> """
>>
>> Dev independently discovered this opportunity while reading the code, and I
>> pointed him to the history, and suggested it would likely be worthwhile to send
>> a patch.
>>
>> My view is that I don't see how this can harm performance; in the common case,
>> when a single order is enabled, this is essentially the same as before. But when
>> there are multiple orders enabled, we are now just doing a single linear scan of
>> the ptes rather than multiple scans. There will likely be some stack accesses
>> interleved, but I'd be gobsmacked if the prefetchers can't tell the difference
>> between the stack and other areas of memory.
>>
>> Perhaps some perf numbers would help; I think the simplest way to gather some
>> numbers would be to create a microbenchmark to allocate a large VMA, then fault
>> in single pages at a given stride (say, 1 every 128K), then enable 1M, 512K,
>> 256K, 128K and 64K mTHP, then memset the entire VMA. It's a bit contrived, but
>> this patch will show improvement if the scan is currently a significant portion
>> of the page fault.
>>
>> If the proposed benchmark shows an improvement, and we don't see any regression
>> when only enabling 64K, then my vote would be to accept the patch.
> 
> Agreed. The challenge now is how to benchmark this. In a system
> without fragmentation,
> we consistently succeed in allocating the largest size (1MB).
> Therefore, we need an
> environment where allocations of various sizes can fail proportionally, allowing
> pte_range_none() to fail on larger sizes but succeed on smaller ones.

I don't think this is about allocation failure? It's about finding a folio order
that fits into the VMA without overlapping any already non-none PTEs.

> 
> It seems we can't micro-benchmark this with a small program.

My proposal was to deliberately fault in a single (4K) page every 128K. That
will cause the scanning logic to reduce the order to the next lowest enabled
order and try again. So with the current code, for all orders {1M, 512K, 256K,
128K} you would scan the first 128K of ptes (32 entries) then for 64K you would
scan 16 entries = 4 * 32 + 16 = 144 entries. For the new change, you would just
scan 32 entries.

Although now that I've actually written that down, it doesn't feel like a very
big win. Perhaps Dev can come up with an even more contrived single-page
pre-allocation pattern that will maximise the number of PTEs we hit with the
current code, and minimise it with the new code :)

> 
>>
>> [1] https://lore.kernel.org/linux-mm/20230414130303.2345383-7-ryan.roberts@arm.com/
>> [2]
>> https://lore.kernel.org/linux-mm/ca649aad-7b76-4c6d-b513-26b3d58f8e68@redhat.com/
>>
>> Thanks,
>> Ryan


