Return-Path: <linux-kernel+bounces-170891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E27E8BDD61
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB1ED1F22169
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 08:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD38A14D420;
	Tue,  7 May 2024 08:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtY2MU9Q"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5D714D2B3
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 08:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715071452; cv=none; b=jCqd7j1HOFek/jeu8Sft7Yc1TRLmzCCZMDV8v6PczXvUN5LH9pBEX0ogQT8+V8iFxlevhqGuZH/46iSPjikLEqHLWI7LLOVLuo3inpS755Yuib/3MUNM0wxMx0UWJWqHx3e7dsr76QZA6ORK4VtHAa1WkyjbktQJzn8tHauDDDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715071452; c=relaxed/simple;
	bh=FdMStnjj9AJGeZnBHm+kWxKbJnuCjt8A/z3U0ZxBrLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qvs6XoKfzTKLfeF5coMAE4W4Z19rzOl+xKROMaV+dvs8OkehiBfN9t0vU55ausr+t2Mj9XAOeFtP9wgB+jhleTuFwZEZlhFW/gJFvmQtlS/YvrXaGJ32H2FpHHee6mJL5C8URnFfPmFLGoTclRjkvkMm9gxmOvyNeYRuJgNZq3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtY2MU9Q; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-47efd204baeso528411137.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 01:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715071449; x=1715676249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODRMoOSN1diJVx7KLKg7xNhRk1uFo6RCS+/6a6GHJH4=;
        b=CtY2MU9QDybWJtwO9Q1rel5UhDJRNvgv12st7GiCtf2hMxVjVMBgHMgvef/Vt9ud85
         xW93DCEYq05HOXNHHYNB0aA2AcahClGKgPaAo9HFf3pkq0T3xh9SH/uC/6xdHFzgsmPp
         Fqgco/feqx+ZSVmZshfeDPiWwVgSGlVSMzNK0cA6JMsp5/Yd8m9vQnBTNqPYPajswSI2
         5brKcm8IhSKHtdRDJfPcf9prkyZbF9HTF/rAVaYmNgTMRRNCOS2hGAw7ozNABvSHSsva
         tjZi0VGogdy4IYacG8NU62Ea96nOwJbNxo7mmGm2m41sP118KYRXb2efZ8josN5gRSr+
         r85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715071449; x=1715676249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ODRMoOSN1diJVx7KLKg7xNhRk1uFo6RCS+/6a6GHJH4=;
        b=I81Ud9GlckpkRCmyPzkwO+3AJr1e3ss72C6Tr8iC7tij8La6rTvdzMhM+hv8zfP9re
         H7Y40ch9bd2SpSXCGrXGdJg6Ihop97UxiU9KcKLn/u6LdWeJjjtkyLRB9i8qjIR+MGZZ
         5WLaqSLAEba6SKQXegP2Ipz0j7ShNsNw6BINciWh/36V60UcXJUlvA0t4dirwdCzfP9C
         cvDhwoRLBoR4Q9/7kmgHQiWlldujYBg7XY3Weg8fOG/aVyM/O6Wcztncqdg4cIpR0L6O
         UIcnjC+8qZ3ahh58ObPKTs9qCbbEpwOvE7LU5UedzlAAOB+bHLYuNx8yuOZaFxdI/8zC
         uUmw==
X-Forwarded-Encrypted: i=1; AJvYcCUMVtS+uWvPruMu43cIvGx3ey1aBFE+T/w2ps3hBEm8motf8DOyvsKFLV9c+OQ7Y9kQ73/2pEMTAjOqK9wxukugLU7C//2Ll3x33Aqv
X-Gm-Message-State: AOJu0Yx7yd0wr6yVfjpsY9VzArVPg8iJRC8dgQ4ZAntnVUx0HE+XCdp6
	mIHD5lhV6zAJhFqPnckHN/b9DIQs3oNhChoa6KQBVwVTVILNZ3oZR68w+vjpm5dM8gid5zf3LjJ
	C1Svn19tyBtdlw16BlFgJFXSXyPc=
