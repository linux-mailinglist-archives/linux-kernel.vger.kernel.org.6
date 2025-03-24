Return-Path: <linux-kernel+bounces-574026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA96A6DFBE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19CDA18939B6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C51426461B;
	Mon, 24 Mar 2025 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfMVJMU8"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41CA2641E3;
	Mon, 24 Mar 2025 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742833819; cv=none; b=HlTINqOdKtGbFxaWgM3OsuN7W7LaAorDGuU0sRlVRA7mePWthNsUVbtDGdnfEcGYLqUFYkQNBJsodKY6ROZlF45lsJyzpKNNa0d9EtOv6PmzZ3fMh1kc7cAY7jvvDjPBqS2iqRo8Kp98hqYQ7P93VPjSieSoEKbBICh2kIyMs28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742833819; c=relaxed/simple;
	bh=UoPzxqR7fMDh+wHIEf0arGh7Tsb9SBUP44rlOtZo9wI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q/pr7CnG1l1ZAvA+OzYss+sYRyhQh/ZbhDTeTgKpdB87tnr5fR452bVrCIjQOov2UKn36z21AHUyFAooRKDNKqYC8hVNraONU5nhC3bTaIbpvCO20rVu8kyKKuyFqJ33isBDg+kp4NTvB+vhY6ErtPlB0n0lvTgYyxJYEvbc1cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfMVJMU8; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43d07ca6a80so22623595e9.1;
        Mon, 24 Mar 2025 09:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742833815; x=1743438615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dkHLVtiZRGLb+v1unC8oKgvdUemVJjrLv1sSsCEAtg=;
        b=WfMVJMU8h7XA831XBgd8rtpaLfjcPcX+oaZGQjZ71RDFu6PngUZ11Q0jeVqQd1nZiz
         tl6Ul2Q70X/1tmSRwI5Is14nmT13Gmgd3eCK181p+Vp77qjqEHdVQNAPIHVtuC6ooS3q
         T6FXLvwmoU49MDGtRsKsP4MkC5E6vd2Y+CEaEHHzBoHqoaeAEefMKo5mqXKqgw8W2YsG
         i79l6Ir66Ea9qhyf+M0z2bBxP39m8Lb1zSIjip0BzTnXHRH/ydNphY00nAvCGipQ+qQK
         eSpbe1nv2ejcQd7Qguq+12leAKHnU0qhaj1AH0eIm7zSg4yTwy0quJAuvlZ9qshWnux9
         +wQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742833815; x=1743438615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+dkHLVtiZRGLb+v1unC8oKgvdUemVJjrLv1sSsCEAtg=;
        b=XnrlYP2xpM+JTCFMUqad2istyUImHP3SDSTRrjvSxH2oMgxmPlUcSMKhag9M3KxXL1
         C6/SP0DP8U/TN3Q1VSZoX2fkBO7rSvRFRuMX9WCgaZNvZLKCweYRX0uKGer4aw0bLIz4
         OjEMaJVTCt8ytsoeiFk92u/zgEAVQVkCv57dTDB4O8q4m2hQt5zLpWzv+3LXIEEDKfyi
         fio7hV6Qyx6OQXJ9Xfa+XTLAPCcf0PugAWjx4U8MspFblhH7zmx2NbuHW4103z4qokCY
         EoIF3sJkUPhqYwg6bKJeULOnG09ubuw14XfrtfBtn2q6RSEi19EvJ13WLbnPzbmH7XCv
         YtSQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/DxkrInnFO1g73eM1vbtQF8Tw2DWIJqnXkSA9Rvqo2/3l+HFZldkm+OdpliRR0YCAAD/foTtUezjlQjkq@vger.kernel.org, AJvYcCWX1MoNaziOZTXJijegP+UGVgLTrd6SdY9dV9fGTR7f4zw94q4XuUZpSaEA+pd5P5oUnopg57l/9s/O@vger.kernel.org
X-Gm-Message-State: AOJu0YxUZGk9GnSBEEIhmpcqWSg7nUNi58008ZsMWAPE2gWuMMsovuKm
	Igf5tXqS71R+NSp+Ds1Fs05vuyaQ92nHDYpUvUSAlJ2+AptuYCdR
X-Gm-Gg: ASbGnctvZ1EZSybkPUa59wJ3tRBWAfQjO9FNJEqmlixGt1BObX9k/SXBO/JIl3pKrsq
	wpZaaA22bmH/9f6g3ofRzt86d1SSemAiML2icxtVEKaaFBfWpL+J8YuXSUVjTGTOTj+fHn9dIvg
	jhWJ67MmKOPin2Wncwd2wrokCL+kHhcIwELafQig0o7mxLVS0Vupn2PX2/NSy2RwRbqNzLVJ1Hk
	kRVUcnGBc8mOyd4KDv8aOst6O4wsN/jglX6vEkarQk/dHP+ybNAO30wJ9iUY9eILrAl+HCo5CZP
	2N3MmdX/yhrhGJcuzPz3U7Pa900CvDtu/Rzr84JBgRPYy5VJQFRD0yU22C2zNQXUPdwgZ/gJwkD
	hz/AVTws=
X-Google-Smtp-Source: AGHT+IH2+OEelK919FNU/gpPRx8fo5vdl1AROa4aq4iE0A/wWtsH8FX2Q56/X5JEk5OPq1wa3npreg==
X-Received: by 2002:a05:600c:1d15:b0:43d:677:3a8a with SMTP id 5b1f17b1804b1-43d509efa8cmr114128435e9.10.1742833814705;
        Mon, 24 Mar 2025 09:30:14 -0700 (PDT)
Received: from playground.localdomain ([82.79.237.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fdb0669sm124106765e9.34.2025.03.24.09.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 09:30:14 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Frank Li <Frank.li@nxp.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] bus: add driver for IMX AIPSTZ bridge
Date: Mon, 24 Mar 2025 12:25:54 -0400
Message-Id: <20250324162556.30972-4-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324162556.30972-1-laurentiumihalcea111@gmail.com>
References: <20250324162556.30972-1-laurentiumihalcea111@gmail.com>
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

Note that some instances of this IP (e.g: AIPSTZ5 on i.MX8MP) may be tied
to a power domain and may lose their configuration when the domain is
powered off. This is why the configuration has to be restored when the
domain is powered on.

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
index 000000000000..538ad89dba30
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
+	const struct imx_aipstz_config *default_cfg;
+	void __iomem *base;
+
+	base = devm_platform_ioremap_resource_byname(pdev, "ac");
+	if (IS_ERR(base))
+		return dev_err_probe(&pdev->dev, -ENOMEM,
+				     "failed to get/ioremap AC memory\n");
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
+	const struct imx_aipstz_config *default_cfg;
+	void __iomem *base;
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


