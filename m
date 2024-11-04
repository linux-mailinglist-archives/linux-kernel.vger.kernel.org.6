Return-Path: <linux-kernel+bounces-394998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0E69BB6EC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0FD91F23730
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2CB13B298;
	Mon,  4 Nov 2024 13:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O/AR8zW3"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE531C689D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730728622; cv=none; b=ojLHuNpzLGzLlDH1XpFmtFCMCehfTjzOo54OT2QogUe8Q2s92qpQXzHjomt2qiZhmkc50ssKeq0j5GJ/JDnbqyG+UIYuHEanKUfer7Nppz8TKCMOQulAAgZtCCNONG6ygENle7Xbss0fqdlWi1l3mYmGHVGcsfQiFm89AG7tigk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730728622; c=relaxed/simple;
	bh=s8LfhPT+pLCmBo0f4JA+CkTH/zWwnsVN5ObiFgKyaaE=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=lwq7+jO8RKSEcEppj8MDWuxDHJl8FKi5IxFqAvFj9+1SokW/+N65DyCWpMicL0ulwI0EsDIG7i+Ln19iCVTErHB7S2seMJr3n5//QJVUDWhQwlRMoJ+oskXFT9zw1BEjMhN4tAF4/7AjGx/4SO73I/b+Mnvlw+v4cglYZIQirRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O/AR8zW3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=O9KexFLcBrR17VmEpNmv6Paedf/C3oA4xrEmGRfDEUo=; b=O/AR8zW33EqVcxZmaNXnPkzkHf
	2+gsgoKcAWizq1z4LAppeiiY5zrU2AqDS0WtRlJQHIYKLnWmGIGTsT1W5Iwb7GmI/DZykymE+PAcS
	CgocaLvyAXA/DfJx/7c4Gae+2Ma8CblTZf8NozyDfE+LRUiu8i5WTjg1H441BDsmHgrVEUTe3fysV
	/X+eN49uCuHHfyK1z0PctUyjQ+1muujTWfqBOeiFVQiTxEyeU8n2G7PxUZmj4pk2xipBoqCehh4Wn
	MaPmWkmvmsSyXBQozGu1vy0PTO8inmgpPRS+AJUBMMvM2sS+JMciPpBnYgYaUKg+cyAL9mYR0n3Zb
	lbdgeb+A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7xZX-00000001EDs-1GsS;
	Mon, 04 Nov 2024 13:56:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 63496302DF7; Mon,  4 Nov 2024 14:56:46 +0100 (CET)
Message-Id: <20241104135518.090915501@infradead.org>
User-Agent: quilt/0.65
Date: Mon, 04 Nov 2024 14:39:14 +0100
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
Subject: [PATCH 05/19] perf: Simplify perf_pmu_register() error path
References: <20241104133909.669111662@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

The error path of perf_pmu_register() is of course very similar to a
subset of perf_pmu_unregister(). Extract this common part in
perf_pmu_free() and simplify things.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   66 ++++++++++++++++++++++-----------------------------
 1 file changed, 29 insertions(+), 37 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11540,11 +11540,6 @@ static int perf_event_idx_default(struct
 	return 0;
 }
 
-static void free_pmu_context(struct pmu *pmu)
-{
-	free_percpu(pmu->cpu_pmu_context);
-}
-
 /*
  * Let userspace know that this PMU supports address range filtering:
  */
@@ -11771,25 +11766,38 @@ static bool idr_cmpxchg(struct idr *idr,
 	return true;
 }
 
