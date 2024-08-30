Return-Path: <linux-kernel+bounces-309378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24861966986
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 21:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4953A1C2184D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02E51BDABD;
	Fri, 30 Aug 2024 19:26:57 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB141BD028
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 19:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725046016; cv=none; b=UwROLxeX+zgTTDAE6vnY+G157QL4dXI+jbf//ddPh30WVBBXUXjwYvoq0EN2tafd3o01tdjKU6AfeEJsP7uOPMLbbOBPyCpiO7VjR2xm2mOrLps7sLB5AgWG0e4IXI8t+unWPm5T9eAWPVqyPFWGoiXaNDJIDwarG/m9A8UzvFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725046016; c=relaxed/simple;
	bh=ZqYWMtyrGWI+DE0ip880R/3MA9gTBkSpAwRLmioirEI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VMatNmAgr69ISIPxNKPvrL9mWNwHIhnNi6mpgT7JlywiLDVn2Hf7/6RWu37CvojqFbccvjBd3Z8K34Khl9DFh/BrKz5YJ6ux8JIUIxzj8EJ7IcJFBrUBqUBjVwdCPFTS98rXcGsKEGfKglMfZ+13bLB0HYwAqw5CaKgMXuX5NJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk7Gn-00068m-BC
	for linux-kernel@vger.kernel.org; Fri, 30 Aug 2024 21:26:53 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk7Gl-004Df4-4X
	for linux-kernel@vger.kernel.org; Fri, 30 Aug 2024 21:26:51 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id BDEFD32E15F
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 19:26:50 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id E9ED232E0EE;
	Fri, 30 Aug 2024 19:26:45 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 06327bef;
	Fri, 30 Aug 2024 19:26:45 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 30 Aug 2024 21:25:58 +0200
Subject: [PATCH can-next v3 01/20] dt-bindings: can: rockchip_canfd: add
 rockchip CAN-FD controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-rockchip-canfd-v3-1-d426266453fa@pengutronix.de>
References: <20240830-rockchip-canfd-v3-0-d426266453fa@pengutronix.de>
In-Reply-To: <20240830-rockchip-canfd-v3-0-d426266453fa@pengutronix.de>
To: kernel@pengutronix.de, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 David Jander <david.jander@protonic.nl>
Cc: Simon Horman <horms@kernel.org>, linux-can@vger.kernel.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=2962; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=ZqYWMtyrGWI+DE0ip880R/3MA9gTBkSpAwRLmioirEI=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBm0hzX6+Nn8nhElPP2Q042ZgQTmKKPk6r8mCLry
 x96UlbW6TyJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZtIc1wAKCRAoOKI+ei28
 b7GeB/wJNwTHxmEwZ8UOuRl0GaCTPzH+/C/ubbvie6+fmfM8EQzNGCINpnOG6hwhrnFKb202wNw
 39Q54Awy2+NTdVYlWMl2la1PZ28jSOpZuoGtZOFE65k1hDm8znxQrtiCa8Zl+rAH5oKcXHoeX0b
 1HcU7LNE5JAzTaQ6cyHS2YklF0egzGlvuAXldoOm50Yj4vuvKACHBykgSH1xyndGM0nTXyzP3VK
 /lk1AYLm1EmA8V5iR9b3WZ4C2T6YdnZooJ7Z2AswZXRshsAyi1yoSrySZbZPAI9lDmHYQVPRE2P
 DQ95cBHv05L+fiVvV+3rXL92pbejaHkXDspGbn72QtuSZVyS
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Add documentation for the rockchip rk3568 CAN-FD controller.

Co-developed-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../bindings/net/can/rockchip,rk3568-canfd.yaml    | 74 ++++++++++++++++++++++
 MAINTAINERS                                        |  7 ++
 2 files changed, 81 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/rockchip,rk3568-canfd.yaml b/Documentation/devicetree/bindings/net/can/rockchip,rk3568-canfd.yaml
new file mode 100644
index 000000000000..022ae799b0cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/rockchip,rk3568-canfd.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/can/rockchip,canfd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title:
+  Rockchip CAN-FD controller
+
+maintainers:
+  - Marc Kleine-Budde <mkl@pengutronix.de>
+
+allOf:
+  - $ref: can-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: rockchip,rk3568v2-canfd
+      - items:
+          - const: rockchip,rk3568v3-canfd
+          - const: rockchip,rk3568v2-canfd
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: baud
+      - const: pclk
+
+  resets:
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: core
+      - const: apb
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3568-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        can@fe570000 {
+            compatible = "rockchip,rk3568v2-canfd";
+            reg = <0x0 0xfe570000 0x0 0x1000>;
+            interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&cru CLK_CAN0>, <&cru PCLK_CAN0>;
+            clock-names = "baud", "pclk";
+            resets = <&cru SRST_CAN0>, <&cru SRST_P_CAN0>;
+            reset-names = "core", "apb";
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index baf88e74c907..115307354f0b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19730,6 +19730,13 @@ F:	Documentation/ABI/*/sysfs-driver-hid-roccat*
 F:	drivers/hid/hid-roccat*
 F:	include/linux/hid-roccat*
 
+ROCKCHIP CAN-FD DRIVER
+M:	Marc Kleine-Budde <mkl@pengutronix.de>
+R:	kernel@pengutronix.de
+L:	linux-can@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/can/rockchip,rk3568-canfd.yaml
+
 ROCKCHIP CRYPTO DRIVERS
 M:	Corentin Labbe <clabbe@baylibre.com>
 L:	linux-crypto@vger.kernel.org

-- 
2.45.2



