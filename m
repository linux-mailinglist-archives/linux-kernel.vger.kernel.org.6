Return-Path: <linux-kernel+bounces-442073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C98B9ED7A5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9604A281256
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568EF22A80E;
	Wed, 11 Dec 2024 20:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vGOGZydM"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63830229685
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 20:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950507; cv=none; b=AOhDKRfkjvEJcKVvyCLj0FdqgyMTjN0Rr6BxxtdpAR+WwukrgNyMF/kK2Roa0CaDH2l3OEX6vT7bS4FYNfZKlUXbZ98+s6QhVpIRcx7FH8iFcZpj4/JMjj/9VAJEM5NlfFn4OlkdyfSFNcS7SITSEgodDunK2VLJFeReommpcD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950507; c=relaxed/simple;
	bh=XZtUpr/DURpr/L2sxiom5IoH3+HQHJD/Z1pBX1+yTWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n2r7pa5q6fVQB/w+hBU2XRtMnG2gYUn/VPAaKd9pvbtJjvAhl3zWP1UigB6w4rPo2ybvbs/04Mv8RvQ1XjMAtF9dgBaFw+TikUZTQ73MDamVR3SNA8vF/pTpCv7kgXBVdJX3Ed3JdIHhNKI/fa61p2dLfqp7IugB3XuXbsu6LUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vGOGZydM; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-71deb2025dbso2056388a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 12:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733950504; x=1734555304; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=13F43V2/MzfKP/yJr1bHKQJVOtOvlPMBJZi2ZlwKDuQ=;
        b=vGOGZydMCNfWxJrh8sQYPijQUA/BVCydSJEHPPf91FdMphh3RMy/1pgyMAXExced/C
         tD0v8mRN0qfVC4Oqze3oxzGRxkOI1TduHHRRqaNBZ3W8gh1T8rf3vsjzLybElXAVeAUs
         OyFt2yl6m/Rjq41scRBiRr9vcdx9WAWExybCAGsMDDfqgfXKKFP+GW5jHJPNhjzdNnk3
         FUTaUdraYP0FJ5UmIvzi96I6zM2cHVG8z6WbV4MGIxJbbHn3FIyzO0DHEc6+XlrMBE8+
         OuM5hoUk0xDkC+qNpyJQ9oWuL4DcpW3dsLWtgdefXXJXi13IoOdv83IWKdkKKjhfxuxP
         f+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733950504; x=1734555304;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13F43V2/MzfKP/yJr1bHKQJVOtOvlPMBJZi2ZlwKDuQ=;
        b=dqyPe5xaoefZr9ZdupLs8prX6z5RRfNSMouB4OpACioU8Lx7sT7pMFc8PDdjfLQEDQ
         jhazMbGMFAC/p8IgQZUwnbq9KjzCiGGPTyTp+6HVVyPXaGcR6V9z4C1XYjK8OlU8PSqZ
         9AAPutVMkCviytpwZMKsOHF++NlVBRMJodp3ds29gDtoiV8rr2fymcwJ7OnIM1+DwPt/
         9Fghc++eLX1oWhNm1qMcoXmpI98tgiwa66nAVjiKQrt8zOvSfIklWrr13Khjsd7gzr8l
         bxyZvQ7Er01vseZ+4XPhctyhdT9qB7G5CUCg8YuWGehKgZxLpputIcUZTZrf4j9Xfi9f
         ql+g==
X-Forwarded-Encrypted: i=1; AJvYcCVwlvGW7RJnbE1yGMzkfoUOml9J8icbyPto62hmxHcWgaSVBFZNq7gNwlTzXKx+fpVJMz3itv7gTgJbh5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDhYIq8s9f/1LDrReEGF0gTYc/s0rJgJxuWAqGVxJDxpON7O6w
	QqQFuAmCAs1pUm8QOVJL6ZjR0aKlHoIdMyrPpRjUV8ge/GBGGcxqhYoDH6c6ROY=
