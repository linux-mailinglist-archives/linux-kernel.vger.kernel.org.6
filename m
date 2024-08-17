Return-Path: <linux-kernel+bounces-290540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C44695557C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 07:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80D461C21E37
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 05:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F0C8563E;
	Sat, 17 Aug 2024 05:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kkWDkZXa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5DE6E619
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 05:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723871371; cv=none; b=iyn5mr9wVc2zBMNiXyqT1q2g0aSkXZ0HJmhCRJj/4H/Gf0gv3AiwB5/blyVLUqZAeJK1eiWsUh3wjryk+Lyujt64Bo8VrYrs7aevtMa8OYaIL3Tc35P9yhOUGLu6UBMrNPMabg8nhgwE3W6kT6bXYeWZzUgniASreaXH04Uh3D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723871371; c=relaxed/simple;
	bh=8aJTLnzMPmjHtUmt/CSvhY9AKnZREM8rFjycd3MYym0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aNtltd8FJ8L7qztKhzp7sCUm8mtDKW7sssrOnC2i+l2ds7kfYXVw4cvaRl3VPWxPjPyNnwbhEzpXmPlypLtwV8/Lr+c/t9ohZz8FJ4C5NAB4mftkJ7Kymon0mmRznxtU06I7SRP6ntgFOMkIP0YxD+/Bi9j4CV8veCReDe5YmVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kkWDkZXa; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723871369; x=1755407369;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8aJTLnzMPmjHtUmt/CSvhY9AKnZREM8rFjycd3MYym0=;
  b=kkWDkZXaJR9rEdru248RrG6sydONdnS8MDygDqzBDTIuy6Jr0BPTE0JD
   ZzIH2lricC4gSOKoynWnuqwkrOoSg0TgvEu/7xRO6pxgpPynSSzlx6bL4
   ovPp/MGahq9ojszEpKvJ95H3wS3gwA6VHp1J5tPZHN5XjN1W2eR43+OvY
   eb3xVyrYSgCBD4ZJSkEqVzNaX81Pyajm2m6j6kl6ivtO2BXsfuQ7nrHrY
   SZMrw+yiSleTT/1fx3CXu+yLo3xMoDDb8yWIOZoPzdbrDjD9Mlai7Ga3T
   XHkVNmu7rQyb/SiPNZ/ooxRmeVobMXaiEKzjlwuAxOjnZSAC/Ve3j3QiL
   w==;
X-CSE-ConnectionGUID: 0jKjyGBTQA2e/pVDLn8Q8w==
X-CSE-MsgGUID: IFwNiohNRyeHsXL+IYGIrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="25929463"
X-IronPort-AV: E=Sophos;i="6.10,154,1719903600"; 
   d="scan'208";a="25929463"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 22:09:21 -0700
X-CSE-ConnectionGUID: SVdXdoIIRwOh7Pc03Kd8zg==
X-CSE-MsgGUID: Uu+OYl+RRTiJZwt1cW3OLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,154,1719903600"; 
   d="scan'208";a="60141492"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by orviesa006.jf.intel.com with ESMTP; 16 Aug 2024 22:09:21 -0700
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org
Cc: nanhai.zou@intel.com,
	wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v3 1/4] mm: zswap: zswap_is_folio_same_filled() takes an index in the folio.
Date: Fri, 16 Aug 2024 22:09:18 -0700
Message-Id: <20240817050921.18462-2-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240817050921.18462-1-kanchana.p.sridhar@intel.com>
References: <20240817050921.18462-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change is being made so that zswap_store can process mTHP folios.

Modified zswap_is_folio_same_filled() to work for any-order folios,
by accepting an additional "index" parameter to arrive at the
page within the folio to run the same-filled page check.

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 mm/zswap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index adeaf9c97fde..6c5c656ec282 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1358,14 +1358,14 @@ static void shrink_worker(struct work_struct *w)
 /*********************************
 * same-filled functions
 **********************************/
-static bool zswap_is_folio_same_filled(struct folio *folio, unsigned long *value)
+static bool zswap_is_folio_same_filled(struct folio *folio, long index, unsigned long *value)
 {
 	unsigned long *data;
 	unsigned long val;
 	unsigned int pos, last_pos = PAGE_SIZE / sizeof(*data) - 1;
 	bool ret = false;
 
-	data = kmap_local_folio(folio, 0);
+	data = kmap_local_folio(folio, index * PAGE_SIZE);
 	val = data[0];
 
 	if (val != data[last_pos])
@@ -1435,7 +1435,7 @@ bool zswap_store(struct folio *folio)
 		goto reject;
 	}
 
-	if (zswap_is_folio_same_filled(folio, &value)) {
+	if (zswap_is_folio_same_filled(folio, 0, &value)) {
 		entry->length = 0;
 		entry->value = value;
 		atomic_inc(&zswap_same_filled_pages);
-- 
2.27.0


