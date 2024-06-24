Return-Path: <linux-kernel+bounces-227182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3C791499A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02D49282046
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 12:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B57713B783;
	Mon, 24 Jun 2024 12:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YaVGONJF"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079072232A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 12:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719231333; cv=none; b=B637yBacUJGuQ7asbIOdJUMjs52JkOGsm1Xt+p0Xz5SKScOtZe3lS4UnksP5R3FMDseLw+L42o/jibpb/TFkuDPco5xh8Doh/NOeWIGuUrU4xLNJqQThXv6lyDNgx8BQWlCircABxDxqYBXtiMIvqyIy7YjWmmnCU1nRIH+Wz6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719231333; c=relaxed/simple;
	bh=xB3jc8JBrcnafMCdPaVW7LYaQa6NMAwud2DG8BDdnis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CD8bac5Jl/6pdv3UU063T6DFpOVH0ZIul3BbWujHILLiEfHbMyEU5HmH0jAeeT8ErjdI7AYxr+jFB1W5FcT9PYaTWx7XfkQCg7kC6M5FAANT2TPW7oDj5e/p6rYcbz5tNc+93VipawPOHfpmupJ8OGLEhJdDuUqMeDgYAAYiBoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YaVGONJF; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7245453319so217563666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 05:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719231330; x=1719836130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Rn8JlgpPAk4s18V2/yagiw1mvhWTbcQX4Wl/KIshJs=;
        b=YaVGONJFzgE7OiZTwJ2JkDNoMi9zHL8JZZYbPsUAGknlX6YeLu8wlZBbpXIoAbd9T8
         2rW33C5xYzkj+pYJ3bMZkKQGekojlbJ1prHL8WJKlXgUTPayJQBqyMOsgfDvhCs+6ObY
         n/n6MKfrAYHBMTiSpoqcSTNI2IpQflBfTDAiu3PBSe3rrwjfsJQXcBbTFcjE2ruS5B4x
         +oIhjcDC1b8+pDIPWE/sbbhFnp+AZY/QXAracC8UXKQvBaF5m2QLsSycxQO6Mfz/0mvp
         4FFYdRc+gDuqfUkNLCD5vlZaz3ZO3gg1LyAauNxyGUZhzNTiT2n+XufZRU85pZo4/Ewy
         iv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719231330; x=1719836130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Rn8JlgpPAk4s18V2/yagiw1mvhWTbcQX4Wl/KIshJs=;
        b=O85PGBtJRnC8IoDzMdz+UsNKKM8viGXXe7P7+ISsjo7j/4ORHpuvJfB50aqjjBgUzU
         mJb2Bhqs4fWHjvLMF4QY15Ju+A4PHvR3VEHllz/nLjqQrx3A+u5ra6Iqu6ri9Mioi6Rq
         DGti4z0ZhUtT94qPENTDqRmi99Sl1Mc9yt09GHGeGoAEfSbovp+vn88SL8rTuRMqlPr4
         i5Fio2Zje6V+tPTQ6GKr1b82adfPUxvuJDoP9bWRkhTNv8wUiYWt95FbO5cDbnVqp/Ya
         2/vjJ5ps4vlekiRdKeXy3WE8C3GA8s11uWpSxxXSmNZMDjjuaLHQBCXgqeTaZq0LkmzM
         Fa9g==
X-Forwarded-Encrypted: i=1; AJvYcCU7s6h6S7soeEM075npT4f4zY2OJERDQDLuUPK0ZnizVRWxJqj6GcQmfRw52/T6or96pyRXM/UB6le3KuIYFtrxqTOc/kDjJqXUeFfP
X-Gm-Message-State: AOJu0Yz7fYwwWPwCTbA4WCUYKJjw9gXCN+l002KLbZkuvk4S3hf8HjUM
	znTK3RWuyAjG0JEbM+tO8tj/1i9mdCOFoQzyZRNy0utTVePJ8ZleHRY/+SMcbPIUNqRnSmweLBC
	tj9bP/WSslrD8LQSebZZ2SXAvDFSOmPuRkqzI
X-Google-Smtp-Source: AGHT+IGSKV4fU1bi706Eu3CbP9AhRzpsXlqcY5iC2z9Vo8PRO/8Eec0SObLM2788WGTPyjSrt9tF3ntG0wNdZVr/By8=
X-Received: by 2002:a17:906:580a:b0:a6e:f793:fcf6 with SMTP id
 a640c23a62f3a-a6ffe39d9aamr399384666b.16.1719231329826; Mon, 24 Jun 2024
 05:15:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621-zsmalloc-lock-mm-everything-v2-0-d30e9cd2b793@linux.dev> <20240621-zsmalloc-lock-mm-everything-v2-2-d30e9cd2b793@linux.dev>
In-Reply-To: <20240621-zsmalloc-lock-mm-everything-v2-2-d30e9cd2b793@linux.dev>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 24 Jun 2024 05:14:53 -0700
Message-ID: <CAJD7tkYUuAdwhSbq+m9KTtC2T8db7tiaKYjfS0M4LOA1yBtCkA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm/zswap: use only one pool in zswap
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Yu Zhao <yuzhao@google.com>, 
	Takero Funaki <flintglass@gmail.com>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 12:15=E2=80=AFAM Chengming Zhou