X-Gm-Gg: ASbGncsRE3IvlDq8Vv2/oukCk0ao1Pi5l2zvfRrdyXoKfCB3q1W1CDDSYkPueCXZh4o
	0UKArFl7mDaKZhfRkTzGWI1Oam9R1XFLNX0ZPnLwnFPzGvgLukfn5iZns2QBYX2ArTkAHfuhmL1
	PBjJpFFH3nqOFTgkyR6ARM0xjUnmqnQq9DNnRso91XQBZkC94plWIpqsvKg1/TUEShNNvHyP3lY
	ZO/y3+mWfLrF07PJOMixoG5LKLS62f9Eo9Sn2zz5fWLY7xdPuZxnc58+W5vLsf9AdWx6QUNTbn2
	xdNcABOaiw==
X-Google-Smtp-Source: AGHT+IFj7c/njNJ9PwxP0C3GEgabzaeOT+72JrS8RcScb/tiWJFWNji25E8s/KzbYVZsbfcjXdh7VQ==
X-Received: by 2002:a05:6830:6e87:b0:71e:1ca5:fc90 with SMTP id 46e09a7af769-71e29c5d7dcmr541603a34.26.1733950499810;
        Wed, 11 Dec 2024 12:54:59 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71def651fb2sm1888288a34.27.2024.12.11.12.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 12:54:59 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Dec 2024 14:54:40 -0600
Subject: [PATCH v6 03/17] dt-bindings: trigger-source: add generic PWM
 trigger source
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-dlech-mainline-spi-engine-offload-2-v6-3-88ee574d5d03@baylibre.com>
References: <20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
In-Reply-To: <20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Add a new binding for using a PWM signal as a trigger source.

The idea here is similar to e.g. "pwm-clock" to allow a trigger source
consumer to use a PWM provider as a trigger source.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v6 changes:
* Moved file from bindings/spi/ to bindings/trigger-source/
* Updated description to not mention SPI
* Dropped $ref: /schemas/spi/trigger-source.yaml#
* Swapped order in name to be consistent with "pwm-clock"

v5 changes:
* Add MAINTAINERS entry

v4 changes: new patch in v4
---
 .../bindings/trigger-source/pwm-trigger.yaml       | 37 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 +++
 2 files changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/trigger-source/pwm-trigger.yaml b/Documentation/devicetree/bindings/trigger-source/pwm-trigger.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..1eac20031dc3cf921aafb8aa37f4e4eca1075835
--- /dev/null
+++ b/Documentation/devicetree/bindings/trigger-source/pwm-trigger.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/trigger-source/pwm-trigger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic trigger source using PWM
+
+description: Remaps a PWM channel as a trigger source.
+
+maintainers:
+  - David Lechner <dlechner@baylibre.com>
+
+properties:
+  compatible:
+    const: pwm-trigger
+
+  '#trigger-source-cells':
+    const: 0
+
+  pwms:
+    maxItems: 1
+
+required:
+  - compatible
+  - '#trigger-source-cells'
+  - pwms
+
+additionalProperties: false
+
+examples:
+  - |
+    trigger {
+        compatible = "pwm-trigger";
+        #trigger-source-cells = <0>;
+        pwms = <&pwm 0 1000000 0>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 9284a257607a740ab7f6fd960c2bcdc34ead7586..b2aa6f37743e48353c60e5973ea8126590c7f6d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23879,6 +23879,11 @@ W:	https://github.com/srcres258/linux-doc
 T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
 F:	Documentation/translations/zh_TW/
 
+TRIGGER SOURCE - PWM
+M:	David Lechner <dlechner@baylibre.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/trigger-source/pwm-trigger.yaml
+
 TRUSTED SECURITY MODULE (TSM) ATTESTATION REPORTS
 M:	Dan Williams <dan.j.williams@intel.com>
 L:	linux-coco@lists.linux.dev

-- 
2.43.0


