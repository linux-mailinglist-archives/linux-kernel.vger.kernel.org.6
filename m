Return-Path: <linux-kernel+bounces-279059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA5894B873
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F9681C20845
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923BE18991A;
	Thu,  8 Aug 2024 08:00:02 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177111898F1;
	Thu,  8 Aug 2024 07:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723104001; cv=none; b=PVNcSoaqOCkztNHdtSYhhYop3sVa7EsQVg7GHi0kD/PtkeZF9/uWsf4ZTUn1zaXe0KdspivWg0NzVIV4jiNJgFJ9VZpvd7i5MqDayqBDAf+yTfdpSkz9tikAj8YONPbaAVDjCCEt/sSCkTg8iPEs3XK/svAIPdmzxHN0VR4QBLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723104001; c=relaxed/simple;
	bh=jWyomkpphq3BVBJLvCHaLBlvZ00UMRIT83bissjhVnY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L5f1+qiOJOdj2myQ7NRaKrvfClvVzb7WdR/G7ECqgg5YqcmYxWxoi4sBL1zggpUVKr30aHui65CRyfV+gHqYAD9ECDfSKr9LYROQUyTleLjaqVjtOTlAbeBKXCegLuKxIN2gsXASpb7DNz1nDc/SRjC6j0do/vwJUvRrnVoCOws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 8 Aug
 2024 15:59:37 +0800
Received: from twmbx02.aspeed.com (192.168.10.152) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 8 Aug 2024 15:59:37 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: <ryan_chen@aspeedtech.com>, Lee Jones <lee@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<linux-clk@vger.kernel.org>
Subject: [PATCH 3/4] dt-bindings: clock: Add AST2700 clock bindings
Date: Thu, 8 Aug 2024 15:59:36 +0800
Message-ID: <20240808075937.2756733-4-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808075937.2756733-1-ryan_chen@aspeedtech.com>
References: <20240808075937.2756733-1-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add dt bindings for AST2700 clock controller

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 .../dt-bindings/clock/aspeed,ast2700-clk.h    | 175 ++++++++++++++++++
 1 file changed, 175 insertions(+)
 create mode 100644 include/dt-bindings/clock/aspeed,ast2700-clk.h

