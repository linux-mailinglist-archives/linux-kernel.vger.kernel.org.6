Return-Path: <linux-kernel+bounces-298664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7966695CA0B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC7BFB23C07
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5646C18733E;
	Fri, 23 Aug 2024 10:09:01 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046541BF3A;
	Fri, 23 Aug 2024 10:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724407740; cv=none; b=o/mPwmnAVo+GpZnsGlzWGrFmwLZexci9NcN73NI/hyWJXKTc1zAB2qnjX+3q0shICjbpsOg9AZc75GYWmQ+GKOr3JJZywDLQM47sM66aHIJZv8MUBWCt/vsiPFOFJhpcOIc6DBUjbSWbSKR+Jk/hlUczrW41j3G+cYMWLSgYObw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724407740; c=relaxed/simple;
	bh=FBKQGEQD/pNFgchyqh4ENLTYory28/taic55pTHfxt4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uejjP8cXIMNK/7/8+FqD4OTLHrsQUGRvve3KjjOzHGwVBhJ5wsWpM23JD9cgnea9FuE2LllT8mLbdQIbWqOvz/TsNbPYNthmNoGhok/AHYIv9bQj9grjwFBu6xdGNvTEjSj1NzAAUlCiom7eVd3RyV4PXWOoMINRonbXaL2K+IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wqwl64Nwjz2Cmvt;
	Fri, 23 Aug 2024 18:08:50 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 71B9E1A0188;
	Fri, 23 Aug 2024 18:08:55 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 23 Aug
 2024 18:08:54 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <mkoutny@suse.com>, <chenridong@huawei.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 -next 03/11] cgroup/cpuset: move memory_pressure to cpuset-v1.c
Date: Fri, 23 Aug 2024 10:01:02 +0000
Message-ID: <20240823100110.472120-4-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823100110.472120-1-chenridong@huawei.com>
References: <20240823100110.472120-1-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd100013.china.huawei.com (7.221.188.163)

Collection of memory_pressure can be enabled by writing 1 to the cpuset
file 'memory_pressure_enabled', which is only for cpuset-v1. Therefore,
move the corresponding code to cpuset-v1.c.

Currently, the 'fmeter_init' and 'fmeter_getrate' functions are called
at cpuset.c, so expose them to cpuset.c.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset-internal.h |   7 ++
 kernel/cgroup/cpuset-v1.c       | 134 ++++++++++++++++++++++++++++++++
 kernel/cgroup/cpuset.c          | 134 --------------------------------
 3 files changed, 141 insertions(+), 134 deletions(-)

diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index 333666a7a947..83795873dac0 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -238,4 +238,11 @@ static inline int is_spread_slab(const struct cpuset *cs)
 	return test_bit(CS_SPREAD_SLAB, &cs->flags);
 }
 
+/*
+ * cpuset-v1.c
+ */
+
+void fmeter_init(struct fmeter *fmp);
+int fmeter_getrate(struct fmeter *fmp);
+
 #endif /* __CPUSET_INTERNAL_H */
diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index ae166eb4f75d..f17ba44bc566 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -2,3 +2,137 @@
 
 #include "cpuset-internal.h"
 
