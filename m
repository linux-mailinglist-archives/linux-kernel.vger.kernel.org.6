Return-Path: <linux-kernel+bounces-575078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4205FA6ED49
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A91AF1894E33
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC9319DF41;
	Tue, 25 Mar 2025 10:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FvBGWK87"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DC6149DE8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 10:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742896966; cv=none; b=Edfuhw9ENlfTleqtpe/+3mvWnsfWs+3HWlSBgzT1VYP54yF/eo3GssDP237zep7HPGAQ4mqcdpyrW7FBj144NbS7JO1VLaqj2Py0gxb8U2+XwvuGsmKCzjnr3luyuEAyJ1jvUMMCkZq2Et7UGSX2SmwJp1xKO9mRK3SFLJnvedQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742896966; c=relaxed/simple;
	bh=Kx+8kK58UDDOeqNe6ijB2aq4bwGrZ/zEAjBdzB12Qbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xw0DwLy/hXTRt+hmrWqYuxL8KKzzrv8KDB5tv8JOxaT2L5q/MZZJ9Yn0+1dBApaMtcUYHPTUNhRk0gE7ohKuBR3aDZVRLSlz7ymVWdDX/4n+AircA/HfqICI1OqrAEoIdBWsoKX3pig4uMHV29w51wtQyJAnQcDIaomxYETdrP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FvBGWK87; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2239c066347so119285595ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 03:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1742896963; x=1743501763; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DA8G5snMj+Ia9kBK7Bv3gXm5YjnljuWtRxGf46RBPnE=;
        b=FvBGWK87QpLKUNlx6y7UETkiWUEs0FcIU0hXfUrmEM/uIinxYDbCFfeoeydLLteayj
         X4SZzR4e6QAHErvfmlAFE1NdrKS9cVS2c8h2nR9uXVks22jl6Ew+mw5pguEVv/5TaHEq
         jqb2oomtiJQDk2IjPLYRwnV4sjb0Umv5RNNxPFLOzrTt4e8fvisCd5p2KMQIj3kpKJSR
         QISoYq6u4zpGy4Q7ouNfte/1m7twCYyj0lgbLEDU6H23V4Zde/XnU9Bf2PSj7WCo4PB3
         2yBmGDLAK+o9izTgjKBDX2h3gzfAwpqvalREXXpIJ48tYB9S8azPW/LLsenJ38kc3Ywq
         jMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742896963; x=1743501763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DA8G5snMj+Ia9kBK7Bv3gXm5YjnljuWtRxGf46RBPnE=;
        b=JpxSPy3T0Kl9aRe/+j+32Qd9gvtL1sDLQaWRENgyW67xel9ZgnSkIGDUq1e3yuNXCx
         RzfRMDPbh3zFFczDp+6PDO55fcOPd8jaKRoFgTxUBxfPO8l4mBLojxweLknKhmGbRZF+
         6oG7AhqvRG95iEM4vCt5aP8CAUCvew2qEjQLImAEQERCTYzLfpPKnTniB+L1rTLbOFSG
         XcOtJ4JKt8fLplUIUp4yik192uWpBVxUr59+PSWHmCW82bQ11bPN6a/hvNGoEW0NhsF5
         zKDc5mKN+gBW+237HJ16JNPfB4zcVbZZGo05BNRyPgQZst106KXhONk9Unkfds+HbVeo
         WNCw==
X-Forwarded-Encrypted: i=1; AJvYcCU1WYTIS6CPhSQBrg2cGBsiu6RV4IGLKVkNQKE+mdrr9wYX2J36dLtLfkqbkiA68IM2pShBaXQ/YOfrl8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWbyT7hpCNxjJLOHbH28lv/HXHhol3ONcnTTG/fo7AqVJPf8Ch
	jiYjTOK//2UTmrKL9qm91DH3vrrGw3WdlgXjuj9qGIGPXKoyJ2Sc4bG0Zx1rVQ==
X-Gm-Gg: ASbGncvdZO+hZQRMfNL+9eLJsya6eAdir7Z4qCe/z15adhDADSL8/IdEtmxHjRw9dtq
	pW+t680xg1KdFY0QWI8R/SmD4hBOA+by9GURcG49GTYDsQHUBhE02WZJCAjpC9gJbiGXCGetaLG
	RDvI8O5BOPKa5Jt5Ja5ClAo6AsUb0/1h705GBVJY237wBJWw/ghDSahXeXzhPQ8j6Lu24499/jx
	qVwyexTcjsWn9ATP54DUjbOV7xKkP5IbFrJN2XCE00SONVWS+9ZgRuJ8+lWJoQTC2jrQHaaoDUR
	ROikv+4CQ9BzXWxfQ4o8ZhdxWRj9GDfTDzlAd9bmsbLW
