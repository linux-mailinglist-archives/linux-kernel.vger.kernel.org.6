Return-Path: <linux-kernel+bounces-526506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C91B5A3FFA1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D94F3BD4D1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E41253F01;
	Fri, 21 Feb 2025 19:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmI0rlPd"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE69E253B58;
	Fri, 21 Feb 2025 19:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740165597; cv=none; b=PYjp8r/uES/7thDVg3PAvW+w+mXTCjoSAgzI2AWlw0VydLFi6QT4JCtO+edex71faHBdWPJYmUIcphvttchzJBRTN4kPE1nq7R0pwVH3+5/D15YUxwSdmvsxhtf/3j7dOlxe9CBL9TwikC69zJsbp+adfDoFyAG3dY5H+d5P8Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740165597; c=relaxed/simple;
	bh=zbfAUKiUNSyy6oSEBdQN+iRDEr73rZQgEXyyQSAdsFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZoR/kw8L7u+mNqEORuBJbl9etvXIWW/fLSNeFR2DuJ2cGZismqkWEs7Br1wTIw9u8PoKOzhHstvzC42MLi4z4kAHAnCtQErLXZD76WQF+3tJA9Kfad5H16JsAAUqG58No79pSDaEKGrfsJZG3tw0mCD21KB1bIYa6AS00RMuRlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmI0rlPd; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abbc38adeb1so431103266b.1;
        Fri, 21 Feb 2025 11:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740165594; x=1740770394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQ9m9HGe9/qjs9gf28iHfA2/6NxUxjMKKdh6HhKymZg=;
        b=RmI0rlPdXAJctQdeCEjiCUXY4ZDb70nC91zDjhLbwMYKOruxaZ+IYnHfiMczWZE9Ia
         7JPEtPbFHdZdlMOyHav2t8zdyBOqvP9Gq32/O06oVuFcBP4qVKjA5Lf7p+gq3PL81feh
         gb9IjxVFaBUJD681DN7v+vqYqWsONGEgbul7GbXUODKun1REwFsJWwo2LPzwgvUntBUU
         ysho/6ettnBHy5gwSFLP/O6QhrHNF7ZA8q1BfMX4MEEL0jptNuaLzwbPprIjfX2LiVu2
         YhF/Les2Ik6ouf5zyy/mahF1XVevLft9XaCwnEKoRVNCth+8SaIrXpEDzwle+adhsS6f
         IOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740165594; x=1740770394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQ9m9HGe9/qjs9gf28iHfA2/6NxUxjMKKdh6HhKymZg=;
        b=jjNRWcbKt2uONSMjRqwz4v0o+O6LzcfwKS1++9Kzz5eDE9Pd+h9/r+yfA4uxtlgyyZ
         qATAdwiRoJclOl0MD8qzbA09+zFjI8U0hqxwL3rLhkUK80Z03JPJUwM4pIBDHsf9fS/6
         PPGcgmVzLkDe15farMI/dtFzRvabqe1p6GBxImvJijTI3RrtiqDGhEDVdn89JG5HaFPK
         xB98nBaJgSebQWGUmEBARVFYNtyCHrtKSGB6JGOaTHlU3K74jVLwyB42U9k+1joDNCCR
         LIenPt2UpLsfzo/JesBClVzlRt5I/kXaKXRlqWYEUoQhaWLQbo8osJnN8qbQ0PoQnjQI
         jUvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWC3GokzvxcZrp36v+ZVwe/v/xchyQHg1GsQhARPagCCfVYMoNGJfDsWqyi+f6Dq+CDa2KHPZ579f0E@vger.kernel.org, AJvYcCWwj4IEp72N3d3Wl/nKcPrpZbyUmFFsXBvGne3RHUnerKkQGOEiDidx2efb/jns+MnLvdiN35b4wDbQs7bV@vger.kernel.org
X-Gm-Message-State: AOJu0YwgFSbzCsqeCaPrAJGzVowrENhgokxMC075JyDpNy5b4T4Hpr/A
	oddzkEXnjK74znzilZL8mSeJKujI4nFQ6zyB8qHcAxknpiLh2oba
X-Gm-Gg: ASbGncvEIHspzNAbiscAZb/PxTGgHnJE+jha8yj/16cHBZBfQH/UH0jcSDfzxqqjG3N
	oq4t6PZtfHm3J3ME+6orews5T7RpnxA4FgqeFRhp4CxETrwRf2jk0e3ZalnoN5ACMAlHM4rvizR
	nTEep6th8Gk7p+v564QsriecZrgx8wJFXBW4VXPoGhe/Pkr2b70SqHx9Iz/jn7/Gbw7+EXhq9U1
	eAWVG15dwk3TK9GDijLIuBV8aDUf2iqjupj0jTGlFCpQAp/wkfgyNxdArQNLj32YCYE9DtrydOO
	T4CAsxGVAxno+YU86/hshmoV39OCtLVrGeH2g6Y6KwsNFcgymisFi18vDF4=
X-Google-Smtp-Source: AGHT+IE3CwqgwPcD60DkN7R6068FIpprPZitsT+PIQCgtbOY0Zrq/F8xkAzZ5w5gvOhKLrjtzpX6hg==
X-Received: by 2002:a17:906:794e:b0:abb:d9c6:ecb2 with SMTP id a640c23a62f3a-abc09aa9b80mr441416066b.21.1740165593802;
        Fri, 21 Feb 2025 11:19:53 -0800 (PST)
