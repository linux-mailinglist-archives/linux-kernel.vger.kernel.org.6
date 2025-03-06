Return-Path: <linux-kernel+bounces-549547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D37A553C9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58ADA3B634F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667BA26B0AD;
	Thu,  6 Mar 2025 17:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAqr6+Ts"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9661426A1D8;
	Thu,  6 Mar 2025 17:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741283957; cv=none; b=t94e05hfsWqE0scMD4PXOtL6lKAgUJe4xYVUiBfvrLw/kMiNXMbZOSV8OZtvFwdKcYsILNCd3wT8iIB6LvjRoMudRYWvt15VF04M49ejpMh09BH0KiygYa0SdEDgyxF3oK6ZIqRMllbKyNujEAGxnchDCuCkZvKwynRialbiTN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741283957; c=relaxed/simple;
	bh=xWjhCxNDcVvgRyq+QB/ZEVdI2Y9i2Y/Y3beU15kO7Bg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i5OG51IzPULIwEbidHeZSvihie4fylgs2tduts9ZDdBYdV+/WAYpQKhIFg9bER+j59KkQPvJcKmPPmRxocMa3ukxZKZzg+uY/oMSWdelI4o9WPxWq7wfhKbc6VL+RJIJrIq+KQBYCXeCE6dmYzm+6Fz5UeOQJ6UbAz4u20rKLfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAqr6+Ts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6772C4CEEB;
	Thu,  6 Mar 2025 17:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741283956;
	bh=xWjhCxNDcVvgRyq+QB/ZEVdI2Y9i2Y/Y3beU15kO7Bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OAqr6+TsOPNYIpJLR2VqTCMMLcMDQrYmEIqMUWvCJAJiKhrVo5H30b4CCRxLVnSJk
	 GJWKg6sOMW+nVChnR6VIdqyq2KagbdswAvM+w+vRrNbmMiT6d45hmb0rcGfUEUzQxV
	 gS+zjda5aMT7X5IB9FReABTZAdT3IGynshnJXABmCvsmM+1vIxpdRq7IdhAVT3EJ58
	 lDRPM1awE5pI6M8H+GTXvxm1Abob0R0yBi3E7IWDl+QhcFXVLarK7m4vrN6GbXipXV
	 dfi6cFKhw3lt+34rTPZdYO7DOUMFnxUoefthMnPoVcquiy0SQCMZ+4xo2jyAu1geEr
	 3PcvV0K/H7SQg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 03/13] mm/damon/core: make damon_set_attrs() be safe to be called from damon_call()
Date: Thu,  6 Mar 2025 09:58:58 -0800
Message-Id: <20250306175908.66300-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250306175908.66300-1-sj@kernel.org>
References: <20250306175908.66300-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently all DAMON kernel API callers do online DAMON parameters commit
from damon_callback->after_aggregation because only those are safe place
to call the DAMON monitoring attributes update function, namely
damon_set_attrs().

Because damon_callback hooks provide no synchronization, the callers
work in asynchronous ways or implement their own inefficient and
complicated synchronization mechanisms.  It also means online DAMON
parameters commit can take up to one aggregation interval.  On large
systems having long aggregation intervals, that can be too slow.  The
synchronization can be done in more efficient and simple way while
removing the latency constraint if it can be done using damon_call().

The fact that damon_call() can be executed in the middle of the
aggregation makes damon_set_attrs() unsafe to be called from it, though.
Two real problems can occur in the case.  First, converting the not yet
completely aggregated nr_accesses for new user-set intervals can
arguably degrade the accuracy or at least make the logic complicated.
Second, kdamond_reset_aggregated() will not be called after the
monitoring results update, so next aggregation starts from unclean
state.  This can result in inconsistent and unexpected nr_accesses_bp.

