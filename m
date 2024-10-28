Return-Path: <linux-kernel+bounces-384091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3987A9B242C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 06:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0EC5281ACC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 05:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9735218C924;
	Mon, 28 Oct 2024 05:30:24 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D155F1DA5A;
	Mon, 28 Oct 2024 05:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730093424; cv=none; b=lBI+jnIzlCGVp9Nw82Wyq4HjX+ax+PYtstIQosbSYZxmuOrEVS8Bn0asSdbenmwWCrvkR1ceWgOhFayEFs4MUtNG+1QuIgDqj72B5FISSKnwMNReeUtQSHc+czYutnnROLrHT8ILOLksCiOgDA4P+fuX86KPC2pQwM6yWVxaKoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730093424; c=relaxed/simple;
	bh=IuqaJS20ADLLL8bkYgM9FMwE/0P4qnRb0lZTXLaOQ2s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OrClrkdVuaXSSdhoAX0gN/WOQ90DctLTO42ffYCAHijGdnRZcaMW7YrVXtATUBaZNJN34WaI5ILziHoEDZasAIvlpeG+rmBFbxOdpVVQ3QcqGnRY6KYdaZRj+nxl42GG8TWiJ3tJ1gG9ZbN6EoNhyGYICIgAaRbDmwcbtRrdVbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 28 Oct
 2024 13:30:18 +0800
Received: from twmbx02.aspeed.com (192.168.10.152) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 28 Oct 2024 13:30:18 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: <ryan_chen@aspeedtech.com>, <lee@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<p.zabel@pengutronix.de>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<dmitry.baryshkov@linaro.org>
Subject: [PATCH v7 0/3] [PATCH v6 0/3] Add support for AST2700 clk driver
Date: Mon, 28 Oct 2024 13:30:15 +0800
Message-ID: <20241028053018.2579200-1-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series is add clk driver for AST2700.

AST2700 is the 8th generation of Integrated Remote Management Processor
introduced by ASPEED Technology Inc. Which is Board Management controller
(BMC) SoC family. AST2700 have two SoC connected, one is SoC0, another
is SoC1, it has it's own scu, this driver inlcude SCU0 and SCU1 driver.

v7:
-reset-aspeed.h: fix declare static inline aspeed_reset_controller_register
if the function is not used.

v6:
-patch-2: add reset-aspeed.h
-reset-aspeed: add include cleanup.h for guard()
-reset-aspeed: change ids name clk_aspeed to reset_aspeed
-reset-aspeed: move aspeed_reset_controller_register,
aspeed_reset_adev_release, aspeed_reset_unregister_adev from clk-ast2700.c
-reset-aspeed: drop base check, since it check in clk-ast2700.c
-clk-ast2700: sync each gate name from *clk to *clk-gate name.
-clk-ast2700: add CLK_GATE_ASPEED to diff clk_hw_register_gate and
ast2700_clk_hw_register_gate.

v5:
-patch-2 Kconfig: add select AUXILIARY_BUS
-reset-aspeed: #define to_aspeed_reset(p) turn into static inline function.
-reset-aspeed: modify spin_lock_irqsave to guard(spinlock_irqsave)
-reset-aspeed: remove unnecessary parentheses.
-clk-ast2700: use <linux/units.h> and refrain from define clk

v4:
-yaml: keep size-cells=<1>.
-merge clk,reset dt binding header with yaml the same patch.
-rename clk,reset dt binding header to aspeed,ast2700-scu.h
-reset-aspeed: update tables tabs sapces to consistent spaces.
-reset-aspeed: remove no use dev_set_drvdata.
-clk-ast2700: modify reset_name to const int scu in struct clk_data.
-clk-ast2700: use scu number in clk_data generate reset_name for reset
 driver register.
-clk-ast2700: fix pll number mix up scu0,scu1.
-clk-ast2700: update dt-binding clock include file.

v3:
-yaml: v2 missing send yaml patch, v3 add.
-yaml: drop 64bits address example.
-yaml: add discription about soc0 and soc1
-dt-bindings: remove (), *_NUMS, reserved.
-dt-bindings: remove dulipated define number.
-dt-bindings: merge clk and reset to be one patch.
-reset-aspeed: add auxiliary device for reset driver.
-clk-ast2700: modify reset to be auxiliary add.
-clk-ast2700: modify to be platform driver.
-clk-ast2700: modify each clk to const clk array.

v2:
-yaml: drop 64bits address example.
-yaml: add discription about soc0 and soc1
-dt-bindings: remove (), *_NUMS, reserved.
-dt-bindings: remove dulipated define number
-clk-ast2700: drop WARN_ON, weird comment.

Ryan Chen (3):
  dt-bindings: mfd: aspeed: support for AST2700
  reset: aspeed: register AST2700 reset auxiliary bus device
  clk: aspeed: add AST2700 clock driver.

 .../bindings/mfd/aspeed,ast2x00-scu.yaml      |    8 +-
 drivers/clk/Kconfig                           |    8 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/clk-ast2700.c                     | 1513 +++++++++++++++++
 drivers/reset/Kconfig                         |    7 +
 drivers/reset/Makefile                        |    1 +
 drivers/reset/reset-aspeed.c                  |  302 ++++
 .../dt-bindings/clock/aspeed,ast2700-scu.h    |  163 ++
 .../dt-bindings/reset/aspeed,ast2700-scu.h    |  124 ++
 include/soc/aspeed/reset-aspeed.h             |   21 +
 10 files changed, 2147 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/clk-ast2700.c
 create mode 100644 drivers/reset/reset-aspeed.c
 create mode 100644 include/dt-bindings/clock/aspeed,ast2700-scu.h
 create mode 100644 include/dt-bindings/reset/aspeed,ast2700-scu.h
 create mode 100644 include/soc/aspeed/reset-aspeed.h

-- 
2.34.1


