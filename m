Return-Path: <linux-kernel+bounces-394987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C53559BB6E2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ABA31F22DDD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA231BC062;
	Mon,  4 Nov 2024 13:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gagivgv1"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF9781732
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730728613; cv=none; b=IqtHObnIzvk8qfFHx7T+ge1rx8BTOjwxyLkyaDdjFjhVLnVTNs7JPSATT9NtuZlDVdOhaqGJt68fS5vWmswLcnR4z2QgbBqKxQpTM3jXuiIMpkTPRqCoZ/TRwRL+ygARaYqMEc3pxwe42KLSMd4CBlwQen7tVzAiNtcFnmAsg1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730728613; c=relaxed/simple;
	bh=fb4yx1mLvfIivb42zEJ6sQ3mn7X1TYb8g7pYQvyHERQ=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=nWyL7CSMBWm9rNwaUupa0Jkdtof08A1sIlze3qHrVQ0Ceh2tTmaX1L5dLZGXjRs+kr+OG6pOQHaMmF0yhaC/myjk3ErW/qswoGrQJvSLrz0fOMCwGkz4WRtp7hcTG1pO9GgfxPKQ7y1y2mrnWoK5+EaLeoogvC5MHq/ML16fTm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Gagivgv1; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=et62BZe26TSNPT9m7zmj3JkW+qnq8ZueXYHt8xkqpL4=; b=Gagivgv1FC/IVKimdzzpNzaZbC
	5gDYVKZAEvD0uWuwpji88jpW5Xp6238+Klrp2vxA/RqNkynNq54JQlwOs32rT2BJ2cb3I1LU9CIvZ
	MA8AYHEQsSe6wCCY0EkiSVymneZfDoZOnfB+l8B1W2+hILS8hSwANtOMN5d+xfSz0G6l+dGPJgM/B
	eg0p1KnNN0gKVV8sVPfJzQC6v1zOSVaTgrdwe1nVA3BUPv8F4JyA7nOCwF3sA0qpAMpvYwFMioVvw
	KvJlZiM854fSsplhj0LratpI7fJN95BLSMQtf7R5c+wWXacfkK+/oU7WRuup2cBG5qtO5P74r2uAj
	xrMzXzvQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7xZX-0000000BL85-3tiT;
	Mon, 04 Nov 2024 13:56:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 67D6830625D; Mon,  4 Nov 2024 14:56:46 +0100 (CET)
Message-Id: <20241104135518.198937277@infradead.org>
User-Agent: quilt/0.65
Date: Mon, 04 Nov 2024 14:39:15 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org,
 lucas.demarchi@intel.com
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 willy@infradead.org,
 acme@kernel.org,
 namhyung@kernel.org,
 mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com,
 jolsa@kernel.org,
 irogers@google.com,
 adrian.hunter@intel.com,
 kan.liang@linux.intel.com
Subject: [PATCH 06/19] perf: Simplify perf_pmu_register()
References: <20241104133909.669111662@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Using the previously introduced perf_pmu_free() and a new IDR helper,
simplify the perf_pmu_register error paths.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/idr.h  |   17 ++++++++++++
 kernel/events/core.c |   71 ++++++++++++++++++++-------------------------------
 2 files changed, 46 insertions(+), 42 deletions(-)

--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -15,6 +15,7 @@
 #include <linux/radix-tree.h>
 #include <linux/gfp.h>
 #include <linux/percpu.h>
