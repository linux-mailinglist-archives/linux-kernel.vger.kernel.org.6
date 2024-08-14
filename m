Return-Path: <linux-kernel+bounces-285942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71ABF951484
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956741C22900
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 06:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5222113C3EE;
	Wed, 14 Aug 2024 06:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CgAodVzZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128B71384B3
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 06:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723616918; cv=none; b=HXkgMlg3CARaVUsD0K1r//6TgGAx9EfV47L/nmnLKE5AgU6CS1FIuwRfEDkNjYTmWswoPNJkrZeUuQ8U9CPvhSjVzSDMu6udKFjxpaFDYxXlhCtLcBizRCRQyWfoFMqh6NdN2uM1lTHwLWK/4EdzKx5leQxiwglSLU1wL0a0/cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723616918; c=relaxed/simple;
	bh=K2v1VkFvaq+3TScgsmYP670KxeFAd1V81S4yNBh/NTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g7fZNdNxNqWSWTQlM92Yigxp0dzRS49NqE+0xDNF9OaEOz43DvLIwduz3oJW3yF55Y9GBpQWqWtaT3fSxx3MsWLwwrR/VEUy1Xzwfj2sN8UF/10hWokaKMHDXFtohkwImoe37fUw1mqqtCL7bsD4uur218yr6Fk5nCg7TdmwS/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CgAodVzZ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723616918; x=1755152918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K2v1VkFvaq+3TScgsmYP670KxeFAd1V81S4yNBh/NTc=;
  b=CgAodVzZm8mlPwJrZFYqajz8uic3OI2sbCBCet/evMMmGtLgETX3jK6s
   hr+SN7zMeDTg1wXL7VaIAPjJx3K74ZqdJ+zKVYxEqt0DRCqK+khmbsDi+
   RSuhXkakPmtJ+Rdt+fXs242iG9XD+lrGHGyTBzEZtN8wjDdCwMJtBaXzZ
   ww4dY1YpAJQRm02LmqxG38f5ctLvTSlJm7wQYDJ7tfw+ZgxEW+O46Xr5G
   mx1jTBo//i31TNRY6VAOVK2PhyejOrmzI5x8Kz9N8xf83NQSVuLFkPb6P
   ysNpQ/xqbKoBYwhjHdxWENGegWb2BmDMYuN/FWUi3UgbfyvuTFEGQYAd8
   g==;
X-CSE-ConnectionGUID: 3L9fmTLwT5i4Fo9YsXzYBQ==
X-CSE-MsgGUID: YmO3IS9fR3WM444cQg2ahA==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="44333020"
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; 
   d="scan'208";a="44333020"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 23:28:33 -0700
X-CSE-ConnectionGUID: 2zyx+9DPTjmnHtf37Gg14Q==
X-CSE-MsgGUID: Jy9a/cZJQdGV9YY2ZGhG0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; 
   d="scan'208";a="63568762"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by fmviesa004.fm.intel.com with ESMTP; 13 Aug 2024 23:28:33 -0700
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
Subject: [RFC PATCH v1 4/4] mm: page_io: Count successful mTHP zswap stores in vmstat.
Date: Tue, 13 Aug 2024 23:28:30 -0700
Message-Id: <20240814062830.26833-5-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240814062830.26833-1-kanchana.p.sridhar@intel.com>
References: <20240814062830.26833-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added count_zswap_thp_swpout_vm_event() that will increment the
appropriate mTHP/PMD vmstat event counters if zswap_store succeeds for
a large folio:

zswap_store mTHP order [0, HPAGE_PMD_ORDER-1] will increment these
vmstat event counters:

  ZSWPOUT_4KB_FOLIO
  mTHP_ZSWPOUT_8kB
  mTHP_ZSWPOUT_16kB
  mTHP_ZSWPOUT_32kB
  mTHP_ZSWPOUT_64kB
  mTHP_ZSWPOUT_128kB
  mTHP_ZSWPOUT_256kB
  mTHP_ZSWPOUT_512kB
  mTHP_ZSWPOUT_1024kB

zswap_store of a PMD-size THP, i.e., mTHP order HPAGE_PMD_ORDER, will
increment both these vmstat event counters:

  ZSWPOUT_PMD_THP_FOLIO
  mTHP_ZSWPOUT_2048kB

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 mm/page_io.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/mm/page_io.c b/mm/page_io.c
index 0a150c240bf4..ab54d2060cc4 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -172,6 +172,49 @@ int generic_swapfile_activate(struct swap_info_struct *sis,
 	goto out;
 }
 
+/*
+ * Count vmstats for ZSWAP store of large folios (mTHP and PMD-size THP).
+ */
+static inline void count_zswap_thp_swpout_vm_event(struct folio *folio)
+{
+	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && folio_test_pmd_mappable(folio)) {
+		count_vm_event(ZSWPOUT_PMD_THP_FOLIO);
+		count_vm_event(mTHP_ZSWPOUT_2048kB);
+	} else if (folio_order(folio) == 0) {
+		count_vm_event(ZSWPOUT_4KB_FOLIO);
+	} else if (IS_ENABLED(CONFIG_THP_SWAP)) {
+		switch (folio_order(folio)) {
+		case 1:
+			count_vm_event(mTHP_ZSWPOUT_8kB);
+			break;
+		case 2:
+			count_vm_event(mTHP_ZSWPOUT_16kB);
+			break;
+		case 3:
+			count_vm_event(mTHP_ZSWPOUT_32kB);
+			break;
+		case 4:
+			count_vm_event(mTHP_ZSWPOUT_64kB);
+			break;
+		case 5:
+			count_vm_event(mTHP_ZSWPOUT_128kB);
+			break;
+		case 6:
+			count_vm_event(mTHP_ZSWPOUT_256kB);
+			break;
+		case 7:
+			count_vm_event(mTHP_ZSWPOUT_512kB);
+			break;
+		case 8:
+			count_vm_event(mTHP_ZSWPOUT_1024kB);
+			break;
+		case 9:
+			count_vm_event(mTHP_ZSWPOUT_2048kB);
+			break;
+		}
+	}
+}
+
 /*
  * We may have stale swap cache pages in memory: notice
  * them here and get rid of the unnecessary final write.
@@ -196,6 +239,7 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
 		return ret;
 	}
 	if (zswap_store(folio)) {
+		count_zswap_thp_swpout_vm_event(folio);
 		folio_start_writeback(folio);
 		folio_unlock(folio);
 		folio_end_writeback(folio);
-- 
2.27.0


