Return-Path: <linux-kernel+bounces-213201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACC59070C6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E536CB218C0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B824C161;
	Thu, 13 Jun 2024 12:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CD/45SMu"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A521C32;
	Thu, 13 Jun 2024 12:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281839; cv=none; b=FuxXPmoci4ndB6EuRWx/y+naQm1PnkNBg1Uqes+0QJ1NERJ3K16WNJbQTpDsC5FI31/y6VayhXZxAgyLWgUX4Nqoy72JmdRI2EXZccE1wHbPx/MNE0w9RRNmUdCMeNLMirDJvsWwDMxAcE4gwugxAGylS907kKY1AXUvV2GzzoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281839; c=relaxed/simple;
	bh=UJ5vlctxDseqqsh+SakzrcuK4Vz7Nl4HZ24S2HN5GkI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nVZzoW57g+Y8KGLjcytKGF+vIMk43pmfRq45CtWcg18M27hKqJganmuEABfiicVCJN+MLbDfS/0j7Fdk73B6PLPrz4HRAyb0hhmokripBO6vFwaUTC/vRpz9QEcbANzy6GZSw58V980ENvyMSGDD7sZNsg1I6eWOu7TbyCOsxJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CD/45SMu; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-254aec5a084so465662fac.3;
        Thu, 13 Jun 2024 05:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718281837; x=1718886637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pCVokkdZ2AzZZwD9JHJBnP81SaNJNef4hr9QhUUF4Mk=;
        b=CD/45SMunkqz+kpgO71fQ41nka37vbfnhJ2y+p3WVdXXs+AtlYEK87n2C9rPe7kX6j
         g8rujQ/6GDp4z/mAfgHM7NlsCcOTwnwkoImNCRpJOG9MH5rCazGVyJTNz/fobBp2aIEV
         ascx1+W3gwcR/ULj5LEuE8pUFss2HyGqcoS0J0nBP1dVl5jSJRVcFyBzW73bXw9I0xEX
         X1jIr1YzcjWq7b1bG/8puRe5G12KJE7atqz7vfvQJ4YPeZRMv+cWVuNlNrlwgfjd9IQ/
         GAlPqmOfQ9XJvp7RsXmzCsfhjAEBQpMFzGRPry3sgZhrXLbCAYMA5o4UhzXmvyTK4AQw
         3tzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718281837; x=1718886637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pCVokkdZ2AzZZwD9JHJBnP81SaNJNef4hr9QhUUF4Mk=;
        b=Npp7+3/NGFsq+oRvoQbHIeyQwcFSZ0GJKkHnfzlkXsE6fjQbPfNXAZSogLB46PDloe
         RwQxR/YGQwVF7TVNSooSVGy+IYr/oUVElyPFaGo2HD9zOSmk8M18JCajiGvxxoylUpda
         NH8kqnwFMfv2JJoAtqgns/UbkJl4m52AzNmCIAyEdkdIYn3JUo6gxf4JUgWglKRz54wd
         C7Kh88ddXJOHq7bJO1y6j+J+vFgu8hm+6izNQdwp8tNc6HL5/3lFOulo+2F+/+w+nPNH
         bwMmEWtRsr+EYSdzci0wPnP79RALrd9WPWIsVjZttCUdHA1BGZmEoMBVi/NBu03h45e+
         hwWA==
X-Forwarded-Encrypted: i=1; AJvYcCXyDczxFNJoKJCoXcBj6m3FifLYiZ4/5gGQbaOQ5iVZsZoDhzoVGp/SjXAMiShpTXAaS1ta2TwRvjhUt/VXsOMtZmZPYOxVbXN3aogkPos6+4ekzCRyqBItpSt07eX6IVJRVOTG8zE5Ils2DkP5Z8rU5NpuH6hEwNKEbsBVNBBzHHnKKQ==
X-Gm-Message-State: AOJu0YxTC9Bp66eDSpHW2z479zdn3x71N/Bdn6QJvEhwnFJhj7HK2175
	jzbzJwCFBAm910EDEhxYsf5REfoqaMPrYW2INyKkyRh8SBC36t1i
