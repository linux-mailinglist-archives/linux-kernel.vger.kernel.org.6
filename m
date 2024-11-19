Return-Path: <linux-kernel+bounces-413629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0169D1C32
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 01:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8475C1F222F5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 00:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22BAE571;
	Tue, 19 Nov 2024 00:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gGsORpEH"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0C5A93D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 00:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731975755; cv=none; b=Gj4kj4koomw5jalcVHBqXQKR2g+vJHOBs+skLzOPJ0JS+6DiV3HTVjEC6NoMtYaUWFsGCrdOLKaOpTTC8WvVjmi86Phar28MZXdnJjYZa5geS3yH/xCNkHCV8Uc6C8jHtxuxoij0mtCO5bEMX9BSj/LQNod92X51ITMJbcerw/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731975755; c=relaxed/simple;
	bh=X+LfutNmkZLBYCMm3jRilySxLsginSJcHgXDLjyD2hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tNkqmTgAvkwq9PoqmQ/ZdlMdsObjeGrIoANXYpYZ9UIeZS7vHtmxS5Oh+LEvL8mvznt/Q9cmMXGoPB0rBNUkMxxZL5z5kX05ilc4yi7WqJQ0QEIiP+I5gd4oV1aWV1APv/oJ80eNrZFE1Pe/Ec/sw/P8/BzpMy4n+QaX7a6l7Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gGsORpEH; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4316cce103dso37102935e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 16:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731975752; x=1732580552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSKTT9+CZJoWXlp0m+3yVsM3zVA66cqs91qqjLrHy/0=;
        b=gGsORpEHseiSX5FpSJkSkxnXPvJpa1xjF2a9srECwldhvF+B0bO25t86CG5WNHXEPO
         D4lUTyWTc2VSR6hmSa8qr5Ew3L0bNv1/TNpMvU34oW/sNYbSoXP3zDqdVhxdOF8QesBm
         Ph98lxaJrBbOAseZQRsAD4b36pPzjkvvjSc4i84GYhmLf9rdNIxLqrHI7uiKUR1o07MO
         xpRub+R9dWnqH9bWCMukS7qoGnupkW00I4xk9V3dAV+YXqISJYT9T3fxpukXZL64OOIV
         KlrLU9sWOVRi9MjQC9ZKn/6tI81KC0QTskfHuo8V2A9uWrMuKrEoJ8th8BpsiAu8uJHh
         /KzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731975752; x=1732580552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VSKTT9+CZJoWXlp0m+3yVsM3zVA66cqs91qqjLrHy/0=;
        b=Sa1rnZpP5t6O0asIB9HgfWU9l/a9aquvONcgXKnf+rqvXoKeW2du8lXZ9Iia11M+Pa
         t8z2hwIM8xQdUbOPpUbgS1rk4BwomUP9AHMgytLgMg/U7SWovPtYT7wEU2FvymZmzYpf
         iM2biRGUVqIu6aizTg+5DksVdEJp3QiFf7qWJhQxHtNJylmiM0aSANfU6HUKKvy3L3n9
         oF1aMCI1r0Tb9NGYRhvv23rbbMjAYR0KJMzTUpN1M2QktMDGnePxq7PadW6MjJ+/X0K6
         oZASEEneILfXTZfij8whIyMqpHe5rWfRz802iRqERR5MZDUTYnFUOoPJrfuhm1jWmH3H
         bhFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4zs+3XOFRSJvihzWTlGFU7alkBmMwaFtlueeQo0Qh4MGWU9y+QH6/fSQs/9W+3uJ0iky0J2mhalFqNnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxIapIrdytxnDs7/L6RFh20Tx+4v3N4ga3ZFriYE0RrT+yCPAi
	IRUHhnjjKhez+PXzNW5wmfNSbODJ6Ils6Q15q3TkvTtsTzPppJpciY/nWiQ6iIcGUmyg9Iam+ZS
	ew9bvmnExprE8P3WBjW+UY9HubK3eYJCELSHX
X-Google-Smtp-Source: AGHT+IFrQ0w4YKf6Tun2dYvIeZ8sw5qBscPut0n0CWGUA0i22fgbhRTxIf3RjbnCdYAKgRNa0rE3NQJXfNE+LvbgfJ4=
X-Received: by 2002:a05:600c:501e:b0:431:4847:47c0 with SMTP id
 5b1f17b1804b1-432df722c63mr140674345e9.7.1731975752011; Mon, 18 Nov 2024
 16:22:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118043745.1857272-1-suleiman@google.com> <20241118143311.3ca94405@gandalf.local.home>
 <CAJWu+oqR=SMKHd1EqvRm3nvz7e1r4e7Rj76hJ8jhDQQkNVo0ig@mail.gmail.com> <20241118191813.145031fc@gandalf.local.home>
In-Reply-To: <20241118191813.145031fc@gandalf.local.home>
From: Joel Fernandes <joelaf@google.com>
Date: Tue, 19 Nov 2024 09:22:20 +0900
Message-ID: <CAJWu+opw2gohuwU2wie1eBghT0fL=fX60LdBu+_B2TjkHc4yyw@mail.gmail.com>
Subject: Re: [PATCH v3] sched: Don't try to catch up excess steal time.
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Suleiman Souhlal <suleiman@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, seanjc@google.com, 
	Srikar Dronamraju <srikar@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>, vineethrp@google.com, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, ssouhlal@freebsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 9:17=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Tue, 19 Nov 2024 09:10:41 +0900
> Joel Fernandes <joelaf@google.com> wrote:
>
> > > > +++ b/kernel/sched/core.c
> > > > @@ -766,13 +766,15 @@ static void update_rq_clock_task(struct rq *r=
q, s64 delta)
> > > >  #endif
> > > >  #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
> > > >       if (static_key_false((&paravirt_steal_rq_enabled))) {
> > > > -             steal =3D paravirt_steal_clock(cpu_of(rq));
> > > > +             u64 prev_steal;
> > > > +
> > > > +             steal =3D prev_steal =3D paravirt_steal_clock(cpu_of(=
rq));
> > > >               steal -=3D rq->prev_steal_time_rq;
> > > >
> > > >               if (unlikely(steal > delta))
> > > >                       steal =3D delta;
> > >
> > > So is the problem just the above if statement? That is, delta is alre=
ady
> > > calculated, but if we get interrupted by the host before steal is
> > > calculated and the time then becomes greater than delta, the time
> > > difference between delta and steal gets pushed off to the next task, =
right?
> >
> > Pretty much.. the steal being capped to delta means the rest of the
> > steal is pushed off to the future. Instead he discards the remaining
> > steal after this patch.
>
> Thanks for confirming. I just wanted to make sure I understand as the
> initial change log went into a lot of detail where I sorta got lost ;-)

No problem!! Glad we're on the same page about the change.

thanks,

 - Joel

