Return-Path: <linux-kernel+bounces-434154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBA89E6247
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEF2C283322
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864C513A24A;
	Fri,  6 Dec 2024 00:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2vBBymRG"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688C72D627
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 00:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733445110; cv=none; b=vFTXJgXXWzR8ikGNmChgqQlDmDP3injA/07wtLCQxN30jQAqbw4nEJxQPN/O0RdyiRHsSkkhAQJRpFkQhfeJ7VIn79EKCRp0wlt5JvPRhjfQ6S9b1LMYZ4bFP+SAipaOVRFScFgrjArNlqRbJJUfc74noGRrggLI815PueNxNss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733445110; c=relaxed/simple;
	bh=VZCMrQWDI6dod9jQGbMKkpRTxcC2ZECYT7EYD4ZOi2U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I5OLa3w0t5atUTBoFo0px9HiMCb4UdaffGq3In+b5A36cPSuGCA8PIw/FLNA1wZ/cLE3EcDdfTUiEXaxUpOU5T3WxxqCL2ZzOJZRQMTRFRFmkN5OJt3mOvMt3rAdeE95cDMtGHtW3+uKRw/tg2ukH3BzYOp6RYxDySW3WrvsMi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2vBBymRG; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-72590d79ef4so1642111b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 16:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733445107; x=1734049907; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jxh/CyTiTo80t1btGtiyWK44N5wckY+h9Q8TEZ4a9hc=;
        b=2vBBymRGg6l+TvjdyBJmFImWg6XwJouZgSaKsjbFFeUP1i/b+9aUh9sf5O2ZuKVtBg
         nQqP73MirOCjLLAeP6vKL8QGPVi+wagAeMLGrE4eK1UKlRhWPaT8fowNY5FhL8MOp2io
         lTf8YfugQILpona8kn/nF4VIFVssQYQ6U83VmDFkuc7leiIR0j1XIvRKs93gsZL6KbFx
         z90WqG9Ei8lZTb4Bc3ShzbHZY6ysAtUvcqXcWe4OokNo4TRdgN+kTnw1dYzXyZ5/6CwF
         GKfm7U26ngcbHHdWRBao+CKHebiSHbU8AOERHlZrUisR1she4eGZjfHqG0hPB8dikkdA
         Jm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733445107; x=1734049907;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jxh/CyTiTo80t1btGtiyWK44N5wckY+h9Q8TEZ4a9hc=;
        b=MgLTae6Q/9oWs2X20KD2zOv9fIgGkYynlQqNuWhrKORVWPoXwHdJ0YGlsLc8rzJuxO
         B/RqemWlgeFj8hqJ/RLgBVRkgAgInbiDZPdV7/K4cMMtU4VyF9QAvk4VqH5xx4E0n0t8
         kt1dBR3Dz1LcWAWGSXCJ5Z7KfWZ0zs0nBpapE2ekU/mPAQDrQ7Dsb0qc2ukAosAHs96h
         qU/azMH1vq8BeugyUTNT1MvsHkVvqRuJbPXn72/H26AvxERE33+BCi3mPFqQMTU8oMSR
         9BGXaGmbJ4Gvsk8UPbERZHx1zDfjllzodMnv5APp3vpF2r3Wexg5NQuP/SamYG8tzwhP
         08dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEqiC3CrVb9wxaecmYQBsijBpJqhD7apcukJmsVbqZRWO0jigWJoJWC0BEyIlGVGIIJyWZKk28b7fQ+Xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqIfQbgsJ9M+PRd9umF4NlV+8qKzlzn3N+YzGIOQuvfTHEX1gK
	0ovFr9rpHYeJ4eRlza8Ur2tM9qv5dmFRyWJ2xahi/FcUaH2sGPKByPIL3+s1d29UdD8tO67FoJD
	Vcw==
