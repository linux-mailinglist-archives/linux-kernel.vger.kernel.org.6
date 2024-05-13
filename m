Return-Path: <linux-kernel+bounces-177374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 739E78C3DB2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 11:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A9D1283797
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF301487DB;
	Mon, 13 May 2024 09:00:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85F21487D0
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715590805; cv=none; b=uu9e396POmlqd4Hz/RsjWmdippT8krUPFj1UznDcMcAKc5gRNQsPoSEQQI8AY7VkvtRNMHRe//zgmVEtSJUnhTC9PGv4z1Lgm4hrL+bEugjcYE7TUL/LlFKcKOHLQt3zFbPplV0wNS5VIzgNuUFqwuww6+bOUiEgXeW6X7GNwrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715590805; c=relaxed/simple;
	bh=/MX6rrnEoR/kypgxe6c7ubeCiw+US5Kh9gC7XtmMmzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TnANiB5JKONmkoFSQjzuwos+H9ijOZT3ZD8lr/llNx7sH1HtHHoulZP68Y8oCWr2I3KhDAhsefHrjY+pRjPEj0F0WKwlZT3ExnOKbSpxWlxBP0AhYRck0dILMTgmewaej7u4wisq/PhVvZ2dKx34gLn4WLyQ9hNSZp0fgm2Gb9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5E1B1007;
	Mon, 13 May 2024 02:00:27 -0700 (PDT)
Received: from [10.57.68.95] (unknown [10.57.68.95])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A91963F762;
	Mon, 13 May 2024 02:00:00 -0700 (PDT)
Message-ID: <7504a525-8211-48b3-becb-a6e838c1b42e@arm.com>
Date: Mon, 13 May 2024 09:59:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 0/9] Merge arm64/riscv hugetlbfs contpte support
Content-Language: en-GB
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Andrew Morton
 <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-mm@kvack.org
References: <20240508113419.18620-1-alexghiti@rivosinc.com>
 <6d37f914-d139-48ea-be63-c428ac767cc1@arm.com>
 <CAHVXubhmihZA50pdaek4=fx83ycdOyuYkRmVLPtZk59uKBoWPw@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAHVXubhmihZA50pdaek4=fx83ycdOyuYkRmVLPtZk59uKBoWPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/05/2024 18:25, Alexandre Ghiti wrote:
> Hi Ryan,
> 
> On Fri, May 10, 2024 at 3:49 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 08/05/2024 12:34, Alexandre Ghiti wrote:
>>> This patchset intends to merge the contiguous ptes hugetlbfs implementation
>>> of arm64 and riscv.
>>>
>>> Both arm64 and riscv support the use of contiguous ptes to map pages that
>>> are larger than the default page table size, respectively called contpte
>>> and svnapot.
>>>
>>> The riscv implementation differs from the arm64's in that the LSBs of the
>>> pfn of a svnapot pte are used to store the size of the mapping, allowing
>>> for future sizes to be added (for now only 64KB is supported). That's an
>>> issue for the core mm code which expects to find the *real* pfn a pte points
>>> to. Patch 1 fixes that by always returning svnapot ptes with the real pfn
>>> and restores the size of the mapping when it is written to a page table.
>>>
>>> The following patches are just merges of the 2 different implementations
>>> that currently exist in arm64 and riscv which are very similar. It paves
>>> the way to the reuse of the recent contpte THP work by Ryan [1] to avoid
>>> reimplementing the same in riscv.
>>
>> Hi Alexandre,
>>
>> I've skimmed through this series and the one that moves contpte. I can see there
>> is definitely value in sharing the implementation, and the rough shape of things
>> seems appropriate. I had some minor concerns about making it harder to implement
>> potential future arm64 errata workarounds but on reflection, most of the
>> now-shared code is really just wrapping the primitives that are still arch-specific.
>>
>> I'm going to need to spend proper time reviewing it to give detailed feedback,
>> but I'll be out on paternity leave for 3 weeks from end of Monday at the latest.
> 
> Too bad, I expected to discuss that with you at LSF/MM...But congrats!
> Hope your wife is fine :)

