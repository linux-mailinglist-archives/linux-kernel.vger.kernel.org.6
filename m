Return-Path: <linux-kernel+bounces-254581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 107699334EA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 03:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9A661C21A5A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 01:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC23138C;
	Wed, 17 Jul 2024 01:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GE0LduZf"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487FAED8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 01:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721178955; cv=none; b=HqCN3RKBkE+xu5D8ONNUss9GqSsbrqvqjduVjUsMFjA6ZsLMdYgbPaUIsve+PMFwgc4f26qqY0xnvLHpAXDTfATEM1KcphHVn1xsvQwpERwxZDVSoF5OrxFqpYDIaGyE+e7VHfrZ7PiEj3ovGz5jRbKOFfW9Lgr/T47Hk+C7n6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721178955; c=relaxed/simple;
	bh=UPC4n3TFMRWzP2IsurN8fGkQELBKZP+88za+ETmYQbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IYosDNIUpCv5HjBDaOe85Hude2jnSM1v/lsQ5Mh2/KeQ+rGmCAjFEQkO+jqC3Ux3Z9URbbtZSqEu0Bl2UAFC1S8MndjnnN/OGCAAYnQE4u+1WdVSZIcgOIe4Ud/pdZpsVpxXuWyoXVLDDvHQ7Rs/dnnS6/Hu7pTkaTU8+jVAuog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GE0LduZf; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-703d5b29e06so2742051a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 18:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721178952; x=1721783752; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wEUpYDGdX5lK9tIEEyrjSHz4yYVdmswjNv1Bx1TiqLg=;
        b=GE0LduZfOD5XNuoq5vpt1khHeIhWcgzHHmpyAh4WRkeRgyh56z0ZOeweZHjBCPIjn4
         O/v9cYeeEfzZddajQ99Alg/w9MMw4Y1g1Ciraykxt7zSZVhdVhqBy2h2hRtstlf7SuK/
         jzgT8VNcswNuxACwh2bibJBGiIiYo6B0D6Z+BvB8tDwa2PsIcRCmjPRIcr79+3yaHCA6
         laTB4G1PDz09+EJxMP7y605qeqC8M9eLHHu7YY60HaQxrGt6veAYXDexYpxs3M45wUTf
         W0qhFBte4cUISli6xNZrNIqkGISrc7eyEaP8u6YPN5iHoUQber9QtnR2gdIOT7xIQYm9
         XSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721178952; x=1721783752;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wEUpYDGdX5lK9tIEEyrjSHz4yYVdmswjNv1Bx1TiqLg=;
        b=NbcdqKXzJ+V3PbtVda5LM6rF0cLc8AXx/Psi4IhwsShFD61PnJg5pBg5PnDK3jS1FP
         xMaWSq3cABfFthfOvD/NpqvKXwRy+4XthKfZnVWoXb8zg3eieKXl49GiO8TjW5LvoQjM
         cNAVay+ZvY7+vS/oQ0EN9zBOpl21Nxs+zEc7EimBcVAGDGnxg6H7K/Bruod/BqqF/oLN
         FNTPI9EYN47/wIYfZtN57JgFMU/CI+teilhGvE8c+SyWmDDdCaoluxEMAjR6qZe7nA8X
         eDH7DuOE9SaN6PiyVeNTQKO/pftIYddNgybQP5xgl4begGIwu/FpXwS/c8s2l0sVBRM+
         Pr5g==
X-Forwarded-Encrypted: i=1; AJvYcCUfnWpQz53t/P7hT8vtnT9cw2HZOdGFMPuE6rKrcUP8K0A4IZ1C3H44e09+SaBFYJekfbwkw6lsU0aF8e0WJecjNueJ9npzGJk1jJph
X-Gm-Message-State: AOJu0Yz1yTz7/WaszmGh/3/BtQtOqbSEyT4AvrwSj5VTWN5We3C502Tk
	LW/JO8UnehrlMK9HPLEu8yhSuLnx0MPYz2Du583Brj6t3Rhn7n88yGxmQPHwSHvEPsiZx9Qqt5O
	8l1mfudheJGEOzeRhq7ez9Ckecco=
