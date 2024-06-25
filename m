Return-Path: <linux-kernel+bounces-228970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 452A9916937
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B87681F22AC1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC4F15FCE9;
	Tue, 25 Jun 2024 13:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I+A5AlIg"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E8215ECD4
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 13:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719323017; cv=none; b=qY7yLXMUj82fLGetjk5sQ8hsCZYe0wYmN59i/XtAkgqFlVnWhu0en3RxJTCtsbpBRl25ytlfCLsQNHyiYiNCE3bNxyke77Ie7kQZBK3PAjgDFpV5NgLtRL0wy/Z1WfqCVVEHPq2KzZp/CyIp3INLrMAoYovCjgJiDI71MdrVqQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719323017; c=relaxed/simple;
	bh=8kGTS4HVT8KpR/eO601IHXpA2FvItFD8t5X6wz4AxBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sXtpjI2vCTEx6pqGCfszcu+vohoc/g6o5fPPyhFTRTVk09su56xl4Pc8J9hjBsn3fNeBYVKvrs3iHqnfQtszqZGPnbP4hCNinjNYi5nX9qB78g5B3zMywIAZe31smYzUzgMz1CFgEhujuFT+1am5sj8d3l3DBY7x0WCTeo5xr+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I+A5AlIg; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-48f4b637d9eso1069061137.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 06:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719323015; x=1719927815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+WevDy/zbmH6/gNWgICGHdme8Bw7y7CeAZkS+a1N+I=;
        b=I+A5AlIg4QMe89zjakL4DoBKOISR/3jE9FolHRi+GYQHGx8xOG2pQ3Vgv8RfBs6iVe
         Vw/Xw3ejgqXfTf7+naiqo3ir/C2zod34q2FR9w3JIMfbHj/GkPrKb40zllvQt4ClYhJ/
         DU1aDJxBxK90KdHVwbKYOCndkSOobs0GGwuy0stPLnuVVAiZPkBgMPAO2twspEmVCJFC
         UsGhd03zk+u35GUd9oI+mYP3a1yy7bD9fui3M2PNmqsDifhljB33Gk4VjAKdrG4qKvn2
         IMS7LwIrZH5EjKR21f6ABFGORUK/B7q+2nXXxlcC6NWTSGandIcUotlO7GeRVaew4kbc
         6ppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719323015; x=1719927815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+WevDy/zbmH6/gNWgICGHdme8Bw7y7CeAZkS+a1N+I=;
        b=ioraWZjTT/Onja/8SCtcehI9ve0c7GAgwNDxIRScR2r7q2pKkKuG+q1Oe54Jr1n+Ho
         UQ0DllC8z+2zXOR4i2uPuiguC2STnmvFThpDT7oPoEi2AuZB3/x3tiB7XxE8WeljFjaq
         wRGkN5xpk3RJlv19owQjzGeME9teh+P+t8jBrxHMh0xB0HP4Ez2mv8EtOxJ1NQPUL3m5
         dc84WeVRO1YyNqtUgLowqcpwdt4fTxujt9DcMwxpoB93WvebHTOlbBKOmy9zqwY0GKNE
         nVCa8+2DZ55jABHUiCPNwZ466mVqaJvFjYVNbPf//mNpxohLwIKaXDzq7e+iMS3p/Z8x
         jkqw==
X-Forwarded-Encrypted: i=1; AJvYcCUe8JMgPeI8DHCFjCSiM8g9DWBMSflVqPbjkJ3ygj1rvSBEz54v5jkUT/ngjr2/po4Bb8oU9sxeEkupI7MElBxglgk2OYS+gAK+M47d
X-Gm-Message-State: AOJu0Yw4S3hsTPvkZ4rbfk+7KDVBiE6WqxIGef+4sJNWvx+JSSXwDhM8
	D59ze15FcqVf9qMEu20ibkbOXIYdEp6vczvrPO2qjru8nBk6Yj1U+kgoUIO4GKPJJOibwhcxmSF
	cYzUws4szs7Ud2Jlm2iYqiagb4iYi4PcL0YGK
