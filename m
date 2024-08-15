Return-Path: <linux-kernel+bounces-288192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E694C95371B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64FCB1F219AC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035911AD3F3;
	Thu, 15 Aug 2024 15:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPe6z5k0"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22B9176AA3;
	Thu, 15 Aug 2024 15:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723735514; cv=none; b=AZFRnE98ZMBmvGB+wE0eOkEqhfVttufT+bBYNGEoqR+WmuhcgQtpoOVA8dIOG/aLhCh4YkXzWCOjz9hpN1R7PNp7PFyRWnmt4LFY7STnUUwF6HE8M6e/yPB85D3BP0Al5mMPR9VjLUTaMen9cFJKYm9paDOkfVras+MQRGHU+To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723735514; c=relaxed/simple;
	bh=up0KofEG3+6Y0xVpvt65/Y20QAlsQ2f5jfoxyjzCaUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YgLtUh3qOgYTvzhEXDhOTodUiBIyTns5kSN1Os0/0RoTVJT+Ny53LJ1G2O8Y8/44K9HYfrsO67D4OIED6zxY546Ldm4mFbBgTWAGhyWjsrVeISYTWoUjvFr2ro1xgtAHKUd35ULD4QQUsE5ESuBEFMeh9F9ITmGuOqD7kHXnWN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPe6z5k0; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so6829995e9.2;
        Thu, 15 Aug 2024 08:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723735511; x=1724340311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8v1mzjCIPNIdgqV+hMVIEVVgOLKzqn9k/EPR2ZkKPYM=;
        b=iPe6z5k0gCOX1vMtKS1xJzUM1jf8KahIssMOcmGmDQ5QPFKILhVaMBqQ3mP47B85fT
         ABGkXxh39IIvuOGnkfWC/rWkwuETtJDSCn2gE4G+COBOmDKL/BO+p7RCCNK78VsTlSE2
         83o9n31FiM4ctw+/ohNYSw4KsbI6JjZ6EPG4FMevELe5OPUe+tuPiqw320U/+YAb8280
         Y/AwJTDx5wlbxzB5vk8OR3ctG7i/qqb6LMOpTwh/JLrYFOFGOZRi6w2eE+bebk9s9i0x
         tvEo4LWM+Q4q9aQCnGObaNEvyKcI98VRnWGJqw/sQlyOMXd0JIAW/FapSLihGS5NY+1W
         ifyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723735511; x=1724340311;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8v1mzjCIPNIdgqV+hMVIEVVgOLKzqn9k/EPR2ZkKPYM=;
        b=MzYsqOpnsn2uIGp5yIu8XMiRYqNqYky893yOMa/iuj1XtQAglqFth1RCrwocPz5H8v
         lKb4TTSx1Zqe7F24w96VMue+PzUMOz4/EY2vVrtSjCLZgZPpzKUEapS1gnaqIhONr9Un
         rVsp97UhnioiZjZAHc+4xObha/aeixWIfVutcf8hCOBSywrvbNi/ROoqvj7eWxgWzHER
         shI3gjMPSJxAgmJvS98PWmquooDj8RYv1Ye4yCb6Q9f6A5NbFs5NPh8r5j6/kfKml2wy
         sow/Cb2eIICZWJy0EBzljhiZ/ph7fkGLFT1YHf8adiiMk3XoS5YZ2xJBPfjnlceoFnlf
         eegA==
X-Forwarded-Encrypted: i=1; AJvYcCXPBnT82CMWmKxnvDJv32qYZakyJBNRdVAkuU6jxr1D8srBJhARduWH2qdqqYiXrcuPV3IudKV5r/VM2Wn+3A7/nuE9eLyXpVdFG3a8yaE6T7oxHt9m9w0O7QYtUr5Ev8vlZmDHbz/v
X-Gm-Message-State: AOJu0YzNSPZBA7skPAkxNSsPeGYdQF8KSj7YuJ6m/pl1hJrlH7phBxEP
	KZA3MqiSNRSbjvU2TsyGCseEuLUFT+4GjkNaqhH9iP7ZY95iYgQM
