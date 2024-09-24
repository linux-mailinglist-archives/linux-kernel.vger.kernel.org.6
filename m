Return-Path: <linux-kernel+bounces-337564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED801984BB5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 21:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DD431F23B32
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 19:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7486136328;
	Tue, 24 Sep 2024 19:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jVAYdkfW"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F3441760
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 19:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727206751; cv=none; b=lmuxhDXFw8Srta3B24aWWtlLKJC2nHBa4K+8WIOzW+buSJ/TYA7iKp7GqROoUZ35V1yxPZfqjjWNcwKD2NA5L5gdgL5Nx6Tw9nPClsI3lxIMlKUux83CnvpeJGJVsL3/zLXjEMxO0pE6IcCi5Zuv0NcWugRSv+TQWqVtgRINScE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727206751; c=relaxed/simple;
	bh=jdOAjNwuejRfCaTIsaldBhIql8GjrhGl17wrWNQf2GQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GeWBRTCnPg/mm902OJx8whBPISCJoQQ+JS0wBHRPeaheAjucUgj/2W5SvxQ2O3alHEsQmg/5QJSs/Q7KRLmo0oHZVyxPghq/LnfZ1T9svf8mGmZ50kvqPFkeWPTHPmcN4nGkS3kDD4P5JyH9sTYQ62xUzTAqIFfdBrUt8eO6qM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jVAYdkfW; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c24c92f699so5993807a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727206748; x=1727811548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtqiHAuCHLMytt38wF6iLI0wBR0Ju/JPn8h/2Oyi2VU=;
        b=jVAYdkfWc+DHtOIL6xDGBeSFUZxT66E6lwCdrVSg3RjNW1OzkC85dX3HKgYgr7sHNo
         VrMWUiGzMNxG3y1qi87QSwVvXsNlAnO+zZfdGlN/qhweYwfmc4+dak2ysl7x5/q5knTd
         pi77AqR0OeyI9mkbIvGh/0cC+RXC3MEra8w2v3sV65dUgc6StuXnSatp5HKyTqUSEZpa
         wd3jQg7rxkduAmS5wPUiv+YBifb91vA3nx5nc8knZLVwuZpicdLvywwF+SQJsbsKQCP9
         smDejaJ6nWFTOXSMmeKRpSub8S3H7aIpHlzV7Ltgq7WwBV6NKt9pmgPvms2VXZGJxD5/
         4tSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727206748; x=1727811548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EtqiHAuCHLMytt38wF6iLI0wBR0Ju/JPn8h/2Oyi2VU=;
        b=MSSrAB2FeVscrv7xOtOT0L5Wby0tmx1REzz5RfV6W3EoP4jraNcGSMRThRFBkFZvLG
         c99kUv2Kawk2HbOS171CdlGIUeD+TZCJeJLE0T9fRvvM3aYJtGIcxSJmJVwOWH6F/Tpb
         j25B5+G6IDLR56enW8hWyl824V/vn6lpJYFXle3KYto/chsPvVh2CxrXBTtH3zTnB0g/
         nkASMITjDXVxbgigpsas0AMDGrbI5P+8TJ+wk+5HJGRe+BaHW5q3gfSeMgye4kvh2W6+
         O/UqwpIKF/CP3QfWicQ72I2AtKJdx7lJoAaNsWzwqwzRrc+CVmXYxAuOyoiubmo1tFEg
         rvyg==
X-Gm-Message-State: AOJu0YyVT3n4YSVCGM25ogQlvAgKQFUCVumG3rL+Np7AXilNuA7CnAzh
	40LQ5JlGf3O6RJXUhi1iL1qNtDubAwqdj0JDjfXvabY5wKJAozpLWKpmY06v52MWJ/oS1/GyctE
	+PHcleNokW/Pq/3oXQ8spQ1jCaT9stmcc1WQm
X-Google-Smtp-Source: AGHT+IGn0R1QEn99UZ9WVWIpyRdJH8rqzL95g49Yztw8S4d+m3UM21Jf0yklrSBW6N8A6ZrvHMXVd9/sQA0NlcZoPzY=
X-Received: by 2002:a17:907:1c1f:b0:a8a:926a:d02a with SMTP id
 a640c23a62f3a-a93a05e7ea0mr29747666b.49.1727206747787; Tue, 24 Sep 2024
 12:39:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com> <20240924011709.7037-7-kanchana.p.sridhar@intel.com>
