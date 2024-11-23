Return-Path: <linux-kernel+bounces-419079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 749959D6937
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 14:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC54216159F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 13:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D3B197549;
	Sat, 23 Nov 2024 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3+PxoNg"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF13A14F9E9;
	Sat, 23 Nov 2024 13:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732367867; cv=none; b=Jis8E6biJvjdm6CyTLfEiI5kLDnWHD84zkfw0swXoOPUi/4vFIPjF+iMXsOY6U+Olex9JqlbqZ/uv/Vz3tzZWlhuhAUsy6hn0MuAawpPKKDJusP1Tyb2iHN3e236jxZcJjiz83f45cdAq6IzZpVamrI9CD9G4RHE/fzWkNDcDPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732367867; c=relaxed/simple;
	bh=wRvYZvYSnnJIoD1Ty07qk2G1peUCzMwq6fr5D36Itt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RJaZx8glGwiufKKzKSmg20b5Rj+li0asgfLvOnKQBn1VNZbRvlCk90Skm5k+faTum5+31mc37RiQPCGyd3d9FqfA3eOhtcUDPqISbTEBiYL3TQTN2f7D4woeCFhERj9PpBttMC1SjAQIRmZvbP6b6+EBLt4crGT2uuhbL9PQsJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3+PxoNg; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ea568d8216so2574807a91.1;
        Sat, 23 Nov 2024 05:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732367865; x=1732972665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BM4r1HEBrTnTWqy/E6iTOqwcoKUdMj3yu2jdBDSd560=;
        b=e3+PxoNgaWf0xmGsQKbnleq1YBd6PSRSd3lV7FxAZwaozxbIoE9H04bkQofpEV6o8U
         XWXTmWs/YxMuXU+Qv0PKC1PaaC0EeoOVGd6SZW6AY7f3ZRWUBXQPQiXYLTroLHZG1Z17
         OHB45JpW54uxN9BbuldxEXfsPjpGVsdEBbh09uWdBRXB7s5n7YFSWrMx8ovoFMMNq3xK
         ed9cDhIYlS//aG58y6bOe679bCtqfavZAA4Re90KYRwz5h9IXybYLgFUWE+IuLyXo5CR
         Xk4nRllB+34lnL6GZOXx1yBgqzsxjBPyo6fY5Cnrx45t9wR/HtxHgQMFD1ZcM6ggBj+v
         qoLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732367865; x=1732972665;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BM4r1HEBrTnTWqy/E6iTOqwcoKUdMj3yu2jdBDSd560=;
        b=PbAXl5vfDrILOQgIHHyOjnYBriTGOvNwLOIvz5CzkwrwW0onolPm9EuazjbDiaxL/w
         xAfljXdccfj/tXTT9UxOQbHHQVyfqkIkV6t1Op8/ZC9Nc+hFW67HeLhVFzKcf+Nm/bEC
         ezezRVD0F32V5M9hk4jPwZSJ0uwaYHqaZuzXL5uqQJJ0ZPMUscfBdZO+gRCmWYGVEgjl
         MN3YU2vaQrim5fuj4zRjzSk/y9ML5zz1dDJEpN/ZnBKrHXVNBg035InY51KGCK9gZ1F3
         d268x8RRnf4AgPgUIFPaxapPaccVXqdIGnI/7nPLStSYm+oRTsU/hlTAbS+zGpdHc5aX
         0F+w==
X-Forwarded-Encrypted: i=1; AJvYcCUGkrfSB4poh+/bN6ltDoroq5+HH0O6pOByblvfBRsfVhoA09QYQpExQw8gOVUa15SRK2PbGPiFvOI=@vger.kernel.org, AJvYcCWwvggmCwDt6d9FNF+/ulkUbCboB3Zzk1wx6UDLXDbmeB/0hgqHiQAXu+ueYrhJuN16xLKvfsiW0iYAjg9s@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy/Lg2zY+o1F3nfvBz3JtffvSFgztr55uiD5Yls26l7Itk0w/A
	vJV/wrcdqHWQ8PHkg/z/62z4NsbgPTogbfLcA7WO/lrIYRWIqtJt
