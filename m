Return-Path: <linux-kernel+bounces-370435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 900159A2C61
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 20:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D6631F2188D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A6E20111B;
	Thu, 17 Oct 2024 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wPYvUGI9"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CA317C9E9
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 18:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729190668; cv=none; b=W8vb25dZ9snLEl26Pn6w8ZiC9rJ/Vgn2OXngPEX/EoMWjl8+2WXmUq+tWgoM09+F7uJ1P8VXpJo0nnOlVWusBPJphzvZYjXILhg+SJ46gmc652zGaF71lBwVBiHkX1UxgEkQ3lALh2lZACDenkr3CaMz8pW8X/to9xycoSn5TtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729190668; c=relaxed/simple;
	bh=6u2MNShmDk/hatjP6zIsokuOIkoOzhcPDxD56hJhGP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vke5CnVXuOwpXGtIDHy2I1oQYsnT/AVYvebFeSQx3Xk3rp0s6i1BkhcbyhGXdA9f7jQkeayzP2NUdyHqx/BPSR2TsFkqTxMFuqF8a0wQj2qijJoVrMQccgvPwwVpa6uZMaSd/x0Mq9ZEhoE7fGPP5H2LrYdZRZ+X5H6qu48tgRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wPYvUGI9; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c93e9e701fso3180a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 11:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729190662; x=1729795462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4LSXbXNO20AxHYvERdb4bBA4B871DiEWg3td+aWMDU=;
        b=wPYvUGI9OeooAh63sNLCFR6WJkqi7mJHhpoj21U34IfyfycWRlNCUHPc8jSXWx2maM
         lEISJKUUlMbLrGS+/KkJuiePzmHy3+pUhzIl3uxx081P3AMSfF2c6eWRicFnA76+uEZn
         a/vY9cKE7KJB/k8SroMHW6pgRh/o8bZtjP/+oEQ7nMYI8OX+qDzW9b9VraYpFKS8bLYF
         twn0AZhS3bMFr/xu3dizC5Mr9Ph2Sli6pXmBhp6oAekgR6/Q78vuqmSAeTP1beqZwtEM
         DRK6Y8eJS6SdoK/ohpqR/Ywq/LPtANY77EO70nizdswvUwBvuQEGFOIpn/mG5iSlMEEz
         w+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729190662; x=1729795462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4LSXbXNO20AxHYvERdb4bBA4B871DiEWg3td+aWMDU=;
        b=kEq17SP4hnIxJCNPDM59YHfTUuyJtzT+eZfJOkSR/ALXQfhG0WPsLCAU9ONoJ3i4vA
         SJl3ROqYK167YYyqFxuaKhF4HMj2+SbRvK4W25413FZxuPG3H5laIAl1aHjH28xW/xQS
         TqdwJxn/3dGKpQ/rKjVOcF2w871+Qj+LRT+FMt3JhmJmO5ZOS+9wIVKM6pe3+ThmPw/0
         R3kWMbHQSXCiDb9A5FDucToqA9xd77j/q3DG2Bcjbba+UeiVTyANWsWUTuuG0+nZt/tP
         MFI+RJdttTvEmrInjlIrtvTDaWtsjA10pIGOF8Bi/W5rdSWQVoBmeJ1hmV02MnyZo5jd
         vDsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmQ539s+95bGGGNqNjZq5tdb1qrUUfgWv5URhRAHaObrvkGVM5O8LIqXqZsjfH18yhac0aMox1DwTBMBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaJ3F+32syInTNyeQeMfbEsK7SMOkvtT9YnTwzMzu8QtfCDAaL
	DlIESMqsUOHhERBZiCCEGAFn9JcIEhIjpOcbZ8SvNeLFaGXdzCiLpspwuNjsdNA1BdYevr0Dn6C
	HGkArkTtazNh/auI/bmt4FRbrvgLC5sPfZeut
X-Google-Smtp-Source: AGHT+IHRT0wqPgR4NZuOwJLPWGnv7qZGhOR/jlX9a973MSbvfq3gHHKV7SeOpZxzpiYoVWtPih/9J/cMG1UeMUoDus8=
X-Received: by 2002:a05:6402:520b:b0:5c9:2834:589c with SMTP id
 4fb4d7f45d1cf-5ca0a1f5063mr33361a12.3.1729190661263; Thu, 17 Oct 2024
 11:44:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729157502.git.zhengqi.arch@bytedance.com> <6c7fe15b0434a08a287c400869f9ba434e1a8fa3.1729157502.git.zhengqi.arch@bytedance.com>
