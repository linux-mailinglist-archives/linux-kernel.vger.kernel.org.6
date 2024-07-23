Return-Path: <linux-kernel+bounces-259633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 440BA9399D8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66D281C21AAB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 06:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BEF14A0B2;
	Tue, 23 Jul 2024 06:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="amopwLWg"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C189913CF85
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 06:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721716667; cv=none; b=iy5dwdSDfTBRBXRoPed5SHgtIE0nbuZeEWoEf6srh1A+B0dPRM3EA+caJOgxAEZLZ+GDmmjsQ6BkZtxsEp9si4vvnQZ1ShWlbrL3yPq0rhdORUdCHGuBgd2rMpRJPBvTYXJ/oie0SSJLIhZim9KLORuN6jQFyXdhRNMtnzn6Jjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721716667; c=relaxed/simple;
	bh=e8bxs5WbWyMB3Y3HCBkJfqp4U0cmWzCad7DB6o7E2B8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BFbMQRmMRPew/z5gufEvSUgCLsbGjgt/G/ufbhYup1Wv6yjwVlRrIdjHvgbnTJb3EqgSpT/z1tF6Akty27FpK9Bld9ynJeVpFkKucBFZBZkBMSQNDBMpmzfYRhx49y3MaqyGvj+7lRrfbAuAMACduAmS7H2NJYzKa7t2zpkRoxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=amopwLWg; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52efd530a4eso3867228e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 23:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721716664; x=1722321464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JhJHh75+vxBq5JCUMaHvgyTNnvrnILojlvhWSODNXw=;
        b=amopwLWg2L3vnypqKRsB4R22ABXxcu9jsqhmfDpsXVf5oA/srQrw8onvTSMjKDqY2a
         8mMm+ktPe8p+P9E9d6POGQ7goOfRx5rEpbiyt5WxaEyQd3js5lyD7FeYlVqMKuZ5Kjyf
         JhcHwdh159eW7lqTDWw9FYQWtazM2GPYP5tbNshinSqpHruahPIpRkjVs985RDzk6Vln
         AqfjNJ7y1BqBcsEp2xkFpT0l1XhhS8c8u+4GALD6zSeMzPCeBT8IPKdUT9G7fYQ4/BRQ
         vnCaYCi4WQSrneNa4wjcW5TX/1BLSpyIINjG5CXZNZc9x4+0jBdaGPA4/jkBgrevcGmp
         Ha7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721716664; x=1722321464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+JhJHh75+vxBq5JCUMaHvgyTNnvrnILojlvhWSODNXw=;
        b=HSTwmGFh7QnWHWGXQKJGu0D6r4buMmf1UtPTwuPAF4a73RqrA3BlAEx2WuzsRIBuLf
         eaXx2rc4/x8oUZlE9JOvQPZpVBh0nK6wclgFLoiE7//psbg8v9Jn357jmYI+JHGHX/rZ
         3SW823fgs7yLx3qGwOwydFmWcTJlA6FzapokkvN670xadMEIlvXZbuyLElzP5Ln/4l2w
         5GtoO4X89KgwslPQ5zABoUAAMNSTVKXZF45riC/Ybxcxgkg/hB2lmzAw9A5Aj8IF4ncq
         wXr4M0q13WHwTYbZuTTe0timoWdQRRav/MTtsnUqDh2oTI7m4MN7qce8+ya8s9As0G+K
         5cWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnUuJUhfG1zWkrFvmNwDMWmDquPiK9UPd6T/UztCEE3u+w5fVoeLUy+P+ug4r87mBOWA4bDKRP2z6krGIK+DC13fEpi00roiJKThP7
X-Gm-Message-State: AOJu0YzvCaYXj2CrFRN5wbcViDSf124w7FJ34tj24vuZRG3VbmPsoRa3
	dV8EPBbPFsmK9O55F0vkdWOTvPk7w8Y60zYdeSta8PEomNAkbWAtaViQ3bJ5AjRhB6vwf8Indnp
	SIcWybqmn12S4HED6Dt3ghwIwEMOZNxPyXMZR
X-Google-Smtp-Source: AGHT+IEglEMjRzjhhYHSEdin5PjH0xkG3h0wSeij+jDfu8mT5OD4uln4LREkccdyh0rDty08M9nEqEdDf759cyKIQe0=
X-Received: by 2002:a05:6512:ba1:b0:52e:f95c:8b with SMTP id
 2adb3069b0e04-52fc4046329mr1466050e87.16.1721716663405; Mon, 22 Jul 2024
 23:37:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240720044127.508042-1-flintglass@gmail.com> <20240720044127.508042-2-flintglass@gmail.com>