X-Google-Smtp-Source: AGHT+IG1yE761Oo0wHvASf6bT313rWSBwQTyYZPjfHIYWPlbf2Wd4perdaLwwot/BR8RraQ77TWppQ==
X-Received: by 2002:a05:6871:521e:b0:24c:4c82:4f15 with SMTP id 586e51a60fabf-25514c4fc96mr5391470fac.24.1718281836864;
        Thu, 13 Jun 2024 05:30:36 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fedf59299fsm875459a12.55.2024.06.13.05.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 05:30:36 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Icenowy Zheng <uwu@icenowy.me>
Cc: Anand Moon <linux.amoon@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/2] dt-bindings: usb: Add the binding example for the Genesys Logic GL3523 hub
Date: Thu, 13 Jun 2024 18:00:14 +0530
Message-ID: <20240613123020.43500-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the binding example for the USB3.1 Genesys Logic GL3523
integrates with USB 3.1 Gen 1 Super Speed and USB 2.0 High-Speed
hub.

For onboard hub controllers that support USB 3.x and USB 2.0 hubs
with shared resets and power supplies, this property is used to identify
the hubs with which these are shared.

GL3523 has built-in 5V to 3.3V and 5V to 1.2V regulators, which serves
power to the USB HUB, it uses 5V power regulator.

Update the peer-hub description.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Now with fresh install image and updated dtschema all the
dt_binding_check pass

make DT_CHECKER_FLAGS=-m -j$(nproc) dt_binding_check

V7: dropped the reset-gpios: true:
Rob 'No need for this if schema. The default is they are allowed.'
[7] https://lore.kernel.org/lkml/194aa24c-2763-47e2-8ccc-1637d299c1ba@linaro.org/T/

V6: fix the description of the regulators
Updated the commit message for regulator updates.
add reviewed by Conor Dooley
[1] https://lore.kernel.org/all/20231130053130.21966-2-linux.amoon@gmail.com/
v5: upgrade peer-hub description : Conor Dooley
[0] https://www.genesyslogic.com.tw/en/product_view.php?show=67 [Block Diagram]
v4: Fix the description of peer-hub and update the commit message.
Schematics of the Odroid N2+
https://dn.odroid.com/S922X/ODROID-N2/Schematic/odroid-n2_rev0.6_20210121.pdf
V3: fix the dt_binding_check error, added new example for Genesys GL3523
v2: added Genesys GL3523 binding
v1: none
---
 .../bindings/usb/genesys,gl850g.yaml          | 60 +++++++++++++++++--
 1 file changed, 55 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
index 37cf5249e526..fc833363cfb4 100644
--- a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
+++ b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
@@ -9,9 +9,6 @@ title: Genesys Logic USB hub controller
 maintainers:
   - Icenowy Zheng <uwu@icenowy.me>
 
-allOf:
-  - $ref: usb-device.yaml#
-
 properties:
   compatible:
     enum:
@@ -27,17 +24,44 @@ properties:
 
   vdd-supply:
     description:
-      the regulator that provides 3.3V core power to the hub.
+      The regulator that provides 3.3V or 5.0V core power to the hub.
 
   peer-hub:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
-      phandle to the peer hub on the controller.
+      For onboard hub controllers that support USB 3.x and USB 2.0 hubs
+      with shared resets and power supplies, this property is used to identify
+      the hubs with which these are shared.
 
 required:
   - compatible
   - reg
 
+allOf:
+  - $ref: usb-device.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - usb5e3,608
+    then:
+      properties:
+        peer-hub: false
+        vdd-supply: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - usb5e3,610
+              - usb5e3,620
+    then:
+      properties:
+        peer-hub: true
+        vdd-supply: true
+
 additionalProperties: false
 
 examples:
@@ -54,3 +78,29 @@ examples:
             reset-gpios = <&pio 7 2 GPIO_ACTIVE_LOW>;
         };
     };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    usb {
+        dr_mode = "host";
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        /* 2.0 hub on port 1 */
+        hub_2_0: hub@1 {
+            compatible = "usb5e3,610";
+            reg = <1>;
+            peer-hub = <&hub_3_0>;
+            reset-gpios = <&gpio 20 GPIO_ACTIVE_LOW>;
+            vdd-supply = <&vcc_5v>;
+        };
+
+        /* 3.1 hub on port 4 */
+        hub_3_0: hub@2 {
+            compatible = "usb5e3,620";
+            reg = <2>;
+            peer-hub = <&hub_2_0>;
+            reset-gpios = <&gpio 20 GPIO_ACTIVE_LOW>;
+            vdd-supply = <&vcc_5v>;
+        };
+    };
-- 
2.44.0


