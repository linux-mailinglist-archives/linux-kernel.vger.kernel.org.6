Return-Path: <linux-kernel+bounces-169856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 692078BCEA1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CA701C23C10
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EAC4EB4C;
	Mon,  6 May 2024 12:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SO/AQUV2"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117A11C6B9
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 12:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715000314; cv=none; b=ojt5aRsrx3PcqZOqrFFnWwDTpucR47hd518gKxIcPmlF2ApWYbx7M17XhKU6SI1vQikRI2c7ExSTifkV4bA8G80JSCtz0d8XvuxrmWT/z+B4+8Lkraea4nNngmHnSaUBca8baM82lQPSNDb4VG9gbip2bL0roMw3tr0BdDIztJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715000314; c=relaxed/simple;
	bh=eJW2vIqh8FG4ctdH9YApKoKeSHZU1IamqD29LPhme40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d8CpWg76lycbPE4YNY9Uogu2JNF9Gc5ZQrda0usqTbBoJof+GiW73vnl/rI142ke7MOgeqsUDW2EupJ24QBzaFgdnvxN/KGMFEGHvVCnj28piwnbFekxmutfbgAiXbUlEthZJG+/oBc5u3IEfBI9wkPwgM+f7Uvx3nb8YVxnOWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SO/AQUV2; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4df1cb3c87eso486105e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 05:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715000311; x=1715605111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMEDKA2r/0kfL1be0rSeK9sjaBQ2sk31dP6B+oKhvyc=;
        b=SO/AQUV2Shmmrdeyb+3NrawgxaF/LaUHxg9vGYafnVMFUyLwU9of2ggIMOlXYWiDK8
         x+mORwtvHVvISZLvKowela7nMw7GBF/0Hs+a0egokIJXgVHAeHgfvhyyK1v8DArv8lmE
         lIt6Bjiv8BjIkfipdIOqyTIzQSRjY0sGbfNBf4awws+G0oVqQW7m0YcwkD6zNlzikNly
         04md//oGiEVtxQmb/dr4fGxaevj8nBeFdwiyFQShQPQMtXV8NUeqXt9oEQ8pWutJFRDd
         z42gRS214p0L9jQJx9EHK+WrhZxFT4PZbVyq0DZP4Ag/aZdYfrQoQuC/5w7ehlxF3pru
         eUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715000311; x=1715605111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMEDKA2r/0kfL1be0rSeK9sjaBQ2sk31dP6B+oKhvyc=;
        b=uYTxI/8UDyo7j7zey1WoHfGBSzdbKcw7SbgJy9nUK79aKPYDP/6vxkFlfA1+x7s43K
         piOr7iyUmAf/+bJIc3/m+mkhbTLCFqzO2NA4bmxbGdtSKiYmU/vcq8+8GQ3S/6SKtoqq
         VQdzvlX+qLEitv3R2/umHoeTnNQ/jGlTjnFIed6FuQzYAdXCyls+ms++Y+vUzQ3TUEJe
         jTcGwTRSNbRrZKH9Og8DFemoV2xtKF6gJyXoW2V0pXlTd6gtSp+PJXJEz1VBmoMMZVLQ
         sT5k87zsjCeyjx36HPiMkKqu2teVmI8ytjZjfkPyJ2lVXMOdhu5dhMRRyY1qDDXEscVN
         QumQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkiG11vTN+bIJpUl3/z2ESNs1xq5Nqfz74vEKljP5RSAhDDcFqVtlAxjzPf4IT40fKj7RvqIIC+/nKzDdpbbbXMBLJyFFfYsfZdLFz
X-Gm-Message-State: AOJu0Yx2Lj7KCyvW++Plvb91d6KyLNItzeIV3xb9zE2fFh05xmGRF6Wc
	ehFdDc7uodGj2e+Kowg0OczkNxwTa65NZ6EzKnPDL5cCOQEfq1u3e7HaPr91XFF/1YmY1kSnJsq
	O9DMu9ihCG8gZZMfgzS9prT8+Cds=
