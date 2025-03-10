Return-Path: <linux-kernel+bounces-553851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4ABA58FD1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FC5B188F6CE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20C82253EC;
	Mon, 10 Mar 2025 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXkTth5h"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FFA1C5F34
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599373; cv=none; b=Yd3XBb20fLqsrVIQG9kcS0qIAD/VPzrZvtyiIPb+sQSy7jLsJb9Xkzr9TY2brgcy13vsVfITQ49dDUy6unGkL9B12sfZdwJhxBQA1dutm1G2laME5RwU967ORY1ViNFP2JhP2jJmrx2EpprVjqZ4a8QKqnT0Nwo9iJjcSCphEtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599373; c=relaxed/simple;
	bh=77Cw6OMirz56mbjUr2uprYqVtTffZBEoqucfaqj42yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EN/KO1Vz+CxN4IqSY1NnN6ViYsgImTYkZ52GMBUFAhTFn9AEDWUlXeCNR6e3RoHWQExZjcJDGX9lxEMFbwXSiKfIZLnK+Suh/z0A3IvYhCe74mr4OCBamffMaGPmZxallQiB+w053yUnHQx/pNEvabGggLJX6606f5oR0qXLlS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cXkTth5h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741599369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KKHSd1R9tSOgqW3rsZG1AGAIm0nBc4+9GIVe07dpeHA=;
	b=cXkTth5hBEZqxBxMiJ3gakFKgTYL704zNTy5ZLE5QvHHeF6E8TVetPxGZh5M+RAWXBjlL9
	zyC5Et0OzGhFvD0zN5f6hplPhArVaCH4ZWAziZEF/uN/cH0/jL4zfLnwSAZjg0cJ3/eHZw
	YAjR7FJ2uiUmnPb8lqtkIcl4maF1WoY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-9FxMArzGOAybXo21BhW_Lg-1; Mon, 10 Mar 2025 05:36:06 -0400
X-MC-Unique: 9FxMArzGOAybXo21BhW_Lg-1
X-Mimecast-MFC-AGG-ID: 9FxMArzGOAybXo21BhW_Lg_1741599365
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-438e180821aso17792315e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 02:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741599364; x=1742204164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKHSd1R9tSOgqW3rsZG1AGAIm0nBc4+9GIVe07dpeHA=;
        b=qUF+dOEKgU5KO0oIq0BqUvhRyenz0V357czJgIe1yzJ0MKPE39h2ep8dOgUJaLbF/v
         xVNPZowXqVLaXC8LmQX8bhTpRzFnR5gMNqtwMa4BjQ5OOYbTBVwqTPTN4mygSwLfRGL5
         T9wCJIA6IXed2WikIcQA65BcZJZNYifBIm5tVHZdT3hXgQCAelWy677Y5LWZislDk8c2
         MQZh/WNV8n2bIdyJGT74rqUtzDQiriOYj+smGOSPOUCJ+m1k980sPU8XEFDfB15I8MZW
         v1j04JdHY1coXZRRbms1uxDUWNKievTJKlPdLn+eBSZN6qSOXXc7pbk3s5a29YQHnJLy
         MvHw==
X-Gm-Message-State: AOJu0YzhBBm1F1bHDaTK3uQlo5tJ6uBKVezSPp4tC1dVfxfVIozev02/
	CcD1vqxIu0ydlRN42KOI3L7eOML1dehseId0dioV5OcAt0GaD/0TYMwytg6+p+33XVG0tjTP0tO
	hIZieelidln+Szb372YEKsXxRDOfKojNgQQmcA0/6wRtGxbMUYSoruc8At65ksaxIHDQudLiVwK
	DRx2XTiU8NpOOXl9nFjo4spxhhz0C95LiFMM2kumml+MwgOEdP49A=
X-Gm-Gg: ASbGnctNbeM1fN/hsBOyzI8tclohrzkzBgzEYaYtshrOEyugw8+9y7iZghfihn/h7yW
	fpe8SCcYTltnbrNcepy/lG9ubN2c3Ogb34A83kqoo8qQisaXpvdrmtzYw/dPeqGV0wuhMCuqUml
	Fn+NaJf8W8ZMstxPBoaAk0nHJl9caXRDeRScv4EWAwvLc2jsq0OS1jSTLEL7gv2U8poa0j1X9DI
	HCLVBekhHBxN+Y7zzmNx0i5P+r6SjMO0U+/XtBeoOLyrElGDp9vnAQEcgACVSg8fqWCAHmrLnZh
	sz+zfNma/seGnhAiU2YiSS0X+Lwj91c6+J/VkAQaJ7k=
X-Received: by 2002:a05:600c:1d03:b0:43c:eacc:9d68 with SMTP id 5b1f17b1804b1-43ceacca125mr38496925e9.20.1741599363985;
        Mon, 10 Mar 2025 02:36:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBr/2t9MYkgNGGYC9N7JgdhFa6kCeNhMjLpUu+D0hEfBcVB2Xa2/6FHmeUAbv9Uc6aabg6bw==
X-Received: by 2002:a05:600c:1d03:b0:43c:eacc:9d68 with SMTP id 5b1f17b1804b1-43ceacca125mr38496025e9.20.1741599363336;
        Mon, 10 Mar 2025 02:36:03 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ce715731csm78799055e9.2.2025.03.10.02.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 02:36:02 -0700 (PDT)
Date: Mon, 10 Mar 2025 10:35:59 +0100
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
Subject: [PATCH v3 3/8] sched/deadline: Generalize unique visiting of root
 domains
Message-ID: <Z86yfz-pIHHqC5TP@jlelli-thinkpadt14gen4.remote.csb>
References: <20250310091935.22923-1-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310091935.22923-1-juri.lelli@redhat.com>

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


