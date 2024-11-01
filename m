Return-Path: <linux-kernel+bounces-391990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD359B8E48
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 10:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 909991C20B24
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 09:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF9A172BA9;
	Fri,  1 Nov 2024 09:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="KrzDpIGZ"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9480915B0E2
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 09:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730455063; cv=none; b=UJXZW7NVxBkUT/DWVOEq+2aZLPhfCTOQ8vxC/wF+JTpcs8A40NOAmhZnddh/00VlkmJQ9o/DWXhD+BYoauG7jh/9Rud4adIf8by6qbA0Q2lhmQ94IXJgE9eYtz/msUlrBAkfx2LQMW9lh9U7hB9HBxOSEiYzCBc0mB3fy0OhWms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730455063; c=relaxed/simple;
	bh=0m638leyhUhtaUAaN9ZlkjBSdE7urTd8c85y7al5QAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VN4MXdY9D9kVnVUzbhiYNee07g/CTtwmHMW1YSDlxuzBbBCkm/TXNjrRbst73RTHj89DunN6/V7ES583v03Yj/WJS/HkzA8yKrIMbEEawjYrVbi8jihgC6wiKJgcohvI/z+Nn51dP+r8htL5r4sEOGf1CVDyE+n3m6sSD5jmdqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=KrzDpIGZ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c9693dc739so2356545a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 02:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1730455058; x=1731059858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gfm06b4hKMdHLkWB/4M6o/0esEDQBJdzAKRNLmWwPQA=;
        b=KrzDpIGZiNf4O1/dgZanHHSM9VXmUYkDiJy7JnafAMbD5ThirU+KdAIRzuTBfPtLUe
         mI3BLQPQuew8NmANe9MTRRuy/EHzwu1uWY6NPEnfNMOklGuM23hxcvy/sebdjVBOYQSL
         +fdQX9Is/B2uWZhUl9czRZRIEG2OrrXsD8rL4FhMYDo7MA9sYMN+nlLo9T0a9ekHNtz+
         pL7RUNWda+MjmkRnNnOIWkOdqbmA/sq6AFIF8Khf6KcGokyC9mn3ksvxPP8rMRZ4qc6L
         RJoOjjOf/cZE5aPzVsykXZPq/dktirMhdbukw292vl0FlDYjHvBunnOR6uBhWqnfThfF
         TbtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730455058; x=1731059858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gfm06b4hKMdHLkWB/4M6o/0esEDQBJdzAKRNLmWwPQA=;
        b=DFgqdd1FIc9CbnilRjm/08ZQjj3JC4TdIEjJJw22XRjUHBtFqXGfS5bnfzR+cY99xR
         QH0Ltm9VOIPnW7/lM1ieHgpZFpjaSb1EKIIRjbnGpgvfDvZOoJTbNh3PhAX/XUAckF+i
         JhWj6yg72tU6W6e+ehjOcSB1UIBEPKCbPfSnfPwh+292SDmrHbkFTxj8O/M5e/Y2IiCW
         fzrglJWmcpl+jHkP3K5DiUnJWzHLvlcRQajVO1XSDIKA6kZXsZaP3xco20WCpMnj1/+p
         jeG0eCzKflY0S2UdoL5q0sUVPXzQeOGNbaCpUpFLyjgtvWlSI/NVRzhtiYOURy0XMylk
         PXwg==
X-Forwarded-Encrypted: i=1; AJvYcCUaQp47rUap1s/a+PlV91tOWrgkrTSsqabTDLF/TflMdA0hlAQcTqLRokyyS6lL/HFUKZFfurqK5xHxXFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ/kugwjUzryM7x4SuNWl9K0bcfan/nE51UJRBQDuFDMEdSux/
	SOmyHkzxYVkJRTfvN3qeoZIG5EZaJ81uecELnK+pOfV7vbTXxsvFFZx0+Zpkv5k=
X-Google-Smtp-Source: AGHT+IEb89p86xoYXu3JKTNPryZg3y3CDRh6iFfjnC4NPmIs9ROG2Yx148IwXpRj1QPZZK99u/gJwg==
X-Received: by 2002:a05:6402:1d4e:b0:5cb:7443:27d4 with SMTP id 4fb4d7f45d1cf-5ceb9343488mr2308264a12.25.1730455057897;
        Fri, 01 Nov 2024 02:57:37 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.190])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac7c8d87sm1364136a12.76.2024.11.01.02.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 02:57:37 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alexandre.belloni@bootlin.com,
	magnus.damm@gmail.com,
	p.zabel@pengutronix.de
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 1/9] dt-bindings: clock: renesas,r9a08g045-vbattb: Document VBATTB
Date: Fri,  1 Nov 2024 11:57:12 +0200
Message-Id: <20241101095720.2247815-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241101095720.2247815-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241101095720.2247815-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The VBATTB IP of the Renesas RZ/G3S SoC controls the clock for RTC,
the tamper detector and a small general usage memory of 128B.

