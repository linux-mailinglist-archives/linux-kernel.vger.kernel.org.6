Return-Path: <linux-kernel+bounces-259626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3059399B8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEBF51C21ADE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 06:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1957614A4C8;
	Tue, 23 Jul 2024 06:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hskgCX+l"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41745DDD9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 06:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721716253; cv=none; b=OIHX530bneOzIsuErjSLPbrHhrBz0C7iZjkBTrSvb1YYDckEOyBLshjxBWOHtRkTsEBtdGa1PHkInVOreGtP7pG+tHhIWOIDpejKarTBQujIFGXDccvyXty3CsmRTucUFBnw8qR7DImq25oX8mvESclEtTCo5GyFPIASfXtn6eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721716253; c=relaxed/simple;
	bh=yOBoEr3oCQvwdpHhbwl24aOk8xHMeTijLqT5BMVYKh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=anXZ2jj7ls42bjHd+s3bjAFkaQMS588Tu8Kco/odiD0qP9kzDDEBaRD5sfQ52MQzAOkTi3KyYC9vPKDRQVASb0Cii6SS3rngYRF3tLyXcuZdPM4zK1Hzg0EVdelNAxnXoo6fLzYbSaQYsIIvhxMEzHNktpPYzcmnDYTj2F5/CCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hskgCX+l; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f01e9f53e3so12019061fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 23:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721716249; x=1722321049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gixz8dZHBgc5zRylZtlf8sz3hXFhSAuDE08kVvUavqs=;
        b=hskgCX+lHUOSCV2dQ1AcS4l148wUxp8LYuyoP0P5K1Y30FP15aHhAoS4Utgsln6RAF
         KVYkmO6XdlqF1Yg/NT8OWOjjXSHQaF6bV95mIg7UJKbGYpwBs+irtSVI5GCL3qWvZb8H
         7lQz+mAw1ywBjEiq3S2OfN7WOLzY2aKKD9n0is+dOO0/GDTofB66su3U1BqhQ2GE5wfh
         uA4iyaXWpKAacVZe+aVGYVwn9Qoy/DiWO7lKUP7vn/0sSalqNSRDXK3CAaS8+bCvCyyk
         5ug8hruhRgSTdWSsbCvWF4mU8T1dVX4Tqq3Ds5k1bLuxlgq+OcvZsi71OvNqirlbh3nT
         UCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721716249; x=1722321049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gixz8dZHBgc5zRylZtlf8sz3hXFhSAuDE08kVvUavqs=;
        b=pofCL2NJQM01bJdEGmTwURPv7FVBERZ8gSjZpeqyulAlQDmboY/VHR7TkJO+GcukNo
         XflpxZZ1Zj3x51cecKmGLLUcs9W/319NUO/Lefi0cRxKPOJvwxELvYP9mVckyhPM1Sjh
         ZuRdlXcepoPBUsODW0FeI2WI3UmhSjDVf8wpkoS4JS3tWqIgIFrX5vUlAOfQH7jPCaL7
         TphflMZLj5pGSQHJltS73doQ9WuwHlAdGH2wc+g1w4/Gds45AXHH6epv/SNT4V0DEpkV
         aUo48i3UwjUL3AiaEuLXjYAmmmKAskRG/cx44XEoK0QjxoC0diJmW1IbV7U+U9AioHmf
         V56g==
X-Forwarded-Encrypted: i=1; AJvYcCVQrrbPwr6GfXWyu2yY5nFbXr50cVcDf5ePiBF2Mj1PqDhNLmd3du5z8CZrBW07YVQAmzwnNaHiYdMM69oc6EhgFLsoitN1LhVJJ2hC
X-Gm-Message-State: AOJu0Yw6OPiM3NpXRlfhbN73APWmyXQBzW2lT+/dnnnsJBN1IPaIJTE9
	93PjWwN9M3t7WNOTwZ97Me7gIzF0nmxU52Nomiu1orDtg2tl5POD3n6IHLyktcgSRC1mwiv7PDX
	SdpRKdDuudtL+AlxTaiPrme3g/4m8oEpqSVMh
X-Google-Smtp-Source: AGHT+IEy9unlR+4QdQeJutICK2sO9G/qd8PbuQ0KDOxxghXJTcuq3XWPg1WGevyTZQnqI6Ecrv1NMQVTTJxxPlnN6lE=
X-Received: by 2002:a2e:a595:0:b0:2ef:2c3c:512a with SMTP id
 38308e7fff4ca-2ef2c3c5208mr49955271fa.42.1721716248735; Mon, 22 Jul 2024
 23:30:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240720044127.508042-1-flintglass@gmail.com> <20240720044127.508042-2-flintglass@gmail.com>
In-Reply-To: <20240720044127.508042-2-flintglass@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 22 Jul 2024 23:30:12 -0700
Message-ID: <CAJD7tka=8YgUx2H=KSjN8ot0TDrh+bZCAgR6iRTfyUqNm7zYfg@mail.gmail.com>
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

I think this comment and the similar one at the end of the loop in
shrink_worker() are very similar and not necessary. The large comment
above the loop in shrink_worker() already explains how that loop and
the offline memcg cleaner interact, and I think the locking follows
naturally from there. You can explicitly mention the locking there as
well if you think it helps, but I think these comments are a little
repetitive and do not add much value.

I don't feel strongly about it tho, if Nhat feels like they add value
then I am okay with that.

Otherwise, and with Nhat's other comments addressed:
Acked-by: Yosry Ahmed <yosryahmed@google.com>

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

