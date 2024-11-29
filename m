Return-Path: <linux-kernel+bounces-425517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9F99DC31A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 12:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3695280A54
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 11:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2783B199FAF;
	Fri, 29 Nov 2024 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LI3W1Frk"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D4D33C5;
	Fri, 29 Nov 2024 11:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732880970; cv=none; b=qCKHKaW+CeWabrmhttAaK8kEyNFgHIPo1g+VskhVQFl11g0u9tq5U00DaPPE/jKNyOMKePJMRJ5+lvZFahiRlf4X/OR1zXYmRono5MewBlcTfFgs9qppL8+xgHsHED/URT1Le3yIOELFr/CBrcPRZZzWXJ8y9Pke+ty4m1v++l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732880970; c=relaxed/simple;
	bh=UCD5HWycmsJqe0eyXUAi4wCA+smYWVnmvgWXMPp+K8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JKouYTFvkvdsPqdqgq67m4n1vSWJgy8Pdhs3wY4jf8b0yvOqWibJAsG8eWrTE1Jzb/wouKes/7j2N1ClzOoh2+pXoZuT0+rdxx3ujtY54PdqaWc6RuaI/F3iIXSQmbjcT5Unh6tHzLXuMGWDocGkQyyFLhc1i88Sw1m0EoGAzJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LI3W1Frk; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7ea7e250c54so1189135a12.0;
        Fri, 29 Nov 2024 03:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732880967; x=1733485767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JvohXbC1xIIhRxSz1kKXy0ooSXTmRMBZW1naMoo6crM=;
        b=LI3W1FrkP4La2pt6tSO/6WDpXWvt9OVA+V/KNE8qz813rlP7AbzRhXw5g+c39Tf9Fe
         3FuBcO3bonA/HpznkJdtovBikLn58krtbKHw2ZKkPpBRanOYzohHwUxpCY7B0wknHoWz
         aPsFDh9+pZHiCmhbJXy+1Q44eZfz0SkObeJy9cr2h9Elcvx2P81S9H89z013Jj4wh+vZ
         yX3m37oilaaM6i3B4/TQnGA+EDKT7YATGKU0XWAq3eVQJI6X45iZZZX+XSjB7HUr7qye
         1vyr5y1hx6b/EovvDXPipaB6FBFgjBCvR/FvAX0m5ceaoxvDarQDqy9ASasMr9OlLWsH
         9xUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732880967; x=1733485767;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JvohXbC1xIIhRxSz1kKXy0ooSXTmRMBZW1naMoo6crM=;
        b=rYYAt+tcBW/YCZPfNCyeB2Txc1D4NKH+k6brZZDpiY66sucps10wYrH6NXTpd1ncsx
         ZR0vU7zgjmRanS0QY3W/Fr7hcKJ4qe/tyfG/SwhQ0MLazE/5eOCAGjA24hhTGUvJ/phL
         uHI10QEWKGZkBYnwXwMWN+PSKZycYR2Xx1PVG9c0EVTbmfqNtrAbOIQRK1n7a5A+Fkyk
         pHVl55a/0pKfqhJyCduKZBwnR0cYgyJKXSDvgzGUBDkhVj/BC+Rb2IG2naBXDGdhsjOY
         NS1zyE/6kC2IGGmslMQ281SCU+IS5Jzs6BmVZUqf0CIVUSzGLLaBS5F7WRncVtsWxXoj
         hACg==
X-Forwarded-Encrypted: i=1; AJvYcCUaLmqC5DBiZ6ixYW4zVTUzWwtKU6p8JcZXQjan/Pr9eta+PB5VxwgmAm7CtnTBYPivVlqRerJUVIbcvIIF@vger.kernel.org, AJvYcCV3GuXLix0uozov2eK++Fa3aM6uo5Iq+kTcNYy/fiGdwTmIeAc7cjUJHB9Y9wjkQHZIEFa9jLLNsiw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywshdo+Nq+hq4jNinXdwmrsJbJ73P69Rwx4o1SGbgcyEjSQWEk5
	UtpKrK6C81de6J0xW7wsKHc68s+UZ2bNPmjPcJQyckGMxV4QRiQ44JStZuDSZ+w=
