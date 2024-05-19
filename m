Return-Path: <linux-kernel+bounces-183208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A408C95E8
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 20:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FDB71F2187C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 18:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623B574424;
	Sun, 19 May 2024 18:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X7jqqwTK"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED9B73186
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 18:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716144166; cv=none; b=UDmq5AMx9MwiEasoPintBWHtxRlKYhMqzzS/5W29GAmV2ImnkAFu/NquyFzmifh1qAqx0Nu2r0duK7iBIQQOof97WPnML6hsb0wPlb6/arglCJZMW8f12PMY3t3so/3ZeKXiMCB4HoknOK2mStt916/hWK3biDFQjSkz8WrfPg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716144166; c=relaxed/simple;
	bh=OOdH/VA0xsPMRYhcDacK8D0Tn//KGept+QvEXbjxFgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tra4NsmOUwlvjfke7ev0288snuGqjWTOgCnnpbkatROKzoKH3YUaPZkG+0PJD4ycM7hgbuBD8alVK89uSIU6aH95Fa0ArN4QVx6SzENTkKU07HFKuRi0m2oSmSmskf7IKI6YRKGPsQE/oIBddvQ+brNTazybvoYSU8j4e9dATRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X7jqqwTK; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57342829409so9213157a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 11:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716144163; x=1716748963; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a4iZfdoNm6KmetFlM+rflXj8Ify4OoKkEWH1DVjf6SY=;
        b=X7jqqwTKccbA845PWQdo0cisUFyV2K2Iy9dRYyQt33qscNdSnH/7LAiCMqXih97sBJ
         Y/ZYXGPNmpNBvro78UpIA74tw/8uKjkosYwth2qzAAv3xB9IByKsdyQrUaHc+P2c43t9
         mELAZj6AMxyKh5KxVjTDm8WhBsrj6uJFBXo4ay1vNomJhyOGetQENKunIA8YogBBqHrp
         /xs57zXKyGqONQrsj9h4xFz8xpedugN/IPRkM+ImEmRqj7HC9iAVXPjRvioU6XktA0qE
         jFvMy9NxnxL7m3tlXqsUIZelsI3Xr6fyeDVIRZ5PGwkAmqZHkJzylv4cpsbcpA3Mxir/
         GkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716144163; x=1716748963;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4iZfdoNm6KmetFlM+rflXj8Ify4OoKkEWH1DVjf6SY=;
        b=PrF+utwUIVXN6cojTYNBllJXARLdyQPnBtX8WVDZ/bmU6UlO1wIghxSqhnBg+/ObAt
         zdG7nRSBwDM61HItWtL2j7cvZIvzAqbFey3/17Nv6ooyWWnoZzO6u0moRv56MaSLeAKW
         8UgyPlwm8AcB6b+FIjqxiC4UD+6vR3NVhQOvAN4LGyyZYV1G9/Zw8WEHAnn1uacVvDpI
         mad6QH+RPEHacqgMrfff3hOQvLo88y70fvPx+8WsJTco2DaxlW5+T8V7uXLSGN2KuPSA
         OF337q4Uj5lyiLY5mHHESjZHRg6TlWENk+ILKJmvz9SH5fUoB4+C5Mn4jQKrCP3SH02r
         VlZA==
X-Forwarded-Encrypted: i=1; AJvYcCV1Y5WY5fKoquM2NquRxB8jfBrGk5duskEAGj7pscVWv2A6OCuVwth0TGf5oxDwgJxwobzTIKyg8rUJmD3BO2sDN1Hfd3QghkUke10e
X-Gm-Message-State: AOJu0Yw7ImFmoy6veyVuHHIHYwG0g5e8smYyCwVVub0rFTJE+gtYCQPu
	HHJ1x3w/Dqg9CkJ7QHrQO467gAtG1jBOsE9sBa6CGEkqHwiQmEhOTWUXGI52q5o=
X-Google-Smtp-Source: AGHT+IERAhveijxy7giHqZCwdGvg8/ABsrt2a2x/cjeUxbcFttmT+WJNsMDmCsz0XPPz7M6nBgPbSw==
X-Received: by 2002:a50:ab0e:0:b0:572:a712:64e0 with SMTP id 4fb4d7f45d1cf-5752b481447mr3925832a12.11.1716144163350;
        Sun, 19 May 2024 11:42:43 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-575313d97desm1789397a12.41.2024.05.19.11.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 11:42:42 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 19 May 2024 20:42:20 +0200
