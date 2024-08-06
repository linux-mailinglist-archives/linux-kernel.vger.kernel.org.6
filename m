Return-Path: <linux-kernel+bounces-275500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7824F94868F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F687283AEA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 00:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9C310F1;
	Tue,  6 Aug 2024 00:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j14bludw"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D65A35
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 00:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722903238; cv=none; b=dSPI32uE+S/9hZJBXJXSQ16khI3TgDVGvnN5qGYzagbbGv36O4fgkpMB3InCPfDDzXMrzKI66cLOO3ka8TKoRvtOvDSewiqv+FW7xcukECCpdG2ipL+EjivbKb4NIVDU48rcuV1bp20WYBRj2EtoMBrFar/Z6BRTiEeSWjpiTQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722903238; c=relaxed/simple;
	bh=ZDxCORataawjKOGxtlarKZDhv+rXkx4UHqog+8LGujQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B8qE+L8o7FJlX/Hi0066ntUXx2h5Sp+R10vv8qcxrouWD8Kd4uRZrBMbESZeRB8yUkV6ma1oi6QBfL7+loprjFonTZLTC+6fdgLiGLKlKttZTi/MgJoQkyb9vR4NFUVITEEb9oBZCecMKK2hR9EKzhzQUwU6NLe4EKYcwj9TdDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j14bludw; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7a81bd549eso8579566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 17:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722903235; x=1723508035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lz1Ae/7rlg/3/u2JXrEz+z/RAQ/eMDWE8SckjgKSpLY=;
        b=j14bludwKHIboLjegi8tkzZsSV1JvwnrHkj5SQyKY8M3RiBM4PnHhR07EOz+ztO7HK
         keSpK2jslJBed7SQIuUes6jDL+jl8IOg3aWT0H7o0b4t1pUmD5+2wUkSxLEnKmv5Yz1w
         0NovQL1tW71VOEarWXAxIQ1AgnsG3abQFO4CuKxrER5jhLQWnVL/8HZgJXXOYosZ955g
         jdXhtqbyuoFOuR8Cnr1UyxA5pz4w00kin7Kt+KTVMTf6gffqafoxM5QaMfXLeZQ5RQmc
         pmFJBPuujz+4PLxJTEKXIC887XvTCNtCWbAnjm1l0hyLcX4Gl6SIBg8upTTIdcuQv2Hr
         lQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722903235; x=1723508035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lz1Ae/7rlg/3/u2JXrEz+z/RAQ/eMDWE8SckjgKSpLY=;
        b=Jyp/l4ldXo5GA+TeMrhtGXu6bvz3tEi+L3qk7RXosQeEvQ8Bzdz3+buJ0hgMyGR7v4
         VTws58qGU6TOchK+1GD9oWQgGUucft/pBt5yJiX4tzOLo4L/60/bRqCUy9Krhg+YUjZF
         JMvcjaHopharK7kmd05h9EtG2+2b0VIvGZsxPiEdyyZftU0Kam9L9TWfwxCHQhwpKqUS
         WT5iwBDRzhCZWrqWmOP93yIrftGu3t8wauFMjmrbpK2yFcA/Zdfufq2VNs5reIb14cfr
         hTD5HnTDCtg8BF1FYT9PHqUritj3QfxXQk6ab1Xgt4p1mmMH3qjV9emoJQfDDWEfsYAS
         rEeg==
X-Forwarded-Encrypted: i=1; AJvYcCUy0u9bl3XTVnCcyFwOYUAKr2foPOOuKuGvg/9qR952P0387Rf5VD9Nag86KwOBX6c8aAtS+JCkV/7KY9uTJgysOdXRt5WaauitAgxL
X-Gm-Message-State: AOJu0YyOYx/TkwZ4dmYgNOAC5aSSi0dYEwB1IPCD4Im0nJyJAfbvo1gu
	mYxYnWJIciIBs7Mc2qaHw+7U7LFvOpBsdnd/9CUYqG0fFnNdYJji92rEqjqdN1vF0wn3jQ2iNhC
	200V2kv0ptL6dfZHcmeWGUXRJa7caYFjllZcT
