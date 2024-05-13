Return-Path: <linux-kernel+bounces-178151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A68F8C49BA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 00:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE0351C21CEB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 22:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7017E84DF3;
	Mon, 13 May 2024 22:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="kHLkwhFu"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83602AF09;
	Mon, 13 May 2024 22:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715640412; cv=none; b=Gm7sPEYP68q2Lm/MDoZ0vfMKpusUd7PlEDD22fhdROEsdpiYusToIk+9orKiNajmlSluo/z3K6bq5u9VPIRF/QM7SchiL6FtEdnoe8bM4VQX/jmX7SKxVmXBRclX7CCIDZZZfk/aHNJX9Ye7DtWSYy0NWUcrP8oqI6DAgeDiVpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715640412; c=relaxed/simple;
	bh=y8FOmJu3tWA29CYfyy+y+pXIeU/7gF8sl1aFPPGxY/k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZMEi4I0WND9AFqFg44WIjChxujst53kC6dv64b4T+KQf3aLDhqjh/nQnNtr2fJQ8W7AzuEARw+02GSdQ5t6PeizQpf8TYop9igrf2RH0EkUOnW/3opqf+xcHux8GRXba3634eEk8oY7oyuOoSp+/sB1HLKfHSLoU4F7n0gLw3DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=kHLkwhFu; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 8B56F12001C;
	Tue, 14 May 2024 01:46:43 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8B56F12001C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1715640403;
	bh=kXE1Li6CYAMN37Y6ndANEsSdW059zB4iC9T0bLHvcxg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=kHLkwhFueeFp6DpOXB/h35U1Z6uGicWSKOkof9iyYngtvn3GPyZu2cn3aUQXCX0it
	 oXSAhD8Ad0+hSVNrS6AlhIId6hNaKXDFQakdxfC7cgQik37aazcYC/6uFsaGqCZeJm
	 vcwLo/3/vfu9PP49863eIAw5dW2mml8Q8kFIBTctudJXdY56jWEnscpKl5t+6eoLdo
	 UunROdUtrE5oFgzFHRIPXaLtsSt38/7g95nRetP8aaT/6GD9Ma3TsvqFoz7PPSs8VU
	 xEztQzkVpm1LlHfxaw2T3AhdSI2/wFU7fq9cUPGsrXFTzGygW1Z0BTUatTci+3mSmM
	 cpDbXI/HzZ/7g==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 14 May 2024 01:46:43 +0300 (MSK)
Received: from CAB-WSD-0003115.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 14 May 2024 01:46:42 +0300
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Conor Dooley
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>, Jerome Brunet
	<jbrunet@baylibre.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>,
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v2] dt-bindings: clock: meson: Convert axg-audio-clkc to YAML format
Date: Tue, 14 May 2024 01:45:52 +0300
Message-ID: <20240513224552.800153-1-jan.dakinevich@salutedevices.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185198 [May 13 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_smtp_not_equal_from}, {Tracking_uf_ne_domains}, sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;devicetree.org:7.1.1;100.64.160.123:7.1.2;lore.kernel.org:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/05/13 21:20:00
X-KSMG-LinksScanning: Clean, bases: 2024/05/13 21:20:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/13 20:57:00 #25189509
X-KSMG-AntiVirus-Status: Clean, skipped

From: Alexander Stein <alexander.stein@mailbox.org>

Convert Amlogic AXG Audio Clock Controller binding to yaml.

Signed-off-by: Alexander Stein <alexander.stein@mailbox.org>
Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
---

Also, this patch was discussed at [1].

Changes v1 -> v2 [2]
 - Stop using conditionals and list all clocks;
 - Cosmetics.

