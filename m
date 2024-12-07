Return-Path: <linux-kernel+bounces-436209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1349E8277
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 23:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D348D162BC6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 22:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7F61922F6;
	Sat,  7 Dec 2024 22:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yo2kpgi2"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74AB198A37
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 22:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733609745; cv=none; b=P3zzp8Q5dUng9MmH6l1z0H7XTfBvTCLvFLJ3iXq4pW77RkIl2eMnPHBISZnuxMaPZllEKU1QR+1H8eNVRNlg0QLXJhDv86aRUTT5A9KycXenKejF0mSQmQnIcZMik6BehSPCad/GnDmk6s0Opy6/K3gZS1aeXyTCMfSzHlP4eBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733609745; c=relaxed/simple;
	bh=q8O0gHs4jCVMQKbWOMIqPjolVQWpQ3HTNz6X2eFWrqw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yzw+pyR7KCBIPpGP06I0K0bllcdcsRyLMoUE73uCxKEZ47XpMDRLCfYyuEv4Hd9K7GDsJ9FMLyBF7QAT2UxDcfJgof6xaxLmCvMotLlrYexqPD/LjovSmtnaKc/hBVYfQqJEPGhZ4v6bCAbYZHlaH63MTCAdehaMvIsygJ+3pk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yo2kpgi2; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ee5668e09bso3430304a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 14:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733609742; x=1734214542; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zdSP+7bjwkvzpRB2PSh99IE+m8RuCZsNUL2DdE4uQBQ=;
        b=yo2kpgi2yj/33rFqO3Poj35AtpBhuVAEmn0C5DPpz+XB2uP9M5qhChtMKWeyEx2s60
         iJ5IIe2GIBXfQ0G4lQv/+95cB7ujxvGBRKScxk/FyzPCSFxGh0MXpNOZcLLaYCdSCzj6
         XZVKrUfg4+P41TRhcol8FJjruCnIRMzitQVz2NCnqZHGlhHcgSPo91jNL+Z/kG6G5tEz
         zV0pQnifhrwDPwXgxv/v2Y9dzVy0rIeZHC2jhL3ipHol/Owe41QG81aWg7D6uPSmalYF
         XMse4ROVu00sYPxkF9pKs7WVDwwnYk4qWFpycfD0nYcc2prw/r9ZRg8Ds9htPne9VlFY
         R2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733609742; x=1734214542;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zdSP+7bjwkvzpRB2PSh99IE+m8RuCZsNUL2DdE4uQBQ=;
        b=P3hVTGG9A6TLAwyqADNsb/esv1q3bkq0NDHOHq+TuvduWix7eDiwOYKSIAv7CLYyIo
         mVrksHNneLwO/Rj/OWmPIlSX4cUCRMh8PPrDEGYC/A060CunAa1+fDje5vuwhsjiH4Hz
         xLaQaGgxTz1POeYUlyj0hxxveMhQNRdlSPYiw4m42UWskCF2GI6ZdcEV/I/t+ZsfnKGs
         q/U1i4hzSFyzicfftP6v5bQ458uq9cOqaaQOSA8iSx0UEai1uAB1geJWnLTdjYnJBNfi
         ENQPa+XJW3v4acjLKAM/BkEsESE609lRZA2b7GvxbWki//gENSHfbiZfUK/5ffURrKys
         vt3A==
X-Forwarded-Encrypted: i=1; AJvYcCXuw6jPY25tym0vrDroMhjv2jr8O45qmgN1eqvqKPPswpMh569DAxbULE8aGhULe1BzT+FnpLc26cI1ZPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzoil/PB+vWkM23vczakOQVhCWbgvWhkZttM5it2HoFAQA4pByB
	LFSYDrPecNN4LDTzpSKrFQtjFgMB5fR6iphobyETtJix40nbh1JEaHtL3Ip2va0oT3rzYVVDXqd
	ruA==
X-Google-Smtp-Source: AGHT+IERU9qwPmX8l6nSHeE+rRW5qB+apC/LbFjVMpXOGf/YBbeh8mwrqP/BiewL8r/X9v+x5VJGbczUnJc=
X-Received: from pjbnr18.prod.google.com ([2002:a17:90b:2412:b0:2ef:6d06:31e4])
 (user=yuzhao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2b47:b0:2ee:dd79:e03c
 with SMTP id 98e67ed59e1d1-2ef6a6baf62mr12546047a91.20.1733609742190; Sat, 07
 Dec 2024 14:15:42 -0800 (PST)
Date: Sat,  7 Dec 2024 15:15:22 -0700
In-Reply-To: <20241207221522.2250311-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241207221522.2250311-1-yuzhao@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241207221522.2250311-7-yuzhao@google.com>
Subject: [PATCH mm-unstable v3 6/6] mm/mglru: rework workingset protection
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
 include/linux/mm_inline.h |  94 ++++++++++++------------
 include/linux/mmzone.h    |  82 +++++++++++++--------
 mm/swap.c                 |  23 +++---
 mm/vmscan.c               | 145 ++++++++++++++++++++++----------------
 mm/workingset.c           |  29 ++++----
 5 files changed, 208 insertions(+), 165 deletions(-)

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
index 756b6c5b9af7..062c8565b899 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -387,24 +387,19 @@ static void lru_gen_inc_refs(struct folio *folio)
 	if (!folio_test_lru(folio) || folio_test_unevictable(folio))
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
 
@@ -416,7 +411,7 @@ static bool lru_gen_clear_refs(struct folio *folio)
 	if (!folio_test_lru(folio) || folio_test_unevictable(folio))
 		return true;
 
-	set_mask_bits(&folio->flags, LRU_REFS_MASK | LRU_REFS_FLAGS, 0);
+	set_mask_bits(&folio->flags, LRU_REFS_FLAGS | BIT(PG_workingset), 0);
 
 	lrugen = &folio_lruvec(folio)->lrugen;
 	/* whether can do without shuffling under the LRU lock */
@@ -498,7 +493,7 @@ void folio_add_lru(struct folio *folio)
 			folio_test_unevictable(folio), folio);
 	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
 
