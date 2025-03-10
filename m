Return-Path: <linux-kernel+bounces-553967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9E0A59141
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D47AF7A3702
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEED225779;
	Mon, 10 Mar 2025 10:33:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07EF1917ED
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741602801; cv=none; b=R0debnnYy1OxB3PuC/0tP0yI6ek7DxxrMQ7IgyfbpQj2hiHpb51vU/npMgogeYF0ZoRfjX5+3DbcTMvtn4Nr7y86cYb6G6YUFxw1Dm7PWpgghW9ncKA1ANWUXpwbHnIsGhbMoL24PfeJuUw20SLEmqH8wJV5yRoldr5ciK/+5oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741602801; c=relaxed/simple;
	bh=mwO++BYcmb/WpfEcWAJLR6xrtEX3mW/pCa4e/P9fi1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qzUEMrFEMqKwYiQObbMau+E0tWWkmpH8cr5Kk/4Jtz3Htgp1S9zdrosg4UNb03n2+GUh/sf72SXASf54ppjH0HszpCTR3Bw3d1Ypxuy3Njl5XGaUfLuycnSlH4mZaSIxOJfOY8mLNa55Hk51u9VE9G9NbbVYifvaA/cwV7zLSjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88F4E153B;
	Mon, 10 Mar 2025 03:33:29 -0700 (PDT)
