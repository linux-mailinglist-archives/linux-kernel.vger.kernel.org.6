Return-Path: <linux-kernel+bounces-177606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AB58C4166
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 090CB1F21FE0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 13:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2341509BF;
	Mon, 13 May 2024 13:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1bDwn0dm"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C51215098B
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 13:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715605613; cv=none; b=ARE9avobPD8f+ZuX6mN2bj78QkmcgmRPKweijSMU6YZnqzK+rZcnJTxzAj33X7jU5wbNwGenrA+o6yc8r84yuQjjX31upSm8mHYCVm7joAk42iV2loBsojCZGegdHAY6/NkbbvMNJyobbjPPRmbrNseeLZg7nXrmqTj2YFgwz98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715605613; c=relaxed/simple;
	bh=oeJDrBF7G410i+qdEbaQKdNOqbu2C/emPUmnjzL4gHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V9HFft9sprO8HydAMZx0PS1GuFYqEP9oWkuTkeai3BMHEQZXVAEz2sR9sM1vddiaxWL+JEWt0js+0gjVdOHMcfaXAjMyQ7+AAD/LS/yMOWtqhRmXCrYlbTjHPE4U6diW7VcWm3ZS9cHedV5unujFvQBUCN6OzJl1033WkUnULmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1bDwn0dm; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59b178b75bso836422966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 06:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715605608; x=1716210408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrsGvge7X1e91Ca7nLsARXz/B6rasvGNzsoO0V6EifM=;
        b=1bDwn0dmnfyEJveHig1q9CMXNzieHs7IfBIzX4tK8WUwsh+ONYbVkkAkPTQZrOxEw4
         BRj2hUe7K3KAqiNprae9GCHjL3yFPr6ZkN6FJ/cbWClSZT0RdpBU8OcMEWmHv1AUi37u
         8FkvW/6ptz982NRyd2Dg8OTXOUHUN4UP4uo1xNtXv3engBwLG9LGjZ74SzDIqmJOxbMQ
         eiQ9BihS57LiO6r+SKZABZQj+xBBh0RPqaDLRsrba1U1bMsRTEa9JZxxFoyv4c2fjoPz
         Ruf07DFKMgdibX3sxTO2q9+N2+5F7WZewfZw60uIVPdUxkUZpaX6trtBFGodzutXbvQB
         /D+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715605608; x=1716210408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrsGvge7X1e91Ca7nLsARXz/B6rasvGNzsoO0V6EifM=;
        b=OL+FyOImQ3DR9UnX3jmFH7psihYXPqsNn0ByJ7rBTUVmT/diBXPAsHS3stxqyf1sY2
         ojRiZkpZYu2EeweDMTjMjgPMQeLugjHx6jNIHLX/lsj1I+pI8QuuMESFuMzDi+FVWFkT
         qDp5kwq+J/tS0r1C4z+vSBIfaPQyYW+zq7REVMk1hoFgqct2vtZZh1ghHAyuDzH+C/Pr
         0JwP1hyZu+xYOum+iOWwiFJUM+NL3fCrewxQ7gvyL9v28jpPaIJvG842pFXc2gEEeDRz
         Kd+nVOYt4Ywnna1322FTOrvbwVmSWqk4yO8opYxmbwn1boGI9RuuEes8X1AfILbPbaOv
         JfMw==
X-Forwarded-Encrypted: i=1; AJvYcCW3ynBdGQX5Y9tl22m0RaJrsH2HTg9P1fjREVWM2JZx5tq28hmVh06VMAmw33VnKigp1/m4jy1gVX57ht7kOOHuCckM3Dje82V6lbQJ
X-Gm-Message-State: AOJu0Yzm4kGnfdh1ny9RomjrQxyY4GhphOt7NLneaWA/RMj5NCiyvyK4
	8eiV4eC+pUD5KkU6JgP+7bYz8HFz/ygru3/wIkkkSsBvWR9CSs+AZf68Eb1pUCMK4xWmnRc3Hmm
	hWfixuzyUjZyDvQo9tWGLF3mtHSZzDmL7meiCvw==
