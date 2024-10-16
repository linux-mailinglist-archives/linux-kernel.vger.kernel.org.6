Return-Path: <linux-kernel+bounces-368347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3D49A0EBA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AFFB1C21188
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E12C20FA8B;
	Wed, 16 Oct 2024 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K25Pibhp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACEE20FA84
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 15:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729093331; cv=none; b=XUkvU9JnZSKc7TfRx3RshooBx2QOvL+1C1k2rU9P+a3qK6uq5z5oS6JaZyX0dt0EDbUH2u7in/GnepPVQ8qaKdiK9cvvIPmwU/8qBYBYy8tPminKKecVf5H+SivCRJgAhKqvl1gxa6eMQAL2/bJp8pOrfLDKSZkYPs83NzZmEh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729093331; c=relaxed/simple;
	bh=u/Fj3XtocN55VN0j0tMVNeViXP1RJmwNkXYG9TfzlL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=StGCpTwMpjlW/LT4iOO/W9y27uyBnF8QyT1SgO0xy2IyI8RAoRqHycMIbHnVdFlPwSB4abeRHgqZEoMDU9FgnzttBFZtTk8E8RPhZwKzzqmXzfow9naO3e/rol3Ycxa9xiPfKykZkoEdn/jAiGIfE2UcBrZOCIsCtuEMxkujVz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K25Pibhp; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729093329; x=1760629329;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u/Fj3XtocN55VN0j0tMVNeViXP1RJmwNkXYG9TfzlL0=;
  b=K25Pibhp4GE8dytnYTGvKogRYWLWL4+ZgWw/f3POTG6kniBowz46nvd5
   vc3yXHG+CndMOXWZuFXFszDZ1hT1ZYRjpjaQgR/YwcnsMkIUH5uTwdzLD
   +mgj+ApnCaDRiglfkaEsYr2w03c7iEnmyBiOL2/w5MBjHRiHU05STPCOD
   /YZGuC9y+H2eSvu6sEP4TLtZ4b4fYuvd9y2x7G3nCbrfDnMkR/R0rC9/K
   YiJ3948WOMcdwwbHXnawu59NnQEMOlbPhm9bdUUx5xs9aYFz8gTdXCErD
   LCLf/Wmuslb2HeJr4IpdrmEOTedLfee/rJYKaLQuizGIlORLTUuOgVcZK
   A==;
X-CSE-ConnectionGUID: xYVG6qdBTIaTdges/kz5vw==
X-CSE-MsgGUID: o8wjv5o4QxeyOXhqe3xMTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46021380"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="46021380"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 08:42:09 -0700
X-CSE-ConnectionGUID: r7upwpckRCmJoHJMMwP35w==
X-CSE-MsgGUID: iXHmcnIjQDGr0gnwyXsyLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="109018940"
Received: from feng-clx.sh.intel.com ([10.239.159.50])
  by fmviesa001.fm.intel.com with ESMTP; 16 Oct 2024 08:42:05 -0700
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
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Narasimhan.V@amd.com
Cc: linux-mm@kvack.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Feng Tang <feng.tang@intel.com>
Subject: [PATCH v3 3/3] mm/slub, kunit: Add testcase for krealloc redzone and zeroing
Date: Wed, 16 Oct 2024 23:41:52 +0800
Message-Id: <20241016154152.1376492-4-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241016154152.1376492-1-feng.tang@intel.com>
References: <20241016154152.1376492-1-feng.tang@intel.com>
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
---
 lib/slub_kunit.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
index 80e39f003344..3cd1cc667988 100644
--- a/lib/slub_kunit.c
+++ b/lib/slub_kunit.c
@@ -192,6 +192,47 @@ static void test_leak_destroy(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 2, slab_errors);
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
@@ -214,6 +255,7 @@ static struct kunit_case test_cases[] = {
 	KUNIT_CASE(test_kmalloc_redzone_access),
 	KUNIT_CASE(test_kfree_rcu),
 	KUNIT_CASE(test_leak_destroy),
+	KUNIT_CASE(test_krealloc_redzone_zeroing),
 	{}
 };
 
-- 
2.27.0


