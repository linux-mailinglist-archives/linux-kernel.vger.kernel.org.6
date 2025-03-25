Return-Path: <linux-kernel+bounces-574873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB593A6EAFB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D74B18921DD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A900253B4B;
	Tue, 25 Mar 2025 08:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HV+J+HdP"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC66F78F36
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 08:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742889773; cv=none; b=M0bxgC+1YO5usfDBpsDFZoIQgBY56ksibY8SvDGk0PSVNCE3KDnVXSNyhKnB8X0OwPt79lGcZ8varwnbwZ+Y/TuTnWjQVVV7dDMKeZ5XkMhteIINFg5ItMyH/gs1p/Ulk5UQlBp+w5lqrZ5jR5BM5BNqvrhOx6QD2ZKg7PKza7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742889773; c=relaxed/simple;
	bh=08g+dfR3FV6Y6Q1D84qQqREWDz+FcRKr/yg3IyPY/+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sqVn7RGqc6S8wCctZggqx0Krsh1nWwlrLgilxwjZ//brfJ7iloYlHuvFjjcm4U4oMeR+2txXa7mAIhRttohAQcn/7JeAYWkSV8eRXzVjKOPGNgOwafNxkdZzm4OkUkSxb+ihxMIB8oCC4ZKYjz8Y/TypSE6//jL3HI4P1Y5MeEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HV+J+HdP; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5ed1ac116e3so430127a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 01:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742889770; x=1743494570; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6SEwl1TCy2+vIo8t3ZzKiS9UVWKw2bXaNUc9+NWEYzs=;
        b=HV+J+HdP27msw87G5m+fkHOniMkh9ZpCKH/IjxLOC28XvSAFOoDtoree2wadgKBAyJ
         B94rPlGeQiAlJBLxu9fBD3qeRQoTp+wkd5Yc3edplu8r/j93uUhnC3jBB1d2iqX6KFci
         probPHRQNheao6s0m4bdr48m4dqvNNGpqRoqODB4dj277EjBTH+cHqFh7SztkVqKynhc
         ZKdWa7xjikUKB+HilUrY/x61J3CidCzyKCepGSWvG7+URmgn8Ar1LSpameJtPsDJ9mhb
         je/amYFDcyVxn99h0FpRFHt1vYpSHhTBUd569obOj1gZJIP4LsNG2y3oecE0lqSRsn6c
         ZmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742889770; x=1743494570;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6SEwl1TCy2+vIo8t3ZzKiS9UVWKw2bXaNUc9+NWEYzs=;
        b=RJUml9hGo94hPrwdK+8rgX5rg2NOIHw9j8VleHduTRyGmfkj9opEHyPn2Dr7EpOko7
         Wej49Vh9dnX8JBAXpePhnjaAx56eBJ0yAdWJGIgwc/w2DwJpZpKrTgyy/t/AkT35fKnX
         zIqn71jfChRtgihVw06ClA4tV4Z1gA2D7/s7GgWtGmNMgZn6L6XgktoszRD4FNuPEIWz
         nYNNQiC27iIK6QUJoIqWzqGJUvz0Z/ji4D2Tc1iPxNX7v6Yc4gEDTQpQrdU0zzESHIiA
         R/lMs3pcjVV1+kVb10lGOu4HaVw13KRH9QYN5SsUrM8sTlfhd+YJTl+6tQBx3Q9Mpfbz
         OZcA==
X-Forwarded-Encrypted: i=1; AJvYcCWPw/3yYJgx3Tmid6e7ixIDXTHrDaWhNx26QpGUfY24LxXxINZ48N3rrRm+xpgXq38atHeWp3C1tzKhbLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFo9HM2FnGEf27A5rPCnE+wxA4dnTIvMIuu3CM2cDN/hW5h9cD
	8oreKe1C92Oc+49GP/l4h+WkncEpnQozORYEdskybvu+reoHXkaxUwzp451nIu0=
