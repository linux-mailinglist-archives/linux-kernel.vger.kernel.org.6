Return-Path: <linux-kernel+bounces-286346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7199519E3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E306B23C76
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E221AED4E;
	Wed, 14 Aug 2024 11:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4Mvi+tW"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C25143C6C;
	Wed, 14 Aug 2024 11:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723635040; cv=none; b=WXQzcopk5UGOAY11/9s49LDVQX5QFkuxo3vIJxZ4WjDYifi26I0iIHcbdBHK78L1n5u//kRQp8Vnx09gEl6qJoZk3FQVXOxyzSLbdIZFGuXNPteFpxHgFHUsGkw7C1V1MBUmKxwEAEIo3Qhiy0qfzTcSeQT3hVq+40aWVKq/Y00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723635040; c=relaxed/simple;
	bh=0Uitr7Znin2cCVYQ/o/39msdIdr0K1ObYmdYY5bDPIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ga+ffRADDm0TcFwNtoQGUy7YrcOWU/++LAjhhever2sjtk5ZRhFqE9KrgxmH70Mw4elCuhNfg6nml2D2KKAXIAvJ9Y+JD+vSI8roA2Q00NvGmAiLjAuzm//KAVtkwJB+WgPoLM66d2Lkv/2kaYv7TNWGCyT3enlr5B9E6SZGrJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4Mvi+tW; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ef2fccca2cso67717771fa.1;
        Wed, 14 Aug 2024 04:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723635036; x=1724239836; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G3QbuTR7PsHCd/KkxZbVnV1PTWpZxVQLKz/yB/X9NSk=;
        b=Z4Mvi+tW4fP8fcF0zbFT4i2EH17Xf1UjSQMkMyKt2p6qWazchJn0fVgBx/PMjBjJx9
         m5VP0IOx120l+s0PdBmIgoe+paAjsEmoY6fskaDTw1vPQU99peSybsPzZ26FcBqatxKx
         +2nTqM7iFba+JpHOZ0d4PSfvk4yOxRtiJ/6+i/1aLrOBfuLjoVoYdrW375L1Wdzjckvb
         /qsGRT/jUfpUycOclM1fucThI5BEacCWHiZfeUAZyXfM/ARWVFqslPB+CYvEnlKgrW6A
         YFUzbdiILbSco+x6dR0TwTkiCNWUrAR1mCDm608+FMpUxdky5RJyYhh1BhM7oIZCjkvs
         FCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723635036; x=1724239836;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G3QbuTR7PsHCd/KkxZbVnV1PTWpZxVQLKz/yB/X9NSk=;
        b=FMBvK3GuI1zYOplOyHIj4FqxEG62hg78QmkJbzluUmIV9F12/qRa5dXxNKeswMrrBG
         p2AZD9iwu/w5qMf/L4za08PvTy5PA1xEwivfzV03S26UFjyZHoK6mGWLM2Rl1GdBrBGs
         kH6Z8huIobxwLuO+yXqJvlv6nBdZLUj46OEILQvlZydBH9r0WtZI7RF+TpwRv9t7HVEP
         O8qpDxkqmmr7PW46bVeAOp5ubLo9WFFTZGfS895g+9Cs5XHTqybM2nOd4Dq6rkZe3ny8
         abcBDHceEdnAYPIXA5A7BqisRZAKu2AQGY6huDiTRMR9MvLUV7DtPOPlyJ0u60Lllewd
         XqSg==
X-Forwarded-Encrypted: i=1; AJvYcCXk2rD2kKZfXo8BB/1CNxJ/jj/YylFKEgBCCrEZtUByTfF5KiZZpu6tI5xyD7m12HvkhsJSXXdGR+W7vVOsMJhxLH5i3ZLBWxrIB9mAi2ZrHm0hE/IXXtaJVobC4dxCkNYmLyAEpyGY
X-Gm-Message-State: AOJu0YzYXeCcJ1ZHnyUbA+FPL28/kzILFC6XVuibYi+t8dDWFJyjHiDY
	tBlnp6QzZt5iF3Q+8DNelYrfJymxRr2Vucv1f4GrH15rZx9/ntPC
X-Google-Smtp-Source: AGHT+IGrqyNakt/u8rUOXDeQW962cysoAw9v98qCsgoCkg6l6CaEsEDRGE8vwyR0MnhGuub+Ft/sXw==
X-Received: by 2002:a2e:d02:0:b0:2ec:5c94:3d99 with SMTP id 38308e7fff4ca-2f3aa1a5887mr13352891fa.2.1723635035883;
        Wed, 14 Aug 2024 04:30:35 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::4:61b7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd187f4e19sm3731357a12.20.2024.08.14.04.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 04:30:35 -0700 (PDT)
