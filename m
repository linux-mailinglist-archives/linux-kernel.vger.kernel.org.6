Return-Path: <linux-kernel+bounces-340400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C129872D1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 13:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67B1A2808FD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8987C18EFFB;
	Thu, 26 Sep 2024 11:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WELNlugk"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2259118EFCC;
	Thu, 26 Sep 2024 11:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727350190; cv=none; b=BBRw2NqYA8aX7wi7EQKMHB8j0I/hndKIQ6a0vfC6pVpBU197V0d4Z2og5y6OcPkZSQs1aocEq98rKvqXfAS/G8lhbQCHl72ZzXGZ5hD1WhYolYylEyon7FQO8O0xjDicvMSDrGZjQ2gss1Sp6I87STwrA91BcfpF99kpH6AuxLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727350190; c=relaxed/simple;
	bh=Ci6AW2+uGhWivjbsiMWz6624aSP6GwHomOszXTHHdxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pSiKGi/Woxl4mFzlM5V52OC3KAJEMxYiyt06wG0NS2rnuVwnWRegj1v87SwyamFFzViDtsl2x/KQoiu9N/CXW3koKnaVY6YE79i5POQB9f+6UPXn9rL6YiKUgYEta3cAMpXuHkRXyLunr4Z+gN2SfJDy6T48wB0wpZ40wI9EX5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WELNlugk; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53653682246so1115093e87.1;
        Thu, 26 Sep 2024 04:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727350187; x=1727954987; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=boaDu+sIvPRzC9VmvUSv9+Z+sYmRNTEiwnvZOuYQtbo=;
        b=WELNlugkoiWVSWRP3JUjGTiK3WA+9W4m3k2CIXgOkR8Rr2YruLWkW9OPrT9zKECawQ
         KLz6QKGdFHIUDytECtYMDWV+5jMQtYdPhxHPC6kLaHvgqsAoX0/7QVVV8cca5O9QX/m4
         rGM6kXRciaFCEnG7Ru5KfHgFafEz6pi++2iOdK7sb9wadAP7grmk3iCDoonjzseT47fH
         Xy7bCIqkAfEh1Eqn+HGl1AJMW48gC0k62yv4MGIPXSD9FxHfOsQPo+r1j6eM7S9c52Vg
         RYont1w3Fqqzsk4vWPl4AIGxYco+kNE/YFJDUt6CsUsE02gMhOo4oFHtDD3NhDKzxG7b
         vcUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727350187; x=1727954987;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=boaDu+sIvPRzC9VmvUSv9+Z+sYmRNTEiwnvZOuYQtbo=;
        b=iURQT/RnOLp78x0oNkEfMsCRhwzauSp2eQGoe2BBpJ8sbY4ONlJwloDERcRRQY1TOV
         ng0dtf+P8hbwBTnvqe3CNRc6godvs5DOHc/V1RoUftJ0a5X2JaO9jahdqi3xh7neGl3C
         OHVDON6tXYv7hgGRstBEiWuhdiVjG4AzLZAXIixlKWBP1XIFTPSD6K6nn8Ytjxh/fJ/a
         7BiAEQK8xOxZHGrN12xjJPyPvvH/QM5DYLIOsIk2ZLyoXqME2r84p5vUpYfEc+SJzF5Y
         3uU7ZK6LQOnK8pNp9r1XjFdXDYhGHMfL71o128pn621L21Qfmg0zyCl/fMMF/8QQeE2m
         Yx1w==
X-Forwarded-Encrypted: i=1; AJvYcCX58ZxK0tkHt2QLnltNWBzL4mkxQsuVABCJNsqjxHgdsfNk5jsVe+ddW7HoSAl075jiyUC7VQ0pVABAUSVW@vger.kernel.org, AJvYcCXlpZO+ynbwxE5KCTBBoYH1Kb9BYGRzh46N4NqUMq1cXwmSgepEoU9e1LEl4g6Sl11ug8u+gJJIgFFo@vger.kernel.org
X-Gm-Message-State: AOJu0YzmlWkXhS2hbuHvR5piNtYWf7B03haRqe+4rs6ntJAh7i/ymjyJ
	Mv1r3WC+xvfFTTRqf+jlJPYRfPqYI1jRmqzjNjFVHzsTQOZmQzwN4sjRcA==
