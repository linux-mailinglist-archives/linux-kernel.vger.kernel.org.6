Return-Path: <linux-kernel+bounces-169470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDD88BC91E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4BA128282C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB63C1411C5;
	Mon,  6 May 2024 08:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bSfa/8K7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E70A6BFD4
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 08:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714982770; cv=none; b=NVeJjRpqY7HqOGjsuL66w9PnccqWVV4skBXY27oVpISTxmPEMCjVh3a+1a78w3sjAOIzRW1iWV9n0keKEwHz2SJsZn9eVM+T7hjLPX6IphUKGMgw4FSt/cd8uMMgxk6RFIQPF6GX4jzP0wHnyvvQnKkTxIKuu9AYWF/ifw6rHWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714982770; c=relaxed/simple;
	bh=ckpJORSzeSDk7L/jF3LN0nbec+5AuJL7KdFJ+/WkVRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QafuUjRCh+FoEhELIB98QonTG4JM7oVqw7iNh8vXc01YuxzbbcAyGBai+1ZsBADRenMCBg9KG50TsVcLN0CRGCCwWw20vj/tU+ZdWENDMhdz8MJutkuUu1bwbdI3a1+ORBOM17bT6vVUZPVBCYceywBtKStrFoHHJTmuOia1E1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bSfa/8K7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714982767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=socFUx6NYRlC6FX+b/4YakVZLjNJbNXEITHP/SnO7pY=;
	b=bSfa/8K74QxnXA2/4a2emGiCwLzivHCJwY7YaWfRw4ke0DC4RBW0IUHrfJdLIy70g8d/qh
	HyteMG22S23rwpQdcnOWJQyzmU0SavjukNFvTR+F9R095P8zYEjWjoIF98hQGZsCjpIaje
	O+1Csi6uPBpEqhmdAT/RT3tJ24cAqts=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-Z1hKX_PsNji7y4vZRbDsCg-1; Mon, 06 May 2024 04:06:05 -0400
X-MC-Unique: Z1hKX_PsNji7y4vZRbDsCg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-346c08df987so1002225f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 01:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714982765; x=1715587565;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=socFUx6NYRlC6FX+b/4YakVZLjNJbNXEITHP/SnO7pY=;
        b=m9gdp4YCz3A/RPOPCpNaFDSXviJW6Tj0/mT78duY3ltHelI4L5IK1PR16FMul/0ThO
         18DciLs0sDN1KhO0jYQapSje2bI1J/je55+3mUh4RJHNAlJVtnCS7JOuU9Lrql9clnfG
         bnLKT6E9JSgWwi9uSGQaSnzlAG5zuR6bXOVWGnR/MLRn+zD/IO50T8a/jcdLFO3G5fl5
         L3xh1NWF3UIOXoUz8n7CeGsthQe6xQgknS/fRLLh8/dKsAsOjDbUjT3OfcSs88z9oZCS
         NJI4ezAsbbd3b6Xr4Kf4M0LHJnUxAz70eXi4PlyV0OcfA9zMT3HdK3n2mlnaXxN1hYIP
         dtlw==
X-Forwarded-Encrypted: i=1; AJvYcCUogAFRFteQ27zPnxRV+nH4RRVOX2Yc4AtIKd2ZiKs6gLXWxWPP0L3yiVMiCWPZorYtKVGaF/ExjnODqe6Iqf/clJIM4qWFB0tPKmuT
X-Gm-Message-State: AOJu0Yxid58m65HzEiyKNgAZac3CrwLOCDh2/v7lWNPHGcODOPLovWcN
	dqrzxSrx79sAcQADkH5LML8QdgCeKkBhlc04sKJG3JFP1REhQaquL4So/wjMmZ0dO3mLjDTnUNC
	8UdpiNSeGswcwEW7roUrYDnY7VoEYSNgwoyfgak7yT33h9bD0fdYEnINKU6g0Iw==
X-Received: by 2002:a05:6000:1806:b0:34d:7f59:30b8 with SMTP id m6-20020a056000180600b0034d7f5930b8mr7951519wrh.12.1714982764741;
        Mon, 06 May 2024 01:06:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+RmIC3tAKIr/hFSe4EocrWncLVX8yrb23Urumb87WSfhYxji8ZOYT7EwQie1VELRGuugF7g==
X-Received: by 2002:a05:6000:1806:b0:34d:7f59:30b8 with SMTP id m6-20020a056000180600b0034d7f5930b8mr7951481wrh.12.1714982764201;
        Mon, 06 May 2024 01:06:04 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:bf00:182c:d606:87cf:6fea? (p200300cbc74bbf00182cd60687cf6fea.dip0.t-ipconnect.de. [2003:cb:c74b:bf00:182c:d606:87cf:6fea])
        by smtp.gmail.com with ESMTPSA id s14-20020adfe00e000000b0034e553f6174sm8490671wrh.98.2024.05.06.01.06.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 01:06:03 -0700 (PDT)
