Return-Path: <linux-kernel+bounces-371073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B711D9A35FD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44A8F1F28A04
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 06:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A07218858C;
	Fri, 18 Oct 2024 06:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QUOsHkCl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC544185954
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 06:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729234091; cv=none; b=JNurN0VVPz4+DIY2oqCvboFp6kijQ9MNblP0/sfq2opSw0ClcLxC6V4nRFOHxPeXnpAectocNp30Cf5O5TcmgbR4s5saLrIvjLXGDqWSNnIe6Bm8IJOTI63JRkJW+6gitXjdm5i4Lfqf0jHGB73j4yQo69s0O4asLMOz7SKVG2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729234091; c=relaxed/simple;
	bh=vgbP0deIxDuw/qX2EJ50fTnXNEzCSKwaUCbRMPN4Zeg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HqDTNGEuWFFGV1PMo4EafTaFw5OQcjJndE+E2Bs5+fuvYzSF0FPd/rFu/+i8PxvW16sw8KpQkkUmwE4ESoVzLlAEBKRjB7lnXBpe2LQW14YC0s/SpnpOLf57SVguuoV2LYuD5l0tT5+/MsEzXRBV6/xndVJ0AdJ5Wuao+JEcLX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QUOsHkCl; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729234090; x=1760770090;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vgbP0deIxDuw/qX2EJ50fTnXNEzCSKwaUCbRMPN4Zeg=;
  b=QUOsHkCl/NNTY/HUeSkuPsZ0Chwa1NAhJekI5gueK1GPcBnWv82aJ7Cd
   njRnZCCvxsfQurlaR3jdx3mGdW5xWh5SRj1EY/MBLqyDyYzS3wqGrOHu6
   bq6pSmlpjcabL7r6VzcmfoQyXHaehG8pz7kfEvIzVt3/ZRmtHIKmEyXge
   CO0ymVezjqDaxwjgjUUznh0jvRBNl3kifMeoVDmRq9CtBKbTlKn1aq/vm
   jnakC5Y+DmZOHXd1JHC83toDwmDI31xX4WYRRoOcA26+TMCr5t7jJdGGf
   oHTYxPntNh/vLsbsE7LMDDy24GVl+Dy6bRnsZXl1jpCUzjoA8b+S/jSNF
   g==;
X-CSE-ConnectionGUID: 4Qdm16b8RwiaUolJ+WlKbw==
X-CSE-MsgGUID: eevwZ78ASgmogHagW3nOJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28963318"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="28963318"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 23:48:07 -0700
X-CSE-ConnectionGUID: UUU+zR47R3umRvDc5akGeQ==
X-CSE-MsgGUID: nOsiFCOlRUqm01m/QxIO7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="82744499"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by fmviesa003.fm.intel.com with ESMTP; 17 Oct 2024 23:48:06 -0700
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
Subject: [RFC PATCH v1 1/7] mm: zswap: Config variable to enable zswap loads with decompress batching.
Date: Thu, 17 Oct 2024 23:47:59 -0700
Message-Id: <20241018064805.336490-2-kanchana.p.sridhar@intel.com>
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

Add a new zswap config variable that controls whether zswap load will
decompress a batch of 4K folios, for instance, the folios prefetched
during swapin_readahead():

  CONFIG_ZSWAP_LOAD_BATCHING_ENABLED

The existing CONFIG_CRYPTO_DEV_IAA_CRYPTO variable added in commit
ea7a5cbb4369 ("crypto: iaa - Add Intel IAA Compression Accelerator crypto
driver core") is used to detect if the system has the Intel Analytics
Accelerator (IAA), and the iaa_crypto module is available. If so, the
kernel build will prompt for CONFIG_ZSWAP_LOAD_BATCHING_ENABLED. Hence,
users have the ability to set CONFIG_ZSWAP_LOAD_BATCHING_ENABLED="y" only
on systems that have Intel IAA.

If CONFIG_ZSWAP_LOAD_BATCHING_ENABLED is enabled, and IAA is configured
as the zswap compressor, the vm.page-cluster is used to prefetch up to
32 4K folios using swapin_readahead(). The readahead folios present in
zswap are then loaded as a batch using IAA decompression batching.

The patch also implements a zswap API that returns the status of this
config variable.

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 include/linux/zswap.h |  8 ++++++++
 mm/Kconfig            | 13 +++++++++++++
 mm/zswap.c            | 12 ++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index 328a1e09d502..294d13efbfb1 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -118,6 +118,9 @@ static inline void zswap_store_batch(struct swap_in_memory_cache_cb *simc)
 	else
 		__zswap_store_batch_single(simc);
 }
+
+bool zswap_load_batching_enabled(void);
+
 unsigned long zswap_total_pages(void);
 bool zswap_store(struct folio *folio);
 bool zswap_load(struct folio *folio);
@@ -145,6 +148,11 @@ static inline void zswap_store_batch(struct swap_in_memory_cache_cb *simc)
 {
 }
 
+static inline bool zswap_load_batching_enabled(void)
+{
+	return false;
+}
+
 static inline bool zswap_store(struct folio *folio)
 {
 	return false;
diff --git a/mm/Kconfig b/mm/Kconfig
index 26d1a5cee471..98e46a3cf0e3 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -137,6 +137,19 @@ config ZSWAP_STORE_BATCHING_ENABLED
 	in the folio in	hardware, thereby improving large folio compression
 	throughput and reducing swapout latency.
 
+config ZSWAP_LOAD_BATCHING_ENABLED
+	bool "Batching of zswap loads of 4K folios with Intel IAA"
+	depends on ZSWAP && CRYPTO_DEV_IAA_CRYPTO
+	default n
+	help
+	Enables zswap_load to swapin multiple 4K folios in batches of 8,
+	rather than a folio at a time, if the system has Intel IAA for hardware
+	acceleration of decompressions. swapin_readahead will be used to
+	prefetch a batch of folios to be swapped in along with the faulting
+	folio. If IAA is the zswap compressor, this will parallelize batch
+	decompression of upto 8 folios in hardware, thereby reducing swapin
+	and do_swap_page latency.
+
 choice
 	prompt "Default allocator"
 	depends on ZSWAP
diff --git a/mm/zswap.c b/mm/zswap.c
index 68ce498ad000..fe7bc2a6672e 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -136,6 +136,13 @@ module_param_named(shrinker_enabled, zswap_shrinker_enabled, bool, 0644);
 static bool __zswap_store_batching_enabled = IS_ENABLED(
 	CONFIG_ZSWAP_STORE_BATCHING_ENABLED);
 
+/*
+ * Enable/disable batching of decompressions of multiple 4K folios, if
+ * the system has Intel IAA.
+ */
+static bool __zswap_load_batching_enabled = IS_ENABLED(
+	CONFIG_ZSWAP_LOAD_BATCHING_ENABLED);
+
 bool zswap_is_enabled(void)
 {
 	return zswap_enabled;
@@ -246,6 +253,11 @@ __always_inline bool zswap_store_batching_enabled(void)
 	return __zswap_store_batching_enabled;
 }
 
+__always_inline bool zswap_load_batching_enabled(void)
+{
+	return __zswap_load_batching_enabled;
+}
+
 static void __zswap_store_batch_core(
 	int node_id,
 	struct folio **folios,
-- 
2.27.0


