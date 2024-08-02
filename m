Return-Path: <linux-kernel+bounces-272899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5E694626D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8192284225
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A43915C13B;
	Fri,  2 Aug 2024 17:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvpbP16h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB875136327
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 17:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722619760; cv=none; b=hTJI1vcYTLqMF4cabPnisyZwnp4q3cY60UY7uTlzfVHNI7yK2xNsbfWOy514SMFM8kumLF3eVBL6IVLwjNimMqi70iVN7x/GWJxXY97i7vPkgSora4FMoHX9WyknlNqfzHN4kLKBV/n5MOJ4Xz73oz9K1mHFmoS8Z58Dk9jpMhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722619760; c=relaxed/simple;
	bh=1aXr1a6cPgOepOy3AhjNqHrv1sNmM2SwAOr0T46pwP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NHZsBL3nEJeKUg8wUMi3OavqCjkWCzDkv95Cmiasp6FHNGETqLBrLpJm99LMyxjDnZEu7kzT4kH04nastDt9fbyly3eKYE7EQP50lGiWs426b5uk6qoq8XjGtravUdeocqMdbKispaoY7EkHtIPPY4okQ37uWLOx4z27jS3HFUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvpbP16h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38900C4AF48
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 17:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722619760;
	bh=1aXr1a6cPgOepOy3AhjNqHrv1sNmM2SwAOr0T46pwP4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pvpbP16hq+rm54xJczTpn8B80vjIfKaT4TK5sbBTfRp5QxEAOiGU5KObwXIcjGYu8
	 SJ6eFZFwJE7eWehVtIvnamZoMeuWH2sc76WM99/NjWa7XJSyS3lu8QTkhkvu5wKfGZ
	 kUNE7YVY3Hr1ZUFxoYoYmktyIQHjDChlchTNVcuHdvH1pwMGOS5cHvN+Bh+pqc5re4
	 jJJa4GeK+7y2W9mdJQdIq5kOZSlFtXzrlAxv47NS4etzILZT7oxEpz9y4blrzoSjJC
	 PpnCCf4ihygaX8kLSYKgIXO2rACzYvbHuKkxploIgjTTF/XpxGrjZM4eoU+EbhYNn/
	 G7RJFqUqVdryA==
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-66526e430e0so71342417b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 10:29:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXLryn41xRDr2bqIkGMcvCMkbm6GTisuYW1B7/NoKRyqRWGHfhAzSTLR859YeV/7C09Ieeci8OlFnxYkhXL5LrRwVENdfzmVfupCyKC
X-Gm-Message-State: AOJu0YxiPsXO1K3Ccs4DyPBkoTaIaChdBfawwwV1M1cp1rKeN1nfI1ak
	k35t3o4dt9bBy/8mmxtYWNqcf8PwdVHKvsEfBur0lRzNYrx0di0ZtTJcnOVhyPsBxbd9JTpTFUj
	bbSZuLul3KXRicU6dUP9G+QkRqQU6S66oS1fYyQ==
X-Google-Smtp-Source: AGHT+IGgp0/LFOnOVLKTwvr2itlc7DfEpJiEC5mNOsNgKnoG0VxvpaCvtmpTWUcoQdIKztSXOlXn9/ACCsSBd3lfotY=
X-Received: by 2002:a81:c20f:0:b0:61b:1e81:4eb8 with SMTP id
 00721157ae682-6895fbdb8c3mr47090427b3.9.1722619758887; Fri, 02 Aug 2024
 10:29:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726094618.401593-1-21cnbao@gmail.com> <20240802122031.117548-1-21cnbao@gmail.com>
 <20240802122031.117548-2-21cnbao@gmail.com>
