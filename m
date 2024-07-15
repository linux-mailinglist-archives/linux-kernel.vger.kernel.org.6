Return-Path: <linux-kernel+bounces-252411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D7B9312BC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 261531F211AC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8427A1891AA;
	Mon, 15 Jul 2024 11:04:16 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B639D18411C;
	Mon, 15 Jul 2024 11:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721041456; cv=none; b=Rjbkx0M/4id7eBYb5YWYbd5Ba3wiVFKA7Yi/f/9sHGD0pJzXu2nVSDBKhcxMQTWg4GQ4GBJLyHlXS5lplUtWesCD84pOp/3RkSqWHfuHk1r+PzDH0Nn7A6GN4sqH1qMf5vUPyBrFY/531qbRCUVhA3lRzJm0qynAlvxPHHW4pPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721041456; c=relaxed/simple;
	bh=zERXhxbSPdCtg8ibfjvU/5ep9gYQ55E1S2QB8wtLjTw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UQhzk5+VOm0sgneqX6LgDwqtOTbcCfC3pvp1bQ4Xj1KtKBpGWHlzb26qAqYUdNBG80SXmC/6M+wz/0bql/iJPhnQgvx65giEdBvZvgxczf8wI60JfQQp1UPOsRusXGnP1I+Bxf1/2o6B3OoymHUFeoYkgzG/SC9PpeBnFaN5sgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860d09.versanet.de ([94.134.13.9] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sTJV3-0006GM-3Z; Mon, 15 Jul 2024 13:04:09 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: mturquette@baylibre.com,
	sboyd@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v2 0/3] Binding and driver for voltage controlled oscillators
Date: Mon, 15 Jul 2024 13:02:48 +0200
Message-Id: <20240715110251.261844-1-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rockchip boards with PCIe3 controllers inside the soc (rk3568, rk3588) have
external oscillators on the board to generate the needed 100MHz reference
clock the PCIe3 controller needs.

Often these clock generators need supplies to be enabled to run.

Modelling this clock has taken a number of shapes:
- The rk3568 Rock-3a modelled the generator-regulator as "phy-supply" [0]
  &pcie30phy {
  	phy-supply = <&vcc3v3_pi6c_03>;
  	status = "okay";
  };
  which is of course not part of the binding

- On the Rock-5-ITX the supply of the clock generator is controlled by
  the same gpio as the regulator supplying the the port connected to the
  pcie30x4 controller, so if this controller probes first, both
  controllers will just run. But if the pcie30x2 controller probes first
  (which has a different supply), the controller will stall at the first
  dbi read.

There are other types too, where an 25MHz oscillator supplies a PLL
chip like the diodes,pi6c557 used on Theobroma Jaguar and Tiger boards.

As we established in v1 [1], these are essentially different types, so
this series attempts to solve the first case of "voltage controlled
oscillators" as Stephen called them.

changes in v2:
- drop the Diodes PLLs for now, to get the first variant right
- rename stuff to voltage-oscillator / clk_vco as suggested by Stephen
- require vdd-supply in the binding
- enable-gpios stays optional, as they often are tied to vdd-supply
- drop deprecated elements that were left in from the fixed clock binding


[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts#n605
[1] https://lore.kernel.org/linux-clk/b3c450a94bcb4ad0bc5b3c7ee8712cb8.sboyd@kernel.org/

Heiko Stuebner (3):
  dt-bindings: clocks: add binding for voltage-controlled-oscillators
  clk: add driver for voltage controlled oscillators
  arm64: dts: rockchip: fix the pcie refclock oscillator on Rock 5 ITX

 .../bindings/clock/voltage-oscillator.yaml    |  49 +++++++
 .../boot/dts/rockchip/rk3588-rock-5-itx.dts   |  38 ++++-
 drivers/clk/Kconfig                           |  10 ++
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-vco.c                         | 133 ++++++++++++++++++
 5 files changed, 229 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/voltage-oscillator.yaml
 create mode 100644 drivers/clk/clk-vco.c

-- 
2.39.2


