Return-Path: <linux-kernel+bounces-318435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1189196EDD6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3015285EA1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5741158862;
	Fri,  6 Sep 2024 08:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="DjQGJgq/"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725E4158538;
	Fri,  6 Sep 2024 08:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725611123; cv=none; b=lx+2q4hpOpS4AV+yOuZZtBBoCa58iz2y4QvKvxG+SDbe3nXzeaOX8S4dWlSP15ATwtdGaqgr+RGzad/rVXzONSoD0oAiqCXxohDQkGXSgRZK42K2Y+mDsa16UiFmX1QQ95HknD1ErEpuZhcBTpsosxULDXmDjB/kB7TeEF+zI5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725611123; c=relaxed/simple;
	bh=aFR7tnhmuKRaAKDJZCHPL+0HzSPymvIBsaXDCAKTrJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ox5/+B/nDbxB+hzo/CnULtMNQKj94PjJXqYMOoekWZSbJOgfDLSUVccLKVa4nWF4g+wyX7lHWb9ry0zEVQvPbdHDXxv0GCR5Z8twzkiXCzE+9+DRxOaHRbRPLM71umTDz6/Zx7+ViSZ6icxyTSg4LoQsG65t0V80pvRcV7y6RHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=DjQGJgq/; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QLt5ROu80qBeLulyysZjT7aHie2yMAENhMSfHIXMOWc=; b=DjQGJgq/ozrgD2AaOtIPaA5vBH
	nJ849xmtFv3gWbWX/w/rMplyVT8U77tAIPar4rP2kJ68acfvOrVGkyE+QwKO/d0yhIiB41VU46KI3
	0fi+l+6o3vXqW/bEWyqdEvhQER1iNUJLwdk2TeOciZNq/XBlC59onC9mFs+SiNnhVm790pcRD+Pnq
	7f5BxJfFRfFQgViHPjxk2YpgNNirVH6Y84gsx9+dgNkc6CUzg75MslfQSVWzc5CUnn/OAcwQWsC2v
	ydliDLTnoNMTm7K2FA1K/6Lg97cw+H2b5ccrmemIMoYefA9KlTSvpGzbgp0VLdvffGuvlSpTvcL6v
	8t6wxXmw==;
Received: from i5e860d0f.versanet.de ([94.134.13.15] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1smUHO-0000jF-Pt; Fri, 06 Sep 2024 10:25:18 +0200
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
	linux-rockchip@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/5] dt-bindings: clocks: add binding for gated-fixed-clocks
Date: Fri,  6 Sep 2024 10:25:07 +0200
Message-ID: <20240906082511.2963890-2-heiko@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240906082511.2963890-1-heiko@sntech.de>
References: <20240906082511.2963890-1-heiko@sntech.de>
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
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/clock/gated-fixed-clock.yaml     | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/gated-fixed-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/gated-fixed-clock.yaml b/Documentation/devicetree/bindings/clock/gated-fixed-clock.yaml
new file mode 100644
index 000000000000..d3e0faf3c64d
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
+    clock-1000000000 {
+      compatible = "gated-fixed-clock";
+      #clock-cells = <0>;
+      clock-frequency = <1000000000>;
+      vdd-supply = <&reg_vdd>;
+    };
+...
-- 
2.43.0


