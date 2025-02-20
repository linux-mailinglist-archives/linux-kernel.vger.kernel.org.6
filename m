Return-Path: <linux-kernel+bounces-523215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 012EFA3D39F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 609E23AEC96
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBFF1EB1A3;
	Thu, 20 Feb 2025 08:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sbdmn09a"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A651B3927
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740041300; cv=none; b=Fs1yRFabXpF1q3oUpuHl4ORKPM8yGAWvXvUhYab1FA/DHM6+bmldHGtudteUVXFW+lJRZ8F8LFetafbcLD8cTDXQvGtISweTxCFYvp65uU3ny78IhOptpj098fpSCKhyFEVQW0t5dcAXH10dVe7GgO7aQOWtstkxEP9QIbnu5GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740041300; c=relaxed/simple;
	bh=eOJF46IaUTaNfT4QyMAMjESNMVY8lwoauqmqP5QZNAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=On+EIFsx+SdFvRIyx5V4irXmsrGGeSk/3Hmp+whbNLSqQBTqGA4p8+6nwo8gYAa9TEPou0e6SEhlt7nNLW3IB/crAl2aAHHvLk5vUpsTI8nUTg5250DOqE1PZiDnM8LbK8N0axykhBF/3RWDTtJ9ut/vhLKlbhj8ncd6Uyxgflo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sbdmn09a; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e058ca6806so1103492a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 00:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740041293; x=1740646093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wn8U20v5f+rx/ps3pY4w1/ateGC6xo29Rt3tQiIDuAA=;
        b=sbdmn09aMWBv+kofs1i/IjKf0HK7QwdVVYtKlQPRPVltnAmZzRwCCUNRlXhyfIWLS1
         2BBOZwmGYURCIFja3ZpYtaR+EcThtVZt6O4ZSWJXw0N3gzSVv/kys8pM1SNnjTZn8LdI
         aiqUhuY+kEbvY4ShBDZ1fODHmfn/WFg5OL2fLYgrmtkMFTyMICTDennEx2Yoykosu0F9
         ++yhL5TOgKdfSac9sk66dQNvOd00+YBu8BnbdyOWrV6DhCDkENOT9hSfo4FkpCxMRh6H
         ZidvINNCEzvXG5sjJt0A3+AWpJ9D/sOgdk1AU/VJWKMRoHxqYoimX43F9TUIcfLZ3Xg7
         d32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740041293; x=1740646093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wn8U20v5f+rx/ps3pY4w1/ateGC6xo29Rt3tQiIDuAA=;
        b=HNv47IMI0/pnmUmUkR1JH/O88ASXDcVTbcWHqe9Dq/Vs129TakRdF/F+xZTOjSoTzw
         ygA1EHgD9QUpeRGeP8kPyI2Q5fZ2pHC8QXwRJ8Z1IYnZoBD0QlpQwTJoOkuI953f1J5u
         zJqpqsZw53DkUAvxmcgVgCo8KW9K5s0bkOUbJzb2rkRLQqA0Ls/OQ43k5eCz7sf+K4P8
         02bUzObElea+snB1F5CnWY5u6fwmGJH2OPu66e5780w1S+FdI68iQZaoNKmXwYE7hxSO
         soZxhuTmEcGeXM7CXiewVVlx8yQxv7IpU6FSG2UTFvwdAdxJeaBMU80ofdzADcepUED9
         ieVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfz78i1GnNfPNdIUL+uhAK0mBBgcGMZ1ucUPl89tHupS2v/5GJ9vFz2/s7+5YnFJ7GD2KXQXLiGvMKqkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWVo2G7pr2gGMY0G4DdGnVc24Do4MDB0XiiiZ4rKS0+YtuD4RF
	PeE4Z7Mpf14de5IpKP/50ZbFqOZ0qZSSTQZtbIFaTpTYMr9wqHJVGS8AuK/UiAUowA1EK4F4Oci
	+vezYVSimj7Maftzpm05xC8lZEfYBoYIoBKgNgD8/f+Q5kw921zSr
X-Gm-Gg: ASbGncv6qnf1zNQo+UEEf+uqU7Y2JS59DMns4viKKSMEVzKnIdosnrNObFM9w8TMUMB
	038Zo8UoTOwGiBCRHMPHHTxZ80XLOJWa3O6Qd/3zzrLuq3/JMBx8TL4Tj246rTrYWqRRza7k+Lg
	O7bEk4GEaoPf9XsHynk18UBEtnIxRvvw==
X-Google-Smtp-Source: AGHT+IFYZLNBrrxeZ0D/1Dd1enkXOye9zIxSSkI1C9v/ccGwQ2J88/lDeiWpn10jQOqgPMQUeWzt7xAhWI3SyCu5yrE=
X-Received: by 2002:a05:6402:a001:b0:5e0:4408:6bcf with SMTP id
 4fb4d7f45d1cf-5e04408718bmr15446691a12.10.1740041293384; Thu, 20 Feb 2025
 00:48:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219125522.2535263-1-edumazet@google.com> <20250219125522.2535263-3-edumazet@google.com>
 <87tt8phw61.ffs@tglx>
In-Reply-To: <87tt8phw61.ffs@tglx>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Feb 2025 09:48:02 +0100
X-Gm-Features: AWEUYZmkvPY51rZ39kRG4J0w-NvpyifR9W9MU2pp3GCuPxC4z2SZ_RGgJDL1kQs
Message-ID: <CANn89iKQ2oVX6pzWxN1rEqHfrkDXkxEgcF6MHW-OiyGc2C=ybw@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] posix-timers: Initialise timer->it_id in posix_timer_add()
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, Benjamin Segall <bsegall@google.com>, 
	Eric Dumazet <eric.dumazet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 9:12=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Wed, Feb 19 2025 at 12:55, Eric Dumazet wrote:
> > A timer is visible only when both timer->signal and timer->i_id
> > are set to their final values.
> >
> > We can initialize timer->it_id sooner.
>
> This changelog tells nothing. What is this fixing, why is it required to
> initialize this sooner?


Just  to make the series more readable and bisectable.

>
> We can... We also can not ... Aside of that please write changelogs in
> imperative mood as Documentation asks for.

I do not understand.

I wrote more than 5000 upstream linux patches, you  are trying to
educate me in 2025 ?

>
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  kernel/time/posix-timers.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
> > index 204a351a2fd3..1f73ea955756 100644
> > --- a/kernel/time/posix-timers.c
> > +++ b/kernel/time/posix-timers.c
> > @@ -114,6 +114,7 @@ static int posix_timer_add(struct k_itimer *timer)
> >
> >               spin_lock(&hash_lock);
> >               if (!__posix_timers_find(head, sig, id)) {
> > +                     timer->it_id =3D (timer_t)id;
> >                       hlist_add_head_rcu(&timer->t_hash, head);
> >                       spin_unlock(&hash_lock);
> >                       return id;
> > @@ -407,8 +408,7 @@ static int do_timer_create(clockid_t which_clock, s=
truct sigevent *event,
> >
> >       /*
> >        * Add the timer to the hash table. The timer is not yet valid
> > -      * because new_timer::it_signal is still NULL. The timer id is al=
so
> > -      * not yet visible to user space.
>
> Even with this change the timer ID is not yet visible to user space
> because it has not yet been copied back ....
>

It is seen in concurrent lookups.

