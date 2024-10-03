Return-Path: <linux-kernel+bounces-349409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D816698F57F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 19:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4184AB2112D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD08E1ABEDA;
	Thu,  3 Oct 2024 17:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TP2pi0dE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ABE1AAE00;
	Thu,  3 Oct 2024 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727977426; cv=none; b=IdP/RRKYjQFtCPYYbVEtdBD79u/DikEVZS37dg1m52KamZy6bMPYBQ4lO4oo7QsUhJLXsdULbpOJloFLkZpMDSjOyrPygOM8/K8CyseL8QjfOtolHuvhj3xW8wWcoIN1fuG8NsSzIeQRrk2XPYW3eNjsow8jC1pnGeLa8200fcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727977426; c=relaxed/simple;
	bh=jXy97VROcWIdRwcHgGwxxGFJVXFoPdWZmEEoWE2/50U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=de9owf7pAqiZt37dv5Bod6AfIlKceFPLVepExXxOlUlRELCMQRG6VG1Ue8lZx3BLrbgl261KngIhjk9EOGA0N/8XCrwi3HYL+sDGm5jTGQ2zePFLsUCbvUXLAI1neeKpS7RU+tsOURtlebH5rctPsF21Cnfq093cc6ym/8FIePg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TP2pi0dE; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727977425; x=1759513425;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jXy97VROcWIdRwcHgGwxxGFJVXFoPdWZmEEoWE2/50U=;
  b=TP2pi0dEE5yk5Z3PBkggsLl97LEKPpnZADwsQLkl1CL+kOnu9EV6PTdn
   9MBkyVGDo4Z9zwpPiXOGGswcGhg2Qsws5Ncc62nW9Jp4Ur5B0wgMnIdaE
   84JbbXYNnM7XWDLliYzofhk/Y43lKO7ECR3I4VaxtJE2ZdG3dmSXzZ2ND
   QfHl/U6hxpw9Lzg1f07cdM0TGHNR5Q1FVrnt9BC/Ngg8sts51micpFtVJ
   RsfncQpS19M1q+SjIB16mObaxQu+POBMM6rQsbv31p/dowXbMsXPdyO8I
   zlMalv4EjW0J9/TL5C1Q3v7cTeRZYLK1OkZXfVhKVoBu2eXJ5U9baEYoN
   A==;
X-CSE-ConnectionGUID: BCoLNv/wThKR1HteaFK/xA==
X-CSE-MsgGUID: KkHmvbarT/uZwQzWRn3ARg==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="49714628"
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="49714628"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 10:43:42 -0700
X-CSE-ConnectionGUID: ZArQMG2CS62tPa5cZ90oVg==
X-CSE-MsgGUID: noBB7BZXRWu9rzfEwkuK6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="79396011"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 03 Oct 2024 10:43:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 98D9F37D; Thu, 03 Oct 2024 20:43:37 +0300 (EEST)
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
Subject: [PATCH v1 2/4] mfd: intel_soc_pmic_bxtwc: Use IRQ domain for TMU device
Date: Thu,  3 Oct 2024 20:32:02 +0300
Message-ID: <20241003174252.1190628-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241003174252.1190628-2-andriy.shevchenko@linux.intel.com>
References: <20241003174252.1190628-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While design wise the idea of converting the driver to use
the hierarchy of the IRQ chips is correct, the implementation
has (inherited) flaws. This was unvelead when platform_get_irq()
had started WARN() on IRQ 0 that is supposed to be a Linux
IRQ number (also known as vIRQ).

Rework the driver to respect IRQ domain when creating each MFD
device separately, as the domain is not the same for all of them.

Fixes: 957ae5098185 ("platform/x86: Add Whiskey Cove PMIC TMU support")
Fixes: 57129044f504 ("mfd: intel_soc_pmic_bxtwc: Use chained IRQs for second level IRQ chips")
Reported-by: Zhang Ning <zhangn1985@outlook.com>
Closes: https://lore.kernel.org/r/TY2PR01MB3322FEDCDC048B7D3794F922CDBA2@TY2PR01MB3322.jpnprd01.prod.outlook.com
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


