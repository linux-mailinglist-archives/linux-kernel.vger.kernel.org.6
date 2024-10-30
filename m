Return-Path: <linux-kernel+bounces-389327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0569B6B65
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FFD228363F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2642144D2;
	Wed, 30 Oct 2024 17:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A6JUtBCf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A511C9B77
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 17:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730310831; cv=none; b=MWgbF+s9wbY/R/j2sCiq/4bgqAykqyEEr9wr18FBsT8y0zdBVoqavE6qvbCom/rCR6+ilgDPU54tCZNtoqu1Su2N/eRggcbAqquYJX5azpfbBQIa+1nQjiOHxzWOgt/GAlmfrgD3jJN7ZmBGOqMTLiw1ZXhfEpnretp01Kf/8Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730310831; c=relaxed/simple;
	bh=iqiLT7AoYtFh+txtnF/bx47h0urvK3MnoO68aMAsPxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZlvKqW9UCOcAqprbDeibILCc34bd6negsgIMIpBsiXD5aWhPF37BtU77nBypEP5IvR9LfxmcC2v5gYfdj0GKBHjvts7NTQ1jGz+6OKQBp9S8wuo5u0cUKXDdptbffeeGqIicSalFX0aHnUcIypoqF72qLMDy70v8+QXwV1HABs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A6JUtBCf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730310828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IB+fIq7UUdzE7rHEelrMfNY3WdXkdgYqJ24QIXo73+Q=;
	b=A6JUtBCfrYxOOvvFAVxSJswQMymATh6CFbd8oPkvtlDSDxQtPLhNHLIqfU78RU4sTQVibs
	U7bpUz1qZ6+qvM+djZpLqOrsc4YWe5wqyfIEXBTY/0ynfth+00Eu1nHOY1Uuu/Wu3qhqF5
	CA1sb9ILitJaoxqSHsrgIy6GCDVClec=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-ayc7AHyOPOGnbH4dc9afyw-1; Wed,
 30 Oct 2024 13:53:44 -0400
X-MC-Unique: ayc7AHyOPOGnbH4dc9afyw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3EC351955F42;
	Wed, 30 Oct 2024 17:53:43 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.81.200])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7FE3A19560A2;
	Wed, 30 Oct 2024 17:53:40 +0000 (UTC)
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
Subject: [RESEND PATCH v4 4/4] sched: Unify HK_TYPE_{TIMER|TICK|MISC} to HK_TYPE_KERNEL_NOISE
Date: Wed, 30 Oct 2024 13:52:53 -0400
Message-ID: <20241030175253.125248-5-longman@redhat.com>
In-Reply-To: <20241030175253.125248-1-longman@redhat.com>
References: <20240921190720.106195-1-longman@redhat.com>
 <20241030175253.125248-1-longman@redhat.com>
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
Acked-by: Frederic Weisbecker <frederic@kernel.org>
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


