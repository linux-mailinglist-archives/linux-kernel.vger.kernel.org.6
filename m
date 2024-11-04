Return-Path: <linux-kernel+bounces-394981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0985E9BB6DC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDB7E2811DE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F8E13B58C;
	Mon,  4 Nov 2024 13:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vp0BrVl1"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B207DA7F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730728612; cv=none; b=lLBU2bkeEHWLFA3KHQvCLaFjCR7YG3oDuQYlbM7MygXZtvZ4Nnb2DcPD2WlsNZgo8XzH7mgVWz/mEtMB8fgd5e0FG5nUxNCp/JJRMH5x4rL7biLuKTqjunjnd05341m6yCDVJa/JjqPWcqwq5K/Fdz3iXgBu0U/PH+t6DVQooEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730728612; c=relaxed/simple;
	bh=2zscDwLR0ZjhieKGNemGCr5W89z17A7bETmSG8j0smg=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=e8i9XLgby/mZEcI/DdEo16KU9Jv3qdDVJU3r4D4cwne9Og1GSQJQxVGTCqX10l8JNvYVXer9aa5lsGE17dYPw5uMDZu/VUJvTnZxwEIEGG0zS+HpHJkzot9PQHNkFCpnxSVZ6wQWV63rlSMqE9Wjzk8PlcHPUCiaMTP8FQz7WuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Vp0BrVl1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=UnuX1XoQTtG9dRc73ChG71Cgdr+YdzLA5XtqNeptKjc=; b=Vp0BrVl1HZgPDEwN+56KEy3/UW
	Dcf1eFU+5oqVihBXFa7yfCTNXRWCLIpZIZ8Qd7MiSYwfZYTBj5xaLZekvFvq7GoHJqKt3dqWaFwxt
	km59f6vwBUh/UppMJSUw3JEXN2xpEm48O5tf+3IPQgWZ6BTyBaIzfzGWHKUbiCpWcB+6UdRA+W6hz
	t2pQhO3ixHMX/vBNU+UtHoSRUOSRxr9aAZCHG9s/NF6ZkEZ6nebY3Q/ee2eUbqTkkc76+pC8Gxf3I
	khzjjA9oEExscpL7igDP4iI9LlTQreW1+STejt57akU7AIh4kM3NZMB38Nqsk6Mt8Vp7krkNyWwG2
	7Hxq7yqQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7xZX-00000001EDu-25zF;
	Mon, 04 Nov 2024 13:56:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 775D1308CBB; Mon,  4 Nov 2024 14:56:46 +0100 (CET)
Message-Id: <20241104135518.650051565@infradead.org>
User-Agent: quilt/0.65
Date: Mon, 04 Nov 2024 14:39:19 +0100
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
Subject: [PATCH 10/19] perf: Add this_cpc() helper
References: <20241104133909.669111662@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

As a preparation for adding yet another indirection.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1176,23 +1176,28 @@ static int perf_mux_hrtimer_restart_ipi(
 	return perf_mux_hrtimer_restart(arg);
 }
 
+static __always_inline struct perf_cpu_pmu_context *this_cpc(struct pmu *pmu)
+{
+	return this_cpu_ptr(pmu->cpu_pmu_context);
+}
+
 void perf_pmu_disable(struct pmu *pmu)
 {
-	int *count = &this_cpu_ptr(pmu->cpu_pmu_context)->pmu_disable_count;
+	int *count = &this_cpc(pmu)->pmu_disable_count;
 	if (!(*count)++)
 		pmu->pmu_disable(pmu);
 }
 
 void perf_pmu_enable(struct pmu *pmu)
 {
-	int *count = &this_cpu_ptr(pmu->cpu_pmu_context)->pmu_disable_count;
+	int *count = &this_cpc(pmu)->pmu_disable_count;
 	if (!--(*count))
 		pmu->pmu_enable(pmu);
 }
 
 static void perf_assert_pmu_disabled(struct pmu *pmu)
 {
-	int *count = &this_cpu_ptr(pmu->cpu_pmu_context)->pmu_disable_count;
+	int *count = &this_cpc(pmu)->pmu_disable_count;
 	WARN_ON_ONCE(*count == 0);
 }
 
