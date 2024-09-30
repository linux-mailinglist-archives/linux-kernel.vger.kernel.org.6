Return-Path: <linux-kernel+bounces-344912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 179DD98AFA8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 00:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26108B2105B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 22:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886E2188920;
	Mon, 30 Sep 2024 22:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QFl6WIrP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772F918858D
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 22:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727734347; cv=none; b=Iemqj0a3kWB46DOJTb8xmm+6u5gUQT/YOw6iWc8y+Tr+tWATmhwdk6HkNZAKtWRbaaEH8FZwZTO7QghJSUUQnnrRbnARQGA/eLHDXVsXPOkZqAqCjbhy5blV0CVu1oFju0VLhp7yVF960oeCamlBVYY/6qhfXY7I1LZsWW/ukmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727734347; c=relaxed/simple;
	bh=WnHMq8BNhME2EnXLEvjuvqDtcGOOpjFxIJHkgzLF8FI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DXL3f9dV7+fF927PH/iuExSJXCJdkVym224bVyvcsCP7BZT38S0K/JovQUpwn7rkreVaPNcsKDEPT1Xv8/659CG9AlotR/85E+Nvz/qB9H2W/H+zsfk/eFPmMqT4h1Ucis6UJVD9qc6U0ktyDyAHoqy8OkrkpbNFLLePdplAe+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QFl6WIrP; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727734346; x=1759270346;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WnHMq8BNhME2EnXLEvjuvqDtcGOOpjFxIJHkgzLF8FI=;
  b=QFl6WIrPSQ9zZ6IGCFXsnshwBS122gq7XnRPm6HGMYekgbEz3ydWBqhF
   sU2fkVdq7pAkJQE5DDmH4UFbNnCmpxZ2Kg+7E9IfP5gBnWAbFIe44i7Qu
   i4Umey9W1QAYZ7o+LksaD8cB/NudR/Fm6CjhFQ0Vv0lwMfwAc3TdYMD0A
   S7tjIbuJ1jW1YOC8v8wbd+GutUFCI0XG1Fe37QaT4o0v2g/SbNfaBo976
   FlgL10m6STi8eQSA1gJS9itmSS26ANLHP8VJCcn3/bsYk6XPz89u2l2L/
   VGYq5ikCbpeSBWl8uyARsVZyvZER27VkdRqR8r4WXdax+2BJhqzCVSQ4i
   g==;
X-CSE-ConnectionGUID: ha9Ti8ayTcGod9y1H/dtPg==
X-CSE-MsgGUID: tV5VxllhSLO8fTrw12bBAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="49368405"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="49368405"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 15:12:23 -0700
X-CSE-ConnectionGUID: fR3kETJWS8C5+ue4fQbuyQ==
X-CSE-MsgGUID: BlgiosatShO/iBvRb3rvGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="77985575"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by fmviesa004.fm.intel.com with ESMTP; 30 Sep 2024 15:12:22 -0700
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
	akpm@linux-foundation.org,
	willy@infradead.org
Cc: nanhai.zou@intel.com,
	wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v9 2/7] mm: zswap: Modify zswap_compress() to accept a page instead of a folio.
Date: Mon, 30 Sep 2024 15:12:16 -0700
Message-Id: <20240930221221.6981-3-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240930221221.6981-1-kanchana.p.sridhar@intel.com>
References: <20240930221221.6981-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For zswap_store() to be able to store a large folio by compressing it
one page at a time, zswap_compress() needs to accept a page as input.
This will allow us to iterate through each page in the folio in
zswap_store(), compress it and store it in the zpool.

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/zswap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index efad4e941e44..fd7a8c14457a 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -875,7 +875,7 @@ static int zswap_cpu_comp_dead(unsigned int cpu, struct hlist_node *node)
 	return 0;
 }
 
-static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
+static bool zswap_compress(struct page *page, struct zswap_entry *entry)
 {
 	struct crypto_acomp_ctx *acomp_ctx;
 	struct scatterlist input, output;
@@ -893,7 +893,7 @@ static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
 
 	dst = acomp_ctx->buffer;
 	sg_init_table(&input, 1);
-	sg_set_folio(&input, folio, PAGE_SIZE, 0);
+	sg_set_page(&input, page, PAGE_SIZE, 0);
 
 	/*
 	 * We need PAGE_SIZE * 2 here since there maybe over-compression case,
@@ -1456,7 +1456,7 @@ bool zswap_store(struct folio *folio)
 		mem_cgroup_put(memcg);
 	}
 
-	if (!zswap_compress(folio, entry))
+	if (!zswap_compress(&folio->page, entry))
 		goto put_pool;
 
 	entry->swpentry = swp;
-- 
2.27.0


