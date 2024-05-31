Return-Path: <linux-kernel+bounces-196779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B381A8D61C1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF0EB1C244AD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05ADC158855;
	Fri, 31 May 2024 12:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hp6XCIzj"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B161586C4
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717158638; cv=none; b=bau1pYnKS2x1JAx7o323K9+4uvSg4yROg/3ccg3cFmT7uwBspLsVz70q/VWF/wV/ppY0zKqC8g5pWoVc5W/FXFQV2sBR/EviYvnf/Kj6zNW/Y3ot46b3tzLr0KJwOjL6G8tdicwEGVVnbx9JNZpsJianCYtCK7WLNmXKOfxWy7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717158638; c=relaxed/simple;
	bh=Mr72enCel7LQ06KMcZmS4q5jw0z5xWmKZ97M5iPHoB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ShCAlqDpS+IPq8F6mIxHhuR7v4R34osn5uYJe8wNYkiQzxnx417O9wzvMHzDwzen5dnyG5DpCsFhtIJaJUyCsayTpwqLai1UvdbGVakQW5dbkQA+bCz61yc+FDkkpXzSxl9eWskTuD/ADpfvoYT6wnG6DsA62apwpRBfmU/W6mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hp6XCIzj; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-80ac969db43so509737241.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 05:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717158635; x=1717763435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqCPiV40FRCqL5KZ/1CQ42Axiq6JU3nKj3bRIMUuHKc=;
        b=hp6XCIzjmisYZxO+/W8QmrELbrPvYILDhG5g9eMpZ8hGYB8yf8SaQN19BC8iWXHt5h
         ViviWejx/7D/QdwUlfn1tMbfwG+rW5YLapbSRwT1YkVlEsvukFCETE0NWL7vDeNb4UwH
         QzrXo6iuIqGmMe0WfNmVrFfkPIXKHkdLX/C/8TIoIPJl1VmyEAjugeB9uS9bktJly5+c
         kAiOD8Z3d6q07PWPv58pTLiA0raZe4B5mnf9S2pJvPEC8AICiaZHxXJcibvkAHfhR0/S
         CGp34Y+ggr1srlzAO4fPeSfRokCOX/HthV9ei2T/3sxJ+WdU444V8Ykf2TN/0bS4eMA2
         cJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717158635; x=1717763435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MqCPiV40FRCqL5KZ/1CQ42Axiq6JU3nKj3bRIMUuHKc=;
        b=EvPP1t7/Q+EvOwiR3hZ9pSHDSgXqoUUfGXtsO5RKpTPjrVEP5zgeZKwaS8+qTVxCPM
         bhfsQZ669Fy4vZaeLXfIeLeJ6Zu0/g6psZ0IG57yNn6N0N3V8ocVNc4GT0KD2KaAA8AU
         GS4XhgvPXHvlvAYNZBtMKAmYLUHsEDhk8nSyV73vTdybJh5fZG3bFMZmCM/QW30wUaM9
         agQ5ut5MvLsKCT8l1B5qDUcWMEfdsnm031sobSFqruOoXrZenBFXGr5nafQlqm29QvsL
         rxIPjfWZVTcbHQzCAmKUIg+pEOY8zSqrkKnuq7cxgZDN7QAfA4/Jp4tO0ndIwWvs9n8M
         7zuQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/RNHyAvZAVw7Uik4Qs/PdO0vT2TFibShF90CmtBw/vQoPmHjxn74V2BUT0z7NhlCHa+w5RG0XL5LO0qErqNu5dN1QfHw69FxmkmMv
X-Gm-Message-State: AOJu0Yxx1KfhPZil2z+3+EKd+9ePAiVJEqtaw1Rza6THUDk1Hmq2CSX7
	HvWa0CEjWHwjMXCWVajikhTXOotQreUbzeqA1D7tRia6wdWkt6kHf+ITDijYwjqlVKH4UBT3UgY
	W48BVjR1A8ESxbAolco7bihkovZY=
X-Google-Smtp-Source: AGHT+IF4M93lrQW5Fsa+giSnqh14rcaRZpYxJ+MPoqduDV6r4sAWty6AusRycWj39BSyyyaDQIlbZEOxnzHCdJzk6Yc=
X-Received: by 2002:a67:ef84:0:b0:47f:251c:61df with SMTP id
 ada2fe7eead31-48bc23b40d2mr1662359137.27.1717158633456; Fri, 31 May 2024
 05:30:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531104819.140218-1-21cnbao@gmail.com> <87ac9610-5650-451f-aa54-e634a6310af4@redhat.com>
 <CAGsJ_4zgf8j0oRnVBhe-__=K2RFDHTCo-JnMak95HTvxtMUwnQ@mail.gmail.com>
 <d4c1a9ad-4945-40d7-9b7a-5b02df805884@redhat.com> <CAGsJ_4xpDwTTbwzMx8ipmpCyNmVmABpRN1f9yfZfFiOaGMKiew@mail.gmail.com>
