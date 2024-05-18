Return-Path: <linux-kernel+bounces-182951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F67F8C922A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 22:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9481B2145B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 20:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EC76BB5B;
	Sat, 18 May 2024 20:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AcKkayvp"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732BF53389
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 20:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716062854; cv=none; b=Q6T7yc+uDWzKaiL2WoFBo8BQhpvZzsL87rJqns3N1muV89g/dMlliuVcxu65Lpfq0uKNqBdY7XQnRfjN1lSKmmXtJ31wGi6ReCENCfu3Y10tcaurIs4jWyAT2xjy6Oft1E7JRQyEBZcaYX7tRCLblYTokFNSaZzPLc+g9yFVBQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716062854; c=relaxed/simple;
	bh=5OgWoFMzJ88ehIRhaEnyRdZayCiH1JcQtzgaI8uAdAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B7pxUV5UG87Cb4P85l7A6r4Ra3tLZVA9/hD9ELyzmesiDWPuCW5GpSiFBAMfBzp3clA5xd8UxQhCBgTndEOBJxERuj4mdpcAOkQ8G8ONUDKc/Ju/eRfBQcewWRBlelE3NcJBKWpuL+dei+uL/492F3d0z7gWqdzsVXhwHARnCd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AcKkayvp; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a59b58fe083so452505666b.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 13:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716062850; x=1716667650; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6xDeQYbTOua966mTWlRvTnMGl2MWuiH7mUfgvayy6q0=;
        b=AcKkayvpDENOtXAIfwumHzLwUWhEqSNZKw3h7iGSBFoBLQWAjsLOTYHIhSkerS3NNS
         l+kmI2c5p8topsgF3PH6zYOmSlalRjBuvGHOtSdmfT5kbxQJJg7pIfKUjnfnpTvsxiNP
         5XsUwl5Uu0Zs9c4NAS6M9TE9j1PCOlGUXdOPh2s/+DZkNbD+cCRYojwe2COJy3EQBeSt
         nk/gP02mJfXXrAeGgx5lFSAisfQ38MnDNxs0MRF46GdJIIYq5yR2zZyMQgvEaOf8BTKZ
         JbePkndnrIKRbD1+4UDkD1yTJ0bwNSOeDpQFDlvReXEdiAVARWtR/38HBkbauwQv/75P
         Zrvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716062850; x=1716667650;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6xDeQYbTOua966mTWlRvTnMGl2MWuiH7mUfgvayy6q0=;
        b=ikfJeOGFa7g/2QWWzSe8+NHzoeNHaoW6V5wSYwElps3+jp4qm2VUAV0R87m05f/vdp
         wNkv9Y/10ohIJpMQoWGmT5HxRQZmnOtH3cReJYp54iM/E9vqqrZTkMzHLNyvxFs66j2G
         hWwuTROhjSrDhIOZPxeiK2vLwnwQxcVcWNqjhZ9sZ13XgY9OolNxcOYYhBxT+INLdbey
         pSfGH2rOfZSoEpgfaerkIE61uAfa6YSn3K5OcjiugyaHyFHn2GvkzW37H+Lz5ai+6PKa
         w0r73dJG48xCPnuRZQ/TrQmWDp7wdsAZxT6coCRwWWNf5ZTutNaSsC09sv5yqLnh7s1J
         HbBw==
X-Forwarded-Encrypted: i=1; AJvYcCXLvXtNQqsIZWpEgdRvzcpZkrxGxARRPcB039urp4LsmXWvPQlxaC1VjXVacZNsjNHU0+N1Qe5dkNFmoD7o66JMH9qo0ze5aAfhBCrN
X-Gm-Message-State: AOJu0YyxB+M1EdkCahWzbgJqQcQSyIhGtIwiuPcd5IjoUpN3afghNVNC
	o4LVSfEgtr7MAIAEMGFs9xxRxhuxaBEc1YIPf5sPBEVe/k0TQTL2CBv4WX7s264=
