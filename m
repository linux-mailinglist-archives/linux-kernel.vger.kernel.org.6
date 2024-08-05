Return-Path: <linux-kernel+bounces-275413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B993C94854C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 00:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36DC51F23610
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 22:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB8016C69C;
	Mon,  5 Aug 2024 22:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nx56sXX0"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32D01662FA
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 22:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722895789; cv=none; b=WdXGIjsU9PtKjVq/m4o9zqWH3H67TOSkWpE/zW+WFrY5rMjt46Cm+D77R6vf+JuFW2z4ptH5rJCWFa8LkZ/1hsXzJA0kxcDVVAcZAnt8cehrkibP4Jnlypt9sRKCb/9TJqgNcdz10561Pnm3YrtC4E0xdT8P+SArgxtDJk2BX0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722895789; c=relaxed/simple;
	bh=4WEV2hKzCT+qK5apstnmKizyDHd3pFbPSau5tN81KpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hdyl3itZ1vyhaJIOIktysApRkbwH+mDrJIFVe2bt4qUtUuK/WXbfB6Ptix9pI6ORNEs4jego46ggMhEwTncE4diG7nxBu1oUPMheqQz0LYyzBIEu9XYd3f/dXuISqNSMZlgqfaNzF8O/K05f4pKJ7adp3FnwFHT94QgPNjf/WvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nx56sXX0; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4928989e272so49653137.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 15:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722895786; x=1723500586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GlmlfKjXwfR6h2DshfQ/bYYzP2vko50q3Xok1sEZvw=;
        b=Nx56sXX0pOITmq9oDbjRMxtVIgeoMaRovXeAraWV5IZBVZRVKh5ETkK1FHc8AKoOAW
         9mL7+0lRs0NLB7xvE0ldC+bT9tOrL0+7sys9eQkxPzxcRsCt1QlyMJZuAjNW9KavLrOm
         OSRNn5LcvMUreKRvjMq7OMFPPEXckWsxleo4x9z015pqv8R8jA41bqNzjf3jeDYcfS4h
         It0EOgRfrXV5ykoZh0sC/J7yjFdyv7MMnfmpCVF9k1ckXbya38nsDlq1Sar87x1Fde1U
         ZSRq6MM8wI0hUSzhPQprnLeL2+RDN14RNPGbRWgYY0YOVvYmb9Bn51fo5WsXZFETd9tx
         aTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722895786; x=1723500586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0GlmlfKjXwfR6h2DshfQ/bYYzP2vko50q3Xok1sEZvw=;
        b=WBoDESA/Bs1vWmDzdhMbZ+XrZVofUqog540AkFrCAfiGwO+hN8cVnVqr4l2vS/Crzn
         C0U30PTORwuGAmArqEidK+jJG3NUn06BhmcfFzkdBNIs+ckjZaKwULx9anmFlhx/Bjf8
         RB/B/tDdVw27ztWxOeXrK4+xK78rr2yMhM9YY5t7fsM2fXvxp6KQLlNbtYmfKzjMs3pl
         Cyw9681JlKV1gtCtpUFzrw4NqvRh6cyP2y7kUSH99m7UDFLHCkL5jldjDsWzhvtEaAuG
         9rWypluW6PaRkHxOAYGN/jWy5gOSyFW5XT2QdsmFX0yeApCMNw/0CRCWuWSyE1hqKwbF
         VFug==
X-Forwarded-Encrypted: i=1; AJvYcCWMzb5GZTYSj0ruyPq/FvxJtjW8roFeCW1Bm8JsblcYNy678sbZ1bYyeXqF8AaBnnFnOobvAMYQBGvvHHCQ0hP53Jma2j8tohALtOcW
X-Gm-Message-State: AOJu0YxCHOsI6xXuokMiGuG4kZHHtGjTv67OaI7aapHCCGS0WUvetWFq
	v4s+r2BOOw3UKePIEDZorrlegLLFsCA3QB1a5LKLvU5PUrEc0b+oX+K/anIU/RLEXctx0RrFq7B
	WAjhkR2WGkJAV6VyiRuEE+S8r0AU=
X-Google-Smtp-Source: AGHT+IHIYR2VNeV0CMUYrwAssvNkO0tVtLB8DEASlbj+pqDLr1t588ZSLuDD8V4HNCwTzJuXO/biUv1YPhBj0gUyLO8=
X-Received: by 2002:a05:6102:512c:b0:493:2177:9811 with SMTP id
 ada2fe7eead31-4945be08629mr15836873137.14.1722895786397; Mon, 05 Aug 2024
 15:09:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805160754.1081-1-justinjiang@vivo.com>
In-Reply-To: <20240805160754.1081-1-justinjiang@vivo.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 6 Aug 2024 10:09:35 +1200
Message-ID: <CAGsJ_4wqENiGf4FoEKA2yO5pmu3SfJD9qsjHD0E7eHPZG1+PuA@mail.gmail.com>
Subject: Re: [PATCH] mm: swap: mTHP frees entries as a whole
To: Zhiguo Jiang <justinjiang@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Chris Li <chrisl@kernel.org>, 
	opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 4:08=E2=80=AFAM Zhiguo Jiang <justinjiang@vivo.com> =
