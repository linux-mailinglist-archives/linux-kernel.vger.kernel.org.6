Return-Path: <linux-kernel+bounces-271823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7B2945398
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 21:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA7722859F3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2406C14A4FC;
	Thu,  1 Aug 2024 19:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yaGPmAJo"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39BF13C832
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 19:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722542268; cv=none; b=I2ET7RKNkhV57c44zJTeEApF/PkyuVMxjWlU/NdfAGzSXvFFE8svMD8eW3FggsMgeilm1M3bYqYWLiydgHTAcedzGM+Qcfe67m5wnvhiYYwfwEsB9e6TrUOCj0dCgoe8yVeml/35wmyiiUCa/ScCRLWD7fl8Do31ZjxbZSibeNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722542268; c=relaxed/simple;
	bh=JzAVouvAJhlJvi9uUBJ1FgLkJV01KFl+B1iVbhOkmNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hKxzK0VkTK7wB/RuZ0imJqIrCQXyuKXAta5Rvyux7blNqEJg1vc4HAYpYIwAUen1BpST5GPuCz4kQdZnwdfJmj89652gD/F82r5hs1qF3rqDoIdu36NT2ma7ZJbSreIrF8C6o1bnq5BRfQtDUeOEqhheAudCZDbUjTe/RBWhd9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yaGPmAJo; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7a9a7af0d0so966385066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 12:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722542265; x=1723147065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4k/RLMqcreuwYmwf4dIylz51CWYvgwkzrXIUeNAYpa8=;
        b=yaGPmAJoDVzOy8aOHlWhlfuE+/rSV3Iu4PAbvU6BNAIdJ3A7YC1QYN5fTyy/aGeTI6
         z+N2pdGOow7ADdDznbvNp5ur6FamV+yl/L1VDD+PVUqHMcrxfkgxG5ZT7GkPAJrxrJh6
         62C0MC+KdrQYKAA9BmMM5ImPM3ySTsVvnYDVxkdX6/nei7nNUha4gt5FaN5yAhf8aNvq
         ij0DCNwT39AizPdxR4r0TJ0pZK1ghIgeU0WVf+xM/caKQJPJnhkpopkQtpc8NCKnvsuF
         E7CIHKEfiNHmfkHCBbe2F2lUjASDaDgL6bh/PoJWWNcDTu8jPw8AdP42UkSHrrLOrIU1
         5Niw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722542265; x=1723147065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4k/RLMqcreuwYmwf4dIylz51CWYvgwkzrXIUeNAYpa8=;
        b=Se13F3D/1e/TX+xj9pMk9k0RNzuxj4E4oOEx2jHmaBBRkecki+AGzO9z8cuE+NKNoH
         n8rkePYJ8MjjwFYA7gsRV/Ll6WHlfZp8iO8S6kN+V6j9jrmXjsU0xz/8Fd4Ioav/djWn
         dby2zOS1NYcDdXKaVaHP36xBNazkrpBl4xJbkp6Yi/2PfkQXKrCHE6GeXLZ4NTyhfEyV
         s5PcAVWLngY3FKTWxP5F5pPYfGDZJ+2MG6/Sry8HIjVHfedmk5i/pgV3i/J83yEuEPmw
         RA5FQwchsQY9jonwHNKDNy8QeMZyZ32vwvPG2o2Az4asXxpYpV1xJFV+B1eJJClutoH6
         t2xA==
X-Forwarded-Encrypted: i=1; AJvYcCWHawyVJzrtcpD02w59tkf9C4fSwkow8NU/dsqXP1jZWBRrdLbU9lhcadLPEUZvEs9+hrjAnZyYUadQ3qBS4/eUraAX6UU4+K2+l0Rr
X-Gm-Message-State: AOJu0YzmNDuLGEHuhyg52plh0jCzCevykPsGdGZFB0g90RqKMF5WSJ0/
	ycA0nF9j1tWWF1Apb/AaWYVHE7NLXBwUk9UwL7P0Q9SDq1+cINtXA1hGPTYoyeggwwl4I/p1NSV
	tKFVukGDs+Z0EL2cEaMbB/osMSK2JbSrdmcjW