Received: from [10.163.42.69] (unknown [10.163.42.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F0DB3F673;
	Mon, 10 Mar 2025 03:33:13 -0700 (PDT)
Message-ID: <68188aa1-8f80-4f91-beb5-9ddb0129a490@arm.com>
Date: Mon, 10 Mar 2025 16:03:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] arm64/mm: Define PTDESC_ORDER
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
References: <20250310040115.91298-1-anshuman.khandual@arm.com>
 <Z86-34-fgk7iskX_@J2N7QTR9R3.cambridge.arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Z86-34-fgk7iskX_@J2N7QTR9R3.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/10/25 15:58, Mark Rutland wrote:
> On Mon, Mar 10, 2025 at 09:31:15AM +0530, Anshuman Khandual wrote:
>> diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
>> index fd5a08450b12..78c7e03a0e35 100644
>> --- a/arch/arm64/include/asm/kernel-pgtable.h
>> +++ b/arch/arm64/include/asm/kernel-pgtable.h
>> @@ -45,11 +45,14 @@
>>  #define SPAN_NR_ENTRIES(vstart, vend, shift) \
>>  	((((vend) - 1) >> (shift)) - ((vstart) >> (shift)) + 1)
>>  
>> -#define EARLY_ENTRIES(vstart, vend, shift, add) \
>> -	(SPAN_NR_ENTRIES(vstart, vend, shift) + (add))
>> +/* Number of VA bits resolved by a single translation table level */
>> +#define PTDESC_TABLE_SHIFT	(PAGE_SHIFT - PTDESC_ORDER)
> 
> To be clear, when I suggested adding PTDESC_TABLE_SHIFT, I expected that
> it would be used consistently in place of (PAGE_SHIFT - PTDESC_ORDER),
> and not only replacing that within the EARLY_ENTRIES() macro
> specifically.

I had that dilemma as well but alright, will respin this once more.

> 
> Mark.
> 
>> -#define EARLY_LEVEL(lvl, lvls, vstart, vend, add)	\
>> -	(lvls > lvl ? EARLY_ENTRIES(vstart, vend, SWAPPER_BLOCK_SHIFT + lvl * (PAGE_SHIFT - 3), add) : 0)
>> +#define EARLY_ENTRIES(lvl, vstart, vend) \
>> +	SPAN_NR_ENTRIES(vstart, vend, SWAPPER_BLOCK_SHIFT + lvl * PTDESC_TABLE_SHIFT)
>> +
>> +#define EARLY_LEVEL(lvl, lvls, vstart, vend, add) \
>> +	((lvls) > (lvl) ? EARLY_ENTRIES(lvl, vstart, vend) + (add) : 0)
>>  
>>  #define EARLY_PAGES(lvls, vstart, vend, add) (1 	/* PGDIR page */				\
>>  	+ EARLY_LEVEL(3, (lvls), (vstart), (vend), add) /* each entry needs a next level page table */	\
>> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
>> index a9136cc551cc..3c544edc3968 100644
>> --- a/arch/arm64/include/asm/pgtable-hwdef.h
>> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
>> @@ -7,40 +7,43 @@
>>  
>>  #include <asm/memory.h>
>>  
>> +#define PTDESC_ORDER 3
>> +
>>  /*
>>   * Number of page-table levels required to address 'va_bits' wide
>>   * address, without section mapping. We resolve the top (va_bits - PAGE_SHIFT)
>> - * bits with (PAGE_SHIFT - 3) bits at each page table level. Hence:
>> + * bits with (PAGE_SHIFT - PTDESC_ORDER) bits at each page table level. Hence:
>>   *
>> - *  levels = DIV_ROUND_UP((va_bits - PAGE_SHIFT), (PAGE_SHIFT - 3))
>> + *  levels = DIV_ROUND_UP((va_bits - PAGE_SHIFT), (PAGE_SHIFT - PTDESC_ORDER))
>>   *
>>   * where DIV_ROUND_UP(n, d) => (((n) + (d) - 1) / (d))
>>   *
>>   * We cannot include linux/kernel.h which defines DIV_ROUND_UP here
>>   * due to build issues. So we open code DIV_ROUND_UP here:
>>   *
>> - *	((((va_bits) - PAGE_SHIFT) + (PAGE_SHIFT - 3) - 1) / (PAGE_SHIFT - 3))
>> + *	((((va_bits) - PAGE_SHIFT) + (PAGE_SHIFT - PTDESC_ORDER) - 1) / (PAGE_SHIFT - PTDESC_ORDER))
>>   *
>>   * which gets simplified as :
>>   */
>> -#define ARM64_HW_PGTABLE_LEVELS(va_bits) (((va_bits) - 4) / (PAGE_SHIFT - 3))
>> +#define ARM64_HW_PGTABLE_LEVELS(va_bits) \
>> +	(((va_bits) - PTDESC_ORDER - 1) / (PAGE_SHIFT - PTDESC_ORDER))
>>  
>>  /*
>>   * Size mapped by an entry at level n ( -1 <= n <= 3)
>> - * We map (PAGE_SHIFT - 3) at all translation levels and PAGE_SHIFT bits
>> + * We map (PAGE_SHIFT - PTDESC_ORDER) at all translation levels and PAGE_SHIFT bits
>>   * in the final page. The maximum number of translation levels supported by
>>   * the architecture is 5. Hence, starting at level n, we have further
>>   * ((4 - n) - 1) levels of translation excluding the offset within the page.
>>   * So, the total number of bits mapped by an entry at level n is :
>>   *
>> - *  ((4 - n) - 1) * (PAGE_SHIFT - 3) + PAGE_SHIFT
>> + *  ((4 - n) - 1) * (PAGE_SHIFT - PTDESC_ORDER) + PAGE_SHIFT
>>   *
>>   * Rearranging it a bit we get :
>> - *   (4 - n) * (PAGE_SHIFT - 3) + 3
>> + *   (4 - n) * (PAGE_SHIFT - PTDESC_ORDER) + PTDESC_ORDER
>>   */
>> -#define ARM64_HW_PGTABLE_LEVEL_SHIFT(n)	((PAGE_SHIFT - 3) * (4 - (n)) + 3)
>> +#define ARM64_HW_PGTABLE_LEVEL_SHIFT(n)	((PAGE_SHIFT - PTDESC_ORDER) * (4 - (n)) + PTDESC_ORDER)
>>  
>> -#define PTRS_PER_PTE		(1 << (PAGE_SHIFT - 3))
>> +#define PTRS_PER_PTE		(1 << (PAGE_SHIFT - PTDESC_ORDER))
>>  
>>  /*
>>   * PMD_SHIFT determines the size a level 2 page table entry can map.
>> @@ -49,7 +52,7 @@
>>  #define PMD_SHIFT		ARM64_HW_PGTABLE_LEVEL_SHIFT(2)
>>  #define PMD_SIZE		(_AC(1, UL) << PMD_SHIFT)
>>  #define PMD_MASK		(~(PMD_SIZE-1))
>> -#define PTRS_PER_PMD		(1 << (PAGE_SHIFT - 3))
>> +#define PTRS_PER_PMD		(1 << (PAGE_SHIFT - PTDESC_ORDER))
>>  #endif
>>  
>>  /*
>> @@ -59,14 +62,14 @@
>>  #define PUD_SHIFT		ARM64_HW_PGTABLE_LEVEL_SHIFT(1)
>>  #define PUD_SIZE		(_AC(1, UL) << PUD_SHIFT)
>>  #define PUD_MASK		(~(PUD_SIZE-1))
>> -#define PTRS_PER_PUD		(1 << (PAGE_SHIFT - 3))
>> +#define PTRS_PER_PUD		(1 << (PAGE_SHIFT - PTDESC_ORDER))
>>  #endif
>>  
>>  #if CONFIG_PGTABLE_LEVELS > 4
>>  #define P4D_SHIFT		ARM64_HW_PGTABLE_LEVEL_SHIFT(0)
>>  #define P4D_SIZE		(_AC(1, UL) << P4D_SHIFT)
>>  #define P4D_MASK		(~(P4D_SIZE-1))
>> -#define PTRS_PER_P4D		(1 << (PAGE_SHIFT - 3))
>> +#define PTRS_PER_P4D		(1 << (PAGE_SHIFT - PTDESC_ORDER))
>>  #endif
>>  
>>  /*
>> diff --git a/arch/arm64/kernel/pi/map_range.c b/arch/arm64/kernel/pi/map_range.c
>> index 2b69e3beeef8..f74335e13929 100644
>> --- a/arch/arm64/kernel/pi/map_range.c
>> +++ b/arch/arm64/kernel/pi/map_range.c
>> @@ -31,7 +31,7 @@ void __init map_range(u64 *pte, u64 start, u64 end, u64 pa, pgprot_t prot,
>>  {
>>  	u64 cmask = (level == 3) ? CONT_PTE_SIZE - 1 : U64_MAX;
>>  	pteval_t protval = pgprot_val(prot) & ~PTE_TYPE_MASK;
>> -	int lshift = (3 - level) * (PAGE_SHIFT - 3);
>> +	int lshift = (3 - level) * (PAGE_SHIFT - PTDESC_ORDER);
>>  	u64 lmask = (PAGE_SIZE << lshift) - 1;
>>  
>>  	start	&= PAGE_MASK;
>> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
>> index b65a29440a0c..211821f80571 100644
>> --- a/arch/arm64/mm/kasan_init.c
>> +++ b/arch/arm64/mm/kasan_init.c
>> @@ -190,7 +190,7 @@ static void __init kasan_pgd_populate(unsigned long addr, unsigned long end,
>>   */
>>  static bool __init root_level_aligned(u64 addr)
>>  {
>> -	int shift = (ARM64_HW_PGTABLE_LEVELS(vabits_actual) - 1) * (PAGE_SHIFT - 3);
>> +	int shift = (ARM64_HW_PGTABLE_LEVELS(vabits_actual) - 1) * (PAGE_SHIFT - PTDESC_ORDER);
>>  
>>  	return (addr % (PAGE_SIZE << shift)) == 0;
>>  }
>> @@ -245,7 +245,7 @@ static int __init root_level_idx(u64 addr)
>>  	 */
>>  	u64 vabits = IS_ENABLED(CONFIG_ARM64_64K_PAGES) ? VA_BITS
>>  							: vabits_actual;
>> -	int shift = (ARM64_HW_PGTABLE_LEVELS(vabits) - 1) * (PAGE_SHIFT - 3);
>> +	int shift = (ARM64_HW_PGTABLE_LEVELS(vabits) - 1) * (PAGE_SHIFT - PTDESC_ORDER);
>>  
>>  	return (addr & ~_PAGE_OFFSET(vabits)) >> (shift + PAGE_SHIFT);
>>  }
>> @@ -269,7 +269,7 @@ static void __init clone_next_level(u64 addr, pgd_t *tmp_pg_dir, pud_t *pud)
>>   */
>>  static int __init next_level_idx(u64 addr)
>>  {
>> -	int shift = (ARM64_HW_PGTABLE_LEVELS(vabits_actual) - 2) * (PAGE_SHIFT - 3);
>> +	int shift = (ARM64_HW_PGTABLE_LEVELS(vabits_actual) - 2) * (PAGE_SHIFT - PTDESC_ORDER);
>>  
>>  	return (addr >> (shift + PAGE_SHIFT)) % PTRS_PER_PTE;
>>  }
>> -- 
>> 2.25.1
>>

