Return-Path: <linux-kernel+bounces-553853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E3EA58FD8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86308188FD37
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EDF225409;
	Mon, 10 Mar 2025 09:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dp3BRF3M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A898F2253E6
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599442; cv=none; b=Gyo0pSyFoWh8YvapNdDbg9412MG+9pcHu3jGhVgAA6sPqpPac7q3eTb6ijOePO9RZEisrTmMDiycT0cCgZScO9fdc77/nYn4jl9J1zk0iafq0I0AiE05CWVBoI1kSv2cnybh0DAb7l/SEZF+87buukWGH+Axxuuii+IrpPbCqME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599442; c=relaxed/simple;
	bh=dJ0qYuhLvHREJelUpJrsJhya+cYWSalYL5+mpIrhEfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTMipmCWyStOzES0Ogw9FBI/plfKitCFPajRcrC3M3yOfkZI9EH+tM4jLi4ashMibuumphN2XlzE1WFCbyVAYcVt/4yNbmjrty5nKV56xnpAewibBPbazjwvMtAQ3Zas1qafUI9Is48RxsGcEeivIeShj6gyjJLCapyvoQ1RtcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dp3BRF3M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741599439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+C55SaFeRG+WldAEv/0LRZJhn3q8mtrbeietSUyeneQ=;
	b=Dp3BRF3MHAbraPPM2qHR0TxwoRun2TmMjDWFragdU2gTGm17HTcxQ9BN1shjvkvfWNY+SG
	yQ8tXmgoe4YCj35rJZhcNe3nMl+9mNnwjqItjf4/b6c/mDfZFeLnh6CqdQZad/7T/Lvfkq
	1smMzDHBqiS6HbE+gPe4ZM1kZLWX/FA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-n0__olMSOC2SE5oakBuT9w-1; Mon, 10 Mar 2025 05:37:18 -0400
X-MC-Unique: n0__olMSOC2SE5oakBuT9w-1
X-Mimecast-MFC-AGG-ID: n0__olMSOC2SE5oakBuT9w_1741599437
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3912fc9861cso1515498f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 02:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741599435; x=1742204235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+C55SaFeRG+WldAEv/0LRZJhn3q8mtrbeietSUyeneQ=;
        b=TB8RiHnpPkT415wh8dFhXRjuP51DtgnWyRAzIUiwzBV2k6X4nSW/4S10wGh0WPaVhF
         RMx7ASDQ+P5dYng7S42+0TpO1iWvPaIfPFGi/FRsAHRldxKSaWkfY5OtJbljLqjcQVX9
         BbXQG4fplSJC8/RWp19NcsRGImJ6I5l3ACSlom6DyWlkcTSJDrC0Ey7biE94s5WMm3Lg
         Olx3HLkD1UG6FeRLGpusifla2Q2SAlkD3C82zXj4wUS9ONqtEadnY3c4r7Bx4sUSkcN0
         f6LKhZOA5frxST6ov/1k6R5qJ1CI/ije6zHngkdgdW9pmktdRjypzLd89eYGCza8aAPE
         LRPg==
X-Gm-Message-State: AOJu0Yxo3w03P4m3T3r0q3HoyZs2gY1OJMSsvFvoQWN79g1um2y0O0Bl
	KkZ6vYsVr/nqeMXALggk2vHH7ZcEpwy0ZrJmOjxWWPn5ESAo9LM/BL7j4n5ji7p5bM5lAjwNZjB
	ivRSyNWh/V7soGHwremLIxvmXkEYZAJ7CTEO4vjgUwlG4sbvWJEWHaM76DA2coj8ucjF7fm6qAm
	YjDUFn6fxJs+rTJrEO95RNKKkRZSGje3l6J4v7rud5VqpnwKH99Fk=
X-Gm-Gg: ASbGncua98MR8blTFBou9muAowQ5bKCKzLy/E+rMQ1N/yr16C8N50hZql8sysSte398
	62gzxJoF1wwh1adyx71LciUE+GqvhgJTbERlL0YHm/pxOu5YEqQJuSXa74kLgOGuqBqXaRUZoqt
	xiBsKtUR0+C+quxTorw4pQIt7CmaeDbxvE26Q/gbpUrPsa5ckDxj9/rVKZ8969CaGPeQ5PFO908
	P7AVvbXwy23YOu0gdhDKf0gkvZPRYSOxSvtTuEuK00nT2XnjErW7Wx/7dMwxx459dMl08UBRaXb
	dTfis12D8Aav2t4ShPPCY3t4ad95rEluGsswbsl9vhA=
X-Received: by 2002:a5d:6d8c:0:b0:391:275a:273f with SMTP id ffacd0b85a97d-39132d062ffmr6592140f8f.4.1741599435302;
        Mon, 10 Mar 2025 02:37:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExIpAItUyYwNwbwrEcWjE6mY/t/AxIyxf0UMVVUy7pCml0YQyGPHbTBqkpFTvPNnlmG/D4tA==
X-Received: by 2002:a5d:6d8c:0:b0:391:275a:273f with SMTP id ffacd0b85a97d-39132d062ffmr6592100f8f.4.1741599434809;
        Mon, 10 Mar 2025 02:37:14 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cfcfd2a95sm10234805e9.29.2025.03.10.02.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 02:37:13 -0700 (PDT)
Date: Mon, 10 Mar 2025 10:37:10 +0100
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
Subject: [PATCH v3 4/8] sched/deadline: Rebuild root domain accounting after
 every update
Message-ID: <Z86yxn12saDHLSy3@jlelli-thinkpadt14gen4.remote.csb>
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

Rebuilding of root domains accounting information (total_bw) is
currently broken on some cases, e.g. suspend/resume on aarch64. Problem
is that the way we keep track of domain changes and try to add bandwidth
back is convoluted and fragile.

Fix it by simplify things by making sure bandwidth accounting is cleared
and completely restored after root domains changes (after root domains
are again stable).

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
Tested-by: Waiman Long <longman@redhat.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
v2 -> v3: remove spurious dl_bw_visited declaration (Shrikanth)
---
 include/linux/sched/deadline.h |  1 +
 include/linux/sched/topology.h |  2 ++
 kernel/cgroup/cpuset.c         | 16 +++++++++-------
 kernel/sched/deadline.c        | 16 ++++++++++------
 kernel/sched/topology.c        |  1 +
 5 files changed, 23 insertions(+), 13 deletions(-)

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


