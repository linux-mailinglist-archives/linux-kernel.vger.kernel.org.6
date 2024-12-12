Return-Path: <linux-kernel+bounces-443356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8FD9EEE05
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C17A2843D7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F5C21E086;
	Thu, 12 Dec 2024 15:52:54 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925ED4F218;
	Thu, 12 Dec 2024 15:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018774; cv=none; b=Ki/z48qHglFZgtyoR7t3eYj72dTN0+C4qy4kMRQSuRSfyft3Dmac+uMl3rpDPA49S6sQIX+NgdxwW8ntNrWGHwMsnFI1xsvVdPI+t+bo/mzkEZNjaXZ5XKiM8lOSvRew042FQFZGFuh15bpGCMK0Xso/tfp2tI07vbDreTqaCfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018774; c=relaxed/simple;
	bh=6KvSWy/qvctLgXtiy34HcDw5CYN2RqavDCfoL9/qKKo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YZdgot+DghOKaP8K3Ktt1Q1iM9e1oI9GEENDfFwwq42nETXHiNxZdlzB7klCfC9IP0GrTxy/aSRZEn4GCEsW7KHqnYCEPqAc1YfLaAIfIwmKmZC6mFjG6aohB1GNTf/92XAyglij0qbcNf9VAkmv5SLYuJalYNvdfb4jtOdt5nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 12 Dec
 2024 23:52:41 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 12 Dec 2024 23:52:41 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>, <tglx@linutronix.de>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <arnd@arndb.de>,
	<olof@lixom.net>, <quic_bjorande@quicinc.com>, <geert+renesas@glider.be>,
	<dmitry.baryshkov@linaro.org>, <konradybcio@kernel.org>,
	<neil.armstrong@linaro.org>, <johan+linaro@kernel.org>,
	<kevin_chen@aspeedtech.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <soc@lists.linux.dev>
Subject: [PATCH v3 0/6] Introduce ASPEED AST27XX BMC SoC
Date: Thu, 12 Dec 2024 23:52:29 +0800
Message-ID: <20241212155237.848336-1-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

---
v3:
  - Split clk and reset driver to other commits, which are in series of
    "Add support for AST2700 clk driver".
  - For BMC console by UART12, add uart12 using ASPEED INTC architecture.

aspeed,ast2700-intc.yaml
  - Add minItems to 1 to fix the warning by "make dtbs_check W=1".
  - Add intc1 into example.

Kconfig.platforms
  - Remove MACH_ASPEED_G7.

Kevin Chen (6):
  dt-bindings: interrupt-controller: Refine size/interrupt-cell usage.
  dt-bindings: arm: aspeed: Add ASPEED AST27XX SoC
  arm64: aspeed: Add support for ASPEED AST27XX BMC SoC
  arm64: dts: aspeed: Add initial AST27XX device tree
  arm64: dts: aspeed: Add initial AST2700 EVB device tree
  arm64: defconfig: Add ASPEED AST2700 family support

 .../bindings/arm/aspeed/aspeed.yaml           |   6 +
 .../aspeed,ast2700-intc.yaml                  |  60 ++++-
 MAINTAINERS                                   |   1 +
 arch/arm64/Kconfig.platforms                  |   6 +
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/aspeed/Makefile           |   4 +
 arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi     | 236 ++++++++++++++++++
 arch/arm64/boot/dts/aspeed/ast2700-evb.dts    |  57 +++++
 arch/arm64/configs/defconfig                  |   1 +
 9 files changed, 359 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm64/boot/dts/aspeed/Makefile
 create mode 100644 arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
 create mode 100644 arch/arm64/boot/dts/aspeed/ast2700-evb.dts

-- 
2.34.1


