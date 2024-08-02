Return-Path: <linux-kernel+bounces-272334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D90945A62
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 11:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93BA1B21816
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 09:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702681D2F7A;
	Fri,  2 Aug 2024 09:05:56 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4401C0DC1;
	Fri,  2 Aug 2024 09:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722589556; cv=none; b=ACfD5tC4oVwRtdUvpW4gIIPkLSzmJmi1tq3Rw6/xJOd45RJcesy2QxVtHe0dCrCXxXZlfnaVvUXU+V89nTRQb4wTY+bP/Wcyjx3k7PLaILiJZ2nA4NTXMa2obQ6xWi6tSxG4WZayEhMEa/+oP80CCs162E5mR6o4Q0S91ky7QEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722589556; c=relaxed/simple;
	bh=D8ogs8GBuYVvZtiV2P2X9897oab0tdFIb2V2GWAbj0I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WQXY1KkEStkZbHF5GuTtnjHAhd8/vE+Me0fRynxAB6ceHvr7wD1NKeT298SPzIT2LFZ4JBsY1wcDNIbpZTxlMRgTy3h3LyrCDzlfmZ5KaY/VzE6HE9R6t0dmr/LKa1R4TRcijxX6j08QTnkycZtBiFxGJz97L53xL9f1pGgCrvY=
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
Subject: [PATCH v1 00/10] Introduce ASPEED AST27XX BMC SoC
Date: Fri, 2 Aug 2024 17:05:34 +0800
Message-ID: <20240802090544.2741206-1-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
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

Kevin Chen (10):
  dt-binding: mfd: aspeed,ast2x00-scu: Add binding for ASPEED AST2700
    SCU
  dt-binding: clk: ast2700: Add binding for Aspeed AST27xx Clock
  clk: ast2700: add clock controller
  dt-bindings: reset: ast2700: Add binding for ASPEED AST2700 Reset
  dt-bindings: arm: aspeed: Add maintainer
  dt-bindings: arm: aspeed: Add aspeed,ast2700-evb compatible string
  arm64: aspeed: Add support for ASPEED AST2700 BMC SoC
  arm64: dts: aspeed: Add initial AST27XX device tree
  arm64: dts: aspeed: Add initial AST2700 EVB device tree
  arm64: defconfig: Add ASPEED AST2700 family support

 .../bindings/arm/aspeed/aspeed.yaml           |    6 +
 .../bindings/mfd/aspeed,ast2x00-scu.yaml      |    3 +
 MAINTAINERS                                   |    3 +
 arch/arm64/Kconfig.platforms                  |   14 +
 arch/arm64/boot/dts/Makefile                  |    1 +
 arch/arm64/boot/dts/aspeed/Makefile           |    4 +
 arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi     |  217 +++
 arch/arm64/boot/dts/aspeed/ast2700-evb.dts    |   50 +
 arch/arm64/configs/defconfig                  |    1 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/clk-ast2700.c                     | 1166 +++++++++++++++++
 .../dt-bindings/clock/aspeed,ast2700-clk.h    |  180 +++
 .../dt-bindings/reset/aspeed,ast2700-reset.h  |  126 ++
 13 files changed, 1772 insertions(+)
 create mode 100644 arch/arm64/boot/dts/aspeed/Makefile
 create mode 100644 arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
 create mode 100644 arch/arm64/boot/dts/aspeed/ast2700-evb.dts
 create mode 100644 drivers/clk/clk-ast2700.c
 create mode 100644 include/dt-bindings/clock/aspeed,ast2700-clk.h
 create mode 100644 include/dt-bindings/reset/aspeed,ast2700-reset.h

-- 
2.34.1


