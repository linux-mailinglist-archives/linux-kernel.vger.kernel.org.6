Return-Path: <linux-kernel+bounces-374132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AF59A64BD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3442D1C22098
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16081EF08B;
	Mon, 21 Oct 2024 10:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYXAi/7+"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC841EE02C;
	Mon, 21 Oct 2024 10:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507471; cv=none; b=tM6IF2FroVGjA0Wd5Q5c+2+SPfWyz6ln1CDP+Habku9bTd+4BE7gq0JIQWD72mDda5ojaUKnFeX/ICYl7NLiquna1+nYKA6wYx78Ej6BWNKbEPL5n6M+RoBQf4GZss86PTjRpR0obpH1cLT2Y2rnLin3ZvZXJ4p8NmogdWZHeuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507471; c=relaxed/simple;
	bh=h9yByxAgFZegd+2L/+PzE+UZHLY9RpCHJvII6XKUzjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GnXfCJ1wlsdKU2MP+hsTG2wuCobGYrgcplU87NME8bb1nrTeJ+pZJVuGd3OHqfndySmJFRVZdJepp2TLHTaamMGy2YuN1+oudYRhUlrCDl+BhxTGh5LHAf11COlccnuf+oJdf5w8rTt+Z3aeStfeWpohejpkuLsQhrRP+KzP9DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYXAi/7+; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d4a5ecc44so3224911f8f.2;
        Mon, 21 Oct 2024 03:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729507467; x=1730112267; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2YjHc/MhGgRsnDDylmRAlAOK5o68LWuyNGszJ2NKgCU=;
        b=ZYXAi/7+By1vFq1NcYjXIJAhU0vH5vuDE4Bkm41BoNg6aJ8ayFSvRNzFhtD7O02cZs
         /OihmTajA/WSRNRCTfxMs9CdUyOnZu/ZW3UFGWrG47OOkS+b8U7MvW661hOPIsW8Fsrt
         8fimr19i034T438u4Rh2NQlPPIA9bMCs2LIWztgYOptPimuMFOfApZiJnRfUAL12iCH5
         wC5FEJuFjbqgKwiZd2LunZQZGciXCd45ALfKMqfUzvHJHRsIj3i+n/92qvBhWugNhFRw
         UtN41WbNzYTBRGNdiFyzIgpR2TdZ7koVdvfeJHs8wfxqeflobqaFZ8Zsx2Keidr/oyNr
         Sgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729507467; x=1730112267;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2YjHc/MhGgRsnDDylmRAlAOK5o68LWuyNGszJ2NKgCU=;
        b=PHX65Pc/50ZEYkt53Zx90gdDqZyatlBuU+/2sGh1X2LK17JET6nCjUwrbzOu6bh2ka
         g3bgjCbtBHxZk1mFu2mM6owKzkIE4UTVvWnhrLcyq7rk8wbMoWgoBV1igliy5dSJ/OOj
         LSNCvpR81XSrBb4dnxJAauuTn0X/kh61nxEropR5nr+OJxC5KbO4t9K/ce4Q3tJ5teMj
         DnBu7qnJLynIe51FEJFIR4AN50OiPRcFqzwGPBFWjnpUG0K+yUE0+PHPYTHECvq/UvOK
         275aJwCTW1WsQSfeGG74ABlzgfRHoBzzqsNmJsKQXXZ+0PQtawrSPmGOfl/jt9LIkHH8
         YhQw==
X-Forwarded-Encrypted: i=1; AJvYcCVny7c5WHVMy2FvGqVRV+7NXI+apnIPQr+fygSiHqz9AXHFN3h3zVI3LJZhPNStI8a7zVeq+WgxowY=@vger.kernel.org, AJvYcCXWpaiJKqwzCjVDdI1yAfx1yo8k+6dJ9QsfwbovBkMPq6SiX5TZC6Mw29byxsEZtqljRlIslNn9TawDXiz5@vger.kernel.org
X-Gm-Message-State: AOJu0YyciMfsZyxJWImMMf0qjDGCHE6Jcdxr8evr/90KgrcBCqqhZDjH
	SWJOvKvmONJIfDK7xxj+ojVbDASkPMC4p7nIudEUV423G2LNkKs9
