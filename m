Return-Path: <linux-kernel+bounces-330201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9590979ADB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 07:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15E351F21D54
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 05:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21CA282FD;
	Mon, 16 Sep 2024 05:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGYPx2Gx"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED036FDC
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 05:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726466128; cv=none; b=p15GoKrnBfu56LCotvaItW91EQcSTNHMpZddcCUhR9IvZJ5dlAe+EgqvLhYVrlzTdPOL14dhUFuBH4XMnU6CPwS1PYFrqH18FHRf5mJl0qPpG+5AHyycs5EU4sdxH3U3jQxt7yQfsfGKCfHnrLR4BTDRF91FZfLVNlj0/MOsIgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726466128; c=relaxed/simple;
	bh=h7dxldhgIDDgX4INLNN4MX+9ZMW7ECx79WqS7mheTFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsbydvJPhkOs2au6cUZEb3U/D6C9rwX+k3eRqHFDXnhLOg83gD/e0cdxP8FvZ/HwkL8AkzulBhCxLkYJfxnzM09dQmeVkcS/7LLrCfBL2aqid9pZyy3MYyBrl7SV78z9zkFy8RC5peD8moZ01Qo8Cfg6fXcjm+xQlGKtoHUooyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGYPx2Gx; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-49bc7387371so1458267137.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 22:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726466124; x=1727070924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7gIVTNufQJvQZU2YDzVnL8sFceZakdJa7DXnawBzrw=;
        b=OGYPx2GxzrRkmdUfBbyD59elDQSeZWJ4PhIhDR+xtIkwg2sM+5v16CPs5BwYKRWvlV
         Sb8D8hJXsgbZ3yYp2Op+88MEqo6E0LVplYB2ezLGkh0yS/f/VSGA9lpwlEjAfSgyEOBq
         PcbiXXDpIyF1g55T3CdyEXCeyNXexf36ks2FmVVzndhytiZydpqXZ+sJPo/k23wN/EX+
         z4425Bb8Qx98Ea282LxpYf3tXwCCRkHdPKVUR3HF3Mbozw6Lp//yLG2pFaUGRCJgkK2x
         zR7x4VyYaRmT5fCz1/2YAGMctUvVf3C5vVKxj1Q04tgPEQvuW0Zlg8r+Xpde7btKyQEf
         NH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726466124; x=1727070924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7gIVTNufQJvQZU2YDzVnL8sFceZakdJa7DXnawBzrw=;
        b=wpF46oMqlC2m+ONqWhNrf5gJV08gPggk2xe3lWctyBZOwZg7IFuGik7AYBHi/1P/6w
         lONwf0llrKAwzSmmTUk/bRZcWM1sSuLq6oDvzi7doKWMX39vr7h8HlA/czTcdMv34Ana
         b+MhbULPfE1+u36pJtsSngPupx8qzYV6wh+0B29WVnQd7tYRQ8wEHok0/x2eo5eICr7S
         HekEg5ceE6ARA2TTIohqm5UZHOHGBqXqsmksuoBxSrF6d+kZZ6QGYiJ790qpCR6bqZqw
         us+8ZZTlVfWqW4eLI+ExWzLxNmGYi0f9E9fsCfeTLzXBlmvEljKydaRkqUExkRcYmVGL
         5R1Q==
X-Gm-Message-State: AOJu0Yypmg6Hf2bKWzdHjja2zcF7+EFPSCZrkoarxDFETsW8qJeEXwnV
	c7uLt9/4NI5JgG4iFhlOKoGzQy+TIOvaA6zu4JuPk+84dPfGtRX6CdVLE9Sqw3pYac7ZjdixjQu
	iZhnYhxa/a0UqZ2y0jQeoBeiykN4=
X-Google-Smtp-Source: AGHT+IGxqpqkALetrEi89MnxwSrjR72j4+MfLpbiorfbLk+AV9M+djvRBDGB7/nthan4w1ZzmJaRSFtANm5OTi3xFOY=
X-Received: by 2002:a05:6102:c8c:b0:49b:d12f:40b0 with SMTP id
 ada2fe7eead31-49d4146b2f8mr12865642137.1.1726466124534; Sun, 15 Sep 2024
 22:55:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829212705.6714-1-kanchana.p.sridhar@intel.com> <20240829212705.6714-3-kanchana.p.sridhar@intel.com>
