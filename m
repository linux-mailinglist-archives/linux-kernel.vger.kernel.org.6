Return-Path: <linux-kernel+bounces-264603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAB693E5E4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 17:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8CA02828F2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 15:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0375061674;
	Sun, 28 Jul 2024 15:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gq4N/JrR"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6FC47F6B
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722180580; cv=none; b=UR4xg7zF9aj9DF89Ymo+Yb8lSFghvO2hMj7ic2q7padkVXR2akrOTQ2dYyqu2SSO3k9PYw4w0MkbJkiU8Yn+A05hVQ1OSPYnuN7GVsrE8hUYVRMPKhdhUbbs2Caw5yS0+gB6324hvLCBSu25jz4nwXzJ4ixlbCEvLxSiDVgnux0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722180580; c=relaxed/simple;
	bh=l6/axAxT1nImCxb/08PZN9pSh55S2eFKDjVck8Y8f9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b411xZ6VgeQUkjlVY2GyRSSZGEudYtzkr8PKk+Ptk3aGhqp6aSj54gLi/XUFKIBZ3r3CEb29UWKL096WBNGA8YB+GgisulGwt98ChI88oDCUqBwezvZNdlGHjApbyii7yRpjavtGKPSTL8D+eBmslGqLJm/clNr7bSD+vMWgFwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gq4N/JrR; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722180575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mGMP4UD3xC3yrKSpA14XHS8J7hiEnnbLaoTLGmdC2zM=;
	b=gq4N/JrRvwgRq7xagbrOED1rxYhRCmNb94Ybw/st/0xNVSgJzp8ZNKSNw1cq8ZyoOxjlDx
	T+UBp2cS1mvXk4xf5hGjXNKw7SGtLaPS/k1FyAyZzr4ZDGMLHI0GK541PmRWTOESsd7TlA
	MzdKpCHPeO6vvNnMHYulDvrmR/sSkbU=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Markus Elfring <elfring@users.sourceforge.net>
Cc: Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH v5 2/2] drm/loongson: Add dummy gpu driver as a subcomponent
Date: Sun, 28 Jul 2024 23:28:58 +0800
Message-ID: <20240728152858.346211-3-sui.jingfeng@linux.dev>
In-Reply-To: <20240728152858.346211-1-sui.jingfeng@linux.dev>
References: <20240728152858.346211-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Loongson Graphics are PCIe multifunctional devices, the GPU and the
display controller are two distinct devices. Despite hardware units
that come along with PCIe are already ready to be driven by the time
the driver is loaded, drm/loongson driver still need to wait all of
its dependencies ready before it can register DRM service to user space.
The newly introduced component framework allow us to use loose coupling
design. Therefore, add a dummy driver for the GPU, it is functional as
a subcomponent as well.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/loongson/Makefile           |   3 +
 drivers/gpu/drm/loongson/loonggpu_pci_drv.c | 163 ++++++++++++++++++++
 drivers/gpu/drm/loongson/loonggpu_pci_drv.h |  35 +++++
 drivers/gpu/drm/loongson/loongson_drv.c     |   1 +
 drivers/gpu/drm/loongson/loongson_module.c  |   4 +
 drivers/gpu/drm/loongson/loongson_module.h  |   1 +
 6 files changed, 207 insertions(+)
 create mode 100644 drivers/gpu/drm/loongson/loonggpu_pci_drv.c
 create mode 100644 drivers/gpu/drm/loongson/loonggpu_pci_drv.h

diff --git a/drivers/gpu/drm/loongson/Makefile b/drivers/gpu/drm/loongson/Makefile
index 90c6239bd77d..cdc60ec975e4 100644
--- a/drivers/gpu/drm/loongson/Makefile
+++ b/drivers/gpu/drm/loongson/Makefile
@@ -17,6 +17,9 @@ loongson-y := \
 	lsdc_probe.o \
 	lsdc_ttm.o
 
+loongson-y += \
+	loonggpu_pci_drv.o
+
 loongson-y += loongson_device.o \
 	      loongson_drv.o \
 	      loongson_module.o
