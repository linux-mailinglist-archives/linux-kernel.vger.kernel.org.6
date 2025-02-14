Return-Path: <linux-kernel+bounces-515447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F243A364F8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D019D16E5A6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498BB267F69;
	Fri, 14 Feb 2025 17:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="piCL5UWH"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E501F265CDE
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739555349; cv=none; b=LwrD+4lXHePulpmrCLSFUaPAeTvhXsSOA7q84vOan0RXidOog6RysAF9idiX56x7d4ExC9AgXNg27LSb3pQE1MrV0CYM2Z36+wdH/wv4RtnnOKPeHS7X7JVs+4NI9YI5n16UfzwSwI8ANfVJhIJPjTNv6l0/E1ug6LeOKzR1mO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739555349; c=relaxed/simple;
	bh=q6FVd+hD83zbXroNu3H4BuQAeKIib9C2ig50g9QhV0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NaG7XCH8NkQ8AJHZPkKBreswNsdio710kG580mR0kXO0fIjbibIOt1CeGFHVnHLSrooTy5a+ynJuOzcIfzPsF6c0vTdzXib7tn/gdf4SDpnzt2kmfAMDyQYHpZ7NFHXfpUQbRrt5TEovTuuU4laAkzG02C/dQiBseqzU7QF4dWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=piCL5UWH; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5de849a0b6cso4249834a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739555346; x=1740160146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHEEfl0gvixw7VLoequ3wDRXaXMOciSTyRhMc6ZZDdA=;
        b=piCL5UWHzvtlJS5Ni3ORNl8KYnBu6ruqddvyhbOE+mz42T+KLVR58FVqp14iHnLyMH
         xHhnbM0n4X4FY1F3sKC3ZdOrxqORXkHdiXumej/x1QF39TpsQvkPyTgIhSouREkWxN64
         HEYcNorreqgEvzalw7ztvz+H+gMLpRaEUiSVoAOhGrYqa8WsxB5BDE5q0VxoZx0hhMpv
         zQPdTLE3GDl3i7E3cNBVRCSEmG/g6m/sHDS3KIL2Rx7cAwFaHqTgwgvTDbrIZqH//IOK
         59YgxRHK0Th/QLFnPqhO5aNPKm53q3LmZyZP04e8CSdpIvufuIVYS6v1BmwtOJRk5srb
         0Q7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739555346; x=1740160146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHEEfl0gvixw7VLoequ3wDRXaXMOciSTyRhMc6ZZDdA=;
        b=wIFMc605IeoXuBA0595XwQ8/RLAlpU9VHrER9kqJ4S0Pd9eHLz1815xS28ZnP3oJ7B
         7cE96q9FzFokpbO7uM3kzHVah4xD4gzvinHqDf/2OgO3WDGs8XP7VVPjGdDFFUfUef+M
         Uqhf9knO7sLmMWg6D5YCYUQdk6pp0f3XdeS577s7FF49stFMvccHjXNVBmvmRicN1Dez
         wr1IpnA0FhgH0UJNLe5fmzyImnEuLwf35H5aYun3159kgXSsCzUmsDO0u/wHA1q3CYg7
         vo+SBSAjK7SR14PodyQJcrEGmNPofG/Pg0HgR/Q0csQ6Lu3lw3V3jTEcVCT07nq9wFTY
         TvGg==
X-Forwarded-Encrypted: i=1; AJvYcCWZvrxTGCZvY13zyJAKW//gLrGI9Tn/D/ig1jk8C1T0SgBevONPliwkcS+cWDVz21Iuyv39aT+tyEPq6BI=@vger.kernel.org
X-Gm-Message-State: AOJu0YylALU0JSveWIYNRMQPA9uzXZivgthw4O2PQFz+IDywEfdwzucA
	EAiIWoeOG6Y0HQpudOSHjEP1dJz8lOhNuwEeS5FM0WfqjKH/xhHoX5weXdWKG4qfahcBsKD/L9v
	ZNoN8l+6mbwqwZEnuYj0+eLG7b/uwOkLnk0kX
X-Gm-Gg: ASbGncsydDrf3b8X2rBhYFrOm4CxDw3ipsONuYyZCjoZ2I4A7Zv8z5UMy7pVInJGQyF
	a3rQZU+tBjuJTnkxLgpPZ42YUfJbMPlFq1fyxECRoX+jUh/a4MZG6Z6F08gDZp7mZ+oM1nkIiKA
	==
