Return-Path: <linux-kernel+bounces-367872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF07D9A07D3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DB0FB26B98
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF162076C8;
	Wed, 16 Oct 2024 10:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NQ3GDTad"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA86A20697A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 10:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729075941; cv=none; b=NbeKnQY0+SRUQeWXLeVJWZ1Lf484gRM0POmToLch2O/w6E0iHGclx2D097FthFnvmZYrNKvWMA/KnZqZ5qQI1/uArV6znDrO2AEkTkhM0IgFN1iRIJNwgpSj22w8AgKQW2oBj4/oKauD80rjE2XGk6jdGRaNdH5Vyst3VRBKD/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729075941; c=relaxed/simple;
	bh=k2E+W1Blaw/I3rKlkRTqHbOxfFTC4GWOb6JoYS5d3qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9KfZjWKZv7cd51ndL8zasjXx/7Iv+I0bk3HF4tonoRBaNRoAr1L9PyVArpVZZgFlef8pEn0KxW/DbUoO2VFnx1kpG7dMmAL26DKlAkEJSVjPxCZXCbYj+qzbi2+TlFyU9+fBQIkpjf4Pu7teoGXwveMXeg2Q0UoabKaD/JHHGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NQ3GDTad; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729075940; x=1760611940;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k2E+W1Blaw/I3rKlkRTqHbOxfFTC4GWOb6JoYS5d3qw=;
  b=NQ3GDTadojwgVxfw71N30YdjjBK9dg9fjm6POIV1OQPlakKhLlt5pBiP
   TDlgOR1xYMBCJZEk4l3qktJ0zZRUCSC5FPmhsng5J+faW7u+LC6WKnLbK
   6NqTK5TqC9GE5yM8Ls37Kr528Mkca5BbZPg0kOjTgV0co/8YBVnBwqBPr
   7br8N0Ej66UAzwaQNT4Wr2Fn82k65iGci4dFvRGwqpG2seAIykb+qvPlH
   1NPc4DqKZUjvKJCPZbHo6G6Yb2EGpO/HLCUDxI4aqlY3xrrEwSLomvB3J
   SFGcb494+UK7TarjIbfJln1a9t3+l/r+MplUuO1jOgEkzpvG6BceWLaQa
   g==;
X-CSE-ConnectionGUID: Tj5PCmAmRWq7xSbnQ9z8pA==
X-CSE-MsgGUID: PCFrVGXCTEakzzHjIDnPjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="31382472"
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="31382472"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 03:52:05 -0700
X-CSE-ConnectionGUID: wfsqdfupQle48vKHGFQBgQ==
X-CSE-MsgGUID: /tTzzYUHQSKH7qTXrg8jHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="82740098"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 16 Oct 2024 03:52:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0BE15388; Wed, 16 Oct 2024 13:52:03 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH v1 3/4] mfd: intel_soc_pmic_bxtwc: Use temporary variable for struct device
Date: Wed, 16 Oct 2024 13:49:53 +0300
Message-ID: <20241016105201.757024-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241016105201.757024-1-andriy.shevchenko@linux.intel.com>
References: <20241016105201.757024-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a temporary variable for the struct device pointers to avoid
dereferencing. This makes code a bit neater.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel_soc_pmic_bxtwc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index 1469e89b88ce..5e6cffb162a0 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -434,15 +434,15 @@ static int bxtwc_add_chained_irq_chip(struct intel_soc_pmic *pmic,
 				const struct regmap_irq_chip *chip,
 				struct regmap_irq_chip_data **data)
 {
+	struct device *dev = pmic->dev;
 	int irq;
 
 	irq = regmap_irq_get_virq(pdata, pirq);
 	if (irq < 0)
-		return dev_err_probe(pmic->dev, irq, "Failed to get parent vIRQ(%d) for chip %s\n",
+		return dev_err_probe(dev, irq, "Failed to get parent vIRQ(%d) for chip %s\n",
 				     pirq, chip->name);
 
-	return devm_regmap_add_irq_chip(pmic->dev, pmic->regmap, irq, irq_flags,
-					0, chip, data);
+	return devm_regmap_add_irq_chip(dev, pmic->regmap, irq, irq_flags, 0, chip, data);
 }
 
 static int bxtwc_add_chained_devices(struct intel_soc_pmic *pmic,
-- 
2.43.0.rc1.1336.g36b5255a03ac