In-Reply-To: <6c7fe15b0434a08a287c400869f9ba434e1a8fa3.1729157502.git.zhengqi.arch@bytedance.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 17 Oct 2024 20:43:43 +0200
Message-ID: <CAG48ez3MLMXZvkbPGZ4He2+tnOSHYxA68Sa1Hd_70-3a8K++=A@mail.gmail.com>
Subject: Re: [PATCH v1 5/7] mm: pgtable: try to reclaim empty PTE page in madvise(MADV_DONTNEED)
To: Qi Zheng <zhengqi.arch@bytedance.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: david@redhat.com, hughd@google.com, willy@infradead.org, mgorman@suse.de, 
	muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org, 
	zokeefe@google.com, rientjes@google.com, peterx@redhat.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+arm64 maintainers in case they have opinions on the break-before-make aspe=
cts

On Thu, Oct 17, 2024 at 11:48=E2=80=AFAM Qi Zheng <zhengqi.arch@bytedance.c=
om> wrote:
> Now in order to pursue high performance, applications mostly use some
> high-performance user-mode memory allocators, such as jemalloc or
> tcmalloc. These memory allocators use madvise(MADV_DONTNEED or MADV_FREE)
> to release physical memory, but neither MADV_DONTNEED nor MADV_FREE will
> release page table memory, which may cause huge page table memory usage.
>
> The following are a memory usage snapshot of one process which actually
> happened on our server:
>
>         VIRT:  55t
>         RES:   590g
>         VmPTE: 110g
>
> In this case, most of the page table entries are empty. For such a PTE
> page where all entries are empty, we can actually free it back to the
> system for others to use.
>
> As a first step, this commit aims to synchronously free the empty PTE
> pages in madvise(MADV_DONTNEED) case. We will detect and free empty PTE
> pages in zap_pte_range(), and will add zap_details.reclaim_pt to exclude
> cases other than madvise(MADV_DONTNEED).
>
> Once an empty PTE is detected, we first try to hold the pmd lock within
> the pte lock. If successful, we clear the pmd entry directly (fast path).
> Otherwise, we wait until the pte lock is released, then re-hold the pmd
> and pte locks and loop PTRS_PER_PTE times to check pte_none() to re-detec=
t
> whether the PTE page is empty and free it (slow path).
>
> For other cases such as madvise(MADV_FREE), consider scanning and freeing
> empty PTE pages asynchronously in the future.

One thing I find somewhat scary about this is that it makes it
possible to free page tables in anonymous mappings, and to free page
tables of VMAs with an ->anon_vma, which was not possible before. Have
you checked all the current users of pte_offset_map_ro_nolock(),
pte_offset_map_rw_nolock(), and pte_offset_map() to make sure none of
them assume that this can't happen?

For example, pte_offset_map_rw_nolock() is called from move_ptes(),
with a comment basically talking about how this is safe *because only
khugepaged can remove page tables*.

