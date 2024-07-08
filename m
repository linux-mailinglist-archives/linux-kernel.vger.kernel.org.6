Return-Path: <linux-kernel+bounces-244798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D316692A9B2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 385E4B21FD3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 19:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45E714E2D7;
	Mon,  8 Jul 2024 19:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mntH/O55"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E17146D74;
	Mon,  8 Jul 2024 19:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720466247; cv=none; b=Q+jpjvNyMfiGqoUGVn4Xa0ORuYIOVReHFHuslxZLEaZRocKd0guO3uF2SN4UX29x5onb9fPyW4BGfyl9G5sU0te2RyMX+zxqEFfa1IzGl3YVGVRwzCpkBCIW06CgG8P6BDFL1xKQz9y5WehMpRSEan9LJ/g4H9jto5w5A0OkCvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720466247; c=relaxed/simple;
	bh=K4f4eJD+xtTkg747FWbJ8u+ZmkC0YWeWXjMD5iy1An0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T+OMsxXlX/Yvjq6lo1lBRCkxLMuUNDhnXiHVUdY7rpV7FxbI6oMQpDNzuDonPhylumFQLqnjJtYMb5C+O87namEvCrLTDFj9ql7IfqPtclGLi6umbLjr5Ppv6q75J8PgQNZcQxPDjICkdDaZ8YLffHBVIXkCYdwqShV82T1Fqms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mntH/O55; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b5eb69e04cso25905656d6.1;
        Mon, 08 Jul 2024 12:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720466244; x=1721071044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LoMHwWvMZITG0MKYsYImhjMa8QW8VMCVVEOqRiLhyAE=;
        b=mntH/O55YoMr7eU+nu7DclFOmI7y6dg/+unSre4uybEgovuXlVtKTHjooALJiQygA2
         UmQRwxfnnGc2YiDytmuPXuGnNHaSQBkIxQp5wNDOzZ9pz7E6p8rFlyeNnbioUC8Nu6mO
         WylLs4nOlCDH6Uk/0rTj6fUJOQlGG+Rumsp+WjEQvSyVqVb5YkD0V8+QugddH8+STs7B
         KZPhiWX9HRIfSwJ4l9SQExp0WiauNbShY4HRBg1KD/xLeeFsct2Y3lx/mNV6C8TpFeHI
         3lGHIMbtMtT7CAOjead67VmqnVoYGiqVIdb25YF8CE6mss15Bm0pr0+KBek80QH/5UGv
         Ohuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720466244; x=1721071044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LoMHwWvMZITG0MKYsYImhjMa8QW8VMCVVEOqRiLhyAE=;
        b=c+vrwRT0hRS4q2hU2c6p9/7F98FOBV9xMMSrVxp0O4gxneB1i4F8lTXzd/6P+REVKM
         +brm1RWUoxZHXRCnwsuG9rAwN6nwRHuWuON1+n7eIjBAL2VQv6fAM+1VVxXth8fkO9nJ
         qbH9FpCHtEfottXPiG7zFgQDvTXOiyX9OZeIh9MyP8IqxFZxJd/vnSoMjPkXQKFC3n2I
         X5K8oqCzaMOzzM506xxsKy3Yyv4nkeJGdLX/S5hSIMKQmYxXQOTsG+exlmpRVJ7wwxKx
         3SW+kfQdaiDwAoyMzmO8qlizEOJ93qQakR8mg/SLezzLm3l2DAPS9EtAAddsklXNypXP
         bK7g==
X-Forwarded-Encrypted: i=1; AJvYcCXpq+d8Nj7PHkwdA9l9+ioi34LjWLDRAyroUo+4gZ3fwBpPLYyr/hrHjPWsSsHWz3LmS5n0+1OhhifbSyTQc3t7KVpYMaAgFax4gl1+ujRkJFWBijkqgXcJLZny1KlvDdtUyzfa62K3
X-Gm-Message-State: AOJu0YyriYYf0qtmdw2H8DGmuwhlSABu7hjUxgvY9xryaca54pR3j0MU
	lsGaoOoQ7+zCaM8b9S5L7FTarodHe9+AmxTdpc/VZSWG+oU8GUfRJJllm+2HmibIhJNLYPOJ5K9
	YRhm+Xnat9Szd7CauCYxIrDKxqpU=
