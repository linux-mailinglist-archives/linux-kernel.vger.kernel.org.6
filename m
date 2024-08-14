Return-Path: <linux-kernel+bounces-286299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4DF95193C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D189B21E5F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DC01A00F3;
	Wed, 14 Aug 2024 10:44:42 +0000 (UTC)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CC133993;
	Wed, 14 Aug 2024 10:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723632282; cv=none; b=lIoFf6Cra/U9pLq9TlN8Ptbp/7LcrZNJZzwAiT3wy0SRv7lKufgBX3teRqH2psaUoXdudD01okBcny6KSU19eqP4NU94ytoDZJYDK8j5KZkorr9tyEkQuSpANq50+1b5wGMcTEqg0JLIkJLZmrt65tNYzI1XW4NKh+wtBu3uOwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723632282; c=relaxed/simple;
	bh=Hi0KMPArLAHcZUBpcAqW5Nwm2thrJkZWmhX/o1QVAhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VVuKEW32zAPnk+inCBO4uk5Lkvu63B/01iddgU0VokhjhagRKwZbm4DikDG8p67/VKaQEz099oLSZh+ZLwmjsmI756XiCo1UpdOpHWy5IkMKkQyYee11TZVL5NXikyOpgNMtX/DeIrDJV4RGbGN/ao3juFUuXpjBLs2DZjrPgcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-842eee4ad03so150996241.0;
        Wed, 14 Aug 2024 03:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723632279; x=1724237079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhuKELtUQfqg3R4iz6eojJcLJbisHRVhT9vIlErWfrI=;
        b=E8e8fGabJQ6gbdjFkSEC9rPGWAymfCTjUCrQvm9lejn4F2j44p3ZWsAcsmIRxFB4nH
         9BIYTuoK0sUNPogg88YqA/kC+2TxhUz3SKYkqvJKMurH5hPi87rkuLAdVjrPc9NSmH8Y
         WKk0cGH7T+mwRLn64T9GzteOcE/WSp5bLUeolaI2qPiihZThSXVk/lJx7UfZMgTuZqup
         FywK01OAbjwzRftAMvkrANeApFPv1wp4ok6KKBuydVasqX3ox6xNHVV4G25rokouAGKA
         VRzwBHiK517wO1Z6tBoJUr2nX4322mxBioJpqFCdbOKlhY4g5rKzW9PDSls3veV40qVU
         X3KQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlevuE7a5RQfquaaD2cnQSeOdxRN1ocWecDONXDxT0kA9cZEvZZaNJekLCYZTPsNNt1pcWQvDOi5oWpmtGEVltmbu5eu2AMUof6G5P+qvAOj8egdaQ5JqZaNohb85RvGPMGXEYYGzD
X-Gm-Message-State: AOJu0YyJDQCFZbK/PipFJLX9AOdIE6o55yClab7Q/CwN0ubBqlc4XYRh
	m0/f4BEusMhVnjpCgs6GV3yzDX9kIOCtUIrO8/WLYAHchKcWp4WKsk3lL8M5Ua5tb7ms+GkJeVQ
	YsenfW0AhRT89NRr1vsmOJjT2B7c=
X-Google-Smtp-Source: AGHT+IGvTxOOiGrecP98na1TniR3pGbwft7uwJhXmKYL1krRvlVLTZHT6Do3qhB3ZBPA61t509Af7/3PGjvMETZRImA=
X-Received: by 2002:a05:6102:3f4f:b0:493:b06d:eea2 with SMTP id
 ada2fe7eead31-497599eb9e5mr2372406137.31.1723632278898; Wed, 14 Aug 2024
 03:44:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813120328.1275952-1-usamaarif642@gmail.com> <20240813120328.1275952-5-usamaarif642@gmail.com>
In-Reply-To: <20240813120328.1275952-5-usamaarif642@gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Wed, 14 Aug 2024 22:44:27 +1200
Message-ID: <CAGsJ_4x+5fiCoWv4G0NsYq+aJRqZsrCEHO_DF+CnNFdqx0VgMQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] mm: Introduce a pageflag for partially mapped folios
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	riel@surriel.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev, 
	yuzhao@google.com, david@redhat.com, ryan.roberts@arm.com, rppt@kernel.org, 
	willy@infradead.org, cerasuolodomenico@gmail.com, corbet@lwn.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 12:03=E2=80=AFAM Usama Arif <usamaarif642@gmail.com=
> wrote:
>
> Currently folio->_deferred_list is used to keep track of
> partially_mapped folios that are going to be split under memory
> pressure. In the next patch, all THPs that are faulted in and collapsed
> by khugepaged are also going to be tracked using _deferred_list.
>
> This patch introduces a pageflag to be able to distinguish between
> partially mapped folios and others in the deferred_list at split time in
> deferred_split_scan. Its needed as __folio_remove_rmap decrements
> _mapcount, _large_mapcount and _entire_mapcount, hence it won't be
> possible to distinguish between partially mapped folios and others in
> deferred_split_scan.
>
> Eventhough it introduces an extra flag to track if the folio is
> partially mapped, there is no functional change intended with this
> patch and the flag is not useful in this patch itself, it will
> become useful in the next patch when _deferred_list has non partially
> mapped folios.
>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>  include/linux/huge_mm.h    |  4 ++--
>  include/linux/page-flags.h |  3 +++
>  mm/huge_memory.c           | 21 +++++++++++++--------
>  mm/hugetlb.c               |  1 +
>  mm/internal.h              |  4 +++-
>  mm/memcontrol.c            |  3 ++-
>  mm/migrate.c               |  3 ++-
>  mm/page_alloc.c            |  5 +++--
>  mm/rmap.c                  |  3 ++-
>  mm/vmscan.c                |  3 ++-
>  10 files changed, 33 insertions(+), 17 deletions(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 4c32058cacfe..969f11f360d2 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -321,7 +321,7 @@ static inline int split_huge_page(struct page *page)
>  {
>         return split_huge_page_to_list_to_order(page, NULL, 0);
>  }
> -void deferred_split_folio(struct folio *folio);
> +void deferred_split_folio(struct folio *folio, bool partially_mapped);
>
>  void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>                 unsigned long address, bool freeze, struct folio *folio);
> @@ -495,7 +495,7 @@ static inline int split_huge_page(struct page *page)
>  {
>         return 0;
>  }
> -static inline void deferred_split_folio(struct folio *folio) {}
> +static inline void deferred_split_folio(struct folio *folio, bool partia=
lly_mapped) {}
>  #define split_huge_pmd(__vma, __pmd, __address)        \
>         do { } while (0)
>
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index a0a29bd092f8..cecc1bad7910 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -182,6 +182,7 @@ enum pageflags {
>         /* At least one page in this folio has the hwpoison flag set */
>         PG_has_hwpoisoned =3D PG_active,
>         PG_large_rmappable =3D PG_workingset, /* anon or file-backed */
> +       PG_partially_mapped, /* was identified to be partially mapped */
>  };
>
>  #define PAGEFLAGS_MASK         ((1UL << NR_PAGEFLAGS) - 1)
> @@ -861,8 +862,10 @@ static inline void ClearPageCompound(struct page *pa=
ge)
>         ClearPageHead(page);
>  }
>  FOLIO_FLAG(large_rmappable, FOLIO_SECOND_PAGE)
> +FOLIO_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
>  #else
>  FOLIO_FLAG_FALSE(large_rmappable)
> +FOLIO_FLAG_FALSE(partially_mapped)
>  #endif
>
>  #define PG_head_mask ((1UL << PG_head))
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 6df0e9f4f56c..c024ab0f745c 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3397,6 +3397,7 @@ int split_huge_page_to_list_to_order(struct page *p=
age, struct list_head *list,
>                          * page_deferred_list.
>                          */
>                         list_del_init(&folio->_deferred_list);
> +                       folio_clear_partially_mapped(folio);
>                 }
>                 spin_unlock(&ds_queue->split_queue_lock);
>                 if (mapping) {
> @@ -3453,11 +3454,12 @@ void __folio_undo_large_rmappable(struct folio *f=
olio)
>         if (!list_empty(&folio->_deferred_list)) {
>                 ds_queue->split_queue_len--;
>                 list_del_init(&folio->_deferred_list);
> +               folio_clear_partially_mapped(folio);
>         }
>         spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>  }
>
> -void deferred_split_folio(struct folio *folio)
> +void deferred_split_folio(struct folio *folio, bool partially_mapped)
>  {
>         struct deferred_split *ds_queue =3D get_deferred_split_queue(foli=
o);
>  #ifdef CONFIG_MEMCG
> @@ -3485,14 +3487,17 @@ void deferred_split_folio(struct folio *folio)
>         if (folio_test_swapcache(folio))
>                 return;
>
> -       if (!list_empty(&folio->_deferred_list))
> -               return;
> -
>         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> +       if (partially_mapped)
> +               folio_set_partially_mapped(folio);
> +       else
> +               folio_clear_partially_mapped(folio);

Hi Usama,

Do we need this? When can a partially_mapped folio on deferred_list become
non-partially-mapped and need a clear? I understand transferring from
entirely_map
to partially_mapped is a one way process? partially_mapped folios can't go =
back
to entirely_mapped?

I am trying to rebase my NR_SPLIT_DEFERRED counter on top of your
work, but this "clear" makes that job quite tricky. as I am not sure
if this patch
is going to clear the partially_mapped flag for folios on deferred_list.

Otherwise, I can simply do the below whenever folio is leaving deferred_lis=
t

        ds_queue->split_queue_len--;
        list_del_init(&folio->_deferred_list);
        if (folio_test_clear_partially_mapped(folio))
                mod_mthp_stat(folio_order(folio),
MTHP_STAT_NR_SPLIT_DEFERRED, -1);

>         if (list_empty(&folio->_deferred_list)) {
> -               if (folio_test_pmd_mappable(folio))
> -                       count_vm_event(THP_DEFERRED_SPLIT_PAGE);
> -               count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFER=
RED);
> +               if (partially_mapped) {
> +                       if (folio_test_pmd_mappable(folio))
> +                               count_vm_event(THP_DEFERRED_SPLIT_PAGE);
> +                       count_mthp_stat(folio_order(folio), MTHP_STAT_SPL=
IT_DEFERRED);
> +               }
>                 list_add_tail(&folio->_deferred_list, &ds_queue->split_qu=
eue);
>                 ds_queue->split_queue_len++;
>  #ifdef CONFIG_MEMCG
> @@ -3541,6 +3546,7 @@ static unsigned long deferred_split_scan(struct shr=
inker *shrink,
>                 } else {
>                         /* We lost race with folio_put() */
>                         list_del_init(&folio->_deferred_list);
> +                       folio_clear_partially_mapped(folio);
>                         ds_queue->split_queue_len--;
>                 }
>                 if (!--sc->nr_to_scan)
> @@ -3558,7 +3564,6 @@ static unsigned long deferred_split_scan(struct shr=
inker *shrink,
>  next:
>                 folio_put(folio);
>         }
> -
>         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>         list_splice_tail(&list, &ds_queue->split_queue);
>         spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 1fdd9eab240c..2ae2d9a18e40 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1758,6 +1758,7 @@ static void __update_and_free_hugetlb_folio(struct =
hstate *h,
>                 free_gigantic_folio(folio, huge_page_order(h));
>         } else {
>                 INIT_LIST_HEAD(&folio->_deferred_list);
> +               folio_clear_partially_mapped(folio);
>                 folio_put(folio);
>         }
>  }
> diff --git a/mm/internal.h b/mm/internal.h
> index 52f7fc4e8ac3..d64546b8d377 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -662,8 +662,10 @@ static inline void prep_compound_head(struct page *p=
age, unsigned int order)
>         atomic_set(&folio->_entire_mapcount, -1);
>         atomic_set(&folio->_nr_pages_mapped, 0);
>         atomic_set(&folio->_pincount, 0);
> -       if (order > 1)
> +       if (order > 1) {
>                 INIT_LIST_HEAD(&folio->_deferred_list);
> +               folio_clear_partially_mapped(folio);
> +       }
>  }
>
>  static inline void prep_compound_tail(struct page *head, int tail_idx)
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e1ffd2950393..0fd95daecf9a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4669,7 +4669,8 @@ static void uncharge_folio(struct folio *folio, str=
uct uncharge_gather *ug)
>         VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
>         VM_BUG_ON_FOLIO(folio_order(folio) > 1 &&
>                         !folio_test_hugetlb(folio) &&
> -                       !list_empty(&folio->_deferred_list), folio);
> +                       !list_empty(&folio->_deferred_list) &&
> +                       folio_test_partially_mapped(folio), folio);
>
>         /*
>          * Nobody should be changing or seriously looking at
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 3288ac041d03..6e32098ac2dc 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1734,7 +1734,8 @@ static int migrate_pages_batch(struct list_head *fr=
om,
>                          * use _deferred_list.
>                          */
>                         if (nr_pages > 2 &&
> -                          !list_empty(&folio->_deferred_list)) {
> +                          !list_empty(&folio->_deferred_list) &&
> +                          folio_test_partially_mapped(folio)) {
>                                 if (!try_split_folio(folio, split_folios,=
 mode)) {
>                                         nr_failed++;
>                                         stats->nr_thp_failed +=3D is_thp;
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 408ef3d25cf5..a145c550dd2a 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -957,8 +957,9 @@ static int free_tail_page_prepare(struct page *head_p=
age, struct page *page)
>                 break;
>         case 2:
>                 /* the second tail page: deferred_list overlaps ->mapping=
 */
> -               if (unlikely(!list_empty(&folio->_deferred_list))) {
> -                       bad_page(page, "on deferred list");
> +               if (unlikely(!list_empty(&folio->_deferred_list) &&
> +                   folio_test_partially_mapped(folio))) {
> +                       bad_page(page, "partially mapped folio on deferre=
d list");
>                         goto out;
>                 }
>                 break;
> diff --git a/mm/rmap.c b/mm/rmap.c
> index a6b9cd0b2b18..9ad558c2bad0 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1579,7 +1579,8 @@ static __always_inline void __folio_remove_rmap(str=
uct folio *folio,
>          */
>         if (partially_mapped && folio_test_anon(folio) &&
>             list_empty(&folio->_deferred_list))
> -               deferred_split_folio(folio);
> +               deferred_split_folio(folio, true);
> +
>         __folio_mod_stat(folio, -nr, -nr_pmdmapped);
>
>         /*
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 25e43bb3b574..25f4e8403f41 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1233,7 +1233,8 @@ static unsigned int shrink_folio_list(struct list_h=
ead *folio_list,
>                                          * Split partially mapped folios =
right away.
>                                          * We can free the unmapped pages=
 without IO.
>                                          */
> -                                       if (data_race(!list_empty(&folio-=
>_deferred_list)) &&
> +                                       if (data_race(!list_empty(&folio-=
>_deferred_list) &&
> +                                           folio_test_partially_mapped(f=
olio)) &&
>                                             split_folio_to_list(folio, fo=
lio_list))
>                                                 goto activate_locked;
>                                 }
> --
> 2.43.5
>

Thanks
Barry

