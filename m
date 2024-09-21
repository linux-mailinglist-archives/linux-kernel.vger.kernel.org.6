Return-Path: <linux-kernel+bounces-334930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3160197DE71
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 21:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6106D1C20C81
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 19:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62718824BD;
	Sat, 21 Sep 2024 19:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJ9UYKRy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62BF6FBF
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 19:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726945682; cv=none; b=ZOvnPI7GE6vpdQ4mud94NGjZHqIiuzurBzHbpITsmaAM54XxafzRyEH2pKQdsKIajuZaSg0fEbooPMA+M0VxDAPYD0nEQlHhdMkLyFQDETw9dlct34rofHwAFBb3w226GH2pTV2NWt4WOEFFGRHhDilR2N1mjTYLs9GizeKyVos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726945682; c=relaxed/simple;
	bh=iF/UcEocnjX8RWhBeAD98LQCH1lLpp4Zs42WIZlDuqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g1WZIOxS4JuelH3zSKOZEYa7ir4GzyMGmqXyY+co59SdbfTqMIrqQ21cnmKI2Vsenm55OmDKhSvpayWD6okq4viQvKGxiLpFBw5mi0ubs8y0y1IFiY4/FGEfeb5fASMKbOra2Zd3a1wP2u1qUv8tnY32d/SO3L7/gLjlozGsaew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eJ9UYKRy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726945679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xThVtH+joJtOehvucbRrBkg1RCKvDrrEyEnwMld3cXo=;
	b=eJ9UYKRyMp+lVuxMI51Tv8UNBwf2bopixMnoBpFdh4X60G3BZUng3uajFPee8kTazCndDp
	59xBa3IHixk2RY6Ox76EDQ0sVe6bbnltU0C9UkM48KTRwwHXtmE6xsT/O64q3CqJ9PoJjw
	/HfoBJZ1X03Hfsajscelrn+xNMrKVAA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-piLTjTyAPFGuiO6KbTs6Tg-1; Sat,
 21 Sep 2024 15:07:56 -0400
X-MC-Unique: piLTjTyAPFGuiO6KbTs6Tg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2472E18F49BE;
	Sat, 21 Sep 2024 19:07:55 +0000 (UTC)
Received: from llong.com (unknown [10.45.224.27])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EE57E19560AB;
	Sat, 21 Sep 2024 19:07:50 +0000 (UTC)
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
Subject: [PATCH v4 1/4] sched/core: Remove HK_TYPE_SCHED
Date: Sat, 21 Sep 2024 15:07:17 -0400
Message-ID: <20240921190720.106195-2-longman@redhat.com>
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


