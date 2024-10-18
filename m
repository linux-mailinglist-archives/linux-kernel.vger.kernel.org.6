Return-Path: <linux-kernel+bounces-371079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 653949A3603
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D37E3B23E42
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 06:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6618218D640;
	Fri, 18 Oct 2024 06:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fX7xmc6w"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B760317DFEB
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 06:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729234095; cv=none; b=Q1Qi4MTAvsBW8gkx4NnvSYVqH1WouljpEK7UnGFdg6/18uE3k1IqG0LgN1YOEOq5UnwxOrGUf+/W5M1W1++/V6+YeBzxvIMzthHTet5rTX9VcC0AVv+g6TtH+tZ7r5jRMlrsyvqta5cXDe6t55nLRc7GYhmHdbIjMIjPcYURzfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729234095; c=relaxed/simple;
	bh=CzMrEaQ3oHH5UP19JYpptn44NLCDei/++V3CWVkaTRg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K865BvJyOB1yqueuNkgYgdOHjc8/g2bnTnQUZJlefYGnlwJdSSaKFqZvwP17UGbev1C14LOPoq7N58zAfUk16SyZ48KiqaC1NUihxMYDKXe2evv1kPJaVFFbm9Lr2SLQ9OHbvc0kJb+LOgDyCwql+wHVukPZa5GxBqzszsV8+b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fX7xmc6w; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729234094; x=1760770094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CzMrEaQ3oHH5UP19JYpptn44NLCDei/++V3CWVkaTRg=;
  b=fX7xmc6w8TSMoB/YcemWGNcSb30FK0VTFmptc2PgssqI2SDetauMWBGi
   73yIETF1KIzZu3NhNPwQhcKOGD39GzMpn5+hrmnnm9RWgVPPANUwmivvr
   vHalrmgb219RdJcIcqC0jswtOSX9+iE1YBspJEcWW2bXGXjii+SdtITbo
   AAvtTYcx2ABCe134+xxLK5VtAe9SyBwzeZ6Ay8GXg2Ey6t/8z3MTdWdVl
   IuhiJ5XafQpbXLNdl/z7vxnKowKFjPUBfzHf9l/ZYxLNQyL+WxF/waVQd
   BRjDmTWLMQY4s7EUI6MilmeFMfa4LSJEozeHd+y+9ASkP+to/HYMzy61R
   g==;
X-CSE-ConnectionGUID: JISYTmxUQvO7u3R+X0U+dg==
X-CSE-MsgGUID: hteHiFgWRh64W3//EuLCrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28963386"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="28963386"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 23:48:10 -0700
X-CSE-ConnectionGUID: IJqafArETn+8qdBvF+ZmKQ==
X-CSE-MsgGUID: heBzjw1nQkOgWyQXAlD5Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="82744533"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by fmviesa003.fm.intel.com with ESMTP; 17 Oct 2024 23:48:10 -0700
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
Subject: [RFC PATCH v1 7/7] mm: For IAA batching, reduce SWAP_BATCH and modify swap slot cache thresholds.
Date: Thu, 17 Oct 2024 23:48:05 -0700
Message-Id: <20241018064805.336490-8-kanchana.p.sridhar@intel.com>
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

When IAA is used for compress batching and decompress batching of folios,
we significantly reduce the swapout-swapin path latencies, such
that swap page-faults' latencies are reduced. This means swap entries will
need to be freed more often, and swap slots will have to be released more
often.

The existing SWAP_BATCH and SWAP_SLOTS_CACHE_SIZE value of 64
can cause lock contention of the swap_info_struct lock in
swapcache_free_entries and cpu hardlockups can result in highly contended
server scenarios.

To prevent this, the SWAP_BATCH and SWAP_SLOTS_CACHE_SIZE
has been reduced to 16 if IAA is used for compress/decompress batching. The
swap_slots_cache activate/deactive thresholds have been modified
accordingly, so that we don't compromise performance for stability.

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 include/linux/swap.h       | 7 +++++++
 include/linux/swap_slots.h | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index ca533b478c21..3987faa0a2ff 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -13,6 +13,7 @@
 #include <linux/pagemap.h>
 #include <linux/atomic.h>
 #include <linux/page-flags.h>
+#include <linux/pagevec.h>
 #include <uapi/linux/mempolicy.h>
 #include <asm/page.h>
 
@@ -32,7 +33,13 @@ struct pagevec;
 #define SWAP_FLAGS_VALID	(SWAP_FLAG_PRIO_MASK | SWAP_FLAG_PREFER | \
 				 SWAP_FLAG_DISCARD | SWAP_FLAG_DISCARD_ONCE | \
 				 SWAP_FLAG_DISCARD_PAGES)
+
+#if defined(CONFIG_ZSWAP_STORE_BATCHING_ENABLED) || \
+	defined(CONFIG_ZSWAP_LOAD_BATCHING_ENABLED)
+#define SWAP_BATCH 16
+#else
 #define SWAP_BATCH 64
+#endif
 
 static inline int current_is_kswapd(void)
 {
diff --git a/include/linux/swap_slots.h b/include/linux/swap_slots.h
index 15adfb8c813a..1b6e4e2798bd 100644
--- a/include/linux/swap_slots.h
+++ b/include/linux/swap_slots.h
@@ -7,8 +7,15 @@
 #include <linux/mutex.h>
 
 #define SWAP_SLOTS_CACHE_SIZE			SWAP_BATCH
+
+#if defined(CONFIG_ZSWAP_STORE_BATCHING_ENABLED) || \
+	defined(CONFIG_ZSWAP_LOAD_BATCHING_ENABLED)
+#define THRESHOLD_ACTIVATE_SWAP_SLOTS_CACHE	(40*SWAP_SLOTS_CACHE_SIZE)
+#define THRESHOLD_DEACTIVATE_SWAP_SLOTS_CACHE	(16*SWAP_SLOTS_CACHE_SIZE)
+#else
 #define THRESHOLD_ACTIVATE_SWAP_SLOTS_CACHE	(5*SWAP_SLOTS_CACHE_SIZE)
 #define THRESHOLD_DEACTIVATE_SWAP_SLOTS_CACHE	(2*SWAP_SLOTS_CACHE_SIZE)
+#endif
 
 struct swap_slots_cache {
 	bool		lock_initialized;
-- 
2.27.0


