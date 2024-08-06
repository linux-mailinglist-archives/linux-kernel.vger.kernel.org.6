Return-Path: <linux-kernel+bounces-275748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB66C948953
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96AFD2843DC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 06:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59A01BC083;
	Tue,  6 Aug 2024 06:26:04 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126B833F6
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 06:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722925564; cv=none; b=ZOP951HVICWj4HPVVEsUEqXv0zRWgSEwH+s7VLvtiG9Npuj8suEVXH9q1ong7VoFRI3+JGW7xwR6jIMUxiUT7MqBf/YDztfLnPsIMXZXyQTDp4/KfyMFtDbDxAMljZ876Jo+9YMjMItc8+oONMUIrrjuG3bUvLcOYhMrMB+sDQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722925564; c=relaxed/simple;
	bh=2D9/B7cCWzOqKpXILArTzVdnKGk0UzyyVeuZ48lABgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hDnSYGSQQ/ZoRVmlsrgfVgBNdA5k3XeAxMUY4Rgxj7m4mTkfd136kfdYt6GE8pYl4FrYoU4kvjgisiYW9MhwxxumVlCFpV8kKnx+kce6TIhjvrzjPJ+BP/7aXbh21kbJytTXlq6PkU9KV8yTodK1WZx+RAHNr3DAyCFk/gMJpmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2cb5b783c15so304216a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 23:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722925562; x=1723530362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkhPq34IbcaE2arSpKB/w97lz5fPFLbPZIaKkBokZu8=;
        b=ZFT1dX7VPHP9s0ktibhKcZDuFjRjBiO7pXiY5AUOB9bX1lcdtKDLhvUKx+vtrIpdjW
         8BqmrMcwSr6QQmJJq4ARiluaoomvFBPaLyMLp5mXsE6yXECXROiXScWZfQcOVp072GtL
         B1HU1v7kAWbbyg+bLj+Qo7GZoXUivtpbc1K1NKHmW5iCcQyk3msMqy3ZhkGLiQGJOhGD
         fmO2yf2DrxPT8dlOy/CWMqxQt/azvb4b1qmZngoQtE6MCgY7b5NiDglFiw/KzZu3r7GP
         AlE9TyILh6/h1JbgJ1alR/QwPUWMJO5M+rUpvpe/sPdQ+n40IqDrta6usiY0S132Kcil
         GCqw==
X-Forwarded-Encrypted: i=1; AJvYcCU/lgmqjauAB3j7tCByf0p7i7D3s46hGFTBw9IFBqq53svhZywNVLb7QF8VQz5Fh5baOPtnlrYK3H2yjrMs2aF329mBSXyOPYdPRpaN
X-Gm-Message-State: AOJu0YyWGOcSP0CZTLIbazOe6Ya4T2hxMcedGoUicfY/dyY6JUdFxSDV
	K58DhsuZ9okNip2pibwASKfYMlnwu3tGlwdP0pkCooUvD1/+KNyQ4x6Gn3LSVDU/xm4vEVszLZL
	8aoJhz/lDIfXYu7OeGBe/6smNVxE=
X-Google-Smtp-Source: AGHT+IHo7n/MNZJ8lg8MMqzWAsAsJ5eg02O4tf5knTx3tyBpIZz/+mt0tmXrnR8VVMHT2AsNR6sLe571m78S3k/SfLI=
X-Received: by 2002:a17:90a:f486:b0:2bd:d42a:e071 with SMTP id
 98e67ed59e1d1-2cff952441dmr16235893a91.30.1722925562001; Mon, 05 Aug 2024
 23:26:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730191925.469649-1-namhyung@kernel.org> <CAL715W+2jmoFvEy=LpkFFwX9oQSW3qhM_D-t77p-2CCBKmpdNg@mail.gmail.com>
In-Reply-To: <CAL715W+2jmoFvEy=LpkFFwX9oQSW3qhM_D-t77p-2CCBKmpdNg@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 5 Aug 2024 23:25:50 -0700
Message-ID: <CAM9d7ci9PpT3A7AC65dmZbqPM8V1wGzvV_9hbdDKbRK=7q0j2Q@mail.gmail.com>
Subject: Re: [PATCH] perf/core: Optimize event reschedule for a PMU
To: Mingwei Zhang <mizhang@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mingwei,

On Mon, Aug 5, 2024 at 9:57=E2=80=AFAM Mingwei Zhang <mizhang@google.com> w=
rote:
>
> On Tue, Jul 30, 2024 at 12:19=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> >
> > Current ctx_resched() reschedules every events in all PMUs in the
> > context even if it only needs to do it for a single event.  This is the
> > case when it opens a new event or enables an existing one.  What we
> > want is to reschedule events in the PMU only.  Also perf_pmu_resched()
> > currently calls ctx_resched() without PMU information.
> >
> > Let's add __perf_pmu_resched() to do the work for the given PMU only.
> > The context time should be updated by ctx_sched_{out,in}(EVENT_TIME)
> > outside from it.  And change the __pmu_ctx_sched_in() to be symmetrical
> > to the _sched_out() for its arguments so that it can be called easily
> > in the __perf_pmu_resched().
> >
> > Note that __perf_install_in_context() should call ctx_resched() for the
> > very first event in the context in order to set ctx->is_active.  Later
> > events can be handled by __perf_pmu_resched().
> >
> > Care should be taken when it installs a task event for a PMU and
> > there's no CPU event for the PMU.  __perf_pmu_resched() will ask the
> > CPU PMU context to schedule any events in it according to the group
> > info.  But as the PMU context was not activated, it didn't set the
> > event context pointer.  So I added new NULL checks in the
> > __pmu_ctx_sched_{in,out}.
> >
> > With this change I can get 4x speed up (but actually it's proportional
> > to the number of uncore PMU events) on a 2-socket Intel EMR machine in
> > opening and closing a perf event for the core PMU in a loop while there
> > are a bunch of uncore PMU events active on the CPU.  The test code
> > (stress-pmu) follows below.
> >
> > Before)
> >   # ./stress-pmu
> >   delta: 0.087068 sec (870 usec/op)
>
> Hi Namhyung,
>
> I wonder how I could test the performance boost on the virtualized
> environment. So, I assume this will have a better performance by
> reducing the number of wrmsrs to event selectors and counters?

Right.

>
> I wonder if I need to run multiple instances of stress-pmu to increase
> the number of PMU context switches?

Yep, I think it'd work.  Basically anything that opens more events in
different PMUs.  But make sure the vcpu thread is running on the
affected CPU (60 in my test).

Thanks,
Namhyung

