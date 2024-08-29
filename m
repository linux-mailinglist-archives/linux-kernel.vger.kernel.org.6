Return-Path: <linux-kernel+bounces-306385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A786963E3F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8FED1F23533
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC10D18C349;
	Thu, 29 Aug 2024 08:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a4fIa6l4"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0138018C02A
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724919681; cv=none; b=B+xWk3o7rEbW2yFm+GaMk3KOgmT5bdfk/uAaATesCVCUg58SMLEZvv5lw5R8PoNwHK3t6dEZs64EQk/61DKm6OjasUMpo9iBrtqnLQi7MhMVqFrQOCcACLlca9MNuBAJClwh/uQ3GIgT8ZwzDQFNfLelCKyXxqY4w0+zAkGQl7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724919681; c=relaxed/simple;
	bh=Rt1zyvmsStyMEQ7Imc4AIEo/xzosFjgkb3d1LP7dDzw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cS8Jkj+JIA5Tdx+FVjiGaZP+w3TemsNVQ1hTw2TIHympnYgyNhwg9uZHn3RzldB6PaPsrm6t6GaNjZVvPZeamaepfnStJzs2ZbTPWchhG0K7rq45XgdZmPEYCgpr9l54b9QQ8KDwaoTa0tXU6cYDS4eEi11IdcugsKwJN5gf5F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a4fIa6l4; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f50f1d864fso4167801fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724919677; x=1725524477; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6rRlnDUQ62hVEyyi6Zzf8hyKbeo68gurNoPgtGYPUfQ=;
        b=a4fIa6l43+7Hc2g5aKsFfwneON4c6BioXqloo/vfRMvt3//wLbUmR7PwXsVur97Lej
         jgyFkYTUFMV98CHmCmNMoKEGdg2y1UK1DZiBiF6KXgcZcFGAU741IOE3Qcijg4LZi6fJ
         NeeWqxm1Vs3uL7nX0SYnu6FtSTX+QjF71k3L8srYOXT8m1WowefsXikhyJoVpoulLEtt
         b1zeQrFkjrQsXnzJDyTSC5PpyWpOTiKR0bN7o6Wo2b/w2IVN0NBv4DxO36wiFKIGVgM/
         WUZPHh5djzslm7NdnR9PYzNylRHRTZ38pGmz2HdNjLyS+gJUboatzBKt1Y7TeIpFX3mQ
         1Ixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724919677; x=1725524477;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rRlnDUQ62hVEyyi6Zzf8hyKbeo68gurNoPgtGYPUfQ=;
        b=mTj3vN7Esv7kfApdT3WvKT1nEsFZ5a6IGcUN42PmPmqia6Tjz1+DG/wSfbD1GdWG5y
         kqIJ5F1U1U1bC7VD7qNdAKnnLFYD5YAjWS/dFzLkuJrA81Xk9XnERkKhq1KOyWkTq47A
         6KQiVnG41O1ADTA7ubBBnFz75pLl8rb8HSzOSrqWDyFAKrlIIUQqD443ggziLTeCpZ7c
         JDX4zFIFM2Elt/uGq3s8IAWkHkwU4FOXslCSnVnsSgS94Vu7DPcYcQ5DBhg6XYECq6Qh
         O4ZrdrJEw9v7o828DxWKu8PblyF2iVaWguff+uuO/aqLdYjvaEYBw2/3HVBrF8lTbAvy
         PrFw==
X-Forwarded-Encrypted: i=1; AJvYcCXPxmKMxyoGPdmstQrxdn07oh0B9mHJ6uOIygYVBihGtrNXmKli3ormTiKhVaW7yKbLv4JPVqvpMNXVAA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz7TftHZNgm8l0xiVfHQwJozrW1AmCxEkyzTxPWQvMn2CYgCvM
	s97mYjBG6WYjTIINvUsh7mtnlHPOhE3xz8i02ACOYFYQoPowwB5tTiC6JM4Zr/E=
X-Google-Smtp-Source: AGHT+IEdfiG8wdAXUjLPn9PNPt905p1RpCSOc6/eqVSv+Bplproc2OyIXIw1yR9abz+N9kBoKVLYHw==
X-Received: by 2002:a05:6512:3a84:b0:533:d3e:16f5 with SMTP id 2adb3069b0e04-5353e5b7b4bmr1095192e87.38.1724919676455;
        Thu, 29 Aug 2024 01:21:16 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-535407ac333sm90243e87.70.2024.08.29.01.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 01:21:16 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 29 Aug 2024 11:21:13 +0300
Subject: [PATCH 1/2] dt-bindings: phy: add NXP PTN3222 eUSB2 to USB2
 redriver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-nxp-ptn3222-v1-1-46906bc4747a@linaro.org>
References: <20240829-nxp-ptn3222-v1-0-46906bc4747a@linaro.org>
In-Reply-To: <20240829-nxp-ptn3222-v1-0-46906bc4747a@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1815;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Rt1zyvmsStyMEQ7Imc4AIEo/xzosFjgkb3d1LP7dDzw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBm0C96aYenMsYK0ZYEgfvXPWoICoZVsrGBXo0iW
 z+iZUBuB+uJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZtAvegAKCRCLPIo+Aiko
 1Tk1B/9OMMF6fU5VWjCowzP29snvZdmDtWqZY+FDFZ35Ppw4BggT8bS7oxc8bgDQ3r0lgdUxmzY
 3b2Gi8YriCNbt71qpS7N3d88BEEPm6PwU+0ANEpU5IvYLA7RNkP3Sa/MhRrwAZjgXCUsTm5kK9c
 sbBjRkmJFuwEU2/CPbgu2zn8ighHiAiHxHM9bI3YJpRZj/M+isyn31Yi13lw/mDBcNRsT/09PSn
 Y1gcNNqolJldhIR6svu+SJIc4rSiLVkajGk+8dEP9HVX2dn553GQTkIMegD3Tmiz6A95CY/F4V/
 8sxKLU8BThWm1ph1LvDnRhOpsHcnSlncRyOesjUD1N5Bm83h
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The NXP PTN3222 is the single-port eUSB2 to USB2 redriver that performs
translation between eUSB2 and USB2 signalling schemes. It supports all
three data rates: Low Speed, Full Speed and High Speed.

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