Message-ID: <0d20d8af-e480-4eb8-8606-1e486b13fd7e@redhat.com>
Date: Mon, 6 May 2024 10:06:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] mm: introduce pte_move_swp_offset() helper which
 can move offset bidirectionally
To: Barry Song <21cnbao@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 baolin.wang@linux.alibaba.com, chrisl@kernel.org, hanchuanhua@oppo.com,
 hannes@cmpxchg.org, hughd@google.com, kasong@tencent.com,
 linux-kernel@vger.kernel.org, surenb@google.com, v-songbaohua@oppo.com,
 willy@infradead.org, xiang@kernel.org, ying.huang@intel.com,
 yosryahmed@google.com, yuzhao@google.com, ziy@nvidia.com
References: <20240503005023.174597-1-21cnbao@gmail.com>
 <20240503005023.174597-4-21cnbao@gmail.com>
 <7548e30c-d56a-4a57-ab87-86c9c8e523b1@arm.com>
 <CAGsJ_4wx60GoB1erTQ7v3GTXLb_140bOJ_+z=kqY39eOd3P23g@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4wx60GoB1erTQ7v3GTXLb_140bOJ_+z=kqY39eOd3P23g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04.05.24 01:40, Barry Song wrote:
> On Fri, May 3, 2024 at 5:41 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 03/05/2024 01:50, Barry Song wrote:
>>> From: Barry Song <v-songbaohua@oppo.com>
>>>
>>> There could arise a necessity to obtain the first pte_t from a swap
>>> pte_t located in the middle. For instance, this may occur within the
>>> context of do_swap_page(), where a page fault can potentially occur in
>>> any PTE of a large folio. To address this, the following patch introduces
>>> pte_move_swp_offset(), a function capable of bidirectional movement by
>>> a specified delta argument. Consequently, pte_increment_swp_offset()
>>
>> You mean pte_next_swp_offset()?
> 
> yes.
> 
>>
>>> will directly invoke it with delta = 1.
>>>
>>> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>> ---
>>>   mm/internal.h | 25 +++++++++++++++++++++----
>>>   1 file changed, 21 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/mm/internal.h b/mm/internal.h
>>> index c5552d35d995..cfe4aed66a5c 100644
>>> --- a/mm/internal.h
>>> +++ b/mm/internal.h
>>> @@ -211,18 +211,21 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
>>>   }
>>>
>>>   /**
>>> - * pte_next_swp_offset - Increment the swap entry offset field of a swap pte.
>>> + * pte_move_swp_offset - Move the swap entry offset field of a swap pte
>>> + *    forward or backward by delta
>>>    * @pte: The initial pte state; is_swap_pte(pte) must be true and
>>>    *    non_swap_entry() must be false.
>>> + * @delta: The direction and the offset we are moving; forward if delta
>>> + *    is positive; backward if delta is negative
>>>    *
>>> - * Increments the swap offset, while maintaining all other fields, including
>>> + * Moves the swap offset, while maintaining all other fields, including
>>>    * swap type, and any swp pte bits. The resulting pte is returned.
>>>    */
>>> -static inline pte_t pte_next_swp_offset(pte_t pte)
>>> +static inline pte_t pte_move_swp_offset(pte_t pte, long delta)
>>
>> We have equivalent functions for pfn:
>>
>>    pte_next_pfn()
>>    pte_advance_pfn()
>>
>> Although the latter takes an unsigned long and only moves forward currently. I
>> wonder if it makes sense to have their naming and semantics match? i.e. change
>> pte_advance_pfn() to pte_move_pfn() and let it move backwards too.
>>
>> I guess we don't have a need for that and it adds more churn.
> 
> we might have a need in the below case.
> A forks B, then A and B share large folios. B unmap/exit, then large
> folios of process
> A become single-mapped.
> Right now, while writing A's folios, we are CoWing A's large folios
> into many small
> folios. I believe we can reuse the entire large folios instead of doing nr_pages
> CoW and page faults.
> In this case, we might want to get the first PTE from vmf->pte.

Once we have COW reuse for large folios in place (I think you know that 
I am working on that), it might make sense to "COW-reuse around", 
meaning we look if some neighboring PTEs map the same large folio and 
map them writable as well. But if it's really worth it, increasing page 
fault latency, is to be decided separately.


> 
> Another case, might be
> A forks B, and we write either A or B, we might CoW an entire large
> folios instead
> CoWing nr_pages small folios.
> 
> case 1 seems more useful, I might have a go after some days. then we might
> see pte_move_pfn().
pte_move_pfn() does sound odd to me. It might not be required to 
implement the optimization described above. (it's easier to simply read 
another PTE, check if it maps the same large folio, and to batch from there)

-- 
Cheers,

David / dhildenb


