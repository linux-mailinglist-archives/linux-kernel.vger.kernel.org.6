Return-Path: <linux-kernel+bounces-342315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C6C988D85
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 04:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB5CEB2154A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 02:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB9E5473C;
	Sat, 28 Sep 2024 02:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YH2cKeBL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2936023774
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 02:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727489788; cv=none; b=kN/5DzL6bpvVZR/k58RMNGI7/Q5zjLN7ychCTAzP2D/x/TUeneURvOTHa3tamNlZbd3Rn4cImgij+8Beek3M2aH+fVM2eJ/SkQp0v0hIEUvqC1NVpbFJZVClLoZ83nG92GVO+wEAmzzdVJFFyz3Ld5dOENJnQwXrqrUTGtxqDqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727489788; c=relaxed/simple;
	bh=KQeyC+P/mFswkiAsqAghN2A7u1uS+p3jOQ5BMPTPZHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N3DkZ9srMzuZ17DeuHe6xcVoDw9+2V9st4NnYQ+E0kplnMnWx/MUMFgojGewhM+gOTNfdOliOY8TjeEmCAiVkbVGS1jDkOtMlqCkst/veVIim8Leq0cPUYUjVTbEw/5O7kL2+CDo1XMAwxxq0txFyZwvDoDSZ4RZ5vg4RuN9T8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YH2cKeBL; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727489787; x=1759025787;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KQeyC+P/mFswkiAsqAghN2A7u1uS+p3jOQ5BMPTPZHI=;
  b=YH2cKeBLZrGltcyHtJ+7x8MVwEcIIJQ42swmMevMGcgo8/fwBx3Qj9Hg
   n5kHyTMoecNvQ7hO29xh15Vm++CufthLhybgo3OMLhsd8lxotFc+HFOoz
   0aw0ZQzH7wOdBZB/Rpxq0drT5a4NtPlZZLs/h6NSakTWENKRTqUkg7Y99
   NsYu1Ta7Nn0ZB8Fv+UlERddNBDKI+WzvkL6QWKkL1Ax48Nd48E+pT7hrk
   l6EugPId70HSEmsvEta1vcRZZtz1qZ+1sb8hMLVA+QKfQaKkOjHl8CyyX
   /xC1IjrbECMwpjJONC7P7EiK6aV//lXkPXqFGbtpULvGjSGLC9kWX5ndr
   Q==;
X-CSE-ConnectionGUID: nMcNcxSdTfO/LnWhiyn2mw==
X-CSE-MsgGUID: 2CSFJoGeTB+V4tMw3O5TvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11208"; a="29526869"
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="29526869"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 19:16:21 -0700
X-CSE-ConnectionGUID: n4rSEBVmS3m1aY2A58DlMA==
X-CSE-MsgGUID: WdeSY2XgRu25oGb8CioSBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="73507114"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by orviesa008.jf.intel.com with ESMTP; 27 Sep 2024 19:16:21 -0700
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
Subject: [PATCH v8 2/8] mm: zswap: Modify zswap_compress() to accept a page instead of a folio.
Date: Fri, 27 Sep 2024 19:16:14 -0700
Message-Id: <20240928021620.8369-3-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240928021620.8369-1-kanchana.p.sridhar@intel.com>
References: <20240928021620.8369-1-kanchana.p.sridhar@intel.com>
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


