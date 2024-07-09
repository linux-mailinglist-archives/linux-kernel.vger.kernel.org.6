Return-Path: <linux-kernel+bounces-245956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3490F92BBD6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 572861C21E21
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FDD18A948;
	Tue,  9 Jul 2024 13:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="wrTvyM57"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E62618508E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 13:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720532934; cv=none; b=r3etLGtjSPo20ScJ6myLSo9SlUGpWpoI+mItApgSJp9jyD/JvDdHDNdfaHuL71plOu1FSlRHVTQ0PWPi8ODGyfM8MN2INycsX/NtyYB5IIpFCSZBeLEbRkNQLZboeJUZe8VaOsd2auBv/1HBsxZ7+6QE46GgSzcDsulomEAQ0oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720532934; c=relaxed/simple;
	bh=kPtprpEAbia452Yz5dZXjFq21tQm/BBQy7vGeFnn+H4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=I47i+Oa3ujnDWI9xo4jYO25Ahyr/bMlKPMaKhBoyftWQrIccrNQf54Ad5tE8/RDH72OTB45WJXP9yCo/o03wn82f1ULZu2AnMmY1Ss8GHaD1kkCgWciwLr+TNDVvALCNXh+sxwtHl8sFMUdbvnOFSOVxOhcRwM4ILk7lioZN6is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=wrTvyM57; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fb1c918860so40849375ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 06:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1720532922; x=1721137722; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d1cg3oGj3xn4CjG29iqKzWVPtEDspEWgovxGLFjyf9Y=;
        b=wrTvyM57sKB5Z8niFcU23jnkki/OE80Q4wWalEld4Lgkdpsk4Yh7A55iHc7YTRL6mv
         B4IFymDVGg6NszfjwPX/E9ta+noybkKITQ+5JVJNF+t32i+eeCJMPdPzKtfcI5rXIjI4
         HWyZSvjKDD+fWOo8C6miuP0EuNVOtNYHo6ddziAeVQyuOm7852ujOKRxY7impwyHmjE+
         X6sYFucBfZ4/I8h+IK9bHZDdn3W+btjo6CMwm30TmGuBumUPBkixkVfTnmhDZ+fqyH0E
         WkQTsipa6MT4EOv8sdwXAYqpykUmudavy8pi35xH5PTXeVViTOgUtXVh7T2iCfPM+qOk
         8zRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720532922; x=1721137722;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d1cg3oGj3xn4CjG29iqKzWVPtEDspEWgovxGLFjyf9Y=;
        b=kbpnINHsvfXA0iodMFaNPjb1dFhmkcDnomOzlgmALeHaoiqfOqFMAq7ti06yDQDv8O
         YZ2TiErRMA7ZYCdVluv221Ke6lJFu/pmFznSdaTD5RVBHjIDSl3DR0eC+DM6ow606VXX
         5YrvSAj8SOKiLUBLIjB07dh5w+F9n6Lr9Ua2qE3W/1ZzPYt6hcnfDO7HEwEI42VqjgGK
         YPY+67rgIcCiZF+Xz4nGumUaDI3QWJQFjp6hi07cbZ4FGDANExGIAuD2QvinNdljO/GY
         tUtC59F8hgvCe+YIS3rXeV7qI9KLcKPf6Ic8AwjtJ3DV0fGEcgTGfB4Y5WBOYFFiC45R
         OWlw==
X-Forwarded-Encrypted: i=1; AJvYcCX51yla+8tlfcAD5jIl5U0saAMw6Hne4wY/o/c9BKQvC5axxOL1R+KSDSJ/kKumE99xyScC2LzBKSUBab24O6h/OpMB+FnuoNQPPiMy
X-Gm-Message-State: AOJu0Yz0sFSAF4RGWuvDkvObaSp7+Sj3lcz1Ak1MDEqH7s+M9nuZYet9
	4fmnJlMxcgUDVFPOvbJOPhWp4/EunQz+Iwf6yadWCwkVSLV0jNI+81AhMgoU/vk=
