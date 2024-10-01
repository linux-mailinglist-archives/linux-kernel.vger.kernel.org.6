Return-Path: <linux-kernel+bounces-345190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FD998B2F2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 06:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B19631F23C86
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 04:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC901B5334;
	Tue,  1 Oct 2024 04:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="fBXVrLWM"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E351B5301;
	Tue,  1 Oct 2024 04:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727756742; cv=none; b=QIUd4Q2m0eUD02GuAHuZCCxmU9434dKeX+CRchLNYE2PGsOwT4+JSANxOuGDPszmzu4/DjYb5SbzGsdgOczmBOdKoUWhdyPS4Y0Kss/hPKlqNPxrSFJsI39T7i+xkp4WCl3Ygp8Jj0PZ0K4yyp5E09F/ZYH/4B84zLE4SLXR+Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727756742; c=relaxed/simple;
	bh=VH7yflsNi1fts3RAMpJZ/C/k4OPfVtdy5jAhDmpXDSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p5HOeKtu5BU8sBTXzFEQPBg9U451fms62xcUhHzEEQrOs8xgBCbU13uIK9BtLV4fKFVsx84jg7o1kuZfKozV2TTCSjf2fe1LwUf3Jgni1in16XHPxx2u1jOZNWCKptA1wo0i8UDvekd0J7g1kiWMkmVaVpf2QAfxvXyHiNRWomc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=fBXVrLWM; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id D706F23D8F;
	Tue,  1 Oct 2024 06:25:29 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U8AI-d-3s4H9; Tue,  1 Oct 2024 06:25:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1727756729; bh=VH7yflsNi1fts3RAMpJZ/C/k4OPfVtdy5jAhDmpXDSI=;
	h=From:To:Cc:Subject:Date;
	b=fBXVrLWMqy9MtllBQKTbPJHQT341uaNCB+Wc/sBHRel0h9X/Hz7JazCACC9G7uu5V
	 zbJLoQa5AhwrCtTRWmvoXiTYEQFbyHaXOxSKnK4z2KHGdlcc/kO6GwZKkW+Bt2y2MG
	 YjAi6nH1RMkvkGFJgJYhlzsnJ65ZKbYZTWEvAYn/v8wP83RF89Kun4vxlanJG5pbji
	 7KP2y2QSgspX17zXQCaX/RU3dhisPoS1GyJy2hiyOBrolspJstaN15lqliE2nqAnnq
	 dZfAHSskvgOdCthlwCLN38KA5UG8eRbCOyFFlM6V8MlRl2MBTbpsKIveyy7UcICg7b
	 I1S9a0d1I01VA==
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
	Celeste Liu <CoelacanthusHex@gmail.com>,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH 0/8] Support clock and reset unit of Rockchip RK3528
Date: Tue,  1 Oct 2024 04:23:54 +0000
Message-ID: <20241001042401.31903-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds clock and reset driver as well as corresponding
dt-bindings and headers for RK3528 SoC.

Similar to previous Rockchip SoCs, reset controller shares MMIO region
with clock controller, combined as Clock and Reset Unit (CRU).

This depends on previous basic dt series[1]. Tested on Radxa E20C board,
a clock tree dump could be obtained here[2].

[1]: https://lore.kernel.org/all/20240829092705.6241-2-ziyao@disroot.org/T/#t
[2]: https://gist.github.com/ziyao233/47c24014d94e0fa1c67e8aa2ea9d3a27

Yao Zi (8):
  dt-bindings: clock: Add clock ID definition for Rockchip RK3528
  dt-bindings: reset: Add reset ID definition for Rockchip RK3528
  dt-bindings: clock: Add rockchip,rk3528-cru
  clk: rockchip: Add PLL flag ROCKCHIP_PLL_FIXED_MODE
  clk: rockchip: Add clock type GATE_NO_SET_RATE
  clk: rockchip: Add clock controller driver for RK3528 SoC
  arm64: dts: rockchip: Add clock generators for RK3528 SoC
  arm64: dts: rockchip: Add UART clocks for RK3528 SoC

 .../bindings/clock/rockchip,rk3528-cru.yaml   |   63 +
 arch/arm64/boot/dts/rockchip/rk3528.dtsi      |   66 +-
 drivers/clk/rockchip/Kconfig                  |    7 +
 drivers/clk/rockchip/Makefile                 |    1 +
 drivers/clk/rockchip/clk-pll.c                |   10 +-
 drivers/clk/rockchip/clk-rk3528.c             | 1194 +++++++++++++++++
 drivers/clk/rockchip/clk.c                    |    8 +
 drivers/clk/rockchip/clk.h                    |   36 +
 .../dt-bindings/clock/rockchip,rk3528-cru.h   |  453 +++++++
 .../dt-bindings/reset/rockchip,rk3528-cru.h   |  292 ++++
 10 files changed, 2125 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3528-cru.yaml
 create mode 100644 drivers/clk/rockchip/clk-rk3528.c
 create mode 100644 include/dt-bindings/clock/rockchip,rk3528-cru.h
 create mode 100644 include/dt-bindings/reset/rockchip,rk3528-cru.h


base-commit: 94ede2a3e9135764736221c080ac7c0ad993dc2d
prerequisite-patch-id: 00765e79597b500b66104626b59192bd0f29728a
prerequisite-patch-id: e4a9167d8787c6e852e45fc7815e5d552843fe48
prerequisite-patch-id: cc3802151c49f4c57c8a88be4ab785070b5e4d17
prerequisite-patch-id: c70c2ef39ebef152c9f3a8720daf06ae361d0416
-- 
2.46.0


