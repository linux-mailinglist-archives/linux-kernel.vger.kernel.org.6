Return-Path: <linux-kernel+bounces-209558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8029037B4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D075B25DD6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E966A17995E;
	Tue, 11 Jun 2024 09:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wIzeR+07"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA08178361
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 09:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097566; cv=none; b=P0uen+Di7pXEjFY9uFB6J2FyPbI9+PkH2nMk/shcs6DR9bG+m/Gz0PnlagWrwVz6Nrys4muqDQtjyZLSGX7A+ZdxeoTAVy5Xy3SWphpoiZJHZhg6RCEi+AbE0rociYaLG6cyGZCTyzz/5MLOjsRhHc+OccCRBzZ3IO7uCIKHlYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097566; c=relaxed/simple;
	bh=6B5VXoDqcNMNwdbpxPt6nXvAMv6Q8BRs62X/u+Uc5OQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bl68enJyxzFpkUqpQ8e224UYp/u49BnbQMM/IBAk33f7S1OqQpelQ1vQIYxmjAn3T6/A+EyAItrlnnI1WDeMJUtx5BS58R+/uSVDM3wM7kM471+UJ342X8dYtQnkNB7dFS5XvkQfKL10KVSrFEl6/MjTHMsBR3Z2hy26ZU8HvGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wIzeR+07; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42179dafd6bso18246845e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 02:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718097562; x=1718702362; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WHLR3wprrg4d+O2k9pr8l2u9LNSAqJ7RZc7brVLMtTU=;
        b=wIzeR+07ZsfW+6GKWfWD0cRYqHgbDCEWkCsc906DFcOai/EwalMrLRM2KRCDFa5QsS
         A48v8EWxOLGWoa5w7un7OcWbkICJzc6NemjNi7b0XS7ZfUpLdWbvchfZyGlfoxWdbm0a
         ZxLfSjSbE8npnbCwsrY3AqJN4J6G+epvpbV4n7Nqv7N0Y6FIyw0puL+uh/y2nuuJudM8
         QF9VZE/I4JnTVZ+hwMa5A+gWHLU6r6oyjOnVWUNl+XTiNKrFjR1FuHz17lakR1opKxXB
         ETRJY2YmLju09sxA89MoyS0c6vtdIqe+nQtGxTKAQQDsAUtpmTcZn2EMNhxxuAh2MRTR
         a/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718097562; x=1718702362;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHLR3wprrg4d+O2k9pr8l2u9LNSAqJ7RZc7brVLMtTU=;
        b=LlOPu1a2OJrzVpQG7Cqp3F7tbR66/0SFghdO1Fx3f8H8bSZHxtonGb6bMKiq+jjtrT
         toJ2DzPu5+B/pt93aTBYHlRcBpZ8z9CI5t4ZG2XgLRtWXIGuFh67BtmO5VAnX8G46L0n
         GDNNh/GCY3XBI/gfEYm/dDb18ITAbjcfWs0+pg7VaxcMMCDO8DZh7aYkvDgtZ6z+1TJO
         QPKHBUX4bpKuhSjHBO92koNQQ3OAAFJyZx6zqd3+9avDZa+EeLs7bg9j4yTZpFZqDwdl
         quGoD+dDiuOv8G0i2HiDAlIISzFbBr2A/EAfDMGwrslcBnnzat8z39NlOLxms55lg45B
         cGEA==
X-Forwarded-Encrypted: i=1; AJvYcCX7PA0hpfsU/2j7HFVtKMclADMygUUNXMMx8o+Q2jMHdbKHkIVmbFv9vj9ayK9a7QgbqCA/Dwzy2xonv2ZkJoYM/CDV1DKgSpVWmlhd
X-Gm-Message-State: AOJu0YxMfD120IUvwq/ddnO9ZwVibOrVTWOXe4eU27rYRI6pySh7f5c2
	9wGja5Uc1/bR6BQ1cucvFKzi4hEBUtwWegueMW76ffbxUADNTx3vgHJMtqBbiD8=
X-Google-Smtp-Source: AGHT+IEunPkynvd8TXepCE7Os2rVKM6V8FP5MywvkIt0CL1m14IwHfKi6ppWTLLtdJlftxnpEkYQkw==
X-Received: by 2002:adf:e8c9:0:b0:35f:d6f:aa91 with SMTP id ffacd0b85a97d-35f2b27c17fmr1923286f8f.9.1718097561518;
        Tue, 11 Jun 2024 02:19:21 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5fc3197sm13334619f8f.101.2024.06.11.02.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 02:19:21 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 11 Jun 2024 11:19:18 +0200
