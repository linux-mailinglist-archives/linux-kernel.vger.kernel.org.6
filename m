Return-Path: <linux-kernel+bounces-543526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CC4A4D6C6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB3B8188CED0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5781FCCEF;
	Tue,  4 Mar 2025 08:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a4TGY1px"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E421FC103
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741077695; cv=none; b=D6EVH7y6Yd4oL6hA/OrxpAUZN3mjM5oiObGwA7ZxNOM4hgmBUNisqArfoxICQBZqtTm6wojZJb6ov/JRg3IUNI6yEIK5v1EfW3O281uIexw/F25FjPhw3xQbdxkpj/EWBwpUZTr84VuHu/I/zAoJ/7TVcfthTCnn0xSpNipDpQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741077695; c=relaxed/simple;
	bh=JoFBG7pMXQvknknPg4p6gPlrPQ55M+46+iQsTj5LTik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WMaWxHIthagZOvRYetHB6fVh0BObj/yarmbPoemXrlbMx04ZLj/FZaG18L/9NpnNCf4G+SktOKoj/S9gHeczswVrw90wzoCmDVeVComD0zODLOxJ8rKsbA0hQdIHgLLnyIV/iyqnGhnChnCG8WHweJWGe6GNTrdoMeKlwN4/V+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a4TGY1px; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741077693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iUFSm032bQgoMPJSD653MNcg2XgGU99Y/sFQDrAbodA=;
	b=a4TGY1pxTRuzXtaMTy9Fex7biZ+umFDQmKgsNZC6lf6LksP/s3kU8KV9u4Gm8dq8CmHLlK
	buYtf1uORe+J4IaEWLSRlJHiGXKCRKIyJGVVkhKkCfAgRrGUeqfUaqQFW3FtD/7rVJM3rJ
	tOqnnNZjlC+lkDVgzmFhD2nHFN5Octw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-8W-3s1-dNOSZxfA6SdVLNg-1; Tue, 04 Mar 2025 03:41:32 -0500
X-MC-Unique: 8W-3s1-dNOSZxfA6SdVLNg-1
X-Mimecast-MFC-AGG-ID: 8W-3s1-dNOSZxfA6SdVLNg_1741077691
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c3b53373faso369689085a.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 00:41:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741077689; x=1741682489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUFSm032bQgoMPJSD653MNcg2XgGU99Y/sFQDrAbodA=;
        b=CuJALMDU/5GqVfWmvxohHRkY/yXrxOEe4VdAkSJ44Q/mRDd5kRwQ+iKAGM7oZuBd03
         kegBnxLzdwXETw2AzFLMm1R4wWuRh9rCx+56ZEMvkgooWX2gMSIHaTNkOwPldvwn3ItD
         sv4emLf1nsF96LuwRKwFZ2vmnzybF1uNq94DjTVHEn4OuK0v3oiDe1LPdF+CroQF7hMt
         FMORnQwq5HYZQcZBj8ROCmjqsPjWlRpm6lwcrmVTJRnZy/YQEgGAOxOULt0dSfU3j2aq
         ihG7x0gOGFxqTc1t5I9BpM9M4ImE7fExxUrLgFmhzBKh4OGH/z0IhY1BZRdOEA9Ut9ZK
         gpJg==
X-Gm-Message-State: AOJu0YzX+CLWM8hkE17vuOz5gKFiDjc0LwNpqB9Xl6UNXJWjdE1ICca/
	5YRjKB5SgexJNYEVxKsQ1DEJJpt5TZDBojhJ+BqFxIOtSFv9LC1r5f4xZddRL0zo34ihC4nju8l
	SNtTzgkZ3JbKj78Kkh5OXrIIIiPTPWHLC0XNw43f5i+Dbs8tufHCaL3hbkD0XMOQOafJAYMHoN7
	U1LvAYDbNWg6aAUDdDVuTaJxW5ryYGommCwvoaLe3WL+jeBb/BoGpf7w==
X-Gm-Gg: ASbGncsp9UjGBC27Bt6iZqZ7QSo52CgSmXdXZGdjF63Atgz1iSZ8gEVsSM2kBnqYiWa
	frMwr1Z+MIMZoVmIMbsS8wkuLw1kLzHZI5r8sooruRn62nxbzPJBWGqq1IIlendECQGbbqb0LjT
	qVM21luN/j+7pqkW8ptmu2ibWQ/AhdckatD+GLoFWjhhfMeCCxAv9ncSYQXOFJbXubTHojV4Q2x
	8QdCKiFXpIAQ5e6B9XL0Bl515d1lqXTnEXuv6GVeipVXZElq4F/+bzmXFk+aKARC7nOek6aP4jH
	lf+mbj05AuA/xYJFAMx+0PY/CeGCSpPFoE/Rpjd3QSZv1XoJXY/Pm8rn80g+E5xSxuIZvaD7Shs
	vK+60
X-Received: by 2002:a05:620a:2b86:b0:7c3:c1fb:3df2 with SMTP id af79cd13be357-7c3c1fb4244mr730708685a.46.1741077689661;
        Tue, 04 Mar 2025 00:41:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjbG0dTZywrc8B1o3eEIcsstcc67Y38OSW68GGeX9mfGUlHgF5MXZ2iZRf4TVMhcQvkAS5og==
X-Received: by 2002:a05:620a:2b86:b0:7c3:c1fb:3df2 with SMTP id af79cd13be357-7c3c1fb4244mr730704985a.46.1741077689282;
        Tue, 04 Mar 2025 00:41:29 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3c0a94fbbsm218395285a.1.2025.03.04.00.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 00:41:26 -0800 (PST)
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
Subject: [PATCH 4/5] sched/deadline: Rebuild root domain accounting after every update
Date: Tue,  4 Mar 2025 08:40:44 +0000
Message-ID: <20250304084045.62554-5-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304084045.62554-1-juri.lelli@redhat.com>
References: <20250304084045.62554-1-juri.lelli@redhat.com>
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
index b70d6002bb93..bdfda0ef1bd9 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2796,6 +2796,7 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
 	ndoms_cur = ndoms_new;
 
 	update_sched_domain_debugfs();
+	dl_rebuild_rd_accounting();
 }
 
 /*
-- 
2.48.1


