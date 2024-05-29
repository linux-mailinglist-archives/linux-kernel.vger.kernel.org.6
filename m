Return-Path: <linux-kernel+bounces-194100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D798D3699
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221FE285B79
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F69181BA7;
	Wed, 29 May 2024 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2HMRmVb"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5A7181B83;
	Wed, 29 May 2024 12:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716986558; cv=none; b=aafpO1LQyd7tYnDbgR/jQQXQkX7y+ZpGt4KlfR2e9+KhCu3nUFRJzSWeMVK2piq5eA/TKAH/AE/ZP5O1dyDd7/GR4BCoq9QR+xk6zLp4GqGmA0P1UsyaLArsi96FX6DJAXA9FtysXl1E9P7/ifhJjG+/HKuGEQbxCWX3QAD+TWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716986558; c=relaxed/simple;
	bh=rMOG4bFrDA+KX8+4P7QFD49tVIsWAJw+cw+RGJ5Z8p4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VwPWLngjAJXru34EC+pxOC1TsTS5lEJqnGs1Ox13XNKxayzwEYsm9NSFNwbQfHMuOUtw5XphM5gMg/+EcLGTT5AKoWyTgwgPgIukJRUr+goFFNXX5YQ5jr28pruVbPhu03TRVv7hdBQiZGI509pHYvO3LP8n8skBRzKc9XFUVRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2HMRmVb; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-627ebbefd85so21580327b3.3;
        Wed, 29 May 2024 05:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716986555; x=1717591355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FcVvsj5wuI35cIO8lkBusWD2C94l8ZGuanLrynn79Jo=;
        b=R2HMRmVbdoEG3zbWuM3sl2RK2SizD/U0NWazopvPIgsiCTFstskJYdGngN998TyU73
         XlPuyW51l9HcuCBB56B2vJQNDL03D/ylIcfEl6Gr9xKS1nQZ6tmc7SkVBasnyNPyqW+A
         Sf7WMZWTEfN4rSlpk/oy71R608ISRMslJ1ujOi3SkemLDP2KQDNGka7pihB4AxgoO6YR
         vCYxqpgd90MglQrV19J1d6ty7fJhDJxFLu4xYrTRfxfi+9VtKnmybXt0msbSE7ZRlDgJ
         kV0COwlz8M1TON56YXS9BFgCVS2ZSZWysZebaaknK8ehn0GLlFIopWWxvdECSdDI1NUI
         TLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716986555; x=1717591355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FcVvsj5wuI35cIO8lkBusWD2C94l8ZGuanLrynn79Jo=;
        b=p9Dcpvv8eXe8L9KOZ/lnNMc8MKtQrBYrTh2O/XtUp8NoQ4YCwModhrRaRzcVH0Wkck
         sBTCHxpsyUbbBCY2XuVv+PNSLzS6be5FTwElNLwur63LS96IO5lwTW1Zo7iLZx2zT8mt
         WOuFQsL/N8LwflzCt6yrMI4nzMgz0DpJHwmAbY22k/hkcScFwR/kbTMzwN9kMYxYrxjg
         bquTSBMmsPi+d0kvWq3mP+/9kvCSXmkcRWKYINxAbeqea0BQ3cKLXj/EFlLGaJYIyiPA
         VYhe4jgrjBoXYu9m0we9QLI5GSlPoQpOc6pg2+JV0hVgGyLL8PiF+OhwNeD960ldSWFL
         LrkA==
X-Forwarded-Encrypted: i=1; AJvYcCWeJ/YQN6JfSCM/APqkVg61awUc2dRUHkUPxz/PD4h0kiA42ML00MiLi8TUqNmYEKT+c32bxy1R223gw5L0nwJNWS6Wan1YPE1IW8T6rZhA3hahfGoCGnOW4xtvoj7YUNNLv0fTPvtv
X-Gm-Message-State: AOJu0YyMKCWsOVJTQ9UwcsK8jj3LCQ0EE7gHH3soSRlOes3G1gXL44vU
	z1L5T+SbpMfbk+lau66scOZh6EMBE3FgAKmwdNBmTbLmcrs1h4w+/s3SdWkjWfGq8hvqXMPyNXt
	CKJEEpDKVRlTLdRnNhQ7qs2nMt8s=
X-Google-Smtp-Source: AGHT+IGfJmkyfeAoH1PK8nD22RQ2FCOmEIRbm+9A28GZ3t1z0wsyghvBwgyVlcJpY99RjuLJaYocEx6k+23hfEkbx3M=
X-Received: by 2002:a81:9182:0:b0:617:cb98:f9b2 with SMTP id
 00721157ae682-62a08f2cae4mr149086817b3.43.1716986555273; Wed, 29 May 2024
 05:42:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528043404.39327-2-flintglass@gmail.com> <20240528043404.39327-3-flintglass@gmail.com>
 <CAKEwX=MwrRc43iM2050v5u-TPUK4Yn+a4G7+h6ieKhpQ7WtQ=A@mail.gmail.com>
