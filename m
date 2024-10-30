Return-Path: <linux-kernel+bounces-388848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FF19B652B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59BE81C21FCA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E941F4FCC;
	Wed, 30 Oct 2024 14:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N1x+D+Tf"
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1DA1F4716
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730297030; cv=none; b=RY46iKY7NrvWFpnWLp+bBBBdRWnY4IckySjKDyicsbz+qegMiTB9/cwVbq1oRPq3qW/dCVyEbDoI1544frmbZwT4+pTYESVpPOmhA3myQp6UrvP67znioRhCnWcoHE/GIPHP87p6g7TAtJWjb+pxQJ6VEJ1P+sz00RetBTomFYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730297030; c=relaxed/simple;
	bh=z2Vunh82dN0BEK3w9+OuIC14wEEgMgwChFgUaC+KfbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ayKeUfRNnm3CEi+k/6taFpD8NQ61+IAX0SUFyPoBfmBXRL6RY/t5cF8NJDuk+vKRzrRA/inG7Wd0JbwqN70xqV8MqJ+iQx2PKO+2ccQTesy6YGUKR/6Z1mW6bYJ4yJxmq9GGlx+d0O8AQQmnTTwcZaAN+6CeIBEtd9LhR8hjoqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N1x+D+Tf; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-43155abaf0bso64711035e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 07:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730297027; x=1730901827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9x6XrtDY+bedYEtd8B1W/i10aHkfc3IYmTqx+xv1FhU=;
        b=N1x+D+TfnKjLVmlBIRR3Lq7tgLcX2vLlybXlCmJSnLQ24aLblYJhAXAU/14Aay6h5a
         4DiIm3GnGCFS1jkOxXFQ0Q339H3BdzZ7srgKaFgt57q8SD3TSXxxB+qVTiotHUSV6k+z
         J3jXkbcamEImyFxHNmSlPd4GOfe2zsTiXe/Ypjmv6sT0AfP2iRsVQWAngntFe/EQnR7I
         7NTzMsqEB/1rOva9R92HJii/I0/Za5Uc7BydEj5McNi5lZoN8vWMzb4DhQDDZWSAPwet
         kmB08n+Gux5mEeGiPTFijedyDMIwsHJAsSjiuvuY/hY0T2uyVbbHhOZgFKxjlGpQ9h28
         gFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730297027; x=1730901827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9x6XrtDY+bedYEtd8B1W/i10aHkfc3IYmTqx+xv1FhU=;
        b=QmASdPYBT9NEqsP6ySU5qKKrahX1ZGiuLoRcfcAVhgIuRwa1PAUoHt0OSrzxwGOGHY
         K9LvR+iyoyhG29KNdtmccNTSzDz9QgfMzhq4I8Adi3hUnjDF1227L9ZGBIq7ept41Otj
         iFwl7xOBZwCBSK//eKt32iMTxygz1Dske/UIkT5md0apwAOsTmd3EB1QBHBnGRgYD0Pc
         Nsg6j+MnfwMzjqeB4G9ORY/oEPDCnwPx6oM+RFI1z/F9x0Fk9L+nSOsES9HN+ku6bgVr
         nT8lJqNbdONuTyhIPH6Ppzu/PFT7FLm76FgTjBjLr0gtcfHEPNSkGmrimdiQMPr3VsJj
         x10Q==
X-Gm-Message-State: AOJu0Yxf2RaMSM+5JpH/MEkjHk4fkJ5DMKDQJoHVAONw2JPWgMOmj1x5
	tWVq+3ZK+pkNlGKxcCdczCEW1gcsIXlSAKVZATZDWKXNVfjy/RqLebMj8mTcwAU=
X-Google-Smtp-Source: AGHT+IFq2lvgnwGMf0Thn5jd9DH4xOblA4X2hZ289Zxtbd7kAUXY4rkBRNLlrJ86dF8Z3UXSUPI8/g==
X-Received: by 2002:a05:600c:1d1d:b0:431:5f8c:ccbd with SMTP id 5b1f17b1804b1-4319ac6e802mr120521395e9.4.1730297026345;
        Wed, 30 Oct 2024 07:03:46 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd97d84bsm22498405e9.30.2024.10.30.07.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 07:03:46 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Stanislav Jakubek <stano.jakubek@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 7/7] dt-bindings: nvmem: sprd,ums312-efuse: convert to YAML
