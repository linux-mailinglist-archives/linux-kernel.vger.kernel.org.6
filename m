Return-Path: <linux-kernel+bounces-403627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C15E59C3844
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 07:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BF11B213AA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 06:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395F314F9F9;
	Mon, 11 Nov 2024 06:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0OgmrP+x"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FB9130A73
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 06:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731305749; cv=none; b=eDOVMId/UtmYTpgBO0iViifO8jpE4atsOODqlm0A3lVOKPVWn4ObGNJ2gJg9/j9MTuzd0uPOqEsYP3vxMhSangwhbHRC22ZBO0mup6Zk802NXoYrTQb60Pe/3yZUAe5EadI40xQWtY7uXViQUrNOW4rLT4i0NladUFAiFiuD4dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731305749; c=relaxed/simple;
	bh=c6LUr/hAMVGKOClMosJRQxLvVMaXhkLYt1smjP/D7lI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZJk0SOeBXQ/xolAUoLDxP8wVoOrfO2s7WO/jUVtu3BztAAP1pJhNOiI29kDyjptrMBnOQz5Fk3T9R3rodJxt1ZNbrBs23m/hFip1HNmglLsVhUzglNasw3Rl1dEPMpWoT3m1aZk9HB4frrL5pzY4yoViRscVWb/247ArqxMG2ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0OgmrP+x; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-723db2798caso4244460b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 22:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731305747; x=1731910547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6LUr/hAMVGKOClMosJRQxLvVMaXhkLYt1smjP/D7lI=;
        b=0OgmrP+xdwxb3Ib+70+nkBQze5aH5dzs+/hTOc92uhVr3/aA0EY1CYRzhvrmauAKpY
         gTFcd9pV72Qr0ztWRGdcM/SQb/nvwGmyPPOJIbR/IdkqTV6rtpyJQzLNY1KlcrwTOysy
         xGZTSDQFsrO0NI7O2Q4RcvCCCzcd8TAQnENW0U8J1dtZuFVkShvDMVLnkQ6s38W5XR6k
         q/48PfVFLLztsyC39KMQ6yxPc4s2quDW9vUC8leBWbN8NUI51OQeqOVjU15XB1TH0pSr
         aElnGbPX2ueGbz6Ok4YT0UX7pyXaF7qEDjrVuG6H5kdLN2lLOV6t/Dfnl/yFN/j+crIr
         si3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731305747; x=1731910547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6LUr/hAMVGKOClMosJRQxLvVMaXhkLYt1smjP/D7lI=;
        b=GiQeKKPZUPv3EI3QWxP35BUX5Hr7TpX7XTt31PG6tgcQOtILGQjjVwdzEoWDJP+xNo
         memqM7NjpCeMDR5qvgR+3u5KWEbnQ9yVAhSBM0X9n8ONlc2LyEdknpSOWjKNQXUW2ui8
         gZ8a16+fU8TcH7t9tqFBNGjqkUysLfyfJRwCG7g67qVXzi4TAHgJd8kpmgRgSRlnbtl9
         oNXxF0JditDtrfItphkgRlh2XBDJ7cNZm5q8OqJs/7J6H9tAGW4xv//KNLKJ69mn0YzV
         YGaUpwMXl/F7a5ktxYHEBlX9pEg4KHvwfDqtrjCIa7SR9RcdYywvDV0geiFURhWdMv9u
         I4sg==
X-Forwarded-Encrypted: i=1; AJvYcCV2YHnw9cNYylNpaCmyzCCt5TRN0c061+uue+pnIN9u6N36d4ymp8H6wGldO2yHahdfBApxkBHWXPkItA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZG8m4+tMJcfqwL4SpNRoDRjAHMYolv2oUq6pqCY7GAZx4TVXt
	zpAMJWOoTiYiS0p+UF9WYa2fF12+pyI4BLbHFn8Xjp9f/4kkKKbc3d1BBqNSDphAzrAleWRxBWN
	DDc2hUzs1qLMMjXp/Wfi0zSJmPbVzQoremVN8
X-Google-Smtp-Source: AGHT+IEkTIwe9oiKtgPfhruLRo7uYMAQS798EKUY9NaPxmskoW+5Ru8yBhdZ2ki9FYYiS8rm1s2DsXYSEzlPjHF1cAA=
X-Received: by 2002:a05:6a20:43a4:b0:1d9:2694:44f0 with SMTP id
 adf61e73a8af0-1dc22b507fcmr16485845637.35.1731305746886; Sun, 10 Nov 2024
 22:15:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGETcx830PZyr_oZAkghR=CLsThLUX1hZRxrNK_FNSLuF2TBAw@mail.gmail.com>
 <20241108083133.GD38786@noisy.programming.kicks-ass.net> <CAGETcx-CvWVc=TP5OmUL_iF7fSb1awJB1G8NghM1q_6dYKXkQQ@mail.gmail.com>
 <cc8831c7-8ea2-0ee7-061f-73352d7832ad@amd.com>