@@ -2304,7 +2309,7 @@ static void
 event_sched_out(struct perf_event *event, struct perf_event_context *ctx)
 {
 	struct perf_event_pmu_context *epc = event->pmu_ctx;
-	struct perf_cpu_pmu_context *cpc = this_cpu_ptr(epc->pmu->cpu_pmu_context);
+	struct perf_cpu_pmu_context *cpc = this_cpc(epc->pmu);
 	enum perf_event_state state = PERF_EVENT_STATE_INACTIVE;
 
 	// XXX cpc serialization, probably per-cpu IRQ disabled
@@ -2445,9 +2450,8 @@ __perf_remove_from_context(struct perf_e
 		pmu_ctx->rotate_necessary = 0;
 
 		if (ctx->task && ctx->is_active) {
-			struct perf_cpu_pmu_context *cpc;
+			struct perf_cpu_pmu_context *cpc = this_cpc(pmu_ctx->pmu);
 
-			cpc = this_cpu_ptr(pmu_ctx->pmu->cpu_pmu_context);
 			WARN_ON_ONCE(cpc->task_epc && cpc->task_epc != pmu_ctx);
 			cpc->task_epc = NULL;
 		}
@@ -2585,7 +2589,7 @@ static int
 event_sched_in(struct perf_event *event, struct perf_event_context *ctx)
 {
 	struct perf_event_pmu_context *epc = event->pmu_ctx;
-	struct perf_cpu_pmu_context *cpc = this_cpu_ptr(epc->pmu->cpu_pmu_context);
+	struct perf_cpu_pmu_context *cpc = this_cpc(epc->pmu);
 	int ret = 0;
 
 	WARN_ON_ONCE(event->ctx != ctx);
@@ -2692,7 +2696,7 @@ group_sched_in(struct perf_event *group_
 static int group_can_go_on(struct perf_event *event, int can_add_hw)
 {
 	struct perf_event_pmu_context *epc = event->pmu_ctx;
-	struct perf_cpu_pmu_context *cpc = this_cpu_ptr(epc->pmu->cpu_pmu_context);
+	struct perf_cpu_pmu_context *cpc = this_cpc(epc->pmu);
 
 	/*
 	 * Groups consisting entirely of software events can always go on.
@@ -3315,9 +3319,8 @@ static void __pmu_ctx_sched_out(struct p
 	struct pmu *pmu = pmu_ctx->pmu;
 
 	if (ctx->task && !(ctx->is_active & EVENT_ALL)) {
-		struct perf_cpu_pmu_context *cpc;
+		struct perf_cpu_pmu_context *cpc = this_cpc(pmu);
 
-		cpc = this_cpu_ptr(pmu->cpu_pmu_context);
 		WARN_ON_ONCE(cpc->task_epc && cpc->task_epc != pmu_ctx);
 		cpc->task_epc = NULL;
 	}
@@ -3565,7 +3568,7 @@ static void perf_ctx_sched_task_cb(struc
 	struct perf_cpu_pmu_context *cpc;
 
 	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
-		cpc = this_cpu_ptr(pmu_ctx->pmu->cpu_pmu_context);
+		cpc = this_cpc(pmu_ctx->pmu);
 
 		if (cpc->sched_cb_usage && pmu_ctx->pmu->sched_task)
 			pmu_ctx->pmu->sched_task(pmu_ctx, sched_in);
@@ -3674,7 +3677,7 @@ static DEFINE_PER_CPU(int, perf_sched_cb
 
 void perf_sched_cb_dec(struct pmu *pmu)
 {
-	struct perf_cpu_pmu_context *cpc = this_cpu_ptr(pmu->cpu_pmu_context);
+	struct perf_cpu_pmu_context *cpc = this_cpc(pmu);
 
 	this_cpu_dec(perf_sched_cb_usages);
 	barrier();
@@ -3686,7 +3689,7 @@ void perf_sched_cb_dec(struct pmu *pmu)
 
 void perf_sched_cb_inc(struct pmu *pmu)
 {
-	struct perf_cpu_pmu_context *cpc = this_cpu_ptr(pmu->cpu_pmu_context);
+	struct perf_cpu_pmu_context *cpc = this_cpc(pmu);
 
 	if (!cpc->sched_cb_usage++)
 		list_add(&cpc->sched_cb_entry, this_cpu_ptr(&sched_cb_list));
@@ -3810,7 +3813,7 @@ static void __link_epc(struct perf_event
 	if (!pmu_ctx->ctx->task)
 		return;
 
-	cpc = this_cpu_ptr(pmu_ctx->pmu->cpu_pmu_context);
+	cpc = this_cpc(pmu_ctx->pmu);
 	WARN_ON_ONCE(cpc->task_epc && cpc->task_epc != pmu_ctx);
 	cpc->task_epc = pmu_ctx;
 }
@@ -3939,10 +3942,9 @@ static int merge_sched_in(struct perf_ev
 			perf_cgroup_event_disable(event, ctx);
 			perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
 		} else {
-			struct perf_cpu_pmu_context *cpc;
+			struct perf_cpu_pmu_context *cpc = this_cpc(event->pmu_ctx->pmu);
 
 			event->pmu_ctx->rotate_necessary = 1;
-			cpc = this_cpu_ptr(event->pmu_ctx->pmu->cpu_pmu_context);
 			perf_mux_hrtimer_restart(cpc);
 			group_update_userpage(event);
 		}



