Return-Path: <linux-kernel+bounces-258769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97864938C86
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 419F51F24E6F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E30116D4D1;
	Mon, 22 Jul 2024 09:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="bqu51DDx"
Received: from smtpout148.security-mail.net (smtpout148.security-mail.net [85.31.212.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061E016CD2B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.31.212.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641508; cv=none; b=oug2u/r2Spi0Nlgd9A/f2lbAgy2sdpyY1xgWPc2dbP3x9k6sWDrBPSmiycSquvBsnOb4vLPurfavB6hLC60m/UDrAtPp3uf0Pa6DiiwTRfWFtvmvoR/BszfJRhFHXeAo/Of2G0KA1DjBct4loyaGQkEPHH+/D8/eSiZ8eKeoN28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641508; c=relaxed/simple;
	bh=DX9g+0kZiXZhcSvUCagT5ep+SpJuakRXEGMnTqccY70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rvdtbIHvPE3Ky+Cc6olj3lsnfGfQEH0mpsDY8DXjRgeHcBocRJsBpJI8T5cYhex3FlexESOdNmd0suU2RhPqLq/hmzgdCG22RU3aBYsrQU/keuLJHgYpMilJx/WY6o7WCqlpTRb7IyLh7IDxhTirwKgvb5a5qXofM2RNWRCAA1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=bqu51DDx; arc=none smtp.client-ip=85.31.212.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx408.security-mail.net [127.0.0.1])
	by fx408.security-mail.net (Postfix) with ESMTP id D1897322B40
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:43:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1721641396;
	bh=DX9g+0kZiXZhcSvUCagT5ep+SpJuakRXEGMnTqccY70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bqu51DDxGuMfZhu5L+7i0SzDj6VEW0HaDzyCWJYc69s0hVpCdgAjMLE0Nc+MenvUp
	 l8FEgM1EHZpAHa5JoDi4I3HLqPM4/AN5zvtzF3WrMcrqc7s6ljAgc0p6JUyrRSGP4V
	 2GS0ijpdxoShZoXyrMXLZFbHvRVbwbBIP85D8Few=
Received: from fx408 (fx408.security-mail.net [127.0.0.1]) by
 fx408.security-mail.net (Postfix) with ESMTP id 9DBCC322B32; Mon, 22 Jul
 2024 11:43:16 +0200 (CEST)
Received: from srvsmtp.lin.mbt.kalray.eu (unknown [217.181.231.53]) by
 fx408.security-mail.net (Postfix) with ESMTPS id 1D4C1322858; Mon, 22 Jul
 2024 11:43:16 +0200 (CEST)
Received: from junon.lan.kalrayinc.com (unknown [192.168.37.161]) by
 srvsmtp.lin.mbt.kalray.eu (Postfix) with ESMTPS id E05CE40317; Mon, 22 Jul
 2024 11:43:15 +0200 (CEST)
X-Quarantine-ID: <V8Dq4_Lk7tQp>
X-Secumail-id: <7edc.669e29b4.1b2d3.0>
From: ysionneau@kalrayinc.com
To: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jonathan Borne <jborne@kalrayinc.com>, Julian
 Vetter <jvetter@kalrayinc.com>, Yann Sionneau <ysionneau@kalrayinc.com>
Cc: Jules Maselbas <jmaselbas@zdiv.net>, devicetree@vger.kernel.org
Subject: [RFC PATCH v3 03/37] dt-bindings: Add binding for kalray,kv3-1-intc
Date: Mon, 22 Jul 2024 11:41:14 +0200
Message-ID: <20240722094226.21602-4-ysionneau@kalrayinc.com>
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

Add binding for Kalray kv3-1 core interrupt controller.

Co-developed-by: Jules Maselbas <jmaselbas@zdiv.net>
Signed-off-by: Jules Maselbas <jmaselbas@zdiv.net>
Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
---

Notes:

V2 -> V3: Fixed bindings to adhere to dt schema
---
 .../kalray,kv3-1-intc.yaml                    | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-intc.yaml
new file mode 100644
index 0000000000000..9c8bb2c8c49dd
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-intc.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/kalray,kv3-1-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Kalray kv3-1 Core Interrupt Controller
+
+maintainers:
+  - Jonathan Borne <jborne@kalrayinc.com>
+  - Julian Vetter <jvetter@kalrayinc.com>
+  - Yann Sionneau <ysionneau@kalrayinc.com>
+
+description: |
+  The Kalray Core Interrupt Controller is tightly integrated in each kv3 core
+  present in the Coolidge SoC.
+
+  It provides the following features:
+  - 32 independent interrupt sources
+  - 2-bit configurable priority level
+  - 2-bit configurable ownership level
+
+properties:
+  compatible:
+    const: kalray,kv3-1-intc
+
+  "#interrupt-cells":
+    const: 1
+    description:
+      The IRQ number.
+
+  "#address-cells":
+    const: 0
+
+  interrupt-controller: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - "#interrupt-cells"
+  - "#address-cells"
+  - interrupt-controller
+
+examples:
+  - |
+    intc: interrupt-controller {
+        compatible = "kalray,kv3-1-intc";
+        #interrupt-cells = <1>;
+        #address-cells = <0>;
+        interrupt-controller;
+    };
+
+...
-- 
2.45.2






