Return-Path: <linux-kernel+bounces-268633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEE9942725
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C149F1C228AC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 06:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7791A6184;
	Wed, 31 Jul 2024 06:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGUYTfmR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10421A4B5B
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 06:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722408563; cv=none; b=GlX5fMhxhoBePPzglvFPcdO9WfjKsJN+L0urGgPDB2PB6yqmiBiS09QQn7xOVyuNAj1SPiamx8HLcdNZvU0gtFzFb8e/vtSpyxhB80WmcQtI4/1XEZVa5yDNwlDCVnfDQ3Pnww1IThNyS3BNFJBOPbsyminilitPSF5CBgCQzaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722408563; c=relaxed/simple;
	bh=LjLGrYfGSpypFUL96oAD4RmEiSL9/y3TWaJKb5zfZhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GPNTmJkVxKDCGMgQbEzWA9ClFcp0YdcQVdzxPhsv64Yc6zMvEecIwU4W262jfbWQzcMoejXysG3B1R2OLH/K/A7iQbgg/TK+DefUK3l3wlH5TB0jpvDYLCFTdY5aoxvEC0QHT/OOJioucSoynxArlFFXdfqt4n0iWo3/XZtZ5s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGUYTfmR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C268BC4AF0C;
	Wed, 31 Jul 2024 06:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722408563;
	bh=LjLGrYfGSpypFUL96oAD4RmEiSL9/y3TWaJKb5zfZhE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aGUYTfmR5q32Z0zxb2/wyFW/QbQQ23Efur5PxJUzlVbMYXuYs7ALfTF8G7eFkWuVh
	 mP+TkWiOMDDNrTjs0WIymVBPV06bIR//zu6ftunKi2VIBQCsRK7KW/ZGIO3+ElQwno
	 hy8nsdhEIjtvbtAE395ivBfkcpZT7U2ZkyhmGNiJGk646FEHJQ8MTyCkEGrRgqO312
	 u3FHrbZ07kBi64GsA+XVa5tnntHpByXK2Vi0uQi50pBcBxBrYw2+FUPXJp6WlknpuW
	 jlbh/caZLD20sJEFqJtxop265nlELUYfZWBrLb3vQbOR3ZVsK/VaL/jAdlS9mm8d0R
	 Li4TyrhURQ42A==
From: chrisl@kernel.org
Date: Tue, 30 Jul 2024 23:49:17 -0700
Subject: [PATCH v5 5/9] mm: swap: skip slot cache on freeing for mTHP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240730-swap-allocator-v5-5-cb9c148b9297@kernel.org>
References: <20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org>
In-Reply-To: <20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kairui Song <kasong@tencent.com>, Hugh Dickins <hughd@google.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>, 
 Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Chris Li <chrisl@kernel.org>, 
 Barry Song <baohua@kernel.org>
X-Mailer: b4 0.13.0

From: Kairui Song <kasong@tencent.com>

Currently when we are freeing mTHP folios from swap cache, we free
then one by one and put each entry into swap slot cache. Slot
cache is designed to reduce the overhead by batching the freeing,
but mTHP swap entries are already continuous so they can be batch
freed without it already, it saves litle overhead, or even increase
overhead for larger mTHP.

What's more, mTHP entries could stay in swap cache for a while.
Contiguous swap entry is an rather rare resource so releasing them
directly can help improve mTHP allocation success rate when under
pressure.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swapfile.c | 59 ++++++++++++++++++++++++++---------------------------------
 1 file changed, 26 insertions(+), 33 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 34e6ea13e8e4..9b63b2262cc2 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -479,20 +479,21 @@ static void inc_cluster_info_page(struct swap_info_struct *p,
 }
 
 /*
- * The cluster ci decreases one usage. If the usage counter becomes 0,
+ * The cluster ci decreases @nr_pages usage. If the usage counter becomes 0,
  * which means no page in the cluster is in use, we can optionally discard
  * the cluster and add it to free cluster list.
  */
