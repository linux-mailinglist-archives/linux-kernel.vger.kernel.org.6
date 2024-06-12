Return-Path: <linux-kernel+bounces-211727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DB8905607
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1218C1C20A1B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B7417F518;
	Wed, 12 Jun 2024 14:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPp7RNFy"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1802B17E908;
	Wed, 12 Jun 2024 14:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204373; cv=none; b=niP0VtLIeN6n/Xg8JJ3Czfz+KBHNhAjNzW5JPyAw69YbIt2txzalaMY4I7JHCdk+9RcDr7rSRXEDIxsZvdBrD+ZltyX410keAQeG777fUzjPgbqah+6qLfsJmkD5OWn5HHJVdu9e2Y1TN3mGtFHQNXlsY1JUCDpDpFpFffkPNzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204373; c=relaxed/simple;
	bh=I/RhYDzf/30awGk8qX49GxRawz1i67PHYIeoDU9q/pA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WZvkG+VNLMbrE3dgHOeAw1dpxyVNE0INH/sE0pkjKsQGCdQ0WUVAX9/UdDBB2PJw6v1w9iKtxu0G6iQ4UddMd/I/lQGGtuluKbXcpc9qPw4kpE6SPX5Oz3yDNpLJU4ZXIwLUAqqzsL8JWgteogY/40wTF2nxbqEKEy1ppnSeYC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPp7RNFy; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-797fb0b4832so23031185a.0;
        Wed, 12 Jun 2024 07:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718204371; x=1718809171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r7pnIh8CCgoUZgqnSf6nIhLg5VDGVcPLcOm4WGfQJrQ=;
        b=GPp7RNFyEbd8m7R5ORIO795gPgpicOY6JIdsIsI8NTqrNlqCLdBsfhNigoUc9H7tUs
         gWCcL/fxng21y+kd9LDeihea+UhyWDjp+SuKaShIxnGVMh9nlLRoBiAEoKHeYizmwq5V
         UqdOw7o2+fdGcuJoj4+xX4NLfaVbJOsS9nzYQthbxSHH+WcaEvgrQkH1TdyxOyc2zRcl
         wDcalQ0CqARJVU9a+cKkN3ObNzQ0+bShzda9upU+0ESSgSX1kk6nPNVnASVPKXZFzqc/
         04g0u+EUF2PE5FXL02Suf68a37ss6tIZes6T0/sjJK/0NNrOuz0OZnMcqdlNvZNSeMHG
         26wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718204371; x=1718809171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r7pnIh8CCgoUZgqnSf6nIhLg5VDGVcPLcOm4WGfQJrQ=;
        b=rkwhDnZKiez6pvamnu2/a+r/ylw17RHB3A4fBrG2kM2+BJuOuOhCSfQ9BVVIKNDzhK
         Vcjm4LcfNv2znahtylsHuN9dL5pqXML0AFQxrotJMIBV1zFozcBlBAjoNb9hQA2NglDd
         KXhffHMnTrDd37U+hyJg7mkYMssUnqlh/exX2XQHC+MTwozuaCRSFdNDLy/Fuu2NTo0f
         CxT1NmtwrPj9UtVUEYmiGh+9S3vOi9VEO9eIBgkgOHVOzwHAGyP59VE90modZua8r9re
         ILC5AWIyoJs64ukiTZWYBG5ZssUPnJ0YXC+feBxtVD/mUL/aXg+RVlq8td7OEQIYa5y+
         Td6g==
X-Forwarded-Encrypted: i=1; AJvYcCVdWTue07FjcJYZQeRZvCqGoZraxALoTvdworm9ioErxOJjKxlfA+3CV3UX4f5v4Dgod14z7vHYGfAutGCtPKzJJGjS+N9NBJbjAGEa5Db/JaJbJaCM+j5yhX6W275pbHbR682Q/e5E4qkhvVdRrY79DhepbfV99gKHLrIAZbKQYQif9sVw
X-Gm-Message-State: AOJu0YwqKd3g6FoXOGXeUjEr8HDCRHWzd6wmWSR0Z5+xmIyAHFaCOInu
	NQxZ8laUDUpr/Tu48mN181zmG/s59WmkiaOiPUJNvJYsmI8gatGk
X-Google-Smtp-Source: AGHT+IEzBD02R0RYQC2Qs1ckK+wDy9Iol4jNBX/wfyFXYm5GbCm+JL+8uf/UJjk2wOPVhPpisc5hjA==
X-Received: by 2002:a05:620a:258a:b0:795:5a93:5b86 with SMTP id af79cd13be357-797f600740bmr217734585a.15.1718204370889;
        Wed, 12 Jun 2024 07:59:30 -0700 (PDT)
Received: from sheun-Legion-5-15IAH7H.phub.net.cable.rogers.com ([2607:fea8:bad7:5400:f2b7:e8f6:98dd:a423])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7955ad3b9b5sm366409385a.85.2024.06.12.07.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 07:59:30 -0700 (PDT)
From: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org
Cc: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>,
	skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: sound: Convert max98088 to dtschema
Date: Wed, 12 Jun 2024 10:59:01 -0400
Message-ID: <20240612145903.497758-1-abdulrasaqolawani@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the max98088 audio codec txt bindings to DT schema.

Signed-off-by: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
---
Validated with dtschema and tested against samsung/exynos5800-peach-pi.dts.

 .../bindings/sound/maxim,max98088.txt         | 23 ---------
 .../bindings/sound/maxim,max98088.yaml        | 47 +++++++++++++++++++
 2 files changed, 47 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/maxim,max98088.txt
 create mode 100644 Documentation/devicetree/bindings/sound/maxim,max98088.yaml

diff --git a/Documentation/devicetree/bindings/sound/maxim,max98088.txt b/Documentation/devicetree/bindings/sound/maxim,max98088.txt
deleted file mode 100644
index da764d913319..000000000000
--- a/Documentation/devicetree/bindings/sound/maxim,max98088.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-MAX98088 audio CODEC
-
-This device supports I2C only.
-
-Required properties:
-
-- compatible: "maxim,max98088" or "maxim,max98089".
-- reg: The I2C address of the device.
-
-Optional properties:
-
-- clocks: the clock provider of MCLK, see ../clock/clock-bindings.txt section
-  "consumer" for more information.
-- clock-names: must be set to "mclk"
-
-Example:
-
-max98089: codec@10 {
-	compatible = "maxim,max98089";
-	reg = <0x10>;
-	clocks = <&clks IMX6QDL_CLK_CKO2>;
-	clock-names = "mclk";
-};
diff --git a/Documentation/devicetree/bindings/sound/maxim,max98088.yaml b/Documentation/devicetree/bindings/sound/maxim,max98088.yaml
new file mode 100644
index 000000000000..8800075f7f97
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/maxim,max98088.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/maxim,max98088.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MAX98088 audio CODEC
+
+maintainers:
+  - Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - maxim,max98088
+      - maxim,max98091
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: master clock
+
+  clock-names:
+    items:
+      - const: mclk
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        audio-codec@10 {
+            compatible = "maxim,max98089";
+            reg = <0x10>;
+            clocks = <&clks 0>;
+            clock-names = "mclk";
+        };
+    };
-- 
2.43.0


