Return-Path: <linux-kernel+bounces-291337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44316956106
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 04:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01464281499
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 02:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7403F288B5;
	Mon, 19 Aug 2024 02:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n8+ZbJkw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75C7208A4
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 02:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724033785; cv=none; b=pzoF9XyW6e9L5BzfXiOjW6G1zIL5nHI1tygMJZrTcbv2NOPk8qXVwSCeJ+nl8U+Dj5AHFzxE+Q9kXv1Nu/WMHEPSrLapnYiJ2QSNTfGE/HYY1q6tXpTxm7umCfVJoQRQl3PQaafFXjsLYUPRpq0zKDTtGmJH5T7thWl6eJfyVds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724033785; c=relaxed/simple;
	bh=i9i0GU1tqbl+gZG9rdF1xrCDy8bSikrdWFFB2p3UFUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n1xdH/L6xolWQ3SSwTI1BDno0ySVGJjPSuxWUzAXOE8qt3RW6lvHngDdTUN/L0fR3SxFkfxOMCgGV8U44GYzN+bu52CiNNfrVzy4OkG9DEYtEqRxkymj68P1snFk3AJFhE7ZvF0wVMtxBv1bZd27BR1gwoc336tBakV4I8nsfVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n8+ZbJkw; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724033784; x=1755569784;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i9i0GU1tqbl+gZG9rdF1xrCDy8bSikrdWFFB2p3UFUw=;
  b=n8+ZbJkwIVZqGnxMaQ1Ip5KPL4n4+9mrj2IEcSrOhsL6EfKGV/4eI68T
   Gg8m4A4j/2puc9F6V9kAiKtpoeT3C/DmeH0kBm9c/5NS5Ulsy0KqIh5rt
   VY0AL+it8/ihygE4JfOOBOWpOM/9zTZbC0MMxSsrRQf78NaZ+GT9xG1pD
   HFNllmOjlp3VIGFGfRRoosFwnjcaPkIO6YDK0ZsAZX6JyzRDmmARCdga2
   fGOHd/j0gRclDCd6RCXsxysYP/gYRX4XUiArYtKNudNcL12IWKmqTXHKL
   AIKeqkzh4Fzm2Un98XCpd3gqFhXHFdf7qfXcr01eQHIrCvssTyc3nhqRt
   g==;
X-CSE-ConnectionGUID: cRZ2sW0iTZK3P5Oq2KvhiA==
X-CSE-MsgGUID: J0WMNWvySDysrcSe2UAHcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="44782958"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="44782958"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 19:16:23 -0700
X-CSE-ConnectionGUID: wUHvjw1jTIGDkmypoq16Tw==
X-CSE-MsgGUID: R4qRuZDVT/aLemdFg0NPEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="64610270"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by fmviesa005.fm.intel.com with ESMTP; 18 Aug 2024 19:16:21 -0700
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
Subject: [PATCH v4 1/4] mm: zswap: zswap_is_folio_same_filled() takes an index in the folio.
Date: Sun, 18 Aug 2024 19:16:18 -0700
Message-Id: <20240819021621.29125-2-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240819021621.29125-1-kanchana.p.sridhar@intel.com>
References: <20240819021621.29125-1-kanchana.p.sridhar@intel.com>
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
index df66ab102d27..6434e76a4ea3 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1419,14 +1419,14 @@ static void shrink_worker(struct work_struct *w)
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
@@ -1496,7 +1496,7 @@ bool zswap_store(struct folio *folio)
 		goto reject;
 	}
 
-	if (zswap_is_folio_same_filled(folio, &value)) {
+	if (zswap_is_folio_same_filled(folio, 0, &value)) {
 		entry->length = 0;
 		entry->value = value;
 		atomic_inc(&zswap_same_filled_pages);
-- 
2.27.0


