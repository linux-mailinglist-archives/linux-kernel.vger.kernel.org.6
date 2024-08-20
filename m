Return-Path: <linux-kernel+bounces-294330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 207B6958C4C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 18:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A16B81F25710
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09191B3F08;
	Tue, 20 Aug 2024 16:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="ZN42eiHZ"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9081BA87C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724171725; cv=none; b=dJ3BfwtimbSfJ5KmHdDu2brnHFnLu/av3/5WL8x6O4TAWbYSK8MNFZ/yl+J4LQ9Qei2Gvp6jkOmDdLWoKJsNuV3UDiI9c+ra/JSKQ+/9OZyiW/pLki5kE0RXUAw5AgygCtAclL2ihAUuLnm9DZzwS5jcaSUVnAz+hdKKR8WnwxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724171725; c=relaxed/simple;
	bh=ZmhmvAh2ezCJJ4PmFxbu0s4/c7f7Y3hO+tlLfSwsztc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YdOvuQEUJz+JSQ9ZrrM3CCwglWZHTfwDZLpGj7iXC1XfVE6YUE7iUFFdS+iIdaGlamLav3Hy7O8NfISdhA5QBWeWd/fPmgHCHPYZJhqIPRSmb7j5Q5mrVor3ZlzB674AL3vot6CPjr2VEOz6/yN7Qa2jgbDPTh1kpgAH2oz9sGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=ZN42eiHZ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7abe5aa9d5so615137666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1724171721; x=1724776521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQ1DK2daPE9ncuhHLypAOQVYnkEU114ByewzWSw0TA4=;
        b=ZN42eiHZCPvTwREOEJqJbGsuizb3xhvMQU+MZwMM7zwdpGQXJPR6SZZfQc6p3D/mN9
         OBtJ23dNwC5DWwNJpmSbUXMusS5vccpj7YQVygqKPqeiXdhZCn6gccNgy+Gsbjf9j3+2
         cZr7ggSGTuB73fANZfHQXOmh7FiwA/eHPo6fXHEpu35ASUbEC6aqWRzlXNeo80nRJ6To
         RXOcI+E/vyHC7ycySs3+7f5fDKDj9NTqZ47GICpek8hUBtP3p9vP67+UURg1Eq+ZT+EW
         3KNhD8the0zCN95BVUUf05GwYDBQ2KWn4kkjDTFQLurhYDTtbS/ZqF54VpcpbRIAxth/
         kq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724171721; x=1724776521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQ1DK2daPE9ncuhHLypAOQVYnkEU114ByewzWSw0TA4=;
        b=UGpoqI5mpwyn0vkaBSnUneIu1fhopod1ShXxn96xQiJEAiQ52Zi8UDZ7IE38Ixb7bM
         5k74kpbVOyiuGuluigOEmB47oNxQgsm0TtHUUB1DdZMslAiLpAcajNy73DiLBGFOUZ43
         F38eCuMSSXwzQyTYN6EXdEXutviFxri/+yN/dsQL12hP4jeZ4IEnNrz0gs5sTen0Z6/6
         jzv1VAJoJPaRMrL3957NnFsldsBRAm2zzfXOltZ00IeP5hfPpq2jnrjx05bL8Jm4AO8o
         2ylyOGS7FhbCyuorMbKC69pY7YXa6QBPUQTi0aDuaJ2Jn3Kkme0kVM+QqweDdHOV4THZ
         ahug==
X-Forwarded-Encrypted: i=1; AJvYcCWMKiqCb3zTPLkZau5Z5IxiiK/kNRKShoi6dq/y5yoMZ6lhnkIfU9H0gVDH4r11aAAU+BHoYxphdXadVW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YynwcFKzKE0jJy+wgjIXSc2NMPxCeKVSGRYdtfMlRtlKz7mD0kV
	rjZLeOa2VDWUc3Dy2XHzt+l/11dIW8C2NfPiZTwZo2f2lVqs4gF0t34gQGuXql0=
X-Google-Smtp-Source: AGHT+IGJIEiqfLHFXG+Ko/nMDgS5J7g2UwUVQhLX/Pve1qWCglcSM9ewImEX+qVu2VF8smMRoWdXuQ==
X-Received: by 2002:a17:907:72cb:b0:a6f:27e6:8892 with SMTP id a640c23a62f3a-a8392a38c8dmr1018867866b.60.1724171720898;
        Tue, 20 Aug 2024 09:35:20 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfb5esm780728766b.59.2024.08.20.09.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 09:35:20 -0700 (PDT)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	John Stultz <jstultz@google.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qais Yousef <qyousef@layalina.io>
Subject: [RFC PATCH 05/16] sched: cpufreq: Remove magic 1.25 headroom from sugov_apply_dvfs_headroom()
Date: Tue, 20 Aug 2024 17:35:01 +0100
Message-Id: <20240820163512.1096301-6-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820163512.1096301-1-qyousef@layalina.io>
References: <20240820163512.1096301-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace 1.25 headroom in sugov_apply_dvfs_headroom() with better dynamic
logic.

