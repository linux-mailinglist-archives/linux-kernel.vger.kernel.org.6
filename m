Return-Path: <linux-kernel+bounces-394988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D800A9BB6E1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9023D1F22D4A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086257DA7F;
	Mon,  4 Nov 2024 13:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h2GqsM8A"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16B81304B0
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730728613; cv=none; b=nB9IqAs2v+PFtm1F0URNLvWzKvxXGqArpMEc5aig4bY0HWDIRH6awt1WIt93MagCEi2kWojVCw5jBFz5CgktZH/MyRYVfv5fd5AHf6L23ZG8j4jGzyGBf5Nid3ix0+Nvv9RiO3v8VFmuwxppTJabCj2Z8Tkx/cbVac3IACxr/3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730728613; c=relaxed/simple;
	bh=jgRrOVbaUhKSCdAgqMm6PBTJtNFsO2F6hbI3CF8E38w=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=NLhiumGgyA25Bwi6ufkN7aaTZOXDeZWhdn5GEuQSUynTMOaGVRzxhipnpqfpw6YoBiADbOkC238sDcEZ8UikY9LYT+NdCOPQM6qoMHVGES0MljEj6xZrN59PxzUGP0GqAwP2b4i6EbI8AhSrTx9QZXJD3SgwHdhcekUOR1a2Mf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h2GqsM8A; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=AXQsUbrNi//UszPgMZlKaiAURaGB4JaNmPRTa3RbqAg=; b=h2GqsM8A0LxtR300o8JeM4Lc97
	i1WDqf1jxsFo3lhMnxWKVdEDYVFt6rUpGIHk51uqUng0XMxpPXD4b1v6jHHcJjiZ3iTM5HCAhD1+m
	h2rVM/QgD4OoFyGin/PrBrRk28C4ER+5Tj6pdijYrTvM5rTjw9OPKAkCsGfFeGPzaG8R1prxOw5om
	tm+9rNHHFazpMqUTvyACJ6SzBRvyYsOr7JSsO6Dlu8X5QByw28DX1FSXTRLMNGIWj58VaUdJi2om3
	GB8rT64v3NSVlTtpO9RG9fDUOCTo/du9+bnU562vxia5iQ4/wj1oF46Dy/l+L6gLgj5ViYhGscR1i
	nhsgrCqQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7xZY-0000000BL8B-0TyB;
	Mon, 04 Nov 2024 13:56:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 73A29308CB6; Mon,  4 Nov 2024 14:56:46 +0100 (CET)
Message-Id: <20241104135518.518730578@infradead.org>
User-Agent: quilt/0.65
Date: Mon, 04 Nov 2024 14:39:18 +0100
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
Subject: [PATCH 09/19] perf: Merge pmu_disable_count into cpu_pmu_context
References: <20241104133909.669111662@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Because it makes no sense to have two per-cpu allocations per pmu.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/perf_event.h |    2 +-
 kernel/events/core.c       |   12 ++++--------
 2 files changed, 5 insertions(+), 9 deletions(-)

--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -336,7 +336,6 @@ struct pmu {
 	 */
 	unsigned int			scope;
 
-	int __percpu			*pmu_disable_count;
 	struct perf_cpu_pmu_context __percpu *cpu_pmu_context;
 	atomic_t			exclusive_cnt; /* < 0: cpu; > 0: tsk */
 	int				task_ctx_nr;
@@ -1010,6 +1009,7 @@ struct perf_cpu_pmu_context {
 
 	int				active_oncpu;
 	int				exclusive;
+	int				pmu_disable_count;
 
 	raw_spinlock_t			hrtimer_lock;
 	struct hrtimer			hrtimer;
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1178,21 +1178,22 @@ static int perf_mux_hrtimer_restart_ipi(
 
 void perf_pmu_disable(struct pmu *pmu)
 {
-	int *count = this_cpu_ptr(pmu->pmu_disable_count);
+	int *count = &this_cpu_ptr(pmu->cpu_pmu_context)->pmu_disable_count;
 	if (!(*count)++)
 		pmu->pmu_disable(pmu);
 }
 
 void perf_pmu_enable(struct pmu *pmu)
 {
-	int *count = this_cpu_ptr(pmu->pmu_disable_count);
+	int *count = &this_cpu_ptr(pmu->cpu_pmu_context)->pmu_disable_count;
 	if (!--(*count))
 		pmu->pmu_enable(pmu);
 }
 
 static void perf_assert_pmu_disabled(struct pmu *pmu)
 {
-	WARN_ON_ONCE(*this_cpu_ptr(pmu->pmu_disable_count) == 0);
+	int *count = &this_cpu_ptr(pmu->cpu_pmu_context)->pmu_disable_count;
+	WARN_ON_ONCE(*count == 0);
 }
 
 static void get_ctx(struct perf_event_context *ctx)
@@ -11758,7 +11759,6 @@ static bool idr_cmpxchg(struct idr *idr,
 
 static void perf_pmu_free(struct pmu *pmu)
 {
-	free_percpu(pmu->pmu_disable_count);
 	if (pmu_bus_running && pmu->dev && pmu->dev != PMU_NULL_DEV) {
 		if (pmu->nr_addr_filters)
 			device_remove_file(pmu->dev, &dev_attr_nr_addr_filters);
@@ -11777,10 +11777,6 @@ int perf_pmu_register(struct pmu *_pmu,
 	struct pmu *pmu __free(pmu_unregister) = _pmu;
 	guard(mutex)(&pmus_lock);
 
-	pmu->pmu_disable_count = alloc_percpu(int);
-	if (!pmu->pmu_disable_count)
-		return -ENOMEM;
-
 	if (WARN_ONCE(!name, "Can not register anonymous pmu.\n"))
 		return -EINVAL;
 



