Return-Path: <linux-kernel+bounces-370136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C4D9A284C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 745AB1C2188B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67CF1DF27F;
	Thu, 17 Oct 2024 16:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="URScoFi3"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467B91DE3B7
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729181758; cv=none; b=j7hulSjrjVBN/ErzY5U+IpBhEsKAZR8sutcRIDUht1eLwK1I1PBXwrIcMoKfsyXDViKWZXN4ReQC8m/UPnNJpHYcKfSEeijpg/EBe9BVZrjEJYyNjG0nFP3CK0DVshBJ+ayE5zBKZswGwpWXHXZVJZOB56WQCOSY0fHhIz6CIS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729181758; c=relaxed/simple;
	bh=O67/rmlGmzlrc+cSv92XCIyID9dUin6lc5DXfaUH4rY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bCXFq8RRYGDYsZ7DpHzv+Jah8aza3o5DaSR3itb2k6ZH/nSHZ6v9LSjSy+sc9RZK7nGF5yrdJnXDtuwkt6cS/tGJpbU3Pmd9szQceDHwRMXQnaMKG92VvY0DM61t3NoftRXBbkYGJwuelRwD9IJDhPIMlbjF5kJFSkFqVcSPifQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=URScoFi3; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539eb97f26aso1382985e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729181751; x=1729786551; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=09RI4LDTl7rc2TinscSjqvsMNphto4hHsHa2fzZZWkE=;
        b=URScoFi3njgU6HqFzUMs7Mat3ef2mwOECIGAvFbA++V//wAL2pHMSsWUM9yCKUtCu9
         IuGd8+FClpPCME0azfgtRGFDPkYTDLxAOPFIlfoF5oF8quf3a2DZmHkzawMq2oU4gPQS
         cykidyJ1FAgpgG2/INYASgln+9YblV0koPZJEBMUESX5Xn2x3sGO5OW5ktKJeQpYek3k
         +Y1PMsKzhKFleyFje0YJXCAfhbyqfec3aP1Pfsa9K18BkEVMjiR/+bpSvLnDDJlD7m/g
         kRw6oTNcbsosPHY7iYwILVJeHl+EvCaxC38NV0OwXYNQdKIOE9f8ill2IE1atObIjM1M
         /3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729181751; x=1729786551;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09RI4LDTl7rc2TinscSjqvsMNphto4hHsHa2fzZZWkE=;
        b=kbZx0i2XqmJ+AOZYum19wIZAN6YhWp5yle/T9gpJ5bynBYhg0D6d4jMietOHpuhKCG
         47ApTFXB4AaTE0+sTbYEmvgcSeQnfCXy+BUlAYF3UsdgPcwAzGUMB8Q5lMBKq6GutubJ
         RdyKI9KbQXUawtSZ+wY4Gem8juDbNZB+DErW5TShbQ/4ZnBVOPP6O4aSU6l4gwS0vf7M
         FQiwb9Rk5yUDJEdm7Unkg/9soKNi6W3TtA4SpAllcfvV+EsKyz95VlotrWSMToKtErR0
         WI0HXyO3aPRbhqdzQUKfCJdDWIju/TplW1Ht2bFTqhp3Rhh+bANEHERo96VhXpVBzZgs
         pFzA==
X-Forwarded-Encrypted: i=1; AJvYcCWmxVp5yXmm55UdOYmuDRPfek/Yk69578d12UtXWZZwtY9LGuiK+CeNJqQAimehSw29FOYwERqppb7M3jk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHOfUxT6E6WbUBgA6Kjf4B04zl33RRAYwjP6p30U5sPuePSE6I
	AiIh42g8ztYfZ3csNy3ngyeypJ1LZAoARRBMA0mGJ70DU/mKAcn1E54oYI7G/kI=
