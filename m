Return-Path: <linux-kernel+bounces-178367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CD38C4CAA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 09:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD67728288A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 07:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E44B15EA6;
	Tue, 14 May 2024 07:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGakXGiG"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA9911720;
	Tue, 14 May 2024 07:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715670722; cv=none; b=HWp0dsMdz4O87DIbTs1imLZv5KBD+Tg4C74i1n9oGmnPyg0mOpGPDhU4PVnv0fdPoeX2a2OFDb7CB875ChOkJ9jiPu3zO1xOVqImM9FOY1SzTyRnsVtwJrGYf8wXbHN6bDnp1tfXL3MUPxChX3CU3/aqxKOp7iy4PI5tMqRCUl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715670722; c=relaxed/simple;
	bh=pcnYluDag238mmBsUKSC6PbYsfe7QbcseXtCxzyXERY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c0nFESfzhso/+8X7nd3TNJLsuSVHqAATxB8SKuk3lPGY06jaM2VD06+1+E5BxrzckM0wYpF8yMQ00ZaXo3HDC6Oa8BbSEJ+HSkV7JxvCAK4bJVLfr+FlTcqiV/4IU0MJtzOKn/Rlo424EtxpDQWvNDiSAxxSsYDxm3i+XjxR5fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGakXGiG; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1eb0e08bfd2so30134385ad.1;
        Tue, 14 May 2024 00:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715670720; x=1716275520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3uYIr3Ml2AVWzJhE/ggK+DKrQxQADQHuE7nOd7CrufI=;
        b=FGakXGiGzuOcD3YDjVKFt/g02EXOOvakW/eoyuq3X3Jcrdn7i3mc4SHWiHP2Q/vphq
         Tp5Bg0WrmXYkHpSKPPBxXUgB2EUJErmUgHLGXCMJJG7mhtmkpL7YGSv+u80JRzsbJyOO
         M8lgnB4dq23USqxIChVoKF8cYw2xIXcVhHRR+FMi6IIQ/Qs74QUcNpaiLQOnaHuCtTTe
         tqYDf9grdVK5V+tk59AmNvYI9YZyjiqzMTKrdv4opfqAldV8AsJouPCV0sz16clZ58FP
         LPooSgH1l7fckNTSzRrtSZBnt20Ak50QPvf/dqWInNLh1qBl2uE6iO6e8JV6kQCyk0t8
         Q30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715670720; x=1716275520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3uYIr3Ml2AVWzJhE/ggK+DKrQxQADQHuE7nOd7CrufI=;
        b=Y6aGIIkE9sxQvPqm4eBF+FDU6+wjtCGNsg8YnnstooF/bLRM90B325W3TUCW8Q79JO
         trf6rpM5z4mfxnN2LoPONFT+yUnoNHw2pd3wu5vbXhvErbBjTM9cS/WwsC5dXiS8sq2J
         AVgPOjXPvmK7g8gkeVXemnLH0ZwxMpBQz9fLu2xk0DffWExo7ZaqGyFSnFmLfwPNIsCS
         R+mxNurgCVcugF0GiiRQ/8sPDMyou7RVPTSZEgltYAQItO3cDO2YrnAMIeX6SmtkEg/l
         1AGwpQAiWdClsJX/Q1N6R03qJCg0EbZn6hH4GrNMdzCvXeylDM9b7pHMi2rHh7d1jmjQ
         PMlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJu61vjky6YVEBlhC/vV9jyT5EJKMVffHJ2Z1o+sKSXgk1uVrJRA38zzlwQPwOCRmbgjf2Drnul30Uj8LY1pwEeBwvII4d2DyPrzQS5ozLc8w3aR+ml5lJYYPOTg1xD5pjBMwa+Y11gyg=
X-Gm-Message-State: AOJu0Yz3pHBx14Wu+6mEuoZkUmQKhUsli0yCWV7xVFcI4Z6nciDqEZTz
	Zv/x9Fciq5LrKbQOU9E3LnFoZTYm7IYBXE8hOruDfHz19QPuvVFBIrKKMIxaeow=
