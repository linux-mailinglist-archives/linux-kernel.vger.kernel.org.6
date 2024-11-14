Return-Path: <linux-kernel+bounces-409951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C85C59C9403
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 22:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89B822853AE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A881AC429;
	Thu, 14 Nov 2024 21:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KeZBz4al"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797DE189F2A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 21:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731619151; cv=none; b=FyhmCI9CBAmqSqWHtFX6U++siufYo3tdkhRYmyCHwwor4ald6OspxXhiPKxStRQogsTnRFq54cSaeMiRhp01wq6odXZxk4FlP8e2QsAu+A84j4vkW2KUA7pNe3jRDj9MHb7alY6ZOQal3UAOah634lVb7oHzUJaaG8yH3Ye6MFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731619151; c=relaxed/simple;
	bh=40r1nWe6zMtUzIDnVqtWJ0MUapjek9frezM4YogtDfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pA1fwlb/NAjGVJBwh6ziMc7zmFSZQSvbR10V5KASVoii4S9buvisEdSW7nLj6hvOFPTszsEnpmHd9hhswB04GTUjxdAxmrQDDYWVpcSdzbrlwTB7Ps1DKhTWziOPL3V0Av7VhHiokPLlwpE6CTqJj0sh4b6+paci7IlSOQYPfdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KeZBz4al; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731619148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=95HXltx35X3axEEyU5I1xFjQCoAgrgxAeN7bNmC+/tk=;
	b=KeZBz4alBr6SQYoBewxfjOHiN4hfLPsS/5tepCGsIB0jxueDi419ckXuFUaZq+RnomdUYQ
	P5HexNwWIAISX9NzNWGSCHLvUv6F4AdQkP86y8UX3DInNTDfE55YYG6NchnZIoRo92kkqj
	d1eB6l7xxsdY9bUDjbqjgHz3wVns3Oo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-WGMO8Yr7OEa-v_dpx-lnWw-1; Thu, 14 Nov 2024 16:19:05 -0500
X-MC-Unique: WGMO8Yr7OEa-v_dpx-lnWw-1
X-Mimecast-MFC-AGG-ID: WGMO8Yr7OEa-v_dpx-lnWw
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4315f48bd70so205015e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:19:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731619144; x=1732223944;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=95HXltx35X3axEEyU5I1xFjQCoAgrgxAeN7bNmC+/tk=;
        b=wp0JEPOmzaPn7ggxNeQPdr6oo0wHOv6vU2urz97NLorNajsjU2++oK2KrHtHToIBv5
         FHMscM67+NHGBM+Gl0YX9XMMPFqWwxNIctuV5bfvTSlCYw+j1NEbvYZLIgJHXcteVZ1e
         zLmyG1Ck5JLct5rH3YxcrjbyWqxwIeo+5qNYaIL1sCN+fc083xWRyp9HbUom+GEiroco
         At9YhWAB6Uhxh2OwSxPgi/wWlZUHjNMSh+BZRi0L+WUIa2VFmJacsWFGWOIjYg+9X80M
         N6gLKbLmBnsclyQJpaBZavJr779jYoFGFREbgVU1eKcWYORsn4+Z3xzs4zWpCRg9MEe7
         BLdw==
X-Forwarded-Encrypted: i=1; AJvYcCXHJTFaMMg8lyEDOysgkQhmu4A6UrnD5kqljti+4z7GIJmhYDiZUnCYUB2GKZ571mjdDRXko2VIgnx0HXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHxQXmd3okHE84SGrbjhawFlRZX5+WoY6RfC3UrKfWQUNkgNN9
	2C5qn2ZdHlanU2cedviZq5ltRkbbRqVkG+9FOU9DSzYFLjjRRrBGqNhc0CwGTk4rYlgdKs4gx9D
	Aovl4pbplvU2juA9w5/LDCsks8DQ3+ZVlwUA9LCLTdTi+zLMY0T444aqeDjDfig==
X-Received: by 2002:a05:600c:4ed3:b0:431:40ca:ce5d with SMTP id 5b1f17b1804b1-432df78ddf0mr1480915e9.23.1731619143820;
        Thu, 14 Nov 2024 13:19:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcOH1bMpb/+3vao6wvut1KxS5uDUNYjzvwxxxG1CfKJaiJxPZnMW4C72pa+al2x4jen3oYoQ==
X-Received: by 2002:a05:600c:4ed3:b0:431:40ca:ce5d with SMTP id 5b1f17b1804b1-432df78ddf0mr1480765e9.23.1731619143415;
        Thu, 14 Nov 2024 13:19:03 -0800 (PST)