X-Google-Smtp-Source: AGHT+IGuxtHdquCf9OJVK2sboxMvXTHyJCiKMZ5sdO54V5h9DlxVbVMWK85LKsksksgojjn9eM9Fi/1qVdBzaK4KbX0=
X-Received: by 2002:a17:906:3398:b0:a59:a8a4:a5a7 with SMTP id
 a640c23a62f3a-a5a2d5c8be3mr718581566b.30.1715605608379; Mon, 13 May 2024
 06:06:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508113419.18620-1-alexghiti@rivosinc.com>
 <20240508113419.18620-2-alexghiti@rivosinc.com> <8aa0a606-f47c-4826-96ad-121ac1f7eb96@arm.com>
In-Reply-To: <8aa0a606-f47c-4826-96ad-121ac1f7eb96@arm.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Mon, 13 May 2024 15:06:37 +0200
Message-ID: <CAHVXubjTbDd6t5NxbvsLTMtHFDd0ZL2aJFPtcjJe=jZDtWjP6A@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 1/9] riscv: Restore the pfn in a NAPOT pte when
 manipulated by core mm code
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ryan,

On Fri, May 10, 2024 at 2:20=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 08/05/2024 12:34, Alexandre Ghiti wrote:
> > The core mm code expects to be able to extract the pfn from a pte. NAPO=
T
> > mappings work differently since its ptes actually point to the first pf=
n
> > of the mapping, the other bits being used to encode the size of the
> > mapping.
> >
> > So modify ptep_get() so that it returns a pte value that contains the
> > *real* pfn (which is then different from what the HW expects) and right
> > before storing the ptes to the page table, reset the pfn LSBs to the
> > size of the mapping.
>
> Did you consider leaving the pte as is and instead modifying your pte_pfn=
()
> implementation?
>
> For arm64 at least, it is beneficial to keep the pte marked as contiguous=
 when
> passing it up to core-mm because there are other helpers which need to pa=
rse the
> contiguous bit (e.g. pte_leaf_size()). If we were to clear the cont bit i=
n
> ptep_get() that info would be lost and perf_get_pgtable_size() would alwa=
ys
> conclude the leaf size is 4K even when it is actually 64K.

I don't clear the contpte bit here (ie the napot bit), I'm just
setting the right pfn so that the core-mm code knows exactly which
page is targeted by each pte of a contpte region (remember riscv napot
extension uses the lsb of the pte pfn to encode the size the mapping,
so all ptes of a contpte region will return the same pfn).

And from pte_pfn(), we have no way of knowing from the pte value alone
which page is targeted, we need to know its position in the page table
to "guess" the right pfn.

