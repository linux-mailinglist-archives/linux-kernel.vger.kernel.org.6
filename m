Return-Path: <linux-kernel+bounces-560059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB91AA5FD1E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B6517A19D1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9516C269D1D;
	Thu, 13 Mar 2025 17:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XYGhcjnY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183CC13AA2F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885831; cv=none; b=mVYqp63mNX3x2n/9dWd9fHQn6buQcogooFE/J2cazcSlGdQ0Fc8BaLpSXIVjwq8+MoQ7qsmn7bAyRhCqXa7Z9ODzDg7vyrW+Z+nbW/BuQgyHYC56rCeCrYDguil2rLu+cP9ppwS9/12dM8KaIlgmFmSi+x/1Z5ikR6pJRUzqA+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885831; c=relaxed/simple;
	bh=nR1ob2cQONENW8eUXzLTE8w0E2+3XPvDjEWYcWYXJ6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GT8LXojRreLHcBzliywrAwuZrTpR0DHMhK/aTZSZWFgIlcYu/mTdy9pbt93uKD/FYkqwIWkImj0bAb5P1qDqa0mt/kb9HlFaMbtvz/QvRyw8j1PA2T0GYPEjDyNhVViobQATczGivF+US5PxFR5FSKgf5K9aJAZzZ+H3tV3u5kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XYGhcjnY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741885828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=13IrME9qVH+0+hXjGK6BJyrl1EowiQUElDsQf/trHmI=;
	b=XYGhcjnYAfj60ayuKX7zQjBrvdp9HcNry2sYd8r+FrWI48v/TxqzVm+M2cMnnhRoDuwNLo
	YDnOtPV3l5LggC5WXaxMPVuIgGCLpGR+rMOb10EwHZazXZX96PXiOuXQPoO+EjkkmX5/+d
	q0ruzZkOsypAmYbmK25gQ8NnFVQknh0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-yta8zfQ9P-OtK4fPYtbBpA-1; Thu, 13 Mar 2025 13:10:27 -0400
X-MC-Unique: yta8zfQ9P-OtK4fPYtbBpA-1
X-Mimecast-MFC-AGG-ID: yta8zfQ9P-OtK4fPYtbBpA_1741885826
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3913aea90b4so535248f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741885825; x=1742490625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13IrME9qVH+0+hXjGK6BJyrl1EowiQUElDsQf/trHmI=;
        b=uHOv9dKvmlpy8FHCB2UbzBrM7DPQU2Q34f/MnW7h272prA4CvKylthgJFqEfy4aDhv
         /fJUhkOAVvwArRBZtBGTssKlcNy3xy6AsPmkrI4HMoLtbz8GEimPw9jn6iSzF3ze4jHF
         VLiL8JKZ151tVCGYSvblEAwDaYmnTdXiXW9Kapt5pRxl/br1XRRkxu0GxCipS40z0Xfl
         mId0CnMmAdex81QRRXC8xqrTZkqmL9gFSzAsn/dn7h0JH3a/y2nqBYTVzg/sYLtdnArT
         xkK+y6rzv2jZgvSvP/RJxAGnwvNc84n+78KEumvr5aC6mqX1wi+f4HhhRophB7ssJq5e
         dgCg==
X-Gm-Message-State: AOJu0YyjFAqGjKyLUOP6xbSeky2vtwECkcmvmzu0uRdFCPbE1ptY3jRw
	sSD7+HPP/hR8EHFoRPFlZGR6wOMgaKykOJFSIuwr9UZCfIsfbyuWS33mSEdjgQah+X5PJBYnOoT
	51AIsHlTWfQo1NyOb2DZWhYOJbYzP7UcU31Ag03VRS2rCEYrD/sLA04hXLBp8iNhVdhGBPEQM/V
	KH4M+ZN6kb/rmykkmfE6yGkKD1a5GiMHXn76w/AhnhPRtglC6/
X-Gm-Gg: ASbGnct/9s0m01g+9E7HKe6tFMZIc2wqe3DTyxf7hI742T3KcOk+J3ITYG37jDtFKmT
	pG+W5b2MbUeMq17JgJ/12F5synN8ZA+szKhSAYXlClYkpAI0quZSdlL10WxCghUTUb1OxyzNgaA
	oK16vvLSP5hF13Pgs+Nwg1uDm2Kj2WODtIiC3yP5ZkWBgtlTvDagKjSwNFiRkGw8nxN3teG/pFf
	Op64AAEnjPgp8bEiMjjwKryTncOAhhDff+X7Rkk+YGH4IEN3xd9mopEN7OmmL2edhhsdnde3UC9
	jgPfZXtFvTbgg5DmRpZe6p4Bc9NClG+4rzaYDY53ujs=
