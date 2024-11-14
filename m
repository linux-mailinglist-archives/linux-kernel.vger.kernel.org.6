Return-Path: <linux-kernel+bounces-409318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E4C9C8B39
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F556286F7D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8504D1FAC5C;
	Thu, 14 Nov 2024 12:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gMmh6ctk"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4421FE0F5
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 12:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731588699; cv=none; b=Dv4C/PG3eEUMuYAixmCwXhJ67/qkfpe8eWai+6MR9xdZn3ilLQdXc6ONrHt43lWzc35uSbGPCFQRCTTcier3TOy/xAJCdBVSUkfY145Z5/TcBRisZdfF55hCOBAnL8jYnKvGEbDOG/sh3osJVMpPJkU8hLEvd8tS9mYUfRFMcko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731588699; c=relaxed/simple;
	bh=Dxfm1+UquUijGX5/OGQQhtSstZ6KeE83Y7Oiq3eYRe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IPZ10JvYJOA4GLzuvvph2GvRJLm8zbCsv2e+bQHMCfh91K/6FTQG08vyowY0eHONFW6SXGCk36FyvuzUF90bADlu/0+RSTtVpVX80Exjt345IGhA+E/zZeGpNtWqsUjul6oQQKvra6zFtNaTE6OSIL9sK0hXF2mzmQewMGQv/Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gMmh6ctk; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e4244fdc6so416172b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 04:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1731588697; x=1732193497; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZC5INDeabHnT71NmEDIa3Mv0iVBAAHNk77rjOFhIaNw=;
        b=gMmh6ctkeFVb9zh+Nhz+I9rksRAmz/USMMiKwcaBMVwu0UPebZzhaecz7NE1HR09BO
         MhcYg3pUmlPJMtQvuBTbk3im98pD/dHEZEJ8lfKz5xW8xE6Ye4mUYTJJLjuuDo8a9My9
         t2eZ79BlJ9Mu6DOwZ+0cf3U/2aExCne5z5uCowxvqDeRkP069Al7IbGaNdPFgUbftkWd
         2QbKp6qtI97ApIrWukycoRvj68gCEXTBHK9s2lzX5850RxPX1NBGQ1bAI8hRndMFvSC+
         yDBmPy4zoyaKYI4vnGTxQCJ8vtu8FQrTvzwurZvOoxVNx610QABM9Sj7SVziuk2W5DSV
         /s6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731588697; x=1732193497;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZC5INDeabHnT71NmEDIa3Mv0iVBAAHNk77rjOFhIaNw=;
        b=TCP7BF/sHA+cFvweIPFxdX8iHHifTBe5HwRg7fwNO7Oo0PxtKCjea0ZnqJQfOdurs7
         oSs5YZItAVVUrbs1w1gvDCwQdYZ+N+4okzr/xpZ8SO0tlo/kLIRB5eBJW6+ZMrq8RDR4
         X4KY3jEoECzpZkH29v8IIb3Hf1XLgIZXjW/5l1CbbfdhTMzDExAxdNTnfFlC+ZkS6wlt
         H6Wva3a9C9zEqidbxIWj+13GEwVsJGVhMoz7eh++zOsHJc2I2f9cRPJmC0UWkJB4lUIX
         8KcSnJYVPRwo/wQq6m/5DVApMHTiXQymQQVcEP1TwPNMcNMY0p0OaIFuJmyD6DTR9KN/
         72xw==
X-Forwarded-Encrypted: i=1; AJvYcCU6hZ3s+3Yb9gG5Sz5WVasFpFUO5fZ2M9tkpYW+2tHMgp6OfHOyQw/2KC+STg0JYm1h83yqlXoxRtcZN90=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcwebOCzFGsXKdWReS1cN9jtv0Rs1BKXpfcqPz6JKnL7pB7FoP
	AJAgx8jmRhELnm0Iow2ZNQF3r7vY1ufDhgplftD8zfeWa6VyRzZxGKrQtvdxrBQ=
