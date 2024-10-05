Return-Path: <linux-kernel+bounces-352081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C67199919E8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 21:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 840612831B2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 19:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DE5161902;
	Sat,  5 Oct 2024 19:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f3LIoXx4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD3914C5B5;
	Sat,  5 Oct 2024 19:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728156638; cv=none; b=BAIEfZp5GO6L+Eq7XvXQ0QWDBxTjTRab/NRZFoxpZuZBdQoJ7hUAyvuLPjH3c/R3fNxT3CF/DasWC4vwD2B/xh4HkNVFr9wHVVkKXFX0D3Oz+wDlHZZ3AbGrORuIl+YEb8lsmLVvSpIlMribysOSu2zW8yjEueF5tZwt6Ketw3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728156638; c=relaxed/simple;
	bh=M25uoz5sLviUJS2fboSk7SWcSJ5iHwoHzOPn2l87Bew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bp2j6cJWjDZWKniRTlQX1vTIylhSWgrDtWttgy2NfR9KD/b5O8YMG6kpLwGJ+0i/hmE/kYjDa14piwgHzVusQRnASNCJrKwwRZfLO5f2N246A/ro7yyqAbZEhk1wzFCoOGBXbL1Dpt7bN6oIt3plNwKi/8CQN+6bV7Ymyd5x5nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f3LIoXx4; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728156637; x=1759692637;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M25uoz5sLviUJS2fboSk7SWcSJ5iHwoHzOPn2l87Bew=;
  b=f3LIoXx4VpBerF1cDdqXttb4TrZThoe8acWXe7jDdjSTOE65Ndn+wm2n
   XJ9rz2u++WJmd1RcWX3rtcCHt+AZS1OjCcvoROz1P7yANipWXyX7uZNDe
   TdbKNyiFLtE7QXesFR9YgEdgifkowuHmgXNWG7iNFRa0mCc3p9QYXh2A/
   zP4LCc/b5E4pVzI6p0vggAtbAnyBPA3m06kByr/6rhGfNJlDh5WYb6vtF
   o2tfSqr7iesFHF9s/ok22dl2yJ4zS8qM7lONBJY1V1qaUx7iunWCDDwJU
   6tUNHpOz3Wl77e+3hZmVFoPMVPZC0/FEcNIaVQNdB6+Yqu75PXBm7zoUH
   Q==;
X-CSE-ConnectionGUID: htmjuVqvS0umSPS7Kj7mSA==
X-CSE-MsgGUID: amll4F3YQmCFMpCpSoVUvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11216"; a="44879461"
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; 
   d="scan'208";a="44879461"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2024 12:30:36 -0700
X-CSE-ConnectionGUID: u4CJzxZVRtuRvKodeHx9dg==
X-CSE-MsgGUID: rQi09u3ZQAS6dz570h+unA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; 
   d="scan'208";a="74861625"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 05 Oct 2024 12:30:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DDB05177; Sat, 05 Oct 2024 22:30:31 +0300 (EEST)
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
Subject: [PATCH v2 1/4] mfd: intel_soc_pmic_bxtwc: Use IRQ domain for USB Type-C device
Date: Sat,  5 Oct 2024 22:27:04 +0300
Message-ID: <20241005193029.1929139-2-andriy.shevchenko@linux.intel.com>
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

Fixes: 9c6235c86332 ("mfd: intel_soc_pmic_bxtwc: Add bxt_wcove_usbc device")
Fixes: d2061f9cc32d ("usb: typec: add driver for Intel Whiskey Cove PMIC USB Type-C PHY")
Fixes: 57129044f504 ("mfd: intel_soc_pmic_bxtwc: Use chained IRQs for second level IRQ chips")
Reported-by: Zhang Ning <zhangn1985@outlook.com>
Closes: https://lore.kernel.org/r/TY2PR01MB3322FEDCDC048B7D3794F922CDBA2@TY2PR01MB3322.jpnprd01.prod.outlook.com
Tested-by: Zhang Ning <zhangn1985@outlook.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel_soc_pmic_bxtwc.c | 57 +++++++++++++++++++++---------
 drivers/usb/typec/tcpm/wcove.c     |  4 ---
 2 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index ccd76800d8e4..d72995a9e820 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -240,16 +240,6 @@ static struct mfd_cell bxt_wc_dev[] = {
 		.num_resources = ARRAY_SIZE(thermal_resources),
 		.resources = thermal_resources,
 	},
