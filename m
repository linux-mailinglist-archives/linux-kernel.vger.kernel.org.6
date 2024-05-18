Return-Path: <linux-kernel+bounces-182960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 695978C9242
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 22:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8C98B21417
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 20:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27B369D31;
	Sat, 18 May 2024 20:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t6pwTSCt"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57629DDDA
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 20:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716064768; cv=none; b=Nsdrei1KeewWVvOKv1JOnV66Rbu0rwakpnGTSQDqhE7cmlPFZUM0Ym/yE/uNEFoo0dp5ModXhtT9uzwQ71TMw2sPTzego1SdEC+9kFghZYmJBYaFcIm/I6+oYDRZNFmih+VQ5bV2V1u18LW9BhFod5UyqjQ60mt87shmjCfS5AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716064768; c=relaxed/simple;
	bh=XcMhQfN7Am8zKPX5i+5RIQbwFF3FyxQ9Q8yVI5QcFss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uUToYiMl4UWB22CDdol1E65V8qMFHa4iV55N9U/sAxC6fz3HOdJ79prlTDoP0Op7yVvBPbQ3JcIIyk8N2v4kjppvexP0sVomfjeR5ZvUQ1VDcm1M6n0H+QBZiF8RVtstVQC/cTaT8m2wujswZ1PfZvSaNPQgcWoZOzq9Mvbcb7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t6pwTSCt; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-574bf7ab218so6461054a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 13:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716064766; x=1716669566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vra2zeL7tZNPCyev4soGTccFuRymfpD1WOFRkTQfoJU=;
        b=t6pwTSCtICbiMwkg5XYPWMehI6XWlTAYlhbyr0xpHrwu+2r7AnObyIbt7gakYLV8iA
         MB4iQm6piRr8aLPdhE06d0r8VMTTAdhlXio1zhv5tJ0Fgze6JjBEbua/jEmKboXQpbiB
         dSiyMEttujX/epfiG4rUi3lf39n1qLKs9I6HSD1Yw9oGH2RRpd70yMUFeDhe3SQx8Khv
         Q/CQCgHBG3okELIULj9AYYJrQjd57ktZhNh//yjs0osSUGRTNc0pFOTaaz70H6X3SjjY
         2iuht0xrVOqNvH7apbRm8+EU98GbthvJRCtwLuFfjkwyJoxbr+KPndrUsmf18uOuTF6c
         tC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716064766; x=1716669566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vra2zeL7tZNPCyev4soGTccFuRymfpD1WOFRkTQfoJU=;
        b=wEN2WJtZLIVG9WjqLi1m1guf/rPvBpFzu/4oqlCGyAw4vR9YLcJOHlcHmijLR3qpvh
         kr/DDNbcuOC8ZDywt7NH2/ZcmWy6gvCnz0CXUtw5ZiEINwlNxIWlzHL/i23ZM/VLu5Xx
         +AwX8C7GgnpE0p6Fa+LIKZ4Ol+nQWzt12sDnATwAc7fa/j66gR+jU4QOTUTJIRDiGl27
         OP/XQrrzyMcQpYTYQXqU3uM+8BGr3iy4b+/swaPmfioiUZuakTWsR9BnecvCynxJOzZp
         fTuxp+kJYzPYHHWGWTK+NHz95IVm74sJXGW52EkzC2bVVPAPJQhr/cnrLHmmGjK6sWqE
         RKQw==
X-Forwarded-Encrypted: i=1; AJvYcCW1W0WmJ+7sK3lwFTw2swFP2NfpaFIspofX3lpWYrMqvcSv+qjz8xsYpRVxkGr0rW7ILPkoKlLvl0Vd0MroFJ+TYGbT7bYjh4aDQc2j
X-Gm-Message-State: AOJu0YyYfKgVDNk9oVZI6OOhv8J5feDFRExZFQlTNSticfUf5ZqfWbhS
	FVpTrZakHTzvfusL+mjb76cYatcbFVpsXZ0FKVZs9rxToeBsLwrTvlVr0NFAmyg=
X-Google-Smtp-Source: AGHT+IHwxt3y3qbfk5PrbEW7Ji1FqvmX1SLB2RJGTBIAQusDHgQ50K6ImMA2W5PaqD7Uk3W7mRaD3A==
X-Received: by 2002:a17:906:3154:b0:a5c:d694:bb33 with SMTP id a640c23a62f3a-a5cd694c6a6mr707249666b.45.1716064765707;
        Sat, 18 May 2024 13:39:25 -0700 (PDT)
Received: from krzk-bin.. ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a90d0e919sm529625866b.85.2024.05.18.13.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 13:39:25 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 1/2] dt-bindings: arm: arm,juno-fpga-apb-regs: document FPGA syscon
Date: Sat, 18 May 2024 22:39:02 +0200
Message-ID: <20240518203903.119608-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dedicated bindings for the FPGA syscon registers on ARM Juno board,
to fully document the block and also fix dtbs_check warning:

  juno.dtb: apbregs@10000: compatible: ['syscon', 'simple-mfd'] is too short

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 .../bindings/arm/arm,juno-fpga-apb-regs.yaml  | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/arm,juno-fpga-apb-regs.yaml

diff --git a/Documentation/devicetree/bindings/arm/arm,juno-fpga-apb-regs.yaml b/Documentation/devicetree/bindings/arm/arm,juno-fpga-apb-regs.yaml
new file mode 100644
index 000000000000..97a7a6281d62
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/arm,juno-fpga-apb-regs.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/arm,juno-fpga-apb-regs.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM Juno FPGA APB Registers
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+properties:
+  compatible:
+    items:
+      - const: arm,juno-fpga-apb-regs
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  ranges: true
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+patternProperties:
+  "^led@[0-9a-f]+,[0-9a-f]$":
+    $ref: /schemas/leds/register-bit-led.yaml#
+
+required:
+  - compatible
+  - reg
+  - ranges
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    syscon@10000 {
+        compatible = "arm,juno-fpga-apb-regs", "syscon", "simple-mfd";
+        reg = <0x010000 0x1000>;
+        ranges = <0x0 0x10000 0x1000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        led@8,0 {
+            compatible = "register-bit-led";
+            reg = <0x08 0x04>;
+            offset = <0x08>;
+            mask = <0x01>;
+            label = "vexpress:0";
+            linux,default-trigger = "heartbeat";
+            default-state = "on";
+        };
+    };
-- 
2.43.0


