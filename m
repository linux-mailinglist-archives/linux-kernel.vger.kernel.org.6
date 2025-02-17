Return-Path: <linux-kernel+bounces-517287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F0EA37EDB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34D631886F28
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAC8215F5B;
	Mon, 17 Feb 2025 09:41:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7432B2153C7
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 09:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739785261; cv=none; b=KibhQH+NRRYcBGRDiBckDo5J8USwNJFnxNEpFZgMtIFAr6dkcvQZqkvCCYT5/yBV9NT7yVYgkTUL4DvUdtdVx3tW0kTyTob+lex6MZVnsg0ArIXTApJA0bl30Guk7p+K77qn7XWP6Zk5BnbFMdF8CzfDeG01VxJZL+maMCrnQLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739785261; c=relaxed/simple;
	bh=TkscNV7R9SN6TrFtqtWjGgMqoeohLYFd5zmGSrMHQnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kBIIQk9EsmpfNxMhsELsJbVDgeLWMwQabpoCkx0fQ/spOftcsXqBW3AzCp764yB3zo4ujD8uIis7m6+MclLWyELheiEJI9E/q8KuZ/Ieb6R5Ub4Z5oqIvGeLudjxCRj8IZl6d8lybjKf6TWF4xsIt65tn0V3maI/5ITEseozT7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAC5C152B;
	Mon, 17 Feb 2025 01:41:16 -0800 (PST)
Received: from [10.1.38.151] (XHFQ2J9959.cambridge.arm.com [10.1.38.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C0823F6A8;
	Mon, 17 Feb 2025 01:40:54 -0800 (PST)
Message-ID: <9c7929f4-d024-4919-9b38-8cae05cc6fcf@arm.com>
Date: Mon, 17 Feb 2025 09:40:53 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 16/16] arm64/mm: Defer barriers when updating kernel
 mappings
Content-Language: en-GB
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Muchun Song <muchun.song@linux.dev>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Dev Jain <dev.jain@arm.com>, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Steve Capper <steve.capper@linaro.org>, Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250205151003.88959-1-ryan.roberts@arm.com>
 <20250205151003.88959-17-ryan.roberts@arm.com>
 <9bc5527e-16f4-45cc-aced-55b1ace6c143@arm.com>
 <a5d66063-c3a0-46fc-ab88-21ae2448c9f0@arm.com>
 <0052097e-2284-4f9e-b37c-2ca2de527667@arm.com>
 <43d852bb-ab5f-40be-b188-166c57ab795c@arm.com>
 <77dfb8ae-2a57-4d76-a3d2-8a486dd9721b@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <77dfb8ae-2a57-4d76-a3d2-8a486dd9721b@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/02/2025 04:48, Anshuman Khandual wrote:
> 
> 
> On 2/13/25 15:08, Ryan Roberts wrote:
>> On 13/02/2025 05:30, Anshuman Khandual wrote:
>>>
>>>
>>> On 2/10/25 16:42, Ryan Roberts wrote:
>>>> On 10/02/2025 08:03, Anshuman Khandual wrote:
>>>>>
>>>>>
>>>>> On 2/5/25 20:39, Ryan Roberts wrote:
>>>>>> Because the kernel can't tolerate page faults for kernel mappings, when
>>>>>> setting a valid, kernel space pte (or pmd/pud/p4d/pgd), it emits a
>>>>>> dsb(ishst) to ensure that the store to the pgtable is observed by the
>>>>>> table walker immediately. Additionally it emits an isb() to ensure that
>>>>>> any already speculatively determined invalid mapping fault gets
>>>>>> canceled.> 
>>>>>> We can improve the performance of vmalloc operations by batching these
>>>>>> barriers until the end of a set up entry updates. The newly added
>>>>>> arch_update_kernel_mappings_begin() / arch_update_kernel_mappings_end()
>>>>>> provide the required hooks.
>>>>>>
>>>>>> vmalloc improves by up to 30% as a result.
>>>>>>
>>>>>> Two new TIF_ flags are created; TIF_KMAP_UPDATE_ACTIVE tells us if we
>>>>>> are in the batch mode and can therefore defer any barriers until the end
>>>>>> of the batch. TIF_KMAP_UPDATE_PENDING tells us if barriers are queued to
>>>>>> be emited at the end of the batch.
>>>>>
>>>>> Why cannot this be achieved with a single TIF_KMAP_UPDATE_ACTIVE which is
>>>>> set in __begin(), cleared in __end() and saved across a __switch_to().
>>>>
>>>> So unconditionally emit the barriers in _end(), and emit them in __switch_to()
>>>> if TIF_KMAP_UPDATE_ACTIVE is set?
>>>
>>> Right.
>>>
>>>>
>>>> I guess if calling _begin() then you are definitely going to be setting at least
>>>> 1 PTE. So you can definitely emit the barriers unconditionally. I was trying to
>>>> protect against the case where you get pre-empted (potentially multiple times)
>>>> while in the loop. The TIF_KMAP_UPDATE_PENDING flag ensures you only emit the
>>>> barriers when you definitely need to. Without it, you would have to emit on
>>>> every pre-emption even if no more PTEs got set.
>>>>
>>>> But I suspect this is a premature optimization. Probably it will never occur. So
>>>
>>> Agreed.
>>
>> Having done this simplification, I've just noticed that one of the
>> arch_update_kernel_mappings_begin/end callsites is __apply_to_page_range() which
>> gets called for user space mappings as well as kernel mappings. So actually with
>> the simplification I'll be emitting barriers even when only user space mappings
>> were touched.
> 
> Right, that will not be desirable.
> 
>>
>> I think there are a couple of options to fix this:
>>
>> - Revert to the 2 flag approach. For the user space case, I'll get to _end() and
>> notice that no barriers are queued so will emit nothing.
>>
>> - Only set TIF_KMAP_UPDATE_ACTIVE if the address range passed to _begin() is a
>> kernel address range. I guess that's just a case of checking if the MSB is set
>> in "end"?
>>
>> - pass mm to _begin() and only set TIF_KMAP_UPDATE_ACTIVE if mm == &init_mm. I
>> guess this should be the same as option 2.
>>
>> I'm leaning towards option 2. But I have a niggling feeling that my proposed
>> check isn't quite correct. What do you think?
> 
> Option 2 and 3 looks better than the two flags approach proposed earlier. But is
> not option 3 bit more simplistic than option 2 ? Does getting struct mm argument
> into these function create more code churn ?

Actually looking at this again, I think the best thing is that when called in
the context of __apply_to_page_range(), we will only call
arch_update_kernel_mappings_[begin|end]() if mm == &init_mm. The function is
explicitly for "kernel mappings" so it doesn't make sense to call it for user
mappings.

Looking at the current implementations of arch_sync_kernel_mappings() they are
filtering on kernel addresses anyway, so this should be safe.

Thanks,
Ryan



