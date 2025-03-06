Return-Path: <linux-kernel+bounces-549093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBC7A54D18
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACCD516C7D9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD521624FA;
	Thu,  6 Mar 2025 14:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOZn289U"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20004155308
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 14:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270274; cv=none; b=NJPaRWwKAgAoqNouy6xtd/RUdk6dXYVX7F24hUGoym2rdnCELoZOk0vFOhfWZ1746Jd6MnOOszdNWFwU1XOVxNAMVDg28o7YhE8cPt9CTt2ryYr/4p9jmNHNqXXk9t3RhmgVr0JUEMOhdbWxgKxJ0nolwqg212abtwiym2rFOn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270274; c=relaxed/simple;
	bh=72vgfzS/NoqpzjzSUDCO8wd5QQDPCLgcmhF+lVelQns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DmENOv9P/ikWJCWeCBL9GtqZz2MTpV9RXaczfcqExwj4h+BDXtdq0D+nLSTv31i9vOYMcgQNku/pIC1tF85SOd181/KOl6rE8FxIliWvf7LAVH36MzS9O8z9LRsLMNfF42ikfYMG3fAhZjop7XRD0H3N8ldDnPSvF+2ylXbwj/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SOZn289U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741270272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dAqrxFos5baxMMm+58GJv+qJfXrJ7okyTkO5C9Q+Myk=;
	b=SOZn289UkmRhMI2o+vpqjTCnStpQIlsvdsPAaShLtwuA7lttgugQqxskM2tkLYo+ny+dkH
	CD6sFM5z2jwHEsfvk73X20WaLrxkTakB+i/PtroKK7M3mlr4B0MmmO6FBusOF74lZMNdum
	tnag+ntnoYu2FfSie7IFSlB5jR81gSk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-xUJKRUB7Nq-868c0ziokpg-1; Thu, 06 Mar 2025 09:11:01 -0500
X-MC-Unique: xUJKRUB7Nq-868c0ziokpg-1
X-Mimecast-MFC-AGG-ID: xUJKRUB7Nq-868c0ziokpg_1741270260
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c3c8f8ab79so127831485a.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 06:11:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741270260; x=1741875060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAqrxFos5baxMMm+58GJv+qJfXrJ7okyTkO5C9Q+Myk=;
        b=X4yDBaV6Ih81f23zdD2fSZjFdE2iYuDiAaKDRYzZNTen2HQheg8ouJWQNuehr0gIfg
         2JKJvLQUP3RN91iWQ6Ltt+H0n32WLw/v3R9QoFIK3NbiXqpfu+tL5Ft98Yu+ptjQO9JY
         /3EmXY0eWJRXvlZK48zKUGLrmXOjuoQ4d+ecDQUatFOaUOHrVtUImZQamIEjEkdyZ5UY
         6+2IIVzyYAVGzUBjAy3zubnhn9ZtylAjUPT/quBQ8y467SltM3iUIElu65xPTBhteSWh
         ORwh7Hvl2uaej1Nmv8dNi+CpUilHBnzjaHWf58dPHvxB1K0QHInChoHlRdI7JKaaVrHq
         RrwA==
X-Gm-Message-State: AOJu0Ywslj7lUV9VXtVDE/AubNzh1Qi4NulVMgdDPimzu68m5ZStg/Ua
	L1Y/TKbMi20BY3yGIueSvokJWMqencl4x/yUxkdhOUcrq3plsDRkU4xzvKqy8AWdUhUvvUNgjN/
	bGMXFywf17PEs62qG7Z58l8SkYQT0qryZ1iohTPXi3etVZmMrOAkon1MLnivXCsYOoHYygpsqxf
	TvEQCXNwZt2RVwlqOIFzn2gmEpmIjv8svhxHLkf4rqyMFIUf1vMls=
X-Gm-Gg: ASbGnctLkxUpNd2ffIgfsImz1NEhPh9zET6USbKgSJzP0AUP8oCpnt9Vukqw/z2Q7lG
	fzTdYJfDCGNJZe3BoUzTBfiDemp4D5/Cm7hUIfZLbU5bV4oBzaQE70vMYHIACMNL2dBUP83nPnr
	jq3K9cEW7lpsAHZVav6YzQzgXoyoN0DCfZs6+SXNVEKaGm3vqICHBNNr47wxYdZBnNB+NIzTtLA
	ZWOQxT4ydN/93VzXaOCB0cHX2m2rHJVQZFLdWj+gMGhR2wgJD07DoeOLC3zWs3Jt39NRTMFMpnh
	vS8gnuuVCwl7BvD4CkqTxF08zSYhThiFrBczhMKWF6tcfbGmwy0vn54s23ZR2sSoDbEP4htHcnZ
	UL4cr
X-Received: by 2002:a05:620a:8085:b0:7c0:ac2a:ec2 with SMTP id af79cd13be357-7c3d8bd2980mr967718885a.2.1741270260275;
        Thu, 06 Mar 2025 06:11:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG771ZEB7JVBEk+ccelxoIpVf1FwI0733+VbrstNGFZVGij6ibDc85fMk4i+GYeD/BM+tseog==
X-Received: by 2002:a05:620a:8085:b0:7c0:ac2a:ec2 with SMTP id af79cd13be357-7c3d8bd2980mr967713185a.2.1741270259808;
        Thu, 06 Mar 2025 06:10:59 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e551119fsm93658985a.108.2025.03.06.06.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 06:10:57 -0800 (PST)
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>,
	luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH v2 4/8] sched/deadline: Rebuild root domain accounting after every update
Date: Thu,  6 Mar 2025 14:10:12 +0000
Message-ID: <20250306141016.268313-5-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306141016.268313-1-juri.lelli@redhat.com>
References: <20250306141016.268313-1-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rebuilding of root domains accounting information (total_bw) is
currently broken on some cases, e.g. suspend/resume on aarch64. Problem
is that the way we keep track of domain changes and try to add bandwidth
back is convoluted and fragile.

Fix it by simplify things by making sure bandwidth accounting is cleared
and completely restored after root domains changes (after root domains
are again stable).

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 include/linux/sched/deadline.h |  4 ++++
 include/linux/sched/topology.h |  2 ++
 kernel/cgroup/cpuset.c         | 16 +++++++++-------
 kernel/sched/deadline.c        | 16 ++++++++++------
 kernel/sched/topology.c        |  1 +
 5 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
index 6ec578600b24..a780068aa1a5 100644
--- a/include/linux/sched/deadline.h
+++ b/include/linux/sched/deadline.h
@@ -34,6 +34,10 @@ static inline bool dl_time_before(u64 a, u64 b)
 struct root_domain;
 extern void dl_add_task_root_domain(struct task_struct *p);
 extern void dl_clear_root_domain(struct root_domain *rd);
+extern void dl_clear_root_domain_cpu(int cpu);
+
+extern u64 dl_cookie;
+extern bool dl_bw_visited(int cpu, u64 gen);
 
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
index f87526edb2a4..f66b2aefdc04 100644
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
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 339434271cba..17b040c92885 100644
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
+	 * dl_servers are not tasks. Since dl_add_task_root_domanin ignores
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


