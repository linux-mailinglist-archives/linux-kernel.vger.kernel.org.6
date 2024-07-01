Return-Path: <linux-kernel+bounces-235881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 167E691DABF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F1751F23284
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB0F12C550;
	Mon,  1 Jul 2024 08:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SdgXWCDW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2014783A0D
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719824190; cv=none; b=uSF/Ej2Ga9/ej4viOppzI2GfD1E4kXHpcY7VTn618mwMudq0AHrJtcpF0nPrZ7ymXAVcm35woDNJkWGQ8hgmMgR+vQlOx03GzeQTFNNgaQcc02el7LMtmytJTx8+8SqT6UFRKPWnAF8NG5nNLeg3cVV1KHJJfWpoqFZT2FSz/eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719824190; c=relaxed/simple;
	bh=6zP324or3FXAFOO8Z7tWLyuOP09zs7+juy2xLJrsppQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jSv0UkDNWFVJH3xxM3otv1rvMiY1Yjk2EjyHSSWa22Y5nclqjS35PhmqjwiFrCiqXQMBte1+MenVzt1qjRNVM56bF3pmk6BG7HHy9X2QaWZIf6kCmNEeq+UDio4xf66gToAtlykJwis/IpNg1N06R42UYNkbdSNP0iL9fATDv6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SdgXWCDW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719824187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=prOrLzfU76m66ukvhw0tQ8YfV+62dZpBOHnYZcLd14Y=;
	b=SdgXWCDWzVgy2cqlBiHqhzDG+rxNzrS9EahqMdg3hZ9qu+cqfmcTjINLxTFLVdDg/6dNvj
	kV/5+mXN07xfYlTdmaSut0/yIth0PyKpQmr9UMP5PEDkl/lEqpGT7fh/I9TGRpvj2CpXZ4
	m9T+kXv3po/EXBwbUnP6LE60eH995e4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-0p2wUqm4P-uS9TUjCXUHkA-1; Mon, 01 Jul 2024 04:56:26 -0400
X-MC-Unique: 0p2wUqm4P-uS9TUjCXUHkA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a751edc86bdso91001766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 01:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719824185; x=1720428985;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prOrLzfU76m66ukvhw0tQ8YfV+62dZpBOHnYZcLd14Y=;
        b=NmxjwdPeRbT24Puu11yUWnIYC5We+PQNrFpXUXJgvJFin+kvaqUtS3LN5xBrvRRyZ6
         7tIQw4j83mxKkSY7zFWinXIl5cQtUCGwUlVbCle9l0Pia3WzUdrOAiZUNDzUwJcHUjfu
         R89eZYyq9t3LqKWjipTz972mf+rJAHdDHcX0kWZwpg5fbsz/DLHCQeS0A/qX0dPd/l7N
         hZj2SbPgnBHqacajIvFiecuKbj3XhOvG4NRDjUeaFQj/xrtw/rv4fi1+u294ziqTryQa
         76BifkHbL9NRFDC+ENntwkmuyQpcHihRogtnTSptrixCnb+r1crf/U6KZSMVYQlkwa0m
         +iTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6FZHhXJN3BYgINZR5IhNDEdS0ZU+aCp813VE0BTQvA83sOGqZWRJIHHmKaWHUqDT3SMSp65rWi1RZfZhZBmBNNisvjjVKzMl/N7A6
X-Gm-Message-State: AOJu0YwnyF28UWKfg/hVLTzjYI1Yoq9ek4daLN5yoMSCXrR4sXdUNczr
	+xEq3WtDMPovfDpVQJvPeYYyhtc+xfIIpr8Llieg8K9ZpR2Kekejez7KMkeua440ugW27BdDOns
	sN2vYqGHRPU5DCbmhPBcbFEpQvwGtDxY4gXig1JnF21Vdq94Fv9K0BDVhksZS8THiSDjd9w==
X-Received: by 2002:a17:906:c14c:b0:a72:8c16:b1d1 with SMTP id a640c23a62f3a-a7514495889mr323767066b.51.1719824185460;
        Mon, 01 Jul 2024 01:56:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsv2Dx/Fh1RI653d0kZaTSGZhe8hYWnI6W4OlVT+5htZtpYH+SWgMqDMFe5bNUiaCdUwTLUA==
X-Received: by 2002:a17:906:c14c:b0:a72:8c16:b1d1 with SMTP id a640c23a62f3a-a7514495889mr323765466b.51.1719824184981;
        Mon, 01 Jul 2024 01:56:24 -0700 (PDT)
