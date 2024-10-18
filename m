Return-Path: <linux-kernel+bounces-371075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E10D9A35FF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B912E1F28ACC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 06:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20438188A3A;
	Fri, 18 Oct 2024 06:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A9P0PveW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA404186E3F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 06:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729234092; cv=none; b=lAUdfWxAw297eGbSoULmJDQNRHplJGGlMEmvbxva3GrnhVxSyM3JfdXPvaSH++4v+7AHx1Fc+Li6/Yf/TfZTRop5uLqLPKrwj8hALUaypr0UGnqufBQf1dHuBEuqUd60RZWLohZxYgNEnVOAk7gt0mQsO+KUBf5Zyxx4rr/91eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729234092; c=relaxed/simple;
	bh=0287k7mWEmWYuvXNZAukIKoRrD9gl2Lhv4dAhuzEN6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DD12BXAojt51Lm3dgcVcyqKh/Cx/R7uxi0NUuCffHGyPOfBeWkjn87mLwCVm3Gygc6t3uaSYt8ce4YTBJWy/gy62sX07DCMXhyYfRwrrdHUBsHEIW7AGDuXP9frPmCk9aIObfLY9YcVqihCeeBKV64GQ8Rxx6RkfiEe4uEVYm8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A9P0PveW; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729234091; x=1760770091;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0287k7mWEmWYuvXNZAukIKoRrD9gl2Lhv4dAhuzEN6E=;
  b=A9P0PveWAhnXrQaO70Kw2LRlhuiQYfKsB43yJLLcPMQ6tQxxpgElR9mP
   PLdIlZ6vS1ziw2gXNtoiPw1rI0pWZelzVa7qQq4r0hKTxFwzXwMNQbkZN
   3wKAs+FcYXiCP64hay6fuL9yxqWcTFEnLBcAMe9JD3lHo1U7ivpDz38eh
   vBszH6tegxlRsYAQftgQL+lBAtcClDxIxuvZ6CPnk8r5k6nXH5eyaWAff
   I5xZrZ1az7ucMNXyqgIdkBjAMviJLm4bHi5m3RgkXFT0QQVOkfbiwU4GM
   ADNfxuy7nhpvaobOYGFt05m1VXGzSrxDZRWqHShM/we9eOAXq7FZzTJVy
   A==;
X-CSE-ConnectionGUID: RGXD59muS5yOLo/Mbeustg==
X-CSE-MsgGUID: KLzBWscXTymyJp5KAFo34A==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28963338"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="28963338"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 23:48:08 -0700
X-CSE-ConnectionGUID: /UVWgjWZT22cO5WouhsKFg==
X-CSE-MsgGUID: +vVqT/OlTbeg2bOeVG+nKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="82744509"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by fmviesa003.fm.intel.com with ESMTP; 17 Oct 2024 23:48:07 -0700
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org,
	hughd@google.com,
	willy@infradead.org,
	bfoster@redhat.com,
	dchinner@redhat.com,
	chrisl@kernel.org,
	david@redhat.com
Cc: wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [RFC PATCH v1 3/7] pagevec: struct folio_batch changes for decompress batching interface.
Date: Thu, 17 Oct 2024 23:48:01 -0700
Message-Id: <20241018064805.336490-4-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20241018064805.336490-1-kanchana.p.sridhar@intel.com>
References: <20241018064805.336490-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Made these changes to "struct folio_batch" for use in the
swapin_readahead() based zswap load batching interface for parallel
decompressions with IAA:

 1) Moved SWAP_RA_ORDER_CEILING definition to pagevec.h.
 2) Increased PAGEVEC_SIZE to (1UL << SWAP_RA_ORDER_CEILING),
    because vm.page-cluster=5 requires capacity for 32 folios.
 3) Made folio_batch_add() more fail-safe.

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 include/linux/pagevec.h | 13 ++++++++++---
 mm/swap_state.c         |  2 --
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index 5d3a0cccc6bf..c9bab240fb6e 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -11,8 +11,14 @@
 
 #include <linux/types.h>
 
-/* 31 pointers + header align the folio_batch structure to a power of two */
-#define PAGEVEC_SIZE	31
+/*
+ * For page-cluster of 5, I noticed that space for 31 pointers was
+ * insufficient. Increasing this to meet the requirements for folio_batch
+ * usage in the swap read decompress batching interface that is based on
+ * swapin_readahead().
+ */
+#define SWAP_RA_ORDER_CEILING	5
+#define PAGEVEC_SIZE	(1UL << SWAP_RA_ORDER_CEILING)
 
 struct folio;
 
@@ -74,7 +80,8 @@ static inline unsigned int folio_batch_space(struct folio_batch *fbatch)
 static inline unsigned folio_batch_add(struct folio_batch *fbatch,
 		struct folio *folio)
 {
-	fbatch->folios[fbatch->nr++] = folio;
+	if (folio_batch_space(fbatch) > 0)
+		fbatch->folios[fbatch->nr++] = folio;
 	return folio_batch_space(fbatch);
 }
 
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 3cebbff40804..0673593d363c 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -44,8 +44,6 @@ struct address_space *swapper_spaces[MAX_SWAPFILES] __read_mostly;
 static unsigned int nr_swapper_spaces[MAX_SWAPFILES] __read_mostly;
 static bool enable_vma_readahead __read_mostly = true;
 
-#define SWAP_RA_ORDER_CEILING	5
-
 #define SWAP_RA_WIN_SHIFT	(PAGE_SHIFT / 2)
 #define SWAP_RA_HITS_MASK	((1UL << SWAP_RA_WIN_SHIFT) - 1)
 #define SWAP_RA_HITS_MAX	SWAP_RA_HITS_MASK
-- 
2.27.0