Received: from playground.nxp.com ([82.79.237.175])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9cee79fasm995276266b.129.2025.02.21.11.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 11:19:53 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] bus: add driver for IMX AIPSTZ bridge
Date: Fri, 21 Feb 2025 14:19:07 -0500
Message-Id: <20250221191909.31874-4-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221191909.31874-1-laurentiumihalcea111@gmail.com>
References: <20250221191909.31874-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

The secure AHB to IP Slave (AIPSTZ) bus bridge provides access control
configurations meant to restrict access to certain peripherals.
Some of the configurations include:

	1) Marking masters as trusted for R/W. Based on this
	(and the configuration of the accessed peripheral), the bridge
	may choose to abort the R/W transactions issued by certain
	masters.

	2) Allowing/disallowing write accesses to peripherals.

Add driver for this IP. Since there's currently no framework for
access controllers (and since there's currently no need for having
flexibility w.r.t the configurations) all this driver does is it
applies a relaxed, "default" configuration, in which all masters
are trusted for R/W.

Note that some instances of this IP may be tied to a power domain and may
lose their configuration when the domain is powered off. This is why the
configuration has to be restored when the domain is powered on.

Co-developed-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 drivers/bus/Kconfig      |  6 +++
 drivers/bus/Makefile     |  1 +
 drivers/bus/imx-aipstz.c | 92 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+)
 create mode 100644 drivers/bus/imx-aipstz.c

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index ff669a8ccad9..fe7600283e70 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -87,6 +87,12 @@ config HISILICON_LPC
 	  Driver to enable I/O access to devices attached to the Low Pin
 	  Count bus on the HiSilicon Hip06/7 SoC.
 
+config IMX_AIPSTZ
+	tristate "Support for IMX Secure AHB to IP Slave bus (AIPSTZ) bridge"
+	depends on ARCH_MXC
+	help
+	  Enable support for IMX AIPSTZ bridge.
+
 config IMX_WEIM
 	bool "Freescale EIM DRIVER"
 	depends on ARCH_MXC || COMPILE_TEST
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index cddd4984d6af..8e693fe8a03a 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_FSL_MC_BUS)	+= fsl-mc/
 
 obj-$(CONFIG_BT1_APB)		+= bt1-apb.o
 obj-$(CONFIG_BT1_AXI)		+= bt1-axi.o
+obj-$(CONFIG_IMX_AIPSTZ)	+= imx-aipstz.o
 obj-$(CONFIG_IMX_WEIM)		+= imx-weim.o
 obj-$(CONFIG_INTEL_IXP4XX_EB)	+= intel-ixp4xx-eb.o
 obj-$(CONFIG_MIPS_CDMM)		+= mips_cdmm.o
diff --git a/drivers/bus/imx-aipstz.c b/drivers/bus/imx-aipstz.c
new file mode 100644
index 000000000000..75696eac8ba2
--- /dev/null
+++ b/drivers/bus/imx-aipstz.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+
+#define IMX_AIPSTZ_MPR0 0x0
+
+struct imx_aipstz_config {
+	u32 mpr0;
+};
+
+static void imx_aipstz_apply_default(void __iomem *base,
+				     const struct imx_aipstz_config *default_cfg)
+{
+	writel(default_cfg->mpr0, base + IMX_AIPSTZ_MPR0);
+}
+
+static int imx_aipstz_probe(struct platform_device *pdev)
+{
+	void __iomem *base;
+	const struct imx_aipstz_config *default_cfg;
+
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
+	if (IS_ERR(base))
+		return dev_err_probe(&pdev->dev, -ENOMEM,
+				     "failed to get/ioremap memory\n");
+
+	default_cfg = of_device_get_match_data(&pdev->dev);
+
+	imx_aipstz_apply_default(base, default_cfg);
+
+	dev_set_drvdata(&pdev->dev, base);
+
+	pm_runtime_set_active(&pdev->dev);
+	devm_pm_runtime_enable(&pdev->dev);
+
+	return devm_of_platform_populate(&pdev->dev);
+}
+
+static int imx_aipstz_runtime_resume(struct device *dev)
+{
+	void __iomem *base;
+	const struct imx_aipstz_config *default_cfg;
+
+	base = dev_get_drvdata(dev);
+	default_cfg = of_device_get_match_data(dev);
+
+	/* restore potentially lost configuration during domain power-off */
+	imx_aipstz_apply_default(base, default_cfg);
+
+	return 0;
+}
+
+static const struct dev_pm_ops imx_aipstz_pm_ops = {
+	RUNTIME_PM_OPS(NULL, imx_aipstz_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+};
+
+/*
+ * following configuration is equivalent to:
+ *	masters 0-7 => trusted for R/W + use AHB's HPROT[1] to det. privilege
+ */
+static const struct imx_aipstz_config imx8mp_aipstz_default_cfg = {
+	.mpr0 = 0x77777777,
+};
+
+static const struct of_device_id imx_aipstz_of_ids[] = {
+	{ .compatible = "fsl,imx8mp-aipstz", .data = &imx8mp_aipstz_default_cfg },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, imx_aipstz_of_ids);
+
+static struct platform_driver imx_aipstz_of_driver = {
+	.probe = imx_aipstz_probe,
+	.driver = {
+		.name = "imx-aipstz",
+		.of_match_table = imx_aipstz_of_ids,
+		.pm = pm_ptr(&imx_aipstz_pm_ops),
+	},
+};
+module_platform_driver(imx_aipstz_of_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("IMX secure AHB to IP Slave bus (AIPSTZ) bridge driver");
+MODULE_AUTHOR("Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>");
-- 
2.34.1


