Return-Path: <linux-kernel+bounces-336434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C22983ABA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 03:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 438891F2237E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186CAE55B;
	Tue, 24 Sep 2024 01:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PgF32FDr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79FD4C92
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 01:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727140636; cv=none; b=MPzsWCPhPEIjPwtaXPEOVBZ5f47vsbnNzDPyE9+1k8oo9nUkfgkyjHqbSNQn0r0wbHfpmMSinOaggzhzNdZK8YPr7hJPqb65QtwaAHBP36MNspaiVSZ2AYb5LIBnu9dXxpO0bA1rbojpV4n5pijJ0epD5EvrZi7nPci62GhI+Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727140636; c=relaxed/simple;
	bh=C86so49XKpWlsyU2wpioV+UDdpE1jz5mE0FAlDLAhFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l17OQwm1wGcvdtNUbTa11BN5E5TMAdseALzJXrzTTCScE75ZDOCz7SEO1jcz7bYQmd/Ewdobu92seggWcREm5rWuSdXwwxS/7IN+SDTAZXy5BcBueuqoocF6k20EX/jgwVfgzuvSwEmi3ImsAlBqeq3dJ8fxMI+RUOac4L6yfHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PgF32FDr; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727140634; x=1758676634;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C86so49XKpWlsyU2wpioV+UDdpE1jz5mE0FAlDLAhFE=;
  b=PgF32FDr0FJfHmTcIVOwoLtCxm0oUTa1cvNk8ZJ/Zsin5Z9mz0XuvGdj
   qanr/oe7vAkU6ZjA+iz/qCvyWRi4T0iTjILHDz0nAl9PKNO9s4aboEY5w
   p4TZFKuxSoOroOa9zWcdznZkJ6ZirQMM0/qKUb22xg+vxFl8U4ua63L2Z
   OKfbPp1Zn5v1Iv0XAiPLeSGPsAzWnaFU4QNdrOB4ryLaN7c3jBRbT3Ai1
   xnPp8IEP7ZL1HHxFXDuLoIhVu+jXchKk8mV58rVVFwFPtBQ7/oR9+JJgq
   AKptFKr13KrfyoJlhixl7c62Acy9pw4gS4liGD5xai6b+Uta4PoA9PuqF
   w==;
X-CSE-ConnectionGUID: OfNFwrFDRdWdsEmk6NjnQQ==
X-CSE-MsgGUID: IRHQzJT/Q6yS31ZVE10WuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="30002021"
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="30002021"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 18:17:11 -0700
X-CSE-ConnectionGUID: sEGsfpQ9TySxYR5zKcbTVw==
X-CSE-MsgGUID: jSs+zcAeQrCa4Hib2fFedw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="108688454"
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
Subject: [PATCH v7 4/8] mm: zswap: Refactor code to delete stored offsets in case of errors.
Date: Mon, 23 Sep 2024 18:17:05 -0700
Message-Id: <20240924011709.7037-5-kanchana.p.sridhar@intel.com>
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

Added a new procedure zswap_delete_stored_offsets() that can be
called to delete stored offsets in a folio in case zswap_store()
fails or zswap is disabled.

Refactored the code in zswap_store() that handles these cases,
to call zswap_delete_stored_offsets().

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 mm/zswap.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index fd35a81b6e36..9bea948d653e 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1435,8 +1435,37 @@ static bool zswap_store_entry(struct xarray *tree,
 	return true;
 }
 
+/*
+ * If the zswap store fails or zswap is disabled, we must invalidate the
+ * possibly stale entries which were previously stored at the offsets
+ * corresponding to each page of the folio. Otherwise, writeback could
+ * overwrite the new data in the swapfile.
+ *
+ * This is called after the store of an offset in a large folio has failed.
+ * All zswap entries in the folio must be deleted. This helps make sure
+ * that a swapped-out mTHP is either entirely stored in zswap, or entirely
+ * not stored in zswap.
+ *
+ * This is also called if zswap_store() is invoked, but zswap is not enabled.
+ * All offsets for the folio are deleted from zswap in this case.
+ */
+static void zswap_delete_stored_offsets(struct xarray *tree,
+					pgoff_t offset,
+					long nr_pages)
+{
+	struct zswap_entry *entry;
+	long i;
+
+	for (i = 0; i < nr_pages; ++i) {
+		entry = xa_erase(tree, offset + i);
+		if (entry)
+			zswap_entry_free(entry);
+	}
+}
+
 bool zswap_store(struct folio *folio)
 {
+	long nr_pages = folio_nr_pages(folio);
 	swp_entry_t swp = folio->swap;
 	pgoff_t offset = swp_offset(swp);
 	struct xarray *tree = swap_zswap_tree(swp);
@@ -1541,9 +1570,7 @@ bool zswap_store(struct folio *folio)
 	 * possibly stale entry which was previously stored at this offset.
 	 * Otherwise, writeback could overwrite the new data in the swapfile.
 	 */
-	entry = xa_erase(tree, offset);
-	if (entry)
-		zswap_entry_free(entry);
+	zswap_delete_stored_offsets(tree, offset, nr_pages);
 	return false;
 }
 
-- 
2.27.0


