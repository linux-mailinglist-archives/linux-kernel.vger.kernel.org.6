Return-Path: <linux-kernel+bounces-273165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EFF946525
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8270D28231D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB5E132111;
	Fri,  2 Aug 2024 21:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mTSg/y5j"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3AC8287A;
	Fri,  2 Aug 2024 21:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722634796; cv=none; b=rDhEZdvSkHscNF42VjW1mxyx8f4N4K/mA526TTTv98fHxxS/w3EmOH+bph+seGSfqNkrX9hPCdhdzQlwviGAbZ/I8OqAivgMuPyOSypo+7mIIjOf19Cc0tf0db6MwCjQRL50nfZHvo3o7Mc1bACQtRNxrQeLDwlKwCjxH4UrRr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722634796; c=relaxed/simple;
	bh=8kARDOUlK4s9GI+774yHjLROrqqrO3C+7cC+cdMj2NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ODc5omWlGA1Q1UzYeB0l2RHGVt3GkP4NjxOBmDlB+0SOVPTi+DK6jJElw702/kktPc+a4FLRoBVzJTLEEf9hHURbrOyhB7sdzqm4vqlWq7yV/Q6FaZqt4nkUic4KsQI2kKdRdNI25RfDePOD+N9kjuHW46Jc18LZ8z46fNrhjc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mTSg/y5j; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722634792;
	bh=8kARDOUlK4s9GI+774yHjLROrqqrO3C+7cC+cdMj2NQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mTSg/y5jI41lRHf3B9hbeIfBbNo3wITlfTKdXqnEbUIyvSSLIddX9KtDmZJN+k0X6
	 cA+0gnuOouSIa5zv1czj4lcawGTuop7QQGbTuMKbASt4DyEsFYlkY7VioKZkNoL7ax
	 yxhArH8QodEX1MLGzl1JuZO/6o1Kdi0Brmqq3orZUGknk78xroZBtMQsPpLUuOSPQD
	 v8BQGTf6OlR0MEUDL3eFd0KUeWWeWNMmcDo+GprX/DaUxWnJCwKLCullJLCK5hUzfO
	 aYS+WE7t/0nF+wCtD/YC0iOn/rIM6dFO0eV+FSz0btiC0Hf16OsYsjg/S3Gv4RZjgo
	 QPvMJiLJyxN2A==
Received: from trenzalore.hitronhub.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 65AEE378221A;
	Fri,  2 Aug 2024 21:39:50 +0000 (UTC)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v2 1/3] dt-bindings: clock: add rk3576 cru bindings
Date: Fri,  2 Aug 2024 17:35:39 -0400
Message-ID: <20240802214053.433493-2-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240802214053.433493-1-detlev.casanova@collabora.com>
References: <20240802214053.433493-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the device tree bindings of the rockchip rk3576 SoC
clock and reset unit.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 .../bindings/clock/rockchip,rk3576-cru.yaml   | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3576-cru.yaml

diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3576-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3576-cru.yaml
new file mode 100644
index 0000000000000..929eb6183bf18
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3576-cru.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/rockchip,rk3576-cru.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip rk3576 Family Clock and Reset Control Module
+
+maintainers:
+  - Elaine Zhang <zhangqing@rock-chips.com>
+  - Heiko Stuebner <heiko@sntech.de>
+
+description: |
+  The RK3576 clock controller generates the clock and also implements a reset
+  controller for SoC peripherals. For example it provides SCLK_UART2 and
+  PCLK_UART2, as well as SRST_P_UART2 and SRST_S_UART2 for the second UART
+  module.
+  Each clock is assigned an identifier and client nodes can use this identifier
+  to specify the clock which they consume. All available clock and reset IDs
+  are defined as preprocessor macros in dt-binding headers.
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3576-cru
+
+  reg:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 1
+
+  "#reset-cells":
+    const: 1
+
+  clocks:
+    minItems: 2
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: xin24m
+      - const: xin32k
+
+  assigned-clocks: true
+
+  assigned-clock-rates: true
+
+  assigned-clock-parents: true
+
+  rockchip,grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: >
+      phandle to the syscon managing the "general register files". It is used
+      for GRF muxes, if missing any muxes present in the GRF will not be
+      available.
+
+required:
+  - compatible
+  - reg
+  - "#clock-cells"
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    cru: clock-controller@27200000 {
+      compatible = "rockchip,rk3576-cru";
+      reg = <0xfd7c0000 0x5c000>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
-- 
2.46.0