X-Google-Smtp-Source: AGHT+IHLnrS5ones95lU+A08RP/q9bJ3HfGVZ7UcfmdzyCJdzEaMdABPZHSXmlD8dlGsauWpvoWXzWX85VWrrG+uDmM=
X-Received: by 2002:a05:6214:acf:b0:6b5:db70:b980 with SMTP id
 6a1803df08f44-6b61bc83bfcmr7678756d6.4.1720466243938; Mon, 08 Jul 2024
 12:17:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706022523.1104080-1-flintglass@gmail.com> <20240706022523.1104080-7-flintglass@gmail.com>
In-Reply-To: <20240706022523.1104080-7-flintglass@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 8 Jul 2024 12:17:12 -0700
Message-ID: <CAKEwX=NzLWSO4oiNBFhsqurOCX=cYVWTUkhRdmOsrqxOz+xi0g@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] mm: zswap: interrupt shrinker writeback while
 pagein/out IO
To: Takero Funaki <flintglass@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 7:25=E2=80=AFPM Takero Funaki <flintglass@gmail.com>=
 wrote:
>
> To prevent the zswap global shrinker from writing back pages
> simultaneously with IO performed for memory reclaim and faults, delay
> the writeback when zswap_store() rejects pages or zswap_load() cannot
> find entry in pool.
>
> When the zswap shrinker is running and zswap rejects an incoming page,
> simulatenous zswap writeback and the rejected page lead to IO contention
> on swap device. In this case, the writeback of the rejected page must be
> higher priority as it is necessary for actual memory reclaim progress.
> The zswap global shrinker can run in the background and should not
> interfere with memory reclaim.

Do you see this problem actually manifesting in real life? Does not
sound infeasible to me, but I wonder how likely this is the case.

Do you have any userspace-visible metrics, or any tracing logs etc.
that proves that it actually happens?

This might also affect the dynamic shrinker as well FWIW.

