Return-Path: <linux-kernel+bounces-251228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC65930261
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 01:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9981F228CC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 23:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70785131BAF;
	Fri, 12 Jul 2024 23:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yvOee40y"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A29130A54
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 23:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720827003; cv=none; b=W3ADg3vrqXq95bImcZ/ghp9v/a3pprqG3JypU2v0NtRvDKjVhMcxT9DUuLq3C4Q9W4pjifnkM9G+hyMEi86OZJNWXftbbMIPr2MuRe1KkpMNvqDR0nBjw6NgKulGuI+8egdEnXSGkjpV6q26nZlu6Q9c2nbwJz4NDwoLP6zgGMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720827003; c=relaxed/simple;
	bh=cyR+TK2hxkkpF1TyaQwUlsc8LJS9V46NbJcy3vuvUxw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JnLktVp3RjpoVH+OGLxMB+zRfKwbWRmoV0TfY3xM1zNMH064WQoZVK0RQvIXXJxdGKNMMWbfIMnYR1n5OIkZ34PLgP5xovcG/KDHTlj0anWxRZfgFcQLiVUcouo4fHTS9BLJQGGs5LE9G8AEqpFoyIL2UI3vnCkZaf3fwvE8AKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yvOee40y; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e057ae54529so4379905276.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 16:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720827001; x=1721431801; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yuopOozH91D09gZpiNN2s1dGAhgwFcGvecwcksbRHfM=;
        b=yvOee40yaTN4CmTDxZx61BCMEzw9WrXFv81wt3XMGB6znb9r9DYkedZP09ffMlPLb7
         vfJw22TEYw2rDNNWD+YWfryuVGq3DQwDHW8k45SR8PTtS/Oajvqgvvq6wDGAt5Y5AEPN
         EQUNNXlCHRxpug+hOiSNffnZPHYwYwchBibWvP/muDzGWR+ki6ztvfgsIa3cEQFtv8Iu
         E3RV/qgHnBkLpqXktWO0xgZ9hs4az5//qLfRnbM31WAKjjb3adBnmF0qAZLiIts1FAuX
         a/WqtDym5KefxwX9CMQUWQo9r2aoXK2bwMFWqQe7D9fyU4v+y/u9HMn5Uf75ToIFe8iq
         ofOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720827001; x=1721431801;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yuopOozH91D09gZpiNN2s1dGAhgwFcGvecwcksbRHfM=;
        b=tpyFh25/70bzsz05NaqCIW2qRUA7n4oodLsIaQ8dZk5wCHPNB3t0pZojy5CuwB5w39
         iPOixdTiigksd4pSdQ11vsOLwI3exPLq/sHxm4aVsbGZYMRnYcc20goi7Tn3Y94s6Krb
         RTBKOdcLRjcPH8coqQsBcsIbFaD/k6mYuAEJ22z78WFTrKNlO5qDcFKshLjZykZ1fx2l
         tSIc5MP5jnIZxyeh7iZoiiLzZNPQOVwj1wj1qiOA6jxavGEizMFuWBqpcd62JX7zXxXA
         n4Mcq/68OUh7nchMopljTahB9Tcwc01BaY2eKX0TyTxIYAWgPKNXp+tK7dMNh1YPbMtd
         F9Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUluqh0ImJBEhefu5a2XRr9jeb/m5o4ggqDdOGd7tFYLGycgLWY0qCkQmN7BPwgX+LMUYeNOm5vpN9eFdYO00IBVorjM9YK50dm0GiU
X-Gm-Message-State: AOJu0YxNMADCOvazxSuFfbHO97OFgAnxX3OQPHEkGTtk8SDUF+M8dFZF
	kaJPxT6DjMVtYvArKfOq1eeWPbkA5oM+1BBDsdgHCLMpTdhJdtXCgGYWEGaV0+12lgmcdmZREI1
	0Xw==