X-Google-Smtp-Source: AGHT+IEgrUHg8vroUe/DxhaxUae5fr5W/MPFcn3eVDlE5IVIClXZqG3nR22jXYCIMkGDkB64W6N7Rr3Bmovncy4rnYY=
X-Received: by 2002:a05:6122:1da1:b0:4d4:2069:eafb with SMTP id
 gg33-20020a0561221da100b004d42069eafbmr7018977vkb.9.1715000310716; Mon, 06
 May 2024 05:58:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503005023.174597-1-21cnbao@gmail.com> <20240503005023.174597-7-21cnbao@gmail.com>
 <0b4d4d4b-91d8-4fd5-af4e-aebe9ee08b89@arm.com> <CAGsJ_4wm6v+xgh4jQ+u2-EzOXCLsz6L6nRJi_=FfWuGDUjxRYg@mail.gmail.com>
 <ff5b371a-16f6-4d03-b80d-b56af0f488c3@redhat.com> <CAGsJ_4z93FwPZx7w2VuCEkHP_JCwkO0whKwymonRJ9bSiKMVyQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4z93FwPZx7w2VuCEkHP_JCwkO0whKwymonRJ9bSiKMVyQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 7 May 2024 00:58:19 +1200
Message-ID: <CAGsJ_4xssg3CcjifePMmgk4aqLO+iAon0YdT9p=Uq-D8vFMxyQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] mm: swap: entirely map large folios found in swapcache
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, hanchuanhua@oppo.com, 
	hannes@cmpxchg.org, hughd@google.com, kasong@tencent.com, 
	linux-kernel@vger.kernel.org, surenb@google.com, v-songbaohua@oppo.com, 
	willy@infradead.org, xiang@kernel.org, ying.huang@intel.com, 
	yosryahmed@google.com, yuzhao@google.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 12:38=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Tue, May 7, 2024 at 12:07=E2=80=AFAM David Hildenbrand <david@redhat.c=
