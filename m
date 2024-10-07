Return-Path: <linux-kernel+bounces-353854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 323419933B0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DEC52858FE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AFD1DC077;
	Mon,  7 Oct 2024 16:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="SuVpfxXt"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E4A1DBB03;
	Mon,  7 Oct 2024 16:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319551; cv=none; b=lA4k9/1479JSPaDOBrr5mSXcipGdDxBY6UHzm0bFE+1LjGzf99oyrDFQnkMwN9vXwpfgayCNN10ZiIw/sxaF84gUUJC0QjeQZKbJKUuPEmKuDVQ0U5RhOIsH9hYNHlohY5lkFRSGckZWYBHOifk+Nw8tG8cTJ9TCpsHVWU+uBFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319551; c=relaxed/simple;
	bh=yFB+QWN/l8F6U9qeO8dL+RgHadwGnwUIxUq7V7LW/E4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QS7Uu6KVYkpazJuoFfQ6kbuC0iAuTb2pEZzlyDQyj2QhChnuiMpq4cJNNG9obx35FGd8BebtfiUuAPm5fCNQWZFVqPmW8jtKNGWcOshldhGYdAqQN9j5wdLXAZBBYe78SgS/zQtpgdKJODnriljeYj0wy3/BYpCR8n4aZOiPMdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=SuVpfxXt; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=r0AuEeSC4qr1idtraZXrY2GOnVpY73RCyu2a/wbcIbI=; b=SuVpfxXtsafoPg8bbWoiWO3eO1
	2Bq3cXcIxdWa2fUpg7lP+rSGHOgrW1XaXbDM/MeRuzVNUjrmMQe6AvyKmmpPl/ae3uM/uQdvyy40Y
	FOGa9f3v7XcXngFhKrGwLUNUQ4sZ72my2nLnwzJZir/CA8WQGAXex5FhDNXyFdFqAjH0mBYSkmlKu
	MDGZKcd2rt7P/+CfqyXhe6j6+aSrQck816ZafL/0CJ3F4GCNyTr+SRwOCENb0Wz/+rjK5eE9kwLPT
	pp4UZ2ro/QvgYW/7gHb70zqEhZOTSaHiHfV7jOeXOBldnKTHlecOg1+IXySR26799McjzFn2hE/ks
	31FrMMtQ==;
Received: from i5e860d18.versanet.de ([94.134.13.24] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sxqrg-00035s-Fu; Mon, 07 Oct 2024 18:45:44 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH] ASoC: dt-bindings: rockchip,rk3036-codec: convert to yaml
Date: Mon,  7 Oct 2024 18:45:42 +0200
Message-ID: <20241007164542.2452315-1-heiko@sntech.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the binding to yaml.

The codec seems to be from Innosilicon, but the compatible has ever only
been rockchip-based, as they sythesized the codec for the rk3036.

So the yaml file gets a name matching that compatible.
The only other notable change is the addition of the #sound-dai-cells
property, that is always required.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../devicetree/bindings/sound/inno-rk3036.txt | 20 -------
 .../bindings/sound/rockchip,rk3036-codec.yaml | 57 +++++++++++++++++++
 2 files changed, 57 insertions(+), 20 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/inno-rk3036.txt
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip,rk3036-codec.yaml

diff --git a/Documentation/devicetree/bindings/sound/inno-rk3036.txt b/Documentation/devicetree/bindings/sound/inno-rk3036.txt
deleted file mode 100644
index 758de8e27561..000000000000
--- a/Documentation/devicetree/bindings/sound/inno-rk3036.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-Inno audio codec for RK3036
-
-Inno audio codec is integrated inside RK3036 SoC.
-
-Required properties:
-- compatible : Should be "rockchip,rk3036-codec".
-- reg : The registers of codec.
-- clock-names : Should be "acodec_pclk".
-- clocks : The clock of codec.
-- rockchip,grf : The phandle of grf device node.
-
-Example:
-
-	acodec: acodec-ana@20030000 {
-		compatible = "rk3036-codec";
-		reg = <0x20030000 0x4000>;
-		rockchip,grf = <&grf>;
-		clock-names = "acodec_pclk";
-		clocks = <&cru ACLK_VCODEC>;
-	};
diff --git a/Documentation/devicetree/bindings/sound/rockchip,rk3036-codec.yaml b/Documentation/devicetree/bindings/sound/rockchip,rk3036-codec.yaml
new file mode 100644
index 000000000000..786b1ec41999
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rockchip,rk3036-codec.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/rockchip,rk3036-codec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip RK3036 internal codec
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: rockchip,rk3036-codec
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: clock for audio codec
+
+  clock-names:
+    items:
+      - const: acodec_pclk
+
+  rockchip,grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      The phandle of the syscon node for the GRF register.
+
+  "#sound-dai-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - rockchip,grf
+  - "#sound-dai-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3036-cru.h>
+    acodec: audio-codec@20030000 {
+      compatible = "rockchip,rk3036-codec";
+      reg = <0x20030000 0x4000>;
+      rockchip,grf = <&grf>;
+      clock-names = "acodec_pclk";
+      clocks = <&cru ACLK_VCODEC>;
+      #sound-dai-cells = <0>;
+    };
-- 
2.43.0