Message-ID: <4bf9b1ba-ee3a-4c9a-b8ab-d1cc27838130@gmail.com>
Date: Wed, 14 Aug 2024 12:30:34 +0100
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
 <925804e4-0b33-45eb-905d-e00f67192828@gmail.com>
 <CAGsJ_4x4Ha5jDZuhNxXvbYU6WXtR9A-o3QxYUHkcUzrzoNWaMw@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAGsJ_4x4Ha5jDZuhNxXvbYU6WXtR9A-o3QxYUHkcUzrzoNWaMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 14/08/2024 12:20, Barry Song wrote:
> On Wed, Aug 14, 2024 at 11:11 PM Usama Arif <usamaarif642@gmail.com> wrote:
>>
>>
>>
>> On 14/08/2024 11:44, Barry Song wrote:
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
>>>
>>> Hi Usama,
>>>
>>> Do we need this? When can a partially_mapped folio on deferred_list become
>>> non-partially-mapped and need a clear? I understand transferring from
>>> entirely_map
>>> to partially_mapped is a one way process? partially_mapped folios can't go back
>>> to entirely_mapped?
>>>
>> Hi Barry,
>>
>> deferred_split_folio function is called in 3 places after this series, at fault, collapse and partial mapping. partial mapping can only happen after fault/collapse, and we have FOLIO_FLAG_FALSE(partially_mapped), i.e. flag initialized to false, so technically its not needed. A partially_mapped folio on deferred list wont become non-partially mapped.
>>
>> I just did it as a precaution if someone ever changes the kernel and calls deferred_split_folio with partially_mapped set to false after it had been true. The function arguments of deferred_split_folio make it seem that passing partially_mapped=false as an argument would clear it, which is why I cleared it as well. I could change the patch to something like below if it makes things better? i.e. add a comment at the top of the function:
>>
> 
> to me, it seems a BUG to call with false after a folio has been
> partially_mapped. So I'd rather
> VM_WARN_ON_FOLIO(folio_test_partially_mapped(folio), folio);
> 
> The below should also fix the MTHP_STAT_SPLIT_DEFERRED
> counter this patch is breaking?
> 
> @@ -3515,16 +3522,18 @@ void deferred_split_folio(struct folio *folio,
> bool partially_mapped)
>                 return;
> 
>         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> -       if (partially_mapped)
> -               folio_set_partially_mapped(folio);
> -       else
> -               folio_clear_partially_mapped(folio);
> -       if (list_empty(&folio->_deferred_list)) {
> -               if (partially_mapped) {
> +       if (partially_mapped) {
> +               if (!folio_test_set_partially_mapped(folio)) {
> +                       mod_mthp_stat(folio_order(folio),
> +                               MTHP_STAT_NR_SPLIT_DEFERRED, 1);
>                         if (folio_test_pmd_mappable(folio))
>                                 count_vm_event(THP_DEFERRED_SPLIT_PAGE);
>                         count_mthp_stat(folio_order(folio),
> MTHP_STAT_SPLIT_DEFERRED);
>                 }
> +       }
> +       VM_WARN_ON_FOLIO(folio_test_partially_mapped(folio), folio);
> +
> +       if (list_empty(&folio->_deferred_list)) {
>                 list_add_tail(&folio->_deferred_list, &ds_queue->split_queue);
>                 ds_queue->split_queue_len++;
>  #ifdef CONFIG_MEMCG
> 
> 
So I had sent the below without the VM_WARN_ON_FOLIO as a reply to the other email, below is with VM_WARN.


-void deferred_split_folio(struct folio *folio)
+/* partially_mapped=false won't clear PG_partially_mapped folio flag */
+void deferred_split_folio(struct folio *folio, bool partially_mapped)
 {
        struct deferred_split *ds_queue = get_deferred_split_queue(folio);
 #ifdef CONFIG_MEMCG
@@ -3485,14 +3488,17 @@ void deferred_split_folio(struct folio *folio)
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
+       } else {
+               /* partially mapped folios cannont become partially unmapped */
+               VM_WARN_ON_FOLIO(folio_test_partially_mapped(folio), folio);
+       }
+       if (list_empty(&folio->_deferred_list)) {
                list_add_tail(&folio->_deferred_list, &ds_queue->split_queue);
                ds_queue->split_queue_len++;
 #ifdef CONFIG_MEMCG

 Thanks

