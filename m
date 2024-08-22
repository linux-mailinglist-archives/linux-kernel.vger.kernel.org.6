Return-Path: <linux-kernel+bounces-297622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA73395BB86
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2BD9288031
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730721CDFA3;
	Thu, 22 Aug 2024 16:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gxi4aKZU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8A91CB300;
	Thu, 22 Aug 2024 16:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724343302; cv=none; b=iOlUEfuK9YgQ/cELi5gtdXG6B/hcVNKZ/BLfT4tUcS03ZQHzEgun8190VYR71M/GgLUCFb+4VdG6iB+wSAEdiBQF4QcDfifYyZr/6D8XcVqW04i8Lvy8XD5TQsaE6bEytDIzBXlSBFDslPdbPd2b784jeLmuWvY1aLZJBcffMik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724343302; c=relaxed/simple;
	bh=FF0VDIiosakR+PVPaqNYv9wsI4N3gnvo5w//z1e7Pfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WgXP/Yz5P9TgSYPqEQn9hKQpXjBNhCHq1W9q+VSgUZJD0cMGAAPyqCCYqFwchMq6w+hk/3MbB3fNmCeJIwjCZgz1vy2zU91DQilPEbgcwiJeqQeg3mDuAxPZjA3klIK5Q+/vvvsWwz/24hTcUFWu+2s5UxctW1l4DG4MjvMTVuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gxi4aKZU; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724343302; x=1755879302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FF0VDIiosakR+PVPaqNYv9wsI4N3gnvo5w//z1e7Pfw=;
  b=gxi4aKZUNd82ZKKmoQRdFO/wnqYvSrVzjj9iWuGObZEZdvZ/0vcDqinI
   bwFKHcwWXAi4nrUOQ+DafsdIU2ewGGayDrCoXHpOMZnIBSskRqRouATZc
   gTAaHCyab24jO/5lMCVwe+C3QRJaFurEKvRqlomOztU09Er6hFNCDD8Va
   E+pYMzu1286kUQ+bRlogNJTYq4DwLnJPxe9Ut5jPey9cw7zDzgsXE+rtF
   fMT5K+JlgA2PXCCIphjNKTKfq1evI2E1UMx7WfYoEveoVPYuBh/UgzZNU
   t8DW/mO71fb2jKTHycSY14ae8FXMpTqNqXUuxJWt5Z7TpsmabJZrunNsi
   A==;
X-CSE-ConnectionGUID: /WQkN7UBRSqKBDRm1DqvXg==
X-CSE-MsgGUID: yNx76kaERnSaJ7aS+WqPqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="40237247"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="40237247"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 09:15:00 -0700
X-CSE-ConnectionGUID: 0tlxdegFTXGdBISSHKftsA==
X-CSE-MsgGUID: FsrnEt72Snign6a2Cyro4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="66425276"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 22 Aug 2024 09:14:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 14D3E268; Thu, 22 Aug 2024 19:14:56 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v1 1/2] clk: x86: lpss-atom: Use predefined constants from units.h
Date: Thu, 22 Aug 2024 19:14:07 +0300
Message-ID: <20240822161452.1780149-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240822161452.1780149-1-andriy.shevchenko@linux.intel.com>
References: <20240822161452.1780149-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use predefined constants from units.h to make code robust against typos
like how many zeros to put.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/clk/x86/clk-lpss-atom.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/x86/clk-lpss-atom.c b/drivers/clk/x86/clk-lpss-atom.c
index aa9d0bb98f8b..c70088be72d1 100644
--- a/drivers/clk/x86/clk-lpss-atom.c
+++ b/drivers/clk/x86/clk-lpss-atom.c
@@ -12,20 +12,24 @@
 #include <linux/module.h>
 #include <linux/platform_data/x86/clk-lpss.h>
 #include <linux/platform_device.h>
+#include <linux/units.h>
 
 static int lpss_atom_clk_probe(struct platform_device *pdev)
 {
 	struct lpss_clk_data *drvdata;
 	struct clk *clk;
+	u32 rate;
 
 	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
 		return -ENOMEM;
 
+	/* Default frequency is 100MHz */
+	rate = 100 * HZ_PER_MHZ;
+
 	/* LPSS free running clock */
 	drvdata->name = "lpss_clk";
-	clk = clk_register_fixed_rate(&pdev->dev, drvdata->name, NULL,
-				      0, 100000000);
+	clk = clk_register_fixed_rate(&pdev->dev, drvdata->name, NULL, 0, rate);
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


