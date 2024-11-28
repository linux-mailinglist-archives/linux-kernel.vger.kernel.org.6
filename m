Return-Path: <linux-kernel+bounces-424503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF669DB512
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D781328294E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA35156F5F;
	Thu, 28 Nov 2024 09:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XNo+V60N"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A50F157E82
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 09:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732787390; cv=none; b=Td/0smoDVByrm/a55aKhS4vAXjFJyKhYBtq//o/5X22GCYuWR0zu/CS2e616bZegXrCiUce2DL0npNTJiiGY2G8FYw2HYgWZj/EEhdZ8yXhoadwVECawhvuZ11p7VyEzZYbXSyDACrE7sCLi1o2OcXtz66goa1l5TG/s0d5bZUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732787390; c=relaxed/simple;
	bh=uLfZxQqRO4XYYAx1scnfPdA7wE6L5CaiUWSPb/Tcc4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S23FQgdOLrtAV8vogxY3Y4EY/47BdoT6d/AkM+fb5RCiC8wfc32y7fOfkIgiLSmKfHriQDYuSe0H/0j+tWGpkxrCgdA1AKsGiM+lTWjV3uQs+5gUOmdm6iiP5mSmaiab5yikQSAs2KC9k0Xlo6P72pruQeRvarbafPDJWL9umss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XNo+V60N; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sIH2CyXtoHZ5IJly2+L+GGKtuU2wr/C+7yKn+r98Z0A=; b=XNo+V60NKB3Kbpm44sgWvystxA
	mvrTge+gToRxPTYYnDQyzax7z2lsS0EFMt6HKvDbCa43asCrvECZC8kIlHIYRFgWHYJRy/izvyP70
	UNlSMBRYPt8NoCWe9lbi79ZRQAL50w5J1Ot7yMMCxrtzjWRB4BgDZ5uHcuqy3HFZCYOaWVwJCWGtq
	JYXDRTcRWHL5SisxRszhNRV0zigNKPl1rrwAcaVEXBYvID4A9AQjBbyRdXF+EIv+dWaNnC+4Ty7UR
	jsQOe8GZ+iZ3TxsbgLHESlDOUxxCXntYMWFpFBBa2LlN+2vwpOzWC9z4JdqkB5z1ec6aUm9f53S+6
	k5lpVj9g==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGb9T-00000002UGU-41AM;
	Thu, 28 Nov 2024 09:49:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5BA3D300271; Thu, 28 Nov 2024 10:49:36 +0100 (CET)
Date: Thu, 28 Nov 2024 10:49:36 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, pauld@redhat.com, efault@gmx.de,
	luis.machado@arm.com
Subject: Re: [PATCH 7/9] sched/fair: Do not try to migrate delayed dequeue
 task
Message-ID: <20241128094936.GA24400@noisy.programming.kicks-ass.net>
References: <20241128092750.2541735-1-vincent.guittot@linaro.org>
 <20241128092750.2541735-8-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128092750.2541735-8-vincent.guittot@linaro.org>

On Thu, Nov 28, 2024 at 10:27:48AM +0100, Vincent Guittot wrote:
> Migrating a delayed dequeued task doesn't help in balancing the number
> of runnable tasks in the system.

But it can help balance the weight; furthermore, by moving them to a
lighter queue, they'll get picked sooner and disappear sooner.

Perhaps make it: p->se.sched_delayed && !env->sd->nr_balance_failed ?

> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1b4f1b610543..9d80f3a61082 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9405,11 +9405,15 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>  
>  	/*
>  	 * We do not migrate tasks that are:
> -	 * 1) throttled_lb_pair, or
> -	 * 2) cannot be migrated to this CPU due to cpus_ptr, or
> -	 * 3) running (obviously), or
> -	 * 4) are cache-hot on their current CPU.
> +	 * 1) delayed dequeued, or
> +	 * 2) throttled_lb_pair, or
> +	 * 3) cannot be migrated to this CPU due to cpus_ptr, or
> +	 * 4) running (obviously), or
> +	 * 5) are cache-hot on their current CPU.
>  	 */
> +	if (p->se.sched_delayed)
> +		return 0;
> +
>  	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
>  		return 0;
>  
> -- 
> 2.43.0
> 