X-Google-Smtp-Source: AGHT+IHhbgvYm/prl5JrJyLRtCGUqKL6R/HrQ4Y5Epmz9U5AzKi99ibpsc8hsW1vLaAX/vAGpX7mmA==
X-Received: by 2002:a05:6512:1599:b0:539:fbfd:fc74 with SMTP id 2adb3069b0e04-539fbfdfd60mr8501215e87.40.1729181751400;
        Thu, 17 Oct 2024 09:15:51 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539fffa88f0sm807114e87.44.2024.10.17.09.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 09:15:49 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 17 Oct 2024 19:15:45 +0300
Subject: [PATCH 1/2] dt-bindings: pinctrl : qcom: document SAR2130P TLMM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-sar2130p-tlmm-v1-1-8d8f0bd6f19a@linaro.org>
References: <20241017-sar2130p-tlmm-v1-0-8d8f0bd6f19a@linaro.org>
In-Reply-To: <20241017-sar2130p-tlmm-v1-0-8d8f0bd6f19a@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5502;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=O67/rmlGmzlrc+cSv92XCIyID9dUin6lc5DXfaUH4rY=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnETgyQBCCuIEhlRZRwShjlaBfVIyKPa1GsUklx
 LZCk9hn5QOJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZxE4MgAKCRAU23LtvoBl
 uHoyEAC2VVKiw3UDGj2JjJ0PoFDsLNVkEp9LhE6jKFpw6cKs6hLefIOcdAkflDlIPoJSV2mAHPW
 ygTD+IdHdwvWtXUVvkKfq4CI9bY87fOCEhOjWDIz3OGXncmE4WH31yrDW4cN+e1Ebn7JYuzzqlh
 fIbxdWrNMbsrLuxrCgIYKn4QvnzmqE8I8XJ998FMutQk6HuSUS+9TX2J5ufIDi+YT+oPWf1hpZR
 RQOW2ICTH9vyABC3AbJJIwB+NYDS/Va9nx+HTK/BydQ1PlssbvAHN+KIx1WP7QOidlEnxZ0laU5
 jcofBJ7zyWpn9Kn9zvTzg6ikvzblMV++lU3XUXFDfUd3mCPEM95ROWdF4aHRCkTTjjOsdDiFT3g
 RapryszRRXIfHID0BFgcaamhrlhg1dex3K1bZ/hkhg9uvjF3aVnmMttGKeF0+VurJxKIamNwiqy
 i/ltYRcPgHD6lZsMCW/mfeMo3FjjNMhoGzGwAO7JEx+WvTLwbQ5zmYVkB2cuTUdHymF69VFWNWK
 +pK6yTvQpKcN7ymKMruOSoPObp1WRMWxukmMAmYVV5kBCd9BB66Z5MsTnZSx76x91QtpgYBLr7c
 y+aQC/1TMLLv6E3fy7AJermaYHC4A50wNqfnbKLKIYuOG/linA66CcMHdcDDyO7VAsOpVYgyEsy
 gH/gzUW1xt0yDQg==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Add bindings for the pin controller (TLMM) present on the
