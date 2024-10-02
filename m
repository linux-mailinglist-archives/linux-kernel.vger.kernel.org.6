Return-Path: <linux-kernel+bounces-347360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A0498D1A8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C3E41F220A2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74007205E04;
	Wed,  2 Oct 2024 10:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3OYByTY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89FC1EC005;
	Wed,  2 Oct 2024 10:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866125; cv=none; b=VMERlaQ79AKVcuOFXeXkKB96R/YVBuL1k713GMuZMPf1n4thtv59kn5rTHKwZM9Wlxa/l3zigRiVprPWggrzo+dKE6YixkvlzvEui0X8zt5DJE9zoRs0hKuD/2HEHjyvZbDEbXYBecvqBiY+3B56cgRpWr0WY4KdpdDj9DKndl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866125; c=relaxed/simple;
	bh=OO6xrEZafxMp0b36XkiEjc5EYx9OU0Q2uYuiCSv6Bso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkwKwvJ0KUzTWKjLC0dmvRDYslIjd2IBeLma0Yh3w7wBqhqcTixZ6vckM3j40qMGperVnpxNZWw24jDBNTl4AOCj9g7JX7N1Few4rKzE1zVdreQwHY8e9vxuZ+iYBGm3qusRg0eycJTWk66YiCis1/OgyVu6FiZKN1QpL6Ui0Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3OYByTY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D35C4CEC5;
	Wed,  2 Oct 2024 10:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727866125;
	bh=OO6xrEZafxMp0b36XkiEjc5EYx9OU0Q2uYuiCSv6Bso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y3OYByTYNpeaweqY/uQo1qtt3imPJqkjeT1vrakSOBDnNQLT/jEcuii0gSq5E2RLc
	 xs2kIY++mflSWoyWTNGvVRLs0IVHchAKEMe4SrDR0oUTW+4zX/D7QijdMJQ0Q1ujjH
	 OdS/Sb7oEiRq2Z8Zxs5HL3fvJvBVD1A3cxPahAsNRUtKnUM1S1olSXeZsqv/2op/Vs
	 kY6+TCXv9jX59XNQbT3FnGhEWKWieqvbEFQrmUgy05H450DmU/W3uWCAacnqZWJQO+
	 nwCjNARtdbDZi6xxntkf8LPjDbyCvHGnYn+OrAKlfIb4VtPZ7HpoiMQsm6ZlXfW/m4
	 Uq6aitmrzDvGw==
From: Conor Dooley <conor@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 07/11] dt-bindings: clk: microchip: mpfs: remove first reg region
Date: Wed,  2 Oct 2024 11:48:05 +0100
Message-ID: <20241002-alarm-drop-down-e37c31e50a48@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241002-private-unequal-33cfa6101338@spud>
References: <20241002-private-unequal-33cfa6101338@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3114; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=kST0+2tXhuKzMDOPomFGGrXe4L7ZWEEe3gXv+x0OOeE=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGl/VR6Wt12Ydeai+CKLbVtPx9pPuv5iTbpzIZ+P1slN1 RwRLDv/dpSyMIhxMMiKKbIk3u5rkVr/x2WHc89bmDmsTCBDGLg4BWAigqsZGe7tOFrA8qh5p8KJ T4m/jBYUd59NnfbRes3F4lm2FRFnC24x/E9tcxaatEbS8bqBJFPxzCTmL1c+1VizrGZfv+mjypw LV1kA
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

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/clock/microchip,mpfs-clkcfg.yaml | 36 +++++++++++--------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/microchip,mpfs-clkcfg.yaml b/Documentation/devicetree/bindings/clock/microchip,mpfs-clkcfg.yaml
index e4e1c31267d2a..ee4f31596d978 100644
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


