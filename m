Return-Path: <linux-kernel+bounces-173434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F338C0060
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE3928BE74
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F2C12AADC;
	Wed,  8 May 2024 14:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="n4v9oMXI"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CDE126F05;
	Wed,  8 May 2024 14:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715179416; cv=none; b=RaYkQMQqKtJRbup4F+OxM4tsREq1y1biIVFNkO9ormhS1C/qz3dJaOCQl/Wxi1Ee1IbCELDIjvR4CaX3KPhaxNlKjRjm8pOoACm3kiqJhVR8SsDHW8/mUdceqnQYOWMl7ch+bPDhGYQztRTY9yALDDB2y1T7KgnbkE70v+9+Zkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715179416; c=relaxed/simple;
	bh=sdVj+zO8H4B/fvjouDoi7Nhc5dIxJ2GTTWp+LPjaQAA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CpcbX3sYbS4nuQkakOwopgDY18mreEjTq8Z7B9zGrSywovUPD5K40j1QVqDtgbrbplbG+gRgHkUhqbCyGiEm9xrXDzy74MPBy4ue6kqprRFxhl0eNHTsAUWLA8vbzotEJ0fOUKrRI6lBdHYBTDK4GURuwAQdkZul8QsIhO9mkfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=n4v9oMXI; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 14952100003;
	Wed,  8 May 2024 17:43:31 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 14952100003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1715179411;
	bh=93FmlCSWH+YO/nmTOmSVLAybLAxTDRjCOeQkxoXUEKA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=n4v9oMXI2cws0zW/bqF3Ci9N4/SH+JI1DfZeQfKJS82ftPNthf4fjNmgswCrACF7U
	 toRMtV5pcfqNWBSro4FwL0o0Q4eKhSnxSwdphLR9H5VftPJCmsxm0GIVjcYF0NdKeo
	 zgD5Lvxl4nXWlEg6K0qKtrBonq+eR33uaxo2ZOxDf3C5dxuCDYZVTcZovUb82965Ab
	 yJnSSmgFJ8EK+Vq8C5vQIAnvACJkqZGEhVPBNL7VdnXbImvS6vRG+C/QOIWTpnp7St
	 bGIpEaUakxHLAv8gh1t+TJRjWr+sxuMTdimzfcfj1sJK80iyLdHWYIemCCV5j2UUb1
	 ZkgyHkrVV3/rA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed,  8 May 2024 17:43:30 +0300 (MSK)
Received: from CAB-WSD-0003115.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 8 May 2024 17:43:30 +0300
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Conor Dooley
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>, Jerome Brunet
	<jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>, Michael Turquette
	<mturquette@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>, Rob
 Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Subject: [APPROACH 1 1/1] dt-bindings: clock: meson: Convert axg-audio-clkc to YAML format
