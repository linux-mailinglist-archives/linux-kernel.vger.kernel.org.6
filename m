Return-Path: <linux-kernel+bounces-445605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B576A9F1834
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 22:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8D81166A64
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 21:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C4E1EF080;
	Fri, 13 Dec 2024 21:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0E3zVoC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2B5194C8B;
	Fri, 13 Dec 2024 21:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734126808; cv=none; b=ghceyO2TAp9gFrXo4YLl2zU4oumzVZOcqsCCpfymGgmbgB0gbGwQ8ttg4P3YjfC9RJyxo5Tj7VfAF/HjF5jAhtphWmGT0yisQff+JSa8rQatvKzWaoC7YtLFyr5nPNZ5lEofcs6kUEiD+98gqPRmbe3uI/XZlQAL5LkpS/B1it8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734126808; c=relaxed/simple;
	bh=ZVUan1fZkxzqrz+Kv9xlvlqW12Ur6Dh+XlW22jd7kFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HRhVho+zhtUIAJg2/ydD7UdYGmAZ1igxnVko6UJAxLOrCVoin8hvFbJ60kkaRuU+MY/54FNJoe52ofBDIv6f6NwyxGmWvuYzoMt+tBFziwP5paGa5apPd5R0nqJRk9NkbSP3TFlpXeXYvJteJ1j4hrSerNO9CasGsLisWZQRosc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0E3zVoC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C85C4CEDF;
	Fri, 13 Dec 2024 21:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734126806;
	bh=ZVUan1fZkxzqrz+Kv9xlvlqW12Ur6Dh+XlW22jd7kFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S0E3zVoCoJpubrVS278f6wuW045DOZ9ZeBH8yXyzO9kDubGZPmBP6QlG/QHK3Jkpy
	 YlLqC9V72MTkRYgamfMWU7FrrcbWMuTjrHqilyTfswU8DpTX/Lg+6YTPVkz7g3jQKD
	 0ZWE+qaBQqKPrz8nIhAOY+pMjaW2dDXO4fwdCqfJ2X61tybGzg0pPqCATM1qGj1WjO
	 XUk/u7KVqMGMY1kIeWl9GYh8FB8vTN7UNqEPR99Hw1n70NEBHe8YlqH+aK3UA8zl54
	 ihQknlRi//zkZIOSk0aO7dehD8ZtbczYdfhpvqSiyQsMOBvb4sJtFvKBqr7WnibqG1
	 BI4AK7SW7LD6Q==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 9/9] mm/damon/sysfs: remove unused code for schemes tried regions update
Date: Fri, 13 Dec 2024 13:53:06 -0800
Message-Id: <20241213215306.54778-10-sj@kernel.org>
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

DAMON sysfs interface was using damon_callback with its own complicated
synchronization logics to update DAMOS scheme applied regions
directories and files.  But it is replaced to use damos_walk(), and the
additional synchronization logics are no more being used.  Remove those.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-common.h  |  10 --
 mm/damon/sysfs-schemes.c | 204 ---------------------------------------
 mm/damon/sysfs.c         |  70 +-------------
 3 files changed, 2 insertions(+), 282 deletions(-)

diff --git a/mm/damon/sysfs-common.h b/mm/damon/sysfs-common.h
index 81f1c845118f..b3f63bc658b7 100644
--- a/mm/damon/sysfs-common.h
+++ b/mm/damon/sysfs-common.h
@@ -45,16 +45,6 @@ void damon_sysfs_schemes_update_stats(
 		struct damon_sysfs_schemes *sysfs_schemes,
 		struct damon_ctx *ctx);
 
