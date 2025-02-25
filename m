Return-Path: <linux-kernel+bounces-531920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E03A44691
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9BD189ED12
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8370119CC39;
	Tue, 25 Feb 2025 16:41:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81F619CC36
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501676; cv=none; b=ZVSnk9RhswjkRcEBk9XFfjLnKpQzmhJv26w9oyG576xe0LFK43IAjYtohDHd0+czD/U+xYj6t043830aC3b2w40IKCEPqD0eieEFP35UhqPWI5oaQxxXHW5D1tTua410pNuVVe564lsCIjoPIMw1iUaAt9ykWh1pAiH9WK5zBxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501676; c=relaxed/simple;
	bh=3Zev8Gv6kDDTK1jXqktFq2F/c8kVG8AGGKHx5YaEY6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SPnFkmvoF6kROKkZXdHq8zui45Qa4TH1cjVE/Ifwfu7aAhfGeyyED9Uthnd8MZJbb1pxahAf1bj2xD4D1yak7YXO7xIOunTZiN+7bQNHluvv9pPVhqGUWUK4sDrI1k9y7d5kDN15MPcU1P1dmcSqSGypOON52jOOEvr5WKlRfxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70A6628C7;
	Tue, 25 Feb 2025 08:41:29 -0800 (PST)
Received: from [10.1.27.154] (XHFQ2J9959.cambridge.arm.com [10.1.27.154])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B0BE3F6A8;
	Tue, 25 Feb 2025 08:41:10 -0800 (PST)
Message-ID: <baa34c09-48a1-4835-842b-4612e3f632f8@arm.com>
Date: Tue, 25 Feb 2025 16:41:09 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] arm64/mm: Avoid barriers for invalid or
 userspace mappings
Content-Language: en-GB
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 David Hildenbrand <david@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250217140809.1702789-1-ryan.roberts@arm.com>
 <20250217140809.1702789-8-ryan.roberts@arm.com> <Z7nOe78W4JXFAkMb@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <Z7nOe78W4JXFAkMb@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/02/2025 13:17, Catalin Marinas wrote:
