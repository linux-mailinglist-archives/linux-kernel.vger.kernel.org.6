Return-Path: <linux-kernel+bounces-222305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2841D90FF81
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0119283091
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734781AB532;
	Thu, 20 Jun 2024 08:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OdGQ1hV1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAFA1AB509
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873394; cv=none; b=m9XMNFuHddRzGUv9iKZVJO3nSuoo/+2DeuqjjeAHyaQPIygqXUNu8gmSjKiOwYkr1lVmlaJDrKYYXyB6w8S2p8GbrM0N3Ubf0y5owVuNTUTgK2b4gjCmvrWvv4MhnEvoa87jPJ0vQgRFaPZIQ/qOZzjHY5vSUDhZAVPSWjCeMXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873394; c=relaxed/simple;
	bh=1F8KwaPLX6bp3oZDdq0o17bsaLOyiV92uMNKJqp32Fs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G+64BIsjkd+FeoRGcLdn+OByv6bou6lNVGsI2Rx361Do1Tny6TJRf+qdoe8lrVV+mDc2tA4D3WbRvJIu/5yxl0iK4hdpFO0C8Xon4rNFZGSMymokaw/HcDjpJTK3S+ibS6TnmurrCPxeFnzCmpUZZWHZpNix6d9wNak/SlKbPnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OdGQ1hV1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718873391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AAv7RQQch7LcXyPfLaCPXho4sTJ6RtYCMTJ25lmcE+w=;
	b=OdGQ1hV1Wjd9IlGxDeP5D0yrdMekvzYsp0if9enUXF1gs+1gItZREXmPvgq/174NWxLbVj
	fT2l1jL8e3TTSlUWxUJsk/LdDAt9g7zGPRtl+HfLAlM+WH8Gn0BRaC8CxCFe5PO2t+foL/
	xM217oUj5hg2FP1k8ATHmAWNoqwe8q8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-Y7hM01djN9SymCqeDMDsXw-1; Thu, 20 Jun 2024 04:49:50 -0400
X-MC-Unique: Y7hM01djN9SymCqeDMDsXw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52c805e6f38so497120e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 01:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718873389; x=1719478189;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AAv7RQQch7LcXyPfLaCPXho4sTJ6RtYCMTJ25lmcE+w=;
        b=CUxHCOsX5oxoSvrGF2wtZ815QgX60Rcy3ReiFtkwmMIgh4xMYMvkrpHlh1R1AFQHuI
         nClX04+QSh7nJ+6lFTZMlF9RQBZwMX8TAfCWzQWXobaL3xf6oPX8JpyB0WQlQ0CdFvlU
         KlXSsd0xya3fglTQiq4YdwtUBNMQR9fkk8E6dLlWLk+woFHQnIOyVlFrLlJ4iS25ohSQ
         0XHHfJunoYca79ISRIyYu8jwE9siu3hcKEgQLb8Uc7cfdmifSkzH/nbsmIRjxf0yhQeL
         uh318Rudhy3usD+6zxyGYE5yWTX6C8LuB3wxD339yPZcyp00t3dxETclgwgGvl1L1zgO
         o7pw==
X-Forwarded-Encrypted: i=1; AJvYcCVAlTRYSD9BfY45EdnUgyExbzHwlUrSiNq6WDVX7oCF3zt3/Aj85Q/R6DnBYunsbJ4Ee2oib5XxI6aocB6O+QpEmC3+eXhXwTSJ2X+Y
X-Gm-Message-State: AOJu0YzHAJmscSeL30chqg+5yVUZame2pFo23pzfDAfmfmgKbVvdgvl/
	PQbn6JQTRpFKUAkX1L38g414/vHcNilOsdDYcrcZQRcy07r6Slx4Iw4QcLG/SLjZF/oiuf7GScp
	MSZXl6qyc29NXvYtxdrUBATeRGkmVOSbT4+wjVJEOl81edZlb5x/Sv/MyU+CZuQ==
X-Received: by 2002:a05:6512:a90:b0:52c:c5c4:43d2 with SMTP id 2adb3069b0e04-52ccaa9270bmr3467096e87.47.1718873388667;
        Thu, 20 Jun 2024 01:49:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKQ0r2BXJa5t1jwi828D6AeNWpQVJ41OidX0Z0GkcnhmFLloc01iW/tC0IeJraaukyc1LIhw==
