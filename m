Return-Path: <linux-kernel+bounces-401177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CB89C16ED
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 805B0286CAF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 07:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CAE1D0E04;
	Fri,  8 Nov 2024 07:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="O5Nrju6H"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBABEDDA8
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 07:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731050010; cv=none; b=XCNNyowluzDNT6g9nMtQO1wL7ZHZrFlbxxJoO8WU6/abbPaqsq0VvmK0p8TIVkLtVzFqiW0qenbqjQH5xhqNbGFqbqZvk9ri3EHmGtDhlnZXkNaZ+0YWH5eATHShiCQL0AozAmWVqxWp3ldKIRnPJT6rAy+lS52qkhmr3niYo50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731050010; c=relaxed/simple;
	bh=Qsv7MANUA5aIwbB0S/MUFYDThKpfhWuJZspjL9QxsUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rUVT24BNYkqpSahQw/jQGiLSWGrtQObDsxxmRezE/3euDUxb9+TIdsnvOuCofxesVQqb2OBlUWSH1hiWBaASask0o7pi0lrSXolht7c8U0S1r/5ph+Sl+QundXKPG5ePaKsrYPGxGnUlPd/kgjXkb0tAilEHnlWPQbtq8yCg+8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=O5Nrju6H; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e3fce4a60so1436056b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 23:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1731050008; x=1731654808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bBEG9HZGs2iopYMSd9JlNjYiGLBvS6h7sIuOs83vCwg=;
        b=O5Nrju6HmuXrI8PpNkafwOysBwF8PAL/PQWeh0qAElJhlvYhKqEFDbBI8WCJqmQDub
         G/Gq2PXDSOLAezSlEwDazMbj8w0KThhtid9UxcJ9HmSHM+KWYNno7ELNmqAPj4Ip+caz
         SWSvalyCdAqbhjJSjNp5VvR8SwzmbvbEfe4qa6XCgXuRoXjfr2qF9OtcyP+qUYG5IlEi
         NIOHvivVvlASDPmJ/aMlzDooS43RFZZ05G5SXLgDCbH2K7/umXtME0YCURmb+W+2NLbH
         DCB4wJInzXFGlD1syLVrG6h+oDXMHClUbiwSVphEdpEkOzpd98g9de/XUG/JeoUkOng+
         yajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731050008; x=1731654808;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bBEG9HZGs2iopYMSd9JlNjYiGLBvS6h7sIuOs83vCwg=;
        b=G8CE+IhjV2ExEkDbvLdUmLe42DYcGLMOcMKvwOC0lTjAQU2Vd43MhMR1dIlRMSHp+X
         g/OeFNh1unQ7Z/1/GXmyG+qskJ9TQ8IUwCCyhrBxSlBkw5Pi2ft2WhBpidsx4epcjChD
         zR6HV2OiF6H37OgY12aBL1hSeeBtQVGYaCanOT2/P7XW5EYlCBm0N0DZN3+lzoH9PHwf
         tEUlwPSXhVOV8FvaCT2Dm3WrKIpqm8pZ+39niWLFELi+fFcx5MRdP6noLqV0Bm0pXcll
         NnfAV0uX8Oihx+6LlbOBVkTS3up0DZ8ro9QMmaoEnnlWJbrhuqqTV+AbIGOvvjojgv1C
         FCXg==
X-Forwarded-Encrypted: i=1; AJvYcCXhrzBd1yWsIwY49eVkoVNpiVFzUYKE/C8NPEunRAUtO0+61gykQX2/1rPh/z5V8j6E1O0tkbyhyMahqCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlQiAzeXfbZgtG06vmOWE6pI6jjcwVjxPkN2MIECP4mhzTApnP
	EGWSBgtwK9R1d9yk31gvocCP/WGc8EDdILZV+dbc8EFOr1E44vL5HhvfWZal980=
X-Google-Smtp-Source: AGHT+IEiWMjX9m7h/e6SEmO+ax7KBvWPkopXi+Sls8eu5PRlrxxTc3uss328GLsO+WL2fi1Q66z+UA==
X-Received: by 2002:a05:6a21:32a6:b0:1db:ed8a:a607 with SMTP id adf61e73a8af0-1dc22934658mr2471552637.11.1731050008009;
        Thu, 07 Nov 2024 23:13:28 -0800 (PST)
Received: from [10.84.149.95] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5f5e513sm2799412a91.12.2024.11.07.23.13.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 23:13:27 -0800 (PST)
Message-ID: <5d371247-853d-49ca-a28c-689a709905d4@bytedance.com>
Date: Fri, 8 Nov 2024 15:13:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] mm: pgtable: try to reclaim empty PTE page in
 madvise(MADV_DONTNEED)