X-Google-Smtp-Source: AGHT+IHc3zANL8ZaSgowmvp7aToDGXdFt777ft/8Sndpc2h+mU1jmNIEJ9xF4cwU9gBldTl1f9hRoWOI/y3KoRYdq/g=
X-Received: by 2002:a17:907:6d28:b0:a77:f2c5:84a9 with SMTP id
 a640c23a62f3a-a7dc4e56417mr954695566b.18.1722903234349; Mon, 05 Aug 2024
 17:13:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805232243.2896283-1-nphamcs@gmail.com> <20240805232243.2896283-2-nphamcs@gmail.com>
In-Reply-To: <20240805232243.2896283-2-nphamcs@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 5 Aug 2024 17:13:17 -0700
Message-ID: <CAJD7tkbnYi5WsQC+5QfrVgmqb34yzY9HtVZ4cZjw9eg+ikCXkQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] zswap: implement a second chance algorithm for
 dynamic zswap shrinker
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, shakeel.butt@linux.dev, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	flintglass@gmail.com, chengming.zhou@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 4:22=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
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
> 1. When a new zswap entry is stored in the zswap pool, its referenced
>    bit is set.
> 2. When the zswap shrinker encounters a zswap entry with the referenced
>    bit set, give it a second chance - only flips the referenced bit and
>    rotate it in the LRU.
> 3. If the shrinker encounters the entry again, this time with its
>    referenced bit unset, then it can reclaim the entry.
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
> The referenced bit is added at the hole after the `length` field of
> struct zswap_entry, so there is no extra space overhead for this
> algorithm.
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
>  include/linux/zswap.h |  16 +++----
>  mm/zswap.c            | 108 ++++++++++++++++++++++++------------------
>  2 files changed, 70 insertions(+), 54 deletions(-)
>
> diff --git a/include/linux/zswap.h b/include/linux/zswap.h
> index 6cecb4a4f68b..9cd1beef0654 100644
> --- a/include/linux/zswap.h
> +++ b/include/linux/zswap.h
> @@ -13,17 +13,15 @@ extern atomic_t zswap_stored_pages;
>
>  struct zswap_lruvec_state {
>         /*
> -        * Number of pages in zswap that should be protected from the shr=
inker.
> -        * This number is an estimate of the following counts:
> +        * Number of swapped in pages from disk, i.e not found in the zsw=
ap pool.
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
> +       atomic_long_t nr_disk_swapins;
>  };
>
>  unsigned long zswap_total_pages(void);
> diff --git a/mm/zswap.c b/mm/zswap.c
> index adeaf9c97fde..fb3d9cb88785 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -187,6 +187,10 @@ static struct shrinker *zswap_shrinker;
>   * length - the length in bytes of the compressed page data.  Needed dur=
ing
>   *          decompression. For a same value filled page length is 0, and=
 both
>   *          pool and lru are invalid and must be ignored.
> + * referenced - true if the entry recently entered the zswap pool. Unset=
 by the
> + *              dynamic shrinker. The entry is only reclaimed by the dyn=
amic
> + *              shrinker if referenced is unset. See comments in the shr=
inker
> + *              section for context.

Nit: It is unset and reclaimed by the writeback logic in general,
which isn't necessarily triggered from the dynamic shrinker, right?

>   * pool - the zswap_pool the entry's data is in
>   * handle - zpool allocation handle that stores the compressed page data
>   * value - value of the same-value filled pages which have same content
> @@ -196,6 +200,7 @@ static struct shrinker *zswap_shrinker;
>  struct zswap_entry {
>         swp_entry_t swpentry;
>         unsigned int length;
> +       bool referenced;
>         struct zswap_pool *pool;
>         union {
>                 unsigned long handle;
> @@ -700,11 +705,8 @@ static inline int entry_to_nid(struct zswap_entry *e=
ntry)
>
>  static void zswap_lru_add(struct list_lru *list_lru, struct zswap_entry =
*entry)
>  {
> -       atomic_long_t *nr_zswap_protected;
> -       unsigned long lru_size, old, new;
>         int nid =3D entry_to_nid(entry);
>         struct mem_cgroup *memcg;
> -       struct lruvec *lruvec;
>
>         /*
>          * Note that it is safe to use rcu_read_lock() here, even in the =
face of
> @@ -722,19 +724,6 @@ static void zswap_lru_add(struct list_lru *list_lru,=
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

Nice, arcane heuristics gone :)

LGTM with the above nit:
Acked-by: Yosry Ahmed <yosryahmed@google.com>

