Return-Path: <linux-kernel+bounces-422508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EC89D9A74
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FD5D163E15
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 15:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7621D63D8;
	Tue, 26 Nov 2024 15:33:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3761D5ADA
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732635188; cv=none; b=Av3NzKP8orU+a96OkvVh+CWXx+H9OiRlxRjCioUErktk3ZTH23bLMKYjZ+zawZwcsuzrFZF+uqfjv6TsYZQQ8C5eU8xuvkTdHyw579DjytXSD18fDqaOrMWrPHtQPqj3jMeKShj53rgszzgcWJ6nUXASnVkSx8BfEt4S02+Waw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732635188; c=relaxed/simple;
	bh=R79lM4HV1OWAjCFPl5G7jfaHtWzMgQCSNApuLL39ulQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=er7t6dxQCy7E9Rz6/174KhZ25kPVSrnBcFwwGPlOtcHuYUsFo40w/bUH50Rqbzi5bPLy4gK9vHTvq46wTKfihHC9sIUcB9jkeac8T/0EdzkXqW9/pLqU+Qioy2C7w7HDafErDM+3OdI0lxu7BShXqsjSUISO7HQ5CK9LcTfqv1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97E84153B;
	Tue, 26 Nov 2024 07:33:34 -0800 (PST)
Received: from [10.1.29.199] (XHFQ2J9959.cambridge.arm.com [10.1.29.199])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C4473F5A1;
	Tue, 26 Nov 2024 07:33:02 -0800 (PST)
Message-ID: <569f1417-0b5a-4360-930f-f7e8c9c6e605@arm.com>
Date: Tue, 26 Nov 2024 15:33:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm/slab: Avoid build bug for calls to kmalloc with a
 large constant
Content-Language: en-GB
To: Vlastimil Babka <vbabka@suse.cz>, Dave Kleikamp
 <dave.kleikamp@oracle.com>, Andrew Morton <akpm@linux-foundation.org>,
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-6-ryan.roberts@arm.com>
 <44312f4a-8b9c-49ce-9277-5873a94ca1bb@oracle.com>
 <cb9cabed-0038-42b3-b9fc-c9ba62b12781@suse.cz>
 <7fb6c5a2-b9ae-4a29-a871-2f0bdc636e41@arm.com>
 <9675f4f0-6290-43aa-bf17-6b9c2b461485@suse.cz>
 <69746c3a-72af-4c28-8f04-bcfae7a78107@arm.com>
 <ba2a3841-6dbc-4920-81f9-2fc0518ec1d3@suse.cz>
 <36577539-bff6-476e-8d6b-ca20e3de2391@suse.cz>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <36577539-bff6-476e-8d6b-ca20e3de2391@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/11/2024 15:27, Vlastimil Babka wrote:
> On 11/26/24 16:09, Vlastimil Babka wrote:
>> On 11/26/24 15:53, Ryan Roberts wrote:
>>> On 26/11/2024 12:36, Vlastimil Babka wrote:
>>>> On 11/26/24 13:18, Ryan Roberts wrote:
>>>>> On 14/11/2024 10:09, Vlastimil Babka wrote:
>>>>>> On 11/1/24 21:16, Dave Kleikamp wrote:
>>>>>>> When boot-time page size is enabled, the test against KMALLOC_MAX_CACHE_SIZE
>>>>>>> is no longer optimized out with a constant size, so a build bug may
>>>>>>> occur on a path that won't be reached.
>>>>>>
>>>>>> That's rather unfortunate, the __builtin_constant_p(size) part of
>>>>>> kmalloc_noprof() really expects things to resolve at compile time and it
>>>>>> would be better to keep it that way.
>>>>>>
>>>>>> I think it would be better if we based KMALLOC_MAX_CACHE_SIZE itself on
>>>>>> PAGE_SHIFT_MAX and kept it constant, instead of introducing
>>>>>> KMALLOC_SHIFT_HIGH_MAX only for some sanity checks.
>>>>>>
>>>>>> So if the kernel was built to support 4k to 64k, but booted as 4k, it would
>>>>>> still create and use kmalloc caches up to 128k. SLUB should handle that fine
>>>>>> (if not, please report it :)
>>>>>
>>>>> So when PAGE_SIZE_MAX=64K and PAGE_SIZE=4K, kmalloc will support up to 128K
>>>>> whereas before it only supported up to 8K. I was trying to avoid that since I
>>>>> assumed that would be costly in terms of extra memory allocated for those higher
>>>>> order buckets that will never be used. But I have no idea how SLUB works in
>>>>> practice. Perhaps memory for the cache is only lazily allocated so we won't see
>>>>> an issue in practice?
>>>>
>>>> Yes the e.g. 128k slabs themselves will be lazily allocated. There will be
>>>> some overhead with the management structures (struct kmem_cache etc) but
>>>> much smaller.
>>>> To be completely honest, some extra overhead might come to be when the slabs
>>>> are allocated ans later the user frees those allocations. kmalloc_large()
>>>> wwould return them immediately, while a regular kmem_cache will keep one or
>>>> more per cpu for reuse. But if that becomes a visible problem we can tune
>>>> those caches to discard slabs more aggressively.
>>>
>>> Sorry to keep pushing on this, now that I've actually looked at the code, I feel
>>> I have a slightly better understanding:
>>>
>>> void *kmalloc_noprof(size_t size, gfp_t flags)
>>> {
>>> 	if (__builtin_constant_p(size) && size) {
>>> 		
>>> 		if (size > KMALLOC_MAX_CACHE_SIZE)
>>> 			return __kmalloc_large_noprof(size, flags); <<< (1)
>>>
>>> 		index = kmalloc_index(size);
>>> 		return __kmalloc_cache_noprof(...);   <<< (2)
>>> 	}
>>> 	return __kmalloc_noprof(size, flags);   <<< (3)
>>> }
>>>
>>> So if size and KMALLOC_MAX_CACHE_SIZE are constant, we end up with this
>>> resolving either to a call to (1) or (2), decided at compile time. If
>>> KMALLOC_MAX_CACHE_SIZE is not constant, (1), (2) and the runtime conditional
>>> need to be kept in the function.
>>>
>>> But intuatively, I would have guessed that given the choice between the overhead
>>> of keeping that runtime conditional vs keeping per-cpu slab caches for extra
>>> sizes between 16K and 128K, then the runtime conditional would be preferable. I
>>> would guess that quite a bit of memory could get tied up in those caches?
>>>
>>> Why is your preference the opposite? What am I not understanding?
>>
>> +CC more slab people.
>>
>> So the above is an inline function, but constructed in a way that it should,
>> without further inline code, become
>> - a call to __kmalloc_large_noprof() for build-time constant size larger
>> than KMALLOC_MAX_CACHE_SIZE
>> - a call to __kmalloc_cache_noprof() for build-time constant size smaller
>> than KMALLOC_MAX_CACHE_SIZE, where the cache is picked from an array with
>> compile-time calculated index
>> - call to __kmalloc_noprof() for non-constant sizes otherwise
>>
>> If KMALLOC_MAX_CACHE_SIZE stops being build-time constant, the sensible way
>> to handle it would be to #ifdef or otherwise compile out away the whole "if
>> __builtin_constant_p(size)" part and just call __kmalloc_noprof() always, so
>> we don't blow the inline paths with a KMALLOC_MAX_CACHE_SIZE check leading
>> to choice between calling __kmalloc_large_noprof() or __kmalloc_cache_noprof().
> 
> Or maybe we could have PAGE_SIZE_MAX derived KMALLOC_MAX_CACHE_SIZE_MAX
> behave as the code above currently does with KMALLOC_MAX_CACHE_SIZE, and
> additionally have PAGE_SIZE_MIN derived KMALLOC_MAX_CACHE_SIZE_MIN, where
> build-time-constant size larger than KMALLOC_MAX_CACHE_SIZE_MIN (which is a
> compile-time test) is redirected to __kmalloc_noprof() for a run-time test.
> 
> That seems like the optimum solution :)

Yes; that feels like the better approach to me. I'll implement this by default
unless anyone else objects.

> 
>> I just don't believe we would waste so much memory with caches the extra
>> sizes for sizes between 16K and 128K, so would do that suggestion only if
>> proven wrong. But I wouldn't mind it that much if you chose it right away.
>> The solution earlier in this thread to patch __kmalloc_index() would be
>> worse than either of those two alternatives though.
> 
> 


