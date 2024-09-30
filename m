Return-Path: <linux-kernel+bounces-344958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC57F98B09F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E684D1C20BC9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB3D18754F;
	Mon, 30 Sep 2024 23:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bquAWJcA"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FA1183CA4
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727737794; cv=none; b=iSdgRtlvZLqjm4qT5fb6r5LGkerbhraq9aB1uuiEnT+KVR2nxVehVbVHlK1hjVUhmkLb5Gp42VHEN+C2kO+UwoAAhz9VU+q/h12VXY3bAsSClDvhpPjd6hlY08EFo+uLi0PuLPIUv2sGdKrwZeGFfk+Lq9iDoCdebcEO8dtM6QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727737794; c=relaxed/simple;
	bh=eN7UHx77XmuqktwOAl+vfxKDeCIHxYfa0eaTctzC+vI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FHobZN9rBsdMGGcHz3sNWAxovdpO0DaIk1wTjfZDSo8etaTKPRd0cHf7N46pWKRlWjUF9R4qNm9pZkk6zNdkkrhOnFOlaLIEAfLSmzAlvlxUii3RGy0LUX3zKOiCa+A9IShRC+Ia/LxZ8k3kpezPbbtBkMilPjzOChTUbJUPDYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bquAWJcA; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8d3cde1103so682694066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 16:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727737790; x=1728342590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RNDaXl/U/fth0NO73obA3tDz7SjnrhgWka0eqUJ5Ks=;
        b=bquAWJcAsEZHl4Q4vuCQAXOmJiOjnOboLJ0goB74ZYCIBQKFPHWW9iPZpyZLBYBwAd
         dl7FmM4Jy5hR7MKoVwmqVdJUbkhXJWcDiVZZUw14RhhwoCd2doQ9pDhqXLx9jlU7gJ5R
         FuZTfLSIBEjgO7qWB/RXC2N+GOVTAL+83C/kg0+3M0nAIpr91XuOPudZFbdr2kd7EO0L
         RMl7g1s5eEFH9+CRGv6/ABY0OnYXseiWwej+5c/3DfshRxIkR301DvsI2xee91/Z1j8N
         eh4WT8Xl2ILi1U/kvIid0uZYPgRhtQRMAM8e9rgZDcP1AEIb1vACsTj5y9pX7wCQtBIr
         Zs3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727737790; x=1728342590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5RNDaXl/U/fth0NO73obA3tDz7SjnrhgWka0eqUJ5Ks=;
        b=dzWsXaWWhF3cutEUiyW2ZlXEDnnybRq9Dgw7MaC47Y09K+UbMQQy+V6YFsi1qtl12J
         RKt/xJMptthYLKKQXCqVWFQbIxVQQy3rbP8Ezn5eeAML6VKpt/gp++BMJa2ypwFHe7H4
         bWYgYWKLyzmiufy54J+JQ+Ehyna8Efda5TaUaqz5eJ+qgfePLBhf1R1CG/iAGotl496S
         C8CLZaJBS8JnmmnUZMxjHvOA0CgonnovQTaa3Zd5E9IUh8F/ISa2yLSYVi+9dZDMDnvf
         S15xfWJAEEs7d977n/0OP43RuzP/dFGLZglAEPBQNQcJc/WwY9l9WypeWZ71GJNbNrxA
         P+MQ==
X-Gm-Message-State: AOJu0Yx/hKFlL+PBBkqwjyUUvV5nkoyodIbUYmzi176XUoYhrX/AkSM/
	1DEIRfj6q5gqo4n198erVQNpnJDSrqUJLal0H+aJiIsQuIN4Wl7pFfuybC//2lVm6b++7bJz81w
	vetn86vvL3RnB0Evt/JihUwEW08zFU2tJOB4N
X-Google-Smtp-Source: AGHT+IFmGMs5P/NFTNZMELBvIdBZGXL8578rLT7kSMFHWQufBjUr5NlJVgq9zDezW+iL/NmC6FPSEhJRaIGle6WaSk8=
X-Received: by 2002:a17:907:1ca2:b0:a90:3498:93b2 with SMTP id
 a640c23a62f3a-a93c48e7facmr1717083166b.1.1727737789867; Mon, 30 Sep 2024
 16:09:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930221221.6981-1-kanchana.p.sridhar@intel.com> <20240930221221.6981-7-kanchana.p.sridhar@intel.com>