diff --git a/include/dt-bindings/clock/aspeed,ast2700-clk.h b/include/dt-bindings/clock/aspeed,ast2700-clk.h
new file mode 100644
index 000000000000..facf72352c3e
--- /dev/null
+++ b/include/dt-bindings/clock/aspeed,ast2700-clk.h
@@ -0,0 +1,175 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Device Tree binding constants for AST2700 clock controller.
+ *
+ * Copyright (c) 2024 Aspeed Technology Inc.
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_AST2700_H
+#define __DT_BINDINGS_CLOCK_AST2700_H
+
+/* SOC0 clk-gate */
+#define SCU0_CLK_GATE_MCLK	(0)
+#define SCU0_CLK_GATE_ECLK	(1)
+#define SCU0_CLK_GATE_2DCLK	(2)
+#define SCU0_CLK_GATE_VCLK	(3)
+#define SCU0_CLK_GATE_BCLK	(4)
+#define SCU0_CLK_GATE_VGA0CLK	(5)
+#define SCU0_CLK_GATE_REFCLK	(6)
+#define SCU0_CLK_GATE_PORTBUSB2CLK	(7)
+#define SCU0_CLK_GATE_RSV8	(8)
+#define SCU0_CLK_GATE_UHCICLK	(9)
+#define SCU0_CLK_GATE_VGA1CLK	(10)
+#define SCU0_CLK_GATE_DDRPHYCLK	(11)
+#define SCU0_CLK_GATE_E2M0CLK	(12)
+#define SCU0_CLK_GATE_HACCLK	(13)
+#define SCU0_CLK_GATE_PORTAUSB2CLK	(14)
+#define SCU0_CLK_GATE_UART4CLK	(15)
+#define SCU0_CLK_GATE_SLICLK	(16)
+#define SCU0_CLK_GATE_DACCLK	(17)
+#define SCU0_CLK_GATE_DP	(18)
+#define SCU0_CLK_GATE_E2M1CLK	(19)
+#define SCU0_CLK_GATE_CRT0CLK	(20)
+#define SCU0_CLK_GATE_CRT1CLK	(21)
+#define SCU0_CLK_GATE_VLCLK	(22)
+#define SCU0_CLK_GATE_ECDSACLK	(23)
+#define SCU0_CLK_GATE_RSACLK	(24)
+#define SCU0_CLK_GATE_RVAS0CLK	(25)
+#define SCU0_CLK_GATE_UFSCLK	(26)
+#define SCU0_CLK_GATE_EMMCCLK	(27)
+#define SCU0_CLK_GATE_RVAS1CLK	(28)
+/* reserved 29 ~ 31*/
+#define SCU0_CLK_GATE_NUM	(SCU0_CLK_GATE_RVAS1CLK + 1)
+
+/* SOC0 clk */
+#define SCU0_CLKIN		(SCU0_CLK_GATE_NUM + 0)
+#define SCU0_CLK_24M		(SCU0_CLK_GATE_NUM + 1)
+#define SCU0_CLK_192M		(SCU0_CLK_GATE_NUM + 2)
+#define SCU0_CLK_UART		(SCU0_CLK_GATE_NUM + 3)
+#define SCU0_CLK_PSP		(SCU0_CLK_GATE_NUM + 4)
+#define SCU0_CLK_HPLL		(SCU0_CLK_GATE_NUM + 5)
+#define SCU0_CLK_HPLL_DIV2	(SCU0_CLK_GATE_NUM + 6)
+#define SCU0_CLK_HPLL_DIV4	(SCU0_CLK_GATE_NUM + 7)
+#define SCU0_CLK_DPLL		(SCU0_CLK_GATE_NUM + 8)
+#define SCU0_CLK_MPLL		(SCU0_CLK_GATE_NUM + 9)
+#define SCU0_CLK_MPLL_DIV2	(SCU0_CLK_GATE_NUM + 10)
+#define SCU0_CLK_MPLL_DIV4	(SCU0_CLK_GATE_NUM + 11)
+#define SCU0_CLK_MPLL_DIV8	(SCU0_CLK_GATE_NUM + 12)
+#define SCU0_CLK_VGA0		(SCU0_CLK_GATE_NUM + 13)
+#define SCU0_CLK_VGA1		(SCU0_CLK_GATE_NUM + 14)
+#define SCU0_CLK_CRT0		(SCU0_CLK_GATE_NUM + 15)
+#define SCU0_CLK_CRT1		(SCU0_CLK_GATE_NUM + 16)
+#define SCU0_CLK_MPHY		(SCU0_CLK_GATE_NUM + 17)
+#define SCU0_CLK_AXI0		(SCU0_CLK_GATE_NUM + 18)
+#define SCU0_CLK_AXI1		(SCU0_CLK_GATE_NUM + 19)
+#define SCU0_CLK_AHB		(SCU0_CLK_GATE_NUM + 20)
+#define SCU0_CLK_APB		(SCU0_CLK_GATE_NUM + 21)
+#define SCU0_CLK_MCLK		(SCU0_CLK_GATE_NUM + 22)
+#define SCU0_CLK_ECLK		(SCU0_CLK_GATE_NUM + 23)
+#define SCU0_CLK_VCLK		(SCU0_CLK_GATE_NUM + 24)
+#define SCU0_CLK_BCLK		(SCU0_CLK_GATE_NUM + 25)
+#define SCU0_CLK_REF		(SCU0_CLK_GATE_NUM + 26)
+#define SCU0_CLK_UART4		(SCU0_CLK_GATE_NUM + 27)
+#define SCU0_CLK_SLI		(SCU0_CLK_GATE_NUM + 28)
+#define SCU0_CLK_UFS		(SCU0_CLK_GATE_NUM + 29)
+#define SCU0_CLK_EMMCMUX	(SCU0_CLK_GATE_NUM + 30)
+#define SCU0_CLK_EMMC		(SCU0_CLK_GATE_NUM + 31)
+#define SCU0_CLK_U2PHY_CLK12M	(SCU0_CLK_GATE_NUM + 32)
+#define SCU0_CLK_U2PHY_REFCLK	(SCU0_CLK_GATE_NUM + 33)
+
+#define SCU0_NUM_CLKS		(SCU0_CLK_U2PHY_REFCLK + 1)
+
+/* SOC1 clk gate */
+#define SCU1_CLK_GATE_LCLK0		(0)
+#define SCU1_CLK_GATE_LCLK1		(1)
+#define SCU1_CLK_GATE_ESPI0CLK		(2)
+#define SCU1_CLK_GATE_ESPI1CLK		(3)
+#define SCU1_CLK_GATE_SDCLK		(4)
+#define SCU1_CLK_GATE_IPEREFCLK		(5)	/* io die pcie ref clk */
+#define SCU1_CLK_GATE_RSV5CLK		(6)
+#define SCU1_CLK_GATE_LPCHCLK		(7)
+#define SCU1_CLK_GATE_MAC0CLK		(8)
+#define SCU1_CLK_GATE_MAC1CLK		(9)
+#define SCU1_CLK_GATE_MAC2CLK		(10)
+#define SCU1_CLK_GATE_UART0CLK		(11)
+#define SCU1_CLK_GATE_UART1CLK		(12)
+#define SCU1_CLK_GATE_UART2CLK		(13)
+#define SCU1_CLK_GATE_UART3CLK		(14)
+#define SCU1_CLK_GATE_I2CCLK		(15)
+#define SCU1_CLK_GATE_I3C0CLK		(16)
+#define SCU1_CLK_GATE_I3C1CLK		(17)
+#define SCU1_CLK_GATE_I3C2CLK		(18)
+#define SCU1_CLK_GATE_I3C3CLK		(19)
+#define SCU1_CLK_GATE_I3C4CLK		(20)
+#define SCU1_CLK_GATE_I3C5CLK		(21)
+#define SCU1_CLK_GATE_I3C6CLK		(22)
+#define SCU1_CLK_GATE_I3C7CLK		(23)
+#define SCU1_CLK_GATE_I3C8CLK		(24)
+#define SCU1_CLK_GATE_I3C9CLK		(25)
+#define SCU1_CLK_GATE_I3C10CLK		(26)
+#define SCU1_CLK_GATE_I3C11CLK		(27)
+#define SCU1_CLK_GATE_I3C12CLK		(28)
+#define SCU1_CLK_GATE_I3C13CLK		(29)
+#define SCU1_CLK_GATE_I3C14CLK		(30)
+#define SCU1_CLK_GATE_I3C15CLK		(31)
+
+#define SCU1_CLK_GATE_UART5CLK		(32 + 0)
+#define SCU1_CLK_GATE_UART6CLK		(32 + 1)
+#define SCU1_CLK_GATE_UART7CLK		(32 + 2)
+#define SCU1_CLK_GATE_UART8CLK		(32 + 3)
+#define SCU1_CLK_GATE_UART9CLK		(32 + 4)
+#define SCU1_CLK_GATE_UART10CLK		(32 + 5)
+#define SCU1_CLK_GATE_UART11CLK		(32 + 6)
+#define SCU1_CLK_GATE_UART12CLK		(32 + 7)
+#define SCU1_CLK_GATE_FSICLK		(32 + 8)
+#define SCU1_CLK_GATE_LTPIPHYCLK	(32 + 9)
+#define SCU1_CLK_GATE_LTPICLK		(32 + 10)
+#define SCU1_CLK_GATE_VGALCLK		(32 + 11)
+#define SCU1_CLK_GATE_USBUARTCLK	(32 + 12)
+#define SCU1_CLK_GATE_CANCLK		(32 + 13)
+#define SCU1_CLK_GATE_PCICLK		(32 + 14)
+#define SCU1_CLK_GATE_SLICLK		(32 + 15)
+#define SCU1_CLK_GATE_E2MCLK		(32 + 16)
+#define SCU1_CLK_GATE_PORTCUSB2CLK	(32 + 17)
+#define SCU1_CLK_GATE_PORTDUSB2CLK	(32 + 18)
+#define SCU1_CLK_GATE_LTPI1TXCLK	(32 + 19)
+
+#define SCU1_CLK_GATE_NUM	(SCU1_CLK_GATE_LTPI1TXCLK + 1)
+
+/* SOC1 clk */
+#define SCU1_CLKIN		(SCU1_CLK_GATE_NUM + 0)
+#define SCU1_CLK_HPLL		(SCU1_CLK_GATE_NUM + 1)
+#define SCU1_CLK_APLL		(SCU1_CLK_GATE_NUM + 2)
+#define SCU1_CLK_APLL_DIV2	(SCU1_CLK_GATE_NUM + 3)
+#define SCU1_CLK_APLL_DIV4	(SCU1_CLK_GATE_NUM + 4)
+#define SCU1_CLK_DPLL		(SCU1_CLK_GATE_NUM + 5)
+#define SCU1_CLK_UXCLK		(SCU1_CLK_GATE_NUM + 6)
+#define SCU1_CLK_HUXCLK		(SCU1_CLK_GATE_NUM + 7)
+#define SCU1_CLK_UARTX		(SCU1_CLK_GATE_NUM + 8)
+#define SCU1_CLK_HUARTX		(SCU1_CLK_GATE_NUM + 9)
+#define SCU1_CLK_AHB		(SCU1_CLK_GATE_NUM + 10)
+#define SCU1_CLK_APB		(SCU1_CLK_GATE_NUM + 11)
+#define SCU1_CLK_UART0		(SCU1_CLK_GATE_NUM + 12)
+#define SCU1_CLK_UART1		(SCU1_CLK_GATE_NUM + 13)
+#define SCU1_CLK_UART2		(SCU1_CLK_GATE_NUM + 14)
+#define SCU1_CLK_UART3		(SCU1_CLK_GATE_NUM + 15)
+#define SCU1_CLK_UART5		(SCU1_CLK_GATE_NUM + 16)
+#define SCU1_CLK_UART6		(SCU1_CLK_GATE_NUM + 17)
+#define SCU1_CLK_UART7		(SCU1_CLK_GATE_NUM + 18)
+#define SCU1_CLK_UART8		(SCU1_CLK_GATE_NUM + 19)
+#define SCU1_CLK_UART9		(SCU1_CLK_GATE_NUM + 20)
+#define SCU1_CLK_UART10		(SCU1_CLK_GATE_NUM + 21)
+#define SCU1_CLK_UART11		(SCU1_CLK_GATE_NUM + 22)
+#define SCU1_CLK_UART12		(SCU1_CLK_GATE_NUM + 23)
+#define SCU1_CLK_APLL_DIVN	(SCU1_CLK_GATE_NUM + 24)
+#define SCU1_CLK_SDMUX		(SCU1_CLK_GATE_NUM + 25)
+#define SCU1_CLK_SDCLK		(SCU1_CLK_GATE_NUM + 26)
+#define SCU1_CLK_RMII		(SCU1_CLK_GATE_NUM + 27)
+#define SCU1_CLK_RGMII		(SCU1_CLK_GATE_NUM + 28)
+#define SCU1_CLK_MACHCLK	(SCU1_CLK_GATE_NUM + 29)
+#define SCU1_CLK_MAC0RCLK	(SCU1_CLK_GATE_NUM + 30)
+#define SCU1_CLK_MAC1RCLK	(SCU1_CLK_GATE_NUM + 31)
+
+#define SCU1_NUM_CLKS		(SCU1_CLK_MAC1RCLK + 1)
+
+#endif
-- 
2.34.1


