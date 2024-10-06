Return-Path: <linux-kernel+bounces-352530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6782B992060
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 20:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B68BB21434
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 18:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B2118B464;
	Sun,  6 Oct 2024 18:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLuWWACX"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA97918A6D3;
	Sun,  6 Oct 2024 18:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728238871; cv=none; b=cbt9E5kKQp45I4oXThjepZmH/g3YUrBqXQRSN74/gewPeMT7QsQHeqh3mN3cxlM1tVfuqBT8z8k0FD2zj1TVA/1Qy7b00rSf56cTD5Tq9b1vOgoJq5ovWsnyxdYsdfjPxSYGibUaD4MZgw/nQ/9gCg1ybAeP2c19SDSSsDyEgXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728238871; c=relaxed/simple;
	bh=8Nxq3DBjGh+N1qOzmBsPWjVg42NnuOUFW+T5n27Uk9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uMfU0FM9/Ah5lmDrMbRFtFu0aoRMWsE+Xowi/tGcVe0kMRp+GWrkYYHwHnT6L/314177qIqKP0hlaGAFo6B49ApMIpb55NnRl0b+5Yq6vPaNVJUUzywF7l+hewALjhLLHqPbzv2PqQJtV+lTInmhtGCuprIwALHXs9bk7FS4uBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLuWWACX; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9944c4d5d4so120992966b.0;
        Sun, 06 Oct 2024 11:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728238868; x=1728843668; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pPRpID3jJTn8I9V4JMm2nGYUdsIJs/RBQaF/mHpfi60=;
        b=RLuWWACXIQZ/UD2pcSspzCDYU/JhDz+0NWypKjoO+WkLIR0GBjN1zDKmDS9smPGOgl
         dGCd92T3VEYcY/RXdEqbSuC4gkx/N4VBUCdwf3NbqGLr0tmQkQxZA67PVmW/2PzNUUiR
         yfjXS5LdKKrF7V4+gDUonW+ScgCLbRFJ6/dPh5oFDoz3GLvEuBtRJmq+gZQ2wVYqZr0t
         rM/HnHB9Km5Zpc8gIqfQgce5ndHsskAF57aS99bfzhsUY0F5qKGXjvUkT9mR8ogPUk3W
         5dWiBHvQPOvC/Jw9oFKqFO287hzleWizNKg3coSVoKqbKCrXmrUusRNg1QxDRVdIUlBB
         cIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728238868; x=1728843668;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pPRpID3jJTn8I9V4JMm2nGYUdsIJs/RBQaF/mHpfi60=;
        b=IRdKmveuI+4JvGdU//HilyIX8GTm9y95pKLujHa0TrGJvcbcenHSshUeWGIYV45RaM
         XGvUHpxlPrhq6LrjpGxkKemNvGgaqY15KCqmLB6o5O8xWYgdcQQMx3R90l8srv2xdZq3
         H6VkTWHMdQWRdapgNCvdFO5AClA+WOzFRzPDhIT00kidR9J8oktuzdthPbNWpXQGyIZz
         2VjVY1vFefkAh9dDaM5mYYVf2gdvO4E5llJfzwMxDKVWiEr8pqZiayfv3tofVZmVb4hI
         0OCnnUtm0IwZJzUjyYp0X/y02fUB8MTTyyWLBMibvAmTfPlei3WlYgm6Sis3HrMm0Gkt
         phsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtoe1MSNzptohyF4hm3wVYKBxI+yTDhZpZuQvsrEv3b8ayd7rqrf8peaoINI3d2PSxyV64b/JSmjKH@vger.kernel.org, AJvYcCXPfwcnHv4B7+eQpqgYHxndm3aEuu2ODgm86d/pBDsZF6VcJ1dkWYswJWxeRRYuhplEYlOGzGVu3c8ZuDVU@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyf8+D9JKfD3xa9gsVSTYC7tF24QACB4XmKUj/SqqW3RA6zhjO
	+Si70JqRRVMZK4DydUbsIzp2pOpFotzWSJ63nGljHfdxxkkraMbQ
X-Google-Smtp-Source: AGHT+IFOHRPEKGnvsianiFg7jfjUZULY7YP0g7z3ruYzApoi4SvQKdz26dfQx6TN0xPpQmoA+kqVvg==
X-Received: by 2002:a17:907:318d:b0:a90:41a9:7c3e with SMTP id a640c23a62f3a-a991c0af160mr1021261466b.65.1728238868235;
        Sun, 06 Oct 2024 11:21:08 -0700 (PDT)
Received: from [127.0.1.1] ([109.126.148.51])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a992e5ba407sm294080866b.14.2024.10.06.11.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 11:21:07 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Sun, 06 Oct 2024 21:18:20 +0300
Subject: [PATCH v6 2/3] dt-bindings: panel: add Samsung s6e3ha8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241006-starqltechn_integration_upstream-v6-2-8336b9cd6c34@gmail.com>
References: <20241006-starqltechn_integration_upstream-v6-0-8336b9cd6c34@gmail.com>
In-Reply-To: <20241006-starqltechn_integration_upstream-v6-0-8336b9cd6c34@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728238859; l=3291;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=8Nxq3DBjGh+N1qOzmBsPWjVg42NnuOUFW+T5n27Uk9Q=;
 b=R6Zs8DhfXfdOjTS2h+QKaWLtF1i9j/+htA5ELIFVjxPZTzQx8ysSqYGSfUdRu29Ej0vifHija
 2G8c/bDMeVXBapyw/fUW/7ltKBZLEiAS3p8ipe43bNmKCAwM79jGKVv
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add binding for the Samsung s6e3ha8 panel found in the Samsung S9.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
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
 Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                                                          |  5 +++++
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
index 84086d47db69..ccc3cf5114c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7389,6 +7389,11 @@ S:	Maintained
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


