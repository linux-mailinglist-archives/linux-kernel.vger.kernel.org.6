Return-Path: <linux-kernel+bounces-388849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6809B652C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9A61C22025
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA8B1F582C;
	Wed, 30 Oct 2024 14:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dCIvzqw8"
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9889E1F4738
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730297032; cv=none; b=FI7ncj9Cdh7VL/lxvYei03pqpvUPo1zXeykMxsopLK3g2SIQlBga9xrpwEFxnCJyTsGIZiLbkV3+wqZJwm0E7idqJsUGWaW8lvjsvrb9hKLP3IeUXvHxSLBmSBdnLva0c7ULW83LqZ8gRDHA1cqpvDwCoLHMBm73K19LtwkNIVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730297032; c=relaxed/simple;
	bh=e2E13pHQX63EUWQaRZE09Iv7l9L/cyQDSZMiSUwHdVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ik/UG8lbtfkyQ26M3niScwEIYVj0UVyn9beuVQZB9OXygsJA2Xp1ijxCzT29nJUdg4Jy44G/Jd/v8PZrO1gqV1MzYv10TrTV2i6hecV3FRYW3FBvHaw0IyZoHBc6k9KwopOuYE1zsO1/MOApXmaP2nN25JN6c++Qyo7kezEnqpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dCIvzqw8; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4316a44d1bbso59708095e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 07:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730297028; x=1730901828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qiTJVHAqjZaJtccWmKiHCP3BUpxrmRUWi6lzwFxakxg=;
        b=dCIvzqw8G5WRwS0DMXWkKEjuWUclJBWdMBH5uvIq0wfq5lUNcFEugKtzsxSdjfNfUs
         6ljr2bYi2JqdXjPvbForkADZBir2fnVQib0v6vp5eThdWN+AA7WjIpvLoWjKPTx+9LCk
         Ee8r7VIj9Anxgiq7oD0s63XWqi+HkEyWSU4HEwG4HieugYt+4BrCeQgeZ7MUc1SOXwza
         6AuJC7OR7rBlt0Ts1+2+ATkPW0nBnKlph08AaWT8Dsf0bjh6nuc1bGWyD+ItwKnebldT
         4Z1zlrRsJEIhJ9H0iRXvZnWRL4fJVtM3QeTXn4UiGKJzClMuo9iPIGBZYApa1U6QW4uB
         IEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730297028; x=1730901828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qiTJVHAqjZaJtccWmKiHCP3BUpxrmRUWi6lzwFxakxg=;
        b=FY0LHAGXmQsBot2RJj5bYQHCez6NaCG/du1lRzpO3/e8tQmoJL0CZEW5Hv7KeueuS3
         b1lSpeDPiquzh749xBEgU7ZpGAo9A6WwQDpD18J17yhwmX3yNrrNeuRlOCWZiRLsiyiq
         3YoJX56ucgvX8HRomG2M5LJnmVJBCIEOSMLTZ6Urgqm5MTdi8c9JORYnLL5hglGCd1hM
         o8YX9cbhIRdIAbItNlS+kBEQUGv9nOrlbCuyRuEcE6GZV/+Mi17evhVbybo/Zi93OyCn
         jpPed+b8sntd0Yf8DyZRCRhPTPxlXbld9LL3Jb5SMeyoUN0cjm8kQP11+WQMfTRGmDXT
         Y5Kg==
X-Gm-Message-State: AOJu0Yw+cRMf1BGU9vgCkKJzKzV1i+UoKVh4UXo7ep7Anns/Fug6hPM0
	nnryZrMQQ+O3hqqrQKEa89qWWzMoOQqaA5r0AwG1cie7tLgX6VS3xnRicM8NQvo=
X-Google-Smtp-Source: AGHT+IE70lFCkuwxLy04y773kByi4EBxg1kHLlX5gBf9whXrkfN+wFvoxLtR775geiDFYHnuGFTFdA==
X-Received: by 2002:a05:600c:3ca3:b0:42c:bb96:340e with SMTP id 5b1f17b1804b1-4319ad317e5mr128437635e9.31.1730297025534;
        Wed, 30 Oct 2024 07:03:45 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd97d84bsm22498405e9.30.2024.10.30.07.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 07:03:44 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Stanislav Jakubek <stano.jakubek@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 6/7] dt-bindings: nvmem: sprd,sc2731-efuse: convert to YAML