In-Reply-To: <20240829212705.6714-3-kanchana.p.sridhar@intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 16 Sep 2024 13:55:13 +0800
Message-ID: <CAGsJ_4z4+1SQtPOa88ABFzUntrkxMy845OBvDLp4vpkgqynoXw@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] mm: zswap: zswap_store() extended to handle mTHP folios.
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, nphamcs@gmail.com, chengming.zhou@linux.dev, 
	usamaarif642@gmail.com, ryan.roberts@arm.com, ying.huang@intel.com, 
	akpm@linux-foundation.org, nanhai.zou@intel.com, wajdi.k.feghali@intel.com, 
	vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 5:27=E2=80=AFAM Kanchana P Sridhar
<kanchana.p.sridhar@intel.com> wrote:
>
> zswap_store() will now process and store mTHP and PMD-size THP folios.
>
> A new config variable CONFIG_ZSWAP_STORE_THP_DEFAULT_ON (off by default)
> will enable/disable zswap storing of (m)THP.
>
> This change reuses and adapts the functionality in Ryan Roberts' RFC
> patch [1]:
>
>   "[RFC,v1] mm: zswap: Store large folios without splitting"
>
>   [1] https://lore.kernel.org/linux-mm/20231019110543.3284654-1-ryan.robe=
rts@arm.com/T/#u
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
> of large folios, by compressing batches of up to say, 8 pages in an
> mTHP in parallel in hardware, with the Intel In-Memory Analytics
> Accelerator (Intel IAA).

Hi Kanchana,
I'm not opposed to this patch, but I don't understand how iterating
through each page within an mTHP supports the use of Intel IAA,
as it involves compressing pages individually.

In the document 'by_n compression and decompression with Intel IAA' by
Andre Glover
(https://lore.kernel.org/all/cover.1714581792.git.andre.glover@linux.intel.=
com),
it appears
that zsmalloc/zram needs to support multi-page compression and
decompression to fully
leverage the hardware's capabilities. Could you clarify how this
approach fits in?

In patch2/3 of that series, you have:
"Add the 'by_n' attribute to the acomp_req. The 'by_n' attribute can be
used a directive by acomp crypto algorithms for splitting compress and
decompress operations into "n" separate jobs."

How can you apply 'by_n' to a single page rather than to a large folio?

