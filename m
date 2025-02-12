Return-Path: <linux-kernel+bounces-510836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBA4A322A8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76FAE3A34B4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41F51FECB4;
	Wed, 12 Feb 2025 09:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="x6BFk/1X"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B41271828
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 09:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739353517; cv=none; b=aknUe/2LvVQhI18XSjUXqsn0nSOLKaNvAPoI3vh5O4I2xvuVdyyjW6qNTQeLAWUgirrGCV3vgrZAQ+5nJ2tZXG4RbYTC6uQkcdH0mAMlA/N5hHrjTfcCV4ghZlo2ZPRG2ivIGXm4k+YGo+g3KFs9An8jCiUDwNCPFVo3dTEUcEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739353517; c=relaxed/simple;
	bh=1NSB5qjI3HdwTQRBQBnjuqJ4TpcqIKiTpLxKV/W6NhQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q2FHzZUMjjeto0nM3D928maSyjJIfU9uh6ux4T6PGvh8+NEV9WfzmQBQKjXz7y0/JizyXCybXLT1Tlgovf+67uAR5TV/5HCB0+66vYNc7ueZy9qf29WXxI+7uVzMlVHzmIE9+mrp6Xtqn2frdWUVTXqoMxyT/4KDosoNKZA58DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=x6BFk/1X; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1739353515; x=1770889515;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1NSB5qjI3HdwTQRBQBnjuqJ4TpcqIKiTpLxKV/W6NhQ=;
  b=x6BFk/1XGcUB3R2pmxS3C67vjeJYpR2FmAfF4Qr966PZO4QWRbyjft7h
   U6ekL5nnGhbkO2Y/aJh9at9P8YxvDlq1hIZYtVAZCEE6+31VnCocj5htp
   CF2elUdksoApVaDP3Nm+jiESYreuAVHgpS7chZuM5+SrwjH1WqKkfkOZ2
   CcxRERMLfsjos8ExeuVOnIJgkvXlIfxUKRTPtQSl4cvRKkWNQ887tYzbM
   AVENRefYOSBUkwySa4/9DU2pjdy1UtDvXQiayGfYfD9H9nb/iLYS7VkFJ
   H0qebCaWFzSGcokoi8ZcmJGEXPq8JRBkyu0kS2m5x1x30+CAN7Er/0N4A
   g==;
X-CSE-ConnectionGUID: qkANol4LQQKG05F3y7BElw==
X-CSE-MsgGUID: P7uX/GQ0TOmWM4WVOBVmyA==
X-IronPort-AV: E=Sophos;i="6.13,279,1732604400"; 
   d="scan'208";a="37191058"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Feb 2025 02:45:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 12 Feb 2025 02:45:08 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 12 Feb 2025 02:45:01 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <sam@ravnborg.org>, <bbrezillon@kernel.org>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <lee@kernel.org>,
	<dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Manikandan Muralidharan <manikandan.m@microchip.com>, "Dharma
 Balasubiramani" <dharma.b@microchip.com>
Subject: [PATCH v2 2/3] mfd: atmel-hlcdc: fetch LVDS PLL clock for LVDS display
Date: Wed, 12 Feb 2025 15:14:48 +0530
Message-ID: <20250212094449.109622-2-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250212094449.109622-1-manikandan.m@microchip.com>
References: <20250212094449.109622-1-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The XLCDC IP supports parallel RGB, MIPI DSI and LVDS Display.
The LCD Generic clock (sys_clk) is used for Parallel RGB and MIPI
displays, while the LVDS PLL clock (lvds_pll_clk) is used for LVDS
displays.Since both the clocks cannot co-exist together in the DT
for a given display, this patch first attempts to retrieve sys_clk
If that fails,it then tries to acquire lvds_pll_clk.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
changes in v2:
- Rephrase the comments, commit message and err logs
- Replace dev_err wwith dev_warn
- Remove Initializing sys_clk and lvds_pll_clk to NULL post
devm_kzalloc() call

---
 drivers/mfd/atmel-hlcdc.c       | 16 ++++++++++++++--
 include/linux/mfd/atmel-hlcdc.h |  1 +
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/atmel-hlcdc.c b/drivers/mfd/atmel-hlcdc.c
index 4c4e35d404f3..f680392b01ba 100644
--- a/drivers/mfd/atmel-hlcdc.c
+++ b/drivers/mfd/atmel-hlcdc.c
@@ -108,10 +108,22 @@ static int atmel_hlcdc_probe(struct platform_device *pdev)
 		return PTR_ERR(hlcdc->periph_clk);
 	}
 
+	/*
+	 * Retrieve any one of the Main clk required by the LCD to operate:
+	 *
+	 * LCDC Generic Clock (sys_clk) - Parallel RGB and MIPI displays,
+	 * LVDS PLL (lvds_pll_clk)      - LVDS display
+	 */
 	hlcdc->sys_clk = devm_clk_get(dev, "sys_clk");
 	if (IS_ERR(hlcdc->sys_clk)) {
-		dev_err(dev, "failed to get system clock\n");
-		return PTR_ERR(hlcdc->sys_clk);
+		dev_warn(dev,
+			 "failed to get LCDC generic clock, trying for LVDS PLL clock instead\n");
+
+		hlcdc->lvds_pll_clk = devm_clk_get(dev, "lvds_pll_clk");
+		if (IS_ERR(hlcdc->lvds_pll_clk)) {
+			dev_err(dev, "failed to get LVDS PLL clock\n");
+			return PTR_ERR(hlcdc->lvds_pll_clk);
+		}
 	}
 
 	hlcdc->slow_clk = devm_clk_get(dev, "slow_clk");
diff --git a/include/linux/mfd/atmel-hlcdc.h b/include/linux/mfd/atmel-hlcdc.h
index 80d675a03b39..07c2081867fd 100644
--- a/include/linux/mfd/atmel-hlcdc.h
+++ b/include/linux/mfd/atmel-hlcdc.h
@@ -75,6 +75,7 @@
  */
 struct atmel_hlcdc {
 	struct regmap *regmap;
+	struct clk *lvds_pll_clk;
 	struct clk *periph_clk;
 	struct clk *sys_clk;
 	struct clk *slow_clk;
-- 
2.25.1


