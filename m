Return-Path: <linux-kernel+bounces-304762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 503C2962483
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECF921F25341
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E096C16C448;
	Wed, 28 Aug 2024 10:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="k/ke22CX"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F30115B0F9;
	Wed, 28 Aug 2024 10:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724840121; cv=none; b=fE43SCCnbrP1dg9o+tmE5EolDYg53A7CnHLtMmhSdNWbLgUiZhomKsog6uPLaxyV2QZ6zC156SI2PoBjoZGWIC9eehm58GrTKwK/n5NiDEsULihs+Wb1zAD3bTlIVrZhLRi7E24rQMU2ARefjVDfpQGAwnti+A9w+3QSAmEsR4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724840121; c=relaxed/simple;
	bh=VgQl7hVtTV26miCga2xU2/6ui5yOWEwJzFKnSMzf19U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VECcCaIHfbHNOMPYmq8qxUT/JlH/RqIU+t/xAzhHQi6EVLMMy0AJMzWI1+xW87h8Ip1u0EENk1kCwufY7YDl5dGn+FaE8WHCwWcEw0Auxpxy8YU3CAqe9vZ7+izoAd5ZyDHWRg1Nzo4hw7FTPGgyYT4qRuBVdJVcjqGL6EndSls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=k/ke22CX; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2wUUgvKrOA9LcaPHHxkyuAr+CT//eVZaSH+GBa8SQUU=; b=k/ke22CXNPdk4BoAX/51lPQyU4
	Q7Va9Daf8YJpco/G/6kbs8xIlPRh8B6no5I/NglyPSHbrg9oazJUEcxeh80FI5gf27/EX8KRP0JPI
	TLYUip6YqN9p7l8GsQbkLVklp+yXTEZwkU6DWcl1+fs1q3XmYJDjPX1rOH7tqdZWzmfw2guJLYQ/Y
	rrtJrMGigi2mNDgYP9YPpT+qort7dyG8op++YDIvSFMqqS86FVyI4ztMClqttYwXST3QG5OEZqKq+
	5Mas83SDztDYNGOTrC0MNkFcOK7dVz04H+tMHp/LaRmivWQspuDpmR960YUpH4BIBpJHlB1a5Wm7S
	mvqtkQ9w==;
Received: from i5e8616cd.versanet.de ([94.134.22.205] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sjFhr-0004M3-PY; Wed, 28 Aug 2024 12:15:15 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: mturquette@baylibre.com,
	sboyd@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-clk@vger.kernel.org,
	heiko@sntech.de,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v3 0/5] Binding and driver for gated-fixed-clocks
Date: Wed, 28 Aug 2024 12:14:58 +0200
Message-ID: <20240828101503.1478491-1-heiko@sntech.de>
X-Mailer: git-send-email 2.43.0
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


With the discussion in v2, gated-fixed-clock was deemed one possible
nice naming, so I did go with that.
Stephen also suggested reusing more of clk-gpio to not re-implement the
gpio handling wrt. sleeping and non-sleeping gpios.

Though instead of exporting masses of structs and ops, gated-fixed-clock
is quite close to the other gpio-clocks, so I've put it into the clk-gpio
file.


changes in v3:
- rename to gated-fixed-clock (Conor)
- move into clk-gpio
- some tiny cleanups to the existing clk-gpio drivers

changes in v2:
- drop the Diodes PLLs for now, to get the first variant right
- rename stuff to voltage-oscillator / clk_vco as suggested by Stephen
- require vdd-supply in the binding
- enable-gpios stays optional, as they often are tied to vdd-supply
- drop deprecated elements that were left in from the fixed clock binding


[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts#n605
[1] https://lore.kernel.org/linux-clk/b3c450a94bcb4ad0bc5b3c7ee8712cb8.sboyd@kernel.org/


Heiko Stuebner (5):
  dt-bindings: clocks: add binding for gated-fixed-clocks
  clk: clk-gpio: update documentation for gpio-gate clock
  clk: clk-gpio: use dev_err_probe for gpio-get failure
  clk: clk-gpio: add driver for gated-fixed-clocks
  arm64: dts: rockchip: fix the pcie refclock oscillator on Rock 5 ITX

 .../bindings/clock/gated-fixed-clock.yaml     |  49 +++++
 .../boot/dts/rockchip/rk3588-rock-5-itx.dts   |  38 +++-
 drivers/clk/clk-gpio.c                        | 202 ++++++++++++++++--
 3 files changed, 273 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/gated-fixed-clock.yaml

-- 
2.43.0


