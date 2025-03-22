Return-Path: <linux-kernel+bounces-572115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0553CA6C6A1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 01:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75FCB1B606A1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 00:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04D22E3395;
	Sat, 22 Mar 2025 00:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xSRjSJ/9"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF933FFD
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 00:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742602521; cv=none; b=SRuIKgcOLJiFuAPpp/l0jKP5GRpCccyPDVMLeXEo7qc9r3A3j6GRWORUtis+iQfiIsfATTU1FjOqbA63RMsI0UB+kiCNHnSGOztRNw0F9Oiqv0pPNjnVxSPs7OKa/jss/7d3G8prG+0Np6UTBFV0EpLt170pv1gxgH7cFaMA9j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742602521; c=relaxed/simple;
	bh=vHifveKPxTuIVE+EhhccTV+UCo3fiTyQYWIuARhoxVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LrPJFn6zxujmne6PdjZlymX/AFJYqLN/RQCIi6lvXn7+qNX3+zINvbfSRRs8qWd2dXoY4SauRTybpFW7+/Mk/d6QZDifbkcbMLy0pNoF+MLGYFF46XO1f6jcRx+Tn8irNx23VUmWfw7sOy46RJCN9f+oU6eV8wQzei+HNyfNcB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xSRjSJ/9; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5dbfc122b82so3887a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 17:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742602516; x=1743207316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWPajkWJogqaXmp1Upnq/GPA8oCmJY5/NKgNJh+xUr4=;
        b=xSRjSJ/9alykskALKNYQtzilUnRdjbVx+t58xsqY5WO532PNCEArWCaXch9stbidL7
         G3vWoPAY+6sOQkQmxR7pfWZZe9iz8PimZxI2jP6opLlXIfrhP6AZy/1efrKnAlHMjJ0c
         fWyeCFI8Xn/ONGgcDu1fqNSsWI0yEG8gShBGo3m1ZPXNpGpyKS8wbXhuXsHQKUqvUKFD
         b+LfEboTq0C0pR0YhujppNS2+ZYL8PsWYhPlEC2zhhdCLldrGkkL5OqEut4NRREIUE39
         Xf9HnXLHEF2ylcjJ4fMmX9qQN65LEeb50w2Ko5VwR/aPtZX99vsG5GFq9aJ9pt4nEYhi
         rEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742602516; x=1743207316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NWPajkWJogqaXmp1Upnq/GPA8oCmJY5/NKgNJh+xUr4=;
        b=ZrAMWQcH25nhVy54UzSUWKyivSs2bgSWRLtUBSmldWbj5XMmz0gXXBTuo1SqtEmcf2
         VTU11XNL44899LHO1cQfLZF47sPd8tGXCZSvqdWoQciIdLA+T1wEfwS8EDzfk32c2WZu
         4EnxXcxkWlGVg7kGxzhjtUfTQnp8BgOsG2WgloikxHhs+s/I6JBVPzlo7cH/9yB+ly+Y
         VasU7ZbYoRgYkeVHdY06QyUJo1Xuaawk9S3sg+SflU4GRJNNL+WD5xvh5tshF8Epc4NA
         DUzG+EBBzRwZ+/3QsL/qudisChb6visrrX315EDEw7wTeVWEfBgMDO9uEe4giHIU4FqQ
         KPXA==
X-Forwarded-Encrypted: i=1; AJvYcCUeX7JUSfy70/RYpQSVVsG20XaUformHK3rwm11PBinZupLtfu3zpkaNV3JdXc7frg0F5Xx13D8DPQV6YI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXSkjRqphO9MUyEjWHxNa8V48KoHkO4S/SrQq2TQPrZAtY5vHI
	IEKbtOIp3sE+eZPk/+rOmInFAc9WikLHAc0vgRvHWYloPSvjAZFvxCLyJ3jLfcCq+5I38htufsb
	gzzmR8FrJlGPDFQ+Q7MbfpvLObrzc/AaiiIWl
