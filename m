Return-Path: <linux-kernel+bounces-370865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0519A3309
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 04:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F634B22B19
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 02:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B673143888;
	Fri, 18 Oct 2024 02:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Y4+A8dUZ"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8430E126C07
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 02:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729220009; cv=none; b=DvCktvpLcWVsmB3TPosfVd6H7tbGWxBpcIJsStGe3u0aKhW+6uEOJh0jhuCbrFazQi8XBxvZEbuLXDc3GFZGMPl1+4QN57EtbjRuSrSST/R75RmxOTtrEp3r0ljredych8TUnfN747pTHKffG/z/dW+mTKrCeSSNd1GXPfbf7b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729220009; c=relaxed/simple;
	bh=+4ATixLOmvgqUwUSb7CggGJIrSorGouEz6OROsXfCF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IX1RhtwmbBoo3MuKSY6Ov40GHnb5AjTkVjucMhCBAeh74jXlfz9qYxOOSN8HYW/KN+JzGqDwHdvKKS+s/T0TuzE0AJ392ki/0HhzvanQXvwgNwQ2HfGx9n2jgl02dK9UnOeTT6CmNfxvyj4rTUG+KT/4PWOULlScB7Ku6IMqzQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Y4+A8dUZ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20cf3e36a76so17028675ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 19:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729220006; x=1729824806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YpF687qRXWCsJr2GZzgHn813zivwFLDmtROmzWQmTmc=;
        b=Y4+A8dUZUFQ/QXMx1iqO7LhskmfG3pfI8Npbe/BLXYt3JgKTIOgOrqut4gPy/2r/+e
         k5Qkxo/NkFNYrCbVhOqP5Q6tZcbl03cQ2SuU+HXunBZyVlFUO5IOBkaWw8Yo/LMfP+Aw
         GjkR9oY4b4lECSv5brloY9Ib3qujHsX0ZlyjZ3V/GmXMhjDBd9Vy4t4u7PhbvWkX97CJ
         O/Dz+cNc1gNUTHtcdb1djuqCXwv4wM3Sqvw1FmAKtLJ8DpRTqoiumzCzNNSb2i856S5X
         fUhbnaraEq85f4hV05q5LecVSOfgDPO6pfsCe/nGT7h3ziQNVyo+q5HbcO4U/qtcTS+7
         SGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729220006; x=1729824806;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YpF687qRXWCsJr2GZzgHn813zivwFLDmtROmzWQmTmc=;
        b=WHSlukLpPfkHjJEhkyHjnuUhcXqB8M+j1ZE395pSsPBAMkjMtr2kNOCekD29Etxn8i
         PyoC30WoOBMAoyxWfpix7lP+b3nXUCozNf7TIdbTgkPRZeBcT2AGurVekuLzbHpH2zAq
         Zkp5HlCXorAj6tRSkBo0x6593KTSSvZEzXKQTSmS9lYAcWaMF9rGkZLcSE/TQJeaFI6B
         LKvf4W0b92La967KicWOfZPN7uX1a8SqcbcBEqa8O7TvLdsdzGRAyZQPvZ/QmY8LF/sD
         2sse9GW4KGyp01fUmPEY42WnK0nesmEZUL9AHIfwshuuSGP5owSC6tZEO525/+w/eCfP
         LJnQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2TVsI19x2z2yNNAFndP7EhcpSz6bNPEtFuDkY4bI+hjDcpFnvS/cd96DPCU9aYANTQRuS5OlLzBCFNDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxppx4R3sfb+6QjQXgXoF/z6j9XoYqDvxlwKA19mcCxxIDy1qKQ
	iUjHSoFyDmovmrLY6V6pGJ48QD1YbOG9x2RWdom10alajTEgMPPu+Fe5JIObm8s=
X-Google-Smtp-Source: AGHT+IFEuiDe9oCOo97CfaiWNFnfs3j4SgghMoiXzyDB1AH6MvxxCvd0YLezzKBKzIvsN9JzlsAXqA==
X-Received: by 2002:a17:902:db12:b0:20c:5fd7:d71 with SMTP id d9443c01a7336-20e5a76da90mr14556145ad.22.1729220005556;
        Thu, 17 Oct 2024 19:53:25 -0700 (PDT)
Received: from [10.84.149.95] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a752468sm3294015ad.99.2024.10.17.19.53.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 19:53:25 -0700 (PDT)
Message-ID: <8068329c-c71c-469e-b2b7-5cb2e9d9671e@bytedance.com>
Date: Fri, 18 Oct 2024 10:53:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/7] mm: pgtable: try to reclaim empty PTE page in
 madvise(MADV_DONTNEED)
