Return-Path: <linux-kernel+bounces-367118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 770B599FED2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 04:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECF6B1F245A9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 02:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB2B15C14B;
	Wed, 16 Oct 2024 02:27:49 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0B4158A2E;
	Wed, 16 Oct 2024 02:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729045669; cv=none; b=NrZ0CAr+mp80gIWChMSL7G0GftfbmPFOHIbZlaXfyqnQ8WjzGmZ4EWztIRNJJ5fH1JG7uph1oCOxSj13YHhL+AJeZ/wJlyxTTOXKpKzQCRaxTvEG5pwbE4SOvaZjiTv1uSHDVa8cICI86ipPiXHkjP5mJcChAClpYDaeP7oXfyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729045669; c=relaxed/simple;
	bh=88cg77w6Zl5aXV4euH8inb+ijowXao7uWH3SKEr7VRY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FcQRrtnVSyJ5gELiO1E1JRKGjsqbCCgDr2UxL/ZoB0adYV7rhSg83I8pe/UoLsQ2rg/14klT/QcQY9TgWbzk9kEYEp7NtLIuR3Cc/fbbDMWEvyGEEWR2dPLR9RfYeJN12PogFpYxLo4yjsUcUxDpIspdPtYTssJBOyaflf1ev18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XSvwX12wGzyTL8;
	Wed, 16 Oct 2024 10:26:20 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id A53651401E0;
	Wed, 16 Oct 2024 10:27:43 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 16 Oct
 2024 10:27:43 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <mripard@kernel.org>,
	<linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] clk: test: Fix some memory leaks
Date: Wed, 16 Oct 2024 10:26:58 +0800
Message-ID: <20241016022658.2131826-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)

CONFIG_CLK_KUNIT_TEST=y, CONFIG_DEBUG_KMEMLEAK=y
and CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y, the following memory leak occurs.

