Return-Path: <linux-kernel+bounces-349407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E9598F57A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 19:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EFAA282F40
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A3A1AB6D4;
	Thu,  3 Oct 2024 17:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y7fDcsfF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DFD1AAE18;
	Thu,  3 Oct 2024 17:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727977425; cv=none; b=mtToxJZkGwIwd/X1ZN8JyMquvJkaQvpGl3nsIF2j7bFVV0Ra5hydkWPoaOGsKtoFUVCi/WSfsOWVFmkabRWkGZMZAZsWM+I2InC8bgnMdmrsTCUb64B0Wy8blPzoLpox9zUGfmLyFdG6dpm0WhCNQpm+cD2mdqWSf2/P79Iwwvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727977425; c=relaxed/simple;
	bh=KRtUtggjBlkantmKIpP6QgKuWIRoSA/mW5QsLa3zxZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4yvIJkwEqbtTqhVfcOI+m1xj/CJ3R0r2TT+9+eLEDfZ+Xz3pXWboEFeSAAWg7lAbrrBLjXHeFqzXgpXcMytg0dXFeK00Cw3aVpb0pV/eQLfKYAklCBzakHXGRQ5Y4Bg8md0gjPil5hfMq5nmVDwTvdoyWiZoljZzPG90rNta5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y7fDcsfF; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727977424; x=1759513424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KRtUtggjBlkantmKIpP6QgKuWIRoSA/mW5QsLa3zxZE=;
  b=Y7fDcsfFzKlgv+KRdvi8aYmTabwm43CVHP/6afuXGQjuqjgs28uU1TeN
   rvm+wDbxB8PVraCbOK95t8Bn/MNfcrrBhmrOdolYytk6V69shTuP6OmkW
   8tIOlroXTv4+MacKBPAcix3gcO0Lmw8oHV5x+9CLQa3+Ll499V+C0ev0U
   Mqm7p6IpCiu41DmL688HzxpP9uIJvlnax51Ihy2/aakvkg6J11eUqJb92
   FN2mNITR0l3Zmti60O1pAENAPR/5q6w6XDtKMIKQRBhMFY02iZaCUINN1
   AZwd6JXhCCYveNp3d+U63X+CnFM2WYF9c/wvNfPt1WybUD2WzueyHygXM
   A==;
X-CSE-ConnectionGUID: 8UIJK7o7RDiVpKp8fSUYgg==
X-CSE-MsgGUID: Bz5nBVaBQUC1ib3cMhxzXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="27074221"
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="27074221"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 10:43:41 -0700
X-CSE-ConnectionGUID: jgsehtEaTSaZNuD1lLIvBg==
X-CSE-MsgGUID: r9/RoGguS3CYE0tjFDmf0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="74116152"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 03 Oct 2024 10:43:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A3A1B3A3; Thu, 03 Oct 2024 20:43:37 +0300 (EEST)
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 3/4] mfd: intel_soc_pmic_bxtwc: Use IRQ domain for PMIC devices
Date: Thu,  3 Oct 2024 20:32:03 +0300
Message-ID: <20241003174252.1190628-5-andriy.shevchenko@linux.intel.com>
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

Fixes: 57129044f504 ("mfd: intel_soc_pmic_bxtwc: Use chained IRQs for second level IRQ chips")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel_soc_pmic_bxtwc.c | 54 +++++++++++++++++-------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index 628108dcf545..fefbeb4164fd 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -230,21 +230,11 @@ static const struct resource tmu_resources[] = {
 };
 
 static struct mfd_cell bxt_wc_dev[] = {
-	{
-		.name = "bxt_wcove_gpadc",
-		.num_resources = ARRAY_SIZE(adc_resources),
-		.resources = adc_resources,
-	},
 	{
 		.name = "bxt_wcove_thermal",
 		.num_resources = ARRAY_SIZE(thermal_resources),
 		.resources = thermal_resources,
 	},
-	{
-		.name = "bxt_wcove_bcu",
-		.num_resources = ARRAY_SIZE(bcu_resources),
-		.resources = bcu_resources,
-	},
 	{
 		.name = "bxt_wcove_gpio",
 		.num_resources = ARRAY_SIZE(gpio_resources),
@@ -263,6 +253,22 @@ static const struct mfd_cell bxt_wc_tmu_dev[] = {
 	},
 };
 
+static const struct mfd_cell bxt_wc_bcu_dev[] = {
+	{
+		.name = "bxt_wcove_bcu",
+		.num_resources = ARRAY_SIZE(bcu_resources),
+		.resources = bcu_resources,
+	},
+};
+
+static const struct mfd_cell bxt_wc_adc_dev[] = {
+	{
+		.name = "bxt_wcove_gpadc",
+		.num_resources = ARRAY_SIZE(adc_resources),
+		.resources = adc_resources,
+	},
+};
+
 static struct mfd_cell bxt_wc_chgr_dev[] = {
 	{
 		.name = "bxt_wcove_usbc",
@@ -508,23 +514,23 @@ static int bxtwc_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to add PWRBTN IRQ chip\n");
 
-	/* Add chained IRQ handler for BCU IRQs */
-	ret = bxtwc_add_chained_irq_chip(pmic, pmic->irq_chip_data,
-					 BXTWC_BCU_LVL1_IRQ,
-					 IRQF_ONESHOT,
-					 &bxtwc_regmap_irq_chip_bcu,
-					 &pmic->irq_chip_data_bcu);
+	ret = bxtwc_add_chained_devices(pmic, bxt_wc_bcu_dev, ARRAY_SIZE(bxt_wc_bcu_dev),
+					pmic->irq_chip_data,
+					BXTWC_BCU_LVL1_IRQ,
+					IRQF_ONESHOT,
+					&bxtwc_regmap_irq_chip_bcu,
+					&pmic->irq_chip_data_bcu);
 	if (ret)
-		return dev_err_probe(dev, ret, "Failed to add BUC IRQ chip\n");
+		return ret;
 
-	/* Add chained IRQ handler for ADC IRQs */
-	ret = bxtwc_add_chained_irq_chip(pmic, pmic->irq_chip_data,
-					 BXTWC_ADC_LVL1_IRQ,
-					 IRQF_ONESHOT,
-					 &bxtwc_regmap_irq_chip_adc,
-					 &pmic->irq_chip_data_adc);
+	ret = bxtwc_add_chained_devices(pmic, bxt_wc_adc_dev, ARRAY_SIZE(bxt_wc_adc_dev),
+					pmic->irq_chip_data,
+					BXTWC_ADC_LVL1_IRQ,
+					IRQF_ONESHOT,
+					&bxtwc_regmap_irq_chip_adc,
+					&pmic->irq_chip_data_adc);
 	if (ret)
-		return dev_err_probe(dev, ret, "Failed to add ADC IRQ chip\n");
+		return ret;
 
 	ret = bxtwc_add_chained_devices(pmic, bxt_wc_chgr_dev, ARRAY_SIZE(bxt_wc_chgr_dev),
 					pmic->irq_chip_data,
-- 
2.43.0.rc1.1336.g36b5255a03ac


