Return-Path: <linux-kernel+bounces-212055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC55905A9C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94757283F57
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E6C40867;
	Wed, 12 Jun 2024 18:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inPNK/6G"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5F0376EC;
	Wed, 12 Jun 2024 18:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718216216; cv=none; b=NjxdgyjyRPPjJg20/lbACqFBezkaWwEQak9N9CEetAiTK5FTCWdpa0ztotM/K2uduqEOBI9CKISE9tPlT/PC3uwU4LMP1dpVNjBr5nhK1hI5VoPjiJTiFFRcWvacHoJ3nSMziHgYKFyXPq/4lxGdmfoYvkasSaP1+aWJrVxdGro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718216216; c=relaxed/simple;
	bh=8UdL2KFJKwnafciSWWW32tPsoKO+GmqGqjDp0IMgwsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dQ2gO1CfmR4GAgkoXKKsJ/gIB9+MnG7Nn4YDUcOJwYomsqnsA9WrVmyuJfb71L4dsUwxm9dAab/ph3f1x6TyoapgY5VbSJhxgE1HfVuSrz3rOOxpByUhi1jE+bnjlupHx0vcwaRGp9XkhXm6wqPMko4CNCiXKiD41Y4MR+qLrdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inPNK/6G; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dfe81d54db9so165713276.2;
        Wed, 12 Jun 2024 11:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718216213; x=1718821013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTwDbvfDAEVuWYB0ESepl2sBU9bDbBMIjrrkfroH+Uw=;
        b=inPNK/6GNryCuw7V+/HoGG0kiR9NbzVVz0iAbij1RjNIIM7TG4FOj4Z8iimjuHtv78
         5uH29d9Sl84YAlSwKyrCWfa4JKfR+UKVVd07nUxZKVnSMTti6a0oYSGOnchlOa+aOiC0
         exg1S9AB4Maz/Sg6cRUpeOpF3r92EPWgEDvYyh4gv2aHDEziKs2DTVdjsslXM7bJ1tyN
         wvE1MwdlBgBSS3EZUnxjzqRSOGchDsgaER3L5nkcaONMtpcC5ln2JF5QGWOWf7KNpmnW
         qQzCcAH3Jgd5CtUbmjOkaH4nNhhJCXOsIT6Qc5shCTas/aep0M2hyc9wCyKu7DMqNjG6
         ZU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718216213; x=1718821013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bTwDbvfDAEVuWYB0ESepl2sBU9bDbBMIjrrkfroH+Uw=;
        b=COdRCZwf+G0Cu/Z8qC5A1oM+V4FlaQsVScex8+ScrGSQ1ZV4ZJC3jXsWAaWpZot8kS
         Kv1Se0WAAUOh0FDBhpFBjpxws+lBvXti9C76DUCcKW9D41nUMeoPk3pw82uQBB5g8Ftl
         wlbPu8X6SwpYxAvjF3BrxABX7+1MSxmV8t4e8ecGWMluaeOK2jsk9hcRlHX2cHS+YHwl
         rbg4KOmZRqleDKVv/3CJFkrFnZkRmZO3hQpQSvz+HKaVmA4Yu0ZOKiavKOb7ttMek3Ag
         McyJEnH6uu+WIcD7wWV749MfnQG7Hd/YO3MxDYp5eqNksRAPam9P29CkFl+isVOz8Qni
         JwCg==
X-Forwarded-Encrypted: i=1; AJvYcCXEYv9MZm8WQ3G9z1/Agj4XH/9IIX+n6gVnlaflpMOMb1hD/T84L9dzBFPgX+hyHrLHggPmntYdXOEC0fk2I7Ukr2c9+Bi4sXS4NnHSfGlUA/bt+BCWICaG/0mYRvRZuQUL0ICBEMx/
X-Gm-Message-State: AOJu0Yxvs1MU/ELfJeOYc4/I7+DnuLVzoeHUk5qG+e3XvDdl2L1w6ENt
	aLYk7jGjMzrQY/tsCR/Fzhh6yUUZ9HDJKWtetJ1Gx6bKOTBarWB0RO6BfRLI35HGfKhvSK8Mupc
	U9xoddIJzZ2zq7wJUsDFBiPkURHQ=