In-Reply-To: <cc8831c7-8ea2-0ee7-061f-73352d7832ad@amd.com>
From: Saravana Kannan <saravanak@google.com>
Date: Sun, 10 Nov 2024 22:15:07 -0800
Message-ID: <CAGETcx9qDK+QUiP8z1iNYXwjHz39oZzOZmhj4p=icU1BuVtcug@mail.gmail.com>
Subject: Re: Very high scheduling delay with plenty of idle CPUs
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Benjamin Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	wuyun.abel@bytedance.com, youssefesmat@chromium.org, 
	Thomas Gleixner <tglx@linutronix.de>, efault@gmx.de, John Stultz <jstultz@google.com>, 
	Vincent Palomares <paillon@google.com>, Tobias Huschle <huschle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 10, 2024 at 9:17=E2=80=AFPM K Prateek Nayak <kprateek.nayak@amd=
.com> wrote:
>
> (+ Tobias)
>
> Hello Saravana,
>
> On 11/10/2024 11:19 AM, Saravana Kannan wrote:
> > On Fri, Nov 8, 2024 at 12:31=E2=80=AFAM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> >>
> >> On Thu, Nov 07, 2024 at 11:28:07PM -0800, Saravana Kannan wrote:
> >>> Hi scheduler folks,
> >>>
> >>> I'm running into some weird scheduling issues when testing non-sched
> >>> changes on a Pixel 6 that's running close to 6.12-rc5. I'm not sure i=
f
> >>> this is an issue in earlier kernel versions or not.
> >>>
> >>
> >> It's a bit unfortunate you don't have a known good kernel there. Anywa=
y,
> >> one thing that recently came up is that DELAY_DEQUEUE can cause some
> >> delays, specifically it can inhibit wakeup migration.
> >
> > I disabled DELAY_DEQUEUE and I'm still seeing preemptions or
> > scheduling latency (after wakeup)
>
> On the scheduling latency front, have you tried running with
> RUN_TO_PARITY and/or PLACE_LAG disabled. If the tick granularity on your
> system is less that the "base_slice_ns", disabling RUN_TO_PARITY can
> help switch to a newly woken up task slightly faster. Disabling
> PLACE_LAG makes sure the newly woken task is always eligible for
> selection. However, both come with the added disadvantage of a sharp
> increase in the number of involuntary context switches for some of the
> scenarios we have tested.

Yeah, I don't think I can just change these because that'd have a much
wider impact on power and performance. I really need something
isolated to the suspend/resume scenario. Or just a generic bug fix
where the scheduler does better CPU selection for a thread. I'm saying
better because I'd think this would be better from a power perspective
too in the specific example I gave.

> There is a separate thread from Cristian
> making a case to toggle these features via sysfs and keep them disabled
> by default [0]
>
> [0] https://lore.kernel.org/lkml/20241017052000.99200-1-cpru@amazon.com/
>
> > when there are plenty of CPUs even
> > within the same cluster/frequency domain.
>
> I'm not aware of any recent EAS specific changes that could have led to
> larger scheduling latencies in the recent times but Tobias had reported
> a similar increase in kworker scheduling latency when EEVDF was first
> introduced in a different context [1]. I'm not sure if he is still
> observing the same behavior on the current upstream but would it be
> possible to check if you can see the large scheduling latency only
> starting with v6.6 (when EEVDF was introduced) and not on v6.5
> (ran with older CFS logic). I'm also assuming the system / benchmark
> does change the default scheduler related debug tunables, some of which
> went away in v6.6

Hmmm... I don't know if this is specific to EEVDF. But going back to
v6.5 has a lot of other hurdles that I don't want to get into.

>
> [1] https://lore.kernel.org/lkml/c7b38bc27cc2c480f0c5383366416455@linux.i=
bm.com/
>
> >
> > Can we tell the scheduler to just spread out all the tasks during
> > suspend/resume? Doesn't make a lot of sense to try and save power
> > during a suspend/resume. It's almost always cheaper/better to do those
> > quickly.
>
> That would increase the resume latency right since each runnable task
> needs to go through a full idle CPU selection cycle? Isn't time a
> consideration / concern in the resume path? Unless we go through the
> slow path, it is very likely we'll end up making the same task
> placement decisions again?

I actually quickly hacked up the cpu_overutilized() function to return
true during suspend/resume and the threads are nicely spread out and
running in parallel. That actually reduces the total of the
dpm_resume*() phases from 90ms to 75ms on my Pixel 6.

Also, this whole email thread started because I'm optimizing the
suspend/resume code to reduce a lot of sleeps/wakeups and the number
of kworker threads. And with that + over utilization hack, resume time
has dropped to 60ms.

Peter,

Would you be open to the scheduler being aware of
dpm_suspend*()/dpm_resume*() phases and triggering the CPU
overutilized behavior during these phases? I know it's a very use case
specific behavior but how often do we NOT want to speed up
suspend/resume? We can make this a CONFIG or a kernel command line
option -- say, fast_suspend or something like that.

Thanks,
Saravana

