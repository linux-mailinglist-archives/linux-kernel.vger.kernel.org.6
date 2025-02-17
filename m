Return-Path: <linux-kernel+bounces-517039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF67A37B37
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 07:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35F0E188BD1F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 06:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D94D18A6A6;
	Mon, 17 Feb 2025 06:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="cSrwkAd9"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E8218DB39;
	Mon, 17 Feb 2025 06:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739772794; cv=none; b=G3EM+TZIG51sUI3JBFFirHbeZ6TX3tr2DshD4ivaW8U0Oe6kFHiSVMMBYr5pqJWiWgYZLY2QQ2bypgRIDgkrnnDLPjCkFUvPTPDyCtcPuvhPN8wMB5FAQDjRvSlxUAR3w3j4gIOe0DrS4Vf2Iv4ECLD+wzEzAuiEcrdiIIRPt+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739772794; c=relaxed/simple;
	bh=HHMbgpNeEzDZ7ORYxSAbQ1Gijr8bxwEMUpfHHov6srE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V0xS62j67VzTuIPvkdWadAvDwJOsquRh6sk594xRQ0GCIExRba7mMKePL9qb2l0MdIgbhYe/BKTElD3anEGMVMI+N0lc7lXr+sLbR7+fd7tXRDk5hqFsFz7HzwbzOCzfZSzyu6/8lnTPp286J3xdrRljm6A8eS3ejmDCrLKrVxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=cSrwkAd9; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 9029C25B74;
	Mon, 17 Feb 2025 07:13:03 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IRIx5wKWMOLU; Mon, 17 Feb 2025 07:13:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1739772782; bh=HHMbgpNeEzDZ7ORYxSAbQ1Gijr8bxwEMUpfHHov6srE=;
	h=From:To:Cc:Subject:Date;
	b=cSrwkAd9nQ9/f7hytK2sLC/Yq52BOidLYDL4/zjPakiRnY+Ko8IGseGBqzrEWGTmg
	 /YubN+MdiNjAsYaRpDlTNFxP4MPkMrbAZ8+hGVCxrKh/RS5SX1uB2kihn2WLd9eMB6
	 wRzYsY+PSPRlkSQngYnlp0QbahuNvqgQdJY4vMx3TzIFVQq6LtQSYq7wR5X5tLZy8N
	 v7OyD+nf0xfigG1RXhlSXn3w/aeB5nPgC0CuJWOW23IGj3O3D1QAhfo8PHDrLfMk2r
	 8YrzORKjnAPpk1ukkWaRWzcHueLFzFaoyvGcWTI8QHG4nyzCLrhZlWmOuwzVBHVAWZ
	 2z03ghVdwzV/A==
From: Yao Zi <ziyao@disroot.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH v3 0/5] Support clock and reset unit of Rockchip RK3528
Date: Mon, 17 Feb 2025 06:11:41 +0000
Message-ID: <20250217061142.38480-5-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to previous Rockchip SoCs, reset controller on RK3528 shares
MMIO region with clock controller, combined as CRU. They're represented
as a single node in dt.

For the reset controller, only bindings are included in this series
because it's hard to test the reset controller without support for some
peripherals (e.g. pinctrl). I'd like to first make dt and basic
peripherals available, then submit the driver.

This is tested on Radxa E20C board. With some out-of-tree drivers, I've
successfully brouhgt up UART, pinctrl/gpio and I2C. A clock dump could
be obtained from [1].

[1]: https://gist.github.com/ziyao233/032961d1eebeecb9a41fea2d690e8351

Changed from v2
- dt-bindings:
  - drop redundant assigned-clocks and assigned-clock-rates properties
  - improve description of input clock gmac0
- Link to v2: https://lore.kernel.org/all/20250108114605.1960-2-ziyao@disroot.org/

Changed from v1
- dt-bindings:
  - relicense binding headers as GPL-2.0-only OR MIT
  - use gapless integers starting from 0 for binding IDs
  - make input clocks essential, add corresponding description
  - rename the input clock that is generated by phy module as "gmac0"
  - style fixes
- driver:
  - format in the common Rockchip driver style
  - drop initializing code of the reset controller, as it'll not be
    supported in this series
- Link to v1: https://lore.kernel.org/linux-rockchip/20241001042401.31903-2-ziyao@disroot.org/

Yao Zi (5):
  dt-bindings: clock: Document clock and reset unit of RK3528
  clk: rockchip: Add PLL flag ROCKCHIP_PLL_FIXED_MODE
  clk: rockchip: Add clock controller driver for RK3528 SoC
  arm64: dts: rockchip: Add clock generators for RK3528 SoC
  arm64: dts: rockchip: Add UART clocks for RK3528 SoC

 .../bindings/clock/rockchip,rk3528-cru.yaml   |   64 +
 arch/arm64/boot/dts/rockchip/rk3528.dtsi      |   68 +-
 drivers/clk/rockchip/Kconfig                  |    7 +
 drivers/clk/rockchip/Makefile                 |    1 +
 drivers/clk/rockchip/clk-pll.c                |   10 +-
 drivers/clk/rockchip/clk-rk3528.c             | 1114 +++++++++++++++++
 drivers/clk/rockchip/clk.h                    |   22 +
 .../dt-bindings/clock/rockchip,rk3528-cru.h   |  453 +++++++
 .../dt-bindings/reset/rockchip,rk3528-cru.h   |  241 ++++
 9 files changed, 1975 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3528-cru.yaml
 create mode 100644 drivers/clk/rockchip/clk-rk3528.c
 create mode 100644 include/dt-bindings/clock/rockchip,rk3528-cru.h
 create mode 100644 include/dt-bindings/reset/rockchip,rk3528-cru.h

-- 
2.48.1