> On Mon, Feb 17, 2025 at 02:07:59PM +0000, Ryan Roberts wrote:
>> __set_pte_complete(), set_pmd(), set_pud(), set_p4d() and set_pgd() are
>> used to write entries into pgtables. And they issue barriers (currently
>> dsb and isb) to ensure that the written values are observed by the table
>> walker prior to any program-order-future memory access to the mapped
>> location.
>>
>> Over the years some of these functions have received optimizations: In
>> particular, commit 7f0b1bf04511 ("arm64: Fix barriers used for page
>> table modifications") made it so that the barriers were only emitted for
>> valid-kernel mappings for set_pte() (now __set_pte_complete()). And
>> commit 0795edaf3f1f ("arm64: pgtable: Implement p[mu]d_valid() and check
>> in set_p[mu]d()") made it so that set_pmd()/set_pud() only emitted the
>> barriers for valid mappings.
> 
> The assumption probably was that set_pmd/pud() are called a lot less
> often than set_pte() as they cover larger address ranges (whether table
> or leaf).

Yes you're probably right. From an optimization perspective I doubt we are
seeing much improvement from the reduction in barriers for pmd/pud/p4d/pgd
levels. I made the change more for the benefit of uniformity.

> 
>> set_p4d()/set_pgd() continue to emit the barriers unconditionally.
> 
> We probably missed them, should have been the same as set_pmd().

So perhaps the middle ground is for pmd/pud/p4d/pgd to all have the same
implementation (emit barriers for valid mappings only). And then let pte level
continue with the additional optimization of only emitting barriers for valid
*kernel* mappings.

The only problem there is that it gets confusing when you bring set_pmd_at() and
set_pud_at() into the picture, which today end up calling __set_pte(). So
pmds/puds set by that route *already* has the same optimizations applied as ptes
today.

Personally, I'd prefer to have a single pattern for all levels.

> 
>> This is all very confusing to the casual observer; surely the rules
>> should be invariant to the level? Let's change this so that every level
>> consistently emits the barriers only when setting valid, non-user
>> entries (both table and leaf).
> 
> Also see commit d0b7a302d58a ("Revert "arm64: Remove unnecessary ISBs
> from set_{pte,pmd,pud}"") why we added back the ISBs to the pmd/pud
> accessors and the last paragraph on why we are ok with the spurious
> faults for PTEs.

Yes, I was already aware of that behaviour (thanks to MarkR for patiently
explaining it to me!). But my changes should still be compatible with that
requirement; we always issue an ISB after updating the page table with a valid,
kernel mapping.

As an aside, my understanding is that if the system supports FEAT_ETS2, then the
CPU promises not to store that "faulting" state in the pipeline, and the ISB
should not be needed; we could patch that out in future with an alternative.

> 
> For user mappings, the translation fault is routed through the usual
> path that can handle mapping new entries, so I think we are fine. But
> it's worth double-checking Will's comment (unless he only referred to
> kernel table entries).
> 
>> It seems obvious that if it is ok to elide barriers all but valid kernel
>> mappings at pte level, it must also be ok to do this for leaf entries at
>> other levels: If setting an entry to invalid, a tlb maintenance
>> operation must surely follow to synchronise the TLB and this contains
>> the required barriers.
> 
> Setting to invalid is fine indeed, handled by the TLB flushing code,
> hence the pmd_valid() checks.
> 
>> If setting a valid user mapping, the previous
>> mapping must have been invalid and there must have been a TLB
>> maintenance operation (complete with barriers) to honour
>> break-before-make.
> 
> That's not entirely true for change_protection() for example or the
> fork() path when we make the entries read-only from writeable without

For fork() we use ptep_set_wrprotect() (or these days, wrprotect_ptes(), right?)

> BBM. We could improve these cases as well, I haven't looked in detail.
> ptep_modify_prot_commit() via change_pte_range() can defer the barriers
> to tlb_end_vma(). Something similar on the copy_present_ptes() path.

But yes, I agree my comments are not fully correct for all corner cases. But the
point is that for all of these corner cases, the higher level causes appropriate
TLBI operations to be issued, which include the appropriate barriers.

> 
>> So the worst that can happen is we take an extra
>> fault (which will imply the DSB + ISB) and conclude that there is
>> nothing to do. These are the arguments for doing this optimization at
>> pte level and they also apply to leaf mappings at other levels.
> 
> It's worth clarifying Will's comment in the commit I mentioned above.

By my interpretation of Will's comment, it agrees with what I'm trying to say
here. Perhaps I've missed something?

> 
>> For table entries, the same arguments hold: If unsetting a table entry,
>> a TLB is required and this will emit the required barriers. If setting a
>> table entry, the previous value must have been invalid and the table
>> walker must already be able to observe that. Additionally the contents
>> of the pgtable being pointed to in the newly set entry must be visible
>> before the entry is written and this is enforced via smp_wmb() (dmb) in
>> the pgtable allocation functions and in __split_huge_pmd_locked(). But
>> this last part could never have been enforced by the barriers in
>> set_pXd() because they occur after updating the entry. So ultimately,
>> the wost that can happen by eliding these barriers for user table
>> entries is an extra fault.
>>
>> I observe roughly the same number of page faults (107M) with and without
>> this change when compiling the kernel on Apple M2.
> 
> That's microarch specific, highly dependent on timing, so you may never
> see a difference.

Fair. Are you advocating for keeping the higher levels not conditional on user
vs kernel? If so, then my preference would be to at least simplfy to 2 patterns
as I describe above.

> 
>> +static inline bool pmd_valid_not_user(pmd_t pmd)
>> +{
>> +	/*
>> +	 * User-space table entries always have (PXN && !UXN). All other
>> +	 * combinations indicate it's a table entry for kernel space.
>> +	 * Valid-not-user leaf entries follow the same rules as
>> +	 * pte_valid_not_user().
>> +	 */
>> +	if (pmd_table(pmd))
>> +		return !((pmd_val(pmd) & (PMD_TABLE_PXN | PMD_TABLE_UXN)) == PMD_TABLE_PXN);
>> +	return pte_valid_not_user(pmd_pte(pmd));
>> +}
> 
> With the 128-bit format I think we lost the PXN/UXNTable bits, though we
> have software bits if we need to. 

Indeed. I've already fed back to Anshuman that in my opinion, those bits need to
be maintained as SW bits. Otherwise it all gets a bit fragile if a SW agent
tries to check the value of those bits in D128 mode vs D64 mode.

> I just wonder whether it's worth the
> hassle of skipping some barriers for user non-leaf entries. Did you see
> any improvement in practice?

As I said, I doubt there is much of a performance improvement in practice, my
main motivation was unifying around a single pattern to simplify.

Thanks,
Ryan



