Return-Path: <linux-kernel+bounces-237852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3349C923EEE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADD5F1F246D2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8931B5805;
	Tue,  2 Jul 2024 13:27:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE6715B125
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 13:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926820; cv=none; b=lBVCVlfZr38yO0kvfLsi+TpLnCJqZRpFxJ7h4XrDl+Tjl4xsHqlEVQLVJLf7pD94vDqTi9wzP8GnRcj+j92JW+cIuOcQ90TynCWcxb0d6rnWZBRHpcEqCoD0qyvEw4QPGZjiAHbsBFOC1esY23R0bgobWYhCjeCOA5exr6WCGo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926820; c=relaxed/simple;
	bh=z2cN92QRC9XP6uX0nenTg8OJrUFSHEUuRRPlK6cGwTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CWD0k5jwxUfPo1fcOER6gDbgpIhV2FACaV8LNGDksSWs3uT3EFwbl/G4EPmzwFL2TS6KymOSyoNE3zwxpzXy9PmCd5MzOH+aYblGTAw6fqc7MJJuKYIjYBNqx2+2dotTW4mxmuG9og50UrSVrxszHWb3xLCmCNQovytUrOlSqFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09A3B339;
	Tue,  2 Jul 2024 06:27:21 -0700 (PDT)
Received: from [10.1.32.193] (XHFQ2J9959.cambridge.arm.com [10.1.32.193])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87B8F3F766;
	Tue,  2 Jul 2024 06:26:54 -0700 (PDT)
Message-ID: <9a9e0a83-59a8-46ac-ae7a-8f2a65b48e1e@arm.com>
Date: Tue, 2 Jul 2024 14:26:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v5 PATCH] arm64: mm: force write fault for atomic RMW
 instructions
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Yang Shi <yang@os.amperecomputing.com>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>, will@kernel.org,
 anshuman.khandual@arm.com, scott@os.amperecomputing.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jinjiang Tu <tujinjiang@huawei.com>
References: <20240626191830.3819324-1-yang@os.amperecomputing.com>
 <Zn7q3oL1AE8jdM-g@arm.com> <773c8be7-eb73-010c-acea-1c2fefd65b84@gentwo.org>
 <Zn7xs6OYZz4dyA8a@arm.com>
 <200c5d06-c551-4847-adaf-287750e6aac4@os.amperecomputing.com>
 <ZoMG6n4hQp5XMhUN@arm.com> <3743d7e1-0b79-4eaf-82d5-d1ca29fe347d@arm.com>
 <34f2d8c6-50fa-4a8a-82a8-d417eb30ea70@redhat.com>
 <905e1319-7b20-4812-b052-8031a3c4dcf3@arm.com>
 <168f9fd4-527d-4b74-86b0-029ef474f9b6@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <168f9fd4-527d-4b74-86b0-029ef474f9b6@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 02/07/2024 13:58, David Hildenbrand wrote:
> On 02.07.24 14:36, Ryan Roberts wrote:
>> On 02/07/2024 12:22, David Hildenbrand wrote:
>>> On 02.07.24 12:26, Ryan Roberts wrote:
>>>> On 01/07/2024 20:43, Catalin Marinas wrote:
>>>>> On Fri, Jun 28, 2024 at 11:20:43AM -0700, Yang Shi wrote:
>>>>>> On 6/28/24 10:24 AM, Catalin Marinas wrote:
>>>>>>> This patch does feel a bit like working around a non-optimal user choice
>>>>>>> in kernel space. Who knows, madvise() may even be quicker if you do a
>>>>>>> single call for a larger VA vs touching each page.
>>>>>>
>>>>>> IMHO, I don't think so. I viewed this patch to solve or workaround some ISA
>>>>>> inefficiency in kernel. Two faults are not necessary if we know we are
>>>>>> definitely going to write the memory very soon, right?
>>>>>
>>>>> I agree the Arm architecture behaviour is not ideal here and any
>>>>> timelines for fixing it in hardware, if they do happen, are far into the
>>>>> future. Purely from a kernel perspective, what I want though is make
>>>>> sure that longer term (a) we don't create additional maintenance burden
>>>>> and (b) we don't keep dead code around.
>>>>>
>>>>> Point (a) could be mitigated if the architecture is changed so that any
>>>>> new atomic instructions added to this range would also come with
>>>>> additional syndrome information so that we don't have to update the
>>>>> decoding patterns.
>>>>>
>>>>> Point (b), however, depends on the OpenJDK and the kernel versions in
>>>>> distros. Nick Gasson kindly provided some information on the OpenJDK
>>>>> changes. The atomic_add(0) change happened in early 2022, about 5-6
>>>>> months after MADV_POPULATE_WRITE support was added to the kernel. What's
>>>>> interesting is Ampere already contributed MADV_POPULATE_WRITE support to
>>>>> OpenJDK a few months ago:
>>>>>
>>>>> https://github.com/openjdk/jdk/commit/a65a89522d2f24b1767e1c74f6689a22ea32ca6a
>>>>>
>>>>> The OpenJDK commit lacks explanation but what I gathered from the diff
>>>>> is that this option is the preferred one in the presence of THP (which
>>>>> most/all distros enable by default). If we merge your proposed kernel
>>>>> patch, it will take time before it makes its way into distros. I'm
>>>>> hoping that by that time, distros would have picked a new OpenJDK
>>>>> version already that doesn't need the atomic_add(0) pattern. If that's
>>>>> the case, we end up with some dead code in the kernel that's almost
>>>>> never exercised.
>>>>>
>>>>> I don't follow OpenJDK development but I heard that updates are dragging
>>>>> quite a lot. I can't tell whether people have picked up the
>>>>> atomic_add(0) feature and whether, by the time a kernel patch would make
>>>>> it into distros, they'd also move to the MADV_POPULATE_WRITE pattern.
>>>>>
>>>>> There's a point (c) as well on the overhead of reading the faulting
>>>>> instruction. I hope that's negligible but I haven't measured it.
>>>>>
>>>>
>>>> Just to add to this, I note the existing kernel behaviour is that if a write
>>>> fault happens in a region that has a (RO) huge zero page mapped at PMD level,
>>>> then the PMD is shattered, the PTE of the fault address is populated with a
>>>> writable page and the remaining PTEs are populated with order-0 zero pages
>>>> (read-only).
>>>
>>> That also recently popped up in [1]. CCing Jinjiang. Ever since I
>>> replied there, I also thought some more about that handling in regard to the
>>> huge zeropage.
>>>
>>>>
>>>> This seems like odd behaviour to me. Surely it would be less effort and more
>>>> aligned with the app's expectations to notice the huge zero page in the PMD,
>>>> remove it, and install a THP, as would have been done if pmd_none() was true? I
>>>> don't think there is a memory bloat argument here because, IIUC, with the
>>>> current behaviour, khugepaged would eventually upgrade it to a THP anyway?
>>>
>>> One detail: depending on the setting of khugepaged_max_ptes_none. zeropages
>>> are treated like pte_none. But in the common case, that setting is left alone.
>>
>> Ahh, got it. So in the common case, khugepaged won't actually collapse
>> unless/until a bunch more write faults occur in the 2M region, and in that case
>> there is a risk that changing this behaviour could lead to a memory bloat
>> regression.
>>
>>>
>>>>
>>>> Changing to this new behaviour would only be a partial solution for your use
>>>> case, since you would still have 2 faults. But it would remove the cost of the
>>>> shattering and ensure you have a THP immediately after the write fault. But I
>>>> can't think of a reason why this wouldn't be a generally useful change
>>>> regardless? Any thoughts?
>>>
>>> The "let's read before we write" as used by QEMU migration code is the desire
>>> to not waste memory by populating the zeropages. Deferring consuming memory
>>> until really required.
>>>
>>>      /*
>>>       * We read one byte of each page; this will preallocate page tables if
>>>       * required and populate the shared zeropage on MAP_PRIVATE anonymous
>>> memory
>>>       * where no page was populated yet. This might require adaption when
>>>       * supporting other mappings, like shmem.
>>>       */
>>
>> So QEMU is concerned with preallocatiing page tables? I would have thought you
>> could make that a lot more efficient with an explicit MADV_POPULATE_PGTABLE
>> call? (i.e. 1 kernel call vs 1 call per 2M, allocate all the pages in one trip
>> through the allocator, fewer pud/pmd lock/unlocks, etc).
> 
> I think we are only concerned about the "shared zeropage" part. Everything else
> is just unnecessary detail that adds confusion here :) One requires the other.

