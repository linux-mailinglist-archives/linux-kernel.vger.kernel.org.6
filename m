Return-Path: <linux-kernel+bounces-286332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5899519C4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49078B228E0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430C81AED20;
	Wed, 14 Aug 2024 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HV3UDUxa"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A9D13D52A;
	Wed, 14 Aug 2024 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723634428; cv=none; b=GB8OoAI1ONoEGs/3YTwXuzUAdJzcrgnlXcbcIIWuflY/qQRrzfc5jUVpHLGIIlBQl/uVrH+I3PQUSTQ4JrpWnL65MZfO+8PDSu9gVAdzsc9ljyh4ybvLiaDw1m7Vrl6rZUH70CDUIYjG99Gu1DYXpQyNZJitC/Qie80NRTScS4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723634428; c=relaxed/simple;
	bh=P6xpCcqGGSAzh1jZ9OCoHS73J5OnrRr4pzamusPqh64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fu0/CUA8D/KHdpP0YG9Psd+D1NQZc9M8ioYgCq86M3FgnxBtO9VWmNlbEvbKF+oG1Gd62lrMtzPkJqfEqf77FAE52raNOGZbxrAp7MjYfVUD/kF8+fp6/hu185LvAmRY8JHAsQbpGnRn558HYiWQQqujBogbux+W/I/CWlTmv3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HV3UDUxa; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a156557026so6796271a12.2;
        Wed, 14 Aug 2024 04:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723634425; x=1724239225; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tb6J3EBLjoNeA2OGyKq3VDoDanL15VcTO4gE9p8DPvA=;
        b=HV3UDUxa/a2EDAkE63bge4rKCrQfoCzi5TURnIwwth3ob7yhHBQ1Dhi7zv9kVI+kat
         pwp1m3Y71i5nLS/RjsZcJBLgHvWIY3WRY1fSJ2fbxDRHG6bq1PGS+w9JBdU3IfZk+wJ9
         4Sihj3sMTT504oRA2v8EE+WUswfa3VFx5fOP0RowbS2bm1NicItOpj0/bMX+xZL8EO9U
         WJ/1JtG0QsU3KhAD+ZoeudKINjuR3Js9K7idf6QdPl51iv+E/wls/CZ71Ja5e6/PLFMb
         GU94Qdoz2EDNx9d3JMDAumUoQ1g3o130bPSFX2S/p7lvkFwxfQDhVH/d2uRVQ8o2etqH
         hxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723634425; x=1724239225;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tb6J3EBLjoNeA2OGyKq3VDoDanL15VcTO4gE9p8DPvA=;
        b=Y7DXKuoo8RjJ/FeDf10e3/n7L5dVmnRG8oSkYJJOJhqeKEz7eiMFoiRqbUjNqoEgej
         6Ol0QPa1GQjwMtYdQfGx+Cs7sajo7uJD6pPW8nuFlfzqZ9W+kyPtLo62CChQZQKDOZ4O
         iM5BFTcXE5BwYXAnoPcex3E5vDGm2DIrAmsxvW4ZMfquPLgn5GtdCKDYzv9Y7a/0KNAU
         gP6QpMaxycvN1cc9MuZX9w8EjU6jbaJa8j4FCwtaccEGPYN1c0WQ89/+F1cRtPu27RZ3
         Wsw+I3McCni7yuzirBbi8MMuD/Hhcg4+ZpsKduuomFQpbuj6sRXRvw8jNop+8BLoqEII
         e1tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP9B94LhCp7znvVWOKr9dXCIiK1iGd/jecWmr/pch3JSp3GOfXbegLlembTb8zLcvnLTWojT0VWwSnrAwS0WaeaJVSMhM0Ui4fWUsMLFPflz4qx6JicBaLssl+5dztU2lx7ELHqViW
X-Gm-Message-State: AOJu0YyRRBGai2sNYyKnASad3WgVe5CMzqzyZANxsj7q1fgkTEGgPGrP
	CcyGLmHvd+2Xqe9FdsGD9FZisn58yEQ4F01XwKLhRjONrlAlMR4Q
X-Google-Smtp-Source: AGHT+IG0voeX5aKQ/WR3VH/GwKdslrggRIzEhGXJGAhCTIBzrdOtWZO74hDQHqf+ohDM30nvGvM5yQ==
X-Received: by 2002:a17:907:e210:b0:a7a:a4be:2f95 with SMTP id a640c23a62f3a-a8366c1fbaemr201841066b.5.1723634424437;
        Wed, 14 Aug 2024 04:20:24 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::4:61b7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f411bb3csm160072166b.116.2024.08.14.04.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 04:20:24 -0700 (PDT)
Message-ID: <59725862-f4fc-456c-bafb-cbd302777881@gmail.com>
Date: Wed, 14 Aug 2024 12:20:23 +0100
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
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAGsJ_4ySxmhQCXT5Nw09tdGJA+j9=ZEMEuPa6jgX__tM+EMqXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 14/08/2024 12:10, Barry Song wrote:
> On Wed, Aug 14, 2024 at 12:03 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>
>> Currently folio->_deferred_list is used to keep track of
>> partially_mapped folios that are going to be split under memory
>> pressure. In the next patch, all THPs that are faulted in and collapsed
>> by khugepaged are also going to be tracked using _deferred_list.
>>
>> This patch introduces a pageflag to be able to distinguish between
>> partially mapped folios and others in the deferred_list at split time in
>> deferred_split_scan. Its needed as __folio_remove_rmap decrements
>> _mapcount, _large_mapcount and _entire_mapcount, hence it won't be
>> possible to distinguish between partially mapped folios and others in
>> deferred_split_scan.
>>
>> Eventhough it introduces an extra flag to track if the folio is
>> partially mapped, there is no functional change intended with this
>> patch and the flag is not useful in this patch itself, it will
>> become useful in the next patch when _deferred_list has non partially
>> mapped folios.
>>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>> ---
>>  include/linux/huge_mm.h    |  4 ++--
>>  include/linux/page-flags.h |  3 +++
>>  mm/huge_memory.c           | 21 +++++++++++++--------
>>  mm/hugetlb.c               |  1 +
>>  mm/internal.h              |  4 +++-
>>  mm/memcontrol.c            |  3 ++-
>>  mm/migrate.c               |  3 ++-
>>  mm/page_alloc.c            |  5 +++--
>>  mm/rmap.c                  |  3 ++-
>>  mm/vmscan.c                |  3 ++-
>>  10 files changed, 33 insertions(+), 17 deletions(-)
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index 4c32058cacfe..969f11f360d2 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -321,7 +321,7 @@ static inline int split_huge_page(struct page *page)
>>  {
>>         return split_huge_page_to_list_to_order(page, NULL, 0);
>>  }
>> -void deferred_split_folio(struct folio *folio);
>> +void deferred_split_folio(struct folio *folio, bool partially_mapped);
>>
>>  void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>>                 unsigned long address, bool freeze, struct folio *folio);
>> @@ -495,7 +495,7 @@ static inline int split_huge_page(struct page *page)
>>  {
>>         return 0;
>>  }
>> -static inline void deferred_split_folio(struct folio *folio) {}
>> +static inline void deferred_split_folio(struct folio *folio, bool partially_mapped) {}
>>  #define split_huge_pmd(__vma, __pmd, __address)        \
>>         do { } while (0)
>>
>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>> index a0a29bd092f8..cecc1bad7910 100644
>> --- a/include/linux/page-flags.h
>> +++ b/include/linux/page-flags.h
>> @@ -182,6 +182,7 @@ enum pageflags {
>>         /* At least one page in this folio has the hwpoison flag set */
>>         PG_has_hwpoisoned = PG_active,
>>         PG_large_rmappable = PG_workingset, /* anon or file-backed */
>> +       PG_partially_mapped, /* was identified to be partially mapped */
>>  };
>>
>>  #define PAGEFLAGS_MASK         ((1UL << NR_PAGEFLAGS) - 1)
>> @@ -861,8 +862,10 @@ static inline void ClearPageCompound(struct page *page)
>>         ClearPageHead(page);
>>  }
>>  FOLIO_FLAG(large_rmappable, FOLIO_SECOND_PAGE)
>> +FOLIO_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
>>  #else
>>  FOLIO_FLAG_FALSE(large_rmappable)
>> +FOLIO_FLAG_FALSE(partially_mapped)
>>  #endif
>>
>>  #define PG_head_mask ((1UL << PG_head))
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 6df0e9f4f56c..c024ab0f745c 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3397,6 +3397,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>>                          * page_deferred_list.
>>                          */
>>                         list_del_init(&folio->_deferred_list);
>> +                       folio_clear_partially_mapped(folio);
>>                 }
>>                 spin_unlock(&ds_queue->split_queue_lock);
>>                 if (mapping) {
>> @@ -3453,11 +3454,12 @@ void __folio_undo_large_rmappable(struct folio *folio)
>>         if (!list_empty(&folio->_deferred_list)) {
>>                 ds_queue->split_queue_len--;
>>                 list_del_init(&folio->_deferred_list);
>> +               folio_clear_partially_mapped(folio);
>>         }
>>         spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>>  }
>>
>> -void deferred_split_folio(struct folio *folio)
>> +void deferred_split_folio(struct folio *folio, bool partially_mapped)
>>  {
>>         struct deferred_split *ds_queue = get_deferred_split_queue(folio);
>>  #ifdef CONFIG_MEMCG
>> @@ -3485,14 +3487,17 @@ void deferred_split_folio(struct folio *folio)
>>         if (folio_test_swapcache(folio))
>>                 return;
>>
>> -       if (!list_empty(&folio->_deferred_list))
>> -               return;
>> -
>>         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>> +       if (partially_mapped)
>> +               folio_set_partially_mapped(folio);
>> +       else
>> +               folio_clear_partially_mapped(folio);
>>         if (list_empty(&folio->_deferred_list)) {
>> -               if (folio_test_pmd_mappable(folio))
>> -                       count_vm_event(THP_DEFERRED_SPLIT_PAGE);
>> -               count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
>> +               if (partially_mapped) {
>> +                       if (folio_test_pmd_mappable(folio))
>> +                               count_vm_event(THP_DEFERRED_SPLIT_PAGE);
>> +                       count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
> 
> This code completely broke MTHP_STAT_SPLIT_DEFERRED for PMD_ORDER. It
> added the folio to the deferred_list as entirely_mapped
> (partially_mapped == false).
> However, when partially_mapped becomes true, there's no opportunity to
> add it again
> as it has been there on the list. Are you consistently seeing the counter for
> PMD_ORDER as 0?
> 

Ah I see it, this should fix it?

-void deferred_split_folio(struct folio *folio)
+/* partially_mapped=false won't clear PG_partially_mapped folio flag */
+void deferred_split_folio(struct folio *folio, bool partially_mapped)
 {
        struct deferred_split *ds_queue = get_deferred_split_queue(folio);
 #ifdef CONFIG_MEMCG
@@ -3485,14 +3488,14 @@ void deferred_split_folio(struct folio *folio)
        if (folio_test_swapcache(folio))
                return;
 
-       if (!list_empty(&folio->_deferred_list))
-               return;
-
        spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
-       if (list_empty(&folio->_deferred_list)) {
+       if (partially_mapped) {
+               folio_set_partially_mapped(folio);
                if (folio_test_pmd_mappable(folio))
                        count_vm_event(THP_DEFERRED_SPLIT_PAGE);
                count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
+       }
+       if (list_empty(&folio->_deferred_list)) {
                list_add_tail(&folio->_deferred_list, &ds_queue->split_queue);
                ds_queue->split_queue_len++;
 #ifdef CONFIG_MEMCG


