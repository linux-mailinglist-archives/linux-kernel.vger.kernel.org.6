Return-Path: <linux-kernel+bounces-205879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51ECB9001D2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0F71282E17
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2413315D5C4;
	Fri,  7 Jun 2024 11:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OjAOY+FJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D57961FDD
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 11:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717758972; cv=none; b=WyB/pcwvuhyF4Nq9dnapcoubdlpK6NJLeszWQ+AoLEKLgexBHqVN0u2J1AN1xwDC68ngJzpOC7pU3lruG2TZd0ukv6C3xd1TtQ7MsOoknm+w+0Z4ECC3zaclM0vdD8qi/9c08I/VEWebs3RKxcrli4peR06gD1IzDovxNfQJWy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717758972; c=relaxed/simple;
	bh=uUhjPAsnwd56RFQPWEJpHfCuBt+okhtCbAKRBKjMS2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CG8w77mByV7WTycBk3UP3+Zis2q4epQ5AgdUpwomg/CH1XQfZc6ArYgirgT9/2QVayGklBltT1Fukv24Ab9f9hrnu5oeLJS5/liDVd7EYNdgil1KIbwZ4aeCIL8qgfgFM2QuT+1OHbFxDVE4ffme1SZmeMtugEb902pbFQy2/uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OjAOY+FJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717758968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JLkZiwsd0/i8KTs2VvAUdeHu8eXRGP4UZfr13fWcNU0=;
	b=OjAOY+FJH+AQuA+V+m9EkTcA0siVpr2xQOW0EjxIpu1GI4Z9jeOyjqzV+BrTRMIPa7LQqi
	PmwHTQuA7Puy4In2+Mw1JyVbv66zR62tuk6G03TQWBpK12phB0IUtf2OSmKmyg2TooqQxW
	+sP5L/KlE/82LoLTAFeJlu5L8vtCDmg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-NMQ8o3M5MSqISkyH39GiUw-1; Fri, 07 Jun 2024 07:16:06 -0400
X-MC-Unique: NMQ8o3M5MSqISkyH39GiUw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42135f60020so16177875e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 04:16:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717758965; x=1718363765;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JLkZiwsd0/i8KTs2VvAUdeHu8eXRGP4UZfr13fWcNU0=;
        b=RUmr9tJWDeGxakrR0A7YJ67qKOQP/VwwS7fZXAjmtV0oWvW6BlKJVf4w/4EFVqDMDL
         Hob2YzLd8cnU1xLG9lMxmU14tyFEDDDMY0zo+F+U7bjMnbWpss08/7461js/YTuUObZP
         /EHmY42duhOzBoP0tk1bHUUoHQ4BwBRJLKWixxJmeTnpK9ieoqwMBIcPQbGMaeIis4U4
         vfApvMz9kQOIUIPzZhfa+BfOmlt4MtjRoBxSWTfQp1zv/uYRv+LmE6tWE1R2jnf076jn
         myvipMd1+z7hVZI05YwUX5WfNFQZxG8Hg7sRRFMWeNsJtUz4+MVjhWeqbOioEQZ/OPot
         J2Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVnKNsbbQ9S4mIiowLdkEC0TYEq50z+fv/GAWfLquqcG6cq1B5szIs2H0giAeZfsZyt8X9kmiuD3zmQ1pv4mAUgZzOnXW/YeDXr7IEW
X-Gm-Message-State: AOJu0YxpeBho3qnnNh6LGeDJZ0lxqdSI8arw8Ddnq+GdEDl/V0xqA+gl
	eJFA0B2GS1EZ0dACppPWuJ03PYfDa4ZlYlu5m3s5ldfC7SrW8sdmOdaCwgSXs6w4/wungpdSfSm
	+GgCY8OKrwSLw4f9AKXDSmAWg0AxkTUcNBerZGPyE3GCTHE/3YWrrIM4odx8ciQ==
X-Received: by 2002:adf:fc48:0:b0:354:f61d:d7c1 with SMTP id ffacd0b85a97d-35efee31873mr1517117f8f.65.1717758965305;
        Fri, 07 Jun 2024 04:16:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVTFbBzGoWE8RYL7NEOL3/OcgdrRba2OSZ/vqVrgSw4xIjUKay9B5HAy4NbIWukcno2VN6kQ==