In-Reply-To: <CAKEwX=MwrRc43iM2050v5u-TPUK4Yn+a4G7+h6ieKhpQ7WtQ=A@mail.gmail.com>
From: Takero Funaki <flintglass@gmail.com>
Date: Wed, 29 May 2024 21:42:23 +0900
Message-ID: <CAPpoddfv-c4RJUU_QyVON8A7GfAPvty2xnHB1oqPHS_9pnQfGA@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: zswap: fix global shrinker memcg iteration
To: Nhat Pham <nphamcs@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B45=E6=9C=8829=E6=97=A5(=E6=B0=B4) 0:10 Nhat Pham <nphamcs@gmail=
com>:
>
> On Mon, May 27, 2024 at 9:34=E2=80=AFPM Takero Funaki <flintglass@gmail.c=
om> wrote:
> >
> > This patch fixes an issue where the zswap global shrinker stopped
> > iterating through the memcg tree.
>
> Did you observe this problem in practice?

Thank you for your comments.

I think this situation is rare, but I need to address this to ensure
patch 2 will not stop at the offline memcg.
The main issue I am seeing in version 6.9.0 to 6.10.0rc1 is that the
shrinker did not shrink until accept_thr_percent, and the
written_back_pages is smaller than max_limit_hit.
This can be explained by the shrinker stopping too early or looping
over only part of the tree.

> >
> > The problem was that `shrink_worker()` would stop iterating when a memc=
g
> > was being offlined and restart from the tree root.  Now, it properly
> > handles the offlining memcg and continues shrinking with the next memcg=
.
> >
> > Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
> > Signed-off-by: Takero Funaki <flintglass@gmail.com>
> > ---
> >  mm/zswap.c | 76 ++++++++++++++++++++++++++++++++++++++++--------------
> >  1 file changed, 56 insertions(+), 20 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index a50e2986cd2f..0b1052cee36c 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -775,12 +775,27 @@ void zswap_folio_swapin(struct folio *folio)
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
> > +
> > +       if (READ_ONCE(zswap_next_shrink) =3D=3D memcg) {
> > +               /* put back reference and advance the cursor */
> > +               memcg =3D mem_cgroup_iter(NULL, memcg, NULL);
> > +               WRITE_ONCE(zswap_next_shrink, memcg);
> > +       }
>
> Hmm could you expand on how your version differs from what's existing?
> What's the point of all these extra steps? The whole thing is done
> under a big spin lock anyway.

I agree that the code is not necessary. These ONCE are for clarifying
what is expected and to align with shrink_worker(), where READ_ONCE is
required to reload the shared variable.
It can be a safeguard for me, sometimes forgetting that we must not
read zswap_next_shrink before acquiring the lock.

