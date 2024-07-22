Return-Path: <linux-kernel+bounces-258727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 078E8938C2E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B27D1C2115B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED1316C69D;
	Mon, 22 Jul 2024 09:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="FMtynVP1"
Received: from smtpout148.security-mail.net (smtpout148.security-mail.net [85.31.212.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCC1168499
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.31.212.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641405; cv=none; b=sEFPR/2iwSDKKj7/KcCvi1QcWbPHqH/FL+IHsuu+sgWQWe5/nJxOrdxGA/jL41xVXBZN3Q7BWvM95T43P5SQ/o8oyBdY/CjcHT7hXnztSVIT16jbwHVOOthinvPaH3176gmiGW4bYH3hIBri5U5Mp1I7O0nHX3SZhC3DOGCuXd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641405; c=relaxed/simple;
	bh=hQQoSnZGeakz3KirXfjKHIJTqkcNAF5znxVkYddg6tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=snusnXIbWRgpsYJ0RZ0Lt9iTCOEu+bldum4ZdFRJ9a123XqtpDPX8z9JU/B4R7aYKwMRFOqdxT2wynsCoT0qyPYZT8EQn/ODMD4LRHBERSNMgPj2YOW4ZnspDcx8HB8j7nl8q4bTxIkHtzA0BQQTEX00iWtej5lBfLrZNweP06U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=FMtynVP1; arc=none smtp.client-ip=85.31.212.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx408.security-mail.net [127.0.0.1])
	by fx408.security-mail.net (Postfix) with ESMTP id B3DBD322C22
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:43:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1721641399;
	bh=hQQoSnZGeakz3KirXfjKHIJTqkcNAF5znxVkYddg6tw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FMtynVP1bneOvKTD66Axq/8eEllOPMFkF8wVjHg98teJ/TiWBUMXFaO5ki9Fw5Yqm
	 +eRqfb1sySLb4+8tpGA28MXjdDi7X2tu14I+9izIp8BRDU4MbWAhnRBrm6OZ8O8uE+
	 5q5foVVAzV0EJrJmEvXuyW67gJqu2I4BQ3w9Xw0Q=
Received: from fx408 (fx408.security-mail.net [127.0.0.1]) by
 fx408.security-mail.net (Postfix) with ESMTP id 80667322B78; Mon, 22 Jul
 2024 11:43:19 +0200 (CEST)
Received: from srvsmtp.lin.mbt.kalray.eu (unknown [217.181.231.53]) by
 fx408.security-mail.net (Postfix) with ESMTPS id E03C83228B4; Mon, 22 Jul
 2024 11:43:18 +0200 (CEST)
Received: from junon.lan.kalrayinc.com (unknown [192.168.37.161]) by
 srvsmtp.lin.mbt.kalray.eu (Postfix) with ESMTPS id B476F40317; Mon, 22 Jul
 2024 11:43:18 +0200 (CEST)
X-Quarantine-ID: <lAdOPk1k_XYt>
X-Secumail-id: <152c5.669e29b6.de7ea.0>
From: ysionneau@kalrayinc.com
To: linux-kernel@vger.kernel.org, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jonathan Borne <jborne@kalrayinc.com>, Julian
 Vetter <jvetter@kalrayinc.com>, Yann Sionneau <ysionneau@kalrayinc.com>
Cc: devicetree@vger.kernel.org
Subject: [RFC PATCH v3 09/37] dt-bindings: Add binding for
 kalray,kv3-1-timer
Date: Mon, 22 Jul 2024 11:41:20 +0200
Message-ID: <20240722094226.21602-10-ysionneau@kalrayinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722094226.21602-1-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

From: Yann Sionneau <ysionneau@kalrayinc.com>

Add binding for Kalray kv3-1 core timer.

Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
---

Notes:

V2 -> V3: New patch
---
 .../bindings/timer/kalray,kv3-1-timer.yaml    | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/kalray,kv3-1-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/kalray,kv3-1-timer.yaml b/Documentation/devicetree/bindings/timer/kalray,kv3-1-timer.yaml
new file mode 100644
index 0000000000000..1932f28a05a18
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/kalray,kv3-1-timer.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/kalray,kv3-1-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Kalray kv3-1 core timer
+
+maintainers:
+  - Jonathan Borne <jborne@kalrayinc.com>
+  - Julian Vetter <jvetter@kalrayinc.com>
+  - Yann Sionneau <ysionneau@kalrayinc.com>
+
+description: |
+  Timer tightly coupled to the kv3-1 processor core. It is configured via core SFR.
+  It triggers an interrupt directly on core-intc.
+
+properties:
+  compatible:
+    const: kalray,kv3-1-timer
+
+  interrupts-extended:
+    maxItems: 16
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - interrupts-extended
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    core_timer {
+        compatible = "kalray,kv3-1-timer";
+        clocks = <&core_clk>;
+        interrupts-extended = <&core_intc0 0>,
+                              <&core_intc1 0>,
+                              <&core_intc2 0>,
+                              <&core_intc3 0>,
+                              <&core_intc4 0>,
+                              <&core_intc5 0>,
+                              <&core_intc6 0>,
+                              <&core_intc7 0>,
+                              <&core_intc8 0>,
+                              <&core_intc9 0>,
+                              <&core_intc10 0>,
+                              <&core_intc11 0>,
+                              <&core_intc12 0>,
+                              <&core_intc13 0>,
+                              <&core_intc14 0>,
+                              <&core_intc15 0>;
+    };
+
-- 
2.45.2






