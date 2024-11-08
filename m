Return-Path: <linux-kernel+bounces-402322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788BB9C2659
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 21:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC1D1B233A2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4FE1F26C3;
	Fri,  8 Nov 2024 20:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dOQsnTxG"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52941D0DDF
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 20:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731096904; cv=none; b=vA9i9zCZSVwT93Bnm+Omuz9hiSDwVg/umlMEXVhpSfQ/+M+1ejB63eWrmhFM3aKwDVpGsErvZIsyCveZPsfMiN+9dEGJBYYIVlFWg4OQCxcfhul83OFCUNiBc2sP44Bvm+JQN2ow6HLyhVyZgPeoY7jIumadIergNHkeVKn2scQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731096904; c=relaxed/simple;
	bh=qGXPiqnF8TFtTk8t+XfD+l9dPtEeEhUBOzw4GLyptrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AI2bHz5z5tjTc6O8hjbQEAfyf0tdZ3wtJAnuHxqbVMfWnUTMzFEXQzBYz/7W6tq0Ps6X33K0tN5Gfh2fHcEUqa2F8gvLliEnzv5EKM53iFZ6OnF3EScBKgHHtqnOioIP68HmGHd/MTUcI6My9amVjDmE/vG7rXtIB1MPn42ErXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dOQsnTxG; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b1511697a5so150302285a.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 12:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731096902; x=1731701702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8ZaVYoPzYCPAMjKNaGUfWAblmU5p0Gp8/YjaHtNL8w=;
        b=dOQsnTxGiNpDKlwWVdy14SJ/y2HWi57WNOv1Vz8Aw5P/pGzO+dd+KdWw5h8feon6tz
         FcN8XRiOGoiLYyaM+QU8ik07qAhkz5RaIDJmAQxfNC3E9yubuFSYswfnwk7iuMadPFId
         OJhdy1KcqhTGJo3EntYB/aWGpInsgBBNLq+WDvfPi3ni0cPchAOgkXc18fcv6u6m+Nln
         VagEO9F2rBuEadWBMCfvqsOD2td9SnM2XvPqZ6b5AGG5X3lF2WcsdA3Yq8/giDsOS96q
         Yiu5Fot5uDYXv7utjd5z3sxc9Ikqs4e5e97r+O6iESuP56IUCA1zKaekiRxg+S71QO5W
         8Otw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731096902; x=1731701702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8ZaVYoPzYCPAMjKNaGUfWAblmU5p0Gp8/YjaHtNL8w=;
        b=rwdds9+xOEVOg9urN3D6QS/tZsjiNHA2UtSyxdybDDV1etPSR/ONxzwawpQ0h1l3xP
         ar8RS0lTNB42NM2OFjW4Wb+QVG+kEExZYlCjNXUIa7Aje11QPK3CyklyfWnoHmkjq+W9
         /YNMw+A+h6i3D3rb/Bl7T6r9ac6cECMtuOrv/6+ctoR7MuhgLLzV6p9q4QU0C9iUiHKa
         qoxNtLuZi/ftUezWx6hNTi7tl0mdoia9ns73XoMbFedqbkBR6Ta4NlfW2h1gjiRL5Qhk
         L1ag1oviyWUxrLGNBTxuAHftnCGZTUEPovQTE2RibVJ+SqoTTGJJor+V0YOQCpJ3vYUv
         D+Vw==
X-Gm-Message-State: AOJu0YxWTP7E1x/HeLgQeg/WPqjZglQUp6qMWGrSut6QNwbCHx21ZWvM
	3YIEH/v4D4imDXGylZk9/0Fvl+k3cojFF0CaNSfXfnfm3iHayKR5hrp3FiUizVkbiaTPq2p/QQ1
	+3U1qEtUGQwvrrRePRHyffhhmtCbP4c4pWXu4
X-Google-Smtp-Source: AGHT+IHwxkiHhBh0v4JSU3A9T/d6Om7fmIZTYA02EaBXG8KwzaA2lJaR/4b4dutDSDaMNve2nSBjqFxaXZCgHlAe5U8=
X-Received: by 2002:a05:6214:3bc7:b0:6bf:6ef6:22d5 with SMTP id
 6a1803df08f44-6d39e16b233mr61618156d6.17.1731096901466; Fri, 08 Nov 2024
 12:15:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106192105.6731-1-kanchana.p.sridhar@intel.com> <20241106192105.6731-9-kanchana.p.sridhar@intel.com>
In-Reply-To: <20241106192105.6731-9-kanchana.p.sridhar@intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 8 Nov 2024 12:14:25 -0800
Message-ID: <CAJD7tkaWTW3FRJvf1ii19E3Yq0LuB=HxKftkQMB3GyrKUZe2-g@mail.gmail.com>
Subject: Re: [PATCH v3 08/13] mm: zswap: acomp_ctx mutex lock/unlock optimizations.
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, usamaarif642@gmail.com, 
	ryan.roberts@arm.com, ying.huang@intel.com, 21cnbao@gmail.com, 
	akpm@linux-foundation.org, linux-crypto@vger.kernel.org, 
	herbert@gondor.apana.org.au, davem@davemloft.net, clabbe@baylibre.com, 
	ardb@kernel.org, ebiggers@google.com, surenb@google.com, 
	kristen.c.accardi@intel.com, zanussi@kernel.org, wajdi.k.feghali@intel.com, 
	vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 11:21=E2=80=AFAM Kanchana P Sridhar
