Return-Path: <linux-kernel+bounces-375156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E209D9A91AC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 22:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 646E41F233F0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 20:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59E41FE11D;
	Mon, 21 Oct 2024 20:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDZA5fIr"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49D31FBF62;
	Mon, 21 Oct 2024 20:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729544242; cv=none; b=ZpZ6Pje48haiR7GiKpB3avv/0p1UBeCQ+UbVt3loIOfjgubUcIxQVLw4v+qh0pGAl8fC3zafb9NdSOCI6cco5KZsp4Gmvj7pPFW/+wF1HRYDS1rPOrsZ0FqGt64ZOTjh6oajXdx+gInOP4+zMqvAoQP1OXzgzztkNL0SqqLHz9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729544242; c=relaxed/simple;
	bh=1q9ujo3uwTsiOkoA5kDMWfWYiVj7seE/iHFfDPK+a9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NQMYkPdv8RUsDNQsOQTXY4hoX/C+sdR19nZtusJb2kAzl2nh9A4xW7FPrFAfUL0qYZJk6wAKxhTuQ1EsWM2s9BpNRksdgAD/0Psem2uNL01nC9wNUiuel8kZ1gGGV+YvG4+4GVffSyx/arD2B3MMs9+4XjGbf6hmPQil71N8fxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDZA5fIr; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d4fd00574so3408489f8f.0;
        Mon, 21 Oct 2024 13:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729544239; x=1730149039; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZlBZbYokjq2qUrngMt0qlyu5ykDp9WbiLWWOTLFp1l8=;
        b=jDZA5fIr0bMH/m9ZYkn0v+rDvd9f9wUw6dDeSdPdqywVHBhPsgDs47d32Uehmix9aB
         Yq3PkLKf5vQJU10UAm9/Scw9BoHqaag3KNSVWdx8iqi7wuepVIFwvqC/RklHUtOBu4D7
         jJRqG7NCzd/cmpA0h+DN5pJRAF5QBGr2IUPz/9puoDLUWpk7yI1BJn6DMs9P5zJQpmSX
         KK3+/rR5oxS56GHsz6X/2vEk6hQQhkCVTvj/1m3JbR2WV5GGT68gqo8EVnccIZiZ0KwQ
         8pyrRSqsUuaHfs+DUQlceMMshDFBV9SRtulvDZGC8kLdAJRlbx3KtdAmK4ue3Q1I4Y7s
         EiIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729544239; x=1730149039;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlBZbYokjq2qUrngMt0qlyu5ykDp9WbiLWWOTLFp1l8=;
        b=AW5PaKR5LtZhGshODUHWVDQbmJ2fCRCwbFCnatNGQ/wUvuS/tdBiA7S/UghCpqtk06
         NrW2jGgQUS+bAPK3AtL/6r/dc6HevbJ6gogWhUmhKpuAI8g+NS2en9Fc62NX5pLUUG7B
         ALdzRRXLfQ83nz00Yk25EDsf1NnGgydWKBvAYsbHSIbg8r3rMSgEq4xrKNkoTjzcgpJv
         znhvnnAeJJKWdAcuOcigM8qIZmdl/EkRYmOYm63qGgWQB5aw/4WbtUNG4P1jPx1uzU+H
         XenT1fzxXZGHazG7+GB+Xl6H53BWP3H+gJPLOoLaht/3CfsLo+HoiCODC+b9mhA0Yc0y
         QgUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCf+mFFRaFCJkUWfEKKe7ore46SW9RbZ9Le9jm0eGeeP37ueM2DCgDYGfHI+AA7x9YLKLyynGPHQi771b/@vger.kernel.org, AJvYcCWbM/L+wOY4WsW/z1QaVn0LZWuLhPMLoN3pty2r9mgBsDglcBSYB0JvFg9MNWToEwzi8DgzjkdFnWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPmvZcpoWE8K8ZPY3USXITrrITj3Qn4UWj9fcWh2/ndvrw8lIj
	n9QKhsUKpMcqJHUqgiv6xcu+YNg6COo9FYl7JTdiprMu+Uo4B4NG
X-Google-Smtp-Source: AGHT+IEK0KG8kGy8QqRtOmDwNHXwXz694CT1ipdEb6PtjYzYCrwAQR53iHDe8ULkVD5U57DarokSVw==
X-Received: by 2002:a05:6000:c44:b0:374:adf1:9232 with SMTP id ffacd0b85a97d-37ef12b1be8mr552584f8f.19.1729544238817;
        Mon, 21 Oct 2024 13:57:18 -0700 (PDT)
