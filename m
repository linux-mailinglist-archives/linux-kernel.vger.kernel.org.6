Return-Path: <linux-kernel+bounces-573635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB28FA6DA07
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69BBB16B60B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2756925E81A;
	Mon, 24 Mar 2025 12:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YBuHoIwU"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF9E25D908
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 12:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742819044; cv=none; b=gPmOkL5LsSiBRRq9LvqZE9PFSSSGRB1Y/wrA3+BEUaRnw7LN4YHjAXLIOYfyOxma9q9ZwwOvPevwBdgRiCcYhBxDX0+NaxZgYkurq8ezOUfYGrlkMMBKzZN9iit/5N8NHA5AwIGpJyRw/3WNvQnS4xMSyXu8XHV71pwqqvHIwpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742819044; c=relaxed/simple;
	bh=l5wT2yMAwiJuX/kTLoFIi7b58hF4JHqWsVvGuJmoQxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mChDGjv6nD3SBnMzv0bJFCAhj3IF3CaJsDWo+WLcnkVJ4qpJkBYCZlbBIKdpsB18XXJckE77me2fkOktFf4puAhCix2ocGjgR8UX1N0ic/cyU7Eno7IF1Nqme6/Srcep21uce+ItwhVlLS7JeHix1qPojhdC7fZydYsLEshx4rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YBuHoIwU; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-476f4e9cf92so28096141cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 05:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742819042; x=1743423842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rw7KdFhgGlzA9hJZu3CUQol3b3y3Kzt/ot+PZJwkTg=;
        b=YBuHoIwUFo8+1Qe7UShQHY4KD08caEZn2okM6G5LArLVbiyo50NSWrvO91cMQGob9F
         vmi1JQLPSjBZM62MRoFriVtmc3xDMgRJ7EGCnSnHXTGouL4LVhCcnJHRjgsRpkhwdU3B
         lUVfhGmsY1WhOnmapVTGf9RnfXv0G913qhEVGLsb2ogrk6zb3hgx3xfK5pQVJ1OwJ5eW
         7q8FLGDoW8EKV+Lu0x/6CxpTeNmazD3nwpRX7bYKWeyoi+BTui22jpaEq7mVu9/BA+KM
         arlbiT2ezSaSjBrAjH3IbHPOyd4ENpOTf4EZpbYOWC4hFTgwfeo8xqTAJqKMakVVeR0m
         r1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742819042; x=1743423842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+rw7KdFhgGlzA9hJZu3CUQol3b3y3Kzt/ot+PZJwkTg=;
        b=pFVSNoIYCGzemylB4a88z8ERl8jE7yQtdV0En3LRt2PSqJCIJKp7exBt46XEy8HcWb
         /em4a5HvR0/pj9ntNBEogcA/Owbh92msbP2ViO8RrzyAVJkNt+xZ/lhr7l1Da2fDAEdY
         RQML4XoAlC6AzxIjWYszQrFk6afZnBUmg2XztKqicw0IEulHZCs27Q5ZJaSSazy+uYzd
         rHYVBLq3BtvhXgWnDowh77hBCHE/GD7T4LQW8GNQyzI7OOUGkLEizZqafzSJ8/Hb/cIT
         1bYa+4KSZLhR77Tr9q4Zrs9snRcn7Bru2PL7yVs4bMjsWMlrd7Vhsc+GN4sxenkhoDeZ
         TFoA==
X-Forwarded-Encrypted: i=1; AJvYcCWyFfkI/ZD1y1F6apn7u7z4iJc/ypWtPI/h6v81kIkzmafpbn9eLYdyhwMVQ7TQBJsVUiggxpJXtUFNfxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhygrNjthJAVbCwictztFmkyiiSsTrf2/2/E1r0+DX7Cbs33+0
	TT+Ae7E+uZXx2B5r+q1bzwCBag4OTbRl5SfLlshbYqdkN6jcQz+I1+W5Mr8ylwywXiVBdsN9GAv
	4r2jV/MaE5QBTWw5PtZQBxbHERGIXER6mnJ03
X-Gm-Gg: ASbGncsBvVvRWI1E8H3wS2CXdQbAun/tQpgrOnP9pIYc2BThkuKJe1+DUbsP8nJTlut
	HNuj2ArSgd2PxGxEdnkysZbHE5NVyuMaaClZ2u+IkectcXSsK73W+mLcW7xEXlXY8gMPteogN2N
	1zDC70gflQr0Zm/KnZnEx77Rq1nM8=
