Return-Path: <linux-kernel+bounces-560052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB83A5FD07
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31B519C2F8C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377C315CD46;
	Thu, 13 Mar 2025 17:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0fuwfQH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90D315747D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885557; cv=none; b=gL0+lYwtgVIN5zxZDbMKGpv6BXW7ds+m3yECkTVR3LaWFiW55ptWxs6345V37vY4dM+jaUl2fPLHtgBjmgWl7FVRIFZ0gxJBf+w1hbX3KPf1C1EODtT5PfwTfzq9LnvmTGfy9nR0I1pzq5pW34+3Ka14WM1ka7SLfuZVdxQ7qQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885557; c=relaxed/simple;
	bh=KQiXIn2VlukWSexqG6FOkdHHd1iYI73n5V5ly7rktl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRiRgy5Gu99pzypyKNQ1qjLEugOpgx9lmfKCxZyb633SNbVV0dq78sEuI3Wu9rMsjn51bXlhfEzvPO8J4VDbs3IbclZcV/ArI5D7/DQp0wxkC/UtzfcQiBInETgT6eEjOati3GOyjh5UeKLE56dGVMZQbH7/N6vhDrAx4K+NqEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q0fuwfQH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741885554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lRaM/X3X7FwnRVTV/8ABm5Bv6FFz4nCJnFljDa4QIJg=;
	b=Q0fuwfQHAY/SBhjVmQUqIZ7jqfX4vMcxlEf2DDgoZKnq4ADgqV1YwMmnRBnHGTWiTLnSgR
	RorT+7rCLsOSaa1lu6ijI6qpvImKuhuzyXF5MqwjtMc4V+RcGiTMtxPAsa6lNP2ZkEy+Fu
	Qd5/vOSG3/xDS54gUc2vfx+HIDGH88g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-R7cq-YC4PnabO9YB5MZFmA-1; Thu, 13 Mar 2025 13:05:53 -0400
X-MC-Unique: R7cq-YC4PnabO9YB5MZFmA-1
X-Mimecast-MFC-AGG-ID: R7cq-YC4PnabO9YB5MZFmA_1741885552
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43bd0586b86so8827965e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:05:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741885551; x=1742490351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRaM/X3X7FwnRVTV/8ABm5Bv6FFz4nCJnFljDa4QIJg=;
        b=MpGjU5zefI9BLkJs9g0V/dApQX4RiT5AecbFt4s/tDJDqttY/nFluJdyKNOeXeWcRS
         c0LFgyhipnONYb3+tu/Tz/CGLowc54F4Rs6csT8GOEz3556Qedt1nWMn1lXGybF8Z8Ro
         Vu2nFyHKotYC4ZYAuAImGTvfl1jQZxB/HTbzdG0PEiTm68IGOtq/YD+wnPSTse+GHKkH
         4jLhSjwdGZYEP+wGp6nfkDN3aJjxzmySo2SX2xp50f6rvTeTufjAXKHSJKPDQrUeIgkp
         ns2KHTmXWItpEOJhkNbL90R/7ONk4cTxhAOENAZ25Cf9Qnk7ZtqCOhpPDc/4Yhp9fAqm
         Xakg==
X-Gm-Message-State: AOJu0Yz7L6QXLZlsN00hKoGB68cyfhiX6KsiDIHFPXbMFYr4KjND+Fxu
	OEqPEh03tbRj7NZM/fzvwkpqOvsz0E0bkft4/Uu8tewzGFgbhIQhePlDaAsOeJJTZ6WaGyXzAyo
	NGaLsYJBDpbcz8q526rXrIe6W7mpBlwWgBtnfOa3qQLrrjFDRAlLFSulJBqqjFS5sIZ06rfNVBD
	j7Xcg687G7mw+AosK4d3bE6OXDZDsqf1HEvCaNUcfp/9ZgV6rB
X-Gm-Gg: ASbGnctDhpgXyIhaQlXbCzAQ9Gt+XS7VPGFpvj1Xgv2AI+f6NPniRiL8NifBnPa25c2
	VGHC5R3Op6LToF5zDD/KvPZw3UTYUpNndiCBRDZfkS3rJm2B6hmXUCle9ECKOuo9mQDO/7juoC/
	MhzXUOh26K6R3nP0CErvieq6F97KIV40rjSuzr9J56qTFJKDLIn0mRTNhWWD8/Gupn5xWukwsvQ
	22xFHYkf4RCgen4VaWxuxPD1ZBGgb33i2e3yQjhxNemk4YpTBksYf0Fc77oVDUi5WJ8klLniF7z
	ad5yPdc0sZ42eJ52tmv3luOSiPjUTW6PEUhs6wLBMLU=
X-Received: by 2002:a05:600c:4690:b0:43c:f1cd:3d78 with SMTP id 5b1f17b1804b1-43d1d8996e4mr4685655e9.12.1741885551233;
        Thu, 13 Mar 2025 10:05:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFqSLsuGYqiWNcWGFhLHtrkt0oSv3EpUnzUFYIX8R0rzU3ce//LTSI6J0Klt+PSgxhr6Qokw==
X-Received: by 2002:a05:600c:4690:b0:43c:f1cd:3d78 with SMTP id 5b1f17b1804b1-43d1d8996e4mr4684875e9.12.1741885550619;
        Thu, 13 Mar 2025 10:05:50 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6e87sm2849628f8f.32.2025.03.13.10.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 10:05:49 -0700 (PDT)
Date: Thu, 13 Mar 2025 18:05:46 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>, luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH v4 3/8] sched/deadline: Generalize unique visiting of root
 domains
Message-ID: <Z9MQaiXPvEeW_v7x@jlelli-thinkpadt14gen4.remote.csb>
References: <20250313170011.357208-1-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313170011.357208-1-juri.lelli@redhat.com>