X-Gm-Gg: ASbGncujFGsTN0yBLzJSoLQYc7b7MOVCERP817kHR6zjMAUhLZvGokaAnJrhkck1MOF
	a0xv3hLUIqzEqw/0p7JnnPAjIr80uzL9HKpwKuX5jHcuvD/U9BnzoFb+WIv5/Qu+qDS4g2jwoOX
	72eLUMTRWNoUmpIEtSwo3T9xTeQKDu0oXnSp4oPlvkBi3Ll1Bt6b/IWXdGTQXaJsxpXeWSEBka/
	uRTdQHmoHBWQAYHEbWdH+UpRiCsALMFvau4kfWnCWQ6+B3O6T/vgZIoTA==
X-Google-Smtp-Source: AGHT+IHYADrTLYbn/F3wRZyiquNzKdu1siH+ebN9lQjmcqt40Qz1W7l19OLUe7uSmkoCSHOWoWa77Q==
X-Received: by 2002:a05:6a20:1593:b0:1e0:ddf6:56ae with SMTP id adf61e73a8af0-1e0e0aaf88fmr16517282637.7.1732880966666;
        Fri, 29 Nov 2024 03:49:26 -0800 (PST)
Received: from [10.239.1.244] ([43.224.245.235])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c13982asm2943684a12.0.2024.11.29.03.49.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 03:49:26 -0800 (PST)
Message-ID: <6dbd2d37-91ca-4566-af4a-7b4153d2001c@gmail.com>
Date: Fri, 29 Nov 2024 19:49:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: add per-order mTHP swap-in
 fallback/fallback_charge counters
To: Lance Yang <ioworker0@gmail.com>, Barry Song <21cnbao@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Usama Arif <usamaarif642@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 Peter Xu <peterx@redhat.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20241122161443.34667-1-haowenchao22@gmail.com>
 <CAK1f24k6n1ngSicrSCv5jX+xa75t-7a3zZB4A95fUvDhteshEQ@mail.gmail.com>
 <CAGsJ_4w-u703LbrmnsgkNVzpFwFwY7tO9mFoo1RXGk3rb_r3mw@mail.gmail.com>
 <CAK1f24meJBDA1wzX56=2y2NQm7BVP6OudFXJuGnZuUFnZKUh+A@mail.gmail.com>
 <24ea047a-7294-4e7a-bf51-66b7f79f5085@gmail.com>
 <CAK1f24kj_0DsVYgZj3nH699jt2MN4AQ55w7gGoFaWM_zgceYSQ@mail.gmail.com>
 <CAGsJ_4yxuV77bR72PHs-_78qb3iud-mQ75VJAAGAsiD4ZsXP4A@mail.gmail.com>
 <CAK1f24n-HW_Rp5FRXrm3nVrzz=4w2=sL_PO9aoa9F3fvL1_1aw@mail.gmail.com>