X-Google-Smtp-Source: AGHT+IGAgpm5GoFYD9qykmXxZI/A1vOOU09TWYvPR+KXmT9blExtTdAcAJFObnKqF7Z28bEoaVttiomcG1HoCl52oqQ=
X-Received: by 2002:a17:907:7f90:b0:a7a:bece:6223 with SMTP id
 a640c23a62f3a-a7dc4db8bfcmr115751966b.6.1722542264145; Thu, 01 Aug 2024
 12:57:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730222707.2324536-1-nphamcs@gmail.com> <20240730222707.2324536-2-nphamcs@gmail.com>
In-Reply-To: <20240730222707.2324536-2-nphamcs@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 1 Aug 2024 12:57:06 -0700
Message-ID: <CAJD7tkYujNCPzrXfmRqFYESeAnrzgJYys-R_=Ftx=rJkUuhBWw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] zswap: implement a second chance algorithm for
 dynamic zswap shrinker
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, shakeel.butt@linux.dev, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	flintglass@gmail.com, chengming.zhou@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 3:27=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> Current zswap shrinker's heuristics to prevent overshrinking is brittle
> and inaccurate, specifically in the way we decay the protection size
> (i.e making pages in the zswap LRU eligible for reclaim).
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

Probably worth mentioning that this is added in a hole and doesn't
consume any extra memory.

> 2. When the zswap shrinker encounters a zswap entry with the reference
>    bit set, give it a second chance - only flips the reference bit and
>    rotate it in the LRU.
> 3. If the shrinker encounters the entry again, this time with its
>    reference bit unset, then it can reclaim the entry.
>
> In this manner, the aging of the pages in the zswap LRUs are decoupled
> from zswap stores, and picks up the pace with increasing memory pressure
> (which is what we want).
>
> The second chance scheme allows us to modulate the writeback rate based
> on recent pool activities. Entries that recently entered the pool will
> be protected, so if the pool is dominated by such entries the writeback
> rate will reduce proportionally, protecting the workload's workingset.On
> the other hand, stale entries will be written back quickly, which
> increases the effective writeback rate.
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
>  include/linux/zswap.h |  16 +++---
>  mm/zswap.c            | 110 ++++++++++++++++++++++++------------------
>  2 files changed, 70 insertions(+), 56 deletions(-)
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

With the next patch, this should be "Number of swapped in pages from
disk". Without the "from disk", the second part about not being found
in the zswap pool doesn't really make sense.

Maybe also the variable name should be changed to nr_disk_swapins or simila=
r.

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
> index adeaf9c97fde..f4e001c9e7e0 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -184,6 +184,10 @@ static struct shrinker *zswap_shrinker;
>   * page within zswap.
>   *
>   * swpentry - associated swap entry, the offset indexes into the red-bla=
ck tree
> + * referenced - true if the entry recently entered the zswap pool. Unset=
 by the
> + *              dynamic shrinker. The entry is only reclaimed by the dyn=
amic
> + *              shrinker if referenced is unset. See comments in the shr=
inker
> + *              section for context.
>   * length - the length in bytes of the compressed page data.  Needed dur=
ing
>   *          decompression. For a same value filled page length is 0, and=
 both