>
> Also, addressed some of the RFC comments from the discussion in [1].
>
> Made a minor edit in the comments for "struct zswap_entry" to delete
> the comments related to "value" since same-filled page handling has
> been removed from zswap.
>
> Co-developed-by: Ryan Roberts
> Signed-off-by:
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> ---
>  mm/Kconfig |   8 ++
>  mm/zswap.c | 243 +++++++++++++++++++++++++++++++++++++++--------------
>  2 files changed, 190 insertions(+), 61 deletions(-)
>
> diff --git a/mm/Kconfig b/mm/Kconfig
> index b23913d4e47e..68c7b01120bd 100644
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
> index 449914ea9919..3abf9810f0b7 100644
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
> @@ -190,7 +198,6 @@ static struct shrinker *zswap_shrinker;
>   *              section for context.
>   * pool - the zswap_pool the entry's data is in
>   * handle - zpool allocation handle that stores the compressed page data
> - * value - value of the same-value filled pages which have same content
>   * objcg - the obj_cgroup that the compressed memory is charged to
>   * lru - handle to the pool's lru used to evict pages.
>   */
> @@ -876,7 +883,7 @@ static int zswap_cpu_comp_dead(unsigned int cpu, stru=
ct hlist_node *node)
>         return 0;
>  }
>
> -static bool zswap_compress(struct folio *folio, struct zswap_entry *entr=
y)
> +static bool zswap_compress(struct page *page, struct zswap_entry *entry)
>  {
>         struct crypto_acomp_ctx *acomp_ctx;
>         struct scatterlist input, output;
> @@ -894,7 +901,7 @@ static bool zswap_compress(struct folio *folio, struc=
t zswap_entry *entry)
>
>         dst =3D acomp_ctx->buffer;
>         sg_init_table(&input, 1);
> -       sg_set_folio(&input, folio, PAGE_SIZE, 0);
> +       sg_set_page(&input, page, PAGE_SIZE, 0);
>
>         /*
>          * We need PAGE_SIZE * 2 here since there maybe over-compression =
case,
> @@ -1404,35 +1411,82 @@ static void shrink_worker(struct work_struct *w)
>  /*********************************
>  * main API
>  **********************************/
> -bool zswap_store(struct folio *folio)
> +
> +/*
> + * Returns true if the entry was successfully
> + * stored in the xarray, and false otherwise.
> + */
> +static bool zswap_store_entry(struct xarray *tree,
> +                             struct zswap_entry *entry)
>  {
> -       swp_entry_t swp =3D folio->swap;
> -       pgoff_t offset =3D swp_offset(swp);
> -       struct xarray *tree =3D swap_zswap_tree(swp);
> -       struct zswap_entry *entry, *old;
> -       struct obj_cgroup *objcg =3D NULL;
> -       struct mem_cgroup *memcg =3D NULL;
> +       struct zswap_entry *old;
> +       pgoff_t offset =3D swp_offset(entry->swpentry);
>
> -       VM_WARN_ON_ONCE(!folio_test_locked(folio));
> -       VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> +       old =3D xa_store(tree, offset, entry, GFP_KERNEL);
>
> -       /* Large folios aren't supported */
> -       if (folio_test_large(folio))
> +       if (xa_is_err(old)) {
> +               int err =3D xa_err(old);
> +
> +               WARN_ONCE(err !=3D -ENOMEM, "unexpected xarray error: %d\=
n", err);
> +               zswap_reject_alloc_fail++;
>                 return false;
> +       }
>
> -       if (!zswap_enabled)
> -               goto check_old;
> +       /*
> +        * We may have had an existing entry that became stale when
> +        * the folio was redirtied and now the new version is being
> +        * swapped out. Get rid of the old.
> +        */
> +       if (old)
> +               zswap_entry_free(old);
>
> -       /* Check cgroup limits */
> -       objcg =3D get_obj_cgroup_from_folio(folio);
> -       if (objcg && !obj_cgroup_may_zswap(objcg)) {
> -               memcg =3D get_mem_cgroup_from_objcg(objcg);
> -               if (shrink_memcg(memcg)) {
> -                       mem_cgroup_put(memcg);
> -                       goto reject;
> -               }
> -               mem_cgroup_put(memcg);
> +       return true;
> +}
> +
> +/*
> + * If the zswap store fails or zswap is disabled, we must invalidate the
> + * possibly stale entries which were previously stored at the offsets
> + * corresponding to each page of the folio. Otherwise, writeback could
> + * overwrite the new data in the swapfile.
> + *
> + * This is called after the store of the i-th offset in a large folio ha=
s
> + * failed. All zswap entries in the folio must be deleted. This helps ma=
ke
> + * sure that a swapped-out mTHP is either entirely stored in zswap, or
> + * entirely not stored in zswap.
> + *
> + * This is also called if zswap_store() is invoked, but zswap is not ena=
bled.
> + * All offsets for the folio are deleted from zswap in this case.
> + */
> +static void zswap_delete_stored_offsets(struct xarray *tree,
> +                                       pgoff_t offset,
> +                                       long nr_pages)
> +{
> +       struct zswap_entry *entry;
> +       long i;
> +
> +       for (i =3D 0; i < nr_pages; ++i) {
> +               entry =3D xa_erase(tree, offset + i);
> +               if (entry)
> +                       zswap_entry_free(entry);
>         }
> +}
> +
> +/*
> + * Stores the page at specified "index" in a folio.
> + */
> +static bool zswap_store_page(struct folio *folio, long index,
> +                            struct obj_cgroup *objcg,
> +                            struct zswap_pool *pool)
> +{
> +       swp_entry_t swp =3D folio->swap;
> +       int type =3D swp_type(swp);
> +       pgoff_t offset =3D swp_offset(swp) + index;
> +       struct page *page =3D folio_page(folio, index);
> +       struct xarray *tree =3D swap_zswap_tree(swp);
> +       struct zswap_entry *entry;
> +
> +       if (objcg)
> +               obj_cgroup_get(objcg);
>
>         if (zswap_check_limits())
>                 goto reject;
> @@ -1445,42 +1499,20 @@ bool zswap_store(struct folio *folio)
>         }
>
>         /* if entry is successfully added, it keeps the reference */
> -       entry->pool =3D zswap_pool_current_get();
> -       if (!entry->pool)
> +       if (!zswap_pool_get(pool))
>                 goto freepage;
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
> -       if (!zswap_compress(folio, entry))
> +       if (!zswap_compress(page, entry))
>                 goto put_pool;
>
> -       entry->swpentry =3D swp;
> +       entry->swpentry =3D swp_entry(type, offset);
>         entry->objcg =3D objcg;
>         entry->referenced =3D true;
>
> -       old =3D xa_store(tree, offset, entry, GFP_KERNEL);
> -       if (xa_is_err(old)) {
> -               int err =3D xa_err(old);
> -
> -               WARN_ONCE(err !=3D -ENOMEM, "unexpected xarray error: %d\=
n", err);
> -               zswap_reject_alloc_fail++;
> +       if (!zswap_store_entry(tree, entry))
>                 goto store_failed;
> -       }
> -
> -       /*
> -        * We may have had an existing entry that became stale when
> -        * the folio was redirtied and now the new version is being
> -        * swapped out. Get rid of the old.
> -        */
> -       if (old)
> -               zswap_entry_free(old);
>
>         if (objcg) {
>                 obj_cgroup_charge_zswap(objcg, entry->length);
> @@ -1511,23 +1543,112 @@ bool zswap_store(struct folio *folio)
>  store_failed:
>         zpool_free(entry->pool->zpool, entry->handle);
>  put_pool:
> -       zswap_pool_put(entry->pool);
> +       zswap_pool_put(pool);
>  freepage:
>         zswap_entry_cache_free(entry);
>  reject:
>         obj_cgroup_put(objcg);
>         if (zswap_pool_reached_full)
>                 queue_work(shrink_wq, &zswap_shrink_work);
> -check_old:
> +
> +       return false;
> +}
> +
> +/*
> + * Modified to store mTHP folios. Each page in the mTHP will be compress=
ed
> + * and stored sequentially.
> + */
> +bool zswap_store(struct folio *folio)
> +{
> +       long nr_pages =3D folio_nr_pages(folio);
> +       swp_entry_t swp =3D folio->swap;
> +       pgoff_t offset =3D swp_offset(swp);
> +       struct xarray *tree =3D swap_zswap_tree(swp);
> +       struct obj_cgroup *objcg =3D NULL;
> +       struct mem_cgroup *memcg =3D NULL;
> +       struct zswap_pool *pool;
> +       bool ret =3D false;
> +       long index;
> +
> +       VM_WARN_ON_ONCE(!folio_test_locked(folio));
> +       VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> +
> +       /* Storing large folios isn't enabled */
> +       if (!zswap_mthp_enabled && folio_test_large(folio))
> +               return false;
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
o store
> +        * a page, unwind by removing all the previous pages we stored.
> +        */
> +       for (index =3D 0; index < nr_pages; ++index) {
> +               if (!zswap_store_page(folio, index, objcg, pool))
> +                       goto put_pool;
> +       }
> +
> +       ret =3D true;
> +
> +put_pool:
> +       zswap_pool_put(pool);
> +put_objcg:
> +       obj_cgroup_put(objcg);
> +       if (zswap_pool_reached_full)
> +               queue_work(shrink_wq, &zswap_shrink_work);
> +reject:
> +       /*
> +        * If the zswap store fails or zswap is disabled, we must invalid=
ate
> +        * the possibly stale entries which were previously stored at the
> +        * offsets corresponding to each page of the folio. Otherwise,
> +        * writeback could overwrite the new data in the swapfile.
> +        */
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

Thanks
Barry

