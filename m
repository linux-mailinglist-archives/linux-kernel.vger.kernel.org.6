Return-Path: <linux-kernel+bounces-533639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF447A45CFE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B33291672A5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5E221576D;
	Wed, 26 Feb 2025 11:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbRWmMWf"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E806B215078;
	Wed, 26 Feb 2025 11:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740569197; cv=none; b=E2zjRvF5MSLvb/4y+yhVTPltL+9u/fRKhXD6pnOQIQoOHBJxtcGQ4vcP+nQWE0b6c4hkD8jCaUVn2MVJnAXy/EykaK6pLsKLlP4WDN00yzlUzVMGBgOrUdm/+d65YWMHnYaDKtUTWCCON87/DXtaVbcBhjV3NDMvf+atIj4Id1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740569197; c=relaxed/simple;
	bh=YgogzbJaAVAR64wopTXml48vyTVpFzwbHVK4g6S1fJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l3/pKRl9GxFDoWIiwrmQm8lAsx4/i9SlJKrNYe/IcZSb2F35D/6TyAGOvQeKkixFBuBho9yTdF/sZTbZ/tvgwrgldxbGybO8Jr2+W8dX1eHTd40am6LgjLbyjt0ZOf43QVF1c7NEXD+ivUHTO9q2ARt1UgLIf+ulP7o2p5iBIn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbRWmMWf; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2211acda7f6so149521075ad.3;
        Wed, 26 Feb 2025 03:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740569195; x=1741173995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJGZpWbDvkxIZVmJShYLY/mP8QNbEoEXn4nR1fnmnoA=;
        b=DbRWmMWfJviWmVOK+N+Y4VajuJdjajP3uXTQwvv4iU9z6KFW9l+WmFfwIG+9t1xFJN
         s2rHGuNosDiDG8zzO91W/pdsCYP8BmqErIpdgiH8ZiQgklFAg1IdFsiG7Ywk5GkS/WHK
         sQ2dlhDhg5IVDRJ9r1rOpmpi+U61XOuQF6PZZpOafKGHQXGQrJUNoDFquOMlNQ54uHV9
         8o+3uXdDr9bNGTb9hemCKoLqiL3z54RtTk41KpSgcu77ImMXSjG9ahNNoXYFP3sXApXn
         cX2xUv7KUdfKinfck/Dp5qeL1OnjkMDrMT2oh/8r2lXU7O+2Fx9wLQYNBzFD3xKQZEVd
         bn3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740569195; x=1741173995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJGZpWbDvkxIZVmJShYLY/mP8QNbEoEXn4nR1fnmnoA=;
        b=gp3dY9huB8sas2OQpWDpOQNaFCtH0LNo6gXV2+Dpa5sxizCxuuoNom+X1A1qXJeUNU
         xJVQRALOS9Bybb1nEcAounFrHXuT4pZb8Ujq1/ELc+O7PTFlZ0YqJSaUyJj33RUpURoe
         7PSi6UUjtcZuXHZ8k90RKNW/bvMTyKAJFRsxvbBkteVfTduqLdyvkOOt4VHp1/Q4D5hV
         D0KDipD3upZGKIzlVGEXa7emp5seMUhwTiWnWxGDc3OIfaYIKRP9CqNZnx7ABykJs7Az
         GZKl1s0cb3f+XogXxO9wdQS1JYp+yD2S0QdN/z35OW9WRnWyUALzehBaDCgsEvp5qO4U
         qnjg==
X-Forwarded-Encrypted: i=1; AJvYcCUtdOOSpkJW+7iRDIvD0HNfDmhU/uZ/XBQsNgJu/o5t9AeS4kswQz3TbXVeaTIFvgjbcmJJ9JQkhsn2@vger.kernel.org
X-Gm-Message-State: AOJu0YyZjz6sK82q4qrB7tndCZi5sJmXkO1DHronCPdbNrKVlVcS969V
	iqg6W/1wJpFOfCljus+tUP0QnsoUYJSgaf3qBJbWhAUeQ4L8T8qOlUpnUwxb
X-Gm-Gg: ASbGncs22awmHBgDxIdT5atbouv+D5fdaOr4WmoYe894TLGlK/0ECJ3l12kx3K5DedV
	0UxMmJBH4RSLd9HJoLSw+i1C1Iz96X6sSMUHttbzhzr4vfSulot497+YGMLkYz7jc9pL+BH1TnI
	JlrOXEdQ7z2p+7aOftav7s47E72sX99gIVHlotWXQeL7U3e1JwjIutSJlAeYNDnuTMFo/8jKwdV
	ms7O2ZsHGJPWos9Vo0RYvuAhCc+3KGa61+NiuHClBPtD99hnNWXM26kIdG6+Opk/LNI4sNiLKOQ
	q/MuteFpK/A+xJYGArZV2Y2pKNXFuQljYbjKHw3XS6kvtLZf2ha3jjx1FblLVzUZQUdeWg==