-int damon_sysfs_schemes_update_regions_start(
-		struct damon_sysfs_schemes *sysfs_schemes,
-		struct damon_ctx *ctx, bool total_bytes_only);
-
-void damos_sysfs_mark_finished_regions_updates(struct damon_ctx *ctx);
-
-bool damos_sysfs_regions_upd_done(void);
-
-int damon_sysfs_schemes_update_regions_stop(struct damon_ctx *ctx);
-
 void damos_sysfs_populate_region_dir(struct damon_sysfs_schemes *sysfs_schemes,
 		struct damon_ctx *ctx, struct damon_target *t,
 		struct damon_region *r, struct damos *s,
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 404c21f45640..5000d81d0d83 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -114,55 +114,11 @@ static const struct kobj_type damon_sysfs_scheme_region_ktype = {
  * scheme regions directory
  */
 
-/*
- * enum damos_sysfs_regions_upd_status - Represent DAMOS tried regions update
- *					 status
- * @DAMOS_TRIED_REGIONS_UPD_IDLE:		Waiting for next request.
- * @DAMOS_TRIED_REGIONS_UPD_STARTED:		Update started.
- * @DAMOS_TRIED_REGIONS_UPD_FINISHED:	Update finished.
- *
- * Each DAMON-based operation scheme (&struct damos) has its own apply
- * interval, and we need to expose the scheme tried regions based on only
- * single snapshot.  For this, we keep the tried regions update status for each
- * scheme.  The status becomes 'idle' at the beginning.
- *
- * Once the tried regions update request is received, the request handling
- * start function (damon_sysfs_scheme_update_regions_start()) sets the status
- * of all schemes as 'idle' again, and register ->before_damos_apply()
- * callback.
- *
- * Then, the first followup ->before_damos_apply() callback
- * (damon_sysfs_before_damos_apply()) sets the status 'started'.  The first
- * ->after_sampling() or ->after_aggregation() callback
- *  (damon_sysfs_cmd_request_callback()) after the call is called only after
- *  the scheme is completely applied to the given snapshot.  Hence the callback
- *  knows the situation by showing 'started' status, and sets the status as
- *  'finished'.  Then, damon_sysfs_before_damos_apply() understands the
- *  situation by showing the 'finished' status and do nothing.
- *
- * If DAMOS is not applied to any region due to any reasons including the
- * access pattern, the watermarks, the quotas, and the filters,
- * ->before_damos_apply() will not be called back.  Until the situation is
- * changed, the update will not be finished.  To avoid this,
- * damon_sysfs_after_sampling() set the status as 'finished' if more than two
- * apply intervals of the scheme is passed while the state is 'idle'.
- *
- *  Finally, the tried regions request handling finisher function
- *  (damon_sysfs_schemes_update_regions_stop()) unregisters the callbacks.
- */
-enum damos_sysfs_regions_upd_status {
-	DAMOS_TRIED_REGIONS_UPD_IDLE,
-	DAMOS_TRIED_REGIONS_UPD_STARTED,
-	DAMOS_TRIED_REGIONS_UPD_FINISHED,
-};
-
 struct damon_sysfs_scheme_regions {
 	struct kobject kobj;
 	struct list_head regions_list;
 	int nr_regions;
 	unsigned long total_bytes;
-	enum damos_sysfs_regions_upd_status upd_status;
-	unsigned long upd_timeout_jiffies;
 };
 
 static struct damon_sysfs_scheme_regions *
@@ -178,7 +134,6 @@ damon_sysfs_scheme_regions_alloc(void)
 	INIT_LIST_HEAD(&regions->regions_list);
 	regions->nr_regions = 0;
 	regions->total_bytes = 0;
-	regions->upd_status = DAMOS_TRIED_REGIONS_UPD_IDLE;
 	return regions;
 }
 
@@ -2131,63 +2086,6 @@ void damon_sysfs_schemes_update_stats(
 	}
 }
 
-/*
- * damon_sysfs_schemes that need to update its schemes regions dir.  Protected
- * by damon_sysfs_lock
- */
-static struct damon_sysfs_schemes *damon_sysfs_schemes_for_damos_callback;
-static int damon_sysfs_schemes_region_idx;
-static bool damos_regions_upd_total_bytes_only;
-
-/*
- * DAMON callback that called before damos apply.  While this callback is
- * registered, damon_sysfs_lock should be held to ensure the regions
- * directories exist.
- */
-static int damon_sysfs_before_damos_apply(struct damon_ctx *ctx,
-		struct damon_target *t, struct damon_region *r,
-		struct damos *s)
-{
-	struct damos *scheme;
-	struct damon_sysfs_scheme_regions *sysfs_regions;
-	struct damon_sysfs_scheme_region *region;
-	struct damon_sysfs_schemes *sysfs_schemes =
-		damon_sysfs_schemes_for_damos_callback;
-	int schemes_idx = 0;
-
-	damon_for_each_scheme(scheme, ctx) {
-		if (scheme == s)
-			break;
-		schemes_idx++;
-	}
-
-	/* user could have removed the scheme sysfs dir */
-	if (schemes_idx >= sysfs_schemes->nr)
-		return 0;
-
-	sysfs_regions = sysfs_schemes->schemes_arr[schemes_idx]->tried_regions;
-	if (sysfs_regions->upd_status == DAMOS_TRIED_REGIONS_UPD_FINISHED)
-		return 0;
-	if (sysfs_regions->upd_status == DAMOS_TRIED_REGIONS_UPD_IDLE)
-		sysfs_regions->upd_status = DAMOS_TRIED_REGIONS_UPD_STARTED;
-	sysfs_regions->total_bytes += r->ar.end - r->ar.start;
-	if (damos_regions_upd_total_bytes_only)
-		return 0;
-
-	region = damon_sysfs_scheme_region_alloc(r);
-	if (!region)
-		return 0;
-	list_add_tail(&region->list, &sysfs_regions->regions_list);
-	sysfs_regions->nr_regions++;
-	if (kobject_init_and_add(&region->kobj,
-				&damon_sysfs_scheme_region_ktype,
-				&sysfs_regions->kobj, "%d",
-				damon_sysfs_schemes_region_idx++)) {
-		kobject_put(&region->kobj);
-	}
-	return 0;
-}
-
 /**
  * damos_sysfs_populate_region_dir() - Populate a schemes tried region dir.
  * @sysfs_schemes:	Schemes directory to populate regions directory.
@@ -2236,29 +2134,6 @@ void damos_sysfs_populate_region_dir(struct damon_sysfs_schemes *sysfs_schemes,
 	}
 }
 
-/*
- * DAMON callback that called after each accesses sampling.  While this
- * callback is registered, damon_sysfs_lock should be held to ensure the
- * regions directories exist.
- */
-void damos_sysfs_mark_finished_regions_updates(struct damon_ctx *ctx)
-{
-	struct damon_sysfs_schemes *sysfs_schemes =
-		damon_sysfs_schemes_for_damos_callback;
-	struct damon_sysfs_scheme_regions *sysfs_regions;
-	int i;
-
-	for (i = 0; i < sysfs_schemes->nr; i++) {
-		sysfs_regions = sysfs_schemes->schemes_arr[i]->tried_regions;
-		if (sysfs_regions->upd_status ==
-				DAMOS_TRIED_REGIONS_UPD_STARTED ||
-				time_after(jiffies,
-					sysfs_regions->upd_timeout_jiffies))
-			sysfs_regions->upd_status =
-				DAMOS_TRIED_REGIONS_UPD_FINISHED;
-	}
-}
-
 /* Called from damon_sysfs_cmd_request_callback under damon_sysfs_lock */
 int damon_sysfs_schemes_clear_regions(
 		struct damon_sysfs_schemes *sysfs_schemes)
