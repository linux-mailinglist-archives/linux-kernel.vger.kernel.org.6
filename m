Return-Path: <linux-kernel+bounces-202564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1F58FCE12
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 14:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0238E1F28396
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 12:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ED31B0109;
	Wed,  5 Jun 2024 12:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xxzHVNqo"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A81197A8E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 12:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589704; cv=none; b=U/xggxJ/TAtbGiGz3Vg9g3C6Q4Qgc0ajgXv+cpgUvRA+GkXBLaC+OvDTqPsMgwwM5Ml7OGlN/HkhNstBFdrlz8uEaMcAqwmuLdDCLJO6QDX7viv2yOvLF/3ehneFpOH0VLgDyFJaqzdx9tENgkDDcTxitOV1EG28JNXMXCmCSCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589704; c=relaxed/simple;
	bh=/VfEqkVwMLSJQyqitV3O6wbGWZZSauTXI2xaR9/HlKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PgKlA4Rj+l5E+rEIKxBj+gDYFDClibB6vGWO2aWzVpMnS1rT0kd6mKpQ1iDC8VOp5u8RpNlxZuUoJRIoT0cP+RAnCl0SLy9YNYN/CJrtX2vs2NgSzwspfcDN97ZacRFW9wJyEXjENy3NlnUuE3iZIzuxgWDIHqFYnhYI34X9je0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=xxzHVNqo; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-35e5604abdcso539076f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 05:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1717589701; x=1718194501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JdSLvtN+Ti6ALvJJmVShDyYuGeu2NdqVBeYATCJyvs=;
        b=xxzHVNqoxLkcECYO+YArTjpwoowgeCB5BbeBp7VCs4fgmb9RnW3N5S6+kyJKqkiarR
         96FQ9Q3mCqW29aRnYXN/nq7qyXPrqMg1va37f74eBoAgVzH/OGvT90APd3lt5H7i1AY6
         MxXG3aXaTfD21LK25SOMTlL9WbSXYogSAdVUkjzLp3Oj6fLImTJ1QO0N/o/sUOxzV4Ea
         WosIM+HsLd1JDaVCpl30Wn6xX275ae//GwNwoX6YMAlDynT0z/xXv3RUXBlXwoXiaLIP
         1qceRERdXExNcPcv8BQlnU8hbFwEpremuPTkNPegH97yLNCn5hsta+PbR7PwoQhI5w0D
         U1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717589701; x=1718194501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8JdSLvtN+Ti6ALvJJmVShDyYuGeu2NdqVBeYATCJyvs=;
        b=FaX1aLUWzlLIUG992mUxxbKpNERbziX1xVRmpK2kbMClOyZfBV8xMBV822R+MvWTFp
         l1NbYEjHW2R50Y8fa6KBMe1GerFoLUiTwfKL+GM6MUwLWNdm3qjtPccUH+KF8aZZCu3k
         5yHCNazf04ezceT2aTX6a9jjScQ7eyzP8T2ACVrjaInH1kodVJWTQFeKnoQSo8T4hWO2
         y8CYmlAr46fLxiG6eqp0HwDtcqwX9bG4uhF7Hd040dYWr9ipDTlvDEj+v8ujm2ftLMYL
         y8JhK3EcddiwgGwQ/w3/KSnlvTTUxPxmBZb2n5HhPLHStqYISQl3Yb9lL9LFZG3Wd2tM
         rWAA==
X-Forwarded-Encrypted: i=1; AJvYcCV+iOQnAIws1GrpoEXjNfLISSeXtxKnFIyWeHZbGlaIxiWx+l3KqchHQudfM4caH71wtyD0U9Qt2K17hTyrTDg4kXir+PwzVziiYXvW
X-Gm-Message-State: AOJu0YyvGOpAnGFzlfI344Cny6hCyJpYYevVspqnEQC5+rOdEvIdfYoI
	T32fF1tgTfIXIPTfuZyKn65ikDxsSJ5PudUqVlKuLcOj7UxkaHnk8OD2lSV+vWU=
X-Google-Smtp-Source: AGHT+IFWaDbbBHJSamvCV4gCt89/6ekiusL7PPyQ9yvBWlHqVVkTisLXnwr4inKcCfQQ3iiIiFQc4w==
X-Received: by 2002:a5d:6287:0:b0:356:4809:1a7e with SMTP id ffacd0b85a97d-35e839f43admr2118407f8f.34.1717589700827;
        Wed, 05 Jun 2024 05:15:00 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:d3dd:423:e1eb:d88b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04d94e6sm14415794f8f.51.2024.06.05.05.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 05:14:59 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v9 1/2] regulator: dt-bindings: describe the PMU module of the QCA6390 package
