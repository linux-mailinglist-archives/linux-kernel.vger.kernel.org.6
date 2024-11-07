Return-Path: <linux-kernel+bounces-400799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9642A9C1281
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 00:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D84D5B21BF5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 23:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945881F12F5;
	Thu,  7 Nov 2024 23:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UdZw+0NN"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6EE198E99
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 23:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731022578; cv=none; b=T82j9a2eXqSNrjXawY7mCSDBZ8by1FshjzHsQxtEOcguitQPsfkpD2rHVuipNVPVER4YU3ZtyI1N1EHhwSuS13F+EuntZxMGyb2ZPjo+wVXte85lsngWVmXBzV93tLA8laQ4LZLF82RM6upmc+NGSiMX2xKea7IblXGGeb4idqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731022578; c=relaxed/simple;
	bh=05porjiPfZDN3J5kZlFnmidraCh8/EWN7MyfvHEzoG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XOWen4NuuAILiDRVPLDqXYFM0pjRiH9VF+qA2GGmrCamFkJJC0SKTFZA53xXSgC/nmM4JOOzz2HxgZZEFQoYgJZYJ+b8Km2DTUaa9m+zQLWjIlgeqAGtZpDto7qPBxecwXLqPAjca4pvH38FCFSNRdQNaSk6v45v65Ge7b+zvgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UdZw+0NN; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c934b2c991so9164a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 15:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731022575; x=1731627375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKyh58HYszHZ6WgJ96MeZYjhhbw/QF5yju4cRb3ZTUA=;
        b=UdZw+0NNCUCa70oJNCwYuBRYLHoOs8TeuFObXGLpP4MGmLisXmjHRGF700fAUpfeY/
         j5syLTzc3JaDGHdXRlkKn81fPc2DYq6y/OLinUoz721adQNl7Y9ArtD0BtTeIB0Mt3ke
         6OPdJdhTNjmtTCfn8NOksEHHxM0mLbisqUBOZczqEXpEOVOkDuoaeUEYTV1c0MsFa3J0
         YN/SpFOj5pE1xRzgDj/kZYDaRtMA75pIPbZLVCBoi2LZSKZ+KXtPGRv+0frHwac9p5wm
         WLDMhTu5YKw75Od9asTz8MVsbrfdoHEAZTBb4o4nHNJym3NblnoI6I64nQo99ynnJBJK
         IbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731022575; x=1731627375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKyh58HYszHZ6WgJ96MeZYjhhbw/QF5yju4cRb3ZTUA=;
        b=Zu9jjdgvZ2yapRkP2iKEfpacqKkSxr192TtqW3Imwj1Flk2SA64fga9j2TR8RH27FW
         wC8GYmqGIpnccei2HFSjWN/uhjO9EoeaCDUsDTbO003yTrYO5pA7cDWP3kX9CVhZA/DM
         giMOY5L2IuxYZu4HqyXLVZCjrIbxjPlmOlNKMMtLRO5AWzfAV1H05rfa/lxNnQZGEl7X
         TW0gCRd/dYmwacU6xZJMyxCwcAtTIqlUev3byrKqeXSOiEf9ybeVLJc8pZN/rDikmtkx
         /xiv7cnVte+IHrLPNADAguhwfKEAptLOiahR+mP9u4Lq4+1tKtJa/4ewSvm7OHtFCSE/
         T61A==
X-Forwarded-Encrypted: i=1; AJvYcCUJi3zan54e7la3W7i8pB6ae7SOu1IWluBzCq+0ugdUPv6qb3mg6TOZ8uJZxTdmnGVlC71nsZRbBWlKh3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcgfrhEWCbsd1vXEW1GuBLA4N1Vy+1Cv5+MIOL9bFfadgb7p1g
	nr/hIp8AITZB82VQItuo3neY2d+MeVIr4xmx+HOF07F0xNLZ1elbz74uE8MFI/YLbCRLfJgIpIP
	h+lJLHC9pOaY20p70LGpqiLxM2VapiY0kiclK
X-Gm-Gg: ASbGnctGcdvsRA6BR37xlP8JYjI/cHNTV5TEu9ZXQul3n5wGPmuBwGNeuqrwLtc1HP/
	BDBb2Wz/9CrMwLoadfQYFaOAO/r4XYNPwsG8yPtf5W3X+q4B2PFX7UioLkhI=