+/*
+ * Frequency meter - How fast is some event occurring?
+ *
+ * These routines manage a digitally filtered, constant time based,
+ * event frequency meter.  There are four routines:
+ *   fmeter_init() - initialize a frequency meter.
+ *   fmeter_markevent() - called each time the event happens.
+ *   fmeter_getrate() - returns the recent rate of such events.
+ *   fmeter_update() - internal routine used to update fmeter.
+ *
+ * A common data structure is passed to each of these routines,
+ * which is used to keep track of the state required to manage the
+ * frequency meter and its digital filter.
+ *
+ * The filter works on the number of events marked per unit time.
+ * The filter is single-pole low-pass recursive (IIR).  The time unit
+ * is 1 second.  Arithmetic is done using 32-bit integers scaled to
+ * simulate 3 decimal digits of precision (multiplied by 1000).
+ *
+ * With an FM_COEF of 933, and a time base of 1 second, the filter
+ * has a half-life of 10 seconds, meaning that if the events quit
+ * happening, then the rate returned from the fmeter_getrate()
+ * will be cut in half each 10 seconds, until it converges to zero.
+ *
+ * It is not worth doing a real infinitely recursive filter.  If more
+ * than FM_MAXTICKS ticks have elapsed since the last filter event,
+ * just compute FM_MAXTICKS ticks worth, by which point the level
+ * will be stable.
+ *
+ * Limit the count of unprocessed events to FM_MAXCNT, so as to avoid
+ * arithmetic overflow in the fmeter_update() routine.
+ *
+ * Given the simple 32 bit integer arithmetic used, this meter works
+ * best for reporting rates between one per millisecond (msec) and
+ * one per 32 (approx) seconds.  At constant rates faster than one
+ * per msec it maxes out at values just under 1,000,000.  At constant
+ * rates between one per msec, and one per second it will stabilize
+ * to a value N*1000, where N is the rate of events per second.
+ * At constant rates between one per second and one per 32 seconds,
+ * it will be choppy, moving up on the seconds that have an event,
+ * and then decaying until the next event.  At rates slower than
+ * about one in 32 seconds, it decays all the way back to zero between
+ * each event.
+ */
+
+#define FM_COEF 933		/* coefficient for half-life of 10 secs */
+#define FM_MAXTICKS ((u32)99)   /* useless computing more ticks than this */
+#define FM_MAXCNT 1000000	/* limit cnt to avoid overflow */
+#define FM_SCALE 1000		/* faux fixed point scale */
+
+/* Initialize a frequency meter */
+void fmeter_init(struct fmeter *fmp)
+{
+	fmp->cnt = 0;
+	fmp->val = 0;
+	fmp->time = 0;
+	spin_lock_init(&fmp->lock);
+}
+
+/* Internal meter update - process cnt events and update value */
+static void fmeter_update(struct fmeter *fmp)
+{
+	time64_t now;
+	u32 ticks;
+
+	now = ktime_get_seconds();
+	ticks = now - fmp->time;
+
+	if (ticks == 0)
+		return;
+
+	ticks = min(FM_MAXTICKS, ticks);
+	while (ticks-- > 0)
+		fmp->val = (FM_COEF * fmp->val) / FM_SCALE;
+	fmp->time = now;
+
+	fmp->val += ((FM_SCALE - FM_COEF) * fmp->cnt) / FM_SCALE;
+	fmp->cnt = 0;
+}
+
+/* Process any previous ticks, then bump cnt by one (times scale). */
+static void fmeter_markevent(struct fmeter *fmp)
+{
+	spin_lock(&fmp->lock);
+	fmeter_update(fmp);
+	fmp->cnt = min(FM_MAXCNT, fmp->cnt + FM_SCALE);
+	spin_unlock(&fmp->lock);
+}
+
+/* Process any previous ticks, then return current value. */
+int fmeter_getrate(struct fmeter *fmp)
+{
+	int val;
+
+	spin_lock(&fmp->lock);
+	fmeter_update(fmp);
+	val = fmp->val;
+	spin_unlock(&fmp->lock);
+	return val;
+}
+
+/*
+ * Collection of memory_pressure is suppressed unless
+ * this flag is enabled by writing "1" to the special
+ * cpuset file 'memory_pressure_enabled' in the root cpuset.
+ */
+
+int cpuset_memory_pressure_enabled __read_mostly;
+
+/*
+ * __cpuset_memory_pressure_bump - keep stats of per-cpuset reclaims.
+ *
+ * Keep a running average of the rate of synchronous (direct)
+ * page reclaim efforts initiated by tasks in each cpuset.
+ *
+ * This represents the rate at which some task in the cpuset
+ * ran low on memory on all nodes it was allowed to use, and
+ * had to enter the kernels page reclaim code in an effort to
+ * create more free memory by tossing clean pages or swapping
+ * or writing dirty pages.
+ *
+ * Display to user space in the per-cpuset read-only file
+ * "memory_pressure".  Value displayed is an integer
+ * representing the recent rate of entry into the synchronous
+ * (direct) page reclaim by any task attached to the cpuset.
+ */
+
+void __cpuset_memory_pressure_bump(void)
+{
+	rcu_read_lock();
+	fmeter_markevent(&task_cs(current)->fmeter);
+	rcu_read_unlock();
+}
+
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index b36050e39558..342ce34c8c6f 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2990,107 +2990,6 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	return 0;
 }
 