X-Gm-Gg: ASbGnctw8xKgnTc4xTVT9fJkKjuPLYGm1VbMq6tPTJy/u/MRqS0iGs3mK+bVEdKO59O
	8DiPV+2TUhl760l9YqxmJzoeiuH+p1fMtPZhf/BsM3hu78jYfisDE8vMTw1bOHBqDJFIYksixLR
	zUqNyXn+3IGkGp/ZrYRyelAcBbhK6FylMmmH0tb35qq5pMjiuCpdPgn0NVqpVCXWkDARnaX39DF
	c2bquye9Gidne/rU8IvzxmFVcP4j3FW929FHOXdKq382JQIstgpDT/KI13U68YyYtwzywKdcrPN
	bmenv7LrTfJHncXipQTXERDZU4DKPBA0V256IpCEZnPv9QkRpipBPKUdLgS4F4vv9DgfwIDymBK
	GKV1iZYpc6DXZYZ364+0fNpI84zdm
X-Google-Smtp-Source: AGHT+IEp7lof/A0OionGLJZy6jB+PNe7OTo3Z3Wv4VGDxxx3INxKX7DAQhryN3U82MCJ2ipnw8Ds/A==
X-Received: by 2002:a05:6402:3511:b0:5ed:1400:f879 with SMTP id 4fb4d7f45d1cf-5ed14011fb0mr1400324a12.32.1742889769962;
        Tue, 25 Mar 2025 01:02:49 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebccfb004fsm7446785a12.40.2025.03.25.01.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 01:02:49 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 25 Mar 2025 08:02:24 +0000
Subject: [PATCH v5 1/6] dt-bindings: gpio: add max77759 binding
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250325-max77759-mfd-v5-1-69bd6f07a77b@linaro.org>
References: <20250325-max77759-mfd-v5-0-69bd6f07a77b@linaro.org>
In-Reply-To: <20250325-max77759-mfd-v5-0-69bd6f07a77b@linaro.org>
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
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2

The Maxim MAX77759 is a companion PMIC for USB Type-C applications and
includes Battery Charger, Fuel Gauge, temperature sensors, USB Type-C
Port Controller (TCPC), NVMEM, and a GPIO expander.

This describes its GPIO module.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
v2:
* drop 'interrupts' property and sort properties alphabetically
---
 .../bindings/gpio/maxim,max77759-gpio.yaml         | 44 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 +++
 2 files changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/maxim,max77759-gpio.yaml b/Documentation/devicetree/bindings/gpio/maxim,max77759-gpio.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..55734190d5ebdbc351e1f91675dddd8a9db80cd7
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/maxim,max77759-gpio.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/maxim,max77759-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim Integrated MAX77759 GPIO
+
+maintainers:
+  - André Draszik <andre.draszik@linaro.org>
+
+description: |
+  This module is part of the MAX77759 PMIC. For additional information, see
+  Documentation/devicetree/bindings/mfd/maxim,max77759.yaml.
+
+  The MAX77759 is a PMIC integrating, amongst others, a GPIO controller
+  including interrupt support for 2 GPIO lines.
+
+properties:
+  compatible:
+    const: maxim,max77759-gpio
+
+  "#gpio-cells":
+    const: 2
+
+  gpio-controller: true
+
+  gpio-line-names:
+    minItems: 1
+    maxItems: 2
+
+  "#interrupt-cells":
+    const: 2
+
+  interrupt-controller: true
+
+required:
+  - compatible
+  - "#gpio-cells"
+  - gpio-controller
+  - "#interrupt-cells"
+  - interrupt-controller
+
+additionalProperties: false
diff --git a/MAINTAINERS b/MAINTAINERS
index cc6536141bb3a06fa6bc411ac69053b8be17e0b0..0abd85ff6fdee93424ee3634c56fbcbcea1a7855 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14568,6 +14568,12 @@ F:	Documentation/devicetree/bindings/mfd/maxim,max77714.yaml
 F:	drivers/mfd/max77714.c
 F:	include/linux/mfd/max77714.h
 
+MAXIM MAX77759 PMIC MFD DRIVER
+M:	André Draszik <andre.draszik@linaro.org>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/*/maxim,max77759*.yaml
+
 MAXIM MAX77802 PMIC REGULATOR DEVICE DRIVER
 M:	Javier Martinez Canillas <javier@dowhile0.org>
 L:	linux-kernel@vger.kernel.org

-- 
2.49.0.395.g12beb8f557-goog


