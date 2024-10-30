Return-Path: <linux-kernel+bounces-388845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A29BE9B6526
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C223A1C21FC4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88F91F4723;
	Wed, 30 Oct 2024 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aOecp5kU"
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943141F1300
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730297028; cv=none; b=pxF1f9/9LBURjcTVlWLIABPmVv+S/rfyYYB5rVNq6yP6527xSocbqPLi+bXDOkT1TIW81iTggiG3ZkyWEqnMeY6GF7MDOADOWbHyOrfqTq4MII5SL1p/XCaXJ0vhnBSE0NoexOWbw38FQdEowzpORAu+zZDWm0ODgpry7y/veV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730297028; c=relaxed/simple;
	bh=ocdTOE3wlQsq2uYR9y0dqZ1+sVHl9iIxkMD/9zTFQw8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=km/Ji/aZOSz/cKzLx5MVskzRHwAlBE+olJGalUrEBC9OddfAMZGSGw4C9Zg8YcXuD213aJwF3y1GtOETviX/YuoDC5V7eSjao/ZRqH5KzR2H4CfZ1JLg58vMbHohqkmLBHo51+T1/yqcx6047LAsrP18tMUYv2yrheipH9nnVuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aOecp5kU; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4315c1c7392so64605655e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 07:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730297024; x=1730901824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFHZHHHtQhHXy0LneA3qrzAuy0eD2+BwnEwT9SmlTxg=;
        b=aOecp5kUo2nD0CBD0tqBBdk0f9TB/nj/Lr+3Oq606wr0pKKqaRbmTV1d3Dva5/9sjw
         sblqqmQRvCgFkOK76l6tpzHV0thtotVhIYDIQ10UKLeiJp6QzAkGD3gkhBp2GFGCaerL
         lsGeThXaJcyFgkIgJJKE95NX5j3RevwCf/TP1w6O96XbFpfsAlu86ai3kNiyCABVBRDu
         yM6e8CfdHrPbTTajqDnbYge9c8v0LgJcXJaFV0zm4saUnrvY0fwIMfZLRlf0HX6MS2th
         4otiOv3bly4tVlIZ5mc2wEMV3GRxZWb08EDGcfOfegQJSLLWpQDe6yv0h4mIW+nO6v1N
         7tMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730297024; x=1730901824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NFHZHHHtQhHXy0LneA3qrzAuy0eD2+BwnEwT9SmlTxg=;
        b=kEXKPwnCyACE5G2YZCAa3FG5l3AtQegH2aEuTkP2GEGbtyFiHKpXYfQPf0q12CcAH2
         ajyhnJxYPWxDgaEYoShCx1Jct6wQM0HdhQzxmekEer9iB0/C6Lkz7bs5okJp1/qx8yxd
         CMOe/+N73b3cUGW0uXTzvMvy4qGwvnFKLdJ5D14xPySElsH18J0P0Bb6ODKsFYdtJT3M
         WT22zxA/TD1S1XQtij9pohQjm4QvRA0HZqxMfqXJMZxTGPTQBC6+fsX1xKaZKIRdXtT5
         CJxF6m7LaQXpwE7LvpS7ultKVB+Gls98jKclQCPFCYlJnjJd96xARXmif+EWNRkiJl9y
         Mgzw==
X-Gm-Message-State: AOJu0Yy7D6OD2XhP+/QGJXOxpxWtwENYW/7yR+8pF0//RjSo+wTbwvXn
	7mMin0YfemMu+HOPoSo0vX/W8xMOEPo0I0ZKqNfVnAHG9RyeOE2YJtZ/o+5ag5Q=
X-Google-Smtp-Source: AGHT+IFmTpDzexI9JYrPSkm4E4ubBW/+6IhiKSPCfQNoLzak5x6FjyKaHELymMtd+iI9G6FNBccLIg==
X-Received: by 2002:a05:600c:458f:b0:42b:a7c7:5667 with SMTP id 5b1f17b1804b1-4319ad02659mr135597485e9.25.1730297023610;
        Wed, 30 Oct 2024 07:03:43 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd97d84bsm22498405e9.30.2024.10.30.07.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 07:03:43 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 5/7] dt-bindings: nvmem: convert zii,rave-sp-eeprom.txt to yaml format
