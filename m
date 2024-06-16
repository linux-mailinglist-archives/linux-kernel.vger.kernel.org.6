Return-Path: <linux-kernel+bounces-216300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A80DA909DA7
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 15:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1D4D1C21895
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 13:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4879918FC6A;
	Sun, 16 Jun 2024 13:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uCt++RHt"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2A918F2C5
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 13:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718543984; cv=none; b=t6gdubS15idlu5NfJYpgiA9Unw+xkVIF3rk4Rjn71HlO+7UCm4N1O1hsuN+/8J4J2B6hiT6P3DodeVINPTm1iC5G6DZQ9jkQU4mHH8o0BF2j2j1Yi2CSULw/2m5ZHJEPfTDE99mUTgSAcfBZer1QJFZ5l6RbDx/WqNEc41WjSG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718543984; c=relaxed/simple;
	bh=2G0rLi4cLmhzl8ZJMSFvOy5W9L4JVSO3sWW9FraSLfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NujK6bqnFKVH8R9Z0Q2sM8lkQzuueVlO6Mi/PjXRPfODEt0KED6kVfFUqP1nHOaX3+wCU7XJjhamw3xupKpcr9LqEtmY6ZFaaRAuDAsKE0fhhGVqP5nQrAg5jOVXiEEBj3mkflhLuOg9gmcPBzjO/C4Vjq9OBOV8FrdawbGZUQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uCt++RHt; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57c68c3f8adso4281942a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 06:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718543981; x=1719148781; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LDxj3dPqBsikHw3COW9fzyU/UFgyyuz6MU/96w6Q9SQ=;
        b=uCt++RHtmsmBoF8h5pAxU2GeS+Ox7+znKKaq+etq04cmVVUZbeNDWOIvUkpizPPWF1
         Uk0j55so3oNAtfySLgN6XFo40yuIU+fVNOdyMZbJOGeadxenKfQcwDRmBytqRaL9/FHt
         obc1frhB7n/ZcBjSfd7AAC6QnIZifgsR6iVebiHAnwLPOYy74pKOL5f+jASq1TcVeAXU
         9XZCTPLEDrDv3RMRqLG4Kd9whRoClfDQvNzFozTSVpYCeePaAd9rKZ7n3yHd7E7fAXlI
         TTxpn4zJ3OW3NrvYqW3XmJwXzrtWfyQaong+X4GnBM6nTF/l3aHpi2nGqRAq5d3kODL2
         Ax9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718543981; x=1719148781;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDxj3dPqBsikHw3COW9fzyU/UFgyyuz6MU/96w6Q9SQ=;
        b=sYSYwBhr047y1/FUNSoHXAU5aPYZrsLK0yn/2/hk66OjNEulqC081bgonsLno2bFkd
         srZOdzy3FTaVo1jJ2YZIRxa7uoa8t8Pg5oaQ8Yv1FA5UBNx+clGbVGdl6Jcxagt1E45J
         Xuyyx9zV1f5lSnasGhqyhTPSU1dUheoZ3TTC3Qrzw1IPG7oSTP+EGfUEIiQ8oYzEVthG
         v9PQeWdebPx4g/NL5Cmr4BVI+NnwynxxRs7BFbWKWMYvbW6tpL6tkiOErqj0Z1antPHR
         vt2CuX/+2XzGYtrA/DPN58rLVDOwwATu5GmLBvJPxnOKCAJqGGh+g5x2Vxv776TzN3aB
         BSSg==
X-Forwarded-Encrypted: i=1; AJvYcCVayrqukreffThsyhp9I2yGIkRegB7i7qML3mPYsZT60WD91UEkt3J34K5vxNiASrZv+cu88Hp7Mw2qYJkWwbMFFqS2N2H+4iSN9aYW
X-Gm-Message-State: AOJu0YwlTaJICzuDDmWnUsXBAfJ8lNoDsWovN2KOihjO5oy2+xUGLkhU
	ZjG98n1VayE+1S8/Ai1mIqY7OENAuSEjSJ/Di5SWqtb/R03GTEXYteLDWkyQNls=
X-Google-Smtp-Source: AGHT+IGXkj91rCNRNjyM3+Ufq9rMUAVmp/bvUxrcipMwwyyQmCi9zjaLfs3liz7jMElLGmjYr+sppQ==
X-Received: by 2002:aa7:c419:0:b0:57c:cba1:444e with SMTP id 4fb4d7f45d1cf-57ccba144dbmr3519556a12.13.1718543980893;
        Sun, 16 Jun 2024 06:19:40 -0700 (PDT)
Received: from [127.0.1.1] ([78.10.207.147])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb7438815sm5099603a12.80.2024.06.16.06.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 06:19:40 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 16 Jun 2024 15:19:24 +0200
Subject: [PATCH v2 4/7] dt-bindings: soc: microchip: sparx5-cpu-syscon:
 Move to dedicated schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240616-dt-bindings-mfd-syscon-split-v2-4-571b5850174a@linaro.org>
