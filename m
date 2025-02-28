Return-Path: <linux-kernel+bounces-538687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA654A49BEA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EB79189518C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0E32702A6;
	Fri, 28 Feb 2025 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sNruckEa"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D970026E623
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740752724; cv=none; b=IH1gz2+F0CQCSEeDKFd0ji9aGkA7ZInBetiCK6nd12N0ZqARLPlFIZ1Zacm8mw4xe0gvXBDdfW+i0GAOCeco6OVh8BWxxYuXdCFPhe9l+IGq5+836h1quhSIScqKt96aMOgGzD4JfTr2Z7W5pgsrzrveMQT8fz9PDrVBlaYcnZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740752724; c=relaxed/simple;
	bh=q8yvSV3OfR1cMeYWUwudsYOgSeKbzLSKCy1iuJ6/+EQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YPvUln7Yng4aRqsoRptGreZSFusv2BnUcjK2YaaJRc7KPxYTFi610POA5Y6IeiJylVp5CvkMjKG9D/dujO9Z4wrcJuks0io5fbjsD6JU5MlY3jeQzqZO88b4LSCFNiLrnUbif1RkUhmz/qQrwCTiFUwjRQBasbkj4K3CVYjmUlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sNruckEa; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e058ca6806so3368038a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 06:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740752720; x=1741357520; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pv4wwRg4MWsotmAwTgSc9LO+fNoS+BdIZnuXjMZYvGI=;
        b=sNruckEamZmIgRbxuKsDuxtQ2qhK0FsXxlNgxFoEGvnqgQAvpE4XZGWpyDeuCIJx3a
         zZ7qnE6eVY75VGT9RSahq/loP+KUwrOV/xq21lCuDXF1cCD0Orsr3TWLn/X/+k5MwN45
         yvTX4YvhedbAbwK8/jMrnMUi6jLWw6c4V68efQcq63+pG37+yYWlSRHno5Izz9pleDW8
         S+WaTeSCY0iC17+uP7jY2tP6pvqmAsdGNI0SsoFByMoGADPLWS5ntNfzVUf5ksPR3a3V
         VNQMprq8QBVlbxukdhR4hnnyIaVjOzv3h0pq+c0U7THK7rozvXPAa4MIQ14dy7LPBofX
         M+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740752720; x=1741357520;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pv4wwRg4MWsotmAwTgSc9LO+fNoS+BdIZnuXjMZYvGI=;
        b=RshekgX0Kk0twKlHC8guLvixwXOz0iufiAoxJhKPOt/twzcMm4N40Y1GzI/KQslQvM
         0fBl3c5ANcmi/LMokfQ5NmFUVKPq62zUdthalJl/Dxv83AlzIg/tkJQ9/iltz/Z+ibU+
         CVUxTsIHIIQQ3/xgF6LwWVH5kUTs4+tE5E/TpggIy552I7YGEZGXd7J9UQIARqFk6Uga
         dQOgy1PTb46PZdYQsmDA8A9KXVvCkvnRe//qRl9+BwqIE/1csyCSPpFGS00vZTlYSDQL
         p15IvXje+TRUrxgm/D0s7ANUhStVc0aaMOZg/TjhSAqoQqpW8tBp8SZx1rQVC4mi6SWe
         RhOQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5GOy05qLVZlt7HIB5lxhtaDb9Xy+bMkAvTGLLu2lfb9ENHW3X6YFIbAgj9kzKKs16Kna8f9Yt/R4RfDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRSwPb23+SIbViofExyzR+ma+LnQudrBhEF13NbLLnBU1rMDVk
	pM7ilUE9oa0smDoF8FJVESf1Hvm6HqwEJdYvzwI/DCrQI9TuLnAnoIyuX7gWqhk=
X-Gm-Gg: ASbGncviWUpGhvnm/UW6zqC9anUIYrcG31ADn3Iqr3fqVeVxFEk39tvhzpSb0c/i8lI
	p9R2VM0xVYyPAQM+L2sH0pPVl89xTYRPGs6MF3vcvX+70cEsJk/tzUxKoXcszvmus6VN9+VjAKS
	b8FuN2K2dPYX82aDu7ckOtRl8z+5NmckbxDxzc3rqT0uw2f2Ah2t1cNtaEteEMM4vCU2Q/yc//q
	3/3IL6wRRszsdrtXCzRVW+eL8FWWAbbrkh7blyRFO2+rO8W6vOokr1ssqfJKUWQ4oCMb4FdrRLi
	10wP9SJ5BYDEe4UKLzSAmfEaSa04jVIAJsy0OJqK9Iv8K6qkfeOqUBjAX+OEL8NKMUXSJHs9fhL
	8QOVlJKIV1Q==
X-Google-Smtp-Source: AGHT+IE/1tdmhyjPnwbfzddWeK3bk95/GNSAF7R8hQFGpqHDHMj7vR+nD7yX+QHUckF9GBrqLY5hFw==
X-Received: by 2002:a17:907:7f27:b0:abe:fa17:12e0 with SMTP id a640c23a62f3a-abf25f8dd1dmr349589766b.11.1740752720119;
        Fri, 28 Feb 2025 06:25:20 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c75bffcsm298754466b.143.2025.02.28.06.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:25:19 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 28 Feb 2025 14:25:15 +0000
Subject: [PATCH v3 1/6] dt-bindings: gpio: add max77759 binding
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250228-max77759-mfd-v3-1-0c3627d42526@linaro.org>
References: <20250228-max77759-mfd-v3-0-0c3627d42526@linaro.org>
In-Reply-To: <20250228-max77759-mfd-v3-0-0c3627d42526@linaro.org>
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

This describes its GPIO module.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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
index 86fa62154d3b23bf84ce2d53cbbdc33f3d43006e..a45d1bd64d116d14bc05a64fa3da852a41e1de7f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14347,6 +14347,12 @@ F:	Documentation/devicetree/bindings/mfd/maxim,max77714.yaml
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
2.48.1.711.g2feabab25a-goog


