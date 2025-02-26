Return-Path: <linux-kernel+bounces-534559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 816F9A46879
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CEF81886EED
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926FC22A807;
	Wed, 26 Feb 2025 17:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ffGik0Uy"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0B722A4C2
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740592289; cv=none; b=A7LCrygxI7RMCxzimkpbvXK5vliVjpSwgZ7bV7XDBddv0sHFf2Mw9Nx5MESzEwjVOcOwfyLIh/dJuucZrMsh9bUleN0w8iSneNglnAmhppogiIRmrU9L8bvOfcrRrJYaZbLrTF/cQEGXTJQHI+55Nmsj1LY0DUWsW96vexwJ5sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740592289; c=relaxed/simple;
	bh=Wrk3Tbjy48DhMXMrJ6FsxsEEZWO2wkyYnH7V/hmHbpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WKm0jDZXwsIYJbSU2bXVvPKB7ivRx3Gqu0RINr0KvPz2dNOJXBjvf2+/yF3mxah0TN6TcaVwP1xVN2pFrVhCWT+MeZfZpTJVJbPqJNIfvOjUKOM30SATL/puQmqSNt3EPPRQ+aPoLib2I/BBKp/Lc78rnko+aIMohG+cbUrkr0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ffGik0Uy; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abb81285d33so7104666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 09:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740592285; x=1741197085; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JO1yRDgm5kl/hQVQWW5vYh5O5OnfQpLxrGfUp86iA18=;
        b=ffGik0UyZ4H1FZtySsggiTuIg8yRHhj0ec76bakiPDSk2i6s/i+HTahRaoxvkpm7za
         UWZbNHMlbD21o1ixSWUfMfNn7Qm4nt9rOPXJzd1X7nq7qTaZK+EAlZ3k6WYReYuRXMfR
         3dgep0O5GTTLVZ8Qa1Elgl3a56HyF5jrQqPUWhucWAUtsBhe0QJ0YoWvqH1tVoQKingp
         ojZFyajXjNW15pmdgKDEaIDOizj5GvfgiKdMJgebTYBdwyyxygkneNpbye0ZtFTVck9x
         0H18AUMcC2amR1kFm39vXJninBn0yL4bQD4ZyQ6P2K0IKRmiB+meEv8etMxszHkdBO3C
         s8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740592285; x=1741197085;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JO1yRDgm5kl/hQVQWW5vYh5O5OnfQpLxrGfUp86iA18=;
        b=kdxjDGF1sNBgO03M4infGHjkgEv+vWDu36FCiX+uLFsD/hGClG6IfqTAlC0fvZdnUr
         1ONzzuD+2WYpMyREr68WcKrLVCej+PXpmzOSKB/cDucXSkjoUR7EkSf6pfqkxC1ZZV7N
         rYw46ngCO2X/5ds5/T2IL0uwS50eHTX26zsRUJAVMHk4XaDDvhoT7T84Uk7JhdtzIzJu
         6rlpFoGAwcdoIz4pmdyqMd8kyVvfu4hiXBcSc89YM4TbHm/9sqgyyJelzYt/MVx0kBS/
         Ref+BwG0L1ABRK+h5YCsCh4C7DTIwdb1yAnarrgEim9K0JtckZm/brTsfzsvZATjpsvk
         wuKA==
X-Forwarded-Encrypted: i=1; AJvYcCXqGVKnMM47RGFl7lUR0lCuqNOaVuwcl8n12n9Vn3AEjDYix+V3PGJZT6ovWPDwK4pSE36az/HFLkqz7W4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE6r/BSSjEcFpew1YjFj3Mc64rjE9xjOEEgYJxa1GZqtRmzw31
	6p1vBpWFPyZ8IEvsh7pKrfWnZ2RcuqD8XbUpcafozTxBGkrjXUQNr2/RfS7V5T4=
X-Gm-Gg: ASbGnctr2j30XlRKgCY6Z4iSZebIcvELgSkE/LM+1vLeqljC1h7rHScJvRLoubUhDI9
	DbpGJ3SisTRyUTZxq2mlkwEvPk0+rFbxdEsIrQEcW3zcIJpiKTzFBSEtJEk8GeLFSFYDWu3O8tc
	YDmRkOS0cyzc3OMO8EC066MaLHul13bdVcUgZmPgazWG452fdrKkBiw7ATFs7FpYnnxyXUd+wg7
	QZpBkDm50GBMZauP+mbUDlET8rmGLqNiTBqTWwLHQf5Pnr/o/K5Axlg2mCEAKQZYFQg9HrNeyik
	3jpbTFfME5IwlmSXW/5GBrgNiEcHvEao3370tlDePv2PMQtEC4hgFKL1FgKMvW9CxQpRwWSoWes
	AN1IN9DQvew==
