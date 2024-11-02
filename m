Return-Path: <linux-kernel+bounces-393589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7499BA2B2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 23:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4473728330D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 22:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6057E16A95B;
	Sat,  2 Nov 2024 22:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFIGN07o"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3788614E;
	Sat,  2 Nov 2024 22:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730585644; cv=none; b=RZVryjWL0eoOosWhl1CgnePdhKr02WuqBeFI6+dlzdEi/uoOEsEKi2LKE+9xlsK+j2uvS2mtmzMjGos/fP/WeIDLyPPsiN5pZhYlUO69J5nVmuNd1ZXeJSn9odAZD7Z7eY3+67A9f70riidRudOI82sQMqtcHsLAdPpRF2paKiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730585644; c=relaxed/simple;
	bh=mlUVrQ1U40ngpvkR1t/agvqrc2Ypun4aKBnfp+29WvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tlHha4uvhYnyKoqMgy05w3R8lYIUNQKUIoDB2aNxXYeOdifX7fyPjjMfHRkH+4Tgy/iuEpev/YsILJeNyU79sXrOJF6Zh5JAnzhaUu/o26f48YJnAP1mMeW4K+zpPeV6XBYQjw9pSyaJZbTflV+U67L4O3H82llpgJmcxn/eL1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFIGN07o; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5ced377447bso245074a12.1;
        Sat, 02 Nov 2024 15:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730585641; x=1731190441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JgUk68zKUc9DMtHCUrZZMvVfkaumU7vHV+v/hTbVrO4=;
        b=fFIGN07oaO2Mr/9Xkpq/GBqCAecQmNo43/SA0pYcEexSKlReGWkAXIq1du3MYQbqaH
         LerKEUqHSk/5UpHWTYzh1iOphXShH8ObCD9NmV8aMICExVDAFa1peClNRCL9QphqmASy
         ALl4b1+bLd7DGqDnYfVRCHGATdyQk32hV1JRp9D4bmzLKiXUSvNPjQZxR3JEoy+Wy6H7
         C2C0gG3KdFJ1J3otfhNYKSp6yCfdCZRim0wDUbFWWbOgC73YDMzw+eaJTt4J8I1rNVhU
         NkhPQSIUFfOimbCbinX+6zJlHLHPqfUCnGAQsVyixZkJm41cXE1tOCLMgHxENgkm9sva
         aqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730585641; x=1731190441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JgUk68zKUc9DMtHCUrZZMvVfkaumU7vHV+v/hTbVrO4=;
        b=Lr9AobYammbu9QF9IbeMAc2hmcZ1q/8/qLs/yOO+4jA/Wkw19TPi/SZ9Qtqwe1mgNm
         OQIfhLOuDfC3wMQOGFLSsBpQ4BP/EQIA73amXoY+RS8z7BWzTSCrRFK5Zv9nNFye02+b
         p+S/MAyYfLAgjvAZ815bZvuEXUJ34bERiE0PAECO+z2QxFnGgOf2CgDdXF3+GfCVl9fd
         iszPVbiv1KfsLLnHKmlWQSC+WV/a/Z4HU28zWFA/wgXT7jAKzJ0G62DTlyyN72ThtfE8
         zDue9Ke0cOtqBXecE3yx9WzyFVxMbkQdoionZWO7DgyydLc2FfNA7tgq7iyTs0R1FL8v
         kFAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmL++5aeYQZ3b+heWTfdjzbMcUExp9kisI4KMZuEecGygUFQoE4WVyayLlv2zfmqnwdRwwici8zT43@vger.kernel.org, AJvYcCXVLTOiUZ60tslNyHC1m7WX9mTggvpqR1u3YfopaXOH7FdMvJH5S0kfHl0Cs9KHEnw4jxRYBwPZ3PLPm9VB@vger.kernel.org
X-Gm-Message-State: AOJu0YwUJWRHiE9iYU12oYDy1ss+jhMG34d7JigPSHVmAIAE65Ua704T
	T/1/3ukyUDgt6/CIKy++hzOYhpeOwSDv0thpAUyoriFdbtvhLmtv