X-Google-Smtp-Source: AGHT+IHA/Z8MYvLh/9a2fJdNDtEjp42BufsuAtyXox/DR5clkJZvTnCF2waMiTHHvinltgzfBEdwxg==
X-Received: by 2002:a05:600c:154c:b0:428:314:f08e with SMTP id 5b1f17b1804b1-429dd234ae2mr43692845e9.5.1723735510719;
        Thu, 15 Aug 2024 08:25:10 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e750:7600:c5:51ce:2b5:970b? ([2a02:6b6f:e750:7600:c5:51ce:2b5:970b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded7dae0sm51548985e9.44.2024.08.15.08.25.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 08:25:10 -0700 (PDT)
Message-ID: <4acdf2b7-ed65-4087-9806-8f4a187b4eb5@gmail.com>
Date: Thu, 15 Aug 2024 16:25:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] mm: Introduce a pageflag for partially mapped
 folios
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org
Cc: baohua@kernel.org, cerasuolodomenico@gmail.com, corbet@lwn.net,
 david@redhat.com, hannes@cmpxchg.org, kernel-team@meta.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 riel@surriel.com, roman.gushchin@linux.dev, rppt@kernel.org,
 ryan.roberts@arm.com, shakeel.butt@linux.dev, willy@infradead.org,
 yuzhao@google.com
References: <88d411c5-6d66-4d41-ae86-e0f943e5fb91@gmail.com>
 <20240814230533.54938-1-21cnbao@gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20240814230533.54938-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 15/08/2024 00:05, Barry Song wrote:
> 
> On Thu, Aug 15, 2024 at 12:37 AM Usama Arif <usamaarif642@gmail.com> wrote:
> [snip]
>>>>>>
>>>>>> -void deferred_split_folio(struct folio *folio)
>>>>>> +void deferred_split_folio(struct folio *folio, bool partially_mapped)
>>>>>>  {
>>>>>>         struct deferred_split *ds_queue = get_deferred_split_queue(folio);
>>>>>>  #ifdef CONFIG_MEMCG
>>>>>> @@ -3485,14 +3487,17 @@ void deferred_split_folio(struct folio *folio)
>>>>>>         if (folio_test_swapcache(folio))
>>>>>>                 return;
>>>>>>
>>>>>> -       if (!list_empty(&folio->_deferred_list))
>>>>>> -               return;
>>>>>> -
>>>>>>         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>>>>>> +       if (partially_mapped)
>>>>>> +               folio_set_partially_mapped(folio);
>>>>>> +       else
>>>>>> +               folio_clear_partially_mapped(folio);
>>>>>>         if (list_empty(&folio->_deferred_list)) {
>>>>>> -               if (folio_test_pmd_mappable(folio))
>>>>>> -                       count_vm_event(THP_DEFERRED_SPLIT_PAGE);
>>>>>> -               count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
>>>>>> +               if (partially_mapped) {
>>>>>> +                       if (folio_test_pmd_mappable(folio))
>>>>>> +                               count_vm_event(THP_DEFERRED_SPLIT_PAGE);
>>>>>> +                       count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
>>>>>
>>>>> This code completely broke MTHP_STAT_SPLIT_DEFERRED for PMD_ORDER. It
>>>>> added the folio to the deferred_list as entirely_mapped
>>>>> (partially_mapped == false).
>>>>> However, when partially_mapped becomes true, there's no opportunity to
>>>>> add it again
>>>>> as it has been there on the list. Are you consistently seeing the counter for
>>>>> PMD_ORDER as 0?
>>>>>
>>>>
>>>> Ah I see it, this should fix it?
>>>>
>>>> -void deferred_split_folio(struct folio *folio)
>>>> +/* partially_mapped=false won't clear PG_partially_mapped folio flag */
>>>> +void deferred_split_folio(struct folio *folio, bool partially_mapped)
>>>>  {
>>>>         struct deferred_split *ds_queue = get_deferred_split_queue(folio);
>>>>  #ifdef CONFIG_MEMCG
>>>> @@ -3485,14 +3488,14 @@ void deferred_split_folio(struct folio *folio)
>>>>         if (folio_test_swapcache(folio))
>>>>                 return;
>>>>
>>>> -       if (!list_empty(&folio->_deferred_list))
>>>> -               return;
>>>> -
>>>>         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>>>> -       if (list_empty(&folio->_deferred_list)) {
>>>> +       if (partially_mapped) {
>>>> +               folio_set_partially_mapped(folio);
>>>>                 if (folio_test_pmd_mappable(folio))
>>>>                         count_vm_event(THP_DEFERRED_SPLIT_PAGE);
>>>>                 count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
>>>> +       }
>>>> +       if (list_empty(&folio->_deferred_list)) {
>>>>                 list_add_tail(&folio->_deferred_list, &ds_queue->split_queue);
>>>>                 ds_queue->split_queue_len++;
>>>>  #ifdef CONFIG_MEMCG
>>>>
>>>
>>> not enough. as deferred_split_folio(true) won't be called if folio has been
>>> deferred_list in __folio_remove_rmap():
>>>
>>>         if (partially_mapped && folio_test_anon(folio) &&
>>>             list_empty(&folio->_deferred_list))
>>>                 deferred_split_folio(folio, true);
>>>
>>> so you will still see 0.
>>>
>>
>> ah yes, Thanks.
>>
>> So below diff over the current v3 series should work for all cases:
>>
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index b4d72479330d..482e3ab60911 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3483,6 +3483,7 @@ void __folio_undo_large_rmappable(struct folio *folio)
>>         spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>>  }
>>
>> +/* partially_mapped=false won't clear PG_partially_mapped folio flag */
>>  void deferred_split_folio(struct folio *folio, bool partially_mapped)
>>  {
>>         struct deferred_split *ds_queue = get_deferred_split_queue(folio);
>> @@ -3515,16 +3516,16 @@ void deferred_split_folio(struct folio *folio, bool partially_mapped)
>>                 return;
>>
>>         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>> -       if (partially_mapped)
>> +       if (partially_mapped) {
>>                 folio_set_partially_mapped(folio);
>> -       else
>> -               folio_clear_partially_mapped(folio);
>> +               if (folio_test_pmd_mappable(folio))
>> +                       count_vm_event(THP_DEFERRED_SPLIT_PAGE);
>> +               count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
>> +       } else {
>> +               /* partially mapped folios cannont become partially unmapped */
>> +               VM_WARN_ON_FOLIO(folio_test_partially_mapped(folio), folio);
>> +       }
>>         if (list_empty(&folio->_deferred_list)) {
>> -               if (partially_mapped) {
>> -                       if (folio_test_pmd_mappable(folio))
>> -                               count_vm_event(THP_DEFERRED_SPLIT_PAGE);
>> -                       count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
>> -               }
>>                 list_add_tail(&folio->_deferred_list, &ds_queue->split_queue);
>>                 ds_queue->split_queue_len++;
>>  #ifdef CONFIG_MEMCG
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 9ad558c2bad0..4c330635aa4e 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1578,7 +1578,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>>          * Check partially_mapped first to ensure it is a large folio.
>>          */
>>         if (partially_mapped && folio_test_anon(folio) &&
>> -           list_empty(&folio->_deferred_list))
>> +           !folio_test_partially_mapped(folio))
>>                 deferred_split_folio(folio, true);
>>
>>         __folio_mod_stat(folio, -nr, -nr_pmdmapped);
>>
> 
> This is an improvement, but there's still an issue. Two or more threads can
> execute deferred_split_folio() simultaneously, which could lead to
> DEFERRED_SPLIT being added multiple times. We should double-check
> the status after acquiring the spinlock.
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index f401ceded697..3d247826fb95 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3607,10 +3607,12 @@ void deferred_split_folio(struct folio *folio, bool partially_mapped)
>  
>  	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>  	if (partially_mapped) {
> -		folio_set_partially_mapped(folio);
> -		if (folio_test_pmd_mappable(folio))
> -			count_vm_event(THP_DEFERRED_SPLIT_PAGE);
> -		count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
> +		if (!folio_test_partially_mapped(folio)) {
> +			folio_set_partially_mapped(folio);
> +			if (folio_test_pmd_mappable(folio))
> +				count_vm_event(THP_DEFERRED_SPLIT_PAGE);
> +			count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
> +		}
>  	} else {
>  		/* partially mapped folios cannont become partially unmapped */
>  		VM_WARN_ON_FOLIO(folio_test_partially_mapped(folio), folio);

Actually above is still not thread safe. multiple threads can test partially_mapped and see its false at the same time and all of them would then increment stats. I believe !folio_test_set_partially_mapped would be best. Hopefully below diff over v3 should cover all the fixes that have come up until now.

Independent of this series, I also think its a good idea to add a selftest for this deferred_split counter. I will send a separate patch for it that just maps a THP, unmaps a small part from it and checks the counter. I think split_huge_page_test.c is probably the right place for it.

If everyone is happy with it, Andrew could replace the original fix patch in [1] with below.

[1] https://lore.kernel.org/all/20240814200220.F1964C116B1@smtp.kernel.org/

commit c627655548fa09b59849e942da4decc84fa0b0f2
Author: Usama Arif <usamaarif642@gmail.com>
Date:   Thu Aug 15 16:07:20 2024 +0100

    mm: Introduce a pageflag for partially mapped folios fix
    
    Fixes the original commit by not clearing partially mapped bit
    in hugeTLB folios and fixing deferred split THP stats.
    
    Signed-off-by: Usama Arif <usamaarif642@gmail.com>

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index cecc1bad7910..7bee743ede40 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -863,6 +863,7 @@ static inline void ClearPageCompound(struct page *page)
 }
 FOLIO_FLAG(large_rmappable, FOLIO_SECOND_PAGE)
 FOLIO_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
+FOLIO_TEST_SET_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
 #else
 FOLIO_FLAG_FALSE(large_rmappable)
 FOLIO_FLAG_FALSE(partially_mapped)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c024ab0f745c..24371e4ef19b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3459,6 +3459,7 @@ void __folio_undo_large_rmappable(struct folio *folio)
        spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
 }
 
+/* partially_mapped=false won't clear PG_partially_mapped folio flag */
 void deferred_split_folio(struct folio *folio, bool partially_mapped)
 {
        struct deferred_split *ds_queue = get_deferred_split_queue(folio);
@@ -3488,16 +3489,17 @@ void deferred_split_folio(struct folio *folio, bool partially_mapped)
                return;
 
        spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
-       if (partially_mapped)
-               folio_set_partially_mapped(folio);
-       else
-               folio_clear_partially_mapped(folio);
-       if (list_empty(&folio->_deferred_list)) {
-               if (partially_mapped) {
+       if (partially_mapped) {
+               if (!folio_test_set_partially_mapped(folio)) {
                        if (folio_test_pmd_mappable(folio))
                                count_vm_event(THP_DEFERRED_SPLIT_PAGE);
                        count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
                }
+       } else {
+               /* partially mapped folios cannot become non-partially mapped */
+               VM_WARN_ON_FOLIO(folio_test_partially_mapped(folio), folio);
+       }
+       if (list_empty(&folio->_deferred_list)) {
                list_add_tail(&folio->_deferred_list, &ds_queue->split_queue);
                ds_queue->split_queue_len++;
 #ifdef CONFIG_MEMCG
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2ae2d9a18e40..1fdd9eab240c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1758,7 +1758,6 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
                free_gigantic_folio(folio, huge_page_order(h));
        } else {
                INIT_LIST_HEAD(&folio->_deferred_list);
-               folio_clear_partially_mapped(folio);
                folio_put(folio);
        }
 }
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





  

