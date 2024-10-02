Return-Path: <linux-kernel+bounces-347361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8053198D1AB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 106611F21E5B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D87205E1B;
	Wed,  2 Oct 2024 10:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOuED2mi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41D01EC00B;
	Wed,  2 Oct 2024 10:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866130; cv=none; b=ax3mQ6LnabiedqSY9sROJbOlFT9NH1rl5hxNrlV1InIkK2HiB2lvcljXYLNkwCOydjAJH8Y4/bKBBDe7/GkCgHnmDqAUgCB9qDdb5S4o72SxSHlrg7/DWnm8KOJcRqCErdXhrd8LfgFn5uH4ioF/9pSvFXEzb1zszuqVzu+Hh1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866130; c=relaxed/simple;
	bh=wyAqtwmQVe6DH6vOA+FUkvhaS55QIELA117se0uIkvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9mdLaGwm7FY82UR36xiG90eQCWrvsLk4p5MX1noscnSRGmOkOvzZB4buQ057Yn0IZJnJmbcUiY61IwxRBUIgs2tSEuVXCnK1WDyw5ZPc0l1uWwHdWPjPnhSY5GuUx6YiAgoLrpInM5b75rDSzPQ45oP0Vv7HmtyNtg+Cuhx+mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOuED2mi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B34C4CEC5;
	Wed,  2 Oct 2024 10:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727866130;
	bh=wyAqtwmQVe6DH6vOA+FUkvhaS55QIELA117se0uIkvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pOuED2mia0rvwsEcdn+K6jDV5rSYRrIymzKfBmZefzuDHcNN9c/g7hYnpckHL06+1
	 Uu53eH2HRARktXDQZKsBxfeo9ixxh3AZ7MDKT5MjcPA9qM76dkT/ksYEXDZ3LPHNeU
	 RMIqI+Cco3GPrpajsc66ySJY/CPkNn8NylOn9nz5/xNPXDh8Q8Wuk3AL5IRreQ5zmk
	 VbUt62wHahxvlvb6zQFlXLSY9JYHc3I5bi0lEV7XFUC+ykIP+Zf7Y3dpQKgok+H8hf
	 HlNgMH0cy+Ja+ZSKThmMXYdPMt4sm/YbkWcfh6V3AitFE29j2isXn7saSVi2qD7d6J
	 Y5FLdDIG/dW4g==
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
Subject: [PATCH v1 08/11] clk: move meson clk-regmap implementation to common code
Date: Wed,  2 Oct 2024 11:48:06 +0100
Message-ID: <20241002-hula-unwashed-1c4ddbadbec2@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241002-private-unequal-33cfa6101338@spud>
References: <20241002-private-unequal-33cfa6101338@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=20090; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=Z6idHNY0klwwl1OjaLT9FKE/+kSQIdv9mwwLFhOkY88=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGl/VR5y6pncqLgv4j0/uD76UvQ6TgGViyWedg0KbLPd3 ne4Ce/pKGVhEONgkBVTZEm83dcitf6Pyw7nnrcwc1iZQIYwcHEKwESOMzEy7FY4ku6e7B+S3F70 YNYjFrMTPaqLbX4lfxJ9OPmmif3Ve4wMj+3bDAxX8S9sO3iRN1u78u+RoPbnB84Hck7kud4/t86 eEQA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