X-Received: by 2002:adf:fc48:0:b0:354:f61d:d7c1 with SMTP id ffacd0b85a97d-35efee31873mr1517099f8f.65.1717758964751;
        Fri, 07 Jun 2024 04:16:04 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:2200:31c4:4d18:1bdd:fb7a? (p200300cbc71a220031c44d181bddfb7a.dip0.t-ipconnect.de. [2003:cb:c71a:2200:31c4:4d18:1bdd:fb7a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d4729asm3794300f8f.25.2024.06.07.04.16.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 04:16:04 -0700 (PDT)
Message-ID: <b458af5d-0f88-47d6-952a-8f69d41d1c80@redhat.com>
Date: Fri, 7 Jun 2024 13:16:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm: clear pte for folios that are zero filled
To: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org,
 shakeel.butt@linux.dev, yosryahmed@google.com, willy@infradead.org
Cc: hannes@cmpxchg.org, nphamcs@gmail.com, chengming.zhou@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20240604105950.1134192-1-usamaarif642@gmail.com>
 <20240604105950.1134192-2-usamaarif642@gmail.com>
 <6b1485b6-c2a1-45b8-8afe-7b211689070b@redhat.com>
 <f26a6ac2-48a9-4bae-89b9-a3f9b97ae9dc@redhat.com>
 <e4d167fe-cb1e-41d1-a144-00bfa14b7148@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <e4d167fe-cb1e-41d1-a144-00bfa14b7148@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07.06.24 12:24, Usama Arif wrote:
> 
> On 04/06/2024 13:43, David Hildenbrand wrote:
>> On 04.06.24 14:30, David Hildenbrand wrote:
>>> On 04.06.24 12:58, Usama Arif wrote:
>>>> Approximately 10-20% of pages to be swapped out are zero pages [1].
>>>> Rather than reading/writing these pages to flash resulting
>>>> in increased I/O and flash wear, the pte can be cleared for those
>>>> addresses at unmap time while shrinking folio list. When this
>>>> causes a page fault, do_pte_missing will take care of this page.
>>>> With this patch, NVMe writes in Meta server fleet decreased
>>>> by almost 10% with conventional swap setup (zswap disabled).
>>>>
>>>> [1]
>>>> https://lore.kernel.org/all/20171018104832epcms5p1b2232e2236258de3d03d1344dde9fce0@epcms5p1/
>>>>
>>>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>>>> ---
>>>>     include/linux/rmap.h |   1 +
>>>>     mm/rmap.c            | 163
>>>> ++++++++++++++++++++++---------------------
>>>>     mm/vmscan.c          |  89 ++++++++++++++++-------
>>>>     3 files changed, 150 insertions(+), 103 deletions(-)
>>>>
>>>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>>>> index bb53e5920b88..b36db1e886e4 100644
>>>> --- a/include/linux/rmap.h
>>>> +++ b/include/linux/rmap.h
>>>> @@ -100,6 +100,7 @@ enum ttu_flags {
>>>>                          * do a final flush if necessary */
>>>>         TTU_RMAP_LOCKED        = 0x80,    /* do not grab rmap lock:
>>>>                          * caller holds it */
>>>> +    TTU_ZERO_FOLIO        = 0x100,/* zero folio */
>>>>     };
>>>>        #ifdef CONFIG_MMU
>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>> index 52357d79917c..d98f70876327 100644
>>>> --- a/mm/rmap.c
>>>> +++ b/mm/rmap.c
>>>> @@ -1819,96 +1819,101 @@ static bool try_to_unmap_one(struct folio
>>>> *folio, struct vm_area_struct *vma,
>>>>                  */
>>>>                 dec_mm_counter(mm, mm_counter(folio));
>>>>             } else if (folio_test_anon(folio)) {
>>>> -            swp_entry_t entry = page_swap_entry(subpage);
>>>> -            pte_t swp_pte;
>>>> -            /*
>>>> -             * Store the swap location in the pte.
>>>> -             * See handle_pte_fault() ...
>>>> -             */
>>>> -            if (unlikely(folio_test_swapbacked(folio) !=
>>>> -                    folio_test_swapcache(folio))) {
>>>> +            if (flags & TTU_ZERO_FOLIO) {
>>>> +                pte_clear(mm, address, pvmw.pte);
>>>> +                dec_mm_counter(mm, MM_ANONPAGES);
>>>
>>> Is there an easy way to reduce the code churn and highlight the added
>>> code?
>>>
>>> Like
>>>
>>> } else if (folio_test_anon(folio) && (flags & TTU_ZERO_FOLIO)) {
>>>
>>> } else if (folio_test_anon(folio)) {
>>>
>>>
>>>
>>> Also to concerns that I want to spell out:
>>>
>>> (a) what stops the page from getting modified in the meantime? The CPU
>>>        can write it until the TLB was flushed.
>>>
> Thanks for pointing this out David and Shakeel. This is a big issue in
> this v2, and as Shakeel pointed out in [1] we need to do a second rmap
> walk. Looking at how ksm deals with this in try_to_merge_one_page which
> calls write_protect_page for each vma (i.e. basically an rmap walk),
> this would be much more CPU expensive and complicated compared to v1
> [2], where the swap subsystem can handle all complexities. I will go
> back to my v1 solution for the next revision as its much more simpler
> and the memory usage is very low (0.003%) as pointed out by Johannes [3]
> which would likely go away with the memory savings of not having a
> zswap_entry for zero filled pages, and the solution being a lot simpler
> than what a valid v2 approach would look like.

Agreed.

-- 
Cheers,

David / dhildenb