Content-Language: en-US
To: Jann Horn <jannh@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 david@redhat.com, hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org,
 zokeefe@google.com, rientjes@google.com, peterx@redhat.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org
References: <cover.1729157502.git.zhengqi.arch@bytedance.com>
 <6c7fe15b0434a08a287c400869f9ba434e1a8fa3.1729157502.git.zhengqi.arch@bytedance.com>
 <CAG48ez3MLMXZvkbPGZ4He2+tnOSHYxA68Sa1Hd_70-3a8K++=A@mail.gmail.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CAG48ez3MLMXZvkbPGZ4He2+tnOSHYxA68Sa1Hd_70-3a8K++=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/10/18 02:43, Jann Horn wrote:
> +arm64 maintainers in case they have opinions on the break-before-make aspects
> 
> On Thu, Oct 17, 2024 at 11:48 AM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>> Now in order to pursue high performance, applications mostly use some
>> high-performance user-mode memory allocators, such as jemalloc or
>> tcmalloc. These memory allocators use madvise(MADV_DONTNEED or MADV_FREE)
>> to release physical memory, but neither MADV_DONTNEED nor MADV_FREE will
>> release page table memory, which may cause huge page table memory usage.
>>
>> The following are a memory usage snapshot of one process which actually
>> happened on our server:
>>
>>          VIRT:  55t
>>          RES:   590g
>>          VmPTE: 110g
>>
>> In this case, most of the page table entries are empty. For such a PTE
>> page where all entries are empty, we can actually free it back to the
>> system for others to use.
>>
>> As a first step, this commit aims to synchronously free the empty PTE
>> pages in madvise(MADV_DONTNEED) case. We will detect and free empty PTE
>> pages in zap_pte_range(), and will add zap_details.reclaim_pt to exclude
>> cases other than madvise(MADV_DONTNEED).
>>
>> Once an empty PTE is detected, we first try to hold the pmd lock within
>> the pte lock. If successful, we clear the pmd entry directly (fast path).
>> Otherwise, we wait until the pte lock is released, then re-hold the pmd
>> and pte locks and loop PTRS_PER_PTE times to check pte_none() to re-detect
>> whether the PTE page is empty and free it (slow path).
>>
>> For other cases such as madvise(MADV_FREE), consider scanning and freeing
>> empty PTE pages asynchronously in the future.
> 
> One thing I find somewhat scary about this is that it makes it
> possible to free page tables in anonymous mappings, and to free page
> tables of VMAs with an ->anon_vma, which was not possible before. Have
> you checked all the current users of pte_offset_map_ro_nolock(),
> pte_offset_map_rw_nolock(), and pte_offset_map() to make sure none of
> them assume that this can't happen?

For the users of pte_offset_map_ro_nolock() and pte_offset_map(), they
will only perform read-only operations on the PTE page, and the
rcu_read_lock() in pte_offset_map_ro_nolock() and pte_offset_map() will
ensure that the PTE page is valid, so this is safe.

For the users of pte_offset_map_rw_nolock() + pmd_same()/pte_same()
check, they behave similarly to pte_offset_map_lock(), so this is
safe.

For the users who have used pte_offset_map_rw_nolock() but have not
performed a pmd_same()/pte_same() check, that is, the following:

1. copy_pte_range()
2. move_ptes()

They all hold the exclusive mmap_lock, and we will hold the read
lock of mmap_lock to free page tables in anonymous mappings, so
it is also safe.

> 
> For example, pte_offset_map_rw_nolock() is called from move_ptes(),
> with a comment basically talking about how this is safe *because only
> khugepaged can remove page tables*.

As mentioned above, it is also safe here.

