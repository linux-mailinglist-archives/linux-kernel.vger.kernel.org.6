Return-Path: <linux-kernel+bounces-380841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D74C29AF6D3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 03:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9785A285F3A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 01:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E3B3FBA5;
	Fri, 25 Oct 2024 01:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Puqb4NTG"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DA238389
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 01:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729819544; cv=none; b=rCP7e9qvyN/wm2ZKS/wbfBZKxHnziMIZRSmjMe5knOLghciiM9NyFVb6npNmztbOC/uf3LhaDFK9SLH3JH3NouxyT9zYHf+PDO932EOya1tOylNsL6kv7QfKhbdv+RqdI9K6v6DaMyscb1Kxfvxr9vcZ9EbTEuOV6JNeovgAACg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729819544; c=relaxed/simple;
	bh=0nslottuT9gPg5wUGV3SSDsavuMHH+G/XVV1//L9A2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=twGSCBo72jK5VodEIgjSWP9PRmgC6u8vC6+vownOL3y77PAzF5a1+UMDx8HIHRONSEsUp6ebpr+Zwm1tDmpWBcmAAcISOxyCQkomabhIPPOUGp2JFTGfSW1uMUm089k6tnXFJC9AyKPG3N6juCMDtobG8ewGJhO28olkA3xOb9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Puqb4NTG; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c9693dc739so1871571a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 18:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729819540; x=1730424340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5s7aeql3P23O+wJGAJNX7yw1mfN0bZ+EB/WGna3iA8=;
        b=Puqb4NTG1CY+pbpQKuqjMHCrB6dPtx8cejAYVolVL+zwzekC53FxImTIhi/fYKBckP
         sIwrNYWmrSd5q/aqurjvOr01hjbYbG4ksunAVywgI9fRApZvqZABY07RBzj+YseWEKnW
         fmFx+5RAJ0JBizvXmw/5ysPzfXuysXDF3XdkvGccX0Fvx/aY6tNdcOaiVLP0Fdwa73mJ
         MsqQWvZbjCGl5uMCh1s6zUACDVCrRVFoR7SUDp92TvTSXpEQhRIDq/KyPQ66jYO8y9Fn
         wCeZXGMrrjWYm8LCsA0GVgaTEV7jQHA3jbizi0o7PK3b9G3iJi9sR/a1gQLEB1D7pFmk
         wuIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729819540; x=1730424340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f5s7aeql3P23O+wJGAJNX7yw1mfN0bZ+EB/WGna3iA8=;
        b=QTAE0s+OgrVl1Puwm60o9svBo415AgcvxKajP7ZVkrLxTDM4uT2Pr1h86hU1ndRclK
         poLILjD5aB601OZwUjHB/sT/c4Lxbbnmn/O/X+I2YX8BhmgLfQEHAmL/P1oFOOJexJzj
         NDRyEmDHe6qU6bAlAYXoGySg6SFDkofOh81In9rrZHA+KKlJ4YIMX1Cl97Z3RhNb4O0W
         e/NlJBgo91Cor/6YB5bsO9J6th9fP9or78SHc4aGO91eeEbxu5b+DG/6ESEu/gppGy5A
         zAYx3tiHoh8s6XL6szvkiEDXyabHEsKyP9tz9TCaAor1craNNFWm9W51AsEw2a7z8vvm
         PZ2w==
X-Forwarded-Encrypted: i=1; AJvYcCU5B3r90LA+LlOlsngLQNFqKCT450s77JsQmGagaevfkigJGeyc8SJ6DyktD+jV9L//6o6f6DuBKMtCBDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwszvSxuHXYVXePNM9HvuH1VMXAuUKDFE8Rotut+ajjx8TXE1M
	urskDedh+D2l1TglZca2QBM/cvquPzxFMq0tMmd87CpbOQ9mlbNyQKeBCt+3byE3FFDt9/wA+7A
	dS6ixewZTBkUWopCaNIZLT9Y60jw=
