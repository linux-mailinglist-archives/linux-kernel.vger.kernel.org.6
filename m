Return-Path: <linux-kernel+bounces-183206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FFF8C95E3
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 20:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5843280FA7
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 18:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF6071B5B;
	Sun, 19 May 2024 18:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ctiI7DWf"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9946F06E
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 18:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716144163; cv=none; b=XhiQlRca8L1erHYHYmxFGkgsA0NeN/k0AoRzm15a9XJLaZC/Jvs597QwUJQtP7oCMVuW+78lBr6KWbPNieeVmdm+zKCyHDlCcD/CfMyJtmqbrkjcRfmKTZpogFyKjYf0071rC40mNZi2hZK4YmdKL9X13MjxzDdrRB+jMdT/exM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716144163; c=relaxed/simple;
	bh=vAJT1P0FomWLhWAzUqykqRB/KaNwziPxJILM0FyE4jg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cvf+I/JLAGByMWF+OHN27IuTcVhnDNKgu7oAEZJbpuAVHPWx2LvT312Hz70RzWXW0zY7J8zl50Ty3RMH9UgbhNYBQzFKF4PSCHwhqMkTs7rgdV2o6Qq4MWnvZHBmD1ybo/dU3lnzpvVNUWd5Ex8cwodlCwR/tjHP5ACj7/6MRkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ctiI7DWf; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5727dc6d3edso6902592a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 11:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716144160; x=1716748960; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z7PYcSJNF1g7ywX09LW0XnY+rtNpzcQYeWJY4FR4cYM=;
        b=ctiI7DWfFBps+AxSTXgdbjij9HP9+SsRZaUqyabAv0A8RMHvhDXD9LRC0G2EHStjXX
         3LKTd+cSvnwr7PhzXgPxnTypICi2uCXZkXFsziiNfGuB1yjfouej+asBKxmZeAg0+YFE
         TubNX4uWbEp2VmlnybNPyU0hQWE/FOh3/u85qC1b9zEO8uqpkWzGP0zirvfYRSySE43J
         Ihohf80rTNs1K0JmYZsJlVSapZ7JuaPgT/xh2MT7VgZr3Bw5TSsJdbWrE8n8vh+DEY+M
         VO5+2t4pD7FxRdn4NgFHQk4WSvOB7pLAaWm20DR5Fj2R8NfYOk7FjZaeO/PFtjwIN4Sg
         eZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716144160; x=1716748960;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z7PYcSJNF1g7ywX09LW0XnY+rtNpzcQYeWJY4FR4cYM=;
        b=j8O1qjzjo13p4F5++UtehwT8GtQkR0m2ZRDz6qDzOHuK6qkPsTldLC1ExHLmNGA3YQ
         pVSMCTOGzck3oV7KNxqe/7ZUCBdzQFRGbATqqgxEXF81tQLp5tgB/rzLX1GgZeJu3xzy
         jEBhAAgA1u2V7mjyXfNCxy0v+iuRNirnAYCwDFbYZZZAIgIX4ZPfYQPmUoq20fx4rx/4
         KxvwRKHGEy6E618lSXZQ2laiLLIBRhANdB2SdPw67PlQ3yIo9DjhwBHGg//F5OQWUc+u
         9gNok5ev823OneYu+SuIshuW0DcQSkqztkRdM4ff+bcPbsxrUK7iNyhQaYE3zZHFk050
         vp0g==
X-Forwarded-Encrypted: i=1; AJvYcCXvDBBWeMIfsPkHs6jnpzvT0VbfGoOUiQDmX4kJC9QVRM3P56Sq7ZlHV3khgJk2JV4pv9AcaWGVhc+QKmQ5D+JkufV/Q6QB0/wXC5GI
X-Gm-Message-State: AOJu0Yz2hICLY+MclNopeA88oVzNvNFSte2sIBKZTAox4RwqQ+M3EJjs
	7IyrsyNUdqT2suUnTcdtO7w7Y8lNPlq+LXPIR7Y15Rj7BTfjGvSRH2JTk+Sg1P0=
X-Google-Smtp-Source: AGHT+IERTbf+ILkmL8wK7SH8w4OETrwrM3/QR2TQZVEqGWc5zTaWklumLATqeRWUQnqKN8hvh9EpRA==
X-Received: by 2002:a50:ccd3:0:b0:574:ebfb:6d98 with SMTP id 4fb4d7f45d1cf-574ebfb6da8mr10157638a12.4.1716144159808;
        Sun, 19 May 2024 11:42:39 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-575313d97desm1789397a12.41.2024.05.19.11.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 11:42:39 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 19 May 2024 20:42:18 +0200