-	{
-		.name = "bxt_wcove_usbc",
-		.num_resources = ARRAY_SIZE(usbc_resources),
-		.resources = usbc_resources,
-	},
-	{
-		.name = "bxt_wcove_ext_charger",
-		.num_resources = ARRAY_SIZE(charger_resources),
-		.resources = charger_resources,
-	},
 	{
 		.name = "bxt_wcove_bcu",
 		.num_resources = ARRAY_SIZE(bcu_resources),
@@ -271,6 +261,19 @@ static struct mfd_cell bxt_wc_dev[] = {
 	},
 };
 
+static struct mfd_cell bxt_wc_chgr_dev[] = {
+	{
+		.name = "bxt_wcove_usbc",
+		.num_resources = ARRAY_SIZE(usbc_resources),
+		.resources = usbc_resources,
+	},
+	{
+		.name = "bxt_wcove_ext_charger",
+		.num_resources = ARRAY_SIZE(charger_resources),
+		.resources = charger_resources,
+	},
+};
+
 static int regmap_ipc_byte_reg_read(void *context, unsigned int reg,
 				    unsigned int *val)
 {
@@ -425,6 +428,26 @@ static int bxtwc_add_chained_irq_chip(struct intel_soc_pmic *pmic,
 					0, chip, data);
 }
 
+static int bxtwc_add_chained_devices(struct intel_soc_pmic *pmic,
+				     const struct mfd_cell *cells, int n_devs,
+				     struct regmap_irq_chip_data *pdata,
+				     int pirq, int irq_flags,
+				     const struct regmap_irq_chip *chip,
+				     struct regmap_irq_chip_data **data)
+{
+	struct device *dev = pmic->dev;
+	struct irq_domain *domain;
+	int ret;
+
+	ret = bxtwc_add_chained_irq_chip(pmic, pdata, pirq, irq_flags, chip, data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add %s IRQ chip\n", chip->name);
+
+	domain = regmap_irq_get_domain(*data);
+
+	return devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE, cells, n_devs, NULL, 0, domain);
+}
+
 static int bxtwc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -500,14 +523,14 @@ static int bxtwc_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to add ADC IRQ chip\n");
 
-	/* Add chained IRQ handler for CHGR IRQs */
-	ret = bxtwc_add_chained_irq_chip(pmic, pmic->irq_chip_data,
-					 BXTWC_CHGR_LVL1_IRQ,
-					 IRQF_ONESHOT,
-					 &bxtwc_regmap_irq_chip_chgr,
-					 &pmic->irq_chip_data_chgr);
+	ret = bxtwc_add_chained_devices(pmic, bxt_wc_chgr_dev, ARRAY_SIZE(bxt_wc_chgr_dev),
+					pmic->irq_chip_data,
+					BXTWC_CHGR_LVL1_IRQ,
+					IRQF_ONESHOT,
+					&bxtwc_regmap_irq_chip_chgr,
+					&pmic->irq_chip_data_chgr);
 	if (ret)
-		return dev_err_probe(dev, ret, "Failed to add CHGR IRQ chip\n");
+		return ret;
 
 	/* Add chained IRQ handler for CRIT IRQs */
 	ret = bxtwc_add_chained_irq_chip(pmic, pmic->irq_chip_data,
diff --git a/drivers/usb/typec/tcpm/wcove.c b/drivers/usb/typec/tcpm/wcove.c
index cf719307b3f6..60b2766a69bf 100644
--- a/drivers/usb/typec/tcpm/wcove.c
+++ b/drivers/usb/typec/tcpm/wcove.c
@@ -621,10 +621,6 @@ static int wcove_typec_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	irq = regmap_irq_get_virq(pmic->irq_chip_data_chgr, irq);
-	if (irq < 0)
-		return irq;
-
 	ret = guid_parse(WCOVE_DSM_UUID, &wcove->guid);
 	if (ret)
 		return ret;
-- 
2.43.0.rc1.1336.g36b5255a03ac


