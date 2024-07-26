Return-Path: <linux-kernel+bounces-263789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4A493DA7E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4F4B1F23FAF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BF1154C10;
	Fri, 26 Jul 2024 21:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oLd02Dfd"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4543154BEC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 21:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722031138; cv=none; b=cMfHVlJBNklNGXWk3PM3HVkhkETYjmFnouseLKdVz23fkFjJuo5tukfD3eYesqBe8m4nmLdLoDkoM3OwPZcPk4Gbye/Jf6G1q5p2P/02FwC9ZjCWojpUZqZkeIroth0yfGr+rLiWCxEsmFRydh3eGt3PyjJFx8xIU+THS7OV6fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722031138; c=relaxed/simple;
	bh=s8/EbX2qlk+JBXIfn7sv8u4yEN77EoK/X570BO1STHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ljtBwMw/D9KoM33VL03WHgSUYTLCcq9Ptg7xIFYY/1SdqGPvPznp9pcb+AA7O9X2w3FPNqtCEKk/m2sUuHvWNkLLhhJL88KioDPEy8EYtw2ARPpLG+IeA2Pr5GcZCD6VqDCwB1eOlHPlW6A3rkBxQvWTg0gUdocSMOZyZ+1yHNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oLd02Dfd; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52efba36802so2901410e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 14:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722031134; x=1722635934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pp3k1dVESRj5IkAa6qsSz0zUBIRiRaDZOEs5yBlkiDE=;
        b=oLd02DfdzIPS0HnZSiR05spaPx2tUjpEC0AuhOa+AT4bBPExDr2FrNRW1UCyNgpJS8
         3JuUS55aReqUICBDG7zaGKYK03u3gFGtjqROQHkcgUkalEE8Yerw4omtDEyG6Q7vMTsk
         o4nlprjkrcwQKAyNYlb1Gc/gCeZFJr5JJBKDxkTRNRwF/cyyAqoE5J8TNMb6t9LsGn+K
         J42jeSlNRDm5Vz4yU8Px1jInlhRfWSDBKrt6LB5CzTBCV1P+ADZDLSPbuEM54WVme9K/
         YCtLXpYVZjRKgegGOw6XYog2A3xAx3veQT1+Hq/4RwAqLo3sN+Apq14s0wTDuTAafruo
         F2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722031134; x=1722635934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pp3k1dVESRj5IkAa6qsSz0zUBIRiRaDZOEs5yBlkiDE=;
        b=BOzwmT4Jg+BUslC2E2FymWz+ddTHN66Xg3vgTS/KqZwKuoa/gPKL4udt9pCCgLU+Ca
         Lwhd0SxzvCcL13meZoIFjQG7LP7/Y0WSCI6I2p2nN8SQEefF8xBFV8HQ+INbJObWGENa
         kuqw1TkMcdHXEhD4s/SDuTYRaJJyleFEGoMWlpPiXaykkYFpdO4FOlkb6xEtLegGNgKq
         FA5mNn3Ph/0hwD23yzLrWfE1+9K7XmQ6zkEbhIarHxOA5u3pxGiOdFHJnbAvrXDn+XjT
         /a7Z6YhF1XbUxouIPdaMJAi3BBf3nRkNvXozPndVLQtOmpDIDpWTDtoSBvujk620eKVS
         2M0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXsMo5/KSWEep04rHPVHCqCWcfooFGAT7OoS63X09ynMkQwE9KR8xYrjFwBiRlJeSFWwhOF0yFsAudpz9WceP8ODAiLKrVGZNEpQLXu
X-Gm-Message-State: AOJu0YwUUuiv7ZjLtEIHMXZD+qeWhLGBP//J2QQeiCsVg/kdR4q3W+QH
	fD74ROgdxARueDiBGaIBR+K0ZS4RHoo54dps+Uf6DifA6UguR4cAJ1e4HfEGBB8jlYwPQ0seL1U
	L0Kr+p8EevYicgDFXDjmLGhvcC1gKLX+Wux98
X-Google-Smtp-Source: AGHT+IHz5QpIp6TMciYkBGiVQczmr5Tlx0E7+PlPYlhcQhE4/+pH1fV+opum5zMho68v71OzHQprexRHcvpqS4M776M=
X-Received: by 2002:ac2:5b89:0:b0:52c:db0a:a550 with SMTP id
 2adb3069b0e04-5309b2bcbe0mr604059e87.42.1722031133005; Fri, 26 Jul 2024
 14:58:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725232813.2260665-1-nphamcs@gmail.com> <20240725232813.2260665-2-nphamcs@gmail.com>
In-Reply-To: <20240725232813.2260665-2-nphamcs@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 26 Jul 2024 14:58:14 -0700
Message-ID: <CAJD7tkY4Jt_OXDEsUN9jzQkrF4mEeLA0BxyNKppSK8k9xL-xKw@mail.gmail.com>
Subject: Re: [PATCH 1/2] zswap: implement a second chance algorithm for
 dynamic zswap shrinker
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, shakeelb@google.com, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	flintglass@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 4:28=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> Current zswap shrinker's heursitics to prevent overshrinking is brittle
> and inaccurate, specifically in the way we decay the protection size
> (i.e making pages in the zswap LRU eligible for reclaim).

Thanks for working on this and experimenting with different
heuristics. I was not a huge fan of these, so I am glad we are trying
to replace them with something more intuitive.

>
> We currently decay protection aggressively in zswap_lru_add() calls.
> This leads to the following unfortunate effect: when a new batch of
> pages enter zswap, the protection size rapidly decays to below 25% of
> the zswap LRU size, which is way too low.
>
> We have observed this effect in production, when experimenting with the
> zswap shrinker: the rate of shrinking shoots up massively right after a
> new batch of zswap stores. This is somewhat the opposite of what we want
> originally - when new pages enter zswap, we want to protect both these
> new pages AND the pages that are already protected in the zswap LRU.
>
> Replace existing heuristics with a second chance algorithm
>
> 1. When a new zswap entry is stored in the zswap pool, its reference bit
>    is set.
> 2. When the zswap shrinker encounters a zswap entry with the reference
>    bit set, give it a second chance - only flips the reference bit and
>    rotate it in the LRU.
> 3. If the shrinker encounters the entry again, this time with its
>    reference bit unset, then it can reclaim the entry.

At the first look, this is similar to the reclaim algorithm. A
fundamental difference here is that the reference bit is only set
once, when the entry is created. It is different from the conventional
second chance page reclaim/replacement algorithm.

What this really does, is that it slows down writeback by enforcing
that we need to iterate entries exactly twice before we write them
back. This sounds a little arbitrary and not very intuitive to me.

Taking a step back, what we really want is to writeback zswap entries
in order, and avoid writing back more entries than needed. I think the
key here is "when needed", which is defined by how much memory
pressure we have. The shrinker framework should already be taking this
into account.

Looking at do_shrink_slab(), in the case of zswap (seek =3D 2),
total_scan should boil down to:

total_scan =3D (zswap_shrinker_count() * 2 + nr_deferred) >> priority

, and this is bounded by zswap_shrinker_count() * 2.

Ignoring nr_deferred, we start by scanning 1/2048th of
zswap_shrinker_count() at DEF_PRIORITY, then we work our way to 2 *
zswap_shrinker_count() at zero priority (before OOMs). At
NODE_RECLAIM_PRIORITY, we start at 1/8th of zswap_shrinker_count().

Keep in mind that zswap_shrinker_count() does not return the number of
all zswap entries, it subtracts the protected part (or recent swapins)
and scales by the compression ratio. So this looks reasonable at first
sight, perhaps we want to tune the seek to slow down writeback if we
think it's too much, but that doesn't explain the scenario you are
describing.

Now let's factor in nr_deferred, which looks to me like it could be
the culprit here. I am assuming the intention is that if we counted
freeable slab objects before but didn't get to free them, we should do
it the next time around. This feels like it assumes that the objects
will remain there unless reclaimed by the shrinker. This does not
apply for zswap, because the objects can be swapped in.

Also, in the beginning, before we encounter too many swapins, the
protection will be very low, so zswap_shrinker_count() will return a
relatively high value. Even if we don't scan and writeback this
amount, we will keep carrying this value forward in next reclaim
operations, even if the number of existing zswap entries have
decreased due to swapins.

Could this be the problem? The number of deferred objects to be
scanned just keeps going forward as a high value, essentially
rendering the heuristics in zswap_shrinker_count() useless?

If we just need to slow down writeback by making sure we scan entries
twice, could something similar be achieved just by tuning the seek
without needing any heuristics to begin with?

I am just trying to understand if the main problem is that zswap does
not fit well into the shrinker framework as it is, and how we can
improve this.

Just to be clear, I am in favor of changing those heuristics to
something more intuitive and simpler, but I really want to understand
what is going on. The approach taken by this patch is definitely
simpler, but it doesn't feel more intuitive to me (at least not yet).

>
> In this manner, the aging of the pages in the zswap LRUs are decoupled
> from zswap stores, and picks up the pace with increasing memory pressure
> (which is what we want).
>
> We will still maintain the count of swapins, which is consumed and
> subtracted from the lru size in zswap_shrinker_count(), to further
> penalize past overshrinking that led to disk swapins. The idea is that
> had we considered this many more pages in the LRU active/protected, they
> would not have been written back and we would not have had to swapped
> them in.
>
> To test this new heuristics, I built the kernel under a cgroup with
> memory.max set to 2G, on a host with 36 cores:
>
> With the old shrinker:
>
> real: 263.89s
> user: 4318.11s
> sys: 673.29s
> swapins: 227300.5
>
> With the second chance algorithm:
>
> real: 244.85s
> user: 4327.22s
> sys: 664.39s
> swapins: 94663
>
> (average over 5 runs)
>
> We observe an 1.3% reduction in kernel CPU usage, and around 7.2%
> reduction in real time. Note that the number of swapped in pages
> dropped by 58%.
>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  include/linux/zswap.h | 16 ++++-----
>  mm/zswap.c            | 84 +++++++++++++++++++------------------------
>  2 files changed, 44 insertions(+), 56 deletions(-)
>
> diff --git a/include/linux/zswap.h b/include/linux/zswap.h
> index 6cecb4a4f68b..b94b6ae262d5 100644
> --- a/include/linux/zswap.h
> +++ b/include/linux/zswap.h
> @@ -13,17 +13,15 @@ extern atomic_t zswap_stored_pages;
>
>  struct zswap_lruvec_state {
>         /*
> -        * Number of pages in zswap that should be protected from the shr=
inker.
> -        * This number is an estimate of the following counts:
> +        * Number of swapped in pages, i.e not found in the zswap pool.
>          *
> -        * a) Recent page faults.
> -        * b) Recent insertion to the zswap LRU. This includes new zswap =
stores,
> -        *    as well as recent zswap LRU rotations.
> -        *
> -        * These pages are likely to be warm, and might incur IO if the a=
re written
> -        * to swap.
> +        * This is consumed and subtracted from the lru size in
> +        * zswap_shrinker_count() to penalize past overshrinking that led=
 to disk
> +        * swapins. The idea is that had we considered this many more pag=
es in the
> +        * LRU active/protected and not written them back, we would not h=
ave had to
> +        * swapped them in.
>          */
> -       atomic_long_t nr_zswap_protected;
> +       atomic_long_t nr_swapins;
>  };
>
>  unsigned long zswap_total_pages(void);
> diff --git a/mm/zswap.c b/mm/zswap.c
> index adeaf9c97fde..a24ee015d7bc 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -203,6 +203,7 @@ struct zswap_entry {
>         };
>         struct obj_cgroup *objcg;
>         struct list_head lru;
> +       bool referenced;

If we take this approach, this needs to be placed in the hole after
the length, to avoid increasing the size of the zswap_entry.

>  };
>
>  static struct xarray *zswap_trees[MAX_SWAPFILES];
> @@ -700,11 +701,10 @@ static inline int entry_to_nid(struct zswap_entry *=
entry)
>
>  static void zswap_lru_add(struct list_lru *list_lru, struct zswap_entry =
*entry)
>  {
> -       atomic_long_t *nr_zswap_protected;
> -       unsigned long lru_size, old, new;
>         int nid =3D entry_to_nid(entry);
>         struct mem_cgroup *memcg;
> -       struct lruvec *lruvec;
> +
> +       entry->referenced =3D true;
>
>         /*
>          * Note that it is safe to use rcu_read_lock() here, even in the =
face of
> @@ -722,19 +722,6 @@ static void zswap_lru_add(struct list_lru *list_lru,=
 struct zswap_entry *entry)
>         memcg =3D mem_cgroup_from_entry(entry);
>         /* will always succeed */
>         list_lru_add(list_lru, &entry->lru, nid, memcg);
> -
> -       /* Update the protection area */
> -       lru_size =3D list_lru_count_one(list_lru, nid, memcg);
> -       lruvec =3D mem_cgroup_lruvec(memcg, NODE_DATA(nid));
> -       nr_zswap_protected =3D &lruvec->zswap_lruvec_state.nr_zswap_prote=
cted;
> -       old =3D atomic_long_inc_return(nr_zswap_protected);
> -       /*
> -        * Decay to avoid overflow and adapt to changing workloads.
> -        * This is based on LRU reclaim cost decaying heuristics.
> -        */
> -       do {
> -               new =3D old > lru_size / 4 ? old / 2 : old;
> -       } while (!atomic_long_try_cmpxchg(nr_zswap_protected, &old, new))=
;
>         rcu_read_unlock();
>  }
>
> @@ -752,7 +739,7 @@ static void zswap_lru_del(struct list_lru *list_lru, =
struct zswap_entry *entry)
>
>  void zswap_lruvec_state_init(struct lruvec *lruvec)
>  {
> -       atomic_long_set(&lruvec->zswap_lruvec_state.nr_zswap_protected, 0=
);
> +       atomic_long_set(&lruvec->zswap_lruvec_state.nr_swapins, 0);
>  }
>
>  void zswap_folio_swapin(struct folio *folio)
> @@ -761,7 +748,7 @@ void zswap_folio_swapin(struct folio *folio)
>
>         if (folio) {
>                 lruvec =3D folio_lruvec(folio);
> -               atomic_long_inc(&lruvec->zswap_lruvec_state.nr_zswap_prot=
ected);
> +               atomic_long_inc(&lruvec->zswap_lruvec_state.nr_swapins);
>         }
>  }
>
> @@ -1091,6 +1078,16 @@ static enum lru_status shrink_memcg_cb(struct list=
_head *item, struct list_lru_o
>         enum lru_status ret =3D LRU_REMOVED_RETRY;
>         int writeback_result;
>
> +       /*
> +        * Second chance algorithm: if the entry has its reference bit se=
t, give it
> +        * a second chance. Only clear the reference bit and rotate it in=
 the
> +        * zswap's LRU list.
> +        */
> +       if (entry->referenced) {
> +               entry->referenced =3D false;
> +               return LRU_ROTATE;
> +       }
> +
>         /*
>          * As soon as we drop the LRU lock, the entry can be freed by
>          * a concurrent invalidation. This means the following:
> @@ -1157,8 +1154,7 @@ static enum lru_status shrink_memcg_cb(struct list_=
head *item, struct list_lru_o
>  static unsigned long zswap_shrinker_scan(struct shrinker *shrinker,
>                 struct shrink_control *sc)
>  {
> -       struct lruvec *lruvec =3D mem_cgroup_lruvec(sc->memcg, NODE_DATA(=
sc->nid));
> -       unsigned long shrink_ret, nr_protected, lru_size;
> +       unsigned long shrink_ret;
>         bool encountered_page_in_swapcache =3D false;
>
>         if (!zswap_shrinker_enabled ||
> @@ -1167,25 +1163,6 @@ static unsigned long zswap_shrinker_scan(struct sh=
rinker *shrinker,
>                 return SHRINK_STOP;
>         }
>
> -       nr_protected =3D
> -               atomic_long_read(&lruvec->zswap_lruvec_state.nr_zswap_pro=
tected);
> -       lru_size =3D list_lru_shrink_count(&zswap_list_lru, sc);
> -
> -       /*
> -        * Abort if we are shrinking into the protected region.
> -        *
> -        * This short-circuiting is necessary because if we have too many=
 multiple
> -        * concurrent reclaimers getting the freeable zswap object counts=
 at the
> -        * same time (before any of them made reasonable progress), the t=
otal
> -        * number of reclaimed objects might be more than the number of u=
nprotected
> -        * objects (i.e the reclaimers will reclaim into the protected ar=
ea of the
> -        * zswap LRU).
> -        */
> -       if (nr_protected >=3D lru_size - sc->nr_to_scan) {
> -               sc->nr_scanned =3D 0;
> -               return SHRINK_STOP;
> -       }
> -
>         shrink_ret =3D list_lru_shrink_walk(&zswap_list_lru, sc, &shrink_=
memcg_cb,
>                 &encountered_page_in_swapcache);
>
> @@ -1200,7 +1177,8 @@ static unsigned long zswap_shrinker_count(struct sh=
rinker *shrinker,
>  {
>         struct mem_cgroup *memcg =3D sc->memcg;
>         struct lruvec *lruvec =3D mem_cgroup_lruvec(memcg, NODE_DATA(sc->=
nid));
> -       unsigned long nr_backing, nr_stored, nr_freeable, nr_protected;
> +       atomic_long_t *nr_swapins =3D &lruvec->zswap_lruvec_state.nr_swap=
ins;
> +       unsigned long nr_backing, nr_stored, lru_size, nr_swapins_cur, nr=
_remain;
>
>         if (!zswap_shrinker_enabled || !mem_cgroup_zswap_writeback_enable=
d(memcg))
>                 return 0;
> @@ -1233,14 +1211,26 @@ static unsigned long zswap_shrinker_count(struct =
shrinker *shrinker,
>         if (!nr_stored)
>                 return 0;
>
> -       nr_protected =3D
> -               atomic_long_read(&lruvec->zswap_lruvec_state.nr_zswap_pro=
tected);
> -       nr_freeable =3D list_lru_shrink_count(&zswap_list_lru, sc);
> +       lru_size =3D list_lru_shrink_count(&zswap_list_lru, sc);
> +       if (!lru_size)
> +               return 0;
> +
>         /*
> -        * Subtract the lru size by an estimate of the number of pages
> -        * that should be protected.
> +        * Subtract the lru size by the number of pages that are recently=
 swapped
> +        * in. The idea is that had we protect the zswap's LRU by this am=
ount of
> +        * pages, these swap in would not have happened.
>          */
> -       nr_freeable =3D nr_freeable > nr_protected ? nr_freeable - nr_pro=
tected : 0;
> +       nr_swapins_cur =3D atomic_long_read(nr_swapins);
> +       do {
> +               if (lru_size >=3D nr_swapins_cur)
> +                       nr_remain =3D 0;
> +               else
> +                       nr_remain =3D nr_swapins_cur - lru_size;
> +       } while (!atomic_long_try_cmpxchg(nr_swapins, &nr_swapins_cur, nr=
_remain));
> +
> +       lru_size -=3D nr_swapins_cur - nr_remain;
> +       if (!lru_size)
> +               return 0;
>
>         /*
>          * Scale the number of freeable pages by the memory saving factor=
.
> @@ -1253,7 +1243,7 @@ static unsigned long zswap_shrinker_count(struct sh=
rinker *shrinker,
>          * space. Hence, we may scale nr_freeable down a little bit more =
than we
>          * should if we have a lot of same-filled pages.
>          */
> -       return mult_frac(nr_freeable, nr_backing, nr_stored);
> +       return mult_frac(lru_size, nr_backing, nr_stored);
>  }
>
>  static struct shrinker *zswap_alloc_shrinker(void)
> --
> 2.43.0
>

