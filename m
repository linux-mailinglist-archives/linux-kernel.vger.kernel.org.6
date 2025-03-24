Return-Path: <linux-kernel+bounces-573661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0190A6DA55
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BE2F1894838
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F89025F791;
	Mon, 24 Mar 2025 12:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NP+xK7Fw"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055E825EF9B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 12:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742820709; cv=none; b=OogjQq9WjMki8eRCCrUOGxJjN0d8atLzuy1rxN1Gnju1I0Ms1dV81jiiWTYGzvVtELUMqtFR58hCDTcloQcJOW9fwRLbfcWCJbzPyGWlF8rc/nnd4p+18yYGTj+D2rONKKa32U9b3IlLtaIDKLuDf5Efu7fds/vdUBHz2ent5Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742820709; c=relaxed/simple;
	bh=5xx5FlSKyFLZJzr6V7Uye9kG+TXRdex/gunTUYdSsNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HwBPu83tMDOsIvu2pOMIsvihmwanWNrxTErRgIg9yJq8qqOjkhpOQg6nCBBSeIVCUC+HxMNTxngQR9SfAGQ4OJh3ijDY1hjOEOKAqiGOY3eLGM9IkgQIdO4p865xkhcyKCesTz2gIYTuXDB1tHtndsg86OyPSdnhY1P9Hme+Wk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NP+xK7Fw; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4394944f161so4662675e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 05:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742820706; x=1743425506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kUoMpr+FmTJUUYgunEAsWmKDX1DoLLbcuPSMJE5oesQ=;
        b=NP+xK7Fw++10iicRo50MFXoOH+THisvuEjDQ5+muT3sN7nbiMPJCfhnlcZ5RmRw/VU
         xtZIvrHUnglYK8dfRV+Bvk00JyqEEBNaTAYo3Yt7mKXJTWktlQwYzWtkcTCQZPeO5nAs
         5XMj3Kiv1PoTm8BwAJgu2B6sR3b8h0A9ea9nWC7Vog7PGbPbD0jMYgP+Jkm2GWI+56iq
         YKPn0LTQwCx5SOwXl2XGJ7mfT2WEhegQn7cGcfq6BxzNsuSqdX6g7FU3fsJaPFXooCeX
         HrGBKXiNK2Sw1r/Yq87qHqBfIlpv2NFORQwodB8Eh9TxqM3kELn8XwhjA5YuETNcN0vF
         3k2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742820706; x=1743425506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kUoMpr+FmTJUUYgunEAsWmKDX1DoLLbcuPSMJE5oesQ=;
        b=t3BrXJJYqvrzG33UlRkcR3memazaVmTnuV6TGSD2vMqDEND7NyGOhMyjsYFr6VOniQ
         IHeag39kGY8QRK5aFlkA+pbfg1/uI+3pYhdC/cmEbzhunnZX8V3ZWqORvW4idwzEmgGV
         xBac2e8doyYI3zByy5MJlWoqVhNKGqQiLJbWFcPOYPUQmpNufFdMtCGUgPT9zCMdKnqx
         bQYShM5EBPvN3ianIr5n2butofQyY5WIwaGRkONIVErODLwidBai7T5mvpGQtQ2nca29
         J/QiKkLaD0z/Oin2/dj6z15P9h8vpFOATQpb+RKaGE0ZPSeY12q8i789gnQtylcZt0DS
         nSWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXapfkeFHHTR567ubvYPxy+QcmVylfw9Vh69tN2/VZzGs4cHfmN5ab+gbthNGVglN8rE1q66vmn6xvR2Dw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzehe+L3WMAt/P/j4xMfb9OFgpW4J8mH/7gEiEOVIdGaO+iq+tj
	nrfqEgd6kOvLtx2gzgnCeV8uX6sP/yFtLcVKh4bpu7tQfwU+vQY3cre/hoE65Pk=
X-Gm-Gg: ASbGncv6QDOLGioJRbJoSGvTgI32Y7kqdZSLAqBV4goigEvxBJTqNeZ8VyjfTPQNJdt
	o75ZwI6F9c4TmKcHfxlPoLnnIQVyHu7GqgdCWz6p+ggBAYuY14zkGaLS1lLrEWrHXC3Uk057uRd
	eNeUWaWaut+FlaxGE2saxaurbHMkCFW/88RXB/Lar5eehMT+jorcxqOEst1janD0xdjpVpKspbN
	j747WNgMtbVHhnZIgF7Wp7m4ShG3sc95/1Y7Aj7WZSSwpeZ45wxIIZ8cWGOixqIu6J3dzEuJV36
	ay/k3oLwWE/dwVYaRBj5yuAYR1zguIsDTothmkI+EH246ab8VHaElCrjWQ==