X-Gm-Gg: ASbGnctxAUwkqYUGXo/EMg/EqCHaLovoCdrqGm9czY7Ujpels5XpipPs6owEjO7OmKu
	0GpefS1zpmPOfcF9lYqDWEwqYe8+oNzOfCbJccB11HoXydeUySt0T9jmbeUy0VJB6U/efPVtRBg
	wb37xX18YVmlzMMi65Syl+16RZZ/gad5Q/Lbnrx6XrW+HHNfk1IJacWWhSOs4t87Eo4R7LB2xLN
	POv1RtQ/X/S1ArABRxDO4nm+Cv2WYJE9q/BuOvMeZt/HV8UN7Varyfyadqft7TwLpnHbEsmOwed
	+ueyucI2kezWHxY4G61WC5FMVfzBDBESb9TbTxJZ0XKS
X-Google-Smtp-Source: AGHT+IFquSV2OHVBBP4S/5O/ly8yiowqeOIk+QFZcCeDyWYWH1WyuRZ2Dca8iG3StAYanBwj/x92ag==
X-Received: by 2002:a17:90a:d40b:b0:2ea:5dcf:6f5d with SMTP id 98e67ed59e1d1-2eb0e528054mr8675157a91.16.1732367864945;
        Sat, 23 Nov 2024 05:17:44 -0800 (PST)
Received: from ?IPV6:2408:843e:480:254b:48e9:fef4:2ffc:1729? ([2408:843e:480:254b:48e9:fef4:2ffc:1729])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eb0d048c41sm3654599a91.41.2024.11.23.05.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Nov 2024 05:17:44 -0800 (PST)
Message-ID: <24ea047a-7294-4e7a-bf51-66b7f79f5085@gmail.com>
Date: Sat, 23 Nov 2024 21:17:32 +0800
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
Content-Language: en-US
From: Wenchao Hao <haowenchao22@gmail.com>
In-Reply-To: <CAK1f24meJBDA1wzX56=2y2NQm7BVP6OudFXJuGnZuUFnZKUh+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/11/23 19:52, Lance Yang wrote:
> On Sat, Nov 23, 2024 at 6:27 PM Barry Song <21cnbao@gmail.com> wrote:
>>
>> On Sat, Nov 23, 2024 at 10:36 AM Lance Yang <ioworker0@gmail.com> wrote:
>>>
>>> Hi Wenchao,
>>>
>>> On Sat, Nov 23, 2024 at 12:14 AM Wenchao Hao <haowenchao22@gmail.com> wrote:
>>>>
>>>> Currently, large folio swap-in is supported, but we lack a method to
>>>> analyze their success ratio. Similar to anon_fault_fallback, we introduce
>>>> per-order mTHP swpin_fallback and swpin_fallback_charge counters for
>>>> calculating their success ratio. The new counters are located at:
>>>>
>>>> /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats/
>>>>         swpin_fallback
>>>>         swpin_fallback_charge
>>>>
>>>> Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>
>>>> ---
>>>> V2:
>>>>  Introduce swapin_fallback_charge, which increments if it fails to
>>>>  charge a huge page to memory despite successful allocation.
>>>>
>>>>  Documentation/admin-guide/mm/transhuge.rst | 10 ++++++++++
>>>>  include/linux/huge_mm.h                    |  2 ++
>>>>  mm/huge_memory.c                           |  6 ++++++
>>>>  mm/memory.c                                |  2 ++
>>>>  4 files changed, 20 insertions(+)
>>>>
>>>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
>>>> index 5034915f4e8e..9c07612281b5 100644
>>>> --- a/Documentation/admin-guide/mm/transhuge.rst
>>>> +++ b/Documentation/admin-guide/mm/transhuge.rst
>>>> @@ -561,6 +561,16 @@ swpin
>>>>         is incremented every time a huge page is swapped in from a non-zswap
>>>>         swap device in one piece.
>>>>
>>>
>>> Would the following be better?
>>>
>>> +swpin_fallback
>>> +       is incremented if a huge page swapin fails to allocate or charge
>>> +       it and instead falls back to using small pages.
>>>
>>> +swpin_fallback_charge
>>> +       is incremented if a huge page swapin fails to charge it and instead
>>> +       falls back to using small pages even though the allocation was
>>> +       successful.
>>
>> much better, but it is better to align with "huge pages with
>> lower orders or small pages", not necessarily small pages:
>>
>> anon_fault_fallback
>> is incremented if a page fault fails to allocate or charge
>> a huge page and instead falls back to using huge pages with
>> lower orders or small pages.
>>
>> anon_fault_fallback_charge
>> is incremented if a page fault fails to charge a huge page and
>> instead falls back to using huge pages with lower orders or
>> small pages even though the allocation was successful.
> 
> Right, I clearly overlooked that ;)
> 

