Return-Path: <linux-kernel+bounces-342340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 448EF988DBB
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 05:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56DAD1C2123A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 03:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B0243146;
	Sat, 28 Sep 2024 03:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i/X6VBEp"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FA25221
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 03:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727494977; cv=none; b=rgpBbCjcJ1dbtOFWCU99SRVetrH6oqxYgfRtn5/qQg9Gu+g0mOT9NUeIdEReBFGi9iT47KAnxo/VYlYY9SbgalXU10o6jWs98UEVwNoeviZQ3TLISSCVeaeLhug5hZrEe3qAp9/t7NczkLRzzcKqzuugeJqiADVxyVaFr7sOR4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727494977; c=relaxed/simple;
	bh=bZgsbldm4+g8ilcDtW5Mc+YBl5Rx47Rv7/qCck/3xYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RtUmd+IFOnp9YXunLauVcFjt3XKZD5yeSQ0gn4PR3UF4ktsOm0KJ1VOrqS6s2JFFi48sXQpp7qdEv/f4nMRCYHKnYHdgxbOC2yaA2SvKYR/ztytl3VJxAFr9xRw5ugKI3LPUoV/ulij2W/248c3fuL6TXsEZhdZ2CXexY64XqGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i/X6VBEp; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8d43657255so398474366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 20:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727494974; x=1728099774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5Tooe2W/E7vFrH7KKO3y3dPr7020Ccg8U9NuOwl7pg=;
        b=i/X6VBEpTtftik4mJqVVsFHnFGtiw25BMkq0DX1jD6w3hLY0oJdixXWRXWUNwK2fyJ
         O+W1esPSd0+U5oAMluZdSE0JRUv9cBQHxH82gp2pwiIjSoHbZ8T7spPRs3xnMOXwU+O8
         Gka+XkQy/8fa9nSnBuvOvnJZ5s9fiBK1nx+05Q+/mS1LNaBWFTTFXDzcQTZIfHiH6uhX
         AbneBSNKUgV8iZEOPcuwioho5LOJwALvMSY6OYV2JB5SM12KTb89PRMh2WEUOvhcBIMj
         3vzSrgaQWQHC7ssEsj14zWmiOHdnYnjfK6gt7iNYbpq/nZEJ1t86WW5bYZmRGJmXPnma
         o32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727494974; x=1728099774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q5Tooe2W/E7vFrH7KKO3y3dPr7020Ccg8U9NuOwl7pg=;
        b=lUQz6HMxGzcSv2Ozs6G7iZebB8qyguyFCV0pfshplhRP5WpmiqFDzww7I/fJMqd7xC
         fcvwsXb4+XZ+aiDn1VJppPIgI8MndaM+3tQ3XRQrBUNdRNmfKVyzLatSX2iV33BZKbCy
         tsH9RTed1Y8C5e8DzxS5u6wF8N79HcvYdz1nPeMDx+Q+gmAWHwpVE5C3SQ0rqEtPEuxm
         0T/gbQnKMPQcK8iTOISIvHXOqg1NTHCQLeOr7VCK7AX5NKQC3E9z1k74K9pMEcKHUtmv
         1WLluoW7jmSaTaqFSxZNP03xNXILTEGsFG99VybFNQgK8RjVBeo7TyPg5Luaec5hvK5k
         jYqg==
X-Gm-Message-State: AOJu0YyWv/SM1COIVvV5Y2urAXehrHitKeRwEWkxUp6CK7gL6UpntLgP
	Xlor7tU0IcW7PIoHUc/0cs40tGkUwl0b8rKW3Hj1pShs0HoqnQ/26D4l90wVg9N8gpfH2J+xKR7
	V5PeQds/Y7Aegf2X+/5D76HrdPzPZQV+vfIbo
X-Google-Smtp-Source: AGHT+IHHJjBitiahFzT6xIDEBXMg1wTVjKX6UJg0YkCO2kCeKKQY3gdmTuvGZLPC3hW0xyIRmUGIiu3arD4Bo+9xoTk=
X-Received: by 2002:a17:907:1b03:b0:a8a:8cdb:83a7 with SMTP id
 a640c23a62f3a-a93c4aa6c29mr504838666b.54.1727494973522; Fri, 27 Sep 2024
 20:42:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240928021620.8369-1-kanchana.p.sridhar@intel.com> <20240928021620.8369-7-kanchana.p.sridhar@intel.com>
