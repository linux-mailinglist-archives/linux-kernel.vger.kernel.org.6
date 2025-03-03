Return-Path: <linux-kernel+bounces-542815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1438EA4CE19
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 23:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBA903AD354
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 22:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CE323907E;
	Mon,  3 Mar 2025 22:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQZOp2wi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF725237702;
	Mon,  3 Mar 2025 22:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741040254; cv=none; b=SrUYj5ZF5+hrn2YVFIijp+RZppZs6Rs40WgYnyc4aHB9jPzwlc6G9f0X0ooeHrcYEj1Lb09BlqlPz2T8+0g3gx/8MVgNJjIRCwaAP8QXnBaekkbiMfRBfO46rX6YuW2Z+pyCPzaLSelxbJzZWspu24nq5YKJR6u29GpoEmAt7hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741040254; c=relaxed/simple;
	bh=nNrODnOa9RS2rW/W7BbbOd+/X+ZlX/z8fAm6OpZQMuM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l/zd+/o6tHpwXpoROdZMS087AbDhcK8au6HqONKUDvc8FkuM4sqRMs3RakShjny0yX9FsXqyNHr5pAiDex9JYLPYoPhlel9XF5L3sbKsGNNH21oaaYqjJEr/WpvZ0DhXoD/CBMPfHxrmx8CnPZaerKBscTb9h/SJeGEx5zPaWoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQZOp2wi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEAF7C4CEE6;
	Mon,  3 Mar 2025 22:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741040254;
	bh=nNrODnOa9RS2rW/W7BbbOd+/X+ZlX/z8fAm6OpZQMuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YQZOp2wi8QtcDcLx4CehWUfk8pKN1UIgYZ/j5qo/V2J5h5A+GDFVKRKrv7EjHdl9v
	 3vyvJRlzucFIzqJbwAOWT3fk3QqNzMjhlc6B+k6bkH2sDz/7kgow9Tx8t9l+UyuVe1
	 mPRha08uIuKPjp3NfS7Yr1znR7hrosDgbPQbje9al72s2j9TV6Fi7kPNmxf3pqAW2n
	 awoPprDyb6B+JAvh1E3l6exNEhTZSuLb0RE6FhQsJD4mX04lzUTNOlQw9MFSJomVc0
	 NrqsvWlo5i8P5HIoXed8N+oYnRTVgQXlHsySAB+HtgntJTEoNrn9De/kIhwzgW8uK0
	 99F3Cd+AAoZfA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/8] mm/damon/core: implement intervals auto-tuning
Date: Mon,  3 Mar 2025 14:17:20 -0800
Message-Id: <20250303221726.484227-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303221726.484227-1-sj@kernel.org>
References: <20250303221726.484227-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the DAMON sampling and aggregation intervals auto-tuning
mechanism as briefly described on 'struct damon_intervals_goal'.  The
core part for deciding the direction and amount of the changes is
implemented reusing the feedback loop function which is being used for
DAMOS quotas auto-tuning.  Unlike the DAMOS quotas auto-tuning use case,
limit the maximum decreasing amount after the adjustment to 50% of the
current value, though.  This is because the intervals have no good
merits at rapid reductions since it could unnecessarily increase the
monitoring overhead.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 16 +++++++++
 mm/damon/core.c       | 76 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 5f2609f24761..b3e2c793c1f4 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -713,6 +713,17 @@ struct damon_attrs {
 	struct damon_intervals_goal intervals_goal;
 	unsigned long min_nr_regions;
 	unsigned long max_nr_regions;
+/* private: internal use only */
+	/*
+	 * @aggr_interval to @sample_interval ratio.
+	 * Core-external components call damon_set_attrs() with &damon_attrs
+	 * that this field is unset.  In the case, damon_set_attrs() sets this
+	 * field of resulting &damon_attrs.  Core-internal components such as
+	 * kdamond_tune_intervals() calls damon_set_attrs() with &damon_attrs
+	 * that this field is set.  In the case, damon_set_attrs() just keep
+	 * it.
+	 */
+	unsigned long aggr_samples;
 };
 
 /**
@@ -761,6 +772,11 @@ struct damon_ctx {
 	 * update
 	 */
 	unsigned long next_ops_update_sis;
+	/*
+	 * number of sample intervals that should be passed before next
+	 * intervals tuning
+	 */
+	unsigned long next_intervals_tune_sis;
 	/* for waiting until the execution of the kdamond_fn is started */
 	struct completion kdamond_started;
 	/* for scheme quotas prioritization */
