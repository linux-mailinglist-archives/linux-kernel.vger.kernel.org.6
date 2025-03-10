Return-Path: <linux-kernel+bounces-553662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CB7A58D1F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8C2A188C50A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 07:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EDB221DAD;
	Mon, 10 Mar 2025 07:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MAYhvrcT"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB11B1D432D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 07:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741592489; cv=none; b=BaJndY0XvHcTLy2C83W7LmJvZSGrbNzBSZL9wj1aql7dvooyUQzHBUbMJ1+6CH5OVQfXHBotSsX32mr1vbNaymVDchqwdwSUzJHJNywjxu5qHANS2KOi6USzb4y3ZViPu3QDKHOgAX9ht71UEVaZPQiV5GPHYlaOX/q9JlhzjUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741592489; c=relaxed/simple;
	bh=vGX1zZeyBUsAgrkJbutMKfYx2NdUHuzc2vegG+Gno5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E8pcWuwWIqUCd52yA8tJESwfs9FnJxJxO+OW2h/zKTD0ab8oVn7NS3JdHzhLqyF2u7KtWr/eEaySsa4NulYcmGwxccQk00gcszmpS8hS7ZPwPSBXq/LvHp2TlFAcEDFQYk4mDSnaee4pXBo0HqFYtmIpuZFWmhG/SL/wC8aASqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MAYhvrcT; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2f9b8ef4261so1060569a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 00:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741592487; x=1742197287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dh8E4zDhLTARv9NUB68GSwh8EhGffaLB5aJyMHyTj1k=;
        b=MAYhvrcTs+q7o+we5PWLg0wF3Ro5dzmBIo8tYvoFK2T5T0dlXx+zkiBOIWxUcLGmEE
         Pn7yZhPEGkbs9BCpGom+3kiBt2QQRisAOYwjq1ftKxdrtT5N6kxTerlHUJ8PSu3vSQBN
         kqsOr1IGlbFvkNb+nlSDC891mQ/NSST8deE5tw7gAcv2QlKilFLGmysIWQ1dpP7ZjWeA
         MrsXziZf063ovMztR/zwSgGrYVy06i/wrZewj4+zQSVhgc+GITYvhT/gvXI/yCgx3KUg
         4/izpNcPKeQGbTK7LJXa1JcbjwGeQ81wTbnTfjslxqZfTPEe1qzPSfqk8JfhpV84O+tK
         1aCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741592487; x=1742197287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dh8E4zDhLTARv9NUB68GSwh8EhGffaLB5aJyMHyTj1k=;
        b=xO+qgeiQRscNs10ct8FbjgJF20Mq/RS8UDw1WhxqJxiE+ZEl+i6GvuGrq4pZTbIAYD
         8MFmo7iwfR4t+1JSqBX2CNsKYXv77P70mm6zCyuBaBbke07pulRgNCciFFEtyLq+Dwob
         RGaZURQyVI/5UT/kCJ8B/UEkqo0mjp9ybptoijGh9S9wnsrUsgP8AuqCMrKXserihnlx
         gQ8IWYq6/ieun+EnWGL6aQ42xVFJPcuP/1/SwRaTg8P26IySXeHlohxuNpMAjw+Un7Nx
         qK8cZW32QXszurhZINJUgnk2OOuyuAdvKW7TrpNxROYxBggfmDTPf3CYv/iymJRaPypN
         ft7A==
X-Forwarded-Encrypted: i=1; AJvYcCXWEJcAzFiq54YJlIMT5aoRfRMfwITS2qnnH6OCUAduC0thZHxU7/11z3s34kOrz84oewqtfA9J3niuMVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdJG4YL96dsdMsWvyiFB3aI6NwzE7Bpmq/7hrnPuf5BeTykZlO
	gbt70Z8R0uFrhJr+k6I9JbCgETkuKKK2eUyv1ZJMLeRfoepXBbFRI8hbOAnLwgc=
X-Gm-Gg: ASbGncsjlj1ru+Uz5thNYRlJgy61dnJjVBa9rjQsisUR0Tad93fpe2pmM6OCpASRD2a
	e5RI1rGfdzf3H1/2LVKZTpksuM+YlmOCKDZ+1cMVTbuiswJpuPcRoeJMNu+1WGg+ELoClVe6spm
	hKphhb0p6qibkIFrY5KAwEDcDKvCICjVEtI6WTwq5xZcPymu5iHL3Dx3Y+V0oV9sl3OisG8ya+a
	jEI3iz5yHHAo5CqyX3TL5i1zUmfvUwAjVNH00HpAm8UfC62pCLDqOWkGG7t1fNqMaYXKGDb+okv
	ZuApWDin/DZe3srNGWs6+J+sMujLhdzlpgagQUysyGBgosxXryTaFv4CyA4Wn6+fRH41DIs2JVy
	VyrlbdhqJ10m4LQejBxbxzaI=
X-Google-Smtp-Source: AGHT+IESvE/mFrsTRU+L5++44F7Z7QlW0OQ1Idyr1KvoR8N3dhzhzi2+Za3PQspS0oHZAD4JWBagXg==
X-Received: by 2002:a17:90b:1a90:b0:2ff:682b:b754 with SMTP id 98e67ed59e1d1-300a2b70cb9mr4748321a91.2.1741592486638;
        Mon, 10 Mar 2025 00:41:26 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f8b6sm70965225ad.136.2025.03.10.00.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 00:41:26 -0700 (PDT)
From: Abel Wu <wuyun.abel@bytedance.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Josh Don <joshdon@google.com>,
	Tianchen Ding <dtcccc@linux.alibaba.com>
Cc: Abel Wu <wuyun.abel@bytedance.com>,
	linux-kernel@vger.kernel.org (open list:SCHEDULER)
Subject: [RFC PATCH 1/2] Revert "sched/fair: Make sched-idle CPU selection consistent throughout"
Date: Mon, 10 Mar 2025 15:40:41 +0800
Message-Id: <20250310074044.3656-2-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250310074044.3656-1-wuyun.abel@bytedance.com>
References: <20250310074044.3656-1-wuyun.abel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 17346452b25b98acfb395d2a82ec2e4ad0cb7a01.

The above commit tried to unify selection policy between idle cpus
and SCHED_IDLE ones in fast- and slow-path of select_task_rq_fair()
by treating them equally (although the SCHED_IDLE cpus are turned
to be given more preference in slowpath). The test results seemed
solid, but the setup didn't take cgroup hierarchy into account,
which actually made some of our important services get affected.

The cgroup hierarchy in our production environment looks like below,
which might be common in modern containerized setup:

			  root
			/	\
		kubepods	system.slice
		/	\\		\
	guaranteed	besteffort	containerd

	(where 'X=A' means A is SCHED_IDLE cgroup)

The cpu is treated as SCHED_IDLE if only besteffort is running, which
is given at least equal preference as the idle cpus when deciding where
to run a newly woken task. But the SCHED_IDLE cpus do not necessarily
mean they can be preempted soon enough to start serving the wakee, and
containerd and other services under system.slice are the case that have
to wait in runqueue since they can not preempt kubepods, while idle cpus
are possible out there untouched.

So prioritize idle cpus over SCHED_IDLE ones to avoid undesired delay
like orchestration operations as much as possible.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 kernel/sched/fair.c | 49 +++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ae0350088ac1..379764bd2795 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7446,7 +7446,7 @@ sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *
 	unsigned int min_exit_latency = UINT_MAX;
 	u64 latest_idle_timestamp = 0;
 	int least_loaded_cpu = this_cpu;
-	int shallowest_idle_cpu = -1;
+	int shallowest_idle_cpu = -1, si_cpu = -1;
 	int i;
 
 	/* Check if we have any choice: */
@@ -7460,9 +7460,6 @@ sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *
 		if (!sched_core_cookie_match(rq, p))
 			continue;
 
