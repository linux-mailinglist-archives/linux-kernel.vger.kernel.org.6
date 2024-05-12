Return-Path: <linux-kernel+bounces-176963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7A98C37D9
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 19:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31FBA1C20AA4
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 17:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB46654762;
	Sun, 12 May 2024 17:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cc70FMlK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0393524A6;
	Sun, 12 May 2024 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715536497; cv=none; b=XrSNfi7UozdHOzX3MR4ffNa3t6WkOKXTlXF7jadv5jI27vSTJUzjYEjQ0vUVuOvSZCdhVuWnEA1HsDoUtWifMFeZKqC++JUZ3rsyA6cQiasIC4BR9LvY8hJT9OHrStsJzR7iwzSk7l7jMY4BQdoH2NlNytKspaQ+1X/8lqu9LDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715536497; c=relaxed/simple;
	bh=pJ6vzvCtZUPWSFq3LZUFfl+zSubCIvDIafn053zECpU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=csRQUqaP515vWa2mgUoB5mxmc0oOoHy64v9jVOlFQRvbOlZCzVuNqNQa6XBfcQ4WXMFXbFqqzu+TIhRTqCVzTuFvbW30kr7T21ybFg3A07tCU9HyVvmoXa/162XVD2idi+nwmIEUkOx/TLJCSJhhRzvnzYAFjf2fwPXcCEROPuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cc70FMlK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9FFC4AF07;
	Sun, 12 May 2024 17:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715536497;
	bh=pJ6vzvCtZUPWSFq3LZUFfl+zSubCIvDIafn053zECpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cc70FMlKxLi1JuD51HmpqEsx8453y79uRyuCpKWF1nFmbmpT3wquNTxEgmigdAGeP
	 vOBagAGtYXvLeuZDb7OAbeB7Bg/rsRmffuka3NZMTyvrPgBuKUCuH6zS64yc8uIegg
	 eo9hlLQMmqvopMR8rbRj2YnhWwtjtZotQ5AgJi26Y5BHdKGHt7b7iqvcnrIV+0XH5h
	 5Ay0c7jBCrdo0JwwpVwLuqqcqJQx6Ur+54tZHTranalXvTOFgw1NHZQYObYyribLXj
	 HySwsRHduSQvTrYwk/d08i69oLkf8HWJkllCj9u+M2yPaM6ABrwmmwrU9Wo0GCzIZN
	 3zOv8UL9vgZ0w==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: Honggyu Kim <honggyu.kim@sk.com>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Hyeongtak Ji <hyeongtak.ji@sk.com>
Subject: [RFC PATCH v4 4/5] mm/damon/paddr: introduce DAMOS_MIGRATE_COLD action for demotion
Date: Sun, 12 May 2024 10:54:46 -0700
Message-Id: <20240512175447.75943-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240512175447.75943-1-sj@kernel.org>
References: <20240512175447.75943-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Honggyu Kim <honggyu.kim@sk.com>

This patch introduces DAMOS_MIGRATE_COLD action, which is similar to
DAMOS_PAGEOUT, but migrate folios to the given 'target_nid' in the sysfs
instead of swapping them out.

The 'target_nid' sysfs knob informs the migration target node ID.

Here is one of the example usage of this 'migrate_cold' action.

  $ cd /sys/kernel/mm/damon/admin/kdamonds/<N>
  $ cat contexts/<N>/schemes/<N>/action
  migrate_cold
  $ echo 2 > contexts/<N>/schemes/<N>/target_nid
  $ echo commit > state
  $ numactl -p 0 ./hot_cold 500M 600M &
  $ numastat -c -p hot_cold

  Per-node process memory usage (in MBs)
  PID             Node 0 Node 1 Node 2 Total
  --------------  ------ ------ ------ -----
  701 (hot_cold)     501      0    601  1101

Since there are some common routines with pageout, many functions have
similar logics between pageout and migrate cold.

