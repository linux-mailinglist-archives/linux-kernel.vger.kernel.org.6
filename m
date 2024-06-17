Return-Path: <linux-kernel+bounces-218282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE18690BC15
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 22:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A45F61C221C1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D392D1991A4;
	Mon, 17 Jun 2024 20:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NDgkWcse"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC3519005E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718655631; cv=none; b=aNb0tqV/T3i8Y2bBAg9rgh5fBBt4YzqbJjCmdleQ6vgwOMYhhWbrFfE7xHvA7DgxBhFpb51DwAM4HW+zZaTm8kJXzbxb+huAqNMugcCIPYkjqTDf+NPYKXTrZ+K3hCjhtPpcOjheTBLGxtBYzaf5ItPjivLM/zmTCqlSVDonwoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718655631; c=relaxed/simple;
	bh=xRa2sS+GcdtYARb1BQr0g1CYaBoAOo2qgXVvgg7AkQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ds751oVgdrURFpSuN047CX3LKJ9zphuEOeDZrAO0g0zOrMlZM5TCkjcsRJmKy1SsGJJkneysB3yihRA1UfVFCm66ZYG/gMUAW/dml6ZTawVbcdyPFYlmAI39yW5lCNfbCpWCowwlarlCAYsp8EzeOWmxYphep2cNh9RVFoMi+Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NDgkWcse; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-423b89f9042so1745e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718655628; x=1719260428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/FZe9TIyimHOzUVMZW48V12HZv1QTlyVGMGhXcnOZw=;
        b=NDgkWcseVHFvzteszAh980c3AWvq/M0/u0Bt0NQcTReMgUSOkgtitYjDhRUsyrLCDz
         gmwDzGcobTr06v4Hnh+UKxpJXnF+zKRFe2lHrKfCZNLthD+5vB66HDcF77jMYZv5+Zog
         nDueHGjOsT16Yt3wLCY9+VlkYxldev+7Bqo65ZARDWq1Y34qYR3x9AkaO/D8BbKU5yNy
         pGI7Ya+xI5KCPgWa9WI6Q+FXee9t0D4ica5XLEnwTgPpqnwzkBLibWSWnLXz4P5iuQ2K
         Oun1GW3RHpP3C1IUojugecIkC7AjHSVCL8e3viTBWW0540j6Nv5q+H/VfvgOy+f1VjFF
         eR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718655628; x=1719260428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/FZe9TIyimHOzUVMZW48V12HZv1QTlyVGMGhXcnOZw=;
        b=QUOEXlsc5fl96oLfvbdS07O+8CPBdWCmfmF+cL5cpNB0RDJXdLBg3aS2rVsDjMGAsB
         g8VSiUBioEd21rLNs7pvRF5SGutjv/FvaZ5Du4D3muSEZI+jJgl9N7sv8Xpu7qqP09gd
         VGPNfbEkSnJSxE9VBminUPZYM2obqI3tIl0mPMUZsEEkKVTu1xW0YR7k70VwnuAQ8OFO
         UE8mSR7tH9H/oNY1i6ifm/LVsOITnyVTgR2Df9s4yCnopTR/QiPRt126Ba3UNrKXrIaA
         mI6abo6pZhMAjIqCb6dNaRMMNzsgiBP8nowVh+5Y1cCbBPTTSeuxOrz36bhYld8D3Zr4
         04qQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwHmYgOIaZmeCqXi8It2/xiAdXJ4Q1km/XavixgCxM6wbsFe57n2Tl5Hr8E7ZnBq3I1VAQHavSspvaxhOIkj9YR8o7OuUle0cnd2RE
X-Gm-Message-State: AOJu0Yw9C135kV3CoWud7I4EFoVQ/FKW/RX7P9TIyewxqyr8Sn+qCI+x
	EdqVw/1zZBu2f9jUJVCq1nzL4+CakBPuboV8cB7oVvAV36eXLTIw7NT4gK1NUZ2kKvRzMTv5jeU
	lvtlYkF8hpvE5ojleclHUeoXfFPmjwQ9Rll1D