In-Reply-To: <20240928021620.8369-7-kanchana.p.sridhar@intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 27 Sep 2024 20:42:16 -0700
Message-ID: <CAJD7tkZRTAiEJQpg96zqDye3ViCfvBsMM1Ozmcs75e__WcF0kQ@mail.gmail.com>
Subject: Re: [PATCH v8 6/8] mm: zswap: Support large folios in zswap_store().
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, usamaarif642@gmail.com, 
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com, 
	21cnbao@gmail.com, akpm@linux-foundation.org, nanhai.zou@intel.com, 
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 7:16=E2=80=AFPM Kanchana P Sridhar
<kanchana.p.sridhar@intel.com> wrote:
>
> zswap_store() will store large folios by compressing them page by page.
>
> This patch provides a sequential implementation of storing a large folio
> in zswap_store() by iterating through each page in the folio to compress
> and store it in the zswap zpool.
>
> Towards this goal, zswap_compress() is modified to take a page instead
> of a folio as input.

It is already modified at this point, it's not part of this patch.

>
> Each page's swap offset is stored as a separate zswap entry.

I think "Each page is compressed individually and stored as a separate
zswap entry" is clearer. We do not store the offsets.

>
> We check the cgroup zswap limit and the zpool utilization against
> the zswap max/accept_threshold limits once, at the beginning of
> zswap_store. We also obtain a percpu_ref_tryget() reference to the
> current zswap_pool at the start of zswap_store to prevent it from
> being deleted while the folio is being stored.

This can be clarified further:

We check the global and per-cgroup limits once at the beginning, and
only check that the limit is not reached yet. This is racy and
inaccurate, but it should be sufficient for now. We also obtain
initial references to the relevant objcg and pool to guarantee that
subsequent references can be acquired by zswap_store_page().

>
> If these one-time checks pass, we compress the sub-pages of the folio,
> while maintaining a running count of compressed bytes for all the folio's
> sub-pages. If all pages are successfully compressed and stored, we do the
> cgroup zswap charging with the total compressed bytes, and batch update
> the zswap_stored_pages atomic/zswpout event stats with folio_nr_pages()
> once, before returning from zswap_store.

Please consistently use "page" instead of "sub-page", and add "()" to
the end of function names.

>
> The patch adds a new zswap_pool_get() function that is called in the
> sub-page level "zswap_store_page()" function.

"that is called by zswap_store_page(), which handles compressing and
storing each page in the folio."

>
> If an error is encountered during the store of any page in the folio,
> all pages in that folio currently stored in zswap will be invalidated.
> Thus, a folio is either entirely stored in zswap, or entirely not stored
> in zswap.
>
> This patch forms the basis for building compress batching of pages in a
> large folio in zswap_store by compressing up to say, 8 pages of the folio
> in parallel in hardware using the Intel In-Memory Analytics Accelerator
> (Intel IAA).

