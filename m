Return-Path: <linux-kernel+bounces-368575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1527C9A1185
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 20:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDE4928832C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C7C2144B4;
	Wed, 16 Oct 2024 18:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CTTTlqs2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3437F2139C4
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 18:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729103208; cv=none; b=M2OzOHGWLWNXUzHXpV38tWi/qf1S5oR4cuMTxBYY3F1pZQ+BLJycmtDSw8u6gL9/oMaAba7hg7mLbWRj8dhvHJONTQPS9f95oVMj9qToIgeAgRYfQ1myxNp8neio5jUxoCQNz3xwiLaGL/4EdLCctpXg2M50dcbhSsFmY3GEnQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729103208; c=relaxed/simple;
	bh=i+jlu5IJcAwS1nR30IqBmViiQ/7hLgqTK8ynQICvJdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U8Djybzi6jvYqMquDHRW4mTfXbkFlktiQwRgKDqtT0kTMoqkBwetJbnq37rXHiLksiyfnbpbW5sye3+xv8/sv/Ltiwq4PgeE4hWsWRft8EcIWvyctlhe+TbzSHhAobPJWVh3c02xiBMipX6T0jgz0AfK+CBTVXVCa2zQPhzMhg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CTTTlqs2; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729103207; x=1760639207;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i+jlu5IJcAwS1nR30IqBmViiQ/7hLgqTK8ynQICvJdY=;
  b=CTTTlqs2pDvyO6+LihlUSSDbXVRpkhwytwAstx0193MVwXASO4g6RbBU
   OIsO3Q7CgmYm+37DuwG3TvY+FTi0dcMEm/9UAekRAaVDM/jthnPpJeBF4
   wgnaOVQa0aaJ0/YygHOWxU8DPt0WgDHrcB32MzNeTZn61uwiOVRZJwh2D
   TTor8mTrE4nvo/oC6Su8u9IAvPyjmcQ1YnE8SCc9q/Tz6gaAZrJ2d/gmN
   wJSHBJTfWPxEEo0rsaIYHTfHa7YYbJggmdJxuswAjbtYblvLy1K1+wqxU
   WeqCmOcJYFu4ZwpEj6Ow9WTuMVL+VM9LvCZhs6U0InRvE/cWGrpuV0427
   w==;
X-CSE-ConnectionGUID: dPDaXa4KQImKXk+S5QOi+Q==
X-CSE-MsgGUID: R/YbT0y/QKi+6et1Scv1lQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39686016"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39686016"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 11:26:44 -0700
X-CSE-ConnectionGUID: qOkdTDljSWaCVjpBCK00fg==
X-CSE-MsgGUID: Ogdlfdq1TzORnKxcVJdobw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="78269525"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 16 Oct 2024 11:26:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 7CE681C4; Wed, 16 Oct 2024 21:26:38 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ingo Molnar <mingo@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 2/2] percpu: Add a test case for the specific 64-bit value addition
Date: Wed, 16 Oct 2024 21:23:52 +0300
Message-ID: <20241016182635.1156168-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241016182635.1156168-1-andriy.shevchenko@linux.intel.com>
References: <20241016182635.1156168-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It might be a corner case when we add UINT_MAX as 64-bit unsigned value
to the percpu variable as it's not the same as -1 (ULONG_LONG_MAX).
Add a test case for that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/percpu_test.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/lib/percpu_test.c b/lib/percpu_test.c
index 4a3d70bbc1a0..ce7124b16dab 100644
--- a/lib/percpu_test.c
+++ b/lib/percpu_test.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <linux/limits.h>
 #include <linux/module.h>
 
 /* validate @native and @pcp counter values match @expected */
@@ -24,8 +25,9 @@ static int __init percpu_test_init(void)
 	 * +ul_one/-ul_one below would replace with inc/dec instructions.
 	 */
 	volatile unsigned int ui_one = 1;
-	long l = 0;
+	unsigned long long ull = 0;
 	unsigned long ul = 0;
+	long l = 0;
 
 	pr_info("percpu test start\n");
 
@@ -112,6 +114,13 @@ static int __init percpu_test_init(void)
 	CHECK(ul, ulong_counter, -1);
 	CHECK(ul, ulong_counter, ULONG_MAX);
 
+	ul = ull = 0;
+	__this_cpu_write(ulong_counter, 0);
+
+	ul = ull += UINT_MAX;
+	__this_cpu_add(ulong_counter, ull);
+	CHECK(ul, ulong_counter, UINT_MAX);
+
 	ul = 3;
 	__this_cpu_write(ulong_counter, 3);
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