X-Google-Smtp-Source: AGHT+IFWEAS2SBcf9yuEn3swxZTPFQNVF8VlquVOGiWY6zTmxPMkkM+98oeIg2tZ2xQ3whJci6IkmR9GFjctp8UESzQ=
X-Received: by 2002:a05:6102:5fc:b0:48f:147f:c022 with SMTP id
 ada2fe7eead31-48f4ef4c9a6mr7045582137.4.1719323014575; Tue, 25 Jun 2024
 06:43:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624152732.1231678-1-bigeasy@linutronix.de>
In-Reply-To: <20240624152732.1231678-1-bigeasy@linutronix.de>
From: Marco Elver <elver@google.com>
Date: Tue, 25 Jun 2024 15:42:56 +0200
Message-ID: <CANpmjNOGpeogkZrGoF82MVEK4NYHFqn7V_kTU_1z3jQhaq5iWw@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] perf: Make SIGTRAP and __perf_pending_irq() work
 on RT.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel Bristot de Oliveira <bristot@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 24 Jun 2024 at 17:27, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> Hi,
>
> Arnaldo reported that "perf test sigtrap" fails on PREEMPT_RT. Sending
> the signal gets delayed until event_sched_out() which then uses
> task_work_add() for its delivery. This breaks on PREEMPT_RT because the
> signal is delivered with disabled preemption.
>
> While looking at this, I also stumbled upon __perf_pending_irq() which
> requires disabled interrupts but this is not the case on PREEMPT_RT.
>
> This series aim to address both issues while not introducing a new issue
> at the same time ;)
> Any testing is appreciated.

Tested-by: Marco Elver <elver@google.com>

Ran lots of concurrent copies of the "sigtrap_threads" and
"remove_on_exec" tests (with lockdep on), and it all survived. Fuzzer
is still running but hasn't found anything relevant yet.


> v3=E2=80=A6v4: https://lore.kernel.org/all/20240322065208.60456-1-bigeasy=
@linutronix.de/
>    - Rebased on top of Frederic's series
>       (https://lore.kernel.org/all/20240621091601.18227-1-frederic@kernel=
.org)
>    - Frederick pointed out that perf_pending_task() needs to
>      perf_swevent_get_recursion_context() in order not to recurse if
>      something within perf_swevent_.*_recursion_context() triggers a
>      software event. To address this, the counters have been moved to
>      the task_struct (#3 + #4) and preemt_disable() has been replaced
>      with a RCU-read lock (#5).
>    - The remaning logic same that means the event is pushed to task-work
>      instead of delivering from IRQ-work. The series was tested with
>      remove_on_exec as suggested by Marco Elver: On PREEMPT_RT a single
>      invocation passes, 100 parallel invocations report (for some)
>      unexpected SIGTRAPs and timeouts. This also observed on !RT
>      (without the series) with a higher task-count.
>
> v2=E2=80=A6v3: https://lore.kernel.org/all/20240312180814.3373778-1-bigea=
sy@linutronix.de/
>     - Marco suggested to add a few comments
>       - Added a comment to __perf_event_overflow() to explain why irq_wor=
k
>         is raised in the in_nmi() case.
>       - Added a comment to perf_event_exit_event() to explain why the
>         pending event is deleted.
>
> v1=E2=80=A6v2: https://lore.kernel.org/all/20240308175810.2894694-1-bigea=
sy@linutronix.de/
>     - Marco pointed me to the testsuite that showed two problems:
>       - Delayed task_work from NMI / missing events.
>         Fixed by triggering dummy irq_work to enforce an interrupt for
>         the exit-to-userland path which checks task_work
>       - Increased ref-count on clean up/ during exec.
>         Mostly addressed by the former change. There is still a window
>         if the NMI occurs during execve(). This is addressed by removing
>         the task_work before free_event().
>       The testsuite (remove_on_exec) fails sometimes if the event/
>       SIGTRAP is sent before the sighandler is installed.
>
> Sebastian
>

