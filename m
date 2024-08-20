Return-Path: <linux-kernel+bounces-294516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58ECB958EA6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 21:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF944B22215
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D401547C9;
	Tue, 20 Aug 2024 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IU8pF3Tz"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF4518E344;
	Tue, 20 Aug 2024 19:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724182519; cv=none; b=i6Aemaef/vkg2g7RPcFcbA4e3UkEFnWXuCM/iEMi3OMO7KG0wt1ksXIRlf2EkN9r8ReQMuarQkKgw5urwLXyPC8tjyLctzOp4TzrMHr5ah2+Gv+0LNr+nKjBrkIot7xzwFa1uIFZPNzq0UGmiXdXJYDjbxiyJnaXI5cRv96/zOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724182519; c=relaxed/simple;
	bh=f+660D3Hh+c1hIKfUGMMBGkJtWrbpoBntNsSrn6d4Sw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZtWyPkweNKFk6menz0w9uphmPn7rHOq8uVFPAFoH+n4IF+CaYOGVLQbQXAT0KhAJQoORjZW5AX3CHH3sy0ywjBGFzfVZyKtgckKmtzg/pWmTpLFekhPqPPcQ+mr5Shol1nkO12xrXo+1odjTurHFfpeDHw1U1z/jzYD2C9ulRH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IU8pF3Tz; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4f52cc4d3beso1953619e0c.3;
        Tue, 20 Aug 2024 12:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724182516; x=1724787316; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JhdEj+sJpVIC9ERYexH59LfqXSJtceBbJDRCMReoFXM=;
        b=IU8pF3TzfSoLaxMMXOqfQU8sJ9RR1CIARwC7lyRpI2ZZFAQJ/JnpPXmIBuLKk3J7ix
         ac0NZA3h3HZByZ7omPSkQWUJ81TYPLVurAfHoajDKC4LEi07Z8Oo9kSlKR5N3+MySp0L
         pIIjMHNvqiLOJb+sIoteWoO0vUiEzv9tscIwEpokMLhbbh0zcV52NtfbnEEca74pmvwD
         uOCfy6s8Wg9seNsExurvsmH6gbl+GxQ4Ce85CmCBOpHKUswxb5SZJs9xoRTIgxOZcoiE
         CZ5rYcHYRY+HA0MTyP0D7jaue5mD639ztoCd549maa9IsULx9mNUH+dAAY1H4PEvnqh5
         73vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724182516; x=1724787316;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JhdEj+sJpVIC9ERYexH59LfqXSJtceBbJDRCMReoFXM=;
        b=ve2EsuxYFBg5XfTLQaBNFv/zuV6KmN6TpyED9bD++Cf8pFBe1SC48i9nKoXyN0Oed3
         VlfO1igc09LCftCQvtc1aMdnSh0RObDnzBqK3DKs6HCUV1o13X/KSAmzcvn2x1x78ib7
         36dg0bnYHHIu2D2a3nXntyVpLc/G1r7tijBI/M1JRNN1hr1++PdoKzQ1uvgh7J1mQo/Q
         ayFcdjc2JoOrCvArEXpQRCaz7RUR3CPreykPWaeo86xCGNmUBqz4uLzlBvf8Mw+9R4TN
         cb1vITPgqTBwRnycNXlMjkASzZHvs5EFKZnudJW5eeqqFfglNliEQcJRm/Z16Nk6KWK6
         D3Rg==
X-Forwarded-Encrypted: i=1; AJvYcCVGb23hcKrwSB+jWN5DhKxvaoS6C34lgULcaXIk5kF7SyUGwjAT7KAwRCvk5/HBzLTmKmWEsODtkC8=@vger.kernel.org, AJvYcCVx5GIzQH0ELmxbhG2+D7tvaS4eB5F/9CE52m9e8R3LW35NSyngdv+xu2O5Hius+Trv5qYLuf/btsi5j1OC@vger.kernel.org
X-Gm-Message-State: AOJu0YyfACSgSMoevcoCYETbncpnsKlFf7PAj/KZgOY0CeZTy4+pnrwH
	TlZISD/BCPblHn5RfAq0zuRtSWAWstnxCvsZDr+Zse3WBWCk7dI4