>
> >
> > And make sure that all NAPOT mappings are set using set_ptes().
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/pgtable-64.h |  11 +++
> >  arch/riscv/include/asm/pgtable.h    | 105 ++++++++++++++++++++++++++--
> >  arch/riscv/mm/hugetlbpage.c         |  38 +++++-----
> >  3 files changed, 128 insertions(+), 26 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/a=
sm/pgtable-64.h
> > index 221a5c1ee287..9fe076fc503e 100644
> > --- a/arch/riscv/include/asm/pgtable-64.h
> > +++ b/arch/riscv/include/asm/pgtable-64.h
> > @@ -106,6 +106,17 @@ enum napot_cont_order {
> >  #define napot_cont_mask(order)       (~(napot_cont_size(order) - 1UL))
> >  #define napot_pte_num(order) BIT(order)
> >
> > +static inline bool is_napot_order(unsigned int order)
> > +{
> > +     unsigned int napot_order;
> > +
> > +     for_each_napot_order(napot_order)
> > +             if (order =3D=3D napot_order)
> > +                     return true;
> > +
> > +     return false;
> > +}
> > +
> >  #ifdef CONFIG_RISCV_ISA_SVNAPOT
> >  #define HUGE_MAX_HSTATE              (2 + (NAPOT_ORDER_MAX - NAPOT_CON=
T_ORDER_BASE))
> >  #else
> > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/=
pgtable.h
> > index 9f8ea0e33eb1..268c828f5152 100644
> > --- a/arch/riscv/include/asm/pgtable.h
> > +++ b/arch/riscv/include/asm/pgtable.h
> > @@ -297,6 +297,8 @@ static inline unsigned long pte_napot(pte_t pte)
> >       return pte_val(pte) & _PAGE_NAPOT;
> >  }
> >
> > +#define pte_valid_napot(pte) (pte_present(pte) && pte_napot(pte))
> > +
> >  static inline pte_t pte_mknapot(pte_t pte, unsigned int order)
> >  {
> >       int pos =3D order - 1 + _PAGE_PFN_SHIFT;
> > @@ -306,6 +308,12 @@ static inline pte_t pte_mknapot(pte_t pte, unsigne=
d int order)
> >       return __pte((pte_val(pte) & napot_mask) | napot_bit | _PAGE_NAPO=
T);
> >  }
> >
> > +/* pte at entry must *not* encode the mapping size in the pfn LSBs. */
> > +static inline pte_t pte_clear_napot(pte_t pte)
> > +{
> > +     return __pte(pte_val(pte) & ~_PAGE_NAPOT);
> > +}
> > +
> >  #else
> >
> >  static __always_inline bool has_svnapot(void) { return false; }
> > @@ -315,17 +323,14 @@ static inline unsigned long pte_napot(pte_t pte)
> >       return 0;
> >  }
> >
> > +#define pte_valid_napot(pte) false
> > +
> >  #endif /* CONFIG_RISCV_ISA_SVNAPOT */
> >
> >  /* Yields the page frame number (PFN) of a page table entry */
> >  static inline unsigned long pte_pfn(pte_t pte)
> >  {
> > -     unsigned long res  =3D __page_val_to_pfn(pte_val(pte));
> > -
> > -     if (has_svnapot() && pte_napot(pte))
> > -             res =3D res & (res - 1UL);
> > -
> > -     return res;
> > +     return __page_val_to_pfn(pte_val(pte));
> >  }
> >
> >  #define pte_page(x)     pfn_to_page(pte_pfn(x))
> > @@ -525,9 +530,91 @@ static inline void __set_pte_at(struct mm_struct *=
mm, pte_t *ptep, pte_t pteval)
> >
> >  #define PFN_PTE_SHIFT                _PAGE_PFN_SHIFT
> >
> > +#ifdef CONFIG_RISCV_ISA_SVNAPOT
> > +static inline int arch_contpte_get_num_contig(pte_t *ptep, unsigned lo=
ng size,
> > +                                           size_t *pgsize)
> > +{
> > +     pte_t __pte;
> > +
> > +     /* We must read the raw value of the pte to get the size of the m=
apping */
> > +     __pte =3D READ_ONCE(*ptep);
> > +
> > +     if (pgsize) {
> > +             if (size >=3D PGDIR_SIZE)
> > +                     *pgsize =3D PGDIR_SIZE;
> > +             else if (size >=3D P4D_SIZE)
> > +                     *pgsize =3D P4D_SIZE;
> > +             else if (size >=3D PUD_SIZE)
> > +                     *pgsize =3D PUD_SIZE;
> > +             else if (size >=3D PMD_SIZE)
> > +                     *pgsize =3D PMD_SIZE;
> > +             else
> > +                     *pgsize =3D PAGE_SIZE;
> > +     }
> > +
> > +     /* Make sure __pte is not a swap entry */
> > +     if (pte_valid_napot(__pte))
> > +             return napot_pte_num(napot_cont_order(__pte));
> > +
> > +     return 1;
> > +}
> > +#endif
> > +
> > +static inline pte_t ptep_get(pte_t *ptep)
> > +{
> > +     pte_t pte =3D READ_ONCE(*ptep);
> > +
> > +#ifdef CONFIG_RISCV_ISA_SVNAPOT
> > +     /*
> > +      * The pte we load has the N bit set and the size of the mapping =
in
> > +      * the pfn LSBs: keep the N bit and replace the mapping size with
> > +      * the *real* pfn since the core mm code expects to find it there=
.
> > +      * The mapping size will be reset just before being written to th=
e
> > +      * page table in set_ptes().
> > +      */
> > +     if (unlikely(pte_valid_napot(pte))) {
> > +             unsigned int order =3D napot_cont_order(pte);
> > +             int pos =3D order - 1 + _PAGE_PFN_SHIFT;
> > +             unsigned long napot_mask =3D ~GENMASK(pos, _PAGE_PFN_SHIF=
T);
> > +             pte_t *orig_ptep =3D PTR_ALIGN_DOWN(ptep, sizeof(*ptep) *=
 napot_pte_num(order));
> > +
> > +             pte =3D __pte((pte_val(pte) & napot_mask) + ((ptep - orig=
_ptep) << _PAGE_PFN_SHIFT));
> > +     }
> > +#endif
> > +
> > +     return pte;
> > +}
> > +#define ptep_get     ptep_get
> > +
> >  static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
> >               pte_t *ptep, pte_t pteval, unsigned int nr)
> >  {
> > +#ifdef CONFIG_RISCV_ISA_SVNAPOT
> > +     if (unlikely(pte_valid_napot(pteval))) {
> > +             unsigned int order =3D ilog2(nr);
> > +
> > +             if (!is_napot_order(order)) {
> > +                     /*
> > +                      * Something's weird, we are given a NAPOT pte bu=
t the
> > +                      * size of the mapping is not a known NAPOT mappi=
ng
> > +                      * size, so clear the NAPOT bit and map this with=
out
> > +                      * NAPOT support: core mm only manipulates pte wi=
th the
> > +                      * real pfn so we know the pte is valid without t=
he N
> > +                      * bit.
> > +                      */
> > +                     pr_err("Incorrect NAPOT mapping, resetting.\n");
> > +                     pteval =3D pte_clear_napot(pteval);
> > +             } else {
> > +                     /*
> > +                      * NAPOT ptes that arrive here only have the N bi=
t set
> > +                      * and their pfn does not contain the mapping siz=
e, so
> > +                      * set that here.
> > +                      */
> > +                     pteval =3D pte_mknapot(pteval, order);
> > +             }
> > +     }
> > +#endif
>
> I think all this complexity comes along due to using this function both a=
s a
> public interface that the core-mm uses (which never sets napot)
> and also using
> it as an internal interface that riscv-hugetlb uses (which does set napot=
)? It
> might be more understandable if you layer it into a lower level/internal =
API and
> a higher level/public API (similar to arm64)?

I think you're right here, I'll try to do that too.

Thanks for your comments,

Alex

>
> > +
> >       page_table_check_ptes_set(mm, ptep, pteval, nr);
> >
> >       for (;;) {
> > @@ -535,6 +622,12 @@ static inline void set_ptes(struct mm_struct *mm, =
unsigned long addr,
> >               if (--nr =3D=3D 0)
> >                       break;
> >               ptep++;
> > +
> > +#ifdef CONFIG_RISCV_ISA_SVNAPOT
> > +             if (unlikely(pte_valid_napot(pteval)))
> > +                     continue;
> > +#endif
> > +
> >               pte_val(pteval) +=3D 1 << _PAGE_PFN_SHIFT;
> >       }
> >  }
> > diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
> > index 5ef2a6891158..fe8067ee71b4 100644
> > --- a/arch/riscv/mm/hugetlbpage.c
> > +++ b/arch/riscv/mm/hugetlbpage.c
> > @@ -256,8 +256,7 @@ void set_huge_pte_at(struct mm_struct *mm,
> >
> >       clear_flush(mm, addr, ptep, pgsize, pte_num);
> >
> > -     for (i =3D 0; i < pte_num; i++, ptep++, addr +=3D pgsize)
> > -             set_pte_at(mm, addr, ptep, pte);
> > +     set_ptes(mm, addr, ptep, pte, pte_num);
> >  }
> >
> >  int huge_ptep_set_access_flags(struct vm_area_struct *vma,
> > @@ -267,16 +266,16 @@ int huge_ptep_set_access_flags(struct vm_area_str=
uct *vma,
> >                              int dirty)
> >  {
> >       struct mm_struct *mm =3D vma->vm_mm;
> > -     unsigned long order;
> > +     size_t pgsize;
> >       pte_t orig_pte;
> > -     int i, pte_num;
> > +     int pte_num;
> >
> >       if (!pte_napot(pte))
> >               return ptep_set_access_flags(vma, addr, ptep, pte, dirty)=
;
> >
> > -     order =3D napot_cont_order(pte);
> > -     pte_num =3D napot_pte_num(order);
> > -     ptep =3D huge_pte_offset(mm, addr, napot_cont_size(order));
> > +     pte_num =3D arch_contpte_get_num_contig(ptep, 0, &pgsize);
> > +     ptep =3D huge_pte_offset(mm, addr, pte_num * pgsize);
> > +
> >       orig_pte =3D get_clear_contig_flush(mm, addr, ptep, pte_num);
> >
> >       if (pte_dirty(orig_pte))
> > @@ -285,8 +284,7 @@ int huge_ptep_set_access_flags(struct vm_area_struc=
t *vma,
> >       if (pte_young(orig_pte))
> >               pte =3D pte_mkyoung(pte);
> >
> > -     for (i =3D 0; i < pte_num; i++, addr +=3D PAGE_SIZE, ptep++)
> > -             set_pte_at(mm, addr, ptep, pte);
> > +     set_ptes(mm, addr, ptep, pte, pte_num);
> >
> >       return true;
> >  }
> > @@ -301,7 +299,7 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
> >       if (!pte_napot(orig_pte))
> >               return ptep_get_and_clear(mm, addr, ptep);
> >
> > -     pte_num =3D napot_pte_num(napot_cont_order(orig_pte));
> > +     pte_num =3D arch_contpte_get_num_contig(ptep, 0, NULL);
> >
> >       return get_clear_contig(mm, addr, ptep, pte_num);
> >  }
> > @@ -311,24 +309,23 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm=
,
> >                            pte_t *ptep)
> >  {
> >       pte_t pte =3D ptep_get(ptep);
> > -     unsigned long order;
> > +     size_t pgsize;
> >       pte_t orig_pte;
> > -     int i, pte_num;
> > +     int pte_num;
> >
> >       if (!pte_napot(pte)) {
> >               ptep_set_wrprotect(mm, addr, ptep);
> >               return;
> >       }
> >
> > -     order =3D napot_cont_order(pte);
> > -     pte_num =3D napot_pte_num(order);
> > -     ptep =3D huge_pte_offset(mm, addr, napot_cont_size(order));
> > +     pte_num =3D arch_contpte_get_num_contig(ptep, 0, &pgsize);
> > +     ptep =3D huge_pte_offset(mm, addr, pte_num * pgsize);
> > +
> >       orig_pte =3D get_clear_contig_flush(mm, addr, ptep, pte_num);
> >
> >       orig_pte =3D pte_wrprotect(orig_pte);
> >
> > -     for (i =3D 0; i < pte_num; i++, addr +=3D PAGE_SIZE, ptep++)
> > -             set_pte_at(mm, addr, ptep, orig_pte);
> > +     set_ptes(mm, addr, ptep, orig_pte, pte_num);
> >  }
> >
> >  pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
> > @@ -341,7 +338,7 @@ pte_t huge_ptep_clear_flush(struct vm_area_struct *=
vma,
> >       if (!pte_napot(pte))
> >               return ptep_clear_flush(vma, addr, ptep);
> >
> > -     pte_num =3D napot_pte_num(napot_cont_order(pte));
> > +     pte_num =3D arch_contpte_get_num_contig(ptep, 0, NULL);
> >
> >       return get_clear_contig_flush(vma->vm_mm, addr, ptep, pte_num);
> >  }
> > @@ -351,6 +348,7 @@ void huge_pte_clear(struct mm_struct *mm,
> >                   pte_t *ptep,
> >                   unsigned long sz)
> >  {
> > +     size_t pgsize;
> >       pte_t pte =3D ptep_get(ptep);
> >       int i, pte_num;
> >
> > @@ -359,8 +357,8 @@ void huge_pte_clear(struct mm_struct *mm,
> >               return;
> >       }
> >
> > -     pte_num =3D napot_pte_num(napot_cont_order(pte));
> > -     for (i =3D 0; i < pte_num; i++, addr +=3D PAGE_SIZE, ptep++)
> > +     pte_num =3D arch_contpte_get_num_contig(ptep, 0, &pgsize);
> > +     for (i =3D 0; i < pte_num; i++, addr +=3D pgsize, ptep++)
> >               pte_clear(mm, addr, ptep);
> >  }
> >
>

