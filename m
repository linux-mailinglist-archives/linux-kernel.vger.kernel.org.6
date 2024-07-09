Return-Path: <linux-kernel+bounces-245801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0C292B983
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C19581F236B8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81E115B115;
	Tue,  9 Jul 2024 12:31:50 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7876415099C;
	Tue,  9 Jul 2024 12:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720528310; cv=none; b=S56NstiV5pmLGp5L6HEDn4iuH/KA0EUcCaIA9GA2NQ3LMyirqQKkygiYHwXXrg2E4N67YoM1WpODoPeesOcEU+mVZuM/UsApJxqkvgUIblBIImidRzV5z3eEEtldFoRqxirm9qCVEkQmhe5EoFEBoSospfp3qDqfA2vumjeI2l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720528310; c=relaxed/simple;
	bh=s7cI0PcCFmrZ6y+/nxcw9pFS2f8AwZKvybSn/j0dkoE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EZIKZJLrm2vimwtkKNkDIkvwZcvv0WDf2VOq5T3Oum/pQU3OXX8iNoombvGpwxbyRE4dOi1tsE96f4givtaFyVw/DPNW4+W3itmLepfKQJbfzBK1duDDyfyLof980ECOeBrCZrq5RPnjcInjajmh3RKfhjNA3VAOJcdlPn0LpN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860d18.versanet.de ([94.134.13.24] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sRA0S-00074P-Hz; Tue, 09 Jul 2024 14:31:40 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: mturquette@baylibre.com,
	sboyd@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	quentin.schulz@cherry.de,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH 0/6] Binding and driver for "dumb" clock generators
Date: Tue,  9 Jul 2024 14:31:15 +0200
Message-Id: <20240709123121.1452394-1-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rockchip boards with PCIe3 controllers inside the soc (rk3568, rk3588) have
external clock generators on the board to generate the needed 100MHz
reference clock the PCIe3 controller needs.

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

- Recent Theobroma-Systems boards (Jaguar and Tiger) modelled their
  generator as a combination of fixed clock and gpio-gate, which works
  because the generator's vdd-supply is always on and only the output-
  enable pin needs to be toggled.


So this series attempts to improve the situation by allowing to model
these clock generators as actual entities in the devicetree, to not have
them just accidentially work or break bindings.


[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts#n605

Heiko Stuebner (6):
  dt-bindings: clocks: add binding for generic clock-generators
  clk: add driver for generic clock generators
  arm64: dts: rockchip: fix the pcie clock generator on Rock 5 ITX
  arm64: dts: rockchip: use clock-generator for pcie-refclk on
    rk3588-jaguar
  arm64: dts: rockchip: use clock-generator for pcie-refclk on
    rk3588-tiger
  arm64: dts: rockchip: add pinctrl for clk-generator gpio on
    rk3588-tiger

 .../bindings/clock/clock-generator.yaml       |  62 ++++++++
 .../arm64/boot/dts/rockchip/rk3588-jaguar.dts |  13 +-
 .../boot/dts/rockchip/rk3588-rock-5itx.dts    |  34 ++++-
 .../arm64/boot/dts/rockchip/rk3588-tiger.dtsi |  21 +--
 drivers/clk/Kconfig                           |   7 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-generator.c                   | 133 ++++++++++++++++++
 7 files changed, 251 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/clock-generator.yaml
 create mode 100644 drivers/clk/clk-generator.c

-- 
2.39.2


