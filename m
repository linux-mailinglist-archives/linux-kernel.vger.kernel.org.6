Return-Path: <linux-kernel+bounces-512488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FCCA339E2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D881188C1A1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 08:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2D820C019;
	Thu, 13 Feb 2025 08:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TinJnH/5"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA57D20B7F8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739435138; cv=none; b=M7u3xgNzt3VG8fmcdqnlZtgLAmozECsDuCxgYA285WxmyzwiHf8mCNyJq0v0eXUOjxjg7MrjPD0SHwbSqWtPewJvrtVoXAwT21FerDe3eq3KEkZfO8I+NWTzBmdyW0vMRxC0zNrAA9PhHs8NPIfVYfWFT5KshWKWm6PbtiVh2Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739435138; c=relaxed/simple;
	bh=N0EVqZW2xG1xjn8irKtCMEM09m3YsMuX9+LMWHhi6O0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l5yK97fodqngwOiOuntgKptF7v94kxqtLlVN3C3MbV3bPp/6/txUjZfSKJnXyer+pRS17+MN9ZGRPRfdsC3+2yKVVJg4kfb8DfOls+D6IVqMzMK0XIAtIWQyPMzzym2lm0M1osWHQPOt4tKGBt5jYD+HQOY4gz+meu//JI3sHqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TinJnH/5; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-545075ff6d5so463748e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 00:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739435135; x=1740039935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fA2MLJ7eo6jxw6NfVMjGyAbneqBRDTuKAcQwqvZYyM=;
        b=TinJnH/5Z1ffdkKXhc3UffZGN1eWzCTh3TkT2AFPi7PfsyNpYDP9ldB6jhoMsy9Nz8
         HM6a3DlYEzMastb/rbJmpTHar+YafH554SQYKObBonhoMN0xDTBEeijyrXasvBOZocy/
         FehTuIPvmb7u/eMX407lwBwRnglzclpZSUZOYOaArfg4soASc8FrPFDHCWJe1Gvhsytb
         VEwn9MZn/gpIKNRHtD9SkWABaxTc6eIWPXrbpD5WObafpZPhEL3uu1/76We1wC1x/ebm
         l4NZO6ZoUHrMoEeojoltEocUEREJ0HybUZ3/xC6QKgO1iIArXeIyrGhqQlmlCUhnEwex
         o2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739435135; x=1740039935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fA2MLJ7eo6jxw6NfVMjGyAbneqBRDTuKAcQwqvZYyM=;
        b=mlCm6IO9qtEnj6+vxjwEq/dm5N8Km652WB/c8ePMI6hFT5ba9+Kwd38omVhO4mWFU9
         Z3RcJbX04e8ubcksOuyfFBXPlxths2PVwaURT0NtMffPlG4GT7k1xuhl2WdyjqWKbYaJ
         T5hj9cGWrRhQba9xKjKjkk45QX5YEfmWGk74GPrInzRY5cqxYAxC/2ciV1USpkf7gCQ3
         1lhdnh7QuE+A9g28QOF0pst0isiuGDEoYvq09nxPG+gIMX9ysILApU6lSyhSF6WN0VLP
         IR0MLHFh1BUCGdO1HDAlrzDsvw+PdotNFZ/VKvgtczbUVBDtKcShAViJIJxH1cX4Fwar
         Nb2A==
X-Forwarded-Encrypted: i=1; AJvYcCV5AmtKl0uhO2xMwsrKaLglgHW/RJbwO7AqgdiLhdvqSmQg8B15opTlvzE7O6VUUaqpdRcqzlyRHJS+/Js=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMsVg0caWFMq+/6oVxVa03Uj8snf0xWzAizIrVI+yZ1EnHqFLc
	EeqldL4LDPdDmIbdSzSOBJ7FUHeebCLF7JNAvl5Oy7M99/V3KBToS5REbTRdUc+XmryX/pQnknE
	DPB55pKg3YGZ+Vl1R3ALRAVtyw322kAPe3ZzJy+ICQbz45aIZuw==
X-Gm-Gg: ASbGncvgtgMS+b0EdxTtHxJghIHNKlE/yum7Ba2lWkk59vQCZmXrxfOvPijjioZDyIs
	ScSDmhAhfHpWwKBXXD4o6PGsSAtVQqH7jIrTs7ax+4ENyRHJSeWr8YOVyCSXpLoHttGALHu0=
X-Google-Smtp-Source: AGHT+IHELkkOFB7EQ7GUofx7b8VWWw/fAnqX8CYEBDcdcwMpWCSakf+bhTcjIK2nI+1d7UuTZRovJbepiZ6B3SD7lwI=
X-Received: by 2002:a05:6512:3c8e:b0:545:cc5:be92 with SMTP id
 2adb3069b0e04-54518177174mr2084413e87.33.1739435134430; Thu, 13 Feb 2025
 00:25:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210001915.123424-1-qyousef@layalina.io>
