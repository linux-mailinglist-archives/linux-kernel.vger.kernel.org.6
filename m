Return-Path: <linux-kernel+bounces-445603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D5B9F1832
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 22:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9068416647C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 21:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDE11EC014;
	Fri, 13 Dec 2024 21:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1ciks1M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F921E883E;
	Fri, 13 Dec 2024 21:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734126804; cv=none; b=FPRxabJg34/L0GffY52Q5h2NlcQT152ICdGsrxP5PKE/zhjtwFFnFoQXnQ74DOj+9vaoBgX2kuWi05kYoOHqKGn24Nkj8LECuQEQZm2rVMayCLG6n+wdViLqzaKHhiwKf6z0U3/jC94e/8fGdlwf7RMbsEJvZv3FWuAo7hQWkJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734126804; c=relaxed/simple;
	bh=iQ/qZJ1QHQV0+h/4WTEQK+3ncwWBGkQjrNEPl3UnO74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r8rTDB/jX68ynPheNYOeDbKiZ8EXcCnp8PAlx6T8Na8nCPdadaLTeYBX1R2253fGw9vwcTQw79L4X0jElsT6gzFYBgT9PN0lJ6tFq5kE3/6Uk8UgFvxxitHM9UvWVpLqlMuioLxwHTzEF2XICb6OrcrMSLSxJgJCAoysSsHj4lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1ciks1M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2357EC4CEDD;
	Fri, 13 Dec 2024 21:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734126804;
	bh=iQ/qZJ1QHQV0+h/4WTEQK+3ncwWBGkQjrNEPl3UnO74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A1ciks1MAAQLTtKHJqC1uldwlJ6lT8vW43m5x64l0pW73cebSFC34x+nIOL9ptgDV
	 GdMY7EW9phV13W3Fxdr5MWnfiVyZPE6gEsV2K1Qf/p9YDRXhm0eZIxsa5qGfconTMF
	 OAT2o2klemlx3QxZHU7qN37fNj2yOm5rkUpDwx9BDxn00TItH1BF5ayvM8ZcuDc7xm
	 O1va3eT27f0HyOwXNAnm1Lu7F+jPh2uwZOQ9gusC8vGkGleZnLjrBr9T9vdGR6eP4h
	 6HxcrmKjgaf+rLpT4P9PD/7Of99n+M8ogmTeSi6PpwuwjMIBVO8yFLaxM+rSfgB7jN
	 1Rd/TxZq3PUDA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 7/9] mm/damon/core: implement damos_walk()
Date: Fri, 13 Dec 2024 13:53:04 -0800
Message-Id: <20241213215306.54778-8-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241213215306.54778-1-sj@kernel.org>
References: <20241213215306.54778-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new core layer interface, damos_walk().  It aims to replace
some damon_callback usages that access DAMOS schemes applied regions of
ongoing kdamond with additional synchronizations.  It receives a
function pointer and asks kdamond to invoke it for any region that it will
apply any DAMOS action within one scheme apply interval for every scheme
of it.  The function further waits until the kdamond finishes the
invocations for every scheme, or cancels the request, and returns.

The kdamond invokes the function as requested within the main loop.  If
it is deactivated by DAMOS watermarks or going out of the main loop, it
marks the request as canceled, so that damos_walk() can wakeup and
return.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  33 ++++++++++-
 mm/damon/core.c       | 134 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 165 insertions(+), 2 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 529ea578f2d5..acedaab4dccf 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -368,6 +368,31 @@ struct damos_filter {
 	struct list_head list;
 };
 
+struct damon_ctx;
+struct damos;
+
+/**
+ * struct damos_walk_control - Control damos_walk().
+ *
+ * @walk_fn:	Function to be called back for each region.
+ * @data:	Data that will be passed to walk functions.
+ *
+ * Control damos_walk(), which requests specific kdamond to invoke the given
+ * function to each region that eligible to apply actions of the kdamond's
+ * schemes.  Refer to damos_walk() for more details.
+ */
+struct damos_walk_control {
+	void (*walk_fn)(void *data, struct damon_ctx *ctx,
+			struct damon_target *t, struct damon_region *r,
+			struct damos *s);
+	void *data;
+/* private: internal use only */
+	/* informs if the kdamond finished handling of the walk request */
+	struct completion completion;
+	/* informs if the walk is canceled. */
+	bool canceled;
+};
+
 /**
  * struct damos_access_pattern - Target access pattern of the given scheme.
  * @min_sz_region:	Minimum size of target regions.
@@ -453,6 +478,8 @@ struct damos {
 	 * @action
 	 */
 	unsigned long next_apply_sis;