> 
>> diff --git a/mm/memory.c b/mm/memory.c
>> index cc89ede8ce2ab..77774b34f2cde 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -1437,7 +1437,7 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
>>   static inline bool should_zap_cows(struct zap_details *details)
>>   {
>>          /* By default, zap all pages */
>> -       if (!details)
>> +       if (!details || details->reclaim_pt)
>>                  return true;
>>
>>          /* Or, we zap COWed pages only if the caller wants to */
>> @@ -1611,8 +1611,18 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>>          pte_t *start_pte;
>>          pte_t *pte;
>>          swp_entry_t entry;
>> +       pmd_t pmdval;
>> +       bool can_reclaim_pt = false;
>> +       bool direct_reclaim;
>> +       unsigned long start = addr;
>>          int nr;
>>
>> +       if (details && details->reclaim_pt)
>> +               can_reclaim_pt = true;
>> +
>> +       if ((ALIGN_DOWN(end, PMD_SIZE)) - (ALIGN(start, PMD_SIZE)) < PMD_SIZE)
>> +               can_reclaim_pt = false;
> 
> Does this check actually work? Assuming we're on x86, if you pass in
> start=0x1000 and end=0x2000, if I understand correctly,
> ALIGN_DOWN(end, PMD_SIZE) will be 0, while ALIGN(start, PMD_SIZE) will
> be 0x200000, and so we will check:
> 
> if (0 - 0x200000 < PMD_SIZE)
> 
> which is
> 
> if (0xffffffffffe00000 < 0x200000)
> 
> which is false?

Oh, I missed this, it seems that we can just do:

if (end - start < PMD_SIZE)
	can_reclaim_pt = false;

> 
>>   retry:
>>          tlb_change_page_size(tlb, PAGE_SIZE);
>>          init_rss_vec(rss);
>> @@ -1641,6 +1651,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>>                          nr = zap_present_ptes(tlb, vma, pte, ptent, max_nr,
>>                                                addr, details, rss, &force_flush,
>>                                                &force_break, &is_pt_unreclaimable);
>> +                       if (is_pt_unreclaimable)
>> +                               set_pt_unreclaimable(&can_reclaim_pt);
>>                          if (unlikely(force_break)) {
>>                                  addr += nr * PAGE_SIZE;
>>                                  break;
>> @@ -1653,8 +1665,10 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>>                      is_device_exclusive_entry(entry)) {
>>                          page = pfn_swap_entry_to_page(entry);
>>                          folio = page_folio(page);
>> -                       if (unlikely(!should_zap_folio(details, folio)))
>> +                       if (unlikely(!should_zap_folio(details, folio))) {
>> +                               set_pt_unreclaimable(&can_reclaim_pt);
>>                                  continue;
>> +                       }
>>                          /*
>>                           * Both device private/exclusive mappings should only
>>                           * work with anonymous page so far, so we don't need to
>> @@ -1670,14 +1684,18 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>>                          max_nr = (end - addr) / PAGE_SIZE;
>>                          nr = swap_pte_batch(pte, max_nr, ptent);
>>                          /* Genuine swap entries, hence a private anon pages */
>> -                       if (!should_zap_cows(details))
>> +                       if (!should_zap_cows(details)) {
>> +                               set_pt_unreclaimable(&can_reclaim_pt);
>>                                  continue;
>> +                       }
>>                          rss[MM_SWAPENTS] -= nr;
>>                          free_swap_and_cache_nr(entry, nr);
>>                  } else if (is_migration_entry(entry)) {
>>                          folio = pfn_swap_entry_folio(entry);
>> -                       if (!should_zap_folio(details, folio))
>> +                       if (!should_zap_folio(details, folio)) {
>> +                               set_pt_unreclaimable(&can_reclaim_pt);
>>                                  continue;
>> +                       }
>>                          rss[mm_counter(folio)]--;
>>                  } else if (pte_marker_entry_uffd_wp(entry)) {
>>                          /*
>> @@ -1685,21 +1703,29 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>>                           * drop the marker if explicitly requested.
>>                           */
>>                          if (!vma_is_anonymous(vma) &&
>> -                           !zap_drop_file_uffd_wp(details))
>> +                           !zap_drop_file_uffd_wp(details)) {
>> +                               set_pt_unreclaimable(&can_reclaim_pt);
>>                                  continue;
>> +                       }
>>                  } else if (is_hwpoison_entry(entry) ||
>>                             is_poisoned_swp_entry(entry)) {
>> -                       if (!should_zap_cows(details))
>> +                       if (!should_zap_cows(details)) {
>> +                               set_pt_unreclaimable(&can_reclaim_pt);
>>                                  continue;
>> +                       }
>>                  } else {
>>                          /* We should have covered all the swap entry types */
>>                          pr_alert("unrecognized swap entry 0x%lx\n", entry.val);
>>                          WARN_ON_ONCE(1);
>>                  }
>>                  clear_not_present_full_ptes(mm, addr, pte, nr, tlb->fullmm);
>> -               zap_install_uffd_wp_if_needed(vma, addr, pte, nr, details, ptent);
>> +               if (zap_install_uffd_wp_if_needed(vma, addr, pte, nr, details, ptent))
>> +                       set_pt_unreclaimable(&can_reclaim_pt);
>>          } while (pte += nr, addr += PAGE_SIZE * nr, addr != end);
>>
>> +       if (addr == end && can_reclaim_pt)
>> +               direct_reclaim = try_get_and_clear_pmd(mm, pmd, &pmdval);
>> +
>>          add_mm_rss_vec(mm, rss);
>>          arch_leave_lazy_mmu_mode();
>>
>> @@ -1724,6 +1750,13 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>>                  goto retry;
>>          }
>>
>> +       if (can_reclaim_pt) {
>> +               if (direct_reclaim)
>> +                       free_pte(mm, start, tlb, pmdval);
>> +               else
>> +                       try_to_free_pte(mm, pmd, start, tlb);
>> +       }
>> +
>>          return addr;
>>   }
>>
>> diff --git a/mm/pt_reclaim.c b/mm/pt_reclaim.c
>> new file mode 100644
>> index 0000000000000..fc055da40b615
>> --- /dev/null
>> +++ b/mm/pt_reclaim.c
>> @@ -0,0 +1,68 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <linux/hugetlb.h>
>> +#include <asm-generic/tlb.h>
>> +#include <asm/pgalloc.h>
>> +
>> +#include "internal.h"
>> +
>> +bool try_get_and_clear_pmd(struct mm_struct *mm, pmd_t *pmd, pmd_t *pmdval)
>> +{
>> +       spinlock_t *pml = pmd_lockptr(mm, pmd);
>> +
>> +       if (!spin_trylock(pml))
>> +               return false;
>> +
>> +       *pmdval = pmdp_get_lockless(pmd);
>> +       pmd_clear(pmd);
>> +       spin_unlock(pml);
>> +
>> +       return true;
>> +}
>> +
>> +void free_pte(struct mm_struct *mm, unsigned long addr, struct mmu_gather *tlb,
>> +             pmd_t pmdval)
>> +{
>> +       pte_free_tlb(tlb, pmd_pgtable(pmdval), addr);
>> +       mm_dec_nr_ptes(mm);
>> +}
>> +
>> +void try_to_free_pte(struct mm_struct *mm, pmd_t *pmd, unsigned long addr,
>> +                    struct mmu_gather *tlb)
>> +{
>> +       pmd_t pmdval;
>> +       spinlock_t *pml, *ptl;
>> +       pte_t *start_pte, *pte;
>> +       int i;
>> +
>> +       start_pte = pte_offset_map_rw_nolock(mm, pmd, addr, &pmdval, &ptl);
>> +       if (!start_pte)
>> +               return;
>> +
>> +       pml = pmd_lock(mm, pmd);
>> +       if (ptl != pml)
>> +               spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
>> +
>> +       if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(pmd))))
>> +               goto out_ptl;
>> +
>> +       /* Check if it is empty PTE page */
>> +       for (i = 0, pte = start_pte; i < PTRS_PER_PTE; i++, pte++) {
>> +               if (!pte_none(ptep_get(pte)))
>> +                       goto out_ptl;
>> +       }
>> +       pte_unmap(start_pte);
>> +
>> +       pmd_clear(pmd);
>> +
>> +       if (ptl != pml)
>> +               spin_unlock(ptl);
>> +       spin_unlock(pml);
> 
> At this point, you have cleared the PMD and dropped the locks
> protecting against concurrency, but have not yet done a TLB flush. If
> another thread concurrently repopulates the PMD at this point, can we
> get incoherent TLB state in a way that violates the arm64
> break-before-make rule?
> 
> Though I guess we can probably already violate break-before-make if
> MADV_DONTNEED races with a pagefault, since zap_present_folio_ptes()
> does not seem to set "force_flush" when zapping anon PTEs...

Thanks for pointing this out! That's why I sent a separate patch
discussing this a while ago, but unfortunately haven't gotten any
feedback yet, please take a look:

https://lore.kernel.org/lkml/20240815120715.14516-1-zhengqi.arch@bytedance.com/

Thanks!

> 
> (I realize you're only enabling this for x86 for now, but we should
> probably make sure the code is not arch-dependent in subtle
> undocumented ways...)
> 
>> +       free_pte(mm, addr, tlb, pmdval);
>> +
>> +       return;
>> +out_ptl:
>> +       pte_unmap_unlock(start_pte, ptl);
>> +       if (pml != ptl)
>> +               spin_unlock(pml);
>> +}
>> --
>> 2.20.1
>>