X-Google-Smtp-Source: AGHT+IF3ut/Agm/Wd5Tdx7OAa5Ke3pxf/V/Wj5lHPSUKc7FCh5rILMpMZj6Fk0u1j4EwlaHbLqMJVJ20A+aHULLxtDQ=
X-Received: by 2002:a05:600c:4e11:b0:421:7195:43e with SMTP id
 5b1f17b1804b1-4246fcab961mr455075e9.0.1718655627881; Mon, 17 Jun 2024
 13:20:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-zsmalloc-lock-mm-everything-v1-0-5e5081ea11b3@linux.dev>
 <20240617-zsmalloc-lock-mm-everything-v1-2-5e5081ea11b3@linux.dev> <CAOUHufaCYqwZLwCzHbC40KDjSWKYFoVKiPfRxvxr+2Z8JRRXaA@mail.gmail.com>
In-Reply-To: <CAOUHufaCYqwZLwCzHbC40KDjSWKYFoVKiPfRxvxr+2Z8JRRXaA@mail.gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Mon, 17 Jun 2024 14:19:51 -0600
Message-ID: <CAOUHufYijvmo+-jRJWCeDEhvyf4z6EBMA=2ZOW2OBxnC2Y2qLg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/zswap: use only one pool in zswap
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	Takero Funaki <flintglass@gmail.com>, Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 2:16=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
>
> On Mon, Jun 17, 2024 at 6:58=E2=80=AFAM Chengming Zhou <chengming.zhou@li=
nux.dev> wrote:
> >
> > Zswap uses 32 pools to workaround the locking scalability problem in
> > zsmalloc,
>
> Note that zpool can have other backends (zbud, z3fold), and the
> original patch was developed (even before zswap could use zsmalloc) to
> make sure it works for all the backend.
>
> This patch only makes sense now only because zsmalloc became a lot
> more popular than other backends (even though some distros still
> default to zbud).

And this might also have answered Yosry's question about the
"historical context" here [1].

[1] https://lore.kernel.org/CAJD7tkbO+ZLdhs-9BpthztZX32i8C4=3DQEnoiXGS7bM39=
9nqwzg@mail.gmail.com/



