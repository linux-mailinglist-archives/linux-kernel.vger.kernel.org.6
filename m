Return-Path: <linux-kernel+bounces-268244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD179942222
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 23:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 432ABB21BC9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6908818E02E;
	Tue, 30 Jul 2024 21:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BriBxaZ4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD81018C914
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 21:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722374379; cv=none; b=b5BZ3wVDb9TGRYerXuhZb5+bDWPhe2x3trxt/PjH1xnmrbvueXNOavtj4zaIqvjKTvvbS/k1X+nE7JgqnHn11QZY0O9o0YaVcobo3EmPqDdNTVewbs+Pcq/ZgdlsakfCOGP+Hj2R5NoV+R4tjqIyuobxCnLa9yHblszEME5MqSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722374379; c=relaxed/simple;
	bh=4LF/D0DfeuxRHOITwtmYNI1LWDVraPm1XSsnlnZ/6eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pUKFCVubYrwUymAExTmRobOKkGqXSJmuQFA2P89qZpB5Lj1sGYfZHDxAuW1p4H6AIWXwbUnY0ricK5tys9eA7TCf9w5u1Amy7n7qeqgI/Aq8MCUJQHwitUofw24ABZ/LzV5EH3R2ouJ5zs2K305YWWgue9UO6Cz5IUkzA8yGPvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BriBxaZ4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722374376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=URA8y1RcRCZ1Ayj47MpTEZ208uMuNs4kA4WTu7Sh2AE=;
	b=BriBxaZ4C0HT9Yc2IEy8WJCeZpGcN/aogbZuJQSssOXmNtMsWAkvYiJNAiY+EHsjZa/RTO
	/5zjOYr/ZhKBpGWOruEGEjvVhTgbDIZljhxaYtWe670ymc4A95yjaC3AzHRwrDBIp06cMX
	LgxaNoCYce9OI5P6FOCSwHoVZ+FJkZA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-OGgQXjTuPkG2HE7lce9qrg-1; Tue, 30 Jul 2024 17:19:31 -0400
X-MC-Unique: OGgQXjTuPkG2HE7lce9qrg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4280c6b3614so30840525e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 14:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722374370; x=1722979170;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=URA8y1RcRCZ1Ayj47MpTEZ208uMuNs4kA4WTu7Sh2AE=;
        b=oxrW+mcZNEvmtxd4L3f9in+4jppx4dRK2i0xeVkuCIlzM3tn3xZqMRN/ul5jOM5o7F
         Hx2bCrXCKaSJAoY8fG2ZdRoHl6qhoLZ+rZ0njxexEO4Hv2sbGbR8TP9c3RPEV1euz13N
         UQmOKrou7OLfs0gcdEUHzANFNWAjDqvyyuUCJFPg3GfI+JSit+0YVgRKeykLkfLtkSnk
         NmDDDD6Af9BZK0itZNICgswQ1iqP9D1+ygVlhrIiKzW3XQOolrZQ/FLoOHXLMagdo60B
         T1XWbWzI2+MbCAgwknC/lK4h/yD31I+TFNjD+pHbeP9TqjvYulajOz1o0bXyhoF2JpNl
         caXw==
X-Gm-Message-State: AOJu0YzmmIoITZF5APDMM87WNeU6Al6RLsvUtD4FbWbWsymRP1cGot2B
	iyWDvgN8s4UEzPoaUzTPYJv7Cpilbf7trMNPTRoyh97vgyNuyjb07udIuIZvuWbC9o74sbGDuna
	8An2rA0E2B6eO8+5O10kmes1y0ypSUh1kdO3GvnvVHV8PjfpqDDBLX3V09lbgrw==
X-Received: by 2002:a05:600c:1550:b0:426:5e8e:410a with SMTP id 5b1f17b1804b1-42811dd7a57mr84363755e9.24.1722374369710;
        Tue, 30 Jul 2024 14:19:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmHtZuDi/lqf35W1WSyS4+8hGZXWl3pM1BZxyElWRmesjHG2v45gayHNvfBJaztXUcCsyyow==