X-Google-Smtp-Source: AGHT+IFMJkpfzrYQsiZm4y1cZaCzq0bbtrKmCxERumgQoGt3+jUALmh441vB5zuy0kk5gpTW4h7Wmw==
X-Received: by 2002:a05:6a20:c886:b0:1f5:79c4:5da2 with SMTP id adf61e73a8af0-1fe4331ddc4mr31539700637.31.1742896963100;
        Tue, 25 Mar 2025 03:02:43 -0700 (PDT)
Received: from bytedance ([115.190.40.12])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a2843af9sm8649772a12.38.2025.03.25.03.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 03:02:42 -0700 (PDT)
Date: Tue, 25 Mar 2025 18:02:25 +0800
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
Message-ID: <20250325100225.GA1539283@bytedance>
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
 <CANCG0GcFF7cnR4rCbU5MmY1Gq3M+r4gPXv39QPXXC=Cdr6sRww@mail.gmail.com>
 <CABk29Nuuq6s1+FBftOPAcMkYU+F1n2nebcP5tDK9dH4_KXA2cw@mail.gmail.com>
 <f121fdf9-aa0d-419f-9323-bd8b0c9682f3@linux.dev>
 <66a69f8e-6f0c-48d0-b8d6-6438092f9377@amd.com>
 <7d9fbee5-2a06-41ed-9ee3-93ef3c077eff@linux.dev>
 <CAOBoifh2Ya279_jjFBrSAHuczqz_FM4NGUne2Tk0sBV=gD4D+w@mail.gmail.com>
 <20250324085822.GA732629@bytedance>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+SYqT80xgeOfiHXD"
Content-Disposition: inline
In-Reply-To: <20250324085822.GA732629@bytedance>


