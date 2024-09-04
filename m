Return-Path: <linux-kernel+bounces-315751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2186A96C684
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DCE61F2698A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248121E2037;
	Wed,  4 Sep 2024 18:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WTQtbYh7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016BD1E1A2F
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 18:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725475030; cv=none; b=bHUpActy2XxrzEGRl+/ntneIm/lSJVSl+4jcmPlvnXjty0zaNZMhikaj7VBgu7y9eXlIqVQI8H7/EF+zPw5j/ia6CZvE7W9vEdoALhNLTqXIPwgMkT8XBKDURXP43Nh1dOKLc/jzTP5lcXWaMtBvEOPlYwM+t6Z+Cr4SVnyEti0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725475030; c=relaxed/simple;
	bh=Wau/q+35GYpxQ+DMRtXpevDS07OwHE6batl31i3kT7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JuXodvr+xYOa5HNIOxYFAGE6ZKh2ZI9WhjSBio4ICewlLRHN4McFshIEkY4HuE+OWW73GkZWlMUXZXs7+Z8vgqT2Tx6GnOP45r8NjQiQbACDa5tpRli4PmoxqHg1I+aQpEXUxoX4hcDjnwHHFrDdK5c/l70KZSTNIq1UDICcs9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WTQtbYh7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725475027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CWMJPGHHsyqwh2jeUcl0baof59j2hw5GpcL0saOPeyM=;
	b=WTQtbYh7pFe01sIlinAqsbE3KFv76bwbrtk0qa5VKYc5Bb5lPa3VnQ9B7e+8cjNr88ITq5
	EKaicJZFJ0FvVrbWxhI7DUi5BufjfE7JR3rX2WiZJ0S2gCIOfOonqP8ahVvmH6U1tH4LPh
	7XGmAQeFoYNW24w652GAu6Al68WGykU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-8U5-aTYWO7-g5Dr8FPgKPw-1; Wed,
 04 Sep 2024 14:37:03 -0400
X-MC-Unique: 8U5-aTYWO7-g5Dr8FPgKPw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D26D1953959;
	Wed,  4 Sep 2024 18:37:01 +0000 (UTC)
Received: from llong.com (unknown [10.2.16.172])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D65AF1955D44;
	Wed,  4 Sep 2024 18:36:58 +0000 (UTC)
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
Subject: [PATCH v3 1/2] sched/core: Remove HK_TYPE_SCHED
Date: Wed,  4 Sep 2024 14:36:49 -0400
Message-ID: <20240904183650.1053708-2-longman@redhat.com>
In-Reply-To: <20240904183650.1053708-1-longman@redhat.com>
References: <20240904183650.1053708-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The HK_TYPE_SCHED housekeeping type is defined but not set anywhere. So
any code that try to use HK_TYPE_SCHED are essentially dead code. So
remove HK_TYPE_SCHED and any code that use it.

Signed-off-by: Waiman Long <longman@redhat.com>
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
index 9057584ec06d..ac5ed846fb55 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11840,9 +11840,6 @@ static inline int on_null_domain(struct rq *rq)
  * - When one of the busy CPUs notices that there may be an idle rebalancing
  *   needed, they will kick the idle load balancer, which then does idle
  *   load balancing for all the idle CPUs.
- *
- * - HK_TYPE_MISC CPUs are used for this task, because HK_TYPE_SCHED is not set
- *   anywhere yet.
  */
 static inline int find_new_ilb(void)
 {
@@ -12087,10 +12084,6 @@ void nohz_balance_enter_idle(int cpu)
 	if (!cpu_active(cpu))
 		return;
 
-	/* Spare idle load balancing on CPUs that don't want to be disturbed: */
-	if (!housekeeping_cpu(cpu, HK_TYPE_SCHED))
-		return;
-
 	/*
 	 * Can be set safely without rq->lock held
 	 * If a clear happens, it will have evaluated last additions because
@@ -12310,13 +12303,6 @@ static void nohz_newidle_balance(struct rq *this_rq)
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


