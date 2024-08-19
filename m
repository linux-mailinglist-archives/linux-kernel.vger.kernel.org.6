Return-Path: <linux-kernel+bounces-292871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0CE957581
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 22:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83316B22659
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 20:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D61415A84E;
	Mon, 19 Aug 2024 20:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXBiyMye"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A463158DCD;
	Mon, 19 Aug 2024 20:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724098572; cv=none; b=ADyRXNqL36gXg3UPwvYuPuQ5jEbjrN3Sc3Vfx9eymP2/9vGbHAEPMRQ0miD9XXMC8o0ajbyUFJz3Bcj1K0JlheGGe5wK7oP6sHxCrhVA3UOIv6MBCYk80VTQ8LORuq5EwoflQgpbJ/qdi4/6LY9nEmZxfoF/t/shmpNlmmoop3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724098572; c=relaxed/simple;
	bh=SWVRgeZ7CTQQ7yYl/MchnPLiTqf6i43UKxuy79sGAz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JQ/IEHSMh2LzP0YnzGcNmOxW6L4v4BGtAtyFtRuWD9LouLtmJBDsuqrVtmMdHXcwsNHZjg8q9ki0uKSGrFuECQ4BqZ8rz8mltYuVT2w6TF6DxgpQ3MkwLvHduY+OFPgffbcMSa6tMAz7Pf6THft3DRc485Mk2WvZsB6TRAcZbco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXBiyMye; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6bf89e59ff8so14132896d6.0;
        Mon, 19 Aug 2024 13:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724098569; x=1724703369; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2bDcAPyWn/B3dB8WEY9pSZO0HQv1mT5yruHlrosIXss=;
        b=YXBiyMye/F2ViPy1tzw8jZZfPzT6fet1wxRkZLA39+9c/ynQOEBTz8gslXybjNZCZV
         0cK//7e7iI8cX4e0dHZygeqkVW0uXApYtPAfaZNOulZ4gf3nwnEti02j+z4l+HXRBEz+
         n7ZxpIGVVOp5d5aa/gC2W73Ii7c3xQbCxzHuIg1R0cnynSkXHTP054feCNZqkdKer00w
         tOipEyonW9QIlUsMctczITiTYyvBnmAZUh5vinMtTSeBWo66dRghiyg9aTPUhvFtItCi
         BOZh41gXJ469aRRmIKt9LOGQIAsfk3V7mevjbHN2dJqbtwfVR9oWBDWIbScoiVNGZnMg
         Ad+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724098569; x=1724703369;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2bDcAPyWn/B3dB8WEY9pSZO0HQv1mT5yruHlrosIXss=;
        b=v/lf9ihQK9xqhmrFPzFwnoSmChnruZJta8BxVDqAwuxSabrSLhYdPOQg1xf9PoFXf5
         sqrsA7gSBDrijaAunH4qrdt7AW6mA3zFkII5PqYIZ8t5CE5ddap2hqvL/uWFiEsM4Wof
         it/Glq6LdjSllVeOPXO9KnlmfA9t/ICh1eERkGQnpczSj4vGdzreoLp5XVctjUU4Y80F
         QH7dhBkzS40TUFXfKlE2iSIMLkSgBr5Vq4FbGTUgQUZBELs4McVfW0qXkgMEoQELUNzF
         s0VsWj/C4HYv+1uQCcjUjZkbbEHkaitx0GUORj2Wq8Cay2nY2JF3XTzj7rBRydpdBVLC
         vStA==
X-Forwarded-Encrypted: i=1; AJvYcCUF70MT8OYQNPzgf2XGLZen39DnMRy8mxrWECTYMxZxC0MqYU3ovKzajpeZ9flOPFgwsirmrusEI1YSkwjzEKtma+QZtm5GneIPdQ/iYqPjyH1mPAjD0NIHuCrUoj+X1Z7hytIqxgD3
X-Gm-Message-State: AOJu0YxIZG08gkNNr2ifE5lWn6I9hs1iccYVBmh/V2I9F4Ny7k4g/iam
	Q8CuQJHBk3lFbam0QCogIs7HKYKJMzFh2qyNV5tR4zMzn99Vv615
