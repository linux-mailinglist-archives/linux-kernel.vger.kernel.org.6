Return-Path: <linux-kernel+bounces-176736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC388C33E5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 23:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A16EB1F21739
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 21:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FAE46430;
	Sat, 11 May 2024 21:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0N/IgyD"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD16F225CE;
	Sat, 11 May 2024 21:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715464046; cv=none; b=koDJ6hvyk6PGP/2h/Yleoy9qfShAppGca1D9RBW8hY5v9Yqq63Y6OACtmUivQSnsaefWQ4BuGTnhq64qZ9KRVsVq2QACRHkPH0EXzbEBOdQnhlZx8src+0wBdsgLaIEsei4xCDaG0VyZBVKiZeTUhjirWWBUFDgn/wAm4enxJE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715464046; c=relaxed/simple;
	bh=pwwGiDR6/6VloAGj9MqJRjrK7X6GFmmGiiTPyj7C0oc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y7VvagkDUXIcJVNI+Ru/41Z6715HWYe0Ph+jjYmIRyet4RqNbE4pCQ+1ose68J0VLsO5k2KFlInnL3BxRZ7KW/gvbbitxFJ0NbPGg6SYx40nk5CZMznTIlyY4IwOrCt9i8Ir1TWrxbbu8KM7kiW1QUSTFi7OaRFIOStC80PMP/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0N/IgyD; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso2473104a12.3;
        Sat, 11 May 2024 14:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715464043; x=1716068843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ckRTRb7gsmLhpFldMqxsVmDmO+RRFrvrEnCpKsYFMyU=;
        b=h0N/IgyDmRffeiTNvmT6043zkYwBQSqFN+AD+pJt+t/EU/KQL62Oyn2zE8qKx0EJty
         CxXYxwswaaOnb1wlJbw0quT/uRIWjjsx3p6r9rIjmKOzmGDEMPXDl182ALzoFp1bh7Xz
         6w05JXkE7y70c2r/c2eEDoYCSY5Gz8I4WiCxS1K69MVQwLdbHnNSFjBBG2ddX9HHKuBM
         Th46gpXBIbakQdeGodKUV4Lh7t/HeLNx5u8N1xu6eAO98Qs4i6D/sJC9ZBiVOjPpBuA0
         IHjtDWTVhSvy3csua0uvhwLGjK5oZaKrGE44OPg+3yWZ1qMwT6Ixl4t0lDqlkpfn9opG
         zFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715464043; x=1716068843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ckRTRb7gsmLhpFldMqxsVmDmO+RRFrvrEnCpKsYFMyU=;
        b=RXcurry9Y+MDeTSQHL+JHGIArP8PwOYDc+7BJw6kcb8C3tQYxuQsBx+kgdezpNT6SC
         9kdG9bD/xz22VgyWHzsmcVdVUbSVgDTXT0LqLI8suqRyYiD4G6etzj59wksUj6OTNQj/
         TpmMAphyn4LzXdjO3CfhUt1ypPBAjuy+slLpVEAShJMhxDH4niBxiHq1Go+0V9Xll911
         bih7WhjSDR0ZgWP5svgbIgCXdzWRbOrIshDwofVOE+7z/dKvMbETUyfj8Bql+UzUW7+0
         93Jcuwq6adveSr5DQb8q9Lzid6xAV+F321wOjXVFEdnxRuRnuSukbnf/mvvIKptoiLRg
         ZShA==
X-Forwarded-Encrypted: i=1; AJvYcCXSClnsGcBej7dQaeYrVi6sUUPo6P6+o8EM6Z72sGstFg07HeNjR0TjzHVL1Oqn5euUYUeubGzWCv726Unzi9OmlykdWShZfICv71QI7YbCXXvgRUe9UJV9VkQFKxvwJViSFeHcLJQluDI=
X-Gm-Message-State: AOJu0Yxd6h+n/+VtQsgzEBq6tBA8n0IKIUI6x4LRa+Ih71r+hQQBi6by
	f8BTzWS2oTVxVaknXR19Tm76o8Tvq7+PM0Y8nziIuRb3BkQVixiO3lcU/ajvxIc=
X-Google-Smtp-Source: AGHT+IFaSubAKFSREviWlTYK5ISN17xeJT1vi5B16LzPtTVpCOfiOBTus2xXniP0KtHWES1O68XMMw==
X-Received: by 2002:a17:902:f54d:b0:1ec:6b87:e125 with SMTP id d9443c01a7336-1ef43f51f9bmr87511545ad.50.1715464042911;
        Sat, 11 May 2024 14:47:22 -0700 (PDT)
Received: from xiaxiShen-ThinkPad.dhcp4.washington.edu ([205.175.106.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf30b22sm53095435ad.180.2024.05.11.14.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 14:47:22 -0700 (PDT)
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
Subject: [PATCH] ASoC: dt-bindings: ssm2305: convert to dt schema
Date: Sat, 11 May 2024 14:47:16 -0700
Message-Id: <20240511214716.242807-1-shenxiaxi26@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert adi,ssm2305 binding to DT schema

It passed dt_binding_check and dtbs_check. Let me know
if you think it should include something else

Signed-off-by: Xiaxi Shen <shenxiaxi26@gmail.com>
---
 .../devicetree/bindings/sound/adi,ssm2305.txt | 14 --------
 .../bindings/sound/adi,ssm2305.yaml           | 35 +++++++++++++++++++
 2 files changed, 35 insertions(+), 14 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/adi,ssm2305.txt
 create mode 100644 Documentation/devicetree/bindings/sound/adi,ssm2305.yaml

diff --git a/Documentation/devicetree/bindings/sound/adi,ssm2305.txt b/Documentation/devicetree/bindings/sound/adi,ssm2305.txt
deleted file mode 100644
index a9c9d83c8a30..000000000000
--- a/Documentation/devicetree/bindings/sound/adi,ssm2305.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-Analog Devices SSM2305 Speaker Amplifier
-========================================
-
-Required properties:
-  - compatible : "adi,ssm2305"
-  - shutdown-gpios : The gpio connected to the shutdown pin.
-                     The gpio signal is ACTIVE_LOW.
-
-Example:
-
-ssm2305: analog-amplifier {
-	compatible = "adi,ssm2305";
-	shutdown-gpios = <&gpio3 20 GPIO_ACTIVE_LOW>;
-};
diff --git a/Documentation/devicetree/bindings/sound/adi,ssm2305.yaml b/Documentation/devicetree/bindings/sound/adi,ssm2305.yaml
new file mode 100644
index 000000000000..8335d763bcd5
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/adi,ssm2305.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/adi,ssm2305.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices SSM2305 Speaker Amplifier
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
+    const: adi,ssm2305
+
+  shutdown-gpios:
+    maxItems: 1
+    description: The gpio connected to the shutdown pin. The gpio signal is ACTIVE_LOW.
+
+required:
+  - compatible
+  - shutdown-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+   analog-amplifier {
+     compatible = "adi,ssm2305";
+     shutdown-gpios = <&gpio3 20 0>;
+   };
-- 
2.34.1


