Return-Path: <linux-kernel+bounces-347358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F8D98D1A2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45958B2465B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43AE1EBFF9;
	Wed,  2 Oct 2024 10:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5qfyIJk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3181EBFEE;
	Wed,  2 Oct 2024 10:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866117; cv=none; b=sKUMPCHzkqyLMIVXKDJ00ucW2QqLNCxcIz5QpjeK9uQnHo0J/Ik63duiyszxCdUG3r7poyS3oIZ+h9CnhcNZPP3HVFO2Ct30UKT2+FFG0S6INq9WYFBznY+CQdjm77bZAj3uEBI79QhCdG29+7Ooq8dYX8paLwtw2zz5hjhHi1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866117; c=relaxed/simple;
	bh=7jVhqVGAjc9ZFGXbZZzkY3dEWfHE6F5nEf5rIqPjM64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLd0t41/n/sLmHIA4MJGht7ESQkNUIyf+G9oQPtICW3LudmvoQA/GEkFLIKCTpEN3K2SehWXa/lF3tk/upsRNSkbmz++m2GLiazs+cU6xPozmb813Y6X8tc0N2pV/1CiZhXigwF4W1VtnvU54rIm2hqQ1qX16uL1k+B5KixSlE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5qfyIJk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2120BC4CEC5;
	Wed,  2 Oct 2024 10:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727866115;
	bh=7jVhqVGAjc9ZFGXbZZzkY3dEWfHE6F5nEf5rIqPjM64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E5qfyIJknPt90hR8jblJ5EMIV13XykjXFwAOzgIGlnyaKdczVFLPP+NWlvI+nBKI0
	 bQ2SqOBZnjWUqAyWcod0rubjlCU+SXknM0UQX4MW9PAy/axP6kQM04MQX2mfVUV2Wl
	 WS1AjX3gBgmwXRSL04vB1auwim+oSJGkLGK2bya4bJZ6v+5lLLWzzQiBlzq844NFT2
	 BSX8usk7NJdxkM7JBEN2U1lUmoFJ4T2M5onVTlm6CjDvkhYHp6WJyo29Smzeye0TcY
	 siIoHYAY+PIBz4K5GP9KToLO9WcDejuJerveDcqQrleLuuUQ4yM5GMPB6dD8V1f4Gd
	 HsJKLcwO47LSg==
From: Conor Dooley <conor@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 05/11] soc: microchip: add mfd drivers for two syscon regions on PolarFire SoC
Date: Wed,  2 Oct 2024 11:48:03 +0100
Message-ID: <20241002-undead-imply-3d240d0cff5e@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241002-private-unequal-33cfa6101338@spud>
References: <20241002-private-unequal-33cfa6101338@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4881; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=P0KwHlFPlXIpFEUesBiUq9EexeIVzEEKS9WSONg93nU=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGl/VR56xJ27Xrj2vIVW3pTbF++UTTsZ5bDO+XOI6ub9d hpdDRNjO0pZGMQ4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjARc1GG/77RUwTSL++K/1L3 5d6/99lOnxQmhvFevZ9te+raResnrtYM/4xOTGrcsiGia/NGoSaO8CVn7yhrLX/qobvCKWpfw5m afdwA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

The control-scb and mss-top-sysreg regions on PolarFire SoC both fulfill
multiple purposes. The former is used for mailbox functions in addition
to the temperature & voltage sensor while the latter is used for clocks,
resets, interrupt muxing and pinctrl.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/soc/microchip/Kconfig               | 13 ++++++
 drivers/soc/microchip/Makefile              |  1 +
 drivers/soc/microchip/mpfs-control-scb.c    | 45 +++++++++++++++++++
 drivers/soc/microchip/mpfs-mss-top-sysreg.c | 48 +++++++++++++++++++++
 4 files changed, 107 insertions(+)
 create mode 100644 drivers/soc/microchip/mpfs-control-scb.c
 create mode 100644 drivers/soc/microchip/mpfs-mss-top-sysreg.c

