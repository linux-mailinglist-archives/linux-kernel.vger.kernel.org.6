Return-Path: <linux-kernel+bounces-402461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0559D9C27F3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 00:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40A10B22273
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 23:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681921E32B0;
	Fri,  8 Nov 2024 23:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pLxVOXjj"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DAD1C1F2B
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 23:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731107294; cv=none; b=GMAP3hDtFSqlZQCM+vu4CjkoZW6mVUD6WGa0p2Tw7ad0g8rcx8Ti7+FMYUxoVGh2V3uOzxSJJXCqRgYTuk6m6jIb66JyIjDcLaAdU964YKXYKOR5S4J4kGo30AQj8byK6wGu1t/PF5e0nZQmesCtBEjEXeZOK7mcZsQ2kZmcOvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731107294; c=relaxed/simple;
	bh=GWZ1jKcIHFlF8XHVXxsn3quaGYguDIHzjkom+mEDeRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tpXaGkj2viSVE4uoIZ5oX7do+TyFzMox/h+T1CmDf1a9a0tZUAgskcqzF1JDVdGTHH7Rxh+uAUnbiw6kLarcC6CgdeRp+oceiddiRRJatbBnLxekWy7N3XpoDLOmsd9ptsFuzUzAxM3+sGirvSC4D/WffEiD47cD+zLnjPogDiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pLxVOXjj; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b158542592so162324185a.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 15:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731107292; x=1731712092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E77NEMjYMvq3s2ZmJeds5qCuD207qrql0cMNnIpXYy4=;
        b=pLxVOXjjiFqc2CcBRMt/8O2+2jI8QPXO5LCUgvOyeGOONnyP42ce4adXouEEvnN731
         7FJ0JUKhQPA8z67Q1DuJEd2YI+jK2VAoP8Ixdysb4pkdXSr286pAgrf7NajJA0G0B+oj
         EKtS64+1ZQB8jSHhMM0Q1ZIvSVZoNV7yrX7sb/jb47TtWA7IpITmYW7SRBVD783vlVcx
         RWTmhzKTMmcNBimklKx4nFsKgqeGvC8lCxCd/gmpc6YfDOfO18HFFhBoQQNOr/Eh9VMd
         8YA2sYFyoTYU/54cG6BYz9nZGhByY+WITvTmF6fmB+vqmhkhcF61fzAmzV02G5bVBbpP
         y5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731107292; x=1731712092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E77NEMjYMvq3s2ZmJeds5qCuD207qrql0cMNnIpXYy4=;
        b=m2Q6ECLlBlvZuBfokhN/tVObWGVYhMuOEI9Pkhmr+4dl7qF88ocLPPTG8/fWQqEwmk
         ZcMQHOkSGsVP/Q+z3qP4aLoxS/VENNamqn1k272rDrxZc9nsBruvQMwG61oQLIWHPG0J
         cowPfZWaF+TSw5+ylvhmq6S6Keu5vwoPlvdujJhI31a92gAKwWqMJKUqHaRq0X5e0rN9
         0NRW27Ed5NKj9t3Htc/lQT05yX57Frn7AdxWGuVeie6RCFOmgJwqSLKJKEnfBl/iNO0+
         h16ZGw2pkWkm2HzY6/WNsB/pjtmr+mRulZkavR39PuKHifNgi3NK489f3L5OBtizncfK
         qCMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXwPjUIq0UR63+VhKbykrJ9XOpWDaRd8lN3MbHcZg6WvcAhP/kdiwduNyEf4VaQzD3Ye2KOPXbt55Gg1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLJEyJ6wVHrm716tSpTPkaQU490CvJKYxVtcfVJvFfYDybpn0o
	wOT4WIF/DyMfSibJMNJuI0jglGABkpMYBxf2ovSbSJJRD0+QLSbr62p3g4CWvrRa6LBhWd2hRnK
	ygkFxdhfQOAQefm/Unsr/Y5R14p1DA3jfx1Xu
