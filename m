Return-Path: <linux-kernel+bounces-263178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAE793D23B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB32B1F21BA2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA1A17A592;
	Fri, 26 Jul 2024 11:27:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5E31B27D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721993227; cv=none; b=iMnkXglOFCB9oSi3+u4pLv9hJ+ehCcJiLYHCkwk05dE0L5esyGjM+HYB7UJCYRN8k6icjQiZHlyRoL6eZxnDWKlbvCdW/ax7olBJ0ONDPcRTBXKE72W9xuf2bWB5pNnKCVg9Q1wthvCw/Gs6g0YtRQlnDdYwRdzWDCmAmp77wUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721993227; c=relaxed/simple;
	bh=7+ZTBC7miCo03yI/XdYHmHRrzH1zUYPuleKcJK5IlqQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rLJbhLbdFBu7P70zUyWH4l2ISnn5UapeThifeMiUD4yjrVnmQHYqqGvpl7NCMYtqoOXTW3rA0FzAbJ0AM3H6y1aFdkHHdWGwOT+hO3C+m/cQ2LmtlWqvE8NmLlGk/z5s4FtvPVaop4sMdXfKxP+6PAiIwTxkcfjuQfx9u3i4Z4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 066801007;
	Fri, 26 Jul 2024 04:27:30 -0700 (PDT)
Received: from [10.163.53.239] (unknown [10.163.53.239])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A562A3F73F;
	Fri, 26 Jul 2024 04:27:02 -0700 (PDT)
Message-ID: <f1f41e1e-d9f9-4a3f-8ada-8d4b612996f3@arm.com>
Date: Fri, 26 Jul 2024 16:56:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH] arm64/mm: Avoid direct referencing page table enties in
 map_range()
To: Ryan Roberts <ryan.roberts@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20240725091052.314750-1-anshuman.khandual@arm.com>
 <3e82687a-0183-42f3-b32c-6d99dbd4fe49@arm.com>
Content-Language: en-US
In-Reply-To: <3e82687a-0183-42f3-b32c-6d99dbd4fe49@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 7/25/24 16:06, Ryan Roberts wrote:
> On 25/07/2024 10:10, Anshuman Khandual wrote:
>> Like else where in arm64 platform, use WRITE_ONCE() in map_range() while
>> creating page table entries. This avoids referencing page table entries
>> directly.
> 
> I could be wrong, but I don't think this code is ever operating on live

map_range() is called on these page tables but sequentially during boot.

primary_entry()
	create_init_idmap()
		map_range(...init_idmap_pg_dir...)

primary_switch()
	early_map_kernel()
		map_fdt()
			map_range(...init_idmap_pg_dir...)

		remap_idmap_for_lpa2()
			create_init_idmap()
				map_range(...init_pg_dir...)
			create_init_idmap()
				map_range(...init_idmap_pg_dir...)

		map_kernel()
			map_segment()
				map_range(...init_pg_dir...)
paging_init()
	create_idmap()
		__pi_map_range(...idmap_pg_dir...)


> pgtables? So there is never a potential to race with the HW walker and therefore
> no need to guarrantee copy atomicity? As long as the correct barriers are placed

Unless there is possibility of concurrent HW walk through these page
tables, WRITE_ONCE() based atomic is not required here ?

I thought arm64 platform decided some time earlier (but don't remember
when) to use READ_ONCE()-WRITE_ONCE() for all page table entry, direct
references for read or write accesses - possibly for some increased
safety ?

> at the point where you load the pgdir into the TTBRx there should be no problem?

Those barriers are already placed as required.

> 
> If my assertion is correct, I don't think there is any need for this change.
> 
> Thanks,
> Ryan
> 
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/kernel/pi/map_range.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/pi/map_range.c b/arch/arm64/kernel/pi/map_range.c
>> index 5410b2cac590..b93b70cdfb62 100644
>> --- a/arch/arm64/kernel/pi/map_range.c
>> +++ b/arch/arm64/kernel/pi/map_range.c
>> @@ -56,8 +56,8 @@ void __init map_range(u64 *pte, u64 start, u64 end, u64 pa, pgprot_t prot,
>>  			 * table mapping if necessary and recurse.
>>  			 */
>>  			if (pte_none(*tbl)) {
>> -				*tbl = __pte(__phys_to_pte_val(*pte) |
>> -					     PMD_TYPE_TABLE | PMD_TABLE_UXN);
>> +				WRITE_ONCE(*tbl, __pte(__phys_to_pte_val(*pte) |
>> +					   PMD_TYPE_TABLE | PMD_TABLE_UXN));
>>  				*pte += PTRS_PER_PTE * sizeof(pte_t);
>>  			}
>>  			map_range(pte, start, next, pa, prot, level + 1,
>> @@ -79,7 +79,7 @@ void __init map_range(u64 *pte, u64 start, u64 end, u64 pa, pgprot_t prot,
>>  				protval &= ~PTE_CONT;
>>  
>>  			/* Put down a block or page mapping */
>> -			*tbl = __pte(__phys_to_pte_val(pa) | protval);
>> +			WRITE_ONCE(*tbl, __pte(__phys_to_pte_val(pa) | protval));
>>  		}
>>  		pa += next - start;
>>  		start = next;
> 

