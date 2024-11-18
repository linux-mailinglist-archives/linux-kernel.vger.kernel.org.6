Return-Path: <linux-kernel+bounces-412795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8104F9D0F16
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 103C21F22310
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94445194A49;
	Mon, 18 Nov 2024 11:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TMDcFYfT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238F715539D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731927599; cv=none; b=KVCrsvv9SnvkE68aW0+GIJXIlgqPpvw9CPfBtT/1AQ81sIUv1aGDX8nG4r4mGBvItGwa0UoXJysgrZ5ck1ogtEuiAFOdQQALC11KzODev8BK1GgNlrA/9+3+jf2mOO2+V6AqEY0zeXEhhX3j0OPCIo66mXHU8zVrBGiiHG+nHD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731927599; c=relaxed/simple;
	bh=wl5c/1f1knQaitAWroN1temBY6UgtK3SwSxWiCRdj3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WPSu5QGIdMT2NUGEKLRooCTsLQ8BkfE2/rx2IDDONj4t6OoHkNnzNoKHBDfTGnjm2YSxvcTPibmvZ0yjgb0DNWzywOeD7yUSv8gQCxUlyqFARG/oOWmlOyUrxQXyEQ5Ov6Jj2jlCleZwJrshdwke5VYYt/Tx0rYzhVG7tsjteuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TMDcFYfT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731927596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1wMqDUVzgNC0qXtX2cYv3nDHAnhBB0vwZg9W4bqUe9s=;
	b=TMDcFYfTWwAiVX90X7cMBb8c2bl7SRjE3BdV6DkMATcXDHbD7AWliwNG/9Gc9O7b+h7QDD
	eUnF5l9LVtYU2EHNg57XaO6m/hbk7OtRmoRfN9dzN24OMtqKj4Hqlit2fxZQe1UDzSojM+
	qQI1oyfUEbqhBGBJlFKmPkm2GKwLRFs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-9SrJ2haSPvODBAGknGKQ3w-1; Mon, 18 Nov 2024 05:59:55 -0500
X-MC-Unique: 9SrJ2haSPvODBAGknGKQ3w-1
X-Mimecast-MFC-AGG-ID: 9SrJ2haSPvODBAGknGKQ3w
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a9a157d028aso139924566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 02:59:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731927594; x=1732532394;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1wMqDUVzgNC0qXtX2cYv3nDHAnhBB0vwZg9W4bqUe9s=;
        b=BUqw4U9hgAuqT60X3qH+wIZdtXJtwS6pRuV5jQ0NvImCIVJVU1LdUCtmvHMkawWMaI
         8do7atwF6LfRBdy3NATRexWfREMbRhwfnMGrXVLoIbQov2wI381RxJo89rrB8pMBqVjT
         faSC3PvA3gdZUaEdoFBDXEueozwO5kQmGCjSeB97QaWqhno9VY1syz7UE1yJxjSA5p62
         wPYPB7jcBJZQH9Uu1PBIp+WyLSzDF4q6mehqGPanJIff/OCmuJpTt7MVlWJc61c8+SBC
         IA54c7BKrwiekT47v6pImJhogRCjiTsp8htsMPlNmObQJGlxpRoJukOfkFdSXFlAK5mA
         HnIA==
X-Forwarded-Encrypted: i=1; AJvYcCXVUThZh6Ub2D7k+4pcAaGpmcULwd+FwBvi2wks0XC8T2N5YnEEPrpaLANoK21s4YTHz5qCRh4TcNEbAVs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlgv20UXHNhi0J8iEEt/FMc6rLBwIwYORcIrAggMz04VX08aRE
	Y93b1r//L32hEIEBvKy3AYlZS2AbD7Z21mJ6cLiS6hpGeZKrIVSaIpbWx5bNd0VC6xZ/rIWoZ1V
	zqrJ4x9BSSIP8euE90c5NdrdnI7aTP09sXNEFf6ZYvZVcth6ZX50bVoy0g1T1Rw==
X-Received: by 2002:a17:907:3f95:b0:a7a:9144:e23a with SMTP id a640c23a62f3a-aa483525e00mr1185959766b.43.1731927594234;
        Mon, 18 Nov 2024 02:59:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHldu5VwCsGt5DJR0xt3dYHYen26VZKvia9lnlnxj3BgeywbNStcdMQukjWaP2h/Ji6wAxtfg==
X-Received: by 2002:a17:907:3f95:b0:a7a:9144:e23a with SMTP id a640c23a62f3a-aa483525e00mr1185956666b.43.1731927593872;
        Mon, 18 Nov 2024 02:59:53 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da29989asm153181285e9.42.2024.11.18.02.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 02:59:53 -0800 (PST)
Message-ID: <332cbacb-cad3-4522-a74b-b5ad5efee4af@redhat.com>
Date: Mon, 18 Nov 2024 11:59:51 +0100
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
 <d27a75fa-b968-43d3-bbd3-cc607feee495@redhat.com>
 <253e5fd0-7e98-43fd-b0d7-8a5b739ae4aa@bytedance.com>
 <77b1eddf-7c1b-43e9-9352-229998ce3fc7@redhat.com>
 <5a3428bd-743a-4d51-8b75-163ab560bca7@bytedance.com>
 <4edccc1a-2761-4a5a-89a6-7869c1b6b08a@redhat.com>
 <2b48d313-4f66-47c8-98d8-8aa78db62b1b@bytedance.com>
 <995804f4-b658-44b2-bb40-c84b8a322616@redhat.com>
 <f3adf382-d252-4007-b8ca-c557814cb5c8@bytedance.com>
 <4ee60b7b-a81e-4b94-96c9-52b1bd9d5061@redhat.com>
 <e2870a81-840a-4b33-b65b-318a4a526c26@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <e2870a81-840a-4b33-b65b-318a4a526c26@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18.11.24 11:56, Qi Zheng wrote:
