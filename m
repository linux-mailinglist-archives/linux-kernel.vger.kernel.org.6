Return-Path: <linux-kernel+bounces-315748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A060A96C680
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF803B20E78
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C313D1DFE08;
	Wed,  4 Sep 2024 18:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="El5uH9pb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447AE7F9
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 18:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725474939; cv=none; b=iRwoVyovMVkB0bJYFvHpSJr0MiW6bFys9UYpdmtIl9rv1di+XFOn1HetGpZKB9hMzjfjFX5u9Cv/ba8TXdbpOh9QrGwpfL/0SrBPjkI2ba8LJdyyA4/WJkWfMuq5UTci82rg7Q1eyOCxe/35x8XudYf+f0XofpVdgWL5qlEns8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725474939; c=relaxed/simple;
	bh=ZgbBY7c+lpTPhuSXTLpXjno6LF3GWHdMMdsIDM6e8a8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fRAK3LYQtbQ25Pt6i00mDNYVTDTA+wloXeQhwyQFOJSKR81aHxFDTiesi66FZ1AD2VkyPParBb3Vy5KYir2ky6uY4F4XDO44iWGwyAPygSX3Jd66JCVs1EIgia8NMaZtgGYiZs5A1GxrU7PaV5aOeVf/ZVhukZZ84llnXhhUemM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=El5uH9pb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725474936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3HVsVF2xOn1FP/Bvg+Qsg7hEnzPUS8l4u7+VV8N40dk=;
	b=El5uH9pbwyljdnspCBXkIvKS+vBDQzaHcaWQcBpDi1f8kzldxB2SXt/yUOaQraZ8AV0s6o
	igmRgJXeyRKzeEx8s9ewmKXwAi7NcxgLBatjBmi4kI7CQD7iz1CDwkdWYAPnfWGmNLtabM
	wnxT4MWz1ukFKxJ85TOVFkngUKHdkWY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-DnPw2zVwN2e1pGk-VJMa7Q-1; Wed, 04 Sep 2024 14:35:35 -0400
X-MC-Unique: DnPw2zVwN2e1pGk-VJMa7Q-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42bb5950d1aso76054825e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 11:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725474934; x=1726079734;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HVsVF2xOn1FP/Bvg+Qsg7hEnzPUS8l4u7+VV8N40dk=;
        b=o0W39J5PmHP7lhcR0AR2RKUEY+kV0gCNqomwRSq67V8tCbzvYnky/7GuXiAfENj37l
         EvAoViT9D+MfL5ezbDL9Yo4XKpG+z6a+fCSpLceCfFxjNEWO9MA4bao9Bz3hu70O/DBg
         BRZB3BP5YZkgl2PH8qu+rzk5SpETaoGHLli6RMaOhBJg4rCuOQ+8zILVfEh1Q+xjZZRz
         A/xv4kJYTxytXy00ACdZXLbqz77Y82ORoyEZAfiQM9kk842rnx9w50zjpnn24fO8djFz
         3L1TXEtQsd3AJUvHbxflvLpg2tql2Mke0RcO1SaKlWEk+SYHvAnQ01qWQcKZluH1tEeO
         ypOw==
X-Forwarded-Encrypted: i=1; AJvYcCUAqTK/QVHopcj9uOAuB61neTqkrgDtY9CGFg3W/9Czp9SFXA/yUkZ5b/jqhJwFwIxBMj2qxJ0VmWckTWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA/nA4Jdfg/jm9l3224pW0GWGSQa5Q2YA7LbkSfj1l5BCZUxnM
	lfEru77Yj48hxTvH01wmqq3S+4/RU0/oKWYsa0tCaHixuzPaSAxDXg8+M9g2KhXJkH7fNlS+bua
	OCqDqdkfTVlgRiQz93kj10cVi3rfFt7ESkIHP69vfZOw2dq21vRXLJVlRycuofQ==
X-Received: by 2002:a05:600c:3b9a:b0:428:29e:8c42 with SMTP id 5b1f17b1804b1-42c9a364c50mr483505e9.9.1725474933796;
        Wed, 04 Sep 2024 11:35:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjQ5W9UCQ2BAAdVNt5vuAXutYNCdvk03IQ6oU8BYEaSI83b+Vz6kIEQ5gshvUwmJyrypkS4Q==
