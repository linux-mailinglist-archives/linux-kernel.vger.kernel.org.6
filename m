Return-Path: <linux-kernel+bounces-192710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B558D2109
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F78D1F25601
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E80172BDF;
	Tue, 28 May 2024 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eN4I56CW"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CABC17279F;
	Tue, 28 May 2024 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716912110; cv=none; b=rW3IsCqIVe9JFK/+D0Lj148e7z69FtS+nGXEQf91VOPiHuyHFhOga/smH54xv8qG03KQJm5sgaatxhFX98Zq7ExmvZSS2/baoPA9UHebYDxX14q121jSbB/ehGVo8svpm64qJz0mSu8XaElCeXCmSYoG8fyVXMeumB5mcyrRyvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716912110; c=relaxed/simple;
	bh=910O4hjh2+s+PhCpXIR4jsebgLIipcKRKXjPJ08nqRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ADLlUzevTbPl+oDKzr10A2YV11EymeKkhNU5V8NQZ2jbckwTceLb3ROA1Atvd1TGlRhtTVxg2QBOYA4UkjZTrJXu0WRaZzj3dGHApMMfsQwdH5A5nallDKAbJyKzHPvYKjWs8lu1TNHi+7UXfwv13zXbJ/JryoqmogWX6+UZ/58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eN4I56CW; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6ab9d01c479so4266986d6.1;
        Tue, 28 May 2024 09:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716912108; x=1717516908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IgAQEmp/9ugkOjEiZVdx8d+ta4a/jU4FQbSX/JXp4y4=;
        b=eN4I56CWltApLBUry8jDegSgMJsbqiAjTzYoLst2Wu0063YeKd3hlTTREr+q79NBRo
         PANcRJtsjz1U2R5YhF2lveX7hjTlpsyAboLVubCBQaqUJmv2iSRC7tmKJQWGZ+0wULKE
         rwkeUr4LJf41kz6uNHG3Twqth9BVxEdw190zxHF4ws882McsFFlX52+KYXI3oOwFK+0i
         4u4CaGYK1E8DQ/LFw8ww95atPiN7zLaz4do3Ce69+LwmF5fPO43SvdeoMK/7R5fXUj8x
         dyusdAOXQxWP5gUGKyev0i+Ly9KL9Xmf9klwmss8Txs0OT0scDkrFpFRsf2u/T4M5lW8
         Pl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716912108; x=1717516908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IgAQEmp/9ugkOjEiZVdx8d+ta4a/jU4FQbSX/JXp4y4=;
        b=cxa3oyPtF33yM5NaqFkBSktxmX9m/S6zzKXBxMJRWq4q1PHtddhmFiZ07QgVa14kAn
         w3x5Sot8fyYQIGImAN2TDT1yZLUnoojMDwzm6mXvkJS1kxKehx1vuJNX5CbTP68oCua9
         +x98lcDstgs9Gn+4VFI64W02/dsAqk23a3TvMA+t3tHXUVYusdZ6S1RQ6/lVIlqYjRsc
         UsMwE3BkkLKo86ZXu5n/z33tKeMM/4T9MDsZ/hHNufGOGNP4HkMrdX9W1Y+uXoXGSixi
         ZvsaeAOKboIlIy1qmgRyfVBC3B1MPy1fwUul+xX+ea8Vnn7UWYfxF9W/FnvsFDwPmSwg
         BkbA==
X-Forwarded-Encrypted: i=1; AJvYcCVFk0V9Qe7mInvo3PmZy/2Z4gnrg1ZXdiTlerWH0nv2G4WWcKNS1bZMpbcF1CIZLkaFzw06Pu3mAOLka5tbGtYn1bUAxhFVPzSgncstWTrxe9AvetohBPctBp7nbRH5LTG+WV2Tpf+T
X-Gm-Message-State: AOJu0Yyw/OcZd7Ca90a0FrDeZuQB+omFjR4BW9uIXADLY+fEBh3ODtH4
	PRv2wmKI926xfFa6Y25QFQXs7y9pCi3XyOdDws/8R2VgRc4qzcspO2Xr7kCGsWIpvMJRyf/knpM
	bpHHHoaOnvlwDNV++tof4P3GYC9k=
X-Google-Smtp-Source: AGHT+IErq1RgS2UwbDZJYY8Aq3VeTlaBalztTGCZ2nGKJoFHybIwsc/cJ515dPOkBjiscIGbF1j71blg3eIfF8RbsI0=
X-Received: by 2002:a05:6214:4b08:b0:6ad:8073:9043 with SMTP id
 6a1803df08f44-6ad807391ccmr67368856d6.11.1716912107862; Tue, 28 May 2024
 09:01:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528043404.39327-2-flintglass@gmail.com> <20240528043404.39327-5-flintglass@gmail.com>