> diff --git a/mm/memory.c b/mm/memory.c
> index cc89ede8ce2ab..77774b34f2cde 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1437,7 +1437,7 @@ copy_page_range(struct vm_area_struct *dst_vma, str=
uct vm_area_struct *src_vma)
>  static inline bool should_zap_cows(struct zap_details *details)
>  {
>         /* By default, zap all pages */
> -       if (!details)
> +       if (!details || details->reclaim_pt)
>                 return true;
>
>         /* Or, we zap COWed pages only if the caller wants to */
> @@ -1611,8 +1611,18 @@ static unsigned long zap_pte_range(struct mmu_gath=
er *tlb,
>         pte_t *start_pte;
>         pte_t *pte;
>         swp_entry_t entry;
> +       pmd_t pmdval;
> +       bool can_reclaim_pt =3D false;
> +       bool direct_reclaim;
> +       unsigned long start =3D addr;
>         int nr;
>
> +       if (details && details->reclaim_pt)
> +               can_reclaim_pt =3D true;
> +
> +       if ((ALIGN_DOWN(end, PMD_SIZE)) - (ALIGN(start, PMD_SIZE)) < PMD_=
SIZE)
> +               can_reclaim_pt =3D false;

Does this check actually work? Assuming we're on x86, if you pass in
start=3D0x1000 and end=3D0x2000, if I understand correctly,
ALIGN_DOWN(end, PMD_SIZE) will be 0, while ALIGN(start, PMD_SIZE) will
be 0x200000, and so we will check:

if (0 - 0x200000 < PMD_SIZE)

which is

if (0xffffffffffe00000 < 0x200000)

which is false?

>  retry:
>         tlb_change_page_size(tlb, PAGE_SIZE);
>         init_rss_vec(rss);
> @@ -1641,6 +1651,8 @@ static unsigned long zap_pte_range(struct mmu_gathe=
r *tlb,
>                         nr =3D zap_present_ptes(tlb, vma, pte, ptent, max=
_nr,
>                                               addr, details, rss, &force_=
flush,
>                                               &force_break, &is_pt_unrecl=
aimable);
> +                       if (is_pt_unreclaimable)
> +                               set_pt_unreclaimable(&can_reclaim_pt);
>                         if (unlikely(force_break)) {
>                                 addr +=3D nr * PAGE_SIZE;
>                                 break;
> @@ -1653,8 +1665,10 @@ static unsigned long zap_pte_range(struct mmu_gath=
er *tlb,
>                     is_device_exclusive_entry(entry)) {
>                         page =3D pfn_swap_entry_to_page(entry);
>                         folio =3D page_folio(page);
> -                       if (unlikely(!should_zap_folio(details, folio)))
> +                       if (unlikely(!should_zap_folio(details, folio))) =
{
> +                               set_pt_unreclaimable(&can_reclaim_pt);
>                                 continue;
> +                       }
>                         /*
>                          * Both device private/exclusive mappings should =
only
>                          * work with anonymous page so far, so we don't n=
eed to
> @@ -1670,14 +1684,18 @@ static unsigned long zap_pte_range(struct mmu_gat=
her *tlb,
>                         max_nr =3D (end - addr) / PAGE_SIZE;
>                         nr =3D swap_pte_batch(pte, max_nr, ptent);
>                         /* Genuine swap entries, hence a private anon pag=
es */
> -                       if (!should_zap_cows(details))
> +                       if (!should_zap_cows(details)) {
> +                               set_pt_unreclaimable(&can_reclaim_pt);
>                                 continue;
> +                       }
>                         rss[MM_SWAPENTS] -=3D nr;
>                         free_swap_and_cache_nr(entry, nr);
>                 } else if (is_migration_entry(entry)) {
>                         folio =3D pfn_swap_entry_folio(entry);
> -                       if (!should_zap_folio(details, folio))
> +                       if (!should_zap_folio(details, folio)) {
> +                               set_pt_unreclaimable(&can_reclaim_pt);
>                                 continue;
> +                       }
>                         rss[mm_counter(folio)]--;
>                 } else if (pte_marker_entry_uffd_wp(entry)) {
>                         /*
> @@ -1685,21 +1703,29 @@ static unsigned long zap_pte_range(struct mmu_gat=
her *tlb,
>                          * drop the marker if explicitly requested.
>                          */
>                         if (!vma_is_anonymous(vma) &&
> -                           !zap_drop_file_uffd_wp(details))
> +                           !zap_drop_file_uffd_wp(details)) {
> +                               set_pt_unreclaimable(&can_reclaim_pt);
>                                 continue;
> +                       }
>                 } else if (is_hwpoison_entry(entry) ||
>                            is_poisoned_swp_entry(entry)) {
> -                       if (!should_zap_cows(details))
> +                       if (!should_zap_cows(details)) {
> +                               set_pt_unreclaimable(&can_reclaim_pt);
>                                 continue;
> +                       }
>                 } else {
>                         /* We should have covered all the swap entry type=
s */
>                         pr_alert("unrecognized swap entry 0x%lx\n", entry=
.val);
>                         WARN_ON_ONCE(1);
>                 }
>                 clear_not_present_full_ptes(mm, addr, pte, nr, tlb->fullm=
m);
> -               zap_install_uffd_wp_if_needed(vma, addr, pte, nr, details=
, ptent);
> +               if (zap_install_uffd_wp_if_needed(vma, addr, pte, nr, det=
ails, ptent))
> +                       set_pt_unreclaimable(&can_reclaim_pt);
>         } while (pte +=3D nr, addr +=3D PAGE_SIZE * nr, addr !=3D end);
>
> +       if (addr =3D=3D end && can_reclaim_pt)
> +               direct_reclaim =3D try_get_and_clear_pmd(mm, pmd, &pmdval=
);
> +
>         add_mm_rss_vec(mm, rss);
>         arch_leave_lazy_mmu_mode();
>
> @@ -1724,6 +1750,13 @@ static unsigned long zap_pte_range(struct mmu_gath=
er *tlb,
>                 goto retry;
>         }
>
> +       if (can_reclaim_pt) {
> +               if (direct_reclaim)
> +                       free_pte(mm, start, tlb, pmdval);
> +               else
> +                       try_to_free_pte(mm, pmd, start, tlb);
> +       }
> +
>         return addr;
>  }
>
> diff --git a/mm/pt_reclaim.c b/mm/pt_reclaim.c
> new file mode 100644
> index 0000000000000..fc055da40b615
> --- /dev/null
> +++ b/mm/pt_reclaim.c
> @@ -0,0 +1,68 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/hugetlb.h>
> +#include <asm-generic/tlb.h>
> +#include <asm/pgalloc.h>
> +
> +#include "internal.h"
> +
> +bool try_get_and_clear_pmd(struct mm_struct *mm, pmd_t *pmd, pmd_t *pmdv=
al)
> +{
> +       spinlock_t *pml =3D pmd_lockptr(mm, pmd);
> +
> +       if (!spin_trylock(pml))
> +               return false;
> +
> +       *pmdval =3D pmdp_get_lockless(pmd);
> +       pmd_clear(pmd);
> +       spin_unlock(pml);
> +
> +       return true;
> +}
> +
> +void free_pte(struct mm_struct *mm, unsigned long addr, struct mmu_gathe=
r *tlb,
> +             pmd_t pmdval)
> +{
> +       pte_free_tlb(tlb, pmd_pgtable(pmdval), addr);
> +       mm_dec_nr_ptes(mm);
> +}
> +
> +void try_to_free_pte(struct mm_struct *mm, pmd_t *pmd, unsigned long add=
r,
> +                    struct mmu_gather *tlb)
> +{
> +       pmd_t pmdval;
> +       spinlock_t *pml, *ptl;
> +       pte_t *start_pte, *pte;
> +       int i;
> +
> +       start_pte =3D pte_offset_map_rw_nolock(mm, pmd, addr, &pmdval, &p=
tl);
> +       if (!start_pte)
> +               return;
> +
> +       pml =3D pmd_lock(mm, pmd);
> +       if (ptl !=3D pml)
> +               spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
> +
> +       if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(pmd))))
> +               goto out_ptl;
> +
> +       /* Check if it is empty PTE page */
> +       for (i =3D 0, pte =3D start_pte; i < PTRS_PER_PTE; i++, pte++) {
> +               if (!pte_none(ptep_get(pte)))
> +                       goto out_ptl;
> +       }
> +       pte_unmap(start_pte);
> +
> +       pmd_clear(pmd);
> +
> +       if (ptl !=3D pml)
> +               spin_unlock(ptl);
> +       spin_unlock(pml);

At this point, you have cleared the PMD and dropped the locks
protecting against concurrency, but have not yet done a TLB flush. If
another thread concurrently repopulates the PMD at this point, can we
get incoherent TLB state in a way that violates the arm64
break-before-make rule?

Though I guess we can probably already violate break-before-make if
MADV_DONTNEED races with a pagefault, since zap_present_folio_ptes()
does not seem to set "force_flush" when zapping anon PTEs...

(I realize you're only enabling this for x86 for now, but we should
probably make sure the code is not arch-dependent in subtle
undocumented ways...)

> +       free_pte(mm, addr, tlb, pmdval);
> +
> +       return;
> +out_ptl:
> +       pte_unmap_unlock(start_pte, ptl);
> +       if (pml !=3D ptl)
> +               spin_unlock(pml);
> +}
> --
> 2.20.1
>

