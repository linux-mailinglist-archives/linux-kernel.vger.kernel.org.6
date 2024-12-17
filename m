Return-Path: <linux-kernel+bounces-448639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B00439F434F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 07:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6312F188F987
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 06:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC714157A46;
	Tue, 17 Dec 2024 06:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z1rV66kb"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABC818E20
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 06:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734415772; cv=none; b=j8k33K6yMiSbuE29ge0J/FtVbqROBb1g6PppuFZ7M3XVB8grLNbdYzlooStsm6JMfJh6vdjxuZDiyDwN3Ay5EjiiYtMYoVY3V9te4GGM/Ev/nr302sFcZnCLtw5jrKPlCHHY0lCxldJT+AcXEv14VZ+B9tdAqw+dCWb3hikKKCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734415772; c=relaxed/simple;
	bh=Tn0p8dSuS65zvQgZn4NqjJWljDDPzJ1B2+ZOqQK8SVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tf7D3TFeiqC7aqSgH74bUjviwzvgE2HOr+mVglCxwL1wAeXTZcAmoTc7AnCtF3kAUdVEIYliw7VOd4BUst/c80OgGnd8Urdg8By0BkzR1F+fYrde0LRjfeK3f2dASsNklVTWBgj0fS41rxecdrymzSp50hpXKdTdWBX2uZLnl1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z1rV66kb; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa692211331so925879766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 22:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734415769; x=1735020569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w98OJ7x2EnucJEEmu7JTJJ2Pu1axRy0kRVyMgxfsao0=;
        b=Z1rV66kblg/ua31AOXga8iXodBeAKvLz4+MHlwi+ETXojaJqRcrifpNMpGMKQWmlf9
         L8nbMKzBfQ9wWZ6SFFCWVIEjbt8XPa2sgvHBenPdp51w+BjeJzhPHKpKjsPvfh2eToFD
         GE/fDnGN09mNmguSVtSmeeDSCyuDCCe4lyqixYMlEpGiSp9rMpZjQqBEJtg2qfjKUjvz
         PyOXuAPZLwJVvvViTJ/4YGSBaSsztvA5bmvG7u27crEYpdUJ9vxEJA4SPVp30+Uqt4hV
         y4rIsPtLKt00iOnKd/VbSo76YfNySNkd0KPHkS4dqL/zEad7iOqfZ+xzyC6sxqTSpoPf
         CiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734415769; x=1735020569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w98OJ7x2EnucJEEmu7JTJJ2Pu1axRy0kRVyMgxfsao0=;
        b=Sg0CT+7kGzP/RDdhTOOodHVYMy7hzgd6ylFg5Xv1eoQx2/tYOrN065fOyc1va1nlyr
         QVhqrBTcJ8kQXwBdnFWmyzBJfTuph9V/CYpiLj9RXcpHc/aJyidNTJajaUo1SiyoaczX
         xQJ90kv9mYDIT/u79TLUQQoEQ7sB9bH+B7kx4FSL7IXRr+VdXft5KdHzw9xpeg6eUIyd
         DbfeZJphkz3WOXgWGbnE8CCJVQz8+6EJrlh/COXF89+W/YQ8fOT0/5OE1kwU7GutNY6Y
         3mj81wlUPPpniM3Fb3nrkHVhYgz/92GFBUNonbW74YD8/nrg0F8HHxuQoAO8KHpbihFF
         N8UQ==
X-Gm-Message-State: AOJu0YxYMtL/S6jBrwuk89o5Ts1+ToAvLEqNzezlAAQjLEGo2ChEdMUO
	ZTDWh/cGYefEiccAnPdRhoE4oIt3qrWqkFW898+V1cN9obPda1A2f9P1u48oouX19TsSuo0miZP
	lxsb3+w7cwV0+/lhyJO3E2bo8wT7kaM1nzrM=
X-Gm-Gg: ASbGnctqqlhJNLEaz5QUterWjHKhk8Z0/Imu+MfKPJRNBK7Rcqeigm3THjNSd1q5WI2
	tHs9dhUNC2HkghG6Gfc3nkTN7tfe6/Y9UvgtB1FEqXlZhYNmgytvGxnVBoT3gNBMEN9s=
X-Google-Smtp-Source: AGHT+IF54C8pM4YYzdjC+EKJcAEBPHrYRY+kZcURt27nmgToyxMFhM9POPEnh3LmDbGWD6b3iRSVLrgVMWBfWVgbFXo=
X-Received: by 2002:a17:907:c23:b0:aa6:acbe:1a81 with SMTP id
 a640c23a62f3a-aabdcba2618mr138437466b.21.1734415768491; Mon, 16 Dec 2024
 22:09:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125195204.2374458-1-jstultz@google.com> <20241125195204.2374458-4-jstultz@google.com>
 <20241213233740.GB17501@noisy.programming.kicks-ass.net> <20241214000951.GA16123@noisy.programming.kicks-ass.net>
In-Reply-To: <20241214000951.GA16123@noisy.programming.kicks-ass.net>
From: John Stultz <jstultz@google.com>
Date: Mon, 16 Dec 2024 22:09:16 -0800
X-Gm-Features: AbW1kva1X5JgqXs3CeqS7rBi0WDWPMRgs5HfH68okr4CUL8ux-CPXZjG_U1dsfc
Message-ID: <CANDhNCoMz9m_U_86utexFp8+QgVr8rEdGwOygBbNEpwtsByxeA@mail.gmail.com>
Subject: Re: [RFC][PATCH v14 3/7] sched: Fix runtime accounting w/ split exec
 & sched contexts
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 4:10=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
> On Sat, Dec 14, 2024 at 12:37:40AM +0100, Peter Zijlstra wrote:
> > Would it not be *much* clearer if we do it like:
> >
> > static s64 update_curr_se(struct rq *rq, struct sched_entity *donor,
> >                         struct sched_entity *curr)
> > {
> >       ...
> >       donor->exec_start =3D now;
> >       curr->exec_start =3D now;
> >       curr->sum_exec_runtime +=3D delta_exec;
> >       ...
> > }
> >
> > and update the callsites like so:
> >
> > update_curr_common()
> >       update_curr_se(rq, &donor->se, &rq->curr.se)
> >
> > update_curr()
> >       update_curr_se(rq, &curr->se, &curr->se);
> >
> >
> > except, now I'm confused about the update_curr() case. That seems to
> > always update the execution context, rather than the donor ?
>
> Ah no, cfs_rq->curr is the donor.

Yeah. That is one detail in the current series where the naming can be
particularly confusing.

I can go through and rename cfs_rq->curr to cfs_rq->donor (or some
other name) to make it more clear, but it seems like a ton of churn,
so I've been hesitant to do so until there was stronger consensus to
taking the patch series, but maybe we're at that point now?

But maybe a simpler and more isolated fix is I could just rework
update_curr_se to just take the rq* and we can derive the donor.se and
curr.se from that.

Thoughts?
thanks
-john

