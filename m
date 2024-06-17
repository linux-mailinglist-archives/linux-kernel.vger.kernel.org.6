Return-Path: <linux-kernel+bounces-218261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB0D90BBD0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 22:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EBB7B226FC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3128A198A3E;
	Mon, 17 Jun 2024 20:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ifJb/T9j"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC34190047
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 20:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718655433; cv=none; b=s90Bh8/GZ6pwU22Eq1+56G56Y24LID38T2RPanSUU0jP87h3KeHyG12FjHrGLl0e7mjsshwTu1RLlNycBNz/BNYAAemlBP+zqpaHZk7PivPa8ZrrXphN35vpTMUTVYFlRnNRrnwWUrKOtlvjfvNhgqnOEzhaB2lq1M/d4UOBpB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718655433; c=relaxed/simple;
	bh=FJz27dD7acqLp3gz1eIkD9N2xK8CyvT80WlHG/ZmnBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XLPR14rCLBu/7Cobkh0PRaN5CyfOpDmJ9fhs8purMwaKnhcb3DvWqiw09kqE4X2zs0XtJaJBrKQZsfiZajLx5y3Toe4L9X9dkt0V5YNoBclPo+Yy85KGOEC8a4KZjhKDARnMvCJCYtHry99sEtm9JeEgaS/Jb661DkAyKuFGySw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ifJb/T9j; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-422f7c7af49so16815e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718655429; x=1719260229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Kc5lyoiHYXORyqMcF3B5Bhd2r+YHt/FZxvnbpja8XY=;
        b=ifJb/T9jFVTj8Xnc42bpwIqhywhirp/thAw1uAfN24Enmkj6r5aav72ZEX7QdRTuXg
         uIdPhXa45b9UWTU9N75tPJ6OZD/AY20IUcFnB1qCNUfjsTmr8h3jRJeQKm7C2UvKvdOf
         59fx3KEUEplF3tqzooBoJ04DQBdVHL/RB/5yTNein8BLUay4PhAmGC1Mpv1xtRVovGOI
         HpxJD5LtQnp+FJmtUAQg7lWqXKTWQwcb2mk3E8GzXK2hIzw9e30Di9SSr8m1tXTc4afb
         NWjhHePMtYbxrImxf2dvYBPM8hIyci7PffyyAvuC/N4dNvUGyJauqs6vKyU+ZKaLipW9
         uf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718655429; x=1719260229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Kc5lyoiHYXORyqMcF3B5Bhd2r+YHt/FZxvnbpja8XY=;
        b=HHDI3mvsZz0vd8jgw0YzNC+ayP5/6KafZbQIeELBz/otfDy/RmCjS0vjSIIVQPvGjn
         5cElg7oFn/Tr9VFccdISHTnX35W0v3MB0x8z6QMfwxObMJK220560Jk0IRXPATKT9KMF
         XnSNM/BnxhciJ4ayj/bfJK+/LDzvpEgT5fjHLhsaTYx4ByASm3/X5rVzhY6ETPu/7r/H
         k2rlOMj5KjKn84+Y0vLms39jeRz5GkK2xGPHQiHY8t1oUAR37n59K5l+kNT6S20R+A/t
         m31QwN+01bm8brnw9JJNnM3BMlcPhaS6LLVvBJvcaAOW/75fYUgwFNuOoaJwNWmBhDph
         cxBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfP+sNnXuhTMoe3VSsVNgiRh/Wn5eA5Qi0zwMKoQ1TBMLr+EaXSzp6/aMOubKhuq42DJUSNNHW81lpANLAVR/tH/oOj4NjzgG9I1Ue
X-Gm-Message-State: AOJu0Yxx0nw9tYyGSejubf499buPZfeIGvlzA1ZgNk0XS+zxPnJ6kaqa
	n//kSn8jhGQXvY/dtxOCqp55XoEUDyMsrgxbuNoVwn6/2rUvtI7nEmsxBj7R94VkJj4yeztpcQY
	ObJ0tn1y1Fr/It6RhNwmJy/V6s67LTRphSbM/
X-Google-Smtp-Source: AGHT+IG3r0+onx+cdt2AnBhnP5B8IOjoAUNZa0XHJbzy7tCE8dAJODZw/dVCg4EEWns+n4pli9/khGQVb4cTwUtcQyY=
X-Received: by 2002:a05:600c:34c8:b0:421:788b:7f21 with SMTP id
 5b1f17b1804b1-4246fd13a82mr441625e9.2.1718655429401; Mon, 17 Jun 2024
 13:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-zsmalloc-lock-mm-everything-v1-0-5e5081ea11b3@linux.dev> <20240617-zsmalloc-lock-mm-everything-v1-2-5e5081ea11b3@linux.dev>