wrote:
>
> Support mTHP's attempt to free swap entries as a whole, which can avoid
> frequent swap_info locking for every individual entry in
> swapcache_free_entries(). When the swap_map count values corresponding
> to all contiguous entries are all zero excluding SWAP_HAS_CACHE, the
> entries will be freed directly by skippping percpu swp_slots caches.
>

No, this isn't quite good. Please review the work done by Chris and Kairui[=
1];
they have handled it better. On a different note, I have a patch that can
handle zap_pte_range() for swap entries in batches[2][3].

[1] https://lore.kernel.org/linux-mm/20240730-swap-allocator-v5-5-cb9c148b9=
297@kernel.org/
[2] https://lore.kernel.org/linux-mm/20240803091118.84274-1-21cnbao@gmail.c=
om/
[3] https://lore.kernel.org/linux-mm/CAGsJ_4wPnQqKOHx6iQcwO8bQzoBXKr2qY2AgS=
xMwTQCj3-8YWw@mail.gmail.com/

> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
> ---
>  mm/swapfile.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index ea023fc25d08..829fb4cfb6ec
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1493,6 +1493,58 @@ static void swap_entry_range_free(struct swap_info=
_struct *p, swp_entry_t entry,
>         swap_range_free(p, offset, nr_pages);
>  }
>
> +/*
> + * Free the contiguous swap entries as a whole, caller have to
> + * ensure all entries belong to the same folio.
> + */
> +static void swap_entry_range_check_and_free(struct swap_info_struct *p,
> +                                 swp_entry_t entry, int nr, bool *any_on=
ly_cache)
> +{
> +       const unsigned long start_offset =3D swp_offset(entry);
> +       const unsigned long end_offset =3D start_offset + nr;
> +       unsigned long offset;
> +       DECLARE_BITMAP(to_free, SWAPFILE_CLUSTER) =3D { 0 };
> +       struct swap_cluster_info *ci;
> +       int i =3D 0, nr_setbits =3D 0;
> +       unsigned char count;
> +
> +       /*
> +        * Free and check swap_map count values corresponding to all cont=
iguous
> +        * entries in the whole folio range.
> +        */
> +       WARN_ON_ONCE(nr > SWAPFILE_CLUSTER);
> +       ci =3D lock_cluster_or_swap_info(p, start_offset);
> +       for (offset =3D start_offset; offset < end_offset; offset++, i++)=
 {
> +               if (data_race(p->swap_map[offset])) {
> +                       count =3D __swap_entry_free_locked(p, offset, 1);
> +                       if (!count) {
> +                               bitmap_set(to_free, i, 1);
> +                               nr_setbits++;
> +                       } else if (count =3D=3D SWAP_HAS_CACHE) {
> +                               *any_only_cache =3D true;
> +                       }
> +               } else {
> +                       WARN_ON_ONCE(1);
> +               }
> +       }
> +       unlock_cluster_or_swap_info(p, ci);
> +
> +       /*
> +        * If the swap_map count values corresponding to all contiguous e=
ntries are
> +        * all zero excluding SWAP_HAS_CACHE, the entries will be freed d=
irectly by
> +        * skippping percpu swp_slots caches, which can avoid frequent sw=
ap_info
> +        * locking for every individual entry.
> +        */
> +       if (nr > 1 && nr_setbits =3D=3D nr) {
> +               spin_lock(&p->lock);
> +               swap_entry_range_free(p, entry, nr);
> +               spin_unlock(&p->lock);
> +       } else {
> +               for_each_set_bit(i, to_free, SWAPFILE_CLUSTER)
> +                       free_swap_slot(swp_entry(p->type, start_offset + =
i));
> +       }
> +}
> +
>  static void cluster_swap_free_nr(struct swap_info_struct *sis,
>                 unsigned long offset, int nr_pages,
>                 unsigned char usage)
> @@ -1808,6 +1860,14 @@ void free_swap_and_cache_nr(swp_entry_t entry, int=
 nr)
>         if (WARN_ON(end_offset > si->max))
>                 goto out;
>
> +       /*
> +        * Try to free all contiguous entries about mTHP as a whole.
> +        */
> +       if (IS_ENABLED(CONFIG_THP_SWAP) && nr > 1) {
> +               swap_entry_range_check_and_free(si, entry, nr, &any_only_=
cache);
> +               goto free_cache;
> +       }
> +
>         /*
>          * First free all entries in the range.
>          */
> @@ -1821,6 +1881,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int =
nr)
>                 }
>         }
>
> +free_cache:
>         /*
>          * Short-circuit the below loop if none of the entries had their
>          * reference drop to zero.
> --
> 2.39.0
>

