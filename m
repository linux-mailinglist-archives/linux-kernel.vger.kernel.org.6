Return-Path: <linux-kernel+bounces-380600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7C79AF32F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 22:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A6651F22769
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFD4189F3E;
	Thu, 24 Oct 2024 20:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wa7rmzr8"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4382522B64B
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 20:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729800060; cv=none; b=E/nUld735SXK4hZs2ju4LzcfJT1VtmhLqVUhhxKyNSA/fgng5UHkXjqzEKK64kW3aH9OAOmvcant5Cw1C6I79c9Q4RhDF6OtR++q3WDlrvCJnN8xPbGdzBxjhKGpPEde/M9zNcmnzvU6WQhN0cJS8+0Kzo/agMdas5ceOkhik5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729800060; c=relaxed/simple;
	bh=40S/b0Ducm/4YvoVE893uFmuUKOeeVxsUqyAZ0wLE7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GpgGNysZ2WTL8DDObPTfnvDOyhSeMZRalFhRlVKZvo7G+2WvXjfIdKonDC1gDrPw0D7AIN+6o2bze4swUCVlfCLK76Cf4XwInQfDb1VZrvMq4E9nQg2rgPGk53Z9B9/vswNlN0G7o/vl4c1auPUi5godLlGkiSG5jyxPaJwf5u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wa7rmzr8; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c903f5bd0eso2397654a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 13:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729800055; x=1730404855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZR5+RDIEeH09JuEQux1/sOKZW2B9xbbsM1/LCOo/bE=;
        b=Wa7rmzr85fyhwEDSjGqNtOJ6OXsFaAcbSOiLXDZeH6tyIuOs0YXBloRwNZlpJEaRG+
         +PyQZQrX909mEzYFcOMbWv4dGLDraI0ikmYtWmUbH3ZqxJwCYSeCVSoJak9qN6c8LmJ4
         tfKMabAJq7gll0oweqJi2PRE8WcuN69NOAQJSLmY7mTQxFt3pDWO1rkXPhkjoapKp2Ct
         VdnNR8lyjtN0NmkbpVr/thl0GATRuA4oXOv8MoX6G9kKdh86EMrTWz8t6fOlszGQNwL0
         JwRcj+jcvTSZRUSHZoeX+W7sU+dNtzkuytNM2FCz9W7t308coip2WGkPG0J81W1v4Gt7
         rmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729800055; x=1730404855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZR5+RDIEeH09JuEQux1/sOKZW2B9xbbsM1/LCOo/bE=;
        b=w2o028SlC40HmRzP6Dm+pH97T0mccHhy0gflj047ytEENWWdu+IyJxgqf9qDziS+mw
         1vM+k5RYO10KpIMfQpn/yuNcf3FknKw5FtmMystllIlEQ5YVhqiUBC9rYK6qqUKs8Sd6
         9Go5ut/bCZtazfxRVL85EibP5/3wl9lgTUN8IvQ5fMFG/oV6ZBU9avbsqfCtRAtRSpbS
         pMWGoF+eUUaVXBFW+0ML6RiRACUO5NPRPgQCfsQw1KBRZuftVYcki8qrnp6ULi4ftJnr
         lnXig3bE4tMhEs3HJfYMGa0eBjIh97PiVgulaTAajcjrzj6LwzQ8kHmO6jQi7XDPXm0L
         Ej8A==
X-Forwarded-Encrypted: i=1; AJvYcCWAB1kFaZuZIRQe6RtyFdraz7WsKun8xqaY++qSQ+JbG+vF3u5Lhv7IeO/w2mu9z0rM/GcjwxaWdMKdi6I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjt9mkq0icsKoz5Gd77skpLw7hYPG3lKXNXP77wdUh0lzOpd36
	Sfw3Ew4AN7MOpP7b+B/n4B2pEEMwcn88NbXctny1jSDsI11oxx6K3uFgAPsDbMzi2Aq5Zk2HeS0
	/v9ls3MriD7mXzYX3LnK8PcnRQDY=
