Return-Path: <linux-kernel+bounces-564676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B79A65945
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BF023B1996
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D531AA1EC;
	Mon, 17 Mar 2025 16:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B81rAcb9"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066441FECD1
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230196; cv=none; b=GOqJhwI3hzzLoDBxJu3dHV5LreYeAdyt2MS3w75n+zPgkk1OlIKYb36rwb2y3CkKi2gzNxZPQWH7D1859mIMejyCa7Ujjducu7FtPinyjut7k/ZJaAIDoqNqxAxxfCEeBmMpw5/FWm+La1ZXFk1yYUzJgZRfwopWSDvXncq79IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230196; c=relaxed/simple;
	bh=2YZgFp1/CjqO9CyAyOqhR/ALYzAt6/6UG/3EMeKc0oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tz/X6tYCIF6Hj/stM4tNaYdrD8mqbbBGY0A3Mk8a9ZjrCelUajEtdHZqVrmbX9LbzwJUc5AldatGkEGUZSfl31RpPC/aseXM8WEv1i9axkwEjP+tlLpVL1C5hA9zoREsZpX1+AambRf1+RQUJC3T6iXp5QIZnu3fR3667ePK3+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B81rAcb9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zElYbGpRV7mHuX9xVyn93ZKiwR+B5ETCWjUfLrDsdxA=; b=B81rAcb9Mv2oYWaUGe7U9Uru4d
	3leOL+xaFU0OYGTfrVZzxpInNgjP9EYEy0RB/FcG3qZ7nqsy8aj2kaReYZ0I8W+2i/z7OJl3MItCD
	pmN56rbQLPTmMkvgk9E+2EruG9ekg19Iz26SAWf2/zw5q4Tm5+tXoYJIfZXb48GmZU0bwCplfIXMB
	WylKotWKVyl4y0p3mcryYvJQ++hMlQXhHYScRk2I9gFQJIAN7I+YwvqgVYzxUU7XldAgHiH2LKig8
	7T5Ef9BeD7e4/14iNNbXEvNhufSugOLX3Jown6L7xklh2GpYpWzXEvzpqlnKMhgDsahNSrNFuJSk1
	G+Zv8UpA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tuDet-00000009822-45sg;
	Mon, 17 Mar 2025 16:49:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 77EF6300783; Mon, 17 Mar 2025 17:49:47 +0100 (CET)
Date: Mon, 17 Mar 2025 17:49:47 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
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
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Suleiman Souhlal <suleiman@google.com>, kernel-team@android.com,
	Valentin Schneider <valentin.schneider@arm.com>,
	Connor O'Brien <connoro@google.com>
Subject: Re: [RFC PATCH v15 7/7] sched: Start blocked_on chain processing in
 find_proxy_task()
Message-ID: <20250317164947.GD6888@noisy.programming.kicks-ass.net>
References: <20250312221147.1865364-1-jstultz@google.com>
 <20250312221147.1865364-8-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312221147.1865364-8-jstultz@google.com>

On Wed, Mar 12, 2025 at 03:11:37PM -0700, John Stultz wrote:

> @@ -2950,8 +2951,15 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
>  	struct set_affinity_pending my_pending = { }, *pending = NULL;
>  	bool stop_pending, complete = false;
>  
> -	/* Can the task run on the task's current CPU? If so, we're done */
> -	if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask)) {
> +	/*
> +	 * Can the task run on the task's current CPU? If so, we're done
> +	 *
> +	 * We are also done if the task is the current donor, boosting a lock-
> +	 * holding proxy, (and potentially has been migrated outside its
> +	 * current or previous affinity mask)
> +	 */
> +	if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask) ||
> +	    (task_current_donor(rq, p) && !task_current(rq, p))) {
>  		struct task_struct *push_task = NULL;
>  
>  		if ((flags & SCA_MIGRATE_ENABLE) &&

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f8ad3a44b3771..091f1a01b3327 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9385,6 +9385,7 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>  	 * 3) cannot be migrated to this CPU due to cpus_ptr, or
>  	 * 4) running (obviously), or
>  	 * 5) are cache-hot on their current CPU.
> +	 * 6) are blocked on mutexes (if SCHED_PROXY_EXEC is enabled)
>  	 */
>  	if ((p->se.sched_delayed) && (env->migration_type != migrate_load))
>  		return 0;
> @@ -9406,6 +9407,9 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>  	if (kthread_is_per_cpu(p))
>  		return 0;
>  
> +	if (task_is_blocked(p))
> +		return 0;
> +
>  	if (!cpumask_test_cpu(env->dst_cpu, p->cpus_ptr)) {
>  		int cpu;
>  
> @@ -9442,7 +9446,8 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>  	/* Record that we found at least one task that could run on dst_cpu */
>  	env->flags &= ~LBF_ALL_PINNED;
>  
> -	if (task_on_cpu(env->src_rq, p)) {
> +	if (task_on_cpu(env->src_rq, p) ||
> +	    task_current_donor(env->src_rq, p)) {
>  		schedstat_inc(p->stats.nr_failed_migrations_running);
>  		return 0;
>  	}


Somehow this and the previous patches that touched upon this made me
think that perhaps we can share with migrate_disable(). Specifically, we
seem to be adding those donor checks and hooks to exactly those
locations.

I've not actually tried though.