X-Google-Smtp-Source: AGHT+IEroN+1eNRmVul2IXF/Tn/9/3+CPo9UMgNFT5rcDOgryag/DFm7d5N/lf6Swe+UH76UpJxPXRHYfgwyOIOKJso=
X-Received: by 2002:a05:620a:4543:b0:79d:536f:7b3a with SMTP id
 af79cd13be357-7b331f1978emr520700885a.56.1731107291514; Fri, 08 Nov 2024
 15:08:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108212946.2642085-1-joshua.hahnjy@gmail.com> <20241108212946.2642085-4-joshua.hahnjy@gmail.com>
In-Reply-To: <20241108212946.2642085-4-joshua.hahnjy@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 8 Nov 2024 15:07:34 -0800
Message-ID: <CAJD7tkaKzLu0DfMynvPg+-78YAZNMCcEoM3wXPx9qfcAxZzUgg@mail.gmail.com>
Subject: Re: [PATCH 3/3] memcg/hugetlb: Deprecate memcg hugetlb
 try-commit-cancel protocol
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: shakeel.butt@linux.dev, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 1:30=E2=80=AFPM Joshua Hahn <joshua.hahnjy@gmail.com=
> wrote:
>
> This patch fully deprecates the mem_cgroup_{try, commit, cancel} charge
> functions, as well as their hugetlb variants. Please note that this
> patch relies on [1], which removes the last references (from memcg-v1)
> to some of these functions.

Nit: We are not really "deprecating" them, we are removing them.
Deprecation is usually tied to user-visible APIs that we cannot just
remove, at least not right away. Please rephrase the subject and
commit log accordingly.

>
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
>
> [1] https://lore.kernel.org/linux-mm/20241025012304.2473312-1-shakeel.but=
t@linux.dev/
>
> ---
>  include/linux/memcontrol.h | 22 -------------
>  mm/memcontrol.c            | 65 ++------------------------------------
>  2 files changed, 3 insertions(+), 84 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index d90c1ac791f1..75f15c4efe73 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -649,8 +649,6 @@ static inline bool mem_cgroup_below_min(struct mem_cg=
roup *target,
>                 page_counter_read(&memcg->memory);
>  }
>
> -void mem_cgroup_commit_charge(struct folio *folio, struct mem_cgroup *me=
mcg);
> -
>  int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t=
 gfp);
