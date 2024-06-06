Return-Path: <linux-kernel+bounces-204835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0798FF404
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 19:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31D561F23DE9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12A61991C7;
	Thu,  6 Jun 2024 17:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q7KLgZ3A"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448FE3BBCC
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 17:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717696001; cv=none; b=J64Gj3pSDltTKhjFCK0ViRGc9xrWoMKxjvlTckyB8A7zX7kWRV6nV/nCK2TI7BlD7AlbTUwtf82X5GMZYKJ3wGE1shhp/GjTcmHzcgfMH2A4XvGeA4wCPdd48iYhOVI/ZMOMgs26O9HGnYsDf+LKZj9eITIRbw946OIWwhrUgOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717696001; c=relaxed/simple;
	bh=HnNpWFZMlXBEsLkfSupgDPzaQ/Fenh0om4HwjI0iNnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kszydGb+wQKvtIzONmt4mCI3Ne0coy1V3j+xQ9qH83ytsOFMOvFfqNaXaKZ1HS5+THPN+2Ekmc+1zKKtvviz7Wnds5Ta8V/2TwXOPbTxBAwZssIwWdnSUdKgbfrHrsUY3RuBgsn7JsIgBDT35u3qMBxy8iyPZaqfToiRxbQYlRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q7KLgZ3A; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-80b13c93a0eso614632241.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 10:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717695999; x=1718300799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRhyW1F2lGb3fjD4x2stgo6BiduS8IQYI372u9O9y8A=;
        b=q7KLgZ3ASIPk3r1lLBT3u7MI8OX/1iWa6lqGeqZIDO8LpAcg8Cb9mDr9NNyAbjw/Po
         gxTEvMfJPlXVQDyYEMP9wnsmMlRXTZitDQ/mOdoZpAFGyWws1fzpz0iSYBfrJe2Gdyu3
         c84C4JMBA8CiXb671qoSWhAARCgChsp499ASrKOPhPEz3YbYjxBvPKHI+r6y+Ud3fiAH
         CB0fJQ/70/rH5PupwR590Al1LZzbro4qvh2jjUb2s6EWZ4jJ/BgAJQ5TIGvDtftaDsM/
         JIFbqjJb68fmTsNeXbvnjjubcnbrfFUFwRbrX96V9I+pX9c5NLtv0x+ge5in0gFo7s5n
         BqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717695999; x=1718300799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HRhyW1F2lGb3fjD4x2stgo6BiduS8IQYI372u9O9y8A=;
        b=qkwqz/pfZIcED4hKLGeQ3bwTheDq7dIoUEHRzsbkOQ9qJH96kFQYmCwG5g4AmFWTZE
         Fi6PndvOYuGHd/a21H0tbyIiEUVM23A+B/AO0A/dzRDYR+6jLYb8EuxJgTGDo69ahMUq
         PwPYaVo58FSsXHhUGqvxVecZOHgEGvSUxfRQmNKUUn4ZVTIohv8CTVg+2NAh9mmwz2Wl
         caHz3XJwntwfrnSs4lMa3W1XNlLnxNh3xhs6ZDtjLzaGJ99CcvFWV5s4826giyJnnjQc
         6kZ3HKLCb19OahnKFZMZU6jzHMvti4PEHVqCtLtv3AZ/FhD6lB1qOIcHX7v/LBwx+PgV
         tQjw==
X-Forwarded-Encrypted: i=1; AJvYcCWcuKUb57wBpmDb0rXxgspjctZFdG5tE4zgnSNZLC0hWUnZGUkIxCvppnsGtSB4+bIOP1pevpUuKO91dZpiIAZ9oBfpUxXbrTpGbCCd
X-Gm-Message-State: AOJu0YwvxPQGQOCk3fXnJDEwAE7dw2CauV0udNNV6lTBhjEXgWM7PO44
	h4hgLZY1XrZQwb87iOP9Aqqld72pdyoVuw5ZmaXLGXsnMf1UQk/6eYuCtnIAMf1XU/aav9U8ygx
	r1Wo+VXemQpQxi/RHgaewYgHj0SpifHvq20pe
X-Google-Smtp-Source: AGHT+IFcPe6HJ1jApyQ8V22o7AJvrNkEDb0YV4XLytf86GnSi5rq0No3NguPHUAaJB83wyb39C5CjyTaBzWiBYd6Bxw=
X-Received: by 2002:a67:f34f:0:b0:48b:c32e:2185 with SMTP id
 ada2fe7eead31-48c17159270mr4157262137.9.1717695998847; Thu, 06 Jun 2024
 10:46:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606165303.431215-1-flintglass@gmail.com>
