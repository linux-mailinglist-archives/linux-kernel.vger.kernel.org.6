Return-Path: <linux-kernel+bounces-554563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D571A599F6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC5043A85A2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E8221E0AF;
	Mon, 10 Mar 2025 15:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TtB4G1jz"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBF21A7264
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 15:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741620487; cv=none; b=rxI4wNEgFsU/CfBOTcNUjCduAfRwxrSJpk4hgjMrAXhIliqMgl6W2uvbyPwhO1WiU9VcREI74/wsou9VIu+One+uvBRWy1P3u2G15YTicFZAeMzSIqwyyGNgjTO/WGCj7WHPh3DAis/CGFfq+yp/33m9A7XhNmV+FQqXe4hTEOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741620487; c=relaxed/simple;
	bh=QB4BXhrgmhwE2pe9luH4R39VAllPIRK5zcmkbr2bZJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNao33mmAzhTUA/lxMqw1hd5Wz9AB5YyC1gJS7I9mRFerKxqbN5LvMxv5DjbnyOexCUdwQOkTditSa9cVUgkIuEwtJWVyDb7VByfcyHhI6J6nHs+bDgStHgCbdOss3KEvXrt5XCtuqSNkjjb+liqDWHCV1E/3/bWBt4GKUN0Afw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TtB4G1jz; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aG8VHbqLq93E8+fKSsUWDSUELF8JmypIY7KCRy7+XBo=; b=TtB4G1jzecZGRg6ijMw1uNHC+f
	sQK3tBIGfPhYVusQfuNVjZRLf8nA521OY/pNLiENigcx2rMEuegvf7wwnMt2lnHHvnvY4/whBYtP3
	5rbrbMw56frq/NthxnuMEVzbS6ae//CNL8JaAOJvdzmLvjBHnTIwO3uCSoBe6e+83BSPxiL+p/XFY
	dxmAdloyMzwA2poKUkz0LBUw8pbcNU0rT6D29mGMM8PTZ3oW/HcKm9fLLSgSm0AT4dskoEdIXzRL/
	th4en0Al2hjJNRZeZf3oAETbGcJbUPxU4TGIB3xPURrUlsDSm5Iuu+Uq/K3wdm4t3GyR9U3I2ywkM
	2Lth8iKA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1trf2s-00000001t6c-1L9J;
	Mon, 10 Mar 2025 15:27:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 79DEB300599; Mon, 10 Mar 2025 16:27:56 +0100 (CET)
Date: Mon, 10 Mar 2025 16:27:56 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: mingo@kernel.org, lucas.demarchi@intel.com,
	linux-kernel@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Subject: Re: [PATCH v3 6/7] perf: Rename perf_event_exit_task(.child)
Message-ID: <20250310152756.GC19344@noisy.programming.kicks-ass.net>
References: <20250307193305.486326750@infradead.org>
 <20250307193723.417881572@infradead.org>
 <d8be26ad-763b-4ab0-9f57-cfafad792194@amd.com>
 <20250310144717.GS5880@noisy.programming.kicks-ass.net>
 <bbd7986d-70b4-47e4-a2e4-ed99a1b89239@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbd7986d-70b4-47e4-a2e4-ed99a1b89239@amd.com>

On Mon, Mar 10, 2025 at 08:50:55PM +0530, Ravi Bangoria wrote:
> On 10-Mar-25 8:17 PM, Peter Zijlstra wrote:
> > On Mon, Mar 10, 2025 at 04:38:36PM +0530, Ravi Bangoria wrote:
> >> Hi Peter,
> >>
> >> On 08-Mar-25 1:03 AM, Peter Zijlstra wrote:
> >>> The task passed to perf_event_exit_task() is not a child, it is
> >>> current. Fix this confusing naming, since much of the rest of the code
> >>> also relies on it being current.
> >>>
> >>> Specifically, both exec() and exit() callers use it with current as
> >>> the argument.
> >>
> >> ...
> >>
> >>> -static void perf_event_exit_task_context(struct task_struct *child, bool exit)
> >>> +static void perf_event_exit_task_context(struct task_struct *task, bool exit)
> >>>  {
> >>> -	struct perf_event_context *child_ctx, *clone_ctx = NULL;
> >>> +	struct perf_event_context *ctx, *clone_ctx = NULL;
> >>>  	struct perf_event *child_event, *next;
> >>>  
> >>> -	WARN_ON_ONCE(child != current);
> >>> +	WARN_ON_ONCE(task != current);
> >>
> >> exec() codepath (i.e. copy_process()) passes child pointer, not 'current'.
> > 
> > I am confused, this not a new warning.
> 
> Right, However the WARN was present only in perf_event_exit_task_context()
> before merging it with perf_event_free_task() (patch #5). And
> perf_event_free_task() is getting called for child task.

Argh, yes.

> > Also, copy_process() is clone(), exec() is another code path.
> 
> My bad. I meant clone() code path:
> 
>   copy_process()
>     p = dup_task_struct(current);
>     perf_event_init_task(p);
>       perf_event_free_task(p);
>         perf_event_exit_task_context(p);
>           WARN_ON_ONCE(task != current);
> 
> Another one:
> 
>   copy_process()
>     p = dup_task_struct(current);
>     ...
>     bad_fork_cleanup_perf:
>       perf_event_free_task(p);
>         perf_event_exit_task_context(p);
>           WARN_ON_ONCE(task != current);
> 
> Or am I missing something?

No, the perf_event_free_task() callchain has a problem.

I'll remove that WARN_ON_ONCE() since perf_event_exit_task() has the
same check. I'll do that in the merge patch, not this rename patch.

