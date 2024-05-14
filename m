Return-Path: <linux-kernel+bounces-178505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D93B08C4EC3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 12:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F02401F21489
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 10:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B66076033;
	Tue, 14 May 2024 09:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FIuH8kwQ"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C476EB56;
	Tue, 14 May 2024 09:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715678674; cv=none; b=lpAH0oVVL49AUU5heUX2Ir8bkP0S5Mb0l38wrXveqfftyjQEJp/fYefn+cvs09vPeJQo3fhZD96x3JKJt9xIACwGYKe5A658/cQRwnk3rqeXLZ7N8c/noVaNAHJ5OmSn0eUSYpWDuW4Kz1BehA8dbbzY8TozE7YeaIPMgnOheEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715678674; c=relaxed/simple;
	bh=U/9PksEjQWpNF758mjEuhi4Xuz5X0hhUVuMp/piEpZc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V14IunSdQ4GAASMjxgoVH/CYS2fpsw80Bltv0MhRYvykJ/OQu+YEKaXQLu0orrBsASS3d6Cl/KsfrzlwweK6hy5npGHdG+pAOU441gCNHiJxXs/hPRD7fLRKZ6QEk7mZfY/NykXon0OaqpRitAQPQYhLK4tEsle3e11UCmWuhaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FIuH8kwQ; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44E9OQhZ077231;
	Tue, 14 May 2024 04:24:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715678666;
	bh=D8tCbzdRYPifPR+nBVdIPv7M63Riinh+KGzqjjkO/ZY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=FIuH8kwQ5wP2nkOCZRQGD9Bd2mU4IIxfnIyMg5/pVxhrTYX0cavSSByFIORh2rdZY
	 Fe+zSW8XeCyIJ5HENX7skxjGK3ThTIhLb9hqK81CEAnWET4If+muqSD81VLseMNHLu
	 LLGEqBOZmrtNmXGVtcGQ4cw+WGFYEvXT+KLcQ14Q=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44E9OQd7030050
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 May 2024 04:24:26 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 14
 May 2024 04:24:26 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 14 May 2024 04:24:26 -0500
Received: from uda0500640.dal.design.ti.com (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44E9OLp9064099;
	Tue, 14 May 2024 04:24:24 -0500
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
To: <peter.chen@kernel.org>, <pawell@cadence.com>, <rogerq@kernel.org>,
        <r-gunasekaran@ti.com>
CC: <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] usb: cdns3: Add quirk flag to enable suspend residency
Date: Tue, 14 May 2024 14:54:20 +0530
Message-ID: <20240514092421.20897-2-r-gunasekaran@ti.com>
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

Some platforms (e.g. ti,j721e-usb, ti,am64-usb) require
this bit to be set to workaround a lockup issue with PHY
short suspend intervals [1]. Add a platform quirk flag
to indicate if Suspend Residency should be enabled.

[1] - https://www.ti.com/lit/er/sprz457h/sprz457h.pdf
i2409 - USB: USB2 PHY locks up due to short suspend

Signed-off-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
---
 drivers/usb/cdns3/core.h | 1 +
 drivers/usb/cdns3/drd.c  | 9 ++++++++-
 drivers/usb/cdns3/drd.h  | 3 +++
 3 files changed, 12 insertions(+), 1 deletion(-)

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
index 8b936a2e93a0..de0d25a072b4 100644
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
@@ -439,6 +439,13 @@ int cdns_drd_init(struct cdns *cdns)
 			return -EINVAL;
 		}
 
+		if (cdns->pdata &&
+		    (cdns->pdata->quirks & CDNS3_DRD_SUSPEND_RESIDENCY_ENABLE)) {
+			reg = readl(&cdns->otg_v1_regs->susp_ctrl);
+			reg |= SUSP_CTRL_SUSPEND_RESIDENCY_ENABLE;
+			writel(reg, &cdns->otg_v1_regs->susp_ctrl);
+		}
+
 		dev_dbg(cdns->dev, "DRD version v1 (ID: %08x, rev: %08x)\n",
 			 readl(&cdns->otg_v1_regs->did),
 			 readl(&cdns->otg_v1_regs->rid));
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