X-Google-Smtp-Source: AGHT+IF+YL/VmQ7OVyY18Cts466NyKsFBNZ/U/RLmdXiO1mMkPReytJ40J1jROEAHVhtKbmvuEq/hA==
X-Received: by 2002:a05:6122:3bd2:b0:4e4:e90f:6749 with SMTP id 71dfb90a1353d-4fcf39a13cfmr42828e0c.10.1724182516133;
        Tue, 20 Aug 2024 12:35:16 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1145:4:1409:786c:cb1d:c3fb? ([2620:10d:c091:500::4:4b1f])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4536a07667fsm51564551cf.93.2024.08.20.12.35.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 12:35:15 -0700 (PDT)
Message-ID: <953d398d-58be-41c6-bf30-4c9df597de77@gmail.com>
Date: Tue, 20 Aug 2024 15:35:14 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] mm: Introduce a pageflag for partially mapped
 folios
To: Barry Song <baohua@kernel.org>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, hannes@cmpxchg.org, riel@surriel.com,
 shakeel.butt@linux.dev, roman.gushchin@linux.dev, yuzhao@google.com,
 david@redhat.com, ryan.roberts@arm.com, rppt@kernel.org,
 willy@infradead.org, cerasuolodomenico@gmail.com, ryncsn@gmail.com,
 corbet@lwn.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kernel-team@meta.com
References: <20240819023145.2415299-1-usamaarif642@gmail.com>
 <20240819023145.2415299-5-usamaarif642@gmail.com>
 <CAGsJ_4yKuvMSazWABXqaeRr84hLEubET0nCUhPFYHQnfR4Tm8w@mail.gmail.com>
 <a09b6af0-4fdb-4ac1-9cbe-9b422ebc3308@gmail.com>
 <CAGsJ_4xeWt9n3zX3-DknE=NftkWS0fe2vKTJT9tLuJPM4EaEwg@mail.gmail.com>
 <9a58e794-2156-4a9f-a383-1cdfc07eee5e@gmail.com>
 <CAGsJ_4xiG+oGkjt3nf0Zh2rdztz8h_AaahZWs4N3UARhw7DcgQ@mail.gmail.com>
 <CAGsJ_4z2YL01wvVgsFsbzGAQ5KowXgxLcj=Y7DSX7ODOF5MUvw@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAGsJ_4z2YL01wvVgsFsbzGAQ5KowXgxLcj=Y7DSX7ODOF5MUvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 19/08/2024 22:55, Barry Song wrote:
> On Tue, Aug 20, 2024 at 9:34 AM Barry Song <baohua@kernel.org> wrote:
>>
>> On Tue, Aug 20, 2024 at 8:16 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>>
>>>
>>>
>>> On 19/08/2024 20:00, Barry Song wrote:
>>>> On Tue, Aug 20, 2024 at 2:17 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 19/08/2024 09:29, Barry Song wrote:
>>>>>> Hi Usama,
>>>>>>
>>>>>> I feel it is much better now! thanks!
>>>>>>
>>>>>> On Mon, Aug 19, 2024 at 2:31 PM Usama Arif <usamaarif642@gmail.com> wrote:
>>>>>>>
>>>>>>> Currently folio->_deferred_list is used to keep track of
>>>>>>> partially_mapped folios that are going to be split under memory
>>>>>>> pressure. In the next patch, all THPs that are faulted in and collapsed
>>>>>>> by khugepaged are also going to be tracked using _deferred_list.
>>>>>>>
>>>>>>> This patch introduces a pageflag to be able to distinguish between
>>>>>>> partially mapped folios and others in the deferred_list at split time in
>>>>>>> deferred_split_scan. Its needed as __folio_remove_rmap decrements
>>>>>>> _mapcount, _large_mapcount and _entire_mapcount, hence it won't be
>>>>>>> possible to distinguish between partially mapped folios and others in
>>>>>>> deferred_split_scan.
>>>>>>>
>>>>>>> Eventhough it introduces an extra flag to track if the folio is
>>>>>>> partially mapped, there is no functional change intended with this
>>>>>>> patch and the flag is not useful in this patch itself, it will
>>>>>>> become useful in the next patch when _deferred_list has non partially
>>>>>>> mapped folios.
>>>>>>>
>>>>>>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>>>>>>> ---
>>>>>>>  include/linux/huge_mm.h    |  4 ++--
>>>>>>>  include/linux/page-flags.h | 11 +++++++++++
>>>>>>>  mm/huge_memory.c           | 23 ++++++++++++++++-------
>>>>>>>  mm/internal.h              |  4 +++-
>>>>>>>  mm/memcontrol.c            |  3 ++-
>>>>>>>  mm/migrate.c               |  3 ++-
>>>>>>>  mm/page_alloc.c            |  5 +++--
>>>>>>>  mm/rmap.c                  |  5 +++--
>>>>>>>  mm/vmscan.c                |  3 ++-
>>>>>>>  9 files changed, 44 insertions(+), 17 deletions(-)
>>>>>>>
>>>>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>>>>>> index 4c32058cacfe..969f11f360d2 100644
>>>>>>> --- a/include/linux/huge_mm.h
>>>>>>> +++ b/include/linux/huge_mm.h
>>>>>>> @@ -321,7 +321,7 @@ static inline int split_huge_page(struct page *page)
>>>>>>>  {
>>>>>>>         return split_huge_page_to_list_to_order(page, NULL, 0);
>>>>>>>  }
>>>>>>> -void deferred_split_folio(struct folio *folio);
>>>>>>> +void deferred_split_folio(struct folio *folio, bool partially_mapped);
>>>>>>>
>>>>>>>  void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>>>>>>>                 unsigned long address, bool freeze, struct folio *folio);
>>>>>>> @@ -495,7 +495,7 @@ static inline int split_huge_page(struct page *page)
>>>>>>>  {
>>>>>>>         return 0;
>>>>>>>  }
>>>>>>> -static inline void deferred_split_folio(struct folio *folio) {}
>>>>>>> +static inline void deferred_split_folio(struct folio *folio, bool partially_mapped) {}
>>>>>>>  #define split_huge_pmd(__vma, __pmd, __address)        \
>>>>>>>         do { } while (0)
>>>>>>>
>>>>>>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>>>>>>> index a0a29bd092f8..c3bb0e0da581 100644
>>>>>>> --- a/include/linux/page-flags.h
>>>>>>> +++ b/include/linux/page-flags.h
>>>>>>> @@ -182,6 +182,7 @@ enum pageflags {
>>>>>>>         /* At least one page in this folio has the hwpoison flag set */
>>>>>>>         PG_has_hwpoisoned = PG_active,
>>>>>>>         PG_large_rmappable = PG_workingset, /* anon or file-backed */
>>>>>>> +       PG_partially_mapped = PG_reclaim, /* was identified to be partially mapped */
>>>>>>>  };
>>>>>>>
>>>>>>>  #define PAGEFLAGS_MASK         ((1UL << NR_PAGEFLAGS) - 1)
>>>>>>> @@ -861,8 +862,18 @@ static inline void ClearPageCompound(struct page *page)
>>>>>>>         ClearPageHead(page);
>>>>>>>  }
>>>>>>>  FOLIO_FLAG(large_rmappable, FOLIO_SECOND_PAGE)
>>>>>>> +FOLIO_TEST_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
>>>>>>> +/*
>>>>>>> + * PG_partially_mapped is protected by deferred_split split_queue_lock,
>>>>>>> + * so its safe to use non-atomic set/clear.
>>>>>>> + */
>>>>>>> +__FOLIO_SET_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
>>>>>>> +__FOLIO_CLEAR_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
>>>>>>>  #else
>>>>>>>  FOLIO_FLAG_FALSE(large_rmappable)
>>>>>>> +FOLIO_TEST_FLAG_FALSE(partially_mapped)
>>>>>>> +__FOLIO_SET_FLAG_NOOP(partially_mapped)
>>>>>>> +__FOLIO_CLEAR_FLAG_NOOP(partially_mapped)
>>>>>>>  #endif
>>>>>>>
>>>>>>>  #define PG_head_mask ((1UL << PG_head))
>>>>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>>>>> index 2d77b5d2291e..70ee49dfeaad 100644
>>>>>>> --- a/mm/huge_memory.c
>>>>>>> +++ b/mm/huge_memory.c
>>>>>>> @@ -3398,6 +3398,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>>>>>>>                          * page_deferred_list.
>>>>>>>                          */
>>>>>>>                         list_del_init(&folio->_deferred_list);
>>>>>>> +                       __folio_clear_partially_mapped(folio);
>>>>>>>                 }
>>>>>>>                 spin_unlock(&ds_queue->split_queue_lock);
>>>>>>>                 if (mapping) {
>>>>>>> @@ -3454,11 +3455,13 @@ void __folio_undo_large_rmappable(struct folio *folio)
>>>>>>>         if (!list_empty(&folio->_deferred_list)) {
>>>>>>>                 ds_queue->split_queue_len--;
>>>>>>>                 list_del_init(&folio->_deferred_list);
>>>>>>> +               __folio_clear_partially_mapped(folio);
>>>>>>
>>>>>> is it possible to make things clearer by
>>>>>>
>>>>>>  if (folio_clear_partially_mapped)
>>>>>>     __folio_clear_partially_mapped(folio);
>>>>>>
>>>>>> While writing without conditions isn't necessarily wrong, adding a condition
>>>>>> will improve the readability of the code and enhance the clarity of my mTHP
>>>>>> counters series. also help decrease smp cache sync if we can avoid
>>>>>> unnecessary writing?
>>>>>>
>>>>>
>>>>> Do you mean if(folio_test_partially_mapped(folio))?
>>>>>
>>>>> I don't like this idea. I think it makes the readability worse? If I was looking at if (test) -> clear for the first time, I would become confused why its being tested if its going to be clear at the end anyways?
>>>>
>>>> In the pmd-order case, the majority of folios are not partially mapped.
>>>> Unconditional writes will trigger cache synchronization across all
>>>> CPUs (related to the MESI protocol), making them more costly. By
>>>> using conditional writes, such as "if(test) write," we can avoid
>>>> most unnecessary writes, which is much more efficient. Additionally,
>>>> we only need to manage nr_split_deferred when the condition
>>>> is met. We are carefully evaluating all scenarios to determine
>>>> if modifications to the partially_mapped flag are necessary.
>>>>
>>>
>>>
>>> Hmm okay, as you said its needed for nr_split_deferred anyways. Something like below is ok to fold in?
>>>
>>> commit 4ae9e2067346effd902b342296987b97dee29018 (HEAD)
>>> Author: Usama Arif <usamaarif642@gmail.com>
>>> Date:   Mon Aug 19 21:07:16 2024 +0100
>>>
>>>     mm: Introduce a pageflag for partially mapped folios fix
>>>
>>>     Test partially_mapped flag before clearing it. This should
>>>     avoid unnecessary writes and will be needed in the nr_split_deferred
>>>     series.
>>>
>>>     Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 5d67d3b3c1b2..ccde60aaaa0f 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -3479,7 +3479,8 @@ void __folio_undo_large_rmappable(struct folio *folio)
>>>         if (!list_empty(&folio->_deferred_list)) {
>>>                 ds_queue->split_queue_len--;
>>>                 list_del_init(&folio->_deferred_list);
>>> -               __folio_clear_partially_mapped(folio);
>>> +               if (folio_test_partially_mapped(folio))
>>> +                       __folio_clear_partially_mapped(folio);
>>>         }
>>>         spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>>>  }
>>> @@ -3610,7 +3611,8 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>>>                 } else {
>>>                         /* We lost race with folio_put() */
>>>                         list_del_init(&folio->_deferred_list);
>>> -                       __folio_clear_partially_mapped(folio);
>>> +                       if (folio_test_partially_mapped(folio))
>>> +                               __folio_clear_partially_mapped(folio);
>>>                         ds_queue->split_queue_len--;
>>>                 }
>>>                 if (!--sc->nr_to_scan)
>>>
>>
>> Do we also need if (folio_test_partially_mapped(folio)) in
>> split_huge_page_to_list_to_order()?
>>
>> I recall that in Yu Zhao's TAO, there’s a chance of splitting (shattering)
>> non-partially-mapped folios. To be future-proof, we might want to handle
>> both cases equally.
> 
> we recall we also have a real case which can split entirely_mapped
> folio:
> 
> mm: huge_memory: enable debugfs to split huge pages to any order
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fc4d182316bd5309b4066fd9ef21529ea397a7d4
> 
>>
>> By the way, we might not need to clear the flag for a new folio. This differs
>> from the init_list, which is necessary. If a new folio has the partially_mapped
>> flag, it indicates that we failed to clear it when freeing the folio to
>> the buddy system, which is a bug we need to fix in the free path.
>>
>> Thanks
>> Barry

