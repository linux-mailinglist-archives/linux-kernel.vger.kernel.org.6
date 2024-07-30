Return-Path: <linux-kernel+bounces-266787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A350094079C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 07:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 532A028469B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 05:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE0616B398;
	Tue, 30 Jul 2024 05:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKA/v9sS"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED3A15B542
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 05:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722317113; cv=none; b=e7gItwscWi+RsunU9rUrW1+4IXiiceXbmyOu52DaZaypsrb9J1291iOhDagNS9g0YVUlaN/KpilzLPhCJsq8N/cEKLnC1dcI9d0l/kldj618Nbyw0a5hrr2hLBquL5/HXhWByOOpmeC84OwO5IRGcbxt2j0A+JHjQJEtztOxvBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722317113; c=relaxed/simple;
	bh=PUcxrHCAwddkWixxoYttRyu4jAhL0opqOG6knUoO/Hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XO4KsT0Pz3PFuPI7ktvVgNXu4kFBThzCipQy9C/V3Vq1omsrG54LyOAX8B0bRX9H5sprYIdghmFwLSW7iZy1dA8O/m0Ih2/Ym2sPsGGRkTuOKN7U4hz7Q4dLlC49cjan4r2RxDGzY4yCHRRlOL/YqgC3ybMdPU0DzxeApOwt29Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKA/v9sS; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e04196b7603so2599294276.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 22:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722317111; x=1722921911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyiDB8MsTuRIBGPC4XFhUVRa3szv8WxrYdF7v0WYTQQ=;
        b=GKA/v9sSKtwVW6MSY8kTUjujf8srl6eUU2K4we/Dh98m1JdPmcCIq+63ukVzHjxVx+
         xCFzz6dl/L4XdhuALg+kut+oMr+l9RW5av6jTvf0bbA2jplYsWbbBTd8vhjVYLokFjzj
         3xAoABoN16Szbv5W6pmczf+JCNWv8RkHmZBat2Z78I60dIh0xo3mHpDPn/xczKwdhiZ1
         IFXG/BJqL4n90J0IjuunSu5tvA63qy5z9S2yRM/PoBZlmXl8t2+IOgxVpdKZ8twbWTBl
         7feKwzowp4JZ0czBhpUEzUEJCRVDEdUlk1S1vtsZQdbMBSOB8O4gcIPhbGS2457kx6D/
         fbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722317111; x=1722921911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cyiDB8MsTuRIBGPC4XFhUVRa3szv8WxrYdF7v0WYTQQ=;
        b=tin5/oqOx5rVSJQgK302CQcL4GQ9JFHF/I5ov+hFTp7lSRCe8Q5tMhE2eVkPxkwIKe
         xkDWPIcDS1zPRBneGXnGElD1pWH4wbDmpBjpPwTYmvMagrHYck96VUoPDLWM4ziNPB75
         AKoJ3MAqcEfT+5JaIuJdX6fJADP2YhkGs9ffUYLsSXD1lx9/RMTX5U3wDOjbbXixI7Yv
         lEZtO65Wm6k6tFhuUlORc8PgESYcAkKD5ZIeVIASPtRoj9TxRExLid3z0Qv6iVIL9ESi
         SXWCnvmRWu0s9n3zHaa3UIWfRnSToUrQQpmJ4rZ3MbmVZiZoKEmZZK6ELTwGxrJk95Vw
         egSw==
X-Forwarded-Encrypted: i=1; AJvYcCW48TlMYmbsJnkFXM1eTBcdRBk2+YpfSJbm9NR/t61oLbEISEepWTmhubTAtuvDJJtNqns7WIYTCGgz+Ap66v2AscyV+/Vy7n9b8YcK
X-Gm-Message-State: AOJu0YzCQFGhI7d5BEVyzmzA4+Xo1u0gIrXkyi4dh72P0s6FG7B8kLWM
	md0IjWK0mMaK7C+Z0nf6YgSUvxsd+tIy8sDFxM+9haA0qQpe7wxDYreOZCRv/FqsYM/neGlzMx5
	UNW5R/2+/j/4XEBgxwzAVh+6FxZQ=