-static void dec_cluster_info_page(struct swap_info_struct *p, struct swap_cluster_info *ci)
+static void dec_cluster_info_page(struct swap_info_struct *p,
+				  struct swap_cluster_info *ci, int nr_pages)
 {
 	if (!p->cluster_info)
 		return;
 
-	VM_BUG_ON(ci->count == 0);
+	VM_BUG_ON(ci->count < nr_pages);
 	VM_BUG_ON(cluster_is_free(ci));
 	lockdep_assert_held(&p->lock);
 	lockdep_assert_held(&ci->lock);
-	ci->count--;
+	ci->count -= nr_pages;
 
 	if (!ci->count) {
 		free_cluster(p, ci);
@@ -998,19 +999,6 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 	return n_ret;
 }
 
-static void swap_free_cluster(struct swap_info_struct *si, unsigned long idx)
-{
-	unsigned long offset = idx * SWAPFILE_CLUSTER;
-	struct swap_cluster_info *ci;
-
-	ci = lock_cluster(si, offset);
-	memset(si->swap_map + offset, 0, SWAPFILE_CLUSTER);
-	ci->count = 0;
-	free_cluster(si, ci);
-	unlock_cluster(ci);
-	swap_range_free(si, offset, SWAPFILE_CLUSTER);
-}
-
 int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
 {
 	int order = swap_entry_order(entry_order);
@@ -1269,21 +1257,28 @@ static unsigned char __swap_entry_free(struct swap_info_struct *p,
 	return usage;
 }
 
-static void swap_entry_free(struct swap_info_struct *p, swp_entry_t entry)
+/*
+ * Drop the last HAS_CACHE flag of swap entries, caller have to
+ * ensure all entries belong to the same cgroup.
+ */
+static void swap_entry_range_free(struct swap_info_struct *p, swp_entry_t entry,
+				  unsigned int nr_pages)
 {
-	struct swap_cluster_info *ci;
 	unsigned long offset = swp_offset(entry);
-	unsigned char count;
+	unsigned char *map = p->swap_map + offset;
+	unsigned char *map_end = map + nr_pages;
+	struct swap_cluster_info *ci;
 
 	ci = lock_cluster(p, offset);
-	count = p->swap_map[offset];
-	VM_BUG_ON(count != SWAP_HAS_CACHE);
-	p->swap_map[offset] = 0;
-	dec_cluster_info_page(p, ci);
+	do {
+		VM_BUG_ON(*map != SWAP_HAS_CACHE);
+		*map = 0;
+	} while (++map < map_end);
+	dec_cluster_info_page(p, ci, nr_pages);
 	unlock_cluster(ci);
 
-	mem_cgroup_uncharge_swap(entry, 1);
-	swap_range_free(p, offset, 1);
+	mem_cgroup_uncharge_swap(entry, nr_pages);
+	swap_range_free(p, offset, nr_pages);
 }
 
 static void cluster_swap_free_nr(struct swap_info_struct *sis,
@@ -1343,7 +1338,6 @@ void swap_free_nr(swp_entry_t entry, int nr_pages)
 void put_swap_folio(struct folio *folio, swp_entry_t entry)
 {
 	unsigned long offset = swp_offset(entry);
-	unsigned long idx = offset / SWAPFILE_CLUSTER;
 	struct swap_cluster_info *ci;
 	struct swap_info_struct *si;
 	unsigned char *map;
@@ -1356,19 +1350,18 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry)
 		return;
 
 	ci = lock_cluster_or_swap_info(si, offset);
-	if (size == SWAPFILE_CLUSTER) {
+	if (size > 1) {
 		map = si->swap_map + offset;
-		for (i = 0; i < SWAPFILE_CLUSTER; i++) {
+		for (i = 0; i < size; i++) {
 			val = map[i];
 			VM_BUG_ON(!(val & SWAP_HAS_CACHE));
 			if (val == SWAP_HAS_CACHE)
 				free_entries++;
 		}
-		if (free_entries == SWAPFILE_CLUSTER) {
+		if (free_entries == size) {
 			unlock_cluster_or_swap_info(si, ci);
 			spin_lock(&si->lock);
-			mem_cgroup_uncharge_swap(entry, SWAPFILE_CLUSTER);
-			swap_free_cluster(si, idx);
+			swap_entry_range_free(si, entry, size);
 			spin_unlock(&si->lock);
 			return;
 		}
@@ -1413,7 +1406,7 @@ void swapcache_free_entries(swp_entry_t *entries, int n)
 	for (i = 0; i < n; ++i) {
 		p = swap_info_get_cont(entries[i], prev);
 		if (p)
-			swap_entry_free(p, entries[i]);
+			swap_entry_range_free(p, entries[i], 1);
 		prev = p;
 	}
 	if (p)

-- 
2.46.0.rc1.232.g9752f9e123-goog