X-Google-Smtp-Source: AGHT+IHJZ27MMa+QM4bFIoZmXc7e0cPr2Wfn3+ytQioqkCZG+HaMt6KJnbAzL7i3cXCeUdXXjK50wIdQ7DI=
X-Received: from plbma14.prod.google.com ([2002:a17:903:94e:b0:20d:1e2b:3284])
 (user=yuzhao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1c4:b0:215:b307:5bb2
 with SMTP id d9443c01a7336-21614d68a58mr11549455ad.14.1733445107659; Thu, 05
 Dec 2024 16:31:47 -0800 (PST)
Date: Thu,  5 Dec 2024 17:31:26 -0700
In-Reply-To: <20241206003126.1338283-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241206003126.1338283-1-yuzhao@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241206003126.1338283-7-yuzhao@google.com>
Subject: [PATCH mm-unstable v2 6/6] mm/mglru: rework workingset protection
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>, Kairui Song <kasong@tencent.com>, 
	Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"

With the aging feedback no longer considering the distribution of
folios in each generation, rework workingset protection to better
distribute folios across MAX_NR_GENS. This is achieved by reusing
PG_workingset and PG_referenced/LRU_REFS_FLAGS in a slightly different
way.

For folios accessed multiple times through file descriptors, make
lru_gen_inc_refs() set additional bits of LRU_REFS_WIDTH in
folio->flags after PG_referenced, then PG_workingset after
LRU_REFS_WIDTH. After all its bits are set, i.e.,
LRU_REFS_FLAGS|BIT(PG_workingset), a folio is lazily promoted into the
second oldest generation in the eviction path. And when
folio_inc_gen() does that, it clears LRU_REFS_FLAGS so that
lru_gen_inc_refs() can start over. For this case, LRU_REFS_MASK is
only valid when PG_referenced is set.

For folios accessed multiple times through page tables,
folio_update_gen() from a page table walk or lru_gen_set_refs() from a
rmap walk sets PG_referenced after the accessed bit is cleared for the
first time. Thereafter, those two paths set PG_workingset and promote
folios to the youngest generation. Like folio_inc_gen(), when
folio_update_gen() does that, it also clears PG_referenced. For this
case, LRU_REFS_MASK is not used.

For both of the cases, after PG_workingset is set on a folio, it
remains until this folio is either reclaimed, or "deactivated" by
lru_gen_clear_refs(). It can be set again if lru_gen_test_recent()
returns true upon a refault.

When adding folios to the LRU lists, lru_gen_distance() distributes
them as follows:
+---------------------------------+---------------------------------+
|    Accessed thru page tables    | Accessed thru file descriptors  |
+---------------------------------+---------------------------------+
| PG_active (set while isolated)  |                                 |
+----------------+----------------+----------------+----------------+
| PG_workingset  | PG_referenced  | PG_workingset  | LRU_REFS_FLAGS |
+---------------------------------+---------------------------------+
|<--------- MIN_NR_GENS --------->|                                 |
|<-------------------------- MAX_NR_GENS -------------------------->|

After this patch, some typical client and server workloads showed
improvements under heavy memory pressure. For example, Python TPC-C,
which was used to benchmark a different approach [1] to better detect
refault distances, showed a significant decrease in total refaults:
                            Before      After      Change
  Time (seconds)            10801       10801      0%
  Executed (transactions)   41472       43663      +5%
  workingset_nodes          109070      120244     +10%
  workingset_refault_anon   5019627     7281831    +45%
  workingset_refault_file   1294678786  554855564  -57%
  workingset_refault_total  1299698413  562137395  -57%

[1] https://lore.kernel.org/20230920190244.16839-1-ryncsn@gmail.com/

Reported-by: Kairui Song <kasong@tencent.com>
Closes: https://lore.kernel.org/CAOUHufahuWcKf5f1Sg3emnqX+cODuR=2TQo7T4Gr-QYLujn4RA@mail.gmail.com/
Signed-off-by: Yu Zhao <yuzhao@google.com>
Tested-by: Kalesh Singh <kaleshsingh@google.com>
---
 include/linux/mm_inline.h |  94 +++++++++++++------------
 include/linux/mmzone.h    |  82 +++++++++++++---------
 mm/swap.c                 |  23 +++---
 mm/vmscan.c               | 142 +++++++++++++++++++++++---------------
 mm/workingset.c           |  29 ++++----
 5 files changed, 209 insertions(+), 161 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 34e5097182a0..3fcf5fa797fe 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -133,31 +133,25 @@ static inline int lru_hist_from_seq(unsigned long seq)
 	return seq % NR_HIST_GENS;
 }
 
-static inline int lru_tier_from_refs(int refs)
+static inline int lru_tier_from_refs(int refs, bool workingset)
 {
 	VM_WARN_ON_ONCE(refs > BIT(LRU_REFS_WIDTH));
 
-	/* see the comment in folio_lru_refs() */
-	return order_base_2(refs + 1);
+	/* see the comment on MAX_NR_TIERS */
+	return workingset ? MAX_NR_TIERS - 1 : order_base_2(refs);
 }
 
 static inline int folio_lru_refs(struct folio *folio)
 {
 	unsigned long flags = READ_ONCE(folio->flags);
-	bool workingset = flags & BIT(PG_workingset);
 
+	if (!(flags & BIT(PG_referenced)))
+		return 0;
 	/*
-	 * Return the number of accesses beyond PG_referenced, i.e., N-1 if the
-	 * total number of accesses is N>1, since N=0,1 both map to the first
-	 * tier. lru_tier_from_refs() will account for this off-by-one. Also see
-	 * the comment on MAX_NR_TIERS.
+	 * Return the total number of accesses including PG_referenced. Also see
+	 * the comment on LRU_REFS_FLAGS.
 	 */
-	return ((flags & LRU_REFS_MASK) >> LRU_REFS_PGOFF) + workingset;
-}
-
-static inline void folio_clear_lru_refs(struct folio *folio)
-{
-	set_mask_bits(&folio->flags, LRU_REFS_MASK | LRU_REFS_FLAGS, 0);
+	return ((flags & LRU_REFS_MASK) >> LRU_REFS_PGOFF) + 1;
 }
 
 static inline int folio_lru_gen(struct folio *folio)
