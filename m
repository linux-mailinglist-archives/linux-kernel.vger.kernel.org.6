Return-Path: <linux-kernel+bounces-320492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9287D970B3B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 03:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31CF5B2146E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 01:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3971C287;
	Mon,  9 Sep 2024 01:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nq8Qelke"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0D71C286
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 01:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725845421; cv=none; b=qVB9ClYxc3utKK5kCrMJ4ITofKVjSSBCyj9VXbo2jsbseWhuaGCHDQZvOAbzYOXPBKkmM/sSNRIRNDgV+YyO2PWSg8oJntutr7NKaOpe4tPecVcOYqwebhPJAVo5ATe2DGeB0zQ9QaZDvW/Sj+c+D7Le++nSCnuKrx/+3/th45g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725845421; c=relaxed/simple;
	bh=sd4pFelEU/QdXj5ouoP5PRXHKn8qGUrWc/AAyu1UHpU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g2ZJqJIvBuBLwzFgl0p0dG6RNrzqfzlBMQwr16i5jkTJt+evyrUWEwU0SC+Xf0dE/fy5Fs8wQJkB9I1TyHzBqkHHTo17Vnvf1FkHJLm1tCWzXTxk2gZzKIgNgcZUPnfdUQTb3Xdhi/7+EOhx3UWdOztW1lmVvB7I6lbRvJ9wS+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nq8Qelke; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725845420; x=1757381420;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sd4pFelEU/QdXj5ouoP5PRXHKn8qGUrWc/AAyu1UHpU=;
  b=Nq8QelkeHuFcOZnhF3FEEfIcgM3sT9yQzoPvF78Ttfv1mUx8L2ePEpaE
   mogHTkDHJiDiDlvzRNgiJgmHanq44ZYHwn6LfaUlpsvjkfiLir7IOm4Yc
   Yd6ZT8puYmkz5ncNvv6eczcwyb2CgQb26GKhP5lWh1S3KQSEbyBnMcXul
   J7epsH/nv5iQrYgvFIMOuV07YOJUsHIZxYR9PN9uK8OnEVTvdQLoqvjSL
   R28PGRTZfJzgRwHbR0W7yLEJ/vOOArs98jwu2xMGCZ1720H6b0zp5MwLe
   s+zM57l/KiRDhUXnu8SvK68vuCC4m7j3MOLLsUxkM6z4eFz+sdltKIreZ
   w==;
X-CSE-ConnectionGUID: dFMCxl44SOi1HZzIx4/bug==
X-CSE-MsgGUID: TkPARlyZQtSuE/G9tVquNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="28258145"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="28258145"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2024 18:30:20 -0700
X-CSE-ConnectionGUID: WDU907LnRC+3vfLghWzWkw==
X-CSE-MsgGUID: 4FEk/tfqQaKVE8AxVIBYaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="66486499"
Received: from feng-clx.sh.intel.com ([10.239.159.50])
  by orviesa009.jf.intel.com with ESMTP; 08 Sep 2024 18:30:15 -0700
From: Feng Tang <feng.tang@intel.com>
To: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Marco Elver <elver@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	David Gow <davidgow@google.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-mm@kvack.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Feng Tang <feng.tang@intel.com>
Subject: [PATCH 4/5] kunit: kfence: Make KFENCE_TEST_REQUIRES macro available for all kunit case
Date: Mon,  9 Sep 2024 09:29:57 +0800
Message-Id: <20240909012958.913438-5-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240909012958.913438-1-feng.tang@intel.com>
References: <20240909012958.913438-1-feng.tang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KFENCE_TEST_REQUIRES macro is convenient for judging if a prerequisite of a
test case exists. Lift it into kunit/test.h so that all kunit test cases
can benefit from it.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 include/kunit/test.h    | 6 ++++++
 mm/kfence/kfence_test.c | 9 ++-------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 5ac237c949a0..8a8027e10b89 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -643,6 +643,12 @@ void __printf(2, 3) kunit_log_append(struct string_stream *log, const char *fmt,
 	WRITE_ONCE(test->last_seen.line, __LINE__);			       \
 } while (0)
 
+#define KUNIT_TEST_REQUIRES(test, cond) do {			\
+	if (!(cond))						\
+		kunit_skip((test), "Test requires: " #cond);	\
+} while (0)
+
+
 /**
  * KUNIT_SUCCEED() - A no-op expectation. Only exists for code clarity.
  * @test: The test context object.
diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
index 00fd17285285..5dbb22c8c44f 100644
--- a/mm/kfence/kfence_test.c
+++ b/mm/kfence/kfence_test.c
@@ -32,11 +32,6 @@
 #define arch_kfence_test_address(addr) (addr)
 #endif
 
-#define KFENCE_TEST_REQUIRES(test, cond) do {			\
-	if (!(cond))						\
-		kunit_skip((test), "Test requires: " #cond);	\
-} while (0)
-
 /* Report as observed from console. */
 static struct {
 	spinlock_t lock;
@@ -561,7 +556,7 @@ static void test_init_on_free(struct kunit *test)
 	};
 	int i;
 
-	KFENCE_TEST_REQUIRES(test, IS_ENABLED(CONFIG_INIT_ON_FREE_DEFAULT_ON));
+	KUNIT_TEST_REQUIRES(test, IS_ENABLED(CONFIG_INIT_ON_FREE_DEFAULT_ON));
 	/* Assume it hasn't been disabled on command line. */
 
 	setup_test_cache(test, size, 0, NULL);
@@ -609,7 +604,7 @@ static void test_gfpzero(struct kunit *test)
 	int i;
 
 	/* Skip if we think it'd take too long. */
-	KFENCE_TEST_REQUIRES(test, kfence_sample_interval <= 100);
+	KUNIT_TEST_REQUIRES(test, kfence_sample_interval <= 100);
 
 	setup_test_cache(test, size, 0, NULL);
 	buf1 = test_alloc(test, size, GFP_KERNEL, ALLOCATE_ANY);
-- 
2.34.1