Date: Wed, 30 Oct 2024 14:03:15 +0000
Message-Id: <20241030140315.40562-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241030140315.40562-1-srinivas.kandagatla@linaro.org>
References: <20241030140315.40562-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3578; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=KRQQIVEb1QG17qT/vexKrFyaF1lhidf4LqH3l2Ml8z0=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBnIjyjwEUbVowkDYQEa/E4a+mOIziAT2ys6cE9r BQ/fc4lTKuJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZyI8owAKCRB6of1ZxzRV N1pjCACVdJhd8UdhnmKM8UUZLTfKk59F6X05rvHJO9hq2xUhFPig6enJiMQmEWBTO8JpNp6DkxE MN2iogCEHR9J4c4Sszhh3c5P2BFPprzbCN9YrLZ5U8MPfqq9DChkDSamwkEGvAkm9ghKuPmI6Lw obOVs7NegaAqb7bQml9E+6a9mGQS1fv7qWheUm7ynC/Z6nlRkrS90CDxaTXOpbwqQi50U+1160m E1rZFDmOC8OOkXB5dOyBIXzvYXKgdypXF+aR3f4Kr9d+jpSIUlrxSV2ZPjBX4ohW9D0a4dnaaRO xF+aN14R372TERXW0DrD9dk/oNtcf3G0hPnFlsOgkNoiBRik
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Stanislav Jakubek <stano.jakubek@gmail.com>

Convert the Spreadtrum UMS312 eFuse bindings to DT schema.
Adjust filename to match compatible.

Note: the UMS312 clock bindings include doesn't seem to exist (yet?), so
      the UMS512 one was used for the "CLK_EFUSE_EB" define.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/nvmem/sprd,ums312-efuse.yaml     | 61 +++++++++++++++++++
 .../devicetree/bindings/nvmem/sprd-efuse.txt  | 39 ------------
 2 files changed, 61 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/sprd,ums312-efuse.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/sprd-efuse.txt

diff --git a/Documentation/devicetree/bindings/nvmem/sprd,ums312-efuse.yaml b/Documentation/devicetree/bindings/nvmem/sprd,ums312-efuse.yaml
new file mode 100644
index 000000000000..00e0fd1353a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/sprd,ums312-efuse.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/sprd,ums312-efuse.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Spreadtrum UMS312 eFuse
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+properties:
+  compatible:
+    const: sprd,ums312-efuse
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: enable
+
+  hwlocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - hwlocks
+
+allOf:
+  - $ref: nvmem.yaml#
+  - $ref: nvmem-deprecated-cells.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/sprd,ums512-clk.h>
+
+    efuse@32240000 {
+      compatible = "sprd,ums312-efuse";
+      reg = <0x32240000 0x10000>;
+      clocks = <&aonapb_gate CLK_EFUSE_EB>;
+      clock-names = "enable";
+      hwlocks = <&hwlock 8>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+
+      /* Data cells */
+      thermal_calib: calib@10 {
+        reg = <0x10 0x2>;
+      };
+    };
+...
diff --git a/Documentation/devicetree/bindings/nvmem/sprd-efuse.txt b/Documentation/devicetree/bindings/nvmem/sprd-efuse.txt
deleted file mode 100644
index 96b6feec27f0..000000000000
--- a/Documentation/devicetree/bindings/nvmem/sprd-efuse.txt
+++ /dev/null
@@ -1,39 +0,0 @@
-= Spreadtrum eFuse device tree bindings =
-
-Required properties:
-- compatible: Should be "sprd,ums312-efuse".
-- reg: Specify the address offset of efuse controller.
-- clock-names: Should be "enable".
-- clocks: The phandle and specifier referencing the controller's clock.
-- hwlocks: Reference to a phandle of a hwlock provider node.
-
-= Data cells =
-Are child nodes of eFuse, bindings of which as described in
-bindings/nvmem/nvmem.txt
-
-Example:
-
-	ap_efuse: efuse@32240000 {
-		compatible = "sprd,ums312-efuse";
-		reg = <0 0x32240000 0 0x10000>;
-		clock-names = "enable";
-		hwlocks = <&hwlock 8>;
-		clocks = <&aonapb_gate CLK_EFUSE_EB>;
-
-		/* Data cells */
-		thermal_calib: calib@10 {
-			reg = <0x10 0x2>;
-		};
-	};
-
-= Data consumers =
-Are device nodes which consume nvmem data cells.
-
-Example:
-
-	thermal {
-		...
-
-		nvmem-cells = <&thermal_calib>;
-		nvmem-cell-names = "calibration";
-	};
-- 
2.25.1


