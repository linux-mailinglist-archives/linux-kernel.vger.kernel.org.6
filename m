Return-Path: <linux-kernel+bounces-350436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC3A99051C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B09F1C22A4C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 14:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F4C21BAF7;
	Fri,  4 Oct 2024 13:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vZdeYk1M"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3E3217329
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 13:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728050279; cv=none; b=k0ZUeaTtTGMV25EJHphGBdBtgGy6La7+NC1+eJ6Jdd6CgMTWLrqnwQeEJ5CVaYfBP5asUNgCh1MlnIgyn83/O401aap9gU6sSrzQARhvaGTfA+C8wbudwd5p4UpDYkigZCCPWCRkmW/mn2WJpcRywIxc6nyhD8/fmCeZy+ztXDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728050279; c=relaxed/simple;
	bh=32lSRc+1qr/HmxpyY50wMuVdjBVIZ6e2CK03ub7GksA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WnFpu1o/o7uHnArNa0/IznvhNJ5kEhqmW94AleXq0J7/UYgNI1uCr9bkbyN6PTJvHiAwsa0bDGIg/c2C7N1+zAX2J3LDL5I8qvf2wPgxGEVGlmrkefBwCnweSpvPgya70B42H2OCPrZIJeinTOVJao7boddMhfISp5bsbwgb6pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vZdeYk1M; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37cc5fb1e45so1601968f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 06:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728050275; x=1728655075; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wqjG39078JrwA8K8jzhRJZ2gHveAtIRvIsyzWgvSmRs=;
        b=vZdeYk1M8ierty7B75329aCpVaO1hkuFS7bRxQMC3qegu6IWbURLLlf5aOcHPS31hi
         EXxmmIKBRnDPTvLVQGr7DfKQDi7cLTwQCHJ/CooXByEGiQRb+GKjpXC4WL2gRQLic8rz
         gxIAF9niATxAWTWtzeH/86oSqaymDPrF1AAvmHgam2G4BeE+Uzcn437yPqLu1QV3uK2T
         +oKvLNADMuq2CE+MrV5C/JwkCLs8C/CoxD56U2oZJkacH1dmDtxc04oNkO9ztSRjJVmY
         3QKyrGztHuuc72i7dXz0DUt85E7DkBj666fLwkmOuCtcDL1G7Ra3lMpR3TkTXm7zgZBT
         p7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728050275; x=1728655075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqjG39078JrwA8K8jzhRJZ2gHveAtIRvIsyzWgvSmRs=;
        b=uu+I0FWuUAJJDH358gIpuw0ruH4QPoPk118obd2xACV14oLk0XGSG1P2NP6caNvtyu
         sxQtra9lnYEQogEkWHmANFFmRhxAkWtV6uvlcuK+BXpC/gABNF1eaXSvq4Q1YxNe0JYE
         h18zsc0r6d4dJt0VntRfj9NIiNyrPApAzlYDXbwaO5W3wvl6d27S+F5ReahModERMVLp
         sRI4DOGQqFd54U1tsZyUTKsn6Ld8Z2y4aIx/3X2vmjh302KsWMZTnC1/3s9zuapaQyVD
         CuUJJaYsd7EbtPDUejxDP9haqitWvfwMEV7hGoaq4QT1fHYCX92DllD14ZKvbfvNd1YM
         k8Vg==
X-Forwarded-Encrypted: i=1; AJvYcCXvS1qfGyN0dxNdTvKIrFOqsDdH3Rk5xzhpn4Lc0xvtIOPojbcjo8sDVCHFt9LTknkt082EChYHIGBx/k8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoWCqEUj6P6j6fW+bk/cRDuqV2OJeBCDfSuwI8GuKvtygqV6fF
	TgCKz98470m88h86PeKUqftat/DCyx0C5IClHRbOweoECkgfWJEQkMZUFca+rX8=
X-Google-Smtp-Source: AGHT+IEI4pA3wtrU34B2kTrRn2BuWktFwdwruRzsOjX6eEkjsqGtsBdh2vfnuvB18+SKyhbAlaJXgQ==
X-Received: by 2002:adf:fac4:0:b0:374:caf6:ca2f with SMTP id ffacd0b85a97d-37d0e7b9cf1mr1993189f8f.45.1728050275245;
        Fri, 04 Oct 2024 06:57:55 -0700 (PDT)