X-Received: by 2002:a05:600c:1550:b0:426:5e8e:410a with SMTP id 5b1f17b1804b1-42811dd7a57mr84363615e9.24.1722374369158;
        Tue, 30 Jul 2024 14:19:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:4e00:31ad:5274:e21c:b59? (p200300cbc7064e0031ad5274e21c0b59.dip0.t-ipconnect.de. [2003:cb:c706:4e00:31ad:5274:e21c:b59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4281fb6369esm66618535e9.48.2024.07.30.14.19.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 14:19:28 -0700 (PDT)
Message-ID: <1c527333-e837-4a40-afa8-eb8728332055@redhat.com>
Date: Tue, 30 Jul 2024 23:19:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/hugetlb: fix hugetlb vs. core-mm PT locking
To: James Houghton <jthoughton@google.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org,
 Peter Xu <peterx@redhat.com>, Oscar Salvador <osalvador@suse.de>,
 Muchun Song <muchun.song@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>
References: <20240730200341.1642904-1-david@redhat.com>
 <CADrL8HXRCNFzmg67p=j0_0Y_NAFo5rUDmvnr40F5HGAsQMvbnw@mail.gmail.com>
 <3f6c97b5-ccd8-4226-a9ac-78d555b0d048@redhat.com>
 <b74fcedb-60c5-4fd3-bcc7-74959e12c38d@redhat.com>
 <CADrL8HUvxp8TX31SsVaQg_HBgTWMDUKWxOJqCp-G_c9Lqz9n+g@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CADrL8HUvxp8TX31SsVaQg_HBgTWMDUKWxOJqCp-G_c9Lqz9n+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30.07.24 23:17, James Houghton wrote:
> On Tue, Jul 30, 2024 at 2:07 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 30.07.24 23:00, David Hildenbrand wrote:
>>> On 30.07.24 22:43, James Houghton wrote:
>>>> On Tue, Jul 30, 2024 at 1:03 PM David Hildenbrand <david@redhat.com> wrote:
>>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>>> index b100df8cb5857..1b1f40ff00b7d 100644
>>>>> --- a/include/linux/mm.h
>>>>> +++ b/include/linux/mm.h
>>>>> @@ -2926,6 +2926,12 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
>>>>>            return ptlock_ptr(page_ptdesc(pmd_page(*pmd)));
>>>>>     }
>>>>>
>>>>> +static inline spinlock_t *ptep_lockptr(struct mm_struct *mm, pte_t *pte)
>>>>> +{
>>>>> +       BUILD_BUG_ON(IS_ENABLED(CONFIG_HIGHPTE));
>>>>> +       return ptlock_ptr(virt_to_ptdesc(pte));
>>>>
>>>> Hi David,
>>>>
>>>
>>> Hi!
>>>
>>>> Small question: ptep_lockptr() does not handle the case where the size
>>>> of the PTE table is larger than PAGE_SIZE, but pmd_lockptr() does.
>>>
>>> I thought I convinced myself that leaf page tables are always single
>>> pages and had a comment in v1.
>>>
>>> But now I have to double-check again, and staring at
>>> pagetable_pte_ctor() callers I am left confused.
>>>
>>> It certainly sounds more future proof to just align the pointer down to
>>> the start of the PTE table like pmd_lockptr() would.
>>>
>>>> IIUC, for pte_lockptr() and ptep_lockptr() to return the same result
>>>> in this case, ptep_lockptr() should be doing the masking that
>>>> pmd_lockptr() is doing. Are you sure that you don't need to be doing
>>>> it? (Or maybe I am misunderstanding something.)
>>>
>>> It's a valid concern even if it would not be required. But I'm afraid I
>>> won't dig into the details and simply do the alignment in a v3.
>>
>> To be precise, the following on top:
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 1b1f40ff00b7d..f6c7fe8f5746f 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -2926,10 +2926,22 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
>>           return ptlock_ptr(page_ptdesc(pmd_page(*pmd)));
>>    }
>>
>> -static inline spinlock_t *ptep_lockptr(struct mm_struct *mm, pte_t *pte)
>> +static inline struct page *ptep_pgtable_page(pte_t *pte)
>>    {
>> +       unsigned long mask = ~(PTRS_PER_PTE * sizeof(pte_t) - 1);
>> +
>>           BUILD_BUG_ON(IS_ENABLED(CONFIG_HIGHPTE));
>> -       return ptlock_ptr(virt_to_ptdesc(pte));
>> +       return virt_to_page((void *)((unsigned long)pte & mask));
>> +}
>> +
>> +static inline struct ptdesc *ptep_ptdesc(pte_t *pte)
>> +{
>> +       return page_ptdesc(ptep_pgtable_page(pte));
>> +}
>> +
>> +static inline spinlock_t *ptep_lockptr(struct mm_struct *mm, pte_t *pte)
>> +{
>> +       return ptlock_ptr(ptep_ptdesc(pte));
>>    }
> 
> Thanks! That looks right to me. Feel free to add
> 
> Reviewed-by: James Houghton <jthoughton@google.com>

Thanks for the review, will send a v3 tomorrow after having wasted more 
valuable life time setting up the ARM environment again ... :)

-- 
Cheers,

David / dhildenb