X-Google-Smtp-Source: AGHT+IH7NtcptdudFNHvQHv/I95ecxrJ8vUbqQTeyGxEIpSlBHSoND+sfqjjs4KC5nLsrrREVEy+XA==
X-Received: by 2002:a05:6512:683:b0:52c:de29:9ff with SMTP id 2adb3069b0e04-538760347eamr4252359e87.2.1727350187073;
        Thu, 26 Sep 2024 04:29:47 -0700 (PDT)
Received: from [127.0.1.1] (mm-20-1-84-93.mgts.dynamic.pppoe.byfly.by. [93.84.1.20])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-537a85ee5fbsm786495e87.74.2024.09.26.04.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 04:29:45 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 26 Sep 2024 14:29:26 +0300
Subject: [PATCH v5 1/2] dt-bindings: panel: add Samsung s6e3ha8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240926-starqltechn_integration_upstream-v5-1-1cb0e43e623f@gmail.com>
References: <20240926-starqltechn_integration_upstream-v5-0-1cb0e43e623f@gmail.com>
In-Reply-To: <20240926-starqltechn_integration_upstream-v5-0-1cb0e43e623f@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727350181; l=3219;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=Ci6AW2+uGhWivjbsiMWz6624aSP6GwHomOszXTHHdxU=;
 b=e57xduEVaMpMZpUC6BlWAkyQ5zR2rl//2MWRHwIaVC9nEgtxDykPwRHnZCz3Pi0sD9qa7VqX/
 yByoq1hs2VCCbK9NIwx3mn2SxZ+v7pfEsL37iuA6j6OOziYlaw75Tcr
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add binding for the Samsung s6e3ha8 panel found in the Samsung S9.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>

---
Changes for v5:
- fix required properties order
- fix example indentation

Changes in v4:
- change dts example intendation from tabs
 to spaces
- remove reset-gpios description
---
 Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                                                          |  5 ++++
 2 files changed, 80 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml
new file mode 100644
index 000000000000..05a78429aaea
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/samsung,s6e3ha8.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung s6e3ha8 AMOLED DSI panel
+
+description: The s6e3ha8 is a 1440x2960 DPI display panel from Samsung Mobile
+  Displays (SMD).
+
+maintainers:
+  - Dzmitry Sankouski <dsankouski@gmail.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: samsung,s6e3ha8
+
+  reg:
+    maxItems: 1
+
+  reset-gpios: true
+
+  port: true
+
+  vdd3-supply:
+    description: VDD regulator
+
+  vci-supply:
+    description: VCI regulator
+
+  vddr-supply:
+    description: VDDR regulator
+
+required:
+  - compatible
+  - reset-gpios
+  - vdd3-supply
+  - vci-supply
+  - vddr-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "samsung,s6e3ha8";
+            reg = <0>;
+            vci-supply = <&s2dos05_ldo4>;
+            vddr-supply = <&s2dos05_buck1>;
+            vdd3-supply = <&s2dos05_ldo1>;
+            te-gpios = <&tlmm 10 GPIO_ACTIVE_HIGH>;
+            reset-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
+            pinctrl-0 = <&sde_dsi_active &sde_te_active_sleep>;
+            pinctrl-1 = <&sde_dsi_suspend &sde_te_active_sleep>;
+            pinctrl-names = "default", "sleep";
+
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&mdss_dsi0_out>;
+                };
+            };
+        };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 5e467ba71e3b..cc876e3653e7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7388,6 +7388,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
 F:	drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
 
+DRM DRIVER FOR SAMSUNG S6E3HA8 PANELS
+M:	Dzmitry Sankouski <dsankouski@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml
+
 DRM DRIVER FOR SITRONIX ST7586 PANELS
 M:	David Lechner <david@lechnology.com>
 S:	Maintained

-- 
2.39.2