X-Google-Smtp-Source: AGHT+IEuPoSniiMQhKZmRRgqC3SgXJOkxDhb4vEa9QopgajXXTElzjq26aqJJGOS015KIrnPvNsKb2nlr3F/PSMhC8I=
X-Received: by 2002:a25:ac8d:0:b0:df4:dd49:7ae7 with SMTP id
 3f1490d57ef6-dfe6706216dmr2553240276.24.1718216213279; Wed, 12 Jun 2024
 11:16:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608155316.451600-1-flintglass@gmail.com> <20240608155316.451600-2-flintglass@gmail.com>
 <CAKEwX=P1Ojb71AEJ2gzQTrfWidFPcJZmoNxEwji7TceBN-szCg@mail.gmail.com>
In-Reply-To: <CAKEwX=P1Ojb71AEJ2gzQTrfWidFPcJZmoNxEwji7TceBN-szCg@mail.gmail.com>
From: Takero Funaki <flintglass@gmail.com>
Date: Thu, 13 Jun 2024 03:16:42 +0900
Message-ID: <CAPpoddeigM44jhTA8Ua=+J4MC1MikouBZVoPrCW2LZF+9r5YeA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] mm: zswap: fix global shrinker memcg iteration
To: Nhat Pham <nphamcs@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B46=E6=9C=8812=E6=97=A5(=E6=B0=B4) 3:26 Nhat Pham <nphamcs@gmail=
.com>:

>
> As I have noted in v0, I think this is unnecessary and makes it more conf=
using.
>

Does spin_lock() ensure that compiler optimizations do not remove
memory access to an external variable? I think we need to use
READ_ONCE/WRITE_ONCE for shared variable access even under a spinlock.
For example,
https://elixir.bootlin.com/linux/latest/source/mm/mmu_notifier.c#L234

isn't this a common use case of READ_ONCE?
```c
bool shared_flag =3D false;
spinlock_t flag_lock;

void somefunc(void) {
    for (;;) {
        spin_lock(&flag_lock);
        /* check external updates */
        if (READ_ONCE(shared_flag))
            break;
        /* do something */
        spin_unlock(&flag_lock);
    }
    spin_unlock(&flag_lock);
}
```
Without READ_ONCE, the check can be extracted from the loop by optimization=
.

In shrink_worker, zswap_next_shrink is the shared_flag , which can be
updated by concurrent cleaner threads, so it must be re-read every
time we reacquire the lock. Am I badly misunderstanding something?

> >         do {
> > +iternext:
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
> > +                       /* advance cursor */
> > +                       memcg =3D mem_cgroup_iter(NULL, memcg, NULL);
> > +                       WRITE_ONCE(zswap_next_shrink, memcg);
> > +               }
>
> I suppose I'm fine with not advancing the memcg when it is already
> advanced by the memcg offlining callback.
>

For where to restart the shrinking, as Yosry pointed, my version
starts from the last memcg (=3Dretrying failed memcg or evicting once
more)
I now realize that skipping the next memcg of offlined memcg is less
likely to happen. I am reverting it to restart from the next memcg of
zswap_next_shrink.
Which one could be better?

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
> >                  * Note that if we got an online memcg, we will keep th=
e extra
> >                  * reference in case the original reference obtained by=
 mem_cgroup_iter
> >                  * is dropped by the zswap memcg offlining callback, en=
suring that the
> > @@ -1434,16 +1468,25 @@ static void shrink_worker(struct work_struct *w=
)
> >                 }
> >
> >                 if (!mem_cgroup_tryget_online(memcg)) {
> > -                       /* drop the reference from mem_cgroup_iter() */
> > -                       mem_cgroup_iter_break(NULL, memcg);
> > -                       zswap_next_shrink =3D NULL;
> > +                       /*
> > +                        * It is an offline memcg which we cannot shrin=
k
> > +                        * until its pages are reparented.
> > +                        *
> > +                        * Since we cannot determine if the offline cle=
aner has
> > +                        * been already called or not, the offline memc=
g must be
> > +                        * put back unconditonally. We cannot abort the=
 loop while
> > +                        * zswap_next_shrink has a reference of this of=
fline memcg.
> > +                        */
> >                         spin_unlock(&zswap_shrink_lock);
> > -
> > -                       if (++failures =3D=3D MAX_RECLAIM_RETRIES)
> > -                               break;
> > -
> > -                       goto resched;
> > +                       goto iternext;
>
> Hmmm yeah in the past, I set it to NULL to make sure we're not
> replacing zswap_next_shrink with an offlined memcg, after that zswap
> offlining callback for that memcg has been completed..
>
> I suppose we can just call mem_cgroup_iter(...) on that offlined
> cgroup, but I'm not 100% sure what happens when we call this function
> on a cgroup that is currently being offlined, and has gone past the
> zswap offline callback stage. So I was just playing it safe and
> restart from the top of the tree :)
>
> I think this implementation has that behavior right? We see that the
> memcg is offlined, so we drop the lock and go to the beginning of the
> loop. We reacquire the lock, and might see that zswap_next_shrink =3D=3D
> memcg, so we call mem_cgroup_iter(...) on it. Is this safe?
>
> Note that zswap_shrink_lock only orders serializes this memcg
> selection loop with memcg offlining after it - there's no guarantee
> what's the behavior is for memcg offlining before it (well other than
> one reference that we manage to acquire thanks to
> mem_cgroup_iter(...), so that memcg has not been freed, but not sure
> what we can guarantee regarding its place in the memcg hierarchy
> tree?).

The locking mechanism in shrink_worker does not rely on what the next
memcg is.sorting stability of mem_cgroup_iter does not matter
here.
The expectation for the iterator is that it will walk through all live
memcgs. I believe mem_cgroup_iter uses parent-to-leaf ordering of
cgroup and it ensures all live cgroups are walked at least once,
regardless of its onlineness.
https://elixir.bootlin.com/linux/v6.10-rc2/source/mm/memcontrol.c#L1368

Regarding reference leak, I overlooked a scenario where a leak might
occur in the existing cleaner. although it should be rare.

When the cleaner is called on a memcg in zswap_next_shrink, the next
memcg from mem_cgroup_iter() can be an offline already-cleaned memcg,
resulting in a reference leak of the next memcg from the cleaner. We
should implement the same online check in the cleaner, like this:


```c
void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
{
        struct mem_cgroup *next;

        /* lock out zswap shrinker walking memcg tree */
        spin_lock(&zswap_shrink_lock);
        if (zswap_next_shrink =3D=3D memcg) {
                next =3D zswap_next_shrink;
                do {
                        next =3D mem_cgroup_iter(NULL, next, NULL);
                        WRITE_ONCE(zswap_next_shrink, next);

                        spin_unlock(&zswap_shrink_lock);
                        /* zswap_next_shrink might be updated here */
                        spin_lock(&zswap_shrink_lock);

                        next =3D READ_ONCE(zswap_next_shrink);
                        if (!next)
                                break;
                } while (!mem_cgroup_online(next));
                /*
                 * We verified the next memcg is online under lock.
                 * Even if the next memcg is being offlined here, another
                 * cleaner for the next memcg is waiting for our unlock jus=
t
                 * behind us.  We can leave the next memcg reference.
                 */
        }
        spin_unlock(&zswap_shrink_lock);
}
```

As same as in shrink_worker, we must check if the next memcg is online
under the lock before leaving the ref in zswap_next_shrink.
Otherwise, zswap_next_shrink might hold the ref of offlined and cleaned mem=
cg.

Or if you are concerning about temporary storing unchecked or offlined
memcg in zswap_next_shrink, it is safe because:

1. If there is no other cleaner running for zswap_next_shrink, the ref
saved in zswap_next_shrink ensures liveness of the memcg when
reacquired.
2. Another cleaner thread may put back and replace zswap_next_shrink
with its next. We will check onlineness of the new zswap_next_shrink
under reacquired lock.
3. Even if the verified-online memcg is being offlined concurrently,
another cleaner thread must wait for our unlock. We can leave the
online memcg and rely on its respective cleaner.

