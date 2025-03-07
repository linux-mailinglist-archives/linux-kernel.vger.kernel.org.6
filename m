Return-Path: <linux-kernel+bounces-551854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AA2A57222
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 20:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 907443AC90F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 19:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AAA2561A4;
	Fri,  7 Mar 2025 19:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TPuo4sXS"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391CC1A3035
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 19:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376301; cv=none; b=Qh2RdzIQGDNVAJvQeReu4M9pZm+doOQUVTStpiQSrvz1hRRN0+gSyC047/sA1KiiV8Ny5mZknxIJwM3d3xyyhEChFXE4x8ubDou/Wt3UW0SDQ2CV/zLZiYraogVlLF6mfjag53nf8VfnlQvrq/7z/tYLq68iWBc88AWprxTA76w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376301; c=relaxed/simple;
	bh=xhcyai6CZkGCFIa3quGH0XnAPCUhm8a9+8kObGkcbpQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=S1iKQ3A4kNj7+BQ1woXfwY3roSmWDPcP0LfG8Y57ppthXCF6yyF/s+mI/32DGd+xn7/N6lNr7Lgj6B60sDx13Ve3rd0btm62asSPjm/RRlWwEcVdfv7S2IWbRLR39HmNZ3knwTzxaw9vsAwhemPXLfNcPZU+f/fKjrvlzuN0x38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TPuo4sXS; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=0DfnIZ92YyJHiYWZaZSFmOmWqQ7IfHZj6snzAYyr9+Y=; b=TPuo4sXSgiYpAabmD26v7Kf2fw
	9R+BalqVXt8U9r94TC4vK85l//3CoyV/Iv/L59MyzmD3AzLejL44CJwiDPWe+WS41B2DDeYS5PYVv
	FcmoYwhfddBNeJ9m1e48uOw/iyREdEv6w2j1u6y7ankvJcVo5joeuIFGiNIZ9ABhl8E44ZPnMnUO9
	kNLXeMLGPTrOfp/NgoMnxL/n1AHT8cLOXZZChmvvbYL5n3gGNs18JzU4wV2VzGybYsYZcoSw6P5wf
	ljkSGFSD1s9LNc0GFmdpwnGYjkrn3GqLVMYuZHhTu7ceovKVcvZ6zsconVVB0smdOHcKBo0ZbnFXD
	JdR8hgqw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tqdWP-00000001PmI-2gqw;
	Fri, 07 Mar 2025 19:38:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 118C830078C; Fri,  7 Mar 2025 20:38:13 +0100 (CET)
Message-ID: <20250307193723.044499344@infradead.org>
User-Agent: quilt/0.66
Date: Fri, 07 Mar 2025 20:33:08 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org,
 ravi.bangoria@amd.com,
 lucas.demarchi@intel.com
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 acme@kernel.org,
 namhyung@kernel.org,
 mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com,
 jolsa@kernel.org,
 irogers@google.com,
 adrian.hunter@intel.com,
 kan.liang@linux.intel.com
Subject: [PATCH v3 3/7] perf: Simplify perf_event_free_task() wait
References: <20250307193305.486326750@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Simplify the code by moving the duplicated wakeup condition into
put_ctx().

Notably, wait_var_event() is in perf_event_free_task() and will have
set ctx->task = TASK_TOMBSTONE.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1223,8 +1223,14 @@ static void put_ctx(struct perf_event_co
 	if (refcount_dec_and_test(&ctx->refcount)) {
 		if (ctx->parent_ctx)
 			put_ctx(ctx->parent_ctx);
-		if (ctx->task && ctx->task != TASK_TOMBSTONE)
-			put_task_struct(ctx->task);
+		if (ctx->task) {
+			if (ctx->task == TASK_TOMBSTONE) {
+				smp_mb(); /* pairs with wait_var_event() */
+				wake_up_var(&ctx->refcount);
+			} else {
+				put_task_struct(ctx->task);
+			}
+		}
 		call_rcu(&ctx->rcu_head, free_ctx);
 	}
 }
@@ -5492,8 +5498,6 @@ int perf_event_release_kernel(struct per
 again:
 	mutex_lock(&event->child_mutex);
 	list_for_each_entry(child, &event->child_list, child_list) {
-		void *var = NULL;
-
 		/*
 		 * Cannot change, child events are not migrated, see the
 		 * comment with perf_event_ctx_lock_nested().
@@ -5533,39 +5537,19 @@ int perf_event_release_kernel(struct per
 			 * this can't be the last reference.
 			 */
 			put_event(event);
-		} else {
-			var = &ctx->refcount;
 		}
 
 		mutex_unlock(&event->child_mutex);
 		mutex_unlock(&ctx->mutex);
 		put_ctx(ctx);
 
-		if (var) {
-			/*
-			 * If perf_event_free_task() has deleted all events from the
-			 * ctx while the child_mutex got released above, make sure to
-			 * notify about the preceding put_ctx().
-			 */
-			smp_mb(); /* pairs with wait_var_event() */
-			wake_up_var(var);
-		}
 		goto again;
 	}
 	mutex_unlock(&event->child_mutex);
 
 	list_for_each_entry_safe(child, tmp, &free_list, child_list) {
-		void *var = &child->ctx->refcount;
-
 		list_del(&child->child_list);
 		free_event(child);
-
-		/*
-		 * Wake any perf_event_free_task() waiting for this event to be
-		 * freed.
-		 */
-		smp_mb(); /* pairs with wait_var_event() */
-		wake_up_var(var);
 	}
 
 no_ctx:



