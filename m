Return-Path: <linux-kernel+bounces-573406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9D2A6D6D1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 10:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B9337A4019
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD0F25D8E3;
	Mon, 24 Mar 2025 08:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TLWUGq15"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058531EB5D7
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 08:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742806725; cv=none; b=NzE7BIePX+vzR5yh9OZ+cIocNTfJ8+2yWuxdOGbTZ3SdxitUvQ2MKSYXvxWGC90Oy05mCdYdUNonNVD9lnvEFPJsMEgz7VshRtiHfzsaz+m7i+HfIA2G+Xj18Q+KPvmKSxUWaOqUTmetZ2Eh7o6bBdA08C15Nb5PuLvahQSFbjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742806725; c=relaxed/simple;
	bh=NYzjk3rLLd/nIoVke4NWjpbHXcWO/P+fq41k0wh0Lzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWMi1TN1IqPi5XGDrQ9L0wfIG2MaAvrZqSwU88aps2z+IXZwU7F5c7PpUKMz3+KkEIw7l5V3m//MzZbZLJyAk9CVLv5y7Ia6M3c9NjKjLp3ZXarC/JQLOegQ/YRwbJJn0v5Oh2OKYa3iEdADVloXkTQ33+RXRLokMVmBpTPlLho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TLWUGq15; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22403cbb47fso73738245ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 01:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1742806722; x=1743411522; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G+YMaLuqQhi5nUDF2j1OZpw954Xv+sr2qhBwWmbmN9s=;
        b=TLWUGq1523pj9+lPsypRc7A7kCfdFKwdpC+gSKkK3l2xFTGY6wEXn+RhUuMNy21AMP
         tcMcEI7BkjscVW5YrJov9JnFC7KOFY7RrfZzN6G2gOgc9SnawRMhrFaXxozrhSTnNCyY
         mAsmDczFT9sZ12iWgakKXZG1Gb7HXjpd2izxGCzWhO+T/17uvXt0PBdvVXwXVkspWDGh
         36eOT9ld2Vif+OFAz4qjRoOfYJa95TclxCScob9bGG1wvx1KEu+StlWQH/cXikmSC0sB
         K27nx2G0COfFRtwlc9bjMaGYt/OHgVQawkP5m1LWP2hBDLzopBMvNrKekXJWnLHiFALh
         uFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742806722; x=1743411522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+YMaLuqQhi5nUDF2j1OZpw954Xv+sr2qhBwWmbmN9s=;
        b=wqd5vYtuGSwywDSsZA2yxEp+WY9cPjx0MfdwL3+HBQKyxJyMNqRUE11YnpAkVqQSyo
         4k+IHAgBDa6qYDke56CIt5XJAdSf3izCpSXVVApJuw5jV7e+x8WlMlfkXKZwwGx5ckPK
         Y/WFqjBxD4n9bwEwVsxZYPdneJdesLw+8GxFiCpsZ/HlR8Hvx4SSqJ+vUzo/opDjA+Qc
         O6nmhBlyzGox7/dhmxD36M9LV+OXl3ojx21YN8zhChcKNjcW3wJqooHy4I9myZHFph0X
         4JREP33WjYIk84ivW39KmBDyMqVKwj1kT/v5Y+DfM7ny64jEvDJFF9C3AMaKMsEKcd7N
         ldqA==
X-Forwarded-Encrypted: i=1; AJvYcCUN3Uoky2+tOme0vYI1PwlewkSghhWa3LdPIl7Q1uZfexQgckmkeYBp0JTA6KJXwfcSH5q9+z164jvES6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM1QY+CjCLDH9vKAOnFJFVuwbtY2PuKXsJKdXDJkZieqyKgjm4
	dz8VxQPXNGlSxheZDXoMCouYLTGl234K5DjrK/ojUIfssbdlLj4QPGDefwAF5w==
