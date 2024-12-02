Return-Path: <linux-kernel+bounces-428267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F919E0C35
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55A43282A9B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C801DE884;
	Mon,  2 Dec 2024 19:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0QS8MVaz"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED261DBB36
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 19:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733168071; cv=none; b=TDpea2feeA2u1qyLRmqT7KaPLkLw0b8MV28VptNX4aPf+yKaHK/zxtXxpbK+w6m+0GMxJSNlMqWLK0LXf9C6ur6EaOzxigWGplRfbJWljWQu25+vt7oAw1BEDUNngvhpJUpUchuZzuB7ILVsvr7nGcK2zznv5IKhQSHA9XcQ2Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733168071; c=relaxed/simple;
	bh=GcrVcFtup5Chadx9wlqf6FeK+RbHrvlrnkI6ai0m6T0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sUT34tttHSY5iysx3faimGEto5Nkiz6imCOC00avGdojGAwxMZvnEsge0emPZIWpTSVfjM0gsiYVnbDYHb+as+9eG6BYNJxLJu+L9m4yKoBRxsl9YR7QdUipkMktSLPI5mGnAGgqShHjlBXQQlo0oX4XvvanNShLVA3ROxQG9g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0QS8MVaz; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3ea5a7a5e48so2158842b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 11:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733168068; x=1733772868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uiyiz80ESC4vZ8IK2v5FDLx2PlcNaf/VwX618n4FUPE=;
        b=0QS8MVazjKh0LCUkwshdX6oMoQQZNGvlwQ/CEfSFDZ7Ew1AkrsEUzbcq2oExKowzty
         zThoZIHJn7fxTWY2PbCuSUvaSh3ULWHkwawgXW5RlNes2YQLAdbg1Nywef57+mkWydjA
         9/Bze94oTBl0EGaxpQyoDZBrZXvvU9ZGo8rovTDgLtWV/inVcyKtwwtlOg+k75M3Zsri
         bGlq5mMYKDYYNLdFwGjRK+z9DgBrZtiRzMLnlro7xcDOrkhybg/WakmLX812Ma0p5D5d
         CvF1Axuas45S4BE0KoX1o1KXBMViaWYrT+fXomPAdtX5ekTblMSsdapPEcDNSa5/SW9v
         IENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733168068; x=1733772868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uiyiz80ESC4vZ8IK2v5FDLx2PlcNaf/VwX618n4FUPE=;
        b=WWa1kd7L3lKTHuQdfBxav7H3r1SNFS42kHZsV9lUWhjvgrrrk8mQvgkrchZSVT/cs6
         VB51KC+magSogBgSZ9jZ4pk0jSxb+DBA3bUmqGEZg1nPmspyYSqD2J73xTrwhCBHi2JV
         i1BWySoaoFeDRr1DZuKblurRpoTmG8ndSkhL49C5McMqGwwM0U/Z0NWwvQj62fcZN5bw
         kPSc1qNOqtG1CD6DZno14tRmrbXgnR5hSs6IkltKh6CvFThVXZe9IOnNdvTiLZHqOjel
         F90PzmqGe2Mze2Jf0d4KhDE1jd2B6/SUSJZditi8O05SNA1XcYYI9peFB8bQC/4kdN92
         YYrw==
X-Gm-Message-State: AOJu0Yy3px2PGilgPpaSe0COMF3ZQ7KOmj7xE3BT2ZYviPMWBc0lgLSk
	w/9PW60ZRzudX5p4cgYeRBsMA48DgGLLR02xoF/ma2AActSshIbxvYYX46Z9q1TcfaKQizXLRdS
	h3Lzb+l/yVev+lPs9qNe60A7T/8WclWcrZzqb
X-Gm-Gg: ASbGnct2MjZCwD+TiJS7ToFTPFhbpPsZjrqyNT7IIhz1KFyYl/ur+TwscjUxGZhi/nn
	7Kb5UOiq3Zb4X/DCweXkZQ4yDqESu
X-Google-Smtp-Source: AGHT+IGGI8g8ewmbrMxXErj4uwLi6IbwzhzBJpnlRWbhdc+GYm9qHmPPswp49Euo4v1tqdwQHREP3F054TW2GM7Cmv4=
X-Received: by 2002:a05:6808:1a28:b0:3ea:5413:1a24 with SMTP id
 5614622812f47-3ea6dbcea00mr20710021b6e.13.1733168068046; Mon, 02 Dec 2024
 11:34:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127225324.6770-1-kanchana.p.sridhar@intel.com> <20241127225324.6770-2-kanchana.p.sridhar@intel.com>