Date: Wed, 8 May 2024 17:42:57 +0300
Message-ID: <20240508144259.191843-2-jan.dakinevich@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508144259.191843-1-jan.dakinevich@salutedevices.com>
References: <20240508144259.191843-1-jan.dakinevich@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185143 [May 08 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 19 0.3.19 07c7fa124d1a1dc9662cdc5aace418c06ae99d2b, {Tracking_smtp_not_equal_from}, {Tracking_uf_ne_domains}, smtp.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;devicetree.org:7.1.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1;sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/05/08 13:27:00
X-KSMG-LinksScanning: Clean, bases: 2024/05/08 13:27:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/08 09:52:00 #25122865
X-KSMG-AntiVirus-Status: Clean, skipped

From: Alexander Stein <alexander.stein@mailbox.org>

Convert Amlogic AXG Audio Clock Controller binding to yaml.

Signed-off-by: Alexander Stein <alexander.stein@mailbox.org>
Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
---
 .../bindings/clock/amlogic,axg-audio-clkc.txt |  59 ---------
 .../clock/amlogic,axg-audio-clkc.yaml         | 115 ++++++++++++++++++
 2 files changed, 115 insertions(+), 59 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml

diff --git a/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt
deleted file mode 100644
index 3a8948c04bc9..000000000000
--- a/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt
+++ /dev/null
@@ -1,59 +0,0 @@
-* Amlogic AXG Audio Clock Controllers
-
-The Amlogic AXG audio clock controller generates and supplies clock to the
-other elements of the audio subsystem, such as fifos, i2s, spdif and pdm
-devices.
-
-Required Properties:
-
-- compatible	: should be "amlogic,axg-audio-clkc" for the A113X and A113D,
-		  "amlogic,g12a-audio-clkc" for G12A,
-		  "amlogic,sm1-audio-clkc" for S905X3.
-- reg		: physical base address of the clock controller and length of
-		  memory mapped region.
-- clocks	: a list of phandle + clock-specifier pairs for the clocks listed
-		  in clock-names.
-- clock-names	: must contain the following:
-		  * "pclk" - Main peripheral bus clock
-		  may contain the following:
-		  * "mst_in[0-7]" - 8 input plls to generate clock signals
-		  * "slv_sclk[0-9]" - 10 slave bit clocks provided by external
-				      components.
-		  * "slv_lrclk[0-9]" - 10 slave sample clocks provided by external
-				       components.
-- resets	: phandle of the internal reset line
-- #clock-cells	: should be 1.
-- #reset-cells  : should be 1 on the g12a (and following) soc family
-
-Each clock is assigned an identifier and client nodes can use this identifier
-to specify the clock which they consume. All available clocks are defined as
-preprocessor macros in the dt-bindings/clock/axg-audio-clkc.h header and can be
-used in device tree sources.
-
-Example:
-
-clkc_audio: clock-controller@0 {
-	compatible = "amlogic,axg-audio-clkc";
-	reg = <0x0 0x0 0x0 0xb4>;
-	#clock-cells = <1>;
-
-	clocks = <&clkc CLKID_AUDIO>,
-		 <&clkc CLKID_MPLL0>,
-		 <&clkc CLKID_MPLL1>,
-		 <&clkc CLKID_MPLL2>,
-		 <&clkc CLKID_MPLL3>,
-		 <&clkc CLKID_HIFI_PLL>,
-		 <&clkc CLKID_FCLK_DIV3>,
-		 <&clkc CLKID_FCLK_DIV4>,
-		 <&clkc CLKID_GP0_PLL>;
-	clock-names = "pclk",
-		      "mst_in0",
-		      "mst_in1",
-		      "mst_in2",
-		      "mst_in3",
-		      "mst_in4",
-		      "mst_in5",
-		      "mst_in6",
-		      "mst_in7";
-	resets = <&reset RESET_AUDIO>;
-};
diff --git a/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml
new file mode 100644
index 000000000000..b683896e950a
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml
@@ -0,0 +1,115 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic AXG Audio Clock Controller
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+  - Jerome Brunet <jbrunet@baylibre.com>
+
+description:
+  The Amlogic AXG audio clock controller generates and supplies clock to the
+  other elements of the audio subsystem, such as fifos, i2s, spdif and pdm
+  devices.
+
+properties:
+  compatible:
+    enum:
+      - amlogic,axg-audio-clkc
+      - amlogic,g12a-audio-clkc
+      - amlogic,sm1-audio-clkc
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 28
+    items:
+      - description: main peripheral bus clock
+    additionalItems:
+      oneOf:
+        - description: mst_in[0-7] - input plls to generate clock signals
+        - description: slv_sclk[0-9] - slave bit clocks provided by external components
+        - description: slv_lrclk[0-9]- slave sample clocks provided by external components
+
+  clock-names:
+    maxItems: 28
+    items:
+      - const: pclk
+    additionalItems:
+      oneOf:
+        - pattern: "^mst_in[0-7]$"
+        - pattern: "^slv_sclk[0-9]$"
+        - pattern: "^slv_lrclk[0-9]$"
+
+  resets:
+    description: internal reset line
+
+required:
+  - compatible
+  - '#clock-cells'
+  - reg
+  - clocks
+  - clock-names
+  - resets
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amlogic,g12a-audio-clkc
+              - amlogic,sm1-audio-clkc
+    then:
+      required:
+        - '#reset-cells'
+    else:
+      properties:
+        '#reset-cells': false
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/axg-clkc.h>
+    #include <dt-bindings/reset/amlogic,meson-axg-reset.h>
+    apb {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        clkc_audio: clock-controller@0 {
+            compatible = "amlogic,axg-audio-clkc";
+            reg = <0x0 0x0 0x0 0xb4>;
+            #clock-cells = <1>;
+
+            clocks = <&clkc CLKID_AUDIO>,
+                     <&clkc CLKID_MPLL0>,
+                     <&clkc CLKID_MPLL1>,
+                     <&clkc CLKID_MPLL2>,
+                     <&clkc CLKID_MPLL3>,
+                     <&clkc CLKID_HIFI_PLL>,
+                     <&clkc CLKID_FCLK_DIV3>,
+                     <&clkc CLKID_FCLK_DIV4>,
+                     <&clkc CLKID_GP0_PLL>;
+            clock-names = "pclk",
+                          "mst_in0",
+                          "mst_in1",
+                          "mst_in2",
+                          "mst_in3",
+                          "mst_in4",
+                          "mst_in5",
+                          "mst_in6",
+                          "mst_in7";
+            resets = <&reset RESET_AUDIO>;
+        };
+    };
-- 
2.34.1


