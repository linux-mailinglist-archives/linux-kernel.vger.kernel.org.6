Return-Path: <linux-kernel+bounces-286324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E609519A9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3101C1F234F0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E291AE84E;
	Wed, 14 Aug 2024 11:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEdiwC6q"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3083D552;
	Wed, 14 Aug 2024 11:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723633891; cv=none; b=AL5K7vXNEAaca+MQd4L3qo3ftoze9ryEmyN4L9mr7BkMIGgrMPAmL9k9ip7v71xvb3tJW4u1PpAZuIRBZjJaJVLUfgDoOZmcdRt8KAPSRNY7e5fzml2w3NzIBECzU2TXDS8l5S5BDCsvUVYEtwF3of5hNpInihmqc2Gl+tVjVHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723633891; c=relaxed/simple;
	bh=6x+EwFgMlixsQabpUKBOp0rSA0BXSFVYfxNw3TXOwU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VU8QIciHaUIsWGgGZc0yal8fWA/bmNs2498hRbB6W5xbBFGdvV1J61yAcYEEJZPyvFuPRz2qmMyPfcUXH5xL6YDkY5n1/dAGLlIrwNPIyQKn3Du9u8BIyIEC6VJ5PibOHHCGjvzlDhnWzh+rPO7fs+1GEun8bzevWBvel40Kays=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEdiwC6q; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a83597ce5beso121128766b.1;
        Wed, 14 Aug 2024 04:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723633888; x=1724238688; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bd95t4QRiWzWEZTdTjQVQS44zRvwX6u9xVdH0F86DIg=;
        b=PEdiwC6q3gP0c0EAte7By/ugLh9YwMmECEkKxkx2bYFhn9OzDGQgUlJ1OGYcCzZyso
         4bgRP869DPepWF737h9xGRbwkIsAPQaf0nBMcE2wColnmeKDOtaHZZ2REYq0mX+/4i4E
         fEYfKeY+5hE7KFgQdlvrJdh7q7l9CtHkNajGAQY/IOEOXKPI/5p31mw436IBDTe4Mij8
         3wJgA67GczjhoQ3i5CiSEJFb4Vs/DNwg/Ouvbwmw0z8IXr3eaXceuav7On9ibd7XEWqy
         lJYWbzjkXy+mug/95MEBZd9JseYRNaGZlJ8IVd6JbtxImQmQjN3rUrMBD+aQ1XDhDGAU
         gP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723633888; x=1724238688;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bd95t4QRiWzWEZTdTjQVQS44zRvwX6u9xVdH0F86DIg=;
        b=Mntokq75MCvjS7wCbqPnIkCDo673wUD+CBKSLCVY6uTWBqhzQhMFZZW0ElIhXLCxPX
         D4hS3tSwjyHXK56Wdel1fHs+rhnGgbtkwlTvvOJejNn3f/qLsBqXCeVppklVL2EKJH5C
         UjgL0jBeKp4zEwsCKKPyBN9jIayFNwEqJ9LxvrXZ1UVfNKRAg7k8o2DemC8l9sLukhp2
         6fLY4mSOeFhfjHDspjlQ2BGyoXHw0Ws5NUHXyL5oqo9jF4DvIOWQbQ5TKugiuykLXvoN
         lvbGm91+mEqDUqyeih/yJbqEksYtjEuzFGFxP0XWBd0l9/0e301ZyrhXnGZOvhMRpOAj
         UX8A==
X-Forwarded-Encrypted: i=1; AJvYcCUIqItCrPOaDhWPTRtgUpjcvH3pOS6RdY359rG9JUomJShmKgFeWPbZH5u+4UdU6h+wb6hFJ2hiWRmDshFfu3KXFUKYPqsYgt2SVHHW/ALJSk32t6xeYfNZR8sQKLZi7bvzuj/c4dvd
X-Gm-Message-State: AOJu0YygTPddTZXGZbjU8iXlNSYGmH2gc4TKmgSxgJeDdfNBFClFVViW
	9BjjZCLxTVHh2SUqrNjZ9HoNGcr/o86ifeqB5xC1RmqIv+3dp/UA