I believe the below fixlet should address all concerns:


From 95492a51b1929ea274b4e5b78fc74e7736645d58 Mon Sep 17 00:00:00 2001
From: Usama Arif <usamaarif642@gmail.com>
Date: Mon, 19 Aug 2024 21:07:16 +0100
Subject: [PATCH] mm: Introduce a pageflag for partially mapped folios fix

Test partially_mapped flag before clearing it. This should
avoid unnecessary writes and will be needed in the nr_split_deferred
series.
Also no need to clear partially_mapped prepping compound head, as it
should start with already being cleared.

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 include/linux/page-flags.h | 2 +-
 mm/huge_memory.c           | 9 ++++++---
 mm/internal.h              | 4 +---
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index c3bb0e0da581..f1602695daf2 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -1182,7 +1182,7 @@ static __always_inline void __ClearPageAnonExclusive(struct page *page)
  */
 #define PAGE_FLAGS_SECOND						\
 	(0xffUL /* order */		| 1UL << PG_has_hwpoisoned |	\
-	 1UL << PG_large_rmappable)
+	 1UL << PG_large_rmappable	| 1UL << PG_partially_mapped)
 
 #define PAGE_FLAGS_PRIVATE				\
 	(1UL << PG_private | 1UL << PG_private_2)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5d67d3b3c1b2..402b9d933de0 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3422,7 +3422,8 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 			 * page_deferred_list.
 			 */
 			list_del_init(&folio->_deferred_list);
-			__folio_clear_partially_mapped(folio);
+			if (folio_test_partially_mapped(folio))
+				__folio_clear_partially_mapped(folio);
 		}
 		spin_unlock(&ds_queue->split_queue_lock);
 		if (mapping) {
@@ -3479,7 +3480,8 @@ void __folio_undo_large_rmappable(struct folio *folio)
 	if (!list_empty(&folio->_deferred_list)) {
 		ds_queue->split_queue_len--;
 		list_del_init(&folio->_deferred_list);
-		__folio_clear_partially_mapped(folio);
+		if (folio_test_partially_mapped(folio))
+			__folio_clear_partially_mapped(folio);
 	}
 	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
 }
@@ -3610,7 +3612,8 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 		} else {
 			/* We lost race with folio_put() */
 			list_del_init(&folio->_deferred_list);
-			__folio_clear_partially_mapped(folio);
+			if (folio_test_partially_mapped(folio))
+				__folio_clear_partially_mapped(folio);
 			ds_queue->split_queue_len--;
 		}
 		if (!--sc->nr_to_scan)
diff --git a/mm/internal.h b/mm/internal.h
index 27cbb5365841..52f7fc4e8ac3 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -662,10 +662,8 @@ static inline void prep_compound_head(struct page *page, unsigned int order)
 	atomic_set(&folio->_entire_mapcount, -1);
 	atomic_set(&folio->_nr_pages_mapped, 0);
 	atomic_set(&folio->_pincount, 0);
-	if (order > 1) {
+	if (order > 1)
 		INIT_LIST_HEAD(&folio->_deferred_list);
-		__folio_clear_partially_mapped(folio);
-	}
 }
 
 static inline void prep_compound_tail(struct page *head, int tail_idx)
-- 
2.43.5