In-Reply-To: <20240720044127.508042-2-flintglass@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 22 Jul 2024 23:37:07 -0700
Message-ID: <CAJD7tkbf0Sc6Q3KyFzG8jRB3Z0D3iiBYiXkjkCix3gy=PctZyQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm: zswap: fix global shrinker memcg iteration
To: Takero Funaki <flintglass@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 9:41=E2=80=AFPM Takero Funaki <flintglass@gmail.com=
> wrote:
>
> This patch fixes an issue where the zswap global shrinker stopped
> iterating through the memcg tree.
>
> The problem was that shrink_worker() would stop iterating when a memcg
> was being offlined and restart from the tree root.  Now, it properly
> handles the offline memcg and continues shrinking with the next memcg.

It is probably worth explicitly calling out that before this change,
the shrinker would stop considering an offline memcg as a failure and
stop after hitting 16 failures, but after this change, a failure is
hitting the end of the tree. This means that cgroup trees with a lot
of offline cgroups will now observe significantly higher zswap
writeback activity.

Similarly, in the next patch commit log, please explicitly call out
the expected behavioral change, that hitting an empty memcg or
reaching the end of a tree is no longer considered a failure if there
is progress, which means that trees with a few cgroups using zswap
will now observe significantly higher zswap writeback activity.

>
> To avoid holding refcount of offline memcg encountered during the memcg
> tree walking, shrink_worker() must continue iterating to release the
> offline memcg to ensure the next memcg stored in the cursor is online.
>
> The offline memcg cleaner has also been changed to avoid the same issue.
> When the next memcg of the offlined memcg is also offline, the refcount
> stored in the iteration cursor was held until the next shrink_worker()
> run. The cleaner must release the offline memcg recursively.
>
> Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
> Signed-off-by: Takero Funaki <flintglass@gmail.com>
> ---
>  mm/zswap.c | 77 +++++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 56 insertions(+), 21 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index a50e2986cd2f..6528668c9af3 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -775,12 +775,33 @@ void zswap_folio_swapin(struct folio *folio)
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
> +       if (zswap_next_shrink =3D=3D memcg) {
> +               do {
> +                       zswap_next_shrink =3D mem_cgroup_iter(NULL,
> +                                       zswap_next_shrink, NULL);
> +               } while (zswap_next_shrink &&
> +                               !mem_cgroup_online(zswap_next_shrink));
> +               /*
> +                * We verified the next memcg is online.  Even if the nex=
t
> +                * memcg is being offlined here, another cleaner must be
> +                * waiting for our lock.  We can leave the online memcg
> +                * reference.
> +                */
> +       }
>         spin_unlock(&zswap_shrink_lock);
>  }
>
> @@ -1319,18 +1340,38 @@ static void shrink_worker(struct work_struct *w)
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
> +        * Since the offline cleaner is called only once, we cannot leave=
 an
> +        * offline memcg reference in zswap_next_shrink.
> +        * We can rely on the cleaner only if we get online memcg under l=
ock.
> +        *
> +        * If we get an offline memcg, we cannot determine if the cleaner=
 has
> +        * already been called or will be called later. We must put back =
the
> +        * reference before returning from this function. Otherwise, the
> +        * offline memcg left in zswap_next_shrink will hold the referenc=
e
> +        * until the next run of shrink_worker().
> +        */
>         do {
>                 spin_lock(&zswap_shrink_lock);
> -               zswap_next_shrink =3D mem_cgroup_iter(NULL, zswap_next_sh=
rink, NULL);
> -               memcg =3D zswap_next_shrink;
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
> +                * Start shrinking from the next memcg after zswap_next_s=
hrink.
> +                * When the offline cleaner has already advanced the curs=
or,
> +                * advancing the cursor here overlooks one memcg, but thi=
s
> +                * should be negligibly rare.
> +                */
> +               do {
> +                       zswap_next_shrink =3D mem_cgroup_iter(NULL,
> +                                               zswap_next_shrink, NULL);
> +                       memcg =3D zswap_next_shrink;
> +               } while (memcg && !mem_cgroup_tryget_online(memcg));
> +
> +               /*
>                  * Note that if we got an online memcg, we will keep the =
extra
>                  * reference in case the original reference obtained by m=
em_cgroup_iter
>                  * is dropped by the zswap memcg offlining callback, ensu=
ring that the
> @@ -1344,17 +1385,11 @@ static void shrink_worker(struct work_struct *w)
>                         goto resched;
>                 }
>
> -               if (!mem_cgroup_tryget_online(memcg)) {
> -                       /* drop the reference from mem_cgroup_iter() */
> -                       mem_cgroup_iter_break(NULL, memcg);
> -                       zswap_next_shrink =3D NULL;
> -                       spin_unlock(&zswap_shrink_lock);
> -
> -                       if (++failures =3D=3D MAX_RECLAIM_RETRIES)
> -                               break;
> -
> -                       goto resched;
> -               }
> +               /*
> +                * We verified the memcg is online and got an extra memcg
> +                * reference.  Our memcg might be offlined concurrently b=
ut the
> +                * respective offline cleaner must be waiting for our loc=
k.
> +                */
>                 spin_unlock(&zswap_shrink_lock);
>
>                 ret =3D shrink_memcg(memcg);
> --
> 2.43.0
>