This patch also has its own merits, it batches some operations, and
more importantly enables swapping out large folios to zswap without
splitting them.

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
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> ---
>  mm/zswap.c | 227 ++++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 165 insertions(+), 62 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 43e4e216db41..b8395ddf7b7c 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -411,6 +411,16 @@ static int __must_check zswap_pool_tryget(struct zsw=
ap_pool *pool)
>         return percpu_ref_tryget(&pool->ref);
>  }
>
> +/*
> + * Note: zswap_pool_get() should only be called after zswap_pool_tryget(=
)
> + * returns success. zswap_pool_tryget() returns success only if the "poo=
l" is
> + * non-NULL and the "&pool->ref" is non-0.

Just use the same statement used by css_get():

"The caller must already have a reference."

> + */
> +static void zswap_pool_get(struct zswap_pool *pool)
> +{
> +       percpu_ref_get(&pool->ref);
> +}
> +
>  static void zswap_pool_put(struct zswap_pool *pool)
>  {
>         percpu_ref_put(&pool->ref);
> @@ -1402,38 +1412,35 @@ static void shrink_worker(struct work_struct *w)
>  /*********************************
>  * main API
>  **********************************/
> -bool zswap_store(struct folio *folio)
> +
> +/*
> + * Stores the page at specified "index" in a folio.
> + *
> + * @folio: The folio to store in zswap.
> + * @index: Index into the page in the folio that this function will stor=
e.
> + * @objcg: The folio's objcg.
> + * @pool:  The zswap_pool to store the compressed data for the page.
> + *         The caller should have obtained a reference to a valid
> + *         zswap_pool by calling zswap_pool_tryget(), to pass as this
> + *         argument.
> + * @compressed_bytes: The compressed entry->length value is added
> + *                    to this, so that the caller can get the total
> + *                    compressed lengths of all sub-pages in a folio.
> + */
> +static bool zswap_store_page(struct folio *folio, long index,
> +                            struct obj_cgroup *objcg,
> +                            struct zswap_pool *pool,
> +                            size_t *compressed_bytes)

Would it be clearer to just return the compressed size, and return -1
upon failure?

>  {
> +       struct page *page =3D folio_page(folio, index);
>         swp_entry_t swp =3D folio->swap;
> -       pgoff_t offset =3D swp_offset(swp);
>         struct xarray *tree =3D swap_zswap_tree(swp);
> +       pgoff_t offset =3D swp_offset(swp) + index;
>         struct zswap_entry *entry, *old;
> -       struct obj_cgroup *objcg =3D NULL;
> -       struct mem_cgroup *memcg =3D NULL;
> -
> -       VM_WARN_ON_ONCE(!folio_test_locked(folio));
> -       VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> +       int type =3D swp_type(swp);

Why do we need type? We use it when initializing entry->swpentry to
reconstruct the swp_entry_t we already have.

>
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
> +       if (objcg)
> +               obj_cgroup_get(objcg);
>
>         /* allocate entry */
>         entry =3D zswap_entry_cache_alloc(GFP_KERNEL, folio_nid(folio));
> @@ -1442,24 +1449,21 @@ bool zswap_store(struct folio *folio)
>                 goto reject;
>         }
>
> -       /* if entry is successfully added, it keeps the reference */
> -       entry->pool =3D zswap_pool_current_get();
> -       if (!entry->pool)
> -               goto freepage;
> +       /*
> +        * We get here only after the call to zswap_pool_tryget() in the
> +        * caller, zswap_store(), has returned success. Hence it is safe
> +        * to call zswap_pool_get().
> +        *
> +        * if entry is successfully added, it keeps the reference
> +        */
> +       zswap_pool_get(pool);

I would move this right above obj_cgroup_get() and have a single
concise comment for both, e.g.:

/* zswap_store() already holds a ref on 'pool' and 'objcg' */

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
> +       entry->pool =3D pool;
>
> -       if (!zswap_compress(&folio->page, entry))
> +       if (!zswap_compress(page, entry))
>                 goto put_pool;
>
> -       entry->swpentry =3D swp;
> +       entry->swpentry =3D swp_entry(type, offset);
>         entry->objcg =3D objcg;
>         entry->referenced =3D true;
>
> @@ -1480,11 +1484,6 @@ bool zswap_store(struct folio *folio)
>         if (old)
>                 zswap_entry_free(old);
>
> -       if (objcg) {
> -               obj_cgroup_charge_zswap(objcg, entry->length);
> -               count_objcg_event(objcg, ZSWPOUT);
> -       }
> -
>         /*
>          * We finish initializing the entry while it's already in xarray.
>          * This is safe because:
> @@ -1496,36 +1495,140 @@ bool zswap_store(struct folio *folio)
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
>         return true;
>
>  store_failed:
>         zpool_free(entry->pool->zpool, entry->handle);
>  put_pool:
> -       zswap_pool_put(entry->pool);
> -freepage:
> +       zswap_pool_put(pool);
>         zswap_entry_cache_free(entry);
>  reject:

Please rename this to put_objcg, we are no longer "rejecting" here.

>         obj_cgroup_put(objcg);
> -       if (zswap_pool_reached_full)
> -               queue_work(shrink_wq, &zswap_shrink_work);
> -check_old:
> +       return false;
> +}
> +
> +bool zswap_store(struct folio *folio)
> +{
> +       long nr_pages =3D folio_nr_pages(folio);
> +       swp_entry_t swp =3D folio->swap;
> +       struct xarray *tree =3D swap_zswap_tree(swp);
> +       pgoff_t offset =3D swp_offset(swp);
> +       struct obj_cgroup *objcg =3D NULL;
> +       struct mem_cgroup *memcg =3D NULL;
> +       struct zswap_pool *pool;
> +       size_t compressed_bytes =3D 0;

Why size_t? entry->length is int.

> +       bool ret =3D false;
> +       long index;
> +
> +       VM_WARN_ON_ONCE(!folio_test_locked(folio));
> +       VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> +
> +       if (!zswap_enabled)
> +               goto reject;
> +
>         /*
> -        * If the zswap store fails or zswap is disabled, we must invalid=
ate the
> -        * possibly stale entry which was previously stored at this offse=
t.
> -        * Otherwise, writeback could overwrite the new data in the swapf=
ile.
> +        * Check cgroup zswap limits:
> +        *
> +        * The cgroup zswap limit check is done once at the beginning of
> +        * zswap_store(). The cgroup charging is done once, at the end
> +        * of a successful folio store. What this means is, if the cgroup
> +        * was within the zswap_max limit at the beginning of a large fol=
io
> +        * store, it could go over the limit by at most (HPAGE_PMD_NR - 1=
)
> +        * pages.

Add ".. due to this store", as it can be much more over the limit when
stores are racing. Also, this comment can be slightly generalized and
the comment above zswap_check_limits() omitted.

>          */
> -       entry =3D xa_erase(tree, offset);
> -       if (entry)
> -               zswap_entry_free(entry);
> -       return false;
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
> +               if (!zswap_store_page(folio, index, objcg, pool, &compres=
sed_bytes))
> +                       goto put_pool;
> +       }
> +
> +       /*
> +        * All pages in the folio have been successfully stored.
> +        * Batch update the cgroup zswap charging, zswap_stored_page atom=
ic,
> +        * and ZSWPOUT event stats.
> +        */