> 
> 
> On 2024/11/18 18:41, David Hildenbrand wrote:
>> On 18.11.24 11:34, Qi Zheng wrote:
>>>
>>>
>>> On 2024/11/18 17:29, David Hildenbrand wrote:
>>>> On 18.11.24 04:35, Qi Zheng wrote:
>>>>>
>>>>>
>>>>> On 2024/11/15 22:59, David Hildenbrand wrote:
>>>>>> On 15.11.24 15:41, Qi Zheng wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2024/11/15 18:22, David Hildenbrand wrote:
>>>>>>>>>>> *nr_skip = nr;
>>>>>>>>>>>
>>>>>>>>>>> and then:
>>>>>>>>>>>
>>>>>>>>>>> zap_pte_range
>>>>>>>>>>> --> nr = do_zap_pte_range(tlb, vma, pte, addr, end, details,
>>>>>>>>>>> &skip_nr,
>>>>>>>>>>>                               rss, &force_flush, &force_break);
>>>>>>>>>>>            if (can_reclaim_pt) {
>>>>>>>>>>>                none_nr += count_pte_none(pte, nr);
>>>>>>>>>>>                none_nr += nr_skip;
>>>>>>>>>>>            }
>>>>>>>>>>>
>>>>>>>>>>> Right?
>>>>>>>>>>
>>>>>>>>>> Yes. I did not look closely at the patch that adds the counting of
>>>>>>>>>
>>>>>>>>> Got it.
>>>>>>>>>
>>>>>>>>>> pte_none though (to digest why it is required :) ).
>>>>>>>>>
>>>>>>>>> Because 'none_nr == PTRS_PER_PTE' is used in patch #7 to detect
>>>>>>>>> empty PTE page.
>>>>>>>>
>>>>>>>> Okay, so the problem is that "nr" would be "all processed
>>>>>>>> entries" but
>>>>>>>> there are cases where we "process an entry but not zap it".
>>>>>>>>
>>>>>>>> What you really only want to know is "was any entry not zapped",
>>>>>>>> which
>>>>>>>> could be a simple input boolean variable passed into
>>>>>>>> do_zap_pte_range?
>>>>>>>>
>>>>>>>> Because as soon as any entry was processed but  no zapped, you can
>>>>>>>> immediately give up on reclaiming that table.
>>>>>>>
>>>>>>> Yes, we can set can_reclaim_pt to false when a !pte_none() entry is
>>>>>>> found in count_pte_none().
>>>>>>
>>>>>> I'm not sure if well need cont_pte_none(), but I'll have to take a
>>>>>> look
>>>>>> at your new patch to see how this fits together with doing the
>>>>>> pte_none
>>>>>> detection+skipping in do_zap_pte_range().
>>>>>>
>>>>>> I was wondering if you cannot simply avoid the additional scanning and
>>>>>> simply set "can_reclaim_pt" if you skip a zap.
>>>>>
>>>>> Maybe we can return the information whether the zap was skipped from
>>>>> zap_present_ptes() and zap_nonpresent_ptes() through parameters like I
>>>>> did in [PATCH v1 3/7] and [PATCH v1 4/7].
>>>>>
>>>>> In theory, we can detect empty PTE pages in the following two ways:
>>>>>
>>>>> 1) If no zap is skipped, it means that all pte entries have been
>>>>>        zap, and the PTE page must be empty.
>>>>> 2) If all pte entries are detected to be none, then the PTE page is
>>>>>        empty.
>>>>>
>>>>> In the error case, 1) may cause non-empty PTE pages to be reclaimed
>>>>> (which is unacceptable), while the 2) will at most cause empty PTE
>>>>> pages
>>>>> to not be reclaimed.
>>>>>
>>>>> So the most reliable and efficient method may be:
>>>>>
>>>>> a. If there is a zap that is skipped, stop scanning and do not reclaim
>>>>>        the PTE page;
>>>>> b. Otherwise, as now, detect the empty PTE page through
>>>>> count_pte_none()
>>>>
>>>> Is there a need for count_pte_none() that I am missing?
>>>
>>> When any_skipped == false, at least add VM_BUG_ON() to recheck none ptes.
>>>
>>>>
>>>> Assume we have
>>>>
>>>> nr = do_zap_pte_range(&any_skipped)
>>>>
>>>>
>>>> If "nr" is the number of processed entries (including pte_none()), and
>>>> "any_skipped" is set whenever we skipped to zap a !pte_none entry, we
>>>> can detect what we need, no?
>>>>
>>>> If any_skipped == false after the call, we now have "nr" pte_none()
>>>> entries. -> We can continue trying to reclaim
>>>
>>> I prefer that "nr" should not include pte_none().
>>>
>>
>> Why? do_zap_pte_range() should tell you how far to advance, nothing
>> less, nothing more.
>>
>> Let's just keep it simple and avoid count_pte_none().
>>
>> I'm probably missing something important?
> 
> As we discussed before, we should skip all consecutive none ptes,
 > pte and addr are already incremented before returning.

It's probably best to send the resulting patch so I can either 
understand why count_pte_none() is required or comment on how to get rid 
of it.

-- 
Cheers,

David / dhildenb


