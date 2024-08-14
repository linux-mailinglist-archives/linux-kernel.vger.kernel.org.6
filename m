Return-Path: <linux-kernel+bounces-286439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21618951AF7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46AF31C20B26
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F391B1408;
	Wed, 14 Aug 2024 12:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTsLfkKJ"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B36C19FA86;
	Wed, 14 Aug 2024 12:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723639023; cv=none; b=ZqlwW4+5Bx4bTsLdw4gMWFFXsNMcA73lOWGzxgoQ/rxjmRT28n7bcBvWubKhx4CiJfuZe9kst4CllHS3QNRigREtukiq1UN6W/3S80y03bqBMftVd6MuZluf+tbizDNcclstlAj9QhCO59xcS7f0/40/8PGrtwSTmw/K0D/OjBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723639023; c=relaxed/simple;
	bh=VKLir/XLcvrzdiQLW/cgPDn5nr9NUrhrnjazWL+94vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bmWPs9ofDIV1MrMfEG1Nz6SsDFul/OLvY7R9IQVwTAGc/o2KddmtOoWxaQd2M1lkrddxgmjyPwEkj+rCNQdUPS8avjStFsvq6jLcm9iJMTfCXPpTAjp6uPYnHyl4Mbbgk1NTsc5HbIS69tLY8uNAEnylkmr8zM1QIp9I9oEY/cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTsLfkKJ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5af326eddb2so1392990a12.1;
        Wed, 14 Aug 2024 05:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723639019; x=1724243819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RZGRk6bxM+/eTZHcLB9jghVV2vIOFeDkAkCxLic2QXc=;
        b=WTsLfkKJJXKVu5bWsGOhbC7WyzuGS2Sl7IrZM9WSkqA6jcZvZ/YHVW2i32IMEXZLOm
         IKhdkWHgOps2aMGDTIOirxR/CYgW/x3OeNVxQg3vFIuA7IuhR3SG8B0wFOtYLkHHM8eW
         r8VE5rltPN6kd/lARVnOCu30JpVdTxPY23wQ1bwrp850XW3kodNRtrqz8kctp2CWaTB7
         bAi/gnPKMNHhYPUHKZVHakDHZkl2351wrmQEdlWFTxX2RKUV6CSz0mnNIjI8a1Jl4quc
         ETEKuGoE8oyNMq17rM223heyqG9FDa+FAyFxm5Z+VLc212SSDcj3S76rqwkHUhcMGcAh
         QILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723639019; x=1724243819;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZGRk6bxM+/eTZHcLB9jghVV2vIOFeDkAkCxLic2QXc=;
        b=V+Uf1xuxTp2vIo8TrZUUkd5aMwNyZE0El9eYft4JQ4rqRtYDISF8V/FZBAiyi39TmQ
         LtZdlL1DokBWXwZHRDB/b2oq+s5fVkZlcroEOFAb1YvUJ4S4qZp2MYUcOeCPrh23kZoT
         n176zp3K8Yn0D4MTEf3Yajx/f+Q6CTCrxIXrUttc41jyZLAdhwSRt3uHZMooZaQ2lFrs
         AqOnxScvh1E/b1SkTC4cj0i1W5dmnJsrK5w9T9waSir8PLC7SpsEAQqVZrsVqAZAsS0p
         vTSMj3166qHtixuoKcBOR2bCVYetY2C566o6eZlS44uCRLATfpBNGG52OOXh6uzQ1PF+
         mj0g==
X-Forwarded-Encrypted: i=1; AJvYcCVnKDWHq1ZjeU5oig+KMmRMdB8MKHkKSHU3Tbd5MZFoapPFbY150KqQEJHBM1HpqfNaW58VxR6OWRxy7d8X+cEVz9Nl5osLxqRJjs+vV9FsP/nMFIEQVYWdHDMFpgzErv2OREsA5AqL
X-Gm-Message-State: AOJu0YzVQKkbPzt96vYtFMtYMZ6ZHkfYB+otTNuNvkAVvQ20vC4yGaAU
	joEj2Crm1gyPrWRDBJ29FXX5SfW072ZMdUSX9oyk4UntEqCNOK0U
