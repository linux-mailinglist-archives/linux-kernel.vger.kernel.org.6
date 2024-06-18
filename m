Return-Path: <linux-kernel+bounces-220009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D12B690DB77
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05D71B2214C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D59815ECE2;
	Tue, 18 Jun 2024 18:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkmS4eEK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A83315E5CC;
	Tue, 18 Jun 2024 18:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718734698; cv=none; b=kxPOmNCwfzVwT1FitCgOA1PCVlufFEYk6IUSxAnt2/zYKfbCB07WkZTN6pvgP8MTXRvRYP1XgOadSrCe5hz9Z78kh153ASYH/51apwQyLO8smf1eG8i2xYIBKV05zMDXxAU7Zc9X9JobA5fB4tUzLSJIZ8t4HfLp5EV9SCvxfGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718734698; c=relaxed/simple;
	bh=q0VgTmMSaytJbmDQpkmd078K1WOntRHHU6KIbNuTpyw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aHRuB+AQE9nK0yaEGl0PfPRy8qS48/zTGrU7i89Hxp+ZlfofCSyTDqe+5SIGRAEZTKjHL4EHuB4PxNtvD/pr75zPpgTCZsLmqOTRF+VDoNX+3hujKoS5e1qLSUw3a0KQjmgvU42W5T67GLxSolB2/9nqHraz+o/z+zQqO/ofdOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkmS4eEK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8474BC4AF4D;
	Tue, 18 Jun 2024 18:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718734698;
	bh=q0VgTmMSaytJbmDQpkmd078K1WOntRHHU6KIbNuTpyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CkmS4eEK+RGfSEGakhprTqdICLAAHvNYxJWUiXjUbGGUa5c6g2ophuL2Wu8Lj0a1C
	 cI9uAFIlIZxeUzwJuzK504OugxjO/3Ua7SB5qS1eWPxpLYzM+b31bBJlf48dwAJUno
	 /Y5k6Mf1WepHXE6coENrRieznOFyab+/mDECE0L80avhvug04yb3GIYBOLReoLH64A
	 QJ8ex2EB7T5XB9Vk0xWSgyVRRuou818fpVCzffjhpE3ITKdfNS6sl6kdzkMpaoJgy3
	 3La4c8cUV4YbnnKB/FkY7lwXSo7AfKK8M3YucH1dnjULop/2RDwwZjnHy278NioxT2
	 +JswtLTRyuriw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] mm/damon/core: implement DAMON context commit function
Date: Tue, 18 Jun 2024 11:17:59 -0700
Message-Id: <20240618181809.82078-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240618181809.82078-1-sj@kernel.org>
References: <20240618181809.82078-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement functions for supporting online DAMON context level parameters
update.  The function receives two DAMON context structs.  One is the
struct that currently being used by a kdamond and therefore to be
updated.  The other one contains the parameters to be applied to the
first one.  The function applies the new parameters to the destination
struct while keeping/updating the internal status and operation results.
The function should be called from DAMON context-update-safe place, like
DAMON callbacks.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |   1 +
 mm/damon/core.c       | 274 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 275 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index ce12c9f1b4e4..27c546bfc6d4 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -756,6 +756,7 @@ void damon_destroy_ctx(struct damon_ctx *ctx);
 int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs);
 void damon_set_schemes(struct damon_ctx *ctx,
 			struct damos **schemes, ssize_t nr_schemes);
+int damon_commit_ctx(struct damon_ctx *old_ctx, struct damon_ctx *new_ctx);
 int damon_nr_running_ctxs(void);
 bool damon_is_registered_ops(enum damon_ops_id id);
 int damon_register_ops(struct damon_operations *ops);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index b538a31fbd83..f69250b68bcc 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -725,6 +725,280 @@ int damos_commit_quota_goals(struct damos_quota *dst, struct damos_quota *src)
 	return 0;
 }
 