X-Google-Smtp-Source: AGHT+IHPTofyAuIjaaxVNDH15uhPKU3Wv587rTdWyPLXQFd/z5ndZagFBChY25BrMPxCqVMt4KOugQ==
X-Received: by 2002:a05:6000:1544:b0:37d:5047:76d8 with SMTP id ffacd0b85a97d-37ebd3c36demr8342275f8f.59.1729507466803;
        Mon, 21 Oct 2024 03:44:26 -0700 (PDT)
Received: from ?IPV6:2a02:6b67:d751:7400:c2b:f323:d172:e42a? ([2a02:6b67:d751:7400:c2b:f323:d172:e42a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a64daasm4005514f8f.64.2024.10.21.03.44.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 03:44:26 -0700 (PDT)
Message-ID: <ca158172-a100-4af6-98de-083d77cd9ed8@gmail.com>
Date: Mon, 21 Oct 2024 11:44:26 +0100
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
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAGsJ_4xyDMUDxVhi0bzZJ4jAd_Hw8Hn25+4epO9u9=iu0QMdoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 21/10/2024 06:49, Barry Song wrote:
> On Fri, Oct 18, 2024 at 11:50 PM Usama Arif <usamaarif642@gmail.com> wrote:
>>
>> At time of folio allocation, alloc_swap_folio checks if the entire
>> folio is in zswap to determine folio order.
>> During swap_read_folio, zswap_load will check if the entire folio
>> is in zswap, and if it is, it will iterate through the pages in
>> folio and decompress them.
>> This will mean the benefits of large folios (fewer page faults, batched
>> PTE and rmap manipulation, reduced lru list, TLB coalescing (for arm64
>> and amd) are not lost at swap out when using zswap.
>> This patch does not add support for hybrid backends (i.e. folios
>> partly present swap and zswap).
>>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>> ---
>>  mm/memory.c | 13 +++-------
>>  mm/zswap.c  | 68 ++++++++++++++++++++++++-----------------------------
>>  2 files changed, 34 insertions(+), 47 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 49d243131169..75f7b9f5fb32 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -4077,13 +4077,14 @@ static bool can_swapin_thp(struct vm_fault *vmf, pte_t *ptep, int nr_pages)
>>
>>         /*
>>          * swap_read_folio() can't handle the case a large folio is hybridly
>> -        * from different backends. And they are likely corner cases. Similar
>> -        * things might be added once zswap support large folios.
>> +        * from different backends. And they are likely corner cases.
>>          */
>>         if (unlikely(swap_zeromap_batch(entry, nr_pages, NULL) != nr_pages))
>>                 return false;
>>         if (unlikely(non_swapcache_batch(entry, nr_pages) != nr_pages))
>>                 return false;
>> +       if (unlikely(!zswap_present_test(entry, nr_pages)))
>> +               return false;
>>
>>         return true;
>>  }
>> @@ -4130,14 +4131,6 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
>>         if (unlikely(userfaultfd_armed(vma)))
>>                 goto fallback;
>>
>> -       /*
>> -        * A large swapped out folio could be partially or fully in zswap. We
>> -        * lack handling for such cases, so fallback to swapping in order-0
>> -        * folio.
>> -        */
>> -       if (!zswap_never_enabled())
>> -               goto fallback;
>> -
>>         entry = pte_to_swp_entry(vmf->orig_pte);
>>         /*
>>          * Get a list of all the (large) orders below PMD_ORDER that are enabled
>> diff --git a/mm/zswap.c b/mm/zswap.c
>> index 9cc91ae31116..a5aa86c24060 100644
>> --- a/mm/zswap.c
>> +++ b/mm/zswap.c
>> @@ -1624,59 +1624,53 @@ bool zswap_present_test(swp_entry_t swp, int nr_pages)
>>
>>  bool zswap_load(struct folio *folio)
>>  {
>> +       int nr_pages = folio_nr_pages(folio);
>>         swp_entry_t swp = folio->swap;
>> +       unsigned int type = swp_type(swp);
>>         pgoff_t offset = swp_offset(swp);
>>         bool swapcache = folio_test_swapcache(folio);
>> -       struct xarray *tree = swap_zswap_tree(swp);
>> +       struct xarray *tree;
>>         struct zswap_entry *entry;
>> +       int i;
>>
>>         VM_WARN_ON_ONCE(!folio_test_locked(folio));
>>
>>         if (zswap_never_enabled())
>>                 return false;
>>
>> -       /*
>> -        * Large folios should not be swapped in while zswap is being used, as
>> -        * they are not properly handled. Zswap does not properly load large
>> -        * folios, and a large folio may only be partially in zswap.
>> -        *
>> -        * Return true without marking the folio uptodate so that an IO error is
>> -        * emitted (e.g. do_swap_page() will sigbus).
>> -        */
>> -       if (WARN_ON_ONCE(folio_test_large(folio)))
>> -               return true;
>> -
>> -       /*
>> -        * When reading into the swapcache, invalidate our entry. The
>> -        * swapcache can be the authoritative owner of the page and
>> -        * its mappings, and the pressure that results from having two
>> -        * in-memory copies outweighs any benefits of caching the
>> -        * compression work.
>> -        *
>> -        * (Most swapins go through the swapcache. The notable
>> -        * exception is the singleton fault on SWP_SYNCHRONOUS_IO
>> -        * files, which reads into a private page and may free it if
>> -        * the fault fails. We remain the primary owner of the entry.)
>> -        */
>> -       if (swapcache)
>> -               entry = xa_erase(tree, offset);
>> -       else
>> -               entry = xa_load(tree, offset);
>> -
>> -       if (!entry)
>> +       if (!zswap_present_test(folio->swap, nr_pages))
>>                 return false;
> 
> Hi Usama,
> 
> Is there any chance that zswap_present_test() returns true
> in do_swap_page() but false in zswap_load()? If that’s
> possible, could we be missing something? For example,
> could it be that zswap has been partially released (with
> part of it still present) during an mTHP swap-in?
> 
> If this happens with an mTHP, my understanding is that
> we shouldn't proceed with reading corrupted data from the
> disk backend.
> 

If its not swapcache, the zswap entry is not deleted so I think
it should be ok?

We can check over here if the entire folio is in zswap,
and if not, return true without marking the folio uptodate
to give an error.


>>
>> -       zswap_decompress(entry, &folio->page);
>> +       for (i = 0; i < nr_pages; ++i) {
>> +               tree = swap_zswap_tree(swp_entry(type, offset + i));
>> +               /*
>> +                * When reading into the swapcache, invalidate our entry. The
>> +                * swapcache can be the authoritative owner of the page and
>> +                * its mappings, and the pressure that results from having two
>> +                * in-memory copies outweighs any benefits of caching the
>> +                * compression work.
>> +                *
>> +                * (Swapins with swap count > 1 go through the swapcache.
>> +                * For swap count == 1, the swapcache is skipped and we
>> +                * remain the primary owner of the entry.)
>> +                */
>> +               if (swapcache)
>> +                       entry = xa_erase(tree, offset + i);
>> +               else
>> +                       entry = xa_load(tree, offset + i);
>>
>> -       count_vm_event(ZSWPIN);
>> -       if (entry->objcg)
>> -               count_objcg_events(entry->objcg, ZSWPIN, 1);
>> +               zswap_decompress(entry, folio_page(folio, i));
>>
>> -       if (swapcache) {
>> -               zswap_entry_free(entry);
>> -               folio_mark_dirty(folio);
>> +               if (entry->objcg)
>> +                       count_objcg_events(entry->objcg, ZSWPIN, 1);
>> +               if (swapcache)
>> +                       zswap_entry_free(entry);
>>         }
>>
>> +       count_vm_events(ZSWPIN, nr_pages);
>> +       if (swapcache)
>> +               folio_mark_dirty(folio);
>> +
>>         folio_mark_uptodate(folio);
>>         return true;
>>  }
>> --
>> 2.43.5
>>
> 
> Thanks
> barry