--+SYqT80xgeOfiHXD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 24, 2025 at 04:58:22PM +0800, Aaron Lu wrote:
> On Thu, Mar 20, 2025 at 11:40:11AM -0700, Xi Wang wrote:
> ...
> > I am a bit unsure about the overhead experiment results. Maybe we can add some
> > counters to check how many cgroups per cpu are actually touched and how many
> > threads are actually dequeued / enqueued for throttling / unthrottling?
> 
> Sure thing.
> 
> > Looks like busy loop workloads were used for the experiment. With throttling
> > deferred to exit_to_user_mode, it would only be triggered by ticks. A large
> > runtime debt can accumulate before the on cpu threads are actually dequeued.
> > (Also noted in https://lore.kernel.org/lkml/20240711130004.2157737-11-vschneid@redhat.com/)
> > 
> > distribute_cfs_runtime would finish early if the quotas are used up by the first
> > few cpus, which would also result in throttling/unthrottling for only a few
> > runqueues per period. An intermittent workload like hackbench may give us more
> > information.
> 
> I've added some trace prints and noticed it already invovled almost all
> cpu rqs on that 2sockets/384cpus test system, so I suppose it's OK to
> continue use that setup as described before:
> https://lore.kernel.org/lkml/CANCG0GdOwS7WO0k5Fb+hMd8R-4J_exPTt2aS3-0fAMUC5pVD8g@mail.gmail.com/

One more data point that might be interesting. I've tested this on a
v5.15 based kernel where async unthrottle is not available yet so things
should be worse.

As Xi mentioned, since the test program is cpu hog, I tweaked the quota
setting to make throttle happen more likely.

The bpftrace duration of distribute_cfs_runtime() is:

@durations:
[4K, 8K)               1 |                                                    |
[8K, 16K)              8 |                                                    |
[16K, 32K)             1 |                                                    |
[32K, 64K)             0 |                                                    |
[64K, 128K)            0 |                                                    |
[128K, 256K)           0 |                                                    |
[256K, 512K)           0 |                                                    |
[512K, 1M)             0 |                                                    |
[1M, 2M)               0 |                                                    |
[2M, 4M)               0 |                                                    |
[4M, 8M)               0 |                                                    |
[8M, 16M)              0 |                                                    |
[16M, 32M)             0 |                                                    |
[32M, 64M)           376 |@@@@@@@@@@@@@@@@@@@@@@@                             |
[64M, 128M)          824 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

One random trace point from the trace prints is:

          <idle>-0       [117] d.h1. 83206.734588: distribute_cfs_runtime: cpu117: begins
          <idle>-0       [117] dnh1. 83206.801902: distribute_cfs_runtime: cpu117: finishes: unthrottled_rqs=384, unthrottled_cfs_rq=422784, unthrottled_task=10000

So for the above trace point, distribute_cfs_runtime() unthrottled 384
rqs with a total of 422784 cfs_rqs and enqueued back 10000 tasks, this
took about 70ms.

Note that other things like rq lock contention might make things worse -
I did not notice any lock contention in this setup.

I've attached the corresponding debug diff in case it's not clear what
this trace print means.

--+SYqT80xgeOfiHXD
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="5.15.diff"

Subject: [DEBUG PATCH] sched/fair: profile distribute_cfs_runtime()

---
 kernel/sched/fair.c  | 17 +++++++++++++++++
 kernel/sched/sched.h |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index da3f728b27725..e3546274a162d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5009,6 +5009,8 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
 	cfs_rq->throttled_clock_pelt_time += rq_clock_pelt(rq) -
 					cfs_rq->throttled_clock_pelt;
 
+	rq->unthrottled_cfs_rq++;
+
 	/* Re-enqueue the tasks that have been throttled at this level. */
 	list_for_each_entry_safe(p, tmp, &cfs_rq->throttled_limbo_list, throttle_node) {
 		list_del_init(&p->throttle_node);
@@ -5017,6 +5019,7 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
 		 * due to affinity change while p is throttled.
 		 */
 		enqueue_task_fair(rq_of(cfs_rq), p, ENQUEUE_WAKEUP);
+		rq->unthrottled_task++;
 	}
 
 	/* Add cfs_rq with load or one or more already running entities to the list */
@@ -5193,7 +5196,9 @@ static void distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
 {
 	struct cfs_rq *cfs_rq;
 	u64 runtime, remaining = 1;
+	unsigned int unthrottled_rqs = 0, unthrottled_cfs_rq = 0, unthrottled_task = 0;
 
+	trace_printk("cpu%d: begins\n", raw_smp_processor_id());
 	rcu_read_lock();
 	list_for_each_entry_rcu(cfs_rq, &cfs_b->throttled_cfs_rq,
 				throttled_list) {
@@ -5201,6 +5206,7 @@ static void distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
 		struct rq_flags rf;
 
 		rq_lock_irqsave(rq, &rf);
+		rq->unthrottled_cfs_rq = rq->unthrottled_task = 0;
 		if (!cfs_rq_throttled(cfs_rq))
 			goto next;
 
@@ -5222,12 +5228,23 @@ static void distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
 			unthrottle_cfs_rq(cfs_rq);
 
 next:
+		trace_printk("cpu%d: cpu%d unthrottled_cfs_rq=%d/%d, unthrottled_task=%d/%d, remaining=%Lu\n",
+				raw_smp_processor_id(), cpu_of(rq),
+				rq->unthrottled_cfs_rq, unthrottled_cfs_rq,
+				rq->unthrottled_task, unthrottled_task, remaining);
+
+		unthrottled_cfs_rq += rq->unthrottled_cfs_rq;
+		unthrottled_task += rq->unthrottled_task;
+		unthrottled_rqs++;
+		rq->unthrottled_cfs_rq = rq->unthrottled_task = 0;
 		rq_unlock_irqrestore(rq, &rf);
 
 		if (!remaining)
 			break;
 	}
 	rcu_read_unlock();
+	trace_printk("cpu%d: finishes: unthrottled_rqs=%u, unthrottled_cfs_rq=%u, unthrottled_task=%u\n",
+			raw_smp_processor_id(), unthrottled_rqs, unthrottled_cfs_rq, unthrottled_task);
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e0e05847855f0..bd3a11582d5b6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1118,6 +1118,8 @@ struct rq {
 	unsigned int		core_forceidle_occupation;
 	u64			core_forceidle_start;
 #endif
+	unsigned int		unthrottled_cfs_rq;
+	unsigned int		unthrottled_task;
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-- 
2.39.5


--+SYqT80xgeOfiHXD--

