Return-Path: <linux-kernel+bounces-275747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9311D94894F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C82A4B23D32
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 06:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968901BCA02;
	Tue,  6 Aug 2024 06:20:02 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AD81BCA03
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 06:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722925202; cv=none; b=iGkRKqIPlloz594vsXMFdYzd2ugRJGIyUbFZvT8HmRAsfmGDTRSqB7ZYQjS1yuXd6Fv1Sr+bXeeQ4TP2/mHpU9yeoWKnwC27dkPAlaMHqXlYfZVeDe3hrg2eFK2+K8t/i2Zokr+PZUSg7FvLRDxMtIOslK6WCeotKczxsEY5TfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722925202; c=relaxed/simple;
	bh=IxqNNLxn4wuFZHVCfI+Ja0q80HBf2Ls5R0lRsIKhM88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V+WuQk9vMOSgf1C+G2BgXj+3BeBiUYEOi9k+kmvoSwEgetHdI8bqz/k7F8pj9xS+SjiOUcOW8GigVg6mzr4TqODhgQFLoXCmATXVfoTwMJNRM9cbx9sL/jDF1IPL34YETEq3IZNAHUS/FhJSadTC/01hWo7YJMC3ozl6EXkes6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2cb5b783c15so301308a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 23:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722925200; x=1723530000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ou6JbE4HvK6WXBzfl7mdvQ5IVasijdNTINmXSpbVxEE=;
        b=MfBXKAUIdHbxvBGstNum4eQFxjqBLtixOLt+Q0g03EuwzxmExqPcqijqZlcyiyjOUf
         J/Zub40fLqNa8CZHzN6pK2aYZy1ctM6y1F5uZeken2TupIQcQPTW1bmZ1FNWLHUwm2Ov
         OZjlwD9C51pnVIHu63okQlwd13iS3FtEK/KkLH6ydEKwKhMYnxYzbGGzdb8tlWmi4Jp/
         FydmrSpGpCKaTF+HXPiRpDpAf3+N1iRdWFKbC/UPBomItGfJJzDU/kn49zdVUQCcDIWa
         9G37wRBJ81ZSgmFxx4XPt64fogpMleawVR2Ay493ElqcD2lxqB2Rg6clZ7Kwr9ngzV2g
         fCPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhskj5jQk1PLCkACidjN3CFtPDEDmINa28cCKXA3rBJsLNyspBCXyFxuyoRee4uqCr4d4l6mw+7DXz38vxZKK/fgliZkZ23ueOKBkJ
X-Gm-Message-State: AOJu0YyigZXHiM1EFjlP1wfhkZs5sGdLtFkLcGIWn0GyCgfCc0fzIAAc
	5lqw035wGKTAX8XG+PDjzj3n5zMBEusER/OUOBN0xGxo9jNai3NsZAlEl7FbltwLCjspEcZeJIN
	ZjlNFoKIYMxkYLPjtDb9FG3xDMyPZqRmY
X-Google-Smtp-Source: AGHT+IFVUnXdT+kgsX3zpCG6WvsgcolEO+S6tBr4cK31cdaP0eEMTCj/kYEu7v/XSHBMTnu1jCJBT+nP7hCcqqCj+Ik=
X-Received: by 2002:a17:90a:c241:b0:2c9:7219:1db0 with SMTP id
 98e67ed59e1d1-2cff93d410cmr16495744a91.3.1722925199490; Mon, 05 Aug 2024
 23:19:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731000607.543783-1-namhyung@kernel.org> <476e7cea-f987-432a-995b-f7d52a123c9d@linux.intel.com>
 <20240805092058.GK37996@noisy.programming.kicks-ass.net> <20240805145827.GE12673@noisy.programming.kicks-ass.net>
In-Reply-To: <20240805145827.GE12673@noisy.programming.kicks-ass.net>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 5 Aug 2024 23:19:48 -0700
Message-ID: <CAM9d7cj8YMt-YiVZ=7dRiEnfODqo=WLRJ87Rd134YR_O6MU_Qg@mail.gmail.com>
Subject: Re: [PATCH v2] perf/core: Optimize event reschedule for a PMU
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Stephane Eranian <eranian@google.com>, 
	Ian Rogers <irogers@google.com>, Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 7:58=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Mon, Aug 05, 2024 at 11:20:58AM +0200, Peter Zijlstra wrote:
> > On Fri, Aug 02, 2024 at 02:30:19PM -0400, Liang, Kan wrote:
> > > > @@ -2792,7 +2833,14 @@ static int  __perf_install_in_context(void *=
info)
> > > >   if (reprogram) {
> > > >           ctx_sched_out(ctx, EVENT_TIME);
> > > >           add_event_to_ctx(event, ctx);
> > > > -         ctx_resched(cpuctx, task_ctx, get_event_type(event));
> > > > +         if (ctx->nr_events =3D=3D 1) {
> > > > +                 /* The first event needs to set ctx->is_active. *=
/
> > > > +                 ctx_resched(cpuctx, task_ctx, NULL, get_event_typ=
e(event));
> > > > +         } else {
> > > > +                 ctx_resched(cpuctx, task_ctx, event->pmu_ctx->pmu=
,
> > > > +                             get_event_type(event));
> > > > +                 ctx_sched_in(ctx, EVENT_TIME);
> > >
> > > The changelog doesn't mention the time difference much. As my
> > > understanding, the time is shared among PMUs in the same ctx.
> > > When perf does ctx_resched(), the time is deducted.
> > > There is no problem to stop and restart the global time when perf
> > > re-schedule all PMUs.
> > > But if only one PMU is re-scheduled while others are still running, i=
t
> > > may be a problem to stop and restart the global time. Other PMUs will=
 be
> > > impacted.
> >
> > So afaict, since we hold ctx->lock, nobody can observe EVENT_TIME was
> > cleared for a little while.
> >
> > So the point was to make all the various ctx_sched_out() calls have the
> > same timestamp. It does this by clearing EVENT_TIME first. Then the
> > first ctx_sched_in() will set it again, and later ctx_sched_in() won't
> > touch time.
> >
> > That leaves a little hole, because the time between
> > ctx_sched_out(EVENT_TIME) and the first ctx_sched_in() gets lost.
> >
> > This isn't typically a problem, but not very nice. Let me go find an
> > alternative solution for this. The simple update I did saturday is
> > broken as per the perf test.
>
> OK, took a little longer than I would have liked, nor is it entirely
> pretty, but it seems to pass 'perf test'.
>
> Please look at: queue.git perf/resched
>
> I'll try and post it all tomorrow.

Thanks for doing this.  But some of my tests are still failing.
I'm seeing some system-wide events are not counted.
Let me take a deeper look at it.

Thanks,
Namhyung

