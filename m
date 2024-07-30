Return-Path: <linux-kernel+bounces-267948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46062941D37
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2701F24D74
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E231A76C1;
	Tue, 30 Jul 2024 17:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMYacAvV"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B151A76B7;
	Tue, 30 Jul 2024 17:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359659; cv=none; b=Isv6SgMyQitqpIbo3vTkMEIENwQPPVqJnxzyp4vi9IbMuCiTnXgSMWAMxzmo+/iOXyH/Oe6k+ysLwvAnjDgvVd5ZlgfjBBcDnzbq3N6iTs0Tb0nQNnY2lRyGpyL150+k6LT580/UKKtVVNTY6+TEwI9d/+iuCXU6plGOmQP8/ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359659; c=relaxed/simple;
	bh=vDbY0ciOSfu5tLicmsPlFjzyFP4CWvRIvH9fqJ0WsM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BkOMVzmPkyBnAYzSWtw3FjQ3270+oIKpvD8ONeTUb8dHL6OL9z4e/EtxZMn9TPn1or5DnN0sLYca6fOTtL7aAmCkEUgUDelwjD+gKZNAqcOGd8tiJQER8Y1tmXPOIb+3zJO8YqeUSFPoE3O9UEET8oqI2lCZUhGAJpHbg+nPbvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMYacAvV; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d399da0b5so4112219b3a.3;
        Tue, 30 Jul 2024 10:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722359657; x=1722964457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ACvUiwIp6P25KXmf/+dl3/QHIP1IaGHSY+Wmq3hoPA8=;
        b=KMYacAvVHU+iUPzRxKHgIS+ECQ9mlepZ3ahOTaHE0uljhmI0AjjOTEZsE/4IavxDc9
         MtKL3+Y3/cNr4L55nOkg/0zL0ktt+5fwwyh3zXl8uYxFU6KJJuOU7WQSAaD2awCMjT1b
         ZbpsOF0wKIHnhdF1bNLmne3mvSjGRv8AUzAVgBse+TgJ5SPW6AjJxS2FUwFMWEMilSY+
         USMNLyV8Pkxj0zIFW84v/ZB5qddKPigGLyFjlHfjOeQ+XvAt8+lzAjb01LPe3lHDjWLV
         ha/X/ID8sudNHutEiShTZ1KWQ2xdtH3c0QzqT7DmtkVPgBEXQtIYpGgjLHz4wecqYn2Q
         kgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722359657; x=1722964457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ACvUiwIp6P25KXmf/+dl3/QHIP1IaGHSY+Wmq3hoPA8=;
        b=amy6rWpcj8h06CJSFebeYipNt+58T2e1348tqKbq2oIr3WGedTZ9veuLoXJG/HoqCk
         MSR4CT23iARhtdgE8MtVqTEqCLw16BnjdKBx36ski8jYRiSxZUw/7hQoL7hJ1PT7ri16
         Z7Acq3vIjDiAXtd+3xiPyveYV75LPXluYGD6rpvfKOWJGtMFFcvVw8W9GdoyUMdnVoYk
         LSULvbz+Rw6SS/oz14Ib6LAAxZPyhYhif01xSq30Hk98V4gYscwrWhzhsNdxd/5IupAp
         awaiWIBViOlqurl9H/XntdIWLtr99UfX5EhrX9X8Jcd+0hTgDQMnIBQXXeNBPgNdMFy8
         qUkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnx/KZTIUTiQSYBxmhI8JOFjaFJqvi9pyZs6emIgkrwWCvWC3GHJOi5tqrsrSEtLqrGow04P25Xk0irzqTbDNGG3ez1Ws3hLouB0dX5EOn6W7q5fh07zSucUU4QdTAkhd0KkBGiiuZvg==
X-Gm-Message-State: AOJu0YzF2b2PHmmpFFJyFoBggA+fqacLSuWRM6oJXH6oCoq8ZgtjQv7/
	75odTS3hT+vuBDoBUyLNTe7Pozjw+jDeJ/GDP7XvVtGyG4hrPifi8gO/I7hULNYfjQ==
