Return-Path: <linux-kernel+bounces-180631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9064C8C7100
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 06:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E392EB22FAC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 04:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF152031D;
	Thu, 16 May 2024 04:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ujOB1hLL"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF86717996;
	Thu, 16 May 2024 04:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715834750; cv=none; b=L4Hd10Zl4LDdv5xKdBA5MxeeaweHYUeXyNZFkQ8IYAw3jAXov7y9wdoRthZtaUtu3pFjmgcOwRD2WqsL0Im5rTshJs5E1jW6gywVL72S6CrkxQRMp5veyEHYV7vQsZVFGO+WUcYQNSIYmQSLgYfnxC6/sxmPlZf0c3/89PDZ1eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715834750; c=relaxed/simple;
	bh=odlMPuT2CoTavPEqeJgu9j4IMP089XYZRpOx2DBeJBs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fu1SPDUtBbOBtuifMwJwwbYgSU0TU4cYsyrnuPv9P5mLsBwizI0RgVGhHIJSgysbI5GFeRXscvbFIN0yIuyJwCO/seKXsGqVkmm0IKzDwD3jYS9gdQB5zkZ0+3U7mXmpB2HVQ8LWxcSHMy6fBFhuAzOs5CadcNnb2ulaNajPBiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ujOB1hLL; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44G4jhn6093157;
	Wed, 15 May 2024 23:45:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715834743;
	bh=izkY2YI9Qk4vqVmtYL+FnKTEjwrrtgXP07VLe6loAsY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ujOB1hLL2vjlisNvAH54onwI3jjnACpTBDOTi3lEne6PemfUAs+5upPhHBOmCVW7e
	 Q9Ombc+llmmuyByv0GJ6yeUxCOIpu6b/Mym8mbpx9oDqx/y7JK6uq+7yWlNPQRLb+k
	 1u7xCZiVW8Vhin+Bpu+FYI+gwo+93QVl718Gv/j8=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44G4jhUo088684
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 15 May 2024 23:45:43 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 15
 May 2024 23:45:43 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 15 May 2024 23:45:43 -0500
Received: from uda0500640.dal.design.ti.com (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44G4jbxp115324;
	Wed, 15 May 2024 23:45:40 -0500
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
To: <peter.chen@kernel.org>, <pawell@cadence.com>, <rogerq@kernel.org>
CC: <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: [PATCH v3 1/2] usb: cdns3: Add quirk flag to enable suspend residency
Date: Thu, 16 May 2024 10:15:36 +0530
Message-ID: <20240516044537.16801-2-r-gunasekaran@ti.com>
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

Some platforms (e.g. ti,j721e-usb, ti,am64-usb) require
this bit to be set to workaround a lockup issue with PHY
short suspend intervals [1]. Add a platform quirk flag
to indicate if Suspend Residency should be enabled.

[1] - https://www.ti.com/lit/er/sprz457h/sprz457h.pdf
i2409 - USB: USB2 PHY locks up due to short suspend

Signed-off-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
---
Change log:
----------
Changes since v2:
----------------
* Fixed the redundant blank line added in v2

Changes since v1:
----------------
* Grouped the susp_ctrl register update along with
  existing CDNS3 snippet as suggested by Peter Chen

v2: https://lore.kernel.org/all/20240516042845.31211-1-r-gunasekaran@ti.com/
v1: https://lore.kernel.org/all/20240514092421.20897-1-r-gunasekaran@ti.com/#t

 drivers/usb/cdns3/core.h |  1 +
 drivers/usb/cdns3/drd.c  | 10 +++++++++-
 drivers/usb/cdns3/drd.h  |  3 +++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
index 81a9c9d6be08..57d47348dc19 100644
--- a/drivers/usb/cdns3/core.h
+++ b/drivers/usb/cdns3/core.h
@@ -44,6 +44,7 @@ struct cdns3_platform_data {
 			bool suspend, bool wakeup);
 	unsigned long quirks;
 #define CDNS3_DEFAULT_PM_RUNTIME_ALLOW	BIT(0)
+#define CDNS3_DRD_SUSPEND_RESIDENCY_ENABLE	BIT(1)
 };
 
 /**
diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
index 8b936a2e93a0..84fb38a5723a 100644
--- a/drivers/usb/cdns3/drd.c
+++ b/drivers/usb/cdns3/drd.c
@@ -389,7 +389,7 @@ static irqreturn_t cdns_drd_irq(int irq, void *data)
 int cdns_drd_init(struct cdns *cdns)
 {
 	void __iomem *regs;
-	u32 state;
+	u32 state, reg;
 	int ret;
 
 	regs = devm_ioremap_resource(cdns->dev, &cdns->otg_res);
@@ -433,6 +433,14 @@ int cdns_drd_init(struct cdns *cdns)
 			cdns->otg_irq_regs = (struct cdns_otg_irq_regs __iomem *)
 					      &cdns->otg_v1_regs->ien;
 			writel(1, &cdns->otg_v1_regs->simulate);
+
+			if (cdns->pdata &&
+			    (cdns->pdata->quirks & CDNS3_DRD_SUSPEND_RESIDENCY_ENABLE)) {
+				reg = readl(&cdns->otg_v1_regs->susp_ctrl);
+				reg |= SUSP_CTRL_SUSPEND_RESIDENCY_ENABLE;
+				writel(reg, &cdns->otg_v1_regs->susp_ctrl);
+			}
+
 			cdns->version  = CDNS3_CONTROLLER_V1;
 		} else {
 			dev_err(cdns->dev, "not supported DID=0x%08x\n", state);
diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
index d72370c321d3..1e2aee14d629 100644
--- a/drivers/usb/cdns3/drd.h
+++ b/drivers/usb/cdns3/drd.h
@@ -193,6 +193,9 @@ struct cdns_otg_irq_regs {
 /* OTGREFCLK - bitmasks */
 #define OTGREFCLK_STB_CLK_SWITCH_EN	BIT(31)
 
+/* SUPS_CTRL - bitmasks */
+#define SUSP_CTRL_SUSPEND_RESIDENCY_ENABLE	BIT(17)
+
 /* OVERRIDE - bitmasks */
 #define OVERRIDE_IDPULLUP		BIT(0)
 /* Only for CDNS3_CONTROLLER_V0 version */
-- 
2.17.1