X-Google-Smtp-Source: AGHT+IHjy9RplyYNtkpgjstWh8etxT8+rKaKrPSFQtNG4FdFsK/ntTcQAtLDJAMGDRMI748GfeeLDw==
X-Received: by 2002:a17:903:2d2:b0:1eb:1008:2dca with SMTP id d9443c01a7336-1ef43f4cf0cmr138053615ad.49.1715670719911;
        Tue, 14 May 2024 00:11:59 -0700 (PDT)
Received: from xiaxiShen-ThinkPad.gigstreem.net ([66.160.179.28])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf32f51sm93073275ad.154.2024.05.14.00.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 00:11:59 -0700 (PDT)
From: Xiaxi Shen <shenxiaxi26@gmail.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Cc: shenxiaxi26@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	javier.carrasco.cruz@gmail.com,
	skhan@linuxfoundation.org
Subject: [PATCH v2] ASoC: dt-bindings: ak4104: convert to dt schema
Date: Tue, 14 May 2024 00:11:43 -0700
Message-Id: <20240514071143.438748-1-shenxiaxi26@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert ak4104 binding to DT schema

Signed-off-by: Xiaxi Shen <shenxiaxi26@gmail.com>
---
Changes in v2:
 - Remove subsystem maintainers
 - Wrap lines at <80

Signed-off-by: Xiaxi Shen <shenxiaxi26@gmail.com>
---
 .../devicetree/bindings/sound/ak4104.txt      | 25 ----------
 .../bindings/sound/asahi-kasei,ak4104.yaml    | 49 +++++++++++++++++++
 2 files changed, 49 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/ak4104.txt
 create mode 100644 Documentation/devicetree/bindings/sound/asahi-kasei,ak4104.yaml

diff --git a/Documentation/devicetree/bindings/sound/ak4104.txt b/Documentation/devicetree/bindings/sound/ak4104.txt
deleted file mode 100644
index ae5f7f057dc3..000000000000
--- a/Documentation/devicetree/bindings/sound/ak4104.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-AK4104 S/PDIF transmitter
-
-This device supports SPI mode only.
-
-Required properties:
-
-  - compatible : "asahi-kasei,ak4104"
-
-  - reg : The chip select number on the SPI bus
-
-  - vdd-supply : A regulator node, providing 2.7V - 3.6V
-
-Optional properties:
-
-  - reset-gpios : a GPIO spec for the reset pin. If specified, it will be
-		  deasserted before communication to the device starts.
-
-Example:
-
-spdif: ak4104@0 {
-	compatible = "asahi-kasei,ak4104";
-	reg = <0>;
-	spi-max-frequency = <5000000>;
-	vdd-supply = <&vdd_3v3_reg>;
-};
diff --git a/Documentation/devicetree/bindings/sound/asahi-kasei,ak4104.yaml b/Documentation/devicetree/bindings/sound/asahi-kasei,ak4104.yaml
new file mode 100644
index 000000000000..91b3a6817a85
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/asahi-kasei,ak4104.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/asahi-kasei,ak4104.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AK4104 S/PDIF transmitter
+
+allOf:
+  - $ref: dai-common.yaml#
+
+maintainers:
+  - Daniel Mack <github@zonque.org>
+  - Xiaxi Shen <shenxiaxi26@gmail.com>
+
+properties:
+  compatible:
+    const: asahi-kasei,ak4104
+
+  reg:
+    description: Chip select number on the SPI bus 
+    maxItems: 1
+
+  vdd-supply:
+    description: A regulator node providing between 2.7V and 3.6V.
+
+  reset-gpios:
+    maxItems: 1
+    description: Optional GPIO spec for the reset pin, deasserted 
+                  before communication starts.
+    
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+   i2c {
+     #address-cells = <1>;
+     #size-cells = <0>;
+     codec@0 {
+       compatible = "asahi-kasei,ak4104";
+       reg = <0>;
+       vdd-supply = <&vdd_3v3_reg>;
+     };
+   };
-- 
2.34.1