X-Gm-Gg: ASbGncvt6KyDal2U42YP6iVvtTUZ6hiHrZ75rWww+V9md5HO6bYnCutyJj8OxuAyHPu
	XArrfioGy/3b6mwQ3br9NML0gcwnzxcpZ9e2d2mJ3EXEHHJPjPUtC9zNym0tJSrd0nCSJMG2cPq
	g23YnTenZmjTkRln2SYG96Vsu6Vvi3WsE6Hv/HG5a1AzdEZkBMEL1ouw==
X-Google-Smtp-Source: AGHT+IGcz6wA92jIM6hDanJsFde5LK802tMMyxQp8td2vt7vZbhUFuPwX/oatoRkWVXGG/+m4MkOSX70/7J9MWyO1zw=
X-Received: by 2002:aa7:d806:0:b0:5e4:afad:9a83 with SMTP id
 4fb4d7f45d1cf-5ec1d9c7e3bmr44923a12.2.1742602515733; Fri, 21 Mar 2025
 17:15:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1742478846.git.lorenzo.stoakes@oracle.com> <d10037699391c42a4943f578c2a0bca890640f30.1742478846.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <d10037699391c42a4943f578c2a0bca890640f30.1742478846.git.lorenzo.stoakes@oracle.com>
From: Jann Horn <jannh@google.com>
Date: Sat, 22 Mar 2025 01:14:39 +0100
X-Gm-Features: AQ5f1JotPQaRDY7T-kyb-A1coQmRsTtQyKGAYHVNXCMhmbARXCP-4LzrfE3v-Jc
Message-ID: <CAG48ez3CiRTUv4Qwy_UQzQuEDtUoPVVXnuPyiWoAhWVqkF3VTA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] mm/mremap: introduce more mergeable mremap via MREMAP_RELOCATE_ANON
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 10:54=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 0865387531ed..bb67562a0114 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
[...]
> +/*
> + * If the folio mapped at the specified pte entry can have its index and=
 mapping
> + * relocated, then do so.
> + *
> + * Returns the number of pages we have traversed, or 0 if the operation =
failed.
> + */
> +static unsigned long relocate_anon(struct pagetable_move_control *pmc,
> +               unsigned long old_addr, unsigned long new_addr, pte_t pte=
,
> +               bool undo)
> +{
> +       struct page *page;
> +       struct folio *folio;
> +       struct vm_area_struct *old, *new;
> +       pgoff_t new_index;
> +       unsigned long ret =3D 1;
> +
> +       old =3D pmc->old;
> +       new =3D pmc->new;
> +
> +       /* Ensure we have truly got an anon folio. */
> +       page =3D vm_normal_page(old, old_addr, pte);
> +       if (!page)
> +               return ret;
> +       folio =3D page_folio(page);
> +       folio_lock(folio);
> +
> +       /* no-op. */
> +       if (!folio_test_anon(folio) || folio_test_ksm(folio))
> +               goto out;
> +
> +       /*
> +        * This should not happen as we explicitly disallow this, but che=
ck
> +        * anyway.
> +        */
> +       if (folio_test_large(folio)) {
> +               ret =3D 0;
> +               goto out;
> +       }

Do I understand correctly that you assume here that the page is
exclusively mapped? Maybe we could at least
WARN_ON(folio_mapcount(folio) !=3D 1) or something like that?

(I was also wondering if the PageAnonExclusive bit is somehow
relevant, but we should probably not look at or touch that here,
unless we want to think about cases where we _used to_ have a child
from which the page may have been GUP'd...)

> +       if (!undo)
> +               new_index =3D linear_page_index(new, new_addr);
> +       else
> +               new_index =3D linear_page_index(old, old_addr);
> +
> +       /*
> +        * The PTL should keep us safe from unmapping, and the fact the f=
olio is
> +        * a PTE keeps the folio referenced.
> +        *
> +        * The mmap/VMA locks should keep us safe from fork and other pro=
cesses.
> +        *
> +        * The rmap locks should keep us safe from anything happening to =
the
> +        * VMA/anon_vma.

"The rmap locks"? I only see that we're holding the rmap lock on the
new anon_vma; are we also holding a lock on the old anon_vma?

> +        * The folio lock should keep us safe from reclaim, migration, et=
c.
> +        */
> +       folio_move_anon_rmap(folio, undo ? old : new);
> +       WRITE_ONCE(folio->index, new_index);
> +
> +out:
> +       folio_unlock(folio);
> +       return ret;
> +}
[...]
> +static bool relocate_anon_ptes(struct pagetable_move_control *pmc,
> +               unsigned long extent, pmd_t *pmd, bool undo)
> +{
> +       struct mm_struct *mm =3D current->mm;
> +       struct pte_state state =3D {
> +               .old_addr =3D pmc->old_addr,
> +               .new_addr =3D pmc->new_addr,
> +               .old_end =3D pmc->old_addr + extent,
> +       };
> +       spinlock_t *ptl;
> +       pte_t *ptep_start;
> +       bool ret;
> +       unsigned long nr_pages;
> +
> +       ptep_start =3D pte_offset_map_lock(mm, pmd, pmc->old_addr, &ptl);
> +       /*
> +        * We prevent faults with mmap write lock, hold the rmap lock and=
 should
> +        * not fail to obtain this lock. Just give up if we can't.
> +        */
> +       if (!ptep_start)
> +               return false;
> +
> +       state.ptep =3D ptep_start;
> +
> +       for (; !pte_done(&state); pte_next(&state, nr_pages)) {
> +               pte_t pte =3D ptep_get(state.ptep);
> +
> +               if (pte_none(pte) || !pte_present(pte)) {
> +                       nr_pages =3D 1;
> +                       continue;
> +               }
> +
> +               nr_pages =3D relocate_anon(pmc, state.old_addr, state.new=
_addr, pte, undo);
> +               if (!nr_pages) {
> +                       ret =3D false;
> +                       goto out;
> +               }
> +       }
> +
> +       ret =3D true;
> +out:
> +       pte_unmap_unlock(ptep_start, ptl);
> +       return ret;
> +}

Just to make sure I understand correctly:
This function is changing the ->pgoff and ->mapping of pages while
they are still mapped in the old VMA, right? And if that fails midway
through for whatever reason, we go and change all the already-changed
->pgoff and ->mapping values back?

[...]
> @@ -1132,6 +1347,42 @@ static void unmap_source_vma(struct vma_remap_stru=
ct *vrm)
>         }
>  }
>
> +/*
> + * Should we attempt to relocate anonymous folios to the location that t=
he VMA
> + * is being moved to by updating index and mapping fields accordingly?
> + */
> +static bool should_relocate_anon(struct vma_remap_struct *vrm,
> +       struct pagetable_move_control *pmc)
> +{
> +       struct vm_area_struct *old =3D vrm->vma;
> +
> +       /* Currently we only do this if requested. */
> +       if (!(vrm->flags & MREMAP_RELOCATE_ANON))
> +               return false;
> +
> +       /* We can't deal with special or hugetlb mappings. */
> +       if (old->vm_flags & (VM_SPECIAL | VM_HUGETLB))
> +               return false;
> +
> +       /* We only support anonymous mappings. */
> +       if (!vma_is_anonymous(old))
> +               return false;
> +
> +       /* If no folios are mapped, then no need to attempt this. */
> +       if (!old->anon_vma)
> +               return false;
> +
> +       /*
> +        * If the old VMA is a child (i.e. has been forked), then the ind=
ex
> +        * references multiple VMAs, we have to bail.
> +        */
> +       if (!list_is_singular(&old->anon_vma_chain))
> +               return false;

I think this is wrong: list_is_singular(&old->anon_vma_chain) tells
you whether pages in the VMA might be shared due to this mm_struct
being forked from a parent mm_struct; but it won't tell you whether
pages in the VMA might be shared due to this mm_struct being the
parent of another mm_struct (other way around). I guess checking
old->anon_vma->root->num_children could maybe work...

> +
> +       /* Otherwise, we're good to go! */
> +       return true;
> +}
> +
>  /*
>   * Copy vrm->vma over to vrm->new_addr possibly adjusting size as part o=
f the
>   * process. Additionally handle an error occurring on moving of page tab=
les,
> @@ -1151,9 +1402,11 @@ static int copy_vma_and_data(struct vma_remap_stru=
ct *vrm,
>         struct vm_area_struct *new_vma;
>         int err =3D 0;
>         PAGETABLE_MOVE(pmc, NULL, NULL, vrm->addr, vrm->new_addr, vrm->ol=
d_len);
> +       bool relocate_anon =3D should_relocate_anon(vrm, &pmc);
>
> +again:
>         new_vma =3D copy_vma(&vma, vrm->new_addr, vrm->new_len, new_pgoff=
,
> -                          &pmc.need_rmap_locks);
> +                          &pmc.need_rmap_locks, &relocate_anon);
>         if (!new_vma) {
>                 vrm_uncharge(vrm);
>                 *new_vma_ptr =3D NULL;
> @@ -1163,12 +1416,66 @@ static int copy_vma_and_data(struct vma_remap_str=
uct *vrm,
>         pmc.old =3D vma;
>         pmc.new =3D new_vma;
>
> +       if (relocate_anon) {
> +               /*
> +                * We have a new VMA to reassign folios to. We take a loc=
k on
> +                * its anon_vma so reclaim doesn't fail to unmap mappings=
.
> +                *
> +                * We have acquired a VMA write lock by now (in vma_link(=
)), so
> +                * we do not have to worry about racing faults.
> +                */
> +               anon_vma_lock_write(new_vma->anon_vma);
> +               pmc.relocate_locked =3D new_vma;
> +
> +               if (!relocate_anon_folios(&pmc, /* undo=3D */false)) {
> +                       unsigned long start =3D new_vma->vm_start;
> +                       unsigned long size =3D new_vma->vm_end - start;
> +
> +                       /* Undo if fails. */
> +                       relocate_anon_folios(&pmc, /* undo=3D */true);

This relocate_anon_folios() has to make sure to only operate on the
subset of PTEs that we already edited successfully, right?

> +                       vrm_stat_account(vrm, vrm->new_len);
> +
> +                       anon_vma_unlock_write(new_vma->anon_vma);
> +                       pmc.relocate_locked =3D NULL;
> +
> +                       do_munmap(current->mm, start, size, NULL);
> +                       relocate_anon =3D false;
> +                       goto again;
> +               }
> +       }
[...]
> diff --git a/mm/vma.c b/mm/vma.c
> index 5418eef3a852..09027448753f 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
[...]
> @@ -1821,6 +1834,14 @@ struct vm_area_struct *copy_vma(struct vm_area_str=
uct **vmap,
>                         new_vma->vm_ops->open(new_vma);
>                 if (vma_link(mm, new_vma))
>                         goto out_vma_link;
> +               /*
> +                * If we're attempting to relocate anonymous VMAs, we
> +                * don't want to reuse an anon_vma as set by
> +                * vm_area_dup(), or copy anon_vma_chain or anything
> +                * like this.
> +                */
> +               if (*relocate_anon && __anon_vma_prepare(new_vma))
> +                       goto out_vma_link;

Is this bailout really okay? We go to the same label as if vma_link()
failed, but we're in a very different state: For example, the VMA has
already been inserted into the VMA tree with vma_iter_store() as part
of vma_link() (unless that changed in one of the prerequisite
patches).

>                 *need_rmap_locks =3D false;
>         }
>         return new_vma;

