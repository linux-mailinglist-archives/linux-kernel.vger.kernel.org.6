Return-Path: <linux-kernel+bounces-174212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C3D8C0BB7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 08:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4E3E1F244B7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 06:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E954813CAAE;
	Thu,  9 May 2024 06:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="haByynD/"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AFE13C9CE
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 06:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715237448; cv=none; b=aiS7t9v95KIx7NlPHwt358K2aji8bWT+j083fzzJZcfMhrAn7IitkL+cQxMTDbnFKuyr/+08LTgbZ4YyifwtdsG0AGl669OzlbLKKgwiq2gq7sygGd8WVn0T3ROjXhFsbFd39fKB8EHEfPtuvDc2ZPpp3vyrp4ORF0JVEBWr2YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715237448; c=relaxed/simple;
	bh=SqbixuuElHwlwTNKxl0yfahl/2Xw5YGkwtNJ0Zcfvvs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ZWy14ZL4RDbq+IVHIqvxytaha8TVEmqHZDz8JykSeu2ZCg7hw242Le7V6gOiuLXkfktSaPJvuoVqk2W2Bv7wZIZZtbzqP2x6tHbGJ7++qwkFDDuxQNktZ8YrCE/RIPcpy4D0UkXP2UHz02CE4e8Gyf7kB5Wjxf5pUazngUIuho4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=haByynD/; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ed9fc77bbfso451537b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 23:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1715237445; x=1715842245; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N4ZlQt/Y9+Dha+5rkW2FelVk7yDcsRo8ctkHcXLJDwk=;
        b=haByynD/rnY6VejAxN0fF0Neru2yrPnm3H+IkRyNPZgl4slBzk73jFxv2RphMPfErY
         Y1b4O1lJF+ayADMp0Fyk2qYTC3XKPLKV7PabOW9YbNsIAYI8XUJjYqaFCaTfBLAEmg3X
         0AhgQS1MFz/0lMkXPk5ourD5Bk8NaN5zcAIaEOmnuiQPi4G6T8Ael5e+xGvdPnUDlvW+
         BklhClFhDmW50sGXilkpKsrR86eQpNHrqljGUldf/krpPdV53PtAr1c752kwZCJ9I37/
         s62NsoMw3gmia2iwwZdZLG8UvoOVwm36qZUbNiNJ8l9wFDU4ZWp5tp/8lgR9KbC8zFGW
         sa0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715237445; x=1715842245;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N4ZlQt/Y9+Dha+5rkW2FelVk7yDcsRo8ctkHcXLJDwk=;
        b=s8Vd2cWzcERANXIW2/A0VfTPyxuOC/qoQePAo7hMJdHn2/xJUHIG5Dof7JgHeF5cin
         MtHUEy+bu8g/kXiCbe28BS4IngcRB+F+n98Bh66kiOdRQQucyhC2KP+86+bys/MX3FlI
         eQP2ZB0+jq9uBRxD9o5Z8elZu2dhuzU3EAaCIO3eubIzyJzgzF81DM4xm0NBgGKnCn8D
         M7M0CIT8RCKQnq0I6kf5S/4Mdv2DQgsWPlQNWKOBPhMc7lmjLeGAH3yBUpDWKSGL0fvs
         9G+798dwz9syOOra4VqD4S9Aq/vWQq4hSHONtKW1dAAV5fTGUv/aV/zKu5SdG5jd4R/c
         SBWw==
X-Forwarded-Encrypted: i=1; AJvYcCXZu7UYylD66K2kf7tZPwGlDpKLYeMOBhelMMiFbaSyDcp7hWJNZV13pn1XhQzR9dD95Z5BSQTAmKvrAU9DOWcYxH2jGxuwv22G+k38
X-Gm-Message-State: AOJu0YxS56A3P9RI6FFgjtBkb5eOj5hELD91MU6UUWatkeEev/ILe0Wp
	SANIDlPRHd1YyVdy9kks21jWOTh7IhSkkXljcW8OIjESTMu0ymvjnNQk9gAAu6U=
X-Google-Smtp-Source: AGHT+IFBNOOnux53aEtgCfWt8suqTQ28VOR/y9RzpqGcfNYpWzPc/8vnze4mt4HMbw5xu1kLSzbltA==
X-Received: by 2002:a05:6a00:3a9a:b0:6f3:88c5:fed6 with SMTP id d2e1a72fcca58-6f49c22a887mr4670792b3a.19.1715237444915;
        Wed, 08 May 2024 23:50:44 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a84b6bsm633939b3a.74.2024.05.08.23.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 23:50:44 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	benjamin.tissoires@redhat.co,
	dianders@google.com,
	hsinyi@google.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v1 1/2] dt-bindings: display: panel: Add Starry-er88577 support
Date: Thu,  9 May 2024 14:49:58 +0800
Message-Id: <20240509064959.23550-2-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240509064959.23550-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240509064959.23550-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Create a new dt-scheam for the Starry-er88577.

Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
---
 .../display/panel/starry,er88577.yaml         | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/starry,er88577.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/starry,er88577.yaml b/Documentation/devicetree/bindings/display/panel/starry,er88577.yaml
new file mode 100644
index 000000000000..6686beaf0f16
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/starry,er88577.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/starry,er88577.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Starry Display ER88577 based MIPI-DSI panels
+
+description: |
+  -This binding is for display panels using an ER88577 controller
+
+maintainers:
+  - Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: starry,er88577
+
+  pp3300-supply: true
+  reg: true
+
+required:
+  - compatible
+  - reg
+  - enable-gpios
+  - pp3300-supply
+  - backlight
+  - port
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
+        panel: panel@0 {
+            compatible = "starry,er88577";
+            reg = <0>;
+            enable-gpios = <&pio 98 0>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&panel_pins_default>;
+            pp3300-supply = <&en_pp6000_mipi_disp>;
+            backlight = <&backlight_lcd0>;
+            rotation = <90>;
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&dsi_out>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.17.1