X-Received: by 2002:a5d:598f:0:b0:391:2e97:577a with SMTP id ffacd0b85a97d-396c3e16586mr352404f8f.55.1741885824808;
        Thu, 13 Mar 2025 10:10:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+lg8zlUlXluRXE6AcisRhjeRo0PjZSFqibrRBKyIRUbuHm3FBSBZu6OcQAhW2z6WDs92D3g==
X-Received: by 2002:a5d:598f:0:b0:391:2e97:577a with SMTP id ffacd0b85a97d-396c3e16586mr352346f8f.55.1741885824314;
        Thu, 13 Mar 2025 10:10:24 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7eb92csm2752500f8f.91.2025.03.13.10.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 10:10:23 -0700 (PDT)
Date: Thu, 13 Mar 2025 18:10:21 +0100
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
Subject: [PATCH v4 4/8] sched/deadline: Rebuild root domain accounting after
 every update
Message-ID: <Z9MRfeJKJUOyUSto@jlelli-thinkpadt14gen4.remote.csb>
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

Rebuilding of root domains accounting information (total_bw) is
currently broken on some cases, e.g. suspend/resume on aarch64. Problem
is that the way we keep track of domain changes and try to add bandwidth
back is convoluted and fragile.

Fix it by simplify things by making sure bandwidth accounting is cleared
and completely restored after root domains changes (after root domains
are again stable).

To be sure we always call dl_rebuild_rd_accounting while holding
cpuset_mutex we also add cpuset_reset_sched_domains() wrapper.

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
Co-developed-by: Waiman Long <llong@redhat.com>
Signed-off-by: Waiman Long <llong@redhat.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
v3 -> v4: add cpuset_reset_sched_domains wrapper so that we always call
          partition_sched_domains holding cpuset_mutex (Waiman)
---
 include/linux/cpuset.h         |  6 ++++++
 include/linux/sched/deadline.h |  1 +
 include/linux/sched/topology.h |  2 ++
 kernel/cgroup/cpuset.c         | 23 ++++++++++++++++-------
 kernel/sched/core.c            |  4 ++--
 kernel/sched/deadline.c        | 16 ++++++++++------
 kernel/sched/topology.c        |  1 +
 7 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 835e7b793f6a..17cc90d900f9 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -128,6 +128,7 @@ extern bool current_cpuset_is_being_rebound(void);
 extern void rebuild_sched_domains(void);
 
 extern void cpuset_print_current_mems_allowed(void);
+extern void cpuset_reset_sched_domains(void);
 
 /*
  * read_mems_allowed_begin is required when making decisions involving
@@ -264,6 +265,11 @@ static inline void rebuild_sched_domains(void)
 	partition_sched_domains(1, NULL, NULL);
 }
 
+static inline void cpuset_reset_sched_domains(void)
+{
+	partition_sched_domains(1, NULL, NULL);
+}
+
 static inline void cpuset_print_current_mems_allowed(void)
 {
 }
diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
index 6ec578600b24..f9aabbc9d22e 100644
--- a/include/linux/sched/deadline.h
+++ b/include/linux/sched/deadline.h
@@ -34,6 +34,7 @@ static inline bool dl_time_before(u64 a, u64 b)
 struct root_domain;
 extern void dl_add_task_root_domain(struct task_struct *p);
 extern void dl_clear_root_domain(struct root_domain *rd);
+extern void dl_clear_root_domain_cpu(int cpu);
 
 #endif /* CONFIG_SMP */
 
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 7f3dbafe1817..1622232bd08b 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -166,6 +166,8 @@ static inline struct cpumask *sched_domain_span(struct sched_domain *sd)
 	return to_cpumask(sd->span);
 }
 
+extern void dl_rebuild_rd_accounting(void);
+
 extern void partition_sched_domains_locked(int ndoms_new,
 					   cpumask_var_t doms_new[],
 					   struct sched_domain_attr *dattr_new);
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index f87526edb2a4..1892dc8cd211 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -954,10 +954,12 @@ static void dl_update_tasks_root_domain(struct cpuset *cs)
 	css_task_iter_end(&it);
 }
 