Received: from [127.0.1.1] ([82.77.84.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d08215cd6sm3302550f8f.28.2024.10.04.06.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 06:57:54 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Fri, 04 Oct 2024 16:57:37 +0300
Subject: [PATCH v2 1/2] dt-bindings: usb: Add Parade PS8830 Type-C retimer
 bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241004-x1e80100-ps8830-v2-1-5cd8008c8c40@linaro.org>
References: <20241004-x1e80100-ps8830-v2-0-5cd8008c8c40@linaro.org>
In-Reply-To: <20241004-x1e80100-ps8830-v2-0-5cd8008c8c40@linaro.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Sibi Sankar <quic_sibis@quicinc.com>, Johan Hovold <johan@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Trilok Soni <quic_tsoni@quicinc.com>, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4063; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=32lSRc+1qr/HmxpyY50wMuVdjBVIZ6e2CK03ub7GksA=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBm//RcnX+oTlx5L4EamD9KoCZj97afDs8xQV/Ca
 Wb37fo9FOSJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZv/0XAAKCRAbX0TJAJUV
 VpE2D/9oPUIm/Jp7VvO+TMWfOv1xvOoQc9TEmj1RBlP0XEmCjXAPZlkZVqeUvyKpcKvxF4t7okR
 kNOtFzaKBl+oitbBpXDcYinb42ueEyGsPKdND8lqhhHuWYdsJMLgslPFLSQt2kqfr2/W9zQHwj8
 JmmYs9fYHugs8WVkatxPTMY0HxZQNCZiLgxEMz7e9amVqUCCtgAzj85p3KvT8Kj0xJhgK1CwSq3
 AdPMMZpR91rMzy15TfD2RpOdv2aU3nOJyC2jV5fC5jM4bthW+PWyAI6tst/6cWhFv+w/vo7DiAi
 ulfDGM0GJ1myoP2gR0u2zhO+henuDVDmYw/P62gnw/ibu93SgZzL2HUsGfWS3Vb6u9x8SrkJ0Eh
 wrYBETid0DPvf3QYKZWGjKs2hF6fyYHYhvx7Cq4J76J3e5MNs/meU4Av50z6vI3qDON6EG0NlhR
 Fw7hjd8NyAXkwgDDaR1WTV7DGRHuhoULuqNNr3PXU4wTbjR4l7TgfNGTPclLmYoLTB64dPIcWBt
 nbeMSuYUu7Lr79vXpwp8BN2c3kVLOZGynLG14PMO4EdVRFwQb5ICZ1s9lCUT9TmL03otF6osMQn
 Vy0Oc7OtQPu6F/089y8mWiRgKE8ffvxh3PxIJzZII/l/HDy9u1zbH5/LHy8CGPthFp4x5FxvPFk
 N8EssqAbHS8jwHw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Document bindings for the Parade PS8830 Type-C retimer. This retimer is
currently found on all boards featuring Qualcomm Snapdragon X Elite SoCs
and it is needed to provide altmode muxing between DP and USB, but also
connector orientation handling between.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../devicetree/bindings/usb/parade,ps8830.yaml     | 129 +++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/parade,ps8830.yaml b/Documentation/devicetree/bindings/usb/parade,ps8830.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..f6721d6eee26c6d4590a12c19791b3d47a8145f3
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/parade,ps8830.yaml
@@ -0,0 +1,129 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/parade,ps8830.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Parade PS8830 USB and DisplayPort Retimer
+
+maintainers:
+  - Abel Vesa <abel.vesa@linaro.org>
+
+properties:
+  compatible:
+    enum:
+      - parade,ps8830
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: XO Clock
+
+  clock-names:
+    items:
+      - const: xo
+
+  reset-gpios:
+    maxItems: 1
+
+  vdd-supply:
+    description: power supply (1.07V)
+
+  vdd33-supply:
+    description: power supply (3.3V)
+
+  vdd33-cap-supply:
+    description: power supply (3.3V)
+
+  vddar-supply:
+    description: power supply (1.07V)
+
+  vddat-supply:
+    description: power supply (1.07V)
+
+  vddio-supply:
+    description: power supply (1.2V or 1.8V)
+
+  orientation-switch: true
+  retimer-switch: true
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Super Speed (SS) Output endpoint to the Type-C connector
+
+      port@1:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        description: Super Speed (SS) Input endpoint from the Super-Speed PHY
+        unevaluatedProperties: false
+
+      port@2:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Sideband Use (SBU) AUX lines endpoint to the Type-C connector for the purpose of
+          handling altmode muxing and orientation switching.
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: usb-switch.yaml#
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        typec-mux@8 {
+            compatible = "parade,ps8830";
+            reg = <0x8>;
+
+            vdd-supply = <&vreg_rtmr_1p15>;
+            vdd33-supply = <&vreg_rtmr_3p3>;
+            vdd33-cap-supply = <&vreg_rtmr_3p3>;
+            vddar-supply = <&vreg_rtmr_1p15>;
+            vddat-supply = <&vreg_rtmr_1p15>;
+            vddio-supply = <&vreg_rtmr_1p8>;
+
+            reset-gpios = <&pm8550_gpios 10 GPIO_ACTIVE_HIGH>;
+
+            retimer-switch;
+            orientation-switch;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    usb_con_ss: endpoint {
+                        remote-endpoint = <&typec_con_ss>;
+                    };
+                };
+                port@1 {
+                    reg = <1>;
+                    phy_con_ss: endpoint {
+                        remote-endpoint = <&usb_phy_ss>;
+                        data-lanes = <3 2 1 0>;
+                    };
+                };
+                port@2 {
+                    reg = <2>;
+                    usb_con_sbu: endpoint {
+                        remote-endpoint = <&typec_dp_aux>;
+                    };
+                };
+            };
+        };
+    };
+...

-- 
2.34.1


