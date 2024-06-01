Return-Path: <linux-kernel+bounces-197623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2B48D6D32
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 02:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4C2E1F23D64
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 00:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E553FF1;
	Sat,  1 Jun 2024 00:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="et1hE7lU"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420AEA38
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 00:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717202928; cv=none; b=Th0KqIS4WK3ZjHVBenO+du1WKfkcBZmChpy8ZIl0QZmWou+DuUhrkP4XHO65EmIFkLzY0JeiXTGlAs0r9j3bH/9jqsJeSBLV+qMn8rgOf1O0nqbDBCLwuVUekL9KqMdYdlfd4gYnaQ9ThcLGc/8Vl4+P2NJi5QVLzEeY9zc4qZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717202928; c=relaxed/simple;
	bh=gurZFsQ8OvJmnaV8agzTrGE7oEuXGBKQ3Re0ATr/GuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJ6wBgx/OubF7LJLo3OIfyBf6J4fi1Vhe1HOfe/bSEp8kqcZUShxLxDkBoTZNKTEms58XZFajTspdeP4/H0GMnvRi1HNF/APKQlwNYMLI/DMlBZ1hTQEMIuEPV6vgraCkVhHc6XahAoZQXJ+dhm1bNoaeGGZ9/BA6YrYyo0AzC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=et1hE7lU; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6f8ef63714cso1730542a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 17:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717202926; x=1717807726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLpooYvn6cqpznIh0g+oklIkjo2I3vAHUhZ1XARf310=;
        b=et1hE7lUYBev3Hh4rQdvFaRw0kr1Xk5nNKeKlnt7dIlI3G2BQUN+P/lghmdyIIULAv
         ZEN8nqk91iWy9LrlwcCA80y6o84qLAbqa658A8DRagaOGWfUcJOXTx5rJXIaFlMBTNXd
         pRR/Qsrcu+xByO0PVwfsLiF2CuGRYkF3454LQAdNyO3V4iQ8uW12+/GHjUexAoSWHikF
         Jl9RMth0C/sDgS6o6kZU2UT+Np0sK6Xlpk5UZ8Ytnhu3Pm7+Gfx5WPUIMFhNWOLYK8x6
         ydvmHDWxS8hoMgf/5qHgJf2mRXK/pvryauH5prd1bkPdfBs1PyNWDLuMLFPuNMfgB6zh
         aanw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717202926; x=1717807726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fLpooYvn6cqpznIh0g+oklIkjo2I3vAHUhZ1XARf310=;
        b=TkdrQBGMleRBvCk+GNrl2ds3rDaT8xxZNsJplto2PyiBxDgsbE7eAd65H2XFIrL/N4
         k7kFiT0WvsIUrpspbayCo3ReFUwu0lcV9JZ8r4NZqIWQs2eHOsLj0Cg4f02iNoh4k/AN
         lodFVWtU4NfsYzoWfddjJJz7QTxAKrsDwLas/Qiu98V9S9gmjmbhGaYE2BouJq0ctxeb
         17LQKuvqSntPPDbcCQjN53rNo/U3z08hVFIDtV7VldoE4EQtXP3svoiUCD7nks9/21ej
         C9uI7gmzK9uCarDl/KRC1jh8Jt7GwhCT14Y1qqO0f6gLo5FnntIYA12SqIpubkDTsYgu
         FiuA==
X-Forwarded-Encrypted: i=1; AJvYcCXy/GzdHppXrcII4J8f/53TVBQbi0/7upWGLfa2MB7zXUwC6RIYn0CBuTP8IUs483vdjHJi1R53m66dwCQ+mUietTXVPDjdcTFV0Q7Y
X-Gm-Message-State: AOJu0Yx4XAfYxKNo/HXTbsKaHolSedDRO3r5OsPfNUahC4SwzQFymilC
	aiTC7vjlRmvCOx9BT1lSN8Ev8SuyXpYgufaVzvqAKQ1hBBswqX2WgXXyBdTW8LcEuIw21OHRm83
	00R0mrLw9xF1Sh8g2T+SnoL9iiO9aL0a2
X-Google-Smtp-Source: AGHT+IEgE6cxa2YbnBDMm9TNEWqxp4u0kLHoB2ZU4k4IHiB+4ruYZqTlDv2zniIUPy0zkfnP9vpri7djL8HkoWPMSjc=
X-Received: by 2002:a05:6830:ed9:b0:6f1:3aa3:b0e7 with SMTP id
 46e09a7af769-6f911f273ffmr3908761a34.7.1717202926307; Fri, 31 May 2024
 17:48:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531104819.140218-1-21cnbao@gmail.com> <87ac9610-5650-451f-aa54-e634a6310af4@redhat.com>
 <CAGsJ_4zgf8j0oRnVBhe-__=K2RFDHTCo-JnMak95HTvxtMUwnQ@mail.gmail.com>
 <d4c1a9ad-4945-40d7-9b7a-5b02df805884@redhat.com> <CAGsJ_4xpDwTTbwzMx8ipmpCyNmVmABpRN1f9yfZfFiOaGMKiew@mail.gmail.com>
 <CAGsJ_4yX52k=Wx2x3jwXzNBG=rDGJrzGNwGCAh0puUP7zby=QA@mail.gmail.com> <821d29b9-cb06-49db-9fe8-6c054c8787fb@redhat.com>