X-Google-Smtp-Source: AGHT+IHj/AJ6NQg7fb4O29SQIz/bkFpqledA+je0qis1vrx0o4D/Etylbm4b8TGNvyYLupb8DZNH1Qc9IJrVLYJp0kI=
X-Received: by 2002:a05:6402:2344:b0:5c9:59e6:e908 with SMTP id
 4fb4d7f45d1cf-5cb8ac5e8ebmr7168493a12.6.1729800055001; Thu, 24 Oct 2024
 13:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <760237a3-69d6-9197-432d-0306d52c048a@google.com> <7dc6b280-cd87-acd1-1124-e512e3d2217d@google.com>
In-Reply-To: <7dc6b280-cd87-acd1-1124-e512e3d2217d@google.com>
From: Yang Shi <shy828301@gmail.com>
Date: Thu, 24 Oct 2024 13:00:43 -0700
Message-ID: <CAHbLzkoRHcC33vj7iajw_JXVig7yghJRGaTpaHXaxhoni76yPw@mail.gmail.com>
Subject: Re: [PATCH hotfix 2/2] mm/thp: fix deferred split unqueue naming and locking
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Usama Arif <usamaarif642@gmail.com>, 
	Wei Yang <richard.weiyang@gmail.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Matthew Wilcox <willy@infradead.org>, 
	David Hildenbrand <david@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Nhat Pham <nphamcs@gmail.com>, Zi Yan <ziy@nvidia.com>, Chris Li <chrisl@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 9:13=E2=80=AFPM Hugh Dickins <hughd@google.com> wro=
