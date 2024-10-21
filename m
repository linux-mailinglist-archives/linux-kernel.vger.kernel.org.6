Return-Path: <linux-kernel+bounces-374276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6997F9A67C8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89E7F1C214B8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0916E1F4731;
	Mon, 21 Oct 2024 12:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUe+GzHv"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1121F429E;
	Mon, 21 Oct 2024 12:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729512999; cv=none; b=j+4W2ubybPVHwsys//psHfY8VSnSETqUWB1+ycR1WXzixu0grqmf2FvdDWdPEJXyp7qM5BJA8EVQIIxjZsN59ImH7CG5pVbjP48q2nb+BXAcaL/gfk+x2axJYYn7v16+EF0XHVPtlDKaYyKJSN2uzSjQjvgRRf7I+R6pz/ga7VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729512999; c=relaxed/simple;
	bh=/QxQgtbGT9pHMWSRh6CJ+3Iapq9VtlZs324F6K7mp+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MwV/kXVMBUUidFk1Mj8ksbzrLq4j1qC6a4YMbDhJnOqEOSehpUjXp8FzV5BJlMJgXnjmJL3dutoh65oDDIWeLs5gvbxRRIzTebLUFEx4WSm1nYYOfAfm6Vr6HOiS4inpSg4h0YqqifHq5aXYffPbz8MTdTiHRh0llOVfAgg1w0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUe+GzHv; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9a0472306cso590744466b.3;
        Mon, 21 Oct 2024 05:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729512995; x=1730117795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=El61r44Z3jvNpsbA3bmUgLdX8Aii77RVSrXblKXqOh8=;
        b=JUe+GzHvBQ0teKlY0Yqy5/kcBdN95ZQQfP9vGlw3Mh7FY4gVU51xki9SLSNqUtXGG4
         s/kSn0SrXa6y8QPzD9hKjG2RZiZap7B6LcgjC2zB5Zw93fnO3nMBZPGbfgkTFEYjVAak
         Ca7CG35VB5/vMCfJDRUXA9etJK/U9xiJ1APms390PBu36CV3yeSLp9ohKWPHmD9AC+Wy
         SJmv7UmFvGYWviui4kVNjoomB1BWrDKRq3orPoUL3NvMvxRpToWUulV3YPvPeg9NCczI
         zvxl+RngAF/JKudRTEY8JEJBlKX1VaCkIA7qVSS1L3E1BR2zeiQAH5PqgxdTY7H+Y7Up
         ry/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729512995; x=1730117795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=El61r44Z3jvNpsbA3bmUgLdX8Aii77RVSrXblKXqOh8=;
        b=qpn4lF9STIUbcg8OvGdnWITdft1fdY09YNDhcYH//lyOM3Fff7ef8vFRqrEZQCKpEc
         iKKnW8nV00oF7ImQdPYChrFjkcddJCi0q3LxN5MEiZU9w6UuSTM5wIxBbbWZiVUgseLx
         d9NbzwVosfEaZnmeqlTEbTYdgISmQqNcc1+h8OYPRutKpYX+dNnMPMzQWisni6nZn+6s
         pUUxr9rOx/p3zc+BKa9o9lvduNYxtPjbCrpVdBXPBYi1dLDR9afg+x9e5S9O9hWF1VRf
         TIT1ECR9RYWk3WoA/VjrIe8J+l2ZY4MJk3MSdN4vDtN/khDPsbJov0awL6LRUxFFG+z5
         UvWw==
X-Forwarded-Encrypted: i=1; AJvYcCVxEpA4f8TjmfnWZxx1OB/1DfkBsefe2H5QA2SKC0Cr06CGk50a6VNN9GGiL8z9sVwZdQSuZ7ZYiAZYjVou@vger.kernel.org, AJvYcCW1N3fL/3WUGP6JuMUyzO9CLOzXRlXXZTF8rsR3weD70pO9tG/xvmmcplJGwwcxu/kwgTMh3732su/N@vger.kernel.org, AJvYcCXmo8C/RjJg2fhVJ9UDEOUB4dGLg2m4nCUx08msJyVj0HZMHj7eVZq7TGxc8ZkBQFtrRvOtAJD2GN7d@vger.kernel.org
X-Gm-Message-State: AOJu0YzDrl1FtwcwLOv0M+PlxDKdD6f48vuX1wXJE4RfKSq4CzNbHecy
	s3fDXgsLrLua1nn+C8qVSWBU3u3UQbn8MXQhkP4BfoFxi7qfERd5
