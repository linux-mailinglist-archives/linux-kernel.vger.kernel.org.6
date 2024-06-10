Return-Path: <linux-kernel+bounces-207865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E633901D2A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE8D7B21623
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B5D7316F;
	Mon, 10 Jun 2024 08:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b="YRQ4a+am"
Received: from mx.adeep.su (mx.adeep.su [185.250.0.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2900F55C29;
	Mon, 10 Jun 2024 08:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.250.0.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718008875; cv=none; b=atGLhpOq5y0WNcTlB3wkbIeBevhbVFZpRwx0P5xX/Ag/5uZCS9EVClmv4XZduqCRBgmAMtlSqSYP5TdlcdDDynwygmG0Sv96yra/DE0lt4fJSxwm5N4+eqEqlSKls8tbPCI8l/fCtss8otxF7UJOk7s1NFVqJN91W3CBB2oUZxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718008875; c=relaxed/simple;
	bh=/LlJMImS2gcMz66PX0akSkRfN/F74m4UUyvJYm1SqUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PM8y7Im7hHDO2pGp6q2xSNBQJQ+EvI/uiexOQgpow3wcwR1NSzphgSX+mKK4JusTZVEGFNmHfyWpazsferlRrV+lavVVwtTI8LnQqQ/FEOgvtuTfTqwzkRRN8AicL2FjnHYlfGYGz20CzVbmL4WAmByIgLAMTfVzmMUPALDGndA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in; spf=pass smtp.mailfrom=lexina.in; dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b=YRQ4a+am; arc=none smtp.client-ip=185.250.0.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lexina.in
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BD356FAF84;
	Mon, 10 Jun 2024 11:41:10 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1718008870; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=7Ikj+bHTocpyNZS+nTDcS+kSHIb7v511fQ33jkgoJFc=;
	b=YRQ4a+amm1ine9TmTkBCWMSHZJxnHPjVZHJilBbn6YYHZb7br/cxSCFEYfG7UrNR0j6Zj8
	g4gsUcMjKHrvJSqPcmF2BOOFUh3UWmpwof8fc4u1W5kyOip+7mZrhLzrW4sqMJOAJbrug3
	XiTUcaybUZnmpUbNcCuhkqkeC5LX+mc9dwdr9UVm7UTkupE/UlKVa5Z4TJLGag6xY81Zim
	2gZNnKb2GkvaCS2roEO7hx2NbA5FgJHBMgLArj+RDu9XQjwVLmq4RpOmBnkSlAiVgBClW9
	5p8FPuwLK8djMLwWgJJEI3TbFUW9SPYUUvgJIbVCJ5W/fZPiSCGKunM1Q6BJFA==
From: Viacheslav Bocharov <adeep@lexina.in>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH v5 2/4] soc: amlogic: meson-gx-socinfo-sm: Add Amlogic secure-monitor SoC Information driver
Date: Mon, 10 Jun 2024 11:39:48 +0300
Message-ID: <20240610084032.3096614-3-adeep@lexina.in>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240610084032.3096614-1-adeep@lexina.in>
References: <20240610084032.3096614-1-adeep@lexina.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Amlogic SoCs have a SoC information secure-monitor call for SoC type,
package type, revision information and chipid.
This patchs adds support for secure-monitor call decoding and exposing
with the SoC bus infrastructure in addition to the previous SoC
Information driver.

Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
---
 drivers/soc/amlogic/Kconfig                   |  10 +
 drivers/soc/amlogic/Makefile                  |   1 +
 .../soc/amlogic/meson-gx-socinfo-internal.h   |  14 +-
 drivers/soc/amlogic/meson-gx-socinfo-sm.c     | 190 ++++++++++++++++++
 4 files changed, 211 insertions(+), 4 deletions(-)
 create mode 100644 drivers/soc/amlogic/meson-gx-socinfo-sm.c

diff --git a/drivers/soc/amlogic/Kconfig b/drivers/soc/amlogic/Kconfig
index d08e398bdad4..82fc77ca3b4b 100644
--- a/drivers/soc/amlogic/Kconfig
+++ b/drivers/soc/amlogic/Kconfig
@@ -26,6 +26,16 @@ config MESON_GX_SOCINFO
 	  Say yes to support decoding of Amlogic Meson GX SoC family
 	  information about the type, package and version.
 
+config MESON_GX_SOCINFO_SM
+	bool "Amlogic Meson GX SoC Information driver via Secure Monitor"
+	depends on (ARM64 && ARCH_MESON || COMPILE_TEST) && MESON_SM=y
+	default ARCH_MESON && MESON_SM
+	select SOC_BUS
+	help
+	  Say yes to support decoding of Amlogic Meson GX SoC family
+	  information about the type, package and version via secure
+	  monitor call.
+
 config MESON_MX_SOCINFO
 	bool "Amlogic Meson MX SoC Information driver"
 	depends on (ARM && ARCH_MESON) || COMPILE_TEST
diff --git a/drivers/soc/amlogic/Makefile b/drivers/soc/amlogic/Makefile
index c25f835e6a26..45d9d6f5904c 100644
--- a/drivers/soc/amlogic/Makefile
+++ b/drivers/soc/amlogic/Makefile
@@ -2,4 +2,5 @@
 obj-$(CONFIG_MESON_CANVAS) += meson-canvas.o
 obj-$(CONFIG_MESON_CLK_MEASURE) += meson-clk-measure.o
 obj-$(CONFIG_MESON_GX_SOCINFO) += meson-gx-socinfo.o
+obj-$(CONFIG_MESON_GX_SOCINFO_SM) += meson-gx-socinfo-sm.o
 obj-$(CONFIG_MESON_MX_SOCINFO) += meson-mx-socinfo.o
diff --git a/drivers/soc/amlogic/meson-gx-socinfo-internal.h b/drivers/soc/amlogic/meson-gx-socinfo-internal.h
index 42cd57e67390..5559573c9024 100644
--- a/drivers/soc/amlogic/meson-gx-socinfo-internal.h
+++ b/drivers/soc/amlogic/meson-gx-socinfo-internal.h
@@ -33,10 +33,16 @@ union meson_cpu_id {
 	u32	raw;
 };
 
-struct meson_sm_chip_id {
-	u32 version;
-	union meson_cpu_id cpu_id;
-	u8 serial[12];
+union meson_sm_chip_id {
+	struct { // cpu_id v2
+		u32 version;
+		union meson_cpu_id cpu_id;
+		u8 serial[12];
+	} v2;
+	struct { // raw
+		u32 version;
+		u8 buf[12 + sizeof(union meson_cpu_id)];
+	} raw;
 };
 
 static const struct meson_gx_soc_id {
diff --git a/drivers/soc/amlogic/meson-gx-socinfo-sm.c b/drivers/soc/amlogic/meson-gx-socinfo-sm.c
new file mode 100644
index 000000000000..e12f45cd8de2
--- /dev/null
+++ b/drivers/soc/amlogic/meson-gx-socinfo-sm.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2017 BayLibre, SAS
+ * Copyright (c) 2024 JetHome
+ * Author: Neil Armstrong <neil.armstrong@linaro.org>
+ * Author: Viacheslav Bocharov <adeep@lexina.in>
+ *
+ */
+
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+
+#include <linux/firmware/meson/meson_sm.h>
+
+#include "meson-gx-socinfo-internal.h"
+
+static char *socinfo_get_chipid(struct device *dev, struct meson_sm_firmware *fw,
+			       union meson_cpu_id *socinfo)
+{
+	char *buf;
+	union meson_sm_chip_id *id_buf;
+	int ret;
+
+	id_buf = kzalloc(sizeof(union meson_sm_chip_id)+1, GFP_KERNEL);
+	if (!id_buf)
+		return NULL;
+
+	ret = meson_sm_call_read(fw, id_buf, sizeof(union meson_sm_chip_id), SM_GET_CHIP_ID,
+				 2, 0, 0, 0, 0);
+	if (ret < 0) {
+		kfree(id_buf);
+		return NULL;
+	}
+	dev_info(dev, "got sm version call %i\n", id_buf->raw.version);
+
+	if (id_buf->raw.version != 2) {
+
+		u8 tmp;
+		/**
+		 * Legacy 12-byte chip ID read out, transform data
+		 * to expected order format
+		 */
+		memmove((void *)&id_buf->v2.serial, (void *)&id_buf->raw.buf, 12);
+		for (int i = 0; i < 6; i++) {
+			tmp = id_buf->v2.serial[i];
+			id_buf->v2.serial[i] = id_buf->v2.serial[11 - i];
+			id_buf->v2.serial[11 - i] = tmp;
+		}
+		id_buf->v2.cpu_id.v2.major_id = socinfo->v1.major_id;
+		id_buf->v2.cpu_id.v2.pack_id = socinfo->v1.pack_id;
+		id_buf->v2.cpu_id.v2.chip_rev = socinfo->v1.chip_rev;
+		id_buf->v2.cpu_id.v2.reserved = socinfo->v1.reserved;
+		id_buf->v2.cpu_id.v2.layout_ver = socinfo->v1.layout_ver;
+	} else {
+		/**
+		 * rewrite socinfo from regmap with value from secure monitor call
+		 */
+		socinfo->v1.major_id = id_buf->v2.cpu_id.v2.major_id;
+		socinfo->v1.pack_id = id_buf->v2.cpu_id.v2.pack_id;
+		socinfo->v1.chip_rev = id_buf->v2.cpu_id.v2.chip_rev;
+		socinfo->v1.reserved = id_buf->v2.cpu_id.v2.reserved;
+		socinfo->v1.layout_ver = id_buf->v2.cpu_id.v2.layout_ver;
+	}
+
+	buf = devm_kasprintf(dev, GFP_KERNEL, "%4phN%12phN", &(id_buf->v2.cpu_id),
+			     &(id_buf->v2.serial));
+
+	kfree(id_buf);
+
+	return buf;
+}
+
+static int meson_gx_socinfo_sm_probe(struct platform_device *pdev)
+{
+	struct soc_device_attribute *soc_dev_attr;
+	struct soc_device *soc_dev;
+	struct device_node *sm_np;
+	struct meson_sm_firmware *fw;
+	struct regmap *regmap;
+	union meson_cpu_id socinfo;
+	struct device *dev;
+	int ret;
+
+	/* check if chip-id is available */
+	if (!of_property_read_bool(pdev->dev.of_node, "amlogic,has-chip-id"))
+		return -ENODEV;
+
+	/* node should be a syscon */
+	regmap = syscon_node_to_regmap(pdev->dev.of_node);
+	if (IS_ERR(regmap))
+		return dev_err_probe(&pdev->dev, PTR_ERR(regmap), "failed to get regmap\n");
+
+	sm_np = of_parse_phandle(pdev->dev.of_node, "secure-monitor", 0);
+	if (!sm_np) {
+		dev_err(&pdev->dev, "no secure-monitor node found\n");
+		return -EINVAL;
+	}
+
+	fw = meson_sm_get(sm_np);
+	of_node_put(sm_np);
+	if (!fw) {
+		dev_dbg(&pdev->dev, "secure-monitor device not ready, probe later\n");
+		return -EPROBE_DEFER;
+	}
+
+	ret = regmap_read(regmap, AO_SEC_SOCINFO_OFFSET, &socinfo.raw);
+	if (ret < 0)
+		return ret;
+
+	if (!socinfo.raw) {
+		dev_err(&pdev->dev, "invalid regmap chipid value\n");
+		return -EINVAL;
+	}
+
+	soc_dev_attr = devm_kzalloc(&pdev->dev, sizeof(*soc_dev_attr),
+				    GFP_KERNEL);
+	if (!soc_dev_attr)
+		return -ENOMEM;
+
+	soc_dev_attr->serial_number = socinfo_get_chipid(&pdev->dev, fw, &socinfo);
+
+	soc_dev_attr->family = "Amlogic Meson";
+	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%x:%x - %x:%x",
+					   socinfo.v1.major_id,
+					   socinfo.v1.chip_rev,
+					   socinfo.v1.pack_id,
+					   (socinfo.v1.reserved<<4) + socinfo.v1.layout_ver);
+	soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "%s (%s)",
+					 socinfo_v1_to_soc_id(socinfo),
+					 socinfo_v1_to_package_id(socinfo));
+
+	soc_dev = soc_device_register(soc_dev_attr);
+
+
+	if (IS_ERR(soc_dev)) {
+		kfree(soc_dev_attr->revision);
+		kfree_const(soc_dev_attr->soc_id);
+		return PTR_ERR(soc_dev);
+	}
+
+	dev = soc_device_to_device(soc_dev);
+	platform_set_drvdata(pdev, soc_dev);
+
+	dev_info(dev, "Amlogic Meson %s Revision %x:%x (%x:%x) Detected (SM)\n",
+			soc_dev_attr->soc_id,
+			socinfo.v1.major_id,
+			socinfo.v1.chip_rev,
+			socinfo.v1.pack_id,
+			(socinfo.v1.reserved<<4) + socinfo.v1.layout_ver);
+
+	return PTR_ERR_OR_ZERO(dev);
+}
+
+
+static int meson_gx_socinfo_sm_remove(struct platform_device *pdev)
+{
+	struct soc_device *soc_dev = platform_get_drvdata(pdev);
+
+	soc_device_unregister(soc_dev);
+	return 0;
+}
+
+static const struct of_device_id meson_gx_socinfo_match[] = {
+	{ .compatible = "amlogic,meson-gx-ao-secure", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, meson_gx_socinfo_match);
+
+static struct platform_driver meson_gx_socinfo_driver = {
+	.probe = meson_gx_socinfo_sm_probe,
+	.remove	= meson_gx_socinfo_sm_remove,
+	.driver = {
+		.name = "meson-gx-socinfo-sm",
+		.of_match_table = meson_gx_socinfo_match,
+	},
+};
+
+
+module_platform_driver(meson_gx_socinfo_driver);
+
+MODULE_AUTHOR("Viacheslav Bocharov <adeep@lexina.in>");
+MODULE_DESCRIPTION("Amlogic Meson GX SOC SM driver");
+MODULE_LICENSE("GPL");
-- 
2.45.2


