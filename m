Return-Path: <linux-kernel+bounces-376790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCD59AB5E5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 20:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF256B234F6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F194E1CB30C;
	Tue, 22 Oct 2024 18:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhmAN83L"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3BC1C9EA5;
	Tue, 22 Oct 2024 18:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729621037; cv=none; b=GWbnC0jzLee+G0nA0dNLFzCytHmsvtkjAYNDRYxpFLSSGBPXsCrZylhLTraD4vDaSG7xhQQuW3//kwRPY36rWL4MF3dytOuDczMqbp8hrsNthGPM1gATeSyWDb0HXYR+y9jUWxJAzY1oYOWrSvtdPaYHQq0bXqJhG3izd58JrLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729621037; c=relaxed/simple;
	bh=TXt7FMHjxwCOlBu3wcBK6UPZElC9tcZtAdhacpGa9PA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=adyJfjT3sN+zRepQM6YQ1D4uTRMtOIq/609d+bwhl8Q8fK11sMMmvTh7Um+197vp+5IO85qLy6Ut2N8yq+jQ+r3/3JIYh5EJv462NW/C0xEJrFFD8HJCE76ne6AoME90NbJbXkaL8vtYYWGBXBHjFVLT0J+SZMEMgmD+z+DtHX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UhmAN83L; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c693b68f5so63830565ad.1;
        Tue, 22 Oct 2024 11:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729621034; x=1730225834; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tOPvOBFrGG9v7r/XPSldG/3s5SdrorTDL8Bqnl9M+ho=;
        b=UhmAN83Lq2E0DSIm19FBJUTGGno/wUS8HsZ043zXFnOmorX5vNPWKR1l89wBbLFCwF
         y58G32cs9FnVDU+Z9ApigfYs/mK2mGu5OxjAeFo+T/u9GHTN3+MCjnpMckBOtNbtg36v
         zUNA+d7BnwQJFplDIseGJseAeCjNjYboJSe+Yah/Tm3HuaJlTQYb+tFUydaTTZV+0NyY
         HlunAeQP5FnGBGnu89plMhtTHSJ5z3aB8/9N+/iYsMTu3nWKWF3//hbefr27e4wovpcw
         IjkBaV7LbOj6bjVbqpFMolxzDsPh/kxDk/cerxQZd9rLt06411MKEN28iDBzt0GoORXE
         t4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729621034; x=1730225834;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tOPvOBFrGG9v7r/XPSldG/3s5SdrorTDL8Bqnl9M+ho=;
        b=X9+Od3gAUYnKWIkD2tHEvcUnkteCJZ9gNH+vlmbOx/MdBTLZKdSUYTmhptLg+oL3vy
         7B2kA3pCpRJlAaZT1Mgopkio5gQuEw7l17FUdajPcMuFv0xCWBSkbnuhTIgW1miDO6E+
         RbguAhmO9Ff4yNurSsVXbDRJzvYOcPsIXvKw1qDN64UfWLIvZguK4sqU9qjaenBer9pk
         ihF1PK9l46tUE0AY6eNxPXFdT3GKRA6Dxm+wtP/Ud+753uXevjGGF6hb78atFE5Og1lv
         TGH2H9AAcOJMgg+DgZ/ag5+eEU2GwRiVTkWl6NkpNtBn3EG6lK/L8VS9xoo9NxGr2LBW
         6O9w==
X-Forwarded-Encrypted: i=1; AJvYcCWPbgwLqlrNqeArNlO10KDbcZNQSvJH3XBU34/o/wnJ7uBqMNLUPRH2slUZBDCf74TWNGGqKQ8ZBUw4G7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YydIiaNSvuMDXDm7fjmTgN0g6BJMWuTqyFeU9p41gJH58ZCG6kJ
	4Y06TicWEi0o4HAMxIxXPsBydTZrehuYfEySgSTdFyCA3wW1dNojCHYDALpq
X-Google-Smtp-Source: AGHT+IFOLoHKXCN01l6moI7lD4MWbgB6NVyAeNycT4AZSKKo1HXOxFdD2XH82mm0UaaD2U1HQvuhDg==
X-Received: by 2002:a17:90b:1983:b0:2e2:a6ee:9280 with SMTP id 98e67ed59e1d1-2e5ddc58547mr3705759a91.26.1729621034306;
        Tue, 22 Oct 2024 11:17:14 -0700 (PDT)