<kanchana.p.sridhar@intel.com> wrote:
>
> This patch implements two changes with respect to the acomp_ctx mutex loc=
k:

The commit subject is misleading, one of these is definitely not an
optimization.

Also, if we are doing two unrelated things we should do them in two
separate commits.

>
> 1) The mutex lock is not acquired/released in zswap_compress(). Instead,
>    zswap_store() acquires the mutex lock once before compressing each pag=
e
>    in a large folio, and releases the lock once all pages in the folio ha=
ve
>    been compressed. This should reduce some compute cycles in case of lar=
ge
>    folio stores.

I understand how bouncing the mutex around can regress performance,
but I expect this to be more due to things like cacheline bouncing and
allowing reclaim to make meaningful progress before giving up the
mutex, rather than the actual cycles spent acquiring the mutex.

Do you have any numbers to support that this is a net improvement? We
usually base optimizations on data.

> 2) In zswap_decompress(), the mutex lock is released after the conditiona=
l
>    zpool_unmap_handle() based on "src !=3D acomp_ctx->buffer" rather than
>    before. This ensures that the value of "src" obtained earlier does not
>    change. If the mutex lock is released before the comparison of "src" i=
t
>    is possible that another call to reclaim by the same process could
>    obtain the mutex lock and over-write the value of "src".

This seems like a bug fix for 9c500835f279 ("mm: zswap: fix kernel BUG
in sg_init_one"). That commit changed checking acomp_ctx->is_sleepable
outside the mutex, which seems to be safe, to checking
acomp_ctx->buffer.

If my understanding is correct, this needs to be sent separately as a
hotfix, with a proper Fixes tag and CC stable. The side effect would
be that we never unmap the zpool handle and essentially leak the
memory, right?

>
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> ---
>  mm/zswap.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index f6316b66fb23..3e899fa61445 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -880,6 +880,9 @@ static int zswap_cpu_comp_dead(unsigned int cpu, stru=
ct hlist_node *node)
>         return 0;
>  }
>
> +/*
> + * The acomp_ctx->mutex must be locked/unlocked in the calling procedure=
.
> + */
>  static bool zswap_compress(struct page *page, struct zswap_entry *entry,
>                            struct zswap_pool *pool)
>  {
> @@ -895,8 +898,6 @@ static bool zswap_compress(struct page *page, struct =
zswap_entry *entry,
>
>         acomp_ctx =3D raw_cpu_ptr(pool->acomp_ctx);
>
> -       mutex_lock(&acomp_ctx->mutex);
> -
>         dst =3D acomp_ctx->buffer;
>         sg_init_table(&input, 1);
>         sg_set_page(&input, page, PAGE_SIZE, 0);
> @@ -949,7 +950,6 @@ static bool zswap_compress(struct page *page, struct =
zswap_entry *entry,
>         else if (alloc_ret)
>                 zswap_reject_alloc_fail++;
>
> -       mutex_unlock(&acomp_ctx->mutex);
>         return comp_ret =3D=3D 0 && alloc_ret =3D=3D 0;
>  }
>
> @@ -986,10 +986,16 @@ static void zswap_decompress(struct zswap_entry *en=
try, struct folio *folio)
>         acomp_request_set_params(acomp_ctx->req, &input, &output, entry->=
length, PAGE_SIZE);
>         BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &=
acomp_ctx->wait));
>         BUG_ON(acomp_ctx->req->dlen !=3D PAGE_SIZE);
> -       mutex_unlock(&acomp_ctx->mutex);
>
>         if (src !=3D acomp_ctx->buffer)
>                 zpool_unmap_handle(zpool, entry->handle);
> +
> +       /*
> +        * It is safer to unlock the mutex after the check for
> +        * "src !=3D acomp_ctx->buffer" so that the value of "src"
> +        * does not change.
> +        */

This comment is unnecessary, we should only release the lock after we
are done accessing protected fields.

> +       mutex_unlock(&acomp_ctx->mutex);
>  }
>
>  /*********************************
> @@ -1487,6 +1493,7 @@ bool zswap_store(struct folio *folio)
>  {
>         long nr_pages =3D folio_nr_pages(folio);
>         swp_entry_t swp =3D folio->swap;
> +       struct crypto_acomp_ctx *acomp_ctx;
>         struct obj_cgroup *objcg =3D NULL;
>         struct mem_cgroup *memcg =3D NULL;
>         struct zswap_pool *pool;
> @@ -1526,6 +1533,9 @@ bool zswap_store(struct folio *folio)
>                 mem_cgroup_put(memcg);
>         }
>
> +       acomp_ctx =3D raw_cpu_ptr(pool->acomp_ctx);
> +       mutex_lock(&acomp_ctx->mutex);
> +
>         for (index =3D 0; index < nr_pages; ++index) {
>                 struct page *page =3D folio_page(folio, index);
>                 ssize_t bytes;
> @@ -1547,6 +1557,7 @@ bool zswap_store(struct folio *folio)
>         ret =3D true;
>
>  put_pool:
> +       mutex_unlock(&acomp_ctx->mutex);
>         zswap_pool_put(pool);
>  put_objcg:
>         obj_cgroup_put(objcg);
> --
> 2.27.0
>

