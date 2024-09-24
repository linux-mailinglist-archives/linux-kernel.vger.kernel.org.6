Return-Path: <linux-kernel+bounces-337456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA57984A54
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 19:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C20B0283D62
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4068E1AC426;
	Tue, 24 Sep 2024 17:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghuU1C3S"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B8A1DFFB
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 17:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727199227; cv=none; b=ki/FEOdjnHILfiOif5JIA9CbQzuEx0z+sLVM8gpWzqpNhLgzGe9PCUz+uD2XW/iKaVNxLr7087iuXBMlzMPUhF+gmnEC9EShX2EmaB57Kw5+12CSSWlHAZVbndo36x1CRDPNdqMutm0rLVSv3/mYAZgz8MvBcPAOJICY4rckEOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727199227; c=relaxed/simple;
	bh=F4x47MxSVZcEOSb9cK8a6LADtm6uY38XyTiC8YCjVek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cSGiPsSebCL84ia1fQt4YMUuVhXkuJXQ1WPQ38jwqGSXnGP7EckhzjmBQlaGXI1dcSy04Yv1TD5ihTpbHwWAWrtMgJSbvq9/zIJr6PM5pJv7cZ6/JqMhROnwlZyiGS/CeJiPInkNQKsJeX8I29+y0RI0n7qNpC/YAeJXCO7fToM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghuU1C3S; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6c35334dfb1so37788286d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 10:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727199225; x=1727804025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiwagejtmdEAMVRH9GY/YhmfCZ26zHU5MaB8DwQPKCU=;
        b=ghuU1C3SQLn6W7RzH3lrtloILRM/2CLppjizH4XOEi2zaTlNEQevnFMUCAkjhqrIIZ
         BwBUTFFgU3dy6VDRRdTB0Obt0nxvmaNDLBicGuCqGG/wU+oA0h2idBbSrwjXJC9uUC0L
         k5R1Lz/RgO0vouYMDJ9eUPs+3Ye+waQ04OeXpJgWiFFqtlLX+oesk31+/lxRpcAvkapd
         ggsaV4Hj/gQ+3VMDd8epMt234HnlaZCu4+uekZk5RB69s7HA43EKPbocX4WcRrxvf4tz
         oLlsFzZcBrJr/3IFhtJP0VW1+qqotjj/tKh/pHdcKywjjYg2d3vGab5lnrCmQNq49/k0
         5a1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727199225; x=1727804025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eiwagejtmdEAMVRH9GY/YhmfCZ26zHU5MaB8DwQPKCU=;
        b=iSkH7Wgung98gljhEYSllrvUPy+54lzLYLhNN3FCp1WVpeefLRb4pqKlPxN9K+CiOU
         N0cEiXO9KBnQR6rpn32rL93DqlxIgvl8CH5GuMB3KEsrleY9Na5mLvD9CVf5xIpQIC/B
         wcpLx0qcFrZYpK8oci7ch8RA9v5cvgc+bex70+vy4Pd3dXp+6WgJdNh4n+cmpUIGT/aZ
         YZeuFsqiJXkqSbAnYYnUw1KlPU/9iil361658Cg/LvhKs8u9P7tSei05mX9GReArYt3o
         g4zxRivAJNVoc+X1Htmuc4Gcwmju7gbm8CCtXdBs/ceDs5rIS53TGpFIcvP77eNKAZHL
         Cvpg==
X-Gm-Message-State: AOJu0YwTg1isabX2i5VQx5siL4TtP7f0UfcvwDmLWV7Zt2L3muyvLHOP
	Tz5U/m39la0qPz1d4JP34yahC0+E3l9Xk30Qd/WuXJgxJZoB1UebiPMcFle7rHAHgM1jFEi7/dd
	PNCUOUHQ4/73MKgYnLASie86QkOkFk8v5cxo=
X-Google-Smtp-Source: AGHT+IGrOSjhuFGPtW+mgJeBjySxDJdCGOugVpXpKH+y02RPYVZ399f8ct2HR5IKi5aQwBWEoR/dXQTid4231a4cUB4=
X-Received: by 2002:a05:6214:460f:b0:6c7:cc6b:f0f5 with SMTP id
 6a1803df08f44-6c7cc6bf13emr207925086d6.13.1727199224820; Tue, 24 Sep 2024
 10:33:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com> <20240924011709.7037-7-kanchana.p.sridhar@intel.com>
In-Reply-To: <20240924011709.7037-7-kanchana.p.sridhar@intel.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 24 Sep 2024 10:33:34 -0700
Message-ID: <CAKEwX=Nw_ax0RRSaD9n3h1vqbu+5PEuur3RqXrMrYyvOPuzB3Q@mail.gmail.com>
Subject: Re: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, chengming.zhou@linux.dev, usamaarif642@gmail.com, 
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

Hmm, so this is a runtime knob. Also, should this be zswap_thp_enabled? :)

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
> +       if (!zswap_mthp_enabled && folio_test_large(folio))
>                 return false;

Hmm can this go wrong somehow? Can we have a case where we enable
zswap_mthp_enabled, have a large folio written to zswap, disable
zswap_mthp_enabled, and attempt to store that folio to zswap again.

Now, we have a stale copy in zswap that is not invalidated...?

Or am I missing something here :)

