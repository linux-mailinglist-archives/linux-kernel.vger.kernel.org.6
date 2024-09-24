Return-Path: <linux-kernel+bounces-336694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAA7983F65
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9E011C228B1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 07:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA22514883F;
	Tue, 24 Sep 2024 07:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gi/IYTqg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32F6148832
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 07:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163598; cv=none; b=oys04mnWdkDuvG6LiUZpYvarMipVkfl9ghE5fNyR83mPu0xX2VWjlDYiQ63tyeru9JRIbUl71+J7oeFGuMo25XPMpOSofxh000iQZeWi+Iw/VFDnsIyQ8elS3Q9Uw5wYjGHsoXDOPG7ZO8f7wE61uNVdabEHjUPoSn2sR8V9KKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163598; c=relaxed/simple;
	bh=bI8YrWpAt/2k7UmNm/YeF4tPo3ocxFkUbVmlW1YEV3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aGcuSR/wzaDAbo4IwgvTBhaMI1wVlblqdcid21PVuAfC2xj4IVUvdKvspeG8pkLWHUVeoCLw5AapGSMGmGHzNaSLAlfZ1CVekHPAaH1ecwN269Bnk/97/f5baHCDT7c3luhiv5inaKgxKf2Qs7Uzu4eolWAVUHkx4A5Ka7IkRVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gi/IYTqg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727163594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2e+i/QUgriTj0JH0WyCYURigj/zdy04HQD4bewj7gzg=;
	b=Gi/IYTqgPokUx8FUZeM2rsyL1v6YcSy4VGhiLQ3d2OcNIf7YMBDsJp0OLyDY41O64jLcw9
	1A5TBTYLzvfMYTaWj8vN3fBaqXyOJPtdp3TE0bupo7u4jktqTNxC+htVYu/NTz2g+kWNmB
	BJYJ726UYEaZds3weIva/8mylusgUro=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-1F-GnTonPi6AErvpE_QnKA-1; Tue, 24 Sep 2024 03:39:53 -0400
X-MC-Unique: 1F-GnTonPi6AErvpE_QnKA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3771b6da3ceso2123286f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 00:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727163592; x=1727768392;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2e+i/QUgriTj0JH0WyCYURigj/zdy04HQD4bewj7gzg=;
        b=HP/06xcRf5l6QAgz1vGhpz06GmwluRWLJRMb1p5mg4h4rRIp8VPDy0QgEDRnJnTMQ1
         eZT7ivK4LDPW6GrUY5smqJCRT/Y/D3nQg6BXeOvtlREm/JsW5mPCfZIUqEX+IksRulq5
         rrolIrUtvGMfobRK+fEm+wJV4fzGW0DhIEW+UMcmjenx25nX2JuWXcAvfZHCRXtBHVgh
         lT5qZwYp/iCX+QedM/g558D7ee+7HaokR5+DbhhitI1He4g1xt+Br5QZlo5CgHgakpSV
         nYwqitJfyQqIAKNEK4vrmZw4dI1l+61OekzhbvJ/REO5XycCAp1evn2SNlpMj45834/K
         juIw==
X-Forwarded-Encrypted: i=1; AJvYcCVk1bqFiMDrp0ysG2I+3S/KxbCrImGwwQeyR6dyyNAMKhfiPtIMsFrSQKzz53nNN07bFaTHR+n4YCucY5A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Em664B9pV1W1tFvc+jmSo2Mjk6duwP3o0ih5x5+fLRK+c+bI
	Yvd7Rf4pVA2YG+ZJxAh2svW8H2rGbpfRB4uIzmzDrqRESCRC0+7xB7Pvm9eJDEFGI5gAECOy/oq
	ZPRyoXkmU48KNLlWv//KZGvw6HR50c7QfpRnVu6RzRGD0Kxzc9zmBQUlscTvO9Q==
X-Received: by 2002:a5d:6646:0:b0:374:ba3f:ad08 with SMTP id ffacd0b85a97d-37a42380e79mr7030995f8f.55.1727163591779;
        Tue, 24 Sep 2024 00:39:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1U23l57hIjlfgvSW85PNSaQPzhOLD5+pc2l8afCaE7zLIBm+mx6zGBACqkgxMxwRFnzGr5A==
