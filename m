Return-Path: <linux-kernel+bounces-344840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B13E98AED2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD4FF1C22AE2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6FB1A0BED;
	Mon, 30 Sep 2024 21:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Jrj4LPkH"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C3F17CA1B;
	Mon, 30 Sep 2024 21:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727730273; cv=none; b=jkZyFQkdTkRu5VntNNK03J9MqDsF9wqwsnwNGFxjC5P59/XMLY0tgMHW3ivbs0fcltKv69QOAEdSlJtXpdPm0Ac/D+BSSU7tbXBOVAgV+DHdtqpE1jgFWE7rmve2L42IfcImB6gIaYBMDhDeCp7QhxkUz4kRQpIYj9plw3fMtLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727730273; c=relaxed/simple;
	bh=s6NZsPtURPNvt13a+YAayRjW35F2DCFucwm2FL4TMAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OJloLZH7QYRdLfQCsgUe8CGDhXeVIMkNQd8r6/M8vZh4/VIEnwod1QG0kRajyQRRldiACcM7wGuGviSm4BtJ2LkLFkB8K4TGVoLhSxauApTse3ci1rA9JlZTZ3SfwFue9WfnK+uAdB/aCt1zg5cvKNpwUYQTCfy6JjrV+Qpg3p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Jrj4LPkH; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5fx3V1fw5iBFqrziJcCAoQs3pzlQ+VIh1ghxNkzwjBs=; b=Jrj4LPkHxLPrt5f6QyIS0tlDHC
	tRfsJiCuDFQGXISGQTBGV7Cu9TXe12xKV25U3tTzpESGLSAFKX9AVD31bx6jEa+/Cv/drTo6F8ru3
	ibCIDYhJPOr51s/0LH6YbIVHXvJEaqZBMAxcaEYbIBSIbNcYhp6pQqD7BOBVsqTT591PYXJXhWT+M
	YiDlyKH++AnpHhyCJO5QHkki78VqoLbc2qP1xdhPM+mHpt/j9rCaYtYS172qjAdarhRFjfgFYwwp6
	ElqoeJWH8OQ4S+Lr5HlCS0wUAjUppJECKQdGVP/An4TFd02Cp2Z141Q3YWDjYjbktH8lRPnZpBKTA
	yZBlAPNA==;
Received: from i5e861925.versanet.de ([94.134.25.37] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1svNZE-0008Bk-MI; Mon, 30 Sep 2024 23:04:28 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH] dt-bindings: regulator: vctrl-regulator: convert to YAML
Date: Mon, 30 Sep 2024 23:04:24 +0200
Message-ID: <20240930210424.1994047-1-heiko@sntech.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the vctrl-regulator bindings to DT schema.
This resolves a dtbs check warning for the rk3399-gru devices.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../bindings/regulator/vctrl-regulator.yaml   | 80 +++++++++++++++++++
 .../devicetree/bindings/regulator/vctrl.txt   | 49 ------------
 2 files changed, 80 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/vctrl-regulator.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/vctrl.txt

diff --git a/Documentation/devicetree/bindings/regulator/vctrl-regulator.yaml b/Documentation/devicetree/bindings/regulator/vctrl-regulator.yaml
new file mode 100644
index 000000000000..2311f79990a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/vctrl-regulator.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/vctrl-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Voltage controlled regulators
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+allOf:
+  - $ref: regulator.yaml#
+
+properties:
+  compatible:
+    const: vctrl-regulator
+
+  ctrl-supply:
+    description: Regulator supplying the control voltage
+
+  ctrl-voltage-range:
+    description:
+      Array of two integer values describing the range (min/max) of the
+      control voltage. The values specify the control voltage needed to
+      generate the corresponding regulator-min/max-microvolt output
+      voltage.
+    minItems: 2
+    maxItems: 2
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
+  min-slew-down-rate:
+    description:
+      Describes how slowly the regulator voltage will decay down in the
+      worst case (lightest expected load). Specified in uV / us (like
+      main regulator ramp rate). This value is required when
+      ovp-threshold-percent is specified.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  ovp-threshold-percent:
+    description:
+      Overvoltage protection (OVP) threshold of the regulator in percent.
+      Some regulators have an OVP circuitry which shuts down the regulator
+      when the actual output voltage deviates beyond a certain margin from
+      the expected value for a given control voltage. On larger voltage
+      decreases this can occur undesiredly since the output voltage does
+      not adjust immediately to changes in the control voltage. To avoid
+      this situation the vctrl driver breaks down larger voltage decreases
+      into multiple steps, where each step is within the OVP threshold.
+    minimum: 0
+    maximum: 100
+
+unevaluatedProperties: false
+
+dependencies:
+  ovp-threshold-percent: [ min-slew-down-rate ]
+
+required:
+  - compatible
+  - ctrl-supply
+  - ctrl-voltage-range
+  - regulator-min-microvolt
+  - regulator-max-microvolt
+
+examples:
+  - |
+    vctrl-reg {
+            compatible = "vctrl-regulator";
+            regulator-name = "vctrl_reg";
+
+            ctrl-supply = <&ctrl_reg>;
+            ctrl-voltage-range = <200000 500000>;
+
+            min-slew-down-rate = <225>;
+            ovp-threshold-percent = <16>;
+
+            regulator-min-microvolt = <800000>;
+            regulator-max-microvolt = <1500000>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/regulator/vctrl.txt b/Documentation/devicetree/bindings/regulator/vctrl.txt
deleted file mode 100644
index e940377cfd69..000000000000
--- a/Documentation/devicetree/bindings/regulator/vctrl.txt
+++ /dev/null
@@ -1,49 +0,0 @@
-Bindings for Voltage controlled regulators
-==========================================
-
-Required properties:
---------------------
-- compatible		  : must be "vctrl-regulator".
-- regulator-min-microvolt : smallest voltage consumers may set
-- regulator-max-microvolt : largest voltage consumers may set
-- ctrl-supply		  : The regulator supplying the control voltage.
-- ctrl-voltage-range	  : an array of two integer values describing the range
-			    (min/max) of the control voltage. The values specify
-			    the control voltage needed to generate the corresponding
-			    regulator-min/max-microvolt output voltage.
-
-Optional properties:
---------------------
-- ovp-threshold-percent	: overvoltage protection (OVP) threshold of the
-			  regulator in percent. Some regulators have an OVP
-			  circuitry which shuts down the regulator when the
-			  actual output voltage deviates beyond a certain
-			  margin from the expected value for a given control
-			  voltage. On larger voltage decreases this can occur
-			  undesiredly since the output voltage does not adjust
-			  immediately to changes in the control voltage. To
-			  avoid this situation the vctrl driver breaks down
-			  larger voltage decreases into multiple steps, where
-			  each step is within the OVP threshold.
-- min-slew-down-rate	: Describes how slowly the regulator voltage will decay
-			  down in the worst case (lightest expected load).
-			  Specified in uV / us (like main regulator ramp rate).
-			  This value is required when ovp-threshold-percent is
-			  specified.
-
-Example:
-
-	vctrl-reg {
-		compatible = "vctrl-regulator";
-		regulator-name = "vctrl_reg";
-
-		ctrl-supply = <&ctrl_reg>;
-
-		regulator-min-microvolt = <800000>;
-		regulator-max-microvolt = <1500000>;
-
-		ctrl-voltage-range = <200000 500000>;
-
-		min-slew-down-rate = <225>;
-		ovp-threshold-percent = <16>;
-	};
-- 
2.43.0