+static void perf_pmu_free(struct pmu *pmu)
+{
+	free_percpu(pmu->pmu_disable_count);
+	if (pmu_bus_running && pmu->dev && pmu->dev != PMU_NULL_DEV) {
+		if (pmu->nr_addr_filters)
+			device_remove_file(pmu->dev, &dev_attr_nr_addr_filters);
+		device_del(pmu->dev);
+		put_device(pmu->dev);
+	}
+	free_percpu(pmu->cpu_pmu_context);
+}
+
 int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 {
 	int cpu, ret, max = PERF_TYPE_MAX;
 
+	pmu->type = -1;
+
 	mutex_lock(&pmus_lock);
 	ret = -ENOMEM;
 	pmu->pmu_disable_count = alloc_percpu(int);
 	if (!pmu->pmu_disable_count)
 		goto unlock;
 
-	pmu->type = -1;
 	if (WARN_ONCE(!name, "Can not register anonymous pmu.\n")) {
 		ret = -EINVAL;
-		goto free_pdc;
+		goto free;
 	}
 
 	if (WARN_ONCE(pmu->scope >= PERF_PMU_MAX_SCOPE, "Can not register a pmu with an invalid scope.\n")) {
 		ret = -EINVAL;
-		goto free_pdc;
+		goto free;
 	}
 
 	pmu->name = name;
@@ -11799,24 +11807,23 @@ int perf_pmu_register(struct pmu *pmu, c
 
 	ret = idr_alloc(&pmu_idr, NULL, max, 0, GFP_KERNEL);
 	if (ret < 0)
-		goto free_pdc;
+		goto free;
 
 	WARN_ON(type >= 0 && ret != type);
 
-	type = ret;
-	pmu->type = type;
+	pmu->type = ret;
 	atomic_set(&pmu->exclusive_cnt, 0);
 
 	if (pmu_bus_running && !pmu->dev) {
 		ret = pmu_dev_alloc(pmu);
 		if (ret)
-			goto free_idr;
+			goto free;
 	}
 
 	ret = -ENOMEM;
 	pmu->cpu_pmu_context = alloc_percpu(struct perf_cpu_pmu_context);
 	if (!pmu->cpu_pmu_context)
-		goto free_dev;
+		goto free;
 
 	for_each_possible_cpu(cpu) {
 		struct perf_cpu_pmu_context *cpc;
@@ -11857,8 +11864,10 @@ int perf_pmu_register(struct pmu *pmu, c
 	/*
 	 * Now that the PMU is complete, make it visible to perf_try_init_event().
 	 */
-	if (!idr_cmpxchg(&pmu_idr, pmu->type, NULL, pmu))
-		goto free_context;
+	if (!idr_cmpxchg(&pmu_idr, pmu->type, NULL, pmu)) {
+		ret = -EINVAL;
+		goto free;
+	}
 	list_add_rcu(&pmu->entry, &pmus);
 
 	ret = 0;
@@ -11867,20 +11876,10 @@ int perf_pmu_register(struct pmu *pmu, c
 
 	return ret;
 
-free_context:
-	free_percpu(pmu->cpu_pmu_context);
-
-free_dev:
-	if (pmu->dev && pmu->dev != PMU_NULL_DEV) {
-		device_del(pmu->dev);
-		put_device(pmu->dev);
-	}
-
-free_idr:
-	idr_remove(&pmu_idr, pmu->type);
-
-free_pdc:
-	free_percpu(pmu->pmu_disable_count);
+free:
+	if (pmu->type >= 0)
+		idr_remove(&pmu_idr, pmu->type);
+	perf_pmu_free(pmu);
 	goto unlock;
 }
 EXPORT_SYMBOL_GPL(perf_pmu_register);
@@ -11899,14 +11898,7 @@ void perf_pmu_unregister(struct pmu *pmu
 	synchronize_srcu(&pmus_srcu);
 	synchronize_rcu();
 
-	free_percpu(pmu->pmu_disable_count);
-	if (pmu_bus_running && pmu->dev && pmu->dev != PMU_NULL_DEV) {
-		if (pmu->nr_addr_filters)
-			device_remove_file(pmu->dev, &dev_attr_nr_addr_filters);
-		device_del(pmu->dev);
-		put_device(pmu->dev);
-	}
-	free_pmu_context(pmu);
+	perf_pmu_free(pmu);
 }
 EXPORT_SYMBOL_GPL(perf_pmu_unregister);
 



