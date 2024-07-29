Return-Path: <linux-kernel+bounces-266340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5722D93FE5D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAC871F23B00
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 19:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DAF187861;
	Mon, 29 Jul 2024 19:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoEtHz6h"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A5A186E4F;
	Mon, 29 Jul 2024 19:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722281876; cv=none; b=SZaln/1as3WFFGlRUwGJC+jL+gtxPoKco1r0C/dJd/16IE163Y1dAg9oJyvBqPr9BOC4csKduaa2vx9MOHLXqKcbnwtL3zgApaLmh6yiTBtLqO0hpCePxwnPOyC791H+eyAoRPRokN1a0R43szy8YL9hmxD11FlWLU441O2P1xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722281876; c=relaxed/simple;
	bh=lbQL5JO9A9Zffie3YIm36F9Acyj955px1UEdozg9wjc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EsOKHu2dHwXwQ6y6I15toLR7vySnH0AT/Xcwu0wLt/Oznf9bre8IhE7zZ9y5e6GSbi4S64PnbIvAB3CmT45vDWzJDXX1SentZkS0WNMaLPQDvffS2Bz/GKQE9M+mbfOmpZHbU4WTtasYHxli21LoQCVXR8RzKQQXmaF4ADLxIcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UoEtHz6h; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70d2b921c48so2726622b3a.1;
        Mon, 29 Jul 2024 12:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722281874; x=1722886674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WuL+X0cuNqgatZoPaLJRqOKFz6ZRnHI8J9rGMVL8Gbw=;
        b=UoEtHz6hXJ5yXbohkBaMhS9dJCyHBVZ9o07U48XY/2JwNoK5qa7rbYtu/dKQz0GvXI
         LBeJkIH6ZqQKG1EBkZMQlfxFJOSwFyv6gQrDHp0IJhbBtSULxgoU4Nw11J5fAD2/zRlo
         5qki7p743DMfUq6MDg0nvqG+RB6N7hpQYCvhxCRblONFTLOTTuiXP08Ooy2U2tqeagni
         lhw2ExZQxqlzSH13vwek4xCZYVX/MQHvAexXK1pG/Kzxnv1NMpBEAeyydUQQd9Wm/JpH
         /+tDQCBBIgjSQJSPmfKivRfyckmIsf37m6XuOu0IYEbzHJjpNsfRpDvZwHdH5fDCTQzl
         T/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722281874; x=1722886674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WuL+X0cuNqgatZoPaLJRqOKFz6ZRnHI8J9rGMVL8Gbw=;
        b=fmaYtJepmDp1uUcHOP9ho4LfQ+tC++nfy2xjZd8lei4VBoxBaaPuYlppmW/01p5nWV
         FdO9LNQeQe9m/iL6qzQKa7xxZD3orMhvroJppYdXsllTsk+CM1CYrq6+UNQ04N3TvykT
         K3e69V798eyS1Gw8geCSW+lu0QO+1r7ExHVtOj6/sMk6ZahERTSEOjxonf9Fo2uNcKqd
         JbCjGvy2oGh2BMxBxMZZZtcglr4pKYhRyPvcdrl+FcJYUayLEHHCkR5iXdt78yFlnYrv
         25nATpYYd165aX3+G95t1TVt5mg8pM3E5uG5bTY8+O8H4U3ty+nCDQKN8aw4sb49tr+6
         A/Tg==
X-Forwarded-Encrypted: i=1; AJvYcCW4lCsSza+0QxauznOoFAU1xSTyke2c1vF6TOXTVoj6niw0NylyRORnBVdLXOHQ0ZVyDbjxLifgJ+aohTnr@vger.kernel.org, AJvYcCX4ti0YoXSavV76rNTlOLvo1AWyOEM24W8vxH5Ana61I2zWVm4A/oVQT66+6wx/OMUkVZqE6P88cjrY@vger.kernel.org, AJvYcCXtOEdT6LGP/0LEfSEJ8eLvxyRFPQra5HQvbshT8eu/iIj7uZFsANAzPuT6p4cH+AofapctT0ZpRmPa@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1vCPcKIQ0HvSBfSJ5WZZizKnwPRQ4HZedXIglpll+fdy+9Dz3
	/9CUbBLSVLjcqsMjmHb5Z1zxEegh/sL17EJxwVyOPz4seeTddB3H
