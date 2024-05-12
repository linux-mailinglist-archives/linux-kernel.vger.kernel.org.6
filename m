Return-Path: <linux-kernel+bounces-176780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9C18C34CB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 02:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5300AB211A4
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 00:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BD223CB;
	Sun, 12 May 2024 00:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHUmlo4U"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE6E1848;
	Sun, 12 May 2024 00:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715473512; cv=none; b=raEog5PVKfawrvvSEi/nSPyLWCEpLNLeoRxWvgd1nKK6LJsatP9JzVZXhRfEtBBCctk1UsPq+/5a9Fbw7KfExIBIppZq5ggqjeIfYYhQ5EaR9gUgx0A958IJ1JzC1eeO1t5noJzIo/IwVXlM50u9WtiTW9TER/IomTJwwwbicI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715473512; c=relaxed/simple;
	bh=MjWZMNVC7Ae5MLOR1g+x21/MOwbT4bYG7cuWzRa1NC0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iJRYiEgnkxFI1zwbdnKzo//6cu75aoMVTim06Wrk/nJyDsAnuIYcp3MbTqudNBk/vJglKf53mCJoxl3kQupjISVU6m++37/4k1dpgdB+kM8RQ0l8eNoZF0suZ3+IZ6DkDh2HD5hYVEmeOXT0DaW4Ra/7Ugru33aq+fNTscpVClw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHUmlo4U; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ec69e3dbcfso27268105ad.0;
        Sat, 11 May 2024 17:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715473509; x=1716078309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Fcqr15Hoz7uvNLMTQl0GUjt/rS4Vk3BnKQaTgeAMOc=;
        b=XHUmlo4USKrSijp+seKPuqqqV+cEed5SIp01qwqhfVwGkhvskHulQ2kGfxtm1Hjicn
         X1YsDBd4MJgFvJ6qbE2IlaasB6nW9EEDDlzKQv1pFnIdKRPDlxg6TUGSphT3Ive2o339
         pbTgK9hTGEYJrtLRP+cgLGeAqejknmsBewp/pLGDz1UpkflIfP7O0SbT1XHdd1ARnzN/
         pEDbR7tAj8tDyR7Dh3nlZUzvT/qtcCl+B6ueoytx6toc9ut0S+dVf7J03YmC4dWiyOjL
         DKEFYsAmpk7ZbMYoYFij/rMsMamJZgwL3ETQG6yrybWVuoMK8pth+qzQQ3AcZ0V7lbW9
         nkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715473509; x=1716078309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Fcqr15Hoz7uvNLMTQl0GUjt/rS4Vk3BnKQaTgeAMOc=;
        b=rIuuA3d4RNVOYZ9qIPa7gLZVLtYy8HouED+ONHvllIlH3OGVtrEM41EOm7zpZa7lFq
         YzymwhwE6xvssKjzl9/wwVdkVKHHktyIL6TDohs/DPJBEdG71nh/e6CWo+3C/kc/duV0
         fkUUC2xPY94yJbammxVLhwIiWKXStgx4BynixCi7UqNLXiZRykO8oQddV4smLXVPUHKX
         hP9zCnXU3Zp9WR5+724cNhrlcTW9IEfloSduzyRhFseyz8yvVHLhPuHo6qp4Cz17dRud
         DhbxYxJ1Lyce185rC6B7YnDb4QZFC6TGvQY6dC4rfNAtsoOqT4rRwjLJmYP1pIz+4WRU
         5WtA==
X-Forwarded-Encrypted: i=1; AJvYcCVRSKFIKHeuz/pX2Qx0iwTYwRI7R0P1oM//X95enkFOk/ohaL/MyU54RJX7/8Agpz519aQQBmL36OT/xynHuYKbbx5OPjg9aOxweU8nKOg8Gul+6Nw0U2aboGSkDyBFcRKsIA/eOHm7zRM=
X-Gm-Message-State: AOJu0Yy2QQ/PX11AVOcoK727ubgdPvCLXb65RN8XUq9R8yBjEgcjx7y1
	znb5iwA+ygqaTXTDQyN0jGiQUZ+3RBhx2sEwJLZpUzQcdiqsvjFw5oq6/k3qWUY=
