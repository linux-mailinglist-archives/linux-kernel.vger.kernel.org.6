Return-Path: <linux-kernel+bounces-378786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEFA9AD576
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D5EC1C21D8B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5EE1D5AAD;
	Wed, 23 Oct 2024 20:29:15 +0000 (UTC)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAFC14EC62
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 20:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.161.129.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715355; cv=none; b=RFEp+HkukVOVjy0qQzYOzEomocAVh5T+SXzxb0yKWCmrVL/G3syAeAHi4idritBlgjWc+o1uYuR0n6TFr0qHeGCeWYuq9NSG99NkqCXSlLbfY4T6CWHWYPwGCXWZ+3EQGW7ztn+KeOkuQIZsGRy0IwDFHdsLmr7Pch+6/UpfHHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715355; c=relaxed/simple;
	bh=VqN3u1ZMr0zI8w4T9GZg5gzHiHk41M7DTdqxJMq4QZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qTic+NKHSeZ7X5/ZGtL19c8tCgVggakv9NzW4pM6Yw6NJFrWMd0Y5uaxvxm3P8QpliG7TUE05Vug0qpARD85B6cE2rKKJr+yHNlAma/J1Pv/+grqUBTnhC/ifRhoWPmzyBgHDkQa8Y3uOeVI5k6Amt6XeXJ0IB4Any61JlCBNKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; arc=none smtp.client-ip=108.161.129.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
	by finn.localdomain with esmtp (Exim 4.95)
	(envelope-from <tharvey@gateworks.com>)
	id 1t3hyb-001CNZ-6x;
	Wed, 23 Oct 2024 20:29:05 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Heiko Schocher <hs@denx.de>,
	Tom Rini <trini@konsulko.com>,
	Peng Fan <peng.fan@nxp.com>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	u-boot@lists.denx.de
Cc: linux-kernel@vger.kernel.org,
	Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 4/4] mmc: fsl_esdhc: Convert to use livetree API for fdt access
Date: Wed, 23 Oct 2024 13:28:55 -0700
Message-Id: <20241023202855.1571188-4-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241023202855.1571188-1-tharvey@gateworks.com>
References: <20241023202855.1571188-1-tharvey@gateworks.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert to using livetree API functions.

Without this if livetree is enabled (OF_LIVE) the fsl_esdhc_imx
driver will fail to read vendor-specific properties from the dt.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/mmc/fsl_esdhc_imx.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/fsl_esdhc_imx.c b/drivers/mmc/fsl_esdhc_imx.c
index fb410104c1fc..d7a45ef0ad0d 100644
--- a/drivers/mmc/fsl_esdhc_imx.c
+++ b/drivers/mmc/fsl_esdhc_imx.c
@@ -1398,8 +1398,7 @@ static int fsl_esdhc_of_to_plat(struct udevice *dev)
 	struct udevice *vqmmc_dev;
 	int ret;
 
-	const void *fdt = gd->fdt_blob;
-	int node = dev_of_offset(dev);
+	ofnode node = dev_ofnode(dev);
 	fdt_addr_t addr;
 	unsigned int val;
 
@@ -1413,15 +1412,15 @@ static int fsl_esdhc_of_to_plat(struct udevice *dev)
 	priv->dev = dev;
 	priv->mode = -1;
 
-	val = fdtdec_get_int(fdt, node, "fsl,tuning-step", 1);
+	val = ofnode_read_u32_default(node, "fsl,tuning-step", 1);
 	priv->tuning_step = val;
-	val = fdtdec_get_int(fdt, node, "fsl,tuning-start-tap",
-			     ESDHC_TUNING_START_TAP_DEFAULT);
+	val = ofnode_read_u32_default(node, "fsl,tuning-start-tap",
+				      ESDHC_TUNING_START_TAP_DEFAULT);
 	priv->tuning_start_tap = val;
-	val = fdtdec_get_int(fdt, node, "fsl,strobe-dll-delay-target",
-			     ESDHC_STROBE_DLL_CTRL_SLV_DLY_TARGET_DEFAULT);
+	val = ofnode_read_u32_default(node, "fsl,strobe-dll-delay-target",
+				      ESDHC_STROBE_DLL_CTRL_SLV_DLY_TARGET_DEFAULT);
 	priv->strobe_dll_delay_target = val;
-	val = fdtdec_get_int(fdt, node, "fsl,signal-voltage-switch-extra-delay-ms", 0);
+	val = ofnode_read_u32_default(node, "fsl,signal-voltage-switch-extra-delay-ms", 0);
 	priv->signal_voltage_switch_extra_delay_ms = val;
 
 	if (dev_read_bool(dev, "broken-cd"))
-- 
2.25.1


