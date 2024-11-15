Return-Path: <linux-kernel+bounces-410172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FD39CD5BA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 04:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF00D1F21826
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 03:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712B9184523;
	Fri, 15 Nov 2024 03:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GcbXLzzc"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C0A17E00F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 03:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731639834; cv=none; b=L7IQFxYUQgszo+U5tz9V8tvlGS+qFwKGJdQXP/Z/cIVMB0xhr6JL8iN/cIcLT4bVNeDxco8S8UCWHfADGHoJMh3Jfax1E3pZfD/RuO+OoEd9XjKlg1P0AsdEtD5lnCqUVjeKymhjtwqSYIPwIf7z+BWXdT4ihe1XQlJBnlZW3R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731639834; c=relaxed/simple;
	bh=sZLJCVskqYShc6w0q2B86DpKpHsPy4Srko1gL9CMaEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FfN0ksuopqkSnywYKTsFvNnd8JfjAiybVKMz6FVb6ileW/1bzTTB2EOiS4u1RrqdZZjgK2Oq9lDgmYispY+2yn4sxXQU+U1SC2V2srhMjgvj3/JCCBi1P7iYB1Sv6IMjEBFFfHte83e3y9LiI0cz+VcMpQH/XwK0yNc0ToV6p+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GcbXLzzc; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c7ee8fe6bso14402825ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 19:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1731639832; x=1732244632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LzrduDD5I5CT/EJOZvTHIxqcU26TJ739IMHWspLK/xs=;
        b=GcbXLzzcnV+W1Buanv81tlu+fpqcxVXchUEi4jW85qQzn7/m5o9MNgYu8eAYkE613v
         +B1bnnaLlEF/paxsEUo5+4ixaZAE8Yqk4MAJKtORcj0Bjrr7xUzN96kthC3+j6BSusZx
         X25suOuedZUJZIb3aOc+tOaDi0ZC0EyJlvk7cSkgPhlEMr/8YHJmp4B3uwvEiY/R5ixJ
         yWZ63hNcZEMnLHV2ShaW53FTWp/9ygQsYzdyT2E8tJE3xoT3KECA2FU7L35HL+laE226
         U8XIJq2AuljO0ujZ750V9/M2wJD2f/G6NsLE6r/x/RKmgyVUnUlDZHZgbER2upMapu2y
         vaLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731639832; x=1732244632;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LzrduDD5I5CT/EJOZvTHIxqcU26TJ739IMHWspLK/xs=;
        b=RUo3WxwfLj8R6fW81iex3G9XYemUJ+xx5w946nSvwiyMcMftMQdvMv8DqWD/H0B/w0
         FhAq+9kJ+vCgSSKIV4RdYGX/bKF0tyLz64aRBtivRhZcsN8ZuAFRrVKWk5tlDtYMP89n
         2DUZCG+w7VCP7fehVLp6Xi64OruRnH7E2W+G7SFXQxjwEjxnOEwLhoT5gt8H96+5UEHp
         IiF/g+H6JoJ9KJzC4YTxl3P2KcJ3XfFgJn6OKG5cNzmXBa7aJHnaGcwz7Tzlkj4jROwo
         j6DMAKFGWHIdN4uk3QCh0EBd+dBBdHRNtP3VNPbWu1fGCT4Bv+D5+M7y5KeDpdO9qD3N
         46+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVofKtUo7G+h6xhajpS2qi7ufsNwyRL20QsgZun+Pt8EjZKpcBR7IerD4kZ7s+V1REPB55XmwNq7ebiiEU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8TVVeF85jE72pbt248ifpduJeFbKB3rv+VQXN5EFpLY+0vxvd
	mK6ih3MeivomKECWoiOXfv5SfjCYkIANjrEuq3AKmyNHbgVL4amm+7yGf9hTBkE=
X-Google-Smtp-Source: AGHT+IFFScrGOGqyoY+ZCRvuSeEvmWSNpvWddykk8QrnIHF12Y6qC8VAElXEUPPl1dP1ZKRq1zPtQg==
X-Received: by 2002:a17:902:c407:b0:20c:9e9b:9614 with SMTP id d9443c01a7336-211d0d725c2mr14630525ad.15.1731639832089;
        Thu, 14 Nov 2024 19:03:52 -0800 (PST)
