Return-Path: <linux-kernel+bounces-209850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F3F903BCF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 14:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9144A1F20C96
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F3217C216;
	Tue, 11 Jun 2024 12:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWS+OsQX"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9CE17BB02;
	Tue, 11 Jun 2024 12:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718108592; cv=none; b=l+TL3A3LX3Y9s0WRAX3aRqFzsNraM0GArD0OuuCOlfTzMh+WCebydFEpZQc2JY71kCC6T5kIUzv5356o+iL1n2u9XPwvawCoSpzUD4ifcUUpEp8Vr2cG5kVRwHWqjnu8jNmGltylaYTsOo60W7Ex/O9qla9oJBbULWat+F74g/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718108592; c=relaxed/simple;
	bh=jz2lKdoLAmywAiVh90VRZ7zihAdGB/Mjfd4CdnLtpFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YYswy10EjUz4ve4CDKDpjSmxA51BLsXYJ7RDg42JefzMKCf9CAueAT0KO4EF3b2b2N/erDpfyeRWW6qCJloV6gZWWw4YSr5H4jSZyucDOV1wlzZpc2J0SLB4Mblm5aTCVUiLTSIHuqm2/v4ljVtDAXpCn5fL0/QTmaaX1EG8Bes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWS+OsQX; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-6eab07ae82bso832175a12.3;
        Tue, 11 Jun 2024 05:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718108591; x=1718713391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EOZTRxupDtWwJHuRilUyPeK4CR8nu2TIfIZfSy2nBSs=;
        b=RWS+OsQXPHRjxLaZcO02Tm2x6kKRuHMMkZoYvkK9wId+9LNd8YJZg097EPKKjZ29MC
         +rzngZ5xx+OmeZzQ7FNyCV1buUfyl+Yc9c3erKtczCSoBuE08WmgsNXGVkSQ24MBM2AR
         2k3WOCVCc6q0DqZvC8csl0S4bKKDuXdsMNdCvyqgHty1hpEFwSXAm/Uaf1Y9btIpgh+g
         E9YPi/PFLcblK6D38zP5it2LGJMO+b+ijc2g9+h9IPz2KwjnS2aDMo4XY2tqW3IYOT8/
         EOUgfZ5k2z9z5XTiyPP+e7zkd34S0nwvGy4/a57cg7xjSAAVtji7Wk0JRF0jfTKBuJ8R
         U6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718108591; x=1718713391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EOZTRxupDtWwJHuRilUyPeK4CR8nu2TIfIZfSy2nBSs=;
        b=TrI4ulhWp1UBOozYNHXWYcchhh2ElRTKOn23HnNkjtfp1o/OxlwFHlxr+Ul81NsZif
         1pZF/EzD8NkvM5zGZde7rXKoRU/glD167Gwz2wFwFl8bvtISb3Eil+0QP6Uo1pP4VHZo
         5Df4Z0cJmbl830G6cmSEmkFeCml/hAT5QULw2l+io9dfZqnoJgaHFlUhz3T+eOJkQGbi
         z+5HuEaERIiRBuRblu+hpZvUWQW0UXkBiUAq/mcdY+vwVlPIQvYXifcG4dfO4TP6eWYx
         wmxqJBhvahNlgI2Xt1SJesQ/0LHMLdETSIXinOZl5AkVmcRGuxipB62R1bCqKfylc8Ng
         QaZg==
X-Forwarded-Encrypted: i=1; AJvYcCU+0KSpaboV58Aa25knhy/URr/uMXwAgYV9RKsiI5qpDfar2oqgb53zkVpNtmREj+4ta7qeFytLNtxiX602Fmmvku5VougbPFwiqh4q9RCy2pKjG4g0hThwNnzgcm0r1aKAjFrRhINhIQf4ftCVDorbGPBil8++VCNC+P7UpnK/QKscSdUX
X-Gm-Message-State: AOJu0YxkmuhwpgpoD8nL9VOyOY+oV1y1epBlsGDwsbf4iW1Y/m+E3L9Q
	bND5YFhlnKd4PiV79Gk0hDyqRGKcbBmWe+7KzbRchHUHU8EZorbA
X-Google-Smtp-Source: AGHT+IEhPFNtb9nmKI5y+NJ+LmMngE9cDpDPrayFaEAYgV3CtqI2Gk9PBOTf6M5x55DhupPbOR5C0w==
X-Received: by 2002:a05:6a21:1a2:b0:1b5:2fbb:2d84 with SMTP id adf61e73a8af0-1b52fbb307amr9428335637.28.1718108590480;
        Tue, 11 Jun 2024 05:23:10 -0700 (PDT)
Received: from fedora.one.one.one.one ([2405:201:6013:c0b2:ea4b:30e0:4e3a:ab56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6f88c51aec4sm328663a12.86.2024.06.11.05.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 05:23:10 -0700 (PDT)
From: Animesh Agarwal <animeshagarwal28@gmail.com>
To: 
Cc: animeshagarwal28@gmail.com,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: wlf,wm8804: Convert to dtschema
Date: Tue, 11 Jun 2024 17:52:51 +0530
Message-ID: <20240611122258.47406-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the WM8804 audio codec bindings to DT schema.

Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
---
 .../devicetree/bindings/sound/wlf,wm8804.yaml | 58 +++++++++++++++++++
 .../devicetree/bindings/sound/wm8804.txt      | 25 --------
 2 files changed, 58 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8804.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wm8804.txt

diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8804.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8804.yaml
new file mode 100644
index 000000000000..3c060179f06e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wlf,wm8804.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/wlf,wm8804.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: WM8804 audio codec
+
+description: |
+  This device supports both I2C and SPI (configured with pin strapping on the
+  board).
+
+maintainers:
+  - patches@opensource.cirrus.com
+
+properties:
+  compatible:
+    const: wlf,wm8804
+
+  reg:
+    description:
+      The I2C address of the device for I2C, the chip select number for SPI.
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 0
+
+  PVDD-supply:
+    description: PLL core supply
+
+  DVDD-supply:
+    description: Digital core supply
+
+  wlf,reset-gpio:
+    description: A GPIO specifier for the GPIO controlling the reset pin.
+    maxItems: 1
+
+required:
+  - reg
+  - compatible
+  - PVDD-supply
+  - DVDD-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        codec@1a {
+            compatible = "wlf,wm8804";
+            reg = <0x1a>;
+            PVDD-supply = <&pvdd_reg>;
+            DVDD-supply = <&dvdd_reg>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/sound/wm8804.txt b/Documentation/devicetree/bindings/sound/wm8804.txt
deleted file mode 100644
index 2c1641c17a91..000000000000
--- a/Documentation/devicetree/bindings/sound/wm8804.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-WM8804 audio CODEC
-
-This device supports both I2C and SPI (configured with pin strapping
-on the board).
-
-Required properties:
-
-  - compatible : "wlf,wm8804"
-
-  - reg : the I2C address of the device for I2C, the chip select
-          number for SPI.
-
-  - PVDD-supply, DVDD-supply : Power supplies for the device, as covered
-    in Documentation/devicetree/bindings/regulator/regulator.txt
-
-Optional properties:
-
-  - wlf,reset-gpio: A GPIO specifier for the GPIO controlling the reset pin
-
-Example:
-
-wm8804: codec@1a {
-	compatible = "wlf,wm8804";
-	reg = <0x1a>;
-};
-- 
2.45.1


