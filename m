Return-Path: <linux-kernel+bounces-249243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E68C192E8C6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72EBC1F21D93
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E046F16130C;
	Thu, 11 Jul 2024 13:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K0n0eQ0O"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A695F160887
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720702886; cv=none; b=a8YMfaGbJYc4Ud3G7uj8zVWof12YxO+o/OmPpFS3/3NeVsVDJrhJMMT2qponxfnewCTG7fiLvJ/YE+fl6vKTtv5Cyd5QyLdLfr/UImFau+VB9gxbl9G4OSNlxLSMXXL08ZpleDqeeM+lXzNbCCYtM27Q9e5gqcx91kWM9yICt4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720702886; c=relaxed/simple;
	bh=ac39iJ85qdc9Ytj5FEcWzWjFfQVSQdQQK96665YcdAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwNshagZ21fptC5InVfcvRTRiM7qj4Lsh0yeNAW33qDDI9ikK6vmAmjT45R0iqkEUBYu2XgSaNjVDOhXJlfma9sngbGzWxqEC5V9bdZqHyD8kVx5h0LJXuLLuuFwBgPDLRJzyDMjlQAy3hfrKO0c4vk7uwmQ4rN1v/BiS3/EU/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K0n0eQ0O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720702883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bY5N4wVYoZd5/9PoLPrXsqV7N1C2PIbxzBinwZyAijs=;
	b=K0n0eQ0Oxjl+mCDGj4ePcSGBu1Qk8Ru+vyXG/IXzOCfJjpgYMRwyYzOeJf0kQzjiOP+ida
	U2eh4oxABTjUWd0CfKVsZvl3qgJUGazDx7E6LXvdsO38OBaA6buReXEu8wI3iGsxeOLe5j
	flBfQfOTtYJLAeCzwx2rReGEutI/wyk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-uymGDPAkPJiTvRpsqk9RfA-1; Thu,
 11 Jul 2024 09:01:17 -0400
X-MC-Unique: uymGDPAkPJiTvRpsqk9RfA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E3E41977009;
	Thu, 11 Jul 2024 13:01:10 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.211])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C08621955E85;
	Thu, 11 Jul 2024 13:01:01 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Phil Auld <pauld@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Guo Ren <guoren@kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [RFC PATCH v3 04/10] sched/fair: Introduce sched_throttle_work
Date: Thu, 11 Jul 2024 14:59:58 +0200
Message-ID: <20240711130004.2157737-5-vschneid@redhat.com>
In-Reply-To: <20240711130004.2157737-1-vschneid@redhat.com>
References: <20240711130004.2157737-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Later commits will change CFS bandwidth control throttling from a
per-cfs_rq basis to a per-task basis. Actual throttling of a task will
happen in the return to user path, which will be implemented via a
task_work callback.

To ease reviewing, the infrastructure and helpers are added first, the
actual behaviour will be implemented when switching to per-task
throttling.

Add a task_work node to struct task_struct, and have it initialised at
sched_fork().

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/sched.h |  1 +
 kernel/sched/core.c   |  4 ++++
 kernel/sched/fair.c   | 12 ++++++++++++
 kernel/sched/sched.h  |  2 ++
 4 files changed, 19 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 90691d99027e3..a4976eb5065fc 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -812,6 +812,7 @@ struct task_struct {
 
 #ifdef CONFIG_CGROUP_SCHED
 	struct task_group		*sched_task_group;
+	struct callback_head            sched_throttle_work;
 #endif
 
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6d35c48239be0..b811670d2c362 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4329,6 +4329,10 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->se.cfs_rq			= NULL;
 #endif
 
+#ifdef CONFIG_CFS_BANDWIDTH
+	init_cfs_throttle_work(p);
+#endif
+
 #ifdef CONFIG_SCHEDSTATS
 	/* Even if schedstat is disabled, there should not be garbage */
 	memset(&p->stats, 0, sizeof(p->stats));
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9057584ec06de..775547cdd3ce0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5759,6 +5759,18 @@ static int tg_throttle_down(struct task_group *tg, void *data)
 	return 0;
 }
 
+static void throttle_cfs_rq_work(struct callback_head *work)
+{
+
+}
+
+void init_cfs_throttle_work(struct task_struct *p)
+{
+	/* Protect against double add, see throttle_cfs_rq() and throttle_cfs_rq_work() */
+	p->sched_throttle_work.next = &p->sched_throttle_work;
+	init_task_work(&p->sched_throttle_work, throttle_cfs_rq_work);
+}
+
 static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	struct rq *rq = rq_of(cfs_rq);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4c36cc6803617..943bca8263ffe 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2510,6 +2510,8 @@ extern void init_sched_dl_class(void);
 extern void init_sched_rt_class(void);
 extern void init_sched_fair_class(void);
 
+extern void init_cfs_throttle_work(struct task_struct *p);
+
 extern void reweight_task(struct task_struct *p, const struct load_weight *lw);
 
 extern void resched_curr(struct rq *rq);
-- 
2.43.0