diff --git a/drivers/soc/microchip/Kconfig b/drivers/soc/microchip/Kconfig
index 19f4b576f822b..31d188311e05f 100644
--- a/drivers/soc/microchip/Kconfig
+++ b/drivers/soc/microchip/Kconfig
@@ -9,3 +9,16 @@ config POLARFIRE_SOC_SYS_CTRL
 	  module will be called mpfs_system_controller.
 
 	  If unsure, say N.
+
+config POLARFIRE_SOC_SYSCONS
+	bool "PolarFire SoC (MPFS) syscon drivers"
+	default y
+	depends on ARCH_MICROCHIP
+	select MFD_CORE
+	help
+	  These drivers add support for the syscons on PolarFire SoC (MPFS).
+	  Without these drivers core parts of the kernel such as clocks
+	  and resets will not function correctly.
+
+	  If unsure, and on a PolarFire SoC, say y.
+
diff --git a/drivers/soc/microchip/Makefile b/drivers/soc/microchip/Makefile
index 14489919fe4b3..1a3a1594b089b 100644
--- a/drivers/soc/microchip/Makefile
+++ b/drivers/soc/microchip/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_POLARFIRE_SOC_SYS_CTRL)	+= mpfs-sys-controller.o
+obj-$(CONFIG_POLARFIRE_SOC_SYSCONS)	+= mpfs-control-scb.o mpfs-mss-top-sysreg.o
diff --git a/drivers/soc/microchip/mpfs-control-scb.c b/drivers/soc/microchip/mpfs-control-scb.c
new file mode 100644
index 0000000000000..d1a8e79c232e3
--- /dev/null
+++ b/drivers/soc/microchip/mpfs-control-scb.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/array_size.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+
+static const struct mfd_cell mpfs_control_scb_devs[] = {
+	{ .name = "mpfs-tvs", },
+};
+
+static int mpfs_control_scb_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	ret = mfd_add_devices(dev, PLATFORM_DEVID_NONE, mpfs_control_scb_devs,
+			      1, NULL, 0, NULL);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct of_device_id mpfs_control_scb_of_match[] = {
+	{.compatible = "microchip,mpfs-control-scb", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mpfs_control_scb_of_match);
+
+static struct platform_driver mpfs_control_scb_driver = {
+	.driver = {
+		.name = "mpfs-control-scb",
+		.of_match_table = mpfs_control_scb_of_match,
+	},
+	.probe = mpfs_control_scb_probe,
+};
+module_platform_driver(mpfs_control_scb_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Conor Dooley <conor.dooley@microchip.com>");
+MODULE_DESCRIPTION("PolarFire SoC control scb driver");
diff --git a/drivers/soc/microchip/mpfs-mss-top-sysreg.c b/drivers/soc/microchip/mpfs-mss-top-sysreg.c
new file mode 100644
index 0000000000000..9b2e7b84cdba2
--- /dev/null
+++ b/drivers/soc/microchip/mpfs-mss-top-sysreg.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/array_size.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+
+static const struct mfd_cell mpfs_mss_top_sysreg_devs[] = {
+	{ .name = "mpfs-reset", },
+};
+
+static int mpfs_mss_top_sysreg_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	ret = mfd_add_devices(dev, PLATFORM_DEVID_NONE, mpfs_mss_top_sysreg_devs,
+			      1, NULL, 0, NULL);
+	if (ret)
+		return ret;
+
+	if (devm_of_platform_populate(dev))
+		dev_err(dev, "Error populating children\n");
+
+	return 0;
+}
+
+static const struct of_device_id mpfs_mss_top_sysreg_of_match[] = {
+	{.compatible = "microchip,mpfs-mss-top-sysreg", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mpfs_mss_top_sysreg_of_match);
+
+static struct platform_driver mpfs_mss_top_sysreg_driver = {
+	.driver = {
+		.name = "mpfs-mss-top-sysreg",
+		.of_match_table = mpfs_mss_top_sysreg_of_match,
+	},
+	.probe = mpfs_mss_top_sysreg_probe,
+};
+module_platform_driver(mpfs_mss_top_sysreg_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Conor Dooley <conor.dooley@microchip.com>");
+MODULE_DESCRIPTION("PolarFire SoC mss top sysreg driver");
-- 
2.45.2