In-Reply-To: <20240924011709.7037-7-kanchana.p.sridhar@intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 24 Sep 2024 12:38:32 -0700
Message-ID: <CAJD7tkbd=H+=wx0gnu8sh44hOmx7BE3G3oSxi7zt+o3HKJthkA@mail.gmail.com>
Subject: Re: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, usamaarif642@gmail.com, 
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com, 
	21cnbao@gmail.com, akpm@linux-foundation.org, nanhai.zou@intel.com, 
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 6:17=E2=80=AFPM Kanchana P Sridhar
<kanchana.p.sridhar@intel.com> wrote:
>
> zswap_store() will now store mTHP and PMD-size THP folios by compressing
> them page by page.
>
> This patch provides a sequential implementation of storing an mTHP in
> zswap_store() by iterating through each page in the folio to compress
> and store it in the zswap zpool.
>
> Towards this goal, zswap_compress() is modified to take a page instead
> of a folio as input.
>
> Each page's swap offset is stored as a separate zswap entry.
>
> If an error is encountered during the store of any page in the mTHP,
> all previous pages/entries stored will be invalidated. Thus, an mTHP
> is either entirely stored in ZSWAP, or entirely not stored in ZSWAP.
>
> This forms the basis for building batching of pages during zswap store
> of large folios by compressing batches of up to say, 8 pages in an
> mTHP in parallel in hardware, with the Intel In-Memory Analytics
> Accelerator (Intel IAA).
>
> A new config variable CONFIG_ZSWAP_STORE_THP_DEFAULT_ON (off by default)
> will enable/disable zswap storing of (m)THP. The corresponding tunable
> zswap module parameter is "mthp_enabled".
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
>  mm/Kconfig |   8 ++++
>  mm/zswap.c | 122 +++++++++++++++++++++++++----------------------------
>  2 files changed, 66 insertions(+), 64 deletions(-)
>
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 09aebca1cae3..c659fb732ec4 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -59,6 +59,14 @@ config ZSWAP_SHRINKER_DEFAULT_ON
>           reducing the chance that cold pages will reside in the zswap po=
ol
>           and consume memory indefinitely.
>
> +config ZSWAP_STORE_THP_DEFAULT_ON
> +       bool "Store mTHP and THP folios in zswap"
> +       depends on ZSWAP
> +       default n
> +       help
> +         If selected, zswap will process mTHP and THP folios by
> +         compressing and storing each 4K page in the large folio.
> +
>  choice
>         prompt "Default compressor"
>         depends on ZSWAP
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 8f2e0ab34c84..16ab770546d6 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -127,6 +127,14 @@ static bool zswap_shrinker_enabled =3D IS_ENABLED(
>                 CONFIG_ZSWAP_SHRINKER_DEFAULT_ON);
>  module_param_named(shrinker_enabled, zswap_shrinker_enabled, bool, 0644)=
;
>
> +/*
> + * Enable/disable zswap processing of mTHP folios.
> + * For now, only zswap_store will process mTHP folios.
> + */
> +static bool zswap_mthp_enabled =3D IS_ENABLED(
> +               CONFIG_ZSWAP_STORE_THP_DEFAULT_ON);
> +module_param_named(mthp_enabled, zswap_mthp_enabled, bool, 0644);
> +
>  bool zswap_is_enabled(void)
>  {
>         return zswap_enabled;
> @@ -1471,9 +1479,9 @@ static void zswap_delete_stored_offsets(struct xarr=
ay *tree,
>   * @objcg: The folio's objcg.
>   * @pool:  The zswap_pool to store the compressed data for the page.
>   */
> -static bool __maybe_unused zswap_store_page(struct folio *folio, long in=
dex,
> -                                           struct obj_cgroup *objcg,
> -                                           struct zswap_pool *pool)
> +static bool zswap_store_page(struct folio *folio, long index,
> +                            struct obj_cgroup *objcg,
> +                            struct zswap_pool *pool)

As I mentioned earlier, the patch that introduced zswap_store_page()
should have directly used it in zswap_store(). This would make this
patch much clearer.

>  {
>         swp_entry_t swp =3D folio->swap;
>         int type =3D swp_type(swp);
> @@ -1551,51 +1559,63 @@ static bool __maybe_unused zswap_store_page(struc=
t folio *folio, long index,
>         return false;
>  }
>
> +/*
> + * Modified to store mTHP folios. Each page in the mTHP will be compress=
ed
> + * and stored sequentially.
> + */
>  bool zswap_store(struct folio *folio)
>  {
>         long nr_pages =3D folio_nr_pages(folio);
>         swp_entry_t swp =3D folio->swap;
>         pgoff_t offset =3D swp_offset(swp);
>         struct xarray *tree =3D swap_zswap_tree(swp);
> -       struct zswap_entry *entry;
>         struct obj_cgroup *objcg =3D NULL;
>         struct mem_cgroup *memcg =3D NULL;
> +       struct zswap_pool *pool;
> +       bool ret =3D false;
> +       long index;
>
>         VM_WARN_ON_ONCE(!folio_test_locked(folio));
>         VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
>
> -       /* Large folios aren't supported */
> -       if (folio_test_large(folio))
> +       /* Storing large folios isn't enabled */

The comment is now stating the obvious, please remove it.

> +       if (!zswap_mthp_enabled && folio_test_large(folio))
>                 return false;
>
>         if (!zswap_enabled)
> -               goto check_old;
> +               goto reject;
>
> -       /* Check cgroup limits */
> +       /*
> +        * Check cgroup limits:
> +        *
> +        * The cgroup zswap limit check is done once at the beginning of =
an
> +        * mTHP store, and not within zswap_store_page() for each page
> +        * in the mTHP. We do however check the zswap pool limits at the
> +        * start of zswap_store_page(). What this means is, the cgroup
> +        * could go over the limits by at most (HPAGE_PMD_NR - 1) pages.
> +        * However, the per-store-page zswap pool limits check should
> +        * hopefully trigger the cgroup aware and zswap LRU aware global
> +        * reclaim implemented in the shrinker. If this assumption holds,
> +        * the cgroup exceeding the zswap limits could potentially be
> +        * resolved before the next zswap_store, and if it is not, the ne=
xt
> +        * zswap_store would fail the cgroup zswap limit check at the sta=
rt.
> +        */

I do not really like this. Allowing going one page above the limit is
one thing, but one THP above the limit seems too much. I also don't
like relying on the repeated limit checking in zswap_store_page(), if
anything I think that should be batched too.

Is it too unreasonable to maintain the average compression ratio and
use that to estimate limit checking for both memcg and global limits?
Johannes, Nhat, any thoughts on this?

>         objcg =3D get_obj_cgroup_from_folio(folio);
>         if (objcg && !obj_cgroup_may_zswap(objcg)) {
>                 memcg =3D get_mem_cgroup_from_objcg(objcg);
>                 if (shrink_memcg(memcg)) {
>                         mem_cgroup_put(memcg);
> -                       goto reject;
> +                       goto put_objcg;
>                 }
>                 mem_cgroup_put(memcg);
>         }
>
>         if (zswap_check_limits())
> -               goto reject;
> -
> -       /* allocate entry */
> -       entry =3D zswap_entry_cache_alloc(GFP_KERNEL, folio_nid(folio));
> -       if (!entry) {
> -               zswap_reject_kmemcache_fail++;
> -               goto reject;
> -       }
> +               goto put_objcg;
>
> -       /* if entry is successfully added, it keeps the reference */
> -       entry->pool =3D zswap_pool_current_get();
> -       if (!entry->pool)
> -               goto freepage;
> +       pool =3D zswap_pool_current_get();
> +       if (!pool)
> +               goto put_objcg;
>
>         if (objcg) {
>                 memcg =3D get_mem_cgroup_from_objcg(objcg);
> @@ -1606,60 +1626,34 @@ bool zswap_store(struct folio *folio)
>                 mem_cgroup_put(memcg);
>         }
>
> -       if (!zswap_compress(&folio->page, entry))
> -               goto put_pool;
> -
> -       entry->swpentry =3D swp;
> -       entry->objcg =3D objcg;
> -       entry->referenced =3D true;
> -
> -       if (!zswap_store_entry(tree, entry))
> -               goto store_failed;
> -
> -       if (objcg) {
> -               obj_cgroup_charge_zswap(objcg, entry->length);
> -               count_objcg_event(objcg, ZSWPOUT);
> -       }
> -
>         /*
> -        * We finish initializing the entry while it's already in xarray.
> -        * This is safe because:
> -        *
> -        * 1. Concurrent stores and invalidations are excluded by folio l=
ock.
> -        *
> -        * 2. Writeback is excluded by the entry not being on the LRU yet=
.
> -        *    The publishing order matters to prevent writeback from seei=
ng
> -        *    an incoherent entry.
> +        * Store each page of the folio as a separate entry. If we fail t=
o store
> +        * a page, unwind by removing all the previous pages we stored.
>          */
> -       if (entry->length) {
> -               INIT_LIST_HEAD(&entry->lru);
> -               zswap_lru_add(&zswap_list_lru, entry);
> +       for (index =3D 0; index < nr_pages; ++index) {
> +               if (!zswap_store_page(folio, index, objcg, pool))
> +                       goto put_pool;
>         }
>
> -       /* update stats */
> -       atomic_inc(&zswap_stored_pages);
> -       count_vm_event(ZSWPOUT);
> -
> -       return true;
> +       ret =3D true;
>
> -store_failed:
> -       zpool_free(entry->pool->zpool, entry->handle);
>  put_pool:
> -       zswap_pool_put(entry->pool);
> -freepage:
> -       zswap_entry_cache_free(entry);
> -reject:
> +       zswap_pool_put(pool);
> +put_objcg:
>         obj_cgroup_put(objcg);
>         if (zswap_pool_reached_full)
>                 queue_work(shrink_wq, &zswap_shrink_work);
> -check_old:
> +reject:
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
> -       zswap_delete_stored_offsets(tree, offset, nr_pages);
> -       return false;
> +       if (!ret)
> +               zswap_delete_stored_offsets(tree, offset, nr_pages);
> +
> +       return ret;
>  }
>
>  bool zswap_load(struct folio *folio)
> --
> 2.27.0
>