>
> The same logic applies to zswap_load(). When zswap cannot find requested
> page from pool and read IO is performed, shrinker should be interrupted.
>
> To avoid IO contention, save the timestamp jiffies when zswap cannot
> buffer the pagein/out IO and interrupt the global shrinker. The shrinker
> resumes the writeback in 500 msec since the saved timestamp.
>
> Signed-off-by: Takero Funaki <flintglass@gmail.com>
> ---
>  mm/zswap.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 45 insertions(+), 2 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index def0f948a4ab..59ba4663c74f 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -35,6 +35,8 @@
>  #include <linux/pagemap.h>
>  #include <linux/workqueue.h>
>  #include <linux/list_lru.h>
> +#include <linux/delay.h>
> +#include <linux/jiffies.h>
>
>  #include "swap.h"
>  #include "internal.h"
> @@ -176,6 +178,14 @@ static bool zswap_next_shrink_changed;
>  static struct work_struct zswap_shrink_work;
>  static struct shrinker *zswap_shrinker;
>
> +/*
> + * To avoid IO contention between pagein/out and global shrinker writeba=
ck,
> + * track the last jiffies of pagein/out and delay the writeback.
> + * Default to 500msec in alignment with mq-deadline read timeout.

If there is a future version, could you include the reason why you
select 500msec in the patch's changelog as well?

> + */
> +#define ZSWAP_GLOBAL_SHRINKER_DELAY_MS 500
> +static unsigned long zswap_shrinker_delay_start;
> +
>  /*
>   * struct zswap_entry
>   *
> @@ -244,6 +254,14 @@ static inline struct xarray *swap_zswap_tree(swp_ent=
ry_t swp)
>         pr_debug("%s pool %s/%s\n", msg, (p)->tfm_name,         \
>                  zpool_get_type((p)->zpools[0]))
>
> +static inline void zswap_shrinker_delay_update(void)
> +{
> +       unsigned long now =3D jiffies;
> +
> +       if (now !=3D zswap_shrinker_delay_start)
> +               zswap_shrinker_delay_start =3D now;
> +}

Hmmm is there a reason why we do not just do:

zswap_shrinker_delay_start =3D jiffies;

or, more unnecessarily:

unsigned long now =3D jiffies;

zswap_shrinker_delay_start =3D now;

IOW, why the branching here? Does not seem necessary to me, but
perhaps there is a correctness/compiler reason I'm not seeing?

In fact, if it's the first version, then we could manually inline it.

Additionally/alternatively, I wonder if it is more convenient to do it
at the mm/page_io.c zswap callsites, i.e whenever zswap_store() and
zswap_load() returns false, then delay the shrinker before proceeding
with the IO steps.

> +
>  /*********************************
>  * pool functions
>  **********************************/
> @@ -1378,6 +1396,8 @@ static void shrink_worker(struct work_struct *w)
>         struct mem_cgroup *memcg;
>         int ret, failures =3D 0, progress;
>         unsigned long thr;
> +       unsigned long now, sleepuntil;
> +       const unsigned long delay =3D msecs_to_jiffies(ZSWAP_GLOBAL_SHRIN=
KER_DELAY_MS);
>
>         /* Reclaim down to the accept threshold */
>         thr =3D zswap_accept_thr_pages();
> @@ -1405,6 +1425,21 @@ static void shrink_worker(struct work_struct *w)
>          * until the next run of shrink_worker().
>          */
>         do {
> +               /*
> +                * delay shrinking to allow the last rejected page comple=
tes
> +                * its writeback
> +                */
> +               sleepuntil =3D delay + READ_ONCE(zswap_shrinker_delay_sta=
rt);

I assume we do not care about racy access here right? Same goes for
updates - I don't see any locks protecting these operations (but I
could be missing something).


> +               now =3D jiffies;
> +               /*
> +                * If zswap did not reject pages for long, sleepuntil-now=
 may
> +                * underflow.  We assume the timestamp is valid only if
> +                * now < sleepuntil < now + delay + 1
> +                */
> +               if (time_before(now, sleepuntil) &&
> +                               time_before(sleepuntil, now + delay + 1))
> +                       fsleep(jiffies_to_usecs(sleepuntil - now));
> +
>                 spin_lock(&zswap_shrink_lock);
>
>                 /*
> @@ -1526,8 +1561,10 @@ bool zswap_store(struct folio *folio)
>         VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
>
>         /* Large folios aren't supported */
> -       if (folio_test_large(folio))
> +       if (folio_test_large(folio)) {
> +               zswap_shrinker_delay_update();
>                 return false;
> +       }
>
>         if (!zswap_enabled)
>                 goto check_old;
> @@ -1648,6 +1685,8 @@ bool zswap_store(struct folio *folio)
>         zswap_entry_cache_free(entry);
>  reject:
>         obj_cgroup_put(objcg);
> +       zswap_shrinker_delay_update();
> +
>         if (need_global_shrink)
>                 queue_work(shrink_wq, &zswap_shrink_work);
>  check_old:
> @@ -1691,8 +1730,10 @@ bool zswap_load(struct folio *folio)
>         else
>                 entry =3D xa_load(tree, offset);
>
> -       if (!entry)
> +       if (!entry) {
> +               zswap_shrinker_delay_update();
>                 return false;
> +       }
>
>         if (entry->length)
>                 zswap_decompress(entry, page);
> @@ -1835,6 +1876,8 @@ static int zswap_setup(void)
>         if (ret)
>                 goto hp_fail;
>
> +       zswap_shrinker_delay_update();
> +
>         shrink_wq =3D alloc_workqueue("zswap-shrink",
>                         WQ_UNBOUND, 1);
>         if (!shrink_wq)
> --
> 2.43.0
>