I like this one better than qualcomms and wish to use it for the
PolarFire SoC clock drivers.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/clk/Kconfig                           |  4 ++
 drivers/clk/Makefile                          |  1 +
 drivers/clk/{meson => }/clk-regmap.c          |  2 +-
 drivers/clk/meson/Kconfig                     | 46 +++++++++----------
 drivers/clk/meson/Makefile                    |  1 -
 drivers/clk/meson/a1-peripherals.c            |  2 +-
 drivers/clk/meson/a1-pll.c                    |  2 +-
 drivers/clk/meson/axg-aoclk.c                 |  2 +-
 drivers/clk/meson/axg-audio.c                 |  2 +-
 drivers/clk/meson/axg.c                       |  2 +-
 drivers/clk/meson/c3-peripherals.c            |  2 +-
 drivers/clk/meson/c3-pll.c                    |  2 +-
 drivers/clk/meson/clk-cpu-dyndiv.c            |  2 +-
 drivers/clk/meson/clk-dualdiv.c               |  2 +-
 drivers/clk/meson/clk-mpll.c                  |  2 +-
 drivers/clk/meson/clk-phase.c                 |  2 +-
 drivers/clk/meson/clk-pll.c                   |  2 +-
 drivers/clk/meson/g12a-aoclk.c                |  2 +-
 drivers/clk/meson/g12a.c                      |  2 +-
 drivers/clk/meson/gxbb-aoclk.c                |  2 +-
 drivers/clk/meson/gxbb.c                      |  2 +-
 drivers/clk/meson/meson-aoclk.h               |  2 +-
 drivers/clk/meson/meson-eeclk.c               |  2 +-
 drivers/clk/meson/meson-eeclk.h               |  2 +-
 drivers/clk/meson/meson8-ddr.c                |  2 +-
 drivers/clk/meson/meson8b.c                   |  2 +-
 drivers/clk/meson/s4-peripherals.c            |  2 +-
 drivers/clk/meson/s4-pll.c                    |  2 +-
 drivers/clk/meson/sclk-div.c                  |  2 +-
 drivers/clk/meson/vclk.h                      |  2 +-
 drivers/clk/meson/vid-pll-div.c               |  2 +-
 .../meson => include/linux/clk}/clk-regmap.h  |  0
 32 files changed, 53 insertions(+), 53 deletions(-)
 rename drivers/clk/{meson => }/clk-regmap.c (99%)
 rename {drivers/clk/meson => include/linux/clk}/clk-regmap.h (100%)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 299bc678ed1b9..85397308a74f4 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -33,6 +33,10 @@ menuconfig COMMON_CLK
 
 if COMMON_CLK
 
+config COMMON_CLK_REGMAP
+	bool
+	select REGMAP
+
 config COMMON_CLK_WM831X
 	tristate "Clock driver for WM831x/2x PMICs"
 	depends on MFD_WM831X
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index fb8878a5d7d93..bffdbfb932beb 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_COMMON_CLK)	+= clk-gate.o
 obj-$(CONFIG_CLK_GATE_KUNIT_TEST) += clk-gate_test.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-multiplier.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-mux.o
+obj-$(CONFIG_COMMON_CLK_REGMAP)	+= clk-regmap.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-composite.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-fractional-divider.o
 obj-$(CONFIG_CLK_FD_KUNIT_TEST) += clk-fractional-divider_test.o
diff --git a/drivers/clk/meson/clk-regmap.c b/drivers/clk/clk-regmap.c
similarity index 99%
rename from drivers/clk/meson/clk-regmap.c
rename to drivers/clk/clk-regmap.c
index 07f7e441b9161..4ec0ed8f72011 100644
--- a/drivers/clk/meson/clk-regmap.c
+++ b/drivers/clk/clk-regmap.c
@@ -5,7 +5,7 @@
  */
 
 #include <linux/module.h>