X-Received: by 2002:a05:6512:a90:b0:52c:c5c4:43d2 with SMTP id 2adb3069b0e04-52ccaa9270bmr3467062e87.47.1718873388220;
        Thu, 20 Jun 2024 01:49:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c719:5b00:61af:900f:3aef:3af3? (p200300cbc7195b0061af900f3aef3af3.dip0.t-ipconnect.de. [2003:cb:c719:5b00:61af:900f:3aef:3af3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0ca68esm17846255e9.30.2024.06.20.01.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 01:49:47 -0700 (PDT)
Message-ID: <60a075da-7c7e-4d99-ac52-059e5a17b72e@redhat.com>
Date: Thu, 20 Jun 2024 10:49:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] mm: use folio_add_new_anon_rmap() if
 folio_test_anon(folio)==false
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 baolin.wang@linux.alibaba.com, chrisl@kernel.org,
 linux-kernel@vger.kernel.org, mhocko@suse.com, ryan.roberts@arm.com,
 shy828301@gmail.com, surenb@google.com, v-songbaohua@oppo.com,
 willy@infradead.org, ying.huang@intel.com, yosryahmed@google.com,
 yuzhao@google.com, Shuai Yuan <yuanshuai@oppo.com>
References: <20240617231137.80726-1-21cnbao@gmail.com>
 <20240617231137.80726-3-21cnbao@gmail.com>
 <f9cb01c2-967f-406c-9304-5e31a82b6b0f@redhat.com>
 <CAGsJ_4yuBJW578sL5dsKvWP2A=x54zV5b+qbwfy9vj8rFiQM1Q@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4yuBJW578sL5dsKvWP2A=x54zV5b+qbwfy9vj8rFiQM1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20.06.24 10:33, Barry Song wrote:
> On Thu, Jun 20, 2024 at 7:46 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 18.06.24 01:11, Barry Song wrote:
>>> From: Barry Song <v-songbaohua@oppo.com>
>>>
>>> For the !folio_test_anon(folio) case, we can now invoke folio_add_new_anon_rmap()
>>> with the rmap flags set to either EXCLUSIVE or non-EXCLUSIVE. This action will
>>> suppress the VM_WARN_ON_FOLIO check within __folio_add_anon_rmap() while initiating
>>> the process of bringing up mTHP swapin.
>>>
>>>    static __always_inline void __folio_add_anon_rmap(struct folio *folio,
>>>                    struct page *page, int nr_pages, struct vm_area_struct *vma,
>>>                    unsigned long address, rmap_t flags, enum rmap_level level)
>>>    {
>>>            ...
>>>            if (unlikely(!folio_test_anon(folio))) {
>>>                    VM_WARN_ON_FOLIO(folio_test_large(folio) &&
>>>                                     level != RMAP_LEVEL_PMD, folio);
>>>            }
>>>            ...
>>>    }
>>>
>>> It also improves the code’s readability. Currently, all new anonymous
>>> folios calling folio_add_anon_rmap_ptes() are order-0. This ensures
>>> that new folios cannot be partially exclusive; they are either entirely
>>> exclusive or entirely shared.
>>>
>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>> Tested-by: Shuai Yuan <yuanshuai@oppo.com>
>>> ---
>>>    mm/memory.c   |  8 ++++++++
>>>    mm/swapfile.c | 13 +++++++++++--
>>>    2 files changed, 19 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 1f24ecdafe05..620654c13b2f 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -4339,6 +4339,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>        if (unlikely(folio != swapcache && swapcache)) {
>>>                folio_add_new_anon_rmap(folio, vma, address, RMAP_EXCLUSIVE);
>>>                folio_add_lru_vma(folio, vma);
>>> +     } else if (!folio_test_anon(folio)) {
>>> +             /*
>>> +              * We currently only expect small !anon folios, for which we now
>>> +              * that they are either fully exclusive or fully shared. If we
>>> +              * ever get large folios here, we have to be careful.
>>> +              */
>>> +             VM_WARN_ON_ONCE(folio_test_large(folio));
>>> +             folio_add_new_anon_rmap(folio, vma, address, rmap_flags);
>>>        } else {
>>>                folio_add_anon_rmap_ptes(folio, page, nr_pages, vma, address,
>>>                                        rmap_flags);
>>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>>> index ae1d2700f6a3..69efa1a57087 100644
>>> --- a/mm/swapfile.c
>>> +++ b/mm/swapfile.c
>>> @@ -1908,8 +1908,17 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
>>>                VM_BUG_ON_FOLIO(folio_test_writeback(folio), folio);
>>>                if (pte_swp_exclusive(old_pte))
>>>                        rmap_flags |= RMAP_EXCLUSIVE;
>>> -
>>> -             folio_add_anon_rmap_pte(folio, page, vma, addr, rmap_flags);
>>> +             /*
>>> +              * We currently only expect small !anon folios, for which we now that
>>> +              * they are either fully exclusive or fully shared. If we ever get
>>> +              * large folios here, we have to be careful.
>>> +              */
>>> +             if (!folio_test_anon(folio)) {
>>> +                     VM_WARN_ON_ONCE(folio_test_large(folio));
>>
>> (comment applies to both cases)
>>
>> Thinking about Hugh's comment, we should likely add here:
>>
>> VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
>>
>> [the check we are removing from __folio_add_anon_rmap()]
>>
>> and document for folio_add_new_anon_rmap() in patch #1, that when
>> dealing with folios that might be mapped concurrently by others, the
>> folio lock must be held.
> 
> I assume you mean something like the following for patch#1?
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index df1a43295c85..20986b25f1b2 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1394,7 +1394,8 @@ void folio_add_anon_rmap_pmd(struct folio
> *folio, struct page *page,
>    *
>    * Like folio_add_anon_rmap_*() but must only be called on *new* folios.
>    * This means the inc-and-test can be bypassed.
> - * The folio does not have to be locked.
> + * The folio doesn't necessarily need to be locked while it's
> exclusive unless two threads
> + * map it concurrently. However, the folio must be locked if it's shared.
>    *
>    * If the folio is pmd-mappable, it is accounted as a THP.
>    */
> @@ -1406,6 +1407,7 @@ void folio_add_new_anon_rmap(struct folio
> *folio, struct vm_area_struct *vma,
>          int nr_pmdmapped = 0;
> 
>          VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
> +       VM_WARN_ON_FOLIO(!exclusive && !folio_test_locked(folio), folio);

For now this would likely do. I was concerned about a concurrent 
scenario in the exclusive case, but that shouldn't really happen I guess.

-- 
Cheers,

David / dhildenb


