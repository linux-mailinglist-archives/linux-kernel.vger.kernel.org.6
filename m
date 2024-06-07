Return-Path: <linux-kernel+bounces-205827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 796729000E0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13040287152
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D219015ECC1;
	Fri,  7 Jun 2024 10:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="je+R2b+x"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9846115CD75
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 10:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717756364; cv=none; b=B0VIYP+3gJhdXOFjqrnrZsjY2bycz/pHl2T4EfZ1xIMOSN+b2iomNDehTSRha8FJvmTUdtDhLfEP/mbLMhg2Hkze5pTi4nC7V2Ab5VuWVjikuT6HrZFZQpFCHMUERvK8SfXTWlYMpv3OsWDN6wIri+8T1TUVPSVRjWld/p713xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717756364; c=relaxed/simple;
	bh=lzuWmQsRHevIFSOU8fqsv8TO85dYE8vzaNEi5gArVS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TLPKMHETvKRaDNbIxRxXqgfvgOx4gDkKIY/xa9qBb0L7mQXUpO7qLFkY01sW9TgJe9cwUnQrQffgXzmZx0JgFhE+q1a+DEnMdRHefKPJg5sp16nKiRakNVdP0SdkD0p6oDWc0KQ1DbegMpk54xic/6A3GVWtKv/UDnLFWhqp8MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=je+R2b+x; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52b840cfecdso2306906e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 03:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717756361; x=1718361161; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sp42j2u8rigijiuxzVvZ7hagCwbbwAjC3ss3o2b1CDw=;
        b=je+R2b+xmkx1Tiye3dE638SjvZfCLVQb4JckhcuruIHHMPsSvpaeHxK/R/VpZrFiAK
         HpnT19oujJ5A7PCfaLMrg8MBaFM0x0sn2VzI7xP608A1JdlBmKtO40jzQoiSjVBrMvpA
         3krILJpMC3zeD6l+oRHRTrpwxHpW7HGxEJV1zjkYVVc3vgxVRcg9mmF6nJUhEpNGD7LV
         CEG7yMsC/N6bji/NHBm+Y1D2kwzlp96iP7wqvaHOu6CRHRbbsj+arsPykM/jzXL0PDev
         pSV/cCMmyJK2gfWbf5ao+I3ajFePWaYHWKoEmaql7v2lKKIOfHJmMO1sWbEel3BitfJZ
         qazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717756361; x=1718361161;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sp42j2u8rigijiuxzVvZ7hagCwbbwAjC3ss3o2b1CDw=;
        b=pe7Z2lK7TSbztUwuQKNiqsMMRphJ1myvMiaGzmmnqFhPfP6CgYj2VjNfzUrK+9JggN
         0tL7KWoj1qgD74bUrovf85cRoRfkPz4sKfhs76RAxfO9yUTc6rYY2FTQyHHZDKGL0G2B
         jka1hifaw3/iiX4gI86JGe6aLjerWwmX6US/AiNidQNNBqMLmtp5R+KrMuZDrvWyYEJl
         N6Iut7/+WsgKKkXuUyOK87xKEeVs+TdiX+SgWOVx7cguwqF/f46cZvAvznqmHe2Qk0LC
         V3DMglraucAIW5623NGjpNwVmd9Ir4VJ4Z70u0/hZ5ZZ7qX80J94xndNRCMtgwVsfu+5
         Zbtw==
X-Forwarded-Encrypted: i=1; AJvYcCV1P+odZBjPfC70nHqxvdXQlBeKm1Dy/ltoRbOw1WYaIdVDT53F3T7xnXod402wB2fAUuJpZO3A7bd0pqzGzKTIdbOclpu3LAXYQzv0
X-Gm-Message-State: AOJu0YzzDYOT+1bR+1OGmeZXEXwZkWvDNIyy+bb6t/1zG/hLmawCtHHq
	TpbzCLZafcV/NWWPTch49BrsEaGPy4aWWgAmbEiXQ80gvOHdqTRt2vA9x9OVtBs=
