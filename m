Return-Path: <linux-kernel+bounces-336561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CE5983C5C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 07:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 333A71F22551
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 05:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8523B335C7;
	Tue, 24 Sep 2024 05:28:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F18554FAD
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 05:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727155737; cv=none; b=moxZzkrNIHSp6I7mF2TL6VhMFLqy6brdfb6IGLSV0DZsRda1r9L/09D5Wh7lADP+LQu8hHwtHKh+fmt7RMDo3c4gfwoE9Fayj0WnoVejzxi8bGpe+w8lGPD2GqB5Vfy8Muz/+VQOAlrKbLuIVlPj538Bo01fP1ZrPFck6CYEOQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727155737; c=relaxed/simple;
	bh=SDwD+VVp5hmY84/QXdF+MTdgGjABTcgydo25UaNRftU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Vef+4okMlDNMeYgovGXzm4WUJw+wC+kxMGUrNVQ9+/xXHOmX5DeOQww18sD4a6//Qhex7qXpt/BEFQ+i4UxTHzMVZdQJqm6zsuTc8aLtRJogSddThMF7OboSoaPN1K0nQ+RNu+klq2+QFcqJTtnWOWp8jOzV81Jb40QKgzOIItk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACFA3DA7;
	Mon, 23 Sep 2024 22:29:22 -0700 (PDT)
Received: from [10.163.37.113] (unknown [10.163.37.113])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 055823F6A8;
	Mon, 23 Sep 2024 22:28:49 -0700 (PDT)
Message-ID: <0245d69d-8544-4068-9739-2d999c1fc599@arm.com>
Date: Tue, 24 Sep 2024 10:58:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Move set_pxd_safe() helpers from generic to platform
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
 akpm@linux-foundation.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, x86@kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240920053017.2514920-1-anshuman.khandual@arm.com>
 <4aad893a-f8ba-4b2e-bded-b01a35ec0a94@redhat.com>
 <6f178f3c-40fd-45f6-a380-a218429852ca@arm.com>
