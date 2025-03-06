Return-Path: <linux-kernel+bounces-548857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E63A54A2F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 409F47A3CCF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EC120AF78;
	Thu,  6 Mar 2025 11:57:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA791EE03B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741262261; cv=none; b=RxJJiHpi3LMU7Rg+L9vs6ucyFiwkX2th9uMTSyHDtTY9qYjLpfxB7hsSZtuA/S0kEmX+AsLvW5+8aI8eqHn5XauNvhziESjGvSv6rYCL4WvVnMktAgQ2zph6UOkMGHjpsQ6umAFtvMM8T6UYvVgnZCrEkO0JMnPn/CBTyCAfjXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741262261; c=relaxed/simple;
	bh=7hK0au45unlHAeUSkndZKafPwMo0WsbkAGoXC+u3dWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QXzn9rrF2zg3GzoaWG/vOtt0+IVS0zHVyIKaKH9gHUPDueL9re6E+7351+KjJn+4gA5dRk7ckvXLLzRQV/OJFLME9nP6OIy8lgZdcc/BzW8MstlSOfnfnohu/qhAbBnvPVRwN1a5BpzTcewn9JqfDZw39QI9TOm/pTioV9U1fgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 451121007;
	Thu,  6 Mar 2025 03:57:52 -0800 (PST)
Received: from [10.1.37.172] (XHFQ2J9959.cambridge.arm.com [10.1.37.172])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61B223F673;
	Thu,  6 Mar 2025 03:57:38 -0800 (PST)
Message-ID: <5f1b36e2-6455-44d9-97b0-253aefd5024f@arm.com>
Date: Thu, 6 Mar 2025 11:57:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: Create level specific section mappings in
 map_range()
Content-Language: en-GB
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
References: <20250303041834.2796751-1-anshuman.khandual@arm.com>
 <0fe6f3b2-1011-4418-bc19-612a3b98c78d@arm.com>
 <e0c2841b-3776-4d78-9514-b03ada39c739@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <e0c2841b-3776-4d78-9514-b03ada39c739@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/03/2025 03:37, Anshuman Khandual wrote:
> 
> 
> On 3/4/25 21:51, Ryan Roberts wrote:
>> On 03/03/2025 04:18, Anshuman Khandual wrote:
>>> Currently PMD section mapping mask i.e PMD_TYPE_SECT is used while creating
>>> section mapping at all page table levels except the last level. This works
>>> fine as the section mapping masks are exactly the same (0x1UL) for all page
>>> table levels.
>>>
>>> This will change in the future with D128 page tables that have unique skip
>>> level values (SKL) required for creating section mapping at different page
>>> table levels. Hence use page table level specific section mapping macros
>>> instead of the common PMD_TYPE_SECT.
>>>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>> Cc: Ard Biesheuvel <ardb@kernel.org>
>>> Cc: linux-kernel@vger.kernel.org
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>> This patch applies on 6.14-rc5
>>>
>>> PGD_TYPE_SECT for level -1 section map handling has been added for 4K
>>> base pages with 52 bit VA configuration that has 5 page table levels.
>>> In such cases (CONFIG_PGTABLE_LEVELS = 5) early_map_kernel() can call
>>> map_range() eventually with -1 (i.e 4 - CONFIG_PGTABLE_LEVELS) as the
>>> root_level.
>>
>> Table Table D8-16 on page D8-6459 of ARM DDI 0487 L.a says that block mappings
>> at level -1 are not permitted for 4K pages; only levels 0-3 support leaf
>> mappings. Similarly for 16K, table D8-26 says only levels 1-3 permit leaf
>> mappings. And for 64K, table D8-35 says only levels 1-3 permit leaf mappings.
> 
> Then seems like the current code is actually wrong because PMD_TYPE_SECT
> is being set at all levels (except level 3) regardless of the configured
> page size ?

Yes, I think so. In that case, you should mark it with Fixes: and Cc: stable.

But I feel like there might be some subtlely here that means that the problem
can't happen in practice. Ard might know?

> 
>>
>> So I don't think PGD_TYPE_SECT is the right solution. Perhaps we need to
>> explicitly force the unsupported levels to be table entries even if the
>> alignment is correct?
> 
> Just wondering - something like the following will work instead ? Tested
> on both 4K and 64K page sizes.

LGTM!

