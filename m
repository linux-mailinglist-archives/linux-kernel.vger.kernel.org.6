Return-Path: <linux-kernel+bounces-367869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4629A07D0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14DB11F2188C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F1C2071EE;
	Wed, 16 Oct 2024 10:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hYFvuJmF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1514B1CACDB
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 10:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729075927; cv=none; b=EpcPaEDt96pcKi+fAbU6V94oASx5ShqdwSOLdE1NO4iMJBXdU1bWstccmkHS2Er9E/8kEHnlCjWf32vfK7Cv2M/WF7v82KLfP47u7ppgqeghGAIfOP5+6dmmp//qyb5KKTp630saKOjUsngcLUcop0tSOhLFrhNPLaAH0R9Vsg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729075927; c=relaxed/simple;
	bh=C37zMoRvT7ptp1nf+FGWQBF+/uvvk9C/Aw3oL1cr7bU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JlEwRrMUcAmJCoNGmI+IzKpuqdWryEAg8uWaS9f8ACKnYMmTmhwNTABYJrfimrKcMK34oFYtMQ350Q2hGbGIauPxlGEzZqPxTTTac0SvvtwfzuCZPpLtPFSvXPDEyNRu3BizbhH4U+qJcxQwMVHTMivBnml3BOxXYJOWgZ2ekhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hYFvuJmF; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729075926; x=1760611926;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C37zMoRvT7ptp1nf+FGWQBF+/uvvk9C/Aw3oL1cr7bU=;
  b=hYFvuJmFkpI1prRAUDzJjWq4RH+wkeW4vTiU/Sfit0eSMpuHZqeEZcMg
   HYfCuxOtCKLBdho+FUEYsNoTzoLma5Fc1aXWVTf4YRzsz9yVx1F80WjEE
   Q0W+BV2o0YhcjrgKTwz+nq5EUU8ovzmo1VDXM2E5/FPXc7/z/OpYOjViq
   TI2IPk4C/YVGVlB4GtORGQRw38ITWXVak4KgquFo5PqqkkukorTv6ItMM
   PS8zJuhUj+J9XIGeSxdGo/B/IDlcVhZoAXIHmBrkh2tMoK8TlLVT5167l
   9nFpTfRyQxaZs0QYih58maPQM+5Ea2FWXY+ZIe7bPxOq1ZlhUjNBMWEwn
   g==;
X-CSE-ConnectionGUID: d1f2o07QS1q138vS83EWUQ==
X-CSE-MsgGUID: QKf9BOFKT56hRDdzHmckcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="28645804"
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="28645804"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 03:52:05 -0700
X-CSE-ConnectionGUID: leKeOUS4QcmfnwU8ZVjcAQ==
X-CSE-MsgGUID: mj6obJL1QgKbhLK5cTAY9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="115631221"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 16 Oct 2024 03:52:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 150655A7; Wed, 16 Oct 2024 13:52:03 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH v1 4/4] mfd: intel_soc_pmic_bxtwc: Deduplicate error messages
Date: Wed, 16 Oct 2024 13:49:54 +0300
Message-ID: <20241016105201.757024-5-andriy.shevchenko@linux.intel.com>
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

Move the individual error messages inside bxtwc_add_chained_irq_chip()
in order to deduplicate them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel_soc_pmic_bxtwc.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index 5e6cffb162a0..cc4056a64dbd 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -435,14 +435,18 @@ static int bxtwc_add_chained_irq_chip(struct intel_soc_pmic *pmic,
 				struct regmap_irq_chip_data **data)
 {
 	struct device *dev = pmic->dev;
-	int irq;
+	int irq, ret;
 
 	irq = regmap_irq_get_virq(pdata, pirq);
 	if (irq < 0)
 		return dev_err_probe(dev, irq, "Failed to get parent vIRQ(%d) for chip %s\n",
 				     pirq, chip->name);
 
-	return devm_regmap_add_irq_chip(dev, pmic->regmap, irq, irq_flags, 0, chip, data);
+	ret = devm_regmap_add_irq_chip(dev, pmic->regmap, irq, irq_flags, 0, chip, data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add %s IRQ chip\n", chip->name);
+
+	return 0;
 }
 
 static int bxtwc_add_chained_devices(struct intel_soc_pmic *pmic,
@@ -458,7 +462,7 @@ static int bxtwc_add_chained_devices(struct intel_soc_pmic *pmic,
 
 	ret = bxtwc_add_chained_irq_chip(pmic, pdata, pirq, irq_flags, chip, data);
 	if (ret)
-		return dev_err_probe(dev, ret, "Failed to add %s IRQ chip\n", chip->name);
+		return ret;
 
 	domain = regmap_irq_get_domain(*data);
 
@@ -521,7 +525,7 @@ static int bxtwc_probe(struct platform_device *pdev)
 					 &bxtwc_regmap_irq_chip_pwrbtn,
 					 &pmic->irq_chip_data_pwrbtn);
 	if (ret)
-		return dev_err_probe(dev, ret, "Failed to add PWRBTN IRQ chip\n");
+		return ret;
 
 	ret = bxtwc_add_chained_devices(pmic, bxt_wc_bcu_dev, ARRAY_SIZE(bxt_wc_bcu_dev),
 					pmic->irq_chip_data,
@@ -557,7 +561,7 @@ static int bxtwc_probe(struct platform_device *pdev)
 					 &bxtwc_regmap_irq_chip_crit,
 					 &pmic->irq_chip_data_crit);
 	if (ret)
-		return dev_err_probe(dev, ret, "Failed to add CRIT IRQ chip\n");
+		return ret;
 
 	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE, bxt_wc_dev, ARRAY_SIZE(bxt_wc_dev),
 				   NULL, 0, NULL);
-- 
2.43.0.rc1.1336.g36b5255a03ac