In-Reply-To: <20240617-zsmalloc-lock-mm-everything-v1-2-5e5081ea11b3@linux.dev>
From: Yu Zhao <yuzhao@google.com>
Date: Mon, 17 Jun 2024 14:16:23 -0600
Message-ID: <CAOUHufaCYqwZLwCzHbC40KDjSWKYFoVKiPfRxvxr+2Z8JRRXaA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/zswap: use only one pool in zswap
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	Takero Funaki <flintglass@gmail.com>, Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 6:58=E2=80=AFAM Chengming Zhou <chengming.zhou@linu=
x.dev> wrote:
>
> Zswap uses 32 pools to workaround the locking scalability problem in
> zsmalloc,

Note that zpool can have other backends (zbud, z3fold), and the
original patch was developed (even before zswap could use zsmalloc) to
make sure it works for all the backend.

This patch only makes sense now only because zsmalloc became a lot
more popular than other backends (even though some distros still
default to zbud).

> which brings its own problems like memory waste and more
> memory fragmentation.
>
> Testing results show that we can have near performance with only one
> pool in zswap after changing zsmalloc to use per-size_class lock instead
> of pool spinlock.
>
> Testing kernel build (make bzImage -j32) on tmpfs with memory.max=3D1GB,
> and zswap shrinker enabled with 10GB swapfile on ext4.
>
>                                 real    user    sys
> 6.10.0-rc3                      138.18  1241.38 1452.73
> 6.10.0-rc3-onepool              149.45  1240.45 1844.69
> 6.10.0-rc3-onepool-perclass     138.23  1242.37 1469.71
>
> Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
> ---
>  mm/zswap.c | 60 +++++++++++++++++++-------------------------------------=
----
>  1 file changed, 19 insertions(+), 41 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index e25a6808c2ed..5063c5372e51 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -122,9 +122,6 @@ static unsigned int zswap_accept_thr_percent =3D 90; =
/* of max pool size */
>  module_param_named(accept_threshold_percent, zswap_accept_thr_percent,
>                    uint, 0644);
>
> -/* Number of zpools in zswap_pool (empirically determined for scalabilit=
y) */
> -#define ZSWAP_NR_ZPOOLS 32
> -
>  /* Enable/disable memory pressure-based shrinker. */
>  static bool zswap_shrinker_enabled =3D IS_ENABLED(
>                 CONFIG_ZSWAP_SHRINKER_DEFAULT_ON);
> @@ -160,7 +157,7 @@ struct crypto_acomp_ctx {
>   * needs to be verified that it's still valid in the tree.
>   */
>  struct zswap_pool {
> -       struct zpool *zpools[ZSWAP_NR_ZPOOLS];
> +       struct zpool *zpool;
>         struct crypto_acomp_ctx __percpu *acomp_ctx;
>         struct percpu_ref ref;
>         struct list_head list;
> @@ -237,7 +234,7 @@ static inline struct xarray *swap_zswap_tree(swp_entr=
y_t swp)
>
>  #define zswap_pool_debug(msg, p)                               \
>         pr_debug("%s pool %s/%s\n", msg, (p)->tfm_name,         \
> -                zpool_get_type((p)->zpools[0]))
> +                zpool_get_type((p)->zpool))
>
>  /*********************************
>  * pool functions
> @@ -246,7 +243,6 @@ static void __zswap_pool_empty(struct percpu_ref *ref=
);
>
>  static struct zswap_pool *zswap_pool_create(char *type, char *compressor=
)
>  {
> -       int i;
>         struct zswap_pool *pool;
>         char name[38]; /* 'zswap' + 32 char (max) num + \0 */
>         gfp_t gfp =3D __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM=
;
> @@ -267,18 +263,14 @@ static struct zswap_pool *zswap_pool_create(char *t=
ype, char *compressor)
>         if (!pool)
>                 return NULL;
>
> -       for (i =3D 0; i < ZSWAP_NR_ZPOOLS; i++) {
> -               /* unique name for each pool specifically required by zsm=
alloc */
> -               snprintf(name, 38, "zswap%x",
> -                        atomic_inc_return(&zswap_pools_count));
> -
> -               pool->zpools[i] =3D zpool_create_pool(type, name, gfp);
> -               if (!pool->zpools[i]) {
> -                       pr_err("%s zpool not available\n", type);
> -                       goto error;
> -               }
> +       /* unique name for each pool specifically required by zsmalloc */
> +       snprintf(name, 38, "zswap%x", atomic_inc_return(&zswap_pools_coun=
t));
> +       pool->zpool =3D zpool_create_pool(type, name, gfp);
> +       if (!pool->zpool) {
> +               pr_err("%s zpool not available\n", type);
> +               goto error;
>         }
> -       pr_debug("using %s zpool\n", zpool_get_type(pool->zpools[0]));
> +       pr_debug("using %s zpool\n", zpool_get_type(pool->zpool));
>
>         strscpy(pool->tfm_name, compressor, sizeof(pool->tfm_name));
>
> @@ -311,8 +303,7 @@ static struct zswap_pool *zswap_pool_create(char *typ=
e, char *compressor)
>  error:
>         if (pool->acomp_ctx)
>                 free_percpu(pool->acomp_ctx);
> -       while (i--)
> -               zpool_destroy_pool(pool->zpools[i]);
> +       zpool_destroy_pool(pool->zpool);
>         kfree(pool);
>         return NULL;
>  }
> @@ -361,15 +352,12 @@ static struct zswap_pool *__zswap_pool_create_fallb=
ack(void)
>
>  static void zswap_pool_destroy(struct zswap_pool *pool)
>  {
> -       int i;
> -
>         zswap_pool_debug("destroying", pool);
>
>         cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &pool->no=
de);
>         free_percpu(pool->acomp_ctx);
>
> -       for (i =3D 0; i < ZSWAP_NR_ZPOOLS; i++)
> -               zpool_destroy_pool(pool->zpools[i]);
> +       zpool_destroy_pool(pool->zpool);
>         kfree(pool);
>  }
>
> @@ -464,8 +452,7 @@ static struct zswap_pool *zswap_pool_find_get(char *t=
ype, char *compressor)
>         list_for_each_entry_rcu(pool, &zswap_pools, list) {
>                 if (strcmp(pool->tfm_name, compressor))
>                         continue;
> -               /* all zpools share the same type */
> -               if (strcmp(zpool_get_type(pool->zpools[0]), type))
> +               if (strcmp(zpool_get_type(pool->zpool), type))
>                         continue;
>                 /* if we can't get it, it's about to be destroyed */
>                 if (!zswap_pool_get(pool))
> @@ -492,12 +479,8 @@ unsigned long zswap_total_pages(void)
>         unsigned long total =3D 0;
>
>         rcu_read_lock();
> -       list_for_each_entry_rcu(pool, &zswap_pools, list) {
> -               int i;
> -
> -               for (i =3D 0; i < ZSWAP_NR_ZPOOLS; i++)
> -                       total +=3D zpool_get_total_pages(pool->zpools[i])=
;
> -       }
> +       list_for_each_entry_rcu(pool, &zswap_pools, list)
> +               total +=3D zpool_get_total_pages(pool->zpool);
>         rcu_read_unlock();
>
>         return total;
> @@ -802,11 +785,6 @@ static void zswap_entry_cache_free(struct zswap_entr=
y *entry)
>         kmem_cache_free(zswap_entry_cache, entry);
>  }
>
> -static struct zpool *zswap_find_zpool(struct zswap_entry *entry)
> -{
> -       return entry->pool->zpools[hash_ptr(entry, ilog2(ZSWAP_NR_ZPOOLS)=
)];
> -}
> -
>  /*
>   * Carries out the common pattern of freeing and entry's zpool allocatio=
n,
>   * freeing the entry itself, and decrementing the number of stored pages=
.
> @@ -814,7 +792,7 @@ static struct zpool *zswap_find_zpool(struct zswap_en=
try *entry)
>  static void zswap_entry_free(struct zswap_entry *entry)
>  {
>         zswap_lru_del(&zswap_list_lru, entry);
> -       zpool_free(zswap_find_zpool(entry), entry->handle);
> +       zpool_free(entry->pool->zpool, entry->handle);
>         zswap_pool_put(entry->pool);
>         if (entry->objcg) {
>                 obj_cgroup_uncharge_zswap(entry->objcg, entry->length);
> @@ -939,7 +917,7 @@ static bool zswap_compress(struct folio *folio, struc=
t zswap_entry *entry)
>         if (comp_ret)
>                 goto unlock;
>
> -       zpool =3D zswap_find_zpool(entry);
> +       zpool =3D entry->pool->zpool;
>         gfp =3D __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
>         if (zpool_malloc_support_movable(zpool))
>                 gfp |=3D __GFP_HIGHMEM | __GFP_MOVABLE;
> @@ -968,7 +946,7 @@ static bool zswap_compress(struct folio *folio, struc=
t zswap_entry *entry)
>
>  static void zswap_decompress(struct zswap_entry *entry, struct folio *fo=
lio)
>  {
> -       struct zpool *zpool =3D zswap_find_zpool(entry);
> +       struct zpool *zpool =3D entry->pool->zpool;
>         struct scatterlist input, output;
>         struct crypto_acomp_ctx *acomp_ctx;
>         u8 *src;
> @@ -1467,7 +1445,7 @@ bool zswap_store(struct folio *folio)
>         return true;
>
>  store_failed:
> -       zpool_free(zswap_find_zpool(entry), entry->handle);
> +       zpool_free(entry->pool->zpool, entry->handle);
>  put_pool:
>         zswap_pool_put(entry->pool);
>  freepage:
> @@ -1683,7 +1661,7 @@ static int zswap_setup(void)
>         pool =3D __zswap_pool_create_fallback();
>         if (pool) {
>                 pr_info("loaded using pool %s/%s\n", pool->tfm_name,
> -                       zpool_get_type(pool->zpools[0]));
> +                       zpool_get_type(pool->zpool));
>                 list_add(&pool->list, &zswap_pools);
>                 zswap_has_pool =3D true;
>                 static_branch_enable(&zswap_ever_enabled);
>
> --
> 2.45.2
>
>