X-Google-Smtp-Source: AGHT+IFlEu7ei+mljdiUJz1Fy6kWbwBDM2f0zYWJI0Gbq85lvUSIFupRyRHakyYtxfIijJ5nLbDxeJHWXvVo9O1rRRg=
X-Received: by 2002:a05:6402:2695:b0:5cb:acdc:b245 with SMTP id
 4fb4d7f45d1cf-5cbacdcbbb5mr1417658a12.17.1729819539358; Thu, 24 Oct 2024
 18:25:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <760237a3-69d6-9197-432d-0306d52c048a@google.com>
 <7dc6b280-cd87-acd1-1124-e512e3d2217d@google.com> <a5a37ff4-3017-4950-b625-d82871139ebc@redhat.com>
In-Reply-To: <a5a37ff4-3017-4950-b625-d82871139ebc@redhat.com>
From: Yang Shi <shy828301@gmail.com>
Date: Thu, 24 Oct 2024 18:25:28 -0700
Message-ID: <CAHbLzkrWuTEsjq++M4hBkuhAao9d92nOoaCJdij9aHvUP018VQ@mail.gmail.com>
Subject: Re: [PATCH hotfix 2/2] mm/thp: fix deferred split unqueue naming and locking
To: David Hildenbrand <david@redhat.com>
Cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Usama Arif <usamaarif642@gmail.com>, Wei Yang <richard.weiyang@gmail.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Matthew Wilcox <willy@infradead.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Barry Song <baohua@kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Nhat Pham <nphamcs@gmail.com>, Zi Yan <ziy@nvidia.com>, 
	Chris Li <chrisl@kernel.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 1:52=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 24.10.24 06:13, Hugh Dickins wrote:
> > Recent changes are putting more pressure on THP deferred split queues:
> > under load revealing long-standing races, causing list_del corruptions,
> > "Bad page state"s and worse (I keep BUGs in both of those, so usually
> > don't get to see how badly they end up without).  The relevant recent
> > changes being 6.8's mTHP, 6.10's mTHP swapout, and 6.12's mTHP swapin,
> > improved swap allocation, and underused THP splitting.
> >
> > Before fixing locking: rename misleading folio_undo_large_rmappable(),
> > which does not undo large_rmappable, to folio_unqueue_deferred_split(),
> > which is what it does.
>
> Yes please. I stumbled into that myself recently -- leftover from
> previous rework.
>
> It would have been reasonable to move that into a separate (follow-up?)
> patch.
>
> > But that and its out-of-line __callee are mm
> > internals of very limited usability: add comment and WARN_ON_ONCEs to
> > check usage; and return a bool to say if a deferred split was unqueued,
> > which can then be used in WARN_ON_ONCEs around safety checks (sparing
> > callers the arcane conditionals in __folio_unqueue_deferred_split()).
> >
> > Swapout: mem_cgroup_swapout() has been resetting folio->memcg_data 0
> > without checking and unqueueing a THP folio from deferred split list;
> > which is unfortunate, since the split_queue_lock depends on the memcg
> > (when memcg is enabled); so swapout has been unqueueing such THPs later=
,
> > when freeing the folio, using the pgdat's lock instead: potentially
> > corrupting the memcg's list.  __remove_mapping() has frozen refcount to
> > 0 here, so no problem with calling folio_unqueue_deferred_split() befor=
e
> > resetting memcg_data.
> >
> > That goes back to 5.4 commit 87eaceb3faa5 ("mm: thp: make deferred spli=
t
> > shrinker memcg aware"): which included a check on swapcache before addi=
ng
> > to deferred queue (which can now be removed), but no check on deferred
> > queue before adding THP to swapcache (maybe other circumstances prevent=
ed
> > it at that time, but not now).
> >
> > Memcg-v1 move (deprecated): mem_cgroup_move_account() has been changing
> > folio->memcg_data without checking and unqueueing a THP folio from the
> > deferred list, sometimes corrupting "from" memcg's list, like swapout.
> > Refcount is non-zero here, so folio_unqueue_deferred_split() can only b=
e
> > used in a WARN_ON_ONCE to validate the fix, which must be done earlier:
> > mem_cgroup_move_charge_pte_range() first try to split the THP (splittin=
g
> > of course unqueues), or skip it if that fails.  Not ideal, but moving
> > charge has been requested, and khugepaged should repair the THP later:
> > nobody wants new custom unqueueing code just for this deprecated case.
> >
> > The 87eaceb3faa5 commit did have the code to move from one deferred lis=
t
> > to another (but was not conscious of its unsafety while refcount non-0)=
;
> > but that was removed by 5.6 commit fac0516b5534 ("mm: thp: don't need
> > care deferred split queue in memcg charge move path"), which argued tha=
t
> > the existence of a PMD mapping guarantees that the THP cannot be on a
> > deferred list.
>
> I recall this can happen, not sure on 5.6 though: assume we have an anon
> THP with 1 PMD mapping and a single PTE mapping for simplicity.
>
> Assume we want to migrate that folio and first remove the PMD mapping,
> then the PTE mapping. After removing the PMD mapping, we add it to the
> deferred split queue (single PTE mapped).
>
> Now assume migration fails and we remove migration entries -> remap.
>
> We now have a PMD-mapped THP on the deferred split queue.
>
> (again, I might be wrong but that's from memory without digging into the
> code)

It sounds possible to me on 5.6 too. I didn't see
remove_migration_ptes() remove PMD-mapped THP from deferred list. As I
said in earlier email, this case should be not common and we were luck
not to hit it.

>
>
> > I'm not sure if that was true at the time (swapcache
> > remapped?), but it's clearly not true since 6.12 commit dafff3f4c850
> > ("mm: split underused THPs").
>
> We only remap PTEs from the swapcache, never PMDs.
>
> >
> > [Note in passing: mem_cgroup_move_charge_pte_range() just skips mTHPs,
> > large but not PMD-mapped: that's safe, but perhaps not intended: it's
> > arguable whether the deprecated feature should be updated to work
> > better with the new feature; but certainly not in this patch.]
> >
> > Backport to 6.11 should be straightforward. Earlier backports must take
> > care that other _deferred_list fixes and dependencies are included.  It
> > is unclear whether these fixes are realistically needed before 6.12.
> >
> > Fixes: 87eaceb3faa5 ("mm: thp: make deferred split shrinker memcg aware=
")
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > Cc: <stable@vger.kernel.org>
> > ---
> >   mm/huge_memory.c   | 35 +++++++++++++++++++++--------------
> >   mm/internal.h      | 10 +++++-----
> >   mm/memcontrol-v1.c | 25 +++++++++++++++++++++++++
> >   mm/memcontrol.c    |  8 +++++---
> >   mm/migrate.c       |  4 ++--
> >   mm/page_alloc.c    |  4 +++-
> >   mm/swap.c          |  4 ++--
> >   mm/vmscan.c        |  4 ++--
> >   8 files changed, 65 insertions(+), 29 deletions(-)
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index a1d345f1680c..dc7d5bb76495 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -3588,10 +3588,27 @@ int split_folio_to_list(struct folio *folio, st=
ruct list_head *list)
> >       return split_huge_page_to_list_to_order(&folio->page, list, ret);
> >   }
> >
> > -void __folio_undo_large_rmappable(struct folio *folio)
> > +/*
> > + * __folio_unqueue_deferred_split() is not to be called directly:
> > + * the folio_unqueue_deferred_split() inline wrapper in mm/internal.h
> > + * limits its calls to those folios which may have a _deferred_list fo=
r
> > + * queueing THP splits, and that list is (racily observed to be) non-e=
mpty.
> > + *
> > + * It is unsafe to call folio_unqueue_deferred_split() until folio ref=
count is
> > + * zero: because even when split_queue_lock is held, a non-empty _defe=
rred_list
> > + * might be in use on deferred_split_scan()'s unlocked on-stack list.
> > + *
> > + * If memory cgroups are enabled, split_queue_lock is in the mem_cgrou=
p: it is
> > + * therefore important to unqueue deferred split before changing folio=
 memcg.
> > + */
> > +bool __folio_unqueue_deferred_split(struct folio *folio)
> >   {
> >       struct deferred_split *ds_queue;
> >       unsigned long flags;
> > +     bool unqueued =3D false;
> > +
> > +     WARN_ON_ONCE(folio_ref_count(folio));
> > +     WARN_ON_ONCE(!mem_cgroup_disabled() && !folio_memcg(folio));
> >
> >       ds_queue =3D get_deferred_split_queue(folio);
> >       spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> > @@ -3603,8 +3620,11 @@ void __folio_undo_large_rmappable(struct folio *=
folio)
> >                                     MTHP_STAT_NR_ANON_PARTIALLY_MAPPED,=
 -1);
> >               }
> >               list_del_init(&folio->_deferred_list);
> > +             unqueued =3D true;
> >       }
> >       spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
> > +
> > +     return unqueued;        /* useful for debug warnings */
> >   }
> >
> >   /* partially_mapped=3Dfalse won't clear PG_partially_mapped folio fla=
g */
> > @@ -3626,19 +3646,6 @@ void deferred_split_folio(struct folio *folio, b=
ool partially_mapped)
> >       if (!partially_mapped && !split_underused_thp)
> >               return;
> >
> > -     /*
> > -      * The try_to_unmap() in page reclaim path might reach here too,
> > -      * this may cause a race condition to corrupt deferred split queu=
e.
> > -      * And, if page reclaim is already handling the same folio, it is
> > -      * unnecessary to handle it again in shrinker.
> > -      *
> > -      * Check the swapcache flag to determine if the folio is being
> > -      * handled by page reclaim since THP swap would add the folio int=
o
> > -      * swap cache before calling try_to_unmap().
> > -      */
> > -     if (folio_test_swapcache(folio))
> > -             return;
> > -
> >       spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> >       if (partially_mapped) {
> >               if (!folio_test_partially_mapped(folio)) {
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 93083bbeeefa..16c1f3cd599e 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -639,11 +639,11 @@ static inline void folio_set_order(struct folio *=
folio, unsigned int order)
> >   #endif
> >   }
> >
> > -void __folio_undo_large_rmappable(struct folio *folio);
> > -static inline void folio_undo_large_rmappable(struct folio *folio)
> > +bool __folio_unqueue_deferred_split(struct folio *folio);
> > +static inline bool folio_unqueue_deferred_split(struct folio *folio)
> >   {
> >       if (folio_order(folio) <=3D 1 || !folio_test_large_rmappable(foli=
o))
>
> The rmappable check here is still confusing for me. I assume we want to
> exclude hugetlb or others that reuse the field for other purposes ...
>
> > -             return;
> > +             return false;
> >
> >       /*
> >        * At this point, there is no one trying to add the folio to
> > @@ -651,9 +651,9 @@ static inline void folio_undo_large_rmappable(struc=
t folio *folio)
> >        * to check without acquiring the split_queue_lock.
> >        */
> >       if (data_race(list_empty(&folio->_deferred_list)))
> > -             return;
> > +             return false;
> >
> > -     __folio_undo_large_rmappable(folio);
> > +     return __folio_unqueue_deferred_split(folio);
> >   }
> >
> >   static inline struct folio *page_rmappable_folio(struct page *page)
> > diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> > index 81d8819f13cd..f8744f5630bb 100644
> > --- a/mm/memcontrol-v1.c
> > +++ b/mm/memcontrol-v1.c
> > @@ -848,6 +848,8 @@ static int mem_cgroup_move_account(struct folio *fo=
lio,
> >       css_get(&to->css);
> >       css_put(&from->css);
> >
> > +     /* Warning should never happen, so don't worry about refcount non=
-0 */
> > +     WARN_ON_ONCE(folio_unqueue_deferred_split(folio));
> >       folio->memcg_data =3D (unsigned long)to;
> >
> >       __folio_memcg_unlock(from);
> > @@ -1217,7 +1219,9 @@ static int mem_cgroup_move_charge_pte_range(pmd_t=
 *pmd,
> >       enum mc_target_type target_type;
> >       union mc_target target;
> >       struct folio *folio;
> > +     bool tried_split_before =3D false;
> >
> > +retry_pmd:
> >       ptl =3D pmd_trans_huge_lock(pmd, vma);
> >       if (ptl) {
> >               if (mc.precharge < HPAGE_PMD_NR) {
> > @@ -1227,6 +1231,27 @@ static int mem_cgroup_move_charge_pte_range(pmd_=
t *pmd,
> >               target_type =3D get_mctgt_type_thp(vma, addr, *pmd, &targ=
et);
> >               if (target_type =3D=3D MC_TARGET_PAGE) {
> >                       folio =3D target.folio;
> > +                     /*
> > +                      * Deferred split queue locking depends on memcg,
> > +                      * and unqueue is unsafe unless folio refcount is=
 0:
> > +                      * split or skip if on the queue? first try to sp=
lit.
> > +                      */
> > +                     if (!list_empty(&folio->_deferred_list)) {
> > +                             spin_unlock(ptl);
> > +                             if (!tried_split_before)
> > +                                     split_folio(folio);
> > +                             folio_unlock(folio);
> > +                             folio_put(folio);
> > +                             if (tried_split_before)
> > +                                     return 0;
> > +                             tried_split_before =3D true;
> > +                             goto retry_pmd;
> > +                     }
> > +                     /*
> > +                      * So long as that pmd lock is held, the folio ca=
nnot
> > +                      * be racily added to the _deferred_list, because
> > +                      * __folio_remove_rmap() will find !partially_map=
ped.
> > +                      */
> >                       if (folio_isolate_lru(folio)) {
> >                               if (!mem_cgroup_move_account(folio, true,
> >                                                            mc.from, mc.=
to)) {
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 2703227cce88..06df2af97415 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -4629,9 +4629,6 @@ static void uncharge_folio(struct folio *folio, s=
truct uncharge_gather *ug)
> >       struct obj_cgroup *objcg;
> >
> >       VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
> > -     VM_BUG_ON_FOLIO(folio_order(folio) > 1 &&
> > -                     !folio_test_hugetlb(folio) &&
> > -                     !list_empty(&folio->_deferred_list), folio);
> >
> >       /*
> >        * Nobody should be changing or seriously looking at
> > @@ -4678,6 +4675,7 @@ static void uncharge_folio(struct folio *folio, s=
truct uncharge_gather *ug)
> >                       ug->nr_memory +=3D nr_pages;
> >               ug->pgpgout++;
> >
> > +             WARN_ON_ONCE(folio_unqueue_deferred_split(folio));
> >               folio->memcg_data =3D 0;
> >       }
> >
> > @@ -4789,6 +4787,9 @@ void mem_cgroup_migrate(struct folio *old, struct=
 folio *new)
> >
> >       /* Transfer the charge and the css ref */
> >       commit_charge(new, memcg);
> > +
> > +     /* Warning should never happen, so don't worry about refcount non=
-0 */
> > +     WARN_ON_ONCE(folio_unqueue_deferred_split(old));
> >       old->memcg_data =3D 0;
> >   }
> >
> > @@ -4975,6 +4976,7 @@ void mem_cgroup_swapout(struct folio *folio, swp_=
entry_t entry)
> >       VM_BUG_ON_FOLIO(oldid, folio);
> >       mod_memcg_state(swap_memcg, MEMCG_SWAP, nr_entries);
> >
> > +     folio_unqueue_deferred_split(folio);
> >       folio->memcg_data =3D 0;
> >
> >       if (!mem_cgroup_is_root(memcg))
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index df91248755e4..691f25ee2489 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -489,7 +489,7 @@ static int __folio_migrate_mapping(struct address_s=
pace *mapping,
> >                   folio_test_large_rmappable(folio)) {
> >                       if (!folio_ref_freeze(folio, expected_count))
> >                               return -EAGAIN;
> > -                     folio_undo_large_rmappable(folio);
> > +                     folio_unqueue_deferred_split(folio);
> >                       folio_ref_unfreeze(folio, expected_count);
> >               }
> >
> > @@ -514,7 +514,7 @@ static int __folio_migrate_mapping(struct address_s=
pace *mapping,
> >       }
> >
> >       /* Take off deferred split queue while frozen and memcg set */
> > -     folio_undo_large_rmappable(folio);
> > +     folio_unqueue_deferred_split(folio);
> >
> >       /*
> >        * Now we know that no one else is looking at the folio:
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 4b21a368b4e2..57f64b5d0004 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -2681,7 +2681,9 @@ void free_unref_folios(struct folio_batch *folios=
)
> >               unsigned long pfn =3D folio_pfn(folio);
> >               unsigned int order =3D folio_order(folio);
> >
> > -             folio_undo_large_rmappable(folio);
> > +             if (mem_cgroup_disabled())
> > +                     folio_unqueue_deferred_split(folio);
> > +
>
> Is it worth adding a comment here where we take care of ths with memcg
> enabled?
>
> It's complicated stuff, nothing jumped at me, but it's late here so my
> brain is not fully functional ...
>
> --
> Cheers,
>
> David / dhildenb
>

