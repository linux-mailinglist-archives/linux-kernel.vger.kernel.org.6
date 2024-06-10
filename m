Return-Path: <linux-kernel+bounces-208858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0299029F0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5DE286365
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0180B481DA;
	Mon, 10 Jun 2024 20:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U3i7pCwa"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF82B65E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 20:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718051284; cv=none; b=KXyi2Yygzuun7rO97FL/gK1mWiFPIT8GModuoSGL2ILIKkF7ub7aa8I+mjqAND1kamL6pqSACQT7fHSMoijwFFDLrAhDQnEyd9Ni5DEWZw+JWSJTRQsxizsL3eZPf2n7Cwddj6KBlj4uc6JOb55MVMVMj6+smkMDet+dYlBjPZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718051284; c=relaxed/simple;
	bh=QLun0ZmSJonCAnqt5EQS+rf8Lz10qIaVszRa5dv+Xy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WvtaJkGo+418pj94FLtyJHLr0cNnLHFLCIO4w3+YU9phJANFAggERSFMc60KyE8X60pAa8DV6+elRXAxxcuXgoV+ivE1DS3NJHzATy6DWSf2zGt9hVUmNXg1FK6i3BdznsaqBTVK1dzAUFH9Nh/z+juzBYbqzORrMUbHr0qWKzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U3i7pCwa; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6f0c3d0792so39314166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 13:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718051281; x=1718656081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmaAu+iZsuEjEiEeynNp1R7+/jNy6Qzg+Lrp5NYV5lE=;
        b=U3i7pCwaO11vdr3llWGTfyNsseYGp70qQSiIFKzj5pGUKTv3PMK8ieH+QEjfklorf4
         rpnwpBOS62PvvoE4d41pAHsBdXy2DFsrVaZFKOC99WtwxRG3eNn/aoI2V7r4fIDTq/OO
         S07SiMfRyoH4RCyAFufxbANdGGPlxhUkBNHnfEahyHdBv4F4pIeXW3qv18kffa2dqE1T
         TlyC5Y2p7MCiKd0EtTWvX9Nw0KV1kS4OZsPTgy7+jHQyQScsvFdLwY4pOeCFPjx0wDgA
         mC/KByH6wBMIs99mpolRUqNZyPOxMivA1xDlNy2j1+PK2p7cpeto1xg+HYh4kCA5iTU4
         4e6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718051281; x=1718656081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CmaAu+iZsuEjEiEeynNp1R7+/jNy6Qzg+Lrp5NYV5lE=;
        b=lx+07EcsIvK8fKGmy+S6yE0pB+Nb6vqODiQMnGIvQovLzYGuzrt2yYsyV23UdMhDu0
         b+vgssSZh7RK4URNSSAPblSzhe0H/PbkxjS0TPItgrMxH635f8qQUaJOuweSPB0IIL8V
         /IK1Ut7LHdW0+jHrmfblDmfJBbtuLdNIvnq1MAO2fJb+1dFZVC5tvc4kdyBgJPLNPyM7
         qxxbqUkrXW3E5bD93O6YQRQSoSu4HFGz9oKkxllmPE3r88rooc0tuM/tOawO74PEZIEb
         bmRpRKqsokIh4AZsTPVJl4ZGDuaoXCOopYmV6GCwIEYxRewiwXJuYEL5iSFJ11zULmZV
         Sl8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXnW8A9YEuSS8mPedGsztL36pmDVWYp+zOiHIQFKeuPZplbHd67eQ9py5n2ekNJ/LHmv+M3S8fdPFenV3qVuFIB43vBAuEImZxBjI7e
X-Gm-Message-State: AOJu0YxpAqX30prBj9Z4ubbSCPFoWkqGvKqdmJJb7qK4YDmgWv8YP4WF
	ItIF8cDavMZ/aGEs6B01YUZqNer8vbDlx5qh2vRxL9RT4cAspNSOCrlYe5VwxFWghdeJhScup52
	03PtdDCCoYPginJ02Av0XevY1rJicOjNN0Zbt