X-Google-Smtp-Source: AGHT+IFRm+u1TMMF+DSEq8KB/DMop4tTV3wwnpZvVMbdJ1AZSLjQbshG5zuMLlHHYPrX4Jn3rNflzz46PobqEQA0YzQ=
X-Received: by 2002:a67:f315:0:b0:47b:dffe:107 with SMTP id
 p21-20020a67f315000000b0047bdffe0107mr10250410vsf.1.1715071449431; Tue, 07
 May 2024 01:44:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503005023.174597-1-21cnbao@gmail.com> <20240503005023.174597-7-21cnbao@gmail.com>
 <0b4d4d4b-91d8-4fd5-af4e-aebe9ee08b89@arm.com> <CAGsJ_4wm6v+xgh4jQ+u2-EzOXCLsz6L6nRJi_=FfWuGDUjxRYg@mail.gmail.com>
 <ff5b371a-16f6-4d03-b80d-b56af0f488c3@redhat.com> <CAGsJ_4z93FwPZx7w2VuCEkHP_JCwkO0whKwymonRJ9bSiKMVyQ@mail.gmail.com>
 <CAGsJ_4xssg3CcjifePMmgk4aqLO+iAon0YdT9p=Uq-D8vFMxyQ@mail.gmail.com>
 <5b770715-7516-42a8-9ea0-3f61572d92af@redhat.com> <CAGsJ_4xP1jPjH-SH7BgnFHiT4m+2gB0tP7ie_cUFynVpD_zpxQ@mail.gmail.com>
 <7dc2084e-d8b1-42f7-b854-38981839f82e@redhat.com>
In-Reply-To: <7dc2084e-d8b1-42f7-b854-38981839f82e@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 7 May 2024 20:43:57 +1200
Message-ID: <CAGsJ_4w4vDu4p-ALrTSKMZhGKDK6TpyDLrAyvY4vkPJEJ3N5Lw@mail.gmail.com>
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