X-Google-Smtp-Source: AGHT+IFmKSPF6nqqiaetA3heVfq299jPwpErUmra97HCWFZu+Y10xqFwRt4yZaOIXY+ZiDT6DcAWfQ==
X-Received: by 2002:a17:907:728a:b0:aba:608d:4a22 with SMTP id a640c23a62f3a-abc09a09707mr2420013566b.21.1740592285488;
        Wed, 26 Feb 2025 09:51:25 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1cdb131sm361889866b.7.2025.02.26.09.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 09:51:25 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 26 Feb 2025 17:51:22 +0000
Subject: [PATCH v2 3/6] dt-bindings: mfd: add max77759 binding
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250226-max77759-mfd-v2-3-a65ebe2bc0a9@linaro.org>
References: <20250226-max77759-mfd-v2-0-a65ebe2bc0a9@linaro.org>
In-Reply-To: <20250226-max77759-mfd-v2-0-a65ebe2bc0a9@linaro.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-hardening@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

The Maxim MAX77759 is a companion PMIC for USB Type-C applications and
includes Battery Charger, Fuel Gauge, temperature sensors, USB Type-C
Port Controller (TCPC), NVMEM, and a GPIO expander.

This describes the top-level device.

Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
v2:
* rename expected nvmem subdev nodename to 'nvmem-0'
  I'd have preferred just 'nvmem', but that matches nvmem-consumer.yaml
  and fails validation.

Note: MAINTAINERS doesn't need updating, the binding update for the
first leaf device (gpio) adds a wildcard matching all max77759 bindings
---
 .../devicetree/bindings/mfd/maxim,max77759.yaml    | 104 +++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77759.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77759.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..87e3737896a289998a18b67932dbccacfb8e3150
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/maxim,max77759.yaml
@@ -0,0 +1,104 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/maxim,max77759.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim Integrated MAX77759 PMIC for USB Type-C applications
+
+maintainers:
+  - André Draszik <andre.draszik@linaro.org>
+
+description: |
+  This is a part of device tree bindings for the MAX77759 companion Power
+  Management IC for USB Type-C applications.
+
+  The MAX77759 includes Battery Charger, Fuel Gauge, temperature sensors, USB
+  Type-C Port Controller (TCPC), NVMEM, and a GPIO expander.
+
+properties:
+  compatible:
+    const: maxim,max77759
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+  gpio:
+    $ref: /schemas/gpio/maxim,max77759-gpio.yaml
+
+  reg:
+    maxItems: 1
+
+  nvmem-0:
+    $ref: /schemas/nvmem/maxim,max77759-nvmem.yaml
+
+required:
+  - compatible
+  - interrupts
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@66 {
+            compatible = "maxim,max77759";
+            reg = <0x66>;
+            interrupts-extended = <&gpa8 3 IRQ_TYPE_LEVEL_LOW>;
+
+            interrupt-controller;
+            #interrupt-cells = <2>;
+
+            gpio {
+                compatible = "maxim,max77759-gpio";
+
+                gpio-controller;
+                #gpio-cells = <2>;
+
+                interrupt-controller;
+                #interrupt-cells = <2>;
+            };
+
+            nvmem-0 {
+                compatible = "maxim,max77759-nvmem";
+
+                nvmem-layout {
+                    compatible = "fixed-layout";
+                    #address-cells = <1>;
+                    #size-cells = <1>;
+
+                    reboot-mode@0 {
+                        reg = <0x0 0x4>;
+                    };
+
+                    boot-reason@4 {
+                        reg = <0x4 0x4>;
+                    };
+
+                    shutdown-user-flag@8 {
+                        reg = <0x8 0x1>;
+                    };
+
+                    rsoc@10 {
+                        reg = <0xa 0x2>;
+                    };
+                };
+            };
+        };
+    };

-- 
2.48.1.658.g4767266eb4-goog


