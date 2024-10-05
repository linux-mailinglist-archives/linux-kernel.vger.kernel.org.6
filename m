Return-Path: <linux-kernel+bounces-352080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0899E9919E6
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 21:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 900EB1F2210E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 19:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B43160883;
	Sat,  5 Oct 2024 19:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FZ3pRf/H"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9C014B08E;
	Sat,  5 Oct 2024 19:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728156638; cv=none; b=OBJ0LQbMmHs2R+CuXyPEk/d9HW5y0rgHb0b3mg9t/cD+nFp7iZ3padhj8tLlx/+SOuGlafBLfuFEIeAOCx+vkvtvocYZqJQTxHxCXqrzU3atVGlkr1+FWKuGrhaT3y2vuEKh4MIDCVD+15beNH5cYsUaueTvP7rlmS2y03lqyd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728156638; c=relaxed/simple;
	bh=Y9sjx62Q4cXe4/rdkl6Pdu0lSNdvUu2WsoQ0DWbxgp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ovf5udxraHoTComBj2iU0B+OpOhpettXOSPOHq1Eb8jFfhQab48Q6ls+CwOE/Ofc5C/+ebb1znTSAmWg6mCLNZPbtHayal5OBBABJe5W7K5BYDgUhjFb7SdW72SdBnTtzgIO7uGb26Y+ZPuJgp7YX+TE2JBZdD2ui1hjvyF3aI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FZ3pRf/H; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728156637; x=1759692637;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y9sjx62Q4cXe4/rdkl6Pdu0lSNdvUu2WsoQ0DWbxgp0=;
  b=FZ3pRf/HEFz7Y+Qvlsbfjyrc+brdHMYhCUMEa5PddDZmv0g0BRfYAk5E
   yk6tf1m071NKxmi/R/cA9I30EOq+jnOewJ1kUjcubnZqpkgzKdI5NgwjL
   uPUVhjNhJmdCCSUeX1vFAhCSq1NodzCYY3sZF/0pd7EdfVCE5FrTCwCk9
   rDxIxWi5Z4Ai+qVvJastH0dg+pPLXI04510ErkCtSMwuVpIzb4+5VRtqt
   QBEFa7gCAVd7I5jk3pfXn7S28D7SE5R8dDHZZkO076hNxB35gvHwCR0Pk
   KTWmn56qg904pmFdb9LLpuTqpg5IggGFLfwR1LEvR15y0PwvSfZkrHUHr
   w==;
X-CSE-ConnectionGUID: nSmq2tX8QyO+XIC3PgXuyA==
X-CSE-MsgGUID: s/S3CdN/Txue+Ry0w9mMOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11216"; a="38484394"
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; 
   d="scan'208";a="38484394"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2024 12:30:36 -0700
X-CSE-ConnectionGUID: H7P4rn/PQgaMR+BLoRBuNA==
X-CSE-MsgGUID: UhJc8n8fQL+d8Ha0gbnqCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; 
   d="scan'208";a="74618668"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 05 Oct 2024 12:30:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id EEDAC3A6; Sat, 05 Oct 2024 22:30:31 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Zhang Ning <zhangn1985@outlook.com>
Subject: [PATCH v2 2/4] mfd: intel_soc_pmic_bxtwc: Use IRQ domain for TMU device
Date: Sat,  5 Oct 2024 22:27:05 +0300
Message-ID: <20241005193029.1929139-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241005193029.1929139-1-andriy.shevchenko@linux.intel.com>
References: <20241005193029.1929139-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While design wise the idea of converting the driver to use
the hierarchy of the IRQ chips is correct, the implementation
has (inherited) flaws. This was unveiled when platform_get_irq()
had started WARN() on IRQ 0 that is supposed to be a Linux
IRQ number (also known as vIRQ).

Rework the driver to respect IRQ domain when creating each MFD
device separately, as the domain is not the same for all of them.

Fixes: 957ae5098185 ("platform/x86: Add Whiskey Cove PMIC TMU support")
Fixes: 57129044f504 ("mfd: intel_soc_pmic_bxtwc: Use chained IRQs for second level IRQ chips")
Reported-by: Zhang Ning <zhangn1985@outlook.com>
Closes: https://lore.kernel.org/r/TY2PR01MB3322FEDCDC048B7D3794F922CDBA2@TY2PR01MB3322.jpnprd01.prod.outlook.com
Tested-by: Zhang Ning <zhangn1985@outlook.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel_soc_pmic_bxtwc.c     | 31 ++++++++++++++------------
 drivers/platform/x86/intel/bxtwc_tmu.c | 22 +++++-------------
 2 files changed, 23 insertions(+), 30 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index d72995a9e820..628108dcf545 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -245,12 +245,6 @@ static struct mfd_cell bxt_wc_dev[] = {
 		.num_resources = ARRAY_SIZE(bcu_resources),
 		.resources = bcu_resources,
 	},
