Return-Path: <linux-kernel+bounces-174029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5048C0959
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 03:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF5B41C20F71
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 01:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB8513C8EE;
	Thu,  9 May 2024 01:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="1b5r2cI3"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED4A13C68B
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 01:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715219584; cv=none; b=fm2oLPC3ooB4O8VRDgP8iyGoExSm6z6wWq5rctbWOvP+AK0XVwwpZroh+Fna/GY/hk3AQDJT4E3Frd2hjGe5YUckFJK6PxoCftmij0GidBnUhEX1SvR8xGB9fgxTYrHRJZoC0/Twv/plGE/nbIAEtIgWCngTWi+JaouUH+kUWas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715219584; c=relaxed/simple;
	bh=RyK+/SayTgMX1VNOzVlyBfeKFcFhKtvLlBK04wH6hl0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AVYbSE0UZdfuPDxM0f5HySnx5BBCtigPtKD8xrEj8a7m+Cg2zO7E3b0WzA5EVTE4MZ6c84KekJkv29vX+M2s7WSzDPABQh4bma5z+DIYSM4afBKpfukRzKhpyW6poX9gzVtNLSh3aumW4+ezck33qTYfxk+6qdC0JBBnE2u4qC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=1b5r2cI3; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ee42b97b32so2342395ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 18:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1715219582; x=1715824382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YHqY4rvmgjZTcyhKpqKOQRPJuxfie+pGF8qzijOtc8=;
        b=1b5r2cI3W95iKz7yh/MvKQo0jLBuV0qiLvwi+KmiDaV9NL3G/RHRSm5BBlt4wHQHYs
         JroQZA5hWqzo2DMz9Mbi1v2j+RmVw65FVYcVoQuRcfapMsHGUZwziBAo9ihvFKp+f10O
         s6d63mw6VOEO+lpnb+II6okxCCzSX/cfMXDYnsy3jcD82RSOMtU/5Gfds4+dR1AXsBmq
         ubqc2LTUSBauDwBsuBVQXpaYwnuFiz7qI8wPd21jDlkJIPJq+wQwa10I4JXYN0j02dsv
         fK1sXB1XZv2TLxxG+jlazuUQvUqlUp4KsohftwlxOCeJpO3CO/xHSgI8gsh5lZdCHVCW
         sONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715219582; x=1715824382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+YHqY4rvmgjZTcyhKpqKOQRPJuxfie+pGF8qzijOtc8=;
        b=wWJfRWK/VoqzI93iEHTdtsxAN1/3cEqc0wFs2zC3RKe06qIVAUnblCM756TiLjQvSh
         xdyOwu3CMcEdNe0P0EbNyY/zxFeJuBP0kDe6ig4jJ+qLTVaqavV7oF9yVqc3JMJp7Xyu
         mpTL+8SnrbF619qczgpYnw6xx+jCFcleGPzyXsNE81uZltm41/oYYfXTolIzMobfHOkM
         jFdN6ZF0niSy38HEf8BHFLjKg4bR163VowI/ZITJkeFmSIGp3PvkpdqgelRFAaNfBshs
         eH8fD9enuKYi8r9J8256mFf242IvAfWFcz+FowVntuBELOGYU2CP2TNSK4UPmXRSbbOQ
         NPYw==
X-Forwarded-Encrypted: i=1; AJvYcCUWUFABe7n19YPP/PCNNrjfa3Bh1C0t3n4zuZX/k5NLYOBPb0c4Jvr5058lI0BHcrfrPDjNzH6VkhV+S40EtAWpiuHX5raosqWUdBV1
X-Gm-Message-State: AOJu0YzB19irNScCghEYLurnv7e76XbwI7dl5zAWqGph4W5Q+KTuCLw3
	6cwwhdCv5YxOIc2awSB24RX6m4thAQU2f8mHGDaEsinNh1jNA9gC2twLWAiO3e0=
X-Google-Smtp-Source: AGHT+IFJnk1bVPkEQ4uPeZpwIxkhqkI4UKKUovM4m5g3TQjpZylCeYUwHPQ4+7G9+YyNeXiRBK07tQ==
X-Received: by 2002:a17:902:e801:b0:1e4:31e9:83ba with SMTP id d9443c01a7336-1eeb049b32emr55347425ad.1.1715219582581;
        Wed, 08 May 2024 18:53:02 -0700 (PDT)
Received: from localhost.localdomain ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d15dfsm2117465ad.62.2024.05.08.18.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 18:53:02 -0700 (PDT)
From: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To: sam@ravnborg.org,
	neil.armstrong@linaro.org,
	daniel@ffwll.ch,
	dianders@chromium.org,
	linus.walleij@linaro.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xuxinxiong@huaqin.corp-partner.google.com,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH v5 1/7] dt-bindings: display: panel: Add himax hx83102 panel bindings
Date: Thu,  9 May 2024 09:52:01 +0800
Message-Id: <20240509015207.3271370-2-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240509015207.3271370-1-yangcong5@huaqin.corp-partner.google.com>
References: <20240509015207.3271370-1-yangcong5@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In V1, discussed with Doug and Linus [1], we need break out as separate
driver for the himax83102-j02 controller. Beacuse "starry,himax83102-j02"
and in this series "BOE nv110wum-l60" "IVO t109nw41" panels use same
controller, they have some common CMDS. So add new documentation for
this panels.

For himax83102-j02 controller, no need 3v3 supply, so remove it.

[1]: https://lore.kernel.org/all/CACRpkdbzYZAS0=zBQJUC4CB2wj4s1h6n6aSAZQvdMV95r3zRUw@mail.gmail.com

Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
---
Chage since V5:

- Modify compatible format.

V4: https://lore.kernel.org/all/20240507135234.1356855-2-yangcong5@huaqin.corp-partner.google.com

Chage since V4:

- Update commit message and add fallback compatible.

V3: https://lore.kernel.org/all/20240424023010.2099949-2-yangcong5@huaqin.corp-partner.google.com

Chage since V3:

- Update commit message.

V2: https://lore.kernel.org/all/20240422090310.3311429-2-yangcong5@huaqin.corp-partner.google.com

---
 .../display/panel/boe,tv101wum-nl6.yaml       |  2 -
 .../bindings/display/panel/himax,hx83102.yaml | 73 +++++++++++++++++++
 2 files changed, 73 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
index 906ef62709b8..53fb35f5c9de 100644
--- a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
+++ b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
@@ -32,8 +32,6 @@ properties:
       - innolux,hj110iz-01a
         # STARRY 2081101QFH032011-53G 10.1" WUXGA TFT LCD panel
       - starry,2081101qfh032011-53g
-        # STARRY himax83102-j02 10.51" WUXGA TFT LCD panel
-      - starry,himax83102-j02
         # STARRY ili9882t 10.51" WUXGA TFT LCD panel
       - starry,ili9882t
 
diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
new file mode 100644
index 000000000000..fc584b5088ff
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/himax,hx83102.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Himax HX83102 MIPI-DSI LCD panel controller
+
+maintainers:
+  - Cong Yang <yangcong5@huaqin.corp-partner.google.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          # STARRY himax83102-j02 10.51" WUXGA TFT LCD panel
+          - starry,himax83102-j02
+      - const: himax,hx83102
+
+  reg:
+    description: the virtual channel number of a DSI peripheral
+
+  enable-gpios:
+    description: a GPIO spec for the enable pin
+
+  pp1800-supply:
+    description: core voltage supply
+
+  avdd-supply:
+    description: phandle of the regulator that provides positive voltage
+
+  avee-supply:
+    description: phandle of the regulator that provides negative voltage
+
+  backlight: true
+  port: true
+  rotation: true
+
+required:
+  - compatible
+  - reg
+  - enable-gpios
+  - pp1800-supply
+  - avdd-supply
+  - avee-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        panel@0 {
+            compatible = "starry,himax83102-j02", "himax,hx83102";
+            reg = <0>;
+            enable-gpios = <&pio 45 0>;
+            avdd-supply = <&ppvarn_lcd>;
+            avee-supply = <&ppvarp_lcd>;
+            pp1800-supply = <&pp1800_lcd>;
+            backlight = <&backlight_lcd0>;
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
2.25.1