om> wrote:
> >
> > On 04.05.24 01:23, Barry Song wrote:
> > > On Fri, May 3, 2024 at 6:50=E2=80=AFPM Ryan Roberts <ryan.roberts@arm=
com> wrote:
> > >>
> > >> On 03/05/2024 01:50, Barry Song wrote:
> > >>> From: Chuanhua Han <hanchuanhua@oppo.com>
> > >>>
> > >>> When a large folio is found in the swapcache, the current implement=
ation
> > >>> requires calling do_swap_page() nr_pages times, resulting in nr_pag=
es
> > >>> page faults. This patch opts to map the entire large folio at once =
to
> > >>> minimize page faults. Additionally, redundant checks and early exit=
s
> > >>> for ARM64 MTE restoring are removed.
> > >>>
> > >>> Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> > >>> Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> > >>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > >>
> > >> With the suggested changes below:
> > >>
> > >> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> > >>
> > >>> ---
> > >>>   mm/memory.c | 60 ++++++++++++++++++++++++++++++++++++++++++------=
-----
> > >>>   1 file changed, 48 insertions(+), 12 deletions(-)
> > >>>
> > >>> diff --git a/mm/memory.c b/mm/memory.c
> > >>> index 22e7c33cc747..940fdbe69fa1 100644
> > >>> --- a/mm/memory.c
> > >>> +++ b/mm/memory.c
> > >>> @@ -3968,6 +3968,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf=
)
> > >>>        pte_t pte;
> > >>>        vm_fault_t ret =3D 0;
> > >>>        void *shadow =3D NULL;
> > >>> +     int nr_pages =3D 1;
> > >>> +     unsigned long page_idx =3D 0;
> > >>> +     unsigned long address =3D vmf->address;
> > >>> +     pte_t *ptep;
> > >>
> > >> nit: Personally I'd prefer all these to get initialised just before =
the "if
> > >> (folio_test_large()..." block below. That way it is clear they are f=
resh (incase
> > >> any logic between here and there makes an adjustment) and its clear =
that they
> > >> are only to be used after that block (the compiler will warn if usin=
g an
> > >> uninitialized value).
> > >
> > > right. I agree this will make the code more readable.
> > >
> > >>
> > >>>
> > >>>        if (!pte_unmap_same(vmf))
> > >>>                goto out;
> > >>> @@ -4166,6 +4170,36 @@ vm_fault_t do_swap_page(struct vm_fault *vmf=
)
> > >>>                goto out_nomap;
> > >>>        }
> > >>>
> > >>> +     ptep =3D vmf->pte;
> > >>> +     if (folio_test_large(folio) && folio_test_swapcache(folio)) {
> > >>> +             int nr =3D folio_nr_pages(folio);
> > >>> +             unsigned long idx =3D folio_page_idx(folio, page);
> > >>> +             unsigned long folio_start =3D vmf->address - idx * PA=
GE_SIZE;
> > >>> +             unsigned long folio_end =3D folio_start + nr * PAGE_S=
IZE;
> > >>> +             pte_t *folio_ptep;
> > >>> +             pte_t folio_pte;
> > >>> +
> > >>> +             if (unlikely(folio_start < max(vmf->address & PMD_MAS=
K, vma->vm_start)))
> > >>> +                     goto check_folio;
> > >>> +             if (unlikely(folio_end > pmd_addr_end(vmf->address, v=
ma->vm_end)))
> > >>> +                     goto check_folio;
> > >>> +
> > >>> +             folio_ptep =3D vmf->pte - idx;
> > >>> +             folio_pte =3D ptep_get(folio_ptep);
> > >>> +             if (!pte_same(folio_pte, pte_move_swp_offset(vmf->ori=
g_pte, -idx)) ||
> > >>> +                 swap_pte_batch(folio_ptep, nr, folio_pte) !=3D nr=
)
> > >>> +                     goto check_folio;
> > >>> +
> > >>> +             page_idx =3D idx;
> > >>> +             address =3D folio_start;
> > >>> +             ptep =3D folio_ptep;
> > >>> +             nr_pages =3D nr;
> > >>> +             entry =3D folio->swap;
> > >>> +             page =3D &folio->page;
> > >>> +     }
> > >>> +
> > >>> +check_folio:
> > >>
> > >> Is this still the correct label name, given the checks are now above=
 the new
