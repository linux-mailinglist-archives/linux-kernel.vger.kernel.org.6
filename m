Return-Path: <linux-kernel+bounces-183207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8018E8C95E6
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 20:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E83EA1F21723
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 18:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933C173509;
	Sun, 19 May 2024 18:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LzbymvHi"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBE871754
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 18:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716144164; cv=none; b=TNZOWzhv66F6xe4QlGqwcws9p8xZpwjyIQn65GigFIVcZ0gqeWvTvfU/ve4NYEkJM394r4DT4Ke+I7q9Dq6yu5eNYqfa/u0dF+wTvqdQ8FmNTXguI7Gso+q8M572xUjZRY7Ca2IosWxUwQymhykaZee/OxmwuQVt8+DVtu+yjhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716144164; c=relaxed/simple;
	bh=sX/Xtm/fQMIFqgBRxKVvaSRYJ/1XiD5kxEcRC96ApDM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bvtUCNDdLGT48YxuJZ8TeujgaRmMJfXw55XQUylUJWoKCLczxHea4oB1ktGnwyGHTLTJDbVoth1Gcu2jaiNwgDHvWfSrlsctUxqi25ZW+Vi2Rg9D7HIH59CckOSPXSSmVCkpFM6GOqRE2uliokGu5Tlv72HAGv6CYVDRnJ9yE/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LzbymvHi; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a5cec2c2981so227792566b.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 11:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716144161; x=1716748961; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pO3NRJbXmJSf+e3cfxUxA2NqH4epjg+9R2AbvoM+0ZQ=;
        b=LzbymvHimJjeTSLsJ0ANRiTpHL6L6kd/ljc2sTXP66yKmiYmotnU4ee5rslXUlXa5i
         m8uo/ssrhgCjec9pVy1taRysweGlHSnaV0PHPVxD1dnR/5LFcluDQaOjZledhuHmUeax
         TK9A4e+bCWKIhqWsdm7VAl+7SA1tBNvF9o0SdEsBcUuYciN2oA7RhDH95OyVqUkmOGQs
         bUtZxJ8mzoxWa320JbQasbgywn8aVbcEO3JyaiyiAZ/wU7kp7bRWhBuv9TvEkYQRWtly
         DKd7kBNqyv9UJS+6BiI25o2UubpiyMoRYGQKxkMKe+jKRgiZtjgTjkBvMPXuADyi95fz
         vVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716144161; x=1716748961;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pO3NRJbXmJSf+e3cfxUxA2NqH4epjg+9R2AbvoM+0ZQ=;
        b=Bx3ID5jqEMnvvxUjDNM1/uoCWC+ckI8b+vqinoiqHhBRL/mIhfuLVWRCZvElDp/AEV
         R0f17NohqQbPcrSUqWW4y4qEuEdT5FyF21lRqUfX4welgmjppclxjdrEgP1IVuW6WlXV
         8tZqNyzMPxTV2hDu6VH5KeA6YCkWxV11VCopwlZs3SkA4G+iVt9OJwxLieQGa4nbFQL0
         jrMhNprsSxcarMamb8jfRq9wM8VVjdL6WymzCguNBODvA5zw/wgIXJwIutB3ZscRhafP
         w+TC8imF5Jxm02Z6oc4X2vrdXLKqvfR4RJy5F9jo5XyhvKlYnfS3rA13+vZGVZZ74gS8
         NXNw==
X-Forwarded-Encrypted: i=1; AJvYcCV8Ll4VchE2fhLCy0B8aHnbDB5Fg72bBEP+ctTpIFeKy8D+nvQXRZ7Byumq0rYCb5G3+cGqEOmO46ioq8wvvj81Hzef6qbV3kKl92H7
X-Gm-Message-State: AOJu0YykNUy0nHeYr1t1stQYgT7vkPPLbU7FIq5uLkbLVIFvh3XAYnuV
	e6NVTPzY6HboXy97ZfRiW4ddm+5U0bdBtvIxn1upU+u5s+Unv5jZUZieUedZqCW3uEoCUV9WNoJ
	U
X-Google-Smtp-Source: AGHT+IFNTIHL/HAyLtlYVOw2G80nM8amYN3Wp95SxozD0aVeP2XqqzO8ZCvlEpt6PEE1lQxrXtDAZA==
X-Received: by 2002:a50:d4dd:0:b0:572:a089:75cc with SMTP id 4fb4d7f45d1cf-5734d597e13mr23782682a12.5.1716144161651;
        Sun, 19 May 2024 11:42:41 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-575313d97desm1789397a12.41.2024.05.19.11.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 11:42:41 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 19 May 2024 20:42:19 +0200
Subject: [PATCH 4/8] dt-bindings: soc: microchip: sparx5-cpu-syscon: Move
 to dedicated schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240519-dt-bindings-mfd-syscon-split-v1-4-aaf996e2313a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2709;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=sX/Xtm/fQMIFqgBRxKVvaSRYJ/1XiD5kxEcRC96ApDM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmSkgTzszfJvvn6dxdlgvQdJYbCuu2hWH8maiGi
 0mchpUi/KOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZkpIEwAKCRDBN2bmhouD
 19SzEACFyXW1D5nJ6zktVW0VlHljoq4UjhZqFWmx9NykeR+3MhUD2yednyILUzMvYPbVMda0vLF
 sF3u4OtPwU4yDAkqLYjMWtvVq1/nLRGjVmPEAp8wJCE2jN5OFKgO3QI+zjjsQX+K3a5/P93xPUN
 Jj62P5IJezthxuNBpUl08Bgqtx7UT2N1hliD8mEGDC9Yk3XgU8UbJbfCZVCQ0aWeeIC8wdte9+r
 jnyHkzOKJyLRkFc94vx0VfKEHh540EOOYiV0ZknCL0FI5mnjfqWwtqOMRZDeFhuc2dn/Cq90GAT
 gPNPA+qg0bXF+V5kOr//7fTojf5z5F1kPfNN/iauQy+iqrOTOEP3CtBp4aUSsmSRqvqRKpSfTeS
 lNek5mfC9vf6jJ55gvLQCZiBXeXKzS61ytB/SdnTH+opFveaY4znDfYxaJRVcNmMVUkNGL9qvAk
 WRUfeqzFG2g39GuHXYQFv0R8fvmCrtGcLtr3d8M25wSJd7rtF0MN6jTSP23YODWBA0VpDzlI/e4
 UTxgWuUXJuvYYDrPK8RNzlP8K+dHwANXXL58uSZ0oAuSf5xm0i+JnFoqxvmBieIgeTPyMoy9e+J
 XJ7FcwswIXaFIqg6UtzqOA9ffDyrtM4AyeNXj2WY1XwgSKhR7F/Cq4Mq3+ci+7EMA3JbCIt6E8n
 iqNMasqicJOIQdA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

microchip,sparx5-cpu-syscon is not a simple syscon device - it has
children and implements simple-mfd compatible - thus it should be fully
documented in its own binding.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Context might depend on
https://lore.kernel.org/r/20240510123018.3902184-1-robh@kernel.org
and also further patches here depend on this one.
---
 Documentation/devicetree/bindings/mfd/syscon.yaml  |  1 -
 .../soc/microchip/microchip,sparx5-cpu-syscon.yaml | 49 ++++++++++++++++++++++
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 5a0aeae24a50..91adf781e8ba 100644
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


