Return-Path: <linux-kernel+bounces-528698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A11CA41AFA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59CEE7A2174
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BD22528F3;
	Mon, 24 Feb 2025 10:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PLb5KMKp"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840E924FC1F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392937; cv=none; b=EhbNlhVKj+v7xh253fft5I2dsg1WlnMTJ5n6DyEMehgI5M74BTukN6WUdY1CWIvmxawOgz6IUc5e0D8rMEt7xUSbcdDCKCaISpA88VKJMhoUMpsnscULgdxdoByzGu2K6EHMY7292OCZNKsg9jD/2+ASVSuC/2UOJ2tIbr2r2yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392937; c=relaxed/simple;
	bh=nQJBIUhPLwK8sP/au/kpUVGthmufT8a/T2KHwyqpg6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jenw32gZ9aB9Z2lH2En4LNY5dcUrhI71WFNErpAYTqnnwcG1ja0wHknjDq6jJxss2ACGJuw2NnRybK2IH7nPC8l+Aybhbxzu3MmFjumNq9jAG/fzZPIFWy81aeP2gmaNi1O3YiRatCa7JZB5ihSKuHiTHo7C8yYI564ojQGPZ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PLb5KMKp; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5ded46f323fso5792835a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 02:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740392933; x=1740997733; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fd8CWfeG8+6FfaIh+fTT4LnoouZsbi9TX6aHe3LpoDQ=;
        b=PLb5KMKp6dktPX2RaD4AtP3jyJWlcCbQGMKvmKDoOsJEx0Qc9jQ6zonUfsHuppb92s
         BJiK0FcJWxH1Z78ngSdHHyR9cl9Dg0Bxvq/u36fn6MEF/mtxQ18LsjnHryXpfthpph1L
         AtI+A9oE46814zySqHuvZfGZXWZug+x3sDjFUMGrZsvi1kCSaJHfPvqcYblIn1fto/Uf
         unF1XgfcvoWSmFq/XF/xppqJsJSungYz6uZMb2M0YWjQuj0wUaMbIvIDWeHHJGQ0ySjn
         3tQBuJ0LwB+ZQ397f7NBh2eFvaG9Wcn8e4BEM6uki45r5ZfvM8phADAsRjpy59bBQFJA
         rnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740392933; x=1740997733;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fd8CWfeG8+6FfaIh+fTT4LnoouZsbi9TX6aHe3LpoDQ=;
        b=QLf1zKxtZGSeP0HJoCrbontP1gm80r7OwS2y+zNgAcNLv93CToIHRtsC3mue3sfYjS
         E/IjAzQW4MI3zHHg5+DkzuPLV5oGYeu5EtUF/k60voJCWmhwjjGEx9OV2o1haRGgNN0T
         sQ8ZxWoTtoXhMCeusqx62Qr+GNWeOLDFGPybK6wodHSmpZK5fju5OFUQrMpn+F9kwm0K
         FNboCDlOUt9Nczr8w75TpzaMy6zqq343Ab5psEldUrRqHDf8zebYT3xcgb4W+XW4js+j
         8kNBM8g9Ywkg9PMNY4LH/9qo0MH5hPKJGWo944XIZ0or562j7nrIIG5EoKgglbsbln6U
         +EIw==
X-Forwarded-Encrypted: i=1; AJvYcCXJ6pCvQEfJRSbNRo8yYXB5wY9GoH4onUGhtHIhZeF+2YIPqOpLNHHv3C3/6Qr7mSVsQX8R8WvkcMQvvMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvoM126RR95g0EYw02Im3CTbZtEX/bfVfEr/PuQxnCWHLxhL/d
	LBOBfKwKRSeXXZlANt6O+ZdD2utC8zfdFas/7kb4U7CTKOdpwLTB1H6V383IIM0=
X-Gm-Gg: ASbGncuP+6pACZmEjF+csHOhDq2G7mvPWzXOX2TXQubSa64d+/rPVtVcNnjwB7IWbm6
	22C+86cg5FPvgNNTsK0/TbXPoHh1ptHSom9h8mO3VbO+XpmpO1s0PqEeW+HaCpJS0SE0yedPGGk
	5k87OQWyI95y2GoP5EP0ot3so/xY+QGkLT8Kw6ddJhg5Dh7KIkJxLMd2cZlxzhRDpoFXmeruwVH
	BBXePcVkysL36UGQT2ivL3o+v7wmC/KFlPcGUp6kGBByx+cvLy1z1EBc0be5vWzclQkRlkvDB+T
	71EpbUUUSiGUR2FHTEvuUx1ZKGUxsb1TbD8UzcTGw9Jj+lIGNaV2lgZLvZBhL/bn45Oxua9NNPL
	qDFxHWMDnPg==
X-Google-Smtp-Source: AGHT+IE4q27LpmwxJ6khnxFSWavRGTvEjWQZ/aQgFTEve7pPUfHXEj5f+O5XTnie9HbVpDVpkSkYgw==
X-Received: by 2002:a17:907:1b26:b0:ab7:be81:8944 with SMTP id a640c23a62f3a-abc099b88ccmr1369497166b.6.1740392932757;
        Mon, 24 Feb 2025 02:28:52 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbb186c5d5sm1349206666b.51.2025.02.24.02.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 02:28:52 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 24 Feb 2025 10:28:50 +0000
Subject: [PATCH 2/6] dt-bindings: gpio: add max77759 binding
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250224-max77759-mfd-v1-2-2bff36f9d055@linaro.org>
References: <20250224-max77759-mfd-v1-0-2bff36f9d055@linaro.org>
In-Reply-To: <20250224-max77759-mfd-v1-0-2bff36f9d055@linaro.org>
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
X-Mailer: b4 0.14.1

Add the DT binding document for the GPIO module of the Maxim MAX77759.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 .../bindings/gpio/maxim,max77759-gpio.yaml         | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/maxim,max77759-gpio.yaml b/Documentation/devicetree/bindings/gpio/maxim,max77759-gpio.yaml
new file mode 100644
index 000000000000..9bafb16ad688
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/maxim,max77759-gpio.yaml
@@ -0,0 +1,47 @@
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
+  "#interrupt-cells":
+    const: 2
+
+  interrupt-controller: true
+
+  interrupts:
+    maxItems: 2
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
+required:
+  - compatible
+  - "#gpio-cells"
+  - gpio-controller
+  - "#interrupt-cells"
+  - interrupt-controller
+
+additionalProperties: false

-- 
2.48.1.658.g4767266eb4-goog


