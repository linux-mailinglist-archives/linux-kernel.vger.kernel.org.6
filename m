Return-Path: <linux-kernel+bounces-169823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C21F8BCE15
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692D01F222FF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5D729408;
	Mon,  6 May 2024 12:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnkUsjOG"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADC26D1AE
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 12:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714999116; cv=none; b=pYQKo6mvAq5wdbO05OvkAWUjoX23Bd+zLlxumSrxGouJyVKcU5gqqvXUYS03GLxbXupXBybdivYZVet7oARodN0hgLZ0nFXaUOhEnMOnHM7uF/eN0sMLCGGFtwjySZEpPzNBlyDP+7NmUMLPb8H2XNifZImSFQ+25VYWZiyy09g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714999116; c=relaxed/simple;
	bh=obL2IvGFDuAcszx0hfFXJt5PO/29dZd5L5BsToJkYyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t409XDInWQjlLGpACYFMH5TEx7alXp/aNnih4HpHnX7F4gCjexLCTvZCYzZVaVeXqS5oyuMVu0tA3d4qphCVRmynoV87MD1Gani6KA+dJ1Mq5PnSizGb2XWki6JuHgE5gJQbAfUc0D3wn7TiJLzM7z6Yu+Kol/40q7SLnSoqRiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnkUsjOG; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7f16ff3aa86so791943241.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 05:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714999114; x=1715603914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNddV6/g7b5X9nuwqRkA6IZ/STwot3sVpGbOunU96o4=;
        b=EnkUsjOG/iXzlSev6R1e18i6tzK1WvaBp+a9cXNqRmVSvjPMXQyC6blZ1NrabRbRCs
         Ed8Nzl78KRI1bISI6Cm2vpjndYspDV1/vO7zgDFaWIu5EClUq1MHe/L1z3f20yhfPWvW
         /1RHNpb8O0QQx0bPZCStcHVBCn/VanhaiFWzCbMWSG/MAYXwLEvKEQJMI0jr8+tZcK0P
         DW3kCsbNQgT0bHRfwrnQRA4lUUus6vEKybw04hY7q6fEN5XG37u3j/N0vAV+Bc31dxfx
         WGV2pkZOLXJVh16eMC39FsCFwilPkPDjFN9wObeZXp9M4BZ0QnbXaCTyhyefpM3fl4Yr
         kSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714999114; x=1715603914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNddV6/g7b5X9nuwqRkA6IZ/STwot3sVpGbOunU96o4=;
        b=WdR2ioSoZpo4J3sn3cInSbmnDyn2gfjzyFV4EDzJ+6VZWk7wf7WSrYGA1WHUBYQ8Dt
         70gOFykRBaSYOt4kzrawl/E+c5GNrino3/KxoyOOujZOkpKRkfRLYzkXobOfhQ3TpjR2
         4q0ciPmng0aVXRnwOPx2D2bcExlSwAbWnQBNtT7XhUpOxiqlKhNhPk0V9vNbnU7rju1w
         MeLu0dQfhVmM4WnMCPGv0nZQXRVnCE9awBE88YrLuHo9vA/SztSLO1wW75QEE+Q4hv63
         msG6j2IjejT0XfHDYIBzrfgxUgQm5qEm5QG/MSQpOuuMpMuyVWnfz1dg3SFkoCWlBKd4
         tchw==
X-Forwarded-Encrypted: i=1; AJvYcCW1TrfxVsCnSJQ+7V4PG5HvGd7u4ubRMucp0QVzduQJhyrGxYmSb8iY4RvpLnYA5aaFSQ7phsY8tjWqQpj8OY/LFUopMDGzJLQ+xZEg
X-Gm-Message-State: AOJu0Yxv/YamLucJCX+K0C9760XYl+8QatPm6n2pameNhPbA5lVQrHnW
	LEltPgEAJFV3s1IlqU4SUaZ8gxrfty8MF2BPSUdEryyl3OGiGX94ql+3s0SwI2cZ7T0lhPowy7x
	u0Kjp5HIPMlbTmNNLt/ViR3FHud4=
