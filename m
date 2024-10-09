Return-Path: <linux-kernel+bounces-357308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39559996F73
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8267280F58
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6BB1E2834;
	Wed,  9 Oct 2024 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNWxBi4f"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38711E25FE;
	Wed,  9 Oct 2024 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728486557; cv=none; b=u1LFmlGdVN6NWz/AjBoWbSTWBBGcBi0QmWCm6Jl9K8DJQ+KsmaG61zpXFWbxAhxF9GU01uPFnH1JzA/lLMRYspFAvmJBFiwM9/GLiZR/yhGfoLDZp7+Z3mxE9jHgnSYX6MoKQEm3OKEQYeE0xHAvzn7iOmHtov232WE6Wq1wOUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728486557; c=relaxed/simple;
	bh=8Nxq3DBjGh+N1qOzmBsPWjVg42NnuOUFW+T5n27Uk9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B7nNMtbp1tkojI808iW4t5nHdnie8xwvP6xX2pcM3pj+buUwJEnLzDqITuLeqTyFEkC/wYK7HQqXnCMNY6EC8QNxmmlS8GcwMpCT1PYD0Fq95M+NX8+743mX1XOEQH7xBb5kshbA5pd6N0He9T+Xs+3DUJxDJbVj4AEM+GU8ox4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNWxBi4f; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9957588566so433715666b.3;
        Wed, 09 Oct 2024 08:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728486554; x=1729091354; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pPRpID3jJTn8I9V4JMm2nGYUdsIJs/RBQaF/mHpfi60=;
        b=BNWxBi4fUAm1XehdASPQd/bL7/e/v3N2g24jEC1238MRCHWCdLyEOut2+rRHWG98Sa
         CIJ+E7cy9ntcUFnwIE8+nP705r+L92LyV/hCKnVE0ORDF7SNGI04Zak7GEZ8UprU/Pfp
         klRp4kbzsYWnXbDBM+5Ka4U9O8dcgUSi1w44iwYGvHqMwNaNbQwsdGzVXKLYoO6m3MwP
         aam8BGuXat0DoowilGUo9D6woLDibaPshf/G+TTZFAuO/YhIyKVIT/MF7VkG31XhDkTX
         5mOqOsjANZw1GDn6qcYThj2uUBIp2hPCdFH5LyqOOUMwhUo02buuRklt9lEe4oQjllgW
         DSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728486554; x=1729091354;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pPRpID3jJTn8I9V4JMm2nGYUdsIJs/RBQaF/mHpfi60=;
        b=ZyCvN15BxlGo3aQF1OYlXvf7Xa8un7mxpxAlLxjU6fR97GPy9ceyU1hjHZcj940fzH
         fc57yzUvM/UAeKtfpH1A2iDrqAH7sz2rfuVIsabOcarNpsv5GnPus9gPFq/J5cxOeyAa
         Ur7e+N8rkRzHBy65tsjztSvtqrOHgJaDT2C3ltz8zf5S9GDIZcGlYMuGjLB9ofVCezUV
         sAcSJ/pGTD7rOW/EaWJu+WIbwTWAyKuQFr4WCgWvluMQkOt3EVcDoWJo5TVWVY2twDMO
         mGiJdNQ/LDZu+hV/TVTJEZgrIsnwoG3vsELyUxIwXRrmw0D/INeBD19WiXGcyZjFjvgM
         UMxg==
X-Forwarded-Encrypted: i=1; AJvYcCV7Gy+40p8iMDsw7loL9wkcoHKCQpnA70viot2SOVlgWLF8YNhRDMzzePYtcfVUg9piBomodp0AFK2G@vger.kernel.org, AJvYcCVCtmX0wLWKGgM1R/KXvqhDcd4xLMQwh+OB+GuChL4L4z2jvIgQQIAxja9P33iDCXnYKNojzxnU0j0CWF7I@vger.kernel.org
X-Gm-Message-State: AOJu0YyEfF5xcw9fP9GT/gVB5PQ9vxo5iEMoRwSD2fSJUiuGjE0+VvBU
	IRyQuiqHAC8W1e/KiRSa+51OPhUPDaNWuFypkbPKpCfFRH1lhVjj
X-Google-Smtp-Source: AGHT+IGGYGjTYmD19xzpwSLKjHIxB0DbuZAy4atQClezI1moGKPNbhTo/EOOQnZ7DkDNbk29GhdCOw==
X-Received: by 2002:a17:907:96ab:b0:a99:5c22:fef6 with SMTP id a640c23a62f3a-a998d124293mr231186166b.1.1728486553903;
        Wed, 09 Oct 2024 08:09:13 -0700 (PDT)
Received: from [127.0.1.1] (leased-line-46-53-189-107.telecom.by. [46.53.189.107])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a992e7b19b8sm668861766b.154.2024.10.09.08.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 08:09:13 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Wed, 09 Oct 2024 18:09:07 +0300
Subject: [PATCH v7 2/3] dt-bindings: panel: add Samsung s6e3ha8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-starqltechn_integration_upstream-v7-2-9967bd15c7c5@gmail.com>
References: <20241009-starqltechn_integration_upstream-v7-0-9967bd15c7c5@gmail.com>
In-Reply-To: <20241009-starqltechn_integration_upstream-v7-0-9967bd15c7c5@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728486550; l=3291;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=8Nxq3DBjGh+N1qOzmBsPWjVg42NnuOUFW+T5n27Uk9Q=;
 b=CEaDa7s2RpvOgyvsKNpJkaf+X2Rmwq5fRRg4ToYc5g9Ornc3LI1+WdxcF2VPXLnlZN4QkFTrv
 1RKmRDoE04xDKDrAuFR0HmscmkY6J7JYmdD3c52kUCKBwhGNa4QfkfX
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


