Return-Path: <linux-kernel+bounces-396617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9829BCF96
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F72B1C257AC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881B61D9593;
	Tue,  5 Nov 2024 14:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thalesgroup.com header.i=@thalesgroup.com header.b="QX7qPsrS"
Received: from esa.hc1631-21.eu.iphmx.com (esa.hc1631-21.eu.iphmx.com [23.90.123.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04DD33080
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 14:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.90.123.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730817520; cv=none; b=SzNOc69+E8x+fP4mE8gUN77aYhltdrYa6IZF7SDzyCm9JJooO8CiWUauORwIR8Y/0zi6b62Ye5Y+dddGphJULuCeWMyDOeNt46kt7LNLD2EcLBfrlFyPX5K3B0zEheM08iEv+OiX/Mjr53KBUIz2npMkQmlCXzay7i8yH7lXw7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730817520; c=relaxed/simple;
	bh=EKLSSDedBiVA9ftpjZ4AwLRovFbARDGX2Jno5+pyMXI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=T7hlPiExsSHiFc9ttCwV00ZTUllgBGgAo8PnjRZbKOXqXrA7auDr18OBAdzJfvv5Dff26bDop1Y1aPegQw/nXQovLfkYruZU9M62UNh3Qi3RrWvMgw/03BQMiRQ7gvtDQG+jM8Yy1L4ABg+LqbrKR2dRDKn1m+Vz3YWoLp6Qyt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thalesgroup.com; spf=pass smtp.mailfrom=thalesgroup.com; dkim=pass (2048-bit key) header.d=thalesgroup.com header.i=@thalesgroup.com header.b=QX7qPsrS; arc=none smtp.client-ip=23.90.123.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thalesgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thalesgroup.com
X-CSE-ConnectionGUID: GMyWrB2RQ+ublfCmf0cDFA==
X-CSE-MsgGUID: xIMXLFppTvWjd1DkZj2yEg==
Authentication-Results: ob1.hc1631-21.eu.iphmx.com; dkim=pass (signature verified) header.i=@thalesgroup.com
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="22961881"
X-IronPort-AV: E=Sophos;i="6.10,215,1719871200"; 
   d="scan'208";a="22961881"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=thalesgroup.com; i=@thalesgroup.com; s=bbmfo20230504;
  t=1730817447;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=o9Vc5ob2XHcxtObi7LqU5Blt1DnixNEvcsEGSma0b9s=;
  b=QX7qPsrS0kKD1kXjSnuwMDzejtTRPVgIS79HIKyOMuPJH8+795HldmeK
   2s2FcZ8Mr0i3ICV/LHNl5qEXsqrUGulQGrggkrwO5IuY+R6i57DQehF2+
   3ANsKqIGpMgkW9FNvEyoTqJsc5XYY2POPKKjAcslW5G2v2Rb/zqlm74ad
   jIaqjsct46cZA916kPHAOGw9A15UOuTdOtNI+v4FDx6WkSXwa5H59jo7Y
   xI8HOHnGtRgks3uSL+yrfPlEiHeDZQzTU4L8C9zxiurQUVkWl2mz3VWDC
   +YNwm/xeaKjwOXEyY2W6P9L135rwttEqL754hF2qyTaOKN85XhftKVdG5
   w==;
X-CSE-ConnectionGUID: JH/+T6rVSs+ZJbBKoU/hAQ==
X-CSE-MsgGUID: cItUh0okRwuUKOX2RoKwmQ==
X-CSE-ConnectionGUID: jZ31JfBtQsi7KpjpS38rQQ==
X-CSE-MsgGUID: lV6Tz9o0Rj2ASal+F0ozYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="33983816"
X-IronPort-AV: E=Sophos;i="6.11,260,1725314400"; 
   d="scan'208";a="33983816"
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
Subject: [PATCH] drm/etnaviv: add optional reset support
Thread-Topic: [PATCH] drm/etnaviv: add optional reset support
Thread-Index: AdsvjVFvm5nmXEwsR6+Q63EAaSdekw==
Date: Tue, 5 Nov 2024 14:37:26 +0000
Message-ID: <0825fa6ad3954cda970b42c25b45fb0d@thalesgroup.com>
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

Signed-off-by: LECOINTRE Philippe <philippe.lecointre@thalesgroup.com>
Reviewed-by: LENAIN Simon <simon.lenain@thalesgroup.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 29 +++++++++++++++++++++++++++
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h |  2 ++
 2 files changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnavi=
v/etnaviv_gpu.c
index 7c7f97793ddd..f698fec50343 100644
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
@@ -13,6 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
+#include <linux/reset.h>
 #include <linux/thermal.h>
=20
 #include "etnaviv_cmdbuf.h"
@@ -1629,8 +1631,24 @@ static int etnaviv_gpu_clk_enable(struct etnaviv_gpu=
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
@@ -1643,6 +1661,8 @@ static int etnaviv_gpu_clk_enable(struct etnaviv_gpu =
*gpu)
=20
 static int etnaviv_gpu_clk_disable(struct etnaviv_gpu *gpu)
 {
+	disable_irq(gpu->irq);
+	reset_control_assert(gpu->rst);
 	clk_disable_unprepare(gpu->clk_shader);
 	clk_disable_unprepare(gpu->clk_core);
 	clk_disable_unprepare(gpu->clk_bus);
@@ -1876,6 +1896,9 @@ static int etnaviv_gpu_platform_probe(struct platform=
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
@@ -1883,6 +1906,12 @@ static int etnaviv_gpu_platform_probe(struct platfor=
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