-	{
-		.name = "bxt_wcove_tmu",
-		.num_resources = ARRAY_SIZE(tmu_resources),
-		.resources = tmu_resources,
-	},
-
 	{
 		.name = "bxt_wcove_gpio",
 		.num_resources = ARRAY_SIZE(gpio_resources),
@@ -261,6 +255,14 @@ static struct mfd_cell bxt_wc_dev[] = {
 	},
 };
 
+static const struct mfd_cell bxt_wc_tmu_dev[] = {
+	{
+		.name = "bxt_wcove_tmu",
+		.num_resources = ARRAY_SIZE(tmu_resources),
+		.resources = tmu_resources,
+	},
+};
+
 static struct mfd_cell bxt_wc_chgr_dev[] = {
 	{
 		.name = "bxt_wcove_usbc",
@@ -489,6 +491,15 @@ static int bxtwc_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to add IRQ chip\n");
 
+	ret = bxtwc_add_chained_devices(pmic, bxt_wc_tmu_dev, ARRAY_SIZE(bxt_wc_tmu_dev),
+					pmic->irq_chip_data,
+					BXTWC_TMU_LVL1_IRQ,
+					IRQF_ONESHOT,
+					&bxtwc_regmap_irq_chip_tmu,
+					&pmic->irq_chip_data_tmu);
+	if (ret)
+		return ret;
+
 	ret = bxtwc_add_chained_irq_chip(pmic, pmic->irq_chip_data,
 					 BXTWC_PWRBTN_LVL1_IRQ,
 					 IRQF_ONESHOT,
@@ -497,14 +508,6 @@ static int bxtwc_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to add PWRBTN IRQ chip\n");
 
-	ret = bxtwc_add_chained_irq_chip(pmic, pmic->irq_chip_data,
-					 BXTWC_TMU_LVL1_IRQ,
-					 IRQF_ONESHOT,
-					 &bxtwc_regmap_irq_chip_tmu,
-					 &pmic->irq_chip_data_tmu);
-	if (ret)
-		return dev_err_probe(dev, ret, "Failed to add TMU IRQ chip\n");
-
 	/* Add chained IRQ handler for BCU IRQs */
 	ret = bxtwc_add_chained_irq_chip(pmic, pmic->irq_chip_data,
 					 BXTWC_BCU_LVL1_IRQ,
diff --git a/drivers/platform/x86/intel/bxtwc_tmu.c b/drivers/platform/x86/intel/bxtwc_tmu.c
index d0e2a3c293b0..9ac801b929b9 100644
--- a/drivers/platform/x86/intel/bxtwc_tmu.c
+++ b/drivers/platform/x86/intel/bxtwc_tmu.c
@@ -48,9 +48,8 @@ static irqreturn_t bxt_wcove_tmu_irq_handler(int irq, void *data)
 static int bxt_wcove_tmu_probe(struct platform_device *pdev)
 {
 	struct intel_soc_pmic *pmic = dev_get_drvdata(pdev->dev.parent);
-	struct regmap_irq_chip_data *regmap_irq_chip;
 	struct wcove_tmu *wctmu;
-	int ret, virq, irq;
+	int ret;
 
 	wctmu = devm_kzalloc(&pdev->dev, sizeof(*wctmu), GFP_KERNEL);
 	if (!wctmu)
@@ -59,27 +58,18 @@ static int bxt_wcove_tmu_probe(struct platform_device *pdev)
 	wctmu->dev = &pdev->dev;
 	wctmu->regmap = pmic->regmap;
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
+	wctmu->irq = platform_get_irq(pdev, 0);
+	if (wctmu->irq < 0)
+		return wctmu->irq;
 
-	regmap_irq_chip = pmic->irq_chip_data_tmu;
-	virq = regmap_irq_get_virq(regmap_irq_chip, irq);
-	if (virq < 0) {
-		dev_err(&pdev->dev,
-			"failed to get virtual interrupt=%d\n", irq);
-		return virq;
-	}
-
-	ret = devm_request_threaded_irq(&pdev->dev, virq,
+	ret = devm_request_threaded_irq(&pdev->dev, wctmu->irq,
 					NULL, bxt_wcove_tmu_irq_handler,
 					IRQF_ONESHOT, "bxt_wcove_tmu", wctmu);
 	if (ret) {
 		dev_err(&pdev->dev, "request irq failed: %d,virq: %d\n",
-							ret, virq);
+			ret, wctmu->irq);
 		return ret;
 	}
-	wctmu->irq = virq;
 
 	/* Unmask TMU second level Wake & System alarm */
 	regmap_update_bits(wctmu->regmap, BXTWC_MTMUIRQ_REG,
-- 
2.43.0.rc1.1336.g36b5255a03ac


