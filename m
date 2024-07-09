Return-Path: <linux-kernel+bounces-245802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D7F92B986
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 291891C2217E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F1D15B98D;
	Tue,  9 Jul 2024 12:31:50 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7871D14F9E9;
	Tue,  9 Jul 2024 12:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720528310; cv=none; b=hAm7bNrATcwEFJjcBEnKWVg9KbDR2zFVSbxRn1ugBGM2KzoI2KDXKqjanJWQ3scQmGXxTuGYHZDyOZuFGyBGqvPvJcHAIHF1hyIu+4zI25VOqD7T5UPqd9ktfaUKMBqOOxp36hKCfauF1c8Sm6T3YARWmd/oft+ivwWPlL1YAFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720528310; c=relaxed/simple;
	bh=DLUP+4DFqt8OqH54ZJCPXCGAcXTBzv6FQz/50YIgfYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sEJJCjaq7ofZEmTx8SQ6cn5NK//AWf/KwGhyrGa5Bt8wZxw5cSQ87uMm1hgQFXcKmI8SrGOy+Wn6rUMjIhgPBNk1gduSx7brwDM7G0lJpwiX7lUimFRPp8iVwfY9tZZI+JakZF49tLGp6bKvd5KLpZvMXV+l+NjdVBqs8iCBWjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860d18.versanet.de ([94.134.13.24] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sRA0T-00074P-3S; Tue, 09 Jul 2024 14:31:41 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: mturquette@baylibre.com,
	sboyd@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	quentin.schulz@cherry.de,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH 1/6] dt-bindings: clocks: add binding for generic clock-generators
Date: Tue,  9 Jul 2024 14:31:16 +0200
Message-Id: <20240709123121.1452394-2-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240709123121.1452394-1-heiko@sntech.de>
References: <20240709123121.1452394-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In contrast to fixed clocks that are described as ungateable, boards
sometimes use additional clock generators for things like PCIe reference
clocks, that need actual supplies to get enabled and enable-gpios to be
toggled for them to work.

This adds a binding for such clock generators that are not configurable
themself, but need to handle supplies for them to work.

While in a lot of cases the type of the IC used is described in board
schematics, in some cases just a generic type description like
"100MHz, 3.3V" might also be used. The binding therefore allows both
cases. Specifying the type is of course preferred.

The clock-frequency is set in devicetree, because while some clock
generators have pins to decide between multipls output rates, those
are generally set statically on the board-layout-level.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../bindings/clock/clock-generator.yaml       | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/clock-generator.yaml

diff --git a/Documentation/devicetree/bindings/clock/clock-generator.yaml b/Documentation/devicetree/bindings/clock/clock-generator.yaml
new file mode 100644
index 0000000000000..f44e61e414e89
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/clock-generator.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/clock-generator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Simple clock generators
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+properties:
+  $nodename:
+    anyOf:
+      - description:
+          Preferred name is 'clock-<freq>' with <freq> being the output
+          frequency as defined in the 'clock-frequency' property.
+        pattern: "^clock-([0-9]+|[a-z0-9-]+)$"
+      - description: Any name allowed
+        deprecated: true
+
+  compatible:
+    oneOf:
+      - const: clock-generator
+      - items:
+          - enum:
+              - diodes,pi6c557-03b
+              - diodes,pi6c557-05b
+          - const: clock-generator
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
+      the clock generator.
+    maxItems: 1
+
+  vdd-supply:
+    description: handle of the regulator that provides the supply voltage
+
+required:
+  - compatible
+  - "#clock-cells"
+  - clock-frequency
+
+additionalProperties: false
+
+examples:
+  - |
+    clock {
+      compatible = "clock-generator";
+      #clock-cells = <0>;
+      clock-frequency = <1000000000>;
+    };
+...
-- 
2.39.2