In-Reply-To: <CAGsJ_4xpDwTTbwzMx8ipmpCyNmVmABpRN1f9yfZfFiOaGMKiew@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 1 Jun 2024 00:30:22 +1200
Message-ID: <CAGsJ_4yX52k=Wx2x3jwXzNBG=rDGJrzGNwGCAh0puUP7zby=QA@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: swap: reuse exclusive folio directly instead of
 wp page faults
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, chrisl@kernel.org, 
	surenb@google.com, kasong@tencent.com, minchan@kernel.org, 
	willy@infradead.org, ryan.roberts@arm.com, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 1, 2024 at 12:20=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Sat, Jun 1, 2024 at 12:10=E2=80=AFAM David Hildenbrand <david@redhat.c=
om> wrote:
> >
> > On 31.05.24 13:55, Barry Song wrote:
> > > On Fri, May 31, 2024 at 11:08=E2=80=AFPM David Hildenbrand <david@red=
hat.com> wrote:
> > >>
> > >> On 31.05.24 12:48, Barry Song wrote:
> > >>> From: Barry Song <v-songbaohua@oppo.com>
> > >>>
> > >>> After swapping out, we perform a swap-in operation. If we first rea=
d
> > >>> and then write, we encounter a major fault in do_swap_page for read=
ing,
> > >>> along with additional minor faults in do_wp_page for writing. Howev=
er,
> > >>> the latter appears to be unnecessary and inefficient. Instead, we c=
an
> > >>> directly reuse in do_swap_page and completely eliminate the need fo=
r
> > >>> do_wp_page.
> > >>>
> > >>> This patch achieves that optimization specifically for exclusive fo=
lios.
> > >>> The following microbenchmark demonstrates the significant reduction=
 in