+#include <linux/cleanup.h>
 
 struct idr {
 	struct radix_tree_root	idr_rt;
@@ -124,6 +125,22 @@ void *idr_get_next_ul(struct idr *, unsi
 void *idr_replace(struct idr *, void *, unsigned long id);
 void idr_destroy(struct idr *);
 
+struct __class_idr {
+	struct idr *idr;
+	int id;
+};
+
+#define idr_null ((struct __class_idr){ NULL, -1 })
+#define take_idr_id(id) __get_and_null(id, idr_null)
+
+DEFINE_CLASS(idr_alloc, struct __class_idr,
+	     if (_T.id >= 0) idr_remove(_T.idr, _T.id),
+	     ((struct __class_idr){
+	     	.idr = idr,
+		.id = idr_alloc(idr, ptr, start, end, gfp),
+	     }),
+	     struct idr *idr, void *ptr, int start, int end, gfp_t gfp);
+
 /**
  * idr_init_base() - Initialise an IDR.
  * @idr: IDR handle.
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11778,52 +11778,49 @@ static void perf_pmu_free(struct pmu *pm
 	free_percpu(pmu->cpu_pmu_context);
 }
 
-int perf_pmu_register(struct pmu *pmu, const char *name, int type)
+DEFINE_FREE(pmu_unregister, struct pmu *, if (_T) perf_pmu_free(_T))
+
+int perf_pmu_register(struct pmu *_pmu, const char *name, int type)
 {
-	int cpu, ret, max = PERF_TYPE_MAX;
+	int cpu, max = PERF_TYPE_MAX;
 
-	pmu->type = -1;
+	struct pmu *pmu __free(pmu_unregister) = _pmu;
+	guard(mutex)(&pmus_lock);
 
-	mutex_lock(&pmus_lock);
-	ret = -ENOMEM;
 	pmu->pmu_disable_count = alloc_percpu(int);
 	if (!pmu->pmu_disable_count)
-		goto unlock;
+		return -ENOMEM;
 
-	if (WARN_ONCE(!name, "Can not register anonymous pmu.\n")) {
-		ret = -EINVAL;
-		goto free;
-	}
+	if (WARN_ONCE(!name, "Can not register anonymous pmu.\n"))
+		return -EINVAL;
 
-	if (WARN_ONCE(pmu->scope >= PERF_PMU_MAX_SCOPE, "Can not register a pmu with an invalid scope.\n")) {
-		ret = -EINVAL;
-		goto free;
-	}
+	if (WARN_ONCE(pmu->scope >= PERF_PMU_MAX_SCOPE,
+		      "Can not register a pmu with an invalid scope.\n"))
+		return -EINVAL;
 
 	pmu->name = name;
 
 	if (type >= 0)
 		max = type;
 
-	ret = idr_alloc(&pmu_idr, NULL, max, 0, GFP_KERNEL);
-	if (ret < 0)
-		goto free;
+	CLASS(idr_alloc, pmu_type)(&pmu_idr, NULL, max, 0, GFP_KERNEL);
+	if (pmu_type.id < 0)
+		return pmu_type.id;
 
-	WARN_ON(type >= 0 && ret != type);
+	WARN_ON(type >= 0 && pmu_type.id != type);
 
-	pmu->type = ret;
+	pmu->type = pmu_type.id;
 	atomic_set(&pmu->exclusive_cnt, 0);
 
 	if (pmu_bus_running && !pmu->dev) {
-		ret = pmu_dev_alloc(pmu);
+		int ret = pmu_dev_alloc(pmu);
 		if (ret)
-			goto free;
+			return ret;
 	}
 
-	ret = -ENOMEM;
 	pmu->cpu_pmu_context = alloc_percpu(struct perf_cpu_pmu_context);
 	if (!pmu->cpu_pmu_context)
-		goto free;
+		return -ENOMEM;
 
 	for_each_possible_cpu(cpu) {
 		struct perf_cpu_pmu_context *cpc;
@@ -11864,32 +11861,22 @@ int perf_pmu_register(struct pmu *pmu, c
 	/*
 	 * Now that the PMU is complete, make it visible to perf_try_init_event().
 	 */
-	if (!idr_cmpxchg(&pmu_idr, pmu->type, NULL, pmu)) {
-		ret = -EINVAL;
-		goto free;
-	}
+	if (!idr_cmpxchg(&pmu_idr, pmu->type, NULL, pmu))
+		return -EINVAL;
 	list_add_rcu(&pmu->entry, &pmus);
 
-	ret = 0;
-unlock:
-	mutex_unlock(&pmus_lock);
-
-	return ret;
-
-free:
-	if (pmu->type >= 0)
-		idr_remove(&pmu_idr, pmu->type);
-	perf_pmu_free(pmu);
-	goto unlock;
+	take_idr_id(pmu_type);
+	_pmu = no_free_ptr(pmu); // let it rip
+	return 0;
 }
 EXPORT_SYMBOL_GPL(perf_pmu_register);
 
 void perf_pmu_unregister(struct pmu *pmu)
 {
-	mutex_lock(&pmus_lock);
-	list_del_rcu(&pmu->entry);
-	idr_remove(&pmu_idr, pmu->type);
-	mutex_unlock(&pmus_lock);
+	scoped_guard (mutex, &pmus_lock) {
+		list_del_rcu(&pmu->entry);
+		idr_remove(&pmu_idr, pmu->type);
+	}
 
 	/*
 	 * We dereference the pmu list under both SRCU and regular RCU, so