-#include "clk-regmap.h"
+#include <linux/clk/clk-regmap.h>
 
 static int clk_regmap_gate_endisable(struct clk_hw *hw, int enable)
 {
diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index 78f648c9c97dc..ee4599dab7ff7 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -2,61 +2,57 @@
 menu "Clock support for Amlogic platforms"
 	depends on ARCH_MESON || COMPILE_TEST
 
-config COMMON_CLK_MESON_REGMAP
-	tristate
-	select REGMAP
-
 config COMMON_CLK_MESON_DUALDIV
 	tristate
-	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_REGMAP
 
 config COMMON_CLK_MESON_MPLL
 	tristate
-	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_REGMAP
 
 config COMMON_CLK_MESON_PHASE
 	tristate
-	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_REGMAP
 
 config COMMON_CLK_MESON_PLL
 	tristate
-	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_REGMAP
 
 config COMMON_CLK_MESON_SCLK_DIV
 	tristate
-	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_REGMAP
 
 config COMMON_CLK_MESON_VID_PLL_DIV
 	tristate
-	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_REGMAP
 
 config COMMON_CLK_MESON_VCLK
 	tristate
-	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_REGMAP
 
 config COMMON_CLK_MESON_CLKC_UTILS
 	tristate
 
 config COMMON_CLK_MESON_AO_CLKC
 	tristate
-	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_REGMAP
 	select COMMON_CLK_MESON_CLKC_UTILS
 	select RESET_CONTROLLER
 
 config COMMON_CLK_MESON_EE_CLKC
 	tristate
-	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_REGMAP
 	select COMMON_CLK_MESON_CLKC_UTILS
 
 config COMMON_CLK_MESON_CPU_DYNDIV
 	tristate
-	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_REGMAP
 
 config COMMON_CLK_MESON8B
 	bool "Meson8 SoC Clock controller support"
 	depends on ARM
 	default y
-	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_REGMAP
 	select COMMON_CLK_MESON_CLKC_UTILS
 	select COMMON_CLK_MESON_MPLL
 	select COMMON_CLK_MESON_PLL
@@ -71,7 +67,7 @@ config COMMON_CLK_GXBB
 	tristate "GXBB and GXL SoC clock controllers support"
 	depends on ARM64
 	default y
-	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_REGMAP
 	select COMMON_CLK_MESON_DUALDIV
 	select COMMON_CLK_MESON_VID_PLL_DIV
 	select COMMON_CLK_MESON_MPLL
@@ -87,7 +83,7 @@ config COMMON_CLK_AXG
 	tristate "AXG SoC clock controllers support"
 	depends on ARM64
 	default y
-	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_REGMAP
 	select COMMON_CLK_MESON_DUALDIV
 	select COMMON_CLK_MESON_MPLL
 	select COMMON_CLK_MESON_PLL
@@ -101,7 +97,7 @@ config COMMON_CLK_AXG
 config COMMON_CLK_AXG_AUDIO
 	tristate "Meson AXG Audio Clock Controller Driver"
 	depends on ARM64
-	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_REGMAP
 	select COMMON_CLK_MESON_PHASE
 	select COMMON_CLK_MESON_SCLK_DIV
 	select COMMON_CLK_MESON_CLKC_UTILS
@@ -113,7 +109,7 @@ config COMMON_CLK_AXG_AUDIO
 config COMMON_CLK_A1_PLL
 	tristate "Amlogic A1 SoC PLL controller support"
 	depends on ARM64
-	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_REGMAP
 	select COMMON_CLK_MESON_CLKC_UTILS
 	select COMMON_CLK_MESON_PLL
 	help
@@ -125,7 +121,7 @@ config COMMON_CLK_A1_PERIPHERALS
 	tristate "Amlogic A1 SoC Peripherals clock controller support"
 	depends on ARM64
 	select COMMON_CLK_MESON_DUALDIV
-	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_REGMAP
 	select COMMON_CLK_MESON_CLKC_UTILS
 	help
 	  Support for the Peripherals clock controller on Amlogic A113L based
@@ -136,7 +132,7 @@ config COMMON_CLK_C3_PLL
 	tristate "Amlogic C3 PLL clock controller"
 	depends on ARM64
 	default y
-	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_REGMAP
 	select COMMON_CLK_MESON_PLL
 	select COMMON_CLK_MESON_CLKC_UTILS
 	imply COMMON_CLK_SCMI
@@ -149,7 +145,7 @@ config COMMON_CLK_C3_PERIPHERALS
 	tristate "Amlogic C3 peripherals clock controller"
 	depends on ARM64
 	default y
-	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_REGMAP
 	select COMMON_CLK_MESON_DUALDIV
 	select COMMON_CLK_MESON_CLKC_UTILS
 	imply COMMON_CLK_SCMI
@@ -163,7 +159,7 @@ config COMMON_CLK_G12A
 	tristate "G12 and SM1 SoC clock controllers support"
 	depends on ARM64
 	default y
-	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_REGMAP
 	select COMMON_CLK_MESON_DUALDIV
 	select COMMON_CLK_MESON_MPLL
 	select COMMON_CLK_MESON_PLL
@@ -184,7 +180,7 @@ config COMMON_CLK_S4_PLL
 	select COMMON_CLK_MESON_CLKC_UTILS
 	select COMMON_CLK_MESON_MPLL
 	select COMMON_CLK_MESON_PLL
-	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_REGMAP
 	help
 	  Support for the PLL clock controller on Amlogic S805X2 and S905Y4 devices,
 	  AKA S4. Say Y if you want the board to work, because PLLs are the parent of
@@ -195,7 +191,7 @@ config COMMON_CLK_S4_PERIPHERALS
 	depends on ARM64
 	default y
 	select COMMON_CLK_MESON_CLKC_UTILS
-	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_REGMAP
 	select COMMON_CLK_MESON_DUALDIV
 	select COMMON_CLK_MESON_VID_PLL_DIV
 	help
diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index bc56a47931c1d..cd870281d82c7 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -9,7 +9,6 @@ obj-$(CONFIG_COMMON_CLK_MESON_EE_CLKC) += meson-eeclk.o
 obj-$(CONFIG_COMMON_CLK_MESON_MPLL) += clk-mpll.o
 obj-$(CONFIG_COMMON_CLK_MESON_PHASE) += clk-phase.o
 obj-$(CONFIG_COMMON_CLK_MESON_PLL) += clk-pll.o
-obj-$(CONFIG_COMMON_CLK_MESON_REGMAP) += clk-regmap.o
 obj-$(CONFIG_COMMON_CLK_MESON_SCLK_DIV) += sclk-div.o
 obj-$(CONFIG_COMMON_CLK_MESON_VID_PLL_DIV) += vid-pll-div.o
 obj-$(CONFIG_COMMON_CLK_MESON_VCLK) += vclk.o
diff --git a/drivers/clk/meson/a1-peripherals.c b/drivers/clk/meson/a1-peripherals.c
index 7aa6abb2eb1f2..6178e6a153394 100644
--- a/drivers/clk/meson/a1-peripherals.c
+++ b/drivers/clk/meson/a1-peripherals.c
@@ -12,7 +12,7 @@
 #include <linux/platform_device.h>
 #include "a1-peripherals.h"
 #include "clk-dualdiv.h"
-#include "clk-regmap.h"
+#include <linux/clk/clk-regmap.h>
 #include "meson-clkc-utils.h"
 
 #include <dt-bindings/clock/amlogic,a1-peripherals-clkc.h>
diff --git a/drivers/clk/meson/a1-pll.c b/drivers/clk/meson/a1-pll.c
index 8e5a42d1afbbc..48ba3981b22df 100644
--- a/drivers/clk/meson/a1-pll.c
+++ b/drivers/clk/meson/a1-pll.c
@@ -11,7 +11,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include "a1-pll.h"
-#include "clk-regmap.h"
+#include <linux/clk/clk-regmap.h>
 #include "meson-clkc-utils.h"
 
 #include <dt-bindings/clock/amlogic,a1-pll-clkc.h>
diff --git a/drivers/clk/meson/axg-aoclk.c b/drivers/clk/meson/axg-aoclk.c
index 1dabc81535a6f..ee89edf05a443 100644
--- a/drivers/clk/meson/axg-aoclk.c
+++ b/drivers/clk/meson/axg-aoclk.c
@@ -15,7 +15,7 @@
 #include <linux/module.h>
 #include "meson-aoclk.h"
 
-#include "clk-regmap.h"
+#include <linux/clk/clk-regmap.h>
 #include "clk-dualdiv.h"
 
 #include <dt-bindings/clock/axg-aoclkc.h>
diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
index beda863493899..06ccf1db63f58 100644
--- a/drivers/clk/meson/axg-audio.c
+++ b/drivers/clk/meson/axg-audio.c
@@ -17,7 +17,7 @@
 
 #include "meson-clkc-utils.h"
 #include "axg-audio.h"
-#include "clk-regmap.h"
+#include <linux/clk/clk-regmap.h>
 #include "clk-phase.h"
 #include "sclk-div.h"
 
diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 757c7a28c53de..73a0cad223c9c 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -15,7 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/module.h>
 
-#include "clk-regmap.h"
+#include <linux/clk/clk-regmap.h>
 #include "clk-pll.h"
 #include "clk-mpll.h"
 #include "axg.h"
diff --git a/drivers/clk/meson/c3-peripherals.c b/drivers/clk/meson/c3-peripherals.c
index 7dcbf4ebee078..13c13ead6bc66 100644
--- a/drivers/clk/meson/c3-peripherals.c
+++ b/drivers/clk/meson/c3-peripherals.c
@@ -8,7 +8,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/platform_device.h>
-#include "clk-regmap.h"
+#include <linux/clk/clk-regmap.h>
 #include "clk-dualdiv.h"
 #include "meson-clkc-utils.h"
 #include <dt-bindings/clock/amlogic,c3-peripherals-clkc.h>
diff --git a/drivers/clk/meson/c3-pll.c b/drivers/clk/meson/c3-pll.c
index 32bd2ed9d3044..06a7322403b53 100644
--- a/drivers/clk/meson/c3-pll.c
+++ b/drivers/clk/meson/c3-pll.c
@@ -8,7 +8,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/platform_device.h>
-#include "clk-regmap.h"
+#include <linux/clk/clk-regmap.h>
 #include "clk-pll.h"
 #include "meson-clkc-utils.h"
 #include <dt-bindings/clock/amlogic,c3-pll-clkc.h>
diff --git a/drivers/clk/meson/clk-cpu-dyndiv.c b/drivers/clk/meson/clk-cpu-dyndiv.c
index 6c1f58826e24a..d14bb1b5e4337 100644
--- a/drivers/clk/meson/clk-cpu-dyndiv.c
+++ b/drivers/clk/meson/clk-cpu-dyndiv.c
@@ -7,7 +7,7 @@
 #include <linux/clk-provider.h>
 #include <linux/module.h>
 
-#include "clk-regmap.h"
+#include <linux/clk/clk-regmap.h>
 #include "clk-cpu-dyndiv.h"
 
 static inline struct meson_clk_cpu_dyndiv_data *
diff --git a/drivers/clk/meson/clk-dualdiv.c b/drivers/clk/meson/clk-dualdiv.c
index 913bf25d3771b..8926f6fc94edf 100644
--- a/drivers/clk/meson/clk-dualdiv.c
+++ b/drivers/clk/meson/clk-dualdiv.c
@@ -24,7 +24,7 @@
 #include <linux/clk-provider.h>
 #include <linux/module.h>
 
-#include "clk-regmap.h"
+#include <linux/clk/clk-regmap.h>
 #include "clk-dualdiv.h"
 
 static inline struct meson_clk_dualdiv_data *
diff --git a/drivers/clk/meson/clk-mpll.c b/drivers/clk/meson/clk-mpll.c
index f639d56f0fd3f..cdf5c3cbeda12 100644
--- a/drivers/clk/meson/clk-mpll.c
+++ b/drivers/clk/meson/clk-mpll.c
@@ -15,7 +15,7 @@
 #include <linux/module.h>
 #include <linux/spinlock.h>
 
-#include "clk-regmap.h"
+#include <linux/clk/clk-regmap.h>
 #include "clk-mpll.h"
 
 #define SDM_DEN 16384
diff --git a/drivers/clk/meson/clk-phase.c b/drivers/clk/meson/clk-phase.c
index c1526fbfb6c4c..f48384c190e2f 100644
--- a/drivers/clk/meson/clk-phase.c
+++ b/drivers/clk/meson/clk-phase.c
@@ -7,7 +7,7 @@
 #include <linux/clk-provider.h>
 #include <linux/module.h>
 
-#include "clk-regmap.h"
+#include <linux/clk/clk-regmap.h>
 #include "clk-phase.h"
 
 #define phase_step(_width) (360 / (1 << (_width)))
diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index bc570a2ff3a3f..44d87c6c3dcaa 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -33,7 +33,7 @@
 #include <linux/math64.h>
 #include <linux/module.h>
 
-#include "clk-regmap.h"
+#include <linux/clk/clk-regmap.h>
 #include "clk-pll.h"
 
 static inline struct meson_clk_pll_data *
diff --git a/drivers/clk/meson/g12a-aoclk.c b/drivers/clk/meson/g12a-aoclk.c
index f0a18d8c9fc23..25e6f2597407e 100644
--- a/drivers/clk/meson/g12a-aoclk.c
+++ b/drivers/clk/meson/g12a-aoclk.c
@@ -15,7 +15,7 @@
 #include <linux/module.h>
 #include "meson-aoclk.h"
 
-#include "clk-regmap.h"
+#include <linux/clk/clk-regmap.h>
 #include "clk-dualdiv.h"
 
 #include <dt-bindings/clock/g12a-aoclkc.h>
diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index 02dda57105b10..b88b2519c9150 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -19,7 +19,7 @@
 
 #include "clk-mpll.h"
 #include "clk-pll.h"
-#include "clk-regmap.h"
+#include <linux/clk/clk-regmap.h>
 #include "clk-cpu-dyndiv.h"
 #include "vid-pll-div.h"
 #include "vclk.h"
diff --git a/drivers/clk/meson/gxbb-aoclk.c b/drivers/clk/meson/gxbb-aoclk.c
index 83b034157b353..f6facefc79041 100644
--- a/drivers/clk/meson/gxbb-aoclk.c
+++ b/drivers/clk/meson/gxbb-aoclk.c
@@ -8,7 +8,7 @@
 #include <linux/module.h>
 #include "meson-aoclk.h"
 
-#include "clk-regmap.h"
+#include <linux/clk/clk-regmap.h>
 #include "clk-dualdiv.h"
 
 #include <dt-bindings/clock/gxbb-aoclkc.h>
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index f071faad1ebb7..a9c5d73ee4bfb 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -11,7 +11,7 @@
 #include <linux/module.h>
 
 #include "gxbb.h"
-#include "clk-regmap.h"
+#include <linux/clk/clk-regmap.h>
 #include "clk-pll.h"
 #include "clk-mpll.h"
 #include "meson-eeclk.h"
diff --git a/drivers/clk/meson/meson-aoclk.h b/drivers/clk/meson/meson-aoclk.h
index 308be3e4814a9..099f4d5b55b10 100644
--- a/drivers/clk/meson/meson-aoclk.h
+++ b/drivers/clk/meson/meson-aoclk.h
@@ -16,7 +16,7 @@
 #include <linux/regmap.h>
 #include <linux/reset-controller.h>
 
-#include "clk-regmap.h"
+#include <linux/clk/clk-regmap.h>
 #include "meson-clkc-utils.h"
 
 struct meson_aoclk_data {
diff --git a/drivers/clk/meson/meson-eeclk.c b/drivers/clk/meson/meson-eeclk.c
index 66f79e384fe51..bbbaf9743abd5 100644
--- a/drivers/clk/meson/meson-eeclk.c
+++ b/drivers/clk/meson/meson-eeclk.c
@@ -11,7 +11,7 @@
 #include <linux/regmap.h>
 #include <linux/module.h>
 
-#include "clk-regmap.h"
+#include <linux/clk/clk-regmap.h>
 #include "meson-eeclk.h"
 
 int meson_eeclkc_probe(struct platform_device *pdev)
diff --git a/drivers/clk/meson/meson-eeclk.h b/drivers/clk/meson/meson-eeclk.h
index 37a48b75c6605..2def0370200a4 100644
--- a/drivers/clk/meson/meson-eeclk.h
+++ b/drivers/clk/meson/meson-eeclk.h
@@ -8,7 +8,7 @@
 #define __MESON_CLKC_H
 
 #include <linux/clk-provider.h>
-#include "clk-regmap.h"
+#include <linux/clk/clk-regmap.h>
 #include "meson-clkc-utils.h"
 
 struct platform_device;
diff --git a/drivers/clk/meson/meson8-ddr.c b/drivers/clk/meson/meson8-ddr.c
index 4b73ea244b630..22b1404ed3e1c 100644
--- a/drivers/clk/meson/meson8-ddr.c
+++ b/drivers/clk/meson/meson8-ddr.c
@@ -10,7 +10,7 @@
 #include <linux/clk-provider.h>
 #include <linux/platform_device.h>
 
-#include "clk-regmap.h"
+#include <linux/clk/clk-regmap.h>
 #include "clk-pll.h"
 
 #define AM_DDR_PLL_CNTL			0x00
diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index b7417ac262d33..8711c57e84b5c 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -17,7 +17,7 @@
 #include <linux/regmap.h>
 
 #include "meson8b.h"
-#include "clk-regmap.h"
+#include <linux/clk/clk-regmap.h>
 #include "meson-clkc-utils.h"
 #include "clk-pll.h"
 #include "clk-mpll.h"
diff --git a/drivers/clk/meson/s4-peripherals.c b/drivers/clk/meson/s4-peripherals.c
index c930cf0614a0f..e780bb0a07895 100644
--- a/drivers/clk/meson/s4-peripherals.c
+++ b/drivers/clk/meson/s4-peripherals.c
@@ -10,7 +10,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 
-#include "clk-regmap.h"
+#include <linux/clk/clk-regmap.h>
 #include "vid-pll-div.h"
 #include "clk-dualdiv.h"
 #include "s4-peripherals.h"
diff --git a/drivers/clk/meson/s4-pll.c b/drivers/clk/meson/s4-pll.c
index b0258933fb9d2..e5e71f0a23ebd 100644
--- a/drivers/clk/meson/s4-pll.c
+++ b/drivers/clk/meson/s4-pll.c
@@ -12,7 +12,7 @@
 
 #include "clk-mpll.h"
 #include "clk-pll.h"
-#include "clk-regmap.h"
+#include <linux/clk/clk-regmap.h>
 #include "s4-pll.h"
 #include "meson-clkc-utils.h"
 #include <dt-bindings/clock/amlogic,s4-pll-clkc.h>
diff --git a/drivers/clk/meson/sclk-div.c b/drivers/clk/meson/sclk-div.c
index ae03b048182f3..912b5c9b4c296 100644
--- a/drivers/clk/meson/sclk-div.c
+++ b/drivers/clk/meson/sclk-div.c
@@ -19,7 +19,7 @@
 #include <linux/clk-provider.h>
 #include <linux/module.h>
 
-#include "clk-regmap.h"
+#include <linux/clk/clk-regmap.h>
 #include "sclk-div.h"
 
 static inline struct meson_sclk_div_data *
diff --git a/drivers/clk/meson/vclk.h b/drivers/clk/meson/vclk.h
index 20b0b181db09d..6f0370b0d3a69 100644
--- a/drivers/clk/meson/vclk.h
+++ b/drivers/clk/meson/vclk.h
@@ -6,7 +6,7 @@
 #ifndef __VCLK_H
 #define __VCLK_H
 
-#include "clk-regmap.h"
+#include <linux/clk/clk-regmap.h>
 #include "parm.h"
 
 /**
diff --git a/drivers/clk/meson/vid-pll-div.c b/drivers/clk/meson/vid-pll-div.c
index 486cf68fc97a0..e3558b1a0744c 100644
--- a/drivers/clk/meson/vid-pll-div.c
+++ b/drivers/clk/meson/vid-pll-div.c
@@ -7,7 +7,7 @@
 #include <linux/clk-provider.h>
 #include <linux/module.h>
 
-#include "clk-regmap.h"
+#include <linux/clk/clk-regmap.h>
 #include "vid-pll-div.h"
 
 static inline struct meson_vid_pll_div_data *
diff --git a/drivers/clk/meson/clk-regmap.h b/include/linux/clk/clk-regmap.h
similarity index 100%
rename from drivers/clk/meson/clk-regmap.h
rename to include/linux/clk/clk-regmap.h
-- 
2.45.2


