Return-Path: <linux-kernel+bounces-576742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E35AA713DC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACE8D18883E1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4631624E5;
	Wed, 26 Mar 2025 09:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h+Sj0hvG"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF2E1ACED5
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742981936; cv=none; b=Y425tQRwHQoNG3nlUXDEuN7PH85Dx2Y1YQKCM67tc4nyGqNZ916sozsHv2dLc6Bv9z6zVVR+QzVwJf3mb7rJi/SNdrpQqf2R3TfMg+WUQd+Un2WqliKwaTf6lqm+882i3/SmZ4Ph4CzxdYuLf/qCDTnu7EVtwU7Xhhx+z6RZoV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742981936; c=relaxed/simple;
	bh=4LXRlbnuuDZLdMndfdcCH6fUiIvF12mtNGW3sm9sfaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9vhGplZFjtMkaSZ5mQwwABFFK+WG4j5+mymSPJV95sqAB56lHSlMHqoBczQS+DB3jYhEaxYVT6QT7wYWFfPf4pNfJTy+MDoBfGoLVyM64q/S6JPvPotNiFwxJfJnCbIbp5oPNWj9AnT6yUjilkw3Za8ZVrODL61jzKUpwzf+LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h+Sj0hvG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eNv9mMIh5gRZ49sudkh3oNDYG55yOzH3foD73Ycykj4=; b=h+Sj0hvGbM2aHd479JbUuf3fzF
	KhmpbyVQngwZStdWu2zRLbP3kqPQIyIMGNs2zS6p7w489h2yr2W6ZpHiZKdk8QrVforpBlnywiXHm
	uGOcLSYDQ8S1xUqx0IujV8gHz8V3qCuolrdNAzoPftIg1m4+xaIv9xvH3kVFhjZuwmqN9TiDmwNJF
	YD4xBBa7oI5aJ+jep40AGbKmgLveLSJ34cNp1qeuR6+eevXNB32BAmMuljHz5YJHNlX0IMXt2rj+J
	cWlta4y88apCPjiO3DeJU5aft1sh6C0Vj7IB7X9cxfB7doiv85nQrp+5LOPaY6/eycmhCOmigeyyk
	rGyD5oAQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txNDd-0000000HKa3-2jW5;
	Wed, 26 Mar 2025 09:38:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 286EA3004AF; Wed, 26 Mar 2025 10:38:41 +0100 (CET)
Date: Wed, 26 Mar 2025 10:38:41 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	tim.c.chen@linux.intel.com, tglx@linutronix.de, len.brown@intel.com,
	gautham.shenoy@amd.com, mingo@kernel.org, kprateek.nayak@amd.com,
	yu.chen.surf@foxmail.com
Subject: Re: [RFC][PATCH] sched: Cache aware load-balancing
Message-ID: <20250326093841.GC25239@noisy.programming.kicks-ass.net>
References: <20250325120952.GJ36322@noisy.programming.kicks-ass.net>
 <4cd8ba54-8b9e-4563-8fbc-1d6cd6699e81@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cd8ba54-8b9e-4563-8fbc-1d6cd6699e81@intel.com>

On Tue, Mar 25, 2025 at 11:19:52PM +0800, Chen, Yu C wrote:

> > +static void task_tick_cache(struct rq *rq, struct task_struct *p)
> > +{
> > +	struct callback_head *work = &p->cache_work;
> > +	struct mm_struct *mm = p->mm;
> > +
> > +	if (!mm || !mm->pcpu_sched)
> > +		return;
> > +
> > +	if (mm->mm_sched_epoch == rq->cpu_epoch)
> > +		return;
> > +
> 
> [1]
> 
> > +	guard(raw_spinlock)(&mm->mm_sched_lock);
> > +
> > +	if (mm->mm_sched_epoch == rq->cpu_epoch)
> > +		return;
> 
> Remove above duplicated [1] and keep the check here?

Why? That just adds locking overhead for no reason.

> > +
> > +	if (work->next == work) {
> > +		task_work_add(p, work, TWA_RESUME);
> > +		WRITE_ONCE(mm->mm_sched_epoch, rq->cpu_epoch);
> > +	}
> > +}
> > +
> > +static void task_cache_work(struct callback_head *work)
> > +{
> > +	struct task_struct *p = current;
> > +	struct mm_struct *mm = p->mm;
> > +	unsigned long m_a_occ = 0;
> > +	int cpu, m_a_cpu = -1;
> > +	cpumask_var_t cpus;
> > +
> > +	WARN_ON_ONCE(work != &p->cache_work);
> > +
> > +	work->next = work;
> > +
> > +	if (p->flags & PF_EXITING)
> > +		return;
> > +
> > +	if (!alloc_cpumask_var(&cpus, GFP_KERNEL))
> > +		return;
> > +
> > +	scoped_guard (cpus_read_lock) {
> > +		cpumask_copy(cpus, cpu_online_mask);
> > +
> > +		for_each_cpu(cpu, cpus) {
> > +			/* XXX sched_cluster_active */
> > +			struct sched_domain *sd = per_cpu(sd_llc, cpu);
> > +			unsigned long occ, m_occ = 0, a_occ = 0;
> > +			int m_cpu = -1, nr = 0, i;
> > +
> > +			for_each_cpu(i, sched_domain_span(sd)) {
> > +				occ = fraction_mm_sched(cpu_rq(i),
> > +							per_cpu_ptr(mm->pcpu_sched, i));
> > +				a_occ += occ;
> > +				if (occ > m_occ) {
> > +					m_occ = occ;
> > +					m_cpu = i;
> > +				}
> > +				nr++;
> > +				trace_printk("(%d) occ: %ld m_occ: %ld m_cpu: %d nr: %d\n",
> > +					     per_cpu(sd_llc_id, i), occ, m_occ, m_cpu, nr);
> > +			}
> > +
> > +			a_occ /= nr;
> 
> 
> In systems with a larger number of CPUs within a single LLC, the division
> may lose accuracy.

May, sure, but does it actually matter? We're tracking occupancy in ns
per EPOCH_PERIOD, which is 1e7. Lets assume 'large' here is something
daft like 100 CPUs per LLC (lets just really hope nobody actually goes
and do that, please), then you're still only loosing like 1e2 ns from
your average.

> Can we either use multiplication for comparison, or just use the accumulated
> total CPU occupancy
> of that LLC for comparison (by removing a_occ /= nr)?

You can't remove the devision, you get into trouble when the LLCs do not
have equal number of CPUs. You can carry that multiplication around ofc,
but again, why bother?

> > +			if (a_occ > m_a_occ) {
> > +				m_a_occ = a_occ;
> > +				m_a_cpu = m_cpu;
> > +			}
> > +
> > +			trace_printk("(%d) a_occ: %ld m_a_occ: %ld\n",
> > +				     per_cpu(sd_llc_id, cpu), a_occ, m_a_occ);
> > +
> > +			for_each_cpu(i, sched_domain_span(sd)) {
> > +				/* XXX threshold ? */
> > +				per_cpu_ptr(mm->pcpu_sched, i)->occ = a_occ;
> > +			}
> > +
> > +			cpumask_andnot(cpus, cpus, sched_domain_span(sd));
> > +		}
> > +	}
> > +
> > +	/*
> > +	 * If the max average cache occupancy is 'small' we don't care.
> > +	 */
> > +	if (m_a_occ < (NICE_0_LOAD >> EPOCH_OLD))
> > +		m_a_cpu = -1;
> > +
> > +	mm->mm_sched_cpu = m_a_cpu;
> 
> There might be an issue with mm_sched_cpu bouncing. Perhaps adding a
> threshold to compare the old a_occ of mm->mm_sched_cpu with the new a_occ of
> m_a_cpu could help. For example, if the latter (new_a_occ) is twice larger
> than the former (old a_occ), we can update mm->mm_sched_cpu to the new
> m_a_cpu. Otherwise, we keep the old value.

Some hysteresis might make sense, but I don't think waiting for it to
double makes sense, that might be too agressive.

> > +#ifdef CONFIG_SCHED_CACHE
> > +static long __migrate_degrades_locality(struct task_struct *p, int src_cpu, int dst_cpu, bool idle);
> > +
> > +static int select_cache_cpu(struct task_struct *p, int prev_cpu)
> > +{
> > +	struct mm_struct *mm = p->mm;
> > +	int cpu;
> > +
> > +	if (!mm || p->nr_cpus_allowed == 1)
> > +		return prev_cpu;
> > +
> > +	cpu = mm->mm_sched_cpu;
> > +	if (cpu < 0)
> > +		return prev_cpu;
> > +
> 
> 
> We observed frequent task migrations during some highly context-switch
> benchmarks, which led to performance regression when the LLC was saturated.
> Could we avoid task migration in cases where the previous CPU and the
> preferred CPU are within the same LLC?
> 
> if (cpus_share_cache(prev_cpu, cpu))
> 	return prev_cpu;

Sure.

> > +
> > +	if (static_branch_likely(&sched_numa_balancing) &&
> > +	    __migrate_degrades_locality(p, prev_cpu, cpu, false) > 0) {
> > +		/*
> > +		 * XXX look for max occupancy inside prev_cpu's node
> > +		 */
> > +		return prev_cpu;
> > +	}
> > +
> 
> Tim found that spreading tasks within the preferred LLC might help avoid
> task stacking:
> 
> sd = rcu_dereference(per_cpu(sd_llc, cpu));
> if (likely(sd))
> 	return cpumask_any(sched_domain_span(sd));

You know that cpumask_any() is implemented using cpumask_first(), right?
You're causing stacking if anything with that.

> > @@ -9288,6 +9556,17 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
> >   	if (sysctl_sched_migration_cost == 0)
> >   		return 0;
> > +#ifdef CONFIG_SCHED_CACHE
> > +	if (p->mm && p->mm->pcpu_sched) {
> > +		/*
> > +		 * XXX things like Skylake have non-inclusive L3 and might not
> > +		 * like this L3 centric view. What to do about L2 stickyness ?
> > +		 */
> > +		return per_cpu_ptr(p->mm->pcpu_sched, env->src_cpu)->occ >
> > +		       per_cpu_ptr(p->mm->pcpu_sched, env->dst_cpu)->occ;
> 
> This might encourage more task migration within the preferred LLC, leading
> to some performance regression. Is it possible to raise the threshold for
> task migration within the preferred LLC and use the original delta time to
> determine whether a task is cache-hot?
> 
> if (p->mm && p->mm->pcpu_sched &&
>     cpus_share_cache(env->dst_cpu, env->src_cpu))
> 	return  2*per_cpu_ptr(p->mm->pcpu_sched, env->src_cpu)->occ >
> 		  per_cpu_ptr(p->mm->pcpu_sched, env->dst_cpu)->occ;
> }

Nah, the saner thing to do is to preserve the topology averages and look
at those instead of the per-cpu values.

Eg. have task_cache_work() compute and store averages in the
sched_domain structure and then use those.