Subject: [PATCH 2/2] ASoC: dt-bindings: convert everest,es7134.txt to
 dt-schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-topic-amlogic-upstream-bindings-convert-everest-v1-2-a7f9b4c9005c@linaro.org>
References: <20240611-topic-amlogic-upstream-bindings-convert-everest-v1-0-a7f9b4c9005c@linaro.org>
In-Reply-To: <20240611-topic-amlogic-upstream-bindings-convert-everest-v1-0-a7f9b4c9005c@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2622;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=6B5VXoDqcNMNwdbpxPt6nXvAMv6Q8BRs62X/u+Uc5OQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmaBaWwhX619LQoOLeVTyiZaRwUDTxyCkZikXb/hU6
 hBCqUaCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZmgWlgAKCRB33NvayMhJ0ZBcD/
 sGywN22u/Nb1IrmmpOxZXTN8RVc529AcNEKbQsQXuihh7MwtxcMbQ2jryUtyVYiqO+mYWumlHmJyLu
 3sC3w8ST1ivLItowcihvxJKkf2Eb0StOnzWWKKmmf22+46+Z8gxYySe1EhAI7mZ8xH9LLlD50MKtSL
 i+wxQh6qCtc2fzxgj3Q0M//tCTaGpOoXwygFqOdfqwpAHSS6+onsDeMxftKSVYDaWTJGyWGIrWz7+S
 QTzik16XBKZpUy/Lw1yUPvC5mS3pFUzehkRmFcxhGi0aZkZ6z+B1AA+/Pf8FTqjclPLp5fMxsiZ/rp
 gGtpczcK9UsUSHCXRl5Wil11nOsu3mKkfuRtFTysfeP8FOJsLg1Ro5t9JIY8N9Gw8ugyTJaFiqrXXm
 g5gvY3hAMFSwLZWXW1uIjBvU/+oAHvDhnHsmQpfZ7bVmmiF6IoEZQ3KjS4fq/f1BCiGsUcsixJGLmy
 5pk/JcaKgelZMXH4Kj3XWav1HQW0XrmmBlxZK5C1lqfyuiv9Y/Qi0HcSWD142RxDtJZfQg0ZfBqa5K
 9+1tFSiUUSLa/U19CywVDF4V5IEMqBB82kXzN7iHi/hr+YyWPW0Mymy7bkwtwljccImRdOrsoizTMF
 5tDUaM17K/31TLjhW/H4BK84FH7uf/D/PoVPxE33t9QTqugKDLUTmgLgWdjg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Convert the text bindings of the Everest ES7134/7144/7154 2 channels
I2S analog to digital converter to dt-schema.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/sound/everest,es7134.txt   | 15 ------
 .../devicetree/bindings/sound/everest,es71x4.yaml  | 62 ++++++++++++++++++++++
 2 files changed, 62 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/everest,es7134.txt b/Documentation/devicetree/bindings/sound/everest,es7134.txt
deleted file mode 100644
index 091666069bde..000000000000
--- a/Documentation/devicetree/bindings/sound/everest,es7134.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-ES7134 i2s DA converter
-
-Required properties:
-- compatible : "everest,es7134" or
-               "everest,es7144" or
-	       "everest,es7154"
-- VDD-supply : regulator phandle for the VDD supply
-- PVDD-supply: regulator phandle for the PVDD supply for the es7154
-
-Example:
-
-i2s_codec: external-codec {
-	compatible = "everest,es7134";
-	VDD-supply = <&vcc_5v>;
-};
diff --git a/Documentation/devicetree/bindings/sound/everest,es71x4.yaml b/Documentation/devicetree/bindings/sound/everest,es71x4.yaml
new file mode 100644
index 000000000000..149dc6a6015d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/everest,es71x4.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/everest,es71x4.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Everest ES7134/7144/7154 2 channels I2S analog to digital converter
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+properties:
+  compatible:
+    enum:
+      - everest,es7134
+      - everest,es7144
+      - everest,es7154
+
+  VDD-supply: true
+  PVDD-supply: true
+
+  '#sound-dai-cells':
+    const: 0
+
+required:
+  - compatible
+  - VDD-supply
+
+allOf:
+  - $ref: dai-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - everest,es7134
+              - everest,es7144
+    then:
+      properties:
+        PVDD-supply: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - everest,es7154
+    then:
+      required:
+        - PVDD-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+   codec-0 {
+       compatible = "everest,es7134";
+       #sound-dai-cells = <0>;
+       VDD-supply = <&vdd_supply>;
+   };
+
+...

-- 
2.34.1


