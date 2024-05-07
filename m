Return-Path: <linux-kernel+bounces-171474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C77D38BE4D6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39D631F22F96
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF5D15E81E;
	Tue,  7 May 2024 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="jzu9Vmly"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADF715E5DD
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 13:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715089983; cv=none; b=qqJVQhgDUTeGZaJwPHfEGiawqtBaTdYhaB3hXqAnKagZgcWwnHQl5BXkkQwnPie+uqfB71hPDk9Q0nOmDVTEwk5dILBr97/x4VDpNZwLN+3TsZt4g5DTKcfQOi8+3kBGdvgPJLFXOxaMuqGBcd4a8BW0cYo73Sg2LCnzEI9YapQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715089983; c=relaxed/simple;
	bh=ZK/tKKRr2/nEyLcsTaJXfoWejqnYbsGg7dH1c5ZlwC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m2MpiNaa0x1pL7Mfhm72PsK5Jh6feUe9v6foBHtXTWqCTRsnzjF6hPytTb44fCfn3ZFYR+lYwTlqzqYz46AybyAX+Me09uhK0zYcLLCsEAxqweC7qMZRS/IXWtzGH9KYZnGwtEHqHroSwK1P4m02RTCE4+rX3myMqYNtr/WWpHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=jzu9Vmly; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5b1ff50e8d1so1715444eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 06:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1715089981; x=1715694781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fd7zJQgzqEaBgMHOkbXwkF1H9L39T9H8kzbx5q3PlWk=;
        b=jzu9VmlyxjeYg/ktnVpB3aYZMmoB/Kcr2Ulu4yG28gnYDEVnhmAetJ9/Mbk4LRy8Qx
         YaJN1xK2dXWW3SHYpqKYlRdOLcjcHxLHlpw1BWoI+wydEt6PJq4a2sDgfqtou+RML7ap
         +bO44av2bNlD9SeqYayFp3rTGLFxPfzN60BdDK659T5nRIuJP3e0R9gA27ykGzKe18rn
         6CfpNWzJJIHu78g0Jh/VbKtuEAqFB6FERQgGeKUmfQUqnxsGtohaGfuKRPs2kbyDWqze
         8BczZEP8jkWgdvrO9Kkq2QW5YK5NqiV30YLzS6ICFxpF5QQ+6MeRchcHyzSafzEfZQOS
         PT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715089981; x=1715694781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fd7zJQgzqEaBgMHOkbXwkF1H9L39T9H8kzbx5q3PlWk=;
        b=oXMTyIiWX6eHmGVgHDJ+650OCjgQDv0Sms2udTtonrlreGarcm15C3T/uGYpPVKMI4
         dwJ6jMdN/qqg0MwUB3kQ/kZN6Z+QBe7rdGqQderjkfc+AdocbGAJSaE85QevYDdQw3kh
         m3hcTHtCoTSB49ECrwCRt3CkeVUsSPiXAxwM6Eahawd6mp9h3tN4k3LJo+ED44p80Muz
         DTgFxNmE7QyN8e1e/FfvMTWXolxP5HWpx2a3vUZ8Jaab5q5Bt6fOTxONzSuev0mOTaD5
         9bLBwylbPC8dWFY+uxVTFE3Y+am4erHN/xDekxqhbLV7jyNCd/aWF2G/B1qcrdEOzZVp
         +T7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2cRJMrT479d3e8suVRHLwJykHLcF0bBRzpIA+g6ZFLWS49WU9LMe6eZnlMaVMukOapZzKPdC5JwychHqMb34o0LG4dV1/yP1ayWgx
X-Gm-Message-State: AOJu0YzwXOdwO/CIm532jX6rFk5O0VXmq/y0XQCfS0igU2K+JRQRmpW7
	KgP5DH0DYYUhJfRJDNMMSnvYZFQCz49b9S+w96CN2/nOSajoDcPIWCdt9BGEdHk=
X-Google-Smtp-Source: AGHT+IEsnZ77ZUDxgsNmh4OEWDd7fgK5pPFOYQK6h64QDvP6Csu575rTvWK+lrHQ6tA0SqdS8cGbig==
X-Received: by 2002:a05:6359:4e03:b0:17e:8e7f:59f9 with SMTP id oq3-20020a0563594e0300b0017e8e7f59f9mr21441480rwb.26.1715089980766;
        Tue, 07 May 2024 06:53:00 -0700 (PDT)
Received: from localhost.localdomain ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id e7-20020a63e007000000b005dc8702f0a9sm9850542pgh.1.2024.05.07.06.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 06:53:00 -0700 (PDT)
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
Subject: [PATCH v4 1/7] dt-bindings: display: panel: Add himax hx83102 panel bindings
Date: Tue,  7 May 2024 21:52:28 +0800
Message-Id: <20240507135234.1356855-2-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240507135234.1356855-1-yangcong5@huaqin.corp-partner.google.com>
References: <20240507135234.1356855-1-yangcong5@huaqin.corp-partner.google.com>
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
index 000000000000..7cd720eb4981
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
+            compatible = "starry,himax83102-j02, himax,hx83102";
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


