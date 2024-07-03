Return-Path: <linux-kernel+bounces-239423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E61BE926055
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA6DAB2EF92
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A51173328;
	Wed,  3 Jul 2024 12:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTBDNWGq"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF3F142904;
	Wed,  3 Jul 2024 12:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720008172; cv=none; b=h3epuh/X+6Ke/amD89mp8+GyV6HNSjfAsVWE0PDrZeEHl4bU021pD9fVmqWiPMkNL+fcTxXIvFd7DH6Oby+kKBpPdtK7ob2/uE8Va7KY1YmH8VjvosMXZaePQJRKRikchbBKjdUP3pZE6VcwI+/oZ695UAhXlmw5MHGOO6S9Qqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720008172; c=relaxed/simple;
	bh=wbp3WxxKIZhpmswTUsyAwmPrBB5XKkn66nqq+Oj6lRM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JeVMBIKdP3ACibZcZOEkzYcGBbTus7e0y5UwlsztkgfsJttOdrmgwrgiEytLfuNecEP4JJyaYw4/uGkgr2jwHMuiK/hhH4KdsekZFglkd8A58SBw/4Bn20w/Cjo1AWybdTnF/E9SpuFO+0be0m71A9jdGcK3UT54+wu8esh7MF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTBDNWGq; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42579b60af1so30929615e9.2;
        Wed, 03 Jul 2024 05:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720008169; x=1720612969; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lHjbPIsTssPtEI+wx/kexPsqSteEWIwv7X4Mb6vwKlE=;
        b=eTBDNWGqL3wOElG2GypU8drMhrccoejs2Wc13BB76tx0VltJZcGhidlbgSPM4vbl8i
         +q5B29FgqbxOrklLHzF4A63WoZl8UdmHG5sIRvy8SRfrpl2b6TSfExl0etUEoNjUKs0t
         ZZI1KtOIIsbLKKdG2OnNE7HN6mCBNg/CCp2ddbLdoVgul0ASSvUkAG/xI6SziNOEVlNN
         Uv1fs/3oogWduvtOfbtm4D/bMQD4TXVAYdhgNjP3UBHeD5qlMgDAVj7yXkyqvkMVnxn4
         RFRka9xVFiayeJXFUVCptUBUomN/uCJ9VmreiSmg7HettOgIsZoYgqj/LUzgPNv3W3Kd
         Cj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720008169; x=1720612969;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lHjbPIsTssPtEI+wx/kexPsqSteEWIwv7X4Mb6vwKlE=;
        b=tmsNb1rqDBmU1jnh08KjD0uMvRkOAJOsyUB6QJ8E0WUWeNwJ3CwbvIHcMyWkr648pm
         8tx7o1iO0XB0wYLSCGx3J3F1VJ+zUyl0ryTUc/HvyyeuGSj2KwTTvyTyfSsITHRS2Es8
         bzqFhTgwnZ+RRiqwwRhjlnV2MQJaJqrQ48OcSgh9aLwDizQCBvRTDzLU848VYFOBzz0w
         FN+7wo4g7pjh75zHjk5AXJnL6RRiW0ONr6dnK3+JVwEYJGYpk4rSUyEMthROzHXAjngc
         X/FuW2Z/1ZwTQwH7qocZy0PERPzHzVwxHmw31cRj0Q8JNSdo3pR1HgVIOYtQauVQzHNW
         Ao9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEVBXecbUl1TZwLzQgmJusPINuL+T8EYscKYIhf2UFQFmCWbq8wn+sTSkqBnYa52d5mJE7oAN6yitJpHd+beY2f2k8bAa/doIuuw==
X-Gm-Message-State: AOJu0YwjLvA1+TMikvoFvHzJG+dR4L+KmgVoYliJ3bLvIElNSgefSRFl
	Kf060Cs9hR3jRsUqoECLfi2qCSkFtNgZhPi/aVa+oyyrr9rMh/hq
X-Google-Smtp-Source: AGHT+IGsosvirTGJ/8ctAZiH25yTViMcfCBtbiveJvRTABfbUmQO0QA6b4COqpDoAchCbDMJxsxSKQ==
X-Received: by 2002:a05:600c:1c88:b0:424:aa64:e9af with SMTP id 5b1f17b1804b1-4257a05c0c4mr77165875e9.32.1720008168844;
        Wed, 03 Jul 2024 05:02:48 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4257880104csm74819155e9.1.2024.07.03.05.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 05:02:48 -0700 (PDT)
Date: Wed, 3 Jul 2024 14:02:46 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baolin Wang <baolin.wang7@gmail.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: timer: sprd-timer: convert to YAML
Message-ID: <ZoU95lBgoyF/8Md3@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Convert the Spreadtrum SC9860 timer bindings to DT schema.

Changes during conversion:
  - rename file to match compatible
  - add sprd,sc9860-suspend-timer which was previously undocumented
  - minor grammar fix in description

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 .../bindings/timer/sprd,sc9860-timer.yaml     | 68 +++++++++++++++++++
 .../bindings/timer/spreadtrum,sprd-timer.txt  | 20 ------
 2 files changed, 68 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/sprd,sc9860-timer.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/spreadtrum,sprd-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/sprd,sc9860-timer.yaml b/Documentation/devicetree/bindings/timer/sprd,sc9860-timer.yaml
new file mode 100644
index 000000000000..62c6da8bab5a
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/sprd,sc9860-timer.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/sprd,sc9860-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Spreadtrum SC9860 timer
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+description:
+  The Spreadtrum SC9860 platform provides 3 general-purpose timers.
+  These timers can support 32bit or 64bit counter, as well as supporting
+  period mode or one-shot mode, and they can be a wakeup source
+  during deep sleep.
+
+properties:
+  compatible:
+    enum:
+      - sprd,sc9860-timer
+      - sprd,sc9860-suspend-timer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: sprd,sc9860-timer
+    then:
+      required:
+        - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      timer@40050000 {
+        compatible = "sprd,sc9860-timer";
+        reg = <0 0x40050000 0 0x20>;
+        interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&ext_32k>;
+      };
+    };
+...
diff --git a/Documentation/devicetree/bindings/timer/spreadtrum,sprd-timer.txt b/Documentation/devicetree/bindings/timer/spreadtrum,sprd-timer.txt
deleted file mode 100644
index 6d97e7d0f6e8..000000000000
--- a/Documentation/devicetree/bindings/timer/spreadtrum,sprd-timer.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-Spreadtrum timers
-
-The Spreadtrum SC9860 platform provides 3 general-purpose timers.
-These timers can support 32bit or 64bit counter, as well as supporting
-period mode or one-shot mode, and they are can be wakeup source
-during deep sleep.
-
-Required properties:
-- compatible: should be "sprd,sc9860-timer" for SC9860 platform.
-- reg: The register address of the timer device.
-- interrupts: Should contain the interrupt for the timer device.
-- clocks: The phandle to the source clock (usually a 32.768 KHz fixed clock).
-
-Example:
-	timer@40050000 {
-		compatible = "sprd,sc9860-timer";
-		reg = <0 0x40050000 0 0x20>;
-		interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&ext_32k>;
-	};
-- 
2.34.1


