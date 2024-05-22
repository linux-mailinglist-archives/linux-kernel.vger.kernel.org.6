Return-Path: <linux-kernel+bounces-185765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9738CBA85
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 06:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75418282D1D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 04:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C37762CD;
	Wed, 22 May 2024 04:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9DZrJGi"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EE74C62
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 04:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716353959; cv=none; b=nw0yITrcv/FYL6Hm02u4OWjehICGeZs2TjBQCalY78e5umE4vqN5pDJIqpb7nJgxVvwi+A+8O2m8Tv95xKOu8SZSxKMDZ89eV9GZBE+OdbVN6fJbtY9wVySYVXVD86mY7ahKvkT3yuhtJfSstZIknCbGuoZcmkusLX7NH4fVKaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716353959; c=relaxed/simple;
	bh=EZUgvT50EiG0noTA0PwEaevnx2DYm3VP9zfDMF3tH2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LqMLuFUULoAuqM/tnTEl4iCAb8eH+s0ZnGCFBGL0WWyoDxUe73OmbiUhdXAhnIuThksxv9B2LtEo+uZOJZ46W2Zh9gKh+mqBce5Ci4OK6ERondQPHSfYVrOPBPx52UD896yblnJJJ69pua38dzR+8P21ofWfzUGSFnSo6nCSI4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9DZrJGi; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57342829409so926681a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 21:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716353956; x=1716958756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39bxPhPVcA85UbzZ3VjWUXERVKdx/CAHlqDcF/RAs0Q=;
        b=B9DZrJGi5oboN+XviEEgy7IUhqVDzeJ90ZgiHWsVxTj/1h/6jToqaZoOZFEFQJmtW0
         ZbClyQMa14a4ubNHWrmZGRvu7Bdbj1/JtQqPM6p53RkOWBp5C5n/c7mQQmc8+H98EwNr
         0vjN9kr8/F/SBcUQn1JzJ06L0ogvQkRFw8gRTh382rEo2V9G6Aacn/UVKQ+WmIJN6tfN
         U9iwzuqc4nrLQli5MAg4uBVdCMf0twcAdli1/uN5y4rQAdFrfKisqOorAZaEvGZjiNiV
         tVg3M3nq3+oPGmp0X0NtsOj38zJbnAe3QEzjY5CQU9TJhObvUfc2oqk3QB3IwgkPcc2U
         MiIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716353956; x=1716958756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=39bxPhPVcA85UbzZ3VjWUXERVKdx/CAHlqDcF/RAs0Q=;
        b=THuI4uO5arIuO+txiJQhEFdEAfz9rStO1Z8JuKjOYsqBpkiR8IfQlBp1CxUw8zEO7v
         y4dfjT2H8TDUo9e57j7vYTMpoL6zp0fM/+dDjuj28pmcQBVc3ARss1/Dbr8N0yLLg9kY
         eUUJxx/zcoFsgOfnd9fO+6gThx6Y4gCP8e+oVCQxQpm6Euwya0SFHsWZuQ/nq6eklSes
         IHpicLOjna8zGqrA6u9OVFlSCA5AUEYteVJtIbX06Xx6HHwBQeClIUca2/vjuq9H4nZv
         BfpCCxhjoWytk4QUcTwhzGZLW61I5hljCA/W+VyVqO7Uwo7tgDqdJ2sO7K7OohgMb4YU
         AdBQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3HU2xjN1awMGiRpf95wRL0jxiwJiW9AYxLd9W83miXpMeTK9f6s/+O842lfN6ijdPbTZXoN5OPcIT/9RR03k+7Q6618MzQblaHvPg
X-Gm-Message-State: AOJu0Yx9gbMIPVEvKI6I8PTAENtaMAh+4PBaoApRyg2oTZmNMQKhJiKc
	75RaBxLpOb67fhJFfbIHoxm+RNaS8KSMXYbuuywwfJuHwXS5B/DE8Onom4VcayVFpheORDWQtMz
	oYzwfMOux4oCTEvunBUpqnkUuXoo=
X-Google-Smtp-Source: AGHT+IGa+13CEFwmy5GAjmwiCyxL7oM9UfZgNMhWLRQ0BlkBOC5alvxMemPCt+VCIkYC9kd+4eTQUKoxh5bxNUxKbRE=
X-Received: by 2002:a50:c044:0:b0:572:7014:230a with SMTP id
 4fb4d7f45d1cf-5752b4c8d66mr9496526a12.14.1716353955662; Tue, 21 May 2024
 21:59:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521233100.358002-1-mjguzik@gmail.com> <Zk1HsDYKwxpzeBjq@snowbird>
