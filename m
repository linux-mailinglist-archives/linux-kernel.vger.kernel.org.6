Return-Path: <linux-kernel+bounces-180856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A94F8C73FA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3477828569C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 09:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABD4143757;
	Thu, 16 May 2024 09:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pF3TRSGx"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130F14206C
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715852509; cv=none; b=XcToUbTfcRECv2CDOnIk5vSAp2uPbp8wQjbQEupXtTWsaTrv6OR9FLMFfW0N6b0HKfhV+nJAWZMvu5LQTwT11IfN/Z1v01r9CAqeOv7L05fnxG54RJdzALN6JKb4oYPWzp4YlxWQH/8wicTOiLOOZihocSAeabsd4PUZh6B8P10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715852509; c=relaxed/simple;
	bh=F1O5jiNGFR1SlNv6rgREly1cwT1VCOaVYJdgntR/vbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4xdq3wWaPgvelvBHVOequdhkXGmsW/YufNJ36QpRkN6x+LVR3p7dCbqlVZ6/BCkd4jFND52Q2rogdORd8n6w9QcQqc5SaPx/Y0hSy3ACXR2giTRNSxRtq9HqvT15Re3JTjPZooHbOYQBsP8saIiQja8DiaDvyxQTsWhtguS1qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pF3TRSGx; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=08Rr6n2VlDN7qZVvcsrOzC5KTt4BIlFK/ML4Imtd0gM=; b=pF3TRSGx81dvl5N+YijK7fWZNk
	gjTe+/wRjN/9/yRTCsxtA+JV7VdiI63YYOIGlQv8uUTnSUogy5Og+c6nEsrN8Cw1RHqltzcp0AgJl
	8Xm1qIEI0ovdGIBKcKwt2TH5A/Wtpue6mPGjb7HolzYbsF5m2a96Brq8l3z4MldHzAjerFWck8s3T
	EflMF7lov07KQh10UaZnpDk3XmWFDKleFQotbDiHKHQoSAjMMIx44RRZXuS8tJwVgdV8xzyRpx8w5
	iS1U6LOLiQFPX9DNjTBAgKVIJihSpvTH/vEj5zxq1bqywjIjlbLNWhlD4EzCpQll/RjZslybCe6/X
	4NIBygww==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7XcI-00000005OP2-0EdO;
	Thu, 16 May 2024 09:41:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A343C30068B; Thu, 16 May 2024 11:41:37 +0200 (CEST)
Date: Thu, 16 May 2024 11:41:37 +0200
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
Subject: Re: [PATCH 4/4] perf: Fix event leak upon exec and file release
Message-ID: <20240516094137.GI22557@noisy.programming.kicks-ass.net>
References: <20240515144311.16038-1-frederic@kernel.org>
 <20240515144311.16038-5-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515144311.16038-5-frederic@kernel.org>

On Wed, May 15, 2024 at 04:43:11PM +0200, Frederic Weisbecker wrote:
> The perf pending task work is never waited upon the matching event
> release. In the case of a child event, released via free_event()
> directly, this can potentially result in a leaked event, such as in the
> following scenario that doesn't even require a weak IRQ work
> implementation to trigger:
> 
> schedule()
>    prepare_task_switch()
> =======> <NMI>
>       perf_event_overflow()
>          event->pending_sigtrap = ...
>          irq_work_queue(&event->pending_irq)
> <======= </NMI>
>       perf_event_task_sched_out()
>           event_sched_out()
>               event->pending_sigtrap = 0;
>               atomic_long_inc_not_zero(&event->refcount)
>               task_work_add(&event->pending_task)
>    finish_lock_switch()
> =======> <IRQ>
>    perf_pending_irq()
>       //do nothing, rely on pending task work
> <======= </IRQ>
> 
> begin_new_exec()
>    perf_event_exit_task()
>       perf_event_exit_event()
>          // If is child event
>          free_event()
>             WARN(atomic_long_cmpxchg(&event->refcount, 1, 0) != 1)
>             // event is leaked
> 
> Similar scenarios can also happen with perf_event_remove_on_exec() or
> simply against concurrent perf_event_release().
> 
> Fix this with synchonizing against the possibly remaining pending task
> work while freeing the event, just like is done with remaining pending
> IRQ work. This means that the pending task callback neither need nor
> should hold a reference to the event, preventing it from ever beeing
> freed.
> 
> Fixes: 517e6a301f34 ("perf: Fix perf_pending_task() UaF")
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Yeah, I suppose this'll do. Thanks!