Received: from ?IPV6:2003:cb:c715:6600:a077:c7da:3362:6896? (p200300cbc7156600a077c7da33626896.dip0.t-ipconnect.de. [2003:cb:c715:6600:a077:c7da:3362:6896])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dac0ae3asm32070715e9.27.2024.11.14.13.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 13:19:02 -0800 (PST)
Message-ID: <d27a75fa-b968-43d3-bbd3-cc607feee495@redhat.com>
Date: Thu, 14 Nov 2024 22:19:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] mm: introduce skip_none_ptes()
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: jannh@google.com, hughd@google.com, willy@infradead.org,
 muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org,
 peterx@redhat.com, mgorman@suse.de, catalin.marinas@arm.com,
 will@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
 peterz@infradead.org, x86@kernel.org, lorenzo.stoakes@oracle.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, zokeefe@google.com,
 rientjes@google.com
References: <cover.1731566457.git.zhengqi.arch@bytedance.com>
 <574bc9b646c87d878a5048edb63698a1f8483e10.1731566457.git.zhengqi.arch@bytedance.com>
 <c7eeac93-3619-4443-896f-ef2e02f0bef0@redhat.com>
 <617a063e-bd84-4da5-acf4-6ff516512055@bytedance.com>
 <fa3fc933-cd51-4be5-944e-250da9289eda@redhat.com>
 <b524a568-fa3b-4618-80cc-e8c31ea4eeac@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <b524a568-fa3b-4618-80cc-e8c31ea4eeac@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14.11.24 13:51, Qi Zheng wrote:
> 
> 
> On 2024/11/14 20:32, David Hildenbrand wrote:
>> On 14.11.24 10:20, Qi Zheng wrote:
>>>
>>>
>>> On 2024/11/14 16:04, David Hildenbrand wrote:
>>>>
>>>>>     static unsigned long zap_pte_range(struct mmu_gather *tlb,
>>>>>                     struct vm_area_struct *vma, pmd_t *pmd,
>>>>>                     unsigned long addr, unsigned long end,
>>>>> @@ -1682,13 +1704,17 @@ static unsigned long zap_pte_range(struct
>>>>> mmu_gather *tlb,
>>>>>             pte_t ptent = ptep_get(pte);
>>>>>             int max_nr;
>>>>> -        nr = 1;
>>>>> -        if (pte_none(ptent))
>>>>> -            continue;
>>>>> -
>>>>>             if (need_resched())
>>>>>                 break;
>>>>> +        nr = skip_none_ptes(pte, addr, end);
>>>>> +        if (nr) {
>>>>> +            addr += PAGE_SIZE * nr;
>>>>> +            if (addr == end)
>>>>> +                break;
>>>>> +            pte += nr;
>>>>> +        }
>>>>> +
>>>>>             max_nr = (end - addr) / PAGE_SIZE;
>>>>
>>>> I dislike calculating max_nr twice, once here and once in skip_non_ptes.
>>>>
>>>> Further, you're missing to update ptent here.
>>>
>>> Oh, my bad. However, with [PATCH v3 5/9], there will be no problem, but
>>> there are still two ptep_get() and max_nr calculation.
>>>
>>> If you inline it you can
>>>> avoid another ptep_get().
>>>
>>> Do you mean to inline the skip_none_ptes() into do_zap_pte_range()?
>>
>> Effectively moving this patch after #5, and have it be something like:
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 1949f5e0fece5..4f5d1e4c6688e 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -1667,8 +1667,21 @@ static inline int do_zap_pte_range(struct
>> mmu_gather *tlb,
>>           pte_t ptent = ptep_get(pte);
>>           int max_nr = (end - addr) / PAGE_SIZE;
>>
>> -       if (pte_none(ptent))
>> -               return 1;
>> +       /* Skip all consecutive pte_none(). */
>> +       if (pte_none(ptent)) {
>> +               int nr;
>> +
>> +               for (nr = 1; nr < max_nr; nr++) {
>> +                       ptent = ptep_get(pte + nr);
>> +                       if (!pte_none(ptent))
>> +                               break;
>> +               }
>> +               max_nr -= nr;
>> +               if (!max_nr)
>> +                       return nr;
>> +               pte += nr;
>> +               addr += nr * PAGE_SIZE;
>> +       }
>>
>>           if (pte_present(ptent))
>>                   return zap_present_ptes(tlb, vma, pte, ptent, max_nr,
>>
>>
>> In the context of this patch this makes most sense.
>>
>> Regarding "count_pte_none" comment, I assume you talk about patch #7.
> 
> Yes.
> 
>>
>> Can't you simply return the number of pte_none that you skipped here
>> using another
>> input variable, if really required?
> 
> Suppose we add an input variable nr_skip to do_zap_pte_range(), you mean
> to return the above nr to zap_pte_range() through:

Maybe "cur_none_nr" or something similar.

> 
> *nr_skip = nr;
> 
> and then:
> 
> zap_pte_range
> --> nr = do_zap_pte_range(tlb, vma, pte, addr, end, details, &skip_nr,
>    				      rss, &force_flush, &force_break);
>       if (can_reclaim_pt) {
>           none_nr += count_pte_none(pte, nr);
>           none_nr += nr_skip;
>       }
> 
> Right?

Yes. I did not look closely at the patch that adds the counting of 
pte_none though (to digest why it is required :) ).

-- 
Cheers,

David / dhildenb