Links
[1] https://lore.kernel.org/linux-devicetree/20240508144259.191843-1-jan.dakinevich@salutedevices.com/
[2] https://lore.kernel.org/linux-devicetree/20230808194811.113087-1-alexander.stein@mailbox.org/

 .../bindings/clock/amlogic,axg-audio-clkc.txt |  59 -----
 .../clock/amlogic,axg-audio-clkc.yaml         | 201 ++++++++++++++++++
 2 files changed, 201 insertions(+), 59 deletions(-)
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
index 000000000000..fd7982dd4cea
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml
@@ -0,0 +1,201 @@
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
+    minItems: 1
+    items:
+      - description: main peripheral bus clock
+      - description: input plls to generate clock signals N0
+      - description: input plls to generate clock signals N1
+      - description: input plls to generate clock signals N2
+      - description: input plls to generate clock signals N3
+      - description: input plls to generate clock signals N4
+      - description: input plls to generate clock signals N5
+      - description: input plls to generate clock signals N6
+      - description: input plls to generate clock signals N7
+      - description: slave bit clock N0 provided by external components
+      - description: slave bit clock N1 provided by external components
+      - description: slave bit clock N2 provided by external components
+      - description: slave bit clock N3 provided by external components
+      - description: slave bit clock N4 provided by external components
+      - description: slave bit clock N5 provided by external components
+      - description: slave bit clock N6 provided by external components
+      - description: slave bit clock N7 provided by external components
+      - description: slave bit clock N8 provided by external components
+      - description: slave bit clock N9 provided by external components
+      - description: slave sample clock N0 provided by external components
+      - description: slave sample clock N1 provided by external components
+      - description: slave sample clock N2 provided by external components
+      - description: slave sample clock N3 provided by external components
+      - description: slave sample clock N4 provided by external components
+      - description: slave sample clock N5 provided by external components
+      - description: slave sample clock N6 provided by external components
+      - description: slave sample clock N7 provided by external components
+      - description: slave sample clock N8 provided by external components
+      - description: slave sample clock N9 provided by external components
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: pclk
+      - const: mst_in0
+      - const: mst_in1
+      - const: mst_in2
+      - const: mst_in3
+      - const: mst_in4
+      - const: mst_in5
+      - const: mst_in6
+      - const: mst_in7
+      - const: slv_sclk0
+      - const: slv_sclk1
+      - const: slv_sclk2
+      - const: slv_sclk3
+      - const: slv_sclk4
+      - const: slv_sclk5
+      - const: slv_sclk6
+      - const: slv_sclk7
+      - const: slv_sclk8
+      - const: slv_sclk9
+      - const: slv_lrclk0
+      - const: slv_lrclk1
+      - const: slv_lrclk2
+      - const: slv_lrclk3
+      - const: slv_lrclk4
+      - const: slv_lrclk5
+      - const: slv_lrclk6
+      - const: slv_lrclk7
+      - const: slv_lrclk8
+      - const: slv_lrclk9
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
+                     <&clkc CLKID_GP0_PLL>,
+                     <&slv_sclk0>,
+                     <&slv_sclk1>,
+                     <&slv_sclk2>,
+                     <&slv_sclk3>,
+                     <&slv_sclk4>,
+                     <&slv_sclk5>,
+                     <&slv_sclk6>,
+                     <&slv_sclk7>,
+                     <&slv_sclk8>,
+                     <&slv_sclk9>,
+                     <&slv_lrclk0>,
+                     <&slv_lrclk1>,
+                     <&slv_lrclk2>,
+                     <&slv_lrclk3>,
+                     <&slv_lrclk4>,
+                     <&slv_lrclk5>,
+                     <&slv_lrclk6>,
+                     <&slv_lrclk7>,
+                     <&slv_lrclk8>,
+                     <&slv_lrclk9>;
+            clock-names = "pclk",
+                          "mst_in0",
+                          "mst_in1",
+                          "mst_in2",
+                          "mst_in3",
+                          "mst_in4",
+                          "mst_in5",
+                          "mst_in6",
+                          "mst_in7",
+                          "slv_sclk0",
+                          "slv_sclk1",
+                          "slv_sclk2",
+                          "slv_sclk3",
+                          "slv_sclk4",
+                          "slv_sclk5",
+                          "slv_sclk6",
+                          "slv_sclk7",
+                          "slv_sclk8",
+                          "slv_sclk9",
+                          "slv_lrclk0",
+                          "slv_lrclk1",
+                          "slv_lrclk2",
+                          "slv_lrclk3",
+                          "slv_lrclk4",
+                          "slv_lrclk5",
+                          "slv_lrclk6",
+                          "slv_lrclk7",
+                          "slv_lrclk8",
+                          "slv_lrclk9";
+            resets = <&reset RESET_AUDIO>;
+        };
+    };
-- 
2.34.1


