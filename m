Return-Path: <linux-kernel+bounces-320493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657C8970B3C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 03:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25A00281F00
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 01:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AD017555;
	Mon,  9 Sep 2024 01:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MLiaaWnj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DEA1CF9A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 01:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725845425; cv=none; b=E4gW+6sjRC1T5QdeqhNqVQFu+l6I3gtM06uq6R8SE7Z60yExmAzuWYtyYKAA1NP6xCqW0owcPEBiTbHyFg4TQnNfC3OLwEd5F6VSp8H2jhwkBZhENHwxCyfVloUjYcV3aMhspt6oQA6Q7lqlc/K5AxiboGS90pJegCzcgCHlc18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725845425; c=relaxed/simple;
	bh=Ol5TUqWkU7uvIyG026mGuFtpsR/rEt0g9LWcDZDc0MM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LdK0Dr7+wgBgT1scDvl8s9fHoIarc0MJkiDtxbPhL0x5Jb2JwfCR0UAuguZ4bS06LP5rlknwf1eHlplCtUvB4sepw68/9GyNDJZsn0eBAFvY9S+zOXEpopPqYdoVnm8ZLeMScdXZAPPf9UAVd2/AQ7ooRKP1nSdJePc06/KO19Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MLiaaWnj; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725845424; x=1757381424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ol5TUqWkU7uvIyG026mGuFtpsR/rEt0g9LWcDZDc0MM=;
  b=MLiaaWnjz/qlMjstOwedT7w+GHAVqaxijuYmEZFoZ6NTFqpRG3Ux7alx
   +QlOJv7lWICUPNMowS43ZEY2gYQREob2TGAUyKjmzH/K4m5yo0YFq/EXR
   BvvKEcTcHm53x3CNZheSzcLYEw9/5BqnDu7qtB4KXGrQB/sZCGvNRVW3b
   B0+KJ+jJE67GWCPOGRZ7MycyFFH55cI82Csw+HoY50t2M5qtBlc6V29JT
   sugZakY7Qwo+iUIJh7eXWubLHjWod8w4qPXcBhQfHhsC9w2KbUIJdDEEz
   yD/HhVXSIubM6f9SvShySuQ+f1Ri6e80izT0finuReRIFANcnuJ2Lbxno
   Q==;
X-CSE-ConnectionGUID: rRtHkNVER7aFJL+IF6PMmw==
X-CSE-MsgGUID: 1zuBpFx/QGmifuMkK9BKHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="28258160"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="28258160"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2024 18:30:24 -0700
X-CSE-ConnectionGUID: ROdRq+r4T9WF2KAQcT/Xlg==
X-CSE-MsgGUID: DV/YFBNgQQa1SpiY83zezA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="66486541"
Received: from feng-clx.sh.intel.com ([10.239.159.50])
  by orviesa009.jf.intel.com with ESMTP; 08 Sep 2024 18:30:19 -0700
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
Subject: [PATCH 5/5] mm/slub, kunit: Add testcase for krealloc redzone and zeroing
Date: Mon,  9 Sep 2024 09:29:58 +0800
Message-Id: <20240909012958.913438-6-feng.tang@intel.com>
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

Danilo Krummrich raised issue about krealloc+GFP_ZERO [1], and Vlastimil
suggested to add some test case which can sanity test the kmalloc-redzone
and zeroing by utilizing the kmalloc's 'orig_size' debug feature.

It covers the grow and shrink case of krealloc() re-using current kmalloc
object, and the case of re-allocating a new bigger object.

User can add "slub_debug" kernel cmdline parameter to test it.

[1]. https://lore.kernel.org/lkml/20240812223707.32049-1-dakr@kernel.org/

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 lib/slub_kunit.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
index 6e3a1e5a7142..03e0089149ad 100644
--- a/lib/slub_kunit.c
+++ b/lib/slub_kunit.c
@@ -186,6 +186,51 @@ static void test_leak_destroy(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 1, slab_errors);
 }
 
+static void test_krealloc_redzone_zeroing(struct kunit *test)
+{
+	char *p;
+	int i;
+
+	KUNIT_TEST_REQUIRES(test, __slub_debug_enabled());
+
+	/* Allocate a 64B kmalloc object */
+	p = kzalloc(48, GFP_KERNEL);
+	if (unlikely(is_kfence_address(p))) {
+		kfree(p);
+		return;
+	}
+	memset(p, 0xff, 48);
+
+	kasan_disable_current();
+	OPTIMIZER_HIDE_VAR(p);
+
+	/* Test shrink */
+	p = krealloc(p, 40, GFP_KERNEL | __GFP_ZERO);
+	for (i = 40; i < 64; i++)
+		KUNIT_EXPECT_EQ(test, p[i], SLUB_RED_ACTIVE);
+
+	/* Test grow within the same 64B kmalloc object */
+	p = krealloc(p, 56, GFP_KERNEL | __GFP_ZERO);
+	for (i = 40; i < 56; i++)
+		KUNIT_EXPECT_EQ(test, p[i], 0);
+	for (i = 56; i < 64; i++)
+		KUNIT_EXPECT_EQ(test, p[i], SLUB_RED_ACTIVE);
+
+	/* Test grow with allocating a bigger 128B object */
+	p = krealloc(p, 112, GFP_KERNEL | __GFP_ZERO);
+	if (unlikely(is_kfence_address(p)))
+		goto exit;
+
+	for (i = 56; i < 112; i++)
+		KUNIT_EXPECT_EQ(test, p[i], 0);
+	for (i = 112; i < 128; i++)
+		KUNIT_EXPECT_EQ(test, p[i], SLUB_RED_ACTIVE);
+
+exit:
+	kfree(p);
+	kasan_enable_current();
+}
+
 static int test_init(struct kunit *test)
 {
 	slab_errors = 0;
@@ -196,6 +241,7 @@ static int test_init(struct kunit *test)
 }
 
 static struct kunit_case test_cases[] = {
+	KUNIT_CASE(test_krealloc_redzone_zeroing),
 	KUNIT_CASE(test_clobber_zone),
 
 #ifndef CONFIG_KASAN
-- 
2.34.1