-	/* see the comment in lru_gen_add_folio() */
+	/* see the comment in lru_gen_distance() */
 	if (lru_gen_enabled() && !folio_test_unevictable(folio) &&
 	    lru_gen_in_fault() && !(current->flags & PF_MEMALLOC))
 		folio_set_active(folio);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 02b01ae2bdbb..5e03a61c894f 100644
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
@@ -888,6 +912,15 @@ static enum folio_references folio_check_references(struct folio *folio,
 	if (referenced_ptes == -1)
 		return FOLIOREF_KEEP;
 
+	if (lru_gen_enabled()) {
+		if (!referenced_ptes)
+			return FOLIOREF_RECLAIM;
+
+		return lru_gen_set_refs(folio) ? FOLIOREF_ACTIVATE : FOLIOREF_KEEP;
+	}
+
+	referenced_folio = folio_test_clear_referenced(folio);
+
 	if (referenced_ptes) {
 		/*
 		 * All mapped folios start out with page table
@@ -1092,11 +1125,6 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
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
@@ -3163,16 +3191,19 @@ static int folio_update_gen(struct folio *folio, int gen)
 
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
@@ -3196,7 +3227,7 @@ static int folio_inc_gen(struct lruvec *lruvec, struct folio *folio, bool reclai
 
 		new_gen = (old_gen + 1) % MAX_NR_GENS;
 
-		new_flags = old_flags & ~(LRU_GEN_MASK | LRU_REFS_MASK | LRU_REFS_FLAGS);
+		new_flags = old_flags & ~(LRU_GEN_MASK | LRU_REFS_FLAGS);
 		new_flags |= (new_gen + 1UL) << LRU_GEN_PGOFF;
 		/* for folio_end_writeback() */
 		if (reclaiming)
@@ -3374,9 +3405,11 @@ static unsigned long get_pmd_pfn(pmd_t pmd, struct vm_area_struct *vma, unsigned
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
 
@@ -3753,8 +3786,7 @@ static bool inc_min_seq(struct lruvec *lruvec, int type, int swappiness)
 		while (!list_empty(head)) {
 			struct folio *folio = lru_to_folio(head);
 			int refs = folio_lru_refs(folio);
-			int tier = lru_tier_from_refs(refs);
-			int delta = folio_nr_pages(folio);
+			bool workingset = folio_test_workingset(folio);
 
 			VM_WARN_ON_ONCE_FOLIO(folio_test_unevictable(folio), folio);
 			VM_WARN_ON_ONCE_FOLIO(folio_test_active(folio), folio);
@@ -3764,8 +3796,14 @@ static bool inc_min_seq(struct lruvec *lruvec, int type, int swappiness)
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
@@ -4134,16 +4172,10 @@ bool lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 			old_gen = folio_update_gen(folio, new_gen);
 			if (old_gen >= 0 && old_gen != new_gen)
 				update_batch_size(walk, folio, old_gen, new_gen);
-
-			continue;
-		}
-
-		old_gen = folio_lru_gen(folio);
-		if (old_gen < 0)
-			folio_set_referenced(folio);
-		else if (old_gen != new_gen) {
-			folio_clear_lru_refs(folio);
-			folio_activate(folio);
+		} else if (lru_gen_set_refs(folio)) {
+			old_gen = folio_lru_gen(folio);
+			if (old_gen >= 0 && old_gen != new_gen)
+				folio_activate(folio);
 		}
 	}
 
@@ -4304,7 +4336,8 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 	int zone = folio_zonenum(folio);
 	int delta = folio_nr_pages(folio);
 	int refs = folio_lru_refs(folio);
-	int tier = lru_tier_from_refs(refs);
+	bool workingset = folio_test_workingset(folio);
+	int tier = lru_tier_from_refs(refs, workingset);
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 
 	VM_WARN_ON_ONCE_FOLIO(gen >= MAX_NR_GENS, folio);
@@ -4326,14 +4359,17 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
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
 
@@ -4353,8 +4389,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 	}
 
 	/* waiting for writeback */
-	if (folio_test_locked(folio) || writeback ||
-	    (type == LRU_GEN_FILE && dirty)) {
+	if (writeback || (type == LRU_GEN_FILE && dirty)) {
 		gen = folio_inc_gen(lruvec, folio, true);
 		list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
 		return true;
@@ -4383,13 +4418,12 @@ static bool isolate_folio(struct lruvec *lruvec, struct folio *folio, struct sca
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
@@ -4585,25 +4619,16 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
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


