Return-Path: <linux-kernel+bounces-171010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEA88BDEC1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD4211F21D0F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414701514F5;
	Tue,  7 May 2024 09:39:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8B114D70E
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 09:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074798; cv=none; b=DsfqxU3l7v9OuOYyRED9pKBfMREXl0DuGNPWKCPGs2vdSa9eOc3gFTe+PIXrgk5Zv2wMMLcdsvUS0fi07stWZF7mDFWSal5GThK7f02Z35Do8qn7q4BKM9Uf+CMJytCXM2LPwB7UZUfXKUpyYpJ/Sist2KVkAT2RO1GeJs16nq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074798; c=relaxed/simple;
	bh=Zhl8vUK+klDYE2ffSvI0Edgsc8m1l9+ebKST8V00zPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bBPzJQ7L2JsYght7jpnz/JNAiCh4Iv9Akm2FObbGX+sObjgV6o8nsyWaFxdWKk16WLDG+1q1bXqYEOohJwNBCw4LyQQZab/Gca3/CwxEcKDqTb0yZ5OEV9XCbMmD910vxc0a256n8tj9m+rwSLj2c45/ALNoRCGxToIRRiI6OTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3AC01063;
	Tue,  7 May 2024 02:40:20 -0700 (PDT)
Received: from [10.1.34.181] (unknown [10.1.34.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 619EF3F587;
	Tue,  7 May 2024 02:39:52 -0700 (PDT)
Message-ID: <fab6d379-6377-44a8-819f-c0e188cf0b9a@arm.com>
Date: Tue, 7 May 2024 10:39:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] mm: introduce pte_move_swp_offset() helper which
 can move offset bidirectionally
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, baolin.wang@linux.alibaba.com, chrisl@kernel.org,
 hanchuanhua@oppo.com, hannes@cmpxchg.org, hughd@google.com,
 kasong@tencent.com, linux-kernel@vger.kernel.org, surenb@google.com,
 v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org,
 ying.huang@intel.com, yosryahmed@google.com, yuzhao@google.com,
 ziy@nvidia.com
References: <20240503005023.174597-1-21cnbao@gmail.com>
 <20240503005023.174597-4-21cnbao@gmail.com>
 <7548e30c-d56a-4a57-ab87-86c9c8e523b1@arm.com>
 <CAGsJ_4wx60GoB1erTQ7v3GTXLb_140bOJ_+z=kqY39eOd3P23g@mail.gmail.com>
 <0d20d8af-e480-4eb8-8606-1e486b13fd7e@redhat.com>
 <CAGsJ_4wP75tFWDcKJZfw7Pk9AdigVCv0niGUeTY6RTZwk1UnjQ@mail.gmail.com>
 <ab283f1f-93bd-4f5e-8172-02109e02e8c4@redhat.com>
 <0bca057d-7344-40a6-a981-9a7a9347a19f@arm.com>
 <CAGsJ_4zA64NDdnqupOf6uUprpEiAbEwdaBzn3uck7ycj4gersQ@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4zA64NDdnqupOf6uUprpEiAbEwdaBzn3uck7ycj4gersQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/05/2024 09:24, Barry Song wrote:
> On Tue, May 7, 2024 at 8:14 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 06/05/2024 09:31, David Hildenbrand wrote:
>>> On 06.05.24 10:20, Barry Song wrote:
>>>> On Mon, May 6, 2024 at 8:06 PM David Hildenbrand <david@redhat.com> wrote:
>>>>>
>>>>> On 04.05.24 01:40, Barry Song wrote:
>>>>>> On Fri, May 3, 2024 at 5:41 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>>>
>>>>>>> On 03/05/2024 01:50, Barry Song wrote:
>>>>>>>> From: Barry Song <v-songbaohua@oppo.com>
>>>>>>>>
>>>>>>>> There could arise a necessity to obtain the first pte_t from a swap
>>>>>>>> pte_t located in the middle. For instance, this may occur within the
>>>>>>>> context of do_swap_page(), where a page fault can potentially occur in
>>>>>>>> any PTE of a large folio. To address this, the following patch introduces
>>>>>>>> pte_move_swp_offset(), a function capable of bidirectional movement by
>>>>>>>> a specified delta argument. Consequently, pte_increment_swp_offset()
>>>>>>>
>>>>>>> You mean pte_next_swp_offset()?
>>>>>>
>>>>>> yes.
>>>>>>
>>>>>>>
>>>>>>>> will directly invoke it with delta = 1.
>>>>>>>>
>>>>>>>> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
>>>>>>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>>>>>>> ---
>>>>>>>>    mm/internal.h | 25 +++++++++++++++++++++----
>>>>>>>>    1 file changed, 21 insertions(+), 4 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/mm/internal.h b/mm/internal.h
>>>>>>>> index c5552d35d995..cfe4aed66a5c 100644
>>>>>>>> --- a/mm/internal.h
>>>>>>>> +++ b/mm/internal.h
>>>>>>>> @@ -211,18 +211,21 @@ static inline int folio_pte_batch(struct folio
>>>>>>>> *folio, unsigned long addr,
>>>>>>>>    }
>>>>>>>>
>>>>>>>>    /**
>>>>>>>> - * pte_next_swp_offset - Increment the swap entry offset field of a swap
>>>>>>>> pte.
>>>>>>>> + * pte_move_swp_offset - Move the swap entry offset field of a swap pte
>>>>>>>> + *    forward or backward by delta
>>>>>>>>     * @pte: The initial pte state; is_swap_pte(pte) must be true and
>>>>>>>>     *    non_swap_entry() must be false.
>>>>>>>> + * @delta: The direction and the offset we are moving; forward if delta
>>>>>>>> + *    is positive; backward if delta is negative
>>>>>>>>     *
>>>>>>>> - * Increments the swap offset, while maintaining all other fields, including
>>>>>>>> + * Moves the swap offset, while maintaining all other fields, including
>>>>>>>>     * swap type, and any swp pte bits. The resulting pte is returned.
>>>>>>>>     */
>>>>>>>> -static inline pte_t pte_next_swp_offset(pte_t pte)
>>>>>>>> +static inline pte_t pte_move_swp_offset(pte_t pte, long delta)
>>>>>>>
>>>>>>> We have equivalent functions for pfn:
>>>>>>>
>>>>>>>     pte_next_pfn()
>>>>>>>     pte_advance_pfn()
>>>>>>>
>>>>>>> Although the latter takes an unsigned long and only moves forward currently. I
>>>>>>> wonder if it makes sense to have their naming and semantics match? i.e. change
>>>>>>> pte_advance_pfn() to pte_move_pfn() and let it move backwards too.
>>>>>>>
>>>>>>> I guess we don't have a need for that and it adds more churn.
>>>>>>
>>>>>> we might have a need in the below case.
>>>>>> A forks B, then A and B share large folios. B unmap/exit, then large
>>>>>> folios of process
>>>>>> A become single-mapped.
>>>>>> Right now, while writing A's folios, we are CoWing A's large folios
>>>>>> into many small
>>>>>> folios. I believe we can reuse the entire large folios instead of doing
>>>>>> nr_pages
>>>>>> CoW and page faults.
>>>>>> In this case, we might want to get the first PTE from vmf->pte.
>>>>>
>>>>> Once we have COW reuse for large folios in place (I think you know that
>>>>> I am working on that), it might make sense to "COW-reuse around",
>>>>
>>>> TBH, I don't know if you are working on that. please Cc me next time :-)
>>>
>>> I could have sworn I mentioned it to you already :)
>>>
>>> See
>>>
>>> https://lore.kernel.org/linux-mm/a9922f58-8129-4f15-b160-e0ace581bcbe@redhat.com/T/
>>>
>>> I'll follow-up on that soonish (now that batching is upstream and the large
>>> mapcount is on its way upstream).
>>>
>>>>
>>>>> meaning we look if some neighboring PTEs map the same large folio and
>>>>> map them writable as well. But if it's really worth it, increasing page
>>>>> fault latency, is to be decided separately.
>>>>
>>>> On the other hand, we eliminate latency for the remaining nr_pages - 1 PTEs.
>>>> Perhaps we can discover a more cost-effective method to signify that a large
>>>> folio is probably singly mapped?
>>>
>>> Yes, precisely what I am up to!
>>>
>>>> and only call "multi-PTEs" reuse while that
>>>> condition is true in PF and avoid increasing latency always?
>>>
>>> I'm thinking along those lines:
>>>
>>> If we detect that it's exclusive, we can certainly mapped the current PTE
>>> writable. Then, we can decide how much (and if) we want to fault-around writable
>>> as an optimization.
>>>
>>> For smallish large folios, it might make sense to try faulting around most of
>>> the folio.
>>>
>>> For large large folios (e.g., PTE-mapped 2MiB THP and bigger), we might not want
>>> to fault around the whole thing -- especially if there is little benefit to be
>>> had from contig-pte bits.
>>>
>>>>
>>>>>
>>>>>
>>>>>>
>>>>>> Another case, might be
>>>>>> A forks B, and we write either A or B, we might CoW an entire large
>>>>>> folios instead
>>>>>> CoWing nr_pages small folios.
>>>>>>
>>>>>> case 1 seems more useful, I might have a go after some days. then we might
>>>>>> see pte_move_pfn().
>>>>> pte_move_pfn() does sound odd to me.
>>
>> Yes, I agree the name is odd. pte_move_swp_offset() sounds similarly odd tbh.
>> Perhaps just pte_advance_swp_offset() with a negative value is clearer about
>> what its doing?
>>
> 
> I am not a native speaker. but dictionary says
> 
> advance:
> move forward in a purposeful way.
> a forward movement.
> 
> Now we are moving backward or forward :-)

Sure, but if you pass a negative value then you are moving forwards by a
negative amount ;-)

Anyway, forget I said anything - its not important.

> 
>>>>> It might not be required to
>>>>> implement the optimization described above. (it's easier to simply read
>>>>> another PTE, check if it maps the same large folio, and to batch from there)
>>
>> Yes agreed.
>>
>>>>>
>>>>
>>>> It appears that your proposal suggests potential reusability as follows: if we
>>>> have a large folio containing 16 PTEs, you might consider reusing only 4 by
>>>> examining PTEs "around" but not necessarily all 16 PTEs. please correct me
>>>> if my understanding is wrong.
>>>>
>>>> Initially, my idea was to obtain the first PTE using pte_move_pfn() and then
>>>> utilize folio_pte_batch() with the first PTE as arguments to ensure consistency
>>>> in nr_pages, thus enabling complete reuse of the whole folio.
>>>
>>> Simply doing an vm_normal_folio(pte - X) == folio and then trying to batch from
>>> there might be easier and cleaner.
>>>
>>


