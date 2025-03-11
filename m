Return-Path: <linux-kernel+bounces-556664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC65AA5CD19
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D8223B8C85
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4051262D18;
	Tue, 11 Mar 2025 18:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="Y7aVSKvC"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A35260A32;
	Tue, 11 Mar 2025 18:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741716164; cv=none; b=E3vNxAW9EH/j5gZAiRX0rW9TUBYssSo2aQS3ZzLaIvfkGr+MuS1CQscSl1UWkeJIt0SszcqDXlyxsdMFtvK9tJLXRdp7sUhT+61ulD7Exo8OPv+gQYv/gf16DvH6jUKtq/vYUK6krRX3/bnUrhcXNedX4SoCv2twHlSu0hSCjoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741716164; c=relaxed/simple;
	bh=cJJ60I0voD1FU/MBcN/l1RUYb420JRiuQNZp6VwoIRw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Dce4SfwKg1Ffm1bx/cuySC1MuZElolWEXzAyyg7ge6oWLYUgHBofMxWcY4HG0Vf4jhF3xuLacE8y+AARQ+llLn138mff4lf92Kz4iiGaRasH0vHYy9z7e2CQdudXXzLspWQLKtGFrpDYLHAqCJlPhnQaFvY7UGHj3cb6ekg50tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=Y7aVSKvC; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=sfOzXF32SVgBzw0bop+7o2FnHha6RNF67mlrgAvS+p0=; b=Y7aVSKvCLCiDDigNnsoRSbI2F/
	Id9YZtVfW86h3pv411HtwRrhGQ2AXkz3XtB2Nn9pygSPDm7xYhxaCSQamdwzB4WJLhFMUlMH8WOnY
	THKqurYoyiHy8q1DCp+GqdiuJ9717FpsQLHg2wCSrqN/2Ow+TDOgvyMftSjnxDjQQhy1erj30WFMX
	ONwDdyTwFTW/RTXSb/XYmxo45TLxVuh0tUgGnn6jYrm5Pyuwl/xdUjB+eZ6tJkydTrBTbYdQACbjd
	8HjJ2fTvEQrZCYxLpBmJQsOVbe01e8bg8wNmNAJNo28gBhdUK5EKHJwy0/6QoteGfNX+gWTNtu0D6
	wZ0gt7Pg==;
From: Andreas Kemnade <andreas@kemnade.info>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	tony@atomide.com,
	andreas@kemnade.info,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: clock: ti: Convert ti-clkctrl.txt to json-schema
Date: Tue, 11 Mar 2025 19:02:15 +0100
Message-Id: <20250311180215.173634-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the TI clkctrl clock device tree binding to json-schema.
Specify the creator of the original binding as a maintainer.

reg property is used mostly with one item, in am3xxx also with
an arbitrary number of items, so divert from the original binding
specifying two (probably meaning one address and one size).
The consumer part of the example is left out because the full consumer
node would be needed.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Changes in V2:
- additional maintainer
- remove txt binding
- dual licensing

 .../devicetree/bindings/clock/ti,clkctrl.yaml | 65 +++++++++++++++++++
 .../devicetree/bindings/clock/ti-clkctrl.txt  | 63 ------------------
 2 files changed, 65 insertions(+), 63 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/ti,clkctrl.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/ti-clkctrl.txt

