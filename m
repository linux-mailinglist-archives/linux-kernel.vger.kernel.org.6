Return-Path: <linux-kernel+bounces-337534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 896C0984B73
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 21:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F131F1F23091
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 19:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6AC12D1F1;
	Tue, 24 Sep 2024 19:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="luK8e5ra"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EEC3BBEF
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 19:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727205339; cv=none; b=ZVXu0sm7Pk/ejYPstjd8ExdLZgF05Hmyus7T+fegKMaxw7JbPHRZ7P3SZfHb2i3AyIrn9M+2UiHIWtUPN/0PixuBiSX1A7RRHhGXx9xvZjfrKJhkpuGUHcGd8RGueBPxWNHn0vjoRNGsoithSZ4eZ0n6xq/2BZXEAiwoY/IuaHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727205339; c=relaxed/simple;
	bh=j2EDtpNtsFmrN/wWQQ5+Be2p3bN7WwExVPapu0MpD8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tQznbkyX3H/EmVDBSS8uuWdWc4hZdQQGGMVc2oRPmtFaeb+A9bynlDBoeuuGojYs/F8ujIHYYcKj2TaYxZoYeZcX/6Ao07qN5DkgruZouoVaw+etdCUlK14mX5c3+Nxa1fLClMDVktgXKgU8PhsisbqYEjlE4iPE9CJ1qyunXw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=luK8e5ra; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8d51a7d6f5so880039866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727205336; x=1727810136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohErbOrqDbKeoqxTroGQO2Ip0GopqiDtJKn6+41MyK4=;
        b=luK8e5rah8yM6kxW99Q1jT9KnjW0Wlxs+9hNdlH5S9XzcMW9YHHB3fHSt/dJqO6bDf
         ASSmXPKYwkMayKqtX9gKkUSXc4gHyo1XHloedzCqwfva9bKhF7R8Ue3eZR5/bq4PPx4a
         UKqCKnoM2F6ymkCIyl5xWxt2gywvtcA4ZxrEpmhBrQ1xKfwQL9gKpcJEUELd12MnIvxB
         WyayhK0z1dAMarOBD2V57aBl6xad1MRKbNr88/WuYKs4PT+LfkLWP/UBwxHke3/Uzwjt
         7EYsdOLmkj5Hyx065X/dUD4ZSiYmnAF6QGgtAw929RRAHEbeq2pMwzt9oXwnZzKlwdim
         dGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727205336; x=1727810136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohErbOrqDbKeoqxTroGQO2Ip0GopqiDtJKn6+41MyK4=;
        b=e/NEa4ismRndPHA2bcYXgitBt9L0yto6L+G3hrluEA2Cbs/QP29Z5s1TQuoQ21xJAI
         RK6QrSwiwW47tCNn37ODx29ps34twf2Y9rHJlguvWFbpzjcEW1458bduUA8kKzG++VYN
         bzVgiXjHMd2if6/EWFT7707vQM9YFrIp4hbYXpxIEMzGlq4oAaWNhp4gyboW6ztv1RRo
         tkiBTt57CEAgNSmGpvSilBdbJQBOxl/0rJygqNybwOnekxJFWhk44yHIJwTtAffK6298
         Kt9bkZCUbU6js30eGawNo3iUuJoT5oYQYNQq/fM1TuxXcSCur+98vkfTlA/0vjzwdf1j
         eQIw==
X-Gm-Message-State: AOJu0YxP7VGBqbNe2USw7ZiLao54HiSEe0OKXZbKd1LpGhu0d1JpGlR7
	zxoD5t7geYXCTEqlwkmamCt2NXcCfbuLT6UGfYgW3HIgIeGnrB+DFDiRrh0SdXGD6lgIjU9T/C4
	HrKj9PNQll4ZHETKkMQ85+pLjX7Z67isEiGv3
