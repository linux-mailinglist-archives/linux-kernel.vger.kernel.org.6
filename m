Return-Path: <linux-kernel+bounces-315621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD5C96C50E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8567B1F2756E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6451E132E;
	Wed,  4 Sep 2024 17:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gp3KastY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C054D7E563
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725470114; cv=none; b=aUqXMSh7HnKbr44JbBoP3aIjzEB3W9msY8pTqvkR/ABoeOisiW4oGqhSsPqKi1+p0aVLXreZNYAlyIAEDJAjhSvyx/bum0IG0ALjI61wqdjk+TeOCfdLclonx7GpkuC3UvZxba0CNALMmUSQrzEanQueFYjoOtw3Ng7w+35rK0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725470114; c=relaxed/simple;
	bh=Wau/q+35GYpxQ+DMRtXpevDS07OwHE6batl31i3kT7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lxr0gMKVLLbPaZQtC1+HD7DVJfr9Ai61iPK2wGbkdNoLPqYErBTAcyrQW5CKlm+5Rou5Z8lNm3zKIQ8BO9K7Lqowe0ifukeQzCEqY7Qtup2WPxx2vNEKimhQkkRwTi/T7KfgGpVTUoo1GqTu8oJ+e/gx8WGz3tOAytBRFasTIXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gp3KastY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725470111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CWMJPGHHsyqwh2jeUcl0baof59j2hw5GpcL0saOPeyM=;
	b=Gp3KastY4gOjFW9tkUpz47ROIfoROTEmpX+M8FMg5c3rdca25A2v9C/u4OoTte+SEF+dKd
	YAsELExq35kr78I1umOUM1T9pyaiac/9+5bHvx7SEAL4Dceuw4MUmevqrq1pe79R1Xnx8/
	igD38hdXMv4QwmlCp79i1MuTvLJT61I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-lptWHoj9OiO-BejzWC5vgA-1; Wed,
 04 Sep 2024 13:15:07 -0400
X-MC-Unique: lptWHoj9OiO-BejzWC5vgA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B413D1944AA5;
	Wed,  4 Sep 2024 17:15:05 +0000 (UTC)
Received: from llong.com (unknown [10.2.16.172])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8B58A1955D42;
	Wed,  4 Sep 2024 17:15:03 +0000 (UTC)
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
Subject: [PATCH v2 1/2] sched/core: Remove HK_TYPE_SCHED
Date: Wed,  4 Sep 2024 13:14:40 -0400
Message-ID: <20240904171441.1048072-2-longman@redhat.com>
In-Reply-To: <20240904171441.1048072-1-longman@redhat.com>
References: <20240904171441.1048072-1-longman@redhat.com>
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


