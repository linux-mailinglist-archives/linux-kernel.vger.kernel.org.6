Return-Path: <linux-kernel+bounces-401753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 974B69C1EBD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B0A3B23F14
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA5A1E907D;
	Fri,  8 Nov 2024 14:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thalesgroup.com header.i=@thalesgroup.com header.b="YZox0ATC"
Received: from esa.hc1631-21.eu.iphmx.com (esa.hc1631-21.eu.iphmx.com [23.90.123.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5977F1E32BC
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.90.123.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731074431; cv=none; b=Z+7f7gEYnJmX0tDNWwZx0ZHkQgZW1wL6k62BUoI+fmfc/e+CMNRAtgHmvT4jh9YzB+w9Kx8GheFumrPJk7Cq9hOG2EEMDwShVYz8T08IRz4wJtaRPqpcB7YnTeRojllVObzTMxWDYRjC2IMSc/9PZA7d11QETmv7HILYBc4Exrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731074431; c=relaxed/simple;
	bh=bLr9vE8qbUA+LBOeToguFBBTTmpirB4h4V///uZGpSo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kLN3kLq2AACK+QH4qL04pJNtfcDLzW5x7PF+dkDDM5g+1m6vM4KCl5QWwrQz2ruK9DPp39tiko5Y4X8USGqYdYOrH9sEkt8olymbsR6GEZs0/bNoPJUPbj5U3wwQagqZ756XfMKuL46vxyaQ86ZqfyvO5L32LYpaQaZIucGVrU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thalesgroup.com; spf=pass smtp.mailfrom=thalesgroup.com; dkim=pass (2048-bit key) header.d=thalesgroup.com header.i=@thalesgroup.com header.b=YZox0ATC; arc=none smtp.client-ip=23.90.123.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thalesgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thalesgroup.com
X-CSE-ConnectionGUID: B0Y4HjYYTHCzKiM8zFcbgA==
X-CSE-MsgGUID: 73O87e/NS4Oo62QliLRjuw==
Authentication-Results: ob1.hc1631-21.eu.iphmx.com; dkim=pass (signature verified) header.i=@thalesgroup.com
X-IronPort-AV: E=McAfee;i="6700,10204,11250"; a="23184882"
X-IronPort-AV: E=Sophos;i="6.12,138,1728943200"; 
   d="scan'208";a="23184882"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=thalesgroup.com; i=@thalesgroup.com; s=bbmfo20230504;
  t=1731074420;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=EE9tBFBFd3mh1SD7uzfbGKLYqBxfml1THD7ynL3J6gg=;
  b=YZox0ATCL2E9TWnbw32gsqbcBjWyLO/AUAf7M5ZG/SzLDfEd3vcXjxvW
   3WRGMaBvUGB7fyB6dheXilHmIuwtKHV34FgjAC8rGLFTWf8nbXjCSnHDR
   HRYPFQRBb8UBRPMjB3w66wUB/vVcLP1+lHrLp45rk9FTsdWIPFjDi5Ufc
   Xg/pfQIqV2JDMTqLDw1QUFJmpwpfXPV2CnvxUoe5f/P/AF2jMUeXcXF6e
   B58ClZpBGG2Ln2ornHtGs6iUWnp2T8NRQmAJntpIo9nPXZ7Y5kT4HYMWf
   hXmREVar0IaUbBWng/ERbJIcsk0Lr03rvs+qb8v/1kIVvOUIvDul247iA
   A==;
X-CSE-ConnectionGUID: EKntwVzJRr2j5C3jfMm0vA==
X-CSE-MsgGUID: iPhXadFFRKW6HfNARCM5Ig==
X-CSE-ConnectionGUID: B2LIapG6QcW74amwA6yqsg==
X-CSE-MsgGUID: yAeelpCZSymhiU6uXUOSYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11250"; a="34531874"
X-IronPort-AV: E=Sophos;i="6.12,138,1728943200"; 
   d="scan'208";a="34531874"
From: LECOINTRE Philippe <philippe.lecointre@thalesgroup.com>
To: Lucas Stach <l.stach@pengutronix.de>, Russell King
	<linux+etnaviv@armlinux.org.uk>, Christian Gmeiner
	<christian.gmeiner@gmail.com>
CC: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	"etnaviv@lists.freedesktop.org" <etnaviv@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, LENAIN Simon
	<simon.lenain@thalesgroup.com>, BARBEAU Etienne
	<etienne.barbeau@thalesgroup.com>, LEJEUNE Sebastien
	<sebastien.lejeune@thalesgroup.com>
Subject: [PATCH v2] drm/etnaviv: add optional reset support
Thread-Topic: [PATCH v2] drm/etnaviv: add optional reset support
Thread-Index: Adsx5YIJONFfGHrTSZ2tfemyyzgnnQ==
Date: Fri, 8 Nov 2024 14:00:03 +0000
Message-ID: <dc139d10a4184d289c9ffd1d308c0db1@thalesgroup.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-nodisclaimer: 0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Add optional reset support which is mentioned in vivante,gc.yaml to
allow the driver to work on SoCs whose reset signal is asserted by default
Avoid enabling the interrupt until everything is ready

Signed-off-by: Philippe Lecointre <philippe.lecointre@thalesgroup.com>
Reviewed-by: Simon Lenain <simon.lenain@thalesgroup.com>
---
v2:
- Add missing include of irq.h
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 30 +++++++++++++++++++++++++++
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h |  2 ++
 2 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnavi=
v/etnaviv_gpu.c
index 7c7f97793ddd..3e0c5dd9f74b 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2015-2018 Etnaviv Project
+ * Copyright (C) 2024 Thales
  */
=20
 #include <linux/clk.h>
@@ -8,11 +9,13 @@
 #include <linux/delay.h>
 #include <linux/dma-fence.h>
 #include <linux/dma-mapping.h>
+#include <linux/irq.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
+#include <linux/reset.h>
 #include <linux/thermal.h>
=20
 #include "etnaviv_cmdbuf.h"
@@ -1629,8 +1632,24 @@ static int etnaviv_gpu_clk_enable(struct etnaviv_gpu=
 *gpu)
 	if (ret)
 		goto disable_clk_core;
=20
+	/* 32 core clock cycles (slowest clock) required before deassertion. */
+	/* 1 microsecond might match all implementations */
+	usleep_range(1, 2);
+
+	ret =3D reset_control_deassert(gpu->rst);
+	if (ret)
+		goto disable_clk_shader;
+
+	/* 128 core clock cycles (slowest clock) required before any activity on =
AHB. */
+	/* 1 microsecond might match all implementations */
+	usleep_range(1, 2);
+
+	enable_irq(gpu->irq);
+
 	return 0;
=20
+disable_clk_shader:
+	clk_disable_unprepare(gpu->clk_shader);
 disable_clk_core:
 	clk_disable_unprepare(gpu->clk_core);
 disable_clk_bus:
@@ -1643,6 +1662,8 @@ static int etnaviv_gpu_clk_enable(struct etnaviv_gpu =
*gpu)
=20
 static int etnaviv_gpu_clk_disable(struct etnaviv_gpu *gpu)
 {
+	disable_irq(gpu->irq);
+	reset_control_assert(gpu->rst);
 	clk_disable_unprepare(gpu->clk_shader);
 	clk_disable_unprepare(gpu->clk_core);
 	clk_disable_unprepare(gpu->clk_bus);
@@ -1876,6 +1897,9 @@ static int etnaviv_gpu_platform_probe(struct platform=
_device *pdev)
 	if (gpu->irq < 0)
 		return gpu->irq;
=20
+	/* Avoid enabling the interrupt until everything is ready */
+	irq_set_status_flags(gpu->irq, IRQ_NOAUTOEN);
+
 	err =3D devm_request_irq(&pdev->dev, gpu->irq, irq_handler, 0,
 			       dev_name(gpu->dev), gpu);
 	if (err) {
@@ -1883,6 +1907,12 @@ static int etnaviv_gpu_platform_probe(struct platfor=
m_device *pdev)
 		return err;
 	}
=20
+	/* Get Reset: */
+	gpu->rst =3D devm_reset_control_get_optional(&pdev->dev, NULL);
+	if (IS_ERR(gpu->rst))
+		return dev_err_probe(dev, PTR_ERR(gpu->rst),
+				     "failed to get reset\n");
+
 	/* Get Clocks: */
 	gpu->clk_reg =3D devm_clk_get_optional(&pdev->dev, "reg");
 	DBG("clk_reg: %p", gpu->clk_reg);
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h b/drivers/gpu/drm/etnavi=
v/etnaviv_gpu.h
index 31322195b9e4..8c181191755e 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2015-2018 Etnaviv Project
+ * Copyright (C) 2024 Thales
  */
=20
 #ifndef __ETNAVIV_GPU_H__
@@ -157,6 +158,7 @@ struct etnaviv_gpu {
 	struct clk *clk_reg;
 	struct clk *clk_core;
 	struct clk *clk_shader;
+	struct reset_control *rst;
=20
 	unsigned int freq_scale;
 	unsigned int fe_waitcycles;
--=20
2.19.1