diff --git a/drivers/gpu/drm/loongson/loonggpu_pci_drv.c b/drivers/gpu/drm/loongson/loonggpu_pci_drv.c
new file mode 100644
index 000000000000..52785a130b83
--- /dev/null
+++ b/drivers/gpu/drm/loongson/loonggpu_pci_drv.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * Authors:
+ *      Sui Jingfeng <sui.jingfeng@linux.dev>
+ */
+
+#include <linux/component.h>
+#include <linux/pci.h>
+
+#include <drm/drm_device.h>
+#include <drm/drm_print.h>
+
+#include "loongson_drv.h"
+#include "loongson_module.h"
+#include "loonggpu_pci_drv.h"
+
+static int loonggpu_get_version(struct loonggpu_device *gpu)
+{
+	u32 hw_info = loong_rreg32(gpu, 0x8C);
+	u8 host_id;
+	u8 revision;
+
+	/* LoongGPU hardware info */
+	gpu->ver_major = (hw_info >> 8) & 0x0F;
+	gpu->ver_minor = (hw_info & 0xF0) >> 4;
+	revision = hw_info & 0x0F;
+	host_id = (hw_info >> 16) & 0xFF;
+
+	drm_info(gpu->drm, "LoongGPU(TM): LG%x%x0, revision: %x, Host: %s\n",
+		 gpu->ver_major, gpu->ver_minor, revision,
+		 host_id ? "LS2K2000" : "LS7A2000");
+
+	return 0;
+}
+
+static irqreturn_t loonggpu_irq_handler(int irq, void *arg)
+{
+	struct loonggpu_device *gpu = arg;
+
+	drm_dbg(gpu->drm, "LoongGPU(TM) interrupted\n");
+
+	return IRQ_HANDLED;
+}
+
+static int loonggpu_pci_component_bind(struct device *dev,
+				   struct device *master,
+				   void *data)
+{
+	struct loonggpu_device *gpu = dev_get_drvdata(dev);
+	struct drm_device *drm = data;
+	struct loongson_drm *ldrm = to_loongson_drm(drm);
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int ret;
+
+	gpu->drm = drm;
+	ldrm->loonggpu = gpu;
+
+	loonggpu_get_version(gpu);
+
+	ret = devm_request_irq(dev,
+			       pdev->irq,
+			       loonggpu_irq_handler,
+			       IRQF_SHARED,
+			       dev_name(dev),
+			       gpu);
+	if (ret)
+		return ret;
+
+	drm_info(gpu->drm, "LoongGPU(TM) irq: %d\n", pdev->irq);
+
+	return 0;
+}
+
+static void loonggpu_pci_component_unbind(struct device *dev,
+				      struct device *master,
+				      void *data)
+{
+	dev_dbg(dev, "LoongGPU(TM) unbind\n");
+}
+
+static const struct component_ops loonggpu_pci_component_ops = {
+	.bind = loonggpu_pci_component_bind,
+	.unbind = loonggpu_pci_component_unbind,
+};
+
+static int loonggpu_pci_probe(struct pci_dev *pdev,
+			      const struct pci_device_id *ent)
+{
+	struct loonggpu_device *gpu;
+	int ret;
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return ret;
+
+	pci_set_master(pdev);
+
+	gpu = devm_kzalloc(&pdev->dev, sizeof(*gpu), GFP_KERNEL);
+	if (!gpu)
+		return -ENOMEM;
+
+	gpu->pdev = pdev;
+
+	gpu->reg_base = pcim_iomap(pdev, 0, 0);
+	if (!gpu->reg_base)
+		return -ENOMEM;
+
+	pci_set_drvdata(pdev, gpu);
+
+	dev_info(&pdev->dev, "LoongGPU(TM) PCI driver probed\n");
+
+	return component_add(&pdev->dev, &loonggpu_pci_component_ops);
+}
+
+static void loonggpu_pci_remove(struct pci_dev *pdev)
+{
+	component_del(&pdev->dev, &loonggpu_pci_component_ops);
+}
+
+static int loonggpu_pm_suspend(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	pci_save_state(pdev);
+	pci_disable_device(pdev);
+	pci_set_power_state(pdev, PCI_D3hot);
+
+	return 0;
+}
+
+static int loonggpu_pm_resume(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	pci_set_power_state(pdev, PCI_D0);
+	pci_restore_state(pdev);
+
+	if (pcim_enable_device(pdev))
+		return -EIO;
+
+	return 0;
+}
+
+static const struct dev_pm_ops loonggpu_pm_ops = {
+	.suspend = loonggpu_pm_suspend,
+	.resume = loonggpu_pm_resume,
+};
+
+static const struct pci_device_id loonggpu_pci_id_list[] = {
+	{PCI_VDEVICE(LOONGSON, 0x7a25), CHIP_LS7A2000},
+	{ },
+};
+
+struct pci_driver loonggpu_pci_driver = {
+	.name = "loongson.loonggpu",
+	.id_table = loonggpu_pci_id_list,
+	.probe = loonggpu_pci_probe,
+	.remove = loonggpu_pci_remove,
+	.driver.pm = &loonggpu_pm_ops,
+};
+
+MODULE_DEVICE_TABLE(pci, loonggpu_pci_id_list);
diff --git a/drivers/gpu/drm/loongson/loonggpu_pci_drv.h b/drivers/gpu/drm/loongson/loonggpu_pci_drv.h
new file mode 100644
index 000000000000..1ba64ef12835
--- /dev/null
+++ b/drivers/gpu/drm/loongson/loonggpu_pci_drv.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Authors:
+ *      Sui Jingfeng <sui.jingfeng@linux.dev>
+ */
+
+#ifndef __LOONGGPU_PCI_DRV_H__
+#define __LOONGGPU_PCI_DRV_H__
+
+#include <linux/component.h>
+#include <linux/pci.h>
+
+struct loonggpu_device {
+	struct pci_dev *pdev;
+	struct drm_device *drm;
+
+	void __iomem *reg_base;
+	int irq;
+
+	u32 ver_major;
+	u32 ver_minor;
+	u32 revision;
+};
+
+static inline u32 loong_rreg32(struct loonggpu_device *ldev, u32 offset)
+{
+	return readl(ldev->reg_base + offset);
+}
+
+static inline void loong_wreg32(struct loonggpu_device *ldev, u32 offset, u32 val)
+{
+	writel(val, ldev->reg_base + offset);
+}
+
+#endif
diff --git a/drivers/gpu/drm/loongson/loongson_drv.c b/drivers/gpu/drm/loongson/loongson_drv.c
index 1d7735cd1b89..f396a7add6ec 100644
--- a/drivers/gpu/drm/loongson/loongson_drv.c
+++ b/drivers/gpu/drm/loongson/loongson_drv.c
@@ -19,6 +19,7 @@
 
 #include "loongson_drv.h"
 #include "loongson_module.h"