Instead of the magical 1.25 headroom, use the new approximate_util_avg()
to provide headroom based on the dvfs_update_delay, which is the period
at which the cpufreq governor will send DVFS updates to the hardware, or
min(curr.se.slice, TICK_USEC) which is the max delay for util signal to
change and promote a cpufreq update; whichever is higher.

Add a new percpu dvfs_update_delay that can be cheaply accessed whenever
sugov_apply_dvfs_headroom() is called. We expect cpufreq governors that
rely on util to drive its DVFS logic/algorithm to populate these percpu
variables. schedutil is the only such governor at the moment.

The behavior of schedutil will change. Some systems will experience
faster dvfs rampup (because of higher TICK or rate_limit_us), others
will experience slower rampup.

The impact on performance should not be visible if not for the black
hole effect of utilization invariance. A problem that will be addressed
in later patches.

Later patches will also address how to provide better control of how
fast or slow the system should respond to allow userspace to select
their power/perf/thermal trade-off.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 kernel/sched/core.c              |  1 +
 kernel/sched/cpufreq_schedutil.c | 36 ++++++++++++++++++++++++++------
 kernel/sched/sched.h             |  9 ++++++++
 3 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 402ee4947ef0..7099e40cc8bd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -118,6 +118,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
+DEFINE_PER_CPU_READ_MOSTLY(u64, dvfs_update_delay);
 
 #ifdef CONFIG_SCHED_DEBUG
 /*
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 575df3599813..303b0ab227e7 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -187,13 +187,28 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
  * to run at adequate performance point.
  *
  * This function provides enough headroom to provide adequate performance
- * assuming the CPU continues to be busy.
+ * assuming the CPU continues to be busy. This headroom is based on the
+ * dvfs_update_delay of the cpufreq governor or min(curr.se.slice, TICK_US),
+ * whichever is higher.
  *
- * At the moment it is a constant multiplication with 1.25.
+ * XXX: Should we provide headroom when the util is decaying?
  */
-static inline unsigned long sugov_apply_dvfs_headroom(unsigned long util)
+static inline unsigned long sugov_apply_dvfs_headroom(unsigned long util,  int cpu)
 {
-	return util + (util >> 2);
+	struct rq *rq = cpu_rq(cpu);
+	u64 delay;
+
+	/*
+	 * What is the possible worst case scenario for updating util_avg, ctx
+	 * switch or TICK?
+	 */
+	if (rq->cfs.h_nr_running > 1)
+		delay = min(rq->curr->se.slice/1000, TICK_USEC);
+	else
+		delay = TICK_USEC;
+	delay = max(delay, per_cpu(dvfs_update_delay, cpu));
+
+	return approximate_util_avg(util, delay);
 }
 
 unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
@@ -201,7 +216,7 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
 				 unsigned long max)
 {
 	/* Add dvfs headroom to actual utilization */
-	actual = sugov_apply_dvfs_headroom(actual);
+	actual = sugov_apply_dvfs_headroom(actual, cpu);
 	/* Actually we don't need to target the max performance */
 	if (actual < max)
 		max = actual;
@@ -579,15 +594,21 @@ rate_limit_us_store(struct gov_attr_set *attr_set, const char *buf, size_t count
 	struct sugov_tunables *tunables = to_sugov_tunables(attr_set);
 	struct sugov_policy *sg_policy;
 	unsigned int rate_limit_us;
+	int cpu;
 
 	if (kstrtouint(buf, 10, &rate_limit_us))
 		return -EINVAL;
 
 	tunables->rate_limit_us = rate_limit_us;
 
-	list_for_each_entry(sg_policy, &attr_set->policy_list, tunables_hook)
+	list_for_each_entry(sg_policy, &attr_set->policy_list, tunables_hook) {
+
 		sg_policy->freq_update_delay_ns = rate_limit_us * NSEC_PER_USEC;
 
+		for_each_cpu(cpu, sg_policy->policy->cpus)
+			per_cpu(dvfs_update_delay, cpu) = rate_limit_us;
+	}
+
 	return count;
 }
 
@@ -868,6 +889,9 @@ static int sugov_start(struct cpufreq_policy *policy)
 		memset(sg_cpu, 0, sizeof(*sg_cpu));
 		sg_cpu->cpu = cpu;
 		sg_cpu->sg_policy = sg_policy;
+
+		per_cpu(dvfs_update_delay, cpu) = sg_policy->tunables->rate_limit_us;
+
 		cpufreq_add_update_util_hook(cpu, &sg_cpu->update_util, uu);
 	}
 	return 0;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ab4672675b84..c2d9fba6ea7a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3068,6 +3068,15 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
 unsigned long approximate_util_avg(unsigned long util, u64 delta);
 u64 approximate_runtime(unsigned long util);
 
+/*
+ * Any governor that relies on util signal to drive DVFS, must populate these
+ * percpu dvfs_update_delay variables.
+ *
+ * It should describe the rate/delay at which the governor sends DVFS freq
+ * update to the hardware in us.
+ */
+DECLARE_PER_CPU_READ_MOSTLY(u64, dvfs_update_delay);
+
 /*
  * Verify the fitness of task @p to run on @cpu taking into account the
  * CPU original capacity and the runtime/deadline ratio of the task.
-- 
2.34.1


