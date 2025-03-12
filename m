Return-Path: <linux-kernel+bounces-557518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12772A5DA50
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 950B23ABA2A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE9123BD09;
	Wed, 12 Mar 2025 10:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TAScYI6y"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C752F1E7C03
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741774622; cv=none; b=jxwImXyuEgswLDIfbKLGFA9gc0HFXfclSnP0Y1FmXxHNx7Tb4XLfwIHX0BmNEN6DAS/z0ZJYaoUiBGvgpT+jFu+1AGM/rBeQN5vjAUYgu0lKMs3zUUQi4HK/tAbTi9OwzpwF9e0Q/kct6Re68QR24ioJk3BEJ3sGKRfXWGgmtIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741774622; c=relaxed/simple;
	bh=Mctx6HJK8lUcA4zMP/2/Ugvzc8u7NE4Q4XHmn0btEF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GE8A7mclHaFqZIn5Yj+VyMXr4tdKA3kvZTzpUld1mCJYj1fOYkDd6UIZFKyrGYmvFuGIQQSjePcryTMA2TnxUKyu92IzD8dIzf8KyZAvxZBgulKalu8gdIr+Y6yKngAj8AcML2IMgk8jiwJdZkb4hSLYzIxKCKHygYo6n+ZBUFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TAScYI6y; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iQm14u3vIWVFyr+TIJc7EsSWgpxdwY6CkflsM34hQds=; b=TAScYI6y+bPdXKPuEr7ASLxcqL
	bMSkETexMzebEsLm7nLnB76BcyOeI5n2kpCpw1kxnRa482lnaI9vJ4tB/ticZis9LCO/MvA7d8Z00
	0AorpUQhXw4+AYAYCx9YIfYGq33Bu8VueZehXjfVk4132nLca9ztflLGGvg+BdlQpXtWGHD2nur1+
	9oP89NWBav15T+TJJ2NkfDdNfrgjIeV7sLlFPoo9F1Q4ZJwhCB4lBesgEwYt7grCxB7YNiBszLFzn
	JCy50mllWz6Z6C+WM9Aqf+s0ZGC0SB38hR2Q20yOcr0iPFPtX4nyd3bpoO3P4yO+rxOKiOQgjY3eQ
	5fTG3Ydw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tsJ8q-0000000ChvF-3mx1;
	Wed, 12 Mar 2025 10:16:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B2434300599; Wed, 12 Mar 2025 11:16:47 +0100 (CET)
Date: Wed, 12 Mar 2025 11:16:47 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: mingo@kernel.org, lucas.demarchi@intel.com,
	linux-kernel@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Subject: Re: [PATCH v3a 6/7] perf: Rename perf_event_exit_task(.child)
Message-ID: <20250312101647.GK19424@noisy.programming.kicks-ass.net>
References: <20250307193305.486326750@infradead.org>
 <20250307193723.417881572@infradead.org>
 <20250310153742.GE19344@noisy.programming.kicks-ass.net>
 <b5a2260f-cedb-4c8c-8435-916d657ee616@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5a2260f-cedb-4c8c-8435-916d657ee616@amd.com>

On Wed, Mar 12, 2025 at 12:01:00PM +0530, Ravi Bangoria wrote:
> Hi Peter,
> 
> > The task passed to perf_event_exit_task() is not a child, it is
> > current. Fix this confusing naming, since much of the rest of the code
> > also relies on it being current.
> > 
> > Specifically, both exec() and exit() callers use it with current as
> > the argument.
> 
> When perf_event_exit_task_context() gets called by perf_event_free_task():
> 
> 1) task_ctx_sched_out(ctx) function should be avoided because the 'ctx'
>    argument is of the (half baked)child task whereas task_ctx_sched_out()
>    expects 'ctx' to be the context of 'current'.
> 2) Similarly, 'task' argument != 'current'.
> 
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -13573,7 +13573,8 @@ static void perf_event_exit_task_context(struct task_struct *task, bool exit)
>  	 * in.
>  	 */
>  	raw_spin_lock_irq(&ctx->lock);
> -	task_ctx_sched_out(ctx, NULL, EVENT_ALL);
> +	if (exit)
> +		task_ctx_sched_out(ctx, NULL, EVENT_ALL);
>  
>  	/*
>  	 * Now that the context is inactive, destroy the task <-> ctx relation
> @@ -13582,7 +13583,7 @@ static void perf_event_exit_task_context(struct task_struct *task, bool exit)
>  	RCU_INIT_POINTER(task->perf_event_ctxp, NULL);
>  	put_ctx(ctx); /* cannot be last */
>  	WRITE_ONCE(ctx->task, TASK_TOMBSTONE);
> -	put_task_struct(current); /* cannot be last */
> +	put_task_struct(task); /* cannot be last */
>  
>  	clone_ctx = unclone_ctx(ctx);
>  	raw_spin_unlock_irq(&ctx->lock);

Right you are. Thanks!

