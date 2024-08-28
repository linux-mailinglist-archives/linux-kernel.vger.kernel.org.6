Return-Path: <linux-kernel+bounces-304759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4400296247B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC691B221E1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CD015B98E;
	Wed, 28 Aug 2024 10:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Ng3MEAGJ"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2B9158DCD;
	Wed, 28 Aug 2024 10:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724840120; cv=none; b=qc/ltWgfrlc7D33fkbG41tWDfYx5ZxWtW91FQK9VaB9fhFso6+3hYLW/GqCIgKfUGMD7j6IfxI4CLJ7OnOg7d8bfQeT5C+jl51BkXaJo1Zdrpsq/3RE20PjylM73m6MS+JbZmzuZuQA054J+LkayeLqVp6oV51SGtrRwZV0p8zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724840120; c=relaxed/simple;
	bh=hGf2gkLd69NQ7KFBnipSAkYCVhNpqHakg4YOOi15HAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQ4S83MIg8WGR8YxllrxbUhe2rfJqemSPzYHkeZETZASwTZS/1fnncR9T97WfQQ1W97nYnfIdxwC6ikCAouSGIB8RvHbeaXy1SzM6c1D2+IfDrfFoo9o30Q4aHhWC+JVwBi/b3dSbg5jda8/k/HTvVynXIzIFopAmlEWGh0NmmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Ng3MEAGJ; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=H2K0zAoArSYqxte5X2D4PhODsFIDA8efuofXW5WP5do=; b=Ng3MEAGJ2czRhxq3mImVOHknWx
	TEbw0Nm6FsoEYe7ymgW0ivBDzvWutrqN32bLfl6BKPBVNDvnwo35StNPtfpifr4ziIx1GQLOqpjGv
	omypbq5QJk+T/Npzv5sd6zHn45pL2Y/d/LuHx8ogdUi3lpZoZrIN0Pn/jsoSUe8oe5GI0vy+95DkD
	inFffYhQIrTtO9uLNbqNbakQ2mDFPgNfDV6MxOx8j7Fl/Pt8RzW6fwz3ySL+PNk1KgflXSRNUXe3i
	mkA7Y2pE+ahLJaxsK8lrVDVGbnJYGsJO0xqeiuOEL1FYb2ujXU5RNU2HRs8GbD5IDwCctGL4n9SRo
	B57WXp2w==;
Received: from i5e8616cd.versanet.de ([94.134.22.205] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sjFhs-0004M3-94; Wed, 28 Aug 2024 12:15:16 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: mturquette@baylibre.com,
	sboyd@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-clk@vger.kernel.org,
	heiko@sntech.de,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v3 1/5] dt-bindings: clocks: add binding for gated-fixed-clocks
Date: Wed, 28 Aug 2024 12:14:59 +0200
Message-ID: <20240828101503.1478491-2-heiko@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240828101503.1478491-1-heiko@sntech.de>
References: <20240828101503.1478491-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In contrast to fixed clocks that are described as ungateable, boards
sometimes use additional oscillators for things like PCIe reference
clocks, that need actual supplies to get enabled and enable-gpios to be
toggled for them to work.

This adds a binding for such oscillators that are not configurable
themself, but need to handle supplies for them to work.

In schematics they often can be seen as

         ----------------
Enable - | 100MHz,3.3V, | - VDD
         |    3225      |
   GND - |              | - OUT
         ----------------

or similar. The enable pin might be separate but can also just be tied
to the vdd supply, hence it is optional in the binding.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../bindings/clock/gated-fixed-clock.yaml     | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/gated-fixed-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/gated-fixed-clock.yaml b/Documentation/devicetree/bindings/clock/gated-fixed-clock.yaml
new file mode 100644
index 000000000000..76d264770d35
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/gated-fixed-clock.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/gated-fixed-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Gated Fixed clock
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+properties:
+  compatible:
+    const: gated-fixed-clock
+
+  "#clock-cells":
+    const: 0
+
+  clock-frequency: true
+
+  clock-output-names:
+    maxItems: 1
+
+  enable-gpios:
+    description:
+      Contains a single GPIO specifier for the GPIO that enables and disables
+      the oscillator.
+    maxItems: 1
+
+  vdd-supply:
+    description: handle of the regulator that provides the supply voltage
+
+required:
+  - compatible
+  - "#clock-cells"
+  - clock-frequency
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    voltage-oscillator {
+      compatible = "gated-fixed-clock";
+      #clock-cells = <0>;
+      clock-frequency = <1000000000>;
+      vdd-supply = <&reg_vdd>;
+    };
+...
-- 
2.43.0