X-Gm-Gg: ASbGncu7uxb/B84DU7Geq9ES3NOfjGc1MOmM+HyJ38othrx4aKU2Ei9VIRJYnVMsye+
	0UmDGzruC+eOx7ge1O21paVjhwaHEYska7LnHsAessv3tJjm1wE5lZ7rLx3xAgi2wAIRfGUuprG
	3l0eZuZ8ezahEAhjavFs6ol3o+cOllxDDXxQ+TBOwZ0jZ3xsGsbVAyD+mE305GDWaWeQyHZdJH5
	Rg2b/0S3bJZCj480ZisV6jOkJLJ9c2QPfkmD3DHEVr2ok9LriqIqfxoQyKTywmxBpGsx8OHCGT5
	awzOIbzo/i+MPi/xzF/qlwD14ZqKD+aj7Q6+z2gYjjZR
X-Google-Smtp-Source: AGHT+IGyVicS7r9an2VuoEtM208RY0l/0h2t2ij3fg2SfU6ziWBeO8r95WAoCfJVjnWQcFmki3nQKA==
X-Received: by 2002:a05:6a00:2d88:b0:736:a7e3:d4ab with SMTP id d2e1a72fcca58-739059457b8mr18009292b3a.5.1742806721800;
        Mon, 24 Mar 2025 01:58:41 -0700 (PDT)
