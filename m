Return-Path: <linux-kernel+bounces-205818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5717E9000BB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA2BD2870E7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5E01E51D;
	Fri,  7 Jun 2024 10:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vxigq0nA"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AE415B55F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 10:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717755858; cv=none; b=YKgCEvRVIGBiB3Ng9p/T++VOPopRNJN9ejK9R5rqURnvV7cYK4p4JGQspUcdmE2yh7tCYEPo6enyOLPUWWlrRQ+oSBbsow93IwYJVxWzKrJ4c4iMsKGhb5iJLqVatJldfCABmaazzkX0f1H1sCJXSYWOBKcEirXONKtEYeC9eFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717755858; c=relaxed/simple;
	bh=pweTeERd4c5pyVKI8J96wfo+EUcdJK9PMrJb/oyZ5w0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hqs0BLHvymJkviKP40jrI0+FCzbkcEoRcr4JyDSOosxJkzcY8uDeDMADBkHDNEW2qKkjT9OjU/FFQUPZ3P3fFNodbOQFEvZ7gWTd1pkdOYp2m3aifNZfWTUpbNLP4Zk8ZlTGOLjQ/vq28sH3Z1Iq0E6Y0TK+EJIzxw45a6OmSlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vxigq0nA; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a68a9a4e9a6so182529266b.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 03:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717755855; x=1718360655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2KbBL1PuW9dZflYjkgNMLA3gaVvoqkOohso43BzxQOU=;
        b=Vxigq0nAh1t6HFgVLzgtqgQkBfY4Kj9QilaAjMTdNtEqtcZDjxw3ar/P0QCbSS2mM+
         0THdL6L0BZYm+HaH//HSGWyRNYu0JagaxCRLYpMs6uMybEgsCw3IVDfUfuuHKls5BNzT
         x13Hdj5QpN69jZ52McA0g6oWcmbMh9Rd3Zpx088Ry6aGed8xaxRiPTrCkjKGgmhFgyTd
         P7FqpsUXOHpbx4WjlIFuDGMBDVNdLF1BpmCn4ckzlrXaTdbsGwJrjAdEa1i7Ty+7LKdB
         Xp20L3YnD0USSZhbMsIojF5ShVDiImEjftEsjOpRKEv3B2vg1U4iRVRt9qTNATYrv+QB
         EqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717755855; x=1718360655;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2KbBL1PuW9dZflYjkgNMLA3gaVvoqkOohso43BzxQOU=;
        b=wYLrt2MKU29vdNWZdoGWXIzrI+n2x3z5dRg5g/BDoY6onlsJDydeuD7yI9MHkPSFkw
         aDwDY5k2/N2TfRLL3IODEm9R385TdrthLc715Fnv7/OX9pvhkpEH4Hjc3gr5+uYPcaka
         xsELsZNj9KPu8yILnkalscbzwlUFdfSQhXzL6WiKjOewMmpvz7XdQ0/YOmQ9zxp1vK8O
         YOEcLE55W7wYw1GZNPAVhmyf1l2ILRSAnPXPJmoN2As2bgTjLWkNW5IzQwHu4FVharwV
         c+W452BHFQOOevduNxS/pn7X1Nq5zGu17tYLpPMWAQ0iGnqh3LR9oBvcYccBIagNrLQW
         VlBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPC+5sKJZuztV5obOYQPePj5je6IHzx9nUE3A45uv3idm2PFc41ZXFAZWBZ7zU4EHbNtl6zc8KibRpEL1oSbWwf92Bbc2preiGFSBM
X-Gm-Message-State: AOJu0Yxn8z7HzZdhjYGOkakBwEHIzjRTIn0gFad6aA2hVFQ8hoLvh5Gs
	vDbWfuouopmVt8cnWlY1j/JPPsWEk0i3/aU3RappXZU80YAzO98hONen6LQg
X-Google-Smtp-Source: AGHT+IEkLyn8YxaJR3wRmKM+H8+esWqMEZzrZFZ7VTEYbOM7qdJuVUFc8p+J9hlrCdPt6evtrwJnrQ==
X-Received: by 2002:a17:906:bc55:b0:a68:b839:485a with SMTP id a640c23a62f3a-a6cdb9d9bacmr153202766b.77.1717755854329;
        Fri, 07 Jun 2024 03:24:14 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::7:fe7a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8070c050sm227963566b.144.2024.06.07.03.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 03:24:14 -0700 (PDT)
Message-ID: <e4d167fe-cb1e-41d1-a144-00bfa14b7148@gmail.com>
Date: Fri, 7 Jun 2024 11:24:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm: clear pte for folios that are zero filled
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 shakeel.butt@linux.dev, yosryahmed@google.com, willy@infradead.org
Cc: hannes@cmpxchg.org, nphamcs@gmail.com, chengming.zhou@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20240604105950.1134192-1-usamaarif642@gmail.com>
 <20240604105950.1134192-2-usamaarif642@gmail.com>
 <6b1485b6-c2a1-45b8-8afe-7b211689070b@redhat.com>
 <f26a6ac2-48a9-4bae-89b9-a3f9b97ae9dc@redhat.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <f26a6ac2-48a9-4bae-89b9-a3f9b97ae9dc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 04/06/2024 13:43, David Hildenbrand wrote:
> On 04.06.24 14:30, David Hildenbrand wrote:
>> On 04.06.24 12:58, Usama Arif wrote:
>>> Approximately 10-20% of pages to be swapped out are zero pages [1].
>>> Rather than reading/writing these pages to flash resulting
>>> in increased I/O and flash wear, the pte can be cleared for those
>>> addresses at unmap time while shrinking folio list. When this
>>> causes a page fault, do_pte_missing will take care of this page.
>>> With this patch, NVMe writes in Meta server fleet decreased
>>> by almost 10% with conventional swap setup (zswap disabled).
>>>
>>> [1] 
>>> https://lore.kernel.org/all/20171018104832epcms5p1b2232e2236258de3d03d1344dde9fce0@epcms5p1/
>>>
>>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>>> ---
>>>    include/linux/rmap.h |   1 +
>>>    mm/rmap.c            | 163 
>>> ++++++++++++++++++++++---------------------
>>>    mm/vmscan.c          |  89 ++++++++++++++++-------
>>>    3 files changed, 150 insertions(+), 103 deletions(-)
>>>
>>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>>> index bb53e5920b88..b36db1e886e4 100644
>>> --- a/include/linux/rmap.h
>>> +++ b/include/linux/rmap.h
>>> @@ -100,6 +100,7 @@ enum ttu_flags {
>>>                         * do a final flush if necessary */
>>>        TTU_RMAP_LOCKED        = 0x80,    /* do not grab rmap lock:
>>>                         * caller holds it */
>>> +    TTU_ZERO_FOLIO        = 0x100,/* zero folio */
>>>    };
>>>       #ifdef CONFIG_MMU
>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>> index 52357d79917c..d98f70876327 100644
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -1819,96 +1819,101 @@ static bool try_to_unmap_one(struct folio 
>>> *folio, struct vm_area_struct *vma,
>>>                 */
>>>                dec_mm_counter(mm, mm_counter(folio));
>>>            } else if (folio_test_anon(folio)) {
>>> -            swp_entry_t entry = page_swap_entry(subpage);
>>> -            pte_t swp_pte;
>>> -            /*
>>> -             * Store the swap location in the pte.
>>> -             * See handle_pte_fault() ...
>>> -             */
>>> -            if (unlikely(folio_test_swapbacked(folio) !=
>>> -                    folio_test_swapcache(folio))) {
>>> +            if (flags & TTU_ZERO_FOLIO) {
>>> +                pte_clear(mm, address, pvmw.pte);
>>> +                dec_mm_counter(mm, MM_ANONPAGES);
>>
>> Is there an easy way to reduce the code churn and highlight the added 
>> code?
>>
>> Like
>>
>> } else if (folio_test_anon(folio) && (flags & TTU_ZERO_FOLIO)) {
>>
>> } else if (folio_test_anon(folio)) {
>>
>>
>>
>> Also to concerns that I want to spell out:
>>
>> (a) what stops the page from getting modified in the meantime? The CPU
>>       can write it until the TLB was flushed.
>>
Thanks for pointing this out David and Shakeel. This is a big issue in 
this v2, and as Shakeel pointed out in [1] we need to do a second rmap 
walk. Looking at how ksm deals with this in try_to_merge_one_page which 
calls write_protect_page for each vma (i.e. basically an rmap walk), 
this would be much more CPU expensive and complicated compared to v1 
[2], where the swap subsystem can handle all complexities. I will go 
back to my v1 solution for the next revision as its much more simpler 
and the memory usage is very low (0.003%) as pointed out by Johannes [3] 
which would likely go away with the memory savings of not having a 
zswap_entry for zero filled pages, and the solution being a lot simpler 
than what a valid v2 approach would look like.


[1] 
https://lore.kernel.org/all/nes73bwc5p6yhwt5tw3upxcqrn5kenn6lvqb6exrf4yppmz6jx@ywhuevpkxlvh/

[2] 
https://lore.kernel.org/all/20240530102126.357438-1-usamaarif642@gmail.com/

[3] https://lore.kernel.org/all/20240530122715.GB1222079@cmpxchg.org/

>> (b) do you properly handle if the page is pinned (or just got pinned)
>>       and we must not discard it?
>
> Oh, and I forgot, are you handling userfaultd as expected? IIRC there 
> are some really nasty side-effects with userfaultfd even when 
> userfaultfd is currently not registered for a VMA [1].
>
> [1] 
> https://lore.kernel.org/linux-mm/3a4b1027-df6e-31b8-b0de-ff202828228d@redhat.com/
>
> What should work is replacing all-zero anonymous pages by the shared 
> zeropage iff the anonymous page is not pinned and we synchronize 
> against GUP fast. Well, and we handle possible concurrent writes 
> accordingly.
>
> KSM does essentially that when told to de-duplicate the shared 
> zeropage, and I was thinking a while ago if we would want a 
> zeropage-only KSM version that doesn't need stable tress and all that, 
> but only deduplicates zero-filled pages into the shared zeropage in a 
> safe way.
>
Thanks for the pointer to KSM code.



