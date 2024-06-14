Return-Path: <linux-kernel+bounces-214280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 118E290823D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 05:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8335C1F23A37
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 03:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A863184136;
	Fri, 14 Jun 2024 03:00:26 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDDD18309B;
	Fri, 14 Jun 2024 03:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718334025; cv=none; b=O7bw80QaXibE0mJkbWgKlVhcBFfrUrZ/Ng9oSxnmbtAypWQwYW4gZAJycD83tZS4unqykxfU81uPTRmb+id0MZKT9wuySnxYeaWk8Xki5a1dtskn/xbu1rWG2Tt4LJAt9SXlkT/KuVXVIDtS9NX7X3rWRkd02qoPW/gjw6A7qCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718334025; c=relaxed/simple;
	bh=PBLigDFeoVj/3sesODDma7eu2K0yE9gUuHQjzZnRg4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=keyOmETsLNvdurmd3XN9zyC6gzEkwtohpoy473jkyYulGgqgCbY7CDidTx7rGKFIZkWSUglm1B+rea45zfK8o47WbMFGRw6PKNMwGRnJBGw6nsOdcz/hCb1NJodf39lMF7xz+70XFM2FZv1C48D/5jDgZfwhzwAJK/ruJljzir0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-35-666bb2448c76
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Gregory Price <gregory.price@memverge.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	42.hyeyoo@gmail.com,
	art.jeongseob@gmail.com,
	kernel_team@skhynix.com,
	Hyeongtak Ji <hyeongtak.ji@sk.com>,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: [PATCH v6 3/7] mm/damon/sysfs-schemes: add target_nid on sysfs-schemes
Date: Fri, 14 Jun 2024 12:00:05 +0900
Message-ID: <20240614030010.751-4-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240614030010.751-1-honggyu.kim@sk.com>
References: <20240614030010.751-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsXC9ZZnka7Lpuw0g8l/eCwm9hhYzFm/hs3i
	/oPX7BZP/v9mtWhoesRicXnXHDaLe2v+s1ocWX+WxWLz2TPMFouXq1ns63jAZHH46xsmBx6P
	paffsHnsnHWX3aNl3y12j02rOtk8Nn2axO5xYsZvFo8Xm2cyemz8+J/d4/MmuQDOKC6blNSc
	zLLUIn27BK6M4+vbWAouW1U82vGIsYFxo0EXIyeHhICJxPHzneww9qVHJxlBbDYBNYkrLycx
	dTFycIgIWElM2xHbxcjFwSxwjVlid/dJZpAaYQF/ibOPVoLVsAioSqy65goS5hUwlfh3fQIb
	xEhNicfbf4KN5xQwk5h+7B4TiC0EVHPhylYmiHpBiZMzn7CA2MwC8hLNW2czg+ySEHjPJvF7
	/m8WiEGSEgdX3GCZwMg/C0nPLCQ9CxiZVjEKZeaV5SZm5pjoZVTmZVboJefnbmIExsCy2j/R
	Oxg/XQg+xCjAwajEw+vxLCtNiDWxrLgy9xCjBAezkgjvrIVAId6UxMqq1KL8+KLSnNTiQ4zS
	HCxK4rxG38pThATSE0tSs1NTC1KLYLJMHJxSDYxam9TsTtimGdXsfeqbMl24QO/QWclZ5mmJ
	EnOyTyR37npz9Kj8uzcRrwW3OWx41fP0xiOOqe+lrs2udf+nlPGP9WLsgaRSy49qP4zMG+tc
	OdL31X2w7LXz2Xz6a/CRmUo2H5OO2N20VI2ek+FcaVKud/3uM5GvTyy0olXKHM7LLmbTsnAo
	m6LEUpyRaKjFXFScCADJ3Mu7fQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsXCNUNLT9d5U3aawe7p1hYTewws5qxfw2Zx
	/8Frdosn/3+zWjQ0PWKx+PzsNbNF55PvjBaH555ktbi8aw6bxb01/1ktjqw/y2Kx+ewZZovF
	y9Us9nU8YLI4/PUNkwO/x9LTb9g8ds66y+7Rsu8Wu8emVZ1sHps+TWL3ODHjN4vHi80zGT02
	fvzP7vHttofH4hcfmDw+b5IL4I7isklJzcksSy3St0vgyji+vo2l4LJVxaMdjxgbGDcadDFy
	ckgImEhcenSSEcRmE1CTuPJyElMXIweHiICVxLQdsV2MXBzMAteYJXZ3n2QGqREW8Jc4+2gl
	WA2LgKrEqmuuIGFeAVOJf9cnsEGM1JR4vP0nO4jNKWAmMf3YPSYQWwio5sKVrUwQ9YISJ2c+
	YQGxmQXkJZq3zmaewMgzC0lqFpLUAkamVYwimXlluYmZOaZ6xdkZlXmZFXrJ+bmbGIHBvqz2
	z8QdjF8uux9iFOBgVOLh9XiWlSbEmlhWXJl7iFGCg1lJhHfWQqAQb0piZVVqUX58UWlOavEh
	RmkOFiVxXq/w1AQhgfTEktTs1NSC1CKYLBMHp1QDo77Msjnbui94CDIE7/oeziMs++led6bc
	Ro0DIawSF9bPMP7E8srh5Op9PRUWnssv7bJWW/B0ubc7Ewvred6OgAnNu094Ps7ZuDH5xVav
	b5u37vne+/+z6Uk3J89Nrp/ruFbKPz3EMe1DugKXwuuQW3+KpweYB2vKqj7aXxUuv507qSu8
	lJF3vRJLcUaioRZzUXEiAOpKILpyAgAA
