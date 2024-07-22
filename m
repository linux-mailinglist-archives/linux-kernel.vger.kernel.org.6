Return-Path: <linux-kernel+bounces-259417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B46769395B4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 23:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA31AB21E56
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 21:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301DB3C684;
	Mon, 22 Jul 2024 21:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyNuwIGt"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79181849
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 21:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721685090; cv=none; b=hCx/kkwMrALBLsyonrxzBPPH0Vbni6DCLb/mYQ2xLjYoL1WNNNhYUMtnKrH2HvnNU9oEfFq8DceThH+Kj51Icbbt9EY6QSr2u50Xkjf10GpcQHa5pNwxqN0nzN8adcAmkuJFu5QPO4lHB5DZJgBUz/3qkSW7rzl1KB7IHgGrw0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721685090; c=relaxed/simple;
	bh=P+ptbGgukWviGEiSpfbUTfBtQisbcwIW10hJdHakDt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DlstaSAmbO0CNQYXDw0w554L/A976AOqtxUAA17dSFsLYvZmJSM6LrnnxQ5wkvGMJSRSOjFgy3DypcDJifqbUNyQ+BG7MHERYohdntc/ECHevbRq3miy6JnVlYYKp6S2hYCg7wgwAYkHaTxXgdSA76kAgcxAKernfh3/DdcMJFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyNuwIGt; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-65f8626780aso49815767b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 14:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721685088; x=1722289888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1AyKNnzGAkcTki8rPtv93FNMTvw546VYOSBbwMVqlA=;
        b=QyNuwIGtqJZfjaIpdN80Vgq0iD2Rbbcouxq6FGHGS4gddxUxTqYeAPGmacLAT9k5Xg
         IQiQXkoV3vLavFKhlA2wAtyH/y72mvidh3Gs/BMEfPl1RtBuQ2+ev/+XCG8IdfFKeOE/
         8ys1T+q2wFR4OzD93oQXlM/Tb2XtHskhQCuIvJ50fVcPD15XFSpu7DDpdamB+Mp6l5nC
         pSRqF4mCD9jMHeir4+RAJGxMjWnSNEdHrNV1Q/kvWoZUOp4gBC6oJ4q5zo/sTCbsFpER
         yYp9C53daTzOGza+14TQaSyM9CfrDzwd4g/5Ej0/HJ3g7XZtIIYUFTTVIVMiEQiYjtwM
         NU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721685088; x=1722289888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1AyKNnzGAkcTki8rPtv93FNMTvw546VYOSBbwMVqlA=;
        b=u2vVjT/C7r9bte+qPgLUeLy4TNR56kVkzMjW/rcaLddrONx3JLqs6pyICbgmFIAuXo
         5wx6U6bSCnMErNq6fyQyU6L7Ckji6PLXBZVjMr61/wn/SGOvslJbY7m/i3fDq/4pyGfQ
         nQTU5DMyvcf4S5ZYOx/dYlaWxGHUhX8322a0YdP5hyekyppyBUCgGUkYUTEJXOqXjgyp
         SnqyhW18tye087g8v9/ADWoWAbac0StKc5aKfA7WC48S2QWFuWRQLiBtTeoMi+k5uAe8
         HhlI0d6XyCeWwWYJuyQZhFovapY8xL370HNKselvUFIz+v+vqctVhZ3LShMwTXfsLdjI
         7bQg==
X-Forwarded-Encrypted: i=1; AJvYcCXIUQXct+Gx0EJlVhXjC3c/DwC2UKYuxGrYHeznBPlbiDZG7N4KEZ3hassVCKi+CJC9PmMExteczhbBhX87e4AOIiztfLhTqOzjolUs
X-Gm-Message-State: AOJu0YzHW8y0sy0JnZFJudp/qSKhHf80dfC9S6aCvugixorzXweCWNJm
	V0+uRE6COHj8uFLhJU1k+ACgadqsoqYabdkwvUguh0srQo89kwQ3qTTARaN0LvJrnsoAUaRwICS
	qE3NwDZpVdk47RMNSjshEmWliNJE=
X-Google-Smtp-Source: AGHT+IHB2RGwQBbyl5TKS5qq8ko4uSod5+wC0Mfz4fQZedFcwBKtXANszbYFgszowCQwwQe5uFGR3n45q6BwPNpa+k4=
X-Received: by 2002:a05:690c:3249:b0:63b:d242:4fa0 with SMTP id
 00721157ae682-66a67104a21mr101512367b3.21.1721685087744; Mon, 22 Jul 2024
 14:51:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240720044127.508042-1-flintglass@gmail.com> <20240720044127.508042-3-flintglass@gmail.com>
In-Reply-To: <20240720044127.508042-3-flintglass@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 22 Jul 2024 14:51:14 -0700
Message-ID: <CAKEwX=NCm9t9Y6z8bWQ788_wnhQsGN0frroTabNpHStxGnJOqw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm: zswap: fix global shrinker error handling logic
To: Takero Funaki <flintglass@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 9:41=E2=80=AFPM Takero Funaki <flintglass@gmail.com=
> wrote:
>
> This patch fixes zswap global shrinker that did not shrink zpool as
> expected.
>
> The issue it addresses is that `shrink_worker()` did not distinguish
> between unexpected errors and expected error codes that should be
> skipped, such as when there is no stored page in a memcg. This led to
> the shrinking process being aborted on the expected error codes.

The code itself seems reasonable to me, but may I ask you to document
(as a comment) all the expected v.s unexpected cases? i.e when do we
increment (or not increment) the failure counter?

My understanding is, we only increment the failure counter if we fail
to reclaim from a selected memcg that is non-empty and
writeback-enabled, or if we go a full tree walk without making any
progress. Is this correct?

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
>  mm/zswap.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 6528668c9af3..053d5be81d9a 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1310,10 +1310,10 @@ static struct shrinker *zswap_alloc_shrinker(void=
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
> @@ -1327,14 +1327,19 @@ static int shrink_memcg(struct mem_cgroup *memcg)
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
> +       int ret, failures =3D 0, progress =3D 0;
>         unsigned long thr;
>
>         /* Reclaim down to the accept threshold */
> @@ -1379,9 +1384,12 @@ static void shrink_worker(struct work_struct *w)
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
> @@ -1396,10 +1404,13 @@ static void shrink_worker(struct work_struct *w)
>                 /* drop the extra reference */
>                 mem_cgroup_put(memcg);
>
> -               if (ret =3D=3D -EINVAL)
> -                       break;
> +               if (ret =3D=3D -ENOENT)
> +                       continue;
> +
>                 if (ret && ++failures =3D=3D MAX_RECLAIM_RETRIES)
>                         break;
> +
> +               ++progress;
>  resched:
>                 cond_resched();
>         } while (zswap_total_pages() > thr);
> --
> 2.43.0
>

