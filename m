Return-Path: <linux-kernel+bounces-243152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C080D92928C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 12:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41B041F222A3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 10:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8EA77F13;
	Sat,  6 Jul 2024 10:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9HllJBE"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6331774424;
	Sat,  6 Jul 2024 10:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720261466; cv=none; b=TEBTB4+ivaTJjl51zr0xPFV+aP8Rb7IT2DWnvn480vFkCEzYMYLkCqBciLJ9T0HdDIxu8ZmYsUhhvnSToEqvS/QMwPw97L2fFKtfsUtltbr0w7RNnGsDwrkImvz62C5MoMQaKvGji16/rDh22NVZ+T5iXOnWf7aj2DqZhCBScKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720261466; c=relaxed/simple;
	bh=4317BdOWR/Gs8r4EvQ0Tn96JLGMtFtLVNqp8bRH2/pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QLrY90gOwpUmOo9V83Cigw0aCt2WmcXiDUtEqv4OYx3oPH+F3gO2RStnUdaqLFMfyUQqOCCMjGDJv2RQCR9XpV5i+qu7dDUpXokv6/Ogf+2k9T8OfieQYWtED6OnTXOvEuNqQ+H3A8uciIUSCLVLE6Q60vyw7ZGDsEZxqEUzNxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9HllJBE; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-75c5bdab7faso1437568a12.1;
        Sat, 06 Jul 2024 03:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720261465; x=1720866265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYJee/mcRebgA7l1n5NmrVNKbMvZcgWZcmI7aolZVm8=;
        b=V9HllJBE4RIUm6GlNoKqj73BumCMWTg77uMnpFIPI0C8tlpKkbo/oGWyGT4/7OQpKk
         e9O641K6cLIa5+e8P/hy9ke+pKvfRctVY2+NuP9Jq0/2MRiqTPMk1HaBaf2QjugajdGP
         izf2lCEDLSxY0/mFu44+n0QHo6TcJCpHRrA+lyNFc083zXOLew5t8d/zS1CJk6INxiWr
         er9n+YCV//ZqrRMXf4V4t8Id7vDTjsnP4HIQnSSwjLkvbPt/A7a6hFN/AhZIYvhGDpiN
         DIVJtr3ox3CfULXDKqqrzdjPj4qzcUCM1nmmw0E7id//GwRUw8azGANzlmYPzpRYB8Ui
         KgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720261465; x=1720866265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYJee/mcRebgA7l1n5NmrVNKbMvZcgWZcmI7aolZVm8=;
        b=ckV5puOeZ4wEPOhOxm8hP9nfZMrm21o8usBZBTf9GdxeyQUnNZRmylDZhSVHBy965F
         LgtrS4+N3h/r0ANZJtmVVzX7Icin9JtN5+vGQSe9UiWe2XuLMQW7OjGgREmAJKo4KfM5
         UMhWdnIY7cH7/Ml1Ak2eCRvzqeW1ZCJ3BdlQyokkGIPa4TXl9lfJQ/K/u4VimJasAgXK
         wE0fN2mkqbfR6eZ7FY6lMk1u9DqVeGM67WMoZmcbkCF2y1mlIEnKwbCOrdB6w7NLHpbe
         AnssvquqDaUqnhiyhyJN0Qs0ra/0HVRCQZ0jafJLC2LpcR/PPRA2C4XKiBfi2/zNZvLX
         Ne0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV42WfRg9uszBqPVnal/zNeKcBThFiBKpfHipmJrRNg+eSp+H/vzlYsESytPutnfg/s+sbHsXuHZ75dYkic28dHG+e93c5m+uZtTw==
X-Gm-Message-State: AOJu0YzBoD26A3hf91qc8xfnjHhf9oniX0p0+TiUdtaeA3O2gDdE9o4I
	nOlifxGk+f5gbMMWZLhwgIc9fAdD/cVymJ9PzOBuQSYiaysB3sKgfLJlEKnYjOY=
