Return-Path: <linux-kernel+bounces-275443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E9C9485CA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 236651C21C30
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 23:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21452155307;
	Mon,  5 Aug 2024 23:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxuKe8VB"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EE614A088
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 23:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722899496; cv=none; b=uBmeNNmiGOlQjH9GjzOiPXdDIXFZSSPUAJhCCuVF00Ccm0Ox0q4+59/sN3kNkvCL+CiV+D7ChMekHGhLkPC41A+4jaIa8vy1yWhn60CCdnz1JTXn2SnRVEu8AkEh/9x0kpJNKNqspnCribDDqudrRceMa3PFaZcucj4ZZoHlbUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722899496; c=relaxed/simple;
	bh=+mkBDlJhlWFcayo/y57jXThxgMERdrVD9KgO1fiYA/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O85yKbYTpWiSbutzK9fAZc4E3jT9QHFOYpVvFwoW062uPqG7j+DyIrlLkXmue5ocXIGPMI5v7cfWiL13eW4ZOTcnKtbIysAcBbMNnVkf0o6CKFBCYIpnuA9NTHwLQcFX0vRE4mAnr5ZC8pmgyZpcGwCcMH5kmerY++SRc3EowAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxuKe8VB; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-70943713472so4174799a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 16:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722899494; x=1723504294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMR8iN/O7kgqDgb1/puphv50VjW/RsvtYTC3HHTUkBg=;
        b=PxuKe8VBZUaYAel6jCAqpSRVbbGwFB95KJIepfdn2Br+Z7H6z5uZjrDYDzAUdBuIij
         f73DZbBtmL5VWfVMZRX76Ozw1BsubMLvg8tgPpQu5ga4GaUZZuGkZ7+/WpLoAh0K7BjT
         vzFqjWXWPpyXxBR6+YL3qm883IXVtvRyvadk2koxPZfnpjlaqpM5vH06M/N7LLQ4Ijyg
         lSnGz62RHkYYMUEUJKaRyWUc16Zn4pgWWY1qLuo038X69PJajTti3rHKJU6dyVwKKXdG
         1XEkNTLyoQAGgpsPpC+akO/FE8sSTVMr2xdIcPuwuYxc3n7KfQTP3XU2XMPLlxhH+b2P
         xgoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722899494; x=1723504294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMR8iN/O7kgqDgb1/puphv50VjW/RsvtYTC3HHTUkBg=;
        b=EdnkSf6C5xwpQH4MNAqOYc7zThaCTTMlkto2RkLQsbGWlbBCbNvWA53+01s+jpSDvz
         UI+STY5yyg+ZR2HxEk3DhW3iN+C9ikLs6GGdQRdlZuBk/PiEttd7WGbhsouniPId6/SN
         of3XlXIwa24VEpfRS9ii6rBh8kAjc8INzMOhlg8OOjJpArjIsJCBUz9DAgyWyKAS/miF
         TSTqIQyqMPvXKKiJReoEmZYS2qwq8x5w8QryIzv1FF8r8L/OzTvq4xd3cudHh/0fFoJ5
         W4LLx9SVuiwA1YIlppR1J6buA/NrRq33Zf0DcDZkhRB28lHblrpqhn6GginPniS9ZJdn
         TGJg==
X-Forwarded-Encrypted: i=1; AJvYcCXCzmYfmCM9ed6gSt+5R1OvoVQqBFACv4gcv/of5F2Gg6+m+qi7QsijwnQKCRmwtnN+a5bVgyb2ZJmC3DC2XHWqBbuwDY+/C+uU2zG0
X-Gm-Message-State: AOJu0YwBzhTgGT8YGzXwQd9sysG0J/TJ1hPQk7qkvJr2DFcbIpArhR9g
	PxhqioSbh5NEiC35SX3/hAILDpT/3UMn4XH31siNe9aCfqcFr8LzCsNclMcnZQY6E387Ztdz+Pg
	7AlY8vmGkd9Zg5xX3CTyPa8737fk=
X-Google-Smtp-Source: AGHT+IEBYyDaA6Q3Zx3x+sgnLlgC1sfXJB9neHTJ2Oy8cXboJVp9BCDEnmwk1kmxZRPaEF+GwdPb6qAJnKWrUQ4eutU=
X-Received: by 2002:a05:6358:6f1a:b0:1ac:65e7:939f with SMTP id
 e5c5f4694b2df-1af3baaa16emr1648001255d.11.1722899493780; Mon, 05 Aug 2024
 16:11:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730222707.2324536-1-nphamcs@gmail.com> <20240730222707.2324536-2-nphamcs@gmail.com>
 <CAJD7tkYujNCPzrXfmRqFYESeAnrzgJYys-R_=Ftx=rJkUuhBWw@mail.gmail.com>
In-Reply-To: <CAJD7tkYujNCPzrXfmRqFYESeAnrzgJYys-R_=Ftx=rJkUuhBWw@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 5 Aug 2024 16:11:20 -0700
Message-ID: <CAKEwX=M24GgiAHbwEqef=rBT94SvSnHwX-zKz78WO+C9HjJjOQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] zswap: implement a second chance algorithm for
 dynamic zswap shrinker
To: Yosry Ahmed <yosryahmed@google.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, shakeel.butt@linux.dev, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	flintglass@gmail.com, chengming.zhou@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 12:57=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Tue, Jul 30, 2024 at 3:27=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wro=
te:
> >
> > Current zswap shrinker's heuristics to prevent overshrinking is brittle
> > and inaccurate, specifically in the way we decay the protection size
> > (i.e making pages in the zswap LRU eligible for reclaim).
> >
> > We currently decay protection aggressively in zswap_lru_add() calls.
> > This leads to the following unfortunate effect: when a new batch of
> > pages enter zswap, the protection size rapidly decays to below 25% of
> > the zswap LRU size, which is way too low.
> >
> > We have observed this effect in production, when experimenting with the
> > zswap shrinker: the rate of shrinking shoots up massively right after a
> > new batch of zswap stores. This is somewhat the opposite of what we wan=
t
> > originally - when new pages enter zswap, we want to protect both these
> > new pages AND the pages that are already protected in the zswap LRU.
> >
> > Replace existing heuristics with a second chance algorithm
> >
> > 1. When a new zswap entry is stored in the zswap pool, its reference bi=
t
> >    is set.
>
> Probably worth mentioning that this is added in a hole and doesn't
> consume any extra memory.

Will do!

>
> > 2. When the zswap shrinker encounters a zswap entry with the reference
> >    bit set, give it a second chance - only flips the reference bit and
> >    rotate it in the LRU.
> > 3. If the shrinker encounters the entry again, this time with its
> >    reference bit unset, then it can reclaim the entry.
> >
> > In this manner, the aging of the pages in the zswap LRUs are decoupled
> > from zswap stores, and picks up the pace with increasing memory pressur=
e
> > (which is what we want).
> >
> > The second chance scheme allows us to modulate the writeback rate based
> > on recent pool activities. Entries that recently entered the pool will
> > be protected, so if the pool is dominated by such entries the writeback
> > rate will reduce proportionally, protecting the workload's workingset.O=
n
> > the other hand, stale entries will be written back quickly, which
> > increases the effective writeback rate.
> >
> > We will still maintain the count of swapins, which is consumed and
> > subtracted from the lru size in zswap_shrinker_count(), to further
> > penalize past overshrinking that led to disk swapins. The idea is that
> > had we considered this many more pages in the LRU active/protected, the=
y
> > would not have been written back and we would not have had to swapped
> > them in.
> >
> > To test this new heuristics, I built the kernel under a cgroup with
> > memory.max set to 2G, on a host with 36 cores:
> >
> > With the old shrinker:
> >
> > real: 263.89s
> > user: 4318.11s
> > sys: 673.29s
> > swapins: 227300.5
> >
> > With the second chance algorithm:
> >
> > real: 244.85s
> > user: 4327.22s
> > sys: 664.39s
> > swapins: 94663
> >
> > (average over 5 runs)
> >
> > We observe an 1.3% reduction in kernel CPU usage, and around 7.2%
> > reduction in real time. Note that the number of swapped in pages
> > dropped by 58%.
> >
> > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > ---
> >  include/linux/zswap.h |  16 +++---
> >  mm/zswap.c            | 110 ++++++++++++++++++++++++------------------
> >  2 files changed, 70 insertions(+), 56 deletions(-)
> >
> > diff --git a/include/linux/zswap.h b/include/linux/zswap.h
> > index 6cecb4a4f68b..b94b6ae262d5 100644
> > --- a/include/linux/zswap.h
> > +++ b/include/linux/zswap.h
> > @@ -13,17 +13,15 @@ extern atomic_t zswap_stored_pages;
> >
> >  struct zswap_lruvec_state {
> >         /*
> > -        * Number of pages in zswap that should be protected from the s=
hrinker.
> > -        * This number is an estimate of the following counts:
> > +        * Number of swapped in pages, i.e not found in the zswap pool.
>
> With the next patch, this should be "Number of swapped in pages from
> disk". Without the "from disk", the second part about not being found
> in the zswap pool doesn't really make sense.
>
> Maybe also the variable name should be changed to nr_disk_swapins or simi=
lar.

Sounds good :)

>
> >          *
> > -        * a) Recent page faults.
> > -        * b) Recent insertion to the zswap LRU. This includes new zswa=
p stores,
> > -        *    as well as recent zswap LRU rotations.
> > -        *
> > -        * These pages are likely to be warm, and might incur IO if the=
 are written
> > -        * to swap.
> > +        * This is consumed and subtracted from the lru size in
> > +        * zswap_shrinker_count() to penalize past overshrinking that l=
ed to disk
> > +        * swapins. The idea is that had we considered this many more p=
ages in the
> > +        * LRU active/protected and not written them back, we would not=
 have had to
> > +        * swapped them in.
> >          */
> > -       atomic_long_t nr_zswap_protected;
> > +       atomic_long_t nr_swapins;
> >  };
> >
> >  unsigned long zswap_total_pages(void);
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index adeaf9c97fde..f4e001c9e7e0 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -184,6 +184,10 @@ static struct shrinker *zswap_shrinker;
> >   * page within zswap.
> >   *
> >   * swpentry - associated swap entry, the offset indexes into the red-b=
lack tree
> > + * referenced - true if the entry recently entered the zswap pool. Uns=
et by the
> > + *              dynamic shrinker. The entry is only reclaimed by the d=
ynamic
> > + *              shrinker if referenced is unset. See comments in the s=
hrinker
> > + *              section for context.
> >   * length - the length in bytes of the compressed page data.  Needed d=
uring
> >   *          decompression. For a same value filled page length is 0, a=
nd both
> >   *          pool and lru are invalid and must be ignored.
> > @@ -196,6 +200,7 @@ static struct shrinker *zswap_shrinker;
> >  struct zswap_entry {
> >         swp_entry_t swpentry;
> >         unsigned int length;
> > +       bool referenced;
> >         struct zswap_pool *pool;
> >         union {
> >                 unsigned long handle;
> > @@ -700,11 +705,10 @@ static inline int entry_to_nid(struct zswap_entry=
 *entry)
> >
> >  static void zswap_lru_add(struct list_lru *list_lru, struct zswap_entr=
y *entry)
> >  {
> > -       atomic_long_t *nr_zswap_protected;
> > -       unsigned long lru_size, old, new;
> >         int nid =3D entry_to_nid(entry);
> >         struct mem_cgroup *memcg;
> > -       struct lruvec *lruvec;
> > +
> > +       entry->referenced =3D true;
>
> Would it be clearer to initialize this in zswap_store() with the rest
> of the zswap_entry initialization?

Sure thing!

>
> >
> >         /*
> >          * Note that it is safe to use rcu_read_lock() here, even in th=
e face of
> > @@ -722,19 +726,6 @@ static void zswap_lru_add(struct list_lru *list_lr=
u, struct zswap_entry *entry)
> >         memcg =3D mem_cgroup_from_entry(entry);
> >         /* will always succeed */
> >         list_lru_add(list_lru, &entry->lru, nid, memcg);
> > -
> > -       /* Update the protection area */
> > -       lru_size =3D list_lru_count_one(list_lru, nid, memcg);
> > -       lruvec =3D mem_cgroup_lruvec(memcg, NODE_DATA(nid));
> > -       nr_zswap_protected =3D &lruvec->zswap_lruvec_state.nr_zswap_pro=
tected;
> > -       old =3D atomic_long_inc_return(nr_zswap_protected);
> > -       /*
> > -        * Decay to avoid overflow and adapt to changing workloads.
> > -        * This is based on LRU reclaim cost decaying heuristics.
> > -        */
> > -       do {
> > -               new =3D old > lru_size / 4 ? old / 2 : old;
> > -       } while (!atomic_long_try_cmpxchg(nr_zswap_protected, &old, new=
));
> >         rcu_read_unlock();
> >  }
> >
> > @@ -752,7 +743,7 @@ static void zswap_lru_del(struct list_lru *list_lru=
, struct zswap_entry *entry)
> >
> >  void zswap_lruvec_state_init(struct lruvec *lruvec)
> >  {
> > -       atomic_long_set(&lruvec->zswap_lruvec_state.nr_zswap_protected,=
 0);
> > +       atomic_long_set(&lruvec->zswap_lruvec_state.nr_swapins, 0);
> >  }
> >
> >  void zswap_folio_swapin(struct folio *folio)
> > @@ -761,7 +752,7 @@ void zswap_folio_swapin(struct folio *folio)
> >
> >         if (folio) {
> >                 lruvec =3D folio_lruvec(folio);
> > -               atomic_long_inc(&lruvec->zswap_lruvec_state.nr_zswap_pr=
otected);
> > +               atomic_long_inc(&lruvec->zswap_lruvec_state.nr_swapins)=
;
> >         }
> >  }
> >
> > @@ -1082,6 +1073,28 @@ static int zswap_writeback_entry(struct zswap_en=
try *entry,
> >  static enum lru_status shrink_memcg_cb(struct list_head *item, struct =
list_lru_one *l,
> >                                        spinlock_t *lock, void *arg)
> >  {
> > @@ -1091,6 +1104,16 @@ static enum lru_status shrink_memcg_cb(struct li=
st_head *item, struct list_lru_o
> >         enum lru_status ret =3D LRU_REMOVED_RETRY;
> >         int writeback_result;
> >
> > +       /*
> > +        * Second chance algorithm: if the entry has its referenced bit=
 set, give it
> > +        * a second chance. Only clear the referenced bit and rotate it=
 in the
> > +        * zswap's LRU list.
> > +        */
> > +       if (entry->referenced) {
> > +               entry->referenced =3D false;
> > +               return LRU_ROTATE;
> > +       }
> > +
> >         /*
> >          * As soon as we drop the LRU lock, the entry can be freed by
> >          * a concurrent invalidation. This means the following:
> > @@ -1157,8 +1180,7 @@ static enum lru_status shrink_memcg_cb(struct lis=
t_head *item, struct list_lru_o
> >  static unsigned long zswap_shrinker_scan(struct shrinker *shrinker,
> >                 struct shrink_control *sc)
> >  {
> > -       struct lruvec *lruvec =3D mem_cgroup_lruvec(sc->memcg, NODE_DAT=
A(sc->nid));
> > -       unsigned long shrink_ret, nr_protected, lru_size;
> > +       unsigned long shrink_ret;
> >         bool encountered_page_in_swapcache =3D false;
> >
> >         if (!zswap_shrinker_enabled ||
> > @@ -1167,25 +1189,6 @@ static unsigned long zswap_shrinker_scan(struct =
shrinker *shrinker,
> >                 return SHRINK_STOP;
> >         }
> >
> > -       nr_protected =3D
> > -               atomic_long_read(&lruvec->zswap_lruvec_state.nr_zswap_p=
rotected);
> > -       lru_size =3D list_lru_shrink_count(&zswap_list_lru, sc);
> > -
> > -       /*
> > -        * Abort if we are shrinking into the protected region.
> > -        *
> > -        * This short-circuiting is necessary because if we have too ma=
ny multiple
> > -        * concurrent reclaimers getting the freeable zswap object coun=
ts at the
> > -        * same time (before any of them made reasonable progress), the=
 total
> > -        * number of reclaimed objects might be more than the number of=
 unprotected
> > -        * objects (i.e the reclaimers will reclaim into the protected =
area of the
> > -        * zswap LRU).
> > -        */
> > -       if (nr_protected >=3D lru_size - sc->nr_to_scan) {
> > -               sc->nr_scanned =3D 0;
> > -               return SHRINK_STOP;
> > -       }
> > -
>
> Do we need a similar mechanism to protect against concurrent shrinkers
> quickly consuming nr_swapins?

Not for nr_swapins consumption per se, and the original reason why I
included this (racy) check is just so that concurrent reclaimers do
not disrespect the protection scheme. We had no guarantee that we
wouldn't just reclaim into the protected region (well even with this
racy check technically). With the second chance scheme, a "protected"
page (i.e with its referenced bit set) would not be reclaimed right
away - a shrinker encountering it would have to "age" it first (by
unsetting the referenced bit), so the intended protection is enforced.

That said, I do believe we need a mechanism to limit the concurrency
here. The amount of pages aged/reclaimed should scale (linearly?
proportionally?) with the reclaim pressure, i.e more reclaimers =3D=3D
more pages reclaimed/aged, so the current behavior is desired.
However, at some point, if we have more shrinkers than there are work
assigned to each of them, we might be unnecessarily wasting resources
(and potentially building up the nr_deferred counter that we discussed
in v1 of the patch series). Additionally, we might be overshrinking in
a very short amount of time, without letting the system have the
chance to react and provide feedback (through swapins/refaults) to the
memory reclaimers.

But let's do this as a follow-up work :) It seems orthogonal to what
we have here.

> > -        * Subtract the lru size by an estimate of the number of pages
> > -        * that should be protected.
> > +        * Subtract the lru size by the number of pages that are recent=
ly swapped
>
> nit: I don't think "subtract by" is correct, it's usually "subtract
> from". So maybe "Subtract the number of pages that are recently
> swapped in from the lru size"? Also, should we remain consistent about
> mentioning that these are disk swapins throughout all the comments to
> keep things clear?

Yeah I should be clearer here - it should be swapped in from disk, or
more generally (accurately?) swapped in from the backing swap device
(but the latter can change once we decoupled swap from zswap). Or
maybe swapped in from the secondary tier?

Let's just not overthink and go with swapped in from disk for now :)

>
> > +        * in. The idea is that had we protect the zswap's LRU by this =
amount of
> > +        * pages, these swap in would not have happened.
> >          */
> > -       nr_freeable =3D nr_freeable > nr_protected ? nr_freeable - nr_p=
rotected : 0;
> > +       nr_swapins_cur =3D atomic_long_read(nr_swapins);
> > +       do {
> > +               if (lru_size >=3D nr_swapins_cur)
> > +                       nr_remain =3D 0;
> > +               else
> > +                       nr_remain =3D nr_swapins_cur - lru_size;
> > +       } while (!atomic_long_try_cmpxchg(nr_swapins, &nr_swapins_cur, =
nr_remain));
> > +
> > +       lru_size -=3D nr_swapins_cur - nr_remain;
>
> It's a little bit weird that we reduce the variable named "lru_size"
> by the consumed swapins. Maybe we should keep this named as
> "nr_freeable", or add another variable here to hold the value after
> subtraction?

Hmmmm yeah now I remember why I called it nr_freeable back then. Seems
like past Nhat is a bit smarter than present Nhat :)
I'll just revert this part then.

