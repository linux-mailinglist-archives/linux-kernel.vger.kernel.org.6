Return-Path: <linux-kernel+bounces-375700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBC99A998B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0887D2821A4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 06:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C043F136E0E;
	Tue, 22 Oct 2024 06:16:15 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE1F433BB;
	Tue, 22 Oct 2024 06:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729577775; cv=none; b=KN6M9JfrFoTq/beTv0yS9WL4pQHHDERelxrNP+m6mfbzfQQeaEFV0lCrYz37VdQHOWHe7mDVujpsYpN/5nTw9dILCTvtc9BSeMnVmiNoVmhvDJXqsbAYDfK2TrNaQrxSTkBOW5cOpKcY7Q4aA/HsHnCPNl3SIqftyi1kuP0cZ+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729577775; c=relaxed/simple;
	bh=NfFBAv1hhK1xP3yx6rpG2ld2SDjNdXZjzYd/Sz7LtF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kqOYYcSB98239rkA4I/xE73w6gLDtjbLa95VRDu/3/3gqjHBgOFluj+XDAyC3Rbb6byFUQV5vKRG7SHZGzmvS4hhuSXfxboIaDynEBftylHjq4hn5XqSBC4c9gNLe/23lvFtSC8Buv64Qfe5Vm+SlfDM7lJoIPfTcb0mUwXE5G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from hay.lan. (unknown [IPv6:2605:59c8:31de:bf00:6ecf:39ff:fe00:8375])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 19980B2C16B3;
	Tue, 22 Oct 2024 08:10:30 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Henry Bell <dmoo_dv@protonmail.com>
Cc: E Shattow <e@freeshell.de>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: dts: starfive: Update ethernet phy0 delay parameter values for Star64
Date: Mon, 21 Oct 2024 23:09:51 -0700
Message-ID: <20241022061004.62812-1-e@freeshell.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve function of Star64 bottom network port phy0 with updated delay values.
Initial upstream patches supporting Star64 use the same vendor board support
package parameters known to result in an unreliable bottom network port.

Success acquiring DHCP lease and no dropped packets to ping LAN address:
rx  900: tx 1500 1650 1800 1950
rx  750: tx      1650 1800 1950
rx  600: tx           1800 1950
rx 1050: tx      1650 1800 1950
rx 1200: tx 1500 1650 1800 1950
rx 1350: tx 1500 1650 1800 1950
rx 1500: tx 1500 1650 1800 1950
rx 1650: tx 1500 1650 1800 1950
rx 1800: tx 1500 1650 1800 1950
rx 1900: tx                1950
rx 1950: tx                1950

Failure acquiring DHCP lease or many dropped packets:
rx  450: tx                1500      1800 1950
rx  600: tx      1200 1350      1650
rx  750: tx           1350 1500
rx  900: tx      1200 1350
rx 1050: tx 1050 1200 1350 1500
rx 1200: tx           1350
rx 1350: tx           1350
rx 1500: tx      1200 1350
rx 1650: tx 1050 1200 1350
rx 1800: tx 1050 1200 1350
rx 1900: tx                1500 1650 1800
rx 1950: tx      1200 1350

Non-functional:
rx    0: tx 0  150  300  450  600  750  900 1050 1200 1350 1500 1650 1800 1950
rx  150: tx 0  150  300  450  600  750  900 1050 1200 1350 1500 1650 1800 1950
rx  300: tx 0  150  300  450  600  750  900 1050 1200 1350 1500 1650 1800 1950
rx  450: tx 0  150  300  450  600  750  900 1050 1200 1350      1650
rx  600: tx 0  150  300  450  600  750  900 1050
rx  750: tx 0  150  300  450  600  750  900 1050 1200
rx  900: tx 0  150  300  450  600  750  900 1050
rx 1050: tx 0  150  300  450  600  750  900
rx 1200: tx 0  150  300  450  600  750  900 1050 1200
rx 1350: tx 0  150  300  450  600  750  900 1050 1200
rx 1500: tx 0  150  300  450  600  750  900 1050
rx 1650: tx 0  150  300  450  600  750  900
rx 1800: tx 0  150  300  450  600  750  900
rx 1900: tx 0  150  300  450  600  750  900 1050 1200 1350
rx 1950: tx 0  150  300  450  600  750  900 1050

Selecting the median of all working rx delay values 1500 combined with tx delay
values 1500, 1650, 1800, and 1950 only the tx delay value of 1950 (default) is
reliable as tested in both Linux 6.11.2 and U-Boot v2024.10

Signed-off-by: E Shattow <e@freeshell.de>
---
 arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
index b720cdd15ed6..8e39fdc73ecb 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
+++ b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
@@ -44,8 +44,7 @@ &pcie1 {
 };
 
 &phy0 {
-	rx-internal-delay-ps = <1900>;
-	tx-internal-delay-ps = <1500>;
+	rx-internal-delay-ps = <1500>;
 	motorcomm,rx-clk-drv-microamp = <2910>;
 	motorcomm,rx-data-drv-microamp = <2910>;
 	motorcomm,tx-clk-adj-enabled;
-- 
2.45.2