Sorry I don't quite follow your comment. As I understand it, the zeropage
concept is intended as a memory-saving mechanism for applications that read
memory but never write it. I don't think that really applies in your migration
case, because you are definitely going to write all the memory eventually, I
think? So I guess you are not interested in the "memory-saving" property, but in
the side-effect, which is the pre-allocation of pagetables? (if you just wanted
the memory-saving property, why not just skip the "read one byte of each page"
op? It's not important though, so let's not go down the rabbit hole.

> 
> Note that this is from migration code where we're supposed to write a single
> page we received from the migration source right now (not more). And we want to
> avoid allcoating memory if it can be avoided (usually for overcommit).
> 
> 
> 
>>
>> TBH I always assumed in the past the that huge zero page is only useful because
>> its a placeholder for a real THP that would be populated on write. But that's
>> obviously not the case at the moment. So other than a hack to preallocate the
>> pgtables with only 1 fault per 2M, what other benefits does it have?
> 
> I don't quite udnerstand that question. [2] has some details why the huge
> zeropage was added -- because we would have never otherwise received huge
> zeropages with THP enabled but always anon THP directly on read.
> 
>>
>>>
>>>
>>> Without THP this works as expected. With THP this currently also works as
>>> expected, but of course with the price [1] of not getting anon THP
>>> immediately, which usually we don't care about. As you note, khugepaged might
>>> fix this up later.
>>>
>>> If we disable the huge zeropage, we would get anon THPs when reading instead of
>>> small zeropages.
>>
>> I wasn't aware of that behaviour either. Although that sounds like another
>> reason why allocating a THP over the huge zero page on write fault should be the
>> "more consistent" behaviour.
> 
> Reading [2] I think the huge zeropage was added to avoid the allocation of THP
> on read. Maybe for really only large readable regions, not sure why exactly.

I might raise this on the THP call tomorrow, if Kyril joins and get his view.

> 
>>
>>>
>>> As reply to [1], I suggested using preallcoation (using MADV_POPULATE_WRITE)
>>> when we really care about that performance difference, which would also
>>> avoid the huge zeropage completely, but it's also not quite optimal in some
>>> cases.
>>
>> I could imagine some cases could benefit from a MADV_POPULATE_WRITE_ON_FAULT,
>> which would just mark the VMA so that any read fault is upgraded to write.
>>
>>>
>>>
>>> I don't really know what to do here: changing the handling for the huge zeropage
>>> only unconditionally does not sound too wrong, but the change in behavior
>>> might (or might not) be desired for some use cases.
>>>
>>> Reading from unpopulated memory can be a clear sign that really the shared
>>> zeropage
>>> is desired (as for QEMU), and concurrent memory preallcoation/population should
>>> ideally use MADV_POPULATE_WRITE. Maybe there are some details buried in [2]
>>> regarding
>>> the common use cases for the huge zeropage back than.
>>
>> The current huge zero page behavior on write fault sounds wonky to me. But I
>> agree there are better and more complete solutions to the identified use cases.
>> So unless something pops up where the change is a clear benefit, I guess better
>> to be safe and leave as is.
> 
> We've had that behavior for a quite a while ... so it's rather surprising to see
> multiple people reporting this right now.
> 
> I guess most use cases don't read from uninitialized memory barely write to it
> and care about getting THPs immediately.
> 
> For preallocation, MADVISE_POPULATE_WRITE is better. For QEMU migration? not
> sure what's really better. Maybe replacing the huge zeropage by a THP would be
> faster in some cases, but result in more memory consumption (and more page
> zeroing?) during migration in other cases.
> 