In-Reply-To: <20240930221221.6981-7-kanchana.p.sridhar@intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 30 Sep 2024 16:09:12 -0700
Message-ID: <CAJD7tkZh6ufHQef5HjXf_F5b5LC1EATexgseD=4WvrO+a6Ni6w@mail.gmail.com>
Subject: Re: [PATCH v9 6/7] mm: zswap: Support large folios in zswap_store().
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, usamaarif642@gmail.com, 
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com, 
	21cnbao@gmail.com, akpm@linux-foundation.org, willy@infradead.org, 
	nanhai.zou@intel.com, wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 3:12=E2=80=AFPM Kanchana P Sridhar
<kanchana.p.sridhar@intel.com> wrote:
>
> zswap_store() will store large folios by compressing them page by page.
>
> This patch provides a sequential implementation of storing a large folio
> in zswap_store() by iterating through each page in the folio to compress
> and store it in the zswap zpool.
>
> zswap_store() calls the newly added zswap_store_page() function for each
> page in the folio. zswap_store_page() handles compressing and storing eac=
h
> page.
>
> We check the global and per-cgroup limits once at the beginning of
> zswap_store(), and only check that the limit is not reached yet. This is
> racy and inaccurate, but it should be sufficient for now. We also obtain
> initial references to the relevant objcg and pool to guarantee that
> subsequent references can be acquired by zswap_store_page(). A new functi=
on
> zswap_pool_get() is added to facilitate this.
>
> If these one-time checks pass, we compress the pages of the folio, while
> maintaining a running count of compressed bytes for all the folio's pages=
.
> If all pages are successfully compressed and stored, we do the cgroup
> zswap charging with the total compressed bytes, and batch update the
> zswap_stored_pages atomic/zswpout event stats with folio_nr_pages() once,
> before returning from zswap_store().
>
> If an error is encountered during the store of any page in the folio,
> all pages in that folio currently stored in zswap will be invalidated.
> Thus, a folio is either entirely stored in zswap, or entirely not stored
> in zswap.
>
> The most important value provided by this patch is it enables swapping ou=
t
> large folios to zswap without splitting them. Furthermore, it batches som=
e
> operations while doing so (cgroup charging, stats updates).
>
> This patch also forms the basis for building compress batching of pages i=
n
> a large folio in zswap_store() by compressing up to say, 8 pages of the
> folio in parallel in hardware using the Intel In-Memory Analytics
> Accelerator (Intel IAA).
>
> This change reuses and adapts the functionality in Ryan Roberts' RFC
> patch [1]:
>
>   "[RFC,v1] mm: zswap: Store large folios without splitting"
>
>   [1] https://lore.kernel.org/linux-mm/20231019110543.3284654-1-ryan.robe=
rts@arm.com/T/#u
>
> Also, addressed some of the RFC comments from the discussion in [1].
>
> Co-developed-by: Ryan Roberts
> Signed-off-by:

We haven't been able to get a signoff from Ryan. Andrew, what's the policy =
here?

> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> ---
>  mm/zswap.c | 220 +++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 153 insertions(+), 67 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 2b8da50f6322..b74c8de99646 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -411,6 +411,12 @@ static int __must_check zswap_pool_tryget(struct zsw=
ap_pool *pool)
>         return percpu_ref_tryget(&pool->ref);
>  }
>
> +/* The caller must already have a reference. */
> +static void zswap_pool_get(struct zswap_pool *pool)
> +{
> +       percpu_ref_get(&pool->ref);
> +}
> +
>  static void zswap_pool_put(struct zswap_pool *pool)
>  {
>         percpu_ref_put(&pool->ref);
> @@ -1402,68 +1408,52 @@ static void shrink_worker(struct work_struct *w)
>  /*********************************
>  * main API
>  **********************************/
> -bool zswap_store(struct folio *folio)
> +
> +/*
> + * Stores the page at specified "index" in a folio.
> + *
> + * @page:  The page to store in zswap.
> + * @objcg: The folio's objcg. Caller has a reference.
> + * @pool:  The zswap_pool to store the compressed data for the page.
> + *         The caller should have obtained a reference to a valid
> + *         zswap_pool by calling zswap_pool_tryget(), to pass as this
> + *         argument.
> + * @tree:  The xarray for the @page's folio's swap.
> + * @compressed_bytes: The compressed entry->length value is added
> + *                    to this, so that the caller can get the total
> + *                    compressed lengths of all sub-pages in a folio.
> + */
> +static bool zswap_store_page(struct page *page,
> +                            struct obj_cgroup *objcg,
> +                            struct zswap_pool *pool,
> +                            struct xarray *tree,
> +                            size_t *compressed_bytes)
>  {
> -       swp_entry_t swp =3D folio->swap;
> -       pgoff_t offset =3D swp_offset(swp);
> -       struct xarray *tree =3D swap_zswap_tree(swp);
>         struct zswap_entry *entry, *old;
> -       struct obj_cgroup *objcg =3D NULL;
> -       struct mem_cgroup *memcg =3D NULL;
> -
> -       VM_WARN_ON_ONCE(!folio_test_locked(folio));
> -       VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> -
> -       /* Large folios aren't supported */
> -       if (folio_test_large(folio))
> -               return false;
> -
> -       if (!zswap_enabled)
> -               goto check_old;
> -
> -       /* Check cgroup limits */
> -       objcg =3D get_obj_cgroup_from_folio(folio);
> -       if (objcg && !obj_cgroup_may_zswap(objcg)) {
> -               memcg =3D get_mem_cgroup_from_objcg(objcg);
> -               if (shrink_memcg(memcg)) {
> -                       mem_cgroup_put(memcg);
> -                       goto reject;
> -               }
> -               mem_cgroup_put(memcg);
> -       }
> -
> -       if (zswap_check_limits())
> -               goto reject;
>
>         /* allocate entry */
> -       entry =3D zswap_entry_cache_alloc(GFP_KERNEL, folio_nid(folio));
> +       entry =3D zswap_entry_cache_alloc(GFP_KERNEL, folio_nid(page_foli=
o(page)));

Can we just use page_to_nid() here? I think the node info exists even
for tail pages, right?

>         if (!entry) {
>                 zswap_reject_kmemcache_fail++;
>                 goto reject;
>         }
>
> -       /* if entry is successfully added, it keeps the reference */
> -       entry->pool =3D zswap_pool_current_get();
> -       if (!entry->pool)
> -               goto freepage;
> +       /* zswap_store() already holds a ref on 'objcg' and 'pool' */
> +       if (objcg)
> +               obj_cgroup_get(objcg);
> +       zswap_pool_get(pool);
>
> -       if (objcg) {
> -               memcg =3D get_mem_cgroup_from_objcg(objcg);
> -               if (memcg_list_lru_alloc(memcg, &zswap_list_lru, GFP_KERN=
EL)) {
> -                       mem_cgroup_put(memcg);
> -                       goto put_pool;
> -               }
> -               mem_cgroup_put(memcg);
> -       }
> +       /* if entry is successfully added, it keeps the reference */
> +       entry->pool =3D pool;
>
> -       if (!zswap_compress(&folio->page, entry))
> -               goto put_pool;
> +       if (!zswap_compress(page, entry))
> +               goto put_pool_objcg;
>
> -       entry->swpentry =3D swp;
> +       entry->swpentry =3D page_swap_entry(page);
>         entry->objcg =3D objcg;
>         entry->referenced =3D true;
>
> -       old =3D xa_store(tree, offset, entry, GFP_KERNEL);
> +       old =3D xa_store(tree, swp_offset(entry->swpentry), entry, GFP_KE=
RNEL);
>         if (xa_is_err(old)) {
>                 int err =3D xa_err(old);
>
> @@ -1480,11 +1470,6 @@ bool zswap_store(struct folio *folio)
>         if (old)
>                 zswap_entry_free(old);
>
> -       if (objcg) {
> -               obj_cgroup_charge_zswap(objcg, entry->length);
> -               count_objcg_events(objcg, ZSWPOUT, 1);
> -       }
> -
>         /*
>          * We finish initializing the entry while it's already in xarray.
>          * This is safe because:
> @@ -1496,36 +1481,137 @@ bool zswap_store(struct folio *folio)
>          *    an incoherent entry.
>          */
>         if (entry->length) {
> +               *compressed_bytes +=3D entry->length;
>                 INIT_LIST_HEAD(&entry->lru);
>                 zswap_lru_add(&zswap_list_lru, entry);
>         }
>
> -       /* update stats */
> -       atomic_long_inc(&zswap_stored_pages);
> -       count_vm_event(ZSWPOUT);
> -
> +       /*
> +        * We shouldn't have any possibility of failure after the entry i=
s
> +        * added in the xarray. The pool/objcg refs obtained here will on=
ly
> +        * be dropped if/when zswap_entry_free() gets called.
> +        */
>         return true;
>
>  store_failed:
>         zpool_free(entry->pool->zpool, entry->handle);
> -put_pool:
> -       zswap_pool_put(entry->pool);
> -freepage:
> +put_pool_objcg:
> +       zswap_pool_put(pool);
> +       obj_cgroup_put(objcg);

I think if we reorder the function we can drop these calls, make the
comments positioned a bit better, and centralize the entry
initializations. I am also not a fan of passing a semi-initialized
entry to zswap_compress() to get the pool pointer.

Does the following diff improve things or did I miss something?

diff --git a/mm/zswap.c b/mm/zswap.c
index b74c8de996468..eac1f846886a6 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -881,7 +881,8 @@ static int zswap_cpu_comp_dead(unsigned int cpu,
struct hlist_node *node)
        return 0;
 }

-static bool zswap_compress(struct page *page, struct zswap_entry *entry)
+static bool zswap_compress(struct page *page, struct zswap_entry *entry,
+                          struct zswap_pool *pool)
 {
        struct crypto_acomp_ctx *acomp_ctx;
        struct scatterlist input, output;
@@ -893,7 +894,7 @@ static bool zswap_compress(struct page *page,
struct zswap_entry *entry)
        gfp_t gfp;
        u8 *dst;

-       acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
+       acomp_ctx =3D raw_cpu_ptr(pool->acomp_ctx);

        mutex_lock(&acomp_ctx->mutex);

@@ -926,7 +927,7 @@ static bool zswap_compress(struct page *page,
struct zswap_entry *entry)
        if (comp_ret)
                goto unlock;

-       zpool =3D entry->pool->zpool;
+       zpool =3D pool->zpool;
        gfp =3D __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
        if (zpool_malloc_support_movable(zpool))
                gfp |=3D __GFP_HIGHMEM | __GFP_MOVABLE;
@@ -1435,23 +1436,11 @@ static bool zswap_store_page(struct page *page,
        entry =3D zswap_entry_cache_alloc(GFP_KERNEL,
folio_nid(page_folio(page)));
        if (!entry) {
                zswap_reject_kmemcache_fail++;
-               goto reject;
+               return false;
        }

-       /* zswap_store() already holds a ref on 'objcg' and 'pool' */
-       if (objcg)
-               obj_cgroup_get(objcg);
-       zswap_pool_get(pool);
-
-       /* if entry is successfully added, it keeps the reference */
-       entry->pool =3D pool;
-
-       if (!zswap_compress(page, entry))
-               goto put_pool_objcg;
-
-       entry->swpentry =3D page_swap_entry(page);
-       entry->objcg =3D objcg;
-       entry->referenced =3D true;
+       if (!zswap_compress(page, entry, pool))
+               goto compress_failed;

        old =3D xa_store(tree, swp_offset(entry->swpentry), entry, GFP_KERN=
EL);
        if (xa_is_err(old)) {
@@ -1470,6 +1459,16 @@ static bool zswap_store_page(struct page *page,
        if (old)
                zswap_entry_free(old);

+       /*
+        * The entry is successfully compressed and stored in the tree, the=
re is
+        * no further possibility of failure. Grab refs to the pool and obj=
cg.
+        * These refs will be dropped by zswap_entry_free() when the entry =
is
+        * removed from the tree.
+        */
+       zswap_pool_get(pool);
+       if (objcg)
+               obj_cgroup_get(objcg);
+
        /*
         * We finish initializing the entry while it's already in xarray.
         * This is safe because:
@@ -1480,26 +1479,22 @@ static bool zswap_store_page(struct page *page,
         *    The publishing order matters to prevent writeback from seeing
         *    an incoherent entry.
         */
+       entry->pool =3D pool;
+       entry->swpentry =3D page_swap_entry(page);
+       entry->objcg =3D objcg;
+       entry->referenced =3D true;
        if (entry->length) {
                *compressed_bytes +=3D entry->length;
                INIT_LIST_HEAD(&entry->lru);
                zswap_lru_add(&zswap_list_lru, entry);
        }

-       /*
-        * We shouldn't have any possibility of failure after the entry is
-        * added in the xarray. The pool/objcg refs obtained here will only
-        * be dropped if/when zswap_entry_free() gets called.
-        */
        return true;

 store_failed:
-       zpool_free(entry->pool->zpool, entry->handle);
-put_pool_objcg:
-       zswap_pool_put(pool);
-       obj_cgroup_put(objcg);
+       zpool_free(pool->zpool, entry->handle);
+compress_failed:
        zswap_entry_cache_free(entry);
-reject:
        return false;
 }


>         zswap_entry_cache_free(entry);
>  reject:
> +       return false;
> +}
> +
> +bool zswap_store(struct folio *folio)
> +{
> +       long nr_pages =3D folio_nr_pages(folio);
> +       swp_entry_t swp =3D folio->swap;
> +       struct xarray *tree =3D swap_zswap_tree(swp);
> +       struct obj_cgroup *objcg =3D NULL;
> +       struct mem_cgroup *memcg =3D NULL;
> +       struct zswap_pool *pool;
> +       size_t compressed_bytes =3D 0;
> +       bool ret =3D false;
> +       long index;
> +
> +       VM_WARN_ON_ONCE(!folio_test_locked(folio));
> +       VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> +
> +       if (!zswap_enabled)
> +               goto check_old;
> +
> +       /*
> +        * Check cgroup zswap limits:
> +        *
> +        * The cgroup zswap limit check is done once at the beginning of
> +        * zswap_store(). The cgroup charging is done once, at the end
> +        * of a successful folio store. What this means is, if the cgroup
> +        * was within the zswap_max limit at the beginning of a large fol=
io
> +        * store, it could go over the limit by at most (HPAGE_PMD_NR - 1=
)
> +        * pages due to this store.
> +        */
> +       objcg =3D get_obj_cgroup_from_folio(folio);
> +       if (objcg && !obj_cgroup_may_zswap(objcg)) {
> +               memcg =3D get_mem_cgroup_from_objcg(objcg);
> +               if (shrink_memcg(memcg)) {
> +                       mem_cgroup_put(memcg);
> +                       goto put_objcg;
> +               }
> +               mem_cgroup_put(memcg);
> +       }
> +
> +       /*
> +        * Check zpool utilization against zswap limits:
> +        *
> +        * The zswap zpool utilization is also checked against the limits
> +        * just once, at the start of zswap_store(). If the check passes,
> +        * any breaches of the limits set by zswap_max_pages() or
> +        * zswap_accept_thr_pages() that may happen while storing this
> +        * folio, will only be detected during the next call to
> +        * zswap_store() by any process.
> +        */

This is essentially a rephrased repetition of the last comment, just
refer to it instead. Something like:

         /*
           * Check zpool utilization against zswap limits. The possibility =
of
           * going overlimit is the same as the cgroup limit check.
           */

> +       if (zswap_check_limits())
> +               goto put_objcg;
> +
> +       pool =3D zswap_pool_current_get();
> +       if (!pool)
> +               goto put_objcg;
> +
> +       if (objcg) {
> +               memcg =3D get_mem_cgroup_from_objcg(objcg);
> +               if (memcg_list_lru_alloc(memcg, &zswap_list_lru, GFP_KERN=
EL)) {
> +                       mem_cgroup_put(memcg);
> +                       goto put_pool;
> +               }
> +               mem_cgroup_put(memcg);
> +       }
> +
> +       /*
> +        * Store each page of the folio as a separate entry. If we fail t=
o
> +        * store a page, unwind by deleting all the pages for this folio
> +        * currently in zswap.
> +        */
> +       for (index =3D 0; index < nr_pages; ++index) {
> +               if (!zswap_store_page(folio_page(folio, index), objcg, po=
ol, tree, &compressed_bytes))
> +                       goto put_pool;
> +       }
> +
> +       if (objcg) {
> +               obj_cgroup_charge_zswap(objcg, compressed_bytes);
> +               count_objcg_events(objcg, ZSWPOUT, nr_pages);
> +       }
> +
> +       atomic_long_add(nr_pages, &zswap_stored_pages);
> +       count_vm_events(ZSWPOUT, nr_pages);
> +
> +       ret =3D true;
> +
> +put_pool:
> +       zswap_pool_put(pool);
> +put_objcg:
>         obj_cgroup_put(objcg);
> -       if (zswap_pool_reached_full)
> +       if (!ret && zswap_pool_reached_full)
>                 queue_work(shrink_wq, &zswap_shrink_work);
>  check_old:
>         /*
> -        * If the zswap store fails or zswap is disabled, we must invalid=
ate the
> -        * possibly stale entry which was previously stored at this offse=
t.
> -        * Otherwise, writeback could overwrite the new data in the swapf=
ile.
> +        * If the zswap store fails or zswap is disabled, we must invalid=
ate
> +        * the possibly stale entries which were previously stored at the
> +        * offsets corresponding to each page of the folio. Otherwise,
> +        * writeback could overwrite the new data in the swapfile.
>          */
> -       entry =3D xa_erase(tree, offset);
> -       if (entry)
> -               zswap_entry_free(entry);
> -       return false;
> +       if (!ret) {
> +               pgoff_t offset =3D swp_offset(swp);
> +               struct zswap_entry *entry;
> +
> +               for (index =3D 0; index < nr_pages; ++index) {
> +                       entry =3D xa_erase(tree, offset + index);
> +                       if (entry)
> +                               zswap_entry_free(entry);
> +               }
> +       }
> +
> +       return ret;
>  }
>
>  bool zswap_load(struct folio *folio)
> --
> 2.27.0
>