+	/* informs if ongoing DAMOS walk for this scheme is finished */
+	bool walk_completed;
 /* public: */
 	struct damos_quota quota;
 	struct damos_watermarks wmarks;
@@ -480,8 +507,6 @@ enum damon_ops_id {
 	NR_DAMON_OPS,
 };
 
-struct damon_ctx;
-
 /**
  * struct damon_operations - Monitoring operations for given use cases.
  *
@@ -694,6 +719,9 @@ struct damon_ctx {
 	struct damon_call_control *call_control;
 	struct mutex call_control_lock;
 
+	struct damos_walk_control *walk_control;
+	struct mutex walk_control_lock;
+
 /* public: */
 	struct task_struct *kdamond;
 	struct mutex kdamond_lock;
@@ -842,6 +870,7 @@ int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive);
 int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
 
 int damon_call(struct damon_ctx *ctx, struct damon_call_control *control);
+int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control);
 
 int damon_set_region_biggest_system_ram_default(struct damon_target *t,
 				unsigned long *start, unsigned long *end);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 89a679c06e30..de923b3a1084 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -534,6 +534,7 @@ struct damon_ctx *damon_new_ctx(void)
 
 	mutex_init(&ctx->kdamond_lock);
 	mutex_init(&ctx->call_control_lock);
+	mutex_init(&ctx->walk_control_lock);
 
 	ctx->attrs.min_nr_regions = 10;
 	ctx->attrs.max_nr_regions = 1000;
@@ -1232,6 +1233,46 @@ int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
 	return 0;
 }
 
+/**
+ * damos_walk() - Invoke a given functions while DAMOS walk regions.
+ * @ctx:	DAMON context to call the functions for.
+ * @control:	Control variable of the walk request.
+ *
+ * Ask DAMON worker thread (kdamond) of @ctx to call a function for each region
+ * that the kdamond will apply DAMOS action to, and wait until the kdamond
+ * finishes handling of the request.
+ *
+ * The kdamond executes the given function in the main loop, for each region
+ * just before it applies any DAMOS actions of @ctx to it.  The invocation is
+ * made only within one &damos->apply_interval_us since damos_walk()
+ * invocation, for each scheme.  The given callback function can hence safely
+ * access the internal data of &struct damon_ctx and &struct damon_region that
+ * each of the scheme will apply the action for next interval, without
+ * additional synchronizations against the kdamond.  If every scheme of @ctx
+ * passed at least one &damos->apply_interval_us, kdamond marks the request as
+ * completed so that damos_walk() can wakeup and return.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control)
+{
+	init_completion(&control->completion);
+	control->canceled = false;
+	mutex_lock(&ctx->walk_control_lock);
+	if (ctx->walk_control) {
+		mutex_unlock(&ctx->walk_control_lock);
+		return -EBUSY;
+	}
+	ctx->walk_control = control;
+	mutex_unlock(&ctx->walk_control_lock);
+	if (!damon_is_running(ctx))
+		return -EINVAL;
+	wait_for_completion(&control->completion);
+	if (control->canceled)
+		return -ECANCELED;
+	return 0;
+}
+
 /*
  * Reset the aggregated monitoring results ('nr_accesses' of each region).
  */
@@ -1411,6 +1452,93 @@ static bool damos_filter_out(struct damon_ctx *ctx, struct damon_target *t,
 	return false;
 }
 
