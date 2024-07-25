Return-Path: <linux-kernel+bounces-262532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BF593C85B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 20:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3FE31C21634
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 18:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763AE446D2;
	Thu, 25 Jul 2024 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L/SAGDK9"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB5A6FB8
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 18:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721932229; cv=none; b=nzwyTsgi0pVBl6JjLlJ72PKNUGuyCOWUsXaDjwbILnTz6+j4U529ZP/cjcSMi8S3K68pKrZdriBp277iWxHq2k6ugA1LEz6FtNXjXRJbpkdLFo7NrK9LOccAj8hMz47OPudUHOO00WpFMs8S3qcqe9tU55zDdahqzbUPTOF296c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721932229; c=relaxed/simple;
	bh=nDwVJe/zZV7N4CBClefxWyRIxPq9UvINF0V29eWhOG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GWBAj8gPJ0oURZBNqp1AyEEGF2mMpBh5g8kGPjz5QHuXr3EoFL9/vWo3Emh0KHNl7s3OZNQqmzhSygWFzJY21jF2cWJD6TdZE8dxf/20jch7XHF9DYUgSkqpjw2DQMuK2HbUmNfrNYb8DTj8Wmn8yeH5Jb6AOi6O8MCSXeFMHHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L/SAGDK9; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-44fdc70e695so64201cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 11:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721932226; x=1722537026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWboNGe0GPmGnnKlHALD1mYzZCC9gIR6IarJsn1e87E=;
        b=L/SAGDK9Pkc6j7fJObIjbe0lmHEQxf3GlT5JQV5yfeafOuToUC0UBFcJjyDMqQjpWy
         QHJTZ7Z34sh6nn/sVaGDDoi1+d3fJDs/aIhOfCugVeLc7eABjQExvOsdLFhROIC+gYcb
         Tv9EUAffG7+S1xYZc0YQiCLpFVi8B+wFG7EKoj2nx50Qf7jqYirKsmIE7tdPmMKNoH5E
         wtz+2UVjYuoNq5V9lSLQnHIC0J4Jwk5seQu2vJlBqM8C+oeqKxbUGZGeIc558UxIenQv
         Xdu/dLhtq4jc/vHehI5dh8v1JSJvJS+DPz/htozIQdD5sr03zCN/da8kRJ6t2ZhjcIlV
         +Bvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721932226; x=1722537026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWboNGe0GPmGnnKlHALD1mYzZCC9gIR6IarJsn1e87E=;
        b=TMMw2KXNVKbd7yT9WQ7/UjQ0WY0mu/0RdvSe9GSBIbwbPacYX42VRchTcDx5dbxe2h
         zVfkbnDTeXVgHO4Gb6GIH+SjOh1nc7QCIZA57S1B30iqsoXCewIg7wjpUCtRt3oyVoYr
         9e+gMZpM4wQw+ahihblm7qd4NQsf19Pivci4KYBY9av9uFP3wEKjhg+rkXydUXcXPaMx
         HEgNFw5CRgBG85/pMMPwxPQeVs+TIRll63Tr8fAlCfCH54vZc/TmkM9SsuiIeyWfB1Mw
         gsF+ljqYUWfYB8QIrKXOGLm8tjkGekTNp7fZkspgadeZS9LU5s1JDiXbPfc5fDKb7jBF
         NTMw==
X-Forwarded-Encrypted: i=1; AJvYcCVsz0MBBQNcssndGmwPF1+u5xwF5we6AtKySr/zLYE+F38ev7hIbATyxi2WysbX0i+EufBseYZpiZt7RxrKDI2603f7vTm7Va4FwgGk
X-Gm-Message-State: AOJu0YwId3GhYRJHq7/xsTKYRUK0gIiHxbVR2ZnrQ1MASlzgufaCbM/D
	8yztZiS1WFGVQEezgh0NLQjP891IrHDWGwAy2bwxxA5cGD3kTFm+6e53jbvDrCapBCNICwvou64
	MPffdlBQ7EzXaUw6DjPjxWyH1Bz14beTAmWJ6
X-Google-Smtp-Source: AGHT+IHUiu7SrV4KAMaecRgK6Yn782IOcgfOtXEKWfR6swvHfNxKq8fdmGpFKpWLG5VKNwjKbn/vDRD/q9Rcer887Uo=
X-Received: by 2002:a05:622a:11ca:b0:447:d81a:9320 with SMTP id
 d75a77b69052e-44ff3b37eacmr268571cf.20.1721932225993; Thu, 25 Jul 2024
 11:30:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715192142.3241557-1-peterx@redhat.com> <20240715192142.3241557-9-peterx@redhat.com>