X-Received: by 2002:a5d:6646:0:b0:374:ba3f:ad08 with SMTP id ffacd0b85a97d-37a42380e79mr7030978f8f.55.1727163591350;
        Tue, 24 Sep 2024 00:39:51 -0700 (PDT)
Received: from [10.202.151.204] (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e754c7580sm148022545e9.47.2024.09.24.00.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 00:39:50 -0700 (PDT)
Message-ID: <f3e1136e-103a-47dc-a282-c8fbccfb5af3@redhat.com>
Date: Tue, 24 Sep 2024 09:39:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Move set_pxd_safe() helpers from generic to platform
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
 akpm@linux-foundation.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, x86@kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240920053017.2514920-1-anshuman.khandual@arm.com>
 <4aad893a-f8ba-4b2e-bded-b01a35ec0a94@redhat.com>
 <6f178f3c-40fd-45f6-a380-a218429852ca@arm.com>
 <0245d69d-8544-4068-9739-2d999c1fc599@arm.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <0245d69d-8544-4068-9739-2d999c1fc599@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24.09.24 07:28, Anshuman Khandual wrote:
> 
> 
> On 9/20/24 14:12, Anshuman Khandual wrote:
>>
>>
>> On 9/20/24 12:09, David Hildenbrand wrote:
>>> On 20.09.24 07:30, Anshuman Khandual wrote:
>>>> set_pxd_safe() helpers that serve a specific purpose for both x86 and riscv
>>>> platforms, do not need to be in the common memory code. Otherwise they just
>>>> unnecessarily make the common API more complicated. This moves the helpers
>>>> from common code to platform instead.
>>>>
>>>> Cc: Paul Walmsley <paul.walmsley@sifive.com>
>>>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>>>> Cc: David Hildenbrand <david@redhat.com>
>>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>> Cc: x86@kernel.org
>>>> Cc: linux-mm@kvack.org
>>>> Cc: linux-riscv@lists.infradead.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>> ---
>>>>    arch/riscv/include/asm/pgtable.h | 19 ++++++++++++++++
>>>>    arch/x86/include/asm/pgtable.h   | 37 +++++++++++++++++++++++++++++++
>>>>    include/linux/pgtable.h          | 38 --------------------------------
>>>>    3 files changed, 56 insertions(+), 38 deletions(-)
>>>>
>>>> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
>>>> index 089f3c9f56a3..39ca652c5ebe 100644
>>>> --- a/arch/riscv/include/asm/pgtable.h
>>>> +++ b/arch/riscv/include/asm/pgtable.h
>>>> @@ -957,6 +957,25 @@ void misc_mem_init(void);
>>>>    extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
>>>>    #define ZERO_PAGE(vaddr) (virt_to_page(empty_zero_page))
>>>>    +/*
>>>> + * Use set_p*_safe(), and elide TLB flushing, when confident that *no*
>>>> + * TLB flush will be required as a result of the "set". For example, use
>>>> + * in scenarios where it is known ahead of time that the routine is
>>>> + * setting non-present entries, or re-setting an existing entry to the
>>>> + * same value. Otherwise, use the typical "set" helpers and flush the
>>>> + * TLB.
>>>> + */
>>>> +#define set_p4d_safe(p4dp, p4d) \
>>>> +({ \
>>>> +    WARN_ON_ONCE(p4d_present(*p4dp) && !p4d_same(*p4dp, p4d)); \
>>>> +    set_p4d(p4dp, p4d); \
>>>> +})
>>>> +
>>>> +#define set_pgd_safe(pgdp, pgd) \
>>>> +({ \
>>>> +    WARN_ON_ONCE(pgd_present(*pgdp) && !pgd_same(*pgdp, pgd)); \
>>>> +    set_pgd(pgdp, pgd); \
>>>> +})
>>>>    #endif /* !__ASSEMBLY__ */
>>>>      #endif /* _ASM_RISCV_PGTABLE_H */
>>>> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
>>>> index e39311a89bf4..fefb52bb6b4d 100644
>>>> --- a/arch/x86/include/asm/pgtable.h
>>>> +++ b/arch/x86/include/asm/pgtable.h
>>>> @@ -1701,6 +1701,43 @@ bool arch_is_platform_page(u64 paddr);
>>>>    #define arch_is_platform_page arch_is_platform_page
>>>>    #endif
>>>>    +/*
>>>> + * Use set_p*_safe(), and elide TLB flushing, when confident that *no*
>>>> + * TLB flush will be required as a result of the "set". For example, use
>>>> + * in scenarios where it is known ahead of time that the routine is
>>>> + * setting non-present entries, or re-setting an existing entry to the
>>>> + * same value. Otherwise, use the typical "set" helpers and flush the
>>>> + * TLB.
>>>> + */
>>>> +#define set_pte_safe(ptep, pte) \
>>>> +({ \
>>>> +    WARN_ON_ONCE(pte_present(*ptep) && !pte_same(*ptep, pte)); \
>>>> +    set_pte(ptep, pte); \
>>>> +})
>>>> +
>>>> +#define set_pmd_safe(pmdp, pmd) \
>>>> +({ \
>>>> +    WARN_ON_ONCE(pmd_present(*pmdp) && !pmd_same(*pmdp, pmd)); \
>>>> +    set_pmd(pmdp, pmd); \
>>>> +})
>>>> +
>>>> +#define set_pud_safe(pudp, pud) \
>>>> +({ \
>>>> +    WARN_ON_ONCE(pud_present(*pudp) && !pud_same(*pudp, pud)); \
>>>> +    set_pud(pudp, pud); \
>>>> +})
>>>> +
>>>> +#define set_p4d_safe(p4dp, p4d) \
>>>> +({ \
>>>> +    WARN_ON_ONCE(p4d_present(*p4dp) && !p4d_same(*p4dp, p4d)); \
>>>> +    set_p4d(p4dp, p4d); \
>>>> +})
>>>> +
>>>> +#define set_pgd_safe(pgdp, pgd) \
>>>> +({ \
>>>> +    WARN_ON_ONCE(pgd_present(*pgdp) && !pgd_same(*pgdp, pgd)); \
>>>> +    set_pgd(pgdp, pgd); \
>>>> +})
>>>>    #endif    /* __ASSEMBLY__ */
>>>
>>> I'm wondering if we can completely get rid of these, for example via:
>>>
>>> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
>>> index d8dbeac8b206..bc71c25930bb 100644
>>> --- a/arch/x86/mm/init_64.c
>>> +++ b/arch/x86/mm/init_64.c
>>> @@ -79,10 +79,8 @@ DEFINE_POPULATE(pmd_populate_kernel, pmd, pte, init)
>>>   static inline void set_##type1##_init(type1##_t *arg1,         \
>>>                          type2##_t arg2, bool init)              \
>>>   {                                                              \
>>> -       if (init)                                               \
>>> -               set_##type1##_safe(arg1, arg2);                 \
>>> -       else                                                    \
>>> -               set_##type1(arg1, arg2);                        \
>>> +       WARN_ON_ONCE(init && ##type1##_present(*arg1) && !##type1##_same(*arg1, arg2)); \
>>> +       set_##type1(arg1, arg2);                                \
>>>   }
>>>   
>>>
>>> We might be able to handle the pgd_populate etc part similarly, possibly getting
>>> rid of the pgd_populate_safe etc as well.
>>>
>>> Assuming I don't miss anything important :)
>>
>> Sounds feasible but will just leave that upto the x86 platform folks to
>> change later on, after this patch which just moves these helpers inside
>> the platform code.
>>
>>>
>>> Ideally, we get rid of the macros here and just use inline functions ...
>>>
>>
>> Sure, makes sense. Will change these as inline functions.
>>
>> -#define set_pte_safe(ptep, pte) \
>> -({ \
>> -       WARN_ON_ONCE(pte_present(*ptep) && !pte_same(*ptep, pte)); \
>> -       set_pte(ptep, pte); \
>> -})
>> +static inline void set_pte_safe(pte_t *ptep, pte_t pte)
>> +{
>> +       WARN_ON_ONCE(pte_present(*ptep) && !pte_same(*ptep, pte));
>> +       set_pte(ptep, pte);
>> +}
>>
> 
> This has hit a road block in converting these macros as static inline
> functions as suggested earlier, because pmd/pud/p4d/pgd_same() macros
> are defined in generic header include/linux/pgtable.h, but way after
> <asm/pgtable.h> gets included. I guess then the current patch should
> be left as it is.

Just to clarify: My ideas was to get rid of set_pte_safe() *completely* 
in x86 code, and turn set_pte_init() etc. into inline functions.

But we can do that on top, if Dave is fine with this patch.

-- 
Cheers,

David / dhildenb