X-Google-Smtp-Source: AGHT+IGXSvDrAADj9Pf8Xu53OIXItT5TQK5ibDqDLkBUNlFNRj/gYFiO9Qxz2XUO3Ze11843IeDDNQqVlc+Qa3ui1pw=
X-Received: by 2002:a17:906:89a:b0:a6f:1fc0:3fc0 with SMTP id
 a640c23a62f3a-a6f1fc04524mr225232566b.6.1718051280487; Mon, 10 Jun 2024
 13:28:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608155316.451600-1-flintglass@gmail.com> <20240608155316.451600-3-flintglass@gmail.com>
In-Reply-To: <20240608155316.451600-3-flintglass@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 10 Jun 2024 13:27:22 -0700
Message-ID: <CAJD7tkZAkzUfbXY3C0QOGqCyjQZeiuGzkZac4hmogOoh=yoZsw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] mm: zswap: fix global shrinker error handling logic
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
>  mm/zswap.c | 31 ++++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index d720a42069b6..1a90f434f247 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1393,7 +1393,7 @@ static struct shrinker *zswap_alloc_shrinker(void)
>
>  static int shrink_memcg(struct mem_cgroup *memcg)
>  {
> -       int nid, shrunk =3D 0;
> +       int nid, shrunk =3D 0, stored =3D 0;
>
>         if (!mem_cgroup_zswap_writeback_enabled(memcg))
>                 return -EINVAL;
> @@ -1408,9 +1408,16 @@ static int shrink_memcg(struct mem_cgroup *memcg)
>         for_each_node_state(nid, N_NORMAL_MEMORY) {
>                 unsigned long nr_to_walk =3D 1;
>
> +               if (!list_lru_count_one(&zswap_list_lru, nid, memcg))
> +                       continue;
> +               ++stored;
>                 shrunk +=3D list_lru_walk_one(&zswap_list_lru, nid, memcg=
,
>                                             &shrink_memcg_cb, NULL, &nr_t=
o_walk);
>         }
> +
> +       if (!stored)
> +               return -ENOENT;
> +

Can't we just check nr_to_walk here and return -ENOENT if it remains as 1?

Something like:

if (nr_to_walk)
    return -ENOENT;
if (!shrunk)
    return -EAGAIN;
return 0;

>         return shrunk ? 0 : -EAGAIN;
>  }
>
> @@ -1418,12 +1425,18 @@ static void shrink_worker(struct work_struct *w)
>  {
>         struct mem_cgroup *memcg =3D NULL;
>         struct mem_cgroup *next_memcg;
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
>         /* global reclaim will select cgroup in a round-robin fashion.
>          *
>          * We save iteration cursor memcg into zswap_next_shrink,
> @@ -1461,9 +1474,12 @@ static void shrink_worker(struct work_struct *w)
>                  */
>                 if (!memcg) {
>                         spin_unlock(&zswap_shrink_lock);
> -                       if (++failures =3D=3D MAX_RECLAIM_RETRIES)
> +
> +                       /* tree walk completed but no progress */
> +                       if (!progress && ++failures =3D=3D MAX_RECLAIM_RE=
TRIES)
>                                 break;

It seems like we may keep iterating the entire hierarchy a lot of
times as long as we are making any type of progress. This doesn't seem
right.

>
> +                       progress =3D 0;
>                         goto resched;
>                 }
>
> @@ -1493,10 +1509,15 @@ static void shrink_worker(struct work_struct *w)
>                 /* drop the extra reference */
>                 mem_cgroup_put(memcg);
>
> -               if (ret =3D=3D -EINVAL)
> -                       break;
> +               /* not a writeback candidate memcg */
> +               if (ret =3D=3D -EINVAL || ret =3D=3D -ENOENT)
> +                       continue;
> +

We should probably return -ENOENT for memcg with writeback disabled as well=
.

>                 if (ret && ++failures =3D=3D MAX_RECLAIM_RETRIES)
>                         break;
> +
> +               ++progress;
> +               /* reschedule as we performed some IO */
>  resched:
>                 cond_resched();
>         } while (zswap_total_pages() > thr);
> --
> 2.43.0
>