In-Reply-To: <20240715192142.3241557-9-peterx@redhat.com>
From: James Houghton <jthoughton@google.com>
Date: Thu, 25 Jul 2024 11:29:49 -0700
Message-ID: <CADrL8HVH8ff+_Szrmn4ZCyAkm9gDc2oY4VVo3r+6RN_ms6pbhw@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] mm/mprotect: fix dax pud handlings
To: Peter Xu <peterx@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Dave Jiang <dave.jiang@intel.com>, Rik van Riel <riel@surriel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	linuxppc-dev@lists.ozlabs.org, Matthew Wilcox <willy@infradead.org>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, Oscar Salvador <osalvador@suse.de>, 
	Mel Gorman <mgorman@techsingularity.net>, Andrew Morton <akpm@linux-foundation.org>, 
	Borislav Petkov <bp@alien8.de>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Huang Ying <ying.huang@intel.com>, "Kirill A . Shutemov" <kirill@shutemov.name>, 
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Hugh Dickins <hughd@google.com>, x86@kernel.org, 
	Nicholas Piggin <npiggin@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 12:22=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote=
:
>
> This is only relevant to the two archs that support PUD dax, aka, x86_64
> and ppc64.  PUD THPs do not yet exist elsewhere, and hugetlb PUDs do not
> count in this case.
>
> DAX have had PUD mappings for years, but change protection path never
> worked.  When the path is triggered in any form (a simple test program
> would be: call mprotect() on a 1G dev_dax mapping), the kernel will repor=
t
> "bad pud".  This patch should fix that.
>
> The new change_huge_pud() tries to keep everything simple.  For example, =
it
> doesn't optimize write bit as that will need even more PUD helpers.  It's
> not too bad anyway to have one more write fault in the worst case once fo=
r
> 1G range; may be a bigger thing for each PAGE_SIZE, though.  Neither does
> it support userfault-wp bits, as there isn't such PUD mappings that is
> supported; file mappings always need a split there.
>
> The same to TLB shootdown: the pmd path (which was for x86 only) has the
> trick of using _ad() version of pmdp_invalidate*() which can avoid one
> redundant TLB, but let's also leave that for later.  Again, the larger th=
e
> mapping, the smaller of such effect.
>
> Another thing worth mention is this path needs to be careful on handling
> "retry" event for change_huge_pud() (where it can return 0): it isn't lik=
e
> change_huge_pmd(), as the pmd version is safe with all conditions handled
> in change_pte_range() later, thanks to Hugh's new pte_offset_map_lock().
> In short, change_pte_range() is simply smarter than change_pmd_range() no=
w
> after the shmem thp collapse rework.  For that reason, change_pud_range()
> will need proper retry if it races with something else when a huge PUD
> changed from under us.
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Kirill A. Shutemov <kirill@shutemov.name>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: x86@kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Fixes: a00cc7d9dd93 ("mm, x86: add support for PUD-sized transparent huge=
pages")
> Fixes: 27af67f35631 ("powerpc/book3s64/mm: enable transparent pud hugepag=
e")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/linux/huge_mm.h | 24 +++++++++++++++++++
>  mm/huge_memory.c        | 52 +++++++++++++++++++++++++++++++++++++++++
>  mm/mprotect.c           | 34 ++++++++++++++++++++++-----
>  3 files changed, 104 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index cff002be83eb..6e742680590a 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -336,6 +336,17 @@ void split_huge_pmd_address(struct vm_area_struct *v=
ma, unsigned long address,
>  void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
>                 unsigned long address);
>
> +#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> +int change_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
> +                   pud_t *pudp, unsigned long addr, pgprot_t newprot,
> +                   unsigned long cp_flags);
> +#else
> +static inline int
> +change_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
> +               pud_t *pudp, unsigned long addr, pgprot_t newprot,
> +               unsigned long cp_flags) { return 0; }
> +#endif
> +
>  #define split_huge_pud(__vma, __pud, __address)                         =
       \