Content-Language: en-US
From: Wenchao Hao <haowenchao22@gmail.com>
In-Reply-To: <CAK1f24n-HW_Rp5FRXrm3nVrzz=4w2=sL_PO9aoa9F3fvL1_1aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/11/24 15:28, Lance Yang wrote:
> On Sun, Nov 24, 2024 at 3:11 PM Barry Song <21cnbao@gmail.com> wrote:
>>
>> On Sun, Nov 24, 2024 at 2:56 PM Lance Yang <ioworker0@gmail.com> wrote:
>>>
>>> On Sat, Nov 23, 2024 at 9:17 PM Wenchao Hao <haowenchao22@gmail.com> wrote:
>>>>
>>>> On 2024/11/23 19:52, Lance Yang wrote:
>>>>> On Sat, Nov 23, 2024 at 6:27 PM Barry Song <21cnbao@gmail.com> wrote:
>>>>>>
>>>>>> On Sat, Nov 23, 2024 at 10:36 AM Lance Yang <ioworker0@gmail.com> wrote:
>>>>>>>
>>>>>>> Hi Wenchao,
>>>>>>>
>>>>>>> On Sat, Nov 23, 2024 at 12:14 AM Wenchao Hao <haowenchao22@gmail.com> wrote:
>>>>>>>>
>>>>>>>> Currently, large folio swap-in is supported, but we lack a method to
>>>>>>>> analyze their success ratio. Similar to anon_fault_fallback, we introduce
>>>>>>>> per-order mTHP swpin_fallback and swpin_fallback_charge counters for
>>>>>>>> calculating their success ratio. The new counters are located at:
>>>>>>>>
>>>>>>>> /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats/
>>>>>>>>         swpin_fallback
>>>>>>>>         swpin_fallback_charge
>>>>>>>>
>>>>>>>> Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>
>>>>>>>> ---
>>>>>>>> V2:
>>>>>>>>  Introduce swapin_fallback_charge, which increments if it fails to
>>>>>>>>  charge a huge page to memory despite successful allocation.
>>>>>>>>
>>>>>>>>  Documentation/admin-guide/mm/transhuge.rst | 10 ++++++++++
>>>>>>>>  include/linux/huge_mm.h                    |  2 ++
>>>>>>>>  mm/huge_memory.c                           |  6 ++++++
>>>>>>>>  mm/memory.c                                |  2 ++
>>>>>>>>  4 files changed, 20 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
>>>>>>>> index 5034915f4e8e..9c07612281b5 100644
>>>>>>>> --- a/Documentation/admin-guide/mm/transhuge.rst
>>>>>>>> +++ b/Documentation/admin-guide/mm/transhuge.rst
>>>>>>>> @@ -561,6 +561,16 @@ swpin
>>>>>>>>         is incremented every time a huge page is swapped in from a non-zswap
>>>>>>>>         swap device in one piece.
>>>>>>>>
>>>>>>>
>>>>>>> Would the following be better?
>>>>>>>
>>>>>>> +swpin_fallback
>>>>>>> +       is incremented if a huge page swapin fails to allocate or charge
>>>>>>> +       it and instead falls back to using small pages.
>>>>>>>
>>>>>>> +swpin_fallback_charge
>>>>>>> +       is incremented if a huge page swapin fails to charge it and instead
>>>>>>> +       falls back to using small pages even though the allocation was
>>>>>>> +       successful.
>>>>>>
>>>>>> much better, but it is better to align with "huge pages with
>>>>>> lower orders or small pages", not necessarily small pages:
>>>>>>
>>>>>> anon_fault_fallback
>>>>>> is incremented if a page fault fails to allocate or charge
>>>>>> a huge page and instead falls back to using huge pages with
>>>>>> lower orders or small pages.
>>>>>>
>>>>>> anon_fault_fallback_charge
>>>>>> is incremented if a page fault fails to charge a huge page and
>>>>>> instead falls back to using huge pages with lower orders or
>>>>>> small pages even though the allocation was successful.
>>>>>
>>>>> Right, I clearly overlooked that ;)
>>>>>
>>>>
>>>> Hi Lance and Barry,
>>>>
>>>> Do you think the following expression is clear? Compared to my original
>>>> version, I’ve removed the word “huge” from the first line, and it now
>>>> looks almost identical to anon_fault_fallback/anon_fault_fallback_charge.
>>>
>>> Well, that's fine with me. And let's see Barry's opinion as well ;)
>>
>> I still prefer Lance's version. The fallback path in it only needs to
>> be adjusted to
>> include huge pages with lower orders. In contrast, Wenchao's version feels less
>> natural to me because "page swapin" sounds quite odd - we often hear
>> "page fault,"
>> but we have never encountered "page swapin."
> 
> Yeah, it makes sense to me ~
> 
>>
>> So I mean:
>>
>>  swpin_fallback
>>         is incremented if swapin fails to allocate or charge a huge
>> page and instead
>>         falls back to using huge pages with lower orders or small pages.
>>
>>  swpin_fallback_charge
>>         is incremented if swapin fails to charge a huge page and instead
>>         falls back to using  huge pages with lower orders or small
>> pages even though
>>         the allocation was successful.
> 
> IHMO, much better and clearer than before ;)
> 

Hi,

Thank you both very much for your valuable suggestions. I am only
now able to respond to your emails due to a network issue.

I will make the revisions based on your feedback and send the third
version of the patch.

Should I include a "Reviewed-by" or any other tags?

Thanks again,
Wenchao