X-Google-Smtp-Source: AGHT+IEOBLX2j2HWuv+pdDU0ZxYrPZnIuxih08kkbFQFADGWXklj0YmOwIp0s2aG0SM4rtdzkYs0fA==
X-Received: by 2002:a05:6402:5242:b0:5c8:8bde:a1d3 with SMTP id 4fb4d7f45d1cf-5cd54af0e79mr10242172a12.22.1730585640884;
        Sat, 02 Nov 2024 15:14:00 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac74ccfdsm2824475a12.11.2024.11.02.15.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 15:14:00 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-actions@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] dt-bindings: timer: actions,owl-timer: convert to YAML
Date: Sun,  3 Nov 2024 00:13:04 +0200
Message-ID: <20241102221354.2856900-1-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert the Actions Semi Owl timer bindings to DT schema.

Changes during conversion:
 - Rename file to match compatible
 - Add a description
 - Make "clocks" a required property, since the driver searches for it
 - Correct the given example according to owl-s500.dtsi

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 .../bindings/timer/actions,owl-timer.txt      | 21 ------
 .../bindings/timer/actions,owl-timer.yaml     | 71 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 72 insertions(+), 22 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/actions,owl-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/actions,owl-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/actions,owl-timer.txt b/Documentation/devicetree/bindings/timer/actions,owl-timer.txt
deleted file mode 100644
index 977054f87..000000000
--- a/Documentation/devicetree/bindings/timer/actions,owl-timer.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-Actions Semi Owl Timer
-
-Required properties:
-- compatible      :  "actions,s500-timer" for S500
-                     "actions,s700-timer" for S700
-                     "actions,s900-timer" for S900
-- reg             :  Offset and length of the register set for the device.
-- interrupts      :  Should contain the interrupts.
-- interrupt-names :  Valid names are: "2hz0", "2hz1",
-                                      "timer0", "timer1", "timer2", "timer3"
-                     See ../resource-names.txt
-
-Example:
-
-		timer@b0168000 {
-			compatible = "actions,s500-timer";
-			reg = <0xb0168000 0x100>;
-			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
-			             <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "timer0", "timer1";
-		};
diff --git a/Documentation/devicetree/bindings/timer/actions,owl-timer.yaml b/Documentation/devicetree/bindings/timer/actions,owl-timer.yaml
new file mode 100644
index 000000000..ed50b4753
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/actions,owl-timer.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/actions,owl-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Actions Semi Owl timer
+
+maintainers:
+  - Andreas Färber <afaerber@suse.de>
+
+description: |
+  Actions Semi Owl SoCs provide 32bit and 2Hz timers.
+  The 32bit timers support dynamic irq, as well as one-shot mode.
+
+properties:
+  compatible:
+    enum:
+      - actions,s500-timer
+      - actions,s700-timer
+      - actions,s900-timer
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 6
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 6
+    items:
+      enum:
+        - 2hz0
+        - 2hz1
+        - timer0
+        - timer1
+        - timer2
+        - timer3
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - clocks
+  - interrupts
+  - interrupt-names
+  - reg
+
+additionalProperties: false
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    soc {
+      #address-cells = <1>;
+      #size-cells = <1>;
+      timer@b0168000 {
+        compatible = "actions,s500-timer";
+        reg = <0xb0168000 0x100>;
+        clocks = <&hosc>;
+        interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "2hz0", "2hz1", "timer0", "timer1";
+      };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 5f34d168b..76ea65128 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2024,7 +2024,7 @@ F:	Documentation/devicetree/bindings/mmc/owl-mmc.yaml
 F:	Documentation/devicetree/bindings/net/actions,owl-emac.yaml
 F:	Documentation/devicetree/bindings/pinctrl/actions,*
 F:	Documentation/devicetree/bindings/power/actions,owl-sps.txt
-F:	Documentation/devicetree/bindings/timer/actions,owl-timer.txt
+F:	Documentation/devicetree/bindings/timer/actions,owl-timer.yaml
 F:	arch/arm/boot/dts/actions/
 F:	arch/arm/mach-actions/
 F:	arch/arm64/boot/dts/actions/
-- 
2.43.0