X-Google-Smtp-Source: AGHT+IFknH3LE/JmHy0tFuHEpBY4ohLoIWvBJ6o7o5+Y6asmp4qHvfL7W8kty7HnkR8AvzgJAFN9PA==
X-Received: by 2002:a05:6512:130b:b0:52b:bf8f:5690 with SMTP id 2adb3069b0e04-52bbf8f5813mr884795e87.52.1717756360754;
        Fri, 07 Jun 2024 03:32:40 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb433ccdbsm483448e87.283.2024.06.07.03.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 03:32:40 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 07 Jun 2024 13:32:36 +0300
Subject: [PATCH v5 1/6] dt-bindings: platform: Add Lenovo Yoga C630 EC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-yoga-ec-driver-v5-1-1ac91a0b4326@linaro.org>
References: <20240607-yoga-ec-driver-v5-0-1ac91a0b4326@linaro.org>
In-Reply-To: <20240607-yoga-ec-driver-v5-0-1ac91a0b4326@linaro.org>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Nikita Travkin <nikita@trvn.ru>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2676;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=C9Lg3cE1aC1zyYeo+0Q2DO6EQOTcK4wvIXQyDKOKakY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmYuHG3p8jdZFXrccZbbViDQw59TeKQsxw9+9r6
 P88TAxl0oiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZmLhxgAKCRCLPIo+Aiko
 1bBgB/0UX3uObxgc6+f7V3dYynZ3YLFQC/ozsvLoq3VqWDyC1wRcfgK/jPt8g237lRw7REhtkja
 vA7JfhRstBLeDDqgREaYLQCTFXoBMYPRgj/GEiFdvmpp5gKPYH2/JF9zdJJPJemR+oxubqrHWsh
 qPNEknxp5v8XEGBQj6Ur3gGPJDOsLEeZ0rIalPjDG26YlcV1sF4LJ1a84raDtxm1xTyGpt8irvK
 q3bDKvQsqPLnBTAz5dlmn8GL79x53s2FiV75kLQVyzKi8CPjVjPo8LBEz6SaX/9Z/uPn4xnaSLG
 cCja5Ydva6OxBZPojq9ByHwp3RjEyrzIBsmKnqYKTAQKFh/h
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

From: Bjorn Andersson <andersson@kernel.org>

Add binding for the Embedded Controller found in the Qualcomm
Snapdragon-based Lenovo Yoga C630.

Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../bindings/platform/lenovo,yoga-c630-ec.yaml     | 83 ++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/Documentation/devicetree/bindings/platform/lenovo,yoga-c630-ec.yaml b/Documentation/devicetree/bindings/platform/lenovo,yoga-c630-ec.yaml
new file mode 100644
index 000000000000..3180ce1a22d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/platform/lenovo,yoga-c630-ec.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/platform/lenovo,yoga-c630-ec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Lenovo Yoga C630 Embedded Controller.
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+
+description:
+  The Qualcomm Snapdragon-based Lenovo Yoga C630 has an Embedded Controller
+  (EC) which handles things such as battery and USB Type-C. This binding
+  describes the interface, on an I2C bus, to this EC.
+
+properties:
+  compatible:
+    const: lenovo,yoga-c630-ec
+
+  reg:
+    const: 0x70
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  interrupts:
+    maxItems: 1
+
+patternProperties:
+  '^connector@[01]$':
+    $ref: /schemas/connector/usb-connector.yaml#
+
+    properties:
+      reg:
+        maxItems: 1
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |+
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c1 {
+        clock-frequency = <400000>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        embedded-controller@70 {
+            compatible = "lenovo,yoga-c630-ec";
+            reg = <0x70>;
+
+            interrupts-extended = <&tlmm 20 IRQ_TYPE_LEVEL_HIGH>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            connector@0 {
+                compatible = "usb-c-connector";
+                reg = <0>;
+                power-role = "source";
+                data-role = "host";
+            };
+
+            connector@1 {
+                compatible = "usb-c-connector";
+                reg = <1>;
+                power-role = "source";
+                data-role = "host";
+            };
+        };
+    };
+...

-- 
2.39.2