>         do {                                                            \
>                 pud_t *____pud =3D (__pud);                              =
 \
> @@ -579,6 +590,19 @@ static inline int next_order(unsigned long *orders, =
int prev)
>  {
>         return 0;
>  }
> +
> +static inline void __split_huge_pud(struct vm_area_struct *vma, pud_t *p=
ud,
> +                                   unsigned long address)
> +{
> +}
> +
> +static inline int change_huge_pud(struct mmu_gather *tlb,
> +                                 struct vm_area_struct *vma, pud_t *pudp=
,
> +                                 unsigned long addr, pgprot_t newprot,
> +                                 unsigned long cp_flags)
> +{
> +       return 0;
> +}
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>
>  static inline int split_folio_to_list_to_order(struct folio *folio,
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index c10247bef08a..9a00c5955c0c 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2112,6 +2112,53 @@ int change_huge_pmd(struct mmu_gather *tlb, struct=
 vm_area_struct *vma,
>         return ret;
>  }
>
> +/*
> + * Returns:
> + *
> + * - 0: if pud leaf changed from under us
> + * - 1: if pud can be skipped
> + * - HPAGE_PUD_NR: if pud was successfully processed
> + */
> +#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> +int change_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
> +                   pud_t *pudp, unsigned long addr, pgprot_t newprot,
> +                   unsigned long cp_flags)
> +{
> +       struct mm_struct *mm =3D vma->vm_mm;
> +       pud_t oldpud, entry;
> +       spinlock_t *ptl;
> +
> +       tlb_change_page_size(tlb, HPAGE_PUD_SIZE);
> +
> +       /* NUMA balancing doesn't apply to dax */
> +       if (cp_flags & MM_CP_PROT_NUMA)
> +               return 1;
> +
> +       /*
> +        * Huge entries on userfault-wp only works with anonymous, while =
we
> +        * don't have anonymous PUDs yet.
> +        */
> +       if (WARN_ON_ONCE(cp_flags & MM_CP_UFFD_WP_ALL))
> +               return 1;
> +
> +       ptl =3D __pud_trans_huge_lock(pudp, vma);
> +       if (!ptl)
> +               return 0;
> +
> +       /*
> +        * Can't clear PUD or it can race with concurrent zapping.  See
> +        * change_huge_pmd().
> +        */
> +       oldpud =3D pudp_invalidate(vma, addr, pudp);
> +       entry =3D pud_modify(oldpud, newprot);
> +       set_pud_at(mm, addr, pudp, entry);
> +       tlb_flush_pud_range(tlb, addr, HPAGE_PUD_SIZE);
> +
> +       spin_unlock(ptl);
> +       return HPAGE_PUD_NR;
> +}
> +#endif
> +
>  #ifdef CONFIG_USERFAULTFD
>  /*
>   * The PT lock for src_pmd and dst_vma/src_vma (for reading) are locked =
by
> @@ -2342,6 +2389,11 @@ void __split_huge_pud(struct vm_area_struct *vma, =
pud_t *pud,
>         spin_unlock(ptl);
>         mmu_notifier_invalidate_range_end(&range);
>  }
> +#else
> +void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
> +               unsigned long address)
> +{
> +}
>  #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
>
>  static void __split_huge_zero_page_pmd(struct vm_area_struct *vma,
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 2a81060b603d..694f13b83864 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -425,31 +425,53 @@ static inline long change_pud_range(struct mmu_gath=
er *tlb,
>                 unsigned long end, pgprot_t newprot, unsigned long cp_fla=
gs)
>  {
>         struct mmu_notifier_range range;
> -       pud_t *pud;
> +       pud_t *pudp, pud;
>         unsigned long next;
>         long pages =3D 0, ret;
>
>         range.start =3D 0;
>
> -       pud =3D pud_offset(p4d, addr);
> +       pudp =3D pud_offset(p4d, addr);
>         do {
> +again:
>                 next =3D pud_addr_end(addr, end);
> -               ret =3D change_prepare(vma, pud, pmd, addr, cp_flags);
> +               ret =3D change_prepare(vma, pudp, pmd, addr, cp_flags);
>                 if (ret) {
>                         pages =3D ret;
>                         break;
>                 }
> -               if (pud_none_or_clear_bad(pud))
> +
> +               pud =3D READ_ONCE(*pudp);
> +               if (pud_none(pud))
>                         continue;
> +
>                 if (!range.start) {
>                         mmu_notifier_range_init(&range,
>                                                 MMU_NOTIFY_PROTECTION_VMA=
, 0,
>                                                 vma->vm_mm, addr, end);
>                         mmu_notifier_invalidate_range_start(&range);
>                 }
> -               pages +=3D change_pmd_range(tlb, vma, pud, addr, next, ne=
wprot,
> +
> +               if (pud_leaf(pud)) {
> +                       if ((next - addr !=3D PUD_SIZE) ||
> +                           pgtable_split_needed(vma, cp_flags)) {
> +                               __split_huge_pud(vma, pudp, addr);
> +                               goto again;

IIUC, most of the time, we're just going to end up clearing the PUD in
this case. __split_huge_pud() will just clear it, then we goto again
and `continue` to the next pudp. Is that ok?

(I think it's ok as long as: you never map an anonymous page with a
PUD, and that uffd-wp is not usable with non-hugetlb PUD mappings of
user memory (which I think is only DAX?). So it seems ok today...?)

Also, does the comment in pgtable_split_needed() need updating?

Somewhat related question: change_huge_pmd() is very careful not to
clear the PMD before writing the new value. Yet change_pmd_range(),
when it calls into __split_huge_pmd(), will totally clear the PMD and
then populate the PTEs underneath (in some cases at least), seemingly
reintroducing the MADV_DONTNEED concern. But your PUD version, because
it never re-populates the PUD (or PMDs/PTEs underneath) does not have
this issue. WDYT?

Thanks for this series!

> +                       } else {
> +                               ret =3D change_huge_pud(tlb, vma, pudp,
> +                                                     addr, newprot, cp_f=
lags);
> +                               if (ret =3D=3D 0)
> +                                       goto again;
> +                               /* huge pud was handled */
> +                               if (ret =3D=3D HPAGE_PUD_NR)
> +                                       pages +=3D HPAGE_PUD_NR;
> +                               continue;
> +                       }
> +               }
> +
> +               pages +=3D change_pmd_range(tlb, vma, pudp, addr, next, n=
ewprot,
>                                           cp_flags);
> -       } while (pud++, addr =3D next, addr !=3D end);
> +       } while (pudp++, addr =3D next, addr !=3D end);
>
>         if (range.start)
>                 mmu_notifier_invalidate_range_end(&range);
> --
> 2.45.0
>
>

