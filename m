Return-Path: <linux-kernel+bounces-532770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F825A451FF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACA3C3AA160
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543E51552E3;
	Wed, 26 Feb 2025 01:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+Sd9Kfo"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A87114F9CF;
	Wed, 26 Feb 2025 01:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740532205; cv=none; b=Rkd6KqjfgRH9S2NzSz92T+T4KXNkb++7vhR6IDE4Tnyi2krp85MMD2UoUd4f4CHL+OVjhv8xdRP6NR2I/j0z/6l8V2nvMacCcF6IlfsU41d9eTgdIsA4RqssyYMDUieBKBOcNZ6WhxjBywWUNG/UJ7wCEerDIEAMyeTARKRR3S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740532205; c=relaxed/simple;
	bh=J1ZAkl3ozYgniAVeeGm/DR4x+8Ypqttwvfp9sj5URr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TMJtcbmosYk8aCBzMhF2ABn1jJlXfe5Jsym1jnIz1JRKqF2WhPNrhsRP/GTSZrLNSlLqQYz9q8/jDlTFxf3Qjomk58pMeAjGYx1+4oIbWl5w+uTcDLJv/gUOZDYDk/uoRye2tEkqPye6Ff7Z6QWW2go0t7JnQuk1hrCRzNU3ZJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+Sd9Kfo; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22113560c57so41371005ad.2;
        Tue, 25 Feb 2025 17:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740532203; x=1741137003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WiEgyM16960NSDV6t1+D1FR+8qHkFg4gFUmoJjgyErM=;
        b=J+Sd9KfoYuXoFlNnGliMghDc+Qf3cDeZI5Pad3ezz0TlHsXRuErKzATp1Cj+YalZ/k
         enTrc6xh484ZusS5tVm3ytSWdXo1gShFEn6LHdw0kLvwNQOJJPwRzvF/GRSKtvLOUnSj
         VYLgzhxMjoqoPe65TOvHo2d1N7tj5hIpFeqOhYZHruv9O2HASBNFEQUl/r5HeUcUzR+f
         ccjouj2uBv+pF9Fs0mXRoD7st5SgFf+8l2khUe8uZTtQ7yElCMEqH4e/+Clm88Tf7r/o
         PasYSmCl0iDcI9NExa04Bq2TTi8Gdidw0hQ4SazRl/5L4nu3ERIsiaUSlS1qwSzolLXU
         E1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740532203; x=1741137003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WiEgyM16960NSDV6t1+D1FR+8qHkFg4gFUmoJjgyErM=;
        b=PI8Tr7e2EYqN1TOiHCWSxepoQgTvvsBvCZdbSkrrBN8xu9OhJ9h+ubVCnn0gObHjAs
         vSdeyiE8xN4DLJcNw/cT7+/KmE02skH3XP4CWmxEWMfbBJnMaNnpVZZkRtNTVz2mzBco
         dHvHBHgd+krXL2tYYlzh9dXmIo3bBDR2fU6sv9kbded31TlsLyCXpyrfqhnYK4vVetRb
         XEEKSoe+0VBrhTgkMmMXqdJu7ZnZhwLP0AQtpha2XN2Xv/RndCrq218+xivwmT58gYH6
         h1sJixcxu6pE5H9sy1yFMoimlpLAjNIiH3BG4tuTRuGAXHASTKG92hntLFXmyvE4Kk2H
         2jeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmEqKCK09+I74yC0uQbtL7MsMSDKGczh9U92QWkpo6ugTXMFvsCh326SxSeaIAM3i/CFUBBEGpHecJ@vger.kernel.org, AJvYcCXvnYsCsSpDqcpkDn5gnWA5yEBc7GGQl2lC9VyQQoifFYA9gvzTOYG80wqFUuaKh7OtagO6AofSqAURqaMd@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7eocUYePd2SBIdUit7BCKS2nycYYHHHuc3cK8iUkrfDH08qet
	E2baDKxNCgxEZVI6FtcTJdsGhqhP85RdkFebn6ONflPmdtR/lpkA
X-Gm-Gg: ASbGncvF+d1DB05W7HwHjxFM+ufmK6jzrQbZ17y9KfThV8QDqHmEaD4omktxbOEQ1xQ
	x9ZnClsCZv+lPNivC7mV7VEMphAtrsyfo3amnCZd+sNNBvs1vUoVwFrmiyJOgP+MK7748B9wo4r
	M/6971+qy5y8Bnc+OezzpB8KzoZ8+djbT80WCBYefvgHJ5h1947AxxNKAqwP13+gF3dynw0A+MB
	PFMjw0mzRJr4MumfeG63iWlWuy4LtJZMLVQ28OcPCyXGCEto+viL8E0PWcYvVjmhBX6MnyFtMLM
	8jiX97OtYetzz8UcLXoth9Y=
X-Google-Smtp-Source: AGHT+IEAIlHRnph+kEm0eZjJMotG6sxrxwDis5EVo+KPSHhWr29FBTWOWu09c8pE742ej1Laf9rDaQ==
X-Received: by 2002:a05:6a00:4f88:b0:72a:8bb6:2963 with SMTP id d2e1a72fcca58-73426cf11e7mr27498782b3a.13.1740532203140;
        Tue, 25 Feb 2025 17:10:03 -0800 (PST)
