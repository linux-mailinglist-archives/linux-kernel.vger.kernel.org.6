Return-Path: <linux-kernel+bounces-208778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D13790290C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 21:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79CE01C2163D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B916880633;
	Mon, 10 Jun 2024 19:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PW15E8QT"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A1A182B5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 19:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718047021; cv=none; b=jicUCw5nAZxG9CkrGzYpIZoNgJYS4oP9xiYiIjL0Rx5Xpda4NcfgN0Gddc80FsAa73j4aQboS2pv/Rl+cXoLJrE3sxZ7gD6OQ0FST1VtomBY8JVo+un7H/nj/M/vC0lXECxWoYhFx2boOrNEx4FPWEzyDER5o2uuMq+kYttoKss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718047021; c=relaxed/simple;
	bh=Us3SXEQ19OfbEtbhaX0vY3W9lAdyrg8Bej4JXSwsnTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ay9K8dJgOZm8r2KLTJtq2KHc6jOnc2ov9csCQ2jwTsAK443Ng+OzkRcJaR9wRhhum/Fli2wOWpO0WIEMcBQiOzrGpTfg+9mnNptiC9cIM/jB+tAo+LEa9QBYcQwkyea43fUg/9QJr84ndVHzCPNpOVSUMvyaY48gDJ35J8rvfg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PW15E8QT; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6269885572so1021587266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718047018; x=1718651818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLI0BFkBBfPQ5TWI+0fPV2cVGs3g9gOOEuOzey2zZBw=;
        b=PW15E8QTFo7AyOAKts9grleTJPA/9+E97+Wa/mKKbOOyX0vzYZuQILHWycEO1zrsd0
         /7rujw0vT02d9Qj1DII9YFBZ35s+b0Zl3Z94G/Jb7xdSOv85+gttDDT4BR1G3CaF0HQi
         LfrxDOnXifuQYQ0kJWW0hCzRmifUVVahSxR3ecjNUfio1qB8jnzIu6VW0Cwp93/Cofu6
         MSnbHMqnt7tZqZBhtVpXjWcYEdomKC27QWHqtF7BWGGs1UzwscyzDf4UhNfoDfvXyDuT
         u8o+MXPwaxEfWrOpTlB2yOUg3dWXMTJJRGl+bseqAp9s28LPiHoCG8YZDZcnuAgvnqAV
         fc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718047018; x=1718651818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLI0BFkBBfPQ5TWI+0fPV2cVGs3g9gOOEuOzey2zZBw=;
        b=S50K5Uy6ilagtTJIw7Xt8VnQ0Gn6cZl/dbKWQ+fv1BHqJOOaK0EgaVMmppCLYW56Bm
         HmkEDz2mJC1KZxL3PmJUWy0OqZWWUQaxAOTnkST5rDc3g54jqtIfFHf+tBNLf2n6y+eq
         gqNl9hfsqa2pMve9r84c6NwuLtdnMhuvk4J1ux0TzBJPElvA8eH7RP2lZBWalEKKQXQk
         u2gVg1oPsoxIjhoHD9ZAyBs126X2eTCnusv7O8VymEUag5PxXFhBf7ijYUlwwJZb2Jbj
         YwgGwuZ0U38vD3FL0a59MiuizjTjmMNA1iZQynUZBN3PLsYlNaFf9dSaGQ5SgKvC7PTC
         U9+w==
X-Forwarded-Encrypted: i=1; AJvYcCVad0UgCGZbskVvdlK/8L/VuuX9tXZh/9ktrE2eE5tPx+EDN64PQS0XsTvacUa1a8++kh6/29kqv6rwsjARDy2Ms0AAa6bpuvvbdWDu
X-Gm-Message-State: AOJu0YwWBtjbQcJCxkSz1lhatXR3XYdTQVNfK5NpADs9e+cciQdlr7bC
	2KfwbRVd/YNMCSD1udIpFoYleLfU/3uhcixXjt/HlRjqTfMHcRKLXjvaoZiLj3GdAvAfRET5vXw
	36hYzPA7ebXY9ygSPbakmNdG3yxFFBGKzC9s9