X-Google-Smtp-Source: AGHT+IGP3YYwncGmZ6ZO0OQ7tAmCexIFvx3BWVJqm8GAj6rlhuHo5b1iWy1j9aicKdhwf4BH5Z5WoA==
X-Received: by 2002:a17:906:80f:b0:a51:8d60:215a with SMTP id a640c23a62f3a-a5a2d572b0emr1699107366b.27.1716062849725;
        Sat, 18 May 2024 13:07:29 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b177desm1248364566b.207.2024.05.18.13.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 13:07:29 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 18 May 2024 22:07:17 +0200
Subject: [PATCH 2/5] dt-bindings: soc: ti: am645-system-controller: add
 AM654 syscon
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240518-dt-bindings-ti-soc-mfd-v1-2-b3952f104c9a@linaro.org>
References: <20240518-dt-bindings-ti-soc-mfd-v1-0-b3952f104c9a@linaro.org>
In-Reply-To: <20240518-dt-bindings-ti-soc-mfd-v1-0-b3952f104c9a@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Roger Quadros <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1998;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=5OgWoFMzJ88ehIRhaEnyRdZayCiH1JcQtzgaI8uAdAw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmSQp6hZcB9yLDsHf823SRQAH008sMS+67j2KVV
 H77XDYicZKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZkkKegAKCRDBN2bmhouD
 10zeD/9LfamfgRtnC6WMvXQurEjIgWPBl+boP6wp5/+Bi86/bOs1ouo0nnu9pI+0ybWJzt/n+dw
 6DuTheLT/WhJE4HO/wQ39p2be7U7RrC0PwKUZWKGARp3AVm6mxvSzYNSTGLiljHXCI/XKtr1NaU
 kvombFH62fl9t99RRR5xxGdHVhgKqZD62fLVLX+OAZLCok4PFWnz0ZP/cxcYo4f+ssiafMMFJSv
 78CRo35JN3QsM63rLh6LNfSB2y/ietKEtVDHf7Abo7K4xt+j2QZT6mC/y8/a730Z9oBDZgo8khY
 RXbz2whmYmoEW5YC3awItJLykLea5rKmeP28o3IdcJwj50Ynhjz+59G/ufG37zWkx2QV8012Id0
 VPFNTmVaySmgbXROF4tVokgy8dspivCogDgTfhCNZ19LdbwsyFp8jULLYwJGUGot66W8RS99tgq
 F3t2NdIVvAeJlo6EOfGkOG0cf8vZkQLRkXLkxihyJFUMEaVLSFNeemODnzWVQVOwn2gD6SCeN+3
 Z9Eh9Wmc90Vb50TJAec8+XqUfHNjzJUJ4ddzCUTASzzoFqwvjXzEfTMUmOVLZIDAGl1EqJwTZ6Y
 vBg3+3iQsFRXkTfrL7Jlwvo9J8NS4R45r+PGo3g/alDHUb3/TOsN4dvsy1M5Wra0Ox95lwEKwpx
 JPR0dUw8uavXmgg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add dedicated binding for the AM654 MCU SCM system controller registers,
already used in the DTS to properly describe its children.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../soc/ti/ti,am654-system-controller.yaml         | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml b/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml
new file mode 100644
index 000000000000..e79803e586ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/ti/ti,am654-system-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI AM654 System Controller Registers R/W
+
+maintainers:
+  - Kishon Vijay Abraham I <kishon@ti.com>
+  - Roger Quadros <rogerq@kernel.org>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - ti,am654-system-controller
+      - const: syscon
+      - const: simple-mfd
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
+  ranges: true
+
+patternProperties:
+  "^phy@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/phy/ti,phy-gmii-sel.yaml#
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    syscon@40f00000 {
+        compatible = "ti,am654-system-controller", "syscon", "simple-mfd";
+        reg = <0x40f00000 0x20000>;
+        ranges = <0x0 0x40f00000 0x20000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        phy@4040 {
+            compatible = "ti,am654-phy-gmii-sel";
+            reg = <0x4040 0x4>;
+            #phy-cells = <1>;
+        };
+    };

-- 
2.43.0