Received: from dev.. ([2804:14d:887:95a9:e1a5:e9d5:ba9a:df82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a839dffsm2271324b3a.172.2025.02.25.17.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 17:10:02 -0800 (PST)
From: Leonardo Felipe Takao Hirata <leo.fthirata@gmail.com>
To: tglx@linutronix.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vz@mleia.com
Cc: Leonardo Felipe Takao Hirata <leo.fthirata@gmail.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2] dt-bindings: interrupt-controller: Convert nxp,lpc3220-mic.txt to yaml format
Date: Tue, 25 Feb 2025 22:09:40 -0300
Message-ID: <20250226010956.50566-1-leo.fthirata@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert NXP LPC3220-MIC to DT schema.

Signed-off-by: Leonardo Felipe Takao Hirata <leo.fthirata@gmail.com>
---
Changes in v2:
 - Fix SoB
 - Remove reg description
 - List #interrupt-cell items
 - Add interrupt restriction per variant
 - Remove extra examples
---
 .../interrupt-controller/nxp,lpc3220-mic.txt  | 58 --------------
 .../interrupt-controller/nxp,lpc3220-mic.yaml | 80 +++++++++++++++++++
 2 files changed, 80 insertions(+), 58 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.txt b/Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.txt
deleted file mode 100644
index 0bfb3ba55f4c..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.txt
+++ /dev/null
@@ -1,58 +0,0 @@
-* NXP LPC32xx MIC, SIC1 and SIC2 Interrupt Controllers
-
-Required properties:
-- compatible: "nxp,lpc3220-mic" or "nxp,lpc3220-sic".
-- reg: should contain IC registers location and length.
-- interrupt-controller: identifies the node as an interrupt controller.
-- #interrupt-cells: the number of cells to define an interrupt, should be 2.
-  The first cell is the IRQ number, the second cell is used to specify
-  one of the supported IRQ types:
-      IRQ_TYPE_EDGE_RISING = low-to-high edge triggered,
-      IRQ_TYPE_EDGE_FALLING = high-to-low edge triggered,
-      IRQ_TYPE_LEVEL_HIGH = active high level-sensitive,
-      IRQ_TYPE_LEVEL_LOW = active low level-sensitive.
-  Reset value is IRQ_TYPE_LEVEL_LOW.
-
-Optional properties:
-- interrupts: empty for MIC interrupt controller, cascaded MIC
-  hardware interrupts for SIC1 and SIC2
-
-Examples:
-
-	/* LPC32xx MIC, SIC1 and SIC2 interrupt controllers */
-	mic: interrupt-controller@40008000 {
-		compatible = "nxp,lpc3220-mic";
-		reg = <0x40008000 0x4000>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-	};
-
-	sic1: interrupt-controller@4000c000 {
-		compatible = "nxp,lpc3220-sic";
-		reg = <0x4000c000 0x4000>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-
-		interrupt-parent = <&mic>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>,
-			     <30 IRQ_TYPE_LEVEL_LOW>;
-	};
-
-	sic2: interrupt-controller@40010000 {
-		compatible = "nxp,lpc3220-sic";
-		reg = <0x40010000 0x4000>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-
-		interrupt-parent = <&mic>;
-		interrupts = <1 IRQ_TYPE_LEVEL_LOW>,
-			     <31 IRQ_TYPE_LEVEL_LOW>;
-	};
-
-	/* ADC */
-	adc@40048000 {
-		compatible = "nxp,lpc3220-adc";
-		reg = <0x40048000 0x1000>;
-		interrupt-parent = <&sic1>;
-		interrupts = <7 IRQ_TYPE_LEVEL_HIGH>;
-	};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.yaml b/Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.yaml
new file mode 100644
index 000000000000..489bd329bc4e
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/nxp,lpc3220-mic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP LPC32xx MIC, SIC1 and SIC2 Interrupt Controllers
+
+maintainers:
+  - Vladimir Zapolskiy <vz@mleia.com>
+
+properties:
+  compatible:
+    enum:
+      - nxp,lpc3220-mic
+      - nxp,lpc3220-sic
+
+  reg:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+
+  interrupts:
+    items:
+      - description:
+          IRQ number.
+      - description: |
+          IRQ type. Can be one of:
+
+              IRQ_TYPE_EDGE_RISING = Low-to-high edge triggered,
+              IRQ_TYPE_EDGE_FALLING = High-to-low edge triggered,
+              IRQ_TYPE_LEVEL_HIGH = Active high level-sensitive,
+              IRQ_TYPE_LEVEL_LOW = Active low level-sensitive.
+
+          Reset value is IRQ_TYPE_LEVEL_LOW.
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - '#interrupt-cells'
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nxp,lpc3220-sic
+    then:
+      required:
+        - interrupts
+    else:
+      properties:
+        interrupts: false
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    mic: interrupt-controller@40008000 {
+      compatible = "nxp,lpc3220-mic";
+      reg = <0x40008000 0x4000>;
+      interrupt-controller;
+      #interrupt-cells = <2>;
+    };
+
+    sic1: interrupt-controller@4000c000 {
+      compatible = "nxp,lpc3220-sic";
+      reg = <0x4000c000 0x4000>;
+      interrupt-controller;
+      #interrupt-cells = <2>;
+      interrupt-parent = <&mic>;
+      interrupts = <0 IRQ_TYPE_LEVEL_LOW>,
+                  <30 IRQ_TYPE_LEVEL_LOW>;
+    };
-- 
2.43.0


