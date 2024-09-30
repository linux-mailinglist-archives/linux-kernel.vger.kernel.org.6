Return-Path: <linux-kernel+bounces-343449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC75989B0A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F9C1C21114
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B8414A0AB;
	Mon, 30 Sep 2024 07:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GtQwInaZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04C855887
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 07:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727679992; cv=none; b=BOlC0WvJrqrqMpQH9k3/FTsi+DMFt25DylaajY1ipEXxN2Tf8u7PGiYJSRA7r4w+NBnoCWPye95BTXxwgOWvVcMguY55i+MVS+kwmmN23seXo8WQoe/9lZvJH+eZ+9b3CMSYG9uMnF2DHWNcn2YG3317gYauczBZjAFLEBSLU4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727679992; c=relaxed/simple;
	bh=PB0MEC1CKGl5nX9ER1cPtNYmSWES5H/VnZiXDThMwbA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A+iBJu5jcRdosPLXq4ap8fJdVfqhflzGjRZ1qvws+L8gaVaHhnrkGFXaKJIoxtw0lVbYFyWHrHcl22ALREobpayPbMuMCjiMy2DNsu1lpbaZeAoTrkNCZ1RKEag8x3eqZ4x6jiTajtZo978tUqUWnt04yzL1lVpgaq5qgogz+pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GtQwInaZ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727679990; x=1759215990;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PB0MEC1CKGl5nX9ER1cPtNYmSWES5H/VnZiXDThMwbA=;
  b=GtQwInaZDD1zl8XR1zV6ok9PsM90HVy0GMg31g/5XdgyVv5V9qlz0Kim
   EAr/KNJg+viLZaY1Ui3bt53PgA7XmGpLiA0yok/OwdsaWLYI5+yhg3xjE
   EFVp13P52pp9sMGTmhvKpTYRlunL8FtlrnuC26guws6KV9YE4QsU8wvsw
   frMM4CtpOgUmC/6QjAXSPI4015ConQ4tJr2MtEZh7fso2PV9PVKn3geGg
   HKBTpH3Fv34df2pqvExo6SKiT00vn/oUCwBVCWX4u4LoSkN1IkYDkHASA
   eoX9bb8KQIwk2932NvVV2SKMxph9hhgq+G3bB9+qxElBzwY6IAKveYfuY
   w==;
X-CSE-ConnectionGUID: mzstUAb0QGiLhCWqBPqH4A==
X-CSE-MsgGUID: GN+HyHHKROugnx3oDNveCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26925487"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26925487"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 00:06:29 -0700
X-CSE-ConnectionGUID: AXnZssvLRtCqvA+3eaPI4A==
X-CSE-MsgGUID: HfY1+I/lThyzjk6e2QLVfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="103989457"
Received: from liyihao-mobl.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.124.238.112])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 00:06:28 -0700
From: Huang Ying <ying.huang@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Huang Ying <ying.huang@intel.com>,
	Kees Bakker <kees@ijzerbout.nl>,
	Dan Williams <dan.j.williams@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] resource, kunit: Fix user-after-free in resource_test_region_intersects()
Date: Mon, 30 Sep 2024 15:06:11 +0800
Message-Id: <20240930070611.353338-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In resource_test_insert_resource(), the pointer is used in error
message after kfree().  This is user-after-free.  To fix this, we need
to call kunit_add_action_or_reset() to schedule memory freeing after
usage.  But kunit_add_action_or_reset() itself may fail and free the
memory.  So, its return value should be checked and abort the test for
failure.  Then, we found that other usage of
kunit_add_action_or_reset() in resource_test_region_intersects() needs
to be fixed too.  We fix all these user-after-free bugs in this patch.

Fixes: 99185c10d5d9 ("resource, kunit: add test case for region_intersects()")
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Reported-by: Kees Bakker <kees@ijzerbout.nl>
Closes: https://lore.kernel.org/lkml/87ldzaotcg.fsf@yhuang6-desk2.ccr.corp.intel.com/
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 kernel/resource_kunit.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/kernel/resource_kunit.c b/kernel/resource_kunit.c
index 42d2d8d20f5d..b8ef75b99eb2 100644
--- a/kernel/resource_kunit.c
+++ b/kernel/resource_kunit.c
@@ -169,6 +169,8 @@ static void resource_test_intersection(struct kunit *test)
 #define RES_TEST_RAM3_SIZE	SZ_1M
 #define RES_TEST_TOTAL_SIZE	((RES_TEST_WIN1_OFFSET + RES_TEST_WIN1_SIZE))
 
+KUNIT_DEFINE_ACTION_WRAPPER(kfree_wrapper, kfree, const void *);
+
 static void remove_free_resource(void *ctx)
 {
 	struct resource *res = (struct resource *)ctx;
@@ -177,6 +179,14 @@ static void remove_free_resource(void *ctx)
 	kfree(res);
 }
 
+static void resource_test_add_action_or_abort(
+	struct kunit *test, void (*action)(void *), void *ctx)
+{
+	KUNIT_ASSERT_EQ_MSG(test, 0,
+			    kunit_add_action_or_reset(test, action, ctx),
+			    "Fail to add action");
+}
+
 static void resource_test_request_region(struct kunit *test, struct resource *parent,
 					 resource_size_t start, resource_size_t size,
 					 const char *name, unsigned long flags)
@@ -185,7 +195,7 @@ static void resource_test_request_region(struct kunit *test, struct resource *pa
 
 	res = __request_region(parent, start, size, name, flags);
 	KUNIT_ASSERT_NOT_NULL(test, res);
-	kunit_add_action_or_reset(test, remove_free_resource, res);
+	resource_test_add_action_or_abort(test, remove_free_resource, res);
 }
 
 static void resource_test_insert_resource(struct kunit *test, struct resource *parent,
@@ -202,11 +212,11 @@ static void resource_test_insert_resource(struct kunit *test, struct resource *p
 	res->end = start + size - 1;
 	res->flags = flags;
 	if (insert_resource(parent, res)) {
-		kfree(res);
+		resource_test_add_action_or_abort(test, kfree_wrapper, res);
 		KUNIT_FAIL_AND_ABORT(test, "Fail to insert resource %pR\n", res);
 	}
 
-	kunit_add_action_or_reset(test, remove_free_resource, res);
+	resource_test_add_action_or_abort(test, remove_free_resource, res);
 }
 
 static void resource_test_region_intersects(struct kunit *test)
@@ -220,7 +230,7 @@ static void resource_test_region_intersects(struct kunit *test)
 				       "test resources");
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
 	start = parent->start;
-	kunit_add_action_or_reset(test, remove_free_resource, parent);
+	resource_test_add_action_or_abort(test, remove_free_resource, parent);
 
 	resource_test_request_region(test, parent, start + RES_TEST_RAM0_OFFSET,
 				     RES_TEST_RAM0_SIZE, "Test System RAM 0", flags);
-- 
2.39.2