>
>  /**
> @@ -675,9 +673,6 @@ static inline int mem_cgroup_charge(struct folio *fol=
io, struct mm_struct *mm,
>         return __mem_cgroup_charge(folio, mm, gfp);
>  }
>
> -int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
> -               long nr_pages);
> -
>  int mem_cgroup_charge_hugetlb(struct folio* folio, gfp_t gfp);
>
>  int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct=
 *mm,
> @@ -708,7 +703,6 @@ static inline void mem_cgroup_uncharge_folios(struct =
folio_batch *folios)
>         __mem_cgroup_uncharge_folios(folios);
>  }
>
> -void mem_cgroup_cancel_charge(struct mem_cgroup *memcg, unsigned int nr_=
pages);
>  void mem_cgroup_replace_folio(struct folio *old, struct folio *new);
>  void mem_cgroup_migrate(struct folio *old, struct folio *new);
>
> @@ -1167,23 +1161,12 @@ static inline bool mem_cgroup_below_min(struct me=
m_cgroup *target,
>         return false;
>  }
>
> -static inline void mem_cgroup_commit_charge(struct folio *folio,
> -               struct mem_cgroup *memcg)
> -{
> -}
> -
>  static inline int mem_cgroup_charge(struct folio *folio,
>                 struct mm_struct *mm, gfp_t gfp)
>  {
>         return 0;
>  }
>
> -static inline int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg=
,
> -               gfp_t gfp, long nr_pages)
> -{
> -       return 0;
> -}
> -
>  static inline int mem_cgroup_swapin_charge_folio(struct folio *folio,
>                         struct mm_struct *mm, gfp_t gfp, swp_entry_t entr=
y)
>  {
> @@ -1202,11 +1185,6 @@ static inline void mem_cgroup_uncharge_folios(stru=
ct folio_batch *folios)
>  {
>  }
>
> -static inline void mem_cgroup_cancel_charge(struct mem_cgroup *memcg,
> -               unsigned int nr_pages)
> -{
> -}
> -
>  static inline void mem_cgroup_replace_folio(struct folio *old,
>                 struct folio *new)
>  {
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 95ee77fe27af..17126d8d263d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2351,21 +2351,6 @@ int try_charge_memcg(struct mem_cgroup *memcg, gfp=
_t gfp_mask,
>         return 0;
>  }
>
> -/**
> - * mem_cgroup_cancel_charge() - cancel an uncommitted try_charge() call.
> - * @memcg: memcg previously charged.
> - * @nr_pages: number of pages previously charged.
> - */
> -void mem_cgroup_cancel_charge(struct mem_cgroup *memcg, unsigned int nr_=
pages)
> -{
> -       if (mem_cgroup_is_root(memcg))
> -               return;
> -
> -       page_counter_uncharge(&memcg->memory, nr_pages);
> -       if (do_memsw_account())
> -               page_counter_uncharge(&memcg->memsw, nr_pages);
> -}
> -
>  static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
>  {
>         VM_BUG_ON_FOLIO(folio_memcg_charged(folio), folio);
> @@ -2379,18 +2364,6 @@ static void commit_charge(struct folio *folio, str=
uct mem_cgroup *memcg)
>         folio->memcg_data =3D (unsigned long)memcg;
>  }
>
> -/**
> - * mem_cgroup_commit_charge - commit a previously successful try_charge(=
).
> - * @folio: folio to commit the charge to.
> - * @memcg: memcg previously charged.
> - */
> -void mem_cgroup_commit_charge(struct folio *folio, struct mem_cgroup *me=
mcg)
> -{
> -       css_get(&memcg->css);
> -       commit_charge(folio, memcg);
> -       memcg1_commit_charge(folio, memcg);
> -}
> -
>  static inline void __mod_objcg_mlstate(struct obj_cgroup *objcg,
>                                        struct pglist_data *pgdat,
>                                        enum node_stat_item idx, int nr)
> @@ -4469,7 +4442,9 @@ static int charge_memcg(struct folio *folio, struct=
 mem_cgroup *memcg,
>         if (ret)
>                 goto out;
>
> -       mem_cgroup_commit_charge(folio, memcg);
> +       css_get(&memcg->css);
> +       commit_charge(folio, memcg);
> +       memcg1_commit_charge(folio, memcg);
>  out:
>         return ret;
>  }
> @@ -4495,40 +4470,6 @@ bool memcg_accounts_hugetlb(void)
>  #endif
>  }
>
> -/**
> - * mem_cgroup_hugetlb_try_charge - try to charge the memcg for a hugetlb=
 folio
> - * @memcg: memcg to charge.
> - * @gfp: reclaim mode.
> - * @nr_pages: number of pages to charge.
> - *
> - * This function is called when allocating a huge page folio to determin=
e if
> - * the memcg has the capacity for it. It does not commit the charge yet,
> - * as the hugetlb folio itself has not been obtained from the hugetlb po=
ol.
> - *
> - * Once we have obtained the hugetlb folio, we can call
> - * mem_cgroup_commit_charge() to commit the charge. If we fail to obtain=
 the
> - * folio, we should instead call mem_cgroup_cancel_charge() to undo the =
effect
> - * of try_charge().
> - *
> - * Returns 0 on success. Otherwise, an error code is returned.
> - */
> -int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
> -                       long nr_pages)
> -{
> -       /*
> -        * If hugetlb memcg charging is not enabled, do not fail hugetlb =
allocation,
> -        * but do not attempt to commit charge later (or cancel on error)=
 either.
> -        */
> -       if (mem_cgroup_disabled() || !memcg ||
> -               !cgroup_subsys_on_dfl(memory_cgrp_subsys) || !memcg_accou=
nts_hugetlb())
> -               return -EOPNOTSUPP;
> -
> -       if (try_charge(memcg, gfp, nr_pages))
> -               return -ENOMEM;
> -
> -       return 0;
> -}
> -
>  int mem_cgroup_charge_hugetlb(struct folio *folio, gfp_t gfp)
>  {
>         struct mem_cgroup *memcg =3D get_mem_cgroup_from_current();
> --
> 2.43.5
>
>