Thanks! Yes its unfortunate timing - there are a few topics I would have liked
to get involved with. There's always next year...

> 
>> So realistically I won't be able to do the detailed review until at least the
>> first week of June.
>>
>> Some high level thoughts:
>>
>>  - huge_ptep_* functions could be working on different sized huge ptes - arm64
>> supports contpte, pmd, contpmd and pud. Is keeping them in contpte.c
>> appropriate?
> 
> Hmm indeed, I'll see what I can do.
> 
>> Perhaps it's better to keep huge_pte and contpte separate? Also, it
>> only works on arm64 because we can get away with calling the lower-level pte
>> functions even when the huge_pte is actually a contpmd/pmd/pud, because the
>> format is the same. That might present challenges to other arches if the format
>> is different?
> 
> Yes, but I think that if that happens, we could get away with it by
> choosing the right function depending on the size of the mapping?

Yes possibly. One potential future new user of this common code would be arm32
(arch/arm), which also has the contig bit. But AIUI, the pmd an pte formats are
quite different. It's likely that arm would want to opt-in to contpte but not
huge_ptep, so separate selectors may be valuable.

> 
>>
>>  - It might be easier to review if the arm64 stuff is first moved (without
>> changes) then modified to make it suitable for riscv, then for riscv to be
>> hooked up. At the moment I'm trying to follow all 3 parts per-function.
> 
> Ok, let me give it a try during your paternity leave!

Thanks! If it's too difficult then it's not a deal-breaker. Perhaps just an
initial patch to move the existing arm functions to core-mm without change, then
all your existing patches on top of that would do the job?

> 
>>
>> Thanks,
>> Ryan
> 
> Thanks,
> 
> Alex
> 
>>
>>
>>>
>>> This patchset was tested by running the libhugetlbfs testsuite with 64KB
>>> and 2MB pages on both architectures (on a 4KB base page size arm64 kernel).
>>>
>>> [1] https://lore.kernel.org/linux-arm-kernel/20240215103205.2607016-1-ryan.roberts@arm.com/
>>>
>>> Changes in v2:
>>>   - Rebase on top of 6.9-rc3
>>>
>>> Alexandre Ghiti (9):
>>>   riscv: Restore the pfn in a NAPOT pte when manipulated by core mm code
>>>   riscv: Safely remove huge_pte_offset() when manipulating NAPOT ptes
>>>   mm: Use common huge_ptep_get() function for riscv/arm64
>>>   mm: Use common set_huge_pte_at() function for riscv/arm64
>>>   mm: Use common huge_pte_clear() function for riscv/arm64
>>>   mm: Use common huge_ptep_get_and_clear() function for riscv/arm64
>>>   mm: Use common huge_ptep_set_access_flags() function for riscv/arm64
>>>   mm: Use common huge_ptep_set_wrprotect() function for riscv/arm64
>>>   mm: Use common huge_ptep_clear_flush() function for riscv/arm64
>>>
>>>  arch/arm64/Kconfig                  |   1 +
>>>  arch/arm64/include/asm/pgtable.h    |  56 +++++-
>>>  arch/arm64/mm/hugetlbpage.c         | 291 +---------------------------
>>>  arch/riscv/Kconfig                  |   1 +
>>>  arch/riscv/include/asm/hugetlb.h    |   2 +-
>>>  arch/riscv/include/asm/pgtable-64.h |  11 ++
>>>  arch/riscv/include/asm/pgtable.h    | 153 +++++++++++++--
>>>  arch/riscv/mm/hugetlbpage.c         | 227 ----------------------
>>>  arch/riscv/mm/pgtable.c             |   6 +-
>>>  mm/Kconfig                          |   3 +
>>>  mm/Makefile                         |   1 +
>>>  mm/contpte.c                        | 272 ++++++++++++++++++++++++++
>>>  12 files changed, 480 insertions(+), 544 deletions(-)
>>>  create mode 100644 mm/contpte.c
>>>
>>


