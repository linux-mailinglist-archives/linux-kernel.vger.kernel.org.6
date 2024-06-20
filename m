Return-Path: <linux-kernel+bounces-222404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 176C89100F5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 11:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C9E21F2207C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400F61A8C0A;
	Thu, 20 Jun 2024 09:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1u08AN/"
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10751A4F2B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 09:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718877564; cv=none; b=e04zBAPhU1NdWe9t1Mr7RQtpg+AilMZbY/3X+En+a1ZkxZLthV1gyuxJ7pklGMyJTJ9xHQkFk/ICwAymlgZYhFH4Z7ntJpDBjkOmL79SKhHqCj9cNgJ/duVpdtH4qHaWOjXTivyms/w0R09nl5zo9tXkxr7xfY7rIsP2jRbzcUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718877564; c=relaxed/simple;
	bh=OU9P56BynAVRqLPd/zttdnxapexvVL1Zn8hOTaQTUm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OP9qm0KjkdWDoIHcwrJAoKeokIaJNPUYIFBENHNkgXJeHPZeGob312TMzbeEyOXB24m8ltN6r9O4Jx11LCHpBGkNSSmS/xQe+QnGivI/Wj1gFM9+epb0uITszaHxcNsrUJHARdJMFvtSHivq7kH2J+8+DVVAMIgpOYCEnZ4Fv9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1u08AN/; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-48c52a1f1ffso301444137.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 02:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718877562; x=1719482362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Tcc7+lX11Nm5cTPkOyMHtqR5mEgxrDJNL4NqrIGilo=;
        b=E1u08AN/OxpcRjNQCTCic/XG7Z37IsTfZEncjsQ6V0EhE0bd5RTMW6Yhksvf1okjhs
         kRm/1XzlP7obbDZ+uJ2Ut+SFqSajVnm7D9e3N97HOqkXPuXG/hVka1IkG6mEpCqf8ieX
         S3RdWQx/T+DjrsUhR7hpT9oBxFTIaSgY9avsGGWVIiHY6qGnKattmD05IR6H4RILFswv
         CjLkpsX3oVxqXB/v1s6Js1BapgmD5AGDr9GCJs6uhVya+bH+iOZ6VQ6wkGh4u//q2wYk
         Q+u++utD23l4abzYy0vQXfEMitaZclRGyLNczuQBv0WvYaDTbrLZv58iTyF4mX63fSV6
         Q46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718877562; x=1719482362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Tcc7+lX11Nm5cTPkOyMHtqR5mEgxrDJNL4NqrIGilo=;
        b=I6rjxaT3sVli70+QT0AiAWLvdHdha152yTlZgHG+Vi/8RV04yvs4VrWdd5DGET1B32
         4ku20H/ajGooUNYZXSjdAk/t0YqqGrY3FjA/sj1HRr23GcZnMg9kC8Tj5+CIH4w7KNaR
         oQgVwW4X29/wBZjLD8ycXVg5AE/RjAY6/KowfTu+7tVWrD0DvU7pt3u/Y/SzVf++UMaw
         HT9ZiSVpSXckijUkTkHaC9FQ/PQDfqX8TdsDWsvwtIjZ7BBD/GFiPOc0UnEz4Lh5egXz
         kZ59PObryuHqlAtUfyPRJsETBprd+npVOqGreF7ASobShR07qiFrpvvSDiFP8ij5Lss3
         Pc4g==
X-Forwarded-Encrypted: i=1; AJvYcCWL0m+GWyIXbSvdSqcqA54kgP3DWYM8EyS6/+SrqX1yd9LqzZGAIAWo6TFZoJCemvPX1BMw24dCK20o64grFB4tuKqnqdE+dSA5SBkA
X-Gm-Message-State: AOJu0Yxeja6wUon5yvSygIEFiHQ9bjNhemLCTIgx1/OHib9eazuUZQPF
	Cv9VIGp/08XjoXIl7M8KIHARBBlIxsgeuNbwW3SDWdCswEDe+lV+UzTvGUYhFlutSMXCUuHVftj
	5+RSQUK1QcJ5Q5AHg3pKuJBp474s=
X-Google-Smtp-Source: AGHT+IHStvyPpwhYHeBeKrbIFaO38ncpvlByd+KWdCKTmteNV90f7HZT/549fCwLns8INBy0aB+LXXI0VSEY97bwCes=
X-Received: by 2002:a67:f244:0:b0:48c:3fc7:1ff9 with SMTP id
 ada2fe7eead31-48f1304d665mr4701205137.1.1718877561613; Thu, 20 Jun 2024
 02:59:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617231137.80726-1-21cnbao@gmail.com> <20240617231137.80726-3-21cnbao@gmail.com>
 <f9cb01c2-967f-406c-9304-5e31a82b6b0f@redhat.com> <CAGsJ_4yuBJW578sL5dsKvWP2A=x54zV5b+qbwfy9vj8rFiQM1Q@mail.gmail.com>
 <60a075da-7c7e-4d99-ac52-059e5a17b72e@redhat.com>
In-Reply-To: <60a075da-7c7e-4d99-ac52-059e5a17b72e@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 20 Jun 2024 21:59:10 +1200
Message-ID: <CAGsJ_4xg6z1sy7JoNxf8kAzK_BDGgwFRakLbE_T6MGjk3HnGcA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mm: use folio_add_new_anon_rmap() if folio_test_anon(folio)==false
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, 
	linux-kernel@vger.kernel.org, mhocko@suse.com, ryan.roberts@arm.com, 
	shy828301@gmail.com, surenb@google.com, v-songbaohua@oppo.com, 
	willy@infradead.org, ying.huang@intel.com, yosryahmed@google.com, 
	yuzhao@google.com, Shuai Yuan <yuanshuai@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 8:49=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 20.06.24 10:33, Barry Song wrote:
> > On Thu, Jun 20, 2024 at 7:46=E2=80=AFPM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >> On 18.06.24 01:11, Barry Song wrote:
> >>> From: Barry Song <v-songbaohua@oppo.com>
> >>>
> >>> For the !folio_test_anon(folio) case, we can now invoke folio_add_new=
_anon_rmap()
> >>> with the rmap flags set to either EXCLUSIVE or non-EXCLUSIVE. This ac=
tion will
> >>> suppress the VM_WARN_ON_FOLIO check within __folio_add_anon_rmap() wh=
ile initiating
> >>> the process of bringing up mTHP swapin.
> >>>
> >>>    static __always_inline void __folio_add_anon_rmap(struct folio *fo=
lio,
> >>>                    struct page *page, int nr_pages, struct vm_area_st=
ruct *vma,
> >>>                    unsigned long address, rmap_t flags, enum rmap_lev=
el level)
> >>>    {
> >>>            ...
> >>>            if (unlikely(!folio_test_anon(folio))) {
> >>>                    VM_WARN_ON_FOLIO(folio_test_large(folio) &&
> >>>                                     level !=3D RMAP_LEVEL_PMD, folio)=
;
> >>>            }
> >>>            ...
> >>>    }
> >>>
> >>> It also improves the code=E2=80=99s readability. Currently, all new a=
nonymous
> >>> folios calling folio_add_anon_rmap_ptes() are order-0. This ensures
> >>> that new folios cannot be partially exclusive; they are either entire=
ly
> >>> exclusive or entirely shared.
> >>>
> >>> Suggested-by: David Hildenbrand <david@redhat.com>
> >>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >>> Tested-by: Shuai Yuan <yuanshuai@oppo.com>
> >>> ---
> >>>    mm/memory.c   |  8 ++++++++
> >>>    mm/swapfile.c | 13 +++++++++++--
> >>>    2 files changed, 19 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/mm/memory.c b/mm/memory.c
> >>> index 1f24ecdafe05..620654c13b2f 100644
> >>> --- a/mm/memory.c
> >>> +++ b/mm/memory.c
> >>> @@ -4339,6 +4339,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>>        if (unlikely(folio !=3D swapcache && swapcache)) {
> >>>                folio_add_new_anon_rmap(folio, vma, address, RMAP_EXCL=
USIVE);
> >>>                folio_add_lru_vma(folio, vma);
> >>> +     } else if (!folio_test_anon(folio)) {
> >>> +             /*
> >>> +              * We currently only expect small !anon folios, for whi=
ch we now
> >>> +              * that they are either fully exclusive or fully shared=
. If we
> >>> +              * ever get large folios here, we have to be careful.
> >>> +              */
> >>> +             VM_WARN_ON_ONCE(folio_test_large(folio));
> >>> +             folio_add_new_anon_rmap(folio, vma, address, rmap_flags=
);
> >>>        } else {
> >>>                folio_add_anon_rmap_ptes(folio, page, nr_pages, vma, a=
ddress,
> >>>                                        rmap_flags);
> >>> diff --git a/mm/swapfile.c b/mm/swapfile.c
> >>> index ae1d2700f6a3..69efa1a57087 100644
> >>> --- a/mm/swapfile.c
> >>> +++ b/mm/swapfile.c
> >>> @@ -1908,8 +1908,17 @@ static int unuse_pte(struct vm_area_struct *vm=
a, pmd_t *pmd,
> >>>                VM_BUG_ON_FOLIO(folio_test_writeback(folio), folio);
> >>>                if (pte_swp_exclusive(old_pte))
> >>>                        rmap_flags |=3D RMAP_EXCLUSIVE;
> >>> -
> >>> -             folio_add_anon_rmap_pte(folio, page, vma, addr, rmap_fl=
ags);
> >>> +             /*
> >>> +              * We currently only expect small !anon folios, for whi=
ch we now that
> >>> +              * they are either fully exclusive or fully shared. If =
we ever get
> >>> +              * large folios here, we have to be careful.
> >>> +              */
> >>> +             if (!folio_test_anon(folio)) {
> >>> +                     VM_WARN_ON_ONCE(folio_test_large(folio));
> >>
> >> (comment applies to both cases)
> >>
> >> Thinking about Hugh's comment, we should likely add here:
> >>
> >> VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
> >>
> >> [the check we are removing from __folio_add_anon_rmap()]
> >>
> >> and document for folio_add_new_anon_rmap() in patch #1, that when
> >> dealing with folios that might be mapped concurrently by others, the
> >> folio lock must be held.
> >
> > I assume you mean something like the following for patch#1?
> >
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index df1a43295c85..20986b25f1b2 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1394,7 +1394,8 @@ void folio_add_anon_rmap_pmd(struct folio
> > *folio, struct page *page,
> >    *
> >    * Like folio_add_anon_rmap_*() but must only be called on *new* foli=
os.
> >    * This means the inc-and-test can be bypassed.
> > - * The folio does not have to be locked.
> > + * The folio doesn't necessarily need to be locked while it's
> > exclusive unless two threads
> > + * map it concurrently. However, the folio must be locked if it's shar=
ed.
> >    *
> >    * If the folio is pmd-mappable, it is accounted as a THP.
> >    */
> > @@ -1406,6 +1407,7 @@ void folio_add_new_anon_rmap(struct folio
> > *folio, struct vm_area_struct *vma,
> >          int nr_pmdmapped =3D 0;
> >
> >          VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
> > +       VM_WARN_ON_FOLIO(!exclusive && !folio_test_locked(folio), folio=
);
>
> For now this would likely do. I was concerned about a concurrent
> scenario in the exclusive case, but that shouldn't really happen I guess.
>

Since this is primarily a documentation update, I'll wait for two or
three days to see if
there are any more Linux-next reports before sending v3 combining these fix=
es
together(I've already fixed another doc warn reported by lkp) and seek Andr=
ew's
assistance to drop v2 and apply v3.

> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry

