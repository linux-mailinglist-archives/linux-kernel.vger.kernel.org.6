Return-Path: <linux-kernel+bounces-232129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E06491A3E2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B126D1C213B4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB58149C60;
	Thu, 27 Jun 2024 10:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xu0Yxrsm"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB665145323
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 10:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719484368; cv=none; b=VAKdKEhEjozg1DKDwT/hpMDL/Pt/6tcbcqS4d08quhs8ORwJyJVrOweQjQ1ELWrbrimF0LP7sz2p5ftSN9+8tLySjudK71gLPvFPZXChS5YkX8TaKhO2Aw9F5XSqH+vv6TKH3fOpqvoPJ6ie/t075o39GrWr45F8XMJg/67VsbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719484368; c=relaxed/simple;
	bh=LwADOOVCCJ4verKOJbmwOwhGrtMJ9b4n73jXo/44U/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LD1ZhJRWu4Q5/zJt00BN5RFEoA/XWhA1gdU3GBRCtmBtiyRrD/dzvgOEYa0U8u9TmMgFJRCydU+NodC9PEgoeaOQa1IRDJU7jfLRVi+NLhkSPDgEEUWPE3Bjgejo6pH7tYoyKlZbR0bRAYrQKMZOsvEoGiHPhpSmUEpwn1sN8aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xu0Yxrsm; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42562fde108so8457865e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 03:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719484364; x=1720089164; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ikedj3tVLkYYnUpwfjDtl00VbRPDE3LLjeOugxhtodI=;
        b=xu0YxrsmSpN6fI7Ohy8njZjYFJsvupTPd308noGdvSd7OJryRFC7dvbXfTzvq0vOUT
         AGXf9eoHRBU7wK0Psr/zCv33y3Rsg8Z8ix207pS9MbVTE4zgdamWKGw9hjM/phPaubC1
         v4FNaQpU5B+n1vI7vhpK21r6kQmBQXPKqhUVpePBIugOia8hxz7HqXupVFobe3gJMeDN
         0jfSjvIZXjrQMDDOcPwltfQcSvrB1jR/zscZ75tB9n0uDtkA7Ira25lm50KxBzpoJ2rU
         flmmiSy4V+LGDTUpMUDfGXXF3hepKJaZfmqEGIgDb1A08QL1zOZn3MwXNfnpqZsOoIkN
         YvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719484364; x=1720089164;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ikedj3tVLkYYnUpwfjDtl00VbRPDE3LLjeOugxhtodI=;
        b=hzvrZlIStPn1YV2Iq10VIKs7LFXinVkJ7VQY3tspC8fwXgiBTwKuoZKX/QBv/5wgSx
         k/PJSDnE+wLqTrwNo+KH0I8ag/Zm0sJtZtwg9ZSWQxUaXOr0PrGOvc1t2y5nQwgCzfgj
         5XAT7xsvhz3vMCO61MipnZlqbAKnQm1HGCxsvsegrIBXSLvvkT5AH2RgDmoAJFZHabtd
         tkNaoctbayJ+o/8IV0hkKGdgrSYZxj7htc+wEOeK4AsX1fFeom7VJbmW+kFV4nBy/sje
         DQVnEy4LAV+8OzmRuuqocWPw95HFiQtSzyz8XHxLVyjkPLrTa7bn15/iw51ErPBUUks2
         SysQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRe3e8qoQw49v85snZdZvbpFGPNgF0efsZylzm3f0DybPPEXPytGYB054dZIpH2pshZUnlRXTptMt2FPrK+qvmORWiHrGtH6zMTJmP
X-Gm-Message-State: AOJu0YxImcRJhDwnr1C61T6q8ZUfL2i3UxwdWWGZ+tLGbJKBh1srcbao
	X9EKXBFnsdLSH+FMl2RWOBtk2JRRZlvDGH2HzCARKzi9ELEAxSy2ZNGWcgaMpAA=
X-Google-Smtp-Source: AGHT+IHIM8K4TTdFmd+OC8FVtPlX+Cx5qck53EwVVVSZ3dVQODT6DSoFQugNihRom9KzkjlOakcDXQ==
X-Received: by 2002:a05:600c:2058:b0:425:63bd:fb44 with SMTP id 5b1f17b1804b1-42563bdfb7cmr14424995e9.33.1719484364231;
        Thu, 27 Jun 2024 03:32:44 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367435852afsm1384352f8f.53.2024.06.27.03.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 03:32:43 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 27 Jun 2024 12:32:20 +0200
Subject: [PATCH v4 4/7] dt-bindings: soc: microchip: sparx5-cpu-syscon:
 Move to dedicated schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-dt-bindings-mfd-syscon-split-v4-4-dc6699a9f3e4@linaro.org>
References: <20240627-dt-bindings-mfd-syscon-split-v4-0-dc6699a9f3e4@linaro.org>
In-Reply-To: <20240627-dt-bindings-mfd-syscon-split-v4-0-dc6699a9f3e4@linaro.org>
To: Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Jacky Huang <ychuang3@nuvoton.com>, 
 Shan-Chun Hung <schung@nuvoton.com>, 
 Khuong Dinh <khuong@os.amperecomputing.com>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chuanhua Lei <lchuanhua@maxlinear.com>, 
 Rahul Tanwar <rtanwar@maxlinear.com>, 
 Lars Povlsen <lars.povlsen@microchip.com>, 
 Steen Hegelund <Steen.Hegelund@microchip.com>, 
 Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
 Nishanth Menon <nm@ti.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2802;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=LwADOOVCCJ4verKOJbmwOwhGrtMJ9b4n73jXo/44U/g=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmfT+99AkL8ZgBw3w+AKELOjfBI1jQr4W1b5DVi
 5t0JVgm1m6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZn0/vQAKCRDBN2bmhouD
 19NhD/4rasYCjtRnGj4xAY0TL+5eFGWwcSeM3+Vm3mHJ+UdUH2w04ppMJSGk87lnCv4HTvlJrOO
 VAILx9Y26BfBVa9Pt2nfP23JKhKqwKiWAjO+PrZSecavmsU7GoRyFghJ76v4N0sksRlGtOgQHUr
 JnjvfJ+Lgwz83qSq250QXm8l4EWuFDWrvxhTB3ZROFoa6IP/s2gLszs0AQdYapxcxoacLhSwo83
 uSga2fq021gM3wjrUfQLJI7ZNmpkOZ212GVulHZlP3IXNNXRuDY3QtcolvFcWjFz3943mn1Xckf
 1I6gSUiDaL453vSAWgE+Ij//8ZllYSTyOGGyXmdDzCOADRSQL9938PWUD6HO/2p976i7lYECUB8
 jMcDy2TPNOfB3mEmHHwrl9EJt0fIpNidlUQ9TvnON3s9fgxJtxuLUtsvJElYSr8JiDCr3kXlIwo
 Ll13rgsh/W5xHpfujGEeVzcSc0yksVDugA+IL7eBU7OL+Ycx2ha8vJCpJQSZpet06oJQZ18xA5Y
 r2lFKDqEVZr7YBVn79sqrrB0uIjuoMjzbrBzhcOwcBR3E9M5iDX96y0CyxgtmSLLzMAzDdofL4T
 t5Bs1R4cRHONXCjVNl94fHjkfAyC1dwxB7v+dSnir2XZZOywUHyGssMERt/lXtY6UFd8BbAaVA+
 N31ovjTBAn5sCDA==
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
index 0e19eb0772f1..49bf85e8f220 100644
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