X-Google-Smtp-Source: AGHT+IHWJMXQRiamAeJVWu4eRAJNadDYJhtO38dS8WMcOCTUIapL+/uAak0BnxNe/tjBFhmz9SU7Qg==
X-Received: by 2002:a05:6000:154a:b0:390:d964:d325 with SMTP id ffacd0b85a97d-3997f9406dcmr4123049f8f.8.1742820706146;
        Mon, 24 Mar 2025 05:51:46 -0700 (PDT)
Received: from krzk-bin.. ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9ef063sm10713445f8f.83.2025.03.24.05.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 05:51:45 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dongjin Kim <tobetter@gmail.com>,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: usb: smsc,usb3503: Correct indentation and style in DTS example
Date: Mon, 24 Mar 2025 13:51:42 +0100
Message-ID: <20250324125142.81910-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DTS example in the bindings should be indented with 2- or 4-spaces and
aligned with opening '- |', so correct any differences like 3-spaces or
mixtures 2- and 4-spaces in one binding.

No functional changes here, but saves some comments during reviews of
new patches built on existing code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/usb/smsc,usb3503.yaml | 84 +++++++++----------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/smsc,usb3503.yaml b/Documentation/devicetree/bindings/usb/smsc,usb3503.yaml
index 6156dc26e65c..18e35122dc1f 100644
--- a/Documentation/devicetree/bindings/usb/smsc,usb3503.yaml
+++ b/Documentation/devicetree/bindings/usb/smsc,usb3503.yaml
@@ -106,54 +106,54 @@ additionalProperties: false
 
 examples:
   - |
-      i2c {
-          #address-cells = <1>;
-          #size-cells = <0>;
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
 
-          usb-hub@8 {
-              compatible = "smsc,usb3503";
-              reg = <0x08>;
-              connect-gpios = <&gpx3 0 1>;
-              disabled-ports = <2 3>;
-              intn-gpios = <&gpx3 4 1>;
-              reset-gpios = <&gpx3 5 1>;
-              initial-mode = <1>;
-              clocks = <&clks 80>;
-              clock-names = "refclk";
-          };
-      };
+        usb-hub@8 {
+            compatible = "smsc,usb3503";
+            reg = <0x08>;
+            connect-gpios = <&gpx3 0 1>;
+            disabled-ports = <2 3>;
+            intn-gpios = <&gpx3 4 1>;
+            reset-gpios = <&gpx3 5 1>;
+            initial-mode = <1>;
+            clocks = <&clks 80>;
+            clock-names = "refclk";
+        };
+    };
 
   - |
-      i2c {
-          #address-cells = <1>;
-          #size-cells = <0>;
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
 
-          usb-hub@8 {
-              compatible = "smsc,usb3803";
-              reg = <0x08>;
-              connect-gpios = <&gpx3 0 1>;
-              disabled-ports = <2 3>;
-              intn-gpios = <&gpx3 4 1>;
-              reset-gpios = <&gpx3 5 1>;
-              bypass-gpios = <&gpx3 6 1>;
-              initial-mode = <3>;
-              clocks = <&clks 80>;
-              clock-names = "refclk";
-          };
-      };
+        usb-hub@8 {
+            compatible = "smsc,usb3803";
+            reg = <0x08>;
+            connect-gpios = <&gpx3 0 1>;
+            disabled-ports = <2 3>;
+            intn-gpios = <&gpx3 4 1>;
+            reset-gpios = <&gpx3 5 1>;
+            bypass-gpios = <&gpx3 6 1>;
+            initial-mode = <3>;
+            clocks = <&clks 80>;
+            clock-names = "refclk";
+        };
+    };
 
   - |
-      #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/gpio/gpio.h>
 
-      usb-hub {
-          /* I2C is not connected */
-          compatible = "smsc,usb3503";
-          initial-mode = <1>; /* initialize in HUB mode */
-          disabled-ports = <1>;
-          intn-gpios = <&pio 7 5 GPIO_ACTIVE_HIGH>; /* PH5 */
-          reset-gpios = <&pio 4 16 GPIO_ACTIVE_LOW>; /* PE16 */
-          connect-gpios = <&pio 4 17 GPIO_ACTIVE_HIGH>; /* PE17 */
-          refclk-frequency = <19200000>;
-      };
+    usb-hub {
+        /* I2C is not connected */
+        compatible = "smsc,usb3503";
+        initial-mode = <1>; /* initialize in HUB mode */
+        disabled-ports = <1>;
+        intn-gpios = <&pio 7 5 GPIO_ACTIVE_HIGH>; /* PH5 */
+        reset-gpios = <&pio 4 16 GPIO_ACTIVE_LOW>; /* PE16 */
+        connect-gpios = <&pio 4 17 GPIO_ACTIVE_HIGH>; /* PE17 */
+        refclk-frequency = <19200000>;
+    };
 
 ...
-- 
2.43.0