Received: from [10.84.149.95] ([203.208.167.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0ec8608sm3407505ad.96.2024.11.14.19.03.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 19:03:51 -0800 (PST)
Message-ID: <253e5fd0-7e98-43fd-b0d7-8a5b739ae4aa@bytedance.com>
Date: Fri, 15 Nov 2024 11:03:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] mm: introduce skip_none_ptes()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
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
 <d27a75fa-b968-43d3-bbd3-cc607feee495@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <d27a75fa-b968-43d3-bbd3-cc607feee495@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/11/15 05:19, David Hildenbrand wrote:
> On 14.11.24 13:51, Qi Zheng wrote:
>>
>>
>> On 2024/11/14 20:32, David Hildenbrand wrote:
>>> On 14.11.24 10:20, Qi Zheng wrote:
>>>>
>>>>
>>>> On 2024/11/14 16:04, David Hildenbrand wrote:
>>>>>
>>>>>>     static unsigned long zap_pte_range(struct mmu_gather *tlb,
>>>>>>                     struct vm_area_struct *vma, pmd_t *pmd,
>>>>>>                     unsigned long addr, unsigned long end,
>>>>>> @@ -1682,13 +1704,17 @@ static unsigned long zap_pte_range(struct
>>>>>> mmu_gather *tlb,
>>>>>>             pte_t ptent = ptep_get(pte);
>>>>>>             int max_nr;
>>>>>> -        nr = 1;
>>>>>> -        if (pte_none(ptent))
>>>>>> -            continue;
>>>>>> -
>>>>>>             if (need_resched())
>>>>>>                 break;
>>>>>> +        nr = skip_none_ptes(pte, addr, end);
>>>>>> +        if (nr) {
>>>>>> +            addr += PAGE_SIZE * nr;
>>>>>> +            if (addr == end)
>>>>>> +                break;
>>>>>> +            pte += nr;
>>>>>> +        }
>>>>>> +
>>>>>>             max_nr = (end - addr) / PAGE_SIZE;
>>>>>
>>>>> I dislike calculating max_nr twice, once here and once in 
>>>>> skip_non_ptes.
>>>>>
>>>>> Further, you're missing to update ptent here.
>>>>
>>>> Oh, my bad. However, with [PATCH v3 5/9], there will be no problem, but
>>>> there are still two ptep_get() and max_nr calculation.
>>>>
>>>> If you inline it you can
>>>>> avoid another ptep_get().
>>>>
>>>> Do you mean to inline the skip_none_ptes() into do_zap_pte_range()?
>>>
>>> Effectively moving this patch after #5, and have it be something like:
>>>
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 1949f5e0fece5..4f5d1e4c6688e 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -1667,8 +1667,21 @@ static inline int do_zap_pte_range(struct
>>> mmu_gather *tlb,
>>>           pte_t ptent = ptep_get(pte);
>>>           int max_nr = (end - addr) / PAGE_SIZE;
>>>
>>> -       if (pte_none(ptent))
>>> -               return 1;
>>> +       /* Skip all consecutive pte_none(). */
>>> +       if (pte_none(ptent)) {
>>> +               int nr;
>>> +
>>> +               for (nr = 1; nr < max_nr; nr++) {
>>> +                       ptent = ptep_get(pte + nr);
>>> +                       if (!pte_none(ptent))
>>> +                               break;
>>> +               }
>>> +               max_nr -= nr;
>>> +               if (!max_nr)
>>> +                       return nr;
>>> +               pte += nr;
>>> +               addr += nr * PAGE_SIZE;
>>> +       }
>>>
>>>           if (pte_present(ptent))
>>>                   return zap_present_ptes(tlb, vma, pte, ptent, max_nr,
>>>
>>>
>>> In the context of this patch this makes most sense.
>>>
>>> Regarding "count_pte_none" comment, I assume you talk about patch #7.
>>
>> Yes.
>>
>>>
>>> Can't you simply return the number of pte_none that you skipped here
>>> using another
>>> input variable, if really required?
>>
>> Suppose we add an input variable nr_skip to do_zap_pte_range(), you mean
>> to return the above nr to zap_pte_range() through:
> 
> Maybe "cur_none_nr" or something similar.

OK.

> 
>>
>> *nr_skip = nr;
>>
>> and then:
>>
>> zap_pte_range
>> --> nr = do_zap_pte_range(tlb, vma, pte, addr, end, details, &skip_nr,
>>                          rss, &force_flush, &force_break);
>>       if (can_reclaim_pt) {
>>           none_nr += count_pte_none(pte, nr);
>>           none_nr += nr_skip;
>>       }
>>
>> Right?
> 
> Yes. I did not look closely at the patch that adds the counting of 

Got it.

> pte_none though (to digest why it is required :) ).

Because 'none_nr == PTRS_PER_PTE' is used in patch #7 to detect
empty PTE page.

Looking forward to your more review feedback on this series.

Thanks!

> 