In-Reply-To: <Zk1HsDYKwxpzeBjq@snowbird>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 22 May 2024 06:59:02 +0200
Message-ID: <CAGudoHGpiJwuNX5MEj_RGdc+vVo_3u3hSv9wWSRm6ZrmAi65NA@mail.gmail.com>
Subject: Re: [PATCH v3] percpu_counter: add a cmpxchg-based _add_batch variant
To: Dennis Zhou <dennis@kernel.org>
Cc: tj@kernel.org, hughd@google.com, akpm@linux-foundation.org, vbabka@suse.cz, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 3:17=E2=80=AFAM Dennis Zhou <dennis@kernel.org> wro=
te:
>
> Hi Mateusz,
>
> On Wed, May 22, 2024 at 01:31:00AM +0200, Mateusz Guzik wrote:
> > Interrupt disable/enable trips are quite expensive on x86-64 compared t=
o
> > a mere cmpxchg (note: no lock prefix!) and percpu counters are used
> > quite often.
> >
> > With this change I get a bump of 1% ops/s for negative path lookups,
> > plugged into will-it-scale:
> >
> > void testcase(unsigned long long *iterations, unsigned long nr)
> > {
> >         while (1) {
> >                 int fd =3D open("/tmp/nonexistent", O_RDONLY);
> >                 assert(fd =3D=3D -1);
> >
> >                 (*iterations)++;
> >         }
> > }
> >
> > The win would be higher if it was not for other slowdowns, but one has
> > to start somewhere.
>
> This is cool!
>
> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
> >
> > v3:
> > - add a missing word to the new comment
> >
> > v2:
> > - dodge preemption
> > - use this_cpu_try_cmpxchg
> > - keep the old variant depending on CONFIG_HAVE_CMPXCHG_LOCAL
> >
> >  lib/percpu_counter.c | 44 +++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 39 insertions(+), 5 deletions(-)
> >
> > diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
> > index 44dd133594d4..c3140276bb36 100644
> > --- a/lib/percpu_counter.c
> > +++ b/lib/percpu_counter.c
> > @@ -73,17 +73,50 @@ void percpu_counter_set(struct percpu_counter *fbc,=
 s64 amount)
> >  EXPORT_SYMBOL(percpu_counter_set);
> >
> >  /*
> > - * local_irq_save() is needed to make the function irq safe:
> > - * - The slow path would be ok as protected by an irq-safe spinlock.
> > - * - this_cpu_add would be ok as it is irq-safe by definition.
> > - * But:
> > - * The decision slow path/fast path and the actual update must be atom=
ic, too.
> > + * Add to a counter while respecting batch size.
> > + *
> > + * There are 2 implementations, both dealing with the following proble=
m:
> > + *
> > + * The decision slow path/fast path and the actual update must be atom=
ic.
> >   * Otherwise a call in process context could check the current values =
and
> >   * decide that the fast path can be used. If now an interrupt occurs b=
efore
> >   * the this_cpu_add(), and the interrupt updates this_cpu(*fbc->counte=
rs),
> >   * then the this_cpu_add() that is executed after the interrupt has co=
mpleted
> >   * can produce values larger than "batch" or even overflows.
> >   */
> > +#ifdef CONFIG_HAVE_CMPXCHG_LOCAL
> > +/*
> > + * Safety against interrupts is achieved in 2 ways:
> > + * 1. the fast path uses local cmpxchg (note: no lock prefix)
> > + * 2. the slow path operates with interrupts disabled
> > + */
> > +void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount, =
s32 batch)
> > +{
> > +     s64 count;
> > +     unsigned long flags;
> > +
> > +     count =3D this_cpu_read(*fbc->counters);
>
> Should this_cpu_read() be inside the do {} while in case the extreme
> case that we get preempted after the read and before the cmpxchg AND
> count + amount < batch on both the previous and next cpu?
>

this_cpu_try_cmpxchg updates the local value on failure (hence &), so
from semantic pov this is equivalent to having this_cpu_read in the
loop. I'm using it the same way as mod_zone_state.

> > +     do {
> > +             if (unlikely(abs(count + amount)) >=3D batch) {
> > +                     raw_spin_lock_irqsave(&fbc->lock, flags);
> > +                     /*
> > +                      * Note: by now we might have migrated to another=
 CPU
> > +                      * or the value might have changed.
> > +                      */
> > +                     count =3D __this_cpu_read(*fbc->counters);
> > +                     fbc->count +=3D count + amount;
> > +                     __this_cpu_sub(*fbc->counters, count);
> > +                     raw_spin_unlock_irqrestore(&fbc->lock, flags);
> > +                     return;
> > +             }
> > +     } while (!this_cpu_try_cmpxchg(*fbc->counters, &count, count + am=
ount));
> > +}
> > +#else
> > +/*
> > + * local_irq_save() is used to make the function irq safe:
> > + * - The slow path would be ok as protected by an irq-safe spinlock.
> > + * - this_cpu_add would be ok as it is irq-safe by definition.
> > + */
> >  void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount, =
s32 batch)
> >  {
> >       s64 count;
> > @@ -101,6 +134,7 @@ void percpu_counter_add_batch(struct percpu_counter=
 *fbc, s64 amount, s32 batch)
> >       }
> >       local_irq_restore(flags);
> >  }
> > +#endif
> >  EXPORT_SYMBOL(percpu_counter_add_batch);
> >
> >  /*
> > --
> > 2.39.2
> >
>
> Thanks,
> Dennis



--=20
Mateusz Guzik <mjguzik gmail.com>