X-Google-Smtp-Source: AGHT+IEaHceH9gR31knisVH1Y/FJiWaha8+lmXmk3GDYifVrdzmXRQGZdEQq5dsRWC64P9siHh14K++VjMZXVtuwmhQ=
X-Received: by 2002:a05:6870:c081:b0:25d:53ff:7543 with SMTP id
 586e51a60fabf-260d905da13mr146014fac.22.1721178952239; Tue, 16 Jul 2024
 18:15:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710033004.3923527-1-zhangchunyan@iscas.ac.cn>
 <9bf70f7c-5deb-4fce-b7c1-ec70d78cb5db@ghiti.fr> <CAAfSe-vhhVvP5Sa9bGGSw4ZQvexqUrjdTFjJL-4gLn0jsuk0ew@mail.gmail.com>
 <cab9dc95-c40c-4c4e-a91d-5698cbd5b4d2@ghiti.fr>
In-Reply-To: <cab9dc95-c40c-4c4e-a91d-5698cbd5b4d2@ghiti.fr>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Wed, 17 Jul 2024 09:15:15 +0800
Message-ID: <CAAfSe-tdFjDwSob6M3mQxaa2SPyYOK0V8dyx_kz9ac_4-iAH+Q@mail.gmail.com>
Subject: Re: [PATCH] riscv/mm: Add soft-dirty page tracking support
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Chunyan Zhang <zhangchunyan@iscas.ac.cn>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 21:00, Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> Hi Chunyan,
>
> On 16/07/2024 04:16, Chunyan Zhang wrote:
> > Hi Alex,
> >
> > On Mon, 15 Jul 2024 at 19:21, Alexandre Ghiti <alex@ghiti.fr> wrote:
> >> Hi Chunyan,
> >>
> >> On 10/07/2024 05:30, Chunyan Zhang wrote:
> >>> The PTE bit (9) is reserved for software, so we can use it for
> >>> soft-dirty tracking. This patch adds its standard handlers for
> >>> PTE, PMD, and swap entry.
> >>
> >> Unfortunately, ZONE_DEVICE has just used this last bit and should be
> >> merged in 6.11.
> > Yes, I read the patch just now.
> >
> >> I'm currently discussing internally how we can get 2 other PTE bits from
> >> RVI in order to have the same number of available bits as x86 and arm64.
> > Yes I noticed that PTE bits reserved for software are too limited on RISC-V.
> >
> > Besides softdirty, we probably can support uffd write-protect on
> > RISC-V if we will have two PTE bits for use.
>
>
> Indeed, softdirty and uffd-wp will use two PTE bits.
>
>
> >
> >> I guess that for now, if we really have a usecase for softdirty (and I
> >> think we do with CRIU), we'll have to make ZONE_DEVICE and soft-dirty
> >> mutually exclusive.
> > Yes, I also learned that CRIU uses soft-dirty.
> >
> >>> To add swap PTE soft-dirty tracking, we borrow bit (4) which is
> >>> available for swap PTEs on RISC-V systems.
> >>>
> >>> This patch has been tested with the kselftest mm suite in which
> >>> soft-dirty and madv_populate run and pass, and no regressions
> >>> are observed in any of the other tests.
> >>
> >> Did you give CRIU a try?
> > I haven't tried CRIU, actually I found soft-dirty was missing on
> > RISC-V by the way of running mm selftest cases.
>
>
> Since CRIU is the main user (?) of softdirty, it would be really nice if
> you can test it :)

Sure, and will keep you updated with the progress.