Content-Language: en-US
To: Jann Horn <jannh@google.com>
Cc: david@redhat.com, hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org,
 zokeefe@google.com, rientjes@google.com, peterx@redhat.com,
 catalin.marinas@arm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 x86@kernel.org
References: <cover.1730360798.git.zhengqi.arch@bytedance.com>
 <c0199a7d7097521bbc183739b1fa6793081d726b.1730360798.git.zhengqi.arch@bytedance.com>
 <CAG48ez0bv_y1k3cqMCsj0sJGPR4iK9zmHTa6124+N6i+s4+bTA@mail.gmail.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CAG48ez0bv_y1k3cqMCsj0sJGPR4iK9zmHTa6124+N6i+s4+bTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jann,

On 2024/11/8 07:35, Jann Horn wrote:
> On Thu, Oct 31, 2024 at 9:14 AM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
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
> 
> How does this interact with move_pages_pte()? I am looking at your
> series applied on top of next-20241106, and it looks to me like
> move_pages_pte() uses pte_offset_map_rw_nolock() and assumes that the
> PMD entry can't change. You can clearly see this assumption at the
> WARN_ON_ONCE(pmd_none(*dst_pmd)). And if we race the wrong way, I

In move_pages_pte(), the following conditions may indeed be triggered:

	/* Sanity checks before the operation */
	if (WARN_ON_ONCE(pmd_none(*dst_pmd)) ||	WARN_ON_ONCE(pmd_none(*src_pmd)) ||
	    WARN_ON_ONCE(pmd_trans_huge(*dst_pmd)) || 
WARN_ON_ONCE(pmd_trans_huge(*src_pmd))) {
		err = -EINVAL;
		goto out;
	}

But maybe we can just remove the WARN_ON_ONCE(), because...

> think for example move_present_pte() can end up moving a present PTE
> into a page table that has already been scheduled for RCU freeing.

...this situation is impossible to happen. Before performing move
operation, the pte_same() check will be performed after holding the
pte lock, which can ensure that the PTE page is stable:

CPU 0                    CPU 1

zap_pte_range

			orig_src_pte = ptep_get(src_pte);

pmd_lock
pte_lock
check if all PTEs are pte_none()
--> clear pmd entry
unlock pte
unlock pmd

			src_pte_lock
			pte_same(orig_src_pte, ptep_get(src_pte))
			--> return false and will skip the move op


> 
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   include/linux/mm.h |  1 +
>>   mm/Kconfig         | 15 ++++++++++
>>   mm/Makefile        |  1 +
>>   mm/internal.h      | 23 ++++++++++++++++
>>   mm/madvise.c       |  4 ++-
>>   mm/memory.c        | 45 +++++++++++++++++++++++++++++-
>>   mm/pt_reclaim.c    | 68 ++++++++++++++++++++++++++++++++++++++++++++++
>>   7 files changed, 155 insertions(+), 2 deletions(-)
>>   create mode 100644 mm/pt_reclaim.c
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 3e4bb43035953..ce3936590fe72 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -2319,6 +2319,7 @@ extern void pagefault_out_of_memory(void);
>>   struct zap_details {
>>          struct folio *single_folio;     /* Locked folio to be unmapped */
>>          bool even_cows;                 /* Zap COWed private pages too? */
>> +       bool reclaim_pt;                /* Need reclaim page tables? */
>>          zap_flags_t zap_flags;          /* Extra flags for zapping */
>>   };
>>
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index 84000b0168086..681909e0a9fa3 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -1301,6 +1301,21 @@ config ARCH_HAS_USER_SHADOW_STACK
>>            The architecture has hardware support for userspace shadow call
>>             stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
>>
>> +config ARCH_SUPPORTS_PT_RECLAIM
>> +       def_bool n
>> +
>> +config PT_RECLAIM
>> +       bool "reclaim empty user page table pages"
>> +       default y
>> +       depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
>> +       select MMU_GATHER_RCU_TABLE_FREE
>> +       help
>> +         Try to reclaim empty user page table pages in paths other that munmap
> 
> nit: s/other that/other than/

will fix.

