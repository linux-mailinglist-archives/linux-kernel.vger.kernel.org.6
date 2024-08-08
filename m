Return-Path: <linux-kernel+bounces-279057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5407694B86D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3BC9B265E2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9B5189519;
	Thu,  8 Aug 2024 07:59:55 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD221891A8;
	Thu,  8 Aug 2024 07:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723103995; cv=none; b=oAkdYaR4C3t+SWYE8JCDKgva4H0x7xWNKT0czmclXOxFPtSjHftKzYU5lZ3+4dX9jew88SGneRvrrmqQIqfbwdSJ3y8aEXfg0/iGaKZPEhli+hkD0jVHA56LpkJIGT9rT7v12DY60cRMqHPlofNqAHCzT+yoGrKrNXUr5eSUVaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723103995; c=relaxed/simple;
	bh=mlkym0TeE+gAegQ/zj2kEHVRh+EgzgS6BKjwh/nSM7E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JNDQkm8fO+rIqV/r2dZXZF0xTSJurzelTdOTe4t5H4iTzM2IkMs6NalBA6LvSSThYhn+2RqaAhDln1KZ+lpqKFImxAmP1jmTI2OPttHw/ScdCr0ulBPN8/DRfjqNTBhgcZW2EgXK35Nyv0IjMDRf1hn8g1YTEVzcwUoyDx1xwm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 8 Aug
 2024 15:59:37 +0800
Received: from twmbx02.aspeed.com (192.168.10.152) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 8 Aug 2024 15:59:37 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: <ryan_chen@aspeedtech.com>, Lee Jones <lee@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<linux-clk@vger.kernel.org>
Subject: [PATCH 1/4] dt-bindings: mfd: aspeed: support for AST2700
Date: Thu, 8 Aug 2024 15:59:34 +0800
Message-ID: <20240808075937.2756733-2-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808075937.2756733-1-ryan_chen@aspeedtech.com>
References: <20240808075937.2756733-1-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add compatible support for AST2700 clk, reset, pinctrl, silicon-id
and example for AST2700 scu.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 .../bindings/mfd/aspeed,ast2x00-scu.yaml      | 31 +++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
index 86ee69c0f45b..c0965f08ae8c 100644
--- a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
+++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
@@ -21,6 +21,8 @@ properties:
           - aspeed,ast2400-scu
           - aspeed,ast2500-scu
           - aspeed,ast2600-scu
+          - aspeed,ast2700-scu0
+          - aspeed,ast2700-scu1
       - const: syscon
       - const: simple-mfd
 
@@ -30,10 +32,12 @@ properties:
   ranges: true
 
   '#address-cells':
-    const: 1
+    minimum: 1
+    maximum: 2
 
   '#size-cells':
-    const: 1
+    minimum: 1
+    maximum: 2
 
   '#clock-cells':
     const: 1
@@ -56,6 +60,8 @@ patternProperties:
             - aspeed,ast2400-pinctrl
             - aspeed,ast2500-pinctrl
             - aspeed,ast2600-pinctrl
+            - aspeed,ast2700-soc0-pinctrl
+            - aspeed,ast2700-soc1-pinctrl
 
     required:
       - compatible
@@ -76,6 +82,7 @@ patternProperties:
               - aspeed,ast2400-silicon-id
               - aspeed,ast2500-silicon-id
               - aspeed,ast2600-silicon-id
+              - aspeed,ast2700-silicon-id
           - const: aspeed,silicon-id
 
       reg:
@@ -115,4 +122,24 @@ examples:
             reg = <0x7c 0x4>, <0x150 0x8>;
         };
     };
+  - |
+    soc0 {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        syscon@12c02000 {
+            compatible = "aspeed,ast2700-scu0", "syscon", "simple-mfd";
+            reg = <0x0 0x12c02000 0x0 0x1000>;
+            #clock-cells = <1>;
+            #reset-cells = <1>;
+
+            #address-cells = <2>;
+            #size-cells = <2>;
+            ranges = <0x0 0x0 0 0x12c02000 0 0x1000>;
+
+            silicon-id@0 {
+                compatible = "aspeed,ast2700-silicon-id", "aspeed,silicon-id";
+                reg = <0x0 0x0 0x0 0x4>;
+            };
+        };
+    };
 ...
-- 
2.34.1