> 
> --- a/arch/arm64/kernel/pi/map_range.c
> +++ b/arch/arm64/kernel/pi/map_range.c
> @@ -26,6 +26,21 @@
>   * @va_offset:         Offset between a physical page and its current mapping
>   *                     in the VA space
>   */
> +static bool sect_supported(int level)
> +{
> +       switch(level) {
> +       case -1:
> +               return false;
> +       case 0:
> +               if(IS_ENABLED(CONFIG_ARM64_16K_PAGES) ||
> +                  IS_ENABLED(CONFIG_ARM64_64K_PAGES))
> +                       return false;
> +               fallthrough;
> +       default:
> +               return true;
> +       }
> +}
> +
>  void __init map_range(u64 *pte, u64 start, u64 end, u64 pa, pgprot_t prot,
>                       int level, pte_t *tbl, bool may_use_cont, u64 va_offset)
>  {
> @@ -44,13 +59,30 @@ void __init map_range(u64 *pte, u64 start, u64 end, u64 pa, pgprot_t prot,
>          * Set the right block/page bits for this level unless we are
>          * clearing the mapping
>          */
> -       if (protval)
> -               protval |= (level < 3) ? PMD_TYPE_SECT : PTE_TYPE_PAGE;
> +       if (protval && sect_supported(level)) {
> +               switch (level) {
> +               case 3:
> +                       protval |= PTE_TYPE_PAGE;
> +                       break;
> +               case 2:
> +                       protval |= PMD_TYPE_SECT;
> +                       break;
> +               case 1:
> +                       protval |= PUD_TYPE_SECT;
> +                       break;
> +               case 0:
> +                       protval |= P4D_TYPE_SECT;
> +                       break;
> +               default:
> +                       break;
> +               }
> +       }
>  
>         while (start < end) {
>                 u64 next = min((start | lmask) + 1, PAGE_ALIGN(end));
>  
> -               if (level < 3 && (start | next | pa) & lmask) {
> +               if ((level < 3 && (start | next | pa) & lmask) ||
> +                    !sect_supported(level)){
>                         /*
>                          * This chunk needs a finer grained mapping. Create a
>                          * table mapping if necessary and recurse.
> 
>>
>> Thanks,
>> Ryan
>>
>>>
>>>  arch/arm64/include/asm/pgtable-hwdef.h |  1 +
>>>  arch/arm64/kernel/pi/map_range.c       | 23 +++++++++++++++++++++--
>>>  2 files changed, 22 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
>>> index a9136cc551cc..fd0a82e8878c 100644
>>> --- a/arch/arm64/include/asm/pgtable-hwdef.h
>>> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
>>> @@ -99,6 +99,7 @@
>>>  #define PGD_TYPE_TABLE		(_AT(pgdval_t, 3) << 0)
>>>  #define PGD_TABLE_BIT		(_AT(pgdval_t, 1) << 1)
>>>  #define PGD_TYPE_MASK		(_AT(pgdval_t, 3) << 0)
>>> +#define PGD_TYPE_SECT		(_AT(pgdval_t, 1) << 0)
>>>  #define PGD_TABLE_AF		(_AT(pgdval_t, 1) << 10)	/* Ignored if no FEAT_HAFT */
>>>  #define PGD_TABLE_PXN		(_AT(pgdval_t, 1) << 59)
>>>  #define PGD_TABLE_UXN		(_AT(pgdval_t, 1) << 60)
>>> diff --git a/arch/arm64/kernel/pi/map_range.c b/arch/arm64/kernel/pi/map_range.c
>>> index 2b69e3beeef8..9ea869f5745f 100644
>>> --- a/arch/arm64/kernel/pi/map_range.c
>>> +++ b/arch/arm64/kernel/pi/map_range.c
>>> @@ -44,8 +44,27 @@ void __init map_range(u64 *pte, u64 start, u64 end, u64 pa, pgprot_t prot,
>>>  	 * Set the right block/page bits for this level unless we are
>>>  	 * clearing the mapping
>>>  	 */
>>> -	if (protval)
>>> -		protval |= (level < 3) ? PMD_TYPE_SECT : PTE_TYPE_PAGE;
>>> +	if (protval) {
>>> +		switch (level) {
>>> +		case 3:
>>> +			protval |= PTE_TYPE_PAGE;
>>> +			break;
>>> +		case 2:
>>> +			protval |= PMD_TYPE_SECT;
>>> +			break;
>>> +		case 1:
>>> +			protval |= PUD_TYPE_SECT;
>>> +			break;
>>> +		case 0:
>>> +			protval |= P4D_TYPE_SECT;
>>> +			break;
>>> +		case -1:
>>> +			protval |= PGD_TYPE_SECT;
>>> +			break;
>>> +		default:
>>> +			break;
>>> +		}
>>> +	}
>>>  
>>>  	while (start < end) {
>>>  		u64 next = min((start | lmask) + 1, PAGE_ALIGN(end));
>>


