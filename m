Return-Path: <linux-kernel+bounces-336433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A98CE983AB9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 03:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC2851C21B85
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF93DDC1;
	Tue, 24 Sep 2024 01:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EwRYuZ7L"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C0D1B85DA
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 01:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727140636; cv=none; b=FgwIxZwJO8ZOLVFQG3DqVyK1UusDnelUN7Gvl+pIecjEm+HvcEXQJYFBdK0jOZoDTSR+eeBv9zkSd5/UX9OzdzWeK/gO57lMo84hG/qPkPjpB6QISqzYv7LdLXmTn7lfriqSMPEPy9ujrmyFDK32d909K4WqZOsGQWg+90MaELY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727140636; c=relaxed/simple;
	bh=RHgitxCwk2O92AmxepTIkYLlPlxcPNy3AMLz8p6gNWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dRQZbnlbcHkuq9h9jTwuy+p+FeykM4JyslJGetLcvvTckKUFf5ARTWafIvyLNv4O5xnKBeGSL83j2wfv8Yp4BGSvFxgZSMzuZbHqWr4B83HbYE9E0zp4ZTUoEvPaev2uGjAc8f6jOoUNKwY7xto9/mF/vxbmuZigmzdvAi+GPss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EwRYuZ7L; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727140634; x=1758676634;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RHgitxCwk2O92AmxepTIkYLlPlxcPNy3AMLz8p6gNWk=;
  b=EwRYuZ7LSiKPpD0zQBy/fHApoRfncwr3prrlZJYv5yEfgMfaO9yjX/ua
   urwiMO4VQDHA8tKrf3BYB8Z9kuAFrvtyT3k1G+Kn1sRjMJafHWlkHBrCT
   Eyg7fnFHpIDevacTciWM/i1UQmc24/sd9f4qHh1YmZiEgf9GE7ThJ1F7R
   1ocHYzX8xRLCW7C/DP39iRqZB/yJUDV4y//M+5qAliD8w1hJfSjAWRwQv
   DgKIH/+cT8Ujkfu2/4sobwGT15p4N9HFbCaYfVJbNzNXY9+lPJJdcfred
   MHfgR2FBQTuwhau8DT9PNSC3QHfD/ZM0TP2bbIExp5Fegi8RfO+k5E0wq
   g==;
X-CSE-ConnectionGUID: C3d2sTaySme0YMDci4tuxw==
X-CSE-MsgGUID: +gwGu9dBR4uvw72NRwhLZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="30002014"
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="30002014"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 18:17:10 -0700
X-CSE-ConnectionGUID: l8/bok0JQDenH8syzM42bQ==
X-CSE-MsgGUID: 3+hniOHXQ32cgOpTEREr0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="108688451"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by orviesa001.jf.intel.com with ESMTP; 23 Sep 2024 18:17:10 -0700
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	shakeel.butt@linux.dev,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org
Cc: nanhai.zou@intel.com,
	wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v7 3/8] mm: zswap: Refactor code to store an entry in zswap xarray.
Date: Mon, 23 Sep 2024 18:17:04 -0700
Message-Id: <20240924011709.7037-4-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added a new procedure zswap_store_entry() that refactors the code
currently in zswap_store() to store an entry in the zswap xarray.
This will allow us to call this procedure for each storing the swap
offset of each page in an mTHP in the xarray, as part of zswap_store()
supporting mTHP.

Also, made a minor edit in the comments for 'struct zswap_entry' to delete
the description of the 'value' member that was deleted in commit
20a5532ffa53d6ecf41ded920a7b0ff9c65a7dcf ("mm: remove code to handle
same filled pages").

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 mm/zswap.c | 51 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 59b7733a62d3..fd35a81b6e36 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -190,7 +190,6 @@ static struct shrinker *zswap_shrinker;
  *              section for context.
  * pool - the zswap_pool the entry's data is in
  * handle - zpool allocation handle that stores the compressed page data
- * value - value of the same-value filled pages which have same content
  * objcg - the obj_cgroup that the compressed memory is charged to
  * lru - handle to the pool's lru used to evict pages.
  */
@@ -1404,12 +1403,44 @@ static void shrink_worker(struct work_struct *w)
 /*********************************
 * main API
 **********************************/
+
+/*
+ * Returns true if the entry was successfully
+ * stored in the xarray, and false otherwise.
+ */
+static bool zswap_store_entry(struct xarray *tree,
+			      struct zswap_entry *entry)
+{
+	struct zswap_entry *old;
+	pgoff_t offset = swp_offset(entry->swpentry);
+
+	old = xa_store(tree, offset, entry, GFP_KERNEL);
+
+	if (xa_is_err(old)) {
+		int err = xa_err(old);
+
+		WARN_ONCE(err != -ENOMEM, "unexpected xarray error: %d\n", err);
+		zswap_reject_alloc_fail++;
+		return false;
+	}
+
+	/*
+	 * We may have had an existing entry that became stale when
+	 * the folio was redirtied and now the new version is being
+	 * swapped out. Get rid of the old.
+	 */
+	if (old)
+		zswap_entry_free(old);
+
+	return true;
+}
+
 bool zswap_store(struct folio *folio)
 {
 	swp_entry_t swp = folio->swap;
 	pgoff_t offset = swp_offset(swp);
 	struct xarray *tree = swap_zswap_tree(swp);
-	struct zswap_entry *entry, *old;
+	struct zswap_entry *entry;
 	struct obj_cgroup *objcg = NULL;
 	struct mem_cgroup *memcg = NULL;
 
@@ -1465,22 +1496,8 @@ bool zswap_store(struct folio *folio)
 	entry->objcg = objcg;
 	entry->referenced = true;
 
-	old = xa_store(tree, offset, entry, GFP_KERNEL);
-	if (xa_is_err(old)) {
-		int err = xa_err(old);
-
-		WARN_ONCE(err != -ENOMEM, "unexpected xarray error: %d\n", err);
-		zswap_reject_alloc_fail++;
+	if (!zswap_store_entry(tree, entry))
 		goto store_failed;
-	}
-
-	/*
-	 * We may have had an existing entry that became stale when
-	 * the folio was redirtied and now the new version is being
-	 * swapped out. Get rid of the old.
-	 */
-	if (old)
-		zswap_entry_free(old);
 
 	if (objcg) {
 		obj_cgroup_charge_zswap(objcg, entry->length);
-- 
2.27.0