X-Received: by 2002:a05:600c:3b9a:b0:428:29e:8c42 with SMTP id 5b1f17b1804b1-42c9a364c50mr483225e9.9.1725474932856;
        Wed, 04 Sep 2024 11:35:32 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:d00:e9a5:ae4b:9bdb:d992? (p200300cbc7150d00e9a5ae4b9bdbd992.dip0.t-ipconnect.de. [2003:cb:c715:d00:e9a5:ae4b:9bdb:d992])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bbf00e095sm171582735e9.13.2024.09.04.11.35.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 11:35:32 -0700 (PDT)
Message-ID: <bb2e9a22-5850-470d-95ae-d04d171a484f@redhat.com>
Date: Wed, 4 Sep 2024 20:35:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH 1/2] hugetlb: arm64: add mte support
To: Yang Shi <yang@os.amperecomputing.com>, catalin.marinas@arm.com,
 will@kernel.org, muchun.song@linux.dev, akpm@linux-foundation.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240821184752.3535276-1-yang@os.amperecomputing.com>
 <034f3269-7290-4599-8f12-72b63bf75195@redhat.com>
 <fee7218b-19c6-48d6-aa35-bd76e3473047@os.amperecomputing.com>
 <cd172334-d1d1-4ace-b4b5-a7dd42c6e58f@redhat.com>
 <3ba2cc44-811b-44ff-b376-50c31b7717c3@os.amperecomputing.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <3ba2cc44-811b-44ff-b376-50c31b7717c3@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04.09.24 19:57, Yang Shi wrote:
> 
> 
> On 9/3/24 2:35 PM, David Hildenbrand wrote:
>> On 03.09.24 18:46, Yang Shi wrote:
>>>
>>>
>>> On 9/2/24 7:33 AM, David Hildenbrand wrote:
>>>> On 21.08.24 20:47, Yang Shi wrote:
>>>>> Enable MTE support for hugetlb.
>>>>>
>>>>> The MTE page flags will be set on the head page only.  When copying
>>>>> hugetlb folio, the tags for all tail pages will be copied when copying
>>>>> head page.
>>>>>
>>>>> When freeing hugetlb folio, the MTE flags will be cleared.
>>>>>
>>>>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>>>>> ---
>>>>>     arch/arm64/include/asm/hugetlb.h | 11 ++++++++++-
>>>>>     arch/arm64/include/asm/mman.h    |  3 ++-
>>>>>     arch/arm64/kernel/hibernate.c    |  7 +++++++
>>>>>     arch/arm64/kernel/mte.c          | 25 +++++++++++++++++++++++--
>>>>>     arch/arm64/kvm/guest.c           | 16 +++++++++++++---
>>>>>     arch/arm64/kvm/mmu.c             | 11 +++++++++++
>>>>>     arch/arm64/mm/copypage.c         | 25 +++++++++++++++++++++++--
>>>>>     fs/hugetlbfs/inode.c             |  2 +-
>>>>>     8 files changed, 90 insertions(+), 10 deletions(-)
>>>>>
>>>>> v2: * Reimplemented the patch to fix the comments from Catalin.
>>>>>        * Added test cases (patch #2) per Catalin.
>>>>>
>>>>> diff --git a/arch/arm64/include/asm/hugetlb.h
>>>>> b/arch/arm64/include/asm/hugetlb.h
>>>>> index 293f880865e8..00a1f75d40ee 100644
>>>>> --- a/arch/arm64/include/asm/hugetlb.h
>>>>> +++ b/arch/arm64/include/asm/hugetlb.h
>>>>> @@ -11,6 +11,7 @@
>>>>>     #define __ASM_HUGETLB_H
>>>>>       #include <asm/cacheflush.h>
>>>>> +#include <asm/mte.h>
>>>>>     #include <asm/page.h>
>>>>>       #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
>>>>> @@ -20,7 +21,15 @@ extern bool
>>>>> arch_hugetlb_migration_supported(struct hstate *h);
>>>>>       static inline void arch_clear_hugetlb_flags(struct folio *folio)
>>>>>     {
>>>>> -    clear_bit(PG_dcache_clean, &folio->flags);
>>>>> +    const unsigned long clear_flags = BIT(PG_dcache_clean) |
>>>>> +        BIT(PG_mte_tagged) | BIT(PG_mte_lock);
>>>>> +
>>>>> +    if (!system_supports_mte()) {
>>>>> +        clear_bit(PG_dcache_clean, &folio->flags);
>>>>> +        return;
>>>>> +    }
>>>>> +
>>>>> +    folio->flags &= ~clear_flags;
>>>>>     }
>>>>>     #define arch_clear_hugetlb_flags arch_clear_hugetlb_flags
>>>>>     diff --git a/arch/arm64/include/asm/mman.h
>>>>> b/arch/arm64/include/asm/mman.h
>>>>> index 5966ee4a6154..304dfc499e68 100644
>>>>> --- a/arch/arm64/include/asm/mman.h
>>>>> +++ b/arch/arm64/include/asm/mman.h
>>>>> @@ -28,7 +28,8 @@ static inline unsigned long
>>>>> arch_calc_vm_flag_bits(unsigned long flags)
>>>>>          * backed by tags-capable memory. The vm_flags may be
>>>>> overridden by a
>>>>>          * filesystem supporting MTE (RAM-based).
>>>>>          */
>>>>> -    if (system_supports_mte() && (flags & MAP_ANONYMOUS))
>>>>> +    if (system_supports_mte() &&
>>>>> +        (flags & (MAP_ANONYMOUS | MAP_HUGETLB)))
>>>>>             return VM_MTE_ALLOWED;
>>>>>           return 0;
>>>>> diff --git a/arch/arm64/kernel/hibernate.c
>>>>> b/arch/arm64/kernel/hibernate.c
>>>>> index 02870beb271e..722e76f29141 100644
>>>>> --- a/arch/arm64/kernel/hibernate.c
>>>>> +++ b/arch/arm64/kernel/hibernate.c
>>>>> @@ -266,10 +266,17 @@ static int swsusp_mte_save_tags(void)
>>>>>             max_zone_pfn = zone_end_pfn(zone);
>>>>>             for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn;
>>>>> pfn++) {
>>>>>                 struct page *page = pfn_to_online_page(pfn);
>>>>> +            struct folio *folio;
>>>>>                   if (!page)
>>>>>                     continue;
>>>>>     +            folio = page_folio(page);
>>>>> +
>>>>> +            if (folio_test_hugetlb(folio) &&
>>>>> +                !page_mte_tagged(&folio->page))
>>>>> +                continue;
>>>>
>>>> Can we have folio_test_mte_tagged() whereby you make sure that only
>>>> folio_test_hugetlb() uses it for now (VM_WARN_ON_ONCE) and then make
>>>> sure that nobody uses page_mte_tagged() on hugetlb folios
>>>> (VM_WARN_ON_ONCE)?
>>>
>>>
>>> IIUC, you mean something like the below?
>>>
>>> bool folio_test_mte_tagged(struct folio *folio)
>>> {
>>>        VM_WARN_ON_ONCE(!folio_test_hugetlb(folio));
>>>
>>>        return test_bit(PG_mte_tagged, &folio->page->flags);
>>
>> folio->flags
>>
>>> }
>>>
>>> bool page_mte_tagged(struct page *page)
>>> {
>>>        struct folio *folio = page_folio(page);
>>>
>>>        VM_WARN_ON_ONCE(folio_test_hugetlb(folio));
>>
>> Yes, but better as
>>
>> VM_WARN_ON_ONCE(folio_test_hugetlb(page_folio(page)));
> 
> I see. But I think all the call sites for folio_test_mte_tagged()
> actually need have folio_test_hugetlb() before it. So the warn seems not
> very useful other than warning on some misuse.

... well, that's the whole reason for them :)

> 
>>
>>>
>>>        return test_bit(PG_mte_tagged, &pge->flags);
>>> }
>>>
>>>>
>>>> Same for folio_set_mte_tagged() and other functions. We could slap a
>>>> "hugetlb" into the function names, but maybe in the future we'll be
>>>> able to use a single flag per folio (I know, it's complicated ...).
>>>
>>> A single flag per folio should be the future direction, but I haven't
>>> done the research so can't tell how complicated it will be.
>>
>> There were some discussions on it, and it's tricky. So maybe we should
>> really just have folio_test_hugetlb_mte_tagged() etc. for now
> 
> Either w/ hugetlb or w/o hugetlb is fine, I don't have strong opinion on
> the naming.

Let's go with "hugetlb" for now, using it for other large folios is out 
of sight a bit ... at least right now :)

-- 
Cheers,

David / dhildenb


