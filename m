Return-Path: <linux-kernel+bounces-193889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF488D33B2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D590D288768
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 09:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F47B1779BB;
	Wed, 29 May 2024 09:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lctE4Bh1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5460216EC0C
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 09:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716976256; cv=none; b=TRcMombyQjDmOB/GyCIthlUHqoIz8uv66rHR4u9n8JPnxQmKUhtBsnUTgzZKt0HqUJw/loSNMK5gGe4gVrgsecEyMbX7ooDgKRCOUZ7Qqm1O08fIa4O7jAM/Px/5oj/GucWl6fx0Gravd3uIhd5Vh4VpbqvnnQ+TTPcKSCyCzOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716976256; c=relaxed/simple;
	bh=ZVR3E9jt+JeuDy6+irGL6vYnObXajj8jRHzDpvRmroI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YLn2o+OEXXH9e3PdYzmcTEGjjSK7UrWHi7H3DLYeH9ltq8kidOyPQORWJ5jWzxQY4zrUW4GWW+7BQdrEVpLKEjl1GLFm/paRUjJRdn6mwX7QROAIuCuoOWsaXV/pcaV9GyZLLN3+9haDBeVqrUDBvRiTZtpKsnKoloBnrK+cPpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lctE4Bh1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC778C2BD10;
	Wed, 29 May 2024 09:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716976255;
	bh=ZVR3E9jt+JeuDy6+irGL6vYnObXajj8jRHzDpvRmroI=;
	h=From:To:Cc:Subject:Date:From;
	b=lctE4Bh1TGIJCLrkhqlvJnCzezIF4H3ZpbzZ6lBo0Hc+Y2JB9UTuGPUNIK+jRCJpm
	 BUTmu7BkIsMyyoKxru67VB4F/7AouoHSteP6cUE3/xJJvYFZDV/IM6H2TUkjDzKhfx
	 xX4cOE6x8CUFAGhDoNI8NY7/teS/gd2zNJJgWLvVgVGiSt9DGWCSMtjEmf1xVe9cro
	 53rbOnl2zw4PkjcQlF9A2oSG/1CEOutqPd6pcDC5MMWwpouboOe6xhbhctTQ2QHdfW
	 vPJVxb2msGrDUst4oh4Kw/EF9X4LvEBfkjnZqepCJM4VkNA3h4V/il/Pz96lqhDy6T
	 8Ln4hVhZHOMrA==
From: Arnd Bergmann <arnd@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	David Woodhouse <David.Woodhouse@intel.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: make mtd_test.c a separate module
Date: Wed, 29 May 2024 11:50:39 +0200
Message-Id: <20240529095049.1915393-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

This file gets linked into nine different modules, which causes a warning:

scripts/Makefile.build:236: drivers/mtd/tests/Makefile: mtd_test.o is added to multiple modules: mtd_nandbiterrs mtd_oobtest mtd_pagetest mtd_readtest mtd_speedtest mtd_stresstest mtd_subpagetest mtd_torturetest

Make it a separate module instead.

Fixes: a995c792280d ("mtd: tests: rename sources in order to link a helper object")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mtd/tests/Makefile   | 34 +++++++++++++++++-----------------
 drivers/mtd/tests/mtd_test.c |  9 +++++++++
 2 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/mtd/tests/Makefile b/drivers/mtd/tests/Makefile