> 
>> +         and exit_mmap path.
>> +
>> +         Note: now only empty user PTE page table pages will be reclaimed.
> [...]
>> diff --git a/mm/madvise.c b/mm/madvise.c
>> index 0ceae57da7dad..ee88652761d45 100644
>> --- a/mm/madvise.c
>> +++ b/mm/madvise.c
>> @@ -851,7 +851,9 @@ static int madvise_free_single_vma(struct vm_area_struct *vma,
>>   static long madvise_dontneed_single_vma(struct vm_area_struct *vma,
>>                                          unsigned long start, unsigned long end)
>>   {
>> -       zap_page_range_single(vma, start, end - start, NULL);
>> +       struct zap_details details = {.reclaim_pt = true,};
>> +
>> +       zap_page_range_single(vma, start, end - start, &details);
>>          return 0;
>>   }
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 002aa4f454fa0..c4a8c18fbcfd7 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -1436,7 +1436,7 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
>>   static inline bool should_zap_cows(struct zap_details *details)
>>   {
>>          /* By default, zap all pages */
>> -       if (!details)
>> +       if (!details || details->reclaim_pt)
>>                  return true;
>>
>>          /* Or, we zap COWed pages only if the caller wants to */
> 
> This looks hacky - when we have a "details" object, its ->even_cows
> member is supposed to indicate whether COW pages should be zapped. So
> please instead set .even_cows=true in madvise_dontneed_single_vma().

But the details->reclaim_pt should continue to be set, right? Because
we need to use .reclaim_pt to indicate whether the empty PTE page
should be reclaimed.

> 
>> @@ -1678,6 +1678,30 @@ static inline int do_zap_pte_range(struct mmu_gather *tlb,
>>                                           details, rss);
>>   }
>>
>> +static inline int count_pte_none(pte_t *pte, int nr)
>> +{
>> +       int none_nr = 0;
>> +
>> +       /*
>> +        * If PTE_MARKER_UFFD_WP is enabled, the uffd-wp PTEs may be
>> +        * re-installed, so we need to check pte_none() one by one.
>> +        * Otherwise, checking a single PTE in a batch is sufficient.
>> +        */
> 
> Please also add a comment noting that count_pte_none() relies on this
> invariant on top of do_zap_pte_range() or somewhere like that.

OK, will add a comment above do_zap_pte_range() to explain this special
case.

> 
>> +#ifdef CONFIG_PTE_MARKER_UFFD_WP
>> +       for (;;) {
>> +               if (pte_none(ptep_get(pte)))
>> +                       none_nr++;
>> +               if (--nr == 0)
>> +                       break;
>> +               pte++;
>> +       }
>> +#else
>> +       if (pte_none(ptep_get(pte)))
>> +               none_nr = nr;
>> +#endif
>> +       return none_nr;
>> +}
>> +
>>   static unsigned long zap_pte_range(struct mmu_gather *tlb,
>>                                  struct vm_area_struct *vma, pmd_t *pmd,
>>                                  unsigned long addr, unsigned long end,
>> @@ -1689,8 +1713,16 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>>          spinlock_t *ptl;
>>          pte_t *start_pte;
>>          pte_t *pte;
>> +       pmd_t pmdval;
>> +       bool can_reclaim_pt = false;
>> +       bool direct_reclaim = false;
>> +       unsigned long start = addr;
>> +       int none_nr = 0;
>>          int nr;
>>
>> +       if (details && details->reclaim_pt && (end - start >= PMD_SIZE))
>> +               can_reclaim_pt = true;
>> +
>>   retry:
>>          tlb_change_page_size(tlb, PAGE_SIZE);
>>          init_rss_vec(rss);
>> @@ -1706,12 +1738,16 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>>
>>                  nr = do_zap_pte_range(tlb, vma, pte, addr, end, details, rss,
>>                                        &force_flush, &force_break);
>> +               none_nr += count_pte_none(pte, nr);
>>                  if (unlikely(force_break)) {
>>                          addr += nr * PAGE_SIZE;
>>                          break;
>>                  }
>>          } while (pte += nr, addr += PAGE_SIZE * nr, addr != end);
>>
>> +       if (addr == end && can_reclaim_pt && (none_nr == PTRS_PER_PTE))
>> +               direct_reclaim = try_get_and_clear_pmd(mm, pmd, &pmdval);
>> +
>>          add_mm_rss_vec(mm, rss);
>>          arch_leave_lazy_mmu_mode();
>>
>> @@ -1738,6 +1774,13 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
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
> 
> If you swap the following two operations around (first pmd_lock(),
> then pte_offset_map_rw_nolock(), then take the PTE lock):

Indeed, will change to it.

Thanks,
Qi

> 
>> +       start_pte = pte_offset_map_rw_nolock(mm, pmd, addr, &pmdval, &ptl);
>> +       if (!start_pte)
>> +               return;
>> +
>> +       pml = pmd_lock(mm, pmd);
>> +       if (ptl != pml)
>> +               spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
>> +
> 
> Then I think this check can go away:
> 
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
>> +
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