X-Google-Smtp-Source: AGHT+IGLfknG2M8X0lovKsSP0vKbezDHgILVPXhoA81XpBuj5dwR7qFpbLQUQaFiZglTuwKGg6Rz4Q==
X-Received: by 2002:a17:902:d2c1:b0:1fb:7530:61c6 with SMTP id d9443c01a7336-1fbb7f7a9f7mr41595795ad.2.1720532921676;
        Tue, 09 Jul 2024 06:48:41 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab6b9fsm16211685ad.138.2024.07.09.06.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 06:48:41 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: neil.armstrong@linaro.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	airlied@gmail.com,
	mripard@kernel.org,
	dianders@google.com,
	hsinyi@google.com,
	awarnecke002@hotmail.com,
	quic_jesszhan@quicinc.com,
	dmitry.baryshkov@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v6 4/5] dt-bindings: display: panel: Add compatible for starry-er88577
Date: Tue,  9 Jul 2024 21:47:53 +0800
Message-Id: <20240709134754.28013-5-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240709134754.28013-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240709134754.28013-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The starry-er88577 is a 10.1" WXGA TFT-LCD panel, and the init_code
of the starry-er88577 panel is very similar to the boe-th101mb31ig002
panel, so We will add a new configuration based on
"boe,th101mb31ig002-28a.yaml".

Because the panel used reset gpio before but did not add the definition
of "reset gpio" in binding, reset gpio was added in binding, but since 
the starry-er88577 panel did not use "reset gpio", a judgment was added 
here.

Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes between V6 and V5:
-  1. Modify the commit information.
-  2. Modify "reset gpio" binding.

v4: https://lore.kernel.org/all/20240704072958.27876-5-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V5 and V4:
-  1. We are compatible with starry-er88577 panels in the boe-th101mb31ig002
-     driver, so add it to the "boe,th101mb31ig002-28a.yaml".

v4: https://lore.kernel.org/all/20240620115245.31540-2-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V4 and V3:
-  1. Move positions to keep the list sorted.

v3: https://lore.kernel.org/all/20240614145609.25432-2-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V3 and V2:
-  1. Separate the Starry bindings from kingdisplay, and add it to panel-simple-dsi.yaml

v2: https://lore.kernel.org/all/20240601084528.22502-4-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V2 and V1:
-  1. Add compatible for Starry er88577 in Kingdisplay kd101ne3 dt-bindings.
---
 .../display/panel/boe,th101mb31ig002-28a.yaml | 20 ++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/boe,th101mb31ig002-28a.yaml b/Documentation/devicetree/bindings/display/panel/boe,th101mb31ig002-28a.yaml
index 32df26cbfeed..c5efc560ba1c 100644
--- a/Documentation/devicetree/bindings/display/panel/boe,th101mb31ig002-28a.yaml
+++ b/Documentation/devicetree/bindings/display/panel/boe,th101mb31ig002-28a.yaml
@@ -9,18 +9,18 @@ title: BOE TH101MB31IG002-28A WXGA DSI Display Panel
 maintainers:
   - Manuel Traut <manut@mecka.net>
 
-allOf:
-  - $ref: panel-common.yaml#
-
 properties:
   compatible:
     enum:
         # BOE TH101MB31IG002-28A 10.1" WXGA TFT LCD panel
       - boe,th101mb31ig002-28a
+        # The Starry-er88577 is a 10.1" WXGA TFT-LCD panel
+      - starry,er88577
 
   reg: true
   backlight: true
   enable-gpios: true
+  reset-gpios: true
   power-supply: true
   port: true
   rotation: true
@@ -31,6 +31,20 @@ required:
   - enable-gpios
   - power-supply
 
+allOf:
+  - $ref: panel-common.yaml#
+  - if:
+      properties:
+        compatible:
+          # The Starry-er88577 is a 10.1" WXGA TFT-LCD panel
+          const: starry,er88577
+    then:
+      properties:
+        reset-gpios: false
+    else:
+      required:
+        - reset-gpios
+
 additionalProperties: false
 
 examples:
@@ -45,6 +59,7 @@ examples:
             reg = <0>;
             backlight = <&backlight_lcd0>;
             enable-gpios = <&gpio 45 GPIO_ACTIVE_HIGH>;
+            reset-gpios = <&gpio 55 GPIO_ACTIVE_LOW>;
             rotation = <90>;
             power-supply = <&vcc_3v3>;
             port {
-- 
2.17.1


