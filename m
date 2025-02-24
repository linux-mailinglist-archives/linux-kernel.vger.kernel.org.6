Return-Path: <linux-kernel+bounces-528699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7C8A41B0F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84B831744DB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C282253B4A;
	Mon, 24 Feb 2025 10:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yls4iqky"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E25E250BE6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392938; cv=none; b=aNQ3Tob2SXj8J7kIVYhL+gf3zgFq+HqRvzdTw5Q0lh/wyMO8Zql/FdhjH9DoY9NlIXTGz5+KqtBjXMQOl3SPTX+7Y4ogZcIZg5MWCxqojGKy6qx8Jor8T1HUpZfw6cdnWleHpHHt5tQhC9wt+ipoZ2qhU+hLyZVwRflk5y1Sm90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392938; c=relaxed/simple;
	bh=SbxyZVFzeep/C5H/BzJACz2cstijlLoAVmx4b9KRzx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gD7yUoZ0jH9rGq37S6uZOZZ8n5BGK38e0ZWEF560i0mfaHsPsE1SG+694IqYm/63AFGZYyLlhhsdDK+myK8Fq/NYA2akP/u8TuTlKBpWD5b5EG9eglHSA7naQ3oatidu7oO+735D8uZaYTJdu98sk2azcCSMDWGUyXFQxGgjsLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yls4iqky; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abb7a6ee2deso648459866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 02:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740392933; x=1740997733; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WbhcZtzS5EwoX+spb+fb7Z6TUP96XJcoUjJrW1dm9ac=;
        b=Yls4iqkywa3myn9tbq8ErI4PwyN1xABko277p6G8VTDqy2DCPKdDutj4kpYcVlXW0Y
         ZjTmnZ310vjKbNIJc1VfeAV4jPwnzjbc6rRKQYSuxg3tWrQzhi9M4tXczIxmrn042x3/
         9KxfY7kHhF77ioSbWKA8BZ32Sx4thJiFZnd23zoxK7zKUMsSxSv0+jkc1fGWv9xQWsAc
         bukYC+P5y6z66cibcsCTfpQITvu5W1TDDrVQmYBOulv+mfapDqIKprl4hdPawVjno8Km
         394Ct3atD6xWBy1ht1pl87erI13tMEXDKriLhH475CrgspZGJQGIau2Q8RZ7KTLG/nQ0
         QQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740392933; x=1740997733;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbhcZtzS5EwoX+spb+fb7Z6TUP96XJcoUjJrW1dm9ac=;
        b=npPOMm+AF04yY91fToLadhT2gfUyFKq7eUc73SzmoDprZ2vYCZjaRxJFQDSRdS19Hu
         AcFbZw6nV5vEWwvRZ4THpfmCEf8DkNIFlvn6WpkIl04q7X/a0OXvkYcCsCuQbS4uDkDa
         WKsaq8Upv/ZJFBgozR0O6ReMATfn8dASnjJlb0gqGyfW+r+I1HOUeFSaZGiXSGYlzFP8
         L3G3DROFfWhBwBzssbe912NmOL00wdhJmSwJEN6XkfB7w+bKg9ksiVSuK1VcLV6d6NQt
         FCT1f8cdCnm8TPe+pekSpYkr0+V1CL4V5p2LlukbowPWXO6zTK/BTKAM0ukS7i8oXOIe
         AHzA==
X-Forwarded-Encrypted: i=1; AJvYcCV6cSxiTNjqxItamaN+dScwsaJ911cTF2hsggsHIxFCIjtDZK1+4ey/53++U9LwiTN4YwUwKwyp+a9mDEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLE9S0zlca1cBKWI9iFCBXJmkbRookNfsCR9BzITNKPufv2KTM
	Ug2iTcFHGAr6YPXS+LWJ35OQARvNPKYb8kV/42dO0P2hTOXuqRkalKGaXZsE+Qg=
X-Gm-Gg: ASbGncv+oQFDnMnEnxet9jrFzn9SpvYMuSk9hhrYteaVcv2yktsQHYTOuQ0nv0Pa1M3
	i/8MTCmr8WTnzG8w22KB663G9GHcm6NRp74m9J/O2gA/u5R6GLGRU6wjtBlvgyvY/lHDm4SRL6l
	0dgNq3ehYzCiQTzumzsrycD9mII76nEpzPBvg4VkFlqtRtwAlLExb5mp7N7+jxyDKXJgYKhfv+b
	bF6ms/x1eNkTLcyqmJZDRRZMyvXwgaNEckKLY+DMyykxkRBwd+buUorBdSaNvQj6SZ8C+BAb3V/
	HPsg/YYlod0x0+6ljqyEMULayx/TyCqQ2MS8N+Ub743pdptxu8jAvvycw7SWfaLaZb7ZTa8mySK
	mrMP4jO7oWA==
X-Google-Smtp-Source: AGHT+IH4RZjl08rR2sE5UQioxf9Tb8q7zCAreWXLTS8Ohg3GQ4mI+vcJ4QA6lsBdoNmgXsyuVz1NiA==
X-Received: by 2002:a17:907:3f92:b0:abb:e259:2a64 with SMTP id a640c23a62f3a-abc09b21c99mr1220180466b.33.1740392933327;
        Mon, 24 Feb 2025 02:28:53 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbb186c5d5sm1349206666b.51.2025.02.24.02.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 02:28:52 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 24 Feb 2025 10:28:51 +0000
Subject: [PATCH 3/6] dt-bindings: nvmem: add max77759 binding
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250224-max77759-mfd-v1-3-2bff36f9d055@linaro.org>
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

Add the DT binding document for the NVMEM module of the Maxim MAX77759.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 .../bindings/nvmem/maxim,max77759-nvmem.yaml       | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/maxim,max77759-nvmem.yaml b/Documentation/devicetree/bindings/nvmem/maxim,max77759-nvmem.yaml
new file mode 100644
index 000000000000..d3b7430ef551
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/maxim,max77759-nvmem.yaml
@@ -0,0 +1,50 @@
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
+
+examples:
+  - |
+    nvmem {
+        compatible = "maxim,max77759-nvmem";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        nvmem-layout {
+            compatible = "fixed-layout";
+            #address-cells = <1>;
+            #size-cells = <1>;
+
+            rsoc@a {
+                reg = <0xa 2>;
+            };
+        };
+    };

-- 
2.48.1.658.g4767266eb4-goog


