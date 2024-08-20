Return-Path: <linux-kernel+bounces-294274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 349AA958B85
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5E962853C9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF8A195985;
	Tue, 20 Aug 2024 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DvEXNZG9"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E0819414E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 15:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724168560; cv=none; b=uRss2R7vGcKiHFAhJbV0vGt+FFszhaIKaSmvyWVxjB04pOzNs+rib6RUf5A9AboLgGc+jvImLDnmVulgYkR+YIkGXkijgYehhXtbX6l9pq0/WDFqnq9FfnN+iZVpuRJ4KS2uq8Cvf2V1GYV45rfxEyT0ZXFgrun2ub1r/fYd4JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724168560; c=relaxed/simple;
	bh=eVbNw2MA5BIsu/7v2DdxXuFbBRjuKk3C44PaYmooD1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AXd3yVv5nlMH7Y64cU171M6hyC8KfNMNEKvCPA2trfHccBsqLR+83XdY/MVbaz774GYOGLQypP7CXyvXF9YluiJbGSN8qkuH2QkxeyDzzujK+MaoY+XlGVMDYgk4nvsucSqVuu5PGCOpySjxueCU8D44MNNt6bBA8QufsajzJ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DvEXNZG9; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4280bca3960so49944855e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724168557; x=1724773357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVbNw2MA5BIsu/7v2DdxXuFbBRjuKk3C44PaYmooD1M=;
        b=DvEXNZG9OMU/8tSEaYzygSkVqcviiCsdzPSZSyg/uobDlsigUxjAWc/JzoKDGU7axu
         zMAmiug7Z9Ck25P/q38tCI1iSR1VdMjIV5EP8PWA86kF4FUu8F/87y1ibPdimy5edE1b
         dqBZBt3JBQygaDuqM9xIEQCYbkNUcLfLcv4UJ60mUTYTZBJupfK8xkkCteVOZ26lzF8J
         hmXev7bbpJBaKm4lkt96qDUroDKHbrURW8ULuluFOm3LcPh5HDq7uI72HPQfuVGazkV+
         bAiG1FTr/oHdnPRxD5MOhxcL0Pqu+au5J9qUgYqIGn5De34Xfp/SU694wfBS/eqcWpR3
         mZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724168557; x=1724773357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eVbNw2MA5BIsu/7v2DdxXuFbBRjuKk3C44PaYmooD1M=;
        b=dvzCmqHaMw+ridSylv7BVdB4SsecBwhNxhlLed+J0cB7GEIKqioqkwg29MF6Fn4NRq
         X53kPPUuSbRb0fbas1/5H6ieRJkLsXwOneO6KJhEFQ8kWNp/ZMYCR/FPrE+aKSJxNKA3
         GcnYih4x2cSIQmk7KYDQUyogaZqIs3VjHs3LjDcVG7vxE7dhcVjEZjAPOPks+xMYC6ed
         glpOboWN12HpxMh/lQgI9bgBJ5OQGi8iuKNo4VOdR67atuM6tNUDb2fBfvAG+LveOWId
         6EfrK7xhNmQMx17D+Fmfg65wZIaC+fmIm/GuAji4TNKBPX/fMyk9Gja1m/C4e2kxMkYz
         L2cg==
X-Forwarded-Encrypted: i=1; AJvYcCUzXzblLgLOzt2tNfmn57izv06WiPvgdI+vDw2sfyg8EypvUXfCdWhHHnJqbcnFAk13/WjANMr3aoS0/nzeMAZJ8/ClEgeKa9Ky1UUc
X-Gm-Message-State: AOJu0Yxy3SYjhUEoVct8fX2EuI/G4FsJ1bvVUGvi2Mmzfdz3EAaquOm+
	UdV9O4TtjqcZo1JOkB8p7W5bp2xzFEVp5XlEDVhjYlAk3rJed2g+Dq9et9RJRWHSMxqPkfE0Zcc
	SZagDZjhQDU8u8r/JBT1eYNWWQedJLElwmq8q
X-Google-Smtp-Source: AGHT+IEFnx0SA7SmO44+VA1QPMgnjKsZAVHGuMn5Zugs9FA4AjmHbkZ8mZLPY0+IK3icawDap7Ou1hcuWcnY/KT9yTg=
X-Received: by 2002:a05:600c:138f:b0:426:4f47:6037 with SMTP id
 5b1f17b1804b1-429ed7b88a6mr93374385e9.19.1724168556515; Tue, 20 Aug 2024
 08:42:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806111157.1336532-1-suleiman@google.com> <20240820094555.7gdb5ado35syu5me@linux.ibm.com>
 <20240820105036.39fb9bb7@gandalf.local.home>
In-Reply-To: <20240820105036.39fb9bb7@gandalf.local.home>
From: Joel Fernandes <joelaf@google.com>
Date: Tue, 20 Aug 2024 11:42:22 -0400
Message-ID: <CAJWu+orJQZkH=iKOw7NOUhtPxcQBAiOd+bxEQTJ8MFxYRrv16A@mail.gmail.com>
Subject: Re: [PATCH] sched: Don't try to catch up excess steal time.
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Srikar Dronamraju <srikar@linux.ibm.com>, Suleiman Souhlal <suleiman@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, vineethrp@google.com, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, ssouhlal@freebsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 10:50=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Tue, 20 Aug 2024 15:15:55 +0530
> Srikar Dronamraju <srikar@linux.ibm.com> wrote:
>
> > * Suleiman Souhlal <suleiman@google.com> [2024-08-06 20:11:57]:
> >
> > > When steal time exceeds the measured delta when updating clock_task, =
we
> > > currently try to catch up the excess in future updates.
> > > However, this results in inaccurate run times for the future clock_ta=
sk
> > > measurements, as they end up getting additional steal time that did n=
ot
> > > actually happen, from the previous excess steal time being paid back.
> > >
> > > For example, suppose a task in a VM runs for 10ms and had 15ms of ste=
al
> > > time reported while it ran. clock_task rightly doesn't advance. Then,=
 a
> > > different task runs on the same rq for 10ms without any time stolen.
> > > Because of the current catch up mechanism, clock_sched inaccurately e=
nds
> > > up advancing by only 5ms instead of 10ms even though there wasn't any
> > > actual time stolen. The second task is getting charged for less time
> > > than it ran, even though it didn't deserve it.
> > > In other words, tasks can end up getting more run time than they shou=
ld
> > > actually get.
> > >
> > > So, we instead don't make future updates pay back past excess stolen =
time.
>
> In other words, If one task had more time stolen from it than it had run,
> the excess time is removed from the next task even though it ran for its
> entire slot?
>
> I'm curious, how does a task get queued on the run queue if 100% of it's
> time was stolen? That is, how did it get queued if the vCPU wasn't runnin=
g?

The scenario seems plausible to me, like say several tasks were
already queued on the RQ (overloaded RQ) before any time stealing
happened. Then vCPU is preempted thus stealing time. When vCPU returns
to execution, the running task runs without the clock_task advancing
and then goes to sleep thus freeing the RQ for other tasks (that were
previously queued).

Or did I miss something?

thanks,
 - Joel

