Return-Path: <linux-kernel+bounces-523212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E61A3D392
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A87A63BBDE4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73CD1EBA19;
	Thu, 20 Feb 2025 08:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ng4Olo79"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106541EB19B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740041094; cv=none; b=h62D5JGo6qMcc2QwnRXM80yuzyJPlHa7K4PmRZZ5gxZe+ovKRHHOjTDmyUhCZunAnj5KAa5yRACu3vIQ/WerVJzwYftsbKn1xVlHyX8lZ3KrrIqoCFlBG6dBavxIbrj26/cAD0PLRTOzfiUiDchEMKaQRBTV/H23i2mIqSBHZxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740041094; c=relaxed/simple;
	bh=nci/VntG0SSXThZjtgNykZVFghZhQ6xGeqhkz25n0oc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NHTqbbqNjQyZpH3/LXPg7rRoEIvDE+GG/C0pDqFf3ryeI342arSHljkRlRXlYoNrp/UBjk6WqGwgdbiVxKg4v0Du4EcTKybNdmycLymY4MaPQbrFXxYITvT4RZTipuwJkw7XJvxKdlyqfrFu8JrxK/E1ylKLWcK572/FgdQK6Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ng4Olo79; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e0452f859cso980470a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 00:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740041091; x=1740645891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Na0HeYQ6ga+Ho1mblegVxC94Dv3c8dGdJT1s6o67Jmg=;
        b=ng4Olo79nTAXcHHC6HfIRVSQ+w4bgIT6S1GQQD33DrrJFZO+YIx7gdrRbIbZlS0PmL
         BLRcBMbndSGU3p/s6r3vOiB3kUAEn003uGv3l7pbSPXcJ8qMYdkYHgNPvUqnCLoLP3ti
         +ShHiIj7yONtKj26rA+1F6ty1KLsxq9vFd6PLiXAblcJ3ZjNN2onzOI+VSX/tu+jIr5w
         1xYhXKeM3PfOySLaoCqI+pe01E41GC0uXgBg8pD6P/en/bHXYGh7ia4p+0nG8LoRbY6Z
         xBYsGiANI/ZwVvsXGv+KTN7FsiHog/xi3dJ8JBrI8mtqD0IjX9ay7FVvWGWmvrchx2QW
         pX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740041091; x=1740645891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Na0HeYQ6ga+Ho1mblegVxC94Dv3c8dGdJT1s6o67Jmg=;
        b=IXIdguL/ooRAg6hfDrCdeRtjAHVf4Q2LiQ9klP4HmCcN/gwtL18Mlbwmp5fij5qb/V
         GFjsSYKfKZqJuco2d87heuIkKkoGt16/Bk8Z8Z43Lf+NvQAoJVhR632rpuTvMCjBKYt3
         mwYZG+1BC++A73fhNdlwv6lboz3LT2aoYg+EFBKh2MOyeqqUlWAB9eFJ0lL51BYOC2+0
         eUCjd4OPTrV67ayJpjyX5N8+NbjMZV2oKi0b4CxPLXMUTRtdzSYZ3QXwC2kbMdOY2Vvt
         rTAiAhkbxCBSo4xPO0/0zWRBY9GeTFlmJ6Rmqc3MgdwACWj5oM8wLwGxC9jxxC9m8vtl
         zLoA==
X-Forwarded-Encrypted: i=1; AJvYcCVnGLp2CmYd15x0C9gtlRNy49S/Ps3CSmCSq4NZZmHbAujrILjB7LSkp6T/wJLqxfIwuki7IYI3KV8KzkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyls45/Xfqb0Q9CrFf15aN2bFyXeojrjg0p5iFMX1TI3w5EYTjU
	3MjQAKVrcU29G7D+ZIxbcoyt9h4vuDFS7/Q2Y3rUvKd0TeirdbEMbTL/kadHzWI73PgfYMjl/i+
	5i10VGmtifGktqJfMUqpfiekFV2f7mYVRwxsAfyGLscFlxUPQmeST
X-Gm-Gg: ASbGncu5F6yx3fD8nDR2XL7L7rHGt7HToOH6VMOH2qTXVvKV+2cTYFZwRiNCSeDYBwx
	R19iNKMrQrrwlN6s5rEMZ0qHgmKC9aAuRQ1v+AQDU0AqwnaJHhXbvCLxGKZe/qI7Aw5lZdm7MXY
	OlNmh3JibnNyIDjC0dy/1TsGnhTRb77g==
X-Google-Smtp-Source: AGHT+IHidEwyBafGAUr0U5hldhxjnshA50aJN7TfNlxWKlCUn3de20gbKgz9ot4a9xwjG1NndARjxAhm6tp6DzN5J1w=
X-Received: by 2002:a05:6402:2750:b0:5dc:5a34:1296 with SMTP id
 4fb4d7f45d1cf-5e08952facdmr6666640a12.16.1740041091010; Thu, 20 Feb 2025
 00:44:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219125522.2535263-1-edumazet@google.com> <20250219125522.2535263-4-edumazet@google.com>
 <87r03thvu7.ffs@tglx>
