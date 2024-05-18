Return-Path: <linux-kernel+bounces-182963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD138C9248
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 22:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19BDA281696
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 20:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F346A039;
	Sat, 18 May 2024 20:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hYl0QXfO"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9496726AFA
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 20:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716065147; cv=none; b=fa8fEtBvMt/W1KkBMLiwuXM6UUUikYcx4tKa5Tlu9+LGGK/Atx6ODwJU9K2iF1LVN1hku/srObnmU9j1PAEKMe0FiIDocrfvbdCjV+LXiQDVAroXNji43ffmve5/Istf36aQswEzIdKIFeCMzh6+gTLi3Pnzo0dlZhovmf5BB08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716065147; c=relaxed/simple;
	bh=7D3JfsQldje8y5kklOAr84GugFeAdgH8b9y1JL6TOCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ay/aswv4Ryj7aePBW1gcaUN+lg+ym8Fc4+7srRLZX7gfJ5t5JpcJhNdua0Z5RIkH4NVa8Y0BJmvvizbvJWJcNE3s++lNl2r0Tr8WcVtL08Tjr19OWMkh5m0nomkC+WkTYXbM4NjBjrb+GwJRht356dKXyCJZ+1ppNe1Rc2bYv1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hYl0QXfO; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a5a2d0d8644so524954266b.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 13:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716065144; x=1716669944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DUhuNF9gHTk1IAfIZXzg3k6X/meW7+BoTontLnhR/a4=;
        b=hYl0QXfOmxB/VxkGQxmhsT+vWA4P68fNqSR8pcrmqMHtSzf04OBOJ/R3MjCdizf5v6
         JYZJ6EQGUd2OwY627NQhMybALmsATeOAE+9JZOOVuUVY2pcCUnkO0aoHN8CSNNOFqaF3
         dX5bBfl6hIK5WpkDWcQQLzjc6LLFAAFSACGKKLdRhHsbCOI1xkMCOFCQh87gZQ8GvsAh
         DMyO+1o4kFczTrRJyjShYYMBoOUXkS5nBw+wSU5SaKCyg5PkCl4LDRwGK0Ax8y9bgU7T
         MoAE/i5U7e8Z8c57g5NnTutdzlqb5yYljMA0vYZqJq7cEH3shEnX2pLr/ZuNfeqdRrTi
         x4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716065144; x=1716669944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DUhuNF9gHTk1IAfIZXzg3k6X/meW7+BoTontLnhR/a4=;
        b=D4cyxHezvx6DnFkXmFBhVucFi/mnWAo7cG3zeh9am5bvXFiUmi574EtdH5Evvya149
         mvIqUUIQQqUtP5+/2olIpaU/FEXsNX5vvZPjYukRFU6yv2LKuwJMVrQGt2wIM7dLmN66
         XdAmMliA2/IrwKgxmhR56AhgD3Xn/2Pg+ALmkLmZSbL3D/DJpIbD3sgJrw/leEYMagTN
         69XOkJy3c6BnEZyL8Op0/7Jg1dWT3X9fPOgQ6XBqw2n/Qoe5XZbQD6rnHjwQSiCzX7uG
         vrOnMMw1LxmNIHYS2ZKQWP/zg9qspVTDwLMp/YknvZaktIeW1vXqtRghQ3Nasig4GFri
         H8aw==
X-Forwarded-Encrypted: i=1; AJvYcCVaPb1P2Xp1jik/1qqezbSvEGgtFvABu9JLhDPlRDzL9HODw91EeGkcF0wAaY/YH6sg7xxELWLKRoJwgljS4O1TGSRaxP5sbUEDoK0G
X-Gm-Message-State: AOJu0Yx1fwKCIrGyJxaALhWL7/0Jl16FauIge4pcDmw58T8rs+ipXNjv
	NWeNz2uYEunQCkA5yWdWtNF1hY/6hfrQ7bmcQnMjuL4VR26JuPSS4QIF+aZwkzI=
X-Google-Smtp-Source: AGHT+IFLoW6ZA9b1C63Bf8OHLm3WLy3NeBN1vX3eOc7oCC6JLBiBVaypz0Q6D7yjtaz1sIWPPtH/WA==
X-Received: by 2002:a17:906:1797:b0:a5a:8d07:6a00 with SMTP id a640c23a62f3a-a5a8d076e2cmr827982966b.64.1716065143946;
        Sat, 18 May 2024 13:45:43 -0700 (PDT)
Received: from krzk-bin.. ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17892471sm1261716566b.84.2024.05.18.13.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 13:45:43 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wei Xu <xuwei5@hisilicon.com>,
	Carvalho Chehab <mchehab+huawei@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 1/2] dt-bindings: soc: hisilicon: document hi3660-usb3-otg-bc
Date: Sat, 18 May 2024 22:44:42 +0200
Message-ID: <20240518204443.122586-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dedicated bindings for the Hisilicon Kirin 960 USB OTG Syscon,
to fully document the block and also fix dtbs_check warning:

  hi3660-hikey960.dtb: usb3_otg_bc@ff200000: compatible: ['syscon', 'simple-mfd'] is too short

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 .../hisilicon,hi3660-usb3-otg-bc.yaml         | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/hisilicon/hisilicon,hi3660-usb3-otg-bc.yaml

diff --git a/Documentation/devicetree/bindings/soc/hisilicon/hisilicon,hi3660-usb3-otg-bc.yaml b/Documentation/devicetree/bindings/soc/hisilicon/hisilicon,hi3660-usb3-otg-bc.yaml
new file mode 100644
index 000000000000..2e26637a4711
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/hisilicon/hisilicon,hi3660-usb3-otg-bc.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/hisilicon/hisilicon,hi3660-usb3-otg-bc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hisilicon Kirin 960 USB OTG Syscon
+
+maintainers:
+  - Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+
+properties:
+  compatible:
+    items:
+      - const: hisilicon,hi3660-usb3-otg-bc
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  usb-phy:
+    $ref: /schemas/phy/hisilicon,hi3660-usb3.yaml
+    description: USB Phy node
+
+required:
+  - compatible
+  - reg
+  - usb-phy
+
+additionalProperties: false
+
+examples:
+  - |
+    syscon@ff200000 {
+        compatible = "hisilicon,hi3660-usb3-otg-bc", "syscon", "simple-mfd";
+        reg = <0xff200000 0x1000>;
+
+        usb-phy {
+            compatible = "hisilicon,hi3660-usb-phy";
+            #phy-cells = <0>;
+            hisilicon,pericrg-syscon = <&crg_ctrl>;
+            hisilicon,pctrl-syscon = <&pctrl>;
+            hisilicon,eye-diagram-param = <0x22466e4>;
+        };
+    };
-- 
2.43.0