Date: Wed,  5 Jun 2024 14:14:48 +0200
Message-ID: <20240605121450.23697-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605121450.23697-1-brgl@bgdev.pl>
References: <20240605121450.23697-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The QCA6390 package contains discrete modules for WLAN and Bluetooth. They
are powered by the Power Management Unit (PMU) that takes inputs from the
host and provides LDO outputs. This document describes this module.

Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../bindings/regulator/qcom,qca6390-pmu.yaml  | 151 ++++++++++++++++++
 1 file changed, 151 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml

diff --git a/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml b/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
new file mode 100644
index 000000000000..4588b4e862a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
@@ -0,0 +1,151 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/qcom,qca6390-pmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. QCA6390 PMU Regulators
+
+maintainers:
+  - Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
+
+description:
+  The QCA6390 package contains discrete modules for WLAN and Bluetooth. They
+  are powered by the Power Management Unit (PMU) that takes inputs from the
+  host and provides LDO outputs. This document describes this module.
+
+properties:
+  compatible:
+    const: qcom,qca6390-pmu
+
+  vddaon-supply:
+    description: VDD_AON supply regulator handle
+
+  vddpmu-supply:
+    description: VDD_PMU supply regulator handle
+
+  vddrfa0p95-supply:
+    description: VDD_RFA_0P95 supply regulator handle
+
+  vddrfa1p3-supply:
+    description: VDD_RFA_1P3 supply regulator handle
+
+  vddrfa1p9-supply:
+    description: VDD_RFA_1P9 supply regulator handle
+
+  vddpcie1p3-supply:
+    description: VDD_PCIE_1P3 supply regulator handle
+
+  vddpcie1p9-supply:
+    description: VDD_PCIE_1P9 supply regulator handle
+
+  vddio-supply:
+    description: VDD_IO supply regulator handle
+
+  wlan-enable-gpios:
+    maxItems: 1
+    description: GPIO line enabling the ATH11K WLAN module supplied by the PMU
+
+  bt-enable-gpios:
+    maxItems: 1
+    description: GPIO line enabling the ATH11K Bluetooth module supplied by the PMU
+
+  regulators:
+    type: object
+    description:
+      LDO outputs of the PMU
+
+    patternProperties:
+      "^ldo[0-9]$":
+        $ref: regulator.yaml#
+        type: object
+        unevaluatedProperties: false
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - regulators
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,qca6390-pmu
+    then:
+      required:
+        - vddaon-supply
+        - vddpmu-supply
+        - vddrfa0p95-supply
+        - vddrfa1p3-supply
+        - vddrfa1p9-supply
+        - vddpcie1p3-supply
+        - vddpcie1p9-supply
+        - vddio-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    pmu {
+        compatible = "qcom,qca6390-pmu";
+
+        pinctrl-names = "default";
+        pinctrl-0 = <&bt_en_state>, <&wlan_en_state>;
+
+        vddaon-supply = <&vreg_s6a_0p95>;
+        vddpmu-supply = <&vreg_s2f_0p95>;
+        vddrfa0p95-supply = <&vreg_s2f_0p95>;
+        vddrfa1p3-supply = <&vreg_s8c_1p3>;
+        vddrfa1p9-supply = <&vreg_s5a_1p9>;
+        vddpcie1p3-supply = <&vreg_s8c_1p3>;
+        vddpcie1p9-supply = <&vreg_s5a_1p9>;
+        vddio-supply = <&vreg_s4a_1p8>;
+
+        wlan-enable-gpios = <&tlmm 20 GPIO_ACTIVE_HIGH>;
+        bt-enable-gpios = <&tlmm 21 GPIO_ACTIVE_HIGH>;
+
+        regulators {
+            vreg_pmu_rfa_cmn: ldo0 {
+                regulator-name = "vreg_pmu_rfa_cmn";
+            };
+
+            vreg_pmu_aon_0p59: ldo1 {
+                regulator-name = "vreg_pmu_aon_0p59";
+            };
+
+            vreg_pmu_wlcx_0p8: ldo2 {
+                regulator-name = "vreg_pmu_wlcx_0p8";
+            };
+
+            vreg_pmu_wlmx_0p85: ldo3 {
+                regulator-name = "vreg_pmu_wlmx_0p85";
+            };
+
+            vreg_pmu_btcmx_0p85: ldo4 {
+                regulator-name = "vreg_pmu_btcmx_0p85";
+            };
+
+            vreg_pmu_rfa_0p8: ldo5 {
+                regulator-name = "vreg_pmu_rfa_0p8";
+            };
+
+            vreg_pmu_rfa_1p2: ldo6 {
+                regulator-name = "vreg_pmu_rfa_1p2";
+            };
+
+            vreg_pmu_rfa_1p7: ldo7 {
+                regulator-name = "vreg_pmu_rfa_1p7";
+            };
+
+            vreg_pmu_pcie_0p9: ldo8 {
+                regulator-name = "vreg_pmu_pcie_0p9";
+            };
+
+            vreg_pmu_pcie_1p8: ldo9 {
+                regulator-name = "vreg_pmu_pcie_1p8";
+            };
+        };
+    };
-- 
2.40.1