X-CFilter-Loop: Reflected

From: Hyeongtak Ji <hyeongtak.ji@sk.com>

This patch adds target_nid under
  /sys/kernel/mm/damon/admin/kdamonds/<N>/contexts/<N>/schemes/<N>/

The 'target_nid' can be used as the destination node for DAMOS actions
such as DAMOS_MIGRATE_{HOT,COLD} in the follow up patches.

Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h    | 11 ++++++++++-
 mm/damon/core.c          |  5 ++++-
 mm/damon/dbgfs.c         |  2 +-
 mm/damon/lru_sort.c      |  3 ++-
 mm/damon/reclaim.c       |  3 ++-
 mm/damon/sysfs-schemes.c | 33 ++++++++++++++++++++++++++++++++-
 6 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index f7da65e1ac04..21d6b69a015c 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -374,6 +374,7 @@ struct damos_access_pattern {
  * @apply_interval_us:	The time between applying the @action.
  * @quota:		Control the aggressiveness of this scheme.
  * @wmarks:		Watermarks for automated (in)activation of this scheme.
+ * @target_nid:		Destination node if @action is "migrate_{hot,cold}".
  * @filters:		Additional set of &struct damos_filter for &action.
  * @stat:		Statistics of this scheme.
  * @list:		List head for siblings.
@@ -389,6 +390,10 @@ struct damos_access_pattern {
  * monitoring context are inactive, DAMON stops monitoring either, and just
  * repeatedly checks the watermarks.
  *
+ * @target_nid is used to set the migration target node for migrate_hot or
+ * migrate_cold actions, which means it's only meaningful when @action is either
+ * "migrate_hot" or "migrate_cold".
+ *
  * Before applying the &action to a memory region, &struct damon_operations
  * implementation could check pages of the region and skip &action to respect
  * &filters
@@ -410,6 +415,9 @@ struct damos {
 /* public: */
 	struct damos_quota quota;
 	struct damos_watermarks wmarks;
+	union {
+		int target_nid;
+	};
 	struct list_head filters;
 	struct damos_stat stat;
 	struct list_head list;
@@ -726,7 +734,8 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 			enum damos_action action,
 			unsigned long apply_interval_us,
 			struct damos_quota *quota,
-			struct damos_watermarks *wmarks);
+			struct damos_watermarks *wmarks,
+			int target_nid);
 void damon_add_scheme(struct damon_ctx *ctx, struct damos *s);
 void damon_destroy_scheme(struct damos *s);
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 6392f1cc97a3..c0ec5be4f56e 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -354,7 +354,8 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 			enum damos_action action,
 			unsigned long apply_interval_us,
 			struct damos_quota *quota,
-			struct damos_watermarks *wmarks)
+			struct damos_watermarks *wmarks,
+			int target_nid)
 {
 	struct damos *scheme;
 
@@ -381,6 +382,8 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 	scheme->wmarks = *wmarks;
 	scheme->wmarks.activated = true;
 
+	scheme->target_nid = target_nid;
+
 	return scheme;
 }
 
diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 2461cfe2e968..51a6f1cac385 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -281,7 +281,7 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
 
 		pos += parsed;
 		scheme = damon_new_scheme(&pattern, action, 0, &quota,
-				&wmarks);
+				&wmarks, NUMA_NO_NODE);
 		if (!scheme)
 			goto fail;
 
diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 3de2916a65c3..3775f0f2743d 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -163,7 +163,8 @@ static struct damos *damon_lru_sort_new_scheme(
 			/* under the quota. */
 			&quota,
 			/* (De)activate this according to the watermarks. */
-			&damon_lru_sort_wmarks);
+			&damon_lru_sort_wmarks,
+			NUMA_NO_NODE);
 }
 
 /* Create a DAMON-based operation scheme for hot memory regions */
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 9bd341d62b4c..a05ccb41749b 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -177,7 +177,8 @@ static struct damos *damon_reclaim_new_scheme(void)
 			/* under the quota. */
 			&damon_reclaim_quota,
 			/* (De)activate this according to the watermarks. */
-			&damon_reclaim_wmarks);
+			&damon_reclaim_wmarks,
+			NUMA_NO_NODE);
 }
 
 static void damon_reclaim_copy_quota_status(struct damos_quota *dst,
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index bea5bc52846a..0632d28b67f8 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/slab.h>
+#include <linux/numa.h>
 
 #include "sysfs-common.h"
 
@@ -1445,6 +1446,7 @@ struct damon_sysfs_scheme {
 	struct damon_sysfs_scheme_filters *filters;
 	struct damon_sysfs_stats *stats;
 	struct damon_sysfs_scheme_regions *tried_regions;
+	int target_nid;
 };
 
 /* This should match with enum damos_action */
@@ -1470,6 +1472,7 @@ static struct damon_sysfs_scheme *damon_sysfs_scheme_alloc(
 	scheme->kobj = (struct kobject){};
 	scheme->action = action;
 	scheme->apply_interval_us = apply_interval_us;
+	scheme->target_nid = NUMA_NO_NODE;
 	return scheme;
 }
 
@@ -1692,6 +1695,28 @@ static ssize_t apply_interval_us_store(struct kobject *kobj,
 	return err ? err : count;
 }
 
+static ssize_t target_nid_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_scheme *scheme = container_of(kobj,
+			struct damon_sysfs_scheme, kobj);
+
+	return sysfs_emit(buf, "%d\n", scheme->target_nid);
+}
+
+static ssize_t target_nid_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_scheme *scheme = container_of(kobj,
+			struct damon_sysfs_scheme, kobj);
+	int err = 0;
+
+	/* TODO: error handling for target_nid range. */
+	err = kstrtoint(buf, 0, &scheme->target_nid);
+
+	return err ? err : count;
+}
+
 static void damon_sysfs_scheme_release(struct kobject *kobj)
 {
 	kfree(container_of(kobj, struct damon_sysfs_scheme, kobj));
@@ -1703,9 +1728,13 @@ static struct kobj_attribute damon_sysfs_scheme_action_attr =
 static struct kobj_attribute damon_sysfs_scheme_apply_interval_us_attr =
 		__ATTR_RW_MODE(apply_interval_us, 0600);
 
+static struct kobj_attribute damon_sysfs_scheme_target_nid_attr =
+		__ATTR_RW_MODE(target_nid, 0600);
+
 static struct attribute *damon_sysfs_scheme_attrs[] = {
 	&damon_sysfs_scheme_action_attr.attr,
 	&damon_sysfs_scheme_apply_interval_us_attr.attr,
+	&damon_sysfs_scheme_target_nid_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_scheme);
@@ -2031,7 +2060,8 @@ static struct damos *damon_sysfs_mk_scheme(
 	};
 
 	scheme = damon_new_scheme(&pattern, sysfs_scheme->action,
-			sysfs_scheme->apply_interval_us, &quota, &wmarks);
+			sysfs_scheme->apply_interval_us, &quota, &wmarks,
+			sysfs_scheme->target_nid);
 	if (!scheme)
 		return NULL;
 
@@ -2068,6 +2098,7 @@ static void damon_sysfs_update_scheme(struct damos *scheme,
 
 	scheme->action = sysfs_scheme->action;
 	scheme->apply_interval_us = sysfs_scheme->apply_interval_us;
+	scheme->target_nid = sysfs_scheme->target_nid;
 
 	scheme->quota.ms = sysfs_quotas->ms;
 	scheme->quota.sz = sysfs_quotas->sz;
-- 
2.34.1


