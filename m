Return-Path: <linux-kernel+bounces-345254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4FF98B3B2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 07:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A678B1C22937
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 05:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EFE1BBBE0;
	Tue,  1 Oct 2024 05:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cJKNjHB0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB121A4F2B
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 05:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727761031; cv=none; b=BsI70Rr2KxVp3siraYVygpWlkl7bQEiFq/DxcKTyRJCYlf62nA13kGqRCbznEjcx7EiotD/ikv79/zvpMbRlNen+R8KhJ8CvHGBP4/MNGukFnC8QDuIJqw4+ywcXccOPMXNLM0mA3csk5RExBxvUJi2Nviy8Y/40XxzM6yJ2vhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727761031; c=relaxed/simple;
	bh=efGW2zzH8VCItzcrEw7X5/h61cbLWY8/tK2pA3rWPZo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CGL3cs26rGj0cAnjuHwy7l6XT5eGndGSGWXcMmhbpffLmWEdKhXfR/0ncY6L9Bk6Dsw5ETooag023QQ8joCFZBI28H5Hp+7+WGrxD+Qc8fNGYVLM5Dwxm1r/R138kIAPgsEm7xmWFdIVZWI6K9aNWJ/ySIpekw/JG/QR00MsXKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cJKNjHB0; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727761029; x=1759297029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=efGW2zzH8VCItzcrEw7X5/h61cbLWY8/tK2pA3rWPZo=;
  b=cJKNjHB0jO3WFZkpOxM7cU5eYcbBhHg2tTg8sMJEpABVZbvT8wOrmAZD
   JQw/fDoFriDukXyKJDvUfvt/9DGP8TLsZE8ZP76WC7tJeGXH+sVrU575h
   na4+r8GifWZfhYbr+pDiSvdbUmytV6lgGTGNBRtOHPf5+bBlV5pORvMPh
   i93dws64e0CBiz9Bc43Wb9QMJM08qsDLWI/+dBFFBx3LQZmjRaITutkqe
   eTVUS1zqsOwImO1A1SAStX/YIqUoPwoJWD1fBVUYKD1mOpprPCWp841yw
   zEPnpEbQyeu6LPHgYpJeOaYXyxN13sDMOEOgcS6744a848pyImWHHhihQ
   Q==;
X-CSE-ConnectionGUID: 2X0JVJSHQraN9g06VMD3UA==
X-CSE-MsgGUID: qNvtyG6XRAGbnwdKGVUGRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="37465079"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="37465079"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 22:32:24 -0700
X-CSE-ConnectionGUID: w49pgGxrSHOs/Gotpi9JWA==
X-CSE-MsgGUID: AyNh3wxhT7C8wmJiQpdeOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="73205798"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by fmviesa007.fm.intel.com with ESMTP; 30 Sep 2024 22:32:24 -0700
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
Subject: [PATCH v10 2/7] mm: zswap: Modify zswap_compress() to accept a page instead of a folio.
Date: Mon, 30 Sep 2024 22:32:17 -0700
Message-Id: <20241001053222.6944-3-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20241001053222.6944-1-kanchana.p.sridhar@intel.com>
References: <20241001053222.6944-1-kanchana.p.sridhar@intel.com>
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
Acked-by: Yosry Ahmed <yosryahmed@google.com>
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