This comment seems unnecessary.

> +       if (objcg) {
> +               obj_cgroup_charge_zswap(objcg, compressed_bytes);
> +               count_objcg_events(objcg, ZSWPOUT, nr_pages);
> +       }
> +
> +       /* update stats */

Please delete this comment too.

> +       atomic_long_add(nr_pages, &zswap_stored_pages);
> +       count_vm_events(ZSWPOUT, nr_pages);
> +
> +       ret =3D true;
> +
> +put_pool:
> +       zswap_pool_put(pool);
> +put_objcg:
> +       obj_cgroup_put(objcg);
> +reject:
> +       /*
> +        * If the zswap store fails or zswap is disabled, we must invalid=
ate
> +        * the possibly stale entries which were previously stored at the
> +        * offsets corresponding to each page of the folio. Otherwise,
> +        * writeback could overwrite the new data in the swapfile.
> +        */
> +       if (!ret) {
> +               struct zswap_entry *entry;
> +               long i;
> +
> +               for (i =3D 0; i < nr_pages; ++i) {

Just reuse 'index' here.

> +                       entry =3D xa_erase(tree, offset + i);
> +                       if (entry)
> +                               zswap_entry_free(entry);

I think we need a comment in zswap_store_page() that we shouldn't have
any possibility of failure after the entry is added in the tree.
Otherwise we may duplicate the cleanup work here (e.g. putting refs).
This is already the case in zswap_store(), but it's now more subtle
and easier to break when the code is split and we have two cleanup
paths.

> +               }
> +
> +               if (zswap_pool_reached_full)
> +                       queue_work(shrink_wq, &zswap_shrink_work);

We are now doing this check even when zswap is disabled. I think this
is a problem.

If zswap gets disabled while 'zswap_pool_reached_full' is true, we
will queue 'zswap_shrink_work' every time zswap_store() is called in
the swapout path, but 'zswap_pool_reached_full' will never become
false again become zswap_check_limits() will never be called.

I think we need to maintain two separate "reject" and "check_old"
labels, and avoid this check when zswap is disabled.

> +       }
> +
> +       return ret;
>  }
>
>  bool zswap_load(struct folio *folio)
> --
> 2.27.0
>