te:
>
> Recent changes are putting more pressure on THP deferred split queues:
> under load revealing long-standing races, causing list_del corruptions,
> "Bad page state"s and worse (I keep BUGs in both of those, so usually
> don't get to see how badly they end up without).  The relevant recent
> changes being 6.8's mTHP, 6.10's mTHP swapout, and 6.12's mTHP swapin,
> improved swap allocation, and underused THP splitting.
>
> Before fixing locking: rename misleading folio_undo_large_rmappable(),
> which does not undo large_rmappable, to folio_unqueue_deferred_split(),
> which is what it does.  But that and its out-of-line __callee are mm
> internals of very limited usability: add comment and WARN_ON_ONCEs to
> check usage; and return a bool to say if a deferred split was unqueued,
> which can then be used in WARN_ON_ONCEs around safety checks (sparing
> callers the arcane conditionals in __folio_unqueue_deferred_split()).
>
> Swapout: mem_cgroup_swapout() has been resetting folio->memcg_data 0
> without checking and unqueueing a THP folio from deferred split list;
> which is unfortunate, since the split_queue_lock depends on the memcg
> (when memcg is enabled); so swapout has been unqueueing such THPs later,
> when freeing the folio, using the pgdat's lock instead: potentially
> corrupting the memcg's list.  __remove_mapping() has frozen refcount to
> 0 here, so no problem with calling folio_unqueue_deferred_split() before
> resetting memcg_data.
>
> That goes back to 5.4 commit 87eaceb3faa5 ("mm: thp: make deferred split
> shrinker memcg aware"): which included a check on swapcache before adding
> to deferred queue (which can now be removed), but no check on deferred
> queue before adding THP to swapcache (maybe other circumstances prevented
> it at that time, but not now).

If I remember correctly, THP just can be added to deferred list when
there is no PMD map before mTHP swapout, so shrink_page_list() did
check THP's compound_mapcount (called _entire_mapcount now) before
adding it to swap cache.

Now the code just checked whether the large folio is on deferred list or no=
t.

>
> Memcg-v1 move (deprecated): mem_cgroup_move_account() has been changing
> folio->memcg_data without checking and unqueueing a THP folio from the
> deferred list, sometimes corrupting "from" memcg's list, like swapout.
> Refcount is non-zero here, so folio_unqueue_deferred_split() can only be
> used in a WARN_ON_ONCE to validate the fix, which must be done earlier:
> mem_cgroup_move_charge_pte_range() first try to split the THP (splitting
> of course unqueues), or skip it if that fails.  Not ideal, but moving
> charge has been requested, and khugepaged should repair the THP later:
> nobody wants new custom unqueueing code just for this deprecated case.
>
> The 87eaceb3faa5 commit did have the code to move from one deferred list
> to another (but was not conscious of its unsafety while refcount non-0);
> but that was removed by 5.6 commit fac0516b5534 ("mm: thp: don't need
> care deferred split queue in memcg charge move path"), which argued that
> the existence of a PMD mapping guarantees that the THP cannot be on a
> deferred list.  I'm not sure if that was true at the time (swapcache
> remapped?), but it's clearly not true since 6.12 commit dafff3f4c850
> ("mm: split underused THPs").

Same reason as above.

>
> [Note in passing: mem_cgroup_move_charge_pte_range() just skips mTHPs,
> large but not PMD-mapped: that's safe, but perhaps not intended: it's
> arguable whether the deprecated feature should be updated to work
> better with the new feature; but certainly not in this patch.]
>
> Backport to 6.11 should be straightforward. Earlier backports must take
> care that other _deferred_list fixes and dependencies are included.  It
> is unclear whether these fixes are realistically needed before 6.12.
>
> Fixes: 87eaceb3faa5 ("mm: thp: make deferred split shrinker memcg aware")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>
> ---
>  mm/huge_memory.c   | 35 +++++++++++++++++++++--------------
>  mm/internal.h      | 10 +++++-----
>  mm/memcontrol-v1.c | 25 +++++++++++++++++++++++++
>  mm/memcontrol.c    |  8 +++++---
>  mm/migrate.c       |  4 ++--
>  mm/page_alloc.c    |  4 +++-
>  mm/swap.c          |  4 ++--
>  mm/vmscan.c        |  4 ++--
>  8 files changed, 65 insertions(+), 29 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index a1d345f1680c..dc7d5bb76495 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3588,10 +3588,27 @@ int split_folio_to_list(struct folio *folio, stru=
ct list_head *list)
>         return split_huge_page_to_list_to_order(&folio->page, list, ret);
>  }
>
> -void __folio_undo_large_rmappable(struct folio *folio)
> +/*
> + * __folio_unqueue_deferred_split() is not to be called directly:
> + * the folio_unqueue_deferred_split() inline wrapper in mm/internal.h
> + * limits its calls to those folios which may have a _deferred_list for
> + * queueing THP splits, and that list is (racily observed to be) non-emp=
ty.
> + *
> + * It is unsafe to call folio_unqueue_deferred_split() until folio refco=
unt is
> + * zero: because even when split_queue_lock is held, a non-empty _deferr=
ed_list
> + * might be in use on deferred_split_scan()'s unlocked on-stack list.
> + *
> + * If memory cgroups are enabled, split_queue_lock is in the mem_cgroup:=
 it is
> + * therefore important to unqueue deferred split before changing folio m=
emcg.
> + */
> +bool __folio_unqueue_deferred_split(struct folio *folio)
>  {
>         struct deferred_split *ds_queue;
>         unsigned long flags;
> +       bool unqueued =3D false;
> +
> +       WARN_ON_ONCE(folio_ref_count(folio));
> +       WARN_ON_ONCE(!mem_cgroup_disabled() && !folio_memcg(folio));
>
>         ds_queue =3D get_deferred_split_queue(folio);
>         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> @@ -3603,8 +3620,11 @@ void __folio_undo_large_rmappable(struct folio *fo=
lio)
>                                       MTHP_STAT_NR_ANON_PARTIALLY_MAPPED,=
 -1);
>                 }
>                 list_del_init(&folio->_deferred_list);
> +               unqueued =3D true;
>         }
>         spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
> +
> +       return unqueued;        /* useful for debug warnings */
>  }
>
>  /* partially_mapped=3Dfalse won't clear PG_partially_mapped folio flag *=
/
> @@ -3626,19 +3646,6 @@ void deferred_split_folio(struct folio *folio, boo=
l partially_mapped)
>         if (!partially_mapped && !split_underused_thp)
>                 return;
>
> -       /*
> -        * The try_to_unmap() in page reclaim path might reach here too,
> -        * this may cause a race condition to corrupt deferred split queu=
e.
> -        * And, if page reclaim is already handling the same folio, it is
> -        * unnecessary to handle it again in shrinker.
> -        *
> -        * Check the swapcache flag to determine if the folio is being
> -        * handled by page reclaim since THP swap would add the folio int=
o
> -        * swap cache before calling try_to_unmap().
> -        */
> -       if (folio_test_swapcache(folio))
> -               return;
> -
>         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>         if (partially_mapped) {
>                 if (!folio_test_partially_mapped(folio)) {
> diff --git a/mm/internal.h b/mm/internal.h
> index 93083bbeeefa..16c1f3cd599e 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -639,11 +639,11 @@ static inline void folio_set_order(struct folio *fo=
lio, unsigned int order)
>  #endif
>  }
>
> -void __folio_undo_large_rmappable(struct folio *folio);
> -static inline void folio_undo_large_rmappable(struct folio *folio)
> +bool __folio_unqueue_deferred_split(struct folio *folio);
> +static inline bool folio_unqueue_deferred_split(struct folio *folio)
>  {
>         if (folio_order(folio) <=3D 1 || !folio_test_large_rmappable(foli=
o))
> -               return;
> +               return false;
>
>         /*
>          * At this point, there is no one trying to add the folio to
> @@ -651,9 +651,9 @@ static inline void folio_undo_large_rmappable(struct =
folio *folio)
>          * to check without acquiring the split_queue_lock.
>          */
>         if (data_race(list_empty(&folio->_deferred_list)))
> -               return;
> +               return false;
>
> -       __folio_undo_large_rmappable(folio);
> +       return __folio_unqueue_deferred_split(folio);
>  }
>
>  static inline struct folio *page_rmappable_folio(struct page *page)
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index 81d8819f13cd..f8744f5630bb 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -848,6 +848,8 @@ static int mem_cgroup_move_account(struct folio *foli=
o,
>         css_get(&to->css);
>         css_put(&from->css);
>
> +       /* Warning should never happen, so don't worry about refcount non=
-0 */
> +       WARN_ON_ONCE(folio_unqueue_deferred_split(folio));
>         folio->memcg_data =3D (unsigned long)to;
>
>         __folio_memcg_unlock(from);
> @@ -1217,7 +1219,9 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *=
pmd,
>         enum mc_target_type target_type;
>         union mc_target target;
>         struct folio *folio;
> +       bool tried_split_before =3D false;
>
> +retry_pmd:
>         ptl =3D pmd_trans_huge_lock(pmd, vma);
>         if (ptl) {
>                 if (mc.precharge < HPAGE_PMD_NR) {
> @@ -1227,6 +1231,27 @@ static int mem_cgroup_move_charge_pte_range(pmd_t =
*pmd,
>                 target_type =3D get_mctgt_type_thp(vma, addr, *pmd, &targ=
et);
>                 if (target_type =3D=3D MC_TARGET_PAGE) {
>                         folio =3D target.folio;
> +                       /*
> +                        * Deferred split queue locking depends on memcg,
> +                        * and unqueue is unsafe unless folio refcount is=
 0:
> +                        * split or skip if on the queue? first try to sp=
lit.
> +                        */
> +                       if (!list_empty(&folio->_deferred_list)) {
> +                               spin_unlock(ptl);
> +                               if (!tried_split_before)
> +                                       split_folio(folio);
> +                               folio_unlock(folio);
> +                               folio_put(folio);
> +                               if (tried_split_before)
> +                                       return 0;
> +                               tried_split_before =3D true;
> +                               goto retry_pmd;
> +                       }
> +                       /*
> +                        * So long as that pmd lock is held, the folio ca=
nnot
> +                        * be racily added to the _deferred_list, because
> +                        * __folio_remove_rmap() will find !partially_map=
ped.
> +                        */
>                         if (folio_isolate_lru(folio)) {
>                                 if (!mem_cgroup_move_account(folio, true,
>                                                              mc.from, mc.=
to)) {
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 2703227cce88..06df2af97415 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4629,9 +4629,6 @@ static void uncharge_folio(struct folio *folio, str=
uct uncharge_gather *ug)
>         struct obj_cgroup *objcg;
>
>         VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
> -       VM_BUG_ON_FOLIO(folio_order(folio) > 1 &&
> -                       !folio_test_hugetlb(folio) &&
> -                       !list_empty(&folio->_deferred_list), folio);
>
>         /*
>          * Nobody should be changing or seriously looking at
> @@ -4678,6 +4675,7 @@ static void uncharge_folio(struct folio *folio, str=
uct uncharge_gather *ug)
>                         ug->nr_memory +=3D nr_pages;
>                 ug->pgpgout++;
>
> +               WARN_ON_ONCE(folio_unqueue_deferred_split(folio));
>                 folio->memcg_data =3D 0;
>         }
>
> @@ -4789,6 +4787,9 @@ void mem_cgroup_migrate(struct folio *old, struct f=
olio *new)
>
>         /* Transfer the charge and the css ref */
>         commit_charge(new, memcg);
> +
> +       /* Warning should never happen, so don't worry about refcount non=
-0 */
> +       WARN_ON_ONCE(folio_unqueue_deferred_split(old));
>         old->memcg_data =3D 0;
>  }
>
> @@ -4975,6 +4976,7 @@ void mem_cgroup_swapout(struct folio *folio, swp_en=
try_t entry)
>         VM_BUG_ON_FOLIO(oldid, folio);
>         mod_memcg_state(swap_memcg, MEMCG_SWAP, nr_entries);
>
> +       folio_unqueue_deferred_split(folio);
>         folio->memcg_data =3D 0;
>
>         if (!mem_cgroup_is_root(memcg))
> diff --git a/mm/migrate.c b/mm/migrate.c
> index df91248755e4..691f25ee2489 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -489,7 +489,7 @@ static int __folio_migrate_mapping(struct address_spa=
ce *mapping,
>                     folio_test_large_rmappable(folio)) {
>                         if (!folio_ref_freeze(folio, expected_count))
>                                 return -EAGAIN;
> -                       folio_undo_large_rmappable(folio);
> +                       folio_unqueue_deferred_split(folio);
>                         folio_ref_unfreeze(folio, expected_count);
>                 }
>
> @@ -514,7 +514,7 @@ static int __folio_migrate_mapping(struct address_spa=
ce *mapping,
>         }
>
>         /* Take off deferred split queue while frozen and memcg set */
> -       folio_undo_large_rmappable(folio);
> +       folio_unqueue_deferred_split(folio);
>
>         /*
>          * Now we know that no one else is looking at the folio:
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 4b21a368b4e2..57f64b5d0004 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2681,7 +2681,9 @@ void free_unref_folios(struct folio_batch *folios)
>                 unsigned long pfn =3D folio_pfn(folio);
>                 unsigned int order =3D folio_order(folio);
>
> -               folio_undo_large_rmappable(folio);
> +               if (mem_cgroup_disabled())
> +                       folio_unqueue_deferred_split(folio);

This looks confusing. It looks all callsites of free_unref_folios()
have folio_unqueue_deferred_split() and memcg uncharge called before
it. If there is any problem, memcg uncharge should catch it. Did I
miss something?

> +
>                 if (!free_pages_prepare(&folio->page, order))
>                         continue;
>                 /*
> diff --git a/mm/swap.c b/mm/swap.c
> index 835bdf324b76..b8e3259ea2c4 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -121,7 +121,7 @@ void __folio_put(struct folio *folio)
>         }
>
>         page_cache_release(folio);
> -       folio_undo_large_rmappable(folio);
> +       folio_unqueue_deferred_split(folio);
>         mem_cgroup_uncharge(folio);
>         free_unref_page(&folio->page, folio_order(folio));
>  }
> @@ -988,7 +988,7 @@ void folios_put_refs(struct folio_batch *folios, unsi=
gned int *refs)
>                         free_huge_folio(folio);
>                         continue;
>                 }
> -               folio_undo_large_rmappable(folio);
> +               folio_unqueue_deferred_split(folio);
>                 __page_cache_release(folio, &lruvec, &flags);
>
>                 if (j !=3D i)
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index eb4e8440c507..635d45745b73 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1475,7 +1475,7 @@ static unsigned int shrink_folio_list(struct list_h=
ead *folio_list,
>                  */
>                 nr_reclaimed +=3D nr_pages;
>
> -               folio_undo_large_rmappable(folio);
> +               folio_unqueue_deferred_split(folio);
>                 if (folio_batch_add(&free_folios, folio) =3D=3D 0) {
>                         mem_cgroup_uncharge_folios(&free_folios);
>                         try_to_unmap_flush();
> @@ -1863,7 +1863,7 @@ static unsigned int move_folios_to_lru(struct lruve=
c *lruvec,
>                 if (unlikely(folio_put_testzero(folio))) {
>                         __folio_clear_lru_flags(folio);
>
> -                       folio_undo_large_rmappable(folio);
> +                       folio_unqueue_deferred_split(folio);
>                         if (folio_batch_add(&free_folios, folio) =3D=3D 0=
) {
>                                 spin_unlock_irq(&lruvec->lru_lock);
>                                 mem_cgroup_uncharge_folios(&free_folios);
> --
> 2.35.3

