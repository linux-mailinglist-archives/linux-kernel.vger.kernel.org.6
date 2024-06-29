Return-Path: <linux-kernel+bounces-234940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B0891CD0A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 15:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36ED7283786
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 13:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451617F48C;
	Sat, 29 Jun 2024 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bwlJbaIQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C0B7BB0A
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 13:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719666877; cv=none; b=ra23L2ZM4r2YNMYwaAjCCgd0WWizI4LFdn7g6t5gDCt817eFTDJAdBDAm+bYyF3GdO/9H/Jcn4Tom8gHoaSPzLERnqJtCnwrhfqS8OHl7DqzHK6YLpSengjwZyESPGZvUIDgH7KzAby+0+kPP9lGhy1l2NYWIHUd3A9wlBqlZVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719666877; c=relaxed/simple;
	bh=7hQNt+tgzDNyfI0ERdM6ItE7zkfdbY+XR2lT9HnNWQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZiBghpyJDwlZRXr0nyzACJh52lppu2eTKuW/YbuZTi/ghF9jwFyvhaCVaCcySiSIEjzsbGYqab7hG0TjgZY5OcqwlFQIlZQhqrQNTfHyiGEdJkEhojoHiFKQ/FGfl4+9ZwsSie/dYtqErj8ZSH/pFjBl1HlUBl4QRYsjCci3kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bwlJbaIQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719666874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hVE+qq0FwSaAl4lhPG6AnVt6VIFtlGrvH7aPKz8kJo8=;
	b=bwlJbaIQLZP5kXV+ok1l8+DM2m4WfgHi18XnINGi7qfuOoQAevhsekEdEbJoPk21XF/mv6
	8TJ2vXbFTir4r7b3LD6OF1pg0Q+mZApwZg+cEdfL6mffWV7hi1Xe8ycFWnPR5/Arf0Y9Lv
	POA527nK+rHKbTlsWQNy700cEul+0lM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-76R4QKeIOdmQdyaoaLZSWg-1; Sat,
 29 Jun 2024 09:14:28 -0400
X-MC-Unique: 76R4QKeIOdmQdyaoaLZSWg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE1DE19560AA;
	Sat, 29 Jun 2024 13:14:26 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.33])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id CE98B3000218;
	Sat, 29 Jun 2024 13:14:22 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 29 Jun 2024 15:12:52 +0200 (CEST)
Date: Sat, 29 Jun 2024 15:12:47 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, mhocko@suse.com, brauner@kernel.org,
	tandersen@netflix.com, bigeasy@linutronix.de,
	vincent.whitchurch@axis.com, ardb@kernel.org,
	linux-kernel@vger.kernel.org, Martin Liu <liumartin@google.com>,
	Minchan Kim <minchan@google.com>
Subject: Re: [PATCH 1/1] signal: on exit skip waiting for an ack from the
 tracer if it is frozen
Message-ID: <20240629131247.GA6138@redhat.com>
References: <20240628173247.3507846-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628173247.3507846-1-surenb@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Oh, PTRACE_EVENT_EXIT again. I can't even recall how many times
I mentioned it is broken by design but any possible change is user
visible...

But I don't really understand this patch.

On 06/28, Suren Baghdasaryan wrote:
>
> When a process is being killed or exiting and it has a tracer, it will
> notify the tracer and wait for an ack from the tracer to proceed. However
> if the tracer is frozen, this ack will not arrive until the tracer gets
> thawed. This poses a problem especially during memory pressure because
> resources of the process are not released.

Yes. But how does this differ from situation when the tracer is not
frozen but just sleeps? Or it is traced too and its tracer is frozen?

> Things become even more interesting if OOM killer picks such tracee
> and adds it into oom_victims. oom_victims counter will get incremented
> and stay that way until tracee exits. In the meantime, if the system
> tries to go into suspend, it will call oom_killer_disable() after
> freezing all processes.

Confused... suspend doesn't use cgroup_freeze/etc, so it seems your
patch should check frozen() rather than cgroup_task_frozen() ?
And what if try_to_freeze_tasks() does freeze_task(tracee->parent)
right after the check in ptrace_stop() below?


I think it would better to simply change ptrace_stop() to check TIF_MEMDIE
along with __fatal_signal_pending() and return in this case.

Although TIF_MEMDIE is per-thread... perhaps signal->oom_mm != NULL?

Michal, what do you think?

Of course, this won't fix all problems.

Oleg.

> That call will fail due to positive oom_victims,
> but not until freeze_timeout_msecs passes. For the whole duration of the
> freeze_timeout_msecs (20sec by default) the system will appear
> unresponsive.
> To fix this problem, skip the ack waiting step in the tracee when it's
> exiting and the tracer is frozen. Per ptrace(2) manual, the tracer
> cannot assume that the ptrace-stopped tracee exists. Therefore this
> change does not break any valid assumptions.
> 
> Debugged-by: Martin Liu <liumartin@google.com>
> Debugged-by: Minchan Kim <minchan@google.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  kernel/signal.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 1f9dd41c04be..dd9c18fdaaa5 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2320,6 +2320,19 @@ static int ptrace_stop(int exit_code, int why, unsigned long message,
>  	if (gstop_done && (!current->ptrace || ptrace_reparented(current)))
>  		do_notify_parent_cldstop(current, false, why);
>  
> +	/*
> +	 * If tracer is frozen, it won't ack until it gets unfrozen and if the
> +	 * tracee is exiting this means its resources do not get freed until
> +	 * the tracer is thawed. Skip waiting for the tracer. Per ptrace(2)
> +	 * manual, the tracer cannot assume that the ptrace-stopped tracee
> +	 * exists, so exiting now should not be an issue.
> +	 */
> +	if (current->ptrace && (exit_code >> 8) == PTRACE_EVENT_EXIT &&
> +	    cgroup_task_frozen(current->parent)) {
> +		read_unlock(&tasklist_lock);
> +		goto skip_wait;
> +	}
> +
>  	/*
>  	 * The previous do_notify_parent_cldstop() invocation woke ptracer.
>  	 * One a PREEMPTION kernel this can result in preemption requirement
> @@ -2356,6 +2369,7 @@ static int ptrace_stop(int exit_code, int why, unsigned long message,
>  	schedule();
>  	cgroup_leave_frozen(true);
>  
> +skip_wait:
>  	/*
>  	 * We are back.  Now reacquire the siglock before touching
>  	 * last_siginfo, so that we are sure to have synchronized with
> 
> base-commit: 6c0483dbfe7223f2b8390e3d5fe942629d3317b7
> -- 
> 2.45.2.803.g4e1b14247a-goog
> 


