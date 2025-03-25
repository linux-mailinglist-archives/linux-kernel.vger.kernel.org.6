Return-Path: <linux-kernel+bounces-574911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D33BBA6EB7D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E00E03AEC9E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28411A5BAC;
	Tue, 25 Mar 2025 08:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G6scjL9D"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5925719C56D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 08:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742891230; cv=none; b=r8c6TB7PqTFihJhQPz6bpGnMVz+nuyRgr4oFaMbDtIZaXK9ahdMRlofVSRPRrfTDJVDvtiggXJuvbhhpQw0psisJpRwSbhN+HXzYGNO287wHlgVPXfoUz5oLMx9OC1izcwVfjxquTtO9dByNn7wgY0AXql3hZ7WO7H1v+pFZYjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742891230; c=relaxed/simple;
	bh=08g+dfR3FV6Y6Q1D84qQqREWDz+FcRKr/yg3IyPY/+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OkZ+akTz3E0vXQjrn4WwiYazYPLC5f7L5CqRKQ+lBOU/03DLDBpPAdEiFtLzbrhziYYZmqTdkDoapoqD1324x8c0JZsJGmb+7t4IoxdNC2EW93pybdGHOMY6OVAAcuZzARVZs2pYiXCm5LDSZaMnzwmv/EpffWQDHI+J+OYdlM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G6scjL9D; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e5cded3e2eso7674727a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 01:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742891227; x=1743496027; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6SEwl1TCy2+vIo8t3ZzKiS9UVWKw2bXaNUc9+NWEYzs=;
        b=G6scjL9DNmE9GB1Dz/XAmVfBhitUGsomcwc2XIJd9YMuEd8E+9bLZkYFrzqucrBjXC
         hcdMQckwsLHw0ioxKx8yBbrElCVMD3o1aTb4UTYXkCBYuvWJp49lefycQQW3eCk4V2Bp
         m6J44fn3topVeBztYrJl0invvyvSOZtzJgVJeCCerJR3M/0OhrzI6RLBbC+FEoozB8nA
         v0ZwDMMOnGt2K9qmHhyEO3/YlITiDsmlGgGCAZ15epUaGyIlzFglozWrKJTlHlYt8leg
         tHHa/kh2JJ2VvtsWsntOj4vvFhmvWzSq0XhFgsxK9K6jlAYE6/5fX2VVWA484TwSQEF6
         fmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742891227; x=1743496027;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6SEwl1TCy2+vIo8t3ZzKiS9UVWKw2bXaNUc9+NWEYzs=;
        b=RPTUAnxrQgeW78yDitdJ1moHvnClsqN7hu0kcJeiBrtUWRelSxKOGzv8Ue0u8842au
         FOPyrdEZ9BZBce4AY3Mi5GayV8mjWZWjjFsgikU0/tyI8SPv1FKYfuNG/BPFssZdG2se
         NQSjV3tzGEYUURZf1z8S1SF1F/9afleIHfe5zreetybaG5N/bsxGWSF63hi6ZMzGYLQn
         ogasrjmj5kFsAhK5wEWDyUqyH0bzj7ZhDkaQGA7XPXiWifr/1SmpZWaeste9vawy8Tvp
         ZGCtXB+VeiJyxhdilLwGYDmIWzgoy2NToZ/C49pT9BwZYO5jYYhzAg1xuoH81Vg+abrV
         iEtw==
X-Forwarded-Encrypted: i=1; AJvYcCULOAW8vvorJ4RHUOThjWihhe/jjUsKy9nHSqY6cQMSLFxLysrXBKwu44/Wsowh2YxblPxK1xbdmiWn+IY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvzWMPhodq3fl811Le+tACBHDarjhuIO2/19pkIQCOAcj1agO6
	DH+BPWCEPVZpQXoTHutC1q/6DhopHSwPR+1i8oXV/sT7j2OSoeUdWJsIlT+yLl0=
X-Gm-Gg: ASbGnctc5JnuhLopbwM4qlbk0MIgIPTLjCq6jTr1cKIyq2/QRAQCeFWCWzmHm7B0PCW
	/plvB4JcOcaoXMVCQp+WN7vFylofB04YKJtG7BHBUgILyCmvwrgvLjHzQqLJiHtFBRN3Mv+dd8R
	rfGgW+e1xtnDmzKzcR1wlLewHmAZ+whxAMGBK6AXPXHlFZJJhLAq3857QQ+DOTJOsbK1ACX2IjU
	cKvLJtPN9hgeO3tAeMXhoKvkd/b7BrR+tRJZT2LcUhMAMfA6nYH87OMZKym62Vt7ptbZp2vEMfH
	xFKfQPSPju94zhirkMy+HVgqpl8edyNyagRByeMwmIQS6LKBf3XcuVKejzL/vYB5pmEelPkTCso
	rnmm8J8kyqiCv0QUhQTwNVsFITsWH
X-Google-Smtp-Source: AGHT+IFGom1pvP26uA9aKjTrkI6D6p34D8OfrDEsjpJgJY0txiyido0Z3dDxMIp3H950t0uf76P28A==
X-Received: by 2002:a05:6402:2816:b0:5e5:49af:411d with SMTP id 4fb4d7f45d1cf-5ebcd476285mr15315373a12.17.1742891226502;
        Tue, 25 Mar 2025 01:27:06 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebcce36d66sm7377366a12.0.2025.03.25.01.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 01:27:06 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 25 Mar 2025 08:27:02 +0000
Subject: [PATCH v6 1/6] dt-bindings: gpio: add max77759 binding
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250325-max77759-mfd-v6-1-c0870ca662ba@linaro.org>
References: <20250325-max77759-mfd-v6-0-c0870ca662ba@linaro.org>
In-Reply-To: <20250325-max77759-mfd-v6-0-c0870ca662ba@linaro.org>
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