If the KUNIT_ASSERT_*() fails, the latter (exit() or testcases)
clk_put() or clk_hw_unregister() will fail to release the clk resource
and cause memory leaks, use new clk_hw_register_kunit()
and clk_hw_get_clk_kunit() to automatically release them.

	unreferenced object 0xffffff80c6af5000 (size 512):
	  comm "kunit_try_catch", pid 371, jiffies 4294896001
	  hex dump (first 32 bytes):
	    20 4c c0 86 e1 ff ff ff e0 1a c0 86 e1 ff ff ff   L..............
	    c0 75 e3 c6 80 ff ff ff 00 00 00 00 00 00 00 00  .u..............
	  backtrace (crc 8ca788fa):
	    [<00000000e21852d0>] kmemleak_alloc+0x34/0x40
	    [<000000009c583f7b>] __kmalloc_cache_noprof+0x26c/0x2f4
	    [<00000000d1bc850c>] __clk_register+0x80/0x1ecc
	    [<00000000b08c78c5>] clk_hw_register+0xc4/0x110
	    [<00000000b16d6df8>] clk_multiple_parents_mux_test_init+0x238/0x288
	    [<0000000014a7e804>] kunit_try_run_case+0x10c/0x3ac
	    [<0000000026b41f03>] kunit_generic_run_threadfn_adapter+0x80/0xec
	    [<0000000066619fb8>] kthread+0x2e8/0x374
	    [<00000000a1157f53>] ret_from_fork+0x10/0x20
	unreferenced object 0xffffff80c6e37880 (size 96):
	  comm "kunit_try_catch", pid 371, jiffies 4294896002
	  hex dump (first 32 bytes):
	    00 50 af c6 80 ff ff ff 00 00 00 00 00 00 00 00  .P..............
	    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	  backtrace (crc b4b766dd):
	    [<00000000e21852d0>] kmemleak_alloc+0x34/0x40
	    [<000000009c583f7b>] __kmalloc_cache_noprof+0x26c/0x2f4
	    [<0000000086e7dd64>] clk_hw_create_clk.part.0.isra.0+0x58/0x2f4
	    [<00000000dcf1ac31>] clk_hw_get_clk+0x8c/0x114
	    [<000000006fab5bfa>] clk_test_multiple_parents_mux_set_range_set_parent_get_rate+0x3c/0xa0
	    [<00000000c97db55a>] kunit_try_run_case+0x13c/0x3ac
	    [<0000000026b41f03>] kunit_generic_run_threadfn_adapter+0x80/0xec
	    [<0000000066619fb8>] kthread+0x2e8/0x374
	    [<00000000a1157f53>] ret_from_fork+0x10/0x20
	unreferenced object 0xffffff80c2b56900 (size 96):
	  comm "kunit_try_catch", pid 395, jiffies 4294896107
	  hex dump (first 32 bytes):
	    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	    00 00 00 00 00 00 00 00 e0 49 c0 86 e1 ff ff ff  .........I......
	  backtrace (crc 2e59b327):
	    [<00000000e21852d0>] kmemleak_alloc+0x34/0x40
	    [<00000000c6c715a8>] __kmalloc_noprof+0x2bc/0x3c0
	    [<00000000f04a7951>] __clk_register+0x70c/0x1ecc
	    [<00000000b08c78c5>] clk_hw_register+0xc4/0x110
	    [<00000000cafa9563>] clk_orphan_transparent_multiple_parent_mux_test_init+0x1a8/0x1dc
	    [<0000000014a7e804>] kunit_try_run_case+0x10c/0x3ac
	    [<0000000026b41f03>] kunit_generic_run_threadfn_adapter+0x80/0xec
	    [<0000000066619fb8>] kthread+0x2e8/0x374
	    [<00000000a1157f53>] ret_from_fork+0x10/0x20
	unreferenced object 0xffffff80c87c9400 (size 512):
	  comm "kunit_try_catch", pid 483, jiffies 4294896907
	  hex dump (first 32 bytes):
	    a0 44 c0 86 e1 ff ff ff e0 1a c0 86 e1 ff ff ff  .D..............
	    20 05 a8 c8 80 ff ff ff 00 00 00 00 00 00 00 00   ...............
	  backtrace (crc c25b43fb):
	    [<00000000e21852d0>] kmemleak_alloc+0x34/0x40
	    [<000000009c583f7b>] __kmalloc_cache_noprof+0x26c/0x2f4
	    [<00000000d1bc850c>] __clk_register+0x80/0x1ecc
	    [<00000000b08c78c5>] clk_hw_register+0xc4/0x110
	    [<000000002688be48>] clk_single_parent_mux_test_init+0x1a0/0x1d4
	    [<0000000014a7e804>] kunit_try_run_case+0x10c/0x3ac
	    [<0000000026b41f03>] kunit_generic_run_threadfn_adapter+0x80/0xec
	    [<0000000066619fb8>] kthread+0x2e8/0x374
	    [<00000000a1157f53>] ret_from_fork+0x10/0x20
	unreferenced object 0xffffff80c6dd2380 (size 96):
	  comm "kunit_try_catch", pid 483, jiffies 4294896908
	  hex dump (first 32 bytes):
	    00 94 7c c8 80 ff ff ff 00 00 00 00 00 00 00 00  ..|.............
	    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	  backtrace (crc 4401212):
	    [<00000000e21852d0>] kmemleak_alloc+0x34/0x40
	    [<000000009c583f7b>] __kmalloc_cache_noprof+0x26c/0x2f4
	    [<0000000086e7dd64>] clk_hw_create_clk.part.0.isra.0+0x58/0x2f4
	    [<00000000dcf1ac31>] clk_hw_get_clk+0x8c/0x114
	    [<0000000063eb2c90>] clk_test_single_parent_mux_set_range_disjoint_child_last+0x3c/0xa0
	    [<00000000c97db55a>] kunit_try_run_case+0x13c/0x3ac
	    [<0000000026b41f03>] kunit_generic_run_threadfn_adapter+0x80/0xec
	    [<0000000066619fb8>] kthread+0x2e8/0x374
	    [<00000000a1157f53>] ret_from_fork+0x10/0x20
	......

Fixes: 02cdeace1e1e ("clk: tests: Add tests for single parent mux")
Fixes: 2e9cad1abc71 ("clk: tests: Add some tests for orphan with multiple parents")
Fixes: 433fb8a611ca ("clk: tests: Add missing test case for ranges")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/clk/clk_test.c | 61 ++++++++++--------------------------------
 1 file changed, 14 insertions(+), 47 deletions(-)

diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
index 41fc8eba3418..aa3ddcfc00eb 100644
--- a/drivers/clk/clk_test.c
+++ b/drivers/clk/clk_test.c
@@ -473,7 +473,7 @@ clk_multiple_parents_mux_test_init(struct kunit *test)
 							    &clk_dummy_rate_ops,
 							    0);
 	ctx->parents_ctx[0].rate = DUMMY_CLOCK_RATE_1;
-	ret = clk_hw_register(NULL, &ctx->parents_ctx[0].hw);
+	ret = clk_hw_register_kunit(test, NULL, &ctx->parents_ctx[0].hw);
 	if (ret)
 		return ret;
 
@@ -481,7 +481,7 @@ clk_multiple_parents_mux_test_init(struct kunit *test)
 							    &clk_dummy_rate_ops,
 							    0);
 	ctx->parents_ctx[1].rate = DUMMY_CLOCK_RATE_2;
-	ret = clk_hw_register(NULL, &ctx->parents_ctx[1].hw);
+	ret = clk_hw_register_kunit(test, NULL, &ctx->parents_ctx[1].hw);
 	if (ret)
 		return ret;
 