X-Google-Smtp-Source: AGHT+IGwuYbdMKN4X8y4WxrF53t7omX0y4mxiwq8/BykUSzl8vXEwho6GMrl85skorVkTtawAHm/PmTuI8tP1Cvp9O8=
X-Received: by 2002:a50:f69a:0:b0:5cb:7316:2e15 with SMTP id
 4fb4d7f45d1cf-5cefbb03500mr871447a12.0.1731022574654; Thu, 07 Nov 2024
 15:36:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730360798.git.zhengqi.arch@bytedance.com> <c0199a7d7097521bbc183739b1fa6793081d726b.1730360798.git.zhengqi.arch@bytedance.com>
In-Reply-To: <c0199a7d7097521bbc183739b1fa6793081d726b.1730360798.git.zhengqi.arch@bytedance.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 8 Nov 2024 00:35:38 +0100
Message-ID: <CAG48ez0bv_y1k3cqMCsj0sJGPR4iK9zmHTa6124+N6i+s4+bTA@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] mm: pgtable: try to reclaim empty PTE page in madvise(MADV_DONTNEED)
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: david@redhat.com, hughd@google.com, willy@infradead.org, mgorman@suse.de, 
	muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org, 
	zokeefe@google.com, rientjes@google.com, peterx@redhat.com, 
	catalin.marinas@arm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 9:14=E2=80=AFAM Qi Zheng <zhengqi.arch@bytedance.co=
m> wrote:
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

How does this interact with move_pages_pte()? I am looking at your
series applied on top of next-20241106, and it looks to me like
move_pages_pte() uses pte_offset_map_rw_nolock() and assumes that the
PMD entry can't change. You can clearly see this assumption at the
WARN_ON_ONCE(pmd_none(*dst_pmd)). And if we race the wrong way, I
think for example move_present_pte() can end up moving a present PTE
into a page table that has already been scheduled for RCU freeing.

> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  include/linux/mm.h |  1 +
>  mm/Kconfig         | 15 ++++++++++
>  mm/Makefile        |  1 +
>  mm/internal.h      | 23 ++++++++++++++++
>  mm/madvise.c       |  4 ++-
>  mm/memory.c        | 45 +++++++++++++++++++++++++++++-
>  mm/pt_reclaim.c    | 68 ++++++++++++++++++++++++++++++++++++++++++++++
>  7 files changed, 155 insertions(+), 2 deletions(-)
>  create mode 100644 mm/pt_reclaim.c
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 3e4bb43035953..ce3936590fe72 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2319,6 +2319,7 @@ extern void pagefault_out_of_memory(void);
>  struct zap_details {
>         struct folio *single_folio;     /* Locked folio to be unmapped */
>         bool even_cows;                 /* Zap COWed private pages too? *=
/
> +       bool reclaim_pt;                /* Need reclaim page tables? */
>         zap_flags_t zap_flags;          /* Extra flags for zapping */
>  };
>
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 84000b0168086..681909e0a9fa3 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1301,6 +1301,21 @@ config ARCH_HAS_USER_SHADOW_STACK
>           The architecture has hardware support for userspace shadow call
>            stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
>
> +config ARCH_SUPPORTS_PT_RECLAIM
> +       def_bool n
> +
> +config PT_RECLAIM
> +       bool "reclaim empty user page table pages"
> +       default y
> +       depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
> +       select MMU_GATHER_RCU_TABLE_FREE
> +       help
> +         Try to reclaim empty user page table pages in paths other that =
munmap

nit: s/other that/other than/

