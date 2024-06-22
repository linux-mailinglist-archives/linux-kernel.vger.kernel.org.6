Return-Path: <linux-kernel+bounces-225740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B56E99134A9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 17:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B4681F2381F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 15:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC8216FF45;
	Sat, 22 Jun 2024 15:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d13D9Fyj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FFA16F298;
	Sat, 22 Jun 2024 15:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719068855; cv=none; b=f4fktF3LSR5FL/n1/A4xbL+UnMi1xMX4YWLAKWFhhFqebJZs27cxa5XORAbB9ixUdO1g2NQEZs5kBySv42EG6fd2Eou1ljTWVmS7wDr29x5zflCeTLrioIzgiA2UyzQqyVMEshYqkOb3bDz/8zdeNyLsKGkGK89AA553mJ4SQTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719068855; c=relaxed/simple;
	bh=IkrAfY68bFi4o7WHsDeoec80a79Xpih8gQk2O74LGVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AS5i0jufrCC8m3GP/QpaLsnenQTOpA8QvU6/XyOuwlJFFqZ3Dh+p77IYaTVMmX3sM0c0ApsulL409WEksCaFdnoBKAH6dGbSK7ep5JCal92I0YpqS/yxHwwCB1zH4WLfNZTrZ0PUALd8K7SiATtLQoppL2yL8lfLzB+4Cj0iJ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d13D9Fyj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67ADC4AF0A;
	Sat, 22 Jun 2024 15:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719068854;
	bh=IkrAfY68bFi4o7WHsDeoec80a79Xpih8gQk2O74LGVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d13D9FyjAlFWXRdMgr71ZKD1qPOw+wJTwoX7hVGFBBoiAjJ1STpWSbehVKbnj9Zxt
	 o0+2Ta9E1ngJpPDNlVDg2cSgRNp2tMncWQX8l5r/q7SAQRhlNBcKfbpjPgjS+iYVy5
	 8PXDJQ07Uqb8VTecB+CNOjMtTnIeiPSNtDY3qTtCgFDjn9uTl3ca31H16l956UEJT7
	 57wj8MXzl3rhmTgYllDOUTriq2lDaAe+lByy085XEHrHcgLr0jsB166JjMTi4FtQRT
	 CR2zam6ADrcnmUG0bjckvePbNAELQ2YC2+kkoznM+8x1Drb1e3uMgKR8G8kKaKcf1P
	 SqF7Gk3eFx9zQ==
Received: by wens.tw (Postfix, from userid 1000)
	id A31E15F725; Sat, 22 Jun 2024 23:07:32 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 1/3] dt-bindings: sram: sunxi-sram: Add regulators child
Date: Sat, 22 Jun 2024 23:07:29 +0800
Message-Id: <20240622150731.1105901-2-wens@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240622150731.1105901-1-wens@kernel.org>
References: <20240622150731.1105901-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Samuel Holland <samuel@sholland.org>

Some sunxi SoCs have in-package regulators controlled by a register in
the system control MMIO block. Allow a child node for this regulator
device in addition to SRAM child nodes.

Signed-off-by: Samuel Holland <samuel@sholland.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../allwinner,sun4i-a10-system-control.yaml   | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
index cf07b8f787a6..d9322704f358 100644
--- a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
+++ b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
@@ -56,6 +56,9 @@ properties:
   ranges: true
 
 patternProperties:
+  "^regulators@[0-9a-f]+$":
+    $ref: /schemas/regulator/allwinner,sun20i-d1-system-ldos.yaml#
+
   "^sram@[a-f0-9]+":
     $ref: /schemas/sram/sram.yaml#
     unevaluatedProperties: false
@@ -130,3 +133,28 @@ examples:
         };
       };
     };
+
+  - |
+    syscon@3000000 {
+      compatible = "allwinner,sun20i-d1-system-control";
+      reg = <0x3000000 0x1000>;
+      ranges;
+      #address-cells = <1>;
+      #size-cells = <1>;
+
+      regulators@3000150 {
+        compatible = "allwinner,sun20i-d1-system-ldos";
+        reg = <0x3000150 0x4>;
+
+        reg_ldoa: ldoa {
+          regulator-min-microvolt = <1800000>;
+          regulator-max-microvolt = <1800000>;
+        };
+
+        reg_ldob: ldob {
+          regulator-name = "vcc-dram";
+          regulator-min-microvolt = <1500000>;
+          regulator-max-microvolt = <1500000>;
+        };
+      };
+    };
-- 
2.39.2