> > which brings its own problems like memory waste and more
> > memory fragmentation.
> >
> > Testing results show that we can have near performance with only one
> > pool in zswap after changing zsmalloc to use per-size_class lock instea=
d
> > of pool spinlock.
> >
> > Testing kernel build (make bzImage -j32) on tmpfs with memory.max=3D1GB=
,
> > and zswap shrinker enabled with 10GB swapfile on ext4.
> >
> >                                 real    user    sys
> > 6.10.0-rc3                      138.18  1241.38 1452.73
> > 6.10.0-rc3-onepool              149.45  1240.45 1844.69
> > 6.10.0-rc3-onepool-perclass     138.23  1242.37 1469.71
> >
> > Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
> > ---
> >  mm/zswap.c | 60 +++++++++++++++++++-----------------------------------=
------
> >  1 file changed, 19 insertions(+), 41 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index e25a6808c2ed..5063c5372e51 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -122,9 +122,6 @@ static unsigned int zswap_accept_thr_percent =3D 90=
; /* of max pool size */
> >  module_param_named(accept_threshold_percent, zswap_accept_thr_percent,
> >                    uint, 0644);
> >
> > -/* Number of zpools in zswap_pool (empirically determined for scalabil=
ity) */
> > -#define ZSWAP_NR_ZPOOLS 32
> > -
> >  /* Enable/disable memory pressure-based shrinker. */
> >  static bool zswap_shrinker_enabled =3D IS_ENABLED(
> >                 CONFIG_ZSWAP_SHRINKER_DEFAULT_ON);
> > @@ -160,7 +157,7 @@ struct crypto_acomp_ctx {
> >   * needs to be verified that it's still valid in the tree.
> >   */
> >  struct zswap_pool {
> > -       struct zpool *zpools[ZSWAP_NR_ZPOOLS];
> > +       struct zpool *zpool;
> >         struct crypto_acomp_ctx __percpu *acomp_ctx;
> >         struct percpu_ref ref;
> >         struct list_head list;
> > @@ -237,7 +234,7 @@ static inline struct xarray *swap_zswap_tree(swp_en=
try_t swp)
> >
> >  #define zswap_pool_debug(msg, p)                               \
> >         pr_debug("%s pool %s/%s\n", msg, (p)->tfm_name,         \
> > -                zpool_get_type((p)->zpools[0]))
> > +                zpool_get_type((p)->zpool))
> >
> >  /*********************************
> >  * pool functions
> > @@ -246,7 +243,6 @@ static void __zswap_pool_empty(struct percpu_ref *r=
ef);
> >
> >  static struct zswap_pool *zswap_pool_create(char *type, char *compress=
or)
> >  {
> > -       int i;
> >         struct zswap_pool *pool;
> >         char name[38]; /* 'zswap' + 32 char (max) num + \0 */
> >         gfp_t gfp =3D __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLA=
IM;
> > @@ -267,18 +263,14 @@ static struct zswap_pool *zswap_pool_create(char =
*type, char *compressor)
> >         if (!pool)
> >                 return NULL;
> >
> > -       for (i =3D 0; i < ZSWAP_NR_ZPOOLS; i++) {
> > -               /* unique name for each pool specifically required by z=
smalloc */
> > -               snprintf(name, 38, "zswap%x",
> > -                        atomic_inc_return(&zswap_pools_count));
> > -
> > -               pool->zpools[i] =3D zpool_create_pool(type, name, gfp);
> > -               if (!pool->zpools[i]) {
> > -                       pr_err("%s zpool not available\n", type);
> > -                       goto error;
> > -               }
> > +       /* unique name for each pool specifically required by zsmalloc =
*/
> > +       snprintf(name, 38, "zswap%x", atomic_inc_return(&zswap_pools_co=
unt));
> > +       pool->zpool =3D zpool_create_pool(type, name, gfp);
> > +       if (!pool->zpool) {
> > +               pr_err("%s zpool not available\n", type);
> > +               goto error;
> >         }
> > -       pr_debug("using %s zpool\n", zpool_get_type(pool->zpools[0]));
> > +       pr_debug("using %s zpool\n", zpool_get_type(pool->zpool));
> >
> >         strscpy(pool->tfm_name, compressor, sizeof(pool->tfm_name));
> >
> > @@ -311,8 +303,7 @@ static struct zswap_pool *zswap_pool_create(char *t=
ype, char *compressor)
> >  error:
> >         if (pool->acomp_ctx)
> >                 free_percpu(pool->acomp_ctx);
> > -       while (i--)
> > -               zpool_destroy_pool(pool->zpools[i]);
> > +       zpool_destroy_pool(pool->zpool);
> >         kfree(pool);
> >         return NULL;
> >  }
> > @@ -361,15 +352,12 @@ static struct zswap_pool *__zswap_pool_create_fal=
lback(void)
> >
> >  static void zswap_pool_destroy(struct zswap_pool *pool)
> >  {
> > -       int i;
> > -
> >         zswap_pool_debug("destroying", pool);
> >
> >         cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &pool->=
node);
> >         free_percpu(pool->acomp_ctx);
> >
> > -       for (i =3D 0; i < ZSWAP_NR_ZPOOLS; i++)
> > -               zpool_destroy_pool(pool->zpools[i]);
> > +       zpool_destroy_pool(pool->zpool);
> >         kfree(pool);
> >  }
> >
> > @@ -464,8 +452,7 @@ static struct zswap_pool *zswap_pool_find_get(char =
*type, char *compressor)
> >         list_for_each_entry_rcu(pool, &zswap_pools, list) {
> >                 if (strcmp(pool->tfm_name, compressor))
> >                         continue;
> > -               /* all zpools share the same type */
> > -               if (strcmp(zpool_get_type(pool->zpools[0]), type))
> > +               if (strcmp(zpool_get_type(pool->zpool), type))
> >                         continue;
> >                 /* if we can't get it, it's about to be destroyed */
> >                 if (!zswap_pool_get(pool))
> > @@ -492,12 +479,8 @@ unsigned long zswap_total_pages(void)
> >         unsigned long total =3D 0;
> >
> >         rcu_read_lock();
> > -       list_for_each_entry_rcu(pool, &zswap_pools, list) {
> > -               int i;
> > -
> > -               for (i =3D 0; i < ZSWAP_NR_ZPOOLS; i++)
> > -                       total +=3D zpool_get_total_pages(pool->zpools[i=
]);
> > -       }
> > +       list_for_each_entry_rcu(pool, &zswap_pools, list)
> > +               total +=3D zpool_get_total_pages(pool->zpool);
> >         rcu_read_unlock();
> >
> >         return total;
> > @@ -802,11 +785,6 @@ static void zswap_entry_cache_free(struct zswap_en=
try *entry)
> >         kmem_cache_free(zswap_entry_cache, entry);
> >  }
> >
> > -static struct zpool *zswap_find_zpool(struct zswap_entry *entry)
> > -{
> > -       return entry->pool->zpools[hash_ptr(entry, ilog2(ZSWAP_NR_ZPOOL=
S))];
> > -}
> > -
> >  /*
> >   * Carries out the common pattern of freeing and entry's zpool allocat=
ion,
> >   * freeing the entry itself, and decrementing the number of stored pag=
es.
> > @@ -814,7 +792,7 @@ static struct zpool *zswap_find_zpool(struct zswap_=
entry *entry)
> >  static void zswap_entry_free(struct zswap_entry *entry)
> >  {
> >         zswap_lru_del(&zswap_list_lru, entry);
> > -       zpool_free(zswap_find_zpool(entry), entry->handle);
> > +       zpool_free(entry->pool->zpool, entry->handle);
> >         zswap_pool_put(entry->pool);
> >         if (entry->objcg) {
> >                 obj_cgroup_uncharge_zswap(entry->objcg, entry->length);
> > @@ -939,7 +917,7 @@ static bool zswap_compress(struct folio *folio, str=
uct zswap_entry *entry)
> >         if (comp_ret)
> >                 goto unlock;
> >
> > -       zpool =3D zswap_find_zpool(entry);
> > +       zpool =3D entry->pool->zpool;
> >         gfp =3D __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
> >         if (zpool_malloc_support_movable(zpool))
> >                 gfp |=3D __GFP_HIGHMEM | __GFP_MOVABLE;
> > @@ -968,7 +946,7 @@ static bool zswap_compress(struct folio *folio, str=
uct zswap_entry *entry)
> >
> >  static void zswap_decompress(struct zswap_entry *entry, struct folio *=
folio)
> >  {
> > -       struct zpool *zpool =3D zswap_find_zpool(entry);
> > +       struct zpool *zpool =3D entry->pool->zpool;
> >         struct scatterlist input, output;
> >         struct crypto_acomp_ctx *acomp_ctx;
> >         u8 *src;
> > @@ -1467,7 +1445,7 @@ bool zswap_store(struct folio *folio)
> >         return true;
> >
> >  store_failed:
> > -       zpool_free(zswap_find_zpool(entry), entry->handle);
> > +       zpool_free(entry->pool->zpool, entry->handle);
> >  put_pool:
> >         zswap_pool_put(entry->pool);
> >  freepage:
> > @@ -1683,7 +1661,7 @@ static int zswap_setup(void)
> >         pool =3D __zswap_pool_create_fallback();
> >         if (pool) {
> >                 pr_info("loaded using pool %s/%s\n", pool->tfm_name,
> > -                       zpool_get_type(pool->zpools[0]));
> > +                       zpool_get_type(pool->zpool));
> >                 list_add(&pool->list, &zswap_pools);
> >                 zswap_has_pool =3D true;
> >                 static_branch_enable(&zswap_ever_enabled);
> >
> > --
> > 2.45.2
> >
> >

