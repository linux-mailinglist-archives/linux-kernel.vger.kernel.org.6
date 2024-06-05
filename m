Return-Path: <linux-kernel+bounces-202781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C878FD0FA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A7971F26B7F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 14:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14874208D1;
	Wed,  5 Jun 2024 14:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fr1Q5aPk"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FFC19D8BE
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 14:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717598440; cv=none; b=OLXaWJAecFzRkVofKOWB/P06txh3i3BaY5SvF0nY/ywCMcfuLL4yRJh5Z2lOdO3miSdQEMAM644IS2kqRanSyjmRnxmKjOz1WtP++qv26FOsXjQGob2uEnfTvf08Ka3cWxHcB/lG9tuyCk67QC4/Ex91BYMsFfzVGcIqk47UYaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717598440; c=relaxed/simple;
	bh=4ckaaGEKU0bnqyjAnB76jWB9HaZqPAp0tPWrSiZqfUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iGxUGICDLUirabAykjOePcIu0LNUJE3ZAa2yy0M3B36ci8s1+/5geDcIOIk8HR+RP4RxcCH7eSWDWb0STRY++e1nYpX3XEqnPTdkU6ffNXovFozcYOMAZUPGBsBQaEzHf9/1Z3X0x61p1iIRP4igFcnEEj/Ap4JzBeYiu+iZ9PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fr1Q5aPk; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a690c8e64bdso1845566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 07:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717598436; x=1718203236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dXP8W3T7Khl5483XJNQT88inD0u+g8r/CZGBhw3b8s=;
        b=fr1Q5aPk1w2vdYyWcZiur4newnBrlPEdrLIKQW43wYoIWeiUQ5IlZR1a65KiICxBF1
         mZfm1dTMsYbRye8IIIKIjvIDSIF4rhAcNNPVZCMNlWQ9AKbzfGqBhhP0zX3jY0FrKKXj
         hj8k/305p/LKlcCglDBaCCDXOsU9HjKnP5NgjVM+/ASbZrqCEjKfOPSv+q7RC4Ab0/QF
         XaUHUkKyYCyf+pLVGUvbyqWBgDDoCcaJq2jmTLXRGGLQgpT6aFCcRqqFBIRjBb5sebG7
         kytB4gnQ/mw6uDupeljEnH01KshpHf3S82Ztxt5gRXMSRZiMtKL+RrV3ChpNOy+XGaOd
         7H+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717598436; x=1718203236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dXP8W3T7Khl5483XJNQT88inD0u+g8r/CZGBhw3b8s=;
        b=gYUJnEyTDLVeSRM+Rv18mm+29axRyafd8MMtcSG1yln5CRUxIB4d44IGzcDdwFXaHw
         Cw+kFdjUdq0xdD+qcONE4sAjT6A7aeKXCf2t0J6wFeTjZwNVJdUiWCV5xW7DfD7EPou4
         HwwMI5Szh3AxTs55veIi4VpOjoDrCJQ2e3VyazEc3vWbIbLMls+Jq6LjYPquLH6LWgzc
         jRMgaMxyHBbfzORv5sOcnry33yLEM6mKjOJ1NhLmjiOOEnLdg4mhYgvD/QlprvjGziTS
         gtsc8vqzZknKaSD+dnsd7FraEcS5vshDUOBnz3FwB4Dua1XK6sDqvOy9J5aUnFhoguYM
         iBHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWzfh6dU9zx83TXVtAZBq0o95Mea8KN9Cjo168AwA7s4cbRom0KP2tz+iEMyzN4bnzbd3xUAFUWererHdO92USkQ1s9E50RUd4gTZm
X-Gm-Message-State: AOJu0Yze59zrWGlYWzPSg3+nNTYQ5CmAReSeB0JCjrKIepdvu3MJChcq
	xULwaUURkZPc9wH8mV4kQYIGqX63EbsaAuZoTVIVM9JiFBvTaATsqGIORGc/YSU3+ly2E/g7XLG
	GncWj9NqFCB10lTHQFM9z/GrFMhM=
X-Google-Smtp-Source: AGHT+IFwftgmzPekvVa7FJHoK6b0fzuiY+Cg308D6F7IsLWcswNUE9qQYgOuUutwb9XcdJO3S2TOTvX2OQeXZJElVhQ=
X-Received: by 2002:a50:8e1c:0:b0:57a:1c24:8b9 with SMTP id
 4fb4d7f45d1cf-57a8bc9bd05mr2346508a12.29.1717598436213; Wed, 05 Jun 2024
 07:40:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521040244.48760-1-ioworker0@gmail.com> <20240521040244.48760-4-ioworker0@gmail.com>
 <ede2a2ad-1046-4967-a930-692cfa829c7b@redhat.com>
In-Reply-To: <ede2a2ad-1046-4967-a930-692cfa829c7b@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Wed, 5 Jun 2024 22:40:24 +0800
Message-ID: <CAK1f24=n308-uTumWHP=kRVqdbwVoBsX3eB00LDFk05x0JXm7g@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] mm/vmscan: avoid split lazyfree THP during shrink_folio_list()
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, sj@kernel.org, 
	baolin.wang@linux.alibaba.com, maskray@google.com, ziy@nvidia.com, 
	ryan.roberts@arm.com, 21cnbao@gmail.com, mhocko@suse.com, 
	fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com, 
	xiehuan09@gmail.com, libang.li@antgroup.com, wangkefeng.wang@huawei.com, 
	songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

Thanks for taking time to review!

On Wed, Jun 5, 2024 at 8:50=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 21.05.24 06:02, Lance Yang wrote:
> > When the user no longer requires the pages, they would use
> > madvise(MADV_FREE) to mark the pages as lazy free. Subsequently, they
> > typically would not re-write to that memory again.
> >
> > During memory reclaim, if we detect that the large folio and its PMD ar=
e
> > both still marked as clean and there are no unexpected references
> > (such as GUP), so we can just discard the memory lazily, improving the
> > efficiency of memory reclamation in this case.
> >
> > On an Intel i5 CPU, reclaiming 1GiB of lazyfree THPs using
> > mem_cgroup_force_empty() results in the following runtimes in seconds
> > (shorter is better):
> >
> > --------------------------------------------
> > |     Old       |      New       |  Change  |
> > --------------------------------------------
> > |   0.683426    |    0.049197    |  -92.80% |
> > --------------------------------------------
> >
> > Suggested-by: Zi Yan <ziy@nvidia.com>
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > ---
> >   include/linux/huge_mm.h |  9 +++++
> >   mm/huge_memory.c        | 80 ++++++++++++++++++++++++++++++++++++++++=
+
> >   mm/rmap.c               | 41 ++++++++++++++-------
> >   3 files changed, 117 insertions(+), 13 deletions(-)
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 9fcb0b0b6ed1..cfd7ec2b6d0a 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -411,6 +411,8 @@ static inline bool thp_migration_supported(void)
> >
> >   void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long =
address,
> >                          pmd_t *pmd, bool freeze, struct folio *folio);
> > +bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long a=
ddr,
> > +                        pmd_t *pmdp, struct folio *folio);
> >
> >   #else /* CONFIG_TRANSPARENT_HUGEPAGE */
> >
> > @@ -478,6 +480,13 @@ static inline void split_huge_pmd_locked(struct vm=
_area_struct *vma,
> >                                        unsigned long address, pmd_t *pm=
d,
> >                                        bool freeze, struct folio *folio=
) {}
> >
> > +static inline bool unmap_huge_pmd_locked(struct vm_area_struct *vma,
> > +                                      unsigned long addr, pmd_t *pmdp,
> > +                                      struct folio *folio)
> > +{
> > +     return false;
> > +}
> > +
> >   #define split_huge_pud(__vma, __pmd, __address)     \
> >       do { } while (0)
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 425272c6c50b..4793ffa912ca 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2687,6 +2687,86 @@ static void unmap_folio(struct folio *folio)
> >       try_to_unmap_flush();
> >   }
> >
> > +static bool __discard_trans_pmd_locked(struct vm_area_struct *vma,
>
> Can we move towards folio terminology?
>
> __discard_anon_folio_pmd_locked() or sth like that?

Nice, it's much clearer!

>
> > +                                    unsigned long addr, pmd_t *pmdp,
> > +                                    struct folio *folio)
> > +{
> > +     VM_WARN_ON_FOLIO(folio_test_swapbacked(folio), folio);
> > +     VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
> > +
> > +     struct mm_struct *mm =3D vma->vm_mm;
> > +     int ref_count, map_count;
> > +     pmd_t orig_pmd =3D *pmdp;
> > +     struct page *page;
> > +
> > +     if (unlikely(!pmd_present(orig_pmd) || !pmd_trans_huge(orig_pmd))=
)
> > +             return false;
> > +
> > +     page =3D pmd_page(orig_pmd);
> > +     if (unlikely(page_folio(page) !=3D folio))
> > +             return false;
> > +
> > +     if (folio_test_dirty(folio) || pmd_dirty(orig_pmd)) {
> > +             folio_set_swapbacked(folio);
> > +             return false;
> > +     }
> > +
> > +     orig_pmd =3D pmdp_huge_clear_flush(vma, addr, pmdp);
> > +
> > +     /*
> > +      * Syncing against concurrent GUP-fast:
> > +      * - clear PMD; barrier; read refcount
> > +      * - inc refcount; barrier; read PMD
> > +      */
> > +     smp_mb();
> > +
> > +     ref_count =3D folio_ref_count(folio);
> > +     map_count =3D folio_mapcount(folio);
> > +
> > +     /*
> > +      * Order reads for folio refcount and dirty flag
> > +      * (see comments in __remove_mapping()).
> > +      */
> > +     smp_rmb();
> > +
> > +     /*
> > +      * If the folio or its PMD is redirtied at this point, or if ther=
e
> > +      * are unexpected references, we will give up to discard this fol=
io
> > +      * and remap it.
> > +      *
> > +      * The only folio refs must be one from isolation plus the rmap(s=
).
> > +      */
> > +     if (folio_test_dirty(folio) || pmd_dirty(orig_pmd))
> > +             folio_set_swapbacked(folio);
> > +
> > +     if (folio_test_swapbacked(folio) || ref_count !=3D map_count + 1)=
 {
> > +             set_pmd_at(mm, addr, pmdp, orig_pmd);
> > +             return false;
> > +     }
> > +
> > +     folio_remove_rmap_pmd(folio, page, vma);
> > +     zap_deposited_table(mm, pmdp);
> > +     add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);
> > +     if (vma->vm_flags & VM_LOCKED)
> > +             mlock_drain_local();
> > +     folio_put(folio);
> > +
> > +     return true;
> > +}
> > +
> > +bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long a=
ddr,
> > +                        pmd_t *pmdp, struct folio *folio)
> > +{
> > +     VM_WARN_ON_FOLIO(!folio_test_pmd_mappable(folio), folio);
> > +     VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
> > +     VM_WARN_ON_ONCE(!IS_ALIGNED(addr, HPAGE_PMD_SIZE));
> > +
> > +     if (folio_test_anon(folio) && !folio_test_swapbacked(folio))
> > +             return __discard_trans_pmd_locked(vma, addr, pmdp, folio)=
;
> > +
> > +     return false;
> > +}
> > +
> >   static void remap_page(struct folio *folio, unsigned long nr)
> >   {
> >       int i =3D 0;
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index 08a93347f283..249d6e305bec 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1630,6 +1630,7 @@ static bool try_to_unmap_one(struct folio *folio,=
 struct vm_area_struct *vma,
> >       enum ttu_flags flags =3D (enum ttu_flags)(long)arg;
> >       unsigned long pfn;
> >       unsigned long hsz =3D 0;
> > +     bool pmd_mapped =3D false;
> >
> >       /*
> >        * When racing against e.g. zap_pte_range() on another cpu,
> > @@ -1677,18 +1678,26 @@ static bool try_to_unmap_one(struct folio *foli=
o, struct vm_area_struct *vma,
> >                       goto walk_done_err;
> >               }
> >
> > -             if (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)) {
> > -                     /*
> > -                      * We temporarily have to drop the PTL and start =
once
> > -                      * again from that now-PTE-mapped page table.
> > -                      */
> > -                     split_huge_pmd_locked(vma, range.start, pvmw.pmd,=
 false,
> > -                                           folio);
> > -                     pvmw.pmd =3D NULL;
> > -                     spin_unlock(pvmw.ptl);
> > -                     pvmw.ptl =3D NULL;
> > -                     flags &=3D ~TTU_SPLIT_HUGE_PMD;
> > -                     continue;
> > +             if (!pvmw.pte) {
> > +                     pmd_mapped =3D true;
> > +                     if (unmap_huge_pmd_locked(vma, range.start, pvmw.=
pmd,
> > +                                               folio))
> > +                             goto walk_done;
> > +
> > +                     if (flags & TTU_SPLIT_HUGE_PMD) {
> > +                             /*
> > +                              * We temporarily have to drop the PTL an=
d start
> > +                              * once again from that now-PTE-mapped pa=
ge
> > +                              * table.
> > +                              */
> > +                             split_huge_pmd_locked(vma, range.start,
> > +                                                   pvmw.pmd, false, fo=
lio);
> > +                             pvmw.pmd =3D NULL;
> > +                             spin_unlock(pvmw.ptl);
> > +                             pvmw.ptl =3D NULL;
> > +                             flags &=3D ~TTU_SPLIT_HUGE_PMD;
> > +                             continue;
> > +                     }
> >               }
> >
> >               /* Unexpected PMD-mapped THP? */
> > @@ -1816,7 +1825,13 @@ static bool try_to_unmap_one(struct folio *folio=
, struct vm_area_struct *vma,
> >                        */
> >                       if (unlikely(folio_test_swapbacked(folio) !=3D
> >                                       folio_test_swapcache(folio))) {
> > -                             WARN_ON_ONCE(1);
> > +                             /*
> > +                              * unmap_huge_pmd_locked() will unmark a
> > +                              * PMD-mapped folio as lazyfree if the fo=
lio or
> > +                              * its PMD was redirtied.
> > +                              */
> > +                             if (!pmd_mapped)
>
> Isn't that simply "pvmw.pte" ?
>
> Also,
>
> WARN_ON_ONCE(!pmd_mapped);

Good catch! I'll adjust as you suggested.

Thanks again for the review!
Lance

>
> > +                                     WARN_ON_ONCE(1);
> >                               goto walk_done_err;
> >                       }
> >
>
> --
> Cheers,
>
> David / dhildenb
>