>   *          pool and lru are invalid and must be ignored.
> @@ -196,6 +200,7 @@ static struct shrinker *zswap_shrinker;
>  struct zswap_entry {
>         swp_entry_t swpentry;
>         unsigned int length;
> +       bool referenced;
>         struct zswap_pool *pool;
>         union {
>                 unsigned long handle;
> @@ -700,11 +705,10 @@ static inline int entry_to_nid(struct zswap_entry *=
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

Would it be clearer to initialize this in zswap_store() with the rest
of the zswap_entry initialization?

>
>         /*
>          * Note that it is safe to use rcu_read_lock() here, even in the =
face of
> @@ -722,19 +726,6 @@ static void zswap_lru_add(struct list_lru *list_lru,=
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
> @@ -752,7 +743,7 @@ static void zswap_lru_del(struct list_lru *list_lru, =
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
> @@ -761,7 +752,7 @@ void zswap_folio_swapin(struct folio *folio)
>
>         if (folio) {
>                 lruvec =3D folio_lruvec(folio);
> -               atomic_long_inc(&lruvec->zswap_lruvec_state.nr_zswap_prot=
ected);
> +               atomic_long_inc(&lruvec->zswap_lruvec_state.nr_swapins);
>         }
>  }
>
> @@ -1082,6 +1073,28 @@ static int zswap_writeback_entry(struct zswap_entr=
y *entry,
>  /*********************************
>  * shrinker functions
>  **********************************/
> +/*
> + * The dynamic shrinker is modulated by the following factors:
> + *
> + * 1. Each zswap entry has a referenced bit, which the shrinker unsets (=
giving
> + *    the entry a second chance) before rotating it in the LRU list. If =
the
> + *    entry is considered again by the shrinker, with its referenced bit=
 unset,
> + *    it is written back. The writeback rate as a result is dynamically
> + *    adjusted by the pool activities - if the pool is dominated by new =
entries
> + *    (i.e lots of recent zswapouts), these entries will be protected an=
d
> + *    the writeback rate will slow down. On the other hand, if the pool =
has a
> + *    lot of stagnant entries, these entries will be reclaimed immediate=
ly,
> + *    effectively increasing the writeback rate.
> + *
> + * 2. Swapins counter: If we observe swapins, it is a sign that we are
> + *    overshrinking and should slow down. We maintain a swapins counter,=
 which
> + *    is consumed and subtract from the number of eligible objects on th=
e LRU
> + *    in zswap_shrinker_count().
> + *
> + * 3. Compression ratio. The better the workload compresses, the less ga=
ins we
> + *    can expect from writeback. We scale down the number of objects ava=
ilable
> + *    for reclaim by this ratio.
> + */

Nice :)

>  static enum lru_status shrink_memcg_cb(struct list_head *item, struct li=
st_lru_one *l,
>                                        spinlock_t *lock, void *arg)
>  {
> @@ -1091,6 +1104,16 @@ static enum lru_status shrink_memcg_cb(struct list=
_head *item, struct list_lru_o
>         enum lru_status ret =3D LRU_REMOVED_RETRY;
>         int writeback_result;
>
> +       /*
> +        * Second chance algorithm: if the entry has its referenced bit s=
et, give it
> +        * a second chance. Only clear the referenced bit and rotate it i=
n the
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
> @@ -1157,8 +1180,7 @@ static enum lru_status shrink_memcg_cb(struct list_=
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
> @@ -1167,25 +1189,6 @@ static unsigned long zswap_shrinker_scan(struct sh=
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

Do we need a similar mechanism to protect against concurrent shrinkers
quickly consuming nr_swapins?

>         shrink_ret =3D list_lru_shrink_walk(&zswap_list_lru, sc, &shrink_=
memcg_cb,
>                 &encountered_page_in_swapcache);
>
> @@ -1200,7 +1203,8 @@ static unsigned long zswap_shrinker_count(struct sh=
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
> @@ -1233,14 +1237,26 @@ static unsigned long zswap_shrinker_count(struct =
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

nit: I don't think "subtract by" is correct, it's usually "subtract
from". So maybe "Subtract the number of pages that are recently
swapped in from the lru size"? Also, should we remain consistent about
mentioning that these are disk swapins throughout all the comments to
keep things clear?

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

It's a little bit weird that we reduce the variable named "lru_size"
by the consumed swapins. Maybe we should keep this named as
"nr_freeable", or add another variable here to hold the value after
subtraction?

> +       if (!lru_size)
> +               return 0;
>
>         /*
>          * Scale the number of freeable pages by the memory saving factor=
.
> @@ -1253,7 +1269,7 @@ static unsigned long zswap_shrinker_count(struct sh=
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