@@ -2275,82 +2150,3 @@ int damon_sysfs_schemes_clear_regions(
 	}
 	return 0;
 }
-
-static struct damos *damos_sysfs_nth_scheme(int n, struct damon_ctx *ctx)
-{
-	struct damos *scheme;
-	int i = 0;
-
-	damon_for_each_scheme(scheme, ctx) {
-		if (i == n)
-			return scheme;
-		i++;
-	}
-	return NULL;
-}
-
-static void damos_tried_regions_init_upd_status(
-		struct damon_sysfs_schemes *sysfs_schemes,
-		struct damon_ctx *ctx)
-{
-	int i;
-	struct damos *scheme;
-	struct damon_sysfs_scheme_regions *sysfs_regions;
-
-	for (i = 0; i < sysfs_schemes->nr; i++) {
-		sysfs_regions = sysfs_schemes->schemes_arr[i]->tried_regions;
-		scheme = damos_sysfs_nth_scheme(i, ctx);
-		if (!scheme) {
-			sysfs_regions->upd_status =
-				DAMOS_TRIED_REGIONS_UPD_FINISHED;
-			continue;
-		}
-		sysfs_regions->upd_status = DAMOS_TRIED_REGIONS_UPD_IDLE;
-		sysfs_regions->upd_timeout_jiffies = jiffies +
-			2 * usecs_to_jiffies(scheme->apply_interval_us ?
-					scheme->apply_interval_us :
-					ctx->attrs.aggr_interval);
-	}
-}
-
-/* Called while damon_sysfs_lock is hold */
-int damon_sysfs_schemes_update_regions_start(
-		struct damon_sysfs_schemes *sysfs_schemes,
-		struct damon_ctx *ctx, bool total_bytes_only)
-{
-	damon_sysfs_schemes_clear_regions(sysfs_schemes);
-	damon_sysfs_schemes_for_damos_callback = sysfs_schemes;
-	damos_tried_regions_init_upd_status(sysfs_schemes, ctx);
-	damos_regions_upd_total_bytes_only = total_bytes_only;
-	ctx->callback.before_damos_apply = damon_sysfs_before_damos_apply;
-	return 0;
-}
-
-bool damos_sysfs_regions_upd_done(void)
-{
-	struct damon_sysfs_schemes *sysfs_schemes =
-		damon_sysfs_schemes_for_damos_callback;
-	struct damon_sysfs_scheme_regions *sysfs_regions;
-	int i;
-
-	for (i = 0; i < sysfs_schemes->nr; i++) {
-		sysfs_regions = sysfs_schemes->schemes_arr[i]->tried_regions;
-		if (sysfs_regions->upd_status !=
-				DAMOS_TRIED_REGIONS_UPD_FINISHED)
-			return false;
-	}
-	return true;
-}
-
-/*
- * Called from damon_sysfs_cmd_request_callback under damon_sysfs_lock.  Caller
- * should unlock damon_sysfs_lock which held before
- * damon_sysfs_schemes_update_regions_start()
- */
-int damon_sysfs_schemes_update_regions_stop(struct damon_ctx *ctx)
-{
-	damon_sysfs_schemes_for_damos_callback = NULL;
-	ctx->callback.before_damos_apply = NULL;
-	damon_sysfs_schemes_region_idx = 0;
-	return 0;
-}
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index dafeec20ac53..77a9b8200e78 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1181,25 +1181,9 @@ static int damon_sysfs_add_targets(struct damon_ctx *ctx,
 	return 0;
 }
 
