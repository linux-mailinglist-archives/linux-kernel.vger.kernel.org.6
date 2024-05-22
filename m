Return-Path: <linux-kernel+bounces-185925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F948CBCF2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA6C11C2207A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 08:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A9E811E9;
	Wed, 22 May 2024 08:27:41 +0000 (UTC)
Received: from mail-sh.amlogic.com (unknown [58.32.228.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9FA8063B;
	Wed, 22 May 2024 08:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.32.228.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716366461; cv=none; b=T9LGg9YG7pjGouUcZ+RK4X7Yi57vyZuJO+r3+vaJGpEJTmdK+797lEFiWF1U2ZjOPTFl3e4zETNiKCvBwV3rTkyRiMIF1cVpMIIPwFd66ywgTn9HvZU53nGp7tvrSnF6qROROXwHkZ9ezkLtWIo7p0bsFSkKTkk8Uq9EBvlBmxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716366461; c=relaxed/simple;
	bh=4SLPJsqT08LVrwDTgJMLvNXsh0vWszWkori5CoGMTa4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A2Y3Ra9e6UgY3DU/QjKCmbMhbe1STKEPWwZSuYIaHf8OnEQdEJv6Vh7L7a5XfeVctN3AWhyeFm34nskg+cDpaCRIjimY25lLuyaqrycugIGHjXQdBS+X341Ay+0ArlHChexJ3wA3P+zudDmLSBkTf9En+W69LS2igtWAauKXi5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; arc=none smtp.client-ip=58.32.228.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Received: from droid01-cd.amlogic.com (10.98.11.200) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.6; Wed, 22 May 2024
 16:27:30 +0800
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
To: <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: Neil Armstrong <neil.armstrong@linaro.org>, Jerome Brunet
	<jbrunet@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, "Stephen
 Boyd" <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>, Xianwei Zhao <xianwei.zhao@amlogic.com>
Subject: [PATCH v9 0/5] Add C3 SoC PLLs and Peripheral clock
Date: Wed, 22 May 2024 16:27:22 +0800
Message-ID: <20240522082727.3029656-1-xianwei.zhao@amlogic.com>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The patchset adds support for the peripheral and PLL clock controller
found on the Amlogic C3 SoC family, such as C302X or C308L.

Some clocks are provided by security zones. These clock accessed
througth SCMI driver in linux, inlcuding DDR_PLL,DDR_PHY, TOP_PLL,
USB_PLL, MIPIISP_VOUT, MCLK_PLL, USB_CTRL, ETH_PLL, OSC, SYS_CLK,
AXI_CLK, CPU_CLK, FIXED_PLL, GP1_PLL, SYS_PLL_DIV16, CPU_CLK_DIV14.

Changes since V8 [1]:
 - Use imply in Kconfig.
 - Link to v8: https://lore.kernel.org/all/20240430064438.2094701-1-xianwei.zhao@amlogic.com 

Changes since V7 [1]:
 - Remove included head file not used.
 - Link to v7: https://lore.kernel.org/all/20240424050928.1997820-1-xianwei.zhao@amlogic.com

Changes since V6 [12]:
 - Add pad src for rtc clock.
 - Add SCMI clock controller support, move some clock node in SCMI,such as GP1 PLL DDR USB etc.
 - Fix some spelling mistake.
 - Use lower case for bindings and update some input clocks desc.
 - Update some clock comments.
 - Delete prefix "AML_" for macro definition.
 - Addd some clock annotation and some clock flag CRITICAL.
 - Add maximum for regmap_config.
 - Delete some unused register definition and unused clock inputs. 
 - Drop patch subject redundant "bindings". Suggested by Krzysztof.
 - Not reference header file "clk.h" and replace comment. Suggested by Jerome.
 - Modify description about board in Kconfig file help item. Suggested by Jerome.
 - Link to v6: https://lore.kernel.org/all/20231106085554.3237511-1-xianwei.zhao@amlogic.com

Changes since V5 [3]:
 - Fix some typo and modify formart for MARCO. Suggested by Jerome.
 - Add pad clock for peripheral input clock in bindings.
 - Add some description for explaining why ddr_dpll_pt_clk and cts_msr_clk are out of tree.
Changes since V4 [10]:
 - Change some fw_name of clocks. Suggested by Jerome.
 - Delete minItem of clocks.
 - Add CLk_GET_RATE_NOCACHE flags for gp1_pll
 - Fix some format. and fix width as 8 for mclk_pll_dco.
 - exchange gate and divder for fclk_50m clock.
 - add CLK_SET_RATE_PARENT for axi_a_divder & axi_b_divder.
 - add CLK_IS_CRITICAL for axi_clk
 - Optimized macro define for pwm clk.
 - add cts_oscin_clk mux between 24M and 32k
 - add some missing gate clock, such as ddr_pll.
Changes since V3 [7]:
 - Modify Kconfig desc and PLL yaml clk desc.
 - Fix some format.Suggested by Yixun and Jerome.
 - Add flag CLK_GET_RATE_NOCACHE for sys_clk.
 - Optimized macro define for pwm clk.
 - Use flag CLK_IS_CRITICAL for axi_clk.
 - Add some description for some clocks.
 - Use FCLK_50M instead of FCLK_DIV40.
Changes since V2 [4]:
 - Modify some format, include clk name & inline, and so on.
 - Define marco for pwm clock.
 - Add GP1_PLL clock.
 - Modify yaml use raw instead of macro.
Changes since V1 [2]:
 - Fix errors when check binding by using "make dt_binding_check".
 - Delete macro definition.
Xianwei Zhao (5):
  dt-bindings: clock: add Amlogic C3 PLL clock controller
  dt-bindings: clock: add Amlogic C3 SCMI clock controller support
  dt-bindings: clock: add Amlogic C3 peripherals clock controller
  clk: meson: c3: add support for the C3 SoC PLL clock
  clk: meson: c3: add c3 clock peripherals controller driver

 .../clock/amlogic,c3-peripherals-clkc.yaml    |  120 +
 .../bindings/clock/amlogic,c3-pll-clkc.yaml   |   59 +
 drivers/clk/meson/Kconfig                     |   27 +
 drivers/clk/meson/Makefile                    |    2 +
 drivers/clk/meson/c3-peripherals.c            | 2365 +++++++++++++++++
 drivers/clk/meson/c3-pll.c                    |  746 ++++++
 .../clock/amlogic,c3-peripherals-clkc.h       |  212 ++
 .../dt-bindings/clock/amlogic,c3-pll-clkc.h   |   40 +
 .../dt-bindings/clock/amlogic,c3-scmi-clkc.h  |   27 +
 9 files changed, 3598 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,c3-peripherals-clkc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml
 create mode 100644 drivers/clk/meson/c3-peripherals.c
 create mode 100644 drivers/clk/meson/c3-pll.c
 create mode 100644 include/dt-bindings/clock/amlogic,c3-peripherals-clkc.h
 create mode 100644 include/dt-bindings/clock/amlogic,c3-pll-clkc.h
 create mode 100644 include/dt-bindings/clock/amlogic,c3-scmi-clkc.h


base-commit: ba535bce57e71463a86f8b33a0ea88c26e3a6418
-- 
2.39.2