X-Google-Smtp-Source: AGHT+IEebQtUDk0CnigbaUezXTxoX65nCAEIxGoc697y/n0gqBCZILJ4/CciYoJMfiPEoGcSa5gX0Q==
X-Received: by 2002:a05:6a20:7f8d:b0:1be:ffe4:b2a2 with SMTP id adf61e73a8af0-1c0cc737349mr6960162637.7.1720261464567;
        Sat, 06 Jul 2024 03:24:24 -0700 (PDT)
Received: from noel.flets-west.jp ([2405:6586:4480:a10:167:9818:d778:5c14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb67e04f64sm9126625ad.214.2024.07.06.03.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 03:24:24 -0700 (PDT)
From: Hironori KIKUCHI <kikuchan98@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Hironori KIKUCHI <kikuchan98@gmail.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 3/5] dt-bindings: display: st7701: Add Anbernic RG28XX panel
Date: Sat,  6 Jul 2024 19:23:34 +0900
Message-ID: <20240706102338.99231-4-kikuchan98@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240706102338.99231-1-kikuchan98@gmail.com>
References: <20240706102338.99231-1-kikuchan98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RG28XX panel is a display panel of the Anbernic RG28XX, a handheld
gaming device from Anbernic. It is 2.8 inches in size (diagonally) with
a resolution of 480x640.

This panel is driven by a variant of the ST7701 driver IC internally,
confirmed by dumping and analyzing its BSP initialization sequence
by using a logic analyzer. It is very similar to the existing
densitron,dmt028vghmcmi-1a panel, but differs in some unknown
register values, so add a new entry for the panel to distinguish them.

Additionally, the panel only has an SPI instead of MIPI DSI.
So add and modify for SPI as well.

Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
---
 .../display/panel/sitronix,st7701.yaml        | 69 +++++++++++++++++--
 1 file changed, 64 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml b/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
index b348f5bf0a9..b07f3eca669 100644
--- a/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
+++ b/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
@@ -20,21 +20,19 @@ description: |
   Densitron DMT028VGHMCMI-1A is 480x640, 2-lane MIPI DSI LCD panel
   which has built-in ST7701 chip.
 
-allOf:
-  - $ref: panel-common.yaml#
-
 properties:
   compatible:
     items:
       - enum:
           - anbernic,rg-arc-panel
+          - anbernic,rg28xx-panel
           - densitron,dmt028vghmcmi-1a
           - elida,kd50t048a
           - techstar,ts8550b
       - const: sitronix,st7701
 
   reg:
-    description: DSI virtual channel used by that screen
+    description: DSI / SPI channel used by that screen
     maxItems: 1
 
   VCC-supply:
@@ -43,6 +41,13 @@ properties:
   IOVCC-supply:
     description: I/O system regulator
 
+  dc-gpios:
+    maxItems: 1
+    description:
+      Controller data/command selection (D/CX) in 4-line SPI mode.
+      If not set, the controller is in 3-line SPI mode.
+      Disallowed for DSI.
+
   port: true
   reset-gpios: true
   rotation: true
@@ -57,7 +62,38 @@ required:
   - port
   - reset-gpios
 
-additionalProperties: false
+allOf:
+  - $ref: panel-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            # SPI connected panels
+            enum:
+              - anbernic,rg28xx-panel
+    then:
+      $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              # DSI or SPI without D/CX pin
+              enum:
+                - anbernic,rg-arc-panel
+                - anbernic,rg28xx-panel
+                - densitron,dmt028vghmcmi-1a
+                - elida,kd50t048a
+                - techstar,ts8550b
+    then:
+      required:
+        - dc-gpios
+    else:
+      properties:
+        dc-gpios: false
+
+unevaluatedProperties: false
 
 examples:
   - |
@@ -82,3 +118,26 @@ examples:
             };
         };
     };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "anbernic,rg28xx-panel", "sitronix,st7701";
+            reg = <0>;
+            spi-max-frequency = <3125000>;
+            VCC-supply = <&reg_lcd>;
+            IOVCC-supply = <&reg_lcd>;
+            reset-gpios = <&pio 8 14 GPIO_ACTIVE_HIGH>; /* LCD-RST: PI14 */
+            backlight = <&backlight>;
+
+            port {
+                panel_in_rgb: endpoint {
+                    remote-endpoint = <&tcon_lcd0_out_lcd>;
+                };
+            };
+        };
+    };
-- 
2.45.2