X-Google-Smtp-Source: AGHT+IFZffRehTVlzmv9yHNpiisxr9LSLmbs4TmHWA1G83FovhjHw4k8OFBV0ksRQhqaEBdbKmu7ADZ7QIm7EfUv8K0=
X-Received: by 2002:a05:6902:120a:b0:e06:d62c:98ec with SMTP id
 3f1490d57ef6-e0b545b9fb4mr9543675276.45.1722317110554; Mon, 29 Jul 2024
 22:25:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727230635.3170-1-flintglass@gmail.com> <20240727230635.3170-2-flintglass@gmail.com>
 <CAJD7tkYKC8Cy0tCc=1m5x=bXVaXPhzRhWjeP5n6YofuPeTgOwg@mail.gmail.com>
In-Reply-To: <CAJD7tkYKC8Cy0tCc=1m5x=bXVaXPhzRhWjeP5n6YofuPeTgOwg@mail.gmail.com>
From: Takero Funaki <flintglass@gmail.com>
Date: Tue, 30 Jul 2024 14:24:58 +0900
Message-ID: <CAPpoddcHCgZGx3DZXBzDCZRVNYpzf+aoeTYYd8Fr3GyndtNC2w@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mm: zswap: fix global shrinker memcg iteration
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B47=E6=9C=8830=E6=97=A5(=E7=81=AB) 3:24 Yosry Ahmed <yosryahmed@=
google.com>:
>
> On Sat, Jul 27, 2024 at 4:06=E2=80=AFPM Takero Funaki <flintglass@gmail.c=
om> wrote:
> >
> > This patch fixes an issue where the zswap global shrinker stopped
> > iterating through the memcg tree.
> >
> > The problem was that shrink_worker() would restart iterating memcg tree
> > from the tree root, considering an offline memcg as a failure, and abor=
t
> > shrinking after encountering the same offline memcg 16 times even if
> > there is only one offline memcg. After this change, an offline memcg in
> > the tree is no longer considered a failure. This allows the shrinker to
> > continue shrinking the other online memcgs regardless of whether an
> > offline memcg exists, gives higher zswap writeback activity.
> >
> > To avoid holding refcount of offline memcg encountered during the memcg
> > tree walking, shrink_worker() must continue iterating to release the
> > offline memcg to ensure the next memcg stored in the cursor is online.
> >
> > The offline memcg cleaner has also been changed to avoid the same issue=
.
> > When the next memcg of the offlined memcg is also offline, the refcount
> > stored in the iteration cursor was held until the next shrink_worker()
> > run. The cleaner must release the offline memcg recursively.
> >
> > Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
> > Signed-off-by: Takero Funaki <flintglass@gmail.com>
> > ---
> >  mm/zswap.c | 73 ++++++++++++++++++++++++++++++++++++------------------
> >  1 file changed, 49 insertions(+), 24 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index adeaf9c97fde..e9b5343256cd 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -765,12 +765,31 @@ void zswap_folio_swapin(struct folio *folio)
> >         }
> >  }
> >
> > +/*
> > + * This function should be called when a memcg is being offlined.
> > + *
> > + * Since the global shrinker shrink_worker() may hold a reference
> > + * of the memcg, we must check and release the reference in
> > + * zswap_next_shrink.
> > + *
> > + * shrink_worker() must handle the case where this function releases
> > + * the reference of memcg being shrunk.
> > + */
> >  void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
> >  {
> >         /* lock out zswap shrinker walking memcg tree */
> >         spin_lock(&zswap_shrink_lock);
> > -       if (zswap_next_shrink =3D=3D memcg)
> > -               zswap_next_shrink =3D mem_cgroup_iter(NULL, zswap_next_=
shrink, NULL);
> > +       if (zswap_next_shrink =3D=3D memcg) {
> > +               do {
> > +                       zswap_next_shrink =3D mem_cgroup_iter(NULL, zsw=
ap_next_shrink, NULL);
> > +               } while (zswap_next_shrink && !mem_cgroup_online(zswap_=
next_shrink));
> > +               /*
> > +                * We verified the next memcg is online.  Even if the n=
ext
> > +                * memcg is being offlined here, another cleaner must b=
e
> > +                * waiting for our lock.  We can leave the online memcg
> > +                * reference.
> > +                */
>
> I thought we agreed to drop this comment :)
>
> > +       }
> >         spin_unlock(&zswap_shrink_lock);
> >  }
> >
> > @@ -1304,43 +1323,49 @@ static void shrink_worker(struct work_struct *w=
)
> >         /* Reclaim down to the accept threshold */
> >         thr =3D zswap_accept_thr_pages();
> >
> > -       /* global reclaim will select cgroup in a round-robin fashion. =
*/
> > +       /* global reclaim will select cgroup in a round-robin fashion.
>
> nit: s/global/Global
>
> > +        *
> > +        * We save iteration cursor memcg into zswap_next_shrink,
> > +        * which can be modified by the offline memcg cleaner
> > +        * zswap_memcg_offline_cleanup().
> > +        *
> > +        * Since the offline cleaner is called only once, we cannot lea=
ve an
> > +        * offline memcg reference in zswap_next_shrink.
> > +        * We can rely on the cleaner only if we get online memcg under=
 lock.
> > +        *
> > +        * If we get an offline memcg, we cannot determine if the clean=
er has
> > +        * already been called or will be called later. We must put bac=
k the
> > +        * reference before returning from this function. Otherwise, th=
e
> > +        * offline memcg left in zswap_next_shrink will hold the refere=
nce
> > +        * until the next run of shrink_worker().
> > +        */
> >         do {
> >                 spin_lock(&zswap_shrink_lock);
> > -               zswap_next_shrink =3D mem_cgroup_iter(NULL, zswap_next_=
shrink, NULL);
> > -               memcg =3D zswap_next_shrink;
> >
> >                 /*
> > -                * We need to retry if we have gone through a full roun=
d trip, or if we
> > -                * got an offline memcg (or else we risk undoing the ef=
fect of the
> > -                * zswap memcg offlining cleanup callback). This is not=
 catastrophic
> > -                * per se, but it will keep the now offlined memcg host=
age for a while.
> > -                *
> > +                * Start shrinking from the next memcg after zswap_next=
_shrink.
> > +                * When the offline cleaner has already advanced the cu=
rsor,
> > +                * advancing the cursor here overlooks one memcg, but t=
his
> > +                * should be negligibly rare.
> > +                */
> > +               do {
> > +                       memcg =3D mem_cgroup_iter(NULL, zswap_next_shri=
nk, NULL);
> > +                       zswap_next_shrink =3D memcg;
> > +               } while (memcg && !mem_cgroup_tryget_online(memcg));
>
> Let's move spin_lock() and spin_unlock() to be right above and before
> the do-while loop, similar to zswap_memcg_offline_cleanup(). This
> should make it more obvious what the lock is protecting.
>
> Actually, maybe it would be cleaner at this point to move the
> iteration to find the next online memcg under lock into a helper, and
> use it here and in zswap_memcg_offline_cleanup(). zswap_shrink_lock
> and zswap_next_shrink can be made static to this helper and maybe some
> of the comments could live there instead. Something like
> zswap_next_shrink_memcg().
>
> This will abstract this whole iteration logic and make shrink_worker()
> significantly easier to follow. WDYT?
>
> I can do that in a followup cleanup patch if you prefer this as well.
>

I'd really appreciate it. Sorry to have kept you waiting for a novice
coder. Thank you for all your comments and support.

