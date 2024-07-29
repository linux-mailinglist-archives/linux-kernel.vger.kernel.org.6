Return-Path: <linux-kernel+bounces-266262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAFB93FD49
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 20:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4088C1F22194
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FE8183087;
	Mon, 29 Jul 2024 18:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qW3Y8KHX"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784C878274
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 18:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722277490; cv=none; b=h+rIIVMeHwFzaVbAxjSDW5pHci9ZFtzN/lndr0km1/AXF7Qhf6yANtYSeiOpCA3Qe3IQueN3EqivYbm+sYYOF5JK9+LEpkxv8HCNVvslWdbJRi7/JL2kZaGiVRspnvtgrhZ3AE4sWzf9eIbxJzc+aMqyW9shkdNry+EkEOY4hSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722277490; c=relaxed/simple;
	bh=VOtiW87Ij47TEXhQambPEUE47bIha9QtT8neNgt+iSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o3p+auFkO9T8tSZzdKvSjAYFUlIuSOOZeiXAIAn/3UfAM5kLlgQ6jifzBgGY1GX9zQw/xqZiIEZPmreUQdjyFsYs0WGfWS5sewYMmVpUjZTh/X8jszUnrnE4R6C9hdjj46kHO4loP+AWAIm8Fbq+B9EMIImB6uk0Ww8rRad+0AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qW3Y8KHX; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52f04b3cb33so8441182e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722277486; x=1722882286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ruasPNPK8KVxSRl2ha7YpZazMWY1eezny9YoCe+Cc3U=;
        b=qW3Y8KHXV9ygRTnJyt4EsmZQ6Tq1MeYOvcWHAsRWq777dH//6E6veUjT3sfB/9xNqA
         qhbxzS0B/f02LqMIN5MYrAX1wgM085uTnuOWEVHgc+PxHCKMIf8ndz5rrDpHj/kFygz/
         EbvjwT7Y5e1odgMcSs6mdkSLMcngQ+RnbArqsRT0/NR+DhdKPvVYTb/Vt9Lq4ZoNuD8H
         qewTXS5jtkS2eeFUqxK1tpaqoW3qN6sgMUTJ5rQTp/QjalRk1VZAr/C5p+vWqW/cCUsu
         6PMkbrULnM1aGxETSuCQwsfSjw/yG3ewb7s8HnB8/jGSEVqFpm2V23R5AbeMsOtPfdHv
         zstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722277486; x=1722882286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ruasPNPK8KVxSRl2ha7YpZazMWY1eezny9YoCe+Cc3U=;
        b=u8jOde/OYdzs/VSVX3rcv5QQAL1DGjOAP8sVRVqogq4XdoczhC325s9wqNetzVEr46
         D0tDk2Um65w+fFNHm6i9BNLty8oH3mZeQnFdmt3yztXrZlLKaM456eGjBUIUb+IWby9v
         PxWy9nJtYCoJMW7nOTWruPcyY4+Nk0f5uSDt+pQbRjFsYJ/tAaft8UBOP35Er19OQYhz
         i/BbP+rQyopxW7wbUDVTRwUKZFYTr+gGz3ICh6cFmKd/+7D9iV0is02zJ8viZIR6yICb
         pRlGMuYbTv56dDfAwsQhs/Q6/8jGD8Se059dumqnyQKoGvl6tCwf94QeDfME9kEPqxDB
         KWNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFW5Uw1aUVsXPs7+DZJKZPlwEQGYMmAc+xX7HLxAfCRU9mDRaXU1MlveaRjpJRN5dXLUUkXNWlKSLfJnbhiiz6o5+LhTVpu2xuWsCe
X-Gm-Message-State: AOJu0YxKHAkg46D9w3Pp4IQ7v2erUdwXzwAnfPxgpDIYUjxwSIpaQAZN
	nlpqOfft92P0mRfbcuzVRaurROtoPQC7+8Cv5/3xYBTyuN1RRmkyBdFiEQELob4VvsB+9ZdgkBT
	w2pgWiGpnLa/2L9OTf1DxR7dBndLHbO4JwTjV
X-Google-Smtp-Source: AGHT+IEPwV28ddsiGG5nMpSWP/Lv2Q5KF4eM3YF1a6FKjfIDQvczLFRKGlmwbqc/3mLBIKOssKU+bJdDRX8eS4JyYms=
X-Received: by 2002:a05:6512:32cb:b0:52e:9f7a:6e6 with SMTP id
 2adb3069b0e04-5309b2caa3bmr6952185e87.41.1722277485916; Mon, 29 Jul 2024
 11:24:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727230635.3170-1-flintglass@gmail.com> <20240727230635.3170-2-flintglass@gmail.com>