-static void dl_rebuild_rd_accounting(void)
+void dl_rebuild_rd_accounting(void)
 {
 	struct cpuset *cs = NULL;
 	struct cgroup_subsys_state *pos_css;
+	int cpu;
+	u64 cookie = ++dl_cookie;
 
 	lockdep_assert_held(&cpuset_mutex);
 	lockdep_assert_cpus_held();
@@ -965,11 +967,12 @@ static void dl_rebuild_rd_accounting(void)
 
 	rcu_read_lock();
 
-	/*
-	 * Clear default root domain DL accounting, it will be computed again
-	 * if a task belongs to it.
-	 */
-	dl_clear_root_domain(&def_root_domain);
+	for_each_possible_cpu(cpu) {
+		if (dl_bw_visited(cpu, cookie))
+			continue;
+
+		dl_clear_root_domain_cpu(cpu);
+	}
 
 	cpuset_for_each_descendant_pre(cs, pos_css, &top_cpuset) {
 
@@ -996,7 +999,6 @@ partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 {
 	sched_domains_mutex_lock();
 	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
-	dl_rebuild_rd_accounting();
 	sched_domains_mutex_unlock();
 }
 
@@ -1083,6 +1085,13 @@ void rebuild_sched_domains(void)
 	cpus_read_unlock();
 }
 
+void cpuset_reset_sched_domains(void)
+{
+	mutex_lock(&cpuset_mutex);
+	partition_sched_domains(1, NULL, NULL);
+	mutex_unlock(&cpuset_mutex);
+}
+
 /**
  * cpuset_update_tasks_cpumask - Update the cpumasks of tasks in the cpuset.
  * @cs: the cpuset in which each task's cpus_allowed mask needs to be changed
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 58593f4d09a1..dbf44ddbb6b4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8183,7 +8183,7 @@ static void cpuset_cpu_active(void)
 		 * operation in the resume sequence, just build a single sched
 		 * domain, ignoring cpusets.
 		 */
-		partition_sched_domains(1, NULL, NULL);
+		cpuset_reset_sched_domains();
 		if (--num_cpus_frozen)
 			return;
 		/*
@@ -8202,7 +8202,7 @@ static void cpuset_cpu_inactive(unsigned int cpu)
 		cpuset_update_active_cpus();
 	} else {
 		num_cpus_frozen++;
-		partition_sched_domains(1, NULL, NULL);
+		cpuset_reset_sched_domains();
 	}
 }
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 3e05032e9e0e..5dca336cdd7c 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -166,7 +166,7 @@ static inline unsigned long dl_bw_capacity(int i)
 	}
 }
 
-static inline bool dl_bw_visited(int cpu, u64 cookie)
+bool dl_bw_visited(int cpu, u64 cookie)
 {
 	struct root_domain *rd = cpu_rq(cpu)->rd;
 
@@ -207,7 +207,7 @@ static inline unsigned long dl_bw_capacity(int i)
 	return SCHED_CAPACITY_SCALE;
 }
 
-static inline bool dl_bw_visited(int cpu, u64 cookie)
+bool dl_bw_visited(int cpu, u64 cookie)
 {
 	return false;
 }
@@ -2981,18 +2981,22 @@ void dl_clear_root_domain(struct root_domain *rd)
 	rd->dl_bw.total_bw = 0;
 
 	/*
-	 * dl_server bandwidth is only restored when CPUs are attached to root
-	 * domains (after domains are created or CPUs moved back to the
-	 * default root doamin).
+	 * dl_servers are not tasks. Since dl_add_task_root_domain ignores
+	 * them, we need to account for them here explicitly.
 	 */
 	for_each_cpu(i, rd->span) {
 		struct sched_dl_entity *dl_se = &cpu_rq(i)->fair_server;
 
 		if (dl_server(dl_se) && cpu_active(i))
-			rd->dl_bw.total_bw += dl_se->dl_bw;
+			__dl_add(&rd->dl_bw, dl_se->dl_bw, dl_bw_cpus(i));
 	}
 }
 
+void dl_clear_root_domain_cpu(int cpu)
+{
+	dl_clear_root_domain(cpu_rq(cpu)->rd);
+}
+
 #endif /* CONFIG_SMP */
 
 static void switched_from_dl(struct rq *rq, struct task_struct *p)
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 44093339761c..363ad268a25b 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2791,6 +2791,7 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
 	ndoms_cur = ndoms_new;
 
 	update_sched_domain_debugfs();
+	dl_rebuild_rd_accounting();
 }
 
 /*
-- 
2.48.1


