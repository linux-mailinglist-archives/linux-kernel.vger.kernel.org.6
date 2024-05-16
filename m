Return-Path: <linux-kernel+bounces-180632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 711278C7102
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 06:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A201D1C22929
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 04:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB3B10A0E;
	Thu, 16 May 2024 04:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hKhiBA/0"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA1721379;
	Thu, 16 May 2024 04:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715834753; cv=none; b=qPofv21pW8v9YYlQu+qOQYICgluLt6Mfk11msFyEvjKgtSBfEpkekR763c+STpEj0WkPT2sJ+V1sWCZeDvpMaW68lrtFczoOtwRRRu7+hkMxTrXxArg3gEdmsA1T2O65BFpLlj8xlci2mG/pxsQQg74G8NoPlLA9SniqbwW/Qg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715834753; c=relaxed/simple;
	bh=CeI7Nj7iYXEoMFAD+W6AENj+Ni8SVHaZgtCZBXnJKY4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BP3xuE/8kM/caanmzlBJoHp4DQ4YsMEfATikjUrSmF5vOvalKNv9HSeVUJPZIYYJmxrZXVbWoI6l0B4G/zKHYCyNaFj0s1bzWrXwjJS4ssd8KRhnoGvXRwxLhFmjF/S1HANd1XB+3whrGkh7EkOruznWovoHIYblittktBnKtdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hKhiBA/0; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44G4jk5V118944;
	Wed, 15 May 2024 23:45:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715834746;
	bh=DXjLif0Hjv029aqYrs3Ya+OtUIaoG6yLYj0HMg+CA+c=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=hKhiBA/0q69Bi5t/m70w16CuSDS+M2Yc5lw8rRJ9O02iJCVYDE1zNLCEzVaEyhruM
	 rEuXbe6YMzDInWY4wLpoiXUpiX2IyUgkEJMs0bAVen2X2RT2DvzZxENq6qD3ODf+UD
	 Gl9V3B5i6iN0f6ThBT1y1D+Qwyxck4ymsC/5KEQE=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44G4jk3f053435
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 15 May 2024 23:45:46 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 15
 May 2024 23:45:45 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 15 May 2024 23:45:45 -0500
Received: from uda0500640.dal.design.ti.com (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44G4jbxq115324;
	Wed, 15 May 2024 23:45:43 -0500
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
To: <peter.chen@kernel.org>, <pawell@cadence.com>, <rogerq@kernel.org>
CC: <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: [PATCH v3 2/2] usb: cdns3-ti: Add workaround for Errata i2409
Date: Thu, 16 May 2024 10:15:37 +0530
Message-ID: <20240516044537.16801-3-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240516044537.16801-1-r-gunasekaran@ti.com>
References: <20240516044537.16801-1-r-gunasekaran@ti.com>
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
Changes since v2:
----------------
* No change

Changes since v1:
----------------
* No change

v2: https://lore.kernel.org/all/20240516042845.31211-1-r-gunasekaran@ti.com/
v1: https://lore.kernel.org/all/20240514092421.20897-1-r-gunasekaran@ti.com/#t

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


