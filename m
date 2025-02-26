Return-Path: <linux-kernel+bounces-534557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25487A46876
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 241F53AE233
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CE422A7E5;
	Wed, 26 Feb 2025 17:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="km5KCfub"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B533122A1ED
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740592289; cv=none; b=ohYgyClZwnpdLT3tbZJhCs1OvpPngPFmSSoMqk1WTgFMlwPRia78V9w8cI6rPszypygk3NGbge47KRAWTBF/eRya1F/pFz9EWp6t3jnP+3keuzdKvCPGqGCP3kbp/Nk6vjBQpWV6oZbgQIX247P49B+gTIFMviaECqWY2yl0zAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740592289; c=relaxed/simple;
	bh=I4feaQK2NeL1iMZsywRHTjEz/SueHsximMXGo9uKgLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mfhv6ZNNKX6SlulmonuN1pUwMJD6yiB/TQOYmQL62+Ixa66iyXaBxO9rVLLM6myXYyVLLkd8hVxc8kYGkRRTGf04tYlHlNf8HBTkcgjQhJXbYOKsD1/KffU2rOkG/1SiC4JnumGrbQ9t9HRchFmURVGBNA52QAa7nyvFwiDUcyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=km5KCfub; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5dedae49c63so12725852a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 09:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740592285; x=1741197085; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A9YomS+c0wThxhIl04CUTErMlrQA8JmWzVl1nv3uerI=;
        b=km5KCfuboEwYf3Lk8LTH7jJmnQvgCD+Dc8ClSyE8K3EK2mwV9/emetFM6v+S7X7Hlu
         4uK9rloDtfjz47LEtO9xjUAS9Oj89VIw4I3Py/QU+qc6r8zA39pTHTvSvq/V8+bgBiZY
         hj5VZSTd0RnEm9E3xpJx32rUEzk3Nrf3/Ze6LTAnx0OR0x4paJ5o9GLhCYhwOG/+Bxmb
         05DHgc8rvMxqaTa+VuQyBDwUiVbBEPcYOTO1Zf1pVtoq1c/JHNW0hyVMxDy1vTRWohTf
         6h9LXVt1sg0IlQogJ2yHxaPYzhO/n6JStcDD2mwliNsVUV9qGJB9iGWYaemL3Fh8pwc3
         egIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740592285; x=1741197085;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9YomS+c0wThxhIl04CUTErMlrQA8JmWzVl1nv3uerI=;
        b=gzCRkGXu7diFEfR5XaqQ+T3BdbTdXrafSOkuQg/PxXv6ksBxMoSlHdAJECmHzuAN8I
         lwPRcuM92Ii6uFZEG3JV/upQMd5PTRvVn9MWRtxdVFURm738SAibOxrVtC8E/U8YS6RF
         lEHVf0k6M1ne9Xcp5YMOWKOk+YJ+12Plm1aNedXD91TtFr6PKMEmMl4e9IL6KoD08nVG
         foZ7CJA24aqONCNqmV3ouqUsUDaMpGsCN0M62i++Rr2g4e8ERBEF9HvMp6TQpf7dK3Z5
         +Fw7iVxmc7kKNkIrpA4LguDkgaLP0k5ba7uF8FrRzXrZdi83+YQbfwmpGFTRduCulaR1
         dyVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjKeHmmuUQqug5RzT1riluYJEwZMYEpUfVx5yKp9XPdkonDpLMKwj58eUf0ZL8vTXD8skc10jj/4LHFy8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2H+Y2KK7daf5SHKJfXRCYGf/xKNmKcEngnnHAgjpp7R0y75Ka
	malEc+CXYsMJTQ39VCqQ1/2iKocr5wL5C+UaWW3aJHKVz/qUAweble95v9f0qLA=
X-Gm-Gg: ASbGncv6ihuw2Ojx8LeTxs7Hj6SXgnuMAmt4mKt8QcPhZK4oJI08EJX9JJv46VQRj3L
	r2W/pwfbi3B/ME3Mm5DafdWNboFxtbOP1gHi/Sm2UYDi3KcLaiunS56pZLX1jtbpEKIwZXM3qnj
	2fb9UapdujUTha2HCJEkIfdmbbifCgZOQoXJ/JYCBnSYDBOdExZtBqgSCQXIjaOLt7ztWk0yCUR
	HrBtCbpZ8ZKXUF6p+eBHmEfUK+LS8AZTi1iXNbkSdEapBDOTB13e6UP854pDgJYjfSEIyZ7WBVV
	/myY2/BVm66/awFJK9pqMyXU8iZ8p1qLhJ9ZmDWTffajClTXAgP/RtQJ2R/vuiS5uwUea+jIq6T
	wnemjDfqcdw==
X-Google-Smtp-Source: AGHT+IF7S3Byg/2EA8G/VaFXwC0WijN7Hyq+Y45Wz3xtOjrJyqaLL3aB8h/6a9ePi5nZG42xtp7hZw==
X-Received: by 2002:a17:906:6a22:b0:aba:6204:1c03 with SMTP id a640c23a62f3a-abc0df5d89fmr2632175766b.57.1740592284983;
        Wed, 26 Feb 2025 09:51:24 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1cdb131sm361889866b.7.2025.02.26.09.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 09:51:24 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 26 Feb 2025 17:51:21 +0000
Subject: [PATCH v2 2/6] dt-bindings: nvmem: add max77759 binding
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250226-max77759-mfd-v2-2-a65ebe2bc0a9@linaro.org>
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

This describes its storage module (NVMEM).

Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
v2:
* drop example as the MFD binding has a complete one (Rob)

Note: MAINTAINERS doesn't need updating, the binding update for the
first leaf device (gpio) adds a wildcard matching all max77759 bindings
---
 .../bindings/nvmem/maxim,max77759-nvmem.yaml       | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/maxim,max77759-nvmem.yaml b/Documentation/devicetree/bindings/nvmem/maxim,max77759-nvmem.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..1e3bd4433007341a11040f513bf444866b9e38a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/maxim,max77759-nvmem.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/maxim,max77759-nvmem.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim Integrated MAX77759 Non Volatile Memory
+
+maintainers:
+  - André Draszik <andre.draszik@linaro.org>
+
+description: |
+  This module is part of the MAX77759 PMIC. For additional information, see
+  Documentation/devicetree/bindings/mfd/maxim,max77759.yaml.
+
+  The MAX77759 is a PMIC integrating, amongst others, Non Volatile Memory
+  (NVMEM) with 30 bytes of storage which can be used by software to store
+  information or communicate with a boot loader.
+
+properties:
+  compatible:
+    const: maxim,max77759-nvmem
+
+  wp-gpios: false
+
+required:
+  - compatible
+
+allOf:
+  - $ref: nvmem.yaml#
+
+unevaluatedProperties: false

-- 
2.48.1.658.g4767266eb4-goog