X-Google-Smtp-Source: AGHT+IGpH6g36qNiVIEg3w3ZrXaIg44tKgS3XSVIbxp+rTpLld1BfBMjCAyyJGXuyPvVRFYt1FTQAw==
X-Received: by 2002:a05:6a20:c799:b0:1c4:d86a:1750 with SMTP id adf61e73a8af0-1c4d86a1901mr5149940637.17.1722359657178;
        Tue, 30 Jul 2024 10:14:17 -0700 (PDT)
Received: from localhost.localdomain ([115.240.194.54])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f8753ce7sm7848795a12.41.2024.07.30.10.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 10:14:16 -0700 (PDT)
From: Animesh Agarwal <animeshagarwal28@gmail.com>
To: 
Cc: Animesh Agarwal <animeshagarwal28@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: timer: fsl,ftm-timer: Convert to dtschema
Date: Tue, 30 Jul 2024 22:43:33 +0530
Message-ID: <20240730171336.99090-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Freescale FlexTimer Module (FTM) Timer bindings to yaml.

Cc: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
---
 .../bindings/timer/fsl,ftm-timer.txt          | 31 ----------
 .../bindings/timer/fsl,ftm-timer.yaml         | 59 +++++++++++++++++++
 2 files changed, 59 insertions(+), 31 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/fsl,ftm-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt b/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
deleted file mode 100644
index aa8c40230e5e..000000000000
--- a/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-Freescale FlexTimer Module (FTM) Timer
-
-Required properties:
-
-- compatible : should be "fsl,ftm-timer"
-- reg : Specifies base physical address and size of the register sets for the
-  clock event device and clock source device.
-- interrupts : Should be the clock event device interrupt.
-- clocks : The clocks provided by the SoC to drive the timer, must contain an
-  entry for each entry in clock-names.
-- clock-names : Must include the following entries:
-  o "ftm-evt"
-  o "ftm-src"
-  o "ftm-evt-counter-en"
-  o "ftm-src-counter-en"
-- big-endian: One boolean property, the big endian mode will be in use if it is
-  present, or the little endian mode will be in use for all the device registers.
-
-Example:
-ftm: ftm@400b8000 {
-	compatible = "fsl,ftm-timer";
-	reg = <0x400b8000 0x1000 0x400b9000 0x1000>;
-	interrupts = <0 44 IRQ_TYPE_LEVEL_HIGH>;
-	clock-names = "ftm-evt", "ftm-src",
-		"ftm-evt-counter-en", "ftm-src-counter-en";
-	clocks = <&clks VF610_CLK_FTM2>,
-		<&clks VF610_CLK_FTM3>,
-		<&clks VF610_CLK_FTM2_EXT_FIX_EN>,
-		<&clks VF610_CLK_FTM3_EXT_FIX_EN>;
-	big-endian;
-};
diff --git a/Documentation/devicetree/bindings/timer/fsl,ftm-timer.yaml b/Documentation/devicetree/bindings/timer/fsl,ftm-timer.yaml
new file mode 100644
index 000000000000..0e4a8ddc3de3
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/fsl,ftm-timer.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/fsl,ftm-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale FlexTimer Module (FTM) Timer
+
+maintainers:
+  - Animesh Agarwal <animeshagarwal28@gmail.com>
+
+properties:
+  compatible:
+    const: fsl,ftm-timer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    description: The clocks provided by the SoC to drive the timer, must
+      contain an entry for each entry in clock-names.
+    minItems: 4
+    maxItems: 4
+
+  clock-names:
+    items:
+      - const: ftm-evt
+      - const: ftm-src
+      - const: ftm-evt-counter-en
+      - const: ftm-src-counter-en
+
+  big-endian: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/vf610-clock.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    ftm@400b8000 {
+        compatible = "fsl,ftm-timer";
+        reg = <0x400b8000 0x1000>;
+        interrupts = <0 44 IRQ_TYPE_LEVEL_HIGH>;
+        clock-names = "ftm-evt", "ftm-src", "ftm-evt-counter-en", "ftm-src-counter-en";
+        clocks = <&clks VF610_CLK_FTM2>, <&clks VF610_CLK_FTM3>,
+            <&clks VF610_CLK_FTM2_EXT_FIX_EN>, <&clks VF610_CLK_FTM3_EXT_FIX_EN>;
+        big-endian;
+    };
-- 
2.45.2