Hi Lance and Barry,

Do you think the following expression is clear? Compared to my original
version, I’ve removed the word “huge” from the first line, and it now
looks almost identical to anon_fault_fallback/anon_fault_fallback_charge.

swpin_fallback
       is incremented if a page swapin fails to allocate or charge
       a huge page and instead falls back to using huge pages with
       lower orders or small pages.

swpin_fallback_charge
       is incremented if a page swapin fails to charge a huge page and
       instead falls back to using huge pages with lower orders or
       small pages even though the allocation was successful.

Thanks,
Wencaho

> Thanks,
> Lance
> 
>>
>>>
>>> Thanks,
>>> Lance
>>>
>>>> +swpin_fallback
>>>> +       is incremented if a huge page swapin fails to allocate or charge
>>>> +       a huge page and instead falls back to using huge pages with
>>>> +       lower orders or small pages.
>>>> +
>>>> +swpin_fallback_charge
>>>> +       is incremented if a page swapin fails to charge a huge page and
>>>> +       instead falls back to using huge pages with lower orders or
>>>> +       small pages even though the allocation was successful.
>>>> +
>>>>  swpout
>>>>         is incremented every time a huge page is swapped out to a non-zswap
>>>>         swap device in one piece without splitting.
>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>>> index b94c2e8ee918..93e509b6c00e 100644
>>>> --- a/include/linux/huge_mm.h
>>>> +++ b/include/linux/huge_mm.h
>>>> @@ -121,6 +121,8 @@ enum mthp_stat_item {
>>>>         MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
>>>>         MTHP_STAT_ZSWPOUT,
>>>>         MTHP_STAT_SWPIN,
>>>> +       MTHP_STAT_SWPIN_FALLBACK,
>>>> +       MTHP_STAT_SWPIN_FALLBACK_CHARGE,
>>>>         MTHP_STAT_SWPOUT,
>>>>         MTHP_STAT_SWPOUT_FALLBACK,
>>>>         MTHP_STAT_SHMEM_ALLOC,
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index ee335d96fc39..46749dded1c9 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -617,6 +617,8 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
>>>>  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
>>>>  DEFINE_MTHP_STAT_ATTR(zswpout, MTHP_STAT_ZSWPOUT);
>>>>  DEFINE_MTHP_STAT_ATTR(swpin, MTHP_STAT_SWPIN);
>>>> +DEFINE_MTHP_STAT_ATTR(swpin_fallback, MTHP_STAT_SWPIN_FALLBACK);
>>>> +DEFINE_MTHP_STAT_ATTR(swpin_fallback_charge, MTHP_STAT_SWPIN_FALLBACK_CHARGE);
>>>>  DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
>>>>  DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
>>>>  #ifdef CONFIG_SHMEM
>>>> @@ -637,6 +639,8 @@ static struct attribute *anon_stats_attrs[] = {
>>>>  #ifndef CONFIG_SHMEM
>>>>         &zswpout_attr.attr,
>>>>         &swpin_attr.attr,
>>>> +       &swpin_fallback_attr.attr,
>>>> +       &swpin_fallback_charge_attr.attr,
>>>>         &swpout_attr.attr,
>>>>         &swpout_fallback_attr.attr,
>>>>  #endif
>>>> @@ -669,6 +673,8 @@ static struct attribute *any_stats_attrs[] = {
>>>>  #ifdef CONFIG_SHMEM
>>>>         &zswpout_attr.attr,
>>>>         &swpin_attr.attr,
>>>> +       &swpin_fallback_attr.attr,
>>>> +       &swpin_fallback_charge_attr.attr,
>>>>         &swpout_attr.attr,
>>>>         &swpout_fallback_attr.attr,
>>>>  #endif
>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>> index 209885a4134f..774dfd309cfe 100644
>>>> --- a/mm/memory.c
>>>> +++ b/mm/memory.c
>>>> @@ -4189,8 +4189,10 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
>>>>                         if (!mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
>>>>                                                             gfp, entry))
>>>>                                 return folio;
>>>> +                       count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK_CHARGE);
>>>>                         folio_put(folio);
>>>>                 }
>>>> +               count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK);
>>>>                 order = next_order(&orders, order);
>>>>         }
>>>>
>>>> --
>>>> 2.45.0
>>>>
>>
>> Thanks
>> Barry