damon_pa_migrate_folio_list() is a minimized version of
shrink_folio_list().

Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h    |   2 +
 mm/damon/paddr.c         | 154 +++++++++++++++++++++++++++++++++++++++
 mm/damon/sysfs-schemes.c |   1 +
 3 files changed, 157 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 21d6b69a015c..56714b6eb0d7 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -105,6 +105,7 @@ struct damon_target {
  * @DAMOS_NOHUGEPAGE:	Call ``madvise()`` for the region with MADV_NOHUGEPAGE.
  * @DAMOS_LRU_PRIO:	Prioritize the region on its LRU lists.
  * @DAMOS_LRU_DEPRIO:	Deprioritize the region on its LRU lists.
+ * @DAMOS_MIGRATE_COLD:	Migrate the regions prioritizing colder regions.
  * @DAMOS_STAT:		Do nothing but count the stat.
  * @NR_DAMOS_ACTIONS:	Total number of DAMOS actions
  *
@@ -122,6 +123,7 @@ enum damos_action {
 	DAMOS_NOHUGEPAGE,
 	DAMOS_LRU_PRIO,
 	DAMOS_LRU_DEPRIO,
+	DAMOS_MIGRATE_COLD,
 	DAMOS_STAT,		/* Do nothing but only record the stat */
 	NR_DAMOS_ACTIONS,
 };
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 18797c1b419b..a468792d9162 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -12,6 +12,9 @@
 #include <linux/pagemap.h>
 #include <linux/rmap.h>
 #include <linux/swap.h>
+#include <linux/memory-tiers.h>
+#include <linux/migrate.h>
+#include <linux/mm_inline.h>
 
 #include "../internal.h"
 #include "ops-common.h"
@@ -325,6 +328,153 @@ static unsigned long damon_pa_deactivate_pages(struct damon_region *r,
 	return damon_pa_mark_accessed_or_deactivate(r, s, false);
 }
 
+static unsigned int __damon_pa_migrate_folio_list(
+		struct list_head *migrate_folios, struct pglist_data *pgdat,
+		int target_nid)
+{
+	unsigned int nr_succeeded;
+	nodemask_t allowed_mask = NODE_MASK_NONE;
+	struct migration_target_control mtc = {
+		/*
+		 * Allocate from 'node', or fail quickly and quietly.
+		 * When this happens, 'page' will likely just be discarded
+		 * instead of migrated.
+		 */
+		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
+			__GFP_NOWARN | __GFP_NOMEMALLOC | GFP_NOWAIT,
+		.nid = target_nid,
+		.nmask = &allowed_mask
+	};
+
+	if (pgdat->node_id == target_nid || target_nid == NUMA_NO_NODE)
+		return 0;
+
+	if (list_empty(migrate_folios))
+		return 0;
+
+	/* Migration ignores all cpuset and mempolicy settings */
+	migrate_pages(migrate_folios, alloc_demote_folio, NULL,
+		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DAMON,
+		      &nr_succeeded);
+
+	return nr_succeeded;
+}
+
+static unsigned int damon_pa_migrate_folio_list(struct list_head *folio_list,
+						struct pglist_data *pgdat,
+						int target_nid)
+{
+	unsigned int nr_migrated = 0;
+	struct folio *folio;
+	LIST_HEAD(ret_folios);
+	LIST_HEAD(migrate_folios);
+
+	while (!list_empty(folio_list)) {
+		struct folio *folio;
+
+		cond_resched();
+
+		folio = lru_to_folio(folio_list);
+		list_del(&folio->lru);
+
+		if (!folio_trylock(folio))
+			goto keep;
+
+		/* Relocate its contents to another node. */
+		list_add(&folio->lru, &migrate_folios);
+		folio_unlock(folio);
+		continue;
+keep:
+		list_add(&folio->lru, &ret_folios);
+	}
+	/* 'folio_list' is always empty here */
+
+	/* Migrate folios selected for migration */
+	nr_migrated += __damon_pa_migrate_folio_list(
+			&migrate_folios, pgdat, target_nid);
+	/*
+	 * Folios that could not be migrated are still in @migrate_folios.  Add
+	 * those back on @folio_list
+	 */
+	if (!list_empty(&migrate_folios))
+		list_splice_init(&migrate_folios, folio_list);
+
+	try_to_unmap_flush();
+
+	list_splice(&ret_folios, folio_list);
+
+	while (!list_empty(folio_list)) {
+		folio = lru_to_folio(folio_list);
+		list_del(&folio->lru);
+		folio_putback_lru(folio);
+	}
+
+	return nr_migrated;
+}
+
+static unsigned long damon_pa_migrate_pages(struct list_head *folio_list,
+					    int target_nid)
+{
+	int nid;
+	unsigned long nr_migrated = 0;
+	LIST_HEAD(node_folio_list);
+	unsigned int noreclaim_flag;
+
+	if (list_empty(folio_list))
+		return nr_migrated;
+
+	noreclaim_flag = memalloc_noreclaim_save();
+
+	nid = folio_nid(lru_to_folio(folio_list));
+	do {
+		struct folio *folio = lru_to_folio(folio_list);
+
+		if (nid == folio_nid(folio)) {
+			list_move(&folio->lru, &node_folio_list);
+			continue;
+		}
+
+		nr_migrated += damon_pa_migrate_folio_list(&node_folio_list,
+							   NODE_DATA(nid),
+							   target_nid);
+		nid = folio_nid(lru_to_folio(folio_list));
+	} while (!list_empty(folio_list));
+
+	nr_migrated += damon_pa_migrate_folio_list(&node_folio_list,
+						   NODE_DATA(nid),
+						   target_nid);
+
+	memalloc_noreclaim_restore(noreclaim_flag);
+
+	return nr_migrated;
+}
+
+static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s)
+{
+	unsigned long addr, applied;
+	LIST_HEAD(folio_list);
+
+	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
+		struct folio *folio = damon_get_folio(PHYS_PFN(addr));
+
+		if (!folio)
+			continue;
+
+		if (damos_pa_filter_out(s, folio))
+			goto put_folio;
+
+		if (!folio_isolate_lru(folio))
+			goto put_folio;
+		list_add(&folio->lru, &folio_list);
+put_folio:
+		folio_put(folio);
+	}
+	applied = damon_pa_migrate_pages(&folio_list, s->target_nid);
+	cond_resched();
+	return applied * PAGE_SIZE;
+}
+
+
 static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 		struct damon_target *t, struct damon_region *r,
 		struct damos *scheme)
@@ -336,6 +486,8 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 		return damon_pa_mark_accessed(r, scheme);
 	case DAMOS_LRU_DEPRIO:
 		return damon_pa_deactivate_pages(r, scheme);
+	case DAMOS_MIGRATE_COLD:
+		return damon_pa_migrate(r, scheme);
 	case DAMOS_STAT:
 		break;
 	default:
@@ -356,6 +508,8 @@ static int damon_pa_scheme_score(struct damon_ctx *context,
 		return damon_hot_score(context, r, scheme);
 	case DAMOS_LRU_DEPRIO:
 		return damon_cold_score(context, r, scheme);
+	case DAMOS_MIGRATE_COLD:
+		return damon_cold_score(context, r, scheme);
 	default:
 		break;
 	}
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 0632d28b67f8..880015d5b5ea 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1458,6 +1458,7 @@ static const char * const damon_sysfs_damos_action_strs[] = {
 	"nohugepage",
 	"lru_prio",
 	"lru_deprio",
+	"migrate_cold",
 	"stat",
 };
 
-- 
2.39.2