In-Reply-To: <20240802122031.117548-2-21cnbao@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 2 Aug 2024 10:29:08 -0700
X-Gmail-Original-Message-ID: <CACePvbUmCN313ippOkP9bhYa8Zd7gNDXgA9w9Q8bA9sgUxTvOQ@mail.gmail.com>
Message-ID: <CACePvbUmCN313ippOkP9bhYa8Zd7gNDXgA9w9Q8bA9sgUxTvOQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] mm: add nr argument in mem_cgroup_swapin_uncharge_swap()
 helper to support large folios
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, david@redhat.com, hannes@cmpxchg.org, 
	hughd@google.com, kaleshsingh@google.com, kasong@tencent.com, 
	linux-kernel@vger.kernel.org, mhocko@suse.com, minchan@kernel.org, 
	nphamcs@gmail.com, ryan.roberts@arm.com, senozhatsky@chromium.org, 
	shakeel.butt@linux.dev, shy828301@gmail.com, surenb@google.com, 
	v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org, 
	ying.huang@intel.com, yosryahmed@google.com, hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Chris Li <chrisl@kernel.org>

Chris

On Fri, Aug 2, 2024 at 5:21=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrote=
:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> With large folios swap-in, we might need to uncharge multiple entries
> all together, add nr argument in mem_cgroup_swapin_uncharge_swap().
>
> For the existing two users, just pass nr=3D1.
>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  include/linux/memcontrol.h | 5 +++--
>  mm/memcontrol.c            | 7 ++++---
>  mm/memory.c                | 2 +-
>  mm/swap_state.c            | 2 +-
>  4 files changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 1b79760af685..44f7fb7dc0c8 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -682,7 +682,8 @@ int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *=
memcg, gfp_t gfp,
>
>  int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct=
 *mm,
>                                   gfp_t gfp, swp_entry_t entry);
> -void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry);
> +
> +void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry, unsigned int nr_=
pages);
>
>  void __mem_cgroup_uncharge(struct folio *folio);
>
> @@ -1181,7 +1182,7 @@ static inline int mem_cgroup_swapin_charge_folio(st=
ruct folio *folio,
>         return 0;
>  }
>
> -static inline void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry)
> +static inline void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry, un=
signed int nr)
>  {
>  }
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b889a7fbf382..5d763c234c44 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4572,14 +4572,15 @@ int mem_cgroup_swapin_charge_folio(struct folio *=
folio, struct mm_struct *mm,
>
>  /*
>   * mem_cgroup_swapin_uncharge_swap - uncharge swap slot
> - * @entry: swap entry for which the page is charged
> + * @entry: the first swap entry for which the pages are charged
> + * @nr_pages: number of pages which will be uncharged
>   *
>   * Call this function after successfully adding the charged page to swap=
cache.
>   *
>   * Note: This function assumes the page for which swap slot is being unc=
harged
>   * is order 0 page.
>   */
> -void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry)
> +void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry, unsigned int nr_=
pages)
>  {
>         /*
>          * Cgroup1's unified memory+swap counter has been charged with th=
e
> @@ -4599,7 +4600,7 @@ void mem_cgroup_swapin_uncharge_swap(swp_entry_t en=
try)
>                  * let's not wait for it.  The page already received a
>                  * memory+swap charge, drop the swap entry duplicate.
>                  */
> -               mem_cgroup_uncharge_swap(entry, 1);
> +               mem_cgroup_uncharge_swap(entry, nr_pages);
>         }
>  }
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 4c8716cb306c..4cf4902db1ec 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4102,7 +4102,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>                                         ret =3D VM_FAULT_OOM;
>                                         goto out_page;
>                                 }
> -                               mem_cgroup_swapin_uncharge_swap(entry);
> +                               mem_cgroup_swapin_uncharge_swap(entry, 1)=
;
>
>                                 shadow =3D get_shadow_from_swap_cache(ent=
ry);
>                                 if (shadow)
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 293ff1afdca4..1159e3225754 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -522,7 +522,7 @@ struct folio *__read_swap_cache_async(swp_entry_t ent=
ry, gfp_t gfp_mask,
>         if (add_to_swap_cache(new_folio, entry, gfp_mask & GFP_RECLAIM_MA=
SK, &shadow))
>                 goto fail_unlock;
>
> -       mem_cgroup_swapin_uncharge_swap(entry);
> +       mem_cgroup_swapin_uncharge_swap(entry, 1);
>
>         if (shadow)
>                 workingset_refault(new_folio, shadow);
> --
> 2.34.1
>

