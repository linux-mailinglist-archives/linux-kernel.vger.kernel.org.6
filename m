Return-Path: <linux-kernel+bounces-324282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 360DF974A92
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E033B1F276E0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 06:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB7113C3D3;
	Wed, 11 Sep 2024 06:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YAhp+rC0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0BD136338
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 06:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726037178; cv=none; b=cYpdXQPHYsuYGH/1qw5O/3jGu4kd8Bm1mY2QgS92un6FFWxOaVlWO57mgdu5tm+Et6/9MVZqFZ5qalyP2Rs35xa91j8o3jBoMPshjaCofkFo4MC43jEfJwjcxObKmf/bV5QVnE5z4WTNcqkisyVKM3T1pPbHE2KjAXitIP/Z/XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726037178; c=relaxed/simple;
	bh=spRk1KgMCNNaHSmFuRFHc+16C4JN3bxZV6odFONV/Uw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H4RK89VP5qcCAcQNmJgQtXgpzfxrPwa6PoaTyuxUHfACflr7el+GdNFl46nBkjL/QePTD4+oKaV02hAZWnRwzvGW4uoHt3plfqXnGInbNfLbyt/cXNWNjIY5HFtMNgjd0T+bZ/C5fblY7UQR6fwJ+nPk5H7vUMU5HpWDNgrBgzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YAhp+rC0; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726037176; x=1757573176;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=spRk1KgMCNNaHSmFuRFHc+16C4JN3bxZV6odFONV/Uw=;
  b=YAhp+rC0hG3OevF7ddcm0cTK3KWJCPHwd4E14L4cKM0pZevAhbqdwvWc
   +QKajrSY6loRxZW20N8/cMD3MreJVqGSYrjM84gAdy7rtOJZtluecFvK4
   5+S7YHJMLFQ4RO7H3Pk65NValRiMro+MbltqCxeKRdVdoRzPlk89AcCQz
   brAHgV0wlpJMxAXKg+yMA7nE+iaS7vnJo7ehUpNRk45nqk7Tw/U2nxICS
   EVksxm/EQN7ac/lG3hqfox7kjs1iNzB6nslYcDEG6Gz3s4HWO97QFNDx3
   glZ2ZBFND/1BzQ+QqtvLZ5YS/9/WRYKuy/LEuRUCGYpN8Maso4KjGMscn
   A==;
X-CSE-ConnectionGUID: 8Izt4nHdQ+eZlj+q0z0koQ==
X-CSE-MsgGUID: mNMGoDDgRYma3vYkRfX+Ag==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="36173051"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="36173051"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 23:46:12 -0700
X-CSE-ConnectionGUID: tvwWZ/Y9QRKy+QIHoKa/xw==
X-CSE-MsgGUID: V2Tkj4x9QrGrTc/GWUmeNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="67771512"
Received: from feng-clx.sh.intel.com ([10.239.159.50])
  by orviesa007.jf.intel.com with ESMTP; 10 Sep 2024 23:46:05 -0700
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
	Danilo Krummrich <dakr@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-mm@kvack.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Feng Tang <feng.tang@intel.com>
Subject: [PATCH v2 5/5] mm/slub, kunit: Add testcase for krealloc redzone and zeroing
Date: Wed, 11 Sep 2024 14:45:35 +0800
Message-Id: <20240911064535.557650-6-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911064535.557650-1-feng.tang@intel.com>
References: <20240911064535.557650-1-feng.tang@intel.com>
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

[1]. https://lore.kernel.org/lkml/20240812223707.32049-1-dakr@kernel.org/

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Feng Tang <feng.tang@intel.com>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
---
Hi Danilo,

I keep your Reviewed-By tag, as I think this v2 mostly changes what kmalloc
slab to be used. Let me know if you want it dropped, thanks.

 lib/slub_kunit.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
index 6e3a1e5a7142..b3d158f38b98 100644
--- a/lib/slub_kunit.c
+++ b/lib/slub_kunit.c
@@ -186,6 +186,47 @@ static void test_leak_destroy(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 1, slab_errors);
 }
 
+static void test_krealloc_redzone_zeroing(struct kunit *test)
+{
+	u8 *p;
+	int i;
+	struct kmem_cache *s = test_kmem_cache_create("TestSlub_krealloc", 64,
+				SLAB_KMALLOC|SLAB_STORE_USER|SLAB_RED_ZONE);
+
+	p = __kmalloc_cache_noprof(s, GFP_KERNEL, 48);
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
+	validate_slab_cache(s);
+	KUNIT_EXPECT_EQ(test, 0, slab_errors);
+
+	memset(p, 0xff, 56);
+	/* Test grow with allocating a bigger 128B object */
+	p = krealloc(p, 112, GFP_KERNEL | __GFP_ZERO);
+	for (i = 0; i < 56; i++)
+		KUNIT_EXPECT_EQ(test, p[i], 0xff);
+	for (i = 56; i < 112; i++)
+		KUNIT_EXPECT_EQ(test, p[i], 0);
+
+	kfree(p);
+	kasan_enable_current();
+	kmem_cache_destroy(s);
+}
+
 static int test_init(struct kunit *test)
 {
 	slab_errors = 0;
@@ -208,6 +249,7 @@ static struct kunit_case test_cases[] = {
 	KUNIT_CASE(test_kmalloc_redzone_access),
 	KUNIT_CASE(test_kfree_rcu),
 	KUNIT_CASE(test_leak_destroy),
+	KUNIT_CASE(test_krealloc_redzone_zeroing),
 	{}
 };
 
-- 
2.34.1