The VBATTB controller controls the clock for the RTC on the Renesas
RZ/G3S. The HW block diagram for the clock logic is as follows:

           +----------+ XC   `\
RTXIN  --->|          |----->| \       +----+  VBATTCLK
           | 32K clock|      |  |----->|gate|----------->
           | osc      | XBYP |  |      +----+
RTXOUT --->|          |----->| /
           +----------+      ,/

One could connect as input to this HW block either a crystal or
an external clock device. This is board specific.

After discussions w/ Stephen Boyd the clock tree associated with this
hardware block was exported in Linux as:

input-xtal
  xbyp
  xc
     mux
        vbattclk

where:
- input-xtal is the input clock (connected to RTXIN, RTXOUT pins)
- xc, xbyp are mux inputs
- mux is the internal mux
- vbattclk is the gate clock that feeds in the end the RTC

to allow selecting the input of the MUX though assigned-clock DT
properties, using the already existing clock drivers and avoid adding
other DT properties.

This allows select the input of the mux based on the type of the
connected input clock:
- if the 32768 crystal is connected as input for the VBATTB,
  the input of the mux should be xc
- if an external clock device is connected as input for the VBATTB the
  input of the mux should be xbyp

Add bindings for the VBATTB controller.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v6:
- collected tags

Changes in v5:
- used spaces in the diagram from the patch description
- added "This is board specific" in the board description to emphasize
  the usage of the assigned-clocks in the example
- added default for quartz-load-femtofarads
- collected tags

Changes in v4:
- squashed with patch "Add clock IDs for the VBATTB controller" from v3
- removed "oscillator" word from commit description
- added assigned-clocks, assigned-clock-parents to the documentation example
- used clock-controller for the node name
- used "quartz-load-femtofarads" property for the load capacitance
- renamed include/dt-bindings/clock/r9a08g045-vbattb.h to
  include/dt-bindings/clock/renesas,r9a08g045-vbattb.h

Changes in v3:
- moved the file to clock dt bindings directory as it is the
  only functionality supported at the moment; the other functionalities
  (tamper detector, SRAM) are offered though register spreaded
  though the address space of the VBATTB IP and not actually
  individual devices; the other functionalities are not
  planned to be supported soon and if they will be I think they
  fit better on auxiliary bus than MFD
- dropped interrupt names as requested in the review process
- dropped the inner node for clock controller
- added #clock-cells
- added rtx clock
- updated description for renesas,vbattb-load-nanofarads
- included dt-bindings/interrupt-controller/irq.h in examples section

Changes in v2:
- changed file name and compatible
- updated title, description sections
- added clock controller part documentation and drop dedicated file
  for it included in v1
- used items to describe interrupts, interrupt-names, clocks, clock-names,
  resets
- dropped node labels and status
- updated clock-names for clock controller to cope with the new
  logic on detecting the necessity to setup bypass

 .../clock/renesas,r9a08g045-vbattb.yaml       | 84 +++++++++++++++++++
 .../clock/renesas,r9a08g045-vbattb.h          | 13 +++
 2 files changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,r9a08g045-vbattb.yaml
 create mode 100644 include/dt-bindings/clock/renesas,r9a08g045-vbattb.h

diff --git a/Documentation/devicetree/bindings/clock/renesas,r9a08g045-vbattb.yaml b/Documentation/devicetree/bindings/clock/renesas,r9a08g045-vbattb.yaml
new file mode 100644
index 000000000000..3707e4118949
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/renesas,r9a08g045-vbattb.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/renesas,r9a08g045-vbattb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas Battery Backup Function (VBATTB)
+
+description:
+  Renesas VBATTB is an always on powered module (backed by battery) which
+  controls the RTC clock (VBATTCLK), tamper detection logic and a small
+  general usage memory (128B).
+
+maintainers:
+  - Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
+
+properties:
+  compatible:
+    const: renesas,r9a08g045-vbattb
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: tamper detector interrupt
+
+  clocks:
+    items:
+      - description: VBATTB module clock
+      - description: RTC input clock (crystal or external clock device)
+
+  clock-names:
+    items:
+      - const: bclk
+      - const: rtx
+
+  '#clock-cells':
+    const: 1
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    items:
+      - description: VBATTB module reset
+
+  quartz-load-femtofarads:
+    description: load capacitance of the on board crystal
+    enum: [ 4000, 7000, 9000, 12500 ]
+    default: 4000
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - '#clock-cells'
+  - power-domains
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r9a08g045-cpg.h>
+    #include <dt-bindings/clock/renesas,r9a08g045-vbattb.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    clock-controller@1005c000 {
+        compatible = "renesas,r9a08g045-vbattb";
+        reg = <0x1005c000 0x1000>;
+        interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&cpg CPG_MOD R9A08G045_VBAT_BCLK>, <&vbattb_xtal>;
+        clock-names = "bclk", "rtx";
+        assigned-clocks = <&vbattb VBATTB_MUX>;
+        assigned-clock-parents = <&vbattb VBATTB_XC>;
+        #clock-cells = <1>;
+        power-domains = <&cpg>;
+        resets = <&cpg R9A08G045_VBAT_BRESETN>;
+        quartz-load-femtofarads = <12500>;
+    };
diff --git a/include/dt-bindings/clock/renesas,r9a08g045-vbattb.h b/include/dt-bindings/clock/renesas,r9a08g045-vbattb.h
new file mode 100644
index 000000000000..67774eafad06
--- /dev/null
+++ b/include/dt-bindings/clock/renesas,r9a08g045-vbattb.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+ *
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ */
+#ifndef __DT_BINDINGS_CLOCK_R9A08G045_VBATTB_H__
+#define __DT_BINDINGS_CLOCK_R9A08G045_VBATTB_H__
+
+#define VBATTB_XC		0
+#define VBATTB_XBYP		1
+#define VBATTB_MUX		2
+#define VBATTB_VBATTCLK		3
+
+#endif /* __DT_BINDINGS_CLOCK_R9A08G045_VBATTB_H__ */
-- 
2.39.2


