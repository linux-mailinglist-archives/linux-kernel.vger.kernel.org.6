Return-Path: <linux-kernel+bounces-297621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E7E95BB98
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7366B2A592
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF8413C9CB;
	Thu, 22 Aug 2024 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MXn9DUHD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E841DDF4;
	Thu, 22 Aug 2024 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724343301; cv=none; b=faCoJSUZbghBkhkt4HqVpWA1vVwt5zLnKh6zoUN77RqXnD0Rod2N5gTImgwreXHsL9StE5UrcVGsRycbBAjeZZOVjafMgEf4U+7bG22HoPoAuq+SKj/VCUZBJnzhpTQ5Tjbojjb0LRH0YOfOgiTH9pobkUH3oF8wAu8R0y7hUsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724343301; c=relaxed/simple;
	bh=k+95UCNA2v0C0pm80mB06e3RVsToOTRByKAER4CdQKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N558/RcJ5jLNBVR1znk5gCrSIy7arzcq7Kpm+ECqS+Y5zw+YacAJO0NCIC5VNjrDxz4dQXqDelR7XK+IRlFinE2nuoWlr+a/Z8C+4i67VoDOfNZLJWg3d49M90HyF3GLgE16pk4za1GjQ1RGlv5B5KpNjYacBPwr6z+NFV8VwxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MXn9DUHD; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724343301; x=1755879301;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k+95UCNA2v0C0pm80mB06e3RVsToOTRByKAER4CdQKs=;
  b=MXn9DUHDcnasVTHg6ZUriZXTD3eyiu57w7EaS9phn7RCIMHBE8oQe+/4
   uM5RyyrkCkfC6AJ7MbCNb9wMsUSu5L6ZVM7J2A6WlxUqWyycu/c+u1oS2
   zq9pCC7GmHvGWcsJb1WEhs5WrhlNA+iWYYw2FObodWeC6TFt7uOeD23b5
   PG7crailKJikReEtzETJVD4G4ET/mFzOqlKAeopHLbpTNhV/G5kFxLBsK
   5zigC9Ingsbsg/DGxfSPYqaV0lczDuMuEM+CqhL5V90myCR2ZrIinev6C
   n5w+mvWog2a175WUmAXoyrEOpA4cj8OWcxPFHQ0RZWg/omwBzk7+pSvmX
   Q==;
X-CSE-ConnectionGUID: hyT8hgtBTja4KIaVz5LVUQ==
X-CSE-MsgGUID: EqdmJ7YQSYKa7zX+inkvGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="33341686"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="33341686"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 09:14:59 -0700
X-CSE-ConnectionGUID: xH5VsMGCT6usrv27Khlitw==
X-CSE-MsgGUID: G0ymy9IGS3mu9YsKX3cObw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="61348637"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 22 Aug 2024 09:14:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1EBB42F2; Thu, 22 Aug 2024 19:14:56 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v1 2/2] clk: x86: lpss-atom: Use temporary variable for struct device
Date: Thu, 22 Aug 2024 19:14:08 +0300
Message-ID: <20240822161452.1780149-3-andriy.shevchenko@linux.intel.com>
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

Use temporary variable for struct device to make code neater.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/clk/x86/clk-lpss-atom.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/x86/clk-lpss-atom.c b/drivers/clk/x86/clk-lpss-atom.c
index c70088be72d1..391a7d2e98e4 100644
--- a/drivers/clk/x86/clk-lpss-atom.c
+++ b/drivers/clk/x86/clk-lpss-atom.c
@@ -16,11 +16,12 @@
 
 static int lpss_atom_clk_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct lpss_clk_data *drvdata;
 	struct clk *clk;
 	u32 rate;
 
-	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
+	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
 		return -ENOMEM;
 
@@ -29,7 +30,7 @@ static int lpss_atom_clk_probe(struct platform_device *pdev)
 
 	/* LPSS free running clock */
 	drvdata->name = "lpss_clk";
-	clk = clk_register_fixed_rate(&pdev->dev, drvdata->name, NULL, 0, rate);
+	clk = clk_register_fixed_rate(dev, drvdata->name, NULL, 0, rate);
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