> > >>> minor faults.
> > >>>
> > >>>    #define DATA_SIZE (2UL * 1024 * 1024)
> > >>>    #define PAGE_SIZE (4UL * 1024)
> > >>>
> > >>>    static void *read_write_data(char *addr)
> > >>>    {
> > >>>            char tmp;
> > >>>
> > >>>            for (int i =3D 0; i < DATA_SIZE; i +=3D PAGE_SIZE) {
> > >>>                    tmp =3D *(volatile char *)(addr + i);
> > >>>                    *(volatile char *)(addr + i) =3D tmp;
> > >>>            }
> > >>>    }
> > >>>
> > >>>    int main(int argc, char **argv)
> > >>>    {
> > >>>            struct rusage ru;
> > >>>
> > >>>            char *addr =3D mmap(NULL, DATA_SIZE, PROT_READ | PROT_WR=
ITE,
> > >>>                            MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> > >>>            memset(addr, 0x11, DATA_SIZE);
> > >>>
> > >>>            do {
> > >>>                    long old_ru_minflt, old_ru_majflt;
> > >>>                    long new_ru_minflt, new_ru_majflt;
> > >>>
> > >>>                    madvise(addr, DATA_SIZE, MADV_PAGEOUT);
> > >>>
> > >>>                    getrusage(RUSAGE_SELF, &ru);
> > >>>                    old_ru_minflt =3D ru.ru_minflt;
> > >>>                    old_ru_majflt =3D ru.ru_majflt;
> > >>>
> > >>>                    read_write_data(addr);
> > >>>                    getrusage(RUSAGE_SELF, &ru);
> > >>>                    new_ru_minflt =3D ru.ru_minflt;
> > >>>                    new_ru_majflt =3D ru.ru_majflt;
> > >>>
> > >>>                    printf("minor faults:%ld major faults:%ld\n",
> > >>>                            new_ru_minflt - old_ru_minflt,
> > >>>                            new_ru_majflt - old_ru_majflt);
> > >>>            } while(0);
> > >>>
> > >>>            return 0;
> > >>>    }
> > >>>
> > >>> w/o patch,
> > >>> / # ~/a.out
> > >>> minor faults:512 major faults:512
> > >>>
> > >>> w/ patch,
> > >>> / # ~/a.out
> > >>> minor faults:0 major faults:512
> > >>>
> > >>> Minor faults decrease to 0!
> > >>>
> > >>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > >>> ---
> > >>>    mm/memory.c | 7 ++++---
> > >>>    1 file changed, 4 insertions(+), 3 deletions(-)
> > >>>
> > >>> diff --git a/mm/memory.c b/mm/memory.c
> > >>> index eef4e482c0c2..e1d2e339958e 100644
> > >>> --- a/mm/memory.c
> > >>> +++ b/mm/memory.c
> > >>> @@ -4325,9 +4325,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf=
)
> > >>>         */
> > >>>        if (!folio_test_ksm(folio) &&
> > >>>            (exclusive || folio_ref_count(folio) =3D=3D 1)) {
> > >>> -             if (vmf->flags & FAULT_FLAG_WRITE) {
> > >>> -                     pte =3D maybe_mkwrite(pte_mkdirty(pte), vma);
> > >>> -                     vmf->flags &=3D ~FAULT_FLAG_WRITE;
> > >>> +             if (vma->vm_flags & VM_WRITE) {
> > >>> +                     pte =3D pte_mkwrite(pte_mkdirty(pte), vma);
> > >>> +                     if (vmf->flags & FAULT_FLAG_WRITE)
> > >>> +                             vmf->flags &=3D ~FAULT_FLAG_WRITE;
> > >>
> > >> This implies, that even on a read fault, you would mark the pte dirt=
y
> > >> and it would have to be written back to swap if still in the swap ca=
che
> > >> and only read.
> > >>
> > >> That is controversial.
> > >>
> > >> What is less controversial is doing what mprotect() via
> > >> change_pte_range()/can_change_pte_writable() would do: mark the PTE
> > >> writable but not dirty.
> > >>
> > >> I suggest setting the pte only dirty if FAULT_FLAG_WRITE is set.
> > >
> > > Thanks!
> > >
> > > I assume you mean something as below?
> >
> > It raises an important point: uffd-wp must be handled accordingly.
> >
> > >
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index eef4e482c0c2..dbf1ba8ccfd6 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -4317,6 +4317,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> > >          add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
> > >          pte =3D mk_pte(page, vma->vm_page_prot);
> > >
> > > +       if (pte_swp_soft_dirty(vmf->orig_pte))
> > > +               pte =3D pte_mksoft_dirty(pte);
> > > +       if (pte_swp_uffd_wp(vmf->orig_pte))
> > > +               pte =3D pte_mkuffd_wp(pte);
> > >          /*
> > >           * Same logic as in do_wp_page(); however, optimize for page=
s that are
> > >           * certainly not shared either because we just allocated the=
m without
> > > @@ -4325,18 +4329,19 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> > >           */
> > >          if (!folio_test_ksm(folio) &&
> > >              (exclusive || folio_ref_count(folio) =3D=3D 1)) {
> > > -               if (vmf->flags & FAULT_FLAG_WRITE) {
> > > -                       pte =3D maybe_mkwrite(pte_mkdirty(pte), vma);
> > > -                       vmf->flags &=3D ~FAULT_FLAG_WRITE;
> > > +               if (vma->vm_flags & VM_WRITE) {
> > > +                       if (vmf->flags & FAULT_FLAG_WRITE) {
> > > +                               pte =3D pte_mkwrite(pte_mkdirty(pte),=
 vma);
> > > +                               vmf->flags &=3D ~FAULT_FLAG_WRITE;
> > > +                       } else if ((!vma_soft_dirty_enabled(vma) ||
> > > pte_soft_dirty(pte))
> > > +                                   && !userfaultfd_pte_wp(vma, pte))=
 {
> > > +                                       pte =3D pte_mkwrite(pte, vma)=
;
> >
> > Even with FAULT_FLAG_WRITE we must respect uffd-wp and *not* do a
> > pte_mkwrite(pte). So we have to catch and handle that earlier (I could
> > have sworn we handle that somehow).
> >
> > Note that the existing
> >         pte =3D pte_mkuffd_wp(pte);
> >
> > Will fix that up because it does an implicit pte_wrprotect().
>
> This is exactly what I have missed as I am struggling with why WRITE_FAUL=
T
> blindly does mkwrite without checking userfaultfd_pte_wp().
>
> >
> >
> > So maybe what would work is
> >
> >
> > if ((vma->vm_flags & VM_WRITE) && !userfaultfd_pte_wp(vma, pte) &&
> >      !vma_soft_dirty_enabled(vma)) {
> >         pte =3D pte_mkwrite(pte);
> >
> >         /* Only set the PTE dirty on write fault. */
> >         if (vmf->flags & FAULT_FLAG_WRITE) {
> >                 pte =3D pte_mkdirty(pte);
> >                 vmf->flags &=3D ~FAULT_FLAG_WRITE;
> >         }

WRITE_FAULT has a pte_mkdirty, so it doesn't need to check
"!vma_soft_dirty_enabled(vma)"?
Maybe I thought too much, just the simple code below should work?

        if (!folio_test_ksm(folio) &&
            (exclusive || folio_ref_count(folio) =3D=3D 1)) {
                if (vma->vm_flags & VM_WRITE) {
                        if (vmf->flags & FAULT_FLAG_WRITE) {
                                pte =3D pte_mkwrite(pte_mkdirty(pte), vma);
                                vmf->flags &=3D ~FAULT_FLAG_WRITE;
                        } else {
                                pte =3D pte_mkwrite(pte, vma);
                        }
                }
                rmap_flags |=3D RMAP_EXCLUSIVE;
        }

        if (pte_swp_soft_dirty(vmf->orig_pte))
                pte =3D pte_mksoft_dirty(pte);
        if (pte_swp_uffd_wp(vmf->orig_pte))
                pte =3D pte_mkuffd_wp(pte);

This still uses the implicit wrprotect of pte_mkuffd_wp.

> > }
> >
>
> looks good!
>
> > --
> > Cheers,
> >
> > David / dhildenb
> >
>
> Thanks
> Barry

