Return-Path: <linux-kernel+bounces-342097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 889E4988A81
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 20:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F5ECB21DE1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 18:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5931C3F0E;
	Fri, 27 Sep 2024 18:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMeX4l2y"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452E21C330C;
	Fri, 27 Sep 2024 18:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727463247; cv=none; b=XDBTqV2vTSW5KL8ktlV88SQmQFQym/5UeIdvm8+qXPBvM2BVZUaKsCEkEYvlUfmVh4hh2aIeO8qxI5I6V2jgCSKbFMcX1Xw8PLTLh/0taPTLb+kILsTxFaNz8up+qYzGy4K2RMTAqg8VejdjEZFqn6+oiN7nY5Mo2BqdAbpMaRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727463247; c=relaxed/simple;
	bh=RL/oXS8HT/W7F9kFa8WXbFROZ++mPP9IRzr6gEiSpFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fSQlje1eKVGcDaV9UtbbU/6ciSR/6FuptBAbngKX3+au8+DIg4Y8EfVelTs/pPs7Bpm1vKzoey0QDCDGvoCXn4nQ27yUdEQkZFFxfOLpmT8THCeD+bKRHt3ebQ5Mg6DTquXMrDVkbrE9v7jWdldJtHTaQaL3fWuMTsbHK98OdFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMeX4l2y; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c88370ad7bso1293247a12.3;
        Fri, 27 Sep 2024 11:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727463245; x=1728068045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gINxRe+ASYqtepoVoa4Hly4r/EQvvxkKq3TYC82Kds0=;
        b=BMeX4l2y6Lo9cn2+qw6CA8ET8fu266tFBYu1UUdORb6yQ6L3l7OgylgzYuOHTv3nJ2
         8yTgr9hxx9YpdejRp4HuzoNcsB2CykJ/rz6JcNQVDY42NVMmi5Gl0hR2uYI8kzAyDrlv
         M2jQUMuZ/MQ4Zv4Vc9/fPg2CflxS/2I0tcr0j7YGn3k+PJQ6R5RAZe98anEf1TKdILq0
         3AOY1Hn/U+9MCoctQlLuD3ASX71iIdo127BfqCh2tDPHz5vhlHRVLduOAl6bRrpCFXKF
         W2XT1s9bii61LFYbNyTCN/nnn+nIvHsubQm0LZeLZ4vtBA+mQCW9Vmx/EEHeiDjLuKly
         H9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727463245; x=1728068045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gINxRe+ASYqtepoVoa4Hly4r/EQvvxkKq3TYC82Kds0=;
        b=tmN4rjkElAs0WjGyGnC4nERNfEZuV2+JPJ5qWzPMn9XYM1GTpCIn30QjQ2l2OTJ7kZ
         lYntEh5mHGSY7m0L6HHXi0ZHCc8giig2uGiKvMY1bA9q63aEZewtjYESUIt+mxP7+erh
         v0IcRsZWX865dsSOVLV+Vgk76LBb+FrNgdKqhMQ1Oas+CCMwXogADfYgHL6AS0QGTP0I
         As3Nt/XMYcE+bZM8K4nLzBpDfACQ9K7VrSFXbF8vdCq1/gBea82ScB3qsumvKw5nMieP
         dHcaWf2ZBzHrwzzi8svSjAz9ZO4lkrXKWeUsbAPp7LLnZ3lSncg7T0/5reNbErgJ0Per
         oybQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNWZnbKPFwLfmlpUiRqTV0BIvGfhIq3QI9UKOUfbKjYWOVro8kU8TaITuwkCi1SL+zSvurrVWIKZ4eMco=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEfpfSmtRwa/aC4B4JlRe6Tw8zSemIr/DKE8gRhblcxSktDe9s
	IjlkvAcEBOQiCPb0ENXzGstDBTsEGk6/NlnOXdIcG+lIHGaSext8
X-Google-Smtp-Source: AGHT+IGPftOepGRLoDTnihg6bcpLgsR5r3KDRKKWvBIB5J4B4iX6OcAQNwhbRzPhxLJMXNogQEkqpg==
X-Received: by 2002:a05:6402:1d4e:b0:5c7:20f9:f744 with SMTP id 4fb4d7f45d1cf-5c8824ea530mr3446185a12.15.1727463244292;
        Fri, 27 Sep 2024 11:54:04 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a311:80b0:1c80:9433:9060:39fc:2954])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c882405d39sm1434704a12.18.2024.09.27.11.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 11:54:03 -0700 (PDT)
From: Maya Matuszczyk <maccraft123mc@gmail.com>
To: Maya Matuszczyk <maccraft123mc@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: platform: Add bindings for Lenovo Yoga Slim 7x EC
Date: Fri, 27 Sep 2024 20:53:40 +0200
Message-ID: <20240927185345.3680-1-maccraft123mc@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds devicetree binding documentation for Lenovo Yoga Slim 7x
EC driver.

Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
---
 .../platform/lenovo,yoga-slim7x-ec.yaml       | 50 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/platform/lenovo,yoga-slim7x-ec.yaml

diff --git a/Documentation/devicetree/bindings/platform/lenovo,yoga-slim7x-ec.yaml b/Documentation/devicetree/bindings/platform/lenovo,yoga-slim7x-ec.yaml
new file mode 100644
index 000000000000..32f8a0b5d667
--- /dev/null
+++ b/Documentation/devicetree/bindings/platform/lenovo,yoga-slim7x-ec.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/platform/lenovo,yoga-slim7x-ec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Lenovo Yoga Slim 7x Embedded Controller.
+
+maintainers:
+  - Maya Matuszczyk <maccraft123mc@gmail.com>
+
+description:
+  The Lenovo Yoga Slim 7x has an EC which handles some minor functions, like
+  power LED or some special keys on the keyboard. This bindings describes
+  how it is connected
+
+properties:
+  compatible:
+    const: lenovo,yoga-slim7x-ec
+
+  reg:
+    const: 0x76
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |+
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c5 {
+        clock-frequency = <400000>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        embedded-controller@76 {
+            compatible = "lenovo,yoga-slim7x-ec";
+            reg = <0x76>;
+
+            interrupts-extended = <&tlmm 66 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 00716c1faff6..0d4bfdde166d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12902,6 +12902,11 @@ S:	Maintained
 W:	http://legousb.sourceforge.net/
 F:	drivers/usb/misc/legousbtower.c
 
+LENOVO YOGA SLIM 7X EC DRIVER
+M:	Maya Matuszczyk <maccraft123mc@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/platform/lenovo,yoga-slim7x-ec.yaml
+
 LETSKETCH HID TABLET DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
 L:	linux-input@vger.kernel.org
-- 
2.45.2