X-Google-Smtp-Source: AGHT+IG2gWi0nLGOKpj4dDyZrHjJgRgzITPsE63NdiS1YrFkAk4rdwGkFABUwfTdHYGCtVaBNOKAtw==
X-Received: by 2002:a17:902:e887:b0:220:faa2:c917 with SMTP id d9443c01a7336-22320208770mr53896785ad.34.1740569195012;
        Wed, 26 Feb 2025 03:26:35 -0800 (PST)
Received: from localhost.localdomain (221x255x40x66.ap221.ftth.ucom.ne.jp. [221.255.40.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a0009a0sm29800345ad.27.2025.02.26.03.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 03:26:34 -0800 (PST)
From: Hironori KIKUCHI <kikuchan98@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Hironori KIKUCHI <kikuchan98@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: display: panel: Add some generic MIPI-DSI/DPI panels
Date: Wed, 26 Feb 2025 20:25:49 +0900
Message-ID: <20250226112552.52494-3-kikuchan98@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226112552.52494-1-kikuchan98@gmail.com>
References: <20250226112552.52494-1-kikuchan98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a binding for generic MIPI-DSI/DPI panels that require
initialization with a simple command sequence before use.

The initialization of the panel requires a firmware binary which can be
made with the Panel Firmware Generator[1] on the web.

Add 4 new panels, as they are available on the same page[1] as a preset
(excluding already included ones).

Note that the "xx" in the panel name is taken from a product's name,
not a wildcard.

[1]: https://kikuchan.github.io/panel-firmware-generator/

Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
---
 .../bindings/display/panel/panel-mipi.yaml    | 121 ++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/panel-mipi.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/panel-mipi.yaml b/Documentation/devicetree/bindings/display/panel/panel-mipi.yaml
new file mode 100644
index 00000000000..d70cf0063fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/panel-mipi.yaml
@@ -0,0 +1,121 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/panel-mipi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic MIPI-DSI/DPI Panels Requiring Initialization
+
+maintainers:
+  - Hironori KIKUCHI <kikuchan98@gmail.com>
+
+description: This is a binding for generic MIPI-DSI/DPI panels that require
+  initialization with a simple command sequence before use.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              # Unknown 3.35" 720x480 24-bit IPS LCD panel
+              # used in Anbernic RG 34XX
+              - anbernic,rg34xx-panel
+              # Unknown 4.00" 640x480 24-bit IPS LCD panel (YLM-LBV0400001X-V1)
+              # used in Anbernic RG40XX series
+              - anbernic,rg40xx-panel
+              # Unknown 3.95" 720x720 24-bit IPS LCD panel (YLM-LBN0395004H-V1)
+              # used in Anbernic RG CubeXX
+              - anbernic,rgcubexx-panel
+          - const: panel-mipi-dpi-spi
+      - items:
+          - enum:
+              # HOTHMI TFT-H028B23VGIST7G40-V1 2.80" 480x640 TFT LCD panel
+              - hothmi,tft-h028b23vgist7g40-v1
+          - const: panel-mipi-dsi
+
+  reg:
+    description: DSI / SPI channel used by that screen
+    maxItems: 1
+
+  power-supply: true
+
+  io-supply:
+    description: I/O system regulator.
+      No need to set if this is the same as polwer-supply.
+
+  dc-gpios:
+    maxItems: 1
+    description: Controller data/command selection (D/CX) in 4-line SPI mode.
+      If not set, the controller is in 3-line SPI mode.
+      Disallowed for DSI.
+
+  port: true
+  reset-gpios: true
+
+  backlight: true
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: panel-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - panel-mipi-dpi-spi
+    then:
+      # SPI mode
+      $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - panel-mipi-dsi
+    then:
+      # DSI mode
+      properties:
+        dc-gpios: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "hothmi,tft-h028b23vgist7g40-v1", "panel-mipi-dsi";
+            reg = <0>;
+
+            port {
+                mipi_in_panel: endpoint {
+                    remote-endpoint = <&mipi_out_panel>;
+                };
+            };
+        };
+    };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "anbernic,rg40xx-panel", "panel-mipi-dpi-spi";
+            reg = <0>;
+
+            spi-max-frequency = <40000000>;
+
+            dc-gpios = <&gpio 24 GPIO_ACTIVE_HIGH>;
+            reset-gpios = <&gpio 25 GPIO_ACTIVE_LOW>;
+
+            backlight = <&backlight>;
+        };
+    };
-- 
2.48.1