+/*
+ * damos_walk_call_walk() - Call &damos_walk_control->walk_fn.
+ * @ctx:	The context of &damon_ctx->walk_control.
+ * @t:		The monitoring target of @r that @s will be applied.
+ * @r:		The region of @t that @s will be applied.
+ * @s:		The scheme of @ctx that will be applied to @r.
+ *
+ * This function is called from kdamond whenever it found a region that
+ * eligible to apply a DAMOS scheme's action.  If a DAMOS walk request is
+ * installed by damos_walk() and its &damos_walk_control->walk_fn has not
+ * invoked for the region for the last &damos->apply_interval_us interval,
+ * invoke it.
+ */
+static void damos_walk_call_walk(struct damon_ctx *ctx, struct damon_target *t,
+		struct damon_region *r, struct damos *s)
+{
+	struct damos_walk_control *control;
+
+	mutex_lock(&ctx->walk_control_lock);
+	control = ctx->walk_control;
+	mutex_unlock(&ctx->walk_control_lock);
+	if (!control)
+		return;
+	control->walk_fn(control->data, ctx, t, r, s);
+}
+
+/*
+ * damos_walk_complete() - Complete DAMOS walk request if all walks are done.
+ * @ctx:	The context of &damon_ctx->walk_control.
+ * @s:		A scheme of @ctx that all walks are now done.
+ *
+ * This function is called when kdamond finished applying the action of a DAMOS
+ * scheme to regions that eligible for the given &damos->apply_interval_us.  If
+ * every scheme of @ctx including @s now finished walking for at least one
+ * &damos->apply_interval_us, this function makrs the handling of the given
+ * DAMOS walk request is done, so that damos_walk() can wake up and return.
+ */
+static void damos_walk_complete(struct damon_ctx *ctx, struct damos *s)
+{
+	struct damos *siter;
+	struct damos_walk_control *control;
+
+	mutex_lock(&ctx->walk_control_lock);
+	control = ctx->walk_control;
+	mutex_unlock(&ctx->walk_control_lock);
+	if (!control)
+		return;
+
+	s->walk_completed = true;
+	/* if all schemes completed, signal completion to walker */
+	damon_for_each_scheme(siter, ctx) {
+		if (!siter->walk_completed)
+			return;
+	}
+	complete(&control->completion);
+	mutex_lock(&ctx->walk_control_lock);
+	ctx->walk_control = NULL;
+	mutex_unlock(&ctx->walk_control_lock);
+}
+
+/*
+ * damos_walk_cancel() - Cancel the current DAMOS walk request.
+ * @ctx:	The context of &damon_ctx->walk_control.
+ *
+ * This function is called when @ctx is deactivated by DAMOS watermarks, DAMOS
+ * walk is requested but there is no DAMOS scheme to walk for, or the kdamond
+ * is already out of the main loop and therefore gonna be terminated, and hence
+ * cannot continue the walks.  This function therefore marks the walk request
+ * as canceled, so that damos_walk() can wake up and return.
+ */
+static void damos_walk_cancel(struct damon_ctx *ctx)
+{
+	struct damos_walk_control *control;
+
+	mutex_lock(&ctx->walk_control_lock);
+	control = ctx->walk_control;
+	mutex_unlock(&ctx->walk_control_lock);
+
+	if (!control)
+		return;
+	control->canceled = true;
+	complete(&control->completion);
+	mutex_lock(&ctx->walk_control_lock);
+	ctx->walk_control = NULL;
+	mutex_unlock(&ctx->walk_control_lock);
+}
+
 static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 		struct damon_region *r, struct damos *s)
 {
@@ -1467,6 +1595,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 		if (damos_filter_out(c, t, r, s))
 			return;
 		ktime_get_coarse_ts64(&begin);
+		damos_walk_call_walk(c, t, r, s);
 		if (c->callback.before_damos_apply)
 			err = c->callback.before_damos_apply(c, t, r, s);
 		if (!err) {
@@ -1745,6 +1874,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 	damon_for_each_scheme(s, c) {
 		if (c->passed_sample_intervals < s->next_apply_sis)
 			continue;
+		damos_walk_complete(c, s);
 		s->next_apply_sis = c->passed_sample_intervals +
 			(s->apply_interval_us ? s->apply_interval_us :
 			 c->attrs.aggr_interval) / sample_interval;
@@ -2077,6 +2207,7 @@ static int kdamond_wait_activation(struct damon_ctx *ctx)
 				ctx->callback.after_wmarks_check(ctx))
 			break;
 		kdamond_call(ctx, true);
+		damos_walk_cancel(ctx);
 	}
 	return -EBUSY;
 }
@@ -2171,6 +2302,8 @@ static int kdamond_fn(void *data)
 		 */
 		if (!list_empty(&ctx->schemes))
 			kdamond_apply_schemes(ctx);
+		else
+			damos_walk_cancel(ctx);
 
 		sample_interval = ctx->attrs.sample_interval ?
 			ctx->attrs.sample_interval : 1;
@@ -2211,6 +2344,7 @@ static int kdamond_fn(void *data)
 	mutex_unlock(&ctx->kdamond_lock);
 
 	kdamond_call(ctx, true);
+	damos_walk_cancel(ctx);
 
 	mutex_lock(&damon_lock);
 	nr_running_ctxs--;
-- 
2.39.5