X-Google-Smtp-Source: AGHT+IFamWA+o+dJNENoDIKowoy2ZKZjHw7Gx4z6RKzEwodmMi0dQWsxzn7/ybltodE1h5nA0JP+UTvoh6D9sJLd41Y=
X-Received: by 2002:a05:622a:1e97:b0:476:a895:7e82 with SMTP id
 d75a77b69052e-4771de78f90mr214642051cf.50.1742819041534; Mon, 24 Mar 2025
 05:24:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321-lockdep-v1-1-78b732d195fb@debian.org> <20250324121202.GG14944@noisy.programming.kicks-ass.net>
In-Reply-To: <20250324121202.GG14944@noisy.programming.kicks-ass.net>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 24 Mar 2025 13:23:50 +0100
X-Gm-Features: AQ5f1JpS_e7Szu4iSZLtlamMU8FxAJtCvtZEXy-PL1Ofpt1wyNMoShDqHy0mZzU
Message-ID: <CANn89iKykrnUVUsqML7dqMuHx6OuGnKWg-xRUV4ch4vGJtUTeg@mail.gmail.com>
Subject: Re: [PATCH] lockdep: Speed up lockdep_unregister_key() with expedited
 RCU synchronization
To: Peter Zijlstra <peterz@infradead.org>
Cc: Breno Leitao <leitao@debian.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, aeh@meta.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jhs@mojatatu.com, 
	kernel-team@meta.com, Erik Lundgren <elundgren@meta.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 1:12=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Fri, Mar 21, 2025 at 02:30:49AM -0700, Breno Leitao wrote:
> > lockdep_unregister_key() is called from critical code paths, including
> > sections where rtnl_lock() is held. For example, when replacing a qdisc
> > in a network device, network egress traffic is disabled while
> > __qdisc_destroy() is called for every network queue.
> >
> > If lockdep is enabled, __qdisc_destroy() calls lockdep_unregister_key()=
,
> > which gets blocked waiting for synchronize_rcu() to complete.
> >
> > For example, a simple tc command to replace a qdisc could take 13
> > seconds:
> >
> >   # time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1: mq
> >     real    0m13.195s
> >     user    0m0.001s
> >     sys     0m2.746s
> >
> > During this time, network egress is completely frozen while waiting for
> > RCU synchronization.
> >
> > Use synchronize_rcu_expedited() instead to minimize the impact on
> > critical operations like network connectivity changes.
> >
> > This improves 10x the function call to tc, when replacing the qdisc for
> > a network card.
> >
> >    # time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1: mq
> >      real     0m1.789s
> >      user     0m0.000s
> >      sys      0m1.613s
> >
> > Reported-by: Erik Lundgren <elundgren@meta.com>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > Reviewed-by: "Paul E. McKenney" <paulmck@kernel.org>
> > ---
> >  kernel/locking/lockdep.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > index 4470680f02269..a79030ac36dd4 100644
> > --- a/kernel/locking/lockdep.c
> > +++ b/kernel/locking/lockdep.c
> > @@ -6595,8 +6595,10 @@ void lockdep_unregister_key(struct lock_class_ke=
y *key)
> >       if (need_callback)
> >               call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
> >
> > -     /* Wait until is_dynamic_key() has finished accessing k->hash_ent=
ry. */
> > -     synchronize_rcu();
> > +     /* Wait until is_dynamic_key() has finished accessing k->hash_ent=
ry.
> > +      * This needs to be quick, since it is called in critical section=
s
> > +      */
> > +     synchronize_rcu_expedited();
> >  }
> >  EXPORT_SYMBOL_GPL(lockdep_unregister_key);
>
> So I fundamentally despise synchronize_rcu_expedited(), also your
> comment style is broken.
>
> Why can't qdisc call this outside of the lock?

Good luck with that, and anyway the time to call it 256 times would
still hurt Breno use case.

My suggestion was to change lockdep_unregister_key() contract, and use
kfree_rcu() there

> I think we should redesign lockdep_unregister_key() to work on a separate=
ly
> allocated piece of memory,
> then use kfree_rcu() in it.
>
> Ie not embed a "struct lock_class_key" in the struct Qdisc, but a pointer=
 to
>
> struct ... {
>      struct lock_class_key key;
>      struct rcu_head  rcu;
> }

More work because it requires changing all lockdep_unregister_key() users.