References: <20240616-dt-bindings-mfd-syscon-split-v2-0-571b5850174a@linaro.org>
In-Reply-To: <20240616-dt-bindings-mfd-syscon-split-v2-0-571b5850174a@linaro.org>
To: Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, 
 Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>, 
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Khuong Dinh <khuong@os.amperecomputing.com>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lars Povlsen <lars.povlsen@microchip.com>, 
 Steen Hegelund <Steen.Hegelund@microchip.com>, 
 Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
 Nishanth Menon <nm@ti.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2802;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=2G0rLi4cLmhzl8ZJMSFvOy5W9L4JVSO3sWW9FraSLfY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmbuZhfXHBzv30HPqvVvXuckFpOfUc2X2zBRfAc
 HNczWTgBAKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZm7mYQAKCRDBN2bmhouD
 1xgID/9ZhhA79JtYTQgEYo+AFhkXlRrTae7kFOvzLQw9hC5Png0N364hNVUaPL23p8dsFP0eOoJ
 Lejso+pHq488mcN0YcLMs+a/Gdqfkfc/21EBbKF/zMTy4tgetv6a2QVs0XODLwau3K/tArM9jfP
 2VADzB9BFviR66voHsVe0rhu2lMHef5awGV3Y8unnbwTNjrRPfdCbbqdm+W/TaQiXQUONW9Z9Kf
 rzXf99Nx9jB+KbxKHvk4rRwtP47eN0YHYDdvp4ezsGNhi7lbhMinMDKyc08MYq7nuyiUDUo49kK
 O89f2SD3G8UA6P8DSlsTxaVQtCewQblZmLrMDjDC7csET/s574e3N6UTefNOJZmhP7XHwdKUhbo
 EGoNiOJgkszXzQRyfHEfnrri9QYexs1dQzWMGzfEZV/1UlAc/oNFyWzW7Sdek5uTTVwvIKKz/zP
 r03hu6jhn7QdQLJBtRdm1c4wp3RqY8iR7xA/c5CRmU442GJPey5nDDnYKYsw0qc4TFBah12e7RB
 19K+ToU38Jub5zigxStNHNuzNqbgODXFv6GkGb+8RjfSKrBuDraKca6byqyMyQlMFdSjtW38+95
 tJZY9QdDegJNpdAQ2GWR9zhv/FrVlYD5AH99v7faN0hOKx6/g8NciFccgvjiNgm2C/PxGA/BPrm
 LJqTwU2MlcHBwbw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

microchip,sparx5-cpu-syscon is not a simple syscon device - it has
children and implements simple-mfd compatible - thus it should be fully
documented in its own binding.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Context might depend on patch in Lee's MFD tree:
https://lore.kernel.org/all/171828959006.2643902.8308227314531523435.b4-ty@kernel.org/
and also further patches here depend on this one.
---
 Documentation/devicetree/bindings/mfd/syscon.yaml  |  1 -
 .../soc/microchip/microchip,sparx5-cpu-syscon.yaml | 49 ++++++++++++++++++++++
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index b9bf5bc05e92..abd3debe5faf 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -95,7 +95,6 @@ properties:
               - microchip,lan966x-cpu-syscon
               - microchip,sam9x60-sfr
               - microchip,sama7g5-ddr3phy
-              - microchip,sparx5-cpu-syscon
               - mscc,ocelot-cpu-syscon
               - mstar,msc313-pmsleep
               - nuvoton,ma35d1-sys
diff --git a/Documentation/devicetree/bindings/soc/microchip/microchip,sparx5-cpu-syscon.yaml b/Documentation/devicetree/bindings/soc/microchip/microchip,sparx5-cpu-syscon.yaml
new file mode 100644
index 000000000000..1f0b542d2296
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/microchip/microchip,sparx5-cpu-syscon.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/microchip/microchip,sparx5-cpu-syscon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip Sparx5 CPU Syscon
+
+maintainers:
+  - Lars Povlsen <lars.povlsen@microchip.com>
+
+properties:
+  compatible:
+    items:
+      - const: microchip,sparx5-cpu-syscon
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  mux-controller:
+    $ref: /schemas/mux/reg-mux.yaml#
+
+required:
+  - compatible
+  - reg
+  - mux-controller
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <1>;
+
+        syscon@600000000 {
+            compatible = "microchip,sparx5-cpu-syscon", "syscon",
+                         "simple-mfd";
+            reg = <0x6 0x00000000 0xd0>;
+
+            mux: mux-controller {
+                compatible = "mmio-mux";
+                #mux-control-cells = <1>;
+                mux-reg-masks = <0x88 0xf0>;
+            };
+        };
+    };

-- 
2.43.0


