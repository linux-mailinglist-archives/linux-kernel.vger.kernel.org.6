Return-Path: <linux-kernel+bounces-449111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA66F9F4A04
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 070E0161FD0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075801EE029;
	Tue, 17 Dec 2024 11:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thalesgroup.com header.i=@thalesgroup.com header.b="GUpTgMck"
Received: from esa.hc1631-21.eu.iphmx.com (esa.hc1631-21.eu.iphmx.com [23.90.122.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6AD1DDA35
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 11:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.90.122.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734435382; cv=none; b=nlIy0qbyrud7/DW/vjUFxt2rvCV10DLduw8MBV+OfWB2WL09NFH7GKdoCD1qiQ9zR+IxyooefWXhKBfdXFwRsqoQryW9SBKv8+z5kV/W0E6EH2LRdAv5wC/FLhKXItCRBjeB1+wdTNu0ADRg7eZknGjd5p6FfwTXWA/W9fQcK5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734435382; c=relaxed/simple;
	bh=xhDQXgulsFB1Srw6sfII+mtBkKsIsQf6ipNZr6mWTZ4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=USL3Q2F+d5Q+uj9LuI4qAGzKXvZt4qGot3mgs5A1ROQbLnvttkSGcjniJYX+Kgc8mkbFpNtupwGoMlS0y/myoa2nsxZMrZKXiRLNYk8vaXL5DpT0pHiewertNuYjv2LhiTO9QTTSvx+gQ5w9Ty7Lv5wVsKQT/d3tiGr+WmchXR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thalesgroup.com; spf=pass smtp.mailfrom=thalesgroup.com; dkim=pass (2048-bit key) header.d=thalesgroup.com header.i=@thalesgroup.com header.b=GUpTgMck; arc=none smtp.client-ip=23.90.122.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thalesgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thalesgroup.com
X-CSE-ConnectionGUID: 8Yh9+6fISe2iK2I/KtNpuA==
X-CSE-MsgGUID: oZSErJDLSNm/FXN7rQtuaw==
Authentication-Results: ob1.hc1631-21.eu.iphmx.com; dkim=pass (signature verified) header.i=@thalesgroup.com
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="23781350"
X-IronPort-AV: E=Sophos;i="6.12,241,1728943200"; 
   d="scan'208";a="23781350"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=thalesgroup.com; i=@thalesgroup.com; s=bbmfo20230504;
  t=1734435373;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=TD5JtJ2CP9uixpsc/oDUrpMauClPo34I9Wrt3XUOczw=;
  b=GUpTgMckTYH4IazAUpRsiPtjvDwwgGVK2wIf9qo1OlGc+7xq1lEb4hxl
   MAklz1hjXi8iZcAdd7MrIw/aUsjedGmGuNotQ1VoPHlYSk3Hd4acMj9/M
   JLVWFs19pAZ/Awn79lzJySw5fyC+pl+TNfODhxndlhM8DQjMH5s7pUuLr
   u4v8WAhufV6iuLI6JAUX1HSOlbYTJI1BAtpE5QlKdP0MKkdSlruEyn2Fc
   6la+kCw7gQ9eTBYZ9KtPIY1o6JaFm59xwnSTq4M62WDGcsHGv5Opq1hUE
   HP0X8o+rSNZ9bbBIRA8T0a3wQzbYY1wd421u4hUrTeNQva7t2b4QZP917
   A==;
X-CSE-ConnectionGUID: 8s2N3jN+Rx+SWeG1Df5rxQ==
X-CSE-MsgGUID: Tv9LX4IET4GmK/yKmmTagg==
X-CSE-ConnectionGUID: /bhLdXNKTBG1cwQzZZTApg==
X-CSE-MsgGUID: gGjcmQmfQiWgACfXvEJgMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="37641209"
X-IronPort-AV: E=Sophos;i="6.12,241,1728943200"; 
   d="scan'208";a="37641209"
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
Subject: [PATCH v4] drm/etnaviv: add optional reset support
Thread-Topic: [PATCH v4] drm/etnaviv: add optional reset support
Thread-Index: AdtQdTRCCPdja+p8TdeGkYsfNshIoA==
Date: Tue, 17 Dec 2024 11:36:11 +0000
Message-ID: <a0b07a6b542d47339584f05c45951b9d@thalesgroup.com>
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

Signed-off-by: Philippe Lecointre <philippe.lecointre@thalesgroup.com>
Acked-by: Simon Lenain <simon.lenain@thalesgroup.com>
---
v4:
- Rework to match feedback
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 41 +++++++++++++++++++++++++++
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h |  2 ++
 2 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnavi=
v/etnaviv_gpu.c
index 2d4c112ce033..cf0d9049bcf1 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -13,6 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
+#include <linux/reset.h>
 #include <linux/thermal.h>
=20
 #include "etnaviv_cmdbuf.h"
@@ -172,6 +173,29 @@ int etnaviv_gpu_get_param(struct etnaviv_gpu *gpu, u32=
 param, u64 *value)
 	return 0;
 }
=20
+static int etnaviv_gpu_reset_deassert(struct etnaviv_gpu *gpu)
+{
+	int ret;
+
+	/*
+	 * 32 core clock cycles (slowest clock) required before deassertion
+	 * 1 microsecond might match all implementations without computation
+	 */
+	usleep_range(1, 2);
+
+	ret =3D reset_control_deassert(gpu->rst);
+	if (ret)
+		return ret;
+
+	/*
+	 * 128 core clock cycles (slowest clock) required before any activity on =
AHB
+	 * 1 microsecond might match all implementations without computation
+	 */
+	usleep_range(1, 2);
+
+	return 0;
+}
+
 static inline bool etnaviv_is_model_rev(struct etnaviv_gpu *gpu, u32 model=
, u32 revision)
 {
 	return gpu->identity.model =3D=3D model &&
@@ -799,6 +823,12 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
 		goto pm_put;
 	}
=20
+	ret =3D etnaviv_gpu_reset_deassert(gpu);
+	if (ret) {
+		dev_err(gpu->dev, "GPU reset deassert failed\n");
+		goto fail;
+	}
+
 	etnaviv_hw_identify(gpu);
=20
 	if (gpu->identity.model =3D=3D 0) {
@@ -1860,6 +1890,17 @@ static int etnaviv_gpu_platform_probe(struct platfor=
m_device *pdev)
 	if (IS_ERR(gpu->mmio))
 		return PTR_ERR(gpu->mmio);
=20
+
+	/* Get Reset: */
+	gpu->rst =3D devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(gpu->rst))
+		return dev_err_probe(dev, PTR_ERR(gpu->rst),
+				     "failed to get reset\n");
+
+	err =3D reset_control_assert(gpu->rst);
+	if (err)
+		return dev_err_probe(dev, err, "failed to assert reset\n");
+
 	/* Get Interrupt: */
 	gpu->irq =3D platform_get_irq(pdev, 0);
 	if (gpu->irq < 0)
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h b/drivers/gpu/drm/etnavi=
v/etnaviv_gpu.h
index 4d8a7d48ade3..5cb46c84e03a 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
@@ -93,6 +93,7 @@ struct etnaviv_event {
 struct etnaviv_cmdbuf_suballoc;
 struct regulator;
 struct clk;
+struct reset_control;
=20
 #define ETNA_NR_EVENTS 30
=20
@@ -158,6 +159,7 @@ struct etnaviv_gpu {
 	struct clk *clk_reg;
 	struct clk *clk_core;
 	struct clk *clk_shader;
+	struct reset_control *rst;
=20
 	unsigned int freq_scale;
 	unsigned int fe_waitcycles;
--=20
2.19.1


