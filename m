Return-Path: <linux-kernel+bounces-272335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A332D945A65
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 11:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CCD21F2207E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 09:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C791D363B;
	Fri,  2 Aug 2024 09:06:03 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FA81D2F77;
	Fri,  2 Aug 2024 09:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722589563; cv=none; b=JRP6+8lnYYcSLj+WkT+DmAKdDRnFMnD2Rq1PvyYrCi+p8CIeiXVZ394TTK0YRzOfVdppId54yL533+tahth0+zXwm4eeo9Javyjnx+s8IE6adxokMfRfPfiXF1Lxoh5wNZPL5nKKCGnLxygvDBQAxACX+0alwQ9lZt+zQ3cMFjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722589563; c=relaxed/simple;
	bh=KcQfXoxz6Z2AYLjXHjgrNNRl3o/C12L828tNePxn4Z4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P1yj8woaDj7DIkHF0vU4oBVByoUFF9uKLWmslb04AGK4In2C2pF5ufIJhog4yQxhns7fg5NY5uh5GWnjvQXVv7AWKWqHRH73yTLXBkAki7JBI27V2il7TIr+Uy9lFE/sxj3Cqp5eDrioogQS/go/e6FmDm91BC+gI1Dfu2iHxRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 2 Aug
 2024 17:05:51 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 2 Aug 2024 17:05:51 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>, <lee@kernel.org>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <arnd@arndb.de>,
	<olof@lixom.net>, <soc@kernel.org>, <mturquette@baylibre.com>,
	<sboyd@kernel.org>, <p.zabel@pengutronix.de>, <quic_bjorande@quicinc.com>,
	<geert+renesas@glider.be>, <dmitry.baryshkov@linaro.org>,
	<shawnguo@kernel.org>, <neil.armstrong@linaro.org>,
	<m.szyprowski@samsung.com>, <nfraprado@collabora.com>, <u-kumar1@ti.com>,
	<kevin_chen@aspeedtech.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v2 0/9] Introduce ASPEED AST27XX BMC SoC
Date: Fri, 2 Aug 2024 17:05:35 +0800
Message-ID: <20240802090544.2741206-2-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240802090544.2741206-1-kevin_chen@aspeedtech.com>
References: <20240802090544.2741206-1-kevin_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patchset adds initial support for the ASPEED.
AST27XX Board Management controller (BMC) SoC family.

AST2700 is ASPEED's 8th-generation server management processor.
Featuring a quad-core ARM Cortex A35 64-bit processor and two
independent ARM Cortex M4 processors

This patchset adds minimal architecture and drivers such as:
Clocksource, Clock and Reset

This patchset was tested on the ASPEED AST2700 evaluation board.

Kevin Chen (9):
  dt-bindings: mfd: aspeed,ast2x00-scu: Add ASPEED AST2700-SCUX schema
  dt-bindings: reset: ast2700: Add ASPEED AST27xx Reset schema
  dt-bindings: clk: ast2700: Add ASPEED AST27XX Clock schema
  clk: ast2700: add clock controller
  dt-bindings: arm: aspeed: Add ASPEED AST27XX SoC
  arm64: aspeed: Add support for ASPEED AST27XX BMC SoC
  arm64: defconfig: Add ASPEED AST2700 family support
  arm64: dts: aspeed: Add initial AST27XX device tree
  arm64: dts: aspeed: Add initial AST2700 EVB device tree

 .../bindings/arm/aspeed/aspeed.yaml           |    7 +
 .../bindings/mfd/aspeed,ast2x00-scu.yaml      |   70 +-
 MAINTAINERS                                   |    3 +
 arch/arm64/Kconfig.platforms                  |   14 +
 arch/arm64/boot/dts/Makefile                  |    1 +
 arch/arm64/boot/dts/aspeed/Makefile           |    4 +
 arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi     |  185 +++
 arch/arm64/boot/dts/aspeed/ast2700-evb.dts    |   58 +
 arch/arm64/configs/defconfig                  |    1 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/clk-ast2700.c                     | 1173 +++++++++++++++++
 .../dt-bindings/clock/aspeed,ast2700-clk.h    |  175 +++
 .../dt-bindings/reset/aspeed,ast2700-reset.h  |  132 ++
 13 files changed, 1804 insertions(+), 20 deletions(-)
 create mode 100644 arch/arm64/boot/dts/aspeed/Makefile
 create mode 100644 arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
 create mode 100644 arch/arm64/boot/dts/aspeed/ast2700-evb.dts
 create mode 100644 drivers/clk/clk-ast2700.c
 create mode 100644 include/dt-bindings/clock/aspeed,ast2700-clk.h
 create mode 100644 include/dt-bindings/reset/aspeed,ast2700-reset.h

-- 
2.34.1


