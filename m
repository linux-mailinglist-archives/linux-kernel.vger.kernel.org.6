Return-Path: <linux-kernel+bounces-434151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D14DA9E6244
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5842418814B7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07025225D6;
	Fri,  6 Dec 2024 00:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NpZaBTjB"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669D53B2BB
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 00:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733445102; cv=none; b=OHd4jsBFEAix2C0Ud0Eh8FMrd47YnacQvGg6D6f/0xuaiIQizGvSWKsPO6u21z8bIoOYT8/prR5Zw/Vf2nzyeZVjQHyxfiI5GEodN1x9ZYHz3UTMp2ahiRS1xjxvyZklN4fDkRgg6RlLsxzMbgu4FKGJZBvY7Geot1GF/ZzGf9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733445102; c=relaxed/simple;
	bh=SdBdoFZBzDFJ4xCZGlyHPtZBQmr1hom1R/GUYtzyBBc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GNBDf0Xw/qMdCQRj+Cv8wqJWOLqIWqkZiY/YHdjZ9E7wUk+VZTRE2clut+gNDWY2S+D3Jw5ZR3DHlvWTH+Vb+wC9eOMMCVew+G6yoL5d8u5v4j69xTlWLhQyTr198AYhTHbQ9Wdb+eQ+bkQE7Tq8Zekuih2qfMf8oP/wA/tLaCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NpZaBTjB; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2154e1cdf72so16690955ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 16:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733445100; x=1734049900; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x/WXMwNfw0sDUCuQfYx8lzIKxCIUKsshP78UrWZEISs=;
        b=NpZaBTjBoGXDe7ArlH7sUtENl4c/1jSKZ6qnjQtrLlSo+/ywA10MaukAy1JKSfyD9y
         RH1nbEjoxptWpkFJB8RrvEZ8Pkpvy7sDOxIUahGCqRwBpj/AjaLBdqHQqjcWyrn2Omhy
         bF4BNB+vytAlT/5YjubpXc7tdwbiKrb93BH9cmJDtg1TOnqExXT4E6lhFXyZ0I7TW1qD
         czTDshtvtwWSAmsh6zGr5vvvSJGiYIryo6GNskjQP0GQ11lZH3b369i8NwWG7ojtvCuD
         CmnKGT575qHd+Dbp7fbixowUF76qHNlRMUOlZJMcyGSy8wwkgxiHHTRyIMDYOmbXvvve
         QWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733445100; x=1734049900;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x/WXMwNfw0sDUCuQfYx8lzIKxCIUKsshP78UrWZEISs=;
        b=FY8DTC+lORYQeEcOMVsQiu0eQNDsHaYrcYP/6O4kyOxvHnDcIbBzX55GWs7w3ugRIy
         ItV9FwpspOnHP4ke3psom8WkoNvhVaOcm8ChVwOfdahAsgfIkV/rUakCE8T4hlkgSgEO
         Y+hy3KNzkwGVNKFjvQxavOLnJPks7cndgUE1rPRBeZD4fg7P14FZ1I3uGmsrIh8+fT+5
         z2sWztmZ8deziTjk5q1mgkUw3OYFAuk+0tFhO8QJ6nosjUI25DdoFw1vmWNlHuFe/nit
         3AsfP5orKo0BVtW9aIKFwCsGwE41jkeFQMW0rrivPjZIxECddA0F9TFCIsEB9oijAybX
         ESXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI6DHEFGz9K2jQFhbFefmYknqy4NC+UFhC/3BWATO4Y2P84ViAWlt9pdtkau6aobzoa3SE1yQLxXPe0r0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTCHnna/aLE6fjbooib8Ay6xYCZYfFonbWUFKdS+1tWU+4qLgL
	VNCs0CRvBw8plBzf9Uh/8Nh0IZn5f1O55I8BNVDFy0kTtUlMnNhh8y3CI1O1wAq6rvCY3pk6I/D
	Zgw==