Received: from ?IPV6:2a02:6b67:d751:7400:c2b:f323:d172:e42a? ([2a02:6b67:d751:7400:c2b:f323:d172:e42a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0ba7dffsm5103823f8f.116.2024.10.21.13.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 13:57:18 -0700 (PDT)
Message-ID: <6d036c4d-ec2e-4562-98a1-6668948086b5@gmail.com>
Date: Mon, 21 Oct 2024 21:57:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/4] mm/zswap: add support for large folio zswapin
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org,
 david@redhat.com, willy@infradead.org, kanchana.p.sridhar@intel.com,
 yosryahmed@google.com, nphamcs@gmail.com, chengming.zhou@linux.dev,
 ryan.roberts@arm.com, ying.huang@intel.com, riel@surriel.com,
 shakeel.butt@linux.dev, kernel-team@meta.com, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20241018105026.2521366-1-usamaarif642@gmail.com>
 <20241018105026.2521366-4-usamaarif642@gmail.com>
 <CAGsJ_4xyDMUDxVhi0bzZJ4jAd_Hw8Hn25+4epO9u9=iu0QMdoA@mail.gmail.com>
 <ca158172-a100-4af6-98de-083d77cd9ed8@gmail.com>
 <CAGsJ_4x9YKi9BKmzOuOfaLrjr=kpQsiog=rAP3jJY=YQJ3Fupg@mail.gmail.com>
 <ac2d47fc-9bdc-441f-8b96-fb47862cd2c6@gmail.com>
 <CAGsJ_4xbciws3AnRFk0U8YeS5MPD=deXw6PCB6i71vgrLir8ew@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAGsJ_4xbciws3AnRFk0U8YeS5MPD=deXw6PCB6i71vgrLir8ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 21/10/2024 21:28, Barry Song wrote:
> On Tue, Oct 22, 2024 at 1:21 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>
>>
>>
>> On 21/10/2024 11:55, Barry Song wrote:
>>> On Mon, Oct 21, 2024 at 11:44 PM Usama Arif <usamaarif642@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>> On 21/10/2024 06:49, Barry Song wrote:
>>>>> On Fri, Oct 18, 2024 at 11:50 PM Usama Arif <usamaarif642@gmail.com> wrote:
>>>>>>
>>>>>> At time of folio allocation, alloc_swap_folio checks if the entire
>>>>>> folio is in zswap to determine folio order.
>>>>>> During swap_read_folio, zswap_load will check if the entire folio
>>>>>> is in zswap, and if it is, it will iterate through the pages in
>>>>>> folio and decompress them.
>>>>>> This will mean the benefits of large folios (fewer page faults, batched
>>>>>> PTE and rmap manipulation, reduced lru list, TLB coalescing (for arm64
>>>>>> and amd) are not lost at swap out when using zswap.
>>>>>> This patch does not add support for hybrid backends (i.e. folios
>>>>>> partly present swap and zswap).
>>>>>>
>>>>>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>>>>>> ---
>>>>>>  mm/memory.c | 13 +++-------
>>>>>>  mm/zswap.c  | 68 ++++++++++++++++++++++++-----------------------------
>>>>>>  2 files changed, 34 insertions(+), 47 deletions(-)
>>>>>>
>>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>>> index 49d243131169..75f7b9f5fb32 100644
>>>>>> --- a/mm/memory.c
>>>>>> +++ b/mm/memory.c
>>>>>> @@ -4077,13 +4077,14 @@ static bool can_swapin_thp(struct vm_fault *vmf, pte_t *ptep, int nr_pages)
>>>>>>
>>>>>>         /*
>>>>>>          * swap_read_folio() can't handle the case a large folio is hybridly
>>>>>> -        * from different backends. And they are likely corner cases. Similar
>>>>>> -        * things might be added once zswap support large folios.
>>>>>> +        * from different backends. And they are likely corner cases.
>>>>>>          */
>>>>>>         if (unlikely(swap_zeromap_batch(entry, nr_pages, NULL) != nr_pages))
>>>>>>                 return false;
>>>>>>         if (unlikely(non_swapcache_batch(entry, nr_pages) != nr_pages))
>>>>>>                 return false;
>>>>>> +       if (unlikely(!zswap_present_test(entry, nr_pages)))
>>>>>> +               return false;
>>>>>>
>>>>>>         return true;
>>>>>>  }
>>>>>> @@ -4130,14 +4131,6 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
>>>>>>         if (unlikely(userfaultfd_armed(vma)))
>>>>>>                 goto fallback;
>>>>>>
>>>>>> -       /*
>>>>>> -        * A large swapped out folio could be partially or fully in zswap. We
>>>>>> -        * lack handling for such cases, so fallback to swapping in order-0
>>>>>> -        * folio.
>>>>>> -        */
>>>>>> -       if (!zswap_never_enabled())
>>>>>> -               goto fallback;
>>>>>> -
>>>>>>         entry = pte_to_swp_entry(vmf->orig_pte);
>>>>>>         /*
>>>>>>          * Get a list of all the (large) orders below PMD_ORDER that are enabled
>>>>>> diff --git a/mm/zswap.c b/mm/zswap.c
>>>>>> index 9cc91ae31116..a5aa86c24060 100644
>>>>>> --- a/mm/zswap.c
>>>>>> +++ b/mm/zswap.c
>>>>>> @@ -1624,59 +1624,53 @@ bool zswap_present_test(swp_entry_t swp, int nr_pages)
>>>>>>
>>>>>>  bool zswap_load(struct folio *folio)
>>>>>>  {
>>>>>> +       int nr_pages = folio_nr_pages(folio);
>>>>>>         swp_entry_t swp = folio->swap;
>>>>>> +       unsigned int type = swp_type(swp);
>>>>>>         pgoff_t offset = swp_offset(swp);
>>>>>>         bool swapcache = folio_test_swapcache(folio);
>>>>>> -       struct xarray *tree = swap_zswap_tree(swp);
>>>>>> +       struct xarray *tree;
>>>>>>         struct zswap_entry *entry;
>>>>>> +       int i;
>>>>>>
>>>>>>         VM_WARN_ON_ONCE(!folio_test_locked(folio));
>>>>>>
>>>>>>         if (zswap_never_enabled())
>>>>>>                 return false;
>>>>>>
>>>>>> -       /*
>>>>>> -        * Large folios should not be swapped in while zswap is being used, as
>>>>>> -        * they are not properly handled. Zswap does not properly load large
>>>>>> -        * folios, and a large folio may only be partially in zswap.
>>>>>> -        *
>>>>>> -        * Return true without marking the folio uptodate so that an IO error is
>>>>>> -        * emitted (e.g. do_swap_page() will sigbus).
>>>>>> -        */
>>>>>> -       if (WARN_ON_ONCE(folio_test_large(folio)))
>>>>>> -               return true;
>>>>>> -
>>>>>> -       /*
>>>>>> -        * When reading into the swapcache, invalidate our entry. The
>>>>>> -        * swapcache can be the authoritative owner of the page and
>>>>>> -        * its mappings, and the pressure that results from having two
>>>>>> -        * in-memory copies outweighs any benefits of caching the
>>>>>> -        * compression work.
>>>>>> -        *
>>>>>> -        * (Most swapins go through the swapcache. The notable
>>>>>> -        * exception is the singleton fault on SWP_SYNCHRONOUS_IO
>>>>>> -        * files, which reads into a private page and may free it if
>>>>>> -        * the fault fails. We remain the primary owner of the entry.)
>>>>>> -        */
>>>>>> -       if (swapcache)
>>>>>> -               entry = xa_erase(tree, offset);
>>>>>> -       else
>>>>>> -               entry = xa_load(tree, offset);
>>>>>> -
>>>>>> -       if (!entry)
>>>>>> +       if (!zswap_present_test(folio->swap, nr_pages))
>>>>>>                 return false;
>>>>>
>>>>> Hi Usama,
>>>>>
>>>>> Is there any chance that zswap_present_test() returns true
>>>>> in do_swap_page() but false in zswap_load()? If that’s
>>>>> possible, could we be missing something? For example,
>>>>> could it be that zswap has been partially released (with
>>>>> part of it still present) during an mTHP swap-in?
>>>>>
>>>>> If this happens with an mTHP, my understanding is that
>>>>> we shouldn't proceed with reading corrupted data from the
>>>>> disk backend.
>>>>>
>>>>
>>>> If its not swapcache, the zswap entry is not deleted so I think
>>>> it should be ok?
>>>>
>>>> We can check over here if the entire folio is in zswap,
>>>> and if not, return true without marking the folio uptodate
>>>> to give an error.
>>>
>>> We have swapcache_prepare() called in do_swap_page(), which should
>>> have protected these entries from being partially freed by other processes
>>> (for example, if someone falls back to small folios for the same address).
>>> Therefore, I believe that zswap_present_test() cannot be false for mTHP in
>>> the current case where only synchronous I/O is supported.
>>>
>>> the below might help detect the bug?
>>>
>>> if (!zswap_present_test(folio->swap, nr_pages)) {
>>>      if (WARN_ON_ONCE(nr_pages > 1))
>>>                 return true;
>>>      return false;
>>> }
>>>
>>
>> I think this isn't correct. If nr_pages > 1 and the entire folio is not in zswap,
>> it should still return false. So would need to check the whole folio if we want to
>> warn. But I think if we are sure the code is ok, it is an unnecessary check.
> 
> my point is that zswap_present_test() can't differentiate
> 1. the *whole* folio is not in zswap
> 2. the folio is *partially* not in zswap
> 
> in case 2, returning false is wrong.
> 

Agreed!

> And when nr_pages > 1, we have already confirmed earlier in
> do_swap_page() that zswap_present_test() is true. At this point,
> it must always be true; if it's false, it indicates a bug.
> 

Yes agreed! I was thinking from just zswap_load perspective irrespective
of who calls it.
If someone adds large folio support to swapin_readahead, then I think the
above warn might be an issue.

But just with this patch series, doing what you suggested is correct. I
will add it in next revision. We can deal with it once swap count > 1,
starts supporting large folios.

>>
>>> the code seems quite ugly :-) do we have some way to unify the code
>>> for large and small folios?
>>>
>>> not quite sure about shmem though....
>>>
>>
>> If its shmem, and the swap_count goes to 1, I think its still ok? because
>> then the folio will be gotten from swap_cache_get_folio if it has already
>> been in swapcache.
>>
>>>>
>>>>
>>>>>>
>>>>>> -       zswap_decompress(entry, &folio->page);
>>>>>> +       for (i = 0; i < nr_pages; ++i) {
>>>>>> +               tree = swap_zswap_tree(swp_entry(type, offset + i));
>>>>>> +               /*
>>>>>> +                * When reading into the swapcache, invalidate our entry. The
>>>>>> +                * swapcache can be the authoritative owner of the page and
>>>>>> +                * its mappings, and the pressure that results from having two
>>>>>> +                * in-memory copies outweighs any benefits of caching the
>>>>>> +                * compression work.
>>>>>> +                *
>>>>>> +                * (Swapins with swap count > 1 go through the swapcache.
>>>>>> +                * For swap count == 1, the swapcache is skipped and we
>>>>>> +                * remain the primary owner of the entry.)
>>>>>> +                */
>>>>>> +               if (swapcache)
>>>>>> +                       entry = xa_erase(tree, offset + i);
>>>>>> +               else
>>>>>> +                       entry = xa_load(tree, offset + i);
>>>>>>
>>>>>> -       count_vm_event(ZSWPIN);
>>>>>> -       if (entry->objcg)
>>>>>> -               count_objcg_events(entry->objcg, ZSWPIN, 1);
>>>>>> +               zswap_decompress(entry, folio_page(folio, i));
>>>>>>
>>>>>> -       if (swapcache) {
>>>>>> -               zswap_entry_free(entry);
>>>>>> -               folio_mark_dirty(folio);
>>>>>> +               if (entry->objcg)
>>>>>> +                       count_objcg_events(entry->objcg, ZSWPIN, 1);
>>>>>> +               if (swapcache)
>>>>>> +                       zswap_entry_free(entry);
>>>>>>         }
>>>>>>
>>>>>> +       count_vm_events(ZSWPIN, nr_pages);
>>>>>> +       if (swapcache)
>>>>>> +               folio_mark_dirty(folio);
>>>>>> +
>>>>>>         folio_mark_uptodate(folio);
>>>>>>         return true;
>>>>>>  }
>>>>>> --
>>>>>> 2.43.5
>>>>>>
>>>>>
>>>
>>> Thanks
>>> barry
>>