Date: Wed, 30 Oct 2024 14:03:14 +0000
Message-Id: <20241030140315.40562-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241030140315.40562-1-srinivas.kandagatla@linaro.org>
References: <20241030140315.40562-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3871; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=UvOwIk+yZD27MovsiuLwpzcGLO9cpJAU/boRvjPd25k=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBnIjyic8resIB1q08zxH6OOB8ePA7EYXkJ8RrwZ Dil7lPzFoqJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZyI8ogAKCRB6of1ZxzRV N79kCACXbUGbuXEPQlqJl8muHrj3E+hShumWxMEQ4hIxIX10u8h5Hpy9JYXQqFBmbMltvqoz0B0 SNS+wvwHMcnMcEVEuKAlbs7GoY3sMzt0oupj34U3T4gVlf7I07ebM5tkPQtSzV5ycYAAkN9t57M NpJIwwUSPAgfKDwDVHq6otgrFaJn8Gh4L/5SJHd3GxBQYoPSLnHfkrIUcQq5a+YlZRFe1gVloqJ l4cBFsCueS86b/4Og5RTp9+0+wbVSwE5edSg0FH5AQcO3d7UEGKXA1HHwG8brxyvohpkHzBlR16 2BLn75Gnyv801YSPAV3HuX2X+bSOaMXKLd8nJJ8kMx66nbsj
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Stanislav Jakubek <stano.jakubek@gmail.com>

Convert the Spreadtrum SC27XX eFuse bindings to DT schema.
Rename the file after the only in-tree user, SC2731.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/nvmem/sc27xx-efuse.txt           | 52 --------------
 .../bindings/nvmem/sprd,sc2731-efuse.yaml     | 68 +++++++++++++++++++
 2 files changed, 68 insertions(+), 52 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/nvmem/sc27xx-efuse.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/sprd,sc2731-efuse.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/sc27xx-efuse.txt b/Documentation/devicetree/bindings/nvmem/sc27xx-efuse.txt
deleted file mode 100644
index 586c08286aa9..000000000000
--- a/Documentation/devicetree/bindings/nvmem/sc27xx-efuse.txt
+++ /dev/null
@@ -1,52 +0,0 @@
-= Spreadtrum SC27XX PMIC eFuse device tree bindings =
-
-Required properties:
-- compatible: Should be one of the following.
-	"sprd,sc2720-efuse"
-	"sprd,sc2721-efuse"
-	"sprd,sc2723-efuse"
-	"sprd,sc2730-efuse"
-	"sprd,sc2731-efuse"
-- reg: Specify the address offset of efuse controller.
-- hwlocks: Reference to a phandle of a hwlock provider node.
-
-= Data cells =
-Are child nodes of eFuse, bindings of which as described in
-bindings/nvmem/nvmem.txt
-
-Example:
-
-	sc2731_pmic: pmic@0 {
-		compatible = "sprd,sc2731";
-		reg = <0>;
-		spi-max-frequency = <26000000>;
-		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		efuse@380 {
-			compatible = "sprd,sc2731-efuse";
-			reg = <0x380>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			hwlocks = <&hwlock 12>;
-
-			/* Data cells */
-			thermal_calib: calib@10 {
-				reg = <0x10 0x2>;
-			};
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
-		nvmem-cells = <&thermal_calib>;
-		nvmem-cell-names = "calibration";
-	};
diff --git a/Documentation/devicetree/bindings/nvmem/sprd,sc2731-efuse.yaml b/Documentation/devicetree/bindings/nvmem/sprd,sc2731-efuse.yaml
new file mode 100644
index 000000000000..dc25fe3d1841
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/sprd,sc2731-efuse.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/sprd,sc2731-efuse.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Spreadtrum SC27XX PMIC eFuse
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - sprd,sc2720-efuse
+      - sprd,sc2721-efuse
+      - sprd,sc2723-efuse
+      - sprd,sc2730-efuse
+      - sprd,sc2731-efuse
+
+  reg:
+    maxItems: 1
+
+  hwlocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
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
+    pmic {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      efuse@380 {
+        compatible = "sprd,sc2731-efuse";
+        reg = <0x380>;
+        hwlocks = <&hwlock 12>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        /* Data cells */
+        fgu_calib: calib@6 {
+          reg = <0x6 0x2>;
+          bits = <0 9>;
+        };
+
+        adc_big_scale: calib@24 {
+          reg = <0x24 0x2>;
+        };
+
+        adc_small_scale: calib@26 {
+          reg = <0x26 0x2>;
+        };
+      };
+    };
+...
-- 
2.25.1