X-Google-Smtp-Source: AGHT+IEwnxpMOsvFRpmsVDRwussKueirUorwya1m0dfAD6zodQXaWMM3Fg6VJTN1aIfBg5r4BWVDhLEJjP9duglTWo8=
X-Received: by 2002:a17:907:e262:b0:a8d:55ce:fb97 with SMTP id
 a640c23a62f3a-a93a03269e7mr31142466b.11.1727205335714; Tue, 24 Sep 2024
 12:15:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com> <20240924011709.7037-4-kanchana.p.sridhar@intel.com>
In-Reply-To: <20240924011709.7037-4-kanchana.p.sridhar@intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 24 Sep 2024 12:14:59 -0700
Message-ID: <CAJD7tkZbx3q5soiwu1V9pVNCy35QDXK_SFQa6cr19-kXZgU8xw@mail.gmail.com>
Subject: Re: [PATCH v7 3/8] mm: zswap: Refactor code to store an entry in
 zswap xarray.
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
> Added a new procedure zswap_store_entry() that refactors the code
> currently in zswap_store() to store an entry in the zswap xarray.
> This will allow us to call this procedure for each storing the swap
> offset of each page in an mTHP in the xarray, as part of zswap_store()
> supporting mTHP.
>
> Also, made a minor edit in the comments for 'struct zswap_entry' to delet=
e
> the description of the 'value' member that was deleted in commit
> 20a5532ffa53d6ecf41ded920a7b0ff9c65a7dcf ("mm: remove code to handle
> same filled pages").
>
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> ---
>  mm/zswap.c | 51 ++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 34 insertions(+), 17 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 59b7733a62d3..fd35a81b6e36 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -190,7 +190,6 @@ static struct shrinker *zswap_shrinker;
>   *              section for context.
>   * pool - the zswap_pool the entry's data is in
>   * handle - zpool allocation handle that stores the compressed page data
> - * value - value of the same-value filled pages which have same content
>   * objcg - the obj_cgroup that the compressed memory is charged to
>   * lru - handle to the pool's lru used to evict pages.
>   */
> @@ -1404,12 +1403,44 @@ static void shrink_worker(struct work_struct *w)
>  /*********************************
>  * main API
>  **********************************/
> +
> +/*
> + * Returns true if the entry was successfully
> + * stored in the xarray, and false otherwise.
> + */
> +static bool zswap_store_entry(struct xarray *tree,
> +                             struct zswap_entry *entry)


I think zswap_tree_store() is a more descriptive name.

>
> +{
> +       struct zswap_entry *old;
> +       pgoff_t offset =3D swp_offset(entry->swpentry);


Reverse xmas tree where possible please (longest to shortest declarations).

>
> +
> +       old =3D xa_store(tree, offset, entry, GFP_KERNEL);
> +

No need for the blank line here.

> +       if (xa_is_err(old)) {
> +               int err =3D xa_err(old);
> +
> +               WARN_ONCE(err !=3D -ENOMEM, "unexpected xarray error: %d\=
n", err);
> +               zswap_reject_alloc_fail++;
> +               return false;
> +       }
> +
> +       /*
> +        * We may have had an existing entry that became stale when
> +        * the folio was redirtied and now the new version is being
> +        * swapped out. Get rid of the old.
> +        */
> +       if (old)
> +               zswap_entry_free(old);
> +
> +       return true;
> +}
> +
>  bool zswap_store(struct folio *folio)
>  {
>         swp_entry_t swp =3D folio->swap;
>         pgoff_t offset =3D swp_offset(swp);
>         struct xarray *tree =3D swap_zswap_tree(swp);
> -       struct zswap_entry *entry, *old;
> +       struct zswap_entry *entry;
>         struct obj_cgroup *objcg =3D NULL;
>         struct mem_cgroup *memcg =3D NULL;
>
> @@ -1465,22 +1496,8 @@ bool zswap_store(struct folio *folio)
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
> --
> 2.27.0
>