> > >> block? Perhaps "one_page" or something like that?
> > >
> > > not quite sure about this, as the code after one_page can be multiple=
_pages.
> > > On the other hand, it seems we are really checking folio after "check=
_folio"
> > > :-)
> > >
> > >
> > > BUG_ON(!folio_test_anon(folio) && folio_test_mappedtodisk(folio));
> > > BUG_ON(folio_test_anon(folio) && PageAnonExclusive(page));
> > >
> > > /*
> > > * Check under PT lock (to protect against concurrent fork() sharing
> > > * the swap entry concurrently) for certainly exclusive pages.
> > > */
> > > if (!folio_test_ksm(folio)) {
> > >
> > >
> > >>
> > >>> +
> > >>>        /*
> > >>>         * PG_anon_exclusive reuses PG_mappedtodisk for anon pages. =
A swap pte
> > >>>         * must never point at an anonymous page in the swapcache th=
at is
> > >>> @@ -4225,12 +4259,13 @@ vm_fault_t do_swap_page(struct vm_fault *vm=
f)
> > >>>         * We're already holding a reference on the page but haven't=
 mapped it
> > >>>         * yet.
> > >>>         */
> > >>> -     swap_free_nr(entry, 1);
> > >>> +     swap_free_nr(entry, nr_pages);
> > >>>        if (should_try_to_free_swap(folio, vma, vmf->flags))
> > >>>                folio_free_swap(folio);
> > >>>
> > >>> -     inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
> > >>> -     dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
> > >>> +     folio_ref_add(folio, nr_pages - 1);
> > >>> +     add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
> > >>> +     add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
> > >>>        pte =3D mk_pte(page, vma->vm_page_prot);
> > >>>
> > >>>        /*
> > >>> @@ -4240,34 +4275,35 @@ vm_fault_t do_swap_page(struct vm_fault *vm=
f)
> > >>>         * exclusivity.
> > >>>         */
> > >>>        if (!folio_test_ksm(folio) &&
> > >>> -         (exclusive || folio_ref_count(folio) =3D=3D 1)) {
> > >>> +         (exclusive || (folio_ref_count(folio) =3D=3D nr_pages &&
> > >>> +                        folio_nr_pages(folio) =3D=3D nr_pages))) {
> > >>
> > >> I think in practice there is no change here? If nr_pages > 1 then th=
e folio is
> > >> in the swapcache, so there is an extra ref on it? I agree with the c=
hange for
> > >> robustness sake. Just checking my understanding.
> > >
> > > This is the code showing we are reusing/(mkwrite) a folio either
> > > 1. we meet a small folio and we are the only one hitting the small fo=
lio
> > > 2. we meet a large folio and we are the only one hitting the large fo=
lio
> > >
> > > any corner cases besides the above two seems difficult. for example,
> > >
> > > while we hit a large folio in swapcache but if we can't entirely map =
it
> > > (nr_pages=3D=3D1) due to partial unmap, we will have folio_ref_count(=
folio)
> > > =3D=3D nr_pages =3D=3D 1
> >
> > No, there would be other references from the swapcache and
> > folio_ref_count(folio) > 1. See my other reply.
>
> right. can be clearer by:

Wait, do we still need folio_nr_pages(folio) =3D=3D nr_pages even if we use
folio_ref_count(folio) =3D=3D 1 and moving folio_ref_add(folio, nr_pages - =
1)?

one case is that we have a large folio with 16 PTEs, and we unmap
15 swap PTE entries, thus we have only one swap entry left. Then
we hit the large folio in swapcache.  but we have only one PTE thus we will
map only one PTE. lacking folio_nr_pages(folio) =3D=3D nr_pages, we reuse t=
he
large folio for one PTE. with it, do_wp_page() will migrate the large
folio to a small one?

1AM, tired and sleepy. not quite sure I am correct.
I look forward to seeing your reply tomorrow morning :-)

>
> @@ -4263,7 +4264,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         if (should_try_to_free_swap(folio, vma, vmf->flags))
>                 folio_free_swap(folio);
>
> -       folio_ref_add(folio, nr_pages - 1);
>         add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
>         add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
>         pte =3D mk_pte(page, vma->vm_page_prot);
> @@ -4275,14 +4275,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>          * exclusivity.
>          */
>         if (!folio_test_ksm(folio) &&
> -           (exclusive || (folio_ref_count(folio) =3D=3D nr_pages &&
> -                          folio_nr_pages(folio) =3D=3D nr_pages))) {
> +           (exclusive || folio_ref_count(folio) =3D=3D 1)) {
>                 if (vmf->flags & FAULT_FLAG_WRITE) {
>                         pte =3D maybe_mkwrite(pte_mkdirty(pte), vma);
>                         vmf->flags &=3D ~FAULT_FLAG_WRITE;
>                 }
>                 rmap_flags |=3D RMAP_EXCLUSIVE;
>         }
> +       folio_ref_add(folio, nr_pages - 1);
>         flush_icache_pages(vma, page, nr_pages);
>         if (pte_swp_soft_dirty(vmf->orig_pte))
>                 pte =3D pte_mksoft_dirty(pte);
>
>
> >
> > --
> > Cheers,
> >
> > David / dhildenb
> >