-		if (sched_idle_cpu(i))
-			return i;
-
 		if (available_idle_cpu(i)) {
 			struct cpuidle_state *idle = idle_get_state(rq);
 			if (idle && idle->exit_latency < min_exit_latency) {
@@ -7484,7 +7481,12 @@ sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *
 				latest_idle_timestamp = rq->idle_stamp;
 				shallowest_idle_cpu = i;
 			}
-		} else if (shallowest_idle_cpu == -1) {
+		} else if (shallowest_idle_cpu == -1 && si_cpu == -1) {
+			if (sched_idle_cpu(i)) {
+				si_cpu = i;
+				continue;
+			}
+
 			load = cpu_load(cpu_rq(i));
 			if (load < min_load) {
 				min_load = load;
@@ -7493,7 +7495,11 @@ sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *
 		}
 	}
 
-	return shallowest_idle_cpu != -1 ? shallowest_idle_cpu : least_loaded_cpu;
+	if (shallowest_idle_cpu != -1)
+		return shallowest_idle_cpu;
+	if (si_cpu != -1)
+		return si_cpu;
+	return least_loaded_cpu;
 }
 
 static inline int sched_balance_find_dst_cpu(struct sched_domain *sd, struct task_struct *p,
@@ -7549,11 +7555,14 @@ static inline int sched_balance_find_dst_cpu(struct sched_domain *sd, struct tas
 	return new_cpu;
 }
 
-static inline int __select_idle_cpu(int cpu, struct task_struct *p)
+static inline int __select_idle_cpu(int cpu, struct task_struct *p, int *si_cpu)
 {
-	if ((available_idle_cpu(cpu) || sched_idle_cpu(cpu)) &&
-	    sched_cpu_cookie_match(cpu_rq(cpu), p))
+	if (!sched_cpu_cookie_match(cpu_rq(cpu), p))
+		return -1;
+	if (available_idle_cpu(cpu))
 		return cpu;
+	if (*si_cpu == -1 && sched_idle_cpu(cpu))
+		*si_cpu = cpu;
 
 	return -1;
 }
@@ -7649,7 +7658,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
  */
 static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
 {
-	int cpu;
+	int cpu, si_cpu = -1;
 
 	for_each_cpu_and(cpu, cpu_smt_mask(target), p->cpus_ptr) {
 		if (cpu == target)
@@ -7660,11 +7669,13 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
 		 */
 		if (!cpumask_test_cpu(cpu, sched_domain_span(sd)))
 			continue;
-		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
+		if (available_idle_cpu(cpu))
 			return cpu;
+		if (si_cpu == -1 && sched_idle_cpu(cpu))
+			si_cpu = cpu;
 	}
 
-	return -1;
+	return si_cpu;
 }
 
 #else /* CONFIG_SCHED_SMT */
@@ -7680,7 +7691,7 @@ static inline bool test_idle_cores(int cpu)
 
 static inline int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
 {
-	return __select_idle_cpu(core, p);
+	return __select_idle_cpu(core, p, idle_cpu);
 }
 
 static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
@@ -7728,10 +7739,10 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 						return i;
 				} else {
 					if (--nr <= 0)
-						return -1;
-					idle_cpu = __select_idle_cpu(cpu, p);
-					if ((unsigned int)idle_cpu < nr_cpumask_bits)
 						return idle_cpu;
+					i = __select_idle_cpu(cpu, p, &idle_cpu);
+					if ((unsigned int)i < nr_cpumask_bits)
+						return i;
 				}
 			}
 			cpumask_andnot(cpus, cpus, sched_group_span(sg));
@@ -7746,9 +7757,9 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 
 		} else {
 			if (--nr <= 0)
-				return -1;
-			idle_cpu = __select_idle_cpu(cpu, p);
-			if ((unsigned int)idle_cpu < nr_cpumask_bits)
+				return idle_cpu;
+			i = __select_idle_cpu(cpu, p, &idle_cpu);
+			if ((unsigned int)i < nr_cpumask_bits)
 				break;
 		}
 	}
-- 
2.37.3