Date: Wed, 30 Oct 2024 14:03:13 +0000
Message-Id: <20241030140315.40562-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241030140315.40562-1-srinivas.kandagatla@linaro.org>
References: <20241030140315.40562-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3845; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=CwYB+KzG2bo6Lm3g4RKbfuZiQwVH2hOe39CUmPQruSw=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBnIjyiakzuob7AA/3vsADSA07PuTH47JeshFPW5 v2Bab+s1jSJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZyI8ogAKCRB6of1ZxzRV NzzEB/9nFfgxwIVb8EO8/E2AEHNANtnF1KXj4V5QBvgC9Nf2vI0QihSOcvo544MfomPgYYiujn1 Eoa1QWXbR9Y3anlkpTc+JCABik40c6W00eQB9xQkzFTldmnwUYlApff/IfCKrPYHlwJcb1IscLv 5IlvGDh5T1BUVqiTwcN3iXGrPuoS6CiLBjq6sCEQ5+r+isma2OGnWhxZLidOzs5lKMbWabNhcjv K39WOCA7owVEi4FEWEudN81Vo/GDoPielmWLq1W/Mh7i3jOM9rkc1bW9k9sy8gfKqXSqDyRYMCg 8YJi2lY4K9V5Zro4pRgzEHSy/bkmp7dAc8NCwPPJI/dtV0sN
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Frank Li <Frank.Li@nxp.com>

Convert device tree binding doc zii,rave-sp-eeprom.txt to yaml format.
Additional changes:
- Add ref to nvme.yaml.
- Add reg property.
- Remove mfd at example.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/nvmem/zii,rave-sp-eeprom.txt     | 40 --------------
 .../bindings/nvmem/zii,rave-sp-eeprom.yaml    | 54 +++++++++++++++++++
 2 files changed, 54 insertions(+), 40 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt b/Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt
deleted file mode 100644
index 0df79d9e07ec..000000000000
--- a/Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt
+++ /dev/null
@@ -1,40 +0,0 @@
-Zodiac Inflight Innovations RAVE EEPROM Bindings
-
-RAVE SP EEPROM device is a "MFD cell" device exposing physical EEPROM
-attached to RAVE Supervisory Processor. It is expected that its Device
-Tree node is specified as a child of the node corresponding to the
-parent RAVE SP device (as documented in
-Documentation/devicetree/bindings/mfd/zii,rave-sp.txt)
-
-Required properties:
-
-- compatible: Should be "zii,rave-sp-eeprom"
-
-Optional properties:
-
-- zii,eeprom-name: Unique EEPROM identifier describing its function in the
-  system. Will be used as created NVMEM deivce's name.
-
-Data cells:
-
-Data cells are child nodes of eerpom node, bindings for which are
-documented in Documentation/devicetree/bindings/nvmem/nvmem.txt
-
-Example:
-
-	rave-sp {
-		compatible = "zii,rave-sp-rdu1";
-		current-speed = <38400>;
-
-		eeprom@a4 {
-			compatible = "zii,rave-sp-eeprom";
-			reg = <0xa4 0x4000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			zii,eeprom-name = "main-eeprom";
-
-			wdt_timeout: wdt-timeout@81 {
-				reg = <0x81 2>;
-			};
-		};
-	}
diff --git a/Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.yaml b/Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.yaml
new file mode 100644
index 000000000000..d073c51c2b9a
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/zii,rave-sp-eeprom.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Zodiac Inflight Innovations RAVE EEPROM
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+description:
+  RAVE SP EEPROM device is a "MFD cell" device exposing physical EEPROM
+  attached to RAVE Supervisory Processor. It is expected that its Device
+  Tree node is specified as a child of the node corresponding to the
+  parent RAVE SP device (as documented in
+  Documentation/devicetree/bindings/mfd/zii,rave-sp.yaml)
+
+properties:
+  compatible:
+    const: zii,rave-sp-eeprom
+
+  reg:
+    maxItems: 1
+
+  zii,eeprom-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Unique EEPROM identifier describing its function in the
+      system. Will be used as created NVMEM deivce's name.
+
+required:
+  - compatible
+
+allOf:
+  - $ref: nvmem.yaml#
+  - $ref: nvmem-deprecated-cells.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    eeprom@a4 {
+        compatible = "zii,rave-sp-eeprom";
+        reg = <0xa4 0x4000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        zii,eeprom-name = "main-eeprom";
+
+        wdt-timeout@81 {
+            reg = <0x81 2>;
+        };
+    };
+
-- 
2.25.1