X-Google-Smtp-Source: AGHT+IGARiTmCyLkm3u7hD+Znks+begLp6HQetG4yLAdPKodzK2Xx8PDWX1HYfje4Mbo+dqEamZnBwYUV6c=
X-Received: from pltf4.prod.google.com ([2002:a17:902:74c4:b0:215:ac55:d3e1])
 (user=yuzhao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:41d0:b0:215:8af7:eff8
 with SMTP id d9443c01a7336-21614dc710amr11353915ad.52.1733445099701; Thu, 05
 Dec 2024 16:31:39 -0800 (PST)
Date: Thu,  5 Dec 2024 17:31:23 -0700
In-Reply-To: <20241206003126.1338283-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241206003126.1338283-1-yuzhao@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241206003126.1338283-4-yuzhao@google.com>
Subject: [PATCH mm-unstable v2 3/6] mm/mglru: rework aging feedback
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>, David Stevens <stevensd@chromium.org>, 
	Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"

The aging feedback is based on both the number of generations and the
distribution of folios in each generation. The number of generations
is currently the distance between max_seq and anon min_seq. This is
because anon min_seq is not allowed to move past file min_seq. The
rationale for that is that file is always evictable whereas anon is
not. However, for use cases where anon is a lot cheaper than file:
1. Anon in the second oldest generation can be a better choice than
   file in the oldest generation.
2. A large amount of file in the oldest generation can skew the
   distribution, making should_run_aging() return false negative.

Allow anon and file min_seq to move independently, and use solely the
number of generations as the feedback for aging. Specifically, when
both anon and file are evictable, anon min_seq can now be greater than
file min_seq, and therefore the number of generations becomes the
distance between max_seq and min(min_seq[0],min_seq[1]). And
should_run_aging() returns true if and only if the number of
generations is less than MAX_NR_GENS.

As the first step to the final optimization, this change by itself
should not have userspace-visiable effects beyond performance. The
next twos patch will take advantage of this change; the last patch in
this series will better distribute folios across MAX_NR_GENS.

Reported-by: David Stevens <stevensd@chromium.org>
Signed-off-by: Yu Zhao <yuzhao@google.com>
Tested-by: Kalesh Singh <kaleshsingh@google.com>
---
 include/linux/mmzone.h |   6 +-
 mm/vmscan.c            | 217 +++++++++++++++++------------------------
 2 files changed, 91 insertions(+), 132 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index b36124145a16..b998ccc5c341 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -446,8 +446,8 @@ struct lru_gen_folio {
 	unsigned long avg_refaulted[ANON_AND_FILE][MAX_NR_TIERS];
 	/* the exponential moving average of evicted+protected */
 	unsigned long avg_total[ANON_AND_FILE][MAX_NR_TIERS];
-	/* the first tier doesn't need protection, hence the minus one */
-	unsigned long protected[NR_HIST_GENS][ANON_AND_FILE][MAX_NR_TIERS - 1];
+	/* can only be modified under the LRU lock */
+	unsigned long protected[NR_HIST_GENS][ANON_AND_FILE][MAX_NR_TIERS];
 	/* can be modified without holding the LRU lock */
 	atomic_long_t evicted[NR_HIST_GENS][ANON_AND_FILE][MAX_NR_TIERS];
 	atomic_long_t refaulted[NR_HIST_GENS][ANON_AND_FILE][MAX_NR_TIERS];
@@ -498,7 +498,7 @@ struct lru_gen_mm_walk {
 	int mm_stats[NR_MM_STATS];
 	/* total batched items */
 	int batched;
-	bool can_swap;
+	int swappiness;
 	bool force_scan;
 };
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2a8db048d581..00a5aff3db42 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2623,11 +2623,17 @@ static bool should_clear_pmd_young(void)
 		READ_ONCE((lruvec)->lrugen.min_seq[LRU_GEN_FILE]),	\
 	}
 
+#define evictable_min_seq(min_seq, swappiness)				\
+	min((min_seq)[!(swappiness)], (min_seq)[(swappiness) != MAX_SWAPPINESS])
+
 #define for_each_gen_type_zone(gen, type, zone)				\
 	for ((gen) = 0; (gen) < MAX_NR_GENS; (gen)++)			\
 		for ((type) = 0; (type) < ANON_AND_FILE; (type)++)	\
 			for ((zone) = 0; (zone) < MAX_NR_ZONES; (zone)++)
 
+#define for_each_evictable_type(type, swappiness)			\
+	for ((type) = !(swappiness); (type) <= ((swappiness) != MAX_SWAPPINESS); (type)++)
+
 #define get_memcg_gen(seq)	((seq) % MEMCG_NR_GENS)
 #define get_memcg_bin(bin)	((bin) % MEMCG_NR_BINS)
 
@@ -2673,10 +2679,16 @@ static int get_nr_gens(struct lruvec *lruvec, int type)
 
 static bool __maybe_unused seq_is_valid(struct lruvec *lruvec)
 {
-	/* see the comment on lru_gen_folio */
-	return get_nr_gens(lruvec, LRU_GEN_FILE) >= MIN_NR_GENS &&
-	       get_nr_gens(lruvec, LRU_GEN_FILE) <= get_nr_gens(lruvec, LRU_GEN_ANON) &&
-	       get_nr_gens(lruvec, LRU_GEN_ANON) <= MAX_NR_GENS;
+	int type;
+
+	for (type = 0; type < ANON_AND_FILE; type++) {
+		int n = get_nr_gens(lruvec, type);
+
+		if (n < MIN_NR_GENS || n > MAX_NR_GENS)
+			return false;
+	}
+
+	return true;
 }
 
 /******************************************************************************
@@ -3083,9 +3095,8 @@ static void read_ctrl_pos(struct lruvec *lruvec, int type, int tier, int gain,
 	pos->refaulted = lrugen->avg_refaulted[type][tier] +
 			 atomic_long_read(&lrugen->refaulted[hist][type][tier]);
 	pos->total = lrugen->avg_total[type][tier] +
+		     lrugen->protected[hist][type][tier] +
 		     atomic_long_read(&lrugen->evicted[hist][type][tier]);
-	if (tier)
-		pos->total += lrugen->protected[hist][type][tier - 1];
 	pos->gain = gain;
 }
 
@@ -3112,17 +3123,15 @@ static void reset_ctrl_pos(struct lruvec *lruvec, int type, bool carryover)
 			WRITE_ONCE(lrugen->avg_refaulted[type][tier], sum / 2);
 
 			sum = lrugen->avg_total[type][tier] +
+			      lrugen->protected[hist][type][tier] +
 			      atomic_long_read(&lrugen->evicted[hist][type][tier]);
-			if (tier)
-				sum += lrugen->protected[hist][type][tier - 1];
 			WRITE_ONCE(lrugen->avg_total[type][tier], sum / 2);
 		}
 
 		if (clear) {
 			atomic_long_set(&lrugen->refaulted[hist][type][tier], 0);
 			atomic_long_set(&lrugen->evicted[hist][type][tier], 0);
-			if (tier)
-				WRITE_ONCE(lrugen->protected[hist][type][tier - 1], 0);
+			WRITE_ONCE(lrugen->protected[hist][type][tier], 0);
 		}
 	}
 }
@@ -3257,7 +3266,7 @@ static int should_skip_vma(unsigned long start, unsigned long end, struct mm_wal
 		return true;
 
 	if (vma_is_anonymous(vma))
-		return !walk->can_swap;
+		return !walk->swappiness;
 
 	if (WARN_ON_ONCE(!vma->vm_file || !vma->vm_file->f_mapping))
 		return true;
@@ -3267,7 +3276,10 @@ static int should_skip_vma(unsigned long start, unsigned long end, struct mm_wal
 		return true;
 
 	if (shmem_mapping(mapping))
-		return !walk->can_swap;
+		return !walk->swappiness;
+
+	if (walk->swappiness == MAX_SWAPPINESS)
+		return true;
 
 	/* to exclude special mappings like dax, etc. */
 	return !mapping->a_ops->read_folio;
@@ -3355,7 +3367,7 @@ static unsigned long get_pmd_pfn(pmd_t pmd, struct vm_area_struct *vma, unsigned
 }
 
 static struct folio *get_pfn_folio(unsigned long pfn, struct mem_cgroup *memcg,
-				   struct pglist_data *pgdat, bool can_swap)
+				   struct pglist_data *pgdat)
 {
 	struct folio *folio;
 
@@ -3366,10 +3378,6 @@ static struct folio *get_pfn_folio(unsigned long pfn, struct mem_cgroup *memcg,
 	if (folio_memcg(folio) != memcg)
 		return NULL;
 
-	/* file VMAs can contain anon pages from COW */
-	if (!folio_is_file_lru(folio) && !can_swap)
-		return NULL;
-
 	return folio;
 }
 
@@ -3425,7 +3433,7 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
 		if (pfn == -1)
 			continue;
 
-		folio = get_pfn_folio(pfn, memcg, pgdat, walk->can_swap);
+		folio = get_pfn_folio(pfn, memcg, pgdat);
 		if (!folio)
 			continue;
 
@@ -3510,7 +3518,7 @@ static void walk_pmd_range_locked(pud_t *pud, unsigned long addr, struct vm_area
 		if (pfn == -1)
 			goto next;
 
-		folio = get_pfn_folio(pfn, memcg, pgdat, walk->can_swap);
+		folio = get_pfn_folio(pfn, memcg, pgdat);
 		if (!folio)
 			goto next;
 
@@ -3722,22 +3730,26 @@ static void clear_mm_walk(void)
 		kfree(walk);
 }
 
-static bool inc_min_seq(struct lruvec *lruvec, int type, bool can_swap)
+static bool inc_min_seq(struct lruvec *lruvec, int type, int swappiness)
 {
 	int zone;
 	int remaining = MAX_LRU_BATCH;
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
+	int hist = lru_hist_from_seq(lrugen->min_seq[type]);
 	int new_gen, old_gen = lru_gen_from_seq(lrugen->min_seq[type]);
 
-	if (type == LRU_GEN_ANON && !can_swap)
+	if (type ? swappiness == MAX_SWAPPINESS : !swappiness)
 		goto done;
 
-	/* prevent cold/hot inversion if force_scan is true */
+	/* prevent cold/hot inversion if the type is evictable */
 	for (zone = 0; zone < MAX_NR_ZONES; zone++) {
 		struct list_head *head = &lrugen->folios[old_gen][type][zone];
 
 		while (!list_empty(head)) {
 			struct folio *folio = lru_to_folio(head);
+			int refs = folio_lru_refs(folio);
+			int tier = lru_tier_from_refs(refs);
+			int delta = folio_nr_pages(folio);
 
 			VM_WARN_ON_ONCE_FOLIO(folio_test_unevictable(folio), folio);
 			VM_WARN_ON_ONCE_FOLIO(folio_test_active(folio), folio);
@@ -3747,6 +3759,9 @@ static bool inc_min_seq(struct lruvec *lruvec, int type, bool can_swap)
 			new_gen = folio_inc_gen(lruvec, folio, false);
 			list_move_tail(&folio->lru, &lrugen->folios[new_gen][type][zone]);
 
+			WRITE_ONCE(lrugen->protected[hist][type][tier],
+				   lrugen->protected[hist][type][tier] + delta);
+
 			if (!--remaining)
 				return false;
 		}
@@ -3758,51 +3773,37 @@ static bool inc_min_seq(struct lruvec *lruvec, int type, bool can_swap)
 	return true;
 }
 
-static bool try_to_inc_min_seq(struct lruvec *lruvec, bool can_swap)
+static bool try_to_inc_min_seq(struct lruvec *lruvec, int swappiness)
 {
 	int gen, type, zone;
 	bool success = false;
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
-	DEFINE_MIN_SEQ(lruvec);
 
 	VM_WARN_ON_ONCE(!seq_is_valid(lruvec));
 
-	/* find the oldest populated generation */
-	for (type = !can_swap; type < ANON_AND_FILE; type++) {
-		while (min_seq[type] + MIN_NR_GENS <= lrugen->max_seq) {
-			gen = lru_gen_from_seq(min_seq[type]);
+	for_each_evictable_type(type, swappiness) {
+		unsigned long seq;
+
+		for (seq = lrugen->min_seq[type]; seq + MIN_NR_GENS <= lrugen->max_seq; seq++) {
+			gen = lru_gen_from_seq(seq);
 
 			for (zone = 0; zone < MAX_NR_ZONES; zone++) {
 				if (!list_empty(&lrugen->folios[gen][type][zone]))
 					goto next;
 			}
-
-			min_seq[type]++;
 		}
 next:
-		;
-	}
-
-	/* see the comment on lru_gen_folio */
-	if (can_swap) {
-		min_seq[LRU_GEN_ANON] = min(min_seq[LRU_GEN_ANON], min_seq[LRU_GEN_FILE]);
-		min_seq[LRU_GEN_FILE] = max(min_seq[LRU_GEN_ANON], lrugen->min_seq[LRU_GEN_FILE]);
-	}
-
-	for (type = !can_swap; type < ANON_AND_FILE; type++) {
-		if (min_seq[type] == lrugen->min_seq[type])
-			continue;
-
-		reset_ctrl_pos(lruvec, type, true);
-		WRITE_ONCE(lrugen->min_seq[type], min_seq[type]);
-		success = true;
+		if (seq != lrugen->min_seq[type]) {
+			reset_ctrl_pos(lruvec, type, true);
+			WRITE_ONCE(lrugen->min_seq[type], seq);
+			success = true;
+		}
 	}
 
 	return success;
 }
 
-static bool inc_max_seq(struct lruvec *lruvec, unsigned long seq,
-			bool can_swap, bool force_scan)
+static bool inc_max_seq(struct lruvec *lruvec, unsigned long seq, int swappiness)
 {
 	bool success;
 	int prev, next;
@@ -3820,13 +3821,11 @@ static bool inc_max_seq(struct lruvec *lruvec, unsigned long seq,
 	if (!success)
 		goto unlock;
 
-	for (type = ANON_AND_FILE - 1; type >= 0; type--) {
+	for (type = 0; type < ANON_AND_FILE; type++) {
 		if (get_nr_gens(lruvec, type) != MAX_NR_GENS)
 			continue;
 
-		VM_WARN_ON_ONCE(!force_scan && (type == LRU_GEN_FILE || can_swap));
-
-		if (inc_min_seq(lruvec, type, can_swap))
+		if (inc_min_seq(lruvec, type, swappiness))
 			continue;
 
 		spin_unlock_irq(&lruvec->lru_lock);
@@ -3870,7 +3869,7 @@ static bool inc_max_seq(struct lruvec *lruvec, unsigned long seq,
 }
 
 static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long seq,
-			       bool can_swap, bool force_scan)
+			       int swappiness, bool force_scan)
 {
 	bool success;
 	struct lru_gen_mm_walk *walk;
@@ -3881,7 +3880,7 @@ static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long seq,
 	VM_WARN_ON_ONCE(seq > READ_ONCE(lrugen->max_seq));
 
 	if (!mm_state)
-		return inc_max_seq(lruvec, seq, can_swap, force_scan);
+		return inc_max_seq(lruvec, seq, swappiness);
 
 	/* see the comment in iterate_mm_list() */
 	if (seq <= READ_ONCE(mm_state->seq))
@@ -3906,7 +3905,7 @@ static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long seq,
 
 	walk->lruvec = lruvec;
 	walk->seq = seq;
-	walk->can_swap = can_swap;
+	walk->swappiness = swappiness;
 	walk->force_scan = force_scan;
 
 	do {
@@ -3916,7 +3915,7 @@ static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long seq,
 	} while (mm);
 done:
 	if (success) {
-		success = inc_max_seq(lruvec, seq, can_swap, force_scan);
+		success = inc_max_seq(lruvec, seq, swappiness);
 		WARN_ON_ONCE(!success);
 	}
 
@@ -3957,13 +3956,13 @@ static bool lruvec_is_sizable(struct lruvec *lruvec, struct scan_control *sc)
 {
 	int gen, type, zone;
 	unsigned long total = 0;
-	bool can_swap = get_swappiness(lruvec, sc);
+	int swappiness = get_swappiness(lruvec, sc);
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	DEFINE_MAX_SEQ(lruvec);
 	DEFINE_MIN_SEQ(lruvec);
 
-	for (type = !can_swap; type < ANON_AND_FILE; type++) {
+	for_each_evictable_type(type, swappiness) {
 		unsigned long seq;
 
 		for (seq = min_seq[type]; seq <= max_seq; seq++) {
@@ -3983,6 +3982,7 @@ static bool lruvec_is_reclaimable(struct lruvec *lruvec, struct scan_control *sc
 {
 	int gen;
 	unsigned long birth;
+	int swappiness = get_swappiness(lruvec, sc);
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	DEFINE_MIN_SEQ(lruvec);
 
@@ -3992,8 +3992,7 @@ static bool lruvec_is_reclaimable(struct lruvec *lruvec, struct scan_control *sc
 	if (!lruvec_is_sizable(lruvec, sc))
 		return false;
 
-	/* see the comment on lru_gen_folio */
-	gen = lru_gen_from_seq(min_seq[LRU_GEN_FILE]);
+	gen = lru_gen_from_seq(evictable_min_seq(min_seq, swappiness));
 	birth = READ_ONCE(lruvec->lrugen.timestamps[gen]);
 
 	return time_is_before_jiffies(birth + min_ttl);
@@ -4060,7 +4059,6 @@ bool lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 	unsigned long addr = pvmw->address;
 	struct vm_area_struct *vma = pvmw->vma;
 	struct folio *folio = pfn_folio(pvmw->pfn);
-	bool can_swap = !folio_is_file_lru(folio);
 	struct mem_cgroup *memcg = folio_memcg(folio);
 	struct pglist_data *pgdat = folio_pgdat(folio);
 	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
@@ -4113,7 +4111,7 @@ bool lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 		if (pfn == -1)
 			continue;
 
-		folio = get_pfn_folio(pfn, memcg, pgdat, can_swap);
+		folio = get_pfn_folio(pfn, memcg, pgdat);
 		if (!folio)
 			continue;
 
@@ -4329,8 +4327,8 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 		gen = folio_inc_gen(lruvec, folio, false);
 		list_move_tail(&folio->lru, &lrugen->folios[gen][type][zone]);
 
-		WRITE_ONCE(lrugen->protected[hist][type][tier - 1],
-			   lrugen->protected[hist][type][tier - 1] + delta);
+		WRITE_ONCE(lrugen->protected[hist][type][tier],
+			   lrugen->protected[hist][type][tier] + delta);
 		return true;
 	}
 
@@ -4529,7 +4527,6 @@ static int isolate_folios(struct lruvec *lruvec, struct scan_control *sc, int sw
 {
 	int i;
 	int type;
-	int scanned;
 	int tier = -1;
 	DEFINE_MIN_SEQ(lruvec);
 
@@ -4554,21 +4551,23 @@ static int isolate_folios(struct lruvec *lruvec, struct scan_control *sc, int sw
 	else
 		type = get_type_to_scan(lruvec, swappiness, &tier);
 
-	for (i = !swappiness; i < ANON_AND_FILE; i++) {
+	for_each_evictable_type(i, swappiness) {
+		int scanned;
+
 		if (tier < 0)
 			tier = get_tier_idx(lruvec, type);
 
+		*type_scanned = type;
+
 		scanned = scan_folios(lruvec, sc, type, tier, list);
 		if (scanned)
-			break;
+			return scanned;
 
 		type = !type;
 		tier = -1;
 	}
 
-	*type_scanned = type;
-
-	return scanned;
+	return 0;
 }
 
 static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swappiness)
@@ -4584,6 +4583,7 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 	struct reclaim_stat stat;
 	struct lru_gen_mm_walk *walk;
 	bool skip_retry = false;
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 
@@ -4593,7 +4593,7 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 
 	scanned += try_to_inc_min_seq(lruvec, swappiness);
 
-	if (get_nr_gens(lruvec, !swappiness) == MIN_NR_GENS)
+	if (evictable_min_seq(lrugen->min_seq, swappiness) + MIN_NR_GENS > lrugen->max_seq)
 		scanned = 0;
 
 	spin_unlock_irq(&lruvec->lru_lock);
@@ -4665,63 +4665,32 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 }
 
 static bool should_run_aging(struct lruvec *lruvec, unsigned long max_seq,
-			     bool can_swap, unsigned long *nr_to_scan)
+			     int swappiness, unsigned long *nr_to_scan)
 {
 	int gen, type, zone;
-	unsigned long old = 0;
-	unsigned long young = 0;
-	unsigned long total = 0;
+	unsigned long size = 0;
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	DEFINE_MIN_SEQ(lruvec);
 
-	/* whether this lruvec is completely out of cold folios */
-	if (min_seq[!can_swap] + MIN_NR_GENS > max_seq) {
-		*nr_to_scan = 0;
+	*nr_to_scan = 0;
+	/* have to run aging, since eviction is not possible anymore */
+	if (evictable_min_seq(min_seq, swappiness) + MIN_NR_GENS > max_seq)
 		return true;
-	}
 
-	for (type = !can_swap; type < ANON_AND_FILE; type++) {
+	for_each_evictable_type(type, swappiness) {
 		unsigned long seq;
 
 		for (seq = min_seq[type]; seq <= max_seq; seq++) {
-			unsigned long size = 0;
-
 			gen = lru_gen_from_seq(seq);
 
 			for (zone = 0; zone < MAX_NR_ZONES; zone++)
 				size += max(READ_ONCE(lrugen->nr_pages[gen][type][zone]), 0L);
-
-			total += size;
-			if (seq == max_seq)
-				young += size;
-			else if (seq + MIN_NR_GENS == max_seq)
-				old += size;
 		}
 	}
 
-	*nr_to_scan = total;
-
-	/*
-	 * The aging tries to be lazy to reduce the overhead, while the eviction
-	 * stalls when the number of generations reaches MIN_NR_GENS. Hence, the
-	 * ideal number of generations is MIN_NR_GENS+1.
-	 */
-	if (min_seq[!can_swap] + MIN_NR_GENS < max_seq)
-		return false;
-
-	/*
-	 * It's also ideal to spread pages out evenly, i.e., 1/(MIN_NR_GENS+1)
-	 * of the total number of pages for each generation. A reasonable range
-	 * for this average portion is [1/MIN_NR_GENS, 1/(MIN_NR_GENS+2)]. The
-	 * aging cares about the upper bound of hot pages, while the eviction
-	 * cares about the lower bound of cold pages.
-	 */
-	if (young * MIN_NR_GENS > total)
-		return true;
-	if (old * (MIN_NR_GENS + 2) < total)
-		return true;
-
-	return false;
+	*nr_to_scan = size;
+	/* better to run aging even though eviction is still possible */
+	return evictable_min_seq(min_seq, swappiness) + MIN_NR_GENS == max_seq;
 }
 
 /*
@@ -4729,7 +4698,7 @@ static bool should_run_aging(struct lruvec *lruvec, unsigned long max_seq,
  * 1. Defer try_to_inc_max_seq() to workqueues to reduce latency for memcg
  *    reclaim.
  */
-static long get_nr_to_scan(struct lruvec *lruvec, struct scan_control *sc, bool can_swap)
+static long get_nr_to_scan(struct lruvec *lruvec, struct scan_control *sc, int swappiness)
 {
 	bool success;
 	unsigned long nr_to_scan;
@@ -4739,7 +4708,7 @@ static long get_nr_to_scan(struct lruvec *lruvec, struct scan_control *sc, bool
 	if (mem_cgroup_below_min(sc->target_mem_cgroup, memcg))
 		return -1;
 
-	success = should_run_aging(lruvec, max_seq, can_swap, &nr_to_scan);
+	success = should_run_aging(lruvec, max_seq, swappiness, &nr_to_scan);
 
 	/* try to scrape all its memory if this memcg was deleted */
 	if (nr_to_scan && !mem_cgroup_online(memcg))
@@ -4750,7 +4719,7 @@ static long get_nr_to_scan(struct lruvec *lruvec, struct scan_control *sc, bool
 		return nr_to_scan >> sc->priority;
 
 	/* stop scanning this lruvec as it's low on cold folios */
-	return try_to_inc_max_seq(lruvec, max_seq, can_swap, false) ? -1 : 0;
+	return try_to_inc_max_seq(lruvec, max_seq, swappiness, false) ? -1 : 0;
 }
 
 static bool should_abort_scan(struct lruvec *lruvec, struct scan_control *sc)
@@ -5294,8 +5263,7 @@ static void lru_gen_seq_show_full(struct seq_file *m, struct lruvec *lruvec,
 				s = "rep";
 				n[0] = atomic_long_read(&lrugen->refaulted[hist][type][tier]);
 				n[1] = atomic_long_read(&lrugen->evicted[hist][type][tier]);
-				if (tier)
-					n[2] = READ_ONCE(lrugen->protected[hist][type][tier - 1]);
+				n[2] = READ_ONCE(lrugen->protected[hist][type][tier]);
 			}
 
 			for (i = 0; i < 3; i++)
@@ -5350,7 +5318,7 @@ static int lru_gen_seq_show(struct seq_file *m, void *v)
 	seq_printf(m, " node %5d\n", nid);
 
 	if (!full)
-		seq = min_seq[LRU_GEN_ANON];
+		seq = evictable_min_seq(min_seq, MAX_SWAPPINESS / 2);
 	else if (max_seq >= MAX_NR_GENS)
 		seq = max_seq - MAX_NR_GENS + 1;
 	else
@@ -5390,23 +5358,14 @@ static const struct seq_operations lru_gen_seq_ops = {
 };
 
 static int run_aging(struct lruvec *lruvec, unsigned long seq,
-		     bool can_swap, bool force_scan)
+		     int swappiness, bool force_scan)
 {
 	DEFINE_MAX_SEQ(lruvec);
-	DEFINE_MIN_SEQ(lruvec);
-
-	if (seq < max_seq)
-		return 0;
 
 	if (seq > max_seq)
 		return -EINVAL;
 
-	if (!force_scan && min_seq[!can_swap] + MAX_NR_GENS - 1 <= max_seq)
-		return -ERANGE;
-
-	try_to_inc_max_seq(lruvec, max_seq, can_swap, force_scan);
-
-	return 0;
+	return try_to_inc_max_seq(lruvec, max_seq, swappiness, force_scan) ? 0 : -EEXIST;
 }
 
 static int run_eviction(struct lruvec *lruvec, unsigned long seq, struct scan_control *sc,
@@ -5422,7 +5381,7 @@ static int run_eviction(struct lruvec *lruvec, unsigned long seq, struct scan_co
 	while (!signal_pending(current)) {
 		DEFINE_MIN_SEQ(lruvec);
 
-		if (seq < min_seq[!swappiness])
+		if (seq < evictable_min_seq(min_seq, swappiness))
 			return 0;
 
 		if (sc->nr_reclaimed >= nr_to_reclaim)
-- 
2.47.0.338.g60cca15819-goog


