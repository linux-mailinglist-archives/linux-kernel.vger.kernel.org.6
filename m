Return-Path: <linux-kernel+bounces-268104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0420942070
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BE2EB22B04
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9111A18C932;
	Tue, 30 Jul 2024 19:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fza/VGun"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2107618C90A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 19:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722367098; cv=none; b=mu0FkFZLS2JPRQKH1V2UcBuAyxmqcj2gByz6wh5x/8RjRPXw2vm5LyEdpQF4eg+l9y6TCBxPxjkMs7UdKDQp2UyISt1YqIft19LVfykdDif0nIXWa8zs+L9MJoHHbNIZ0PdKm8odb+Ps1BPeODrPp49mRO60g3u4mUupRHB3SzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722367098; c=relaxed/simple;
	bh=/o/rVZ+/iu1o2PfMRPideNbkXW3ZjTS9hSmqvhLdNxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lLdWEjDH3EcKoXf0t3JyhW+4IM/SBrji/DsKgf1n0V8gwf+lKx2VpWY3NIP3PA39XN+N5lu+5dkJfzTfozNPGbFos03br4oMDUUn715xhUq8ltlxHQxic9/aBd4KH7qA6PXYz+EqJNcWUblAoUu84iN1eqSr51jS9AmKvOMrLuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fza/VGun; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6b797fb1c4aso33681916d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722367096; x=1722971896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2sF0eceqoXNG5LGtMfw8S8kHnapYiMxImOpIZ5orbg=;
        b=fza/VGunfLEc9uZHen9NkWbaEWTWEj+hf0/D9j54f3S9F8S/DhqUkAM9Xsz9v3e6jZ
         guTSY0e36Wb2Svw0JuvmtygRlnbj+oQP4+jSa6tv4I+JHmTPKLCMAXXD+0DAjOjmYSty
         nMXVqrpet8CVFHNQ3tUtSpHO6A6Jo/NK9OfqqC+iaeZs5hn1788C1PmFASE+j6hVQfQa
         yzALO/hRI4e+Q/2fyL/AXynqf1eb31vaz1/qo8wcRDlWb2MM6IpOD3V7GYMWV0LO3u3H
         RC04LggTI5YKBR1NYmbIWtjwpFQsQmwDoum4K0cedtG/rh7VsQsfj/I93CLiNvgfle24
         Teyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722367096; x=1722971896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2sF0eceqoXNG5LGtMfw8S8kHnapYiMxImOpIZ5orbg=;
        b=QsYy5TPvrYlnNbJK3lZEhVKjU4+MyItxFMDtvFE/tOAQMlCMSrA6OEt9xhcJQOV+Ow
         XyJux669o359yVoQQauL5WfaZkUaz4MbyCDQvdxmM11kSdOTX7QWhq0n4dGe5blSXv1d
         nKifxBB7uWmV0jPMbTrMI0htx+sjoB8eqX1hq8GErwehyEv+icvBcr2hU1XPfetOo8l1
         jVq8tpq5fMn9S32z3bSBaS5SOqoEocSikkAJORq/L1akZBtSfpqZiiVN8bvu0l/tNo0+
         OFh3bwkxQvqsvaDciYpQRQV9AI+nLWT+y7N6FQIXev3qEAc7pCURHZ0aGY5X3ppfzRRD
         p57g==
X-Forwarded-Encrypted: i=1; AJvYcCXr88+PkgtfWjCkIEpUyyKB6G30P3k3p718P+4CTDFNkYTapSCjoTAKfYVZMgj7++ONc4Jo6YXaC7YzHPdPMezUcKOZOX71fLir7Vyx
X-Gm-Message-State: AOJu0Yxksh8/JTFo5LZNVpDeTd/LrByGGe6LMOqIYTZnQlXt5Ub9UT66
	Gih8Y4hCRLTIu5iXFL9031lBatCmmLIKsVJzRcURkiwrttFzW4SLoXnbVARB7Cru081hQcUIZqF
	K4+0WbvKU4uDsjIfe+GncT+k5rKk=
X-Google-Smtp-Source: AGHT+IEznjHMLlgyMAbP6wvlIkg8tzvcopc13YOI3gNan43f7O7Hd/f6lP9/dVui+WirrqkOk8TaYGDyHaNjHQj+wKI=
X-Received: by 2002:a05:6214:5019:b0:6b7:9fe3:b2be with SMTP id
 6a1803df08f44-6bb55af364amr153630796d6.53.1722367095856; Tue, 30 Jul 2024
 12:18:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727230635.3170-1-flintglass@gmail.com> <20240727230635.3170-2-flintglass@gmail.com>
In-Reply-To: <20240727230635.3170-2-flintglass@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 30 Jul 2024 12:18:04 -0700
Message-ID: <CAKEwX=NYL+vRvHvMh43dTa_wHaT=ipi_ttLxd7Cot+tRSasrQQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mm: zswap: fix global shrinker memcg iteration
To: Takero Funaki <flintglass@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
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
> +               /*

Yeah I agree with Yosry's comment - the do while loop looks like it
can become a helper in some form? But that asides, the rest LGTM:

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