> >
> > I can cook a new patch to implement soft-dirty and ZONE_DEVICE share
> > the PTE bit(9), and make both features mutually exclusive if this
> > solution is accepted.
>
>
> I agree with this solution, let's implement both softdirty and uffd-wp
> by sharing the last PTE bit that ZONE_DEVICE stole. At least it will
> allow people to play with them.

Ok, then I will do next.

> Do you intend to work on uffd-wp? This is on my todo list, so up to you.

Yes, this is not hard for me, let me take it.

Thanks for your review,
Chunyan

> > Or not to add soft-dirty until we have more other PTE bits that can be
> > used for software.
> >
> > I'm open to listen to suggestions.
> >
> > Thanks,
> > Chunyan
>
>
> Thanks,
>
> Alex
>
>
> >
> >> Thanks,
> >>
> >> Alex
> >>
> >>
> >>> Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
> >>> ---
> >>>    arch/riscv/Kconfig                    |  1 +
> >>>    arch/riscv/include/asm/pgtable-bits.h | 13 ++++++
> >>>    arch/riscv/include/asm/pgtable.h      | 65 ++++++++++++++++++++++++++-
> >>>    3 files changed, 78 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> >>> index b94176e25be1..2e3ad2925a6b 100644
> >>> --- a/arch/riscv/Kconfig
> >>> +++ b/arch/riscv/Kconfig
> >>> @@ -118,6 +118,7 @@ config RISCV
> >>>        select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
> >>>        select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
> >>>        select HAVE_ARCH_SECCOMP_FILTER
> >>> +     select HAVE_ARCH_SOFT_DIRTY
> >>>        select HAVE_ARCH_THREAD_STRUCT_WHITELIST
> >>>        select HAVE_ARCH_TRACEHOOK
> >>>        select HAVE_ARCH_TRANSPARENT_HUGEPAGE if 64BIT && MMU
> >>> diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
> >>> index 179bd4afece4..bab48f5fd1e2 100644
> >>> --- a/arch/riscv/include/asm/pgtable-bits.h
> >>> +++ b/arch/riscv/include/asm/pgtable-bits.h
> >>> @@ -19,6 +19,19 @@
> >>>    #define _PAGE_SOFT      (3 << 8)    /* Reserved for software */
> >>>
> >>>    #define _PAGE_SPECIAL   (1 << 8)    /* RSW: 0x1 */
> >>> +
> >>> +#ifdef CONFIG_MEM_SOFT_DIRTY
> >>> +#define _PAGE_SOFT_DIRTY     (1 << 9)    /* RSW: 0x2 for software dirty tracking */
> >>> +/*
> >>> + * BIT 4 is not involved into swap entry computation, so we
> >>> + * can borrow it for swap page soft-dirty tracking.
> >>> + */
> >>> +#define _PAGE_SWP_SOFT_DIRTY _PAGE_USER
> >>> +#else
> >>> +#define _PAGE_SOFT_DIRTY     0
> >>> +#define _PAGE_SWP_SOFT_DIRTY 0
> >>> +#endif /* CONFIG_MEM_SOFT_DIRTY */
> >>> +
> >>>    #define _PAGE_TABLE     _PAGE_PRESENT
> >>>
> >>>    /*
> >>> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> >>> index aad8b8ca51f1..46f512f52580 100644
> >>> --- a/arch/riscv/include/asm/pgtable.h
> >>> +++ b/arch/riscv/include/asm/pgtable.h
> >>> @@ -408,7 +408,7 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
> >>>
> >>>    static inline pte_t pte_mkdirty(pte_t pte)
> >>>    {
> >>> -     return __pte(pte_val(pte) | _PAGE_DIRTY);
> >>> +     return __pte(pte_val(pte) | _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
> >>>    }
> >>>
> >>>    static inline pte_t pte_mkclean(pte_t pte)
> >>> @@ -436,6 +436,36 @@ static inline pte_t pte_mkhuge(pte_t pte)
> >>>        return pte;
> >>>    }
> >>>
> >>> +static inline int pte_soft_dirty(pte_t pte)
> >>> +{
> >>> +     return pte_val(pte) & _PAGE_SOFT_DIRTY;
> >>> +}
> >>> +
> >>> +static inline pte_t pte_mksoft_dirty(pte_t pte)
> >>> +{
> >>> +     return __pte(pte_val(pte) | _PAGE_SOFT_DIRTY);
> >>> +}
> >>> +
> >>> +static inline pte_t pte_clear_soft_dirty(pte_t pte)
> >>> +{
> >>> +     return __pte(pte_val(pte) & ~(_PAGE_SOFT_DIRTY));
> >>> +}
> >>> +
> >>> +static inline int pte_swp_soft_dirty(pte_t pte)
> >>> +{
> >>> +     return pte_val(pte) & _PAGE_SWP_SOFT_DIRTY;
> >>> +}
> >>> +
> >>> +static inline pte_t pte_swp_mksoft_dirty(pte_t pte)
> >>> +{
> >>> +     return __pte(pte_val(pte) | _PAGE_SWP_SOFT_DIRTY);
> >>> +}
> >>> +
> >>> +static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
> >>> +{
> >>> +     return __pte(pte_val(pte) & ~(_PAGE_SWP_SOFT_DIRTY));
> >>> +}
> >>> +
> >>>    #ifdef CONFIG_RISCV_ISA_SVNAPOT
> >>>    #define pte_leaf_size(pte)  (pte_napot(pte) ?                               \
> >>>                                        napot_cont_size(napot_cont_order(pte)) :\
> >>> @@ -721,6 +751,38 @@ static inline pmd_t pmd_mkdirty(pmd_t pmd)
> >>>        return pte_pmd(pte_mkdirty(pmd_pte(pmd)));
> >>>    }
> >>>
> >>> +static inline int pmd_soft_dirty(pmd_t pmd)
> >>> +{
> >>> +     return pte_soft_dirty(pmd_pte(pmd));
> >>> +}
> >>> +
> >>> +static inline pmd_t pmd_mksoft_dirty(pmd_t pmd)
> >>> +{
> >>> +     return pte_pmd(pte_mksoft_dirty(pmd_pte(pmd)));
> >>> +}
> >>> +
> >>> +static inline pmd_t pmd_clear_soft_dirty(pmd_t pmd)
> >>> +{
> >>> +     return pte_pmd(pte_clear_soft_dirty(pmd_pte(pmd)));
> >>> +}
> >>> +
> >>> +#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> >>> +static inline int pmd_swp_soft_dirty(pmd_t pmd)
> >>> +{
> >>> +     return pte_swp_soft_dirty(pmd_pte(pmd));
> >>> +}
> >>> +
> >>> +static inline pmd_t pmd_swp_mksoft_dirty(pmd_t pmd)
> >>> +{
> >>> +     return pte_pmd(pte_swp_mksoft_dirty(pmd_pte(pmd)));
> >>> +}
> >>> +
> >>> +static inline pmd_t pmd_swp_clear_soft_dirty(pmd_t pmd)
> >>> +{
> >>> +     return pte_pmd(pte_swp_clear_soft_dirty(pmd_pte(pmd)));
> >>> +}
> >>> +#endif /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
> >>> +
> >>>    static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
> >>>                                pmd_t *pmdp, pmd_t pmd)
> >>>    {
> >>> @@ -811,6 +873,7 @@ extern pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
> >>>     * Format of swap PTE:
> >>>     *  bit            0:       _PAGE_PRESENT (zero)
> >>>     *  bit       1 to 3:       _PAGE_LEAF (zero)
> >>> + *   bit            4:       _PAGE_SWP_SOFT_DIRTY
> >>>     *  bit            5:       _PAGE_PROT_NONE (zero)
> >>>     *  bit            6:       exclusive marker
> >>>     *  bits      7 to 11:      swap type
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

