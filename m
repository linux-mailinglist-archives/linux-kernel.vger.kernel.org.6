Return-Path: <linux-kernel+bounces-233352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C10091B5EC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 07:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0978B22ADC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 05:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780FD405E6;
	Fri, 28 Jun 2024 05:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCsfeck8"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7A43B79C;
	Fri, 28 Jun 2024 05:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719551464; cv=none; b=uJSCD2Kqi6d7P22BVgZmIWInNl4f0rnTFL7Y5eO/gghy0tvtKugrwRuneqBGKaF9qQWc4J1QLJh+bLZ+ZSKas5qhjWpXEm/5tDSenIeFCZiTOEMl5TiOZe1fn5aS9stj0YFEfisWH/B8YIf2LKn0uCsL9avI0eCwXPObpJrMthk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719551464; c=relaxed/simple;
	bh=UxDKj4f8iCxtplt60bdHV8yYeVJ12ipkFvKoame/0Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B0LkIm3okQW3CJ5vDFilnpqt6KZjxpX3iUiZyWXWzOarbswE8q84QqXovLMTk0BM8rxfff7Xoq6ECw4zrYs6d0+/mYDKnbfoyRcJ0WRPM9z1dX7j2Y+dfEYTN3Xj47AgCf/4ClWG86+C13HHw3V63lmAhyrV6k9S2DYFdun/VMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCsfeck8; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3d5611cdc52so109777b6e.0;
        Thu, 27 Jun 2024 22:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719551462; x=1720156262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JpenRVGjM2ZSkUQ2dBUpd49BSbf2cRRpi0pJzb2v/wA=;
        b=nCsfeck8MRdcb9jyL2Ox1hCg2tElacxPFGAFORqE2IEbqIKBEjXTdGaoDBPdETGOpj
         eNkOP7D/1XD/hDKAf+p8auiO7JK2Qo0Y0USrHXc/f+ncr83m1WQ2y5Tv3IL4VZaGCDPX
         PLxZ6/DZ/TFOQEatJIMQOCdccDCN4uSIggENoY/m4ZHprywAQ/UMWoh/YxKFqJKR3N+d
         ohcmMER2SS4a11iXnuHCI092o6l4geEwqd5dnz+Gg9avfvtnkK27sK3oaJuPkOY8jfIW
         LU90Ig5grZSq3jRtQQBcgEdxwKkovtdRU+ImuLP/p+hkKGGKp4L82ZVSo4BSuHOrNweA
         8nZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719551462; x=1720156262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JpenRVGjM2ZSkUQ2dBUpd49BSbf2cRRpi0pJzb2v/wA=;
        b=Qzn5O4f49rq7VMTlQmfD0diwgPK3RXMfz0fN76e5x9zO54rsKujvzPS+3MZ1Eb5K0V
         5XqFPg71SOSKAek3yDwBEZeDQjWSO3jUbooc63q/Tvymu/8AIVB85Kc/KNHHw00VCcgV
         Hyfb2n3LVo83GV1Wf4DSeUDkbUi073jJPxZuAMaEwqOvOlLNdXSL0HsND/SE2vVYv0rV
         L08WhgF37hXirCjhLxJzmydHPpIdQ+fkrdta1vzpMH2Ibw2J5z1JGpSbGizLxvdSYMb7
         c9jNruYbqHbw2eQsM4c1NnJdX9ckc6TZFANsF7QtnSogr54jodZvJop1RoUoJqBvb+Wb
         dLOg==
X-Forwarded-Encrypted: i=1; AJvYcCUawIQHX/0xGmaIIyU5DFbjVQlJ5lyvxJYtLa7Hecspl1c4n0AH2gV3Cvr1MnvG8WrkW8q1Pefi1eFJnzBfY8W/pOos+vb364Yhhw==
X-Gm-Message-State: AOJu0Yz+ZlIs0EVVfcMy5+S4nChpJAl5aDxgdnGdJUdjz1A6Exe2RGzI
	XB1IQDXolbEqRikZODliz1DhqqR1TNjy1MMoHt6LhCmPq0uxBda8+LmvsVdAW1E=
X-Google-Smtp-Source: AGHT+IEx8bqjf6+huD46hE7EYOhNRkSCa7gQ7/NJzyrFgBjzYsCqxdHOWw/F7oJT2+64neV07mk8Tg==
X-Received: by 2002:a05:6808:1b26:b0:3d2:1759:7db1 with SMTP id 5614622812f47-3d54594bcbamr18842835b6e.10.1719551462153;
        Thu, 27 Jun 2024 22:11:02 -0700 (PDT)
Received: from noel.flets-west.jp ([2405:6586:4480:a10:167:9818:d778:5c14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804893e4bsm624716b3a.184.2024.06.27.22.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 22:11:01 -0700 (PDT)
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
Subject: [PATCH v2 1/3] dt-bindings: display: st7701: Add Anbernic RG28XX panel
Date: Fri, 28 Jun 2024 14:10:15 +0900
Message-ID: <20240628051019.975172-2-kikuchan98@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628051019.975172-1-kikuchan98@gmail.com>
References: <20240628051019.975172-1-kikuchan98@gmail.com>
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

Additionally, the panel is connected via SPI instead of MIPI DSI.
So add and modify for SPI as well.

Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
---
 .../display/panel/sitronix,st7701.yaml        | 69 +++++++++++++++++--
 1 file changed, 64 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml b/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
index b348f5bf0a9..835ea436531 100644
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
+      $ref: /schemas/spi/spi-peripheral-props.yaml
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