In-Reply-To: <20240606165303.431215-1-flintglass@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 6 Jun 2024 10:45:59 -0700
Message-ID: <CAJD7tkZ=o3AN+4Cj5UBJv6zcrjPFW5T1_53iHB2qtShRRhKhbQ@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: limit number of zpools based on CPU and RAM
To: Takero Funaki <flintglass@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 9:53=E2=80=AFAM Takero Funaki <flintglass@gmail.com>=
 wrote:
>
> This patch limits the number of zpools used by zswap on smaller systems.
>
> Currently, zswap allocates 32 pools unconditionally. This was
> implemented to reduce contention on per-zpool locks. However, it incurs
> allocation overhead by distributing pages across pools, wasting memory
> on systems with fewer CPUs and less RAM.
>
> This patch allocates approximately 2*CPU zpools, with a minimum of 1
> zpool for single-CPU systems and up to 32 zpools for systems with 16 or
> more CPUs.  This number is sufficient to keep the probability of
> busy-waiting by a thread under 40%. The upper limit of 32 zpools remains
> unchanged.
>
> For memory, it limits to 1 zpool per 60MB of memory for the 20% default
> max pool size limit, assuming the best case with no fragmentation in
> zspages. It expects 90% pool usage for zsmalloc.
>
> Signed-off-by: Takero Funaki <flintglass@gmail.com>

There are a lot of magic numbers in this patch, and it seems like it's
all based on theory. I don't object to making the number of zpools
dynamic in some way, but unless we do it in a data-driven way where we
understand the implications, I think the added complexity and
inconsistency is not justified.

For example, 2*CPU zpools is an overkill and will cause a lot of
fragmentation. We use 32 zpools right now for machines with 100s of
CPUs. I know that you are keeping 32 as the limit, but why 2*CPUs if
nr_cpus <=3D 16?

Also, the limitation based on memory size assumes that zsmalloc is the
only allocator used by zswap, which is unfortunately not the case.

The current implementation using 32 zpools all the time is not
perfect, and I did write a patch to make it at least be min(nr_cpus,
32), but it is simple and it works. Complexity should be justified.

> ---
>  mm/zswap.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 60 insertions(+), 7 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 4de342a63bc2..e957bfdeaf70 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -124,8 +124,11 @@ static unsigned int zswap_accept_thr_percent =3D 90;=
 /* of max pool size */
