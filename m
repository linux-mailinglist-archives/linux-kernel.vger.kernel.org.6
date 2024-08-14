Return-Path: <linux-kernel+bounces-286322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DA395199E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C43D1C2166E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD461AE852;
	Wed, 14 Aug 2024 11:10:42 +0000 (UTC)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DAAB679;
	Wed, 14 Aug 2024 11:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723633841; cv=none; b=iMN2XpQFf3iHYSEo20k0OIy9/aepu+beTxRYJCfVZARwUEeboBZ0ZnfIDHVbxFuMhUg5wHZxilZC8wb5kx6dNYp62jF31yRkwZfMRW3Lmtw52g+15BgchWBeuU68FMgp7/mhU11C7w8CqRCsH7moj3v327x0CPOMJ5csl2St/4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723633841; c=relaxed/simple;
	bh=j8pEXE9PVlJYvlw6ZK1FH3arytThtP5WQMjRFt6T5xA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PnUb1PfGRK08cmAQCJAdMft882YStjbQcjP8yKdizy6cAIHDLa0BHMm0bBwftyPI5dLzJlP2q1+S38awn/G7oIKSzkvDiQ4pCJt2C6JdlvwM1eN1RBpYUICnhFqXvkuwbcrMC7Wf7BrtUY1UVPOPobbl73q6onPqEdZgYt3oku8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4f52bd5b555so504642e0c.1;
        Wed, 14 Aug 2024 04:10:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723633839; x=1724238639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKBWMOZpHAAA5MQNXuooT8nERpHIRTsKHqQ8nBNa4qM=;
        b=NSd8ixOAqMMDuVTvf8jflbmOS16V4Uctq4SV8bZeXoi+K1Qy3ULVxaAXRzJzF+s/iz
         /ugEKEqtgCEkutYA1GFlAn43sQISsw3mIt0xIFvusAVfRX1fKUd14KkDUuz7dtxaqQrx
         eKdElfsWsMPQR+yMnLlHdUHO79Rd7q3jLY4Wj9JnxO9dpvLrhkT4hbQxXBZ8Wmj+tbR6
         t2O8fASDIK18ELtqO0Ys1XO3mdx4zhPeN4ZI6KMNk8HaCqVzX/KihLwrrKpF01Q+YRrK
         SnDf7+KqYp/3XQj0U1UwK3Dpw+uyjth2aMkqIqCcRC17JjPK5FqMvv907pDX5C8mvkvC
         vGbg==
X-Forwarded-Encrypted: i=1; AJvYcCX4X5NQXDn3cFpZERaAbwA9G2F3SkbV8Uk7QKTlauSWzG5RLm3Q3mWmjX4gju22Jslv9TqWKraKSoNjwt44Wkw3c7LuTbCPhUIhbKveL3L1RkgHks8Hv6gY3QsA1CqzhMagKk42LSHE
X-Gm-Message-State: AOJu0YxoKKVQBGqUm1IXuqAWQOs+OwBKxdARw7/FGhwPqqvRffO0hPrN
	8q9jT4ZB6/w/I0rbXHgsL31UujMYSWaGxqcIlXvFUSMqu9AeNAHrqjr1L/vqBLBL3tGFgR5tmIz
	xatuQqRi7p3UO5SYAAe71qcQZUXw=
X-Google-Smtp-Source: AGHT+IFHgr/BQNWyLd6y2D+x0J3hYd9uJcbjA4OqOeeGBarXFRitZS2fB2fPvtdzpMbd30EAMfhGGrR3DACkRgOL9OU=
X-Received: by 2002:a1f:4b47:0:b0:4f5:2849:598d with SMTP id
 71dfb90a1353d-4fac1aba611mr2748884e0c.4.1723633838617; Wed, 14 Aug 2024
 04:10:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813120328.1275952-1-usamaarif642@gmail.com> <20240813120328.1275952-5-usamaarif642@gmail.com>
In-Reply-To: <20240813120328.1275952-5-usamaarif642@gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Wed, 14 Aug 2024 23:10:27 +1200
Message-ID: <CAGsJ_4ySxmhQCXT5Nw09tdGJA+j9=ZEMEuPa6jgX__tM+EMqXw@mail.gmail.com>
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

This code completely broke MTHP_STAT_SPLIT_DEFERRED for PMD_ORDER. It
added the folio to the deferred_list as entirely_mapped
(partially_mapped =3D=3D false).
However, when partially_mapped becomes true, there's no opportunity to
add it again
as it has been there on the list. Are you consistently seeing the counter f=
or
PMD_ORDER as 0?

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

