Return-Path: <linux-kernel+bounces-218845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C7190C6F2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53D72B2298A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486541A2FA1;
	Tue, 18 Jun 2024 08:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQ+pnf+S"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD301A2C29;
	Tue, 18 Jun 2024 08:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718698551; cv=none; b=MK0UNKWf83k8u+zS7OgpMAD6LTMqOr8rKLWPr/Kjq1IjhuFxi3J3CKdOpVzBbZURbxZsOtTDM9O7weOfjFN1L68pkhFdoA3ozDdJXvtjmHfHCCmh853uAzLHgTud0qhsgGn8N4GkOfweMLfsfYkGYJoTJ23O2BtNJCMH01t42z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718698551; c=relaxed/simple;
	bh=ZAJBtCaUM9JLEirclO5Y43C7w4KKYkdHh8DUoibIq4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/WPEbFdKi/FhC+5r0DL4sg/NwjUibiOIOH+ZGc05Ha4soV8W+fzLEPf4XsgwfD0d5u3GE+Lq7x1ynQVmem9HboC/rnLaVSFS0qv1mWqepaVid9dYkoFy+qz0HIlqTmcHiMGD8NmB8DeHgkHzkI4ML6+/NxnAC7yKs5OhLvtmII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQ+pnf+S; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-70df213542aso543934a12.1;
        Tue, 18 Jun 2024 01:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718698549; x=1719303349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1NVDaPXa6D4F2sbo9R4akJ/9kWJg22tXMUc7cYS2HM=;
        b=WQ+pnf+SmGgIbJmVTwtuoBNknmJlxJgIlAvdsYh7qbjVPcxq5wk9yqPcSKan3oWT/x
         xqk3r4XX863rBtVMtrjKeO1lj7UIGmsNi1XWxY3iAD2oVLEf+bBK5BIsLe5UN05ijzRs
         aQrjhcdTefrEdQPGpE7JFpD4yrMEpPtxY7ezpqCrMHVTZs3Xu8/RUrJuP+ST4FEuBth4
         pL+BJZ4U+EhMQgNc/t65pvhfB/z0UtnaP0BiCGtmcQLIumA/gu/iURfsaKBcD9Ck24dc
         0lsXqAehAgT+HiW2E9IIc+BGXIJTQsP75wwUJu6G4YPpQD7fWE9vKn8IrOFXkCO7iYl+
         8gWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718698549; x=1719303349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1NVDaPXa6D4F2sbo9R4akJ/9kWJg22tXMUc7cYS2HM=;
        b=dgdtPeepUW+PtZFwgGEUf4i8YfE3adTKnVgj+vkn/swHeKJSATqcrwuyMrPjabl9DB
         czeaAIZQXzhn0d/fUZTfPwuiCWizt26RsO6kNi2f0FONyScEoYn9w4DBJ0jlRsvwtdB/
         a9H4cTyNYceVWOuYPbirtb+97XJaIBob1lV2F3fWgtZwPIy6jai7ZIgnHZV/SXTgJijN
         KjNhm29EBsS9KjQDaiMEEEgfarLyY7nt/z9oQMJPFdCE9/a7IRaKD6ftpyiQOd/hx5iq
         wDAbets/TXDZcwN8IzmW10h6k8SNIjE6/I3l4MCqX9i+Ni5CRSfBux/hapfMcmToL7be
         1YIw==
X-Forwarded-Encrypted: i=1; AJvYcCWU785kda0z5kpyk4yVO4db0qN+3Jik0nYHj73HTgLGG6LCocNCzWFRKhyIXCDXmmEF2D1ipeIQxvInuPMpl3/vhbdpdqnPsToUAQ==
X-Gm-Message-State: AOJu0YxrO8poRQT6aEm1l0q0/zTQDJWY4DArvcc102ePA2xIgkVF5YeW
	eDUMzVS7Gmet6jBAhIupohKnGU35+M5Dfl1R3716is393rCue6czk0rPK5vCYag=
X-Google-Smtp-Source: AGHT+IGzYUM3GnISel4DD57OKPNCWzNF0T1Fd0b4gLUiKppMSD2hu6qFDU9hmvCWOlG2Ky/D3Xd3lw==
X-Received: by 2002:a05:6a20:2447:b0:1b8:5c3c:794f with SMTP id adf61e73a8af0-1bae7e1133emr13429201637.10.1718698549371;
        Tue, 18 Jun 2024 01:15:49 -0700 (PDT)
Received: from noel.flets-west.jp ([2405:6586:4480:a10:167:9818:d778:5c14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f1a1ebsm91883575ad.238.2024.06.18.01.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 01:15:49 -0700 (PDT)
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
Subject: [PATCH v1 1/3] dt-bindings: display: st7701: Add Anbernic RG28XX panel
Date: Tue, 18 Jun 2024 17:15:12 +0900
Message-ID: <20240618081515.1215552-2-kikuchan98@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618081515.1215552-1-kikuchan98@gmail.com>
References: <20240618081515.1215552-1-kikuchan98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RG28XX panel is a panel specific to the Anbernic RG28XX.
It is 2.8 inches in size (diagonally) with a resolution of 480x640.

Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
---
 .../display/panel/sitronix,st7701.yaml        | 36 +++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml b/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
index b348f5bf0a9..04f6751ccca 100644
--- a/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
+++ b/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
@@ -22,19 +22,21 @@ description: |
 
 allOf:
   - $ref: panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
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
@@ -43,6 +45,13 @@ properties:
   IOVCC-supply:
     description: I/O system regulator
 
+  dc-gpios:
+    maxItems: 1
+    description: |
+      Controller data/command selection (D/CX) in 4-line SPI mode.
+      If not set, the controller is in 3-line SPI mode.
+      No effect for DSI.
+
   port: true
   reset-gpios: true
   rotation: true
@@ -57,7 +66,7 @@ required:
   - port
   - reset-gpios
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
@@ -82,3 +91,26 @@ examples:
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