In-Reply-To: <20240528043404.39327-5-flintglass@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 28 May 2024 09:01:36 -0700
Message-ID: <CAKEwX=NcdpgGTp8Kj_kiTkvAK=k8kzayhMo+oeaXGZFA5RuoEw@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: zswap: proactive shrinking before pool size limit
 is hit
To: Takero Funaki <flintglass@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 9:34=E2=80=AFPM Takero Funaki <flintglass@gmail.com=
> wrote:
>
> This patch implements proactive shrinking of zswap pool before the max
> pool size limit is reached. This also changes zswap to accept new pages
> while the shrinker is running.
>
> To prevent zswap from rejecting new pages and incurring latency when
> zswap is full, this patch queues the global shrinker by a pool usage
> threshold at the middle of 100% and accept_thr_percent, instead of the
> max pool size.  The pool size will be controlled between 90% to 95% for
> the default accept_thr_percent=3D90.  Since the current global shrinker
> continues to shrink until accept_thr_percent, we do not need to maintain
> the hysteresis variable tracking the pool limit overage in
> zswap_store().
>
> Before this patch, zswap rejected pages while the shrinker is running
> without incrementing zswap_pool_limit_hit counter. It could be a reason
> why zswap writethrough new pages before writeback old pages.  With this
> patch, zswap accepts new pages while shrinking, and zswap increments
> the counter when and only when zswap rejects pages by the max pool size.
>
> The name of sysfs tunable accept_thr_percent is unchanged as it is still
> the stop condition of the shrinker.
> The respective documentation is updated to describe the new behavior.

I'm a bit unsure about using this tunable. How would the user
determine the level at which the zswap pool should be kept empty?

I was actually thinking of removing this knob altogether :)

>
> Signed-off-by: Takero Funaki <flintglass@gmail.com>
> ---
>  Documentation/admin-guide/mm/zswap.rst | 17 +++++----
>  mm/zswap.c                             | 49 +++++++++++++++-----------
>  2 files changed, 37 insertions(+), 29 deletions(-)
>
> diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation/admin=
-guide/mm/zswap.rst
> index 3598dcd7dbe7..a1d8f167a27a 100644
> --- a/Documentation/admin-guide/mm/zswap.rst
> +++ b/Documentation/admin-guide/mm/zswap.rst
> @@ -111,18 +111,17 @@ checked if it is a same-value filled page before co=
mpressing it. If true, the
>  compressed length of the page is set to zero and the pattern or same-fil=
led
>  value is stored.
>
> -To prevent zswap from shrinking pool when zswap is full and there's a hi=
gh
> -pressure on swap (this will result in flipping pages in and out zswap po=
ol
> -without any real benefit but with a performance drop for the system), a
> -special parameter has been introduced to implement a sort of hysteresis =
to
> -refuse taking pages into zswap pool until it has sufficient space if the=
 limit
