Return-Path: <linux-kernel+bounces-176738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038198C33E9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 23:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2772C1C20DE6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 21:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FA2381AD;
	Sat, 11 May 2024 21:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="an1LL7Cq"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEE0225AF;
	Sat, 11 May 2024 21:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715464063; cv=none; b=l9NT0RlIi+pB6tpVeG3+WkEj5wikXNw8hSlebL85GkyIsGHd9dQutFGVFJ8hDCx31z78M80OxLhMTl6DHlXeZUNgr1TyGSxw4qICeMLQHpQYr6lNlKq58ET8FwdXi3V3VhRm5KLRCQL5T4QxcI8aViJSbVT0yTth3ozmMmVD7U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715464063; c=relaxed/simple;
	bh=QNfjN4b2tMzhtzedtoNZ+pfxvQvfHMTLgszdJkvCiFk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UAYyYiTS2WbUek4DrbIHlXOQ9rVmNCxtPCOAxKMdgRh5n67yCivUQSf7Qf2R0TFuVAq1GOhIHxwUW9lC6/WeFAGDU0+1QVcBk3dxbWQNqtNp6nEq9v8WawTWpcIwumqNyMU9mEHEDb/vXXf4hTk+ABBXYOpsIYjxwsH9igWhepI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=an1LL7Cq; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ec41d82b8bso30333205ad.2;
        Sat, 11 May 2024 14:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715464061; x=1716068861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rD666xAhRciBgaRR2uTaGJkbuodAuHOu2qefsIjOur8=;
        b=an1LL7CqNT/aud6RE0pUuhax0VcTRmzPVH9S9XYHFnFHs0LlobaoE/GMru6rjeTEJ8
         5/0xRDqRerwSiebm9f8ZJteS+uFAOKidCh64qH/bxmQpSGiqtSddcSBcoDyAyMhWO291
         //mwEcg61eeSgDoQsZjfjyU1sm06MfIqFcuE31bkGK6S1JbtUNF7+B5Zq+6Pkeb2G9di
         1+K2fVBjgvJ6u7yQKR8a3yYMYi5nrpa5LKEw4QQVCaKGp7C2v1rod7RXcD2bF/N/lgqI
         4xGXyW6Ntqw5q8tz20gLIBPvSDxx99FmHPu6gFda52YWZ9YDaynPiJoq08Kll3WTVeSf
         KT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715464061; x=1716068861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rD666xAhRciBgaRR2uTaGJkbuodAuHOu2qefsIjOur8=;
        b=Sx5KvCxO7MOCqKTTs0todR6ORrjNNyBm7Gk+vjDhu9oV8oXAplMWHdYQDSVA6CM4U5
         zmzlMeLQcuOFNfp6cgzQURjz7K4JiPb/q5mq+Ck+T2OCTI0+B74brXzykBzuVnE0qvIt
         q2EmQQgaBaqH2EOUNLn/2OaOz8OC/XUu5dxD+GK7FgKe6HCA4+kN3LZcmhDyk/MxmULL
         QQttB5cZ8L+SiYhV6vkFz1HfJshPEXYBLUP8m8XKhutxaPoft5CzeiyoU6lQZfnBkZ2B
         q56alqXsCskl4B8h8gYJHrFLE6cPBLg+s92QqL24CKl7H1JminbEdFknv9vfC5QEx7yR
         uZ8g==
X-Forwarded-Encrypted: i=1; AJvYcCXWhFFS8LN16wd9rabKit0rzWs3hsIH0fmVRlW+kWT9WmxMTQLbZByoH/ARtbqLEskYWwa5PrYc5OYCzcomCvLjIRwoZZ4ebG25/YmIblAf3hx9wsrbQaXcvJQjcGTppxDMyMt2AA9aQWg=
X-Gm-Message-State: AOJu0Yzvf/IIt/ZBsBYsBRHS8QOULxLtU64J37CIoKhmd3xBQbqS/h+F
	uSUkLnIILXyG9zWFNrgLsm0Wr9T2hn21Y9ABLv1jGNINvijxyZ71NaQKpwrQwk8=
X-Google-Smtp-Source: AGHT+IHGEOhP9IMAbf0jqJJ5qYdjRo7qxPcny49vef74WmCt7q9fOnDvRht9695fH+4jSlqfrZ2hlA==
X-Received: by 2002:a17:902:da87:b0:1eb:b50e:3577 with SMTP id d9443c01a7336-1ef4404f4a5mr97356175ad.56.1715464061310;
        Sat, 11 May 2024 14:47:41 -0700 (PDT)
Received: from xiaxiShen-ThinkPad.dhcp4.washington.edu ([205.175.106.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf319e2sm54259535ad.174.2024.05.11.14.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 14:47:40 -0700 (PDT)
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
Subject: [PATCH] ASoC: dt-bindings: ssm2602: convert to dt schema
Date: Sat, 11 May 2024 14:47:39 -0700
Message-Id: <20240511214739.242950-1-shenxiaxi26@gmail.com>
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
+$id: http://devicetree.org/schemas/sound/adi,ssm2602.yaml#
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