X-Google-Smtp-Source: AGHT+IHO9cGKQgaqJkZ+7GB+ZpeqZraO2WCWExxitrFgqhu3J4kQyV2weGkJxdqk5ocMunJT0LuRCw==
X-Received: by 2002:a17:903:1c8:b0:1eb:7981:28e8 with SMTP id d9443c01a7336-1ef43c0c94cmr80444055ad.7.1715473509310;
        Sat, 11 May 2024 17:25:09 -0700 (PDT)
Received: from xiaxiShen-ThinkPad.gigstreem.net ([66.160.179.28])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c035c42sm53975495ad.187.2024.05.11.17.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 17:25:08 -0700 (PDT)
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
Subject: [PATCH v2] ASoC: dt-bindings: ssm2602: convert to dt schema
Date: Sat, 11 May 2024 17:24:56 -0700
Message-Id: <20240512002456.267057-1-shenxiaxi26@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert adi,ssm2602 binding to DT schema

The original adi,ssm2602.txt contains bindings for 3 devices
SSM2602, SSM2603 and SSM2604. Since they share something
in common. So I created one single yaml and name it 260x instead.
Let me know if you think it should be done in another way.

It passed dt_binding_check and dtbs_check.

Signed-off-by: Xiaxi Shen <shenxiaxi26@gmail.com>
---
Changes in v2:
 - Change '2602' to '260x' in the variable $id and
 it passed dt_binding_check and dtbs_check now.

 .../devicetree/bindings/sound/adi,ssm2602.txt | 19 -------
 .../bindings/sound/adi,ssm260x.yaml           | 50 +++++++++++++++++++
 2 files changed, 50 insertions(+), 19 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/adi,ssm2602.txt
 create mode 100644 Documentation/devicetree/bindings/sound/adi,ssm260x.yaml

diff --git a/Documentation/devicetree/bindings/sound/adi,ssm2602.txt b/Documentation/devicetree/bindings/sound/adi,ssm2602.txt
deleted file mode 100644
index 3b3302fe399b..000000000000
--- a/Documentation/devicetree/bindings/sound/adi,ssm2602.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-Analog Devices SSM2602, SSM2603 and SSM2604 I2S audio CODEC devices
-
-SSM2602 support both I2C and SPI as the configuration interface,
-the selection is made by the MODE strap-in pin.
-SSM2603 and SSM2604 only support I2C as the configuration interface.
-
-Required properties:
-
-  - compatible : One of "adi,ssm2602", "adi,ssm2603" or "adi,ssm2604"
-
-  - reg : the I2C address of the device for I2C, the chip select
-          number for SPI.
-
- Example:
-
-	ssm2602: ssm2602@1a {
-		compatible = "adi,ssm2602";
-		reg = <0x1a>;
-	};
diff --git a/Documentation/devicetree/bindings/sound/adi,ssm260x.yaml b/Documentation/devicetree/bindings/sound/adi,ssm260x.yaml
new file mode 100644
index 000000000000..f465f9168a0a
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/adi,ssm260x.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/adi,ssm260x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices SSM2602, SSM2603 and SSM2604 I2S audio CODEC devices
+
+description:
+  SSM2602 support both I2C and SPI as the configuration interface,
+  
+  the selection is made by the MODE strap-in pin.
+
+  SSM2603 and SSM2604 only support I2C as the configuration interface.
+
+maintainers:
+  - Liam Girdwood <lgirdwood@gmail.com>
+  - Mark Brown <broonie@kernel.org>
+  - Rob Herring <robh@kernel.org>
+  - Krzysztof Kozlowski <krzk+dt@kernel.org>
+  - Conor Dooley <conor+dt@kernel.org>
+
+properties:
+  compatible:
+    description: One of "adi,ssm2602", "adi,ssm2603" or "adi,ssm2604"
+    enum:
+      - adi,ssm2602
+      - adi,ssm2603
+      - adi,ssm2604
+
+  reg:
+    description: the I2C address of the device for I2C, the chip select number for SPI.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+   i2c {
+     #address-cells = <1>;
+     #size-cells = <0>;
+     ssm2602@1a {
+       compatible = "adi,ssm2602";
+       reg = <0x1a>;
+     };
+   };
-- 
2.34.1