Subject: [PATCH 5/8] dt-bindings: soc: ti: am654-serdes-ctrl: Move to
 dedicated schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240519-dt-bindings-mfd-syscon-split-v1-5-aaf996e2313a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2354;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=OOdH/VA0xsPMRYhcDacK8D0Tn//KGept+QvEXbjxFgc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmSkgU4qP0BJA4XKDpZ7Wvn50e/Ri2RoAv0jgbH
 9A5h7StGdCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZkpIFAAKCRDBN2bmhouD
 14vtD/41lxCZUAle71Z5RV8DtWeAuAW/4vtMslb18wpwO4PjUZSfIurRxsBNpDMWmbrEe5wehNg
 IAhl1W+I41vdMBBoL7AofhxwwKbux/y1V7rCbwG5X0+GN7TFASHMg5GIbpMn96zQOiV+7W3FiFA
 imCHWAJyb9SWI6mGK2D2jEPDYxWCbLjxTVhcQOYPtvE4m74ZZzf+ovUro73pKnPPpKRLEYJhRIb
 k8+2XQDDYDnk4uXSFKwLlXmrVkqr23d22h+U4koosUkp+hwt7wg+0DTS7oXzeh3qnaSpz/7bgyV
 5xj7jAHTln/hZ33G52/KeVAbFLBmeRxymyyy4IKSYay0VXEX0sCF0VpOPpSvlFlgzE0DKifTs8E
 Mpsri0yFQWHGSc2ydrPWW9UuAbYqbRM3QI3hDYNYJ8kCiw7ow7Jce5P6T2iPindQD9Na2UeCGsO
 4dkgV/wnARN4SXiOOKsv/+h3Bp68Ij/p/CqyJ6BUWvVQWqj2kzWGwhJQTHL4E4hIQL80vbf7Y3m
 OqGNYuhwiKLkI2nn9rRYJec/AEznTgsy2jV2QYzxJ/JLv/Icowas55bmAHmN6v1EIVsGMhqMT8O
 iWrqJWeAiMI2wfiA0/KBKpUKSMmPHRpV3fjtqUyufu+foR/O0H3n07+DmdNm1ntnONRpaAFAnlj
 49hSv2Iy146uRlw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

ti,am654-serdes-ctrl is not a simple syscon device - it has children -
thus it should be fully documented in its own binding.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Context might depend on
https://lore.kernel.org/r/20240510123018.3902184-1-robh@kernel.org
and also further patches here depend on this one.
---
 Documentation/devicetree/bindings/mfd/syscon.yaml  |  1 -
 .../bindings/soc/ti/ti,am654-serdes-ctrl.yaml      | 42 ++++++++++++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 91adf781e8ba..b17fa0487178 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -116,7 +116,6 @@ properties:
               - ti,am62-usb-phy-ctrl
               - ti,am62p-cpsw-mac-efuse
               - ti,am654-dss-oldi-io-ctrl
-              - ti,am654-serdes-ctrl
               - ti,j784s4-pcie-ctrl
               - ti,keystone-pllctrl
 
diff --git a/Documentation/devicetree/bindings/soc/ti/ti,am654-serdes-ctrl.yaml b/Documentation/devicetree/bindings/soc/ti/ti,am654-serdes-ctrl.yaml
new file mode 100644
index 000000000000..a10a3b89ae05
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/ti/ti,am654-serdes-ctrl.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/ti/ti,am654-serdes-ctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments AM654 Serdes Control Syscon
+
+maintainers:
+  - Nishanth Menon <nm@ti.com>
+
+properties:
+  compatible:
+    items:
+      - const: ti,am654-serdes-ctrl
+      - const: syscon
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
+    clock@4080 {
+        compatible = "ti,am654-serdes-ctrl", "syscon";
+        reg = <0x4080 0x4>;
+
+        mux-controller {
+            compatible = "mmio-mux";
+            #mux-control-cells = <1>;
+            mux-reg-masks = <0x0 0x3>; /* lane select */
+        };
+    };

-- 
2.43.0