X-Google-Smtp-Source: AGHT+IHhDLg8iF0W4ocBy32TeGuIZJfhmk/ta1j0BVxQ4rkVUv2uZXUfe7v8aGYspqAdYnING71TnWh9ndo=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:f82:d194:27fc:2620])
 (user=yuzhao job=sendgmr) by 2002:a05:6902:2384:b0:e03:31ec:8a2d with SMTP id
 3f1490d57ef6-e041b17bf90mr531180276.12.1720827000832; Fri, 12 Jul 2024
 16:30:00 -0700 (PDT)
Date: Fri, 12 Jul 2024 17:29:56 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240712232956.1427127-1-yuzhao@google.com>
Subject: [PATCH mm-unstable v1] mm/mglru: fix ineffective protection calculation
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "T. J. Mercier" <tjmercier@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

mem_cgroup_calculate_protection() is not stateless and should only be
used as part of a top-down tree traversal. shrink_one() traverses the
per-node memcg LRU instead of the root_mem_cgroup tree, and therefore
it should not call mem_cgroup_calculate_protection().

The existing misuse in shrink_one() can cause ineffective protection
of sub-trees that are grandchildren of root_mem_cgroup. Fix it by
reusing lru_gen_age_node(), which already traverses the
root_mem_cgroup tree, to calculate the protection.

Previously lru_gen_age_node() opportunistically skips the first pass,
i.e., when scan_control->priority is DEF_PRIORITY. On the second pass,
lruvec_is_sizable() uses appropriate scan_control->priority, set by
set_initial_priority() from lru_gen_shrink_node(), to decide whether a
memcg is too small to reclaim from.

Now lru_gen_age_node() unconditionally traverses the root_mem_cgroup
tree. So it should call set_initial_priority() upfront, to make sure
lruvec_is_sizable() uses appropriate scan_control->priority on the
first pass. Otherwise, lruvec_is_reclaimable() can return false
negatives and result in premature OOM kills when min_ttl_ms is used.

Reported-by: T.J. Mercier <tjmercier@google.com>
Fixes: e4dde56cd208 ("mm: multi-gen LRU: per-node lru_gen_folio lists")
Cc: stable@vger.kernel.org
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/vmscan.c | 86 +++++++++++++++++++++++++----------------------------
 1 file changed, 40 insertions(+), 46 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6216d79edb7f..525d3ffa8451 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3915,6 +3915,32 @@ static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long seq,
  *                          working set protection
  ******************************************************************************/
 
+static void set_initial_priority(struct pglist_data *pgdat, struct scan_control *sc)
+{
+	int priority;
+	unsigned long reclaimable;
+
+	if (sc->priority != DEF_PRIORITY || sc->nr_to_reclaim < MIN_LRU_BATCH)
+		return;
+	/*
+	 * Determine the initial priority based on
+	 * (total >> priority) * reclaimed_to_scanned_ratio = nr_to_reclaim,
+	 * where reclaimed_to_scanned_ratio = inactive / total.
+	 */
+	reclaimable = node_page_state(pgdat, NR_INACTIVE_FILE);
+	if (can_reclaim_anon_pages(NULL, pgdat->node_id, sc))
+		reclaimable += node_page_state(pgdat, NR_INACTIVE_ANON);
+
+	/* round down reclaimable and round up sc->nr_to_reclaim */
+	priority = fls_long(reclaimable) - 1 - fls_long(sc->nr_to_reclaim - 1);
+
+	/*
+	 * The estimation is based on LRU pages only, so cap it to prevent
+	 * overshoots of shrinker objects by large margins.
+	 */
+	sc->priority = clamp(priority, DEF_PRIORITY / 2, DEF_PRIORITY);
+}
+
 static bool lruvec_is_sizable(struct lruvec *lruvec, struct scan_control *sc)
 {
 	int gen, type, zone;
@@ -3948,19 +3974,17 @@ static bool lruvec_is_reclaimable(struct lruvec *lruvec, struct scan_control *sc
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	DEFINE_MIN_SEQ(lruvec);
 
+	if (mem_cgroup_below_min(NULL, memcg))
+		return false;
+
+	if (!lruvec_is_sizable(lruvec, sc))
+		return false;
+
 	/* see the comment on lru_gen_folio */
 	gen = lru_gen_from_seq(min_seq[LRU_GEN_FILE]);
 	birth = READ_ONCE(lruvec->lrugen.timestamps[gen]);
 
-	if (time_is_after_jiffies(birth + min_ttl))
-		return false;
-
-	if (!lruvec_is_sizable(lruvec, sc))
-		return false;
-
-	mem_cgroup_calculate_protection(NULL, memcg);
-
-	return !mem_cgroup_below_min(NULL, memcg);
+	return time_is_before_jiffies(birth + min_ttl);
 }
 
 /* to protect the working set of the last N jiffies */
@@ -3970,23 +3994,20 @@ static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
 {
 	struct mem_cgroup *memcg;
 	unsigned long min_ttl = READ_ONCE(lru_gen_min_ttl);
+	bool reclaimable = !min_ttl;
 
 	VM_WARN_ON_ONCE(!current_is_kswapd());
 
-	/* check the order to exclude compaction-induced reclaim */
-	if (!min_ttl || sc->order || sc->priority == DEF_PRIORITY)
-		return;
+	set_initial_priority(pgdat, sc);
 
 	memcg = mem_cgroup_iter(NULL, NULL, NULL);
 	do {
 		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
 
-		if (lruvec_is_reclaimable(lruvec, sc, min_ttl)) {
-			mem_cgroup_iter_break(NULL, memcg);
-			return;
-		}
+		mem_cgroup_calculate_protection(NULL, memcg);
 
-		cond_resched();
+		if (!reclaimable)
+			reclaimable = lruvec_is_reclaimable(lruvec, sc, min_ttl);
 	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)));
 
 	/*
@@ -3994,7 +4015,7 @@ static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
 	 * younger than min_ttl. However, another possibility is all memcgs are
 	 * either too small or below min.
 	 */
-	if (mutex_trylock(&oom_lock)) {
+	if (!reclaimable && mutex_trylock(&oom_lock)) {
 		struct oom_control oc = {
 			.gfp_mask = sc->gfp_mask,
 		};
@@ -4786,8 +4807,7 @@ static int shrink_one(struct lruvec *lruvec, struct scan_control *sc)
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 
-	mem_cgroup_calculate_protection(NULL, memcg);
-
+	/* lru_gen_age_node() called mem_cgroup_calculate_protection() */
 	if (mem_cgroup_below_min(NULL, memcg))
 		return MEMCG_LRU_YOUNG;
 
@@ -4911,32 +4931,6 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
 	blk_finish_plug(&plug);
 }
 
-static void set_initial_priority(struct pglist_data *pgdat, struct scan_control *sc)
-{
-	int priority;
-	unsigned long reclaimable;
-
-	if (sc->priority != DEF_PRIORITY || sc->nr_to_reclaim < MIN_LRU_BATCH)
-		return;
-	/*
-	 * Determine the initial priority based on
-	 * (total >> priority) * reclaimed_to_scanned_ratio = nr_to_reclaim,
-	 * where reclaimed_to_scanned_ratio = inactive / total.
-	 */
-	reclaimable = node_page_state(pgdat, NR_INACTIVE_FILE);
-	if (can_reclaim_anon_pages(NULL, pgdat->node_id, sc))
-		reclaimable += node_page_state(pgdat, NR_INACTIVE_ANON);
-
-	/* round down reclaimable and round up sc->nr_to_reclaim */
-	priority = fls_long(reclaimable) - 1 - fls_long(sc->nr_to_reclaim - 1);
-
-	/*
-	 * The estimation is based on LRU pages only, so cap it to prevent
-	 * overshoots of shrinker objects by large margins.
-	 */
-	sc->priority = clamp(priority, DEF_PRIORITY / 2, DEF_PRIORITY);
-}
-
 static void lru_gen_shrink_node(struct pglist_data *pgdat, struct scan_control *sc)
 {
 	struct blk_plug plug;
-- 
2.45.2.993.g49e7a77208-goog