X-Google-Smtp-Source: AGHT+IEnIGFZX9kzzbutJ1qxerJXhFCeqJ8JjjG8kOisUdAOlgit3F2cBktHmUj3eeqh8oX1Tfi/7w==
X-Received: by 2002:a17:907:96ab:b0:a72:5967:b34 with SMTP id a640c23a62f3a-a836afcbfc2mr170367866b.22.1723639019054;
        Wed, 14 Aug 2024 05:36:59 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::4:61b7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f4181a4esm167043666b.193.2024.08.14.05.36.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 05:36:58 -0700 (PDT)
Message-ID: <88d411c5-6d66-4d41-ae86-e0f943e5fb91@gmail.com>
Date: Wed, 14 Aug 2024 13:36:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] mm: Introduce a pageflag for partially mapped
 folios
To: Barry Song <baohua@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org,
 riel@surriel.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev,
 yuzhao@google.com, david@redhat.com, ryan.roberts@arm.com, rppt@kernel.org,
 willy@infradead.org, cerasuolodomenico@gmail.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kernel-team@meta.com
References: <20240813120328.1275952-1-usamaarif642@gmail.com>
 <20240813120328.1275952-5-usamaarif642@gmail.com>
 <CAGsJ_4ySxmhQCXT5Nw09tdGJA+j9=ZEMEuPa6jgX__tM+EMqXw@mail.gmail.com>
 <59725862-f4fc-456c-bafb-cbd302777881@gmail.com>
 <CAGsJ_4zT0R_QcHCvPW7EozY86Skbo_3BtgcJz_fd-tipXZJxTQ@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAGsJ_4zT0R_QcHCvPW7EozY86Skbo_3BtgcJz_fd-tipXZJxTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 14/08/2024 12:23, Barry Song wrote:
> On Wed, Aug 14, 2024 at 11:20 PM Usama Arif <usamaarif642@gmail.com> wrote:
>>
>>
>>
>> On 14/08/2024 12:10, Barry Song wrote:
>>> On Wed, Aug 14, 2024 at 12:03 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>>>
>>>> Currently folio->_deferred_list is used to keep track of
>>>> partially_mapped folios that are going to be split under memory
>>>> pressure. In the next patch, all THPs that are faulted in and collapsed
>>>> by khugepaged are also going to be tracked using _deferred_list.
>>>>
>>>> This patch introduces a pageflag to be able to distinguish between
>>>> partially mapped folios and others in the deferred_list at split time in
>>>> deferred_split_scan. Its needed as __folio_remove_rmap decrements
>>>> _mapcount, _large_mapcount and _entire_mapcount, hence it won't be
>>>> possible to distinguish between partially mapped folios and others in
>>>> deferred_split_scan.
>>>>
>>>> Eventhough it introduces an extra flag to track if the folio is
>>>> partially mapped, there is no functional change intended with this
>>>> patch and the flag is not useful in this patch itself, it will
>>>> become useful in the next patch when _deferred_list has non partially
>>>> mapped folios.
>>>>
>>>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>>>> ---
>>>>  include/linux/huge_mm.h    |  4 ++--
>>>>  include/linux/page-flags.h |  3 +++
>>>>  mm/huge_memory.c           | 21 +++++++++++++--------
>>>>  mm/hugetlb.c               |  1 +
>>>>  mm/internal.h              |  4 +++-
>>>>  mm/memcontrol.c            |  3 ++-
>>>>  mm/migrate.c               |  3 ++-
>>>>  mm/page_alloc.c            |  5 +++--
>>>>  mm/rmap.c                  |  3 ++-
>>>>  mm/vmscan.c                |  3 ++-
>>>>  10 files changed, 33 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>>> index 4c32058cacfe..969f11f360d2 100644
>>>> --- a/include/linux/huge_mm.h
>>>> +++ b/include/linux/huge_mm.h
>>>> @@ -321,7 +321,7 @@ static inline int split_huge_page(struct page *page)
>>>>  {
>>>>         return split_huge_page_to_list_to_order(page, NULL, 0);
>>>>  }
>>>> -void deferred_split_folio(struct folio *folio);
>>>> +void deferred_split_folio(struct folio *folio, bool partially_mapped);
>>>>
>>>>  void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>>>>                 unsigned long address, bool freeze, struct folio *folio);
>>>> @@ -495,7 +495,7 @@ static inline int split_huge_page(struct page *page)
>>>>  {
>>>>         return 0;
>>>>  }
>>>> -static inline void deferred_split_folio(struct folio *folio) {}
>>>> +static inline void deferred_split_folio(struct folio *folio, bool partially_mapped) {}
>>>>  #define split_huge_pmd(__vma, __pmd, __address)        \
>>>>         do { } while (0)
>>>>
>>>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>>>> index a0a29bd092f8..cecc1bad7910 100644
>>>> --- a/include/linux/page-flags.h
>>>> +++ b/include/linux/page-flags.h
>>>> @@ -182,6 +182,7 @@ enum pageflags {
>>>>         /* At least one page in this folio has the hwpoison flag set */
>>>>         PG_has_hwpoisoned = PG_active,
>>>>         PG_large_rmappable = PG_workingset, /* anon or file-backed */
>>>> +       PG_partially_mapped, /* was identified to be partially mapped */
>>>>  };
>>>>
>>>>  #define PAGEFLAGS_MASK         ((1UL << NR_PAGEFLAGS) - 1)
>>>> @@ -861,8 +862,10 @@ static inline void ClearPageCompound(struct page *page)
>>>>         ClearPageHead(page);
>>>>  }
>>>>  FOLIO_FLAG(large_rmappable, FOLIO_SECOND_PAGE)
>>>> +FOLIO_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
>>>>  #else
>>>>  FOLIO_FLAG_FALSE(large_rmappable)
>>>> +FOLIO_FLAG_FALSE(partially_mapped)
>>>>  #endif
>>>>
>>>>  #define PG_head_mask ((1UL << PG_head))
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index 6df0e9f4f56c..c024ab0f745c 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -3397,6 +3397,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>>>>                          * page_deferred_list.
>>>>                          */
>>>>                         list_del_init(&folio->_deferred_list);
>>>> +                       folio_clear_partially_mapped(folio);
>>>>                 }
>>>>                 spin_unlock(&ds_queue->split_queue_lock);
>>>>                 if (mapping) {
>>>> @@ -3453,11 +3454,12 @@ void __folio_undo_large_rmappable(struct folio *folio)
>>>>         if (!list_empty(&folio->_deferred_list)) {
>>>>                 ds_queue->split_queue_len--;
>>>>                 list_del_init(&folio->_deferred_list);
>>>> +               folio_clear_partially_mapped(folio);
>>>>         }
>>>>         spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>>>>  }
>>>>
>>>> -void deferred_split_folio(struct folio *folio)
>>>> +void deferred_split_folio(struct folio *folio, bool partially_mapped)
>>>>  {
>>>>         struct deferred_split *ds_queue = get_deferred_split_queue(folio);
>>>>  #ifdef CONFIG_MEMCG
>>>> @@ -3485,14 +3487,17 @@ void deferred_split_folio(struct folio *folio)
>>>>         if (folio_test_swapcache(folio))
>>>>                 return;
>>>>
>>>> -       if (!list_empty(&folio->_deferred_list))
>>>> -               return;
>>>> -
>>>>         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>>>> +       if (partially_mapped)
>>>> +               folio_set_partially_mapped(folio);
>>>> +       else
>>>> +               folio_clear_partially_mapped(folio);
>>>>         if (list_empty(&folio->_deferred_list)) {
>>>> -               if (folio_test_pmd_mappable(folio))
>>>> -                       count_vm_event(THP_DEFERRED_SPLIT_PAGE);
>>>> -               count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
>>>> +               if (partially_mapped) {
>>>> +                       if (folio_test_pmd_mappable(folio))
>>>> +                               count_vm_event(THP_DEFERRED_SPLIT_PAGE);
>>>> +                       count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
>>>
>>> This code completely broke MTHP_STAT_SPLIT_DEFERRED for PMD_ORDER. It
>>> added the folio to the deferred_list as entirely_mapped
>>> (partially_mapped == false).
>>> However, when partially_mapped becomes true, there's no opportunity to
>>> add it again
>>> as it has been there on the list. Are you consistently seeing the counter for
>>> PMD_ORDER as 0?
>>>
>>
>> Ah I see it, this should fix it?
>>
>> -void deferred_split_folio(struct folio *folio)
>> +/* partially_mapped=false won't clear PG_partially_mapped folio flag */
>> +void deferred_split_folio(struct folio *folio, bool partially_mapped)
>>  {
>>         struct deferred_split *ds_queue = get_deferred_split_queue(folio);
>>  #ifdef CONFIG_MEMCG
>> @@ -3485,14 +3488,14 @@ void deferred_split_folio(struct folio *folio)
>>         if (folio_test_swapcache(folio))
>>                 return;
>>
>> -       if (!list_empty(&folio->_deferred_list))
>> -               return;
>> -
>>         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>> -       if (list_empty(&folio->_deferred_list)) {
>> +       if (partially_mapped) {
>> +               folio_set_partially_mapped(folio);
>>                 if (folio_test_pmd_mappable(folio))
>>                         count_vm_event(THP_DEFERRED_SPLIT_PAGE);
>>                 count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
>> +       }
>> +       if (list_empty(&folio->_deferred_list)) {
>>                 list_add_tail(&folio->_deferred_list, &ds_queue->split_queue);
>>                 ds_queue->split_queue_len++;
>>  #ifdef CONFIG_MEMCG
>>
> 
> not enough. as deferred_split_folio(true) won't be called if folio has been
> deferred_list in __folio_remove_rmap():
> 
>         if (partially_mapped && folio_test_anon(folio) &&
>             list_empty(&folio->_deferred_list))
>                 deferred_split_folio(folio, true);
> 
> so you will still see 0.
> 

ah yes, Thanks.

So below diff over the current v3 series should work for all cases:


diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b4d72479330d..482e3ab60911 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3483,6 +3483,7 @@ void __folio_undo_large_rmappable(struct folio *folio)
        spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
 }
 
+/* partially_mapped=false won't clear PG_partially_mapped folio flag */
 void deferred_split_folio(struct folio *folio, bool partially_mapped)
 {
        struct deferred_split *ds_queue = get_deferred_split_queue(folio);
@@ -3515,16 +3516,16 @@ void deferred_split_folio(struct folio *folio, bool partially_mapped)
                return;
 
        spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
-       if (partially_mapped)
+       if (partially_mapped) {
                folio_set_partially_mapped(folio);
-       else
-               folio_clear_partially_mapped(folio);
+               if (folio_test_pmd_mappable(folio))
+                       count_vm_event(THP_DEFERRED_SPLIT_PAGE);
+               count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
+       } else {
+               /* partially mapped folios cannont become partially unmapped */
+               VM_WARN_ON_FOLIO(folio_test_partially_mapped(folio), folio);
+       }
        if (list_empty(&folio->_deferred_list)) {
-               if (partially_mapped) {
-                       if (folio_test_pmd_mappable(folio))
-                               count_vm_event(THP_DEFERRED_SPLIT_PAGE);
-                       count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
-               }
                list_add_tail(&folio->_deferred_list, &ds_queue->split_queue);
                ds_queue->split_queue_len++;
 #ifdef CONFIG_MEMCG
diff --git a/mm/rmap.c b/mm/rmap.c
index 9ad558c2bad0..4c330635aa4e 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1578,7 +1578,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
         * Check partially_mapped first to ensure it is a large folio.
         */
        if (partially_mapped && folio_test_anon(folio) &&
-           list_empty(&folio->_deferred_list))
+           !folio_test_partially_mapped(folio))
                deferred_split_folio(folio, true);
 
        __folio_mod_stat(folio, -nr, -nr_pmdmapped);

