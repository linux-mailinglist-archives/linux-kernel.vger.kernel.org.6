Return-Path: <linux-kernel+bounces-279058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 626DC94B870
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98D08B2672C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1921898F6;
	Thu,  8 Aug 2024 07:59:58 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2F7189514;
	Thu,  8 Aug 2024 07:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723103997; cv=none; b=rCmUV+4H1wHZmcj0iWJY9RpXk0ue+BGIUqd2+fJTCnPeojWsPesVrzg66fEpYK9YESzQPTQRtcFEpnHoCeYQd26DkXSWFqP4WfhhFcsZEFo9bUoslNFsVoiQ7k2HgbSPuT85TtYEFq2cDwEYFXhyvQQroM+7j1V7ALVC0geXFmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723103997; c=relaxed/simple;
	bh=eayL23xPk6bPP98JeSf5U5mcNbxWQ4yXhRdE8H+JKvo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h0YjG/M1Ct5CLp9ReE8rFIRqL+nFN491amvDy8tZojPeIyv5JxyNd89ZZA6xaV8yXbEwD2iaba/jIJWJaWdEFXDMe4acNWsDsg/A0LlqjwPcBwmoobT7LCC7btIcxiadfB08LUkjxJcgMIsNTstIDEW1LvafJzTzFga3uytdCuY=
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
Subject: [PATCH 2/4] dt-bindings: reset Add AST2700 reset bindings
Date: Thu, 8 Aug 2024 15:59:35 +0800
Message-ID: <20240808075937.2756733-3-ryan_chen@aspeedtech.com>
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

Add dt bindings for AST2700 reset driver.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 .../dt-bindings/reset/aspeed,ast2700-reset.h  | 132 ++++++++++++++++++
 1 file changed, 132 insertions(+)
 create mode 100644 include/dt-bindings/reset/aspeed,ast2700-reset.h

