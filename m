Return-Path: <linux-kernel+bounces-389324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 380FE9B6B62
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C743328286C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54F61C9EB4;
	Wed, 30 Oct 2024 17:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ise4C7d1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299EF194138
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 17:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730310820; cv=none; b=k1ZIg7jI68hoE+cuqHdAy4UXj6ES/pVu3zWGCOx2iRbwJDfcU4WpkH+uncz6L5r2QRNiNqgNny1XbdBdYrxv5RrfGYvhugAQBBOw8ow2XUdrf+dz5zS0XpQpZQmfiEUtvFvmgC8Fexu1cPkXYkRwJVHziX+Nf0TLup7QUaxYuOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730310820; c=relaxed/simple;
	bh=X77KITlwJmbdbWpDqkHXNwuU9228E2WwcmoO/xNvEHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4MJXcz1CRCP2n+4wNEZfD1OFLffUturKfb2jOW445g9XjUaRIpgHK6x+DfbwQdvzmk7BLOOOPGaMyDzMReAVPOUDJPNwSM+cX/QGTvDwVn9kl36Ymt/bKbgTvDHrtpMwsly8MElbZFQAiQrHd1lnkj0ba4kvBBMbRx/EIcGnnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ise4C7d1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730310817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tzYePkSzdUHZxKhahOcUHMkyyEiJ4JD4O1Ou8UL6sUc=;
	b=ise4C7d1mGLrw6RHalbaM83u1U91lghxXvzos8qiWobUhnebbh2DFJosc5ZigvzW3av9F/
	IgrmF0yIRSNJFkNKu9sx10b6qCMHhzjImUqq3kcHMcvS3UAbpsdzg6L6ssfTvNqrvFQexs
	nUuPQJ/f5V5Alz6s/clpWlwNb0GvhAI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-ouK1QbSSOq6o9TaAZNsK0g-1; Wed,
 30 Oct 2024 13:53:36 -0400
X-MC-Unique: ouK1QbSSOq6o9TaAZNsK0g-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 800711955F45;
	Wed, 30 Oct 2024 17:53:34 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.81.200])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8C37B19560A2;
	Wed, 30 Oct 2024 17:53:31 +0000 (UTC)
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
Subject: [RESEND PATCH v4 1/4] sched/core: Remove HK_TYPE_SCHED
Date: Wed, 30 Oct 2024 13:52:50 -0400
Message-ID: <20241030175253.125248-2-longman@redhat.com>
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

The HK_TYPE_SCHED housekeeping type is defined but not set anywhere. So
any code that try to use HK_TYPE_SCHED are essentially dead code. So
remove HK_TYPE_SCHED and any code that use it.

Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/sched/isolation.h |  1 -
 kernel/sched/fair.c             | 14 --------------
 kernel/sched/isolation.c        |  1 -
 3 files changed, 16 deletions(-)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index 2b461129d1fa..499d5e480882 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -10,7 +10,6 @@ enum hk_type {
 	HK_TYPE_TIMER,
 	HK_TYPE_RCU,
 	HK_TYPE_MISC,
-	HK_TYPE_SCHED,
 	HK_TYPE_TICK,
 	HK_TYPE_DOMAIN,
 	HK_TYPE_WQ,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b9784e13e6b6..f76690c15bfe 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12202,9 +12202,6 @@ static inline int on_null_domain(struct rq *rq)
  * - When one of the busy CPUs notices that there may be an idle rebalancing
  *   needed, they will kick the idle load balancer, which then does idle
  *   load balancing for all the idle CPUs.
- *
- * - HK_TYPE_MISC CPUs are used for this task, because HK_TYPE_SCHED is not set
- *   anywhere yet.
  */
 static inline int find_new_ilb(void)
 {
@@ -12449,10 +12446,6 @@ void nohz_balance_enter_idle(int cpu)
 	if (!cpu_active(cpu))
 		return;
 
-	/* Spare idle load balancing on CPUs that don't want to be disturbed: */
-	if (!housekeeping_cpu(cpu, HK_TYPE_SCHED))
-		return;
-
 	/*
 	 * Can be set safely without rq->lock held
 	 * If a clear happens, it will have evaluated last additions because
@@ -12672,13 +12665,6 @@ static void nohz_newidle_balance(struct rq *this_rq)
 {
 	int this_cpu = this_rq->cpu;
 
-	/*
-	 * This CPU doesn't want to be disturbed by scheduler
-	 * housekeeping
-	 */
-	if (!housekeeping_cpu(this_cpu, HK_TYPE_SCHED))
-		return;
-
 	/* Will wake up very soon. No time for doing anything else*/
 	if (this_rq->avg_idle < sysctl_sched_migration_cost)
 		return;
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 5891e715f00d..5345e11f3d44 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -12,7 +12,6 @@ enum hk_flags {
 	HK_FLAG_TIMER		= BIT(HK_TYPE_TIMER),
 	HK_FLAG_RCU		= BIT(HK_TYPE_RCU),
 	HK_FLAG_MISC		= BIT(HK_TYPE_MISC),
-	HK_FLAG_SCHED		= BIT(HK_TYPE_SCHED),
 	HK_FLAG_TICK		= BIT(HK_TYPE_TICK),
 	HK_FLAG_DOMAIN		= BIT(HK_TYPE_DOMAIN),
 	HK_FLAG_WQ		= BIT(HK_TYPE_WQ),
-- 
2.43.5


