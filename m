Return-Path: <linux-kernel+bounces-178506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C698C4EC6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 12:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20DFB1F213B1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 10:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314D184A22;
	Tue, 14 May 2024 09:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TABiJawB"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13829763E6;
	Tue, 14 May 2024 09:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715678677; cv=none; b=TwRJik2Un+KwSeYFPkJ6peW3Axz+WDkvlcM0R610KSXLHaJ8fHMZ7aEWreOcW0ss87zoZVlfArVd8wXbZk8Hb9oKFUaB/rtQSovcfBJXOtwQD9kiTdS1V7qd/sh/6IuOAJu/aXR2pTX8FhxeeAV8mMymS5R1t98FR0kDWK3/k/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715678677; c=relaxed/simple;
	bh=uMzp/zTf/osP+gvkR0MCVf4ImXGLvfVmMy07wrsnYyc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lr5o4cOaqAq8CYSXOL7eu4Chw2V9/+puCcEO/cNN2fzR/AU1YhL+teNuqtZmtwZlcNv1mGLEErKpEzLubI6YKeCth34cdG4+3olkuW7G0UocFe5RJmZ6VKwrstyRBOB3Lb66zH/8sTIZK8EQgmdzFD8tMNvEqHaXy7XMbMDmK78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TABiJawB; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44E9OTh3049021;
	Tue, 14 May 2024 04:24:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715678669;
	bh=fBkjCYCCabd2QECou4K0JssT6mcmJbLsPyjH8U2CaNA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=TABiJawBNSUhp0XcHtLTbHTO+XbmCIsLb9yxIHK5A50q9iIJvWgLQw2O7tGFrccYJ
	 C3Rg/OSImH2FdDdO7lSgDjLyRFq3s52stM4dbIC3DkuJqkfOEjJXuD2j6LefblGaeP
	 6YrmWrfGJet8Idz/GbHHqVSyC+oOE9fG2Mb+8pxI=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44E9OTcE088675
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 May 2024 04:24:29 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 14
 May 2024 04:24:28 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 14 May 2024 04:24:28 -0500
Received: from uda0500640.dal.design.ti.com (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44E9OLpA064099;
	Tue, 14 May 2024 04:24:26 -0500
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
To: <peter.chen@kernel.org>, <pawell@cadence.com>, <rogerq@kernel.org>,
        <r-gunasekaran@ti.com>
CC: <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] usb: cdns3-ti: Add workaround for Errata i2409
Date: Tue, 14 May 2024 14:54:21 +0530
Message-ID: <20240514092421.20897-3-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240514092421.20897-1-r-gunasekaran@ti.com>
References: <20240514092421.20897-1-r-gunasekaran@ti.com>
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