diff --git a/include/dt-bindings/reset/aspeed,ast2700-reset.h b/include/dt-bindings/reset/aspeed,ast2700-reset.h
new file mode 100644
index 000000000000..ea261108abfb
--- /dev/null
+++ b/include/dt-bindings/reset/aspeed,ast2700-reset.h
@@ -0,0 +1,132 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Device Tree binding constants for AST2700 reset controller.
+ *
+ * Copyright (c) 2024 Aspeed Technology Inc.
+ */
+
+#ifndef _MACH_ASPEED_AST2700_RESET_H_
+#define _MACH_ASPEED_AST2700_RESET_H_
+
+/* SOC0 */
+#define SCU0_RESET_SDRAM		(0)
+#define SCU0_RESET_DDRPHY		(1)
+#define SCU0_RESET_RSA			(2)
+#define SCU0_RESET_SHA3			(3)
+#define SCU0_RESET_HACE			(4)
+#define SCU0_RESET_SOC			(5)
+#define SCU0_RESET_VIDEO		(6)
+#define SCU0_RESET_2D			(7)
+#define SCU0_RESET_PCIS			(8)
+#define SCU0_RESET_RVAS0		(9)
+#define SCU0_RESET_RVAS1		(10)
+#define SCU0_RESET_SM3			(11)
+#define SCU0_RESET_SM4			(12)
+#define SCU0_RESET_CRT0			(13)
+#define SCU0_RESET_ECC			(14)
+#define SCU0_RESET_DP_PCI		(15)
+#define SCU0_RESET_UFS			(16)
+#define SCU0_RESET_EMMC			(17)
+#define SCU0_RESET_PCIE1RST		(18)
+#define SCU0_RESET_PCIE1RSTOE		(19)
+#define SCU0_RESET_PCIE0RST		(20)
+#define SCU0_RESET_PCIE0RSTOE		(21)
+#define SCU0_RESET_JTAG			(22)
+#define SCU0_RESET_MCTP0		(23)
+#define SCU0_RESET_MCTP1		(24)
+#define SCU0_RESET_XDMA0		(25)
+#define SCU0_RESET_XDMA1		(26)
+#define SCU0_RESET_H2X1			(27)
+#define SCU0_RESET_DP			(28)
+#define SCU0_RESET_DP_MCU		(29)
+#define SCU0_RESET_SSP			(30)
+#define SCU0_RESET_H2X0			(31)
+#define SCU0_RESET_PORTA_VHUB1		(32)
+#define SCU0_RESET_PORTA_PHY3		(33)
+#define SCU0_RESET_PORTA_XHCI		(34)
+#define SCU0_RESET_PORTB_VHUB1		(35)
+#define SCU0_RESET_PORTB_PHY3		(36)
+#define SCU0_RESET_PORTB_XHCI		(37)
+#define SCU0_RESET_PORTA_EHCI		(38)
+#define SCU0_RESET_PORTA_VHUB0		(38)
+#define SCU0_RESET_PORTB_EHCI		(39)
+#define SCU0_RESET_PORTB_VHUB0		(39)
+#define SCU0_RESET_UHCI			(40)
+#define SCU0_RESET_TSP			(41)
+#define SCU0_RESET_E2M0			(42)
+#define SCU0_RESET_E2M1			(43)
+#define SCU0_RESET_VLINK		(44)
+
+#define SCU0_RESET_NUMS		(SCU0_RESET_VLINK + 1)
+
+/* SOC1 */
+#define SCU1_RESET_LPC0			(0)
+#define SCU1_RESET_LPC1			(1)
+#define SCU1_RESET_MII			(2)
+#define SCU1_RESET_PECI			(3)
+#define SCU1_RESET_PWM			(4)
+#define SCU1_RESET_MAC0			(5)
+#define SCU1_RESET_MAC1			(6)
+#define SCU1_RESET_MAC2			(7)
+#define SCU1_RESET_ADC			(8)
+#define SCU1_RESET_SD			(9)
+#define SCU1_RESET_ESPI0		(10)
+#define SCU1_RESET_ESPI1		(11)
+#define SCU1_RESET_JTAG1		(12)
+#define SCU1_RESET_SPI0			(13)
+#define SCU1_RESET_SPI1			(14)
+#define SCU1_RESET_SPI2			(15)
+#define SCU1_RESET_I3C0			(16)
+#define SCU1_RESET_I3C1			(17)
+#define SCU1_RESET_I3C2			(18)
+#define SCU1_RESET_I3C3			(19)
+#define SCU1_RESET_I3C4			(20)
+#define SCU1_RESET_I3C5			(21)
+#define SCU1_RESET_I3C6			(22)
+#define SCU1_RESET_I3C7			(23)
+#define SCU1_RESET_I3C8			(24)
+#define SCU1_RESET_I3C9			(25)
+#define SCU1_RESET_I3C10		(26)
+#define SCU1_RESET_I3C11		(27)
+#define SCU1_RESET_I3C12		(28)
+#define SCU1_RESET_I3C13		(29)
+#define SCU1_RESET_I3C14		(30)
+#define SCU1_RESET_I3C15		(31)
+#define SCU1_RESET_I3C15		(31)
+#define SCU1_RESET_MCU0			(32)
+#define SCU1_RESET_MCU1			(33)
+#define SCU1_RESET_H2A_SPI1		(34)
+#define SCU1_RESET_H2A_SPI2		(35)
+#define SCU1_RESET_UART0		(36)
+#define SCU1_RESET_UART1		(37)
+#define SCU1_RESET_UART2		(38)
+#define SCU1_RESET_UART3		(39)
+#define SCU1_RESET_I2C_FILTER		(40)
+#define SCU1_RESET_CALIPTRA		(41)
+#define SCU1_RESET_XDMA			(42)
+/* reserved 43 */
+#define SCU1_RESET_FSI			(44)
+#define SCU1_RESET_CAN			(45)
+#define SCU1_RESET_MCTP			(46)
+#define SCU1_RESET_I2C			(47)
+#define SCU1_RESET_UART6		(48)
+#define SCU1_RESET_UART7		(49)
+#define SCU1_RESET_UART8		(50)
+#define SCU1_RESET_UART9		(51)
+#define SCU1_RESET_LTPI			(52)
+#define SCU1_RESET_VGAL			(53)
+#define SCU1_RESET_LTPI1		(54)
+#define SCU1_RESET_ACE			(55)
+#define SCU1_RESET_E2M			(56)
+#define SCU1_RESET_UHCI			(57)
+#define SCU1_RESET_PORTC_EHCI		(58)
+#define SCU1_RESET_PORTC_VHUB		(59)
+#define SCU1_RESET_PORTD_EHCI		(60)
+#define SCU1_RESET_PORTD_VHUB		(61)
+#define SCU1_RESET_H2X			(62)
+#define SCU1_RESET_I3CDMA		(63)
+#define SCU1_RESET_PCIE2RST		(64)
+
+#define SCU1_RESET_NUMS		(SCU1_RESET_PCIE2RST + 1)
+
+#endif  /* _MACH_ASPEED_AST2700_RESET_H_ */
-- 
2.34.1