-/*
- * Frequency meter - How fast is some event occurring?
- *
- * These routines manage a digitally filtered, constant time based,
- * event frequency meter.  There are four routines:
- *   fmeter_init() - initialize a frequency meter.
- *   fmeter_markevent() - called each time the event happens.
- *   fmeter_getrate() - returns the recent rate of such events.
- *   fmeter_update() - internal routine used to update fmeter.
- *
- * A common data structure is passed to each of these routines,
- * which is used to keep track of the state required to manage the
- * frequency meter and its digital filter.
- *
- * The filter works on the number of events marked per unit time.
- * The filter is single-pole low-pass recursive (IIR).  The time unit
- * is 1 second.  Arithmetic is done using 32-bit integers scaled to
- * simulate 3 decimal digits of precision (multiplied by 1000).
- *
- * With an FM_COEF of 933, and a time base of 1 second, the filter
- * has a half-life of 10 seconds, meaning that if the events quit
- * happening, then the rate returned from the fmeter_getrate()
- * will be cut in half each 10 seconds, until it converges to zero.
- *
- * It is not worth doing a real infinitely recursive filter.  If more
- * than FM_MAXTICKS ticks have elapsed since the last filter event,
- * just compute FM_MAXTICKS ticks worth, by which point the level
- * will be stable.
- *
- * Limit the count of unprocessed events to FM_MAXCNT, so as to avoid
- * arithmetic overflow in the fmeter_update() routine.
- *
- * Given the simple 32 bit integer arithmetic used, this meter works
- * best for reporting rates between one per millisecond (msec) and
- * one per 32 (approx) seconds.  At constant rates faster than one
- * per msec it maxes out at values just under 1,000,000.  At constant
- * rates between one per msec, and one per second it will stabilize
- * to a value N*1000, where N is the rate of events per second.
- * At constant rates between one per second and one per 32 seconds,
- * it will be choppy, moving up on the seconds that have an event,
- * and then decaying until the next event.  At rates slower than
- * about one in 32 seconds, it decays all the way back to zero between
- * each event.
- */
-
-#define FM_COEF 933		/* coefficient for half-life of 10 secs */
-#define FM_MAXTICKS ((u32)99)   /* useless computing more ticks than this */
-#define FM_MAXCNT 1000000	/* limit cnt to avoid overflow */
-#define FM_SCALE 1000		/* faux fixed point scale */
-
-/* Initialize a frequency meter */
-static void fmeter_init(struct fmeter *fmp)
-{
-	fmp->cnt = 0;
-	fmp->val = 0;
-	fmp->time = 0;
-	spin_lock_init(&fmp->lock);
-}
-
-/* Internal meter update - process cnt events and update value */
-static void fmeter_update(struct fmeter *fmp)
-{
-	time64_t now;
-	u32 ticks;
-
-	now = ktime_get_seconds();
-	ticks = now - fmp->time;
-
-	if (ticks == 0)
-		return;
-
-	ticks = min(FM_MAXTICKS, ticks);
-	while (ticks-- > 0)
-		fmp->val = (FM_COEF * fmp->val) / FM_SCALE;
-	fmp->time = now;
-
-	fmp->val += ((FM_SCALE - FM_COEF) * fmp->cnt) / FM_SCALE;
-	fmp->cnt = 0;
-}
-
-/* Process any previous ticks, then bump cnt by one (times scale). */
-static void fmeter_markevent(struct fmeter *fmp)
-{
-	spin_lock(&fmp->lock);
-	fmeter_update(fmp);
-	fmp->cnt = min(FM_MAXCNT, fmp->cnt + FM_SCALE);
-	spin_unlock(&fmp->lock);
-}
-
-/* Process any previous ticks, then return current value. */
-static int fmeter_getrate(struct fmeter *fmp)
-{
-	int val;
-
-	spin_lock(&fmp->lock);
-	fmeter_update(fmp);
-	val = fmp->val;
-	spin_unlock(&fmp->lock);
-	return val;
-}
-
 static struct cpuset *cpuset_attach_old_cs;
 
 /*
@@ -4780,39 +4679,6 @@ void cpuset_print_current_mems_allowed(void)
 	rcu_read_unlock();
 }
 
-/*
- * Collection of memory_pressure is suppressed unless
- * this flag is enabled by writing "1" to the special
- * cpuset file 'memory_pressure_enabled' in the root cpuset.
- */
-
-int cpuset_memory_pressure_enabled __read_mostly;
-
-/*
- * __cpuset_memory_pressure_bump - keep stats of per-cpuset reclaims.
- *
- * Keep a running average of the rate of synchronous (direct)
- * page reclaim efforts initiated by tasks in each cpuset.
- *
- * This represents the rate at which some task in the cpuset
- * ran low on memory on all nodes it was allowed to use, and
- * had to enter the kernels page reclaim code in an effort to
- * create more free memory by tossing clean pages or swapping
- * or writing dirty pages.
- *
- * Display to user space in the per-cpuset read-only file
- * "memory_pressure".  Value displayed is an integer
- * representing the recent rate of entry into the synchronous
- * (direct) page reclaim by any task attached to the cpuset.
- */
-
-void __cpuset_memory_pressure_bump(void)
-{
-	rcu_read_lock();
-	fmeter_markevent(&task_cs(current)->fmeter);
-	rcu_read_unlock();
-}
-
 #ifdef CONFIG_PROC_PID_CPUSET
 /*
  * proc_cpuset_show()
-- 
2.34.1