Subject: [PATCH 3/8] dt-bindings: soc: intel: lgm-syscon: Move to dedicated
 schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240519-dt-bindings-mfd-syscon-split-v1-3-aaf996e2313a@linaro.org>
References: <20240519-dt-bindings-mfd-syscon-split-v1-0-aaf996e2313a@linaro.org>
In-Reply-To: <20240519-dt-bindings-mfd-syscon-split-v1-0-aaf996e2313a@linaro.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2616;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=vAJT1P0FomWLhWAzUqykqRB/KaNwziPxJILM0FyE4jg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmSkgSBDwpWFtDxIz0QH0LiVJvEMjMZleLn5a2h
 BGkMwtdqg+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZkpIEgAKCRDBN2bmhouD
 12/0D/99xK/6Tafjmp5u5Rklb1WDho4MtHUcbBHTGUfCWh0r70/umtMwP5mPeqzC3sY4/EJet0Z
 T66duDebCbpAU1UH4A0XIq+0fGAYwA/Ap4cXaodHERwX6mQvAjAG5XSPKMe2/nd3MFgPMrtunVh
 sK1mAbhKAk9rCkz1B9lI8z5g0aVaukItJ4sfIyothjXIw6Y5AIIv494EA4pXXsDDdkjUwFb0kcf
 KVcl5wOijgOZyvHzJXu++n87RT7GNllr3OrkHYaZzL4qIqsu3UC+Gwx9nHJPcbHPJn07/71tsKI
 ipgLoESg6STxuAgpl4Yr4iPO3HRM//wAjSE4TQ04XhNH8D5qBRUNr+i0woIiU4mS9YRytVyDtjb
 FRxPiJdLZ0U73p31Fsswvg+uwmXa50/JSuiiYjgSQzfeIzLhCBTQ/KjxSqOU4seSGB2l3ZzcNAv
 2IAJCu5gdQFT+uAb6pVvQRV3nTf7Y4GT4vVtk7VPG6aekeNp9h/wY7MG+4JS9jirLvpgtIczE36
 8nEBxV7y6h4vbEIYTJUynB8ZW7z3NTr7vj60iczmQZbX0ggXDGQPg7gr1CvsRmvytOtTrS7SrK+
 P3aN6UokB+opJXkP4Cyz7opxKUPsh+k8tKIERvGyKrGmP7rxsyJL06PP79JYUCFQuADgVeERHiB
 axo8qKdiIs7/1Rw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

intel,lgm-syscon is not a simple syscon device - it has children - thus
it should be fully documented in its own binding.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Context might depend on
https://lore.kernel.org/r/20240510123018.3902184-1-robh@kernel.org
and also further patches here depend on this one.
---
 Documentation/devicetree/bindings/mfd/syscon.yaml  |  1 -
 .../bindings/soc/intel/intel,lgm-syscon.yaml       | 53 ++++++++++++++++++++++
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 622ea0f1b08e..5a0aeae24a50 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -77,7 +77,6 @@ properties:
               - hisilicon,pcie-sas-subctrl
               - hisilicon,peri-subctrl
               - hpe,gxp-sysreg
-              - intel,lgm-syscon
               - loongson,ls1b-syscon
               - loongson,ls1c-syscon
               - lsi,axxia-syscon
diff --git a/Documentation/devicetree/bindings/soc/intel/intel,lgm-syscon.yaml b/Documentation/devicetree/bindings/soc/intel/intel,lgm-syscon.yaml
new file mode 100644
index 000000000000..aa8d24074fd7
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/intel/intel,lgm-syscon.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/intel/intel,lgm-syscon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel Lightning Mountain(LGM) Syscon
+
+maintainers:
+  - Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
+
+properties:
+  compatible:
+    items:
+      - const: intel,lgm-syscon
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+patternProperties:
+  "^emmc-phy@[0-9a-f]+$":
+    $ref: /schemas/phy/intel,lgm-emmc-phy.yaml#
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    chiptop@e0200000 {
+        compatible = "intel,lgm-syscon", "syscon";
+        reg = <0xe0200000 0x100>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        emmc-phy@a8 {
+            compatible = "intel,lgm-emmc-phy";
+            reg = <0x00a8 0x10>;
+            clocks = <&emmc>;
+            #phy-cells = <0>;
+        };
+    };

-- 
2.43.0