@@ -489,23 +489,13 @@ clk_multiple_parents_mux_test_init(struct kunit *test)
 	ctx->hw.init = CLK_HW_INIT_PARENTS("test-mux", parents,
 					   &clk_multiple_parents_mux_ops,
 					   CLK_SET_RATE_PARENT);
-	ret = clk_hw_register(NULL, &ctx->hw);
+	ret = clk_hw_register_kunit(test, NULL, &ctx->hw);
 	if (ret)
 		return ret;
 
 	return 0;
 }
 
-static void
-clk_multiple_parents_mux_test_exit(struct kunit *test)
-{
-	struct clk_multiple_parent_ctx *ctx = test->priv;
-
-	clk_hw_unregister(&ctx->hw);
-	clk_hw_unregister(&ctx->parents_ctx[0].hw);
-	clk_hw_unregister(&ctx->parents_ctx[1].hw);
-}
-
 /*
  * Test that for a clock with multiple parents, clk_get_parent()
  * actually returns the current one.
@@ -561,18 +551,18 @@ clk_test_multiple_parents_mux_set_range_set_parent_get_rate(struct kunit *test)
 {
 	struct clk_multiple_parent_ctx *ctx = test->priv;
 	struct clk_hw *hw = &ctx->hw;
-	struct clk *clk = clk_hw_get_clk(hw, NULL);
+	struct clk *clk = clk_hw_get_clk_kunit(test, hw, NULL);
 	struct clk *parent1, *parent2;
 	unsigned long rate;
 	int ret;
 
 	kunit_skip(test, "This needs to be fixed in the core.");
 
-	parent1 = clk_hw_get_clk(&ctx->parents_ctx[0].hw, NULL);
+	parent1 = clk_hw_get_clk_kunit(test, &ctx->parents_ctx[0].hw, NULL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent1);
 	KUNIT_ASSERT_TRUE(test, clk_is_match(clk_get_parent(clk), parent1));
 
-	parent2 = clk_hw_get_clk(&ctx->parents_ctx[1].hw, NULL);
+	parent2 = clk_hw_get_clk_kunit(test, &ctx->parents_ctx[1].hw, NULL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent2);
 
 	ret = clk_set_rate(parent1, DUMMY_CLOCK_RATE_1);
@@ -593,10 +583,6 @@ clk_test_multiple_parents_mux_set_range_set_parent_get_rate(struct kunit *test)
 	KUNIT_ASSERT_GT(test, rate, 0);
 	KUNIT_EXPECT_GE(test, rate, DUMMY_CLOCK_RATE_1 - 1000);
 	KUNIT_EXPECT_LE(test, rate, DUMMY_CLOCK_RATE_1 + 1000);
-
-	clk_put(parent2);
-	clk_put(parent1);
-	clk_put(clk);
 }
 
 static struct kunit_case clk_multiple_parents_mux_test_cases[] = {
@@ -617,7 +603,6 @@ static struct kunit_suite
 clk_multiple_parents_mux_test_suite = {
 	.name = "clk-multiple-parents-mux-test",
 	.init = clk_multiple_parents_mux_test_init,
-	.exit = clk_multiple_parents_mux_test_exit,
 	.test_cases = clk_multiple_parents_mux_test_cases,
 };
 
@@ -637,29 +622,20 @@ clk_orphan_transparent_multiple_parent_mux_test_init(struct kunit *test)
 							    &clk_dummy_rate_ops,
 							    0);
 	ctx->parents_ctx[1].rate = DUMMY_CLOCK_INIT_RATE;
-	ret = clk_hw_register(NULL, &ctx->parents_ctx[1].hw);
+	ret = clk_hw_register_kunit(test, NULL, &ctx->parents_ctx[1].hw);
 	if (ret)
 		return ret;
 
 	ctx->hw.init = CLK_HW_INIT_PARENTS("test-orphan-mux", parents,
 					   &clk_multiple_parents_mux_ops,
 					   CLK_SET_RATE_PARENT);
-	ret = clk_hw_register(NULL, &ctx->hw);
+	ret = clk_hw_register_kunit(test, NULL, &ctx->hw);
 	if (ret)
 		return ret;
 
 	return 0;
 }
 
-static void
-clk_orphan_transparent_multiple_parent_mux_test_exit(struct kunit *test)
-{
-	struct clk_multiple_parent_ctx *ctx = test->priv;
-
-	clk_hw_unregister(&ctx->hw);
-	clk_hw_unregister(&ctx->parents_ctx[1].hw);
-}
-
 /*
  * Test that, for a mux whose current parent hasn't been registered yet and is
  * thus orphan, clk_get_parent() will return NULL.
@@ -912,7 +888,7 @@ clk_test_orphan_transparent_multiple_parent_mux_set_range_set_parent_get_rate(st
 {
 	struct clk_multiple_parent_ctx *ctx = test->priv;
 	struct clk_hw *hw = &ctx->hw;
-	struct clk *clk = clk_hw_get_clk(hw, NULL);
+	struct clk *clk = clk_hw_get_clk_kunit(test, hw, NULL);
 	struct clk *parent;
 	unsigned long rate;
 	int ret;
@@ -921,7 +897,7 @@ clk_test_orphan_transparent_multiple_parent_mux_set_range_set_parent_get_rate(st
 
 	clk_hw_set_rate_range(hw, DUMMY_CLOCK_RATE_1, DUMMY_CLOCK_RATE_2);
 
-	parent = clk_hw_get_clk(&ctx->parents_ctx[1].hw, NULL);
+	parent = clk_hw_get_clk_kunit(test, &ctx->parents_ctx[1].hw, NULL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
 
 	ret = clk_set_parent(clk, parent);
@@ -931,9 +907,6 @@ clk_test_orphan_transparent_multiple_parent_mux_set_range_set_parent_get_rate(st
 	KUNIT_ASSERT_GT(test, rate, 0);
 	KUNIT_EXPECT_GE(test, rate, DUMMY_CLOCK_RATE_1);
 	KUNIT_EXPECT_LE(test, rate, DUMMY_CLOCK_RATE_2);
-
-	clk_put(parent);
-	clk_put(clk);
 }
 
 static struct kunit_case clk_orphan_transparent_multiple_parent_mux_test_cases[] = {
@@ -961,7 +934,6 @@ static struct kunit_case clk_orphan_transparent_multiple_parent_mux_test_cases[]
 static struct kunit_suite clk_orphan_transparent_multiple_parent_mux_test_suite = {
 	.name = "clk-orphan-transparent-multiple-parent-mux-test",
 	.init = clk_orphan_transparent_multiple_parent_mux_test_init,
-	.exit = clk_orphan_transparent_multiple_parent_mux_test_exit,
 	.test_cases = clk_orphan_transparent_multiple_parent_mux_test_cases,
 };
 
@@ -986,7 +958,7 @@ static int clk_single_parent_mux_test_init(struct kunit *test)
 				      &clk_dummy_rate_ops,
 				      0);
 
-	ret = clk_hw_register(NULL, &ctx->parent_ctx.hw);
+	ret = clk_hw_register_kunit(test, NULL, &ctx->parent_ctx.hw);
 	if (ret)
 		return ret;
 
@@ -994,7 +966,7 @@ static int clk_single_parent_mux_test_init(struct kunit *test)
 				   &clk_dummy_single_parent_ops,
 				   CLK_SET_RATE_PARENT);
 
-	ret = clk_hw_register(NULL, &ctx->hw);
+	ret = clk_hw_register_kunit(test, NULL, &ctx->hw);
 	if (ret)
 		return ret;
 
@@ -1060,7 +1032,7 @@ clk_test_single_parent_mux_set_range_disjoint_child_last(struct kunit *test)
 {
 	struct clk_single_parent_ctx *ctx = test->priv;
 	struct clk_hw *hw = &ctx->hw;
-	struct clk *clk = clk_hw_get_clk(hw, NULL);
+	struct clk *clk = clk_hw_get_clk_kunit(test, hw, NULL);
 	struct clk *parent;
 	int ret;
 
@@ -1074,8 +1046,6 @@ clk_test_single_parent_mux_set_range_disjoint_child_last(struct kunit *test)
 
 	ret = clk_set_rate_range(clk, 3000, 4000);
 	KUNIT_EXPECT_LT(test, ret, 0);
-
-	clk_put(clk);
 }
 
 /*
@@ -1092,7 +1062,7 @@ clk_test_single_parent_mux_set_range_disjoint_parent_last(struct kunit *test)
 {
 	struct clk_single_parent_ctx *ctx = test->priv;
 	struct clk_hw *hw = &ctx->hw;
-	struct clk *clk = clk_hw_get_clk(hw, NULL);
+	struct clk *clk = clk_hw_get_clk_kunit(test, hw, NULL);
 	struct clk *parent;
 	int ret;
 
@@ -1106,8 +1076,6 @@ clk_test_single_parent_mux_set_range_disjoint_parent_last(struct kunit *test)
 
 	ret = clk_set_rate_range(parent, 3000, 4000);
 	KUNIT_EXPECT_LT(test, ret, 0);
-
-	clk_put(clk);
 }
 
 /*
@@ -1238,7 +1206,6 @@ static struct kunit_suite
 clk_single_parent_mux_test_suite = {
 	.name = "clk-single-parent-mux-test",
 	.init = clk_single_parent_mux_test_init,
-	.exit = clk_single_parent_mux_test_exit,
 	.test_cases = clk_single_parent_mux_test_cases,
 };
 
-- 
2.34.1


