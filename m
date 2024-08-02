Return-Path: <linux-kernel+bounces-272633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D2D945F33
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 578B2B21671
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 14:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53BB1E4EF3;
	Fri,  2 Aug 2024 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JkvoRah1"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BC11E4849;
	Fri,  2 Aug 2024 14:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722608238; cv=none; b=M2RLnh7bOqgfcL2Yms/P2R/ORKSMybCiia1jHuX5uAh/9vN1b0+ZCDDRoDfSk9BXMoOxpU2D/HEysPsjYU4rYwuDwTp6MGjHUZ1xHF2k6Pdjro67P8wBxFotquz+m4CFHZUdkfQWvJ0ktBXGorHKI01ouK5d5d6NRBfovSD4qdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722608238; c=relaxed/simple;
	bh=8kARDOUlK4s9GI+774yHjLROrqqrO3C+7cC+cdMj2NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y1BObOwFOgR+nnZLsWgxFYJqThDwj1MhPwYy5QMIJfZjBGu1NCm7qUvso8U2EcN7CQyg2fc6l7c79EoMqM7YBHpoSRSKormmDCW+T6x59Fm6cOKO1j5ZdHZMj7gBuZm5C6CMeRJL8UeatEdz9Lid4cCDIFAVkicDtv9YDDwJwMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JkvoRah1; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722608234;
	bh=8kARDOUlK4s9GI+774yHjLROrqqrO3C+7cC+cdMj2NQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JkvoRah1g3eD8NHJGmrqrznjOtjH2QcPUer0b0BQZfnn3bzvgzQnR9b3yS56ccwlS
	 TI8eYewYvg2FwwTLLBqeLqKT51qWA6zZlZ0D+ffW5C5f4a+fzLGpjntM2lwfNtrpLO
	 /OUKb9der7bz4ob6ljrJojdHGYklEniWn6duw1QZbhmH06348LXsZ42cbCCxCFoqtV
	 EMirmALuLj1stjWKk0oDtqKKxhKDUw3y3enhNgKrXiSWO10NOeGK4kGxrf/cKdxfOV
	 Ms6ramnHFjlAZC9f2Higg3aJswQ8rIt1/tgjsfhZyV0BFrTIe5S5nQ9l7tiKoNV4rx
	 mcOqxLFG2hWRA==
Received: from trenzalore.hitronhub.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9FF9E3782219;
	Fri,  2 Aug 2024 14:17:12 +0000 (UTC)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH 1/3] dt-bindings: clock: add rk3576 cru bindings
Date: Fri,  2 Aug 2024 10:12:48 -0400
Message-ID: <20240802141816.288337-2-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240802141816.288337-1-detlev.casanova@collabora.com>
References: <20240802141816.288337-1-detlev.casanova@collabora.com>
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