Make it safe as follows.  Catch the middle-of-the-aggregation case from
damon_set_attrs() by checking the passed_sample_intervals and
next_aggregationsis of the context.  And pass the information to
nr_accesses conversion logic.  The logic works as before if it is not
the case (called after the current aggregation is completed).  If it is
the case (committing parameters in the middle of the aggregation), it
drops the nr_accesses information that so far aggregated, and make the
status same to the beginning of this aggregation, but as if the last
aggregation was started with the updated sampling/aggregation intervals.

The middle-of-aggregastion check introduce yet another edge case,
though.  This happens because kdamond_tune_intervals() can also call
damon_set_attrs() with the middle-of-aggregation check.  Consider
damon_call() for parameters commit and kdamond_tune_intervals() are
called in same iteration of kdamond main loop.  Because
kdamond_tune_interval() is called for aggregation intervals, it should
be the end of the aggregation.  The first damon_set_attrs() call from
kdamond_call() understands it is the end of the aggregation and
correctly handle it.  But, because the damon_set_attrs() updated
next_aggregation_sis of the context.  Hence, the second
damon_set_attrs() invocation from kdamond_tune_interval() believes it is
called in the middle of the aggregation.  It therefore resets aggregated
information so far.  After that, kdamond_reset_interval() is called and
double-reset the aggregated information.  Avoid this case, too, by
setting the next_aggregation_sis before kdamond_tune_intervals() is
invoked.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c             | 56 +++++++++++++++++++++++++++++--------
 mm/damon/tests/core-kunit.h |  6 ++--
 2 files changed, 48 insertions(+), 14 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 0f359b4ebf1a..de30b788e13a 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -603,11 +603,25 @@ static unsigned int damon_nr_accesses_for_new_attrs(unsigned int nr_accesses,
 }
 
 static void damon_update_monitoring_result(struct damon_region *r,
-		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs)
+		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs,
+		bool aggregating)
 {
-	r->nr_accesses = damon_nr_accesses_for_new_attrs(r->nr_accesses,
-			old_attrs, new_attrs);
-	r->nr_accesses_bp = r->nr_accesses * 10000;
+	if (!aggregating) {
+		r->nr_accesses = damon_nr_accesses_for_new_attrs(
+				r->nr_accesses, old_attrs, new_attrs);
+		r->nr_accesses_bp = r->nr_accesses * 10000;
+	} else {
+		/*
+		 * if this is called in the middle of the aggregation, reset
+		 * the aggregations we made so far for this aggregation
+		 * interval.  In other words, make the status like
+		 * kdamond_reset_aggregated() is called.
+		 */
+		r->last_nr_accesses = damon_nr_accesses_for_new_attrs(
+				r->last_nr_accesses, old_attrs, new_attrs);
+		r->nr_accesses_bp = r->last_nr_accesses * 10000;
+		r->nr_accesses = 0;
+	}
 	r->age = damon_age_for_new_attrs(r->age, old_attrs, new_attrs);
 }
 
