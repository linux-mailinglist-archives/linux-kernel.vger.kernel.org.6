Return-Path: <linux-kernel+bounces-337547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56868984B91
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 21:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 191BE283F3F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 19:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0427A149DE8;
	Tue, 24 Sep 2024 19:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F21u48Ob"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6AF84E11
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 19:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727206178; cv=none; b=cW5qjGJ+RRL5HCxKTx+9cuxz5q4PRCwYSv4SFpoJ2GqPUh/OPrDpBTlJyz05r/X80KMFqne4wJZ0GL82pPBE+rnv2qq29YD6HRHkkX2EPGPJAXa76ido2Tv4gkPBRMuLOeOmi+ErAPjf7HpUp++dCUm7AeL6MYBVJfYS07tBBYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727206178; c=relaxed/simple;
	bh=KiiB1/HRHoW34yH5czQBzOwoSm+s3eCc8u+fguOW7OI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K6ajhY1qbIOqoIAq2ES7DSAuh2EZ0eL7TLZycTKB6FSmyikp2o6hMG0z1/E9+iJav86WNcQlQ2dLDvI+OTYIxjJiD5qBRCI2b9iPDVNOsKL7FLLYP1R5JoMSNAwv4hbWYJ1YYvf4yf3a3H3z0g9WKl8cfv4GCIYCPUEfYT+aoOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F21u48Ob; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8d0d0aea3cso789223566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727206175; x=1727810975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4BOssAkuAwRClHbE2/wt4tNf3MQbxCJfkDCUpoY7D8=;
        b=F21u48ObFfgS43RoQPBjJO6Ne4aWAW0Sslu0RIoUQpVjn/O0bWV1hHgohNLlYs8xd1
         3Oc6o/NrmwBCrY7XHAT5dolr2h/WOZdROpblXqzAHO9rnuPFICH6AjR7k2/8ZnEgGtJR
         51lAM76oD9jwhGaPUJkLurJZhtHhUtAHYomCJZbB7cjAV1ka7QAG8ITcX9OvkPOoaPXT
         P/cVP62YxYvfyOkJjpSay8PcNpBuGhn7kwqjQwn7RzIttOQQyaRluGWzxCy4RLo7lU2T
         tEMfQdqns4Bcvwc4sVWr41kOPXMqPkq0UV1S30GyYUJvHO7FyZ33I/97g7IrT85v2Dtc
         e6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727206175; x=1727810975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4BOssAkuAwRClHbE2/wt4tNf3MQbxCJfkDCUpoY7D8=;
        b=c4Xv3d4U2qo6NAcOxexeiQMl8wTS5PRmEHdvpfT25x4hDIBAbRjAiLehWTpuZ5F5ml
         MQ7/74GttZuVdyPfmMFsggvHJoKmOEhOxpzhYge0fSk1OsgO0Y+ZuD/KIdGa1ewmHiJA
         sIwP4D1IktiC0kJy2WVfDBMipbrhy9lsxhoOUJDnCfo5+0BOKSp/AlbsQhOBE+X2NoBM
         UAWYgbqn8xLjuBgacTUnfWpXl3lBfuNvFLNrbNLXTojX4RSREQpWTHdQOf1JUEX6BQ1F
         LMG4HQe/ivABS4nip/9ZkneIp3lEeDdrgqFeOSZs5WOGIcSd5TwRPfza3Pxry5ILjHd8
         BfkA==
X-Gm-Message-State: AOJu0Yy9/zLunZebWnGolxkUUFQkWxwqY2aljH82SQsvNG8l4Qdkijyx
	fTYD0XFm21KT60qpZcrZV+XmI0C+dobV/9DOISyiGH0LLD8ngY8Sb9P6/pYYh55cvUwydhVBT4t
	gRRfHmliX1v4NnBuw3iXN04muife5sNir3wy+
X-Google-Smtp-Source: AGHT+IGUaF1f8l78cUoq8isSds5CUzjips4/fROPPKTW6dYdtdbT1H31ZkBg7fwXhKSlWwGHs9iRfpoMpsWInM+/zqg=
X-Received: by 2002:a17:907:eaa:b0:a8a:9054:8399 with SMTP id
 a640c23a62f3a-a93a03adfe1mr23906666b.27.1727206174479; Tue, 24 Sep 2024
 12:29:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com> <20240924011709.7037-6-kanchana.p.sridhar@intel.com>
