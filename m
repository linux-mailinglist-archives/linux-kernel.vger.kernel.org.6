Return-Path: <linux-kernel+bounces-576821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E386DA714C7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D02BF16DAAE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDA7191461;
	Wed, 26 Mar 2025 10:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oK65oWsJ"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997DD1B0F3C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742984772; cv=none; b=L+VYYhhmfPXdzsrcUq767+KYahgu6idAjlIZVYMMBgikypOyg611kwdUNKOy7RZRDYtOc6hA9aBg0YNXBxlWbmX9ldVJPavsWdnK3xLZvCd4sVYx4XtXA+2sT6yfPoL/JVvjjnPCjwWvWyiwkh9bIcaoxpY4nGMKHJwn0y7JmqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742984772; c=relaxed/simple;
	bh=MM12JQn2wzPk2C0uiAR4+c0nN2f2FV/rP/aPhZgTdNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKDqw+4oe2ABTdcj9Sx6YRyBPCeGjpyFPGFtDJ7QhspVEyGscMkRVjIL8PK3MmDDCLP5QMd+UKoKOU/zEy7JtCzHnmkSt1itglb987hYRprTn3u06Y+nhYVvx5kTgp9/ZA/lnhIv2zRq/6fZPNUix6MVbVV0oMDFfHcn90oDZmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oK65oWsJ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=McOHGzb5sQRovXsRNn1qB5Me1cYEx0yWEIKpIsq3eZI=; b=oK65oWsJ8tK2k9oVpnUIRGh6i7
	ywQwgCMLq8U6OfHwkM1Ugty0rqxnAwFxYcgQm4KDF+iSU6BIZxROvEXcJ91jMLS+ANQQtkcZdP3w8
	Y0CqCr3WzpbTfk33GgScgPk7GgzI9ZKUuP1gc1mH56/rz/xzOoUi8EoMRMmjrXk/ZWoY80XRq2URh
	pLSz2iGREMyLi0XOgxQiO8R7bjU8QkoCzYKfIO82MVPjwurV93KU8Epwqa/EEQ2LIrnnDRpc2KiH7
	wYULwteuRCUhdNdR3qRAVElO7PxKyxBa4rF14gmBKSsfA8ulGPFs0+iioSTqmKgFM877RypdrFRdG
	pmp0jBdQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txNxK-00000005mj7-302Y;
	Wed, 26 Mar 2025 10:25:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F085C3003C4; Wed, 26 Mar 2025 11:25:53 +0100 (CET)
Date: Wed, 26 Mar 2025 11:25:53 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	tim.c.chen@linux.intel.com, tglx@linutronix.de, len.brown@intel.com,
	gautham.shenoy@amd.com, mingo@kernel.org, kprateek.nayak@amd.com,
	yu.chen.surf@foxmail.com
Subject: Re: [RFC][PATCH] sched: Cache aware load-balancing
Message-ID: <20250326102553.GA12071@noisy.programming.kicks-ass.net>
References: <20250325120952.GJ36322@noisy.programming.kicks-ass.net>
 <4cd8ba54-8b9e-4563-8fbc-1d6cd6699e81@intel.com>
 <20250326093841.GC25239@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326093841.GC25239@noisy.programming.kicks-ass.net>

On Wed, Mar 26, 2025 at 10:38:41AM +0100, Peter Zijlstra wrote:

> Nah, the saner thing to do is to preserve the topology averages and look
> at those instead of the per-cpu values.
> 
> Eg. have task_cache_work() compute and store averages in the
> sched_domain structure and then use those.

A little something like so perhaps ?

This immediately also gives the information required for clusters and
finding the best LLC of a Node and things like that.

--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -82,6 +82,9 @@ struct sched_domain_shared {
 	atomic_t	nr_busy_cpus;
 	int		has_idle_cores;
 	int		nr_idle_scan;
+
+	unsigned long   sum_occ;
+	unsigned long	avg_occ;
 };
 
 struct sched_domain {
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1286,8 +1286,8 @@ static void task_cache_work(struct callb
 	struct task_struct *p = current;
 	struct mm_struct *mm = p->mm;
 	unsigned long m_a_occ = 0;
-	int cpu, m_a_cpu = -1;
-	cpumask_var_t cpus;
+	int m_a_cpu = -1;
+	int cpu;
 
 	WARN_ON_ONCE(work != &p->cache_work);
 
@@ -1296,46 +1296,46 @@ static void task_cache_work(struct callb
 	if (p->flags & PF_EXITING)
 		return;
 
-	if (!alloc_cpumask_var(&cpus, GFP_KERNEL))
-		return;
-
 	scoped_guard (cpus_read_lock) {
-		cpumask_copy(cpus, cpu_online_mask);
 
-		for_each_cpu(cpu, cpus) {
-			/* XXX sched_cluster_active */
-			struct sched_domain *sd = per_cpu(sd_llc, cpu);
-			unsigned long occ, m_occ = 0, a_occ = 0;
-			int m_cpu = -1, nr = 0, i;
+		for_each_online_cpu(cpu) {
+			struct sched_domain *sd;
+			struct sched_domain_shared *sds;
+			unsigned long occ;
+
+			for_each_domain(cpu, sd) {
+				if (!(sd->flags & SD_SHARE_LLC))
+					break;
 
-			for_each_cpu(i, sched_domain_span(sd)) {
+				sds = sd->shared;
 				occ = fraction_mm_sched(cpu_rq(i),
 							per_cpu_ptr(mm->pcpu_sched, i));
-				a_occ += occ;
-				if (occ > m_occ) {
-					m_occ = occ;
-					m_cpu = i;
-				}
-				nr++;
-				trace_printk("(%d) occ: %ld m_occ: %ld m_cpu: %d nr: %d\n",
-					     per_cpu(sd_llc_id, i), occ, m_occ, m_cpu, nr);
-			}
-
-			a_occ /= nr;
-			if (a_occ > m_a_occ) {
-				m_a_occ = a_occ;
-				m_a_cpu = m_cpu;
+				sds->sum_occ += occ + 1;
 			}
+		}
 
-			trace_printk("(%d) a_occ: %ld m_a_occ: %ld\n",
-				     per_cpu(sd_llc_id, cpu), a_occ, m_a_occ);
+		for_each_online_cpu(cpu) {
+			struct sched_domain *sd;
+			struct sched_domain_shared *sds;
+
+			for_each_domain(cpu, sd) {
+				if (!(sd->flags & SD_SHARE_LLC))
+					break;
+
+				sds = sd->shared;
+				if (sds->agg_occ) {
+					sds->avg_occ = (sds->agg_occ - sd->span_weight) /
+						       sd->span_weight;
+					sds->sum_occ = 0;
+				}
 
-			for_each_cpu(i, sched_domain_span(sd)) {
-				/* XXX threshold ? */
-				per_cpu_ptr(mm->pcpu_sched, i)->occ = a_occ;
+				if (sd == per_cpu(sd_llc, cpu)) {
+					if (sds->avg_occ > m_a_occ) {
+						m_a_occ = sds->avg_occ;
+						m_a_cpu = cpu;
+					}
+				}
 			}
-
-			cpumask_andnot(cpus, cpus, sched_domain_span(sd));
 		}
 	}
 
@@ -1346,8 +1346,6 @@ static void task_cache_work(struct callb
 		m_a_cpu = -1;
 
 	mm->mm_sched_cpu = m_a_cpu;
-
-	free_cpumask_var(cpus);
 }
 
 void init_sched_mm(struct task_struct *p)