In-Reply-To: <20240727230635.3170-2-flintglass@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 29 Jul 2024 11:24:08 -0700
Message-ID: <CAJD7tkYKC8Cy0tCc=1m5x=bXVaXPhzRhWjeP5n6YofuPeTgOwg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mm: zswap: fix global shrinker memcg iteration
To: Takero Funaki <flintglass@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 27, 2024 at 4:06=E2=80=AFPM Takero Funaki <flintglass@gmail.com=
> wrote:
>
> This patch fixes an issue where the zswap global shrinker stopped
> iterating through the memcg tree.
>
> The problem was that shrink_worker() would restart iterating memcg tree
> from the tree root, considering an offline memcg as a failure, and abort
> shrinking after encountering the same offline memcg 16 times even if
> there is only one offline memcg. After this change, an offline memcg in
> the tree is no longer considered a failure. This allows the shrinker to
> continue shrinking the other online memcgs regardless of whether an
> offline memcg exists, gives higher zswap writeback activity.
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
>  mm/zswap.c | 73 ++++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 49 insertions(+), 24 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index adeaf9c97fde..e9b5343256cd 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -765,12 +765,31 @@ void zswap_folio_swapin(struct folio *folio)
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
> +                       zswap_next_shrink =3D mem_cgroup_iter(NULL, zswap=
_next_shrink, NULL);
> +               } while (zswap_next_shrink && !mem_cgroup_online(zswap_ne=
xt_shrink));
> +               /*
> +                * We verified the next memcg is online.  Even if the nex=
t
> +                * memcg is being offlined here, another cleaner must be
> +                * waiting for our lock.  We can leave the online memcg
> +                * reference.
> +                */

I thought we agreed to drop this comment :)

> +       }
>         spin_unlock(&zswap_shrink_lock);
>  }
>
> @@ -1304,43 +1323,49 @@ static void shrink_worker(struct work_struct *w)
>         /* Reclaim down to the accept threshold */
>         thr =3D zswap_accept_thr_pages();
>
> -       /* global reclaim will select cgroup in a round-robin fashion. */
> +       /* global reclaim will select cgroup in a round-robin fashion.

nit: s/global/Global

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
> +                       memcg =3D mem_cgroup_iter(NULL, zswap_next_shrink=
, NULL);
> +                       zswap_next_shrink =3D memcg;
> +               } while (memcg && !mem_cgroup_tryget_online(memcg));

Let's move spin_lock() and spin_unlock() to be right above and before
the do-while loop, similar to zswap_memcg_offline_cleanup(). This
should make it more obvious what the lock is protecting.

Actually, maybe it would be cleaner at this point to move the
iteration to find the next online memcg under lock into a helper, and
use it here and in zswap_memcg_offline_cleanup(). zswap_shrink_lock
and zswap_next_shrink can be made static to this helper and maybe some
of the comments could live there instead. Something like
zswap_next_shrink_memcg().

This will abstract this whole iteration logic and make shrink_worker()
significantly easier to follow. WDYT?

I can do that in a followup cleanup patch if you prefer this as well.

> +               /*
>                  * Note that if we got an online memcg, we will keep the =
extra
>                  * reference in case the original reference obtained by m=
em_cgroup_iter
>                  * is dropped by the zswap memcg offlining callback, ensu=
ring that the
>                  * memcg is not killed when we are reclaiming.
>                  */
> -               if (!memcg) {
> -                       spin_unlock(&zswap_shrink_lock);
> -                       if (++failures =3D=3D MAX_RECLAIM_RETRIES)
> -                               break;
> -
> -                       goto resched;
> -               }
> -
> -               if (!mem_cgroup_tryget_online(memcg)) {
> -                       /* drop the reference from mem_cgroup_iter() */
> -                       mem_cgroup_iter_break(NULL, memcg);
> -                       zswap_next_shrink =3D NULL;
> -                       spin_unlock(&zswap_shrink_lock);
> +               spin_unlock(&zswap_shrink_lock);
>
> +               if (!memcg) {
>                         if (++failures =3D=3D MAX_RECLAIM_RETRIES)
>                                 break;
>
>                         goto resched;
>                 }
> -               spin_unlock(&zswap_shrink_lock);
>
>                 ret =3D shrink_memcg(memcg);
>                 /* drop the extra reference */
> --
> 2.43.0
>