In-Reply-To: <20240924011709.7037-6-kanchana.p.sridhar@intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 24 Sep 2024 12:28:57 -0700
Message-ID: <CAJD7tkacF3hCXiZHy7_+E7xmdojnsUewDeP=BsamcZReHxCTtg@mail.gmail.com>
Subject: Re: [PATCH v7 5/8] mm: zswap: Compress and store a specific page in a folio.
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
> For zswap_store() to handle mTHP folios, we need to iterate through each
> page in the mTHP, compress it and store it in the zswap pool. This patch
> introduces an auxiliary function zswap_store_page() that provides this
> functionality.
>
> The function signature reflects the design intent, namely, for it
> to be invoked by zswap_store() per-page in an mTHP. Hence, the folio's
> objcg and the zswap_pool to use are input parameters for sake of
> efficiency and consistency.
>
> The functionality in zswap_store_page() is reused and adapted from
> Ryan Roberts' RFC patch [1]:
>
>   "[RFC,v1] mm: zswap: Store large folios without splitting"
>
>   [1] https://lore.kernel.org/linux-mm/20231019110543.3284654-1-ryan.robe=
rts@arm.com/T/#u
>
> Co-developed-by: Ryan Roberts
> Signed-off-by:
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> ---
>  mm/zswap.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 9bea948d653e..8f2e0ab34c84 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1463,6 +1463,94 @@ static void zswap_delete_stored_offsets(struct xar=
ray *tree,
>         }
>  }
>
> +/*
> + * Stores the page at specified "index" in a folio.
> + *
> + * @folio: The folio to store in zswap.
> + * @index: Index into the page in the folio that this function will stor=
e.
> + * @objcg: The folio's objcg.
> + * @pool:  The zswap_pool to store the compressed data for the page.
> + */
> +static bool __maybe_unused zswap_store_page(struct folio *folio, long in=
dex,
> +                                           struct obj_cgroup *objcg,
> +                                           struct zswap_pool *pool)

Why are we adding an unused function that duplicates code in
zswap_store(), then using it in the following patch? This makes it
difficult to see that the function does the same thing. This patch
should be refactoring the per-page code out of zswap_store() into
zswap_store_page(), and directly calling zswap_store_page() from
zswap_store().

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
> +
> +       if (zswap_check_limits())
> +               goto reject;
> +
> +       /* allocate entry */
> +       entry =3D zswap_entry_cache_alloc(GFP_KERNEL, folio_nid(folio));
> +       if (!entry) {
> +               zswap_reject_kmemcache_fail++;
> +               goto reject;
> +       }
> +
> +       /* if entry is successfully added, it keeps the reference */
> +       if (!zswap_pool_get(pool))
> +               goto freepage;

I think we can batch this for all pages in zswap_store(), maybe first
add zswap_pool_get_many().

I am also wondering if it would be better to batch the limit checking
and allocating the entries, to front load any failures before we start
compression. Not sure if that's overall better though.

To batch allocate entries we will have to also allocate an array to
hold them. To batch the limit checking we will have to either allow
going further over limit for mTHPs, or check if there is enough
clearance to allow for compressing all the pages. Using the
uncompressed size will lead to false negatives though, so maybe we can
start tracking the average compression ratio for better limit
checking.

Nhat, Johannes, any thoughts here? I need someone to tell me if I am
overthinking this :)

> +
> +       entry->pool =3D pool;
> +
> +       if (!zswap_compress(page, entry))
> +               goto put_pool;
> +
> +       entry->swpentry =3D swp_entry(type, offset);
> +       entry->objcg =3D objcg;
> +       entry->referenced =3D true;
> +
> +       if (!zswap_store_entry(tree, entry))
> +               goto store_failed;
> +
> +       if (objcg) {
> +               obj_cgroup_charge_zswap(objcg, entry->length);
> +               count_objcg_event(objcg, ZSWPOUT);
> +       }
> +
> +       /*
> +        * We finish initializing the entry while it's already in xarray.
> +        * This is safe because:
> +        *
> +        * 1. Concurrent stores and invalidations are excluded by folio l=
ock.
> +        *
> +        * 2. Writeback is excluded by the entry not being on the LRU yet=
.
> +        *    The publishing order matters to prevent writeback from seei=
ng
> +        *    an incoherent entry.
> +        */
> +       if (entry->length) {
> +               INIT_LIST_HEAD(&entry->lru);
> +               zswap_lru_add(&zswap_list_lru, entry);
> +       }
> +
> +       /* update stats */
> +       atomic_inc(&zswap_stored_pages);
> +       count_vm_event(ZSWPOUT);

We should probably also batch updating the stats. It actually seems
like now we don't handle rolling them back upon failure.


> +
> +       return true;
> +
> +store_failed:
> +       zpool_free(entry->pool->zpool, entry->handle);
> +put_pool:
> +       zswap_pool_put(pool);
> +freepage:
> +       zswap_entry_cache_free(entry);
> +reject:
> +       obj_cgroup_put(objcg);
> +       if (zswap_pool_reached_full)
> +               queue_work(shrink_wq, &zswap_shrink_work);
> +
> +       return false;
> +}
> +
>  bool zswap_store(struct folio *folio)
>  {
>         long nr_pages =3D folio_nr_pages(folio);
> --
> 2.27.0
>