X-Google-Smtp-Source: AGHT+IHM31GPVlJI3xYYzrz/YcFa0e7LtoyNUZirTosFge3OL28eCwLFmqDJtlOhGMcicQbeKtuUVg==
X-Received: by 2002:a05:6a20:3952:b0:1c4:9886:b511 with SMTP id adf61e73a8af0-1c4a117921cmr7845881637.2.1722281873546;
        Mon, 29 Jul 2024 12:37:53 -0700 (PDT)
Received: from localhost.localdomain ([2409:40f4:39:bb36:901a:3e6d:4815:b10c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8116a4sm7146706b3a.130.2024.07.29.12.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 12:37:53 -0700 (PDT)
From: Animesh Agarwal <animeshagarwal28@gmail.com>
To: 
Cc: Animesh Agarwal <animeshagarwal28@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: clock: nxp,lpc3220-clk: Convert bindings to DT schema
Date: Tue, 30 Jul 2024 01:07:25 +0530
Message-ID: <20240729193731.142069-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the NXP LPC32xx Clock Controller bindings to yaml format.

Cc: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
---
 .../bindings/clock/nxp,lpc3220-clk.txt        | 30 -----------
 .../bindings/clock/nxp,lpc3220-clk.yaml       | 51 +++++++++++++++++++
 2 files changed, 51 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/nxp,lpc3220-clk.txt
 create mode 100644 Documentation/devicetree/bindings/clock/nxp,lpc3220-clk.yaml

diff --git a/Documentation/devicetree/bindings/clock/nxp,lpc3220-clk.txt b/Documentation/devicetree/bindings/clock/nxp,lpc3220-clk.txt
deleted file mode 100644
index 20cbca3f41d8..000000000000
--- a/Documentation/devicetree/bindings/clock/nxp,lpc3220-clk.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-NXP LPC32xx Clock Controller
-
-Required properties:
-- compatible: should be "nxp,lpc3220-clk"
-- reg:  should contain clock controller registers location and length
-- #clock-cells: must be 1, the cell holds id of a clock provided by the
-  clock controller
-- clocks: phandles of external oscillators, the list must contain one
-  32768 Hz oscillator and may have one optional high frequency oscillator
-- clock-names: list of external oscillator clock names, must contain
-  "xtal_32k" and may have optional "xtal"
-
-Examples:
-
-	/* System Control Block */
-	scb {
-		compatible = "simple-bus";
-		ranges = <0x0 0x040004000 0x00001000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		clk: clock-controller@0 {
-			compatible = "nxp,lpc3220-clk";
-			reg = <0x00 0x114>;
-			#clock-cells = <1>;
-
-			clocks = <&xtal_32k>, <&xtal>;
-			clock-names = "xtal_32k", "xtal";
-		};
-	};
diff --git a/Documentation/devicetree/bindings/clock/nxp,lpc3220-clk.yaml b/Documentation/devicetree/bindings/clock/nxp,lpc3220-clk.yaml
new file mode 100644
index 000000000000..2faa845bab21
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/nxp,lpc3220-clk.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/nxp,lpc3220-clk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP LPC32xx Clock Controller
+
+maintainers:
+  - Animesh Agarwal <animeshagarwal28@gmail.com>
+
+properties:
+  compatible:
+    const: nxp,lpc3220-clk
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+  clocks:
+    description: Phandles of external oscillators, the list must contain one
+      32768 Hz oscillator and may have one optional high frequency oscillator.
+    maxItems: 2
+
+  clock-names:
+    oneOf:
+      - items:
+          - const: xtal_32k
+          - const: xtal
+      - const: xtal_32k
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@0 {
+        compatible = "nxp,lpc3220-clk";
+        reg = <0x00 0x114>;
+        #clock-cells = <1>;
+        clocks = <&xtal_32k>, <&xtal>;
+        clock-names = "xtal_32k", "xtal";
+    };
-- 
2.45.2