+#include "loonggpu_pci_drv.h"
 #include "lsdc_drv.h"
 #include "lsdc_gem.h"
 #include "lsdc_output.h"
diff --git a/drivers/gpu/drm/loongson/loongson_module.c b/drivers/gpu/drm/loongson/loongson_module.c
index 918c1cfbac6f..f4b3dfaf3b5c 100644
--- a/drivers/gpu/drm/loongson/loongson_module.c
+++ b/drivers/gpu/drm/loongson/loongson_module.c
@@ -27,6 +27,10 @@ static const struct loongson_driver_info loongson_driver_array[] = {
 		.driver = &lsdc_pci_driver.driver,
 		.type = LOONGSON_DRIVER_FLAG_PCI,
 	},
+	{
+		.driver = &loonggpu_pci_driver.driver,
+		.type = LOONGSON_DRIVER_FLAG_PCI,
+	},
 	{
 		.driver = &loongson_drm_platform_driver.driver,
 		.type = LOONGSON_DRIVER_FLAG_PLATFORM | LOONGSON_DRIVER_FLAG_FAKE_MASTER,
diff --git a/drivers/gpu/drm/loongson/loongson_module.h b/drivers/gpu/drm/loongson/loongson_module.h
index e8f268b14fee..95e0201a8661 100644
--- a/drivers/gpu/drm/loongson/loongson_module.h
+++ b/drivers/gpu/drm/loongson/loongson_module.h
@@ -37,6 +37,7 @@ const struct loongson_driver_info *loongson_get_driver_info_array(int *num);
 extern int loongson_vblank;
 
 extern struct pci_driver lsdc_pci_driver;
+extern struct pci_driver loonggpu_pci_driver;
 extern struct platform_driver lsdc_output_platform_driver;
 extern struct platform_driver loongson_drm_platform_driver;
 
-- 
2.43.0


