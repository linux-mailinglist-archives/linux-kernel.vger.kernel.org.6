Return-Path: <linux-kernel+bounces-254616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF17E933580
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 04:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7504B2840FF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 02:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48AE566A;
	Wed, 17 Jul 2024 02:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3hPNjBW3"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86958AD21
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 02:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721184021; cv=none; b=n1h3Nr3JqcWWb6VShCNytVgGUQkcVyy05CmQvxdk6ycZb1Aw8Fr4Ej9Fy/0yfX62ogCE+5+Rmzfml9xAGFBHLJJE3mVnfpUQjzUYubjNQShPQxhTeBIgV6mr6BEfg0KxNWGHM4wnjyw0UQPPpGcopEQJBAi2PAnntOdkOOURz2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721184021; c=relaxed/simple;
	bh=75XATE9RKK2TR951t5MjICEmUyfWO3oof1OVB4NBLCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TaU1Tu4TUs3Zuo96IxgICBLGCOTM+frT9rJita2cYoNL3G21FCcRcRoQwf3KkfrsOljmYMu6oPf+uPzYKY43zv3mLehUbpUe2ZT5gx/hT8u5hYHhVEsQNHzozyJwhvYH6g/znBL+W+pII42lMT8N8ZCfZMNvlLoPrln2hmmviBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3hPNjBW3; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-36798779d75so5619209f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 19:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721184018; x=1721788818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zm3VZqqxmL9kr77/aMbZkRuLYRNgUU0cP/KPPl+urNY=;
        b=3hPNjBW3OpgusCGrsnu+GGmK8NVaEYII4YBjf3si2GEa9BHT4jGjcMsfQVHMXR8L6z
         Jy+T0amhc7alM6IxtrBGHGajgYrQmRibY37d9AiBfJHA5Kw8UCjj8pdWviezLMJ2LhoH
         90JYFdwKyFubnn3VBF9qsr23W6ZWpgQ7zwF/SmYYnVuuu1qozz9oDdGO0B3JG8jxkAaV
         wg7cGtQQEMSZqHQuyQ2kLidXjLXtUKGioC2yFmdloxb81lCxKUSgL/N58TT4oEHo1oy9
         1WJHKfGC2hCamwZGdPlOW3XAW+WXsi2QC9+4rA7+UJunhT2TtAbN4Fo5LlHxwaXPd9Mc
         FwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721184018; x=1721788818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zm3VZqqxmL9kr77/aMbZkRuLYRNgUU0cP/KPPl+urNY=;
        b=PErBkQaykK5GdQC8xyF+VpaH42lZd2RHU2jSqONMEWvLqhCx4NmqWyCEHgdrsjjGWx
         Y+JvOAgC1CMmmHHys2SUid1UZNrYLfhuI10JJjeD/zHCaWk1NUeMPQZsfSVgAg1iFtaj
         7+W8ePBpUjJSyLs3Nsh6YANLUMUmTQVd7xMnWGwQy1p2tT84dG36pDjs8KOoQvORIujh
         wM0nL5zjj/i5L2QuPHZX6ht8NIhxKYg43w6qz9UsN2xAXRDVUlcLcsX4EuJZwZP17i+g
         0p6v3tO8862qWJG/oexGMQ9rV6f11NwwCD4tbffnNQQKrtOirivnbuF0O45/ArYI5tzW
         wcCw==
X-Forwarded-Encrypted: i=1; AJvYcCW2m8KVbzm+11jzrwc0Q+t+KSNiubpKsknuyxI5AlNOkyxFs81G6Ff9C9LS4syLCmhVIM4ygDmwcFM0MbYLghvSa140lffpD9oHBd/Q
X-Gm-Message-State: AOJu0YzShl6qWDvNqf3/ydTe7XRIc7c87+daXLe/0EjD3NUqQqRjoED9
	EzvgV3SldZSxIOVYOMV0/Zql2svk372Wc5JzjoE+LJtnD0wmGPnhKHdQ8/mpryq/M7DpkfdZK8U
	bin0O+iDA8fg9ndT73TmPLz0kUr+vKCF1B4uI
X-Google-Smtp-Source: AGHT+IGQJ3deHF+c7iwxQd/1wvM8XLYmCaUkv2t0Cl8krKimBCrVFIGo89cvJXhgULf848FrvUlMSsoQF2E/ZdHjGYQ=
X-Received: by 2002:a05:6000:e87:b0:367:8a2f:a6db with SMTP id
 ffacd0b85a97d-3683176a8f0mr198641f8f.58.1721184017376; Tue, 16 Jul 2024
 19:40:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706022523.1104080-1-flintglass@gmail.com> <20240706022523.1104080-3-flintglass@gmail.com>
