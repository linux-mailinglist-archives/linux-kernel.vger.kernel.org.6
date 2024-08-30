Return-Path: <linux-kernel+bounces-308304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C548965A10
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5142E1C22034
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2508616D9B8;
	Fri, 30 Aug 2024 08:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pcEj8kd/"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6BB16BE12
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725006053; cv=none; b=fd4s87qeDmICtf2SB9QJt4KsJPbzsVUH5bnD8qtd962+TqRXJvbnEeJnTCiFIp5Mh/xyWEEmAFwrG4Qnhbr9798WsEYyfYgzqfYGor4+UKvGfbTem5Sn8kJ6vJ9xZSwpJNsIK/5YZGvGKg9ftfnGPqN7ASXPRCEMEBS1mRdoArc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725006053; c=relaxed/simple;
	bh=LfGF/Co2ZJ3EMAUZRj7r68zzJQIEdxPhr4ofALXrn2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aC/cj8rheQSrtJPbzNb7mwmEFrifdpXTowgzxGIZXWMQirfyIT5JMqNTUnTC8HULvAiF9O3+XUoH3PKvd8OcbH5w4fTVpRNTLzIZDeDl4YPZobZiyMqEs+U82Kru3Vt4SYxO162k1SJaBM2jXQ6l4K64E1rxfoJ9lcy/LeHIeT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pcEj8kd/; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5334c4d6829so2011094e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 01:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725006049; x=1725610849; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NploNZbtHibi2ZJNMh06TTcB1PFBEXr824NaRwcdxH4=;
        b=pcEj8kd/ZjWnuHFgRfiVGWdQM5KQ4PXUHaVyvLbCB9tagwghrLljPDtFtZ25HRUeKd
         /ZXL+IptLqSna4b/mTH/OaIp/zGk3XBdCEHqd0oRe3kCiCkeFoH/ykFdZGPUtIuf2jgs
         1JifDA9ZzeyGwkBQRX4LRSie2zTqSJmvDFa39/GXEkjmxqL+H6+dFZet8mRXF/pGP29u
         ugRNXGtu4RHZQTiq2D+ul21eR1j0qtq7Bg+fO/BU+CyLbEcb/vWUtYCxdrX7wOCdnyM5
         E3+2bzps5E2suAorz8FjavjFkvRkw+xnYKCvhHRBqa3T7E4sl/hMmVrQV7Svs4yHp4//
         QEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725006049; x=1725610849;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NploNZbtHibi2ZJNMh06TTcB1PFBEXr824NaRwcdxH4=;
        b=ueJkDX5ULX0D9M05EJO/ENRS3RVGoN3ZkG8XxaNRWiI6w/4PNGdxWg3mLrY5txfwR+
         UDR8bKOHYSyn8SGbCV/adCZGn9ZVHH4d3sEgaVNWfwVWZzY/ipP1r09HG98HVS9MHHMZ
         AZp9S84iHCgsz0Y3WiWA5xF8Ykv1UaZ+EcPSk1V2+aZdN2MPfjBfbv2/Ay9ZGbjB7Pxq
         0UX0H6anryD+l3g2SqYT43oDLHZC+rW11UExMDbYOu+Z7KXfOFYX04ribnnOldOzEJKv
         nSRyKPfDNSg5nVLjJ9YhEL5fK64hQUop8CYsce4f1P9Ml7b6AKlafaSxxicee1XqfBFG
         bAzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaA8p4MgGmLx0TSZK6M92sR3EHmUmJi3AKVfgdC+s3s9O3SR1lG3hduguQEIuANVT40ZVtWRbmdhpOAdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3oJEhcQdDZHfW/hQp3nu/6ws/lT1btgG4B4LiMF+jDqN0JeoO
	ZEsiLqc2CuV+EvYL8ZeHXErLFpeDmit5nbSSfxBPUi+BFE+tIUtVCKlnisuWSoo=
X-Google-Smtp-Source: AGHT+IFjoXVe7FHll2U5M0piT4wcA911NawXP/5Kjk9sBE49dz+SZpVtOH1da/Ghu5j7P08Cy1gpAw==
X-Received: by 2002:a05:6512:b0b:b0:52e:fd84:cec0 with SMTP id 2adb3069b0e04-53546bc38cdmr988847e87.52.1725006048563;
        Fri, 30 Aug 2024 01:20:48 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5354084e00asm482623e87.271.2024.08.30.01.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 01:20:48 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 30 Aug 2024 11:20:45 +0300
Subject: [PATCH v2 1/2] dt-bindings: phy: add NXP PTN3222 eUSB2 to USB2
 redriver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-nxp-ptn3222-v2-1-4c6d8535cf6c@linaro.org>
References: <20240830-nxp-ptn3222-v2-0-4c6d8535cf6c@linaro.org>
In-Reply-To: <20240830-nxp-ptn3222-v2-0-4c6d8535cf6c@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1871;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=LfGF/Co2ZJ3EMAUZRj7r68zzJQIEdxPhr4ofALXrn2I=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBm0YDfXFp9G/36L62vW481XT0BRm68dKHQdFAsR
 zkKyC7wuKKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZtGA3wAKCRCLPIo+Aiko
 1VyrCACHueN76NHtu8a869ncODgddH+cdhywW4JZQSPDYK7ZfowB3kQgVAHxG8CNd+CSFz5HWF1
 0BZcatkQY/H52lZKGemBtg0MFxKLLxWXHne1VUDINy4rEEW+SwO1jejRBZ0ZuCkH0/Fz6aAoCx7
 bPLauJCDdAqDbGS2tE4Sk6Cexo3yHW2uO3Mc5n7wbxH926MfGgiQEb8g9RGhH3+im5+0KNY3TCl
 NQEdcIUNJ0w6+RWyDabyK/ZlRBOsaJH22CgPR+CnbOVkWuVYm7pt6c9PmnOu53XOasuwa4yRZ6w
 O1O7m2w9JEFicIxStltOCVcjjOk2gUBaM4VV00KlrqAysmpI
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The NXP PTN3222 is the single-port eUSB2 to USB2 redriver that performs
translation between eUSB2 and USB2 signalling schemes. It supports all
three data rates: Low Speed, Full Speed and High Speed.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/phy/nxp,ptn3222.yaml       | 55 ++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/nxp,ptn3222.yaml b/Documentation/devicetree/bindings/phy/nxp,ptn3222.yaml
new file mode 100644
index 000000000000..acec5bb2391d
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/nxp,ptn3222.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/nxp,ptn3222.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP PTN3222 1-port eUSB2 to USB2 redriver
+
+maintainers:
+  - Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
+
+properties:
+  compatible:
+    enum:
+      - nxp,ptn3222
+
+  reg:
+    maxItems: 1
+
+  "#phy-cells":
+    const: 0
+
+  vdd1v8-supply:
+    description: power supply (1.8V)
+
+  vdd3v3-supply:
+    description: power supply (3.3V)
+
+  reset-gpios: true
+
+required:
+  - compatible
+  - reg
+  - '#phy-cells'
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
+        redriver@4f {
+            compatible = "nxp,ptn3222";
+            reg = <0x4f>;
+            #phy-cells = <0>;
+            vdd3v3-supply = <&vreg_3p3>;
+            vdd1v8-supply = <&vreg_1p8>;
+            reset-gpios = <&gpio_reset GPIO_ACTIVE_LOW>;
+        };
+    };
+...

-- 
2.39.2