X-Google-Smtp-Source: AGHT+IHknOnS20IyEG/AmrwiepdTigiTNWIelQsTYhKN3Y1IRu+FxgeFnHy8Zkl+3GUU1PdwRobzR3HHVc+lNJwdUFY=
X-Received: by 2002:a05:6402:1d52:b0:5dc:88fe:dcd1 with SMTP id
 4fb4d7f45d1cf-5e036071a81mr417228a12.12.1739555346067; Fri, 14 Feb 2025
 09:49:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214135911.2037402-1-edumazet@google.com> <20250214135911.2037402-3-edumazet@google.com>
 <20250214165904.33b73dc8@pumpkin>
In-Reply-To: <20250214165904.33b73dc8@pumpkin>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 14 Feb 2025 18:48:54 +0100
X-Gm-Features: AWEUYZle8NGtapUexCMhyEjuVpNeBA8mY81lgxOCXMld5sUqCm-VaVjsRfQTPgI
Message-ID: <CANn89iJjsCe+Yk6Kn8OUTqPEnSfbZv_gVhqByAYaY+pL2V36Qg@mail.gmail.com>
Subject: Re: [PATCH 2/2] posix-timers: Use RCU in posix_timer_add()
To: David Laight <david.laight.linux@gmail.com>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel <linux-kernel@vger.kernel.org>, 
	Benjamin Segall <bsegall@google.com>, Eric Dumazet <eric.dumazet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 5:59=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Fri, 14 Feb 2025 13:59:11 +0000
> Eric Dumazet <edumazet@google.com> wrote:
>
> > If many posix timers are hashed in posix_timers_hashtable,
> > hash_lock can be held for long durations.
> >
> > This can be really bad in some cases as Thomas
> > explained in https://lore.kernel.org/all/87ednpyyeo.ffs@tglx/
> >
> > We can perform all searches under RCU, then acquire
> > the lock only when there is a good chance to need it,
> > and after cpu caches were populated.
> >
> > I also added a cond_resched() in the possible long loop.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  kernel/time/posix-timers.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
> > index 204a351a2fd3..dd2f9016d3dc 100644
> > --- a/kernel/time/posix-timers.c
> > +++ b/kernel/time/posix-timers.c
> > @@ -112,7 +112,19 @@ static int posix_timer_add(struct k_itimer *timer)
> >
> >               head =3D &posix_timers_hashtable[hash(sig, id)];
> >
> > +             rcu_read_lock();
> > +             if (__posix_timers_find(head, sig, id)) {
> > +                     rcu_read_unlock();
> > +                     cond_resched();
> > +                     continue;
> > +             }
> > +             rcu_read_unlock();
> >               spin_lock(&hash_lock);
> > +             /*
> > +              * We must perform the lookup under hash_lock protection
> > +              * because another thread could have used the same id.
> > +              * This is very unlikely, but possible.
> > +              */
>
> If next_posix_timer_id is 64bit (so can't wrap) I think you can compare t=
he
> (unmasked by MAX_INT) value being used with the current value.
> If the difference is small (well less than MAX_INT) I don't think you nee=
d
> the rescan.
> (Not going to help 32bit - but who cares :-)

I just noticed the rescan is racy anyway, because when the other threads ad=
d
a timer, the timer->it_signal and timer->it_id are temporarily zero.

There is a small race window.

We can set timer->it_id earlier [1], but not timer->it_signal

More work is needed :)

[1]

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index dd2f9016d3dc..59ff75c81cff 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -126,6 +126,7 @@ static int posix_timer_add(struct k_itimer *timer)
                 * This is very unlikely, but possible.
                 */
                if (!__posix_timers_find(head, sig, id)) {
+                       timer->it_id =3D (timer_t)id;
                        hlist_add_head_rcu(&timer->t_hash, head);
                        spin_unlock(&hash_lock);
                        return id;
@@ -428,7 +429,6 @@ static int do_timer_create(clockid_t which_clock,
struct sigevent *event,
                return new_timer_id;
        }

-       new_timer->it_id =3D (timer_t) new_timer_id;
        new_timer->it_clock =3D which_clock;
        new_timer->kclock =3D kc;
        new_timer->it_overrun =3D -1LL;