Bandwidth checks and updates that work on root domains currently employ
a cookie mechanism for efficiency. This mechanism is very much tied to
when root domains are first created and initialized.

Generalize the cookie mechanism so that it can be used also later at
runtime while updating root domains. Also, additionally guard it with
sched_domains_mutex, since domains need to be stable while updating them
(and it will be required for further dynamic changes).

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
Tested-by: Waiman Long <longman@redhat.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 include/linux/sched/deadline.h |  3 +++
 kernel/sched/deadline.c        | 23 +++++++++++++----------
 kernel/sched/rt.c              |  2 ++
 kernel/sched/sched.h           |  2 +-
 kernel/sched/topology.c        |  2 +-
 5 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
index 3a912ab42bb5..6ec578600b24 100644
--- a/include/linux/sched/deadline.h
+++ b/include/linux/sched/deadline.h
@@ -37,4 +37,7 @@ extern void dl_clear_root_domain(struct root_domain *rd);
 
 #endif /* CONFIG_SMP */
 
+extern u64 dl_cookie;
+extern bool dl_bw_visited(int cpu, u64 cookie);
+
 #endif /* _LINUX_SCHED_DEADLINE_H */
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 1a041c1fc0d1..3e05032e9e0e 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -166,14 +166,14 @@ static inline unsigned long dl_bw_capacity(int i)
 	}
 }
 
-static inline bool dl_bw_visited(int cpu, u64 gen)
+static inline bool dl_bw_visited(int cpu, u64 cookie)
 {
 	struct root_domain *rd = cpu_rq(cpu)->rd;
 
-	if (rd->visit_gen == gen)
+	if (rd->visit_cookie == cookie)
 		return true;
 
-	rd->visit_gen = gen;
+	rd->visit_cookie = cookie;
 	return false;
 }
 
@@ -207,7 +207,7 @@ static inline unsigned long dl_bw_capacity(int i)
 	return SCHED_CAPACITY_SCALE;
 }
 
-static inline bool dl_bw_visited(int cpu, u64 gen)
+static inline bool dl_bw_visited(int cpu, u64 cookie)
 {
 	return false;
 }
@@ -3171,15 +3171,18 @@ DEFINE_SCHED_CLASS(dl) = {
 #endif
 };
 
-/* Used for dl_bw check and update, used under sched_rt_handler()::mutex */
-static u64 dl_generation;
+/*
+ * Used for dl_bw check and update, used under sched_rt_handler()::mutex and
+ * sched_domains_mutex.
+ */
+u64 dl_cookie;
 
 int sched_dl_global_validate(void)
 {
 	u64 runtime = global_rt_runtime();
 	u64 period = global_rt_period();
 	u64 new_bw = to_ratio(period, runtime);
-	u64 gen = ++dl_generation;
+	u64 cookie = ++dl_cookie;
 	struct dl_bw *dl_b;
 	int cpu, cpus, ret = 0;
 	unsigned long flags;
@@ -3192,7 +3195,7 @@ int sched_dl_global_validate(void)
 	for_each_online_cpu(cpu) {
 		rcu_read_lock_sched();
 
-		if (dl_bw_visited(cpu, gen))
+		if (dl_bw_visited(cpu, cookie))
 			goto next;
 
 		dl_b = dl_bw_of(cpu);
@@ -3229,7 +3232,7 @@ static void init_dl_rq_bw_ratio(struct dl_rq *dl_rq)
 void sched_dl_do_global(void)
 {
 	u64 new_bw = -1;
-	u64 gen = ++dl_generation;
+	u64 cookie = ++dl_cookie;
 	struct dl_bw *dl_b;
 	int cpu;
 	unsigned long flags;
@@ -3240,7 +3243,7 @@ void sched_dl_do_global(void)
 	for_each_possible_cpu(cpu) {
 		rcu_read_lock_sched();
 
-		if (dl_bw_visited(cpu, gen)) {
+		if (dl_bw_visited(cpu, cookie)) {
 			rcu_read_unlock_sched();
 			continue;
 		}
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 4b8e33c615b1..8cebe71d2bb1 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2910,6 +2910,7 @@ static int sched_rt_handler(const struct ctl_table *table, int write, void *buff
 	int ret;
 
 	mutex_lock(&mutex);
+	sched_domains_mutex_lock();
 	old_period = sysctl_sched_rt_period;
 	old_runtime = sysctl_sched_rt_runtime;
 
@@ -2936,6 +2937,7 @@ static int sched_rt_handler(const struct ctl_table *table, int write, void *buff
 		sysctl_sched_rt_period = old_period;
 		sysctl_sched_rt_runtime = old_runtime;
 	}
+	sched_domains_mutex_unlock();
 	mutex_unlock(&mutex);
 
 	return ret;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c8512a9fb022..c978abe38c07 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -998,7 +998,7 @@ struct root_domain {
 	 * Also, some corner cases, like 'wrap around' is dangerous, but given
 	 * that u64 is 'big enough'. So that shouldn't be a concern.
 	 */
-	u64 visit_gen;
+	u64 visit_cookie;
 
 #ifdef HAVE_RT_PUSH_IPI
 	/*
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 296ff2acfd32..44093339761c 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -568,7 +568,7 @@ static int init_rootdomain(struct root_domain *rd)
 	rd->rto_push_work = IRQ_WORK_INIT_HARD(rto_push_irq_work_func);
 #endif
 
-	rd->visit_gen = 0;
+	rd->visit_cookie = 0;
 	init_dl_bw(&rd->dl_bw);
 	if (cpudl_init(&rd->cpudl) != 0)
 		goto free_rto_mask;
-- 
2.48.1