@@ -223,11 +217,46 @@ static inline void lru_gen_update_size(struct lruvec *lruvec, struct folio *foli
 	VM_WARN_ON_ONCE(lru_gen_is_active(lruvec, old_gen) && !lru_gen_is_active(lruvec, new_gen));
 }
 
+static inline int lru_gen_distance(struct folio *folio, bool reclaiming)
+{
+	/*
+	 * Distance until eviction (larger values provide stronger protection):
+	 * +-------------------------------------+-------------------------------------+
+	 * | Accessed through page tables and    | Accessed through file descriptors   |
+	 * | promoted by folio_update_gen()      | and protected by folio_inc_gen()    |
+	 * +-------------------------------------+-------------------------------------+
+	 * | PG_active (only set while isolated) |                                     |
+	 * +------------------+------------------+------------------+------------------+
+	 * |  PG_workingset   |  PG_referenced   |  PG_workingset   |  LRU_REFS_FLAGS  |
+	 * +-------------------------------------+-------------------------------------+
+	 * |        3         |        2         |        1         |        0         |
+	 * +-------------------------------------+-------------------------------------+
+	 * |<----------- MIN_NR_GENS ----------->|                                     |
+	 * |<------------------------------ MAX_NR_GENS ------------------------------>|
+	 */
+	if (reclaiming)
+		return 0;
+
+	if (folio_test_active(folio))
+		return MIN_NR_GENS + folio_test_workingset(folio);
+
+	if (folio_test_workingset(folio))
+		return MIN_NR_GENS - 1;
+
+	if (!folio_is_file_lru(folio) && !folio_test_swapcache(folio))
+		return MIN_NR_GENS - 1;
+
+	if (folio_test_reclaim(folio) && (folio_test_dirty(folio) || folio_test_writeback(folio)))
+		return MIN_NR_GENS - 1;
+
+	return 0;
+}
+
 static inline bool lru_gen_add_folio(struct lruvec *lruvec, struct folio *folio, bool reclaiming)
 {
+	int dist;
 	unsigned long seq;
 	unsigned long flags;
-	unsigned long mask;
 	int gen = folio_lru_gen(folio);
 	int type = folio_is_file_lru(folio);
 	int zone = folio_zonenum(folio);
@@ -237,40 +266,17 @@ static inline bool lru_gen_add_folio(struct lruvec *lruvec, struct folio *folio,
 
 	if (folio_test_unevictable(folio) || !lrugen->enabled)
 		return false;
-	/*
-	 * There are four common cases for this page:
-	 * 1. If it's hot, i.e., freshly faulted in, add it to the youngest
-	 *    generation, and it's protected over the rest below.
-	 * 2. If it can't be evicted immediately, i.e., a dirty page pending
-	 *    writeback, add it to the second youngest generation.
-	 * 3. If it should be evicted first, e.g., cold and clean from
-	 *    folio_rotate_reclaimable(), add it to the oldest generation.
-	 * 4. Everything else falls between 2 & 3 above and is added to the
-	 *    second oldest generation if it's considered inactive, or the
-	 *    oldest generation otherwise. See lru_gen_is_active().
-	 */
-	if (folio_test_active(folio))
-		seq = lrugen->max_seq;
-	else if ((type == LRU_GEN_ANON && !folio_test_swapcache(folio)) ||
-		 (folio_test_reclaim(folio) &&
-		  (folio_test_dirty(folio) || folio_test_writeback(folio))))
-		seq = lrugen->max_seq - 1;
-	else if (reclaiming || lrugen->min_seq[type] + MIN_NR_GENS >= lrugen->max_seq)
-		seq = lrugen->min_seq[type];
+
+	dist = lru_gen_distance(folio, reclaiming);
+	if (dist < MIN_NR_GENS)
+		seq = lrugen->min_seq[type] + dist;
 	else
-		seq = lrugen->min_seq[type] + 1;
+		seq = lrugen->max_seq + dist - MIN_NR_GENS - 1;
 
 	gen = lru_gen_from_seq(seq);
 	flags = (gen + 1UL) << LRU_GEN_PGOFF;
 	/* see the comment on MIN_NR_GENS about PG_active */
-	mask = LRU_GEN_MASK;
-	/*
-	 * Don't clear PG_workingset here because it can affect PSI accounting
-	 * if the activation is due to workingset refault.
-	 */
-	if (folio_test_active(folio))
-		mask |= LRU_REFS_MASK | BIT(PG_referenced) | BIT(PG_active);
-	set_mask_bits(&folio->flags, mask, flags);
+	set_mask_bits(&folio->flags, LRU_GEN_MASK | BIT(PG_active), flags);
 
 	lru_gen_update_size(lruvec, folio, -1, gen);
 	/* for folio_rotate_reclaimable() */
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index b998ccc5c341..c7ad4d6e1618 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -332,66 +332,88 @@ enum lruvec_flags {
 #endif /* !__GENERATING_BOUNDS_H */
 
 /*
- * Evictable pages are divided into multiple generations. The youngest and the
+ * Evictable folios are divided into multiple generations. The youngest and the
  * oldest generation numbers, max_seq and min_seq, are monotonically increasing.
  * They form a sliding window of a variable size [MIN_NR_GENS, MAX_NR_GENS]. An
  * offset within MAX_NR_GENS, i.e., gen, indexes the LRU list of the
  * corresponding generation. The gen counter in folio->flags stores gen+1 while
- * a page is on one of lrugen->folios[]. Otherwise it stores 0.
+ * a folio is on one of lrugen->folios[]. Otherwise it stores 0.
  *
- * A page is added to the youngest generation on faulting. The aging needs to
- * check the accessed bit at least twice before handing this page over to the
- * eviction. The first check takes care of the accessed bit set on the initial
- * fault; the second check makes sure this page hasn't been used since then.
- * This process, AKA second chance, requires a minimum of two generations,
- * hence MIN_NR_GENS. And to maintain ABI compatibility with the active/inactive
- * LRU, e.g., /proc/vmstat, these two generations are considered active; the
- * rest of generations, if they exist, are considered inactive. See
- * lru_gen_is_active().
+ * After a folio is faulted in, the aging needs to check the accessed bit at
+ * least twice before handing this folio over to the eviction. The first check
+ * clears the accessed bit from the initial fault; the second check makes sure
+ * this folio hasn't been used since then. This process, AKA second chance,
+ * requires a minimum of two generations, hence MIN_NR_GENS. And to maintain ABI
+ * compatibility with the active/inactive LRU, e.g., /proc/vmstat, these two
+ * generations are considered active; the rest of generations, if they exist,
+ * are considered inactive. See lru_gen_is_active().
  *
- * PG_active is always cleared while a page is on one of lrugen->folios[] so
- * that the aging needs not to worry about it. And it's set again when a page
- * considered active is isolated for non-reclaiming purposes, e.g., migration.
- * See lru_gen_add_folio() and lru_gen_del_folio().
+ * PG_active is always cleared while a folio is on one of lrugen->folios[] so
+ * that the sliding window needs not to worry about it. And it's set again when
+ * a folio considered active is isolated for non-reclaiming purposes, e.g.,
+ * migration. See lru_gen_add_folio() and lru_gen_del_folio().
  *
  * MAX_NR_GENS is set to 4 so that the multi-gen LRU can support twice the
  * number of categories of the active/inactive LRU when keeping track of
  * accesses through page tables. This requires order_base_2(MAX_NR_GENS+1) bits
- * in folio->flags.
+ * in folio->flags, masked by LRU_GEN_MASK.
  */
 #define MIN_NR_GENS		2U
 #define MAX_NR_GENS		4U
 
 /*
- * Each generation is divided into multiple tiers. A page accessed N times
- * through file descriptors is in tier order_base_2(N). A page in the first tier
- * (N=0,1) is marked by PG_referenced unless it was faulted in through page
- * tables or read ahead. A page in any other tier (N>1) is marked by
- * PG_referenced and PG_workingset. This implies a minimum of two tiers is
- * supported without using additional bits in folio->flags.
+ * Each generation is divided into multiple tiers. A folio accessed N times
+ * through file descriptors is in tier order_base_2(N). A folio in the first
+ * tier (N=0,1) is marked by PG_referenced unless it was faulted in through page
+ * tables or read ahead. A folio in the last tier (MAX_NR_TIERS-1) is marked by
+ * PG_workingset. A folio in any other tier (1<N<5) between the first and last
+ * is marked by additional bits of LRU_REFS_WIDTH in folio->flags.
  *
  * In contrast to moving across generations which requires the LRU lock, moving
  * across tiers only involves atomic operations on folio->flags and therefore
  * has a negligible cost in the buffered access path. In the eviction path,
- * comparisons of refaulted/(evicted+protected) from the first tier and the
- * rest infer whether pages accessed multiple times through file descriptors
- * are statistically hot and thus worth protecting.
+ * comparisons of refaulted/(evicted+protected) from the first tier and the rest
+ * infer whether folios accessed multiple times through file descriptors are
+ * statistically hot and thus worth protecting.
  *
  * MAX_NR_TIERS is set to 4 so that the multi-gen LRU can support twice the
  * number of categories of the active/inactive LRU when keeping track of
  * accesses through file descriptors. This uses MAX_NR_TIERS-2 spare bits in
- * folio->flags.
+ * folio->flags, masked by LRU_REFS_MASK.
  */
 #define MAX_NR_TIERS		4U
 
 #ifndef __GENERATING_BOUNDS_H
 
-struct lruvec;
-struct page_vma_mapped_walk;
-
 #define LRU_GEN_MASK		((BIT(LRU_GEN_WIDTH) - 1) << LRU_GEN_PGOFF)
 #define LRU_REFS_MASK		((BIT(LRU_REFS_WIDTH) - 1) << LRU_REFS_PGOFF)
 
+/*
+ * For folios accessed multiple times through file descriptors,
+ * lru_gen_inc_refs() sets additional bits of LRU_REFS_WIDTH in folio->flags
+ * after PG_referenced, then PG_workingset after LRU_REFS_WIDTH. After all its
+ * bits are set, i.e., LRU_REFS_FLAGS|BIT(PG_workingset), a folio is lazily
+ * promoted into the second oldest generation in the eviction path. And when
+ * folio_inc_gen() does that, it clears LRU_REFS_FLAGS so that
+ * lru_gen_inc_refs() can start over. Note that for this case, LRU_REFS_MASK is
+ * only valid when PG_referenced is set.
+ *
+ * For folios accessed multiple times through page tables, folio_update_gen()
+ * from a page table walk or lru_gen_set_refs() from a rmap walk sets
+ * PG_referenced after the accessed bit is cleared for the first time.
+ * Thereafter, those two paths set PG_workingset and promote folios to the
+ * youngest generation. Like folio_inc_gen(), folio_update_gen() also clears
+ * PG_referenced. Note that for this case, LRU_REFS_MASK is not used.
+ *
+ * For both cases above, after PG_workingset is set on a folio, it remains until
+ * this folio is either reclaimed, or "deactivated" by lru_gen_clear_refs(). It
+ * can be set again if lru_gen_test_recent() returns true upon a refault.
+ */
+#define LRU_REFS_FLAGS		(LRU_REFS_MASK | BIT(PG_referenced))
+
+struct lruvec;
+struct page_vma_mapped_walk;
+
 #ifdef CONFIG_LRU_GEN
 
 enum {
@@ -406,8 +428,6 @@ enum {
 	NR_LRU_GEN_CAPS
 };
 
-#define LRU_REFS_FLAGS		(BIT(PG_referenced) | BIT(PG_workingset))
-
 #define MIN_LRU_BATCH		BITS_PER_LONG
 #define MAX_LRU_BATCH		(MIN_LRU_BATCH * 64)
 
diff --git a/mm/swap.c b/mm/swap.c
index 15a94be8b0af..320b959b74c6 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -387,24 +387,19 @@ static void lru_gen_inc_refs(struct folio *folio)
 	if (folio_test_unevictable(folio))
 		return;
 
+	/* see the comment on LRU_REFS_FLAGS */
 	if (!folio_test_referenced(folio)) {
-		folio_set_referenced(folio);
+		set_mask_bits(&folio->flags, LRU_REFS_MASK, BIT(PG_referenced));
 		return;
 	}
 
-	if (!folio_test_workingset(folio)) {
-		folio_set_workingset(folio);
-		return;
-	}
-
-	/* see the comment on MAX_NR_TIERS */
 	do {
-		new_flags = old_flags & LRU_REFS_MASK;
-		if (new_flags == LRU_REFS_MASK)
-			break;
+		if ((old_flags & LRU_REFS_MASK) == LRU_REFS_MASK) {
+			folio_set_workingset(folio);
+			return;
+		}
 
-		new_flags += BIT(LRU_REFS_PGOFF);
-		new_flags |= old_flags & ~LRU_REFS_MASK;
+		new_flags = old_flags + BIT(LRU_REFS_PGOFF);
 	} while (!try_cmpxchg(&folio->flags, &old_flags, new_flags));
 }
 
@@ -414,7 +409,7 @@ static bool lru_gen_clear_refs(struct folio *folio)
 	int type = folio_is_file_lru(folio);
 	struct lru_gen_folio *lrugen = &folio_lruvec(folio)->lrugen;
 
-	set_mask_bits(&folio->flags, LRU_REFS_MASK | LRU_REFS_FLAGS, 0);
+	set_mask_bits(&folio->flags, LRU_REFS_FLAGS | BIT(PG_workingset), 0);
 
 	/* whether can do without shuffling under the LRU lock */
 	return gen == lru_gen_from_seq(READ_ONCE(lrugen->min_seq[type]));
@@ -495,7 +490,7 @@ void folio_add_lru(struct folio *folio)
 			folio_test_unevictable(folio), folio);
 	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
 
-	/* see the comment in lru_gen_add_folio() */
+	/* see the comment in lru_gen_distance() */
 	if (lru_gen_enabled() && !folio_test_unevictable(folio) &&
 	    lru_gen_in_fault() && !(current->flags & PF_MEMALLOC))
 		folio_set_active(folio);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 02b01ae2bdbb..90bbc2b3be8b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -862,6 +862,31 @@ enum folio_references {
 	FOLIOREF_ACTIVATE,
 };
 
+#ifdef CONFIG_LRU_GEN
+/*
+ * Only used on a mapped folio in the eviction (rmap walk) path, where promotion
+ * needs to be done by taking the folio off the LRU list and then adding it back
+ * with PG_active set. In contrast, the aging (page table walk) path uses
+ * folio_update_gen().
+ */
+static bool lru_gen_set_refs(struct folio *folio)
+{
+	/* see the comment on LRU_REFS_FLAGS */
+	if (!folio_test_referenced(folio) && !folio_test_workingset(folio)) {
+		set_mask_bits(&folio->flags, LRU_REFS_MASK, BIT(PG_referenced));
+		return false;
+	}
+
+	set_mask_bits(&folio->flags, LRU_REFS_FLAGS, BIT(PG_workingset));
+	return true;
+}
+#else
+static bool lru_gen_set_refs(struct folio *folio)
+{
+	return false;
+}
+#endif /* CONFIG_LRU_GEN */
+
 static enum folio_references folio_check_references(struct folio *folio,
 						  struct scan_control *sc)
 {
@@ -870,7 +895,6 @@ static enum folio_references folio_check_references(struct folio *folio,
 
 	referenced_ptes = folio_referenced(folio, 1, sc->target_mem_cgroup,
 					   &vm_flags);
-	referenced_folio = folio_test_clear_referenced(folio);
 
 	/*
 	 * The supposedly reclaimable folio was found to be in a VM_LOCKED vma.
@@ -888,6 +912,16 @@ static enum folio_references folio_check_references(struct folio *folio,
 	if (referenced_ptes == -1)
 		return FOLIOREF_KEEP;
 
+	if (lru_gen_enabled()) {
+		if (!referenced_ptes)
+			return FOLIOREF_RECLAIM;
+
+		lru_gen_set_refs(folio);
+		return FOLIOREF_ACTIVATE;
+	}
+
+	referenced_folio = folio_test_clear_referenced(folio);
+
 	if (referenced_ptes) {
 		/*
 		 * All mapped folios start out with page table
@@ -1092,11 +1126,6 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		if (!sc->may_unmap && folio_mapped(folio))
 			goto keep_locked;
 
-		/* folio_update_gen() tried to promote this page? */
-		if (lru_gen_enabled() && !ignore_references &&
-		    folio_mapped(folio) && folio_test_referenced(folio))
-			goto keep_locked;
-
 		/*
 		 * The number of dirty pages determines if a node is marked
 		 * reclaim_congested. kswapd will stall and start writing
@@ -3163,16 +3192,19 @@ static int folio_update_gen(struct folio *folio, int gen)
 
 	VM_WARN_ON_ONCE(gen >= MAX_NR_GENS);
 
+	/* see the comment on LRU_REFS_FLAGS */
+	if (!folio_test_referenced(folio) && !folio_test_workingset(folio)) {
+		set_mask_bits(&folio->flags, LRU_REFS_MASK, BIT(PG_referenced));
+		return -1;
+	}
+
 	do {
 		/* lru_gen_del_folio() has isolated this page? */
-		if (!(old_flags & LRU_GEN_MASK)) {
-			/* for shrink_folio_list() */
-			new_flags = old_flags | BIT(PG_referenced);
-			continue;
-		}
+		if (!(old_flags & LRU_GEN_MASK))
+			return -1;
 
-		new_flags = old_flags & ~(LRU_GEN_MASK | LRU_REFS_MASK | LRU_REFS_FLAGS);
-		new_flags |= (gen + 1UL) << LRU_GEN_PGOFF;
+		new_flags = old_flags & ~(LRU_GEN_MASK | LRU_REFS_FLAGS);
+		new_flags |= ((gen + 1UL) << LRU_GEN_PGOFF) | BIT(PG_workingset);
 	} while (!try_cmpxchg(&folio->flags, &old_flags, new_flags));
 
 	return ((old_flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
@@ -3196,7 +3228,7 @@ static int folio_inc_gen(struct lruvec *lruvec, struct folio *folio, bool reclai
 
 		new_gen = (old_gen + 1) % MAX_NR_GENS;
 
-		new_flags = old_flags & ~(LRU_GEN_MASK | LRU_REFS_MASK | LRU_REFS_FLAGS);
+		new_flags = old_flags & ~(LRU_GEN_MASK | LRU_REFS_FLAGS);
 		new_flags |= (new_gen + 1UL) << LRU_GEN_PGOFF;
 		/* for folio_end_writeback() */
 		if (reclaiming)
@@ -3374,9 +3406,11 @@ static unsigned long get_pmd_pfn(pmd_t pmd, struct vm_area_struct *vma, unsigned
 static struct folio *get_pfn_folio(unsigned long pfn, struct mem_cgroup *memcg,
 				   struct pglist_data *pgdat)
 {
-	struct folio *folio;
+	struct folio *folio = pfn_folio(pfn);
+
+	if (folio_lru_gen(folio) < 0)
+		return NULL;
 
-	folio = pfn_folio(pfn);
 	if (folio_nid(folio) != pgdat->node_id)
 		return NULL;
 
@@ -3753,8 +3787,7 @@ static bool inc_min_seq(struct lruvec *lruvec, int type, int swappiness)
 		while (!list_empty(head)) {
 			struct folio *folio = lru_to_folio(head);
 			int refs = folio_lru_refs(folio);
-			int tier = lru_tier_from_refs(refs);
-			int delta = folio_nr_pages(folio);
+			bool workingset = folio_test_workingset(folio);
 
 			VM_WARN_ON_ONCE_FOLIO(folio_test_unevictable(folio), folio);
 			VM_WARN_ON_ONCE_FOLIO(folio_test_active(folio), folio);
@@ -3764,8 +3797,14 @@ static bool inc_min_seq(struct lruvec *lruvec, int type, int swappiness)
 			new_gen = folio_inc_gen(lruvec, folio, false);
 			list_move_tail(&folio->lru, &lrugen->folios[new_gen][type][zone]);
 
-			WRITE_ONCE(lrugen->protected[hist][type][tier],
-				   lrugen->protected[hist][type][tier] + delta);
+			/* don't count the workingset being lazily promoted */
+			if (refs + workingset != BIT(LRU_REFS_WIDTH) + 1) {
+				int tier = lru_tier_from_refs(refs, workingset);
+				int delta = folio_nr_pages(folio);
+
+				WRITE_ONCE(lrugen->protected[hist][type][tier],
+					   lrugen->protected[hist][type][tier] + delta);
+			}
 
 			if (!--remaining)
 				return false;
@@ -4138,12 +4177,10 @@ bool lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 			continue;
 		}
 
-		old_gen = folio_lru_gen(folio);
-		if (old_gen < 0)
-			folio_set_referenced(folio);
-		else if (old_gen != new_gen) {
-			folio_clear_lru_refs(folio);
-			folio_activate(folio);
+		if (lru_gen_set_refs(folio)) {
+			old_gen = folio_lru_gen(folio);
+			if (old_gen >= 0 && old_gen != new_gen)
+				folio_activate(folio);
 		}
 	}
 
@@ -4304,7 +4341,8 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 	int zone = folio_zonenum(folio);
 	int delta = folio_nr_pages(folio);
 	int refs = folio_lru_refs(folio);
-	int tier = lru_tier_from_refs(refs);
+	bool workingset = folio_test_workingset(folio);
+	int tier = lru_tier_from_refs(refs, workingset);
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 
 	VM_WARN_ON_ONCE_FOLIO(gen >= MAX_NR_GENS, folio);
@@ -4326,14 +4364,17 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 	}
 
 	/* protected */
-	if (tier > tier_idx || refs == BIT(LRU_REFS_WIDTH)) {
-		int hist = lru_hist_from_seq(lrugen->min_seq[type]);
-
+	if (tier > tier_idx || refs + workingset == BIT(LRU_REFS_WIDTH) + 1) {
 		gen = folio_inc_gen(lruvec, folio, false);
-		list_move_tail(&folio->lru, &lrugen->folios[gen][type][zone]);
+		list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
 
-		WRITE_ONCE(lrugen->protected[hist][type][tier],
-			   lrugen->protected[hist][type][tier] + delta);
+		/* don't count the workingset being lazily promoted */
+		if (refs + workingset != BIT(LRU_REFS_WIDTH) + 1) {
+			int hist = lru_hist_from_seq(lrugen->min_seq[type]);
+
+			WRITE_ONCE(lrugen->protected[hist][type][tier],
+				   lrugen->protected[hist][type][tier] + delta);
+		}
 		return true;
 	}
 
@@ -4353,8 +4394,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 	}
 
 	/* waiting for writeback */
-	if (folio_test_locked(folio) || writeback ||
-	    (type == LRU_GEN_FILE && dirty)) {
+	if (writeback || (type == LRU_GEN_FILE && dirty)) {
 		gen = folio_inc_gen(lruvec, folio, true);
 		list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
 		return true;
@@ -4383,13 +4423,12 @@ static bool isolate_folio(struct lruvec *lruvec, struct folio *folio, struct sca
 		return false;
 	}
 
-	/* see the comment on MAX_NR_TIERS */
+	/* see the comment on LRU_REFS_FLAGS */
 	if (!folio_test_referenced(folio))
-		folio_clear_lru_refs(folio);
+		set_mask_bits(&folio->flags, LRU_REFS_MASK, 0);
 
 	/* for shrink_folio_list() */
 	folio_clear_reclaim(folio);
-	folio_clear_referenced(folio);
 
 	success = lru_gen_del_folio(lruvec, folio, true);
 	VM_WARN_ON_ONCE_FOLIO(!success, folio);
@@ -4585,25 +4624,16 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 			continue;
 		}
 
-		if (folio_test_reclaim(folio) &&
-		    (folio_test_dirty(folio) || folio_test_writeback(folio))) {
-			/* restore LRU_REFS_FLAGS cleared by isolate_folio() */
-			if (folio_test_workingset(folio))
-				folio_set_referenced(folio);
-			continue;
-		}
-
-		if (skip_retry || folio_test_active(folio) || folio_test_referenced(folio) ||
-		    folio_mapped(folio) || folio_test_locked(folio) ||
-		    folio_test_dirty(folio) || folio_test_writeback(folio)) {
-			/* don't add rejected folios to the oldest generation */
-			set_mask_bits(&folio->flags, LRU_REFS_MASK | LRU_REFS_FLAGS,
-				      BIT(PG_active));
-			continue;
-		}
-
 		/* retry folios that may have missed folio_rotate_reclaimable() */
-		list_move(&folio->lru, &clean);
+		if (!skip_retry && !folio_test_active(folio) && !folio_mapped(folio) &&
+		    !folio_test_dirty(folio) && !folio_test_writeback(folio)) {
+			list_move(&folio->lru, &clean);
+			continue;
+		}
+
+		/* don't add rejected folios to the oldest generation */
+		if (!lru_gen_distance(folio, false))
+			set_mask_bits(&folio->flags, LRU_REFS_FLAGS, BIT(PG_active));
 	}
 
 	spin_lock_irq(&lruvec->lru_lock);
diff --git a/mm/workingset.c b/mm/workingset.c
index 2c310c29f51e..3662c0def77a 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -239,7 +239,8 @@ static void *lru_gen_eviction(struct folio *folio)
 	int type = folio_is_file_lru(folio);
 	int delta = folio_nr_pages(folio);
 	int refs = folio_lru_refs(folio);
-	int tier = lru_tier_from_refs(refs);
+	bool workingset = folio_test_workingset(folio);
+	int tier = lru_tier_from_refs(refs, workingset);
 	struct mem_cgroup *memcg = folio_memcg(folio);
 	struct pglist_data *pgdat = folio_pgdat(folio);
 
@@ -253,7 +254,7 @@ static void *lru_gen_eviction(struct folio *folio)
 	hist = lru_hist_from_seq(min_seq);
 	atomic_long_add(delta, &lrugen->evicted[hist][type][tier]);
 
-	return pack_shadow(mem_cgroup_id(memcg), pgdat, token, refs);
+	return pack_shadow(mem_cgroup_id(memcg), pgdat, token, workingset);
 }
 
 /*
@@ -304,24 +305,20 @@ static void lru_gen_refault(struct folio *folio, void *shadow)
 	lrugen = &lruvec->lrugen;
 
 	hist = lru_hist_from_seq(READ_ONCE(lrugen->min_seq[type]));
-	/* see the comment in folio_lru_refs() */
-	refs = (token & (BIT(LRU_REFS_WIDTH) - 1)) + workingset;
-	tier = lru_tier_from_refs(refs);
+	refs = (token & (BIT(LRU_REFS_WIDTH) - 1)) + 1;
+	tier = lru_tier_from_refs(refs, workingset);
 
 	atomic_long_add(delta, &lrugen->refaulted[hist][type][tier]);
-	mod_lruvec_state(lruvec, WORKINGSET_ACTIVATE_BASE + type, delta);
 
-	/*
-	 * Count the following two cases as stalls:
-	 * 1. For pages accessed through page tables, hotter pages pushed out
-	 *    hot pages which refaulted immediately.
-	 * 2. For pages accessed multiple times through file descriptors,
-	 *    they would have been protected by sort_folio().
-	 */
-	if (lru_gen_in_fault() || refs >= BIT(LRU_REFS_WIDTH) - 1) {
-		set_mask_bits(&folio->flags, 0, LRU_REFS_MASK | BIT(PG_workingset));
+	/* see folio_add_lru() where folio_set_active() happens */
+	if (lru_gen_in_fault())
+		mod_lruvec_state(lruvec, WORKINGSET_ACTIVATE_BASE + type, delta);
+
+	if (workingset) {
+		folio_set_workingset(folio);
 		mod_lruvec_state(lruvec, WORKINGSET_RESTORE_BASE + type, delta);
-	}
+	} else
+		set_mask_bits(&folio->flags, LRU_REFS_MASK, (refs - 1UL) << LRU_REFS_PGOFF);
 unlock:
 	rcu_read_unlock();
 }
-- 
2.47.0.338.g60cca15819-goog