In-Reply-To: <87r03thvu7.ffs@tglx>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Feb 2025 09:44:39 +0100
X-Gm-Features: AWEUYZn4cGBb7InJyKRTzqQNySQqgY2Ej7ZmSgTWBtja7R0IKGB8soy2k_og4EE
Message-ID: <CANn89iKyxncwVioEHDqRBOTOrgnYoMcq+KAKqCzTadt68UP6yA@mail.gmail.com>
Subject: Re: [PATCH V2 3/4] posix-timers: Initialise timer->it_signal in posix_timer_add()
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, Benjamin Segall <bsegall@google.com>, 
	Eric Dumazet <eric.dumazet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 9:19=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Wed, Feb 19 2025 at 12:55, Eric Dumazet wrote:
> > Instead of leaving a NULL value in timer->it_signal,
> > set it to the current sig pointer, but with the low order bit set.
>
> And that low order bit set does what?
>
> > This fixes a potential race, in the unlikely case a thread
> > was preempted long enough that other threads created more than
> > 2^31 itimers.
>
> and then what happens?

Two threads might get the same timer_id given back.

>
> > Rename __posix_timers_find() to posix_timers_find()
>
> That's not what the patch does. It renames to posix_sig_owner(). Aside
> of that the rename is not relevant to the problem itself.

posix_sig_owner() is a new helper, to remove the low order bit.

>
> > Mask the low order bit in posix_timers_find().
>
> What for?



>
> I pointed you before to the changelog documentation, which clearly says:
>
>   A good structure is to explain the context, the problem and the
>   solution in separate paragraphs and this order.
>
> It's not asked too much to write proper change logs.

Ok.

>
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  kernel/time/posix-timers.c | 28 +++++++++++++++++++++-------
> >  1 file changed, 21 insertions(+), 7 deletions(-)
> >
> > diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
> > index 1f73ea955756..ed27c7eab456 100644
> > --- a/kernel/time/posix-timers.c
> > +++ b/kernel/time/posix-timers.c
> > @@ -72,15 +72,22 @@ static int hash(struct signal_struct *sig, unsigned=
 int nr)
> >       return hash_32(hash32_ptr(sig) ^ nr, HASH_BITS(posix_timers_hasht=
able));
> >  }
> >
> > -static struct k_itimer *__posix_timers_find(struct hlist_head *head,
> > +static struct signal_struct *posix_sig_owner(const struct k_itimer *ti=
mer)
> > +{
> > +     /* timer->it_signal can be set concurrently */
> > +     unsigned long val =3D (unsigned long)READ_ONCE(timer->it_signal);
> > +
> > +     return (struct signal_struct *)(val & ~1UL);
> > +}
> > +
> > +static struct k_itimer *posix_timers_find(struct hlist_head *head,
> >                                           struct signal_struct *sig,
> >                                           timer_t id)
> >  {
> >       struct k_itimer *timer;
> >
> >       hlist_for_each_entry_rcu(timer, head, t_hash, lockdep_is_held(&ha=
sh_lock)) {
> > -             /* timer->it_signal can be set concurrently */
> > -             if ((READ_ONCE(timer->it_signal) =3D=3D sig) && (timer->i=
t_id =3D=3D id))
> > +             if ((posix_sig_owner(timer) =3D=3D sig) && (timer->it_id =
=3D=3D id))
> >                       return timer;
> >       }
> >       return NULL;
> > @@ -90,8 +97,14 @@ static struct k_itimer *posix_timer_by_id(timer_t id=
)
> >  {
> >       struct signal_struct *sig =3D current->signal;
> >       struct hlist_head *head =3D &posix_timers_hashtable[hash(sig, id)=
];
> > +     struct k_itimer *timer;
> >
> > -     return __posix_timers_find(head, sig, id);
> > +     hlist_for_each_entry_rcu(timer, head, t_hash) {
> > +             /* timer->it_signal can be set concurrently */
> > +             if ((READ_ONCE(timer->it_signal) =3D=3D sig) && (timer->i=
t_id =3D=3D id))
> > +                     return timer;
> > +     }
> > +     return NULL;
> >  }
> >
> >  static int posix_timer_add(struct k_itimer *timer)
> > @@ -113,8 +126,9 @@ static int posix_timer_add(struct k_itimer *timer)
> >               head =3D &posix_timers_hashtable[hash(sig, id)];
> >
> >               spin_lock(&hash_lock);
> > -             if (!__posix_timers_find(head, sig, id)) {
> > +             if (!posix_timers_find(head, sig, id)) {
> >                       timer->it_id =3D (timer_t)id;
> > +                     timer->it_signal =3D (struct signal_struct *)((un=
signed long)sig | 1UL);
> >                       hlist_add_head_rcu(&timer->t_hash, head);
> >                       spin_unlock(&hash_lock);
> >                       return id;
> > @@ -453,7 +467,7 @@ static int do_timer_create(clockid_t which_clock, s=
truct sigevent *event,
> >       }
> >       /*
> >        * After succesful copy out, the timer ID is visible to user spac=
e
> > -      * now but not yet valid because new_timer::signal is still NULL.
> > +      * now but not yet valid because new_timer::signal low order bit =
is 1.
> >        *
> >        * Complete the initialization with the clock specific create
> >        * callback.
> > @@ -463,7 +477,7 @@ static int do_timer_create(clockid_t which_clock, s=
truct sigevent *event,
> >               goto out;
> >
> >       spin_lock_irq(&current->sighand->siglock);
> > -     /* This makes the timer valid in the hash table */
> > +     /* This makes the timer valid in the hash table, clearing low ord=
er bit. */
>
> Clearing the low order bit of what? This is a full write and not a clear
> low order bit operation.
>

Prior value was (sig | 1L)

New value is (sig)

-> low order bit is cleared.