index 5de0378f90db..7dae831ee8b6 100644
--- a/drivers/mtd/tests/Makefile
+++ b/drivers/mtd/tests/Makefile
@@ -1,19 +1,19 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_MTD_TESTS) += mtd_oobtest.o
-obj-$(CONFIG_MTD_TESTS) += mtd_pagetest.o
-obj-$(CONFIG_MTD_TESTS) += mtd_readtest.o
-obj-$(CONFIG_MTD_TESTS) += mtd_speedtest.o
-obj-$(CONFIG_MTD_TESTS) += mtd_stresstest.o
-obj-$(CONFIG_MTD_TESTS) += mtd_subpagetest.o
-obj-$(CONFIG_MTD_TESTS) += mtd_torturetest.o
-obj-$(CONFIG_MTD_TESTS) += mtd_nandecctest.o
-obj-$(CONFIG_MTD_TESTS) += mtd_nandbiterrs.o
+obj-$(CONFIG_MTD_TESTS) += mtd_oobtest.o mtd_test.o
+obj-$(CONFIG_MTD_TESTS) += mtd_pagetest.o mtd_test.o
+obj-$(CONFIG_MTD_TESTS) += mtd_readtest.o mtd_test.o
+obj-$(CONFIG_MTD_TESTS) += mtd_speedtest.o mtd_test.o
+obj-$(CONFIG_MTD_TESTS) += mtd_stresstest.o mtd_test.o
+obj-$(CONFIG_MTD_TESTS) += mtd_subpagetest.o mtd_test.o
+obj-$(CONFIG_MTD_TESTS) += mtd_torturetest.o mtd_test.o
+obj-$(CONFIG_MTD_TESTS) += mtd_nandecctest.o mtd_test.o
+obj-$(CONFIG_MTD_TESTS) += mtd_nandbiterrs.o mtd_test.o
 
-mtd_oobtest-objs := oobtest.o mtd_test.o
-mtd_pagetest-objs := pagetest.o mtd_test.o
-mtd_readtest-objs := readtest.o mtd_test.o
-mtd_speedtest-objs := speedtest.o mtd_test.o
-mtd_stresstest-objs := stresstest.o mtd_test.o
-mtd_subpagetest-objs := subpagetest.o mtd_test.o
-mtd_torturetest-objs := torturetest.o mtd_test.o
-mtd_nandbiterrs-objs := nandbiterrs.o mtd_test.o
+mtd_oobtest-objs := oobtest.o
+mtd_pagetest-objs := pagetest.o
+mtd_readtest-objs := readtest.o
+mtd_speedtest-objs := speedtest.o
+mtd_stresstest-objs := stresstest.o
+mtd_subpagetest-objs := subpagetest.o
+mtd_torturetest-objs := torturetest.o
+mtd_nandbiterrs-objs := nandbiterrs.o
diff --git a/drivers/mtd/tests/mtd_test.c b/drivers/mtd/tests/mtd_test.c
index c84250beffdc..f391e0300cdc 100644
--- a/drivers/mtd/tests/mtd_test.c
+++ b/drivers/mtd/tests/mtd_test.c
@@ -25,6 +25,7 @@ int mtdtest_erase_eraseblock(struct mtd_info *mtd, unsigned int ebnum)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mtdtest_erase_eraseblock);
 
 static int is_block_bad(struct mtd_info *mtd, unsigned int ebnum)
 {
@@ -57,6 +58,7 @@ int mtdtest_scan_for_bad_eraseblocks(struct mtd_info *mtd, unsigned char *bbt,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mtdtest_scan_for_bad_eraseblocks);
 
 int mtdtest_erase_good_eraseblocks(struct mtd_info *mtd, unsigned char *bbt,
 				unsigned int eb, int ebcnt)
@@ -75,6 +77,7 @@ int mtdtest_erase_good_eraseblocks(struct mtd_info *mtd, unsigned char *bbt,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mtdtest_erase_good_eraseblocks);
 
 int mtdtest_read(struct mtd_info *mtd, loff_t addr, size_t size, void *buf)
 {
@@ -92,6 +95,7 @@ int mtdtest_read(struct mtd_info *mtd, loff_t addr, size_t size, void *buf)
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(mtdtest_read);
 
 int mtdtest_write(struct mtd_info *mtd, loff_t addr, size_t size,
 		const void *buf)
@@ -107,3 +111,8 @@ int mtdtest_write(struct mtd_info *mtd, loff_t addr, size_t size,
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(mtdtest_write);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MTD function test helpers");
+MODULE_AUTHOR("Akinobu Mita");
-- 
2.39.2


