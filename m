Return-Path: <linux-kernel+bounces-571729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9F7A6C15A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DCDB189E3E2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADBB22FE13;
	Fri, 21 Mar 2025 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mo0eTwd4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E10322FE02;
	Fri, 21 Mar 2025 17:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577811; cv=none; b=GZKSjcntM83v2vec99GcDW6s+yY/e5uuBUzDk/7vdtfDA6VJC9LdH5hm73Qi0c4K/AscDfIRs2DrfBJy/a3YJat1Mtds0JgweHOqX51VnWOdwGonLac6JpkjhdsKwD5FU7X2fqgW8QTXShROJca+j93wfjnJ4fNwEIgEKmaRL34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577811; c=relaxed/simple;
	bh=NRPZVMg8q8Glkkek+MZ6GcEzInHhK6SX1BhDs6BGtW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kC4IONeKCBhugMpVHpWIlJuRMA8cP8IRLr/JygVRf+aPQqpTwfs1ADx4xRihh5qb8Z/aT/1m6ktMLurSjer20d9gtITMl87KBmPAzWqnuBYjxYV880WF16qcv7NWWc6D/GDwTt3ROBrICcaB0UwpUC3GGnjvEReBjviqxA8OjFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mo0eTwd4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72855C4CEE8;
	Fri, 21 Mar 2025 17:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742577810;
	bh=NRPZVMg8q8Glkkek+MZ6GcEzInHhK6SX1BhDs6BGtW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mo0eTwd46VQIln6hxjk3OQXTODpg3IEBL3QgxORx7opDBGbPqm3zC6Tb3yZAnFUg/
	 ZfpHYuSCjNlR/W/PK9ES7Ynnp/fwBiD876cWYfGvFV8z+wz0pSjQLZrmskSN8zl8nu
	 SGkrln0yZmXOtbMigQ1XaPHtnJ9lu3DMf5iOsnilfEIupaiALC7p6GfmwHuCiY4/VV
	 jOrn/icFy1wII4u601qNyFYII4LpKDB0B6jQvmMEYxyV8Q6pPWYB5tAIZDn4nWAuq+
	 xNvTtgEyb5E8w7Bjx3I1sMSwH1U8lM/HQr7VBcq51yMidT0Lt+XasT+1z5cbkHc5Wr
	 7FNOFHo/EvjpQ==
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
Subject: [RFC PATCH v2 5/9] dt-bindings: clk: microchip: mpfs: remove first reg region
Date: Fri, 21 Mar 2025 17:22:38 +0000
Message-ID: <20250321-majesty-overhung-1441f3858efc@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250321-cuddly-hazily-d0ab1e1747b5@spud>
References: <20250321-cuddly-hazily-d0ab1e1747b5@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3159; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=PXlK/3bLOMNEyxgWeBhvy5NgnPZBRf51ELypfcFIriA=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOl3F0TN8Nev1tRQ3O5wNHDiGTafNYdszRYKFQkzbSqa7 86i/bamo5SFQYyDQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABMxnsbIcGvGSY3l/1sn205d XNi/J3Vbt0qJefYOuV1tSrn/ZsT/NmH4pxWYLs7NPm9FRlOFnPfyV3Ilm5SSbM9Lf5/lfO+F1oG 9TAA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

The first reg region in this binding is not exclusively for clocks, as
evidenced by the dual role of this device as a reset controller at
present. The first region is however better described by a simple-mfd
syscon, but this would have require a significant re-write of the
devicetree for the platform, so the easy way out was chosen when reset
support was first introduced. The region doesn't just contain clock and
reset registers, it also contains pinctrl and interrupt controller
functionality, so drop the region from the clock binding so that it can
be described instead by a simple-mfd syscon rather than propagate this
incorrect description of the hardware to the new pic64gx SoC.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/clock/microchip,mpfs-clkcfg.yaml | 36 +++++++++++--------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/microchip,mpfs-clkcfg.yaml b/Documentation/devicetree/bindings/clock/microchip,mpfs-clkcfg.yaml
index e4e1c31267d2..ee4f31596d97 100644
--- a/Documentation/devicetree/bindings/clock/microchip,mpfs-clkcfg.yaml
+++ b/Documentation/devicetree/bindings/clock/microchip,mpfs-clkcfg.yaml
@@ -22,16 +22,23 @@ properties:
     const: microchip,mpfs-clkcfg
 
   reg:
-    items:
-      - description: |
-          clock config registers:
-          These registers contain enable, reset & divider tables for the, cpu,
-          axi, ahb and rtc/mtimer reference clocks as well as enable and reset
-          for the peripheral clocks.
-      - description: |
-          mss pll dri registers:
-          Block of registers responsible for dynamic reconfiguration of the mss
-          pll
+    oneOf:
+      - items:
+          - description: |
+              clock config registers:
+              These registers contain enable, reset & divider tables for the, cpu,
+              axi, ahb and rtc/mtimer reference clocks as well as enable and reset
+              for the peripheral clocks.
+          - description: |
+              mss pll dri registers:
+              Block of registers responsible for dynamic reconfiguration of the mss
+              pll
+        deprecated: true
+      - items:
+          - description: |
+              mss pll dri registers:
+              Block of registers responsible for dynamic reconfiguration of the mss
+              pll
 
   clocks:
     maxItems: 1
@@ -69,11 +76,12 @@ examples:
   - |
     #include <dt-bindings/clock/microchip,mpfs-clock.h>
     soc {
-            #address-cells = <2>;
-            #size-cells = <2>;
-            clkcfg: clock-controller@20002000 {
+            #address-cells = <1>;
+            #size-cells = <1>;
+
+            clkcfg: clock-controller@3E001000 {
                 compatible = "microchip,mpfs-clkcfg";
-                reg = <0x0 0x20002000 0x0 0x1000>, <0x0 0x3E001000 0x0 0x1000>;
+                reg = <0x3E001000 0x1000>;
                 clocks = <&ref>;
                 #clock-cells = <1>;
         };
-- 
2.45.2