X-Google-Smtp-Source: AGHT+IHEyhLEgeimAkd9GXuJSNNv7L8w7oaZQ1vPG7m7h93lU03u3PVsTB3mMqMFL13Rf1nhKFODiGTyicrEiTKjGLI=
X-Received: by 2002:a17:906:4708:b0:a6f:dc0:904b with SMTP id
 a640c23a62f3a-a6f34d9590bmr37050366b.23.1718047018045; Mon, 10 Jun 2024
 12:16:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608155316.451600-1-flintglass@gmail.com> <20240608155316.451600-2-flintglass@gmail.com>
In-Reply-To: <20240608155316.451600-2-flintglass@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 10 Jun 2024 12:16:19 -0700
Message-ID: <CAJD7tkaKaMpni2tA_G6DhiRLdV+O3AmXE81JyKY=PEN54o=aAw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] mm: zswap: fix global shrinker memcg iteration
To: Takero Funaki <flintglass@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 8, 2024 at 8:53=E2=80=AFAM Takero Funaki <flintglass@gmail.com>=
 wrote:
>
> This patch fixes an issue where the zswap global shrinker stopped
> iterating through the memcg tree.
>
> The problem was that `shrink_worker()` would stop iterating when a memcg
> was being offlined and restart from the tree root.  Now, it properly
> handles the offlining memcg and continues shrinking with the next memcg.
>
> This patch also modified handing of the lock for offlined memcg cleaner
> to adapt the change in the iteration, and avoid negligibly rare skipping
> of a memcg from shrink iteration.
>
> Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
> Signed-off-by: Takero Funaki <flintglass@gmail.com>
> ---
>  mm/zswap.c | 87 ++++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 68 insertions(+), 19 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 80c634acb8d5..d720a42069b6 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -827,12 +827,27 @@ void zswap_folio_swapin(struct folio *folio)
>         }
>  }
>
> +/*
> + * This function should be called when a memcg is being offlined.
> + *
> + * Since the global shrinker shrink_worker() may hold a reference
> + * of the memcg, we must check and release the reference in
> + * zswap_next_shrink.
> + *
> + * shrink_worker() must handle the case where this function releases
> + * the reference of memcg being shrunk.
> + */
>  void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
>  {
>         /* lock out zswap shrinker walking memcg tree */
>         spin_lock(&zswap_shrink_lock);
> -       if (zswap_next_shrink =3D=3D memcg)
> -               zswap_next_shrink =3D mem_cgroup_iter(NULL, zswap_next_sh=
rink, NULL);
> +
> +       if (READ_ONCE(zswap_next_shrink) =3D=3D memcg) {
> +               /* put back reference and advance the cursor */
> +               memcg =3D mem_cgroup_iter(NULL, memcg, NULL);
> +               WRITE_ONCE(zswap_next_shrink, memcg);
> +       }
> +

I am really finding it difficult to understand what the diff is trying
to do. We are holding a lock that protects zswap_next_shrink. We
always access it with the lock held. Why do we need all of this?

Adding READ_ONCE() and WRITE_ONCE() where they are not needed is just
confusing imo.

>         spin_unlock(&zswap_shrink_lock);
>  }
>
> @@ -1401,25 +1416,44 @@ static int shrink_memcg(struct mem_cgroup *memcg)
>
>  static void shrink_worker(struct work_struct *w)
>  {
> -       struct mem_cgroup *memcg;
> +       struct mem_cgroup *memcg =3D NULL;
> +       struct mem_cgroup *next_memcg;
>         int ret, failures =3D 0;
>         unsigned long thr;
>
>         /* Reclaim down to the accept threshold */
>         thr =3D zswap_accept_thr_pages();
>
> -       /* global reclaim will select cgroup in a round-robin fashion. */
> +       /* global reclaim will select cgroup in a round-robin fashion.
> +        *
> +        * We save iteration cursor memcg into zswap_next_shrink,
> +        * which can be modified by the offline memcg cleaner
> +        * zswap_memcg_offline_cleanup().
> +        *
> +        * Since the offline cleaner is called only once, we cannot aband=
one
> +        * offline memcg reference in zswap_next_shrink.
> +        * We can rely on the cleaner only if we get online memcg under l=
ock.
> +        * If we get offline memcg, we cannot determine the cleaner will =
be
> +        * called later. We must put it before returning from this functi=
on.
> +        */
>         do {
> +iternext:
>                 spin_lock(&zswap_shrink_lock);
> -               zswap_next_shrink =3D mem_cgroup_iter(NULL, zswap_next_sh=
rink, NULL);
> -               memcg =3D zswap_next_shrink;
> +               next_memcg =3D READ_ONCE(zswap_next_shrink);
> +
> +               if (memcg !=3D next_memcg) {
> +                       /*
> +                        * Ours was released by offlining.
> +                        * Use the saved memcg reference.
> +                        */
> +                       memcg =3D next_memcg;

'memcg' will always be NULL on the first iteration, so we will always
start by shrinking 'zswap_next_shrink' for a second time before moving
the iterator.

> +               } else {
> +                       /* advance cursor */
> +                       memcg =3D mem_cgroup_iter(NULL, memcg, NULL);
> +                       WRITE_ONCE(zswap_next_shrink, memcg);

Again, I don't see what this is achieving. The first iteration will
always set 'memcg' to 'zswap_next_shrink', and then we will always
move the iterator forward. The only difference I see is that we shrink
'zswap_next_shrink' twice in a row now (last 'memcg' in prev call, and
first 'memcg' in this call).

> +               }
>
>                 /*
> -                * We need to retry if we have gone through a full round =
trip, or if we
> -                * got an offline memcg (or else we risk undoing the effe=
ct of the
> -                * zswap memcg offlining cleanup callback). This is not c=
atastrophic
> -                * per se, but it will keep the now offlined memcg hostag=
e for a while.
> -                *
>                  * Note that if we got an online memcg, we will keep the =
extra
>                  * reference in case the original reference obtained by m=
em_cgroup_iter
>                  * is dropped by the zswap memcg offlining callback, ensu=
ring that the
> @@ -1434,16 +1468,25 @@ static void shrink_worker(struct work_struct *w)
>                 }
>
>                 if (!mem_cgroup_tryget_online(memcg)) {
> -                       /* drop the reference from mem_cgroup_iter() */
> -                       mem_cgroup_iter_break(NULL, memcg);
> -                       zswap_next_shrink =3D NULL;
> +                       /*
> +                        * It is an offline memcg which we cannot shrink
> +                        * until its pages are reparented.
> +                        *
> +                        * Since we cannot determine if the offline clean=
er has
> +                        * been already called or not, the offline memcg =
must be
> +                        * put back unconditonally. We cannot abort the l=
oop while
> +                        * zswap_next_shrink has a reference of this offl=
ine memcg.
> +                        */

You actually deleted the code that actually puts the ref to the
offline memcg above.

Why don't you just replace mem_cgroup_iter_break(NULL, memcg) with
mem_cgroup_iter(NULL, memcg, NULL) here? I don't understand what the
patch is trying to do to be honest. This patch is a lot more confusing
than it should be.

Also, I would like Nhat to weigh in here. Perhaps the decision to
reset the iterator instead of advancing it in this case was made for a
reason that we should honor. Maybe cgroups are usually offlined
together so we will keep running into offline cgroups here if we
continue? I am not sure.

>                         spin_unlock(&zswap_shrink_lock);
> -
> -                       if (++failures =3D=3D MAX_RECLAIM_RETRIES)
> -                               break;
> -
> -                       goto resched;
> +                       goto iternext;
>                 }
> +               /*
> +                * We got an extra memcg reference before unlocking.
> +                * The cleaner cannot free it using zswap_next_shrink.
> +                *
> +                * Our memcg can be offlined after we get online memcg he=
re.
> +                * In this case, the cleaner is waiting the lock just beh=
ind us.
> +                */
>                 spin_unlock(&zswap_shrink_lock);
>
>                 ret =3D shrink_memcg(memcg);
> @@ -1457,6 +1500,12 @@ static void shrink_worker(struct work_struct *w)
>  resched:
>                 cond_resched();
>         } while (zswap_total_pages() > thr);
> +
> +       /*
> +        * We can still hold the original memcg reference.
> +        * The reference is stored in zswap_next_shrink, and then reused
> +        * by the next shrink_worker().
> +        */
>  }
>
>  /*********************************
> --
> 2.43.0
>