Received: from Emma ([2401:4900:1c96:850b:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad36783dsm6524333a91.21.2024.10.22.11.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 11:17:13 -0700 (PDT)
From: Karan Sanghavi <karansanghvi98@gmail.com>
Date: Tue, 22 Oct 2024 18:17:03 +0000
Subject: [PATCH v2] dt-bindings: soc: bcm: Convert
 raspberrypi,bcm2835-power to Dt schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241022-raspberrypi-bcm2835-power-v2-1-1a4a8a8a5737@gmail.com>
X-B4-Tracking: v=1; b=H4sIAB7sF2cC/42NQQ6CMBBFr0JmbQ0tbaCuuIdhUcoIkwhtpgYlh
 LtbOYHL95L//g4JmTDBrdiBcaVEYcmgLgX4yS0jChoygyqVlqW0gl2KPTJvkUTvZ9VURsTwRhb
 GaVXJHhtrLOR9ZHzQ52zfu8wTpVfg7bxa5c/+U12lkKI2aJUefFVr046zo+fVhxm64zi+JvT2S
 8IAAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Alexander Aring <alex.aring@gmail.com>, Eric Anholt <eric@anholt.net>, 
 Karan Sanghavi <karansanghvi98@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729621030; l=3542;
 i=karansanghvi98@gmail.com; s=20241017; h=from:subject:message-id;
 bh=TXt7FMHjxwCOlBu3wcBK6UPZElC9tcZtAdhacpGa9PA=;
 b=VzEGHIQ+m+wo5aAFSGt04AUeIBJkcK+AjlUMZsEq3Zcj2VTuPi7jLmx+zxQ/j9V0AZyZYaPMs
 wjKvMnAea17DqI+P+lqWBP8gJ1RTZ0tbKA4SiNIg0fVWCOT63q5pbRE
X-Developer-Key: i=karansanghvi98@gmail.com; a=ed25519;
 pk=UAcbefT1C06npNVDJHdgpPqTm4WE9IhaA1fmJb3A37Y=

Convert the raspberrypi,bcm2835-power binding to Dt schema

Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
---
Changes in v2:
- Added original file maintainers
- Removed unnecessary headers from example and formating from description 
- Link to v1: https://lore.kernel.org/r/20241019-raspberrypi-bcm2835-power-v1-1-75e924dc3745@gmail.com
---
 .../bindings/soc/bcm/raspberrypi,bcm2835-power.txt | 47 ----------------------
 .../soc/bcm/raspberrypi,bcm2835-power.yaml         | 42 +++++++++++++++++++
 2 files changed, 42 insertions(+), 47 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/bcm/raspberrypi,bcm2835-power.txt b/Documentation/devicetree/bindings/soc/bcm/raspberrypi,bcm2835-power.txt
deleted file mode 100644
index 30942cf7992b..000000000000
--- a/Documentation/devicetree/bindings/soc/bcm/raspberrypi,bcm2835-power.txt
+++ /dev/null
@@ -1,47 +0,0 @@
-Raspberry Pi power domain driver
-
-Required properties:
-
-- compatible:		Should be "raspberrypi,bcm2835-power".
-- firmware:		Reference to the RPi firmware device node.
-- #power-domain-cells:	Should be <1>, we providing multiple power domains.
-
-The valid defines for power domain are:
-
- RPI_POWER_DOMAIN_I2C0
- RPI_POWER_DOMAIN_I2C1
- RPI_POWER_DOMAIN_I2C2
- RPI_POWER_DOMAIN_VIDEO_SCALER
- RPI_POWER_DOMAIN_VPU1
- RPI_POWER_DOMAIN_HDMI
- RPI_POWER_DOMAIN_USB
- RPI_POWER_DOMAIN_VEC
- RPI_POWER_DOMAIN_JPEG
- RPI_POWER_DOMAIN_H264
- RPI_POWER_DOMAIN_V3D
- RPI_POWER_DOMAIN_ISP
- RPI_POWER_DOMAIN_UNICAM0
- RPI_POWER_DOMAIN_UNICAM1
- RPI_POWER_DOMAIN_CCP2RX
- RPI_POWER_DOMAIN_CSI2
- RPI_POWER_DOMAIN_CPI
- RPI_POWER_DOMAIN_DSI0
- RPI_POWER_DOMAIN_DSI1
- RPI_POWER_DOMAIN_TRANSPOSER
- RPI_POWER_DOMAIN_CCP2TX
- RPI_POWER_DOMAIN_CDP
- RPI_POWER_DOMAIN_ARM
-
-Example:
-
-power: power {
-	compatible = "raspberrypi,bcm2835-power";
-	firmware = <&firmware>;
-	#power-domain-cells = <1>;
-};
-
-Example for using power domain:
-
-&usb {
-       power-domains = <&power RPI_POWER_DOMAIN_USB>;
-};
diff --git a/Documentation/devicetree/bindings/soc/bcm/raspberrypi,bcm2835-power.yaml b/Documentation/devicetree/bindings/soc/bcm/raspberrypi,bcm2835-power.yaml
new file mode 100644
index 000000000000..bc4223428bac
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/bcm/raspberrypi,bcm2835-power.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/bcm/raspberrypi,bcm2835-power.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM2835 power domain driver
+
+maintainers:
+  - Alexander Aring <alex.aring@gmail.com>
+  - Eric Anholt <eric@anholt.net>
+
+description:
+  The Raspberry Pi power domain driver manages power for various subsystems
+  in the Raspberry Pi BCM2835 SoC.
+
+properties:
+  compatible:
+    enum:
+      - raspberrypi,bcm2835-power
+
+  firmware:
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  '#power-domain-cells':
+    const: 1
+
+required:
+  - compatible
+  - firmware
+  - "#power-domain-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    power: power {
+      compatible = "raspberrypi,bcm2835-power";
+      firmware = <&firmware>;
+      #power-domain-cells = <1>;
+    };
+

---
base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
change-id: 20241019-raspberrypi-bcm2835-power-5a4231be8959

Best regards,
-- 
Karan Sanghavi <karansanghvi98@gmail.com>