Content-Language: en-US
In-Reply-To: <6f178f3c-40fd-45f6-a380-a218429852ca@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/20/24 14:12, Anshuman Khandual wrote:
> 
> 
> On 9/20/24 12:09, David Hildenbrand wrote:
>> On 20.09.24 07:30, Anshuman Khandual wrote:
>>> set_pxd_safe() helpers that serve a specific purpose for both x86 and riscv
>>> platforms, do not need to be in the common memory code. Otherwise they just
>>> unnecessarily make the common API more complicated. This moves the helpers
>>> from common code to platform instead.
>>>
>>> Cc: Paul Walmsley <paul.walmsley@sifive.com>
>>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: x86@kernel.org
>>> Cc: linux-mm@kvack.org
>>> Cc: linux-riscv@lists.infradead.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>>   arch/riscv/include/asm/pgtable.h | 19 ++++++++++++++++
>>>   arch/x86/include/asm/pgtable.h   | 37 +++++++++++++++++++++++++++++++
>>>   include/linux/pgtable.h          | 38 --------------------------------
>>>   3 files changed, 56 insertions(+), 38 deletions(-)
>>>
>>> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
>>> index 089f3c9f56a3..39ca652c5ebe 100644
>>> --- a/arch/riscv/include/asm/pgtable.h
>>> +++ b/arch/riscv/include/asm/pgtable.h
>>> @@ -957,6 +957,25 @@ void misc_mem_init(void);
>>>   extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
>>>   #define ZERO_PAGE(vaddr) (virt_to_page(empty_zero_page))
>>>   +/*
>>> + * Use set_p*_safe(), and elide TLB flushing, when confident that *no*
>>> + * TLB flush will be required as a result of the "set". For example, use
>>> + * in scenarios where it is known ahead of time that the routine is
>>> + * setting non-present entries, or re-setting an existing entry to the
>>> + * same value. Otherwise, use the typical "set" helpers and flush the
>>> + * TLB.
>>> + */
>>> +#define set_p4d_safe(p4dp, p4d) \
>>> +({ \
>>> +    WARN_ON_ONCE(p4d_present(*p4dp) && !p4d_same(*p4dp, p4d)); \
>>> +    set_p4d(p4dp, p4d); \
>>> +})
>>> +
>>> +#define set_pgd_safe(pgdp, pgd) \
>>> +({ \
>>> +    WARN_ON_ONCE(pgd_present(*pgdp) && !pgd_same(*pgdp, pgd)); \
>>> +    set_pgd(pgdp, pgd); \
>>> +})
>>>   #endif /* !__ASSEMBLY__ */
>>>     #endif /* _ASM_RISCV_PGTABLE_H */
>>> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
>>> index e39311a89bf4..fefb52bb6b4d 100644
>>> --- a/arch/x86/include/asm/pgtable.h
>>> +++ b/arch/x86/include/asm/pgtable.h
>>> @@ -1701,6 +1701,43 @@ bool arch_is_platform_page(u64 paddr);
>>>   #define arch_is_platform_page arch_is_platform_page
>>>   #endif
>>>   +/*
>>> + * Use set_p*_safe(), and elide TLB flushing, when confident that *no*
>>> + * TLB flush will be required as a result of the "set". For example, use
>>> + * in scenarios where it is known ahead of time that the routine is
>>> + * setting non-present entries, or re-setting an existing entry to the
>>> + * same value. Otherwise, use the typical "set" helpers and flush the
>>> + * TLB.
>>> + */
>>> +#define set_pte_safe(ptep, pte) \
>>> +({ \
>>> +    WARN_ON_ONCE(pte_present(*ptep) && !pte_same(*ptep, pte)); \
>>> +    set_pte(ptep, pte); \
>>> +})
>>> +
>>> +#define set_pmd_safe(pmdp, pmd) \
>>> +({ \
>>> +    WARN_ON_ONCE(pmd_present(*pmdp) && !pmd_same(*pmdp, pmd)); \
>>> +    set_pmd(pmdp, pmd); \
>>> +})
>>> +
>>> +#define set_pud_safe(pudp, pud) \
>>> +({ \
>>> +    WARN_ON_ONCE(pud_present(*pudp) && !pud_same(*pudp, pud)); \
>>> +    set_pud(pudp, pud); \
>>> +})
>>> +
>>> +#define set_p4d_safe(p4dp, p4d) \
>>> +({ \
>>> +    WARN_ON_ONCE(p4d_present(*p4dp) && !p4d_same(*p4dp, p4d)); \
>>> +    set_p4d(p4dp, p4d); \
>>> +})
>>> +
>>> +#define set_pgd_safe(pgdp, pgd) \
>>> +({ \
>>> +    WARN_ON_ONCE(pgd_present(*pgdp) && !pgd_same(*pgdp, pgd)); \
>>> +    set_pgd(pgdp, pgd); \
>>> +})
>>>   #endif    /* __ASSEMBLY__ */
>>
>> I'm wondering if we can completely get rid of these, for example via:
>>
>> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
>> index d8dbeac8b206..bc71c25930bb 100644
>> --- a/arch/x86/mm/init_64.c
>> +++ b/arch/x86/mm/init_64.c
>> @@ -79,10 +79,8 @@ DEFINE_POPULATE(pmd_populate_kernel, pmd, pte, init)
>>  static inline void set_##type1##_init(type1##_t *arg1,         \
>>                         type2##_t arg2, bool init)              \
>>  {                                                              \
>> -       if (init)                                               \
>> -               set_##type1##_safe(arg1, arg2);                 \
>> -       else                                                    \
>> -               set_##type1(arg1, arg2);                        \
>> +       WARN_ON_ONCE(init && ##type1##_present(*arg1) && !##type1##_same(*arg1, arg2)); \
>> +       set_##type1(arg1, arg2);                                \
>>  }
>>  
>>
>> We might be able to handle the pgd_populate etc part similarly, possibly getting
>> rid of the pgd_populate_safe etc as well.
>>
>> Assuming I don't miss anything important :)
> 
> Sounds feasible but will just leave that upto the x86 platform folks to
> change later on, after this patch which just moves these helpers inside
> the platform code.
> 
>>
>> Ideally, we get rid of the macros here and just use inline functions ...
>>
> 
> Sure, makes sense. Will change these as inline functions.
> 
> -#define set_pte_safe(ptep, pte) \
> -({ \
> -       WARN_ON_ONCE(pte_present(*ptep) && !pte_same(*ptep, pte)); \
> -       set_pte(ptep, pte); \
> -})
> +static inline void set_pte_safe(pte_t *ptep, pte_t pte)
> +{
> +       WARN_ON_ONCE(pte_present(*ptep) && !pte_same(*ptep, pte));
> +       set_pte(ptep, pte);
> +}
> 

This has hit a road block in converting these macros as static inline
functions as suggested earlier, because pmd/pud/p4d/pgd_same() macros
are defined in generic header include/linux/pgtable.h, but way after
<asm/pgtable.h> gets included. I guess then the current patch should
be left as it is.

