Return-Path: <linux-kernel+bounces-334933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6B497DE74
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 21:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7406A281DC2
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 19:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4307DA62;
	Sat, 21 Sep 2024 19:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gI5L1tCu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECEA84D02
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 19:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726945700; cv=none; b=D17jMxPmaVcGqR8pnz3FZRI+06FKEajj11vfJhzdI5hQ67IkW85FkIjttyDDA6frkQZoZ4ElET5h+6bPtYwHRhMYgntoYSVLV/3TV5naScEMQF+0y2hMoN9Nj9eUW+v2GthlgT8Fbrs1OlhQ+9cWrbt2oLgv2uZ9rw0zwrJdq98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726945700; c=relaxed/simple;
	bh=I5z8KfkbyY6LrOPBboRcLTcgir1/WS/06RX1b/K8XPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VPU5JaMUrLToqHq41UJnp9+iwJOTS/rwJ87NBYTJUwiabeijj/ODUibcEyJF8qbLZMHn1CCmZKX82sWqmnZXktIcWuRLkGpZRSMwRfHfazgr8VtafgIsp01wDTb+LW/MwmW/6ygfXs4MHpxw5aEnuKqOlG704k38X4gZgGSeURc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gI5L1tCu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726945697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i+ujuK4NVoJhhXN+rtx0sM9reuyr8LRm8/o1/7F4LpU=;
	b=gI5L1tCuVivtTBJUPtsYZ2sGRo9Vgs36ZXZqKe5Dr7wqVh5nZgcPMQBRMk5o6H262wOFY6
	Wjx1bExe0bjp3A9OLv6gMLs9wqrioSVYNMHmCLbVUnMCcv1vYsEbKFCgRc5wRFdWS0FN9a
	VKUVcrMC+g3UVd5/gBtkO+SxTdGBCTk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-Ivkio_g0OWip3maM5fKmXQ-1; Sat,
 21 Sep 2024 15:08:12 -0400
X-MC-Unique: Ivkio_g0OWip3maM5fKmXQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D2B701936B83;
	Sat, 21 Sep 2024 19:08:10 +0000 (UTC)
Received: from llong.com (unknown [10.45.224.27])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 31C7919560AB;
	Sat, 21 Sep 2024 19:08:05 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Phil Auld <pauld@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v4 4/4] sched: Unify HK_TYPE_{TIMER|TICK|MISC} to HK_TYPE_KERNEL_NOISE
Date: Sat, 21 Sep 2024 15:07:20 -0400
Message-ID: <20240921190720.106195-5-longman@redhat.com>
In-Reply-To: <20240921190720.106195-1-longman@redhat.com>
References: <20240921190720.106195-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

As all the non-domain and non-managed_irq housekeeping types have been
unified to HK_TYPE_KERNEL_NOISE, replace all these references in the
scheduler to use HK_TYPE_KERNEL_NOISE.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/core.c | 12 ++++++------
 kernel/sched/fair.c |  5 +++--
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a7af49b3a337..3412d0046d08 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1114,13 +1114,13 @@ int get_nohz_timer_target(void)
 	struct sched_domain *sd;
 	const struct cpumask *hk_mask;
 
-	if (housekeeping_cpu(cpu, HK_TYPE_TIMER)) {
+	if (housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE)) {
 		if (!idle_cpu(cpu))
 			return cpu;
 		default_cpu = cpu;
 	}
 
-	hk_mask = housekeeping_cpumask(HK_TYPE_TIMER);
+	hk_mask = housekeeping_cpumask(HK_TYPE_KERNEL_NOISE);
 
 	guard(rcu)();
 
@@ -1135,7 +1135,7 @@ int get_nohz_timer_target(void)
 	}
 
 	if (default_cpu == -1)
-		default_cpu = housekeeping_any_cpu(HK_TYPE_TIMER);
+		default_cpu = housekeeping_any_cpu(HK_TYPE_KERNEL_NOISE);
 
 	return default_cpu;
 }
@@ -5526,7 +5526,7 @@ void sched_tick(void)
 	unsigned long hw_pressure;
 	u64 resched_latency;
 
-	if (housekeeping_cpu(cpu, HK_TYPE_TICK))
+	if (housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE))
 		arch_scale_freq_tick();
 
 	sched_clock_tick();
@@ -5652,7 +5652,7 @@ static void sched_tick_start(int cpu)
 	int os;
 	struct tick_work *twork;
 
-	if (housekeeping_cpu(cpu, HK_TYPE_TICK))
+	if (housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE))
 		return;
 
 	WARN_ON_ONCE(!tick_work_cpu);
@@ -5673,7 +5673,7 @@ static void sched_tick_stop(int cpu)
 	struct tick_work *twork;
 	int os;
 
-	if (housekeeping_cpu(cpu, HK_TYPE_TICK))
+	if (housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE))
 		return;
 
 	WARN_ON_ONCE(!tick_work_cpu);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f76690c15bfe..08a3d024faf9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12208,7 +12208,7 @@ static inline int find_new_ilb(void)
 	const struct cpumask *hk_mask;
 	int ilb_cpu;
 
-	hk_mask = housekeeping_cpumask(HK_TYPE_MISC);
+	hk_mask = housekeeping_cpumask(HK_TYPE_KERNEL_NOISE);
 
 	for_each_cpu_and(ilb_cpu, nohz.idle_cpus_mask, hk_mask) {
 
@@ -12226,7 +12226,8 @@ static inline int find_new_ilb(void)
  * Kick a CPU to do the NOHZ balancing, if it is time for it, via a cross-CPU
  * SMP function call (IPI).
  *
- * We pick the first idle CPU in the HK_TYPE_MISC housekeeping set (if there is one).
+ * We pick the first idle CPU in the HK_TYPE_KERNEL_NOISE housekeeping set
+ * (if there is one).
  */
 static void kick_ilb(unsigned int flags)
 {
-- 
2.43.5