Received: from [100.81.188.195] ([178.24.249.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ae5ac5b8sm301274666b.14.2024.07.01.01.56.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 01:56:24 -0700 (PDT)
Message-ID: <23d9f708-b1fd-4b10-b755-b7ef6aa683e8@redhat.com>
Date: Mon, 1 Jul 2024 10:56:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: add per-order mTHP split counters
To: Barry Song <baohua@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>
Cc: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org,
 baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240424135148.30422-1-ioworker0@gmail.com>
 <20240424135148.30422-2-ioworker0@gmail.com>
 <a0f57d90-a556-4b19-a925-a82a81fbb067@arm.com>
 <CAGsJ_4xSKWXGY9TPS_kvhp7FALH16cyVnZu5FkHy3nN_hsZ_kQ@mail.gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4xSKWXGY9TPS_kvhp7FALH16cyVnZu5FkHy3nN_hsZ_kQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30.06.24 11:48, Barry Song wrote:
> On Thu, Apr 25, 2024 at 3:41 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> + Barry
>>
>> On 24/04/2024 14:51, Lance Yang wrote:
>>> At present, the split counters in THP statistics no longer include
>>> PTE-mapped mTHP. Therefore, this commit introduces per-order mTHP split
>>> counters to monitor the frequency of mTHP splits. This will assist
>>> developers in better analyzing and optimizing system performance.
>>>
>>> /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
>>>          split_page
>>>          split_page_failed
>>>          deferred_split_page
>>>
>>> Signed-off-by: Lance Yang <ioworker0@gmail.com>
>>> ---
>>>   include/linux/huge_mm.h |  3 +++
>>>   mm/huge_memory.c        | 14 ++++++++++++--
>>>   2 files changed, 15 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>> index 56c7ea73090b..7b9c6590e1f7 100644
>>> --- a/include/linux/huge_mm.h
>>> +++ b/include/linux/huge_mm.h
>>> @@ -272,6 +272,9 @@ enum mthp_stat_item {
>>>        MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
>>>        MTHP_STAT_ANON_SWPOUT,
>>>        MTHP_STAT_ANON_SWPOUT_FALLBACK,
>>> +     MTHP_STAT_SPLIT_PAGE,
>>> +     MTHP_STAT_SPLIT_PAGE_FAILED,
>>> +     MTHP_STAT_DEFERRED_SPLIT_PAGE,
>>>        __MTHP_STAT_COUNT
>>>   };
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 055df5aac7c3..52db888e47a6 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -557,6 +557,9 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
>>>   DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
>>>   DEFINE_MTHP_STAT_ATTR(anon_swpout, MTHP_STAT_ANON_SWPOUT);
>>>   DEFINE_MTHP_STAT_ATTR(anon_swpout_fallback, MTHP_STAT_ANON_SWPOUT_FALLBACK);
>>> +DEFINE_MTHP_STAT_ATTR(split_page, MTHP_STAT_SPLIT_PAGE);
>>> +DEFINE_MTHP_STAT_ATTR(split_page_failed, MTHP_STAT_SPLIT_PAGE_FAILED);
>>> +DEFINE_MTHP_STAT_ATTR(deferred_split_page, MTHP_STAT_DEFERRED_SPLIT_PAGE);
>>>
>>>   static struct attribute *stats_attrs[] = {
>>>        &anon_fault_alloc_attr.attr,
>>> @@ -564,6 +567,9 @@ static struct attribute *stats_attrs[] = {
>>>        &anon_fault_fallback_charge_attr.attr,
>>>        &anon_swpout_attr.attr,
>>>        &anon_swpout_fallback_attr.attr,
>>> +     &split_page_attr.attr,
>>> +     &split_page_failed_attr.attr,
>>> +     &deferred_split_page_attr.attr,
>>>        NULL,
>>>   };
>>>
>>> @@ -3083,7 +3089,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>>>        XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_order);
>>>        struct anon_vma *anon_vma = NULL;
>>>        struct address_space *mapping = NULL;
>>> -     bool is_thp = folio_test_pmd_mappable(folio);
>>> +     int order = folio_order(folio);
>>>        int extra_pins, ret;
>>>        pgoff_t end;
>>>        bool is_hzp;
>>> @@ -3262,8 +3268,10 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>>>                i_mmap_unlock_read(mapping);
>>>   out:
>>>        xas_destroy(&xas);
>>> -     if (is_thp)
>>> +     if (order >= HPAGE_PMD_ORDER)
>>>                count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAILED);
>>> +     count_mthp_stat(order, !ret ? MTHP_STAT_SPLIT_PAGE :
>>> +                                   MTHP_STAT_SPLIT_PAGE_FAILED);
>>>        return ret;
>>>   }
>>>
>>> @@ -3327,6 +3335,8 @@ void deferred_split_folio(struct folio *folio)
>>>        if (list_empty(&folio->_deferred_list)) {
>>>                if (folio_test_pmd_mappable(folio))
>>>                        count_vm_event(THP_DEFERRED_SPLIT_PAGE);
>>> +             count_mthp_stat(folio_order(folio),
>>> +                             MTHP_STAT_DEFERRED_SPLIT_PAGE);
>>
>> There is a very long conversation with Barry about adding a 'global "mTHP became
>> partially mapped 1 or more processes" counter (inc only)', which terminates at
>> [1]. There is a lot of discussion about the required semantics around the need
>> for partial map to cover alignment and contiguity as well as whether all pages
>> are mapped, and to trigger once it becomes partial in at least 1 process.
>>
>> MTHP_STAT_DEFERRED_SPLIT_PAGE is giving much simpler semantics, but less
>> information as a result. Barry, what's your view here? I'm guessing this doesn't
>> quite solve what you are looking for?
> 
> This doesn't quite solve what I am looking for but I still think the
> patch has its value.
> 
> I'm looking for a solution that can:
> 
>    *  Count the amount of memory in the system for each mTHP size.
>    *  Determine how much memory for each mTHP size is partially unmapped.
> 
> For example, in a system with 16GB of memory, we might find that we have 3GB
> of 64KB mTHP, and within that, 512MB is partially unmapped, potentially wasting
> memory at this moment.  I'm uncertain whether Lance is interested in
> this job :-)
> 
> Counting deferred_split remains valuable as it can signal whether the system is
> experiencing significant partial unmapping.

I'll note that, especially without subpage mapcounts, in the future we 
won't have that information (how much is currently mapped) readily 
available in all cases. To obtain that information on demand, we'd have 
to scan page tables or walk the rmap.

Something to keep in mind: we don't want to introduce counters that will 
be expensive to maintain longterm.

-- 
Cheers,

David / dhildenb