<chengming.zhou@linux.dev> wrote:
>
> Zswap uses 32 pools to workaround the locking scalability problem in
> zswap backends (mainly zsmalloc nowadays), which brings its own problems
> like memory waste and more memory fragmentation.
>
> Testing results show that we can have near performance with only one
> pool in zswap after changing zsmalloc to use per-size_class lock instead
> of pool spinlock.
>
> Testing kernel build (make bzImage -j32) on tmpfs with memory.max=3D1GB,
> and zswap shrinker enabled with 10GB swapfile on ext4.
>
>                                 real    user    sys
> 6.10.0-rc3                      138.18  1241.38 1452.73
> 6.10.0-rc3-onepool              149.45  1240.45 1844.69
> 6.10.0-rc3-onepool-perclass     138.23  1242.37 1469.71
>
> And do the same testing using zbud, which shows a little worse performanc=
e
> as expected since we don't do any locking optimization for zbud. I think
> it's acceptable since zsmalloc became a lot more popular than other
> backends, and we may want to support only zsmalloc in the future.
>
>                                 real    user    sys
> 6.10.0-rc3-zbud                 138.23  1239.58 1430.09
> 6.10.0-rc3-onepool-zbud         139.64  1241.37 1516.59
>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
> ---
>  mm/zswap.c | 60 +++++++++++++++++++-------------------------------------=
----
>  1 file changed, 19 insertions(+), 41 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index e25a6808c2ed..7925a3d0903e 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -122,9 +122,6 @@ static unsigned int zswap_accept_thr_percent =3D 90; =
/* of max pool size */
>  module_param_named(accept_threshold_percent, zswap_accept_thr_percent,
>                    uint, 0644);
>
> -/* Number of zpools in zswap_pool (empirically determined for scalabilit=
y) */
> -#define ZSWAP_NR_ZPOOLS 32
> -
>  /* Enable/disable memory pressure-based shrinker. */
>  static bool zswap_shrinker_enabled =3D IS_ENABLED(
>                 CONFIG_ZSWAP_SHRINKER_DEFAULT_ON);
> @@ -160,7 +157,7 @@ struct crypto_acomp_ctx {
>   * needs to be verified that it's still valid in the tree.
>   */
>  struct zswap_pool {
> -       struct zpool *zpools[ZSWAP_NR_ZPOOLS];
> +       struct zpool *zpool;
>         struct crypto_acomp_ctx __percpu *acomp_ctx;
>         struct percpu_ref ref;
>         struct list_head list;
> @@ -237,7 +234,7 @@ static inline struct xarray *swap_zswap_tree(swp_entr=
y_t swp)
>
>  #define zswap_pool_debug(msg, p)                               \
>         pr_debug("%s pool %s/%s\n", msg, (p)->tfm_name,         \
> -                zpool_get_type((p)->zpools[0]))
> +                zpool_get_type((p)->zpool))
>
>  /*********************************
>  * pool functions
> @@ -246,7 +243,6 @@ static void __zswap_pool_empty(struct percpu_ref *ref=
);
>
>  static struct zswap_pool *zswap_pool_create(char *type, char *compressor=
)
>  {
> -       int i;
>         struct zswap_pool *pool;
>         char name[38]; /* 'zswap' + 32 char (max) num + \0 */
>         gfp_t gfp =3D __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM=
;
> @@ -267,18 +263,14 @@ static struct zswap_pool *zswap_pool_create(char *t=
ype, char *compressor)
>         if (!pool)
>                 return NULL;
>
> -       for (i =3D 0; i < ZSWAP_NR_ZPOOLS; i++) {
> -               /* unique name for each pool specifically required by zsm=
alloc */
> -               snprintf(name, 38, "zswap%x",
> -                        atomic_inc_return(&zswap_pools_count));
> -
> -               pool->zpools[i] =3D zpool_create_pool(type, name, gfp);
> -               if (!pool->zpools[i]) {
> -                       pr_err("%s zpool not available\n", type);
> -                       goto error;
> -               }
> +       /* unique name for each pool specifically required by zsmalloc */
> +       snprintf(name, 38, "zswap%x", atomic_inc_return(&zswap_pools_coun=
t));
> +       pool->zpool =3D zpool_create_pool(type, name, gfp);
> +       if (!pool->zpool) {
> +               pr_err("%s zpool not available\n", type);
> +               return NULL;

We need to goto error here to free the pool.

>         }
> -       pr_debug("using %s zpool\n", zpool_get_type(pool->zpools[0]));
> +       pr_debug("using %s zpool\n", zpool_get_type(pool->zpool));
>
>         strscpy(pool->tfm_name, compressor, sizeof(pool->tfm_name));
>
> @@ -311,8 +303,7 @@ static struct zswap_pool *zswap_pool_create(char *typ=
e, char *compressor)
>  error:
>         if (pool->acomp_ctx)
>                 free_percpu(pool->acomp_ctx);
> -       while (i--)
> -               zpool_destroy_pool(pool->zpools[i]);
> +       zpool_destroy_pool(pool->zpool);

.. and then we will need a NULL check needed here.