Qualcomm SAR2130P platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../bindings/pinctrl/qcom,sar2130p-tlmm.yaml       | 138 +++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sar2130p-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sar2130p-tlmm.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..a8daa96936599e459c801b6685a42659271604ee
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sar2130p-tlmm.yaml
@@ -0,0 +1,138 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,sar2130p-tlmm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. SAR2130P TLMM block
+
+maintainers:
+  - Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
+
+description:
+  Top Level Mode Multiplexer pin controller in Qualcomm SAR2130P SoC.
+
+allOf:
+  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
+
+properties:
+  compatible:
+    const: qcom,sar2130p-tlmm
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  gpio-reserved-ranges:
+    minItems: 1
+    maxItems: 105
+
+  gpio-line-names:
+    maxItems: 156
+
+patternProperties:
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-sar2130p-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-sar2130p-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-sar2130p-tlmm-state:
+    type: object
+    description:
+      Pinctrl node's client devices use subnodes for desired pin configuration.
+      Client device subnodes use below standard properties.
+    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
+    unevaluatedProperties: false
+
+    properties:
+      pins:
+        description:
+          List of gpio pins affected by the properties specified in this
+          subnode.
+        items:
+          oneOf:
+            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-9][0-9]|20[0-9])$"
+            - enum: [ sdc1_clk, sdc1_cmd, sdc1_data, sdc1_rclk ]
+        minItems: 1
+        maxItems: 36
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+        enum: [ aoss_cti, atest_char, atest_char0, atest_char1, atest_char2,
+                atest_char3, atest_usb0, atest_usb00, atest_usb01, atest_usb02,
+                atest_usb03, audio_ref, cam_mclk, cci_async, cci_i2c,
+                cci_timer0, cci_timer1, cci_timer2, cci_timer3, cci_timer4,
+                cri_trng, cri_trng0, cri_trng1, dbg_out, ddr_bist, ddr_pxi0,
+                ddr_pxi1, ddr_pxi2, ddr_pxi3, dp0_hot, ext_mclk0, ext_mclk1,
+                gcc_gp1, gcc_gp2, gcc_gp3, gpio, host2wlan_sol, i2s0_data0,
+                i2s0_data1, i2s0_sck, i2s0_ws, ibi_i3c, jitter_bist, mdp_vsync,
+                mdp_vsync0, mdp_vsync1, mdp_vsync2, mdp_vsync3, pcie0_clkreqn,
+                pcie1_clkreqn, phase_flag0, phase_flag1, phase_flag10,
+                phase_flag11, phase_flag12, phase_flag13, phase_flag14,
+                phase_flag15, phase_flag16, phase_flag17, phase_flag18,
+                phase_flag19, phase_flag2, phase_flag20, phase_flag21,
+                phase_flag22, phase_flag23, phase_flag24, phase_flag25,
+                phase_flag26, phase_flag27, phase_flag28, phase_flag29,
+                phase_flag3, phase_flag30, phase_flag31, phase_flag4,
+                phase_flag5, phase_flag6, phase_flag7, phase_flag8,
+                phase_flag9, pll_bist, pll_clk, prng_rosc0, prng_rosc1,
+                prng_rosc2, prng_rosc3, qdss_cti, qdss_gpio, qdss_gpio0,
+                qdss_gpio1, qdss_gpio10, qdss_gpio11, qdss_gpio12, qdss_gpio13,
+                qdss_gpio14, qdss_gpio15, qdss_gpio2, qdss_gpio3, qdss_gpio4,
+                qdss_gpio5, qdss_gpio6, qdss_gpio7, qdss_gpio8, qdss_gpio9,
+                qspi0, qspi1, qspi2, qspi3, qspi_clk, qspi_cs0, qspi_cs1, qup0,
+                qup1, qup2, qup3, qup4, qup5, qup6, qup7, qup8, qup9, qup10,
+                qup11, tb_trig, tgu_ch0, tgu_ch1, tgu_ch2, tgu_ch3,
+                tmess_prng0, tmess_prng1, tmess_prng2, tmess_prng3,
+                tsense_pwm1, tsense_pwm2, usb0_phy, vsense_trigger ]
+
+    required:
+      - pins
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    pinctrl@f100000 {
+        compatible = "qcom,sar2130p-tlmm";
+        reg = <0x0f100000 0x300000>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        gpio-ranges = <&tlmm 0 0 156>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+
+        gpio-wo-state {
+            pins = "gpio1";
+            function = "gpio";
+        };
+
+        uart-w-state {
+            rx-pins {
+                pins = "gpio26";
+                function = "qup7";
+                bias-pull-up;
+            };
+
+            tx-pins {
+                pins = "gpio27";
+                function = "qup7";
+                bias-disable;
+            };
+        };
+    };
+...

-- 
2.39.5