diff --git a/Documentation/devicetree/bindings/clock/ti,clkctrl.yaml b/Documentation/devicetree/bindings/clock/ti,clkctrl.yaml
new file mode 100644
index 0000000000000..49787550ce450
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ti,clkctrl.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/ti,clkctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments clkctrl clock
+
+maintainers:
+  - Tony Lindgren <tony@atomide.com>
+  - Andreas Kemnade <andreas@kemnade.info>
+
+description: |
+  Texas Instruments SoCs can have a clkctrl clock controller for each
+  interconnect target module. The clkctrl clock controller manages functional
+  and interface clocks for each module. Each clkctrl controller can also
+  gate one or more optional functional clocks for a module, and can have one
+  or more clock muxes. There is a clkctrl clock controller typically for each
+  interconnect target module on omap4 and later variants.
+
+  The clock consumers can specify the index of the clkctrl clock using
+  the hardware offset from the clkctrl instance register space. The optional
+  clocks can be specified by clkctrl hardware offset and the index of the
+  optional clock.
+
+properties:
+  compatible:
+    enum:
+      - ti,clkctrl
+      - ti,clkctrl-l4-cfg
+      - ti,clkctrl-l4-per
+      - ti,clkctrl-l4-secure
+      - ti,clkctrl-l4-wkup
+
+  "#clock-cells":
+    const: 2
+
+  clock-output-names:
+    maxItems: 1
+
+  reg:
+    minItems: 1
+    maxItems: 8 # arbitrary, should be enough
+
+required:
+  - compatible
+  - "#clock-cells"
+  - clock-output-names
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    bus {
+      #address-cells = <1>;
+      #size-cells = <1>;
+
+      clock@20 {
+        compatible = "ti,clkctrl";
+        clock-output-names = "l4_per";
+        reg = <0x20 0x1b0>;
+        #clock-cells = <2>;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/clock/ti-clkctrl.txt b/Documentation/devicetree/bindings/clock/ti-clkctrl.txt
deleted file mode 100644
index d20db7974a383..0000000000000
--- a/Documentation/devicetree/bindings/clock/ti-clkctrl.txt
+++ /dev/null
@@ -1,63 +0,0 @@
-Texas Instruments clkctrl clock binding
-
-Texas Instruments SoCs can have a clkctrl clock controller for each
-interconnect target module. The clkctrl clock controller manages functional
-and interface clocks for each module. Each clkctrl controller can also
-gate one or more optional functional clocks for a module, and can have one
-or more clock muxes. There is a clkctrl clock controller typically for each
-interconnect target module on omap4 and later variants.
-
-The clock consumers can specify the index of the clkctrl clock using
-the hardware offset from the clkctrl instance register space. The optional
-clocks can be specified by clkctrl hardware offset and the index of the
-optional clock.
-
-For more information, please see the Linux clock framework binding at
-Documentation/devicetree/bindings/clock/clock-bindings.txt.
-
-Required properties :
-- compatible : shall be "ti,clkctrl" or a clock domain specific name:
-	       "ti,clkctrl-l4-cfg"
-	       "ti,clkctrl-l4-per"
-	       "ti,clkctrl-l4-secure"
-	       "ti,clkctrl-l4-wkup"
-- clock-output-names : from common clock binding
-- #clock-cells : shall contain 2 with the first entry being the instance
-		 offset from the clock domain base and the second being the
-		 clock index
-- reg : clock registers
-
-Example: Clock controller node on omap 4430:
-
-&cm2 {
-	l4per: cm@1400 {
-		cm_l4per@0 {
-			cm_l4per_clkctrl: clock@20 {
-				compatible = "ti,clkctrl";
-				clock-output-names = "l4_per";
-				reg = <0x20 0x1b0>;
-				#clock-cells = <2>;
-			};
-		};
-	};
-};
-
-Example: Preprocessor helper macros in dt-bindings/clock/ti-clkctrl.h
-
-#define OMAP4_CLKCTRL_OFFSET		0x20
-#define OMAP4_CLKCTRL_INDEX(offset)	((offset) - OMAP4_CLKCTRL_OFFSET)
-#define MODULEMODE_HWCTRL		1
-#define MODULEMODE_SWCTRL		2
-
-#define OMAP4_GPTIMER10_CLKTRL		OMAP4_CLKCTRL_INDEX(0x28)
-#define OMAP4_GPTIMER11_CLKTRL		OMAP4_CLKCTRL_INDEX(0x30)
-#define OMAP4_GPTIMER2_CLKTRL		OMAP4_CLKCTRL_INDEX(0x38)
-...
-#define OMAP4_GPIO2_CLKCTRL		OMAP_CLKCTRL_INDEX(0x60)
-
-Example: Clock consumer node for GPIO2:
-
-&gpio2 {
-       clocks = <&cm_l4per_clkctrl OMAP4_GPIO2_CLKCTRL 0
-		 &cm_l4per_clkctrl OMAP4_GPIO2_CLKCTRL 8>;
-};
-- 
2.39.5