In-Reply-To: <20240706022523.1104080-3-flintglass@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 16 Jul 2024 19:39:39 -0700
Message-ID: <CAJD7tkaZsGU13XoKLWQy+AxNAWCZHYmr4DhAYvs32ppQwzCwmw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] mm: zswap: fix global shrinker error handling logic
To: Takero Funaki <flintglass@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 7:25=E2=80=AFPM Takero Funaki <flintglass@gmail.com>=
 wrote:
>
> This patch fixes zswap global shrinker that did not shrink zpool as
> expected.
>
> The issue it addresses is that `shrink_worker()` did not distinguish
> between unexpected errors and expected error codes that should be
> skipped, such as when there is no stored page in a memcg. This led to
> the shrinking process being aborted on the expected error codes.
>
> The shrinker should ignore these cases and skip to the next memcg.
> However,  skipping all memcgs presents another problem. To address this,
> this patch tracks progress while walking the memcg tree and checks for
> progress once the tree walk is completed.
>
> To handle the empty memcg case, the helper function `shrink_memcg()` is
> modified to check if the memcg is empty and then return -ENOENT.
>
> Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
> Signed-off-by: Takero Funaki <flintglass@gmail.com>
> ---
>  mm/zswap.c | 31 +++++++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 29944d8145af..f092932e652b 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1317,10 +1317,10 @@ static struct shrinker *zswap_alloc_shrinker(void=
)
>
>  static int shrink_memcg(struct mem_cgroup *memcg)
>  {
> -       int nid, shrunk =3D 0;
> +       int nid, shrunk =3D 0, scanned =3D 0;
>
>         if (!mem_cgroup_zswap_writeback_enabled(memcg))
> -               return -EINVAL;
> +               return -ENOENT;
>
>         /*
>          * Skip zombies because their LRUs are reparented and we would be
> @@ -1334,19 +1334,30 @@ static int shrink_memcg(struct mem_cgroup *memcg)
>
>                 shrunk +=3D list_lru_walk_one(&zswap_list_lru, nid, memcg=
,
>                                             &shrink_memcg_cb, NULL, &nr_t=
o_walk);
> +               scanned +=3D 1 - nr_to_walk;
>         }
> +
> +       if (!scanned)
> +               return -ENOENT;
> +
>         return shrunk ? 0 : -EAGAIN;
>  }
>
>  static void shrink_worker(struct work_struct *w)
>  {
>         struct mem_cgroup *memcg;
> -       int ret, failures =3D 0;
> +       int ret, failures =3D 0, progress;
>         unsigned long thr;
>
>         /* Reclaim down to the accept threshold */
>         thr =3D zswap_accept_thr_pages();
>
> +       /*
> +        * We might start from the last memcg.
> +        * That is not a failure.
> +        */
> +       progress =3D 1;
> +

I think this is unneeded complexity imo. Doing one less retry if we
happen to start at the last memcg should be fine.

>         /* global reclaim will select cgroup in a round-robin fashion.
>          *
>          * We save iteration cursor memcg into zswap_next_shrink,
> @@ -1390,9 +1401,12 @@ static void shrink_worker(struct work_struct *w)
>                  */
>                 if (!memcg) {
>                         spin_unlock(&zswap_shrink_lock);
> -                       if (++failures =3D=3D MAX_RECLAIM_RETRIES)
> +
> +                       /* tree walk completed but no progress */
> +                       if (!progress && ++failures =3D=3D MAX_RECLAIM_RE=
TRIES)
>                                 break;
>
> +                       progress =3D 0;
>                         goto resched;
>                 }
>
> @@ -1407,10 +1421,15 @@ static void shrink_worker(struct work_struct *w)
>                 /* drop the extra reference */
>                 mem_cgroup_put(memcg);
>
> -               if (ret =3D=3D -EINVAL)
> -                       break;
> +               /* not a writeback candidate memcg */

Unneeded comment.

> +               if (ret =3D=3D -ENOENT)
> +                       continue;
> +
>                 if (ret && ++failures =3D=3D MAX_RECLAIM_RETRIES)
>                         break;
> +
> +               ++progress;
> +               /* reschedule as we performed some IO */

Unneeded comment.


>  resched:
>                 cond_resched();
>         } while (zswap_total_pages() > thr);
> --
> 2.43.0
>