In-Reply-To: <821d29b9-cb06-49db-9fe8-6c054c8787fb@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 1 Jun 2024 12:48:34 +1200
Message-ID: <CAGsJ_4xrH0iQ1KU6ATWVx4SutfWqCBC6bF-a1tJyRFRKcOUV4A@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: swap: reuse exclusive folio directly instead of
 wp page faults
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, chrisl@kernel.org, 
	surenb@google.com, kasong@tencent.com, minchan@kernel.org, 
	willy@infradead.org, ryan.roberts@arm.com, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 1, 2024 at 12:35=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 31.05.24 14:30, Barry Song wrote:
> > On Sat, Jun 1, 2024 at 12:20=E2=80=AFAM Barry Song <21cnbao@gmail.com> =
wrote:
> >>
> >> On Sat, Jun 1, 2024 at 12:10=E2=80=AFAM David Hildenbrand <david@redha=
t.com> wrote:
> >>>
> >>> On 31.05.24 13:55, Barry Song wrote:
> >>>> On Fri, May 31, 2024 at 11:08=E2=80=AFPM David Hildenbrand <david@re=
dhat.com> wrote:
> >>>>>
> >>>>> On 31.05.24 12:48, Barry Song wrote:
> >>>>>> From: Barry Song <v-songbaohua@oppo.com>
> >>>>>>
> >>>>>> After swapping out, we perform a swap-in operation. If we first re=
ad
> >>>>>> and then write, we encounter a major fault in do_swap_page for rea=
ding,
> >>>>>> along with additional minor faults in do_wp_page for writing. Howe=
ver,
> >>>>>> the latter appears to be unnecessary and inefficient. Instead, we =
can
> >>>>>> directly reuse in do_swap_page and completely eliminate the need f=
or
> >>>>>> do_wp_page.
> >>>>>>
> >>>>>> This patch achieves that optimization specifically for exclusive f=
olios.
> >>>>>> The following microbenchmark demonstrates the significant reductio=
n in
> >>>>>> minor faults.
> >>>>>>
> >>>>>>     #define DATA_SIZE (2UL * 1024 * 1024)
> >>>>>>     #define PAGE_SIZE (4UL * 1024)
> >>>>>>
> >>>>>>     static void *read_write_data(char *addr)
> >>>>>>     {
> >>>>>>             char tmp;
> >>>>>>
> >>>>>>             for (int i =3D 0; i < DATA_SIZE; i +=3D PAGE_SIZE) {
> >>>>>>                     tmp =3D *(volatile char *)(addr + i);
> >>>>>>                     *(volatile char *)(addr + i) =3D tmp;
> >>>>>>             }
> >>>>>>     }
> >>>>>>
> >>>>>>     int main(int argc, char **argv)
> >>>>>>     {
> >>>>>>             struct rusage ru;
> >>>>>>
> >>>>>>             char *addr =3D mmap(NULL, DATA_SIZE, PROT_READ | PROT_=
WRITE,
> >>>>>>                             MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> >>>>>>             memset(addr, 0x11, DATA_SIZE);
> >>>>>>
> >>>>>>             do {
> >>>>>>                     long old_ru_minflt, old_ru_majflt;
> >>>>>>                     long new_ru_minflt, new_ru_majflt;
> >>>>>>
> >>>>>>                     madvise(addr, DATA_SIZE, MADV_PAGEOUT);
> >>>>>>
> >>>>>>                     getrusage(RUSAGE_SELF, &ru);
> >>>>>>                     old_ru_minflt =3D ru.ru_minflt;
> >>>>>>                     old_ru_majflt =3D ru.ru_majflt;
> >>>>>>
> >>>>>>                     read_write_data(addr);
> >>>>>>                     getrusage(RUSAGE_SELF, &ru);
> >>>>>>                     new_ru_minflt =3D ru.ru_minflt;
> >>>>>>                     new_ru_majflt =3D ru.ru_majflt;
> >>>>>>
> >>>>>>                     printf("minor faults:%ld major faults:%ld\n",
> >>>>>>                             new_ru_minflt - old_ru_minflt,
> >>>>>>                             new_ru_majflt - old_ru_majflt);
> >>>>>>             } while(0);
> >>>>>>
> >>>>>>             return 0;
> >>>>>>     }
> >>>>>>
> >>>>>> w/o patch,
> >>>>>> / # ~/a.out
> >>>>>> minor faults:512 major faults:512
> >>>>>>
> >>>>>> w/ patch,
> >>>>>> / # ~/a.out
> >>>>>> minor faults:0 major faults:512
> >>>>>>
> >>>>>> Minor faults decrease to 0!
> >>>>>>
> >>>>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >>>>>> ---
> >>>>>>     mm/memory.c | 7 ++++---
> >>>>>>     1 file changed, 4 insertions(+), 3 deletions(-)
> >>>>>>
> >>>>>> diff --git a/mm/memory.c b/mm/memory.c
> >>>>>> index eef4e482c0c2..e1d2e339958e 100644
> >>>>>> --- a/mm/memory.c
> >>>>>> +++ b/mm/memory.c
> >>>>>> @@ -4325,9 +4325,10 @@ vm_fault_t do_swap_page(struct vm_fault *vm=
f)
> >>>>>>          */
> >>>>>>         if (!folio_test_ksm(folio) &&
> >>>>>>             (exclusive || folio_ref_count(folio) =3D=3D 1)) {
> >>>>>> -             if (vmf->flags & FAULT_FLAG_WRITE) {
> >>>>>> -                     pte =3D maybe_mkwrite(pte_mkdirty(pte), vma)=
;
> >>>>>> -                     vmf->flags &=3D ~FAULT_FLAG_WRITE;
> >>>>>> +             if (vma->vm_flags & VM_WRITE) {
> >>>>>> +                     pte =3D pte_mkwrite(pte_mkdirty(pte), vma);
> >>>>>> +                     if (vmf->flags & FAULT_FLAG_WRITE)
> >>>>>> +                             vmf->flags &=3D ~FAULT_FLAG_WRITE;
> >>>>>
> >>>>> This implies, that even on a read fault, you would mark the pte dir=
ty
> >>>>> and it would have to be written back to swap if still in the swap c=
ache
> >>>>> and only read.
> >>>>>
> >>>>> That is controversial.
> >>>>>
> >>>>> What is less controversial is doing what mprotect() via
> >>>>> change_pte_range()/can_change_pte_writable() would do: mark the PTE
> >>>>> writable but not dirty.
> >>>>>
> >>>>> I suggest setting the pte only dirty if FAULT_FLAG_WRITE is set.
> >>>>
> >>>> Thanks!
> >>>>
> >>>> I assume you mean something as below?
> >>>
> >>> It raises an important point: uffd-wp must be handled accordingly.
> >>>
> >>>>
> >>>> diff --git a/mm/memory.c b/mm/memory.c
> >>>> index eef4e482c0c2..dbf1ba8ccfd6 100644
> >>>> --- a/mm/memory.c
> >>>> +++ b/mm/memory.c
> >>>> @@ -4317,6 +4317,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>>>           add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
> >>>>           pte =3D mk_pte(page, vma->vm_page_prot);
> >>>>
> >>>> +       if (pte_swp_soft_dirty(vmf->orig_pte))
> >>>> +               pte =3D pte_mksoft_dirty(pte);
> >>>> +       if (pte_swp_uffd_wp(vmf->orig_pte))
> >>>> +               pte =3D pte_mkuffd_wp(pte);
> >>>>           /*
> >>>>            * Same logic as in do_wp_page(); however, optimize for pa=
ges that are
> >>>>            * certainly not shared either because we just allocated t=
hem without
> >>>> @@ -4325,18 +4329,19 @@ vm_fault_t do_swap_page(struct vm_fault *vmf=
)
> >>>>            */
> >>>>           if (!folio_test_ksm(folio) &&
> >>>>               (exclusive || folio_ref_count(folio) =3D=3D 1)) {
> >>>> -               if (vmf->flags & FAULT_FLAG_WRITE) {
> >>>> -                       pte =3D maybe_mkwrite(pte_mkdirty(pte), vma)=
;
> >>>> -                       vmf->flags &=3D ~FAULT_FLAG_WRITE;
> >>>> +               if (vma->vm_flags & VM_WRITE) {
> >>>> +                       if (vmf->flags & FAULT_FLAG_WRITE) {
> >>>> +                               pte =3D pte_mkwrite(pte_mkdirty(pte)=
, vma);
> >>>> +                               vmf->flags &=3D ~FAULT_FLAG_WRITE;
> >>>> +                       } else if ((!vma_soft_dirty_enabled(vma) ||
> >>>> pte_soft_dirty(pte))
> >>>> +                                   && !userfaultfd_pte_wp(vma, pte)=
) {
> >>>> +                                       pte =3D pte_mkwrite(pte, vma=
);
> >>>
> >>> Even with FAULT_FLAG_WRITE we must respect uffd-wp and *not* do a
> >>> pte_mkwrite(pte). So we have to catch and handle that earlier (I coul=
d
> >>> have sworn we handle that somehow).
> >>>
> >>> Note that the existing
> >>>          pte =3D pte_mkuffd_wp(pte);
> >>>
> >>> Will fix that up because it does an implicit pte_wrprotect().
> >>
> >> This is exactly what I have missed as I am struggling with why WRITE_F=
AULT
> >> blindly does mkwrite without checking userfaultfd_pte_wp().
> >>
> >>>
> >>>
> >>> So maybe what would work is
> >>>
> >>>
> >>> if ((vma->vm_flags & VM_WRITE) && !userfaultfd_pte_wp(vma, pte) &&
> >>>       !vma_soft_dirty_enabled(vma)) {
> >>>          pte =3D pte_mkwrite(pte);
> >>>
> >>>          /* Only set the PTE dirty on write fault. */
> >>>          if (vmf->flags & FAULT_FLAG_WRITE) {
> >>>                  pte =3D pte_mkdirty(pte);
> >>>                  vmf->flags &=3D ~FAULT_FLAG_WRITE;
> >>>          }
> >
> > WRITE_FAULT has a pte_mkdirty, so it doesn't need to check
> > "!vma_soft_dirty_enabled(vma)"?
> > Maybe I thought too much, just the simple code below should work?
>
> That would likely not handle softdirty correctly in case we end up in
> pte_mkwrite(pte, vma); note that pte_mksoft_dirty() will not wrprotect ..=
.

if SOFTDIRTY has been set, we shouldn't do wrprotect? till the dirty
is cleared, we don't rely on further write fault to set soft dirty, right?

so we should better do pte_mkwrite if pte_soft_dirty(pte) =3D=3D true?

 if ((vma->vm_flags & VM_WRITE) && !userfaultfd_pte_wp(vma, pte) &&
      (!vma_soft_dirty_enabled(vma) || pte_soft_dirty(pte)))

>
> (note that we shouldn't optimize for softdirty handling)
>
> >
> >          if (!folio_test_ksm(folio) &&
> >              (exclusive || folio_ref_count(folio) =3D=3D 1)) {
> >                  if (vma->vm_flags & VM_WRITE) {
> >                          if (vmf->flags & FAULT_FLAG_WRITE) {
> >                                  pte =3D pte_mkwrite(pte_mkdirty(pte), =
vma);
> >                                  vmf->flags &=3D ~FAULT_FLAG_WRITE;
> >                          } else {
> >                                  pte =3D pte_mkwrite(pte, vma);
> >                          }
> >                  }
> >                  rmap_flags |=3D RMAP_EXCLUSIVE;
> >          }
> >
> >          if (pte_swp_soft_dirty(vmf->orig_pte))
> >                  pte =3D pte_mksoft_dirty(pte);
> >          if (pte_swp_uffd_wp(vmf->orig_pte))
> >                  pte =3D pte_mkuffd_wp(pte);
> >
> > This still uses the implicit wrprotect of pte_mkuffd_wp.
>
> But the wrprotected->writable->wrprotected path really is confusing. I'd
> prefer to set these bits ahead of time instead, so we can properly rely
> on them -- like we do in other code.

I agree. we are setting WRITE then reverting the WRITE. It is confusing.

So in conclusion, we get the belows?

        if (pte_swp_soft_dirty(vmf->orig_pte))
                pte =3D pte_mksoft_dirty(pte);
        if (pte_swp_uffd_wp(vmf->orig_pte))
                pte =3D pte_mkuffd_wp(pte);

        /*
         * Same logic as in do_wp_page(); however, optimize for pages that =
are
         * certainly not shared either because we just allocated them witho=
ut
         * exposing them to the swapcache or because the swap entry indicat=
es
         * exclusivity.
         */
        if (!folio_test_ksm(folio) &&
            (exclusive || folio_ref_count(folio) =3D=3D 1)) {
                if (vma->vm_flags & VM_WRITE && !userfaultfd_pte_wp(vma, pt=
e)
                    && (!vma_soft_dirty_enabled(vma) || pte_soft_dirty(pte)=
)) {
                        if (vmf->flags & FAULT_FLAG_WRITE) {
                                pte =3D pte_mkwrite(pte_mkdirty(pte), vma);
                                vmf->flags &=3D ~FAULT_FLAG_WRITE;
                        } else {
                                pte =3D pte_mkwrite(pte, vma);
                        }
                }
                rmap_flags |=3D RMAP_EXCLUSIVE;
        }

>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry

