Return-Path: <linux-kernel+bounces-286306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 836DE951962
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A30591C21AFD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEC513D298;
	Wed, 14 Aug 2024 10:52:23 +0000 (UTC)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA82137772;
	Wed, 14 Aug 2024 10:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723632743; cv=none; b=Y5DASmcL0Ue2m9/lZWbK+ZqiwzJAs4IsuJ5v6RtsNLlockge2cVNIeAaMVy/y3N7TXJum+OB0yRrnl0iKnzol5Sv4dYf+eqtOgLtOQlITBo7oNMmIwREsQRNHZVc8lWcceAOu4wWDxsrSJ1JBZ03JVIE/voSIyveSp3zC2ZKyEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723632743; c=relaxed/simple;
	bh=erqoQak8kLuA4kVDbzOiEkjaJjeQLoe7c3FBR1u8wKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FVGiFkHjOpCEwbDOzRYJ2oo1gdhwwZ5lOtBXS4I6HPjaFKoPHLQXgzjetLMSS+nnwY6e1a1BpaqKYxZqYoh4gZuSfNzEXGrNgYVc62ZMwiQFim6BqbXGZpgsO5tqFsJ+vVodhHmEVll3oCC4gl1ERcAF6H8ymW6ZQYdAShu23dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-84119164f2cso1859330241.3;
        Wed, 14 Aug 2024 03:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723632740; x=1724237540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w5/n5d5lmVGLGigHOKu/MLPoj++bPwRRRmXllww2nAo=;
        b=QY+b4OIe4vEu37HIQ1WPKUq4BgMwgyU8t+lNt7it7HeIO8dBjzNAAbIIzirpj+smAc
         6F7qkR94R2giWgV8gBVSxQfg9U8lCdEjW7bXkCOdQFaen24q0aJDEIem3cB3LMzvXrV/
         ZsZ7UZHyS+4Bwxaf7xsfAaVweOPtXRQjS9FHCmCP+ODZhRCI63mf729K4ajenGTZMGEX
         wcr38Tgy8Yz+PBmzp18up5mfct1A4ZuyWnsN7hdPhvxXyjCf/xWIpFaDYUqwJ1czdgNB
         jj3v0+Id6gXjwuIKABHlcQIOy2u5my2HmJ4QQ6pwRuvrAZqztixeCVtVrHsn4S5KBNVH
         lhIg==
X-Forwarded-Encrypted: i=1; AJvYcCUBl4ER4WOTHOSk7/Ox4jGZqXQQKznP/kU4/VysIOz6nPe7skiNHI1/fg85bcz9eUwICrdSN/lk1LAc6pJo6U5O56V69iAhQ3HQLZHSTokwaxar5PF1J90LBnZwlbR0iNKlCozoveH9
X-Gm-Message-State: AOJu0YxSp/d6+2L7kqVK9GMdLUlpb+a+LAE9SyPPpn7+xtTxzownu/SA
	e82m0ZSjtB63LdG/W5vNJPdpK01sLGzipuEK8HwIAFsI/WMOcgRrAzmNjv0KXDltTDc3tGTJXAa
	CU84byOjHEPCcyPN8m+dSLQFgc0w=
X-Google-Smtp-Source: AGHT+IELhyG190zQF+28yikuwU77z558kfVX1tiW0MPuCdZnW1nGfLhePqOrXj2gEhXwDBoOeVW7b9QMQ79LA1MQx98=
X-Received: by 2002:a05:6122:d0a:b0:4f5:27ac:ce6e with SMTP id
 71dfb90a1353d-4fad1e9c79bmr3097621e0c.7.1723632739821; Wed, 14 Aug 2024
 03:52:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813120328.1275952-1-usamaarif642@gmail.com>
 <20240813120328.1275952-5-usamaarif642@gmail.com> <CAGsJ_4x+5fiCoWv4G0NsYq+aJRqZsrCEHO_DF+CnNFdqx0VgMQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4x+5fiCoWv4G0NsYq+aJRqZsrCEHO_DF+CnNFdqx0VgMQ@mail.gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Wed, 14 Aug 2024 22:52:08 +1200
Message-ID: <CAGsJ_4xus8OUHQ5Q7L8G6EgyYSV2Y_8m_Lt6hcNJ6=WnTqQ00Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] mm: Introduce a pageflag for partially mapped folios
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	riel@surriel.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev, 
	yuzhao@google.com, david@redhat.com, ryan.roberts@arm.com, rppt@kernel.org, 
	willy@infradead.org, cerasuolodomenico@gmail.com, corbet@lwn.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 10:44=E2=80=AFPM Barry Song <baohua@kernel.org> wro=
te:
>
> On Wed, Aug 14, 2024 at 12:03=E2=80=AFAM Usama Arif <usamaarif642@gmail.c=
om> wrote:
> >
> > Currently folio->_deferred_list is used to keep track of
> > partially_mapped folios that are going to be split under memory
> > pressure. In the next patch, all THPs that are faulted in and collapsed
> > by khugepaged are also going to be tracked using _deferred_list.
> >
> > This patch introduces a pageflag to be able to distinguish between
> > partially mapped folios and others in the deferred_list at split time i=
n
> > deferred_split_scan. Its needed as __folio_remove_rmap decrements
> > _mapcount, _large_mapcount and _entire_mapcount, hence it won't be
> > possible to distinguish between partially mapped folios and others in
> > deferred_split_scan.
> >
> > Eventhough it introduces an extra flag to track if the folio is
> > partially mapped, there is no functional change intended with this
> > patch and the flag is not useful in this patch itself, it will
> > become useful in the next patch when _deferred_list has non partially
> > mapped folios.
> >
> > Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> > ---
> >  include/linux/huge_mm.h    |  4 ++--
> >  include/linux/page-flags.h |  3 +++
> >  mm/huge_memory.c           | 21 +++++++++++++--------
> >  mm/hugetlb.c               |  1 +
> >  mm/internal.h              |  4 +++-
> >  mm/memcontrol.c            |  3 ++-
> >  mm/migrate.c               |  3 ++-
> >  mm/page_alloc.c            |  5 +++--
> >  mm/rmap.c                  |  3 ++-
> >  mm/vmscan.c                |  3 ++-
> >  10 files changed, 33 insertions(+), 17 deletions(-)
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 4c32058cacfe..969f11f360d2 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -321,7 +321,7 @@ static inline int split_huge_page(struct page *page=
)
> >  {
> >         return split_huge_page_to_list_to_order(page, NULL, 0);
> >  }
> > -void deferred_split_folio(struct folio *folio);
> > +void deferred_split_folio(struct folio *folio, bool partially_mapped);
> >
> >  void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
> >                 unsigned long address, bool freeze, struct folio *folio=
);
> > @@ -495,7 +495,7 @@ static inline int split_huge_page(struct page *page=
)
> >  {
> >         return 0;
> >  }
> > -static inline void deferred_split_folio(struct folio *folio) {}
> > +static inline void deferred_split_folio(struct folio *folio, bool part=
ially_mapped) {}
> >  #define split_huge_pmd(__vma, __pmd, __address)        \
> >         do { } while (0)
> >
> > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > index a0a29bd092f8..cecc1bad7910 100644
> > --- a/include/linux/page-flags.h
> > +++ b/include/linux/page-flags.h
> > @@ -182,6 +182,7 @@ enum pageflags {
> >         /* At least one page in this folio has the hwpoison flag set */
> >         PG_has_hwpoisoned =3D PG_active,
> >         PG_large_rmappable =3D PG_workingset, /* anon or file-backed */
> > +       PG_partially_mapped, /* was identified to be partially mapped *=
/
> >  };
> >
> >  #define PAGEFLAGS_MASK         ((1UL << NR_PAGEFLAGS) - 1)
> > @@ -861,8 +862,10 @@ static inline void ClearPageCompound(struct page *=
page)
> >         ClearPageHead(page);
> >  }
> >  FOLIO_FLAG(large_rmappable, FOLIO_SECOND_PAGE)
> > +FOLIO_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
> >  #else
> >  FOLIO_FLAG_FALSE(large_rmappable)
> > +FOLIO_FLAG_FALSE(partially_mapped)
> >  #endif
> >
> >  #define PG_head_mask ((1UL << PG_head))
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 6df0e9f4f56c..c024ab0f745c 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -3397,6 +3397,7 @@ int split_huge_page_to_list_to_order(struct page =
*page, struct list_head *list,
> >                          * page_deferred_list.
> >                          */
> >                         list_del_init(&folio->_deferred_list);
> > +                       folio_clear_partially_mapped(folio);
> >                 }
> >                 spin_unlock(&ds_queue->split_queue_lock);
> >                 if (mapping) {
> > @@ -3453,11 +3454,12 @@ void __folio_undo_large_rmappable(struct folio =
*folio)
> >         if (!list_empty(&folio->_deferred_list)) {
> >                 ds_queue->split_queue_len--;
> >                 list_del_init(&folio->_deferred_list);
> > +               folio_clear_partially_mapped(folio);
> >         }
> >         spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
> >  }
> >
> > -void deferred_split_folio(struct folio *folio)
> > +void deferred_split_folio(struct folio *folio, bool partially_mapped)
> >  {
> >         struct deferred_split *ds_queue =3D get_deferred_split_queue(fo=
lio);
> >  #ifdef CONFIG_MEMCG
> > @@ -3485,14 +3487,17 @@ void deferred_split_folio(struct folio *folio)
> >         if (folio_test_swapcache(folio))
> >                 return;
> >
> > -       if (!list_empty(&folio->_deferred_list))
> > -               return;
> > -
> >         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> > +       if (partially_mapped)
> > +               folio_set_partially_mapped(folio);
> > +       else
> > +               folio_clear_partially_mapped(folio);
>
> Hi Usama,
>
> Do we need this? When can a partially_mapped folio on deferred_list becom=
e
> non-partially-mapped and need a clear? I understand transferring from
> entirely_map
> to partially_mapped is a one way process? partially_mapped folios can't g=
o back
> to entirely_mapped?
>
> I am trying to rebase my NR_SPLIT_DEFERRED counter on top of your
> work, but this "clear" makes that job quite tricky. as I am not sure
> if this patch
> is going to clear the partially_mapped flag for folios on deferred_list.
>
> Otherwise, I can simply do the below whenever folio is leaving deferred_l=
ist
>
>         ds_queue->split_queue_len--;
>         list_del_init(&folio->_deferred_list);
>         if (folio_test_clear_partially_mapped(folio))
>                 mod_mthp_stat(folio_order(folio),
> MTHP_STAT_NR_SPLIT_DEFERRED, -1);

On the other hand, I can still make things correct by the below code,
but it looks much more tricky. i believe we at least need the first
one folio_test_set_partially_mapped()  because folios on
deferred_list can become partially_mapped from
entirely_mapped.

Not quite sure if we need the second folio_test_clear_partially_mapped(foli=
o)
in deferred_split_folio(). My understand is that it is impossible and this
folio_clear_partially_mapped() is probably redundant.

@@ -3515,10 +3522,13 @@ void deferred_split_folio(struct folio *folio,
bool partially_mapped)
                return;

        spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
-       if (partially_mapped)
-               folio_set_partially_mapped(folio);
-       else
-               folio_clear_partially_mapped(folio);
+       if (partially_mapped) {
+               if (!folio_test_set_partially_mapped(folio))
+                       mod_mthp_stat(folio_order(folio),
+                               MTHP_STAT_NR_SPLIT_DEFERRED, 1);
+       } else if (folio_test_clear_partially_mapped(folio)) {
+                mod_mthp_stat(folio_order(folio),
MTHP_STAT_NR_SPLIT_DEFERRED, -1);
+       }
        if (list_empty(&folio->_deferred_list)) {
                if (partially_mapped) {
                        if (folio_test_pmd_mappable(folio))

>
> >         if (list_empty(&folio->_deferred_list)) {
> > -               if (folio_test_pmd_mappable(folio))
> > -                       count_vm_event(THP_DEFERRED_SPLIT_PAGE);
> > -               count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEF=
ERRED);
> > +               if (partially_mapped) {
> > +                       if (folio_test_pmd_mappable(folio))
> > +                               count_vm_event(THP_DEFERRED_SPLIT_PAGE)=
;
> > +                       count_mthp_stat(folio_order(folio), MTHP_STAT_S=
PLIT_DEFERRED);
> > +               }
> >                 list_add_tail(&folio->_deferred_list, &ds_queue->split_=
queue);
> >                 ds_queue->split_queue_len++;
> >  #ifdef CONFIG_MEMCG
> > @@ -3541,6 +3546,7 @@ static unsigned long deferred_split_scan(struct s=
hrinker *shrink,
> >                 } else {
> >                         /* We lost race with folio_put() */
> >                         list_del_init(&folio->_deferred_list);
> > +                       folio_clear_partially_mapped(folio);
> >                         ds_queue->split_queue_len--;
> >                 }
> >                 if (!--sc->nr_to_scan)
> > @@ -3558,7 +3564,6 @@ static unsigned long deferred_split_scan(struct s=
hrinker *shrink,
> >  next:
> >                 folio_put(folio);
> >         }
> > -
> >         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> >         list_splice_tail(&list, &ds_queue->split_queue);
> >         spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 1fdd9eab240c..2ae2d9a18e40 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1758,6 +1758,7 @@ static void __update_and_free_hugetlb_folio(struc=
t hstate *h,
> >                 free_gigantic_folio(folio, huge_page_order(h));
> >         } else {
> >                 INIT_LIST_HEAD(&folio->_deferred_list);
> > +               folio_clear_partially_mapped(folio);
> >                 folio_put(folio);
> >         }
> >  }
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 52f7fc4e8ac3..d64546b8d377 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -662,8 +662,10 @@ static inline void prep_compound_head(struct page =
*page, unsigned int order)
> >         atomic_set(&folio->_entire_mapcount, -1);
> >         atomic_set(&folio->_nr_pages_mapped, 0);
> >         atomic_set(&folio->_pincount, 0);
> > -       if (order > 1)
> > +       if (order > 1) {
> >                 INIT_LIST_HEAD(&folio->_deferred_list);
> > +               folio_clear_partially_mapped(folio);
> > +       }
> >  }
> >
> >  static inline void prep_compound_tail(struct page *head, int tail_idx)
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index e1ffd2950393..0fd95daecf9a 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -4669,7 +4669,8 @@ static void uncharge_folio(struct folio *folio, s=
truct uncharge_gather *ug)
> >         VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
> >         VM_BUG_ON_FOLIO(folio_order(folio) > 1 &&
> >                         !folio_test_hugetlb(folio) &&
> > -                       !list_empty(&folio->_deferred_list), folio);
> > +                       !list_empty(&folio->_deferred_list) &&
> > +                       folio_test_partially_mapped(folio), folio);
> >
> >         /*
> >          * Nobody should be changing or seriously looking at
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 3288ac041d03..6e32098ac2dc 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -1734,7 +1734,8 @@ static int migrate_pages_batch(struct list_head *=
from,
> >                          * use _deferred_list.
> >                          */
> >                         if (nr_pages > 2 &&
> > -                          !list_empty(&folio->_deferred_list)) {
> > +                          !list_empty(&folio->_deferred_list) &&
> > +                          folio_test_partially_mapped(folio)) {
> >                                 if (!try_split_folio(folio, split_folio=
s, mode)) {
> >                                         nr_failed++;
> >                                         stats->nr_thp_failed +=3D is_th=
p;
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 408ef3d25cf5..a145c550dd2a 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -957,8 +957,9 @@ static int free_tail_page_prepare(struct page *head=
_page, struct page *page)
> >                 break;
> >         case 2:
> >                 /* the second tail page: deferred_list overlaps ->mappi=
ng */
> > -               if (unlikely(!list_empty(&folio->_deferred_list))) {
> > -                       bad_page(page, "on deferred list");
> > +               if (unlikely(!list_empty(&folio->_deferred_list) &&
> > +                   folio_test_partially_mapped(folio))) {
> > +                       bad_page(page, "partially mapped folio on defer=
red list");
> >                         goto out;
> >                 }
> >                 break;
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index a6b9cd0b2b18..9ad558c2bad0 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1579,7 +1579,8 @@ static __always_inline void __folio_remove_rmap(s=
truct folio *folio,
> >          */
> >         if (partially_mapped && folio_test_anon(folio) &&
> >             list_empty(&folio->_deferred_list))
> > -               deferred_split_folio(folio);
> > +               deferred_split_folio(folio, true);
> > +
> >         __folio_mod_stat(folio, -nr, -nr_pmdmapped);
> >
> >         /*
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 25e43bb3b574..25f4e8403f41 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -1233,7 +1233,8 @@ static unsigned int shrink_folio_list(struct list=
_head *folio_list,
> >                                          * Split partially mapped folio=
s right away.
> >                                          * We can free the unmapped pag=
es without IO.
> >                                          */
> > -                                       if (data_race(!list_empty(&foli=
o->_deferred_list)) &&
> > +                                       if (data_race(!list_empty(&foli=
o->_deferred_list) &&
> > +                                           folio_test_partially_mapped=
(folio)) &&
> >                                             split_folio_to_list(folio, =
folio_list))
> >                                                 goto activate_locked;
> >                                 }
> > --
> > 2.43.5
> >
>
> Thanks
> Barry