-static bool damon_sysfs_schemes_regions_updating;
-
 static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
 {
 	struct damon_target *t, *next;
-	struct damon_sysfs_kdamond *kdamond;
-	enum damon_sysfs_cmd cmd;
-
-	/* damon_sysfs_schemes_update_regions_stop() might not yet called */
-	kdamond = damon_sysfs_cmd_request.kdamond;
-	cmd = damon_sysfs_cmd_request.cmd;
-	if (kdamond && ctx == kdamond->damon_ctx &&
-			(cmd == DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_REGIONS ||
-			 cmd == DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_BYTES) &&
-			damon_sysfs_schemes_regions_updating) {
-		damon_sysfs_schemes_update_regions_stop(ctx);
-		damon_sysfs_schemes_regions_updating = false;
-		mutex_unlock(&damon_sysfs_lock);
-	}
 
 	if (!damon_target_has_pid(ctx))
 		return;
@@ -1232,28 +1216,6 @@ static int damon_sysfs_upd_schemes_stats(void *data)
 	return 0;
 }
 
-static int damon_sysfs_upd_schemes_regions_start(
-		struct damon_sysfs_kdamond *kdamond, bool total_bytes_only)
-{
-	struct damon_ctx *ctx = kdamond->damon_ctx;
-
-	if (!ctx)
-		return -EINVAL;
-	return damon_sysfs_schemes_update_regions_start(
-			kdamond->contexts->contexts_arr[0]->schemes, ctx,
-			total_bytes_only);
-}
-
-static int damon_sysfs_upd_schemes_regions_stop(
-		struct damon_sysfs_kdamond *kdamond)
-{
-	struct damon_ctx *ctx = kdamond->damon_ctx;
-
-	if (!ctx)
-		return -EINVAL;
-	return damon_sysfs_schemes_update_regions_stop(ctx);
-}
-
 static inline bool damon_sysfs_kdamond_running(
 		struct damon_sysfs_kdamond *kdamond)
 {
@@ -1358,12 +1320,10 @@ static int damon_sysfs_cmd_request_callback(struct damon_ctx *c, bool active,
 		bool after_aggregation)
 {
 	struct damon_sysfs_kdamond *kdamond;
-	bool total_bytes_only = false;
 	int err = 0;
 
 	/* avoid deadlock due to concurrent state_store('off') */
-	if (!damon_sysfs_schemes_regions_updating &&
-			!mutex_trylock(&damon_sysfs_lock))
+	if (!mutex_trylock(&damon_sysfs_lock))
 		return 0;
 	kdamond = damon_sysfs_cmd_request.kdamond;
 	if (!kdamond || kdamond->damon_ctx != c)
@@ -1374,39 +1334,13 @@ static int damon_sysfs_cmd_request_callback(struct damon_ctx *c, bool active,
 			goto out;
 		err = damon_sysfs_commit_input(kdamond);
 		break;
-	case DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_BYTES:
-		total_bytes_only = true;
-		fallthrough;
-	case DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_REGIONS:
-		if (!damon_sysfs_schemes_regions_updating) {
-			err = damon_sysfs_upd_schemes_regions_start(kdamond,
-					total_bytes_only);
-			if (!err) {
-				damon_sysfs_schemes_regions_updating = true;
-				goto keep_lock_out;
-			}
-		} else {
-			damos_sysfs_mark_finished_regions_updates(c);
-			/*
-			 * Continue regions updating if DAMON is till
-			 * active and the update for all schemes is not
-			 * finished.
-			 */
-			if (active && !damos_sysfs_regions_upd_done())
-				goto keep_lock_out;
-			err = damon_sysfs_upd_schemes_regions_stop(kdamond);
-			damon_sysfs_schemes_regions_updating = false;
-		}
-		break;
 	default:
 		break;
 	}
 	/* Mark the request as invalid now. */
 	damon_sysfs_cmd_request.kdamond = NULL;
 out:
-	if (!damon_sysfs_schemes_regions_updating)
-		mutex_unlock(&damon_sysfs_lock);
-keep_lock_out:
+	mutex_unlock(&damon_sysfs_lock);
 	return err;
 }
 
-- 
2.39.5