> > +
> >         spin_unlock(&zswap_shrink_lock);
> >  }
> >
> > @@ -1312,25 +1327,38 @@ static int shrink_memcg(struct mem_cgroup *memc=
g)
> >
> >  static void shrink_worker(struct work_struct *w)
> >  {
> > -       struct mem_cgroup *memcg;
> > +       struct mem_cgroup *memcg =3D NULL;
> > +       struct mem_cgroup *next_memcg;
> >         int ret, failures =3D 0;
> >         unsigned long thr;
> >
> >         /* Reclaim down to the accept threshold */
> >         thr =3D zswap_accept_thr_pages();
> >
> > -       /* global reclaim will select cgroup in a round-robin fashion. =
*/
> > +       /* global reclaim will select cgroup in a round-robin fashion.
> > +        *
> > +        * We save iteration cursor memcg into zswap_next_shrink,
> > +        * which can be modified by the offline memcg cleaner
> > +        * zswap_memcg_offline_cleanup().
> > +        */
>
> I feel like the only difference between this loop and the old loop, is
> that if we fail to get an online reference to memcg, we're trying from
> the next one (given by mem_cgroup_iter()) rather than from the top
> (NULL).
>
> For instance, consider the first two steps:
>
> 1. First, we check if memcg is the same as zswap_next_shrink. if not,
> then reset it to zswap_next_shrink.
> 2. Advance memcg, then store the result at zswap_next_shrink.
>
> Under the big zswap_shrink_lock, this is the same as:
>
> 1. Advance zswap_next_shrink.
> 2. Look up zswap_next_shrink, then store it under the local memcg variabl=
e.
>
> which is what we were previously doing.
>
> The next step is shared - check for null memcg (which again, is the
> same as zswap_next_shrink now), and attempt to get an online
> reference.
> The only difference is when we fail to get the online reference -
> instead of starting from the top, we advance memcg again.
>
> Can't we just drop the lock, then add a continue statement? That will
> reacquire the lock, advance zswap_next_shrink, look up the result and
> store it at memcg, which is what you're trying to achieve?
>

If I understand correctly, in this offlining pattern, we are not
allowed to leave an offline memcg in zswap_next_shrink more than once.
While offline memcg can appear in memcg_iter_next repeatedly, the
cleaner is called only once per an offline memcg. (or is there some
retry logic?)

If the shrink_worker finds an offline memcg in iteration AFTER the
cleaner was called, we must put back the offline memcg reference
inside shrink_worker() BEFORE going to return/sleep.
Otherwise, the offline memcg reference will be kept in
zswap_next_shrink until the next shrink_worker() is requeued. There is
no rescue chance from the cleaner again.

This means the shrink_worker has to check:
1. We get a lock. Check if the memcg is online while locked.
2a. If online, it can be offlined while we have the lock. But the lock
assures us that the cleaner is waiting for the lock just behind us. We
can rely on this.
2b. If offline, we cannot determine if the cleaner has already been
called or is being called. We have to put back the offline memcg
reference, assuming no cleaner is available.

If we get offline memcg AND abort the shrinker by the max failure
limit, that breaks condition 2b. Thus we need to unconditionally
restart from the beginning of the do block.
I will add these expected situations to the comments.

For unlocking, should we rewrite,

goto iternext;

to

spin_unlock();
goto before_spin_lock; /* just after do{ */

I think that will minimize the critical section and satisfy the condition 2=
b.

For the memcg iteration,
> 2. Advance memcg, then store the result at zswap_next_shrink.
should be done only if `(memcg =3D=3D zswap_next_shrink)`.

Say iterating A -> B -> C and A is being offlined.
While we have memcg=3DA and drop the lock, the cleaner may advance
zswap_next_shrink=3DA to B.
If we do not check `memcg !=3D next_memcg`, we advance
zswap_next_shrink=3DB to C again, forgetting B.

That is the reason I added  `(memcg !=3D next_memcg)` check.
Although It can be negligible as it only ignores one memcg per one
cleaner callback.

This is my understanding. Am I missing any crucial points? Any
comments or advice would be greatly appreciated.

> >         do {
> >                 spin_lock(&zswap_shrink_lock);
> > -               zswap_next_shrink =3D mem_cgroup_iter(NULL, zswap_next_=
shrink, NULL);
> > -               memcg =3D zswap_next_shrink;
> > +               next_memcg =3D READ_ONCE(zswap_next_shrink);
> > +
> > +               if (memcg !=3D next_memcg) {
> > +                       /*
> > +                        * Ours was released by offlining.
> > +                        * Use the saved memcg reference.
> > +                        */
> > +                       memcg =3D next_memcg;
> > +               } else {
> > +iternext:
> > +                       /* advance cursor */
> > +                       memcg =3D mem_cgroup_iter(NULL, memcg, NULL);
> > +                       WRITE_ONCE(zswap_next_shrink, memcg);
> > +               }
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
>
> Why are we removing this comment?

The existing comment about aborting the loop on the offlining memcg,
is not valid on  this patch. The offline memcg will just be skipped.
I think the new behavior is commented at the beginning of the loop and
in the !mem_cgroup_tryget_online branch. Please let me know if you
have any suggestions.


> >                  * Note that if we got an online memcg, we will keep th=
e extra
> >                  * reference in case the original reference obtained by=
 mem_cgroup_iter
> >                  * is dropped by the zswap memcg offlining callback, en=
suring that the
> > @@ -1345,16 +1373,18 @@ static void shrink_worker(struct work_struct *w=
)
> >                 }
> >
> >                 if (!mem_cgroup_tryget_online(memcg)) {
> > -                       /* drop the reference from mem_cgroup_iter() */
> > -                       mem_cgroup_iter_break(NULL, memcg);
> > -                       zswap_next_shrink =3D NULL;
> > -                       spin_unlock(&zswap_shrink_lock);
> > -
> > -                       if (++failures =3D=3D MAX_RECLAIM_RETRIES)
> > -                               break;
> > -
> > -                       goto resched;
>
> I think we should still increment the failure counter, to guard
> against long running/infinite loops.

Since we skip the offline memcg instead of restarting from the root,
the new iteration will be terminated when it reaches tree root in
finite steps.  I am afraid that counting this as a failure will
terminate the shrinker too easily.

I think shrinker_worker() running longer is not an issue because the
amount of work per the while loop is limited by rescheduling. As it
has a dedicated WQ_MEM_RECLAIM workqueue, returning from the function
is not necessary. cond_resched() should allow the other workqueue to
run.
The next patch also adds a progress check per walking.


> > +                       /*
> > +                        * It is an offline memcg which we cannot shrin=
k
> > +                        * until its pages are reparented.
> > +                        * Put back the memcg reference before cleanup
> > +                        * function reads it from zswap_next_shrink.
> > +                        */
> > +                       goto iternext;
> >                 }
> > +               /*
> > +                * We got an extra memcg reference before unlocking.
> > +                * The cleaner cannot free it using zswap_next_shrink.
> > +                */
> >                 spin_unlock(&zswap_shrink_lock);
> >
> >                 ret =3D shrink_memcg(memcg);
> > @@ -1368,6 +1398,12 @@ static void shrink_worker(struct work_struct *w)
> >  resched:
> >                 cond_resched();
> >         } while (zswap_total_pages() > thr);
> > +
> > +       /*
> > +        * We can still hold the original memcg reference.
> > +        * The reference is stored in zswap_next_shrink, and then reuse=
d
> > +        * by the next shrink_worker().
> > +        */
> >  }
> >
> >  /*********************************
> > --
> > 2.43.0
> >



--

<flintglass@gmail.com>

