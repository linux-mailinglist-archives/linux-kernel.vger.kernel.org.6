Return-Path: <linux-kernel+bounces-344961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5258F98B0A5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7A1A1F22E4A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4351898E6;
	Mon, 30 Sep 2024 23:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2LcHx94"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3A7189511
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727737896; cv=none; b=k+AaNBSbt3snrS7sIkU9MUT/QsW+RNs1PWv5yiUbiNGWah8XztZflLib+pXPqsh92nqJpNsY+RgdhTFwK+/3xVqDDP2Xw6LMO3uJOvQKYSXuwFehfLSOr/jlwYBSn6JWFKJ6Phj9jUvqZ/b7L/6AvLng23HmfHrvVJvscxj0OAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727737896; c=relaxed/simple;
	bh=qZvLJWiuZnrkQ+xxFDcNlyv22UZ5W/pSHbwIRIrklKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aoxIrVsxKnOg3Dq3phlvQDmkYImcbZp8EpeZZmB9MVh5c8HgxR2rRAtdZ+ldlQ1YgW1pYItkY8RWrgYq4OCCRCN1dT76gjqTEL6h09e8uOHY/o3OjfBM6jZBLNg68HdEZeAXHDvI5VW1OzUCAEUQenBBAt73j4C0RPH2LvYxVGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2LcHx94; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a9aec89347so318585685a.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 16:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727737893; x=1728342693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bt1p6qi/avv3Z7JNtcGvm+YnEBXlYqUjxh3iCuxFEK4=;
        b=a2LcHx94raMTOIayYqd2idEWgrOyY9QI9slMsXQN4Yk/br3vPSWYwh4RQYqYDhy05+
         0uw9Dj1tUvIzGy8UxC0uHtIWb5Nge3V4/OZsKkt8BIfjebIBTFAq7pU0vaj0nR8oU7r2
         MFe7L+mpZnYM3IqZ0SoiVduB+VqFqlOeR6UqNo0CBbauyieeXPjwEfz8JWHh+CNcsNgB
         D5mpKDG17mYmG3URrGPFMSP8yFE59vw0cBeuCtjFq/KHCLZZYte+5nSH85e7l8M7SFmm
         H8cglpup/U0yI1bb35cgNS5LFSCfmRnJXbQc73dpvkAXzGUlTBm4ls2eDhqrZH/HAGOZ
         d8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727737893; x=1728342693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bt1p6qi/avv3Z7JNtcGvm+YnEBXlYqUjxh3iCuxFEK4=;
        b=nV9jji8I4hv5NEoHQJZ6VRu35yScVemDQ2gUpGl8fidLfiXEhJICkxqCNzrNmyUElw
         KjOP6HgDPtW0EaYd9REHAxNslXgAqB67VXvYiwa5mc5GKEDMNQhl6uN/07+H3nhgwwO8
         m6A7serePVCGLQwXdpanV9hc9OrWJpPr7gHBtAz9dEAemJh2IMXbvPv6/LVErF0ZzbSm
         MA8pcIx0OApIJgunzJhwNhOPlAbDphQDdtlH17DpYLicMPErhLqA6wM3+imZSL4fDOZU
         0b+L4tH0LcSC3/Xxav0biJme0itwsBnqqKBwZMu36mRdrz1zNBiUsveJwh/ay+69XhSD
         ZOfg==
X-Gm-Message-State: AOJu0Yy4UodtxfiFbRRyduvxB2cQru0Zt5kFlIOPEVZ4KM18rgg5VLUB
	yHQdvCFaIwQRtJel+5kQHHaLRcQGLpm30seDDMOOTJ7zX6In7bHxUEdI69knBiPQwFvtdotM75r
	68YyE1KW6DiA5Was62aidMXSUoIs=
X-Google-Smtp-Source: AGHT+IEZsCfg9FoV3ap/Q71ShaRhWDJAzq8H8/gftDicFSR8wkle3axkldA0oLqVhTU52iUKUH4ysSsEsc91Ico8dZg=
X-Received: by 2002:a05:620a:17ab:b0:7a9:c13d:6e5c with SMTP id
 af79cd13be357-7ae37852751mr1708462385a.29.1727737893167; Mon, 30 Sep 2024
 16:11:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930221221.6981-1-kanchana.p.sridhar@intel.com> <20240930221221.6981-7-kanchana.p.sridhar@intel.com>
In-Reply-To: <20240930221221.6981-7-kanchana.p.sridhar@intel.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 30 Sep 2024 16:11:22 -0700
Message-ID: <CAKEwX=Podz0XkX4=sutZk_nRTPy_aQ3JSVUZ9GNxPbX=t7R2kg@mail.gmail.com>
Subject: Re: [PATCH v9 6/7] mm: zswap: Support large folios in zswap_store().
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, chengming.zhou@linux.dev, usamaarif642@gmail.com, 
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

Should we also batch-get references to the pool as well? i.e add a
helper function:

/* The caller must already have a reference. */
static void zswap_pool_get_many(struct zswap_pool *pool, unsigned long nr)
{
       percpu_ref_get_many(&pool->ref, nr);
}

then do it in a fell swoop after you're done storing all individual subpage=
s
(near atomic_long_add(nr_pages, &zswap_stored_pages)).

Do double check that it is safe - I think it should be, since we have
the folio locked in swapcache, so there should not be any shenanigans
(for e.g no race with concurrent free or writeback).

Perhaps a fixlet suffices?