@@ -620,7 +634,7 @@ static void damon_update_monitoring_result(struct damon_region *r,
  * ->nr_accesses and ->age of given damon_ctx's regions for new damon_attrs.
  */
 static void damon_update_monitoring_results(struct damon_ctx *ctx,
-		struct damon_attrs *new_attrs)
+		struct damon_attrs *new_attrs, bool aggregating)
 {
 	struct damon_attrs *old_attrs = &ctx->attrs;
 	struct damon_target *t;
@@ -635,7 +649,7 @@ static void damon_update_monitoring_results(struct damon_ctx *ctx,
 	damon_for_each_target(t, ctx)
 		damon_for_each_region(r, t)
 			damon_update_monitoring_result(
-					r, old_attrs, new_attrs);
+					r, old_attrs, new_attrs, aggregating);
 }
 
 /*
@@ -662,10 +676,10 @@ static bool damon_valid_intervals_goal(struct damon_attrs *attrs)
  * @ctx:		monitoring context
  * @attrs:		monitoring attributes
  *
- * This function should be called while the kdamond is not running, or an
- * access check results aggregation is not ongoing (e.g., from
- * &struct damon_callback->after_aggregation or
- * &struct damon_callback->after_wmarks_check callbacks).
+ * This function should be called while the kdamond is not running, an access
+ * check results aggregation is not ongoing (e.g., from &struct
+ * damon_callback->after_aggregation or &struct
+ * damon_callback->after_wmarks_check callbacks), or from damon_call().
  *
  * Every time interval is in micro-seconds.
  *
@@ -676,6 +690,8 @@ int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
 	unsigned long sample_interval = attrs->sample_interval ?
 		attrs->sample_interval : 1;
 	struct damos *s;
+	bool aggregating = ctx->passed_sample_intervals <
+		ctx->next_aggregation_sis;
 
 	if (!damon_valid_intervals_goal(attrs))
 		return -EINVAL;
@@ -696,7 +712,7 @@ int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
 	ctx->next_ops_update_sis = ctx->passed_sample_intervals +
 		attrs->ops_update_interval / sample_interval;
 
-	damon_update_monitoring_results(ctx, attrs);
+	damon_update_monitoring_results(ctx, attrs, aggregating);
 	ctx->attrs = *attrs;
 
 	damon_for_each_scheme(s, ctx)
@@ -2452,6 +2468,24 @@ static int kdamond_fn(void *data)
 			if (ctx->attrs.intervals_goal.aggrs &&
 					ctx->passed_sample_intervals >=
 					ctx->next_intervals_tune_sis) {
+				/*
+				 * ctx->next_aggregation_sis might be updated
+				 * from kdamond_call().  In the case,
+				 * damon_set_attrs() which will be called from
+				 * kdamond_tune_interval() may wrongly think
+				 * this is in the middle of the current
+				 * aggregation, and make aggregation
+				 * information reset for all regions.  Then,
+				 * following kdamond_reset_aggregated() call
+				 * will make the region information invalid,
+				 * particularly for ->nr_accesses_bp.
+				 *
+				 * Reset ->next_aggregation_sis to avoid that.
+				 * It will anyway correctly updated after this
+				 * if caluse.
+				 */
+				ctx->next_aggregation_sis =
+					next_aggregation_sis;
 				ctx->next_intervals_tune_sis +=
 					ctx->attrs.aggr_samples *
 					ctx->attrs.intervals_goal.aggrs;
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 532c6a6f21f9..be0fea9ee5fc 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -348,19 +348,19 @@ static void damon_test_update_monitoring_result(struct kunit *test)
 
 	new_attrs = (struct damon_attrs){
 		.sample_interval = 100, .aggr_interval = 10000,};
-	damon_update_monitoring_result(r, &old_attrs, &new_attrs);
+	damon_update_monitoring_result(r, &old_attrs, &new_attrs, false);
 	KUNIT_EXPECT_EQ(test, r->nr_accesses, 15);
 	KUNIT_EXPECT_EQ(test, r->age, 2);
 
 	new_attrs = (struct damon_attrs){
 		.sample_interval = 1, .aggr_interval = 1000};
-	damon_update_monitoring_result(r, &old_attrs, &new_attrs);
+	damon_update_monitoring_result(r, &old_attrs, &new_attrs, false);
 	KUNIT_EXPECT_EQ(test, r->nr_accesses, 150);
 	KUNIT_EXPECT_EQ(test, r->age, 2);
 
 	new_attrs = (struct damon_attrs){
 		.sample_interval = 1, .aggr_interval = 100};
-	damon_update_monitoring_result(r, &old_attrs, &new_attrs);
+	damon_update_monitoring_result(r, &old_attrs, &new_attrs, false);
 	KUNIT_EXPECT_EQ(test, r->nr_accesses, 150);
 	KUNIT_EXPECT_EQ(test, r->age, 20);
 
-- 
2.39.5