In-Reply-To: <20250210001915.123424-1-qyousef@layalina.io>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 13 Feb 2025 00:24:58 -0800
X-Gm-Features: AWEUYZnwXI5Xs-I4iJ7LqN3OVbCLJxKFHc5ZhdZo6ySGEBwwB0KkH9BtDxlAZpQ
Message-ID: <CAGETcx9T-Fz-AN0GgOCmT+xZ3JMehmz-cDf5wEm7a1QuBHWUxA@mail.gmail.com>
Subject: Re: [PATCH] Kconfig.hz: Change default HZ to 1000
To: Qais Yousef <qyousef@layalina.io>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	John Stultz <jstultz@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Frederic Weisbecker <frederic@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 9, 2025 at 4:19=E2=80=AFPM Qais Yousef <qyousef@layalina.io> wr=
ote:
>
> The frequency at which TICK happens is very important from scheduler
> perspective. There's a responsiveness trade-of that for interactive
> systems the current default is set too low.
>
> Having a slow TICK frequency can lead to the following shortcomings in
> scheduler decisions:
>
> 1. Imprecise time slice
> -----------------------
>
> Preemption checks occur when a new task wakes up, on return from
> interrupt or at TICK. If we have N tasks running on the same CPU then as
> a worst case scenario these tasks will time slice every TICK regardless
> of their actual slice size.
>
> By default base_slice ends up being 3ms on many systems. But due to TICK
> being 4ms by default, tasks will end up slicing every 4ms instead in
> busy scenarios.  It also makes the effectiveness of reducing the
> base_slice to a lower value like 2ms or 1ms pointless. It will allow new
> waking tasks to preempt sooner.  But it will prevent timely cycling of
> tasks in busy scenarios. Which is an important and frequent scenario.
>
> 2. Delayed load_balance()
> -------------------------
>
> Scheduler task placement decision at wake up can easily become stale as
> more tasks wake up. load_balance() is the correction point to ensure the
> system is loaded optimally. And in the case of HMP systems tasks are
> migrated to a bigger CPU to meet their compute demand.
>
> Newidle balance can help alleviate the problem. But the worst case
> scenario is for the TICK to trigger the load_balance().
>
> 3. Delayed stats update
> -----------------------
>
> And subsequently delayed cpufreq updates and misfit detection (the need
> to move a task from little CPU to a big CPU in HMP systems).
>
> When a task is busy then as a worst case scenario the util signal will
> update every TICK. Since util signal is the main driver for our
> preferred governor - schedutil - and what drives EAS to decide if
> a task fits a CPU or needs to migrate to a bigger CPU, these delays can
> be detrimental to system responsiveness.
>
> ------------------------------------------------------------------------
>
> Note that the worst case scenario is an important and defining
> characteristic for interactive systems. It's all about the P90 and P95.
> Responsiveness IMHO is no longer a characteristic of a desktop system.
> Modern hardware and workloads are interactive generally and need better
> latencies. To my knowledge even servers run mixed workloads and serve
> a lot of users interactively.
>
> On Android and Desktop systems etc 120Hz is a common screen
> configuration. This gives tasks 8ms deadline to do their work. 4ms is
> half this time which makes the burden on making very correct decision at
> wake up stressed more than necessary. And it makes utilizing the system
> effectively to maintain best perf/watt harder. As an example [1] tries
> to fix our definition of DVFS headroom to be a function of TICK as it
> defines our worst case scenario of updating stats. The larger TICK means
> we have to be overly aggressive in going into higher frequencies if we
> want to ensure perf is not impacted. But if the task didn't consume all
> of its slice, we lost an opportunity to use a lower frequency and save
> power. Lower TICK value allows us to be smarter about our resource
> allocation to balance perf and power.
>
> Generally workloads working with ever smaller deadlines is not unique to
> UI pipeline. Everything is expected to finish work sooner and be more
> responsive.
>
> I believe HZ_250 was the default as a trade-off for battery power
> devices that might not be happy with frequent TICKS potentially draining
> the battery unnecessarily. But to my understanding the current state of
> NOHZ should be good enough to alleviate these concerns. And recent
> addition of RCU_LAZY further helps with keeping TICK quite in idle
> scenarios.
>
> As pointed out to me by Saravana though, the longer TICK did indirectly
> help with timer coalescing which means it could hide issues with
> drivers/tasks asking for frequent timers preventing entry to deeper idle
> states (4ms is a high value to allow entry to deeper idle state for many
> systems). But one can argue this is a problem with these drivers/tasks.
> And if the coalescing behavior is desired we can make it intentional
> rather than accidental.
>
> The faster TICK might still result in higher power, but not due to TICK
> activities. The system is more responsive (as intended) and it is
> expected the residencies in higher freqs would be higher as they were
> accidentally being stuck at lower freqs. The series in [1] attempts to
> improve scheduler handling of responsiveness and give users/apps a way
> to better provide their needs, including opting out of getting adequate
> response (rampup_multiplier being 0 in the mentioned series).
>
> Since the default behavior might end up on many unwary users, ensure it
> matches what modern systems and workloads expect given that our NOHZ has
> moved a long way to keep TICKS tamed in idle scenarios.
>
> [1] https://lore.kernel.org/lkml/20240820163512.1096301-6-qyousef@layalin=
a.io/
>
> Signed-off-by: Qais Yousef <qyousef@layalina.io>
> ---
>  kernel/Kconfig.hz | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/Kconfig.hz b/kernel/Kconfig.hz
> index 38ef6d06888e..c742c9298af3 100644
> --- a/kernel/Kconfig.hz
> +++ b/kernel/Kconfig.hz
> @@ -5,7 +5,7 @@
>
>  choice
>         prompt "Timer frequency"
> -       default HZ_250
> +       default HZ_1000

This is going to mess up power for tons of IOT and low power devices.
I think we should leave the default alone and set the config in the
device specific defconfig. Even on Android, for some use cases, this
causes ~7% CPU power increase. This also causes more CPU wakeups
because jiffy based timers that are set for t + 1ms, t + 2ms, t+ 3ms,
t + 4ms would all get grouped into a t + 4ms HZ wakeup, but with 1000
HZ timer, it'd cause 4 separate wakeups.

I'd like to Nack this.

-Saravana

>         help
>          Allows the configuration of the timer frequency. It is customary
>          to have the timer interrupt run at 1000 Hz but 100 Hz may be mor=
e
> --
> 2.34.1
>

