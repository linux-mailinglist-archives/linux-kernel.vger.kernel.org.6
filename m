Return-Path: <linux-kernel+bounces-292768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB42295740E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 21:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0B271C20CA6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5616F1990B2;
	Mon, 19 Aug 2024 19:00:19 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CB1198A37;
	Mon, 19 Aug 2024 19:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724094018; cv=none; b=munt1ywKvnMbDoVeD5twSzj5c/RVMcyiUk6fOrwqh4gzzHjYcSB6QjysdCji8u5O362dZpHCTlzC4C9mjxGaDYbWh9m1Tduf+g1Qbkg467QgJPSgQ69yraVEp5O798Nm/g/wFiXeA3jjAA0c2xwjp6a1/xZBzo5Y7aP6jSUKkg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724094018; c=relaxed/simple;
	bh=UtxkLNWso+6PDK/qPMqiWXkYvoB5IMMTkcQgsdcH1RQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mMw5O+6G4ODBGaMMngbw8ea1SZ6iAT/9c3ysmFQnSOx8ZXLIjAIqn2ZukPa8rdstFoTDYng9jkF0aqXs1Ic7oVJ6Cs5PcF3HnpZuTssuX8gSv/Xzn++ubbbfzUeRn9Bbhk/CIBJX1GoAV1uj07BcMjSqS53onAQWLBdkW4IhIuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a3375015f8so329093085a.1;
        Mon, 19 Aug 2024 12:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724094015; x=1724698815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8F6Nydj3yEfTP1phJ/fYlgauLlLfmFz/dc96wAQKWY=;
        b=Wz0RJS0KDPH/JQsENNjv0LG0qo6gDtE7ERPZbIJBI1HZyBcxjrWDHN1bhHnJdrCle8
         eni/5fcPHw/LVMXDioEtMkeHpTS5aXcukIVCzo5nc1xbupepyGCzpDN7uc70IZ77SWx8
         oXtOsfwHLvf/Hw/zJogA7+xJtGLKqBmFSA2+GmLLdwIAhT/rMgL+ugopGwN7o0KlI8+W
         CldmDp2dtOKp/tiAxvJo2FendaOubKRVJFPlkZIQEPnPUlmOxDU63beLFRb3TsF2OQc0
         uTNnKU2V1GZLNCQWj3VYrZ2JezZ74T9cP0mYwnz1AfC56GaE0WIUdFkKeCmmdxy6HK2M
         9w7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVB9c/CDtdUygQZIHUKnpc6XrhfrVjP8P4O/zvILgdjEgZdbCI/mpNnn9eUAxhVA72TgNm2t28p83Ai2pFdQUVfKqz18mZ9ojE31+SCpZv73ENo7yTunWFLTDaCcK2OLbZ2foKOK0M9
X-Gm-Message-State: AOJu0Yw2L4SKYZZgi0/M81aCW6EQgvijDHU/WBv7E1g+M3yeBbtK+1ja
	F5+EnTvI2MsrVtN/deyq41i4A8gu8y/OSDgtHxU7DJueiGOyyFwn6SAWYr7u58uUdirgQeSyWrh
	q/jIlLzaJKQV/2BMASAqBk51uIOY=
X-Google-Smtp-Source: AGHT+IHeBtHMm1l2+gHNOdhm9JSOpinboSXGzjArPcNWUeX4B+C8eMaR9wfrA7a5dVtS3Etzoz9NWCzl+QtNevqSeHA=
X-Received: by 2002:a05:6214:469f:b0:6bd:88d5:fa87 with SMTP id
 6a1803df08f44-6bf7ce9cdb6mr175109976d6.55.1724094015061; Mon, 19 Aug 2024
 12:00:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819023145.2415299-1-usamaarif642@gmail.com>
 <20240819023145.2415299-5-usamaarif642@gmail.com> <CAGsJ_4yKuvMSazWABXqaeRr84hLEubET0nCUhPFYHQnfR4Tm8w@mail.gmail.com>
 <a09b6af0-4fdb-4ac1-9cbe-9b422ebc3308@gmail.com>
In-Reply-To: <a09b6af0-4fdb-4ac1-9cbe-9b422ebc3308@gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Tue, 20 Aug 2024 07:00:01 +1200
Message-ID: <CAGsJ_4xeWt9n3zX3-DknE=NftkWS0fe2vKTJT9tLuJPM4EaEwg@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] mm: Introduce a pageflag for partially mapped folios
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	riel@surriel.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev, 
	yuzhao@google.com, david@redhat.com, ryan.roberts@arm.com, rppt@kernel.org, 
	willy@infradead.org, cerasuolodomenico@gmail.com, ryncsn@gmail.com, 
	corbet@lwn.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 2:17=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 19/08/2024 09:29, Barry Song wrote:
> > Hi Usama,
> >
> > I feel it is much better now! thanks!
> >
> > On Mon, Aug 19, 2024 at 2:31=E2=80=AFPM Usama Arif <usamaarif642@gmail.=
com> wrote:
> >>
> >> Currently folio->_deferred_list is used to keep track of
> >> partially_mapped folios that are going to be split under memory
> >> pressure. In the next patch, all THPs that are faulted in and collapse=
d
> >> by khugepaged are also going to be tracked using _deferred_list.
> >>
> >> This patch introduces a pageflag to be able to distinguish between
> >> partially mapped folios and others in the deferred_list at split time =
in
> >> deferred_split_scan. Its needed as __folio_remove_rmap decrements
> >> _mapcount, _large_mapcount and _entire_mapcount, hence it won't be
> >> possible to distinguish between partially mapped folios and others in
> >> deferred_split_scan.
> >>
> >> Eventhough it introduces an extra flag to track if the folio is
> >> partially mapped, there is no functional change intended with this
> >> patch and the flag is not useful in this patch itself, it will
> >> become useful in the next patch when _deferred_list has non partially
> >> mapped folios.
> >>
> >> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> >> ---
> >>  include/linux/huge_mm.h    |  4 ++--
> >>  include/linux/page-flags.h | 11 +++++++++++
> >>  mm/huge_memory.c           | 23 ++++++++++++++++-------
> >>  mm/internal.h              |  4 +++-
> >>  mm/memcontrol.c            |  3 ++-
> >>  mm/migrate.c               |  3 ++-
> >>  mm/page_alloc.c            |  5 +++--
> >>  mm/rmap.c                  |  5 +++--
> >>  mm/vmscan.c                |  3 ++-
> >>  9 files changed, 44 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> >> index 4c32058cacfe..969f11f360d2 100644
> >> --- a/include/linux/huge_mm.h
> >> +++ b/include/linux/huge_mm.h
> >> @@ -321,7 +321,7 @@ static inline int split_huge_page(struct page *pag=
e)
> >>  {
> >>         return split_huge_page_to_list_to_order(page, NULL, 0);
> >>  }
> >> -void deferred_split_folio(struct folio *folio);
> >> +void deferred_split_folio(struct folio *folio, bool partially_mapped)=
;
> >>
> >>  void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
> >>                 unsigned long address, bool freeze, struct folio *foli=
o);
> >> @@ -495,7 +495,7 @@ static inline int split_huge_page(struct page *pag=
e)
> >>  {
> >>         return 0;
> >>  }
> >> -static inline void deferred_split_folio(struct folio *folio) {}
> >> +static inline void deferred_split_folio(struct folio *folio, bool par=
tially_mapped) {}
> >>  #define split_huge_pmd(__vma, __pmd, __address)        \
> >>         do { } while (0)
> >>
> >> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> >> index a0a29bd092f8..c3bb0e0da581 100644
> >> --- a/include/linux/page-flags.h
> >> +++ b/include/linux/page-flags.h
> >> @@ -182,6 +182,7 @@ enum pageflags {
> >>         /* At least one page in this folio has the hwpoison flag set *=
/
> >>         PG_has_hwpoisoned =3D PG_active,
> >>         PG_large_rmappable =3D PG_workingset, /* anon or file-backed *=
/
> >> +       PG_partially_mapped =3D PG_reclaim, /* was identified to be pa=
rtially mapped */
> >>  };
> >>
> >>  #define PAGEFLAGS_MASK         ((1UL << NR_PAGEFLAGS) - 1)
> >> @@ -861,8 +862,18 @@ static inline void ClearPageCompound(struct page =
*page)
> >>         ClearPageHead(page);
> >>  }
> >>  FOLIO_FLAG(large_rmappable, FOLIO_SECOND_PAGE)
> >> +FOLIO_TEST_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
> >> +/*
> >> + * PG_partially_mapped is protected by deferred_split split_queue_loc=
k,
> >> + * so its safe to use non-atomic set/clear.
> >> + */
> >> +__FOLIO_SET_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
> >> +__FOLIO_CLEAR_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
> >>  #else
> >>  FOLIO_FLAG_FALSE(large_rmappable)
> >> +FOLIO_TEST_FLAG_FALSE(partially_mapped)
> >> +__FOLIO_SET_FLAG_NOOP(partially_mapped)
> >> +__FOLIO_CLEAR_FLAG_NOOP(partially_mapped)
> >>  #endif
> >>
> >>  #define PG_head_mask ((1UL << PG_head))
> >> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >> index 2d77b5d2291e..70ee49dfeaad 100644
> >> --- a/mm/huge_memory.c
> >> +++ b/mm/huge_memory.c
> >> @@ -3398,6 +3398,7 @@ int split_huge_page_to_list_to_order(struct page=
 *page, struct list_head *list,
> >>                          * page_deferred_list.
> >>                          */
> >>                         list_del_init(&folio->_deferred_list);
> >> +                       __folio_clear_partially_mapped(folio);
> >>                 }
> >>                 spin_unlock(&ds_queue->split_queue_lock);
> >>                 if (mapping) {
> >> @@ -3454,11 +3455,13 @@ void __folio_undo_large_rmappable(struct folio=
 *folio)
> >>         if (!list_empty(&folio->_deferred_list)) {
> >>                 ds_queue->split_queue_len--;
> >>                 list_del_init(&folio->_deferred_list);
> >> +               __folio_clear_partially_mapped(folio);
> >
> > is it possible to make things clearer by
> >
> >  if (folio_clear_partially_mapped)
> >     __folio_clear_partially_mapped(folio);
> >
> > While writing without conditions isn't necessarily wrong, adding a cond=
ition
> > will improve the readability of the code and enhance the clarity of my =
mTHP
> > counters series. also help decrease smp cache sync if we can avoid
> > unnecessary writing?
> >
>
> Do you mean if(folio_test_partially_mapped(folio))?
>
> I don't like this idea. I think it makes the readability worse? If I was =
looking at if (test) -> clear for the first time, I would become confused w=
hy its being tested if its going to be clear at the end anyways?

In the pmd-order case, the majority of folios are not partially mapped.
Unconditional writes will trigger cache synchronization across all
CPUs (related to the MESI protocol), making them more costly. By
using conditional writes, such as "if(test) write," we can avoid
most unnecessary writes, which is much more efficient. Additionally,
we only need to manage nr_split_deferred when the condition
is met. We are carefully evaluating all scenarios to determine
if modifications to the partially_mapped flag are necessary.

>
>
> >>         }
> >>         spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
> >>  }
> >>
> >> -void deferred_split_folio(struct folio *folio)
> >> +/* partially_mapped=3Dfalse won't clear PG_partially_mapped folio fla=
g */
> >> +void deferred_split_folio(struct folio *folio, bool partially_mapped)
> >>  {
> >>         struct deferred_split *ds_queue =3D get_deferred_split_queue(f=
olio);
> >>  #ifdef CONFIG_MEMCG
> >> @@ -3486,14 +3489,19 @@ void deferred_split_folio(struct folio *folio)
> >>         if (folio_test_swapcache(folio))
> >>                 return;
> >>
> >> -       if (!list_empty(&folio->_deferred_list))
> >> -               return;
> >> -
> >>         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> >> +       if (partially_mapped) {
> >> +               if (!folio_test_partially_mapped(folio)) {
> >> +                       __folio_set_partially_mapped(folio);
> >> +                       if (folio_test_pmd_mappable(folio))
> >> +                               count_vm_event(THP_DEFERRED_SPLIT_PAGE=
);
> >> +                       count_mthp_stat(folio_order(folio), MTHP_STAT_=
SPLIT_DEFERRED);
> >> +               }
> >> +       } else {
> >> +               /* partially mapped folios cannot become non-partially=
 mapped */
> >> +               VM_WARN_ON_FOLIO(folio_test_partially_mapped(folio), f=
olio);
> >> +       }
> >>         if (list_empty(&folio->_deferred_list)) {
> >> -               if (folio_test_pmd_mappable(folio))
> >> -                       count_vm_event(THP_DEFERRED_SPLIT_PAGE);
> >> -               count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DE=
FERRED);
> >>                 list_add_tail(&folio->_deferred_list, &ds_queue->split=
_queue);
> >>                 ds_queue->split_queue_len++;
> >>  #ifdef CONFIG_MEMCG
> >> @@ -3542,6 +3550,7 @@ static unsigned long deferred_split_scan(struct =
shrinker *shrink,
> >>                 } else {
> >>                         /* We lost race with folio_put() */
> >>                         list_del_init(&folio->_deferred_list);
> >> +                       __folio_clear_partially_mapped(folio);
> >
> > as above? Do we also need if(test) for split_huge_page_to_list_to_order=
()?
> >
> >>                         ds_queue->split_queue_len--;
> >>                 }
> >>                 if (!--sc->nr_to_scan)
> >> diff --git a/mm/internal.h b/mm/internal.h
> >> index 52f7fc4e8ac3..27cbb5365841 100644
> >> --- a/mm/internal.h
> >> +++ b/mm/internal.h
> >> @@ -662,8 +662,10 @@ static inline void prep_compound_head(struct page=
 *page, unsigned int order)
> >>         atomic_set(&folio->_entire_mapcount, -1);
> >>         atomic_set(&folio->_nr_pages_mapped, 0);
> >>         atomic_set(&folio->_pincount, 0);
> >> -       if (order > 1)
> >> +       if (order > 1) {
> >>                 INIT_LIST_HEAD(&folio->_deferred_list);
> >> +               __folio_clear_partially_mapped(folio);
> >
> > if partially_mapped is true for a new folio, does it mean we already ha=
ve
> > a bug somewhere?
> >
> > How is it possible for a new folio to be partially mapped?
> >
>
> Its not, I did it because I wanted to make it explicit that the folio is =
being initialized, similar to how before this INIT_LIST_HEAD(&folio->_defer=
red_list) is done here.
>
> There is no functional issue in removing it here, because I believe the f=
lag is initialized to false from start.
> >> +       }
> >>  }
> >>
> >>  static inline void prep_compound_tail(struct page *head, int tail_idx=
)
> >> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> >> index e1ffd2950393..0fd95daecf9a 100644
> >> --- a/mm/memcontrol.c
> >> +++ b/mm/memcontrol.c
> >> @@ -4669,7 +4669,8 @@ static void uncharge_folio(struct folio *folio, =
struct uncharge_gather *ug)
> >>         VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
> >>         VM_BUG_ON_FOLIO(folio_order(folio) > 1 &&
> >>                         !folio_test_hugetlb(folio) &&
> >> -                       !list_empty(&folio->_deferred_list), folio);
> >> +                       !list_empty(&folio->_deferred_list) &&
> >> +                       folio_test_partially_mapped(folio), folio);
> >>
> >>         /*
> >>          * Nobody should be changing or seriously looking at
> >> diff --git a/mm/migrate.c b/mm/migrate.c
> >> index 2d2e65d69427..ef4a732f22b1 100644
> >> --- a/mm/migrate.c
> >> +++ b/mm/migrate.c
> >> @@ -1735,7 +1735,8 @@ static int migrate_pages_batch(struct list_head =
*from,
> >>                          * use _deferred_list.
> >>                          */
> >>                         if (nr_pages > 2 &&
> >> -                          !list_empty(&folio->_deferred_list)) {
> >> +                          !list_empty(&folio->_deferred_list) &&
> >> +                          folio_test_partially_mapped(folio)) {
> >>                                 if (!try_split_folio(folio, split_foli=
os, mode)) {
> >>                                         nr_failed++;
> >>                                         stats->nr_thp_failed +=3D is_t=
hp;
> >> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >> index 408ef3d25cf5..a145c550dd2a 100644
> >> --- a/mm/page_alloc.c
> >> +++ b/mm/page_alloc.c
> >> @@ -957,8 +957,9 @@ static int free_tail_page_prepare(struct page *hea=
d_page, struct page *page)
> >>                 break;
> >>         case 2:
> >>                 /* the second tail page: deferred_list overlaps ->mapp=
ing */
> >> -               if (unlikely(!list_empty(&folio->_deferred_list))) {
> >> -                       bad_page(page, "on deferred list");
> >> +               if (unlikely(!list_empty(&folio->_deferred_list) &&
> >> +                   folio_test_partially_mapped(folio))) {
> >> +                       bad_page(page, "partially mapped folio on defe=
rred list");
> >>                         goto out;
> >>                 }
> >>                 break;
> >> diff --git a/mm/rmap.c b/mm/rmap.c
> >> index a6b9cd0b2b18..4c330635aa4e 100644
> >> --- a/mm/rmap.c
> >> +++ b/mm/rmap.c
> >> @@ -1578,8 +1578,9 @@ static __always_inline void __folio_remove_rmap(=
struct folio *folio,
> >>          * Check partially_mapped first to ensure it is a large folio.
> >>          */
> >>         if (partially_mapped && folio_test_anon(folio) &&
> >> -           list_empty(&folio->_deferred_list))
> >> -               deferred_split_folio(folio);
> >> +           !folio_test_partially_mapped(folio))
> >> +               deferred_split_folio(folio, true);
> >> +
> >>         __folio_mod_stat(folio, -nr, -nr_pmdmapped);
> >>
> >>         /*
> >> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >> index 25e43bb3b574..25f4e8403f41 100644
> >> --- a/mm/vmscan.c
> >> +++ b/mm/vmscan.c
> >> @@ -1233,7 +1233,8 @@ static unsigned int shrink_folio_list(struct lis=
t_head *folio_list,
> >>                                          * Split partially mapped foli=
os right away.
> >>                                          * We can free the unmapped pa=
ges without IO.
> >>                                          */
> >> -                                       if (data_race(!list_empty(&fol=
io->_deferred_list)) &&
> >> +                                       if (data_race(!list_empty(&fol=
io->_deferred_list) &&
> >> +                                           folio_test_partially_mappe=
d(folio)) &&
> >>                                             split_folio_to_list(folio,=
 folio_list))
> >>                                                 goto activate_locked;
> >>                                 }
> >> --
> >> 2.43.5
> >>
> >
> > Thanks
> > Barry