X-Google-Smtp-Source: AGHT+IGBU4oEgLhtMtUTy0jy1FrOvevihP2RUEWR89Y1SrW/4ky4uCUP/QrzhHHHWRNNQ88+2LKuiQ==
X-Received: by 2002:a17:907:e257:b0:a7c:d284:4f1d with SMTP id a640c23a62f3a-a836afcbf78mr152560766b.28.1723633887604;
        Wed, 14 Aug 2024 04:11:27 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::4:61b7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f4184ec9sm159151466b.219.2024.08.14.04.11.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 04:11:27 -0700 (PDT)
Message-ID: <925804e4-0b33-45eb-905d-e00f67192828@gmail.com>
Date: Wed, 14 Aug 2024 12:11:26 +0100
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
 <CAGsJ_4x+5fiCoWv4G0NsYq+aJRqZsrCEHO_DF+CnNFdqx0VgMQ@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAGsJ_4x+5fiCoWv4G0NsYq+aJRqZsrCEHO_DF+CnNFdqx0VgMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 14/08/2024 11:44, Barry Song wrote:
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
> 
> Hi Usama,
> 
> Do we need this? When can a partially_mapped folio on deferred_list become
> non-partially-mapped and need a clear? I understand transferring from
> entirely_map
> to partially_mapped is a one way process? partially_mapped folios can't go back
> to entirely_mapped?
> 
Hi Barry,

deferred_split_folio function is called in 3 places after this series, at fault, collapse and partial mapping. partial mapping can only happen after fault/collapse, and we have FOLIO_FLAG_FALSE(partially_mapped), i.e. flag initialized to false, so technically its not needed. A partially_mapped folio on deferred list wont become non-partially mapped. 

I just did it as a precaution if someone ever changes the kernel and calls deferred_split_folio with partially_mapped set to false after it had been true. The function arguments of deferred_split_folio make it seem that passing partially_mapped=false as an argument would clear it, which is why I cleared it as well. I could change the patch to something like below if it makes things better? i.e. add a comment at the top of the function:


-void deferred_split_folio(struct folio *folio)
+/* partially_mapped=false won't clear PG_partially_mapped folio flag */
+void deferred_split_folio(struct folio *folio, bool partially_mapped)
 {
        struct deferred_split *ds_queue = get_deferred_split_queue(folio);
 #ifdef CONFIG_MEMCG
@@ -3485,14 +3488,15 @@ void deferred_split_folio(struct folio *folio)
        if (folio_test_swapcache(folio))
                return;
 
-       if (!list_empty(&folio->_deferred_list))
-               return;
-
        spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
+       if (partially_mapped)
+               folio_set_partially_mapped(folio);
        if (list_empty(&folio->_deferred_list)) {
-               if (folio_test_pmd_mappable(folio))
-                       count_vm_event(THP_DEFERRED_SPLIT_PAGE);
-               count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
+               if (partially_mapped) {
+                       if (folio_test_pmd_mappable(folio))
+                               count_vm_event(THP_DEFERRED_SPLIT_PAGE);
+                       count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
+               }
                list_add_tail(&folio->_deferred_list, &ds_queue->split_queue);
                ds_queue->split_queue_len++;
 #ifdef CONFIG_MEMCG


> I am trying to rebase my NR_SPLIT_DEFERRED counter on top of your
> work, but this "clear" makes that job quite tricky. as I am not sure
> if this patch
> is going to clear the partially_mapped flag for folios on deferred_list.
> 
> Otherwise, I can simply do the below whenever folio is leaving deferred_list
> 
>         ds_queue->split_queue_len--;
>         list_del_init(&folio->_deferred_list);
>         if (folio_test_clear_partially_mapped(folio))
>                 mod_mthp_stat(folio_order(folio),
> MTHP_STAT_NR_SPLIT_DEFERRED, -1);
> 