>  module_param_named(accept_threshold_percent, zswap_accept_thr_percent,
>                    uint, 0644);
>
> -/* Number of zpools in zswap_pool (empirically determined for scalabilit=
y) */
> -#define ZSWAP_NR_ZPOOLS 32
> +/*
> + * Number of max zpools in zswap_pool (empirically determined for scalab=
ility)
> + * This must be order of 2, for pointer hashing.
> + */
> +#define ZSWAP_NR_ZPOOLS_MAX 32
>
>  /* Enable/disable memory pressure-based shrinker. */
>  static bool zswap_shrinker_enabled =3D IS_ENABLED(
> @@ -157,12 +160,13 @@ struct crypto_acomp_ctx {
>   * needs to be verified that it's still valid in the tree.
>   */
>  struct zswap_pool {
> -       struct zpool *zpools[ZSWAP_NR_ZPOOLS];
> +       struct zpool *zpools[ZSWAP_NR_ZPOOLS_MAX];
>         struct crypto_acomp_ctx __percpu *acomp_ctx;
>         struct percpu_ref ref;
>         struct list_head list;
>         struct work_struct release_work;
>         struct hlist_node node;
> +       unsigned char nr_zpools_order;
>         char tfm_name[CRYPTO_MAX_ALG_NAME];
>  };
>
> @@ -243,11 +247,55 @@ static inline struct xarray *swap_zswap_tree(swp_en=
try_t swp)
>         pr_debug("%s pool %s/%s\n", msg, (p)->tfm_name,         \
>                  zpool_get_type((p)->zpools[0]))
>
> +static unsigned long zswap_max_pages(void);
> +
>  /*********************************
>  * pool functions
>  **********************************/
>  static void __zswap_pool_empty(struct percpu_ref *ref);
>
> +/*
> + * Estimate the optimal number of zpools based on CPU and memory.
> + *
> + * For CPUs, aim for 40% or lower probability of busy-waiting from a thr=
ead,
> + * assuming all cores are accessing zswap concurrently.
> + * The threshold is chosen for the simplicity of the formula:
> + * The probability is 1-(1-(1/pool))^(thr-1). For 40% threshold, this is
> + * approximately pool =3D 2 * threads rounded up to orders of 2.
> + * Threads \ Pools
> + *      2       4       8       16      32
> + * 2    0.50    0.25 <  0.13    0.06    0.03
> + * 4    0.88    0.58    0.33 <  0.18    0.09
> + * 6    0.97    0.76    0.49    0.28 <  0.15
> + * 8    0.99    0.87    0.61    0.36 <  0.20
> + * 10   1.00    0.92    0.70    0.44    0.25 <
> + * 16   1.00    0.99    0.87    0.62    0.38 <
> + * 18   1.00    0.99    0.90    0.67    0.42
> + *
> + * For memory, expect 90% pool usage for zsmalloc in the best case.
> + * Assuming uniform distribution, we need to store:
> + *   590       : sum of pages_per_zspage
> + *   * 0.5     : about half of zspage is empty if no fragmentation
> + *   / (1-0.9) : 90% target usage
> + *   =3D 2950    : expected max pages of a zpool,
> + *               equivalent to 60MB RAM for a 20% max_pool_percent.
> + */
> +static void __zswap_set_nr_zpools(struct zswap_pool *pool)
> +{
> +       unsigned long mem =3D zswap_max_pages();
> +       unsigned long cpu =3D num_online_cpus();
> +
> +       mem =3D DIV_ROUND_UP(mem, 2950);
> +       mem =3D min(max(1, mem), ZSWAP_NR_ZPOOLS_MAX);
> +
> +       if (cpu <=3D 1)
> +               cpu =3D 1;
> +       else
> +               cpu =3D 1 << ilog2(min(cpu * 2, ZSWAP_NR_ZPOOLS_MAX);
> +
> +       pool->nr_zpools_order =3D ilog2(min(mem, cpu));
> +}
> +
>  static struct zswap_pool *zswap_pool_create(char *type, char *compressor=
)
>  {
>         int i;
> @@ -271,7 +319,9 @@ static struct zswap_pool *zswap_pool_create(char *typ=
e, char *compressor)
>         if (!pool)
>                 return NULL;
>
> -       for (i =3D 0; i < ZSWAP_NR_ZPOOLS; i++) {
> +       __zswap_set_nr_zpools(pool);
> +
> +       for (i =3D 0; i < (1 << pool->nr_zpools_order); i++) {
>                 /* unique name for each pool specifically required by zsm=
alloc */
>                 snprintf(name, 38, "zswap%x",
>                          atomic_inc_return(&zswap_pools_count));
> @@ -372,7 +422,7 @@ static void zswap_pool_destroy(struct zswap_pool *poo=
l)
>         cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &pool->no=
de);
>         free_percpu(pool->acomp_ctx);
>
> -       for (i =3D 0; i < ZSWAP_NR_ZPOOLS; i++)
> +       for (i =3D 0; i < (1 << pool->nr_zpools_order); i++)
>                 zpool_destroy_pool(pool->zpools[i]);
>         kfree(pool);
>  }
> @@ -513,7 +563,7 @@ unsigned long zswap_total_pages(void)
>         list_for_each_entry_rcu(pool, &zswap_pools, list) {
>                 int i;
>
> -               for (i =3D 0; i < ZSWAP_NR_ZPOOLS; i++)
> +               for (i =3D 0; i < (1 << pool->nr_zpools_order); i++)
>                         total +=3D zpool_get_total_pages(pool->zpools[i])=
;
>         }
>         rcu_read_unlock();
> @@ -822,7 +872,10 @@ static void zswap_entry_cache_free(struct zswap_entr=
y *entry)
>
>  static struct zpool *zswap_find_zpool(struct zswap_entry *entry)
>  {
> -       return entry->pool->zpools[hash_ptr(entry, ilog2(ZSWAP_NR_ZPOOLS)=
)];
> +       if (entry->pool->nr_zpools_order =3D=3D 0)
> +               return entry->pool->zpools[0];
> +
> +       return entry->pool->zpools[hash_ptr(entry, entry->pool->nr_zpools=
_order)];
>  }
>
>  /*
> --
> 2.43.0
>

