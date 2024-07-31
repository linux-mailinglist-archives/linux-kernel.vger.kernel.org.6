Return-Path: <linux-kernel+bounces-269950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E457943929
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 01:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF1B62826E5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 23:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E4616D4FF;
	Wed, 31 Jul 2024 23:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1V41JND"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0DC101EE;
	Wed, 31 Jul 2024 23:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722466958; cv=none; b=TTOzaL6oM5FbG82KKfn9dksCBBIti37/RKur0P3afoYIK0No9g32BRaqRmBI3o/4N3qf+/Jn1Awc/2Jr7GhTRwn/MuhoTKXbBfSO1gaIU4q9CFr7eNv5gb+yhR8tmT6Gnz91Bkq/0O2Rs7J4GNWNXDWLJT0Y2ExBCyIDMgkv6hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722466958; c=relaxed/simple;
	bh=T3h7NIC263TS4VjgpaJsYcFVLKjUz1wp3oH8WWzKtl0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NvRJf7yWE2RjPFXafReCmhBxMadtYzAamhzi1rGDA6FDJYe7E7orP2XWWStIco+gGimPJpFLKA0f3GJIjr/QEaxIqbk+kbF5uHDdn5eX7DgNs31W3vsrcWhHSE66M09h447RWpaSZ2Na0Kf+saQ8SWM6Vs097N3sob8+clUhITs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1V41JND; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-428119da952so39579105e9.0;
        Wed, 31 Jul 2024 16:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722466955; x=1723071755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5J6VZcNo0LtNQ5f0ps5pzEZ8PgHvh7UDv7Qgap+Mbjg=;
        b=B1V41JNDA8+8dyJ2M+/2EdGAAz0dPfAKydwylSPbF5Jvp5/rEU8MYU+Fkqu1FgqBoe
         dEUevRYHBhi2937zWa/cvvTo11FuelBI92XP1DXfs8JItJ7p1wHBJzDC32v7Vifpp24a
         hn/kmqiH871KcTa1GO4HoV3kNm/KSJyL9jCpjVs/WNLEmsJmzzt6BlmHS1NMjFzrNc0L
         lt3wRi28XhrZaJoyNkwhf0ofHlDWPg4m/EN90U9kL/+HVKInjSNOXTthzQhxnzGvFeDM
         /79lQxcNZo8USbjd8/AujsdcLNqQbAk7ZdGfXfgMeTL9ruW/VFOMGFRV9pBkuEZHzZj5
         zQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722466955; x=1723071755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5J6VZcNo0LtNQ5f0ps5pzEZ8PgHvh7UDv7Qgap+Mbjg=;
        b=pjbbtXaJ6Voh2CA3lYUP+lOaJZjV904ecigydJUNzoV9edmnga1op84+Vr4a4E0y70
         bJWXVSryR3AXcxfvgfbiOZTWKepx93lmJmcWZqCW1rM3brqIt2CmWI4YxUN8XjwZiHWK
         hayYt5nHEID2PdzEEhfME3H9QpG2rbrP2eZIm3gWRZJJFl8/z+awNQM4eZkS0FHV/435
         EyCObDdSSZqqC1JWILkAdR5zw6PcIyPp8XTTiJO/ntrSmz86Y1ZvriXxNK/zXwOKGnoK
         3GDPTMQoCFar2mLgYZ1jnVyODm0Rz1s/uwzwXcxn+EkuJdGGOjPIP9vspZBkfS97J19b
         natg==
X-Forwarded-Encrypted: i=1; AJvYcCVG4664uUwiVRfIY2t4GdTQDloXeEcbOf+zaWGrYOIC7lF+34pUjkkWqozGecRTSzMSgKoRtC3zKiF55RTuDwNO0ZUpvLQecXsLEoR+F93oBwG400YwPYIJG4V919FOeu8MMzmcBvxqWw==
X-Gm-Message-State: AOJu0Yx7Vt+fuOv3BQtExK1X9vLxoN2BvQqvkbNf7NxTaHZnWCYnDpiT
	ReYqd6TwTMyckeAIH+aHQQNq6PPYo8De6a9JrJVzDY8S25jhWZys
X-Google-Smtp-Source: AGHT+IEdmZ6Tq+R0aohGrLw8B3uVS9OsbbEWsd1pnFEYVKwRYVznc7DlJgb2QViXJoV8iTVcmvfCSg==
X-Received: by 2002:a05:600c:1385:b0:426:5e8e:410a with SMTP id 5b1f17b1804b1-428b030c91bmr5519885e9.24.1722466955197;
        Wed, 31 Jul 2024 16:02:35 -0700 (PDT)
Received: from alessandro-pc.station (net-37-119-36-202.cust.vodafonedsl.it. [37.119.36.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282baacd7fsm35534635e9.18.2024.07.31.16.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 16:02:34 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	skhan@linuxfoundation.org
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm: socfpga: Add Altera SOCFPGA SDRAM EDAS
Date: Thu,  1 Aug 2024 01:02:26 +0200
Message-ID: <20240731230231.12917-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added new yaml file that substitues the old txt file.

Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---
 .../arm/altera/socfpga-sdram-edac.txt         | 15 ------
 .../arm/altera/socfpga-sdram-edac.yaml        | 46 +++++++++++++++++++
 2 files changed, 46 insertions(+), 15 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt
 create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.yaml

diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt
deleted file mode 100644
index f5ad0ff69fae..000000000000
--- a/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-Altera SOCFPGA SDRAM Error Detection & Correction [EDAC]
-The EDAC accesses a range of registers in the SDRAM controller.
-
-Required properties:
-- compatible : should contain "altr,sdram-edac" or "altr,sdram-edac-a10"
-- altr,sdr-syscon : phandle of the sdr module
-- interrupts : Should contain the SDRAM ECC IRQ in the
-	appropriate format for the IRQ controller.
-
-Example:
-	sdramedac {
-		compatible = "altr,sdram-edac";
-		altr,sdr-syscon = <&sdr>;
-		interrupts = <0 39 4>;
-	};
diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.yaml b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.yaml
new file mode 100644
index 000000000000..78fbe31e4a2b
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/altera/socfpga-sdram-edac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera SOCFPGA SDRAM Error Detection & Correction [EDAC]
+
+maintainers:
+  - Dinh Nguyen <dinguyen@kernel.org>
+
+description:
+  The EDAC accesses a range of registers in the SDRAM controller.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - altr,sdram-edac
+              - altr,sdram-edac-a10
+
+  altr,sdr-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: 
+      Phandle of the sdr module
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - altr,sdr-syscon
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    sdramedac {
+      compatible = "altr,sdram-edac";
+      altr,sdr-syscon = <&sdr>;
+      interrupts = <0 39 4>;
+    };
+
+...
-- 
2.43.0


