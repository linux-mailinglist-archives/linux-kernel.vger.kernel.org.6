Return-Path: <linux-kernel+bounces-180624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DDC8C70F0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 06:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C46141F24018
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 04:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C076F4085C;
	Thu, 16 May 2024 04:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YFIxAjA9"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1C92E40F;
	Thu, 16 May 2024 04:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715833742; cv=none; b=ewuM4abbwdN5omCfeHp/GglkqLuOPKnkWC+/RN7AFxOIzd5O6YdJCB0GxU8NqEHRwhoLC7zHvpknuf1RQN3v37jmk33Lhcspvy4lj5UpmWcS/EyOaKj/9f8mxZJCf25OkeKKLlinsDeh5hNAQDWcMxI+L3J4i071wsOyr+xOdbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715833742; c=relaxed/simple;
	bh=pHNKsL8SM98MS8k8WpkNws8qA6DAVNJdvMKuWFe4FAc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rM6i9PaypIbFoHE9XUapVeHUipXxlZrSO19mazOrqKZh/mQwEeIyU/JxvzptCgFF2ZFrnmVhyfQEch8bo8tBmCw2AVzyY+/5eYuKStV4OfNjiOHcoEdGGw4dCVGU9VRMmxyNbMyX0ZiaFtWTmazqQ8MQhzFKyWf6fuYftwZY61I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YFIxAjA9; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44G4SsSn114245;
	Wed, 15 May 2024 23:28:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715833734;
	bh=NirSqQ+aOY8qUrlzSO1MGMO9I52LiKwz6bgLBnApSVs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=YFIxAjA97S9T0yV5JrDyjw2wLDwd8ey0PVAiJyhpAhN/UBFFOI/oaUCF46pgc7mSZ
	 SxjyRvGMeh7zLZq+r1Hma2W2Y4i8yGAPY/ffcce423EfL3kmaT0vgQT8RHALbHeCqp
	 woff0XAnZUckTqHB3W/Iu9mBunqdLmbYUw0hVUlg=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44G4Ss3N043812
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 15 May 2024 23:28:54 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 15
 May 2024 23:28:54 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 15 May 2024 23:28:54 -0500
Received: from uda0500640.dal.design.ti.com (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44G4Skhk089022;
	Wed, 15 May 2024 23:28:52 -0500
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
To: <peter.chen@kernel.org>, <pawell@cadence.com>, <rogerq@kernel.org>
CC: <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: [PATCH v2 2/2] usb: cdns3-ti: Add workaround for Errata i2409
Date: Thu, 16 May 2024 09:58:45 +0530
Message-ID: <20240516042845.31211-3-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240516042845.31211-1-r-gunasekaran@ti.com>
References: <20240516042845.31211-1-r-gunasekaran@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Roger Quadros <rogerq@kernel.org>

TI USB2 PHY is known to have a lockup issue on very short
suspend intervals. Enable the Suspend Residency quirk flag to
workaround this as described in Errata i2409 [1].

[1] - https://www.ti.com/lit/er/sprz457h/sprz457h.pdf

Signed-off-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
---
Change log:
----------

Changes since v1:
----------------
* No change

v1:  https://lore.kernel.org/all/20240514092421.20897-1-r-gunasekaran@ti.com/#t

 drivers/usb/cdns3/cdns3-ti.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
index 5945c4b1e11f..cfabc12ee0e3 100644
--- a/drivers/usb/cdns3/cdns3-ti.c
+++ b/drivers/usb/cdns3/cdns3-ti.c
@@ -16,6 +16,7 @@
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
+#include "core.h"
 
 /* USB Wrapper register offsets */
 #define USBSS_PID		0x0
@@ -85,6 +86,18 @@ static inline void cdns_ti_writel(struct cdns_ti *data, u32 offset, u32 value)
 	writel(value, data->usbss + offset);
 }
 
+static struct cdns3_platform_data cdns_ti_pdata = {
+	.quirks = CDNS3_DRD_SUSPEND_RESIDENCY_ENABLE,   /* Errata i2409 */
+};
+
+static const struct of_dev_auxdata cdns_ti_auxdata[] = {
+	{
+		.compatible = "cdns,usb3",
+		.platform_data = &cdns_ti_pdata,
+	},
+	{},
+};
+
 static int cdns_ti_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -176,7 +189,7 @@ static int cdns_ti_probe(struct platform_device *pdev)
 	reg |= USBSS_W1_PWRUP_RST;
 	cdns_ti_writel(data, USBSS_W1, reg);
 
-	error = of_platform_populate(node, NULL, NULL, dev);
+	error = of_platform_populate(node, NULL, cdns_ti_auxdata, dev);
 	if (error) {
 		dev_err(dev, "failed to create children: %d\n", error);
 		goto err;
-- 
2.17.1


