Return-Path: <linux-kernel+bounces-273700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E707E946CA3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 08:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D9F81F21CBD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 06:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3C4DDC7;
	Sun,  4 Aug 2024 06:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3t3bRC/"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AA817C91;
	Sun,  4 Aug 2024 06:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722752173; cv=none; b=E0JdJl6A/8RL3Rzl8iVd6tgKyMsFHwUS3pVoac5WVHLFUoelGMIn+0i368bYY3erzZLcUWVloUwXy3l68tyjgl1jJWncSfowgY5xsw938pp8mQ1Dvfx2D26Me0yxYsL3PIoiJDJpTz31KhVQ9mHZmirGhs/wOT9iRK50epcogpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722752173; c=relaxed/simple;
	bh=uuJEVRc6EdWMtxFULOKYVzWbEJzMtPlm1a9bxPzbs/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AneQ/iOUr/M1/F04Uzci2/iTwgECA1eNcC6FWSCkfPAxtbni36PebXGr0ELvurDTLA7H09hKifIFGAcPb7U7HBB44R/QFEk/nNdMhEwDIK6j8t7eV0JO5qupmOKjjmwsEdtPF7pyT5fRqUz1NpLX8HI5QcckkC5GrVbOqs5mh6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3t3bRC/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fc569440e1so83857895ad.3;
        Sat, 03 Aug 2024 23:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722752172; x=1723356972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cz+seGpILxawIlaSSD47XDWHvw876gqL+2G/I4oXFk=;
        b=X3t3bRC/s++EDe860IhgP9QRchBfrUd+k3irDoc8aozxtWKK08tDSlv0yy6rOpyKTL
         nbY69LshsMGvBj4VMD4OtHlkc9CmXOxm7Szvoxy5MNLpG/aZdjON+liuShNVRKpTgq2w
         HbH/OmfuK8fQb9xTjCyiXqO0jprRmmunnNBf0vSzCQcvIf+Lt9kvhDSCPPsRt+VtIZ4h
         Mla8JABUFZcxCYfJOx+qmXQAgxIlhnn0YmjIK59L3U2j/U9D3khnfbknrjnJqeSUYY77
         ZpKjShUap7SfbELaXo8eMdJ5QEOTIW8WYIhZJZ5bSq/qDKyHMv/Z6oNb0dlBDY2rbFKf
         5kFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722752172; x=1723356972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+cz+seGpILxawIlaSSD47XDWHvw876gqL+2G/I4oXFk=;
        b=UJxXSHG6/faw7OAu7mS36f9g+/iJ/ryquuv8tF0rhfeaEV7cUbJ6mYUtqWyJLz0EH0
         kHbyT1VKZp/Kf1Q5PXl2IOrX6I3r2314cs+WRJMlyIXMq3APjCUBMGjmjqbjYO0g/I0M
         +3uddv/wlTjPKOByh2vc3fYVjyIzf2G3wVR4qMmxb4vkLNGOlFhCisFG/NrYXmEg1R4e
         MfDBuIky1tvhkJCsM3Bzj4PcaWXn4OWEFfMqovLtEPl6V3l9KKqhm3c/QiOtKAEG5z6L
         Lt0z1I7JzxbUsUhYjJhTBpgSNUFMVbZhPfMvBErgDc7iIAi42jdaL7dxOeLSncMn9PAQ
         pgeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaUr0hOXiTnZBTSiiIGRPYhujNZ/ldMpg8s7NFyIBFiyesJq4h10513QfQwxk8UW14264OLNTTHmj/410DE/Zr64lhrd1Q9cIGeQ==
X-Gm-Message-State: AOJu0YwncPiMxxqw7E4fm/oVePq/maYgLk9aYmMdnBRYE6Msk/PWk93y
	/aegUOCchAoS+dj8WxmrwqSO8sjtARe0KNEgtp4WjrmCPs7C8og9A51Oqqlb
X-Google-Smtp-Source: AGHT+IEFqt86zqX8dMZiR7DKDz3o2UunpKDibmO7X4MHgtYm5K2Ia4Um+0fJFjOJPsqOAfrG8pmQqQ==
X-Received: by 2002:a17:902:c405:b0:1fb:8620:c0bd with SMTP id d9443c01a7336-1ff5725870bmr127684215ad.15.1722752171673;
        Sat, 03 Aug 2024 23:16:11 -0700 (PDT)
Received: from noel.flets-west.jp ([2405:6586:4480:a10:167:9818:d778:5c14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f29ef4sm44194195ad.14.2024.08.03.23.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 23:16:11 -0700 (PDT)
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
	devicetree@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 3/5] dt-bindings: display: st7701: Add Anbernic RG28XX panel
Date: Sun,  4 Aug 2024 15:14:47 +0900
Message-ID: <20240804061503.881283-4-kikuchan98@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240804061503.881283-1-kikuchan98@gmail.com>
References: <20240804061503.881283-1-kikuchan98@gmail.com>
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

Although a panel connected via SPI with a D/CX pin theoretically exists,
no such panels have been found for this driver yet. Therefore, disable
the use of the dc-gpios property for all currently known devices.

Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
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


