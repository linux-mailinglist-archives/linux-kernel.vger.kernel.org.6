Return-Path: <linux-kernel+bounces-291148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDAE955DED
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 19:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E32A1C20356
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 17:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6024614A61A;
	Sun, 18 Aug 2024 17:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TErJa4RF"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C5A1EB36
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 17:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724002122; cv=none; b=G6opcPgSGebFilOu6UpCDN1GX3mZ1YzPRiVMyI2SSwQm9VlN6EB0dNMlaoLPTUQRoeE4fvr99dvlp/yGULT81LHiAImbuj9KMKTBzJ2nGKyaYi0SY6sTbwyaoUnKhLbtmPEvpcMqT0He4QHSgfj6486sdbJM30QvoCPgWGdWrZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724002122; c=relaxed/simple;
	bh=AbFEOueyTkApHOCZ2VmW6GfqYLBCyUHUN/YS6oy+fCY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IndAh3B+UPyYgaZ2rBFK8P9SOgQ9W1x0aY9wwWJyo7wfdxR0qxb0teKqCHBWGFelvJMSbwoiGnkYDjPGtJfy9oY01qUVzsmPQu6NTIrZc2qu6h60arpWvvc/MZ7vjopAcsB7K2r/CcfZU/TDhUK1gw5vKMtgnIeTllY7bHPdVZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TErJa4RF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-429ec9f2155so21918515e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 10:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724002119; x=1724606919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PMnjAah/UWroMhE148PgxhjcZt84A7eF0pUsqexp/xQ=;
        b=TErJa4RFXpz8hZ6AySjZ6CD05IoJYIKFwn3YMVSscnsy90+DTS5HtzZT77ZjxQcQLa
         QD0Lgq6Kx+u5c8z/sX2PO7WLisafhKxhXHI3e0BlwETyCy6ar1e64GjsyDQq9JzVGI3J
         uUoFh5G9yfXf2blnZqxth6UEUPxWiqba3EqKuh94AC/SHhl5Ok4pL4e8AbpVm9D9pnBL
         vziNOp+8/h6fF+yI/mThOn1YYq4/Tic42Hwc5DeIlSFBpMvWyKs/g9WsQiH79mYM9My5
         ezklLBKuSOiCUp1wJONp1Y/soNOB+uoc5qhjup/BqCTXGgLBD8iqbUrpOmE9x1oYieVE
         jMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724002119; x=1724606919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PMnjAah/UWroMhE148PgxhjcZt84A7eF0pUsqexp/xQ=;
        b=duDBA0+Ba7Q0GZxrt+EROfbw68jgQYLQ5jBsqdYho2IkupEcfPfA+kGQh5Ncz1S8gy
         irLBTJ1F6Fv6ipbDVJJWgoYOAI/uo1OJJ9IcaZw1+LjjLdlUwxhACXj1a7ozQ/zixoaJ
         qEwS+iIiKdgxclFppBXjHcd9JMtR2ghBAGZiopDeCFQP7MjbFIGxfc6cSGas+XzOLa5M
         WtluQTDf97TluyCBQHbE47zJJ+LRhhHPlstAL5fBJ7jwkt80Q/4H9VtOqOm85hyYw30I
         fb7TIFO+ZPs6qGESMTFZV0864Q8icbkGEH7AUraHPcHlKbwrWaqpvfcYbOU70//EsfI8
         wH2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvge0RC/IUkyd7DFkyS+TgxJtXk1j5mXpXs5cqlJcKJ4Cw8u0sRToARA0duJouyaLFhMg04/u+EHgDCRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdS+KlnX2q9f8udMQaWyglAA313A5D3FhcUy0IxrW2s4b9z8fm
	6NrZ064nLdDV1UZV/cXkP7PvTEpn24o637OPbnCecOiBs1MVmXkmjUNrWFf1zXA=
X-Google-Smtp-Source: AGHT+IHKIKkAiJcdyepoCL+1/HhHa4+A1IIkB0xWHjT0oRr8pb2bKGRlOXa3/rVSag8EpoJHu5jWLw==
X-Received: by 2002:adf:b347:0:b0:368:3b21:6643 with SMTP id ffacd0b85a97d-371946a1372mr5523675f8f.48.1724002119278;
        Sun, 18 Aug 2024 10:28:39 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898498casm8461112f8f.42.2024.08.18.10.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 10:28:38 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: phy: socionext,uniphier: add top-level constraints
Date: Sun, 18 Aug 2024 19:28:35 +0200
Message-ID: <20240818172835.121757-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Properties with variable number of items per each device are expected to
have widest constraints in top-level "properties:" block and further
customized (narrowed) in "if:then:".  Add missing top-level constraints
for clock-names and reset-names.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/phy/socionext,uniphier-ahci-phy.yaml         | 8 ++++++--
 .../bindings/phy/socionext,uniphier-pcie-phy.yaml         | 8 ++++++--
 .../bindings/phy/socionext,uniphier-usb3hs-phy.yaml       | 7 +++++--
 .../bindings/phy/socionext,uniphier-usb3ss-phy.yaml       | 7 +++++--
 4 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
index de3cffc850bc..e34b875a1bb8 100644
--- a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
@@ -30,13 +30,17 @@ properties:
     minItems: 1
     maxItems: 2
 
-  clock-names: true
+  clock-names:
+    minItems: 1
+    maxItems: 6
 
   resets:
     minItems: 2
     maxItems: 6
 
-  reset-names: true
+  reset-names:
+    minItems: 2
+    maxItems: 6
 
 allOf:
   - if:
diff --git a/Documentation/devicetree/bindings/phy/socionext,uniphier-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/socionext,uniphier-pcie-phy.yaml
index b3ed2f74a414..9fc0e87c508e 100644
--- a/Documentation/devicetree/bindings/phy/socionext,uniphier-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-pcie-phy.yaml
@@ -31,13 +31,17 @@ properties:
     minItems: 1
     maxItems: 2
 
-  clock-names: true
+  clock-names:
+    minItems: 1
+    maxItems: 2
 
   resets:
     minItems: 1
     maxItems: 2
 
-  reset-names: true
+  reset-names:
+    minItems: 1
+    maxItems: 2
 
   socionext,syscon:
     $ref: /schemas/types.yaml#/definitions/phandle
diff --git a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
index 2107d98ace15..25c4159f86e4 100644
--- a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
@@ -34,12 +34,15 @@ properties:
     minItems: 2
     maxItems: 3
 
-  clock-names: true
+  clock-names:
+    minItems: 2
+    maxItems: 3
 
   resets:
     maxItems: 2
 
-  reset-names: true
+  reset-names:
+    maxItems: 2
 
   vbus-supply:
     description: A phandle to the regulator for USB VBUS
diff --git a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.yaml b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.yaml
index 8f5aa6238bf3..1f663e9901da 100644
--- a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.yaml
@@ -35,12 +35,15 @@ properties:
     minItems: 2
     maxItems: 3
 
-  clock-names: true
+  clock-names:
+    minItems: 2
+    maxItems: 3
 
   resets:
     maxItems: 2
 
-  reset-names: true
+  reset-names:
+    maxItems: 2
 
   vbus-supply:
     description: A phandle to the regulator for USB VBUS, only for USB host
-- 
2.43.0