> -has been hit. To set the threshold at which zswap would start accepting =
pages
> -again after it became full, use the sysfs ``accept_threshold_percent``
> -attribute, e. g.::
> +To prevent zswap from rejecting new pages and incurring latency when zsw=
ap is
> +full, zswap initiates a worker called global shrinker that proactively e=
victs
> +some pages from the pool to swap devices while the pool is reaching the =
limit.
> +The global shrinker continues to evict pages until there is sufficient s=
pace to
> +accept new pages. To control how many pages should remain in the pool, u=
se the
> +sysfs ``accept_threshold_percent`` attribute as a percentage of the max =
pool
> +size, e. g.::
>
>         echo 80 > /sys/module/zswap/parameters/accept_threshold_percent
>
> -Setting this parameter to 100 will disable the hysteresis.
> +Setting this parameter to 100 will disable the proactive shrinking.
>
>  Some users cannot tolerate the swapping that comes with zswap store fail=
ures
>  and zswap writebacks. Swapping can be disabled entirely (without disabli=
ng
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 08a6f5a6bf62..0186224be8fc 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -71,8 +71,6 @@ static u64 zswap_reject_kmemcache_fail;
>
>  /* Shrinker work queue */
>  static struct workqueue_struct *shrink_wq;
> -/* Pool limit was hit, we need to calm down */
> -static bool zswap_pool_reached_full;
>
>  /*********************************
>  * tunables
> @@ -118,7 +116,10 @@ module_param_cb(zpool, &zswap_zpool_param_ops, &zswa=
p_zpool_type, 0644);
>  static unsigned int zswap_max_pool_percent =3D 20;
>  module_param_named(max_pool_percent, zswap_max_pool_percent, uint, 0644)=
;
>
> -/* The threshold for accepting new pages after the max_pool_percent was =
hit */
> +/*
> + * The percentage of pool size that the global shrinker keeps in memory.
> + * It does not protect old pages from the dynamic shrinker.
> + */
>  static unsigned int zswap_accept_thr_percent =3D 90; /* of max pool size=
 */
>  module_param_named(accept_threshold_percent, zswap_accept_thr_percent,
>                    uint, 0644);
> @@ -487,6 +488,14 @@ static unsigned long zswap_accept_thr_pages(void)
>         return zswap_max_pages() * zswap_accept_thr_percent / 100;
>  }
>
> +/*
> + * Returns threshold to start proactive global shrinking.
> + */
> +static inline unsigned long zswap_shrink_start_pages(void)
> +{
> +       return zswap_max_pages() * (100 - (100 - zswap_accept_thr_percent=
)/2) / 100;
> +}
> +
>  unsigned long zswap_total_pages(void)
>  {
>         struct zswap_pool *pool;
> @@ -504,21 +513,6 @@ unsigned long zswap_total_pages(void)
>         return total;
>  }
>
> -static bool zswap_check_limits(void)
> -{
> -       unsigned long cur_pages =3D zswap_total_pages();
> -       unsigned long max_pages =3D zswap_max_pages();
> -
> -       if (cur_pages >=3D max_pages) {
> -               zswap_pool_limit_hit++;
> -               zswap_pool_reached_full =3D true;
> -       } else if (zswap_pool_reached_full &&
> -                  cur_pages <=3D zswap_accept_thr_pages()) {
> -                       zswap_pool_reached_full =3D false;
> -       }
> -       return zswap_pool_reached_full;
> -}
> -
>  /*********************************
>  * param callbacks
>  **********************************/
> @@ -1475,6 +1469,8 @@ bool zswap_store(struct folio *folio)
>         struct obj_cgroup *objcg =3D NULL;
>         struct mem_cgroup *memcg =3D NULL;
>         unsigned long value;
> +       unsigned long cur_pages;
> +       bool need_global_shrink =3D false;
>
>         VM_WARN_ON_ONCE(!folio_test_locked(folio));
>         VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> @@ -1497,8 +1493,18 @@ bool zswap_store(struct folio *folio)
>                 mem_cgroup_put(memcg);
>         }
>
> -       if (zswap_check_limits())
> +       cur_pages =3D zswap_total_pages();
> +
> +       if (cur_pages >=3D zswap_max_pages()) {
> +               zswap_pool_limit_hit++;
> +               need_global_shrink =3D true;
>                 goto reject;
> +       }
> +
> +       /* schedule shrink for incoming pages */
> +       if (cur_pages >=3D zswap_shrink_start_pages()
> +                       && !work_pending(&zswap_shrink_work))
> +               queue_work(shrink_wq, &zswap_shrink_work);

I think work_pending() check here is redundant. If you look at the
documentation, queue_work only succeeds if zswap_shrink_work is not
already on the shrink_wq workqueue.

More specifically, if you check the code, queue_work calls
queue_work_on, which has this check:

if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)) &&
   !clear_pending_if_disabled(work)) {

This is the same bit-check as work_pending, which is defined as:

#define work_pending(work) \
test_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))


>
>         /* allocate entry */
>         entry =3D zswap_entry_cache_alloc(GFP_KERNEL, folio_nid(folio));
> @@ -1541,6 +1547,9 @@ bool zswap_store(struct folio *folio)
>
>                 WARN_ONCE(err !=3D -ENOMEM, "unexpected xarray error: %d\=
n", err);
>                 zswap_reject_alloc_fail++;
> +
> +               /* reduce entry in array */
> +               need_global_shrink =3D true;
>                 goto store_failed;
>         }
>
> @@ -1590,7 +1599,7 @@ bool zswap_store(struct folio *folio)
>         zswap_entry_cache_free(entry);
>  reject:
>         obj_cgroup_put(objcg);
> -       if (zswap_pool_reached_full)
> +       if (need_global_shrink && !work_pending(&zswap_shrink_work))
>                 queue_work(shrink_wq, &zswap_shrink_work);
>  check_old:
>         /*
> --
> 2.43.0
>