X-Google-Smtp-Source: AGHT+IF361PCS/bcPQDXdLLBgiShj8tlb0DlrjHFfS9TEIc70Q8vWeR4C5rynAElu9jpvQokJBteD0vRH1G3zQL8TGI=
X-Received: by 2002:a05:6102:5f47:b0:47e:a214:5317 with SMTP id
 il7-20020a0561025f4700b0047ea2145317mr12206866vsb.19.1714999113599; Mon, 06
 May 2024 05:38:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503005023.174597-1-21cnbao@gmail.com> <20240503005023.174597-7-21cnbao@gmail.com>
 <0b4d4d4b-91d8-4fd5-af4e-aebe9ee08b89@arm.com> <CAGsJ_4wm6v+xgh4jQ+u2-EzOXCLsz6L6nRJi_=FfWuGDUjxRYg@mail.gmail.com>
 <ff5b371a-16f6-4d03-b80d-b56af0f488c3@redhat.com>
In-Reply-To: <ff5b371a-16f6-4d03-b80d-b56af0f488c3@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 7 May 2024 00:38:22 +1200
Message-ID: <CAGsJ_4z93FwPZx7w2VuCEkHP_JCwkO0whKwymonRJ9bSiKMVyQ@mail.gmail.com>
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

On Tue, May 7, 2024 at 12:07=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 04.05.24 01:23, Barry Song wrote:
> > On Fri, May 3, 2024 at 6:50=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.c=
om> wrote:
> >>
> >> On 03/05/2024 01:50, Barry Song wrote:
> >>> From: Chuanhua Han <hanchuanhua@oppo.com>
> >>>
> >>> When a large folio is found in the swapcache, the current implementat=
ion
> >>> requires calling do_swap_page() nr_pages times, resulting in nr_pages
> >>> page faults. This patch opts to map the entire large folio at once to
> >>> minimize page faults. Additionally, redundant checks and early exits
> >>> for ARM64 MTE restoring are removed.
> >>>
> >>> Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> >>> Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> >>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >>
> >> With the suggested changes below:
> >>
> >> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> >>
> >>> ---
> >>>   mm/memory.c | 60 ++++++++++++++++++++++++++++++++++++++++++--------=
---
> >>>   1 file changed, 48 insertions(+), 12 deletions(-)
> >>>
> >>> diff --git a/mm/memory.c b/mm/memory.c
> >>> index 22e7c33cc747..940fdbe69fa1 100644
> >>> --- a/mm/memory.c
> >>> +++ b/mm/memory.c
> >>> @@ -3968,6 +3968,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>>        pte_t pte;
> >>>        vm_fault_t ret =3D 0;
> >>>        void *shadow =3D NULL;
> >>> +     int nr_pages =3D 1;
> >>> +     unsigned long page_idx =3D 0;
> >>> +     unsigned long address =3D vmf->address;
> >>> +     pte_t *ptep;
> >>
> >> nit: Personally I'd prefer all these to get initialised just before th=
e "if
> >> (folio_test_large()..." block below. That way it is clear they are fre=
sh (incase
> >> any logic between here and there makes an adjustment) and its clear th=
at they
> >> are only to be used after that block (the compiler will warn if using =
an
> >> uninitialized value).
> >
> > right. I agree this will make the code more readable.
> >
> >>
> >>>
> >>>        if (!pte_unmap_same(vmf))
> >>>                goto out;
> >>> @@ -4166,6 +4170,36 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>>                goto out_nomap;
> >>>        }
> >>>
> >>> +     ptep =3D vmf->pte;
> >>> +     if (folio_test_large(folio) && folio_test_swapcache(folio)) {
> >>> +             int nr =3D folio_nr_pages(folio);
> >>> +             unsigned long idx =3D folio_page_idx(folio, page);
> >>> +             unsigned long folio_start =3D vmf->address - idx * PAGE=
_SIZE;
> >>> +             unsigned long folio_end =3D folio_start + nr * PAGE_SIZ=
E;
> >>> +             pte_t *folio_ptep;
> >>> +             pte_t folio_pte;
> >>> +
> >>> +             if (unlikely(folio_start < max(vmf->address & PMD_MASK,=
 vma->vm_start)))
> >>> +                     goto check_folio;
> >>> +             if (unlikely(folio_end > pmd_addr_end(vmf->address, vma=
->vm_end)))
> >>> +                     goto check_folio;
> >>> +
> >>> +             folio_ptep =3D vmf->pte - idx;
> >>> +             folio_pte =3D ptep_get(folio_ptep);
> >>> +             if (!pte_same(folio_pte, pte_move_swp_offset(vmf->orig_=
pte, -idx)) ||
> >>> +                 swap_pte_batch(folio_ptep, nr, folio_pte) !=3D nr)
> >>> +                     goto check_folio;
> >>> +
> >>> +             page_idx =3D idx;
> >>> +             address =3D folio_start;
> >>> +             ptep =3D folio_ptep;
> >>> +             nr_pages =3D nr;
> >>> +             entry =3D folio->swap;
> >>> +             page =3D &folio->page;
> >>> +     }
> >>> +
> >>> +check_folio:
> >>
> >> Is this still the correct label name, given the checks are now above t=
he new
> >> block? Perhaps "one_page" or something like that?
> >
> > not quite sure about this, as the code after one_page can be multiple_p=
ages.
> > On the other hand, it seems we are really checking folio after "check_f=
olio"
> > :-)
> >
> >
> > BUG_ON(!folio_test_anon(folio) && folio_test_mappedtodisk(folio));
> > BUG_ON(folio_test_anon(folio) && PageAnonExclusive(page));
> >
> > /*
> > * Check under PT lock (to protect against concurrent fork() sharing
> > * the swap entry concurrently) for certainly exclusive pages.
> > */
> > if (!folio_test_ksm(folio)) {
> >
> >
> >>
> >>> +
> >>>        /*
> >>>         * PG_anon_exclusive reuses PG_mappedtodisk for anon pages. A =
swap pte
> >>>         * must never point at an anonymous page in the swapcache that=
 is
> >>> @@ -4225,12 +4259,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>>         * We're already holding a reference on the page but haven't m=
apped it
> >>>         * yet.
> >>>         */
> >>> -     swap_free_nr(entry, 1);
> >>> +     swap_free_nr(entry, nr_pages);
> >>>        if (should_try_to_free_swap(folio, vma, vmf->flags))
> >>>                folio_free_swap(folio);
> >>>
> >>> -     inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
> >>> -     dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
> >>> +     folio_ref_add(folio, nr_pages - 1);
> >>> +     add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
> >>> +     add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
> >>>        pte =3D mk_pte(page, vma->vm_page_prot);
> >>>
> >>>        /*
> >>> @@ -4240,34 +4275,35 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>>         * exclusivity.
> >>>         */
> >>>        if (!folio_test_ksm(folio) &&
> >>> -         (exclusive || folio_ref_count(folio) =3D=3D 1)) {
> >>> +         (exclusive || (folio_ref_count(folio) =3D=3D nr_pages &&
> >>> +                        folio_nr_pages(folio) =3D=3D nr_pages))) {
> >>
> >> I think in practice there is no change here? If nr_pages > 1 then the =
folio is
> >> in the swapcache, so there is an extra ref on it? I agree with the cha=
nge for
> >> robustness sake. Just checking my understanding.
> >
> > This is the code showing we are reusing/(mkwrite) a folio either
> > 1. we meet a small folio and we are the only one hitting the small foli=
o
> > 2. we meet a large folio and we are the only one hitting the large foli=
o
> >
> > any corner cases besides the above two seems difficult. for example,
> >
> > while we hit a large folio in swapcache but if we can't entirely map it
> > (nr_pages=3D=3D1) due to partial unmap, we will have folio_ref_count(fo=
lio)
> > =3D=3D nr_pages =3D=3D 1
>
> No, there would be other references from the swapcache and
> folio_ref_count(folio) > 1. See my other reply.

right. can be clearer by:

@@ -4263,7 +4264,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
        if (should_try_to_free_swap(folio, vma, vmf->flags))
                folio_free_swap(folio);

-       folio_ref_add(folio, nr_pages - 1);
        add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
        add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
        pte =3D mk_pte(page, vma->vm_page_prot);
@@ -4275,14 +4275,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
         * exclusivity.
         */
        if (!folio_test_ksm(folio) &&
-           (exclusive || (folio_ref_count(folio) =3D=3D nr_pages &&
-                          folio_nr_pages(folio) =3D=3D nr_pages))) {
+           (exclusive || folio_ref_count(folio) =3D=3D 1)) {
                if (vmf->flags & FAULT_FLAG_WRITE) {
                        pte =3D maybe_mkwrite(pte_mkdirty(pte), vma);
                        vmf->flags &=3D ~FAULT_FLAG_WRITE;
                }
                rmap_flags |=3D RMAP_EXCLUSIVE;
        }
+       folio_ref_add(folio, nr_pages - 1);
        flush_icache_pages(vma, page, nr_pages);
        if (pte_swp_soft_dirty(vmf->orig_pte))
                pte =3D pte_mksoft_dirty(pte);


>
> --
> Cheers,
>
> David / dhildenb
>

