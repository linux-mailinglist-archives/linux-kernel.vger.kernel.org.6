Return-Path: <linux-kernel+bounces-576842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55284A7150B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4156173AEF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213BE1C84A3;
	Wed, 26 Mar 2025 10:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X2jgAovw"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6C519DF4A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742985757; cv=none; b=uxWe+oLKhmeuRV7DP+qdki2Wb6sDkwqcRf1isTjRedflgy/qVV4YxORCMMR8oLPbEJPEagk7owxpWklsXsZEqW9rox9/A6n87d9BcWN2qKEeuXnmsB/dsiT6xLUQGIg+Z5FRD5Hd8MUSs/JqSXP5NVjM5U6KV4iPjErBfUoOnag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742985757; c=relaxed/simple;
	bh=xxVEA4x69be8/GH65CA1pQsiJA+hsFhikdNxwCp+DbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLfudQ64PFqiVuQ4X8Isc1/9Lv+CDFxrbt3xZvMU7XVx66f2knU/3fB+OzNBK6d6zs35HuT8zzxedNDLY+wSKj6LPgD4HGGcOsKxEi04BRHR53c/9scH/cDx+c6v3U8KbZLRRYUvMLx2bbYWqsgJzrfv7CQ5XaLpjEMfYXj7wOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X2jgAovw; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fSyZ6Phzb9iwBvQf1kZXoP1Egy/rOHn1FiDq1GRjp2o=; b=X2jgAovwoBn5pyvgBoaXPfJ77N
	iMGh9vUhf3x+w2FgzPQWwlphA8HiWwg2+p0lahtz6CB1EzKKLTGYs7qd5CmhxbOtuYm+DSrolOb3e
	3G2IZd6WoaYoc1J35M6eB7tFhdsewJz0X1ld2okYn6LUjwuxA5EU8DjPzHCDU7HHJ0XP66d+LERcq
	fX8ODzq806sO3aS6+tE1L4TQnLgcltYUPd/z6DnJ89/kgqzpWGBLoU7CU+8wl7+3/Ptpj1yqvl7Gt
	vnWmpn6zN69gwY0HXf/4Iahlt7ks2Bnv7c7w5HcVJ0FLOCGaLEp+qPG/Bm1iTYZLkCDgr69tS0/46
	ZL7WsEeg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txODI-00000005mry-1BoF;
	Wed, 26 Mar 2025 10:42:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D14C33003C4; Wed, 26 Mar 2025 11:42:23 +0100 (CET)
Date: Wed, 26 Mar 2025 11:42:23 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	tim.c.chen@linux.intel.com, tglx@linutronix.de, len.brown@intel.com,
	gautham.shenoy@amd.com, mingo@kernel.org, kprateek.nayak@amd.com,
	yu.chen.surf@foxmail.com
Subject: Re: [RFC][PATCH] sched: Cache aware load-balancing
Message-ID: <20250326104223.GB12071@noisy.programming.kicks-ass.net>
References: <20250325120952.GJ36322@noisy.programming.kicks-ass.net>
 <4cd8ba54-8b9e-4563-8fbc-1d6cd6699e81@intel.com>
 <20250326093841.GC25239@noisy.programming.kicks-ass.net>
 <20250326102553.GA12071@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326102553.GA12071@noisy.programming.kicks-ass.net>

On Wed, Mar 26, 2025 at 11:25:53AM +0100, Peter Zijlstra wrote:
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1286,8 +1286,8 @@ static void task_cache_work(struct callb
>  	struct task_struct *p = current;
>  	struct mm_struct *mm = p->mm;
>  	unsigned long m_a_occ = 0;
> -	int cpu, m_a_cpu = -1;
> -	cpumask_var_t cpus;
> +	int m_a_cpu = -1;
> +	int cpu;
>  
>  	WARN_ON_ONCE(work != &p->cache_work);
>  
> @@ -1296,46 +1296,46 @@ static void task_cache_work(struct callb
>  	if (p->flags & PF_EXITING)
>  		return;
>  
> -	if (!alloc_cpumask_var(&cpus, GFP_KERNEL))
> -		return;
> -
>  	scoped_guard (cpus_read_lock) {
> -		cpumask_copy(cpus, cpu_online_mask);
>  
> -		for_each_cpu(cpu, cpus) {
> -			/* XXX sched_cluster_active */
> -			struct sched_domain *sd = per_cpu(sd_llc, cpu);
> -			unsigned long occ, m_occ = 0, a_occ = 0;
> -			int m_cpu = -1, nr = 0, i;
> +		for_each_online_cpu(cpu) {
> +			struct sched_domain *sd;
> +			struct sched_domain_shared *sds;
> +			unsigned long occ;
> +
> +			for_each_domain(cpu, sd) {
> +				if (!(sd->flags & SD_SHARE_LLC))
> +					break;
>  
> -			for_each_cpu(i, sched_domain_span(sd)) {
> +				sds = sd->shared;
>  				occ = fraction_mm_sched(cpu_rq(i),
>  							per_cpu_ptr(mm->pcpu_sched, i));
> -				a_occ += occ;
> -				if (occ > m_occ) {
> -					m_occ = occ;
> -					m_cpu = i;
> -				}
> -				nr++;
> -				trace_printk("(%d) occ: %ld m_occ: %ld m_cpu: %d nr: %d\n",
> -					     per_cpu(sd_llc_id, i), occ, m_occ, m_cpu, nr);
> -			}
> -
> -			a_occ /= nr;
> -			if (a_occ > m_a_occ) {
> -				m_a_occ = a_occ;
> -				m_a_cpu = m_cpu;
> +				sds->sum_occ += occ + 1;
>  			}
> +		}
>  
> -			trace_printk("(%d) a_occ: %ld m_a_occ: %ld\n",
> -				     per_cpu(sd_llc_id, cpu), a_occ, m_a_occ);
> +		for_each_online_cpu(cpu) {
> +			struct sched_domain *sd;
> +			struct sched_domain_shared *sds;
> +
> +			for_each_domain(cpu, sd) {
> +				if (!(sd->flags & SD_SHARE_LLC))
> +					break;
> +
> +				sds = sd->shared;
> +				if (sds->agg_occ) {
> +					sds->avg_occ = (sds->agg_occ - sd->span_weight) /
> +						       sd->span_weight;
> +					sds->sum_occ = 0;
> +				}

s/agg_occ/sum_occ/g, stupid last minute renames etc.. :-)

>  
> -			for_each_cpu(i, sched_domain_span(sd)) {
> -				/* XXX threshold ? */
> -				per_cpu_ptr(mm->pcpu_sched, i)->occ = a_occ;
> +				if (sd == per_cpu(sd_llc, cpu)) {
> +					if (sds->avg_occ > m_a_occ) {
> +						m_a_occ = sds->avg_occ;
> +						m_a_cpu = cpu;
> +					}
> +				}
>  			}
> -
> -			cpumask_andnot(cpus, cpus, sched_domain_span(sd));
>  		}
>  	}
>  
> @@ -1346,8 +1346,6 @@ static void task_cache_work(struct callb
>  		m_a_cpu = -1;
>  
>  	mm->mm_sched_cpu = m_a_cpu;
> -
> -	free_cpumask_var(cpus);
>  }
>  
>  void init_sched_mm(struct task_struct *p)