X-Google-Smtp-Source: AGHT+IE6YNcQajPHmUZtx2yiT0fJOw3M/4hiatkcBJRSA6HMdKocYS46njw84M/KfuTqyRFvYDdTaw==
X-Received: by 2002:a05:6a00:3d52:b0:71e:3b51:e850 with SMTP id d2e1a72fcca58-72469c5e105mr2873394b3a.2.1731588696726;
        Thu, 14 Nov 2024 04:51:36 -0800 (PST)
Received: from [10.84.149.95] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7246a9bf773sm1155490b3a.159.2024.11.14.04.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 04:51:36 -0800 (PST)
Message-ID: <b524a568-fa3b-4618-80cc-e8c31ea4eeac@bytedance.com>
Date: Thu, 14 Nov 2024 20:51:27 +0800
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
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <fa3fc933-cd51-4be5-944e-250da9289eda@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/11/14 20:32, David Hildenbrand wrote:
> On 14.11.24 10:20, Qi Zheng wrote:
>>
>>
>> On 2024/11/14 16:04, David Hildenbrand wrote:
>>>
>>>>    static unsigned long zap_pte_range(struct mmu_gather *tlb,
>>>>                    struct vm_area_struct *vma, pmd_t *pmd,
>>>>                    unsigned long addr, unsigned long end,
>>>> @@ -1682,13 +1704,17 @@ static unsigned long zap_pte_range(struct
>>>> mmu_gather *tlb,
>>>>            pte_t ptent = ptep_get(pte);
>>>>            int max_nr;
>>>> -        nr = 1;
>>>> -        if (pte_none(ptent))
>>>> -            continue;
>>>> -
>>>>            if (need_resched())
>>>>                break;
>>>> +        nr = skip_none_ptes(pte, addr, end);
>>>> +        if (nr) {
>>>> +            addr += PAGE_SIZE * nr;
>>>> +            if (addr == end)
>>>> +                break;
>>>> +            pte += nr;
>>>> +        }
>>>> +
>>>>            max_nr = (end - addr) / PAGE_SIZE;
>>>
>>> I dislike calculating max_nr twice, once here and once in skip_non_ptes.
>>>
>>> Further, you're missing to update ptent here.
>>
>> Oh, my bad. However, with [PATCH v3 5/9], there will be no problem, but
>> there are still two ptep_get() and max_nr calculation.
>>
>> If you inline it you can
>>> avoid another ptep_get().
>>
>> Do you mean to inline the skip_none_ptes() into do_zap_pte_range()?
> 
> Effectively moving this patch after #5, and have it be something like:
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 1949f5e0fece5..4f5d1e4c6688e 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1667,8 +1667,21 @@ static inline int do_zap_pte_range(struct 
> mmu_gather *tlb,
>          pte_t ptent = ptep_get(pte);
>          int max_nr = (end - addr) / PAGE_SIZE;
> 
> -       if (pte_none(ptent))
> -               return 1;
> +       /* Skip all consecutive pte_none(). */
> +       if (pte_none(ptent)) {
> +               int nr;
> +
> +               for (nr = 1; nr < max_nr; nr++) {
> +                       ptent = ptep_get(pte + nr);
> +                       if (!pte_none(ptent))
> +                               break;
> +               }
> +               max_nr -= nr;
> +               if (!max_nr)
> +                       return nr;
> +               pte += nr;
> +               addr += nr * PAGE_SIZE;
> +       }
> 
>          if (pte_present(ptent))
>                  return zap_present_ptes(tlb, vma, pte, ptent, max_nr,
> 
> 
> In the context of this patch this makes most sense.
> 
> Regarding "count_pte_none" comment, I assume you talk about patch #7.

Yes.

> 
> Can't you simply return the number of pte_none that you skipped here 
> using another
> input variable, if really required?

Suppose we add an input variable nr_skip to do_zap_pte_range(), you mean
to return the above nr to zap_pte_range() through:

*nr_skip = nr;

and then:

zap_pte_range
--> nr = do_zap_pte_range(tlb, vma, pte, addr, end, details, &skip_nr,
  				      rss, &force_flush, &force_break);
     if (can_reclaim_pt) {
         none_nr += count_pte_none(pte, nr);
         none_nr += nr_skip;
     }

Right?

> 

