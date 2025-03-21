Return-Path: <linux-kernel+bounces-571731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B856BA6C155
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75E7117F584
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2470230996;
	Fri, 21 Mar 2025 17:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcNl2pnJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D84230268;
	Fri, 21 Mar 2025 17:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577818; cv=none; b=fXW3JXven7qkUVWIPWQZV+IaSBFqz03Mo5NAlxTsECSUOPllUQmuHfTapLo6/8HeTtWmNJUuYA1L6vHpuaBBvNv6QjydoS5adtv3HwMA7BMGuYD0iVNYDJYmHfyzEjnWS22JaO+fZ8ozBPtkPvlemPhkocdhJYNGWDGiTVCGYbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577818; c=relaxed/simple;
	bh=f9XLsCJlmlDSiEFANz3UPnWGwYytvFNhw2FHQbcHCQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l8jsbu2oE2mASHL6sHnSjn/DOMz18OTRDrKcnkFmjDDWPtSrK9f5A1NwgM3wte9c/31Id/RD+G6D6A3smcztkK0Q3HISxNxtrV6u6+/84NrVy7dtPUhH7y24TIGGFPFPOEeUhUQcP7MsMEDU3xaTwTXj7cF5QHHRhHFmuI0sacQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcNl2pnJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7035C4CEE3;
	Fri, 21 Mar 2025 17:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742577818;
	bh=f9XLsCJlmlDSiEFANz3UPnWGwYytvFNhw2FHQbcHCQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fcNl2pnJFseTpGGz8bNi+X09lJGJ018ul/XCE0i9VPfT+BJkow0gI/DnF8Cp3iZhE
	 c5Mq+uqRELR26G6UPozuYiCMGL+GMkrPS8qH8Uv4w+nc8K0FfrfTeX85r8nrmdoVln
	 pRg59vZqqSbGjhuBcO+tL7yeugwlS4meAcAXLSNgEuyWQ/Mag3iCCDs27MYrVFt74I
	 GF4Wn716zkHFPiNrvCC/9MrmCqI3mEhfIPpFpBIMsWxe7p8d9AoJ1xC/KvRvq0Mdsm
	 Z4xXPNCOcxV3zcug2rTXKvHyKBSr+H4sKI4VJJVu75hR01AjQy2ubSyWs3HhEkpFoC
	 ejYFl/WGW8LAg==
From: Conor Dooley <conor@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 7/9] riscv: dts: microchip: convert clock and reset to use syscon
Date: Fri, 21 Mar 2025 17:22:40 +0000
Message-ID: <20250321-ferocious-projector-c22da63afe21@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250321-cuddly-hazily-d0ab1e1747b5@spud>
References: <20250321-cuddly-hazily-d0ab1e1747b5@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2216; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=PM6cFJ1IerUUu+VkUFTnmY9mCANBqD5NBbof7moNREM=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOl3F0RxeG3fdmDV7h1xD54pqrBb62+MMS1gqzhqyf61Q UZD7/W6jlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAExklRUjw72/Ru42Spwftcqr I93mSwoG2oeYPqpZNOf1wXkcPwpblBn+eyU87lnw4Ifaj8eHdm+1/lWvoj55tonwM+NJ+R5NWxY YMwIA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

The "subblock" clocks and reset registers on PolarFire SoC are located
in the mss-top-sysreg region, alongside pinctrl and interrupt control
functionality. Re-write the devicetree to describe the sys explicitly,
as its own node, rather than as a region of the clock node.
Correspondingly, the phandles to the reset controller must be updated to
the new provider. The drivers will continue to support the old way of
doing things.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/microchip/mpfs.dtsi | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs.dtsi b/arch/riscv/boot/dts/microchip/mpfs.dtsi
index f9d6bf08e717..5c2963e269b8 100644
--- a/arch/riscv/boot/dts/microchip/mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs.dtsi
@@ -251,11 +251,9 @@ pdma: dma-controller@3000000 {
 			#dma-cells = <1>;
 		};
 
-		clkcfg: clkcfg@20002000 {
-			compatible = "microchip,mpfs-clkcfg";
-			reg = <0x0 0x20002000 0x0 0x1000>, <0x0 0x3E001000 0x0 0x1000>;
-			clocks = <&refclk>;
-			#clock-cells = <1>;
+		mss_top_sysreg: syscon@20002000 {
+			compatible = "microchip,mpfs-mss-top-sysreg", "syscon", "simple-mfd";
+			reg = <0x0 0x20002000 0x0 0x1000>;
 			#reset-cells = <1>;
 		};
 
@@ -452,7 +450,7 @@ mac0: ethernet@20110000 {
 			local-mac-address = [00 00 00 00 00 00];
 			clocks = <&clkcfg CLK_MAC0>, <&clkcfg CLK_AHB>;
 			clock-names = "pclk", "hclk";
-			resets = <&clkcfg CLK_MAC0>;
+			resets = <&mss_top_sysreg CLK_MAC0>;
 			status = "disabled";
 		};
 
@@ -466,7 +464,7 @@ mac1: ethernet@20112000 {
 			local-mac-address = [00 00 00 00 00 00];
 			clocks = <&clkcfg CLK_MAC1>, <&clkcfg CLK_AHB>;
 			clock-names = "pclk", "hclk";
-			resets = <&clkcfg CLK_MAC1>;
+			resets = <&mss_top_sysreg CLK_MAC1>;
 			status = "disabled";
 		};
 
@@ -550,5 +548,12 @@ syscontroller_qspi: spi@37020100 {
 			clocks = <&scbclk>;
 			status = "disabled";
 		};
+
+		clkcfg: clkcfg@3e001000 {
+			compatible = "microchip,mpfs-clkcfg";
+			reg = <0x0 0x3e001000 0x0 0x1000>;
+			clocks = <&refclk>;
+			#clock-cells = <1>;
+		};
 	};
 };
-- 
2.45.2


