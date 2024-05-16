Return-Path: <linux-kernel+bounces-180811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9448C7373
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 652F4B23CD1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 09:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FD9142E98;
	Thu, 16 May 2024 09:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p1CQuLpn"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F06142E75
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 09:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715850345; cv=none; b=EUhOLNpZrfdQZRqWrzK/BcLPbPldLfx6Xxun1wTWKqEmP1MhInD3uEEs9jmxfDsHy+R6RV2085GJkPk0j6pTuitXh6ltdPre8J0cMbM/QwaD/HPJ4ryRnw6eWCabxyNhxCV072VrymHXuhJ4xvNuS5y6sH4BA5AbnxSPLxVSmdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715850345; c=relaxed/simple;
	bh=RHSX2yKsuPqAL+lWO3G5kIbkjnDQKu9dA9oMc8iQu0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVkI/NdAB7HHsa0ylq+ZA4TvQFyXSD6vjLHOFqaN6HnqQjGmKbCcuqxjvJe4av6DGvcPP3lYrm0jLMGJn0EF0O3RJondOAZ58AB7VeVd2NZoEJlalaLDg1khj6AjIPMzrut+wXTKxKyCwIogsAZpAcnjU+56Xg1iDVZ3JQY0IF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p1CQuLpn; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=itjTlUPY9VTCjwdh1TN5R/QTu3m/DiLZSbOLn98mcqY=; b=p1CQuLpnmkX9AmcLKMNgmZamWh
	mXXSnhlzPDEjNSgX4CcYRGKNxwNWZ/Ne3q8+iWjMuIrxlSzBPWzp3ykbsjfN1lh8yFpZ4zKxmXmwi
	U4XypldYBaqZo5eElZdyq5pSQ6cxHl/mrv5kCaAL+KdUAXxHkqDu26Nl0uJiqKmq0jBTqtJY6kCy6
	X0YmRQPYpX+4kdl6IOwqg47Mh3eAIszVcCoUgs228MJLrB2RcyHMmI8wcUUAnFSHVJ7pV1nSwY0rK
	QSpwlXhRnXUuNCpKzKPiz6BZsBum1e+LS7b2XXU8tsVfnh5cUQPLXEiUkw52T8gWU0kUy+vQ7YIpI
	CrpilRJg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7X3K-00000005O4T-0ZTu;
	Thu, 16 May 2024 09:05:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A1C6B30068B; Thu, 16 May 2024 11:05:29 +0200 (CEST)
Date: Thu, 16 May 2024 11:05:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 3/4] perf: Fix event leak upon exit
Message-ID: <20240516090529.GH22557@noisy.programming.kicks-ass.net>
References: <20240515144311.16038-1-frederic@kernel.org>
 <20240515144311.16038-4-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515144311.16038-4-frederic@kernel.org>

On Wed, May 15, 2024 at 04:43:10PM +0200, Frederic Weisbecker wrote:
> When a task is scheduled out, pending sigtrap deliveries are deferred
> to the target task upon resume to userspace via task_work.
> 
> However failures while adding en event's callback to the task_work
> engine are ignored. And since the last call for events exit happen
> after task work is eventually closed, there is a small window during
> which pending sigtrap can be queued though ignored, leaking the event
> refcount addition such as in the following scenario:
> 
>     TASK A
>     -----
> 
>     do_exit()
>        exit_task_work(tsk);
> 
>        <IRQ>
>        perf_event_overflow()
>           event->pending_sigtrap = pending_id;
>           irq_work_queue(&event->pending_irq);
>        </IRQ>
>     =========> PREEMPTION: TASK A -> TASK B
>        event_sched_out()
>           event->pending_sigtrap = 0;
>           atomic_long_inc_not_zero(&event->refcount)
>           // FAILS: task work has exited
>           task_work_add(&event->pending_task)
>        [...]
>        <IRQ WORK>
>        perf_pending_irq()
>           // early return: event->oncpu = -1
>        </IRQ WORK>
>        [...]
>     =========> TASK B -> TASK A
>        perf_event_exit_task(tsk)
>           perf_event_exit_event()
>              free_event()
>                 WARN(atomic_long_cmpxchg(&event->refcount, 1, 0) != 1)
>                 // leak event due to unexpected refcount == 2
> 
> As a result the event is never released while the task exits.

Urgh...

> 
> Fix this with appropriate task_work_add()'s error handling.
> 
> Fixes: 517e6a301f34 ("perf: Fix perf_pending_task() UaF")
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/events/core.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 724e6d7e128f..c1632e69c69d 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2289,10 +2289,11 @@ event_sched_out(struct perf_event *event, struct perf_event_context *ctx)
>  		event->pending_sigtrap = 0;
>  		if (state != PERF_EVENT_STATE_OFF &&
>  		    !event->pending_work) {
> -			event->pending_work = 1;
> -			dec = false;
> -			WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
> -			task_work_add(current, &event->pending_task, TWA_RESUME);
> +			if (task_work_add(current, &event->pending_task, TWA_RESUME) >= 0) {

AFAICT the thing is a return 0 on success -Efoo on fail, no? That is,
should this not simply be '== 0' ?

> +				WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
> +				dec = false;
> +				event->pending_work = 1;
> +			}

Also, do we want to write it like so and save an indent?

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2288,11 +2288,11 @@ event_sched_out(struct perf_event *event
 
 		event->pending_sigtrap = 0;
 		if (state != PERF_EVENT_STATE_OFF &&
-		    !event->pending_work) {
+		    !event->pending_work &&
+		    !task_work_add(current, &event->pending_task, TWA_RESUME)) {
 			event->pending_work = 1;
 			dec = false;
 			WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
-			task_work_add(current, &event->pending_task, TWA_RESUME);
 		}
 		if (dec)
 			local_dec(&event->ctx->nr_pending);

