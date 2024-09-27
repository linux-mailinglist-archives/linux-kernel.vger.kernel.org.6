Return-Path: <linux-kernel+bounces-341390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFF0987F67
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFB5C1C22CC7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 07:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E454187FE6;
	Fri, 27 Sep 2024 07:26:16 +0000 (UTC)
Received: from out28-220.mail.aliyun.com (out28-220.mail.aliyun.com [115.124.28.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBFD17E00D;
	Fri, 27 Sep 2024 07:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727421976; cv=none; b=YzOXA8TzevAcZWeynj8NLgyw0owmlWKfZHzVCOtGogv0R0T5P1c6RC2JDn0YI6t7+Dydr5rmeo5Wjeo17q2i6g7o/QuCsK5WXSrPv7LNuQ8vF2zFDJYWojbeqtHpni00kIW06eHpLQmY8biEOxjkW188dKUUpHi9Yiuv6dxfb+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727421976; c=relaxed/simple;
	bh=oBnAi/AhRfLXxj4J934ja59rEJk5n2K9gXVnf9OBLhw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s3BjRJjIZoJcCNvpwvLqCSAnM422gIr/6WJCMwHLNCUGaD5UeDKUzQeXe5K4qn7xJNCNUUsGtt7NAs7/1+cuXZ9TQaLuV5NKbuyFWj+y9sFindV8JtTXrjOtrVfSbvXnlnjU920pWYhP2pkQaa471N4OcJigzKU6uJTATCzLi7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=allwinnertech.com; spf=pass smtp.mailfrom=allwinnertech.com; arc=none smtp.client-ip=115.124.28.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=allwinnertech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allwinnertech.com
Received: from SunxiBot.allwinnertech.com(mailfrom:michael@allwinnertech.com fp:SMTPD_---.ZUNKLol_1727421959)
          by smtp.aliyun-inc.com;
          Fri, 27 Sep 2024 15:26:00 +0800
From: Michael Wu <michael@allwinnertech.com>
To: gregkh@linuxfoundation.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Thinh.Nguyen@synopsys.com,
	balbi@kernel.org
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] usb: dwc3: core: add Gen2 polarity detection support
Date: Fri, 27 Sep 2024 15:25:56 +0800
Message-Id: <20240927072557.74194-1-michael@allwinnertech.com>
X-Mailer: git-send-email 2.29.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the DWC31 Enhanced SuperSpeed USB3.1 Controller Programming
Guide, for Gen2 polarity detection, link uses data block (0011b) sync
header for SYNC OS instead of control block (1100b).

Added 'snps,inv-sync-hdr-quirk' a DT property to set this bit 30 of
LLUCTL if the third-party PHY doesn't correct the sync header of the
SYNC OS in the case of inverse polarity.

Signed-off-by: Michael Wu <michael@allwinnertech.com>
---
 drivers/usb/dwc3/core.c | 24 ++++++++++++++++--------
 drivers/usb/dwc3/core.h |  6 ++++++
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 734de2a8bd212..72fddfcbdd0c3 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1434,15 +1434,20 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	dwc3_config_threshold(dwc);
 
-	/*
-	 * Modify this for all supported Super Speed ports when
-	 * multiport support is added.
-	 */
-	if (hw_mode != DWC3_GHWPARAMS0_MODE_GADGET &&
-	    (DWC3_IP_IS(DWC31)) &&
-	    dwc->maximum_speed == USB_SPEED_SUPER) {
+	if (DWC3_IP_IS(DWC31)) {
 		reg = dwc3_readl(dwc->regs, DWC3_LLUCTL);
-		reg |= DWC3_LLUCTL_FORCE_GEN1;
+
+		/*
+		 * Modify this for all supported Super Speed ports when
+		 * multiport support is added.
+		 */
+		if (hw_mode != DWC3_GHWPARAMS0_MODE_GADGET &&
+		    dwc->maximum_speed == USB_SPEED_SUPER)
+			reg |= DWC3_LLUCTL_FORCE_GEN1;
+
+		if (dwc->inv_sync_hdr_quirk)
+			reg |= DWC3_LLUCTL_INV_SYNC_HDR;
+
 		dwc3_writel(dwc->regs, DWC3_LLUCTL, reg);
 	}
 
@@ -1774,6 +1779,9 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	dwc->dis_split_quirk = device_property_read_bool(dev,
 				"snps,dis-split-quirk");
 
+	dwc->inv_sync_hdr_quirk = device_property_read_bool(dev,
+				"snps,inv-sync-hdr-quirk");
+
 	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
 	dwc->tx_de_emphasis = tx_de_emphasis;
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 1e561fd8b86e2..5e5971e50bc09 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -673,6 +673,9 @@
 /* Force Gen1 speed on Gen2 link */
 #define DWC3_LLUCTL_FORCE_GEN1		BIT(10)
 
+/* Link uses data block sync header for Gen2 polarity detection */
+#define DWC3_LLUCTL_INV_SYNC_HDR	BIT(30)
+
 /* Structures */
 
 struct dwc3_trb;
@@ -1146,6 +1149,8 @@ struct dwc3_scratchpad_array {
  *	3	- Reserved
  * @dis_metastability_quirk: set to disable metastability quirk.
  * @dis_split_quirk: set to disable split boundary.
+ * @inv_sync_hdr_quirk: set if the third-party PHY does not correct the sync
+ *			header of the SYNC OS in case of inverse polarity.
  * @sys_wakeup: set if the device may do system wakeup.
  * @wakeup_configured: set if the device is configured for remote wakeup.
  * @suspended: set to track suspend event due to U3/L2.
@@ -1376,6 +1381,7 @@ struct dwc3 {
 	unsigned		dis_metastability_quirk:1;
 
 	unsigned		dis_split_quirk:1;
+	unsigned		inv_sync_hdr_quirk:1;
 	unsigned		async_callbacks:1;
 	unsigned		sys_wakeup:1;
 	unsigned		wakeup_configured:1;
-- 
2.29.0