X-Google-Smtp-Source: AGHT+IEfAzgKuTl08mwpAKNMUEJ3JqHR+e9hh5pUDQ9yCvhlSfkERO+PIMvyot8OKHFebA3lMkgYQQ==
X-Received: by 2002:a17:907:1c1b:b0:a9a:183a:b84e with SMTP id a640c23a62f3a-a9a69c98812mr1125296566b.40.1729512994421;
        Mon, 21 Oct 2024 05:16:34 -0700 (PDT)
Received: from zenbook.agu.edu.tr ([95.183.227.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d6ee6sm197068966b.4.2024.10.21.05.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:16:33 -0700 (PDT)
From: Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Sam Shih <sam.shih@mediatek.com>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>,
	Yassine Oudjana <yassine.oudjana@gmail.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] clk: mediatek: Add drivers for MT6735 syscon clock and reset controllers
Date: Mon, 21 Oct 2024 15:16:16 +0300
Message-ID: <20241021121618.151079-3-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021121618.151079-1-y.oudjana@protonmail.com>
References: <20241021121618.151079-1-y.oudjana@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yassine Oudjana <y.oudjana@protonmail.com>

Add drivers for IMGSYS, MFGCFG, VDECSYS and VENCSYS clocks and resets
on MT6735.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 MAINTAINERS                               |  4 ++
 drivers/clk/mediatek/Kconfig              | 32 +++++++++
 drivers/clk/mediatek/Makefile             |  4 ++
 drivers/clk/mediatek/clk-mt6735-imgsys.c  | 57 ++++++++++++++++
 drivers/clk/mediatek/clk-mt6735-mfgcfg.c  | 61 +++++++++++++++++
 drivers/clk/mediatek/clk-mt6735-vdecsys.c | 81 +++++++++++++++++++++++
 drivers/clk/mediatek/clk-mt6735-vencsys.c | 53 +++++++++++++++
 7 files changed, 292 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt6735-imgsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt6735-mfgcfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt6735-vdecsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt6735-vencsys.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 25484783f6a0b..939f9d29fc9bf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14533,9 +14533,13 @@ L:	linux-clk@vger.kernel.org
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/clk/mediatek/clk-mt6735-apmixedsys.c
+F:	drivers/clk/mediatek/clk-mt6735-imgsys.c
 F:	drivers/clk/mediatek/clk-mt6735-infracfg.c
+F:	drivers/clk/mediatek/clk-mt6735-mfgcfg.c
 F:	drivers/clk/mediatek/clk-mt6735-pericfg.c
 F:	drivers/clk/mediatek/clk-mt6735-topckgen.c
+F:	drivers/clk/mediatek/clk-mt6735-vdecsys.c
+F:	drivers/clk/mediatek/clk-mt6735-vencsys.c
 F:	include/dt-bindings/clock/mediatek,mt6735-apmixedsys.h
 F:	include/dt-bindings/clock/mediatek,mt6735-imgsys.h
 F:	include/dt-bindings/clock/mediatek,mt6735-infracfg.h
diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 7a33f9e92d963..4dd6d2d6263fd 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -133,6 +133,38 @@ config COMMON_CLK_MT6735
 	  by apmixedsys, topckgen, infracfg and pericfg on the
 	  MediaTek MT6735 SoC.
 
+config COMMON_CLK_MT6735_IMGSYS
+	tristate "Clock driver for MediaTek MT6735 imgsys"
+	depends on (ARCH_MEDIATEK && COMMON_CLK_MT6735) || COMPILE_TEST
+	select COMMON_CLK_MEDIATEK
+	help
+	  This enables a driver for clocks provided by imgsys
+	  on the MediaTek MT6735 SoC.
+
+config COMMON_CLK_MT6735_MFGCFG
+	tristate "Clock driver for MediaTek MT6735 mfgcfg"
+	depends on (ARCH_MEDIATEK && COMMON_CLK_MT6735) || COMPILE_TEST
+	select COMMON_CLK_MEDIATEK
+	help
+	  This enables a driver for clocks and resets provided
+	  by mfgcfg on the MediaTek MT6735 SoC.
+
+config COMMON_CLK_MT6735_VDECSYS
+	tristate "Clock driver for MediaTek MT6735 vdecsys"
+	depends on (ARCH_MEDIATEK && COMMON_CLK_MT6735) || COMPILE_TEST
+	select COMMON_CLK_MEDIATEK
+	help
+	  This enables a driver for clocks and resets provided
+	  by vdecsys on the MediaTek MT6735 SoC.
+
+config COMMON_CLK_MT6735_VENCSYS
+	tristate "Clock driver for MediaTek MT6735 vencsys"
+	depends on (ARCH_MEDIATEK && COMMON_CLK_MT6735) || COMPILE_TEST
+	select COMMON_CLK_MEDIATEK
+	help
+	  This enables a driver for clocks provided by vencsys
+	  on the MediaTek MT6735 SoC.
+
 config COMMON_CLK_MT6765
        bool "Clock driver for MediaTek MT6765"
        depends on (ARCH_MEDIATEK && ARM64) || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 70456ffc6c492..6efec95406bd5 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -3,6 +3,10 @@ obj-$(CONFIG_COMMON_CLK_MEDIATEK) += clk-mtk.o clk-pll.o clk-gate.o clk-apmixed.
 obj-$(CONFIG_COMMON_CLK_MEDIATEK_FHCTL) += clk-fhctl.o clk-pllfh.o
 
 obj-$(CONFIG_COMMON_CLK_MT6735) += clk-mt6735-apmixedsys.o clk-mt6735-infracfg.o clk-mt6735-pericfg.o clk-mt6735-topckgen.o
+obj-$(CONFIG_COMMON_CLK_MT6735_IMGSYS) += clk-mt6735-imgsys.o
+obj-$(CONFIG_COMMON_CLK_MT6735_MFGCFG) += clk-mt6735-mfgcfg.o
+obj-$(CONFIG_COMMON_CLK_MT6735_VDECSYS) += clk-mt6735-vdecsys.o
+obj-$(CONFIG_COMMON_CLK_MT6735_VENCSYS) += clk-mt6735-vencsys.o
 obj-$(CONFIG_COMMON_CLK_MT6765) += clk-mt6765.o
 obj-$(CONFIG_COMMON_CLK_MT6765_AUDIOSYS) += clk-mt6765-audio.o
 obj-$(CONFIG_COMMON_CLK_MT6765_CAMSYS) += clk-mt6765-cam.o
diff --git a/drivers/clk/mediatek/clk-mt6735-imgsys.c b/drivers/clk/mediatek/clk-mt6735-imgsys.c
new file mode 100644
index 0000000000000..c564f8f724324
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt6735-imgsys.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Yassine Oudjana <y.oudjana@protonmail.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+
+#include "clk-gate.h"
+#include "clk-mtk.h"
+
+#include <dt-bindings/clock/mediatek,mt6735-imgsys.h>
+
+#define IMG_CG_CON			0x00
+#define IMG_CG_SET			0x04
+#define IMG_CG_CLR			0x08
+
+static struct mtk_gate_regs imgsys_cg_regs = {
+	.set_ofs = IMG_CG_SET,
+	.clr_ofs = IMG_CG_CLR,
+	.sta_ofs = IMG_CG_CON,
+};
+
+static const struct mtk_gate imgsys_gates[] = {
+	GATE_MTK(CLK_IMG_SMI_LARB2, "smi_larb2", "mm_sel", &imgsys_cg_regs, 0, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_IMG_CAM_SMI, "cam_smi", "mm_sel", &imgsys_cg_regs, 5, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_IMG_CAM_CAM, "cam_cam", "mm_sel", &imgsys_cg_regs, 6, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_IMG_SEN_TG, "sen_tg", "mm_sel", &imgsys_cg_regs, 7, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_IMG_SEN_CAM, "sen_cam", "mm_sel", &imgsys_cg_regs, 8, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_IMG_CAM_SV, "cam_sv", "mm_sel", &imgsys_cg_regs, 9, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_IMG_SUFOD, "sufod", "mm_sel", &imgsys_cg_regs, 10, &mtk_clk_gate_ops_setclr),
+	GATE_MTK(CLK_IMG_FD, "fd", "mm_sel", &imgsys_cg_regs, 11, &mtk_clk_gate_ops_setclr),
+};
+
+static const struct mtk_clk_desc imgsys_clks = {
+	.clks = imgsys_gates,
+	.num_clks = ARRAY_SIZE(imgsys_gates),
+};
+
+static const struct of_device_id of_match_mt6735_imgsys[] = {
+	{ .compatible = "mediatek,mt6735-imgsys", .data = &imgsys_clks },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt6735_imgsys = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt6735-imgsys",
+		.of_match_table = of_match_mt6735_imgsys,
+	},
+};
+module_platform_driver(clk_mt6735_imgsys);
+
+MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
+MODULE_DESCRIPTION("MediaTek MT6735 imgsys clock driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6735-mfgcfg.c b/drivers/clk/mediatek/clk-mt6735-mfgcfg.c
new file mode 100644
index 0000000000000..1f5aedddf209d
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt6735-mfgcfg.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Yassine Oudjana <y.oudjana@protonmail.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+
+#include "clk-gate.h"
+#include "clk-mtk.h"
+
+#include <dt-bindings/clock/mediatek,mt6735-mfgcfg.h>
+
+#define MFG_CG_CON			0x00
+#define MFG_CG_SET			0x04
+#define MFG_CG_CLR			0x08
+#define MFG_RESET			0x0c
+
+static struct mtk_gate_regs mfgcfg_cg_regs = {
+	.set_ofs = MFG_CG_SET,
+	.clr_ofs = MFG_CG_CLR,
+	.sta_ofs = MFG_CG_CON,
+};
+
+static const struct mtk_gate mfgcfg_gates[] = {
+	GATE_MTK(CLK_MFG_BG3D, "bg3d", "mfg_sel", &mfgcfg_cg_regs, 0, &mtk_clk_gate_ops_setclr),
+};
+
+static u16 mfgcfg_rst_ofs[] = { MFG_RESET };
+
+static const struct mtk_clk_rst_desc mfgcfg_resets = {
+	.version = MTK_RST_SIMPLE,
+	.rst_bank_ofs = mfgcfg_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(mfgcfg_rst_ofs)
+};
+
+static const struct mtk_clk_desc mfgcfg_clks = {
+	.clks = mfgcfg_gates,
+	.num_clks = ARRAY_SIZE(mfgcfg_gates),
+
+	.rst_desc = &mfgcfg_resets
+};
+
+static const struct of_device_id of_match_mt6735_mfgcfg[] = {
+	{ .compatible = "mediatek,mt6735-mfgcfg", .data = &mfgcfg_clks },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt6735_mfgcfg = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt6735-mfgcfg",
+		.of_match_table = of_match_mt6735_mfgcfg,
+	},
+};
+module_platform_driver(clk_mt6735_mfgcfg);
+
+MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
+MODULE_DESCRIPTION("Mediatek MT6735 mfgcfg clock and reset driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6735-vdecsys.c b/drivers/clk/mediatek/clk-mt6735-vdecsys.c
new file mode 100644
index 0000000000000..f59b481aaa6da
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt6735-vdecsys.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Yassine Oudjana <y.oudjana@protonmail.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+
+#include "clk-gate.h"
+#include "clk-mtk.h"
+
+#include <dt-bindings/clock/mediatek,mt6735-vdecsys.h>
+#include <dt-bindings/reset/mediatek,mt6735-vdecsys.h>
+
+#define VDEC_CKEN_SET			0x00
+#define VDEC_CKEN_CLR			0x04
+#define SMI_LARB1_CKEN_SET		0x08
+#define SMI_LARB1_CKEN_CLR		0x0c
+#define VDEC_RESETB_CON			0x10
+#define SMI_LARB1_RESETB_CON		0x14
+
+#define RST_NR_PER_BANK			32
+
+static struct mtk_gate_regs vdec_cg_regs = {
+	.set_ofs = VDEC_CKEN_SET,
+	.clr_ofs = VDEC_CKEN_CLR,
+	.sta_ofs = VDEC_CKEN_SET,
+};
+
+static struct mtk_gate_regs smi_larb1_cg_regs = {
+	.set_ofs = SMI_LARB1_CKEN_SET,
+	.clr_ofs = SMI_LARB1_CKEN_CLR,
+	.sta_ofs = SMI_LARB1_CKEN_SET,
+};
+
+static const struct mtk_gate vdecsys_gates[] = {
+	GATE_MTK(CLK_VDEC_VDEC, "vdec", "vdec_sel", &vdec_cg_regs, 0, &mtk_clk_gate_ops_setclr_inv),
+	GATE_MTK(CLK_VDEC_SMI_LARB1, "smi_larb1", "vdec_sel", &smi_larb1_cg_regs, 0, &mtk_clk_gate_ops_setclr_inv),
+};
+
+static u16 vdecsys_rst_bank_ofs[] = { VDEC_RESETB_CON, SMI_LARB1_RESETB_CON };
+
+static u16 vdecsys_rst_idx_map[] = {
+	[MT6735_VDEC_RST0_VDEC]		= 0 * RST_NR_PER_BANK + 0,
+
+	[MT6735_VDEC_RST1_SMI_LARB1]	= 1 * RST_NR_PER_BANK + 0,
+};
+
+static const struct mtk_clk_rst_desc vdecsys_resets = {
+	.version = MTK_RST_SIMPLE,
+	.rst_bank_ofs = vdecsys_rst_bank_ofs,
+	.rst_bank_nr = ARRAY_SIZE(vdecsys_rst_bank_ofs),
+	.rst_idx_map = vdecsys_rst_idx_map,
+	.rst_idx_map_nr = ARRAY_SIZE(vdecsys_rst_idx_map)
+};
+
+static const struct mtk_clk_desc vdecsys_clks = {
+	.clks = vdecsys_gates,
+	.num_clks = ARRAY_SIZE(vdecsys_gates),
+
+	.rst_desc = &vdecsys_resets
+};
+
+static const struct of_device_id of_match_mt6735_vdecsys[] = {
+	{ .compatible = "mediatek,mt6735-vdecsys", .data = &vdecsys_clks },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt6735_vdecsys = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt6735-vdecsys",
+		.of_match_table = of_match_mt6735_vdecsys,
+	},
+};
+module_platform_driver(clk_mt6735_vdecsys);
+
+MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
+MODULE_DESCRIPTION("MediaTek MT6735 vdecsys clock and reset driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6735-vencsys.c b/drivers/clk/mediatek/clk-mt6735-vencsys.c
new file mode 100644
index 0000000000000..8dec7f98492ac
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt6735-vencsys.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Yassine Oudjana <y.oudjana@protonmail.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+
+#include "clk-gate.h"
+#include "clk-mtk.h"
+
+#include <dt-bindings/clock/mediatek,mt6735-vencsys.h>
+
+#define VENC_CG_CON			0x00
+#define VENC_CG_SET			0x04
+#define VENC_CG_CLR			0x08
+
+static struct mtk_gate_regs venc_cg_regs = {
+	.set_ofs = VENC_CG_SET,
+	.clr_ofs = VENC_CG_CLR,
+	.sta_ofs = VENC_CG_CON,
+};
+
+static const struct mtk_gate vencsys_gates[] = {
+	GATE_MTK(CLK_VENC_SMI_LARB3, "smi_larb3", "mm_sel", &venc_cg_regs, 0, &mtk_clk_gate_ops_setclr_inv),
+	GATE_MTK(CLK_VENC_VENC, "venc", "mm_sel", &venc_cg_regs, 4, &mtk_clk_gate_ops_setclr_inv),
+	GATE_MTK(CLK_VENC_JPGENC, "jpgenc", "mm_sel", &venc_cg_regs, 8, &mtk_clk_gate_ops_setclr_inv),
+	GATE_MTK(CLK_VENC_JPGDEC, "jpgdec", "mm_sel", &venc_cg_regs, 12, &mtk_clk_gate_ops_setclr_inv),
+};
+
+static const struct mtk_clk_desc vencsys_clks = {
+	.clks = vencsys_gates,
+	.num_clks = ARRAY_SIZE(vencsys_gates),
+};
+
+static const struct of_device_id of_match_mt6735_vencsys[] = {
+	{ .compatible = "mediatek,mt6735-vencsys", .data = &vencsys_clks },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt6735_vencsys = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt6735-vencsys",
+		.of_match_table = of_match_mt6735_vencsys,
+	},
+};
+module_platform_driver(clk_mt6735_vencsys);
+
+MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
+MODULE_DESCRIPTION("Mediatek MT6735 vencsys clock driver");
+MODULE_LICENSE("GPL");
-- 
2.47.0