On Tue, May 7, 2024 at 8:24=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 07.05.24 00:58, Barry Song wrote:
> > On Tue, May 7, 2024 at 1:16=E2=80=AFAM David Hildenbrand <david@redhat.=
com> wrote:
> >>
> >> On 06.05.24 14:58, Barry Song wrote:
> >>> On Tue, May 7, 2024 at 12:38=E2=80=AFAM Barry Song <21cnbao@gmail.com=
> wrote:
> >>>>
> >>>> On Tue, May 7, 2024 at 12:07=E2=80=AFAM David Hildenbrand <david@red=
hat.com> wrote:
> >>>>>
> >>>>> On 04.05.24 01:23, Barry Song wrote:
> >>>>>> On Fri, May 3, 2024 at 6:50=E2=80=AFPM Ryan Roberts <ryan.roberts@=
arm.com> wrote:
> >>>>>>>
> >>>>>>> On 03/05/2024 01:50, Barry Song wrote:
> >>>>>>>> From: Chuanhua Han <hanchuanhua@oppo.com>
> >>>>>>>>
> >>>>>>>> When a large folio is found in the swapcache, the current implem=
entation
> >>>>>>>> requires calling do_swap_page() nr_pages times, resulting in nr_=
pages
> >>>>>>>> page faults. This patch opts to map the entire large folio at on=
ce to
> >>>>>>>> minimize page faults. Additionally, redundant checks and early e=
xits
> >>>>>>>> for ARM64 MTE restoring are removed.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> >>>>>>>> Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> >>>>>>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >>>>>>>
> >>>>>>> With the suggested changes below:
> >>>>>>>
> >>>>>>> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> >>>>>>>
> >>>>>>>> ---
> >>>>>>>>     mm/memory.c | 60 ++++++++++++++++++++++++++++++++++++++++++-=
----------
> >>>>>>>>     1 file changed, 48 insertions(+), 12 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/mm/memory.c b/mm/memory.c
> >>>>>>>> index 22e7c33cc747..940fdbe69fa1 100644
> >>>>>>>> --- a/mm/memory.c
> >>>>>>>> +++ b/mm/memory.c
> >>>>>>>> @@ -3968,6 +3968,10 @@ vm_fault_t do_swap_page(struct vm_fault *=
vmf)
> >>>>>>>>          pte_t pte;
> >>>>>>>>          vm_fault_t ret =3D 0;
> >>>>>>>>          void *shadow =3D NULL;
> >>>>>>>> +     int nr_pages =3D 1;
> >>>>>>>> +     unsigned long page_idx =3D 0;
> >>>>>>>> +     unsigned long address =3D vmf->address;
> >>>>>>>> +     pte_t *ptep;
> >>>>>>>
> >>>>>>> nit: Personally I'd prefer all these to get initialised just befo=
re the "if
> >>>>>>> (folio_test_large()..." block below. That way it is clear they ar=
e fresh (incase
> >>>>>>> any logic between here and there makes an adjustment) and its cle=
ar that they
> >>>>>>> are only to be used after that block (the compiler will warn if u=
sing an
> >>>>>>> uninitialized value).
> >>>>>>
> >>>>>> right. I agree this will make the code more readable.
> >>>>>>
> >>>>>>>
> >>>>>>>>
> >>>>>>>>          if (!pte_unmap_same(vmf))
> >>>>>>>>                  goto out;
> >>>>>>>> @@ -4166,6 +4170,36 @@ vm_fault_t do_swap_page(struct vm_fault *=
vmf)
> >>>>>>>>                  goto out_nomap;
> >>>>>>>>          }
> >>>>>>>>
> >>>>>>>> +     ptep =3D vmf->pte;
> >>>>>>>> +     if (folio_test_large(folio) && folio_test_swapcache(folio)=
) {
> >>>>>>>> +             int nr =3D folio_nr_pages(folio);
> >>>>>>>> +             unsigned long idx =3D folio_page_idx(folio, page);
> >>>>>>>> +             unsigned long folio_start =3D vmf->address - idx *=
 PAGE_SIZE;
> >>>>>>>> +             unsigned long folio_end =3D folio_start + nr * PAG=
E_SIZE;
> >>>>>>>> +             pte_t *folio_ptep;
> >>>>>>>> +             pte_t folio_pte;
> >>>>>>>> +
> >>>>>>>> +             if (unlikely(folio_start < max(vmf->address & PMD_=
MASK, vma->vm_start)))
> >>>>>>>> +                     goto check_folio;
> >>>>>>>> +             if (unlikely(folio_end > pmd_addr_end(vmf->address=
, vma->vm_end)))
> >>>>>>>> +                     goto check_folio;
> >>>>>>>> +
> >>>>>>>> +             folio_ptep =3D vmf->pte - idx;
> >>>>>>>> +             folio_pte =3D ptep_get(folio_ptep);
> >>>>>>>> +             if (!pte_same(folio_pte, pte_move_swp_offset(vmf->=
orig_pte, -idx)) ||
> >>>>>>>> +                 swap_pte_batch(folio_ptep, nr, folio_pte) !=3D=
 nr)
> >>>>>>>> +                     goto check_folio;
> >>>>>>>> +
> >>>>>>>> +             page_idx =3D idx;
> >>>>>>>> +             address =3D folio_start;
> >>>>>>>> +             ptep =3D folio_ptep;
> >>>>>>>> +             nr_pages =3D nr;
> >>>>>>>> +             entry =3D folio->swap;
> >>>>>>>> +             page =3D &folio->page;
> >>>>>>>> +     }
> >>>>>>>> +
> >>>>>>>> +check_folio:
> >>>>>>>
> >>>>>>> Is this still the correct label name, given the checks are now ab=
ove the new
> >>>>>>> block? Perhaps "one_page" or something like that?
> >>>>>>
> >>>>>> not quite sure about this, as the code after one_page can be multi=
ple_pages.
> >>>>>> On the other hand, it seems we are really checking folio after "ch=
eck_folio"
> >>>>>> :-)
> >>>>>>
> >>>>>>
> >>>>>> BUG_ON(!folio_test_anon(folio) && folio_test_mappedtodisk(folio));
> >>>>>> BUG_ON(folio_test_anon(folio) && PageAnonExclusive(page));
> >>>>>>
> >>>>>> /*
> >>>>>> * Check under PT lock (to protect against concurrent fork() sharin=
g
> >>>>>> * the swap entry concurrently) for certainly exclusive pages.
> >>>>>> */
> >>>>>> if (!folio_test_ksm(folio)) {
> >>>>>>
> >>>>>>
> >>>>>>>
> >>>>>>>> +
> >>>>>>>>          /*
> >>>>>>>>           * PG_anon_exclusive reuses PG_mappedtodisk for anon pa=
ges. A swap pte
> >>>>>>>>           * must never point at an anonymous page in the swapcac=
he that is
> >>>>>>>> @@ -4225,12 +4259,13 @@ vm_fault_t do_swap_page(struct vm_fault =
*vmf)
> >>>>>>>>           * We're already holding a reference on the page but ha=
ven't mapped it
> >>>>>>>>           * yet.
> >>>>>>>>           */
> >>>>>>>> -     swap_free_nr(entry, 1);
> >>>>>>>> +     swap_free_nr(entry, nr_pages);
> >>>>>>>>          if (should_try_to_free_swap(folio, vma, vmf->flags))
> >>>>>>>>                  folio_free_swap(folio);
> >>>>>>>>
> >>>>>>>> -     inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
> >>>>>>>> -     dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
> >>>>>>>> +     folio_ref_add(folio, nr_pages - 1);
> >>>>>>>> +     add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
> >>>>>>>> +     add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
> >>>>>>>>          pte =3D mk_pte(page, vma->vm_page_prot);
> >>>>>>>>
> >>>>>>>>          /*
> >>>>>>>> @@ -4240,34 +4275,35 @@ vm_fault_t do_swap_page(struct vm_fault =
*vmf)
> >>>>>>>>           * exclusivity.
> >>>>>>>>           */
> >>>>>>>>          if (!folio_test_ksm(folio) &&
> >>>>>>>> -         (exclusive || folio_ref_count(folio) =3D=3D 1)) {
> >>>>>>>> +         (exclusive || (folio_ref_count(folio) =3D=3D nr_pages =
&&
> >>>>>>>> +                        folio_nr_pages(folio) =3D=3D nr_pages))=
) {
> >>>>>>>
> >>>>>>> I think in practice there is no change here? If nr_pages > 1 then=
 the folio is
> >>>>>>> in the swapcache, so there is an extra ref on it? I agree with th=
e change for
> >>>>>>> robustness sake. Just checking my understanding.
> >>>>>>
> >>>>>> This is the code showing we are reusing/(mkwrite) a folio either
> >>>>>> 1. we meet a small folio and we are the only one hitting the small=
 folio
> >>>>>> 2. we meet a large folio and we are the only one hitting the large=
 folio
> >>>>>>
> >>>>>> any corner cases besides the above two seems difficult. for exampl=
e,
> >>>>>>
> >>>>>> while we hit a large folio in swapcache but if we can't entirely m=
ap it
> >>>>>> (nr_pages=3D=3D1) due to partial unmap, we will have folio_ref_cou=
nt(folio)
> >>>>>> =3D=3D nr_pages =3D=3D 1
> >>>>>
> >>>>> No, there would be other references from the swapcache and
> >>>>> folio_ref_count(folio) > 1. See my other reply.
> >>>>
> >>>> right. can be clearer by:
> >>>
> >>> Wait, do we still need folio_nr_pages(folio) =3D=3D nr_pages even if =
we use
> >>> folio_ref_count(folio) =3D=3D 1 and moving folio_ref_add(folio, nr_pa=
ges - 1)?
> >>
> >> I don't think that we will "need" it.
> >>
> >>>
> >>> one case is that we have a large folio with 16 PTEs, and we unmap
> >>> 15 swap PTE entries, thus we have only one swap entry left. Then
> >>> we hit the large folio in swapcache.  but we have only one PTE thus w=
e will
> >>> map only one PTE. lacking folio_nr_pages(folio) =3D=3D nr_pages, we r=
euse the
> >>> large folio for one PTE. with it, do_wp_page() will migrate the large
> >>> folio to a small one?
> >>
> >> We will set PAE bit and do_wp_page() will unconditionally reuse that p=
age.
> >>
> >> Note that this is the same as if we had pte_swp_exclusive() set and
> >> would have run into "exclusive=3Dtrue" here.
> >>
> >> If we'd want a similar "optimization" as we have in
> >> wp_can_reuse_anon_folio(), you'd want something like
> >>
> >> exclusive || (folio_ref_count(folio) =3D=3D 1 &&
> >>                (!folio_test_large(folio) || nr_pages > 1)
> >
> > I feel like
> >
> > A :   !folio_test_large(folio) || nr_pages > 1
> >
> > equals
> >
> > B:    folio_nr_pages(folio) =3D=3D nr_pages
> >
> > if folio is small,  folio_test_large(folio) is false, both A and B will=
 be true;
> > if folio is large, and we map the whole large folio, A will be true
> > because of nr_pages > 1;
> > B is also true;
> > if folio is large, and we map single one PTE, A will be false;
> > B is also false, because nr_pages =3D=3D 1 but  folio_nr_pages(folio) >=
 1;
> >
> > right?
>
> Let's assume a single subpage of a large folio is no longer mapped.
> Then, we'd have:
>
> nr_pages =3D=3D folio_nr_pages(folio) - 1.
>
> You could simply map+reuse most of the folio without COWing.

yes. This is good but the pte which is no longer mapped could be
anyone within the nr_pages PTEs. so it could be quite tricky for
set_ptes.

>
> Once we support COW reuse of PTE-mapped THP we'd do the same. Here, it's
> just easy to detect that the folio is exclusive (folio_ref_count(folio)
> =3D=3D 1 before mapping anything).
>
> If you really want to mimic what do_wp_page() currently does, you should
> have:
>
> exclusive || (folio_ref_count(folio) =3D=3D 1 && !folio_test_large(folio)=
)

I actually dislike the part that do_wp_page() handles the reuse of a large
folio which is entirely mapped. For example, A forks B, B exit, we write
A's large folio, we get nr_pages CoW of small folios. Ideally, we can
reuse the whole folios for writing.

>
> Personally, I think we should keep it simple here and use:
>
> exclusive || folio_ref_count(folio) =3D=3D 1

I feel this is still better than
exclusive || (folio_ref_count(folio) =3D=3D 1 && !folio_test_large(folio))
as we reuse the whole large folio. the do_wp_page() behaviour
doesn't have this.

>
> IMHO, that's as clear as it gets.

I agree this is clear. But I wonder if there is a possibility to optimize.

Using your instance,
"Let's assume a single subpage of a large folio is no longer mapped."

For a large folio with 16 PTEs and in case we have unmapped one of them.
Thus, we have 15 swap entries left.

The first PTE which gets page faults will reuse the whole large folio havin=
g
"exclusive || folio_ref_count(folio) =3D=3D 1" only. The left 14 will
allocate 14 small
folios(swapcache has been dropped), thus, we use 16 + 14 =3D 30 pages
memory.

with either
A :   !folio_test_large(folio) || nr_pages > 1
or
B:    folio_nr_pages(folio) =3D=3D nr_pages

We consume 15 pages.

>
> --
> Cheers,
>
> David / dhildenb

Thanks
Barry

