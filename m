Return-Path: <linux-kernel+bounces-445716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEE69F1A3B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 00:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 700FE16384F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 23:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBB71E5721;
	Fri, 13 Dec 2024 23:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ilfxwnlr"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DA11B5ED0
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 23:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734133072; cv=none; b=rASqA0eS7ujpE/nrm7/tptr4+tu8KDXdP3RwCGA0QXrvcR6Me3HJ+3dqd96bY2/pK8lpXV22lozABXU3ZQ2m0AiTnP8VhTR3uzlVGH7AhgpBremHO8WsBTINVmY1gEbJzTwdCEMZvsIwrlE5014ahaa4RGWglh2kBkqdA+Na2SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734133072; c=relaxed/simple;
	bh=EYQka2eEcKnLaAZZyxjkEjdgBi4TldqPEy8LhkOLXFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpMedj5dk3q/WQw8kqZhWHa0aJQuwfu1RtmzXk1x/v5082YCnaAhMWRRvN+kioL/tBpupadNi6EG21pDN4jQUzx5dGpPeFAHwiRk4A3g2jKIxZsSAg4cL1OKRw+TmQE8nU9ATIEH0zxsPd0CJJg/F7+YdwashOKnnUfo/4UecOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ilfxwnlr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IETbRn3VqGD/a2y5jqYQQtPGrkqxTZz0g+dvOeb/DjE=; b=ilfxwnlrKOoEcUk0F5V66FkFLd
	q1b7RBsc0SS/zw9aM15DvtDGeEZo+xgbN592GknU4zillS2HQtjbTiCa8jBolPMOOvLsOYq8rUNGA
	lKUT2GF6dQCzNbSJetK1rk6gZ+v9uSerwFpZgC07gprOj9PHyG418RZeYxa7EiFN2XGBPiad/SOIR
	Uqlde514vnqkWlJxKpjbH5W/zW26VwLFGg1MYD9wASjPf+Cx2H8xQoK3tyzxF66cxAi1v+e/QF01K
	mC31gU/zlJMvSzXc4R7lufBRgFHM2vw5w6pVlQtC0z3Fjg6nztctEnthPHofaup8P4Vfqo9uLMZAz
	d8faYPnw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tMFE4-0000000GW8C-3dst;
	Fri, 13 Dec 2024 23:37:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6B7F430049D; Sat, 14 Dec 2024 00:37:40 +0100 (CET)
Date: Sat, 14 Dec 2024 00:37:40 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelaf@google.com>,
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Metin Kaya <Metin.Kaya@arm.com>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com
Subject: Re: [RFC][PATCH v14 3/7] sched: Fix runtime accounting w/ split exec
 & sched contexts
Message-ID: <20241213233740.GB17501@noisy.programming.kicks-ass.net>
References: <20241125195204.2374458-1-jstultz@google.com>
 <20241125195204.2374458-4-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125195204.2374458-4-jstultz@google.com>

On Mon, Nov 25, 2024 at 11:51:57AM -0800, John Stultz wrote:



> -static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
> +static s64 update_curr_se(struct rq *rq, struct sched_entity *se)
>  {
>  	u64 now = rq_clock_task(rq);
>  	s64 delta_exec;
>  
> -	delta_exec = now - curr->exec_start;
> +	delta_exec = now - se->exec_start;
>  	if (unlikely(delta_exec <= 0))
>  		return delta_exec;
>  
> -	curr->exec_start = now;
> -	curr->sum_exec_runtime += delta_exec;
> +	se->exec_start = now;
> +	if (entity_is_task(se)) {
> +		struct task_struct *running = rq->curr;
> +		/*
> +		 * If se is a task, we account the time against the running
> +		 * task, as w/ proxy-exec they may not be the same.
> +		 */
> +		running->se.exec_start = now;
> +		running->se.sum_exec_runtime += delta_exec;
> +	} else {
> +		/* If not task, account the time against se */
> +		se->sum_exec_runtime += delta_exec;
> +	}
>  
>  	if (schedstat_enabled()) {
>  		struct sched_statistics *stats;
>  
> -		stats = __schedstats_from_se(curr);
> +		stats = __schedstats_from_se(se);
>  		__schedstat_set(stats->exec_max,
>  				max(delta_exec, stats->exec_max));
>  	}

Would it not be *much* clearer if we do it like:

static s64 update_curr_se(struct rq *rq, struct sched_entity *donor,
			  struct sched_entity *curr)
{
	...
	donor->exec_start = now;
	curr->exec_start = now;
	curr->sum_exec_runtime += delta_exec;
	...
}

and update the callsites like so:

update_curr_common()
	update_curr_se(rq, &donor->se, &rq->curr.se)

update_curr()
	update_curr_se(rq, &curr->se, &curr->se);


except, now I'm confused about the update_curr() case. That seems to
always update the execution context, rather than the donor ?

