Return-Path: <linux-kernel+bounces-318438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 447B096EDE0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA17BB2779D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3581015990C;
	Fri,  6 Sep 2024 08:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Rs4+nzZu"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DDA15821E;
	Fri,  6 Sep 2024 08:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725611124; cv=none; b=dhl2nN5MMLchQut2F5nvqXA2u8+9UC5299HQ1H26bq+mYm6D6y4KP4OCKr4+m4PUNHK1AEZ3UVPKswk0NG2wbFVuDfh7FOr3fnCRwg/gk8Dx8H/h9JhwEVxbusWewgTp1g0Hh21+qwJjx/JrskScvn7s6D8JQdiWsyDN+dFNkq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725611124; c=relaxed/simple;
	bh=kPYfGr82crZFwSXbV9Yrzd5rE1nyn6IPSCCfxB5SxAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NqvSe8UnqMV/xRSSgrDZIZyRedD1lzZ/PfDwuCBCv5vuz9hg6lSuhR2PkxazPBAJAPdNUBLCFoYrNLKPARiZCKaIni7Ns1w3EveJUyymRrsJWRcBT4pIiO3y3gW3w/6cALMiY+eUoK6fkJFD8tj0sZKNKVrEQP/3tjylvQounDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Rs4+nzZu; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SMWPR0ffevZU4QK7TroW0Y57HczgmsnN8JBHEkqCR00=; b=Rs4+nzZuZgai96tBrFYnaQUHm+
	QEAfCB7oyRDM5UnJr7n/54ieR+1A0JEJHG/CRU71VtPuI9d7p0NNqzrPC+XUsHoeOVjGJkdwV4AgD
	VboucS9wfUQZlBKMyLObCh5vzSKyDxEQP45fhv19NgEVSIGSTruG5UfXt4tBvn8DzLUAwGfr8hFZp
	PGq4y9PupEmtUCqARILf0IERQzAWWQob9Q5JJ9R6v3/t7Qqz7GJJ1NhCIOwSDBKm0QrsmnFLRj6u9
	10XgbasRwClRBv88bz8VYAmRtLelKj1bla0kMG7XjDBlz4RlTxtKG2XoaosKFsm/YcnDqCUTw1JYn
	OmLEnVbQ==;
Received: from i5e860d0f.versanet.de ([94.134.13.15] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1smUHO-0000jF-87; Fri, 06 Sep 2024 10:25:18 +0200
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
Subject: [PATCH v4 0/5] Binding and driver for gated-fixed-clocks
Date: Fri,  6 Sep 2024 10:25:06 +0200
Message-ID: <20240906082511.2963890-1-heiko@sntech.de>
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

changes in v4:
- fix example node-name in binding (Rob)
- add Rob's and Conor's Reviewed-by
- which -> with in patch 2 message (Diederik)
- store rate as unsigned long (with a temporary u32 to make
  of_property_read_u32 happy) (Stephen)
- add static to struct clk_ops (Stephen)
- match table sentinel (Stephen)
- some formatting (Stephen)

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
 drivers/clk/clk-gpio.c                        | 206 ++++++++++++++++--
 3 files changed, 277 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/gated-fixed-clock.yaml

-- 
2.43.0


