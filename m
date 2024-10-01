Return-Path: <linux-kernel+bounces-345193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C3098B2FB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 06:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF2FA283A14
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 04:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE071B5EC4;
	Tue,  1 Oct 2024 04:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="ZLb3Hg5J"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474731B5839;
	Tue,  1 Oct 2024 04:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727756749; cv=none; b=BMZXfpnIlQ6UfkW5EtspMAGsMGneOIatEy6KMPAJp8l+p/f8fz6mMUsfb1g5qIO1y/uiSKNizuBhoX6VvQqx67rgheU3DI7a4Z3aoWBsWOLDecBK3L1F+TbREg8hividJSJbFIf39YdoKEhkyvaH+ytmEQLFkP22IW2h3LpOnPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727756749; c=relaxed/simple;
	bh=5MrQbBokfZMOsLxeFgXKXqngGLTWAVulicUDVAiD3dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZjkrY4FaLUcdzbMDQhn1T9gSj9eISeKPvpMEIS9Ul3DuIj7wFeNzBkRNq8Cl+ggiQNWQetxM1VmXbIOCk7vhf3vkaXVIPxEVzj58sLrqKsYs74vNGOnEhtNcYUM2EJKmUsG6PwqFoCLCoIYC4UCNHZDgBdWo/XZdmTqiB3SOcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=ZLb3Hg5J; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id E3B8023DA2;
	Tue,  1 Oct 2024 06:25:45 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1GZLnuBHkKf2; Tue,  1 Oct 2024 06:25:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1727756745; bh=5MrQbBokfZMOsLxeFgXKXqngGLTWAVulicUDVAiD3dc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZLb3Hg5JpYgyHICNo8PHo4FdgSJ1G15e47gYb5CK8D2WLjhQ5T/fw6PIa1TmdV9SM
	 8eq+uFmPbLAqquCYQoXg+fLbNlKvgQcuUcW2DTiDRvvsDDKJy0Gj/Ei9O/G7r8eikk
	 QcV0pCNdKtAN8Qfc7yJf6LPleddthpbxyOotK/QQx3yFtKKSpygBMYGK3+LrZXnfXY
	 ItcZlTAkQ04tyU1JYY+2F4u7fJS6wCzJwpfHdmUr5rzpxbGZY58g8pExdOR1yQoLk6
	 VOOKD62hErQXD6SEwCznQCFi1hnBMIaSV5gnNjF0pTa5LoCdOazF1MmfU+sxZAt3v7
	 xcB56LadeQYQQ==
From: Yao Zi <ziyao@disroot.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Celeste Liu <CoelacanthusHex@gmail.com>,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH 3/8] dt-bindings: clock: Add rockchip,rk3528-cru
Date: Tue,  1 Oct 2024 04:23:57 +0000
Message-ID: <20241001042401.31903-5-ziyao@disroot.org>
In-Reply-To: <20241001042401.31903-2-ziyao@disroot.org>
References: <20241001042401.31903-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document Rockchip RK3528 clock and reset unit.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 .../bindings/clock/rockchip,rk3528-cru.yaml   | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3528-cru.yaml

diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3528-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3528-cru.yaml
new file mode 100644
index 000000000000..ae51dfde5bb9
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3528-cru.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/rockchip,rk3528-cru.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip RK3528 Clock and Reset Controller
+
+maintainers:
+  - Yao Zi <ziyao@disroot.org>
+
+description: |
+  The RK3528 clock controller generates the clock and also implements a reset
+  controller for SoC peripherals. For example, it provides SCLK_UART0 and
+  PCLK_UART0 as well as SRST_P_UART0 and SRST_S_UART0 for the first UART
+  module.
+  Each clock is assigned an identifier, consumer nodes can use it to specify
+  the clock. All available clock and reset IDs are defined in dt-binding
+  headers.
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3528-cru
+
+  reg:
+    maxItems: 1
+
+  assigned-clocks: true
+
+  assigned-clock-rates: true
+
+  clocks:
+    minItems: 2
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: xin24m
+      - const: phy_50m_out
+
+  "#clock-cells":
+    const: 1
+
+  "#reset-cells":
+    const: 1
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
+    cru: clock-controller@ff4a0000 {
+        compatible = "rockchip,rk3528-cru";
+        reg = <0xff4a0000 0x30000>;
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+    };
-- 
2.46.0