Received: from bytedance ([115.190.40.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fd5747sm7614972b3a.55.2025.03.24.01.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 01:58:41 -0700 (PDT)
Date: Mon, 24 Mar 2025 16:58:22 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Xi Wang <xii@google.com>
Cc: Chengming Zhou <chengming.zhou@linux.dev>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Josh Don <joshdon@google.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: Re: [RFC PATCH 2/7] sched/fair: Handle throttle path for task based
 throttle
Message-ID: <20250324085822.GA732629@bytedance>
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
 <CANCG0GcFF7cnR4rCbU5MmY1Gq3M+r4gPXv39QPXXC=Cdr6sRww@mail.gmail.com>
 <CABk29Nuuq6s1+FBftOPAcMkYU+F1n2nebcP5tDK9dH4_KXA2cw@mail.gmail.com>
 <f121fdf9-aa0d-419f-9323-bd8b0c9682f3@linux.dev>
 <66a69f8e-6f0c-48d0-b8d6-6438092f9377@amd.com>
 <7d9fbee5-2a06-41ed-9ee3-93ef3c077eff@linux.dev>
 <CAOBoifh2Ya279_jjFBrSAHuczqz_FM4NGUne2Tk0sBV=gD4D+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Epr9608kl7REck+8"
Content-Disposition: inline
In-Reply-To: <CAOBoifh2Ya279_jjFBrSAHuczqz_FM4NGUne2Tk0sBV=gD4D+w@mail.gmail.com>


--Epr9608kl7REck+8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 20, 2025 at 11:40:11AM -0700, Xi Wang wrote:
...
> I am a bit unsure about the overhead experiment results. Maybe we can add some
> counters to check how many cgroups per cpu are actually touched and how many
> threads are actually dequeued / enqueued for throttling / unthrottling?

Sure thing.

> Looks like busy loop workloads were used for the experiment. With throttling
> deferred to exit_to_user_mode, it would only be triggered by ticks. A large
> runtime debt can accumulate before the on cpu threads are actually dequeued.
> (Also noted in https://lore.kernel.org/lkml/20240711130004.2157737-11-vschneid@redhat.com/)
> 
> distribute_cfs_runtime would finish early if the quotas are used up by the first
> few cpus, which would also result in throttling/unthrottling for only a few
> runqueues per period. An intermittent workload like hackbench may give us more
> information.

I've added some trace prints and noticed it already invovled almost all
cpu rqs on that 2sockets/384cpus test system, so I suppose it's OK to
continue use that setup as described before:
https://lore.kernel.org/lkml/CANCG0GdOwS7WO0k5Fb+hMd8R-4J_exPTt2aS3-0fAMUC5pVD8g@mail.gmail.com/

Below is one print sample:

          <idle>-0       [214] d.h1.  1879.281972: distribute_cfs_runtime: cpu214: begins                                         <idle>-0       [214] dNh2.  1879.283564: distribute_cfs_runtime: cpu214: finishes. unthrottled rqs=383, unthro
ttled_cfs_rq=1101, unthrottled_task=69

With async unthrottle, it's not possible to account exactly how many
cfs_rqs are unthrottled and how many tasks are enqueued back, just
how many rqs are involved and how many cfs_rqs/tasks the local cpu has
unthrottled. So this sample means in distribute_cfs_runtime(), 383 rqs
are involved and the local cpu has unthrottled 1101 cfs_rqs and a total
of 69 tasks are enqueued back.

The corresponding bpftrace(duration of distribute_cfs_runtime(), in
nano-seconds) is:
@durations:
[4K, 8K)               9 |                                                    |
[8K, 16K)            227 |@@@@@@@@@@@@@@                                      |
[16K, 32K)           120 |@@@@@@@                                             |
[32K, 64K)            70 |@@@@                                                |
[64K, 128K)            0 |                                                    |
[128K, 256K)           0 |                                                    |
[256K, 512K)           0 |                                                    |
[512K, 1M)           158 |@@@@@@@@@                                           |
[1M, 2M)             832 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[2M, 4M)             177 |@@@@@@@@@@@                                         |

Thanks,
Aaron

> See slide 10 of my presentation for more info:
> https://lpc.events/event/18/contributions/1883/attachments/1420/3040/Priority%20Inheritance%20for%20CFS%20Bandwidth%20Control.pdf
> 
> Indeed we are seeing more cfsb scalability problems with larger servers. Both
> the irq off time from the cgroup walk and the overheads from per task actions
> can be problematic.
> 
> -Xi

--Epr9608kl7REck+8
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="upstream.diff"

Subject: [DEBUG PATCH] sched/fair: add profile for distribute_cfs_runtime()

---
 kernel/sched/fair.c  | 10 ++++++++++
 kernel/sched/sched.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d646451d617c1..a4e3780c076e3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5922,10 +5922,12 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
 		cfs_rq->throttled_clock_self_time += delta;
 	}
 
+	rq->unthrottled_cfs_rq++;
 	/* Re-enqueue the tasks that have been throttled at this level. */
 	list_for_each_entry_safe(p, tmp, &cfs_rq->throttled_limbo_list, throttle_node) {
 		list_del_init(&p->throttle_node);
 		enqueue_task_fair(rq_of(cfs_rq), p, ENQUEUE_WAKEUP);
+		rq->unthrottled_task++;
 	}
 
 	/* Add cfs_rq with load or one or more already running entities to the list */
@@ -6192,6 +6194,9 @@ static bool distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
 	struct rq_flags rf;
 	struct rq *rq;
 	LIST_HEAD(local_unthrottle);
+	unsigned int unthrottled_rqs = 0;
+
+	trace_printk("cpu%d: begins\n", this_cpu);
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(cfs_rq, &cfs_b->throttled_cfs_rq,
@@ -6228,6 +6233,7 @@ static bool distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
 		if (cfs_rq->runtime_remaining > 0) {
 			if (cpu_of(rq) != this_cpu) {
 				unthrottle_cfs_rq_async(cfs_rq);
+				unthrottled_rqs++;
 			} else {
 				/*
 				 * We currently only expect to be unthrottling
@@ -6250,12 +6256,16 @@ static bool distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
 		struct rq *rq = rq_of(cfs_rq);
 
 		rq_lock_irqsave(rq, &rf);
+		rq->unthrottled_cfs_rq = rq->unthrottled_task = 0;
 
 		list_del_init(&cfs_rq->throttled_csd_list);
 
 		if (cfs_rq_throttled(cfs_rq))
 			unthrottle_cfs_rq(cfs_rq);
 
+		trace_printk("cpu%d: finishes. unthrottled rqs=%u, unthrottled_cfs_rq=%d, unthrottled_task=%d\n",
+				raw_smp_processor_id(), unthrottled_rqs,
+				rq->unthrottled_cfs_rq, rq->unthrottled_task);
 		rq_unlock_irqrestore(rq, &rf);
 	}
 	SCHED_WARN_ON(!list_empty(&local_unthrottle));
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5c2af5a70163c..d004da2bc9071 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1309,6 +1309,8 @@ struct rq {
 #if defined(CONFIG_CFS_BANDWIDTH) && defined(CONFIG_SMP)
 	call_single_data_t	cfsb_csd;
 	struct list_head	cfsb_csd_list;
+	unsigned int            unthrottled_cfs_rq;
+	unsigned int            unthrottled_task;
 #endif
 };
 
-- 
2.39.5


--Epr9608kl7REck+8--