> Thank,
> Lance
> 
>>
>>>
>>> Thanks,
>>> Lance
>>>
>>>>
>>>> swpin_fallback
>>>>        is incremented if a page swapin fails to allocate or charge
>>>>        a huge page and instead falls back to using huge pages with
>>>>        lower orders or small pages.
>>>>
>>>> swpin_fallback_charge
>>>>        is incremented if a page swapin fails to charge a huge page and
>>>>        instead falls back to using huge pages with lower orders or
>>>>        small pages even though the allocation was successful.
>>>>
>>>> Thanks,
>>>> Wencaho
>>>>
>>>>> Thanks,
>>>>> Lance
>>>>>
>>>>>>
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Lance
>>>>>>>
>>>>>>>> +swpin_fallback
>>>>>>>> +       is incremented if a huge page swapin fails to allocate or charge
>>>>>>>> +       a huge page and instead falls back to using huge pages with
>>>>>>>> +       lower orders or small pages.
>>>>>>>> +
>>>>>>>> +swpin_fallback_charge
>>>>>>>> +       is incremented if a page swapin fails to charge a huge page and
>>>>>>>> +       instead falls back to using huge pages with lower orders or
>>>>>>>> +       small pages even though the allocation was successful.
>>>>>>>> +
>>>>>>>>  swpout
>>>>>>>>         is incremented every time a huge page is swapped out to a non-zswap
>>>>>>>>         swap device in one piece without splitting.
>>>>>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>>>>>>> index b94c2e8ee918..93e509b6c00e 100644
>>>>>>>> --- a/include/linux/huge_mm.h
>>>>>>>> +++ b/include/linux/huge_mm.h
>>>>>>>> @@ -121,6 +121,8 @@ enum mthp_stat_item {
>>>>>>>>         MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
>>>>>>>>         MTHP_STAT_ZSWPOUT,
>>>>>>>>         MTHP_STAT_SWPIN,
>>>>>>>> +       MTHP_STAT_SWPIN_FALLBACK,
>>>>>>>> +       MTHP_STAT_SWPIN_FALLBACK_CHARGE,
>>>>>>>>         MTHP_STAT_SWPOUT,
>>>>>>>>         MTHP_STAT_SWPOUT_FALLBACK,
>>>>>>>>         MTHP_STAT_SHMEM_ALLOC,
>>>>>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>>>>>> index ee335d96fc39..46749dded1c9 100644
>>>>>>>> --- a/mm/huge_memory.c
>>>>>>>> +++ b/mm/huge_memory.c
>>>>>>>> @@ -617,6 +617,8 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
>>>>>>>>  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
>>>>>>>>  DEFINE_MTHP_STAT_ATTR(zswpout, MTHP_STAT_ZSWPOUT);
>>>>>>>>  DEFINE_MTHP_STAT_ATTR(swpin, MTHP_STAT_SWPIN);
>>>>>>>> +DEFINE_MTHP_STAT_ATTR(swpin_fallback, MTHP_STAT_SWPIN_FALLBACK);
>>>>>>>> +DEFINE_MTHP_STAT_ATTR(swpin_fallback_charge, MTHP_STAT_SWPIN_FALLBACK_CHARGE);
>>>>>>>>  DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
>>>>>>>>  DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
>>>>>>>>  #ifdef CONFIG_SHMEM
>>>>>>>> @@ -637,6 +639,8 @@ static struct attribute *anon_stats_attrs[] = {
>>>>>>>>  #ifndef CONFIG_SHMEM
>>>>>>>>         &zswpout_attr.attr,
>>>>>>>>         &swpin_attr.attr,
>>>>>>>> +       &swpin_fallback_attr.attr,
>>>>>>>> +       &swpin_fallback_charge_attr.attr,
>>>>>>>>         &swpout_attr.attr,
>>>>>>>>         &swpout_fallback_attr.attr,
>>>>>>>>  #endif
>>>>>>>> @@ -669,6 +673,8 @@ static struct attribute *any_stats_attrs[] = {
>>>>>>>>  #ifdef CONFIG_SHMEM
>>>>>>>>         &zswpout_attr.attr,
>>>>>>>>         &swpin_attr.attr,
>>>>>>>> +       &swpin_fallback_attr.attr,
>>>>>>>> +       &swpin_fallback_charge_attr.attr,
>>>>>>>>         &swpout_attr.attr,
>>>>>>>>         &swpout_fallback_attr.attr,
>>>>>>>>  #endif
>>>>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>>>>> index 209885a4134f..774dfd309cfe 100644
>>>>>>>> --- a/mm/memory.c
>>>>>>>> +++ b/mm/memory.c
>>>>>>>> @@ -4189,8 +4189,10 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
>>>>>>>>                         if (!mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
>>>>>>>>                                                             gfp, entry))
>>>>>>>>                                 return folio;
>>>>>>>> +                       count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK_CHARGE);
>>>>>>>>                         folio_put(folio);
>>>>>>>>                 }
>>>>>>>> +               count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK);
>>>>>>>>                 order = next_order(&orders, order);
>>>>>>>>         }
>>>>>>>>
>>>>>>>> --
>>>>>>>> 2.45.0
>>>>>>>>
>>>>>>
>>
>> Thanks
>> Barry


