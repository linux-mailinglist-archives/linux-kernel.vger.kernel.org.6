Return-Path: <linux-kernel+bounces-536871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4FDA48536
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89BE21893214
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5131D9A48;
	Thu, 27 Feb 2025 16:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b="k6DomKcY"
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [94.124.121.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA23D1CAA6A
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673800; cv=none; b=GYA/mYdiN4q/pg+GP+oV4re8nQH+T9QMY8elrePNhmT3VU7/7nsmGm568LLjfLkISANC2bkGXF1n93F+xDmezOPJ9gKe1cSqtLLACoQrz9bib/oUZnLiP8aMT/r6uwphUkujSEhRxEWBXAFqklxhdgNM8GKUj/sct4XUCDb4xWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673800; c=relaxed/simple;
	bh=9uMpx9Mab9fK3MfAkfHCHHv51TtabIU/UJX98iJNxtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFdDpVnRq0WGhwi7yn+1r1LTvC3hE1BfQUFpPcRYxrmZkRhGpJBlp4Oo34O3WaR955opYE1BLXYrJuvuxYD0BmVKlLVquNOvY1n7xIiykee26wGMeQ8+EBPbJ+AIcsl+2EYLCjZT9X/BOK5O06euXBDLoh+ONwoMirOmuETThIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl; spf=pass smtp.mailfrom=protonic.nl; dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b=k6DomKcY; arc=none smtp.client-ip=94.124.121.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonic.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=/mtSJ5kvDnJhqBx+5Yy3liA8YbzxZ1PsBPRkJzt2uEM=;
	b=k6DomKcY6uxpzxkxo8UJKqtaV34WucRmBtHkd5ccUb9PobdahUYG8/Cq82IV/ba2LY/5fJLPB6eDR
	 5S4/Xyze8kYMN3O+bwfsCnwc3rRzwdYIOwzPlh3FSeLRuZpNUCWa8pJqCk0dNPwbiAhhFqV8yhaIUR
	 2fzpsUjZlRgeOMaGo3m9arCQpP9ESm+rQbC+q6yEk1ntkNANPM+SGOCxEulBttDTgNM86CRmhf8tag
	 mLJcUUm3176oGaLnZG+wroSgQoPO8oxemy01ypKZC8PGEg7+yei6RjmEL4tbIgQqZumMBw5Wk3cvVt
	 jRvflwPe/B1ndh6Kr0mNXZ6MDd1OqDQ==
X-MSG-ID: ec71a464-f527-11ef-b5ca-0050568164d1
From: David Jander <david@protonic.nl>
To: linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Nuno Sa <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	David Jander <david@protonic.nl>
Subject: [RFC PATCH 6/7] dt-bindings: motion: Add adi,tmc5240 bindings
Date: Thu, 27 Feb 2025 17:28:22 +0100
Message-ID: <20250227162823.3585810-7-david@protonic.nl>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250227162823.3585810-1-david@protonic.nl>
References: <20250227162823.3585810-1-david@protonic.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device-tree bindings for Analog Devices TMC5240 stepper controllers.

Signed-off-by: David Jander <david@protonic.nl>
---
 .../bindings/motion/adi,tmc5240.yaml          | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/motion/adi,tmc5240.yaml

diff --git a/Documentation/devicetree/bindings/motion/adi,tmc5240.yaml b/Documentation/devicetree/bindings/motion/adi,tmc5240.yaml
new file mode 100644
index 000000000000..3364f9dfccb1
--- /dev/null
+++ b/Documentation/devicetree/bindings/motion/adi,tmc5240.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/motion/adi,tmc5240.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices TMC5240 Stepper Motor controller
+
+maintainers:
+  - David Jander <david@protonic>
+
+description: |
+   Stepper motor controller with motion engine and SPI interface.
+
+properties:
+  compatible:
+    enum:
+      - adi,tmc5240
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  enable-supply:
+    description: Optional external enable supply to control SLEEPn pin. Can
+      be shared between several controllers.
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - $ref: /schemas/motion/common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        motor@0 {
+            compatible = "adi,tmc5240";
+            reg = <0>;
+            interrupts-extended = <&gpiok 7 0>;
+            clocks = <&clock_tmc5240>;
+            enable-supply = <&stpsleepn>;
+            spi-max-frequency = <1000000>;
+        };
+    };
+
-- 
2.47.2


