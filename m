Return-Path: <linux-kernel+bounces-416955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1769D4CD8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 13:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9D231F22EC2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 12:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1861D7982;
	Thu, 21 Nov 2024 12:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S9WUDbgK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B959715ADB4
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 12:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732192485; cv=none; b=F6ztfpRiJp8j7ar4OKl0DlhldllW3uNrgMAgXCyb6mIseLEt5JWXAMS1xbxclQASvbcEMC41c8P4iBUajmA5AyeT29hOV0FJ625Zpz8VhL8e6bJACVfNayHXsD3v1bI3/8WqUTweoGbXrSwDQSSaZnHWJn4+ty4hpSt2/7E0SSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732192485; c=relaxed/simple;
	bh=s3FI6NDLHn+OOKtF/eUjk86BllrxhCELP6mnFqUsNAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ows0Ahegv0U3MYrkTdyPkt8xMnSE30cAaTe7RxaouSt/LWeZD/a41ZCx7brCF8B0vQH8e7ocNIwrMdDfinBIxQySGYi8EjmwqWtNQou3TPkarbl3ZPGT7vtjQdq94PlYI2C8Eoc1j3M37fbRY7Y1xhU5o+oF/awpno5FhTyU6oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S9WUDbgK; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732192484; x=1763728484;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s3FI6NDLHn+OOKtF/eUjk86BllrxhCELP6mnFqUsNAg=;
  b=S9WUDbgKejF2DRdJ9Gicmk2CpH8h/YR5YIVSJz+96MmFvwUnNgFbAFaV
   xyPRdaeyWUgvpqc1UP8K7qBbeP6xSnbDO4yHK7tpiifcVCnsMf4amen5P
   QNMjaX9IAF8rchOc6HrhNMjFBAX5sOdm2sx01U9m9BrM8v8z1layKEcaU
   btHzQjlvNDPpi/FEAQkf0wuiodGPtCA+YZ0Hmb+BgqkSljsURwpS9Gxo4
   E1TOWdx+Ecj6f1nOlKiu8IbWcOPtoEN+lRSGBw0LQF3/k3jvfczN5pKKn
   xdwZuD6grsYJ87xyTGB45GwrZRn0pTgZHaZB/E9rfYn8D3DxzQEb47KnN
   A==;
X-CSE-ConnectionGUID: geGPAwA2Q1S8c77asIpqbQ==
X-CSE-MsgGUID: e04NTb8vQfujsuyIMrMhJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="35968029"
X-IronPort-AV: E=Sophos;i="6.12,172,1728975600"; 
   d="scan'208";a="35968029"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 04:34:44 -0800
X-CSE-ConnectionGUID: eW+rkQ5aTIym1xPgI9y+2A==
X-CSE-MsgGUID: MMqwTU6vRc2ol++LDLkY9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,172,1728975600"; 
   d="scan'208";a="90646792"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 21 Nov 2024 04:34:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 183022CA; Thu, 21 Nov 2024 14:34:41 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 1/1] regmap: cache: rbtree: use krealloc_array() to replace krealloc()
Date: Thu, 21 Nov 2024 14:34:39 +0200
Message-ID: <20241121123439.4180167-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use krealloc_array() to replace krealloc() with multiplication.
krealloc_array() has multiply overflow check, which will be safer.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/regcache-rbtree.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/base/regmap/regcache-rbtree.c b/drivers/base/regmap/regcache-rbtree.c
index 188438186589..a9d17f316e55 100644
--- a/drivers/base/regmap/regcache-rbtree.c
+++ b/drivers/base/regmap/regcache-rbtree.c
@@ -275,18 +275,16 @@ static int regcache_rbtree_insert_to_block(struct regmap *map,
 	pos = (reg - base_reg) / map->reg_stride;
 	offset = (rbnode->base_reg - base_reg) / map->reg_stride;
 
-	blk = krealloc(rbnode->block,
-		       blklen * map->cache_word_size,
-		       map->alloc_flags);
+	blk = krealloc_array(rbnode->block, blklen, map->cache_word_size, map->alloc_flags);
 	if (!blk)
 		return -ENOMEM;
 
 	rbnode->block = blk;
 
 	if (BITS_TO_LONGS(blklen) > BITS_TO_LONGS(rbnode->blklen)) {
-		present = krealloc(rbnode->cache_present,
-				   BITS_TO_LONGS(blklen) * sizeof(*present),
-				   map->alloc_flags);
+		present = krealloc_array(rbnode->cache_present,
+					 BITS_TO_LONGS(blklen), sizeof(*present),
+					 map->alloc_flags);
 		if (!present)
 			return -ENOMEM;
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