+static int damos_commit_quota(struct damos_quota *dst, struct damos_quota *src)
+{
+	int err;
+
+	dst->reset_interval = src->reset_interval;
+	dst->ms = src->ms;
+	dst->sz = src->sz;
+	err = damos_commit_quota_goals(dst, src);
+	if (err)
+		return err;
+	dst->weight_sz = src->weight_sz;
+	dst->weight_nr_accesses = src->weight_nr_accesses;
+	dst->weight_age = src->weight_age;
+	return 0;
+}
+
+static struct damos_filter *damos_nth_filter(int n, struct damos *s)
+{
+	struct damos_filter *filter;
+	int i = 0;
+
+	damos_for_each_filter(filter, s) {
+		if (i++ == n)
+			return filter;
+	}
+	return NULL;
+}
+
+static void damos_commit_filter_arg(
+		struct damos_filter *dst, struct damos_filter *src)
+{
+	switch (dst->type) {
+	case DAMOS_FILTER_TYPE_MEMCG:
+		dst->memcg_id = src->memcg_id;
+		break;
+	case DAMOS_FILTER_TYPE_ADDR:
+		dst->addr_range = src->addr_range;
+		break;
+	case DAMOS_FILTER_TYPE_TARGET:
+		dst->target_idx = src->target_idx;
+		break;
+	default:
+		break;
+	}
+}
+
+static void damos_commit_filter(
+		struct damos_filter *dst, struct damos_filter *src)
+{
+	dst->type = src->type;
+	dst->matching = src->matching;
+	damos_commit_filter_arg(dst, src);
+}
+
+static int damos_commit_filters(struct damos *dst, struct damos *src)
+{
+	struct damos_filter *dst_filter, *next, *src_filter, *new_filter;
+	int i = 0, j = 0;
+
+	damos_for_each_filter_safe(dst_filter, next, dst) {
+		src_filter = damos_nth_filter(i++, src);
+		if (src_filter)
+			damos_commit_filter(dst_filter, src_filter);
+		else
+			damos_destroy_filter(dst_filter);
+	}
+
+	damos_for_each_filter_safe(src_filter, next, src) {
+		if (j++ < i)
+			continue;
+
+		new_filter = damos_new_filter(
+				src_filter->type, src_filter->matching);
+		if (!new_filter)
+			return -ENOMEM;
+		damos_commit_filter_arg(new_filter, src_filter);
+		damos_add_filter(dst, new_filter);
+	}
+	return 0;
+}
+
+static struct damos *damon_nth_scheme(int n, struct damon_ctx *ctx)
+{
+	struct damos *s;
+	int i = 0;
+
+	damon_for_each_scheme(s, ctx) {
+		if (i++ == n)
+			return s;
+	}
+	return NULL;
+}
+
+static int damos_commit(struct damos *dst, struct damos *src)
+{
+	int err;
+
+	dst->pattern = src->pattern;
+	dst->action = src->action;
+	dst->apply_interval_us = src->apply_interval_us;
+
+	err = damos_commit_quota(&dst->quota, &src->quota);
+	if (err)
+		return err;
+
+	dst->wmarks = src->wmarks;
+
+	err = damos_commit_filters(dst, src);
+	return err;
+}
+
+static int damon_commit_schemes(struct damon_ctx *dst, struct damon_ctx *src)
+{
+	struct damos *dst_scheme, *next, *src_scheme, *new_scheme;
+	int i = 0, j = 0, err;
+
+	damon_for_each_scheme_safe(dst_scheme, next, dst) {
+		src_scheme = damon_nth_scheme(i++, src);
+		if (src_scheme) {
+			err = damos_commit(dst_scheme, src_scheme);
+			if (err)
+				return err;
+		} else {
+			damon_destroy_scheme(dst_scheme);
+		}
+	}
+
+	damon_for_each_scheme_safe(src_scheme, next, src) {
+		if (j++ < i)
+			continue;
+		new_scheme = damon_new_scheme(&src_scheme->pattern,
+				src_scheme->action,
+				src_scheme->apply_interval_us,
+				&src_scheme->quota, &src_scheme->wmarks,
+				NUMA_NO_NODE);
+		if (!new_scheme)
+			return -ENOMEM;
+		damon_add_scheme(dst, new_scheme);
+	}
+	return 0;
+}
+
+static struct damon_target *damon_nth_target(int n, struct damon_ctx *ctx)
+{
+	struct damon_target *t;
+	int i = 0;
+
+	damon_for_each_target(t, ctx) {
+		if (i++ == n)
+			return t;
+	}
+	return NULL;
+}
+
+/*
+ * The caller should ensure the regions of @src are
+ * 1. valid (end >= src) and
+ * 2. sorted by starting address.
+ *
+ * If @src has no region, @dst keeps current regions.
+ */
+static int damon_commit_target_regions(
+		struct damon_target *dst, struct damon_target *src)
+{
+	struct damon_region *src_region;
+	struct damon_addr_range *ranges;
+	int i = 0, err;
+
+	damon_for_each_region(src_region, src)
+		i++;
+	if (!i)
+		return 0;
+
+	ranges = kmalloc_array(i, sizeof(*ranges), GFP_KERNEL | __GFP_NOWARN);
+	if (!ranges)
+		return -ENOMEM;
+	i = 0;
+	damon_for_each_region(src_region, src)
+		ranges[i++] = src_region->ar;
+	err = damon_set_regions(dst, ranges, i);
+	kfree(ranges);
+	return err;
+}
+
+static int damon_commit_target(
+		struct damon_target *dst, bool dst_has_pid,
+		struct damon_target *src, bool src_has_pid)
+{
+	int err;
+
+	err = damon_commit_target_regions(dst, src);
+	if (err)
+		return err;
+	if (dst_has_pid)
+		put_pid(dst->pid);
+	if (src_has_pid)
+		get_pid(src->pid);
+	dst->pid = src->pid;
+	return 0;
+}
+
+static int damon_commit_targets(
+		struct damon_ctx *dst, struct damon_ctx *src)
+{
+	struct damon_target *dst_target, *next, *src_target, *new_target;
+	int i = 0, j = 0, err;
+
+	damon_for_each_target_safe(dst_target, next, dst) {
+		src_target = damon_nth_target(i++, src);
+		if (src_target) {
+			err = damon_commit_target(
+					dst_target, damon_target_has_pid(dst),
+					src_target, damon_target_has_pid(src));
+			if (err)
+				return err;
+		} else {
+			if (damon_target_has_pid(dst))
+				put_pid(dst_target->pid);
+			damon_destroy_target(dst_target);
+		}
+	}
+
+	damon_for_each_target_safe(src_target, next, src) {
+		if (j++ < i)
+			continue;
+		new_target = damon_new_target();
+		if (!new_target)
+			return -ENOMEM;
+		err = damon_commit_target(new_target, false,
+				src_target, damon_target_has_pid(src));
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
+/**
+ * damon_commit_ctx() - Commit parameters of a DAMON context to another.
+ * @dst:	The commit destination DAMON context.
+ * @src:	The commit source DAMON context.
+ *
+ * This function copies user-specified parameters from @src to @dst and update
+ * the internal status and results accordingly.  Users should use this function
+ * for context-level parameters update of running context, instead of manual
+ * in-place updates.
+ *
+ * This function should be called from parameters-update safe context, like
+ * DAMON callbacks.
+ */
+int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
+{
+	int err;
+
+	err = damon_commit_schemes(dst, src);
+	if (err)
+		return err;
+	err = damon_commit_targets(dst, src);
+	if (err)
+		return err;
+	/*
+	 * schemes and targets should be updated first, since
+	 * 1. damon_set_attrs() updates monitoring results of targets and
+	 * next_apply_sis of schemes, and
+	 * 2. ops update should be done after pid handling is done (target
+	 *    committing require putting pids).
+	 */
+	err = damon_set_attrs(dst, &src->attrs);
+	if (err)
+		return err;
+	dst->ops = src->ops;
+
+	return 0;
+}
+
 /**
  * damon_nr_running_ctxs() - Return number of currently running contexts.
  */
-- 
2.39.2