X-Google-Smtp-Source: AGHT+IH5rVdrhtASVA0IbpdMpTAjIzrHEi8lN53IGRcdkXNk+ka7mf3rD/j3HaEFfUtc07VqzgCwoA==
X-Received: by 2002:a05:6214:3204:b0:6bf:8ae8:fc0c with SMTP id 6a1803df08f44-6bf8ae92718mr130582366d6.35.1724098569193;
        Mon, 19 Aug 2024 13:16:09 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1145:4:1409:786c:cb1d:c3fb? ([2620:10d:c091:500::7:e1ca])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fec5e9csm45817476d6.80.2024.08.19.13.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 13:16:08 -0700 (PDT)
Message-ID: <9a58e794-2156-4a9f-a383-1cdfc07eee5e@gmail.com>
Date: Mon, 19 Aug 2024 16:16:07 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] mm: Introduce a pageflag for partially mapped
 folios
To: Barry Song <baohua@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org,
 riel@surriel.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev,
 yuzhao@google.com, david@redhat.com, ryan.roberts@arm.com, rppt@kernel.org,
 willy@infradead.org, cerasuolodomenico@gmail.com, ryncsn@gmail.com,
 corbet@lwn.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kernel-team@meta.com
References: <20240819023145.2415299-1-usamaarif642@gmail.com>
 <20240819023145.2415299-5-usamaarif642@gmail.com>
 <CAGsJ_4yKuvMSazWABXqaeRr84hLEubET0nCUhPFYHQnfR4Tm8w@mail.gmail.com>
 <a09b6af0-4fdb-4ac1-9cbe-9b422ebc3308@gmail.com>
 <CAGsJ_4xeWt9n3zX3-DknE=NftkWS0fe2vKTJT9tLuJPM4EaEwg@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAGsJ_4xeWt9n3zX3-DknE=NftkWS0fe2vKTJT9tLuJPM4EaEwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 19/08/2024 20:00, Barry Song wrote:
> On Tue, Aug 20, 2024 at 2:17 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>
>>
>>
>> On 19/08/2024 09:29, Barry Song wrote:
>>> Hi Usama,
>>>
>>> I feel it is much better now! thanks!
>>>
>>> On Mon, Aug 19, 2024 at 2:31 PM Usama Arif <usamaarif642@gmail.com> wrote:
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
>>>>  include/linux/page-flags.h | 11 +++++++++++
>>>>  mm/huge_memory.c           | 23 ++++++++++++++++-------
>>>>  mm/internal.h              |  4 +++-
>>>>  mm/memcontrol.c            |  3 ++-
>>>>  mm/migrate.c               |  3 ++-
>>>>  mm/page_alloc.c            |  5 +++--
>>>>  mm/rmap.c                  |  5 +++--
>>>>  mm/vmscan.c                |  3 ++-
>>>>  9 files changed, 44 insertions(+), 17 deletions(-)
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
>>>> index a0a29bd092f8..c3bb0e0da581 100644
>>>> --- a/include/linux/page-flags.h
>>>> +++ b/include/linux/page-flags.h
>>>> @@ -182,6 +182,7 @@ enum pageflags {
>>>>         /* At least one page in this folio has the hwpoison flag set */
>>>>         PG_has_hwpoisoned = PG_active,
>>>>         PG_large_rmappable = PG_workingset, /* anon or file-backed */
>>>> +       PG_partially_mapped = PG_reclaim, /* was identified to be partially mapped */
>>>>  };
>>>>
>>>>  #define PAGEFLAGS_MASK         ((1UL << NR_PAGEFLAGS) - 1)
>>>> @@ -861,8 +862,18 @@ static inline void ClearPageCompound(struct page *page)
>>>>         ClearPageHead(page);
>>>>  }
>>>>  FOLIO_FLAG(large_rmappable, FOLIO_SECOND_PAGE)
>>>> +FOLIO_TEST_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
>>>> +/*
>>>> + * PG_partially_mapped is protected by deferred_split split_queue_lock,
>>>> + * so its safe to use non-atomic set/clear.
>>>> + */
>>>> +__FOLIO_SET_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
>>>> +__FOLIO_CLEAR_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
>>>>  #else
>>>>  FOLIO_FLAG_FALSE(large_rmappable)
>>>> +FOLIO_TEST_FLAG_FALSE(partially_mapped)
>>>> +__FOLIO_SET_FLAG_NOOP(partially_mapped)
>>>> +__FOLIO_CLEAR_FLAG_NOOP(partially_mapped)
>>>>  #endif
>>>>
>>>>  #define PG_head_mask ((1UL << PG_head))
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index 2d77b5d2291e..70ee49dfeaad 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -3398,6 +3398,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>>>>                          * page_deferred_list.
>>>>                          */
>>>>                         list_del_init(&folio->_deferred_list);
>>>> +                       __folio_clear_partially_mapped(folio);
>>>>                 }
>>>>                 spin_unlock(&ds_queue->split_queue_lock);
>>>>                 if (mapping) {
>>>> @@ -3454,11 +3455,13 @@ void __folio_undo_large_rmappable(struct folio *folio)
>>>>         if (!list_empty(&folio->_deferred_list)) {
>>>>                 ds_queue->split_queue_len--;
>>>>                 list_del_init(&folio->_deferred_list);
>>>> +               __folio_clear_partially_mapped(folio);
>>>
>>> is it possible to make things clearer by
>>>
>>>  if (folio_clear_partially_mapped)
>>>     __folio_clear_partially_mapped(folio);
>>>
>>> While writing without conditions isn't necessarily wrong, adding a condition
>>> will improve the readability of the code and enhance the clarity of my mTHP
>>> counters series. also help decrease smp cache sync if we can avoid
>>> unnecessary writing?
>>>
>>
>> Do you mean if(folio_test_partially_mapped(folio))?
>>
>> I don't like this idea. I think it makes the readability worse? If I was looking at if (test) -> clear for the first time, I would become confused why its being tested if its going to be clear at the end anyways?
> 
> In the pmd-order case, the majority of folios are not partially mapped.
> Unconditional writes will trigger cache synchronization across all
> CPUs (related to the MESI protocol), making them more costly. By
> using conditional writes, such as "if(test) write," we can avoid
> most unnecessary writes, which is much more efficient. Additionally,
> we only need to manage nr_split_deferred when the condition
> is met. We are carefully evaluating all scenarios to determine
> if modifications to the partially_mapped flag are necessary.
> 


Hmm okay, as you said its needed for nr_split_deferred anyways. Something like below is ok to fold in?

commit 4ae9e2067346effd902b342296987b97dee29018 (HEAD)
Author: Usama Arif <usamaarif642@gmail.com>
Date:   Mon Aug 19 21:07:16 2024 +0100

    mm: Introduce a pageflag for partially mapped folios fix
    
    Test partially_mapped flag before clearing it. This should
    avoid unnecessary writes and will be needed in the nr_split_deferred
    series.
    
    Signed-off-by: Usama Arif <usamaarif642@gmail.com>

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5d67d3b3c1b2..ccde60aaaa0f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3479,7 +3479,8 @@ void __folio_undo_large_rmappable(struct folio *folio)
        if (!list_empty(&folio->_deferred_list)) {
                ds_queue->split_queue_len--;
                list_del_init(&folio->_deferred_list);
-               __folio_clear_partially_mapped(folio);
+               if (folio_test_partially_mapped(folio))
+                       __folio_clear_partially_mapped(folio);
        }
        spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
 }
@@ -3610,7 +3611,8 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
                } else {
                        /* We lost race with folio_put() */
                        list_del_init(&folio->_deferred_list);
-                       __folio_clear_partially_mapped(folio);
+                       if (folio_test_partially_mapped(folio))
+                               __folio_clear_partially_mapped(folio);
                        ds_queue->split_queue_len--;
                }
                if (!--sc->nr_to_scan)