> +         and exit_mmap path.
> +
> +         Note: now only empty user PTE page table pages will be reclaime=
d.
[...]
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 0ceae57da7dad..ee88652761d45 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -851,7 +851,9 @@ static int madvise_free_single_vma(struct vm_area_str=
uct *vma,
>  static long madvise_dontneed_single_vma(struct vm_area_struct *vma,
>                                         unsigned long start, unsigned lon=
g end)
>  {
> -       zap_page_range_single(vma, start, end - start, NULL);
> +       struct zap_details details =3D {.reclaim_pt =3D true,};
> +
> +       zap_page_range_single(vma, start, end - start, &details);
>         return 0;
>  }
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 002aa4f454fa0..c4a8c18fbcfd7 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1436,7 +1436,7 @@ copy_page_range(struct vm_area_struct *dst_vma, str=
uct vm_area_struct *src_vma)
>  static inline bool should_zap_cows(struct zap_details *details)
>  {
>         /* By default, zap all pages */
> -       if (!details)
> +       if (!details || details->reclaim_pt)
>                 return true;
>
>         /* Or, we zap COWed pages only if the caller wants to */

This looks hacky - when we have a "details" object, its ->even_cows
member is supposed to indicate whether COW pages should be zapped. So
please instead set .even_cows=3Dtrue in madvise_dontneed_single_vma().

> @@ -1678,6 +1678,30 @@ static inline int do_zap_pte_range(struct mmu_gath=
er *tlb,
>                                          details, rss);
>  }
>
> +static inline int count_pte_none(pte_t *pte, int nr)
> +{
> +       int none_nr =3D 0;
> +
> +       /*
> +        * If PTE_MARKER_UFFD_WP is enabled, the uffd-wp PTEs may be
> +        * re-installed, so we need to check pte_none() one by one.
> +        * Otherwise, checking a single PTE in a batch is sufficient.
> +        */

Please also add a comment noting that count_pte_none() relies on this
invariant on top of do_zap_pte_range() or somewhere like that.

> +#ifdef CONFIG_PTE_MARKER_UFFD_WP
> +       for (;;) {
> +               if (pte_none(ptep_get(pte)))
> +                       none_nr++;
> +               if (--nr =3D=3D 0)
> +                       break;
> +               pte++;
> +       }
> +#else
> +       if (pte_none(ptep_get(pte)))
> +               none_nr =3D nr;
> +#endif
> +       return none_nr;
> +}
> +
>  static unsigned long zap_pte_range(struct mmu_gather *tlb,
>                                 struct vm_area_struct *vma, pmd_t *pmd,
>                                 unsigned long addr, unsigned long end,
> @@ -1689,8 +1713,16 @@ static unsigned long zap_pte_range(struct mmu_gath=
er *tlb,
>         spinlock_t *ptl;
>         pte_t *start_pte;
>         pte_t *pte;
> +       pmd_t pmdval;
> +       bool can_reclaim_pt =3D false;
> +       bool direct_reclaim =3D false;
> +       unsigned long start =3D addr;
> +       int none_nr =3D 0;
>         int nr;
>
> +       if (details && details->reclaim_pt && (end - start >=3D PMD_SIZE)=
)
> +               can_reclaim_pt =3D true;
> +
>  retry:
>         tlb_change_page_size(tlb, PAGE_SIZE);
>         init_rss_vec(rss);
> @@ -1706,12 +1738,16 @@ static unsigned long zap_pte_range(struct mmu_gat=
her *tlb,
>
>                 nr =3D do_zap_pte_range(tlb, vma, pte, addr, end, details=
, rss,
>                                       &force_flush, &force_break);
> +               none_nr +=3D count_pte_none(pte, nr);
>                 if (unlikely(force_break)) {
>                         addr +=3D nr * PAGE_SIZE;
>                         break;
>                 }
>         } while (pte +=3D nr, addr +=3D PAGE_SIZE * nr, addr !=3D end);
>
> +       if (addr =3D=3D end && can_reclaim_pt && (none_nr =3D=3D PTRS_PER=
_PTE))
> +               direct_reclaim =3D try_get_and_clear_pmd(mm, pmd, &pmdval=
);
> +
>         add_mm_rss_vec(mm, rss);
>         arch_leave_lazy_mmu_mode();
>
> @@ -1738,6 +1774,13 @@ static unsigned long zap_pte_range(struct mmu_gath=
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

If you swap the following two operations around (first pmd_lock(),
then pte_offset_map_rw_nolock(), then take the PTE lock):

> +       start_pte =3D pte_offset_map_rw_nolock(mm, pmd, addr, &pmdval, &p=
tl);
> +       if (!start_pte)
> +               return;
> +
> +       pml =3D pmd_lock(mm, pmd);
> +       if (ptl !=3D pml)
> +               spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
> +

Then I think this check can go away:

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
> +
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

