Return-Path: <linux-kernel+bounces-336430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 718A6983AB6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 03:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BE2C28245F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB5D1B85E1;
	Tue, 24 Sep 2024 01:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DH+sUafW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D8615C0
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 01:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727140633; cv=none; b=NICjFwWS76nXXksVuDTGUfHsfjGIYC5WphEuae+AV7DXSrCxjIVX4CpvgQYEbztLVvpwFITay8FBtNLBo6gQGJlyD/fh8a4hnss2pTrXD8VRXkwV8G/EiHtyHr47On+OiYOMD9yPD8pDL0/29Zss7yIj0l7+oPSMMYJ48GwbExI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727140633; c=relaxed/simple;
	bh=pUUdV92IiG6zC8GNm5xDbVEXW5oShMyaugmREkMxm7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bufcfVTNO/yd/hPwsSBHgwgi9yTyPePic6yqGRYBgxlqFO56jZAtLmzYfxHzdPiQr+t4Z+b/91fP4lfOsp5VzKg6qKYS79b0rZ/FqTkMHjpch4ULkako0rGGZYfYnkC2rWIYO+0b5QqOyRox8mLT2FZgIA+lBeTXzJNreDMuSG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DH+sUafW; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727140632; x=1758676632;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pUUdV92IiG6zC8GNm5xDbVEXW5oShMyaugmREkMxm7k=;
  b=DH+sUafWH9CysPvlcT8N0UO2cMJSIwIvzM7DQ1gVA/2D1snM6oZBvp9g
   yZ0lDs2P0dlcVfPqIGCelfNi9TynkxAbvAxiNaMfZXwuXJ9LJKcBWuNTu
   ikEH6MCc+jcc6GtkkUSsrYcBSN4H2lxE5vrmSp+UR6PiZogDgSa77B3wA
   OtLB+JOoIfD9xpF8/5nl/cB2c4q58/6XG+xNkXkgWjxB/+d5J7zqsnvoT
   bYXW0FSKg1l2Rk49SynAq31dfN6/x559UjdQ07xvlCSnKcU+UnDrmsoyj
   ohBAoFMi9qKi1F32DScQlevABYyPfHOfbCBqzb+aXQTrrLcQmsRJhiw6E
   Q==;
X-CSE-ConnectionGUID: mxAZTHilTKibq7Nm/HTHLA==
X-CSE-MsgGUID: GhNIty5dR12G4DpB9cx5ZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="30002006"
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="30002006"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 18:17:10 -0700
X-CSE-ConnectionGUID: Ow60v4ymQFG6hfj4EMYAUA==
X-CSE-MsgGUID: HuTf+8mJT82ukI2RZ+87ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="108688447"
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
Subject: [PATCH v7 2/8] mm: zswap: Modify zswap_compress() to accept a page instead of a folio.
Date: Mon, 23 Sep 2024 18:17:03 -0700
Message-Id: <20240924011709.7037-3-kanchana.p.sridhar@intel.com>
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

For zswap_store() to be able to store an mTHP by compressing
it one page at a time, zswap_compress() needs to accept a page
as input. This will allow us to iterate through each page in
the mTHP in zswap_store(), compress it and store it in the zpool.

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 mm/zswap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 449914ea9919..59b7733a62d3 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -876,7 +876,7 @@ static int zswap_cpu_comp_dead(unsigned int cpu, struct hlist_node *node)
 	return 0;
 }
 
-static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
+static bool zswap_compress(struct page *page, struct zswap_entry *entry)
 {
 	struct crypto_acomp_ctx *acomp_ctx;
 	struct scatterlist input, output;
@@ -894,7 +894,7 @@ static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
 
 	dst = acomp_ctx->buffer;
 	sg_init_table(&input, 1);
-	sg_set_folio(&input, folio, PAGE_SIZE, 0);
+	sg_set_page(&input, page, PAGE_SIZE, 0);
 
 	/*
 	 * We need PAGE_SIZE * 2 here since there maybe over-compression case,
@@ -1458,7 +1458,7 @@ bool zswap_store(struct folio *folio)
 		mem_cgroup_put(memcg);
 	}
 
-	if (!zswap_compress(folio, entry))
+	if (!zswap_compress(&folio->page, entry))
 		goto put_pool;
 
 	entry->swpentry = swp;
-- 
2.27.0