diff --git a/mm/damon/core.c b/mm/damon/core.c
index ad3b5c065cb8..9d37d3664030 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -664,6 +664,10 @@ int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
 	if (attrs->sample_interval > attrs->aggr_interval)
 		return -EINVAL;
 
+	/* calls from core-external doesn't set this. */
+	if (!attrs->aggr_samples)
+		attrs->aggr_samples = attrs->aggr_interval / sample_interval;
+
 	ctx->next_aggregation_sis = ctx->passed_sample_intervals +
 		attrs->aggr_interval / sample_interval;
 	ctx->next_ops_update_sis = ctx->passed_sample_intervals +
@@ -1301,6 +1305,65 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 	}
 }
 
+static unsigned long damon_get_intervals_score(struct damon_ctx *c)
+{
+	struct damon_target *t;
+	struct damon_region *r;
+	unsigned long sz_region, max_access_events = 0, access_events = 0;
+	unsigned long target_access_events;
+	unsigned long goal_bp = c->attrs.intervals_goal.access_bp;
+
+	damon_for_each_target(t, c) {
+		damon_for_each_region(r, t) {
+			sz_region = damon_sz_region(r);
+			max_access_events += sz_region * c->attrs.aggr_samples;
+			access_events += sz_region * r->nr_accesses;
+		}
+	}
+	target_access_events = max_access_events * goal_bp / 10000;
+	return access_events * 10000 / target_access_events;
+}
+
+static unsigned long damon_feed_loop_next_input(unsigned long last_input,
+		unsigned long score);
+
+static unsigned long damon_get_intervals_adaptation_bp(struct damon_ctx *c)
+{
+	unsigned long score_bp, adaptation_bp;
+
+	score_bp = damon_get_intervals_score(c);
+	adaptation_bp = damon_feed_loop_next_input(100000000, score_bp) /
+		10000;
+	/*
+	 * adaptaion_bp ranges from 1 to 20,000.  Avoid too rapid reduction of
+	 * the intervals by rescaling [1,10,000] to [5000, 10,000].
+	 */
+	if (adaptation_bp <= 10000)
+		adaptation_bp = 5000 + adaptation_bp / 2;
+	return adaptation_bp;
+}
+
+static void kdamond_tune_intervals(struct damon_ctx *c)
+{
+	unsigned long adaptation_bp;
+	struct damon_attrs new_attrs;
+	struct damon_intervals_goal *goal;
+
+	adaptation_bp = damon_get_intervals_adaptation_bp(c);
+	if (adaptation_bp == 10000)
+		return;
+
+	new_attrs = c->attrs;
+	goal = &c->attrs.intervals_goal;
+	new_attrs.sample_interval = min(goal->max_sample_us,
+			c->attrs.sample_interval * adaptation_bp / 10000);
+	new_attrs.sample_interval = max(goal->min_sample_us,
+			new_attrs.sample_interval);
+	new_attrs.aggr_interval = new_attrs.sample_interval *
+		c->attrs.aggr_samples;
+	damon_set_attrs(c, &new_attrs);
+}
+
 static void damon_split_region_at(struct damon_target *t,
 				  struct damon_region *r, unsigned long sz_r);
 
@@ -2209,6 +2272,8 @@ static void kdamond_init_intervals_sis(struct damon_ctx *ctx)
 	ctx->next_aggregation_sis = ctx->attrs.aggr_interval / sample_interval;
 	ctx->next_ops_update_sis = ctx->attrs.ops_update_interval /
 		sample_interval;
+	ctx->next_intervals_tune_sis = ctx->next_aggregation_sis *
+		ctx->attrs.intervals_goal.aggrs;
 
 	damon_for_each_scheme(scheme, ctx) {
 		apply_interval = scheme->apply_interval_us ?
@@ -2293,6 +2358,17 @@ static int kdamond_fn(void *data)
 		sample_interval = ctx->attrs.sample_interval ?
 			ctx->attrs.sample_interval : 1;
 		if (ctx->passed_sample_intervals >= next_aggregation_sis) {
+			if (ctx->attrs.intervals_goal.aggrs &&
+					ctx->passed_sample_intervals >=
+					ctx->next_intervals_tune_sis) {
+				ctx->next_intervals_tune_sis +=
+					ctx->attrs.aggr_samples *
+					ctx->attrs.intervals_goal.aggrs;
+				kdamond_tune_intervals(ctx);
+				sample_interval = ctx->attrs.sample_interval ?
+					ctx->attrs.sample_interval : 1;
+
+			}
 			ctx->next_aggregation_sis = next_aggregation_sis +
 				ctx->attrs.aggr_interval / sample_interval;
 
-- 
2.39.5