In-Reply-To: <20241127225324.6770-2-kanchana.p.sridhar@intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 2 Dec 2024 11:33:51 -0800
Message-ID: <CAJD7tkYZSWL9WQ9X9UMLNTbDcF0hX=t90Ouf22WWHrcUvXyPRg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mm: zswap: Modified zswap_store_page() to process
 multiple pages in a folio.
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, usamaarif642@gmail.com, 
	ryan.roberts@arm.com, 21cnbao@gmail.com, akpm@linux-foundation.org, 
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 2:53=E2=80=AFPM Kanchana P Sridhar
<kanchana.p.sridhar@intel.com> wrote:
>
> Modified zswap_store() to store the folio in batches of
> SWAP_CRYPTO_BATCH_SIZE pages. Accordingly, refactored zswap_store_page()
> into zswap_store_pages() that processes a range of pages in the folio.
> zswap_store_pages() is a vectorized version of zswap_store_page().
>
> For now, zswap_store_pages() will sequentially compress these pages with
> zswap_compress().
>
> These changes are follow-up to code review comments received for [1], and
> are intended to set up zswap_store() for batching with Intel IAA.
>
> [1]: https://patchwork.kernel.org/project/linux-mm/patch/20241123070127.3=
32773-11-kanchana.p.sridhar@intel.com/
>
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> ---
>  include/linux/zswap.h |   1 +
>  mm/zswap.c            | 154 ++++++++++++++++++++++++------------------
>  2 files changed, 88 insertions(+), 67 deletions(-)
>
> diff --git a/include/linux/zswap.h b/include/linux/zswap.h
> index d961ead91bf1..05a81e750744 100644
> --- a/include/linux/zswap.h
> +++ b/include/linux/zswap.h
> @@ -7,6 +7,7 @@
>
>  struct lruvec;
>
> +#define SWAP_CRYPTO_BATCH_SIZE 8UL
>  extern atomic_long_t zswap_stored_pages;
>
>  #ifdef CONFIG_ZSWAP
> diff --git a/mm/zswap.c b/mm/zswap.c
> index f6316b66fb23..b09d1023e775 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1409,78 +1409,96 @@ static void shrink_worker(struct work_struct *w)
>  * main API
>  **********************************/
>
> -static ssize_t zswap_store_page(struct page *page,
> -                               struct obj_cgroup *objcg,
> -                               struct zswap_pool *pool)
> +/*
> + * Store multiple pages in @folio, starting from the page at index @si u=
p to
> + * and including the page at index @ei.
> + */
> +static ssize_t zswap_store_pages(struct folio *folio,
> +                                long si,
> +                                long ei,
> +                                struct obj_cgroup *objcg,
> +                                struct zswap_pool *pool)
>  {
> -       swp_entry_t page_swpentry =3D page_swap_entry(page);
> +       struct page *page;
> +       swp_entry_t page_swpentry;
>         struct zswap_entry *entry, *old;
> +       size_t compressed_bytes =3D 0;
> +       u8 nr_pages =3D ei - si + 1;
> +       u8 i;
> +
> +       for (i =3D 0; i < nr_pages; ++i) {
> +               page =3D folio_page(folio, si + i);
> +               page_swpentry =3D page_swap_entry(page);
> +
> +               /* allocate entry */
> +               entry =3D zswap_entry_cache_alloc(GFP_KERNEL, page_to_nid=
(page));
> +               if (!entry) {
> +                       zswap_reject_kmemcache_fail++;
> +                       return -EINVAL;
> +               }

I think this patch is wrong on its own, for example if an allocation
fails in the above loop we exit without cleaning up previous
allocations. I think it's fixed in patch 2 but we cannot introduce
bugs in-between patches. I think the helpers in patch 2 don't really
help as I mentioned. Please combine the changes and keep them in the
main series (unless you have a reason not to).

>
> -       /* allocate entry */
> -       entry =3D zswap_entry_cache_alloc(GFP_KERNEL, page_to_nid(page));
> -       if (!entry) {
> -               zswap_reject_kmemcache_fail++;
> -               return -EINVAL;
> -       }
> -
> -       if (!zswap_compress(page, entry, pool))
> -               goto compress_failed;
> +               if (!zswap_compress(page, entry, pool))
> +                       goto compress_failed;
>
> -       old =3D xa_store(swap_zswap_tree(page_swpentry),
> -                      swp_offset(page_swpentry),
> -                      entry, GFP_KERNEL);
> -       if (xa_is_err(old)) {
> -               int err =3D xa_err(old);
> +               old =3D xa_store(swap_zswap_tree(page_swpentry),
> +                              swp_offset(page_swpentry),
> +                              entry, GFP_KERNEL);
> +               if (xa_is_err(old)) {
> +                       int err =3D xa_err(old);
>
> -               WARN_ONCE(err !=3D -ENOMEM, "unexpected xarray error: %d\=
n", err);
> -               zswap_reject_alloc_fail++;
> -               goto store_failed;
> -       }
> +                       WARN_ONCE(err !=3D -ENOMEM, "unexpected xarray er=
ror: %d\n", err);
> +                       zswap_reject_alloc_fail++;
> +                       goto store_failed;
> +               }
>
> -       /*
> -        * We may have had an existing entry that became stale when
> -        * the folio was redirtied and now the new version is being
> -        * swapped out. Get rid of the old.
> -        */
> -       if (old)
> -               zswap_entry_free(old);
> +               /*
> +                * We may have had an existing entry that became stale wh=
en
> +                * the folio was redirtied and now the new version is bei=
ng
> +                * swapped out. Get rid of the old.
> +                */
> +               if (old)
> +                       zswap_entry_free(old);
>
> -       /*
> -        * The entry is successfully compressed and stored in the tree, t=
here is
> -        * no further possibility of failure. Grab refs to the pool and o=
bjcg.
> -        * These refs will be dropped by zswap_entry_free() when the entr=
y is
> -        * removed from the tree.
> -        */
> -       zswap_pool_get(pool);
> -       if (objcg)
> -               obj_cgroup_get(objcg);
> +               /*
> +                * The entry is successfully compressed and stored in the=
 tree, there is
> +                * no further possibility of failure. Grab refs to the po=
ol and objcg.
> +                * These refs will be dropped by zswap_entry_free() when =
the entry is
> +                * removed from the tree.
> +                */
> +               zswap_pool_get(pool);
> +               if (objcg)
> +                       obj_cgroup_get(objcg);
>
> -       /*
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
> -        */
> -       entry->pool =3D pool;
> -       entry->swpentry =3D page_swpentry;
> -       entry->objcg =3D objcg;
> -       entry->referenced =3D true;
> -       if (entry->length) {
> -               INIT_LIST_HEAD(&entry->lru);
> -               zswap_lru_add(&zswap_list_lru, entry);
> -       }
> +               /*
> +                * We finish initializing the entry while it's already in=
 xarray.
> +                * This is safe because:
> +                *
> +                * 1. Concurrent stores and invalidations are excluded by=
 folio lock.
> +                *
> +                * 2. Writeback is excluded by the entry not being on the=
 LRU yet.
> +                *    The publishing order matters to prevent writeback f=
rom seeing
> +                *    an incoherent entry.
> +                */
> +               entry->pool =3D pool;
> +               entry->swpentry =3D page_swpentry;
> +               entry->objcg =3D objcg;
> +               entry->referenced =3D true;
> +               if (entry->length) {
> +                       INIT_LIST_HEAD(&entry->lru);
> +                       zswap_lru_add(&zswap_list_lru, entry);
> +               }
>
> -       return entry->length;
> +               compressed_bytes +=3D entry->length;
> +               continue;
>
>  store_failed:
> -       zpool_free(pool->zpool, entry->handle);
> +               zpool_free(pool->zpool, entry->handle);
>  compress_failed:
> -       zswap_entry_cache_free(entry);
> -       return -EINVAL;
> +               zswap_entry_cache_free(entry);
> +               return -EINVAL;
> +       }
> +
> +       return compressed_bytes;
>  }
>
>  bool zswap_store(struct folio *folio)
> @@ -1492,7 +1510,7 @@ bool zswap_store(struct folio *folio)
>         struct zswap_pool *pool;
>         size_t compressed_bytes =3D 0;
>         bool ret =3D false;
> -       long index;
> +       long si, ei, incr =3D SWAP_CRYPTO_BATCH_SIZE;
>
>         VM_WARN_ON_ONCE(!folio_test_locked(folio));
>         VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> @@ -1526,11 +1544,13 @@ bool zswap_store(struct folio *folio)
>                 mem_cgroup_put(memcg);
>         }
>
> -       for (index =3D 0; index < nr_pages; ++index) {
> -               struct page *page =3D folio_page(folio, index);
> +       /* Store the folio in batches of SWAP_CRYPTO_BATCH_SIZE pages. */
> +       for (si =3D 0, ei =3D min(si + incr - 1, nr_pages - 1);
> +            ((si < nr_pages) && (ei < nr_pages));
> +            si =3D ei + 1, ei =3D min(si + incr - 1, nr_pages - 1)) {
>                 ssize_t bytes;
>
> -               bytes =3D zswap_store_page(page, objcg, pool);
> +               bytes =3D zswap_store_pages(folio, si, ei, objcg, pool);
>                 if (bytes < 0)
>                         goto put_pool;
>                 compressed_bytes +=3D bytes;
> @@ -1565,9 +1585,9 @@ bool zswap_store(struct folio *folio)
>                 struct zswap_entry *entry;
>                 struct xarray *tree;
>
> -               for (index =3D 0; index < nr_pages; ++index) {
> -                       tree =3D swap_zswap_tree(swp_entry(type, offset +=
 index));
> -                       entry =3D xa_erase(tree, offset + index);
> +               for (si =3D 0; si < nr_pages; ++si) {
> +                       tree =3D swap_zswap_tree(swp_entry(type, offset +=
 si));
> +                       entry =3D xa_erase(tree, offset + si);
>                         if (entry)
>                                 zswap_entry_free(entry);
>                 }
> --
> 2.27.0
>

