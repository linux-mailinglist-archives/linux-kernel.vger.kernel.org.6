Return-Path: <linux-kernel+bounces-268639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6971394272F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 962CDB23275
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 06:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD4E1A4B55;
	Wed, 31 Jul 2024 06:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVzvCBur"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D687A6E614;
	Wed, 31 Jul 2024 06:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722408724; cv=none; b=Is25clFygqu+u50MTS0umAYXUqEPS5SwUKo+I0ZMAsC0dKLAs6OWyTNvv6rUIuzH3zP8MtVWNRFG+d1wOaS2h2KysLxJJhOUtNItw9w7rbUiWwRToH0iuowX4gAI/2kXLYmYXjhQeznNvq7KG7Z/fkp/nFmb1bT9adMBw9IKg2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722408724; c=relaxed/simple;
	bh=QGQ7UcDgLseVwst6/lVeoLfgo6ne99fQU3rFqT+jJzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gSgIteeCAvm/7fVw77evdmTXt8dDtZPpCGvKYzvG6hpbDYaQQ2AINUy+1VpUGZ1vz8bjyy4+jilGh6YaJ53itIdr82rQfZZ1KCFU9E9sw9Uu/jjzEdjunn8Xo5vGEUlajmKjrO6/bVsVJAvPY7sdWuvCng0Dd2aQBnUmnPR7e/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVzvCBur; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fed72d23a7so38427915ad.1;
        Tue, 30 Jul 2024 23:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722408722; x=1723013522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UL4pzV5kNcQzdAISGWSssRa96/8ZELbs9Z5LYhAlirQ=;
        b=HVzvCBurD0TMBtytxo8mkIJENWbhQKKKdv8xzV+mZiQdj3qT8v8IKWdu6aF0GpTBZx
         fg7+hb+9jiHjCSCjx9teHOsSRNSrvi+UsQnTU4CkO7BqO/aQb9yyh2I4AnRyXK+st/hk
         t9v4ELYIl+xNjDL8tS8OnCFulGK4LYS2Wd35Rh7r30JnJkWjNPSqhIHyHnhe5K4bOtmL
         4GXkU3zARoOUqNDbgD3qYEnQEy4AI45jT0S2Dv/UyO5XteYu3ZKaD/sT9ByWuyUrE9j1
         wjcTNPw5/N93Mw3W1yXDz7qY9y2TeX3TmTSkxapmcNdBD4OM5QMdVdQc+xNPARI6x9zC
         uIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722408722; x=1723013522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UL4pzV5kNcQzdAISGWSssRa96/8ZELbs9Z5LYhAlirQ=;
        b=YvdSRr8tjPD/3UqaVnBFun/B33RblYuHsVRcZgJS1XVM3oNM73rc/wbSBIGqJENQPw
         tGvv6vGju9o97EVHgswWPlevAsmavEGf/SHVtBQfYREkfWRE0KAytnA8DNIJcqzDufXF
         JZYE/rvbO/i1qpUKctMEZXSR55tNwnyQz6P7ZX6Rh+tBu6iupUzQ58jE1TzXxT78qpVZ
         sXYFLc4Dhtmmyyyt3JegS8hePYb65lL6hGLVtscIxIv160ms8uVKCWrLqnZoIhYaD3mU
         XipDy3IsBx2A2IhkaRLaE+y9stDAhvxTatSo1tw6fz2GddqcKnu9l9BEuuK9a0bJTIg8
         kgsg==
X-Forwarded-Encrypted: i=1; AJvYcCUmM5/LdMfM9KdXW31p36/dnWuA3RllVA1cqCBHee9WVdcYU3irvBx/q6OBmcuYyGTB21do8Vv1rlV5GR7Q0p4YgApi+kO00E2sKBwk2rRIdymqBUNKK+1v5Lklch82giPsCeq0jz8MY1EiJk+IcHgUskPwKTDUfPp5cBce6A721VV1sw==
X-Gm-Message-State: AOJu0Yx0mym03ShIbIgHoWjJS7UtffuVPytroKNJ1wSMVEV8IitU04uH
	eub9LlJ2WfHOeo88REGH+hb7g/WqjHpKmYzLF9cYGHNQ1Bbsz4ie
X-Google-Smtp-Source: AGHT+IHq5APEBHZUKRRPP88QWREisQJS1K0mGr46QU+4f0kE0BSoDDxkFSH7nRK0wak612oG6IxWrg==
X-Received: by 2002:a17:902:c40e:b0:1fd:6677:69b4 with SMTP id d9443c01a7336-1ff0489f48fmr138938025ad.49.1722408721968;
        Tue, 30 Jul 2024 23:52:01 -0700 (PDT)
Received: from localhost.localdomain ([115.240.194.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c8c826sm112752865ad.58.2024.07.30.23.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 23:52:01 -0700 (PDT)
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
Subject: [PATCH v2] dt-bindings: clock: nxp,lpc3220-clk: Convert bindings to DT schema
Date: Wed, 31 Jul 2024 12:21:33 +0530
Message-ID: <20240731065137.156935-1-animeshagarwal28@gmail.com>
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
Changes in v2:
  - Listed the items with description in the clock property.
  - Corrected clock-names property.
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
index 000000000000..16f79616d18a
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
+    minItems: 1
+    items:
+      - description: External 32768 Hz oscillator.
+      - description: Optional high frequency oscillator.
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: xtal_32k
+      - const: xtal
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


