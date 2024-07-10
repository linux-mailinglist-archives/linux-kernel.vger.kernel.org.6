Return-Path: <linux-kernel+bounces-247533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD3792D0D8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 13:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D11261F23C92
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EC6190488;
	Wed, 10 Jul 2024 11:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bSdt83b+"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154D519048D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 11:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720611592; cv=none; b=qPS3W1AvlX/SJKqfNgH9cTH8UhprqMs8Mvtn2RBFagwj05Nqhkt1ew6NkAXEKLxUM4PQ0GT+LW8xFUfhXbQIFtXURpbTbmlo3lb/zs+gK/CTpJ5cUp4EQyu8skj+HZ1b50DvNyHeLPHK93j+EZy3bfhZZNbnhgiS8D5vGPvkbCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720611592; c=relaxed/simple;
	bh=kXcXQlQw8cCu7vUhvQQqw7fNx9k+D9plQJiW4hesxaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJ66U1wwSPCBZsboSe+5tJFeYd1mcXDqQaQiEBzRaKrVGdIcob26cSpTvwO+s0Qeyxau0CUw9f+0kNN5OvMnmlzJFNfyHUBFYmDud+v0YBTFDIhnFAG9JzIWVWTKN6PLksdGkoDyGqeYF/o3JWHh95V5aw7Fe1+wybJ57zgSA7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bSdt83b+; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52e98087e32so6957629e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 04:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720611589; x=1721216389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrw0KmyxDKt0z/+5CdGnxoQjpcekSUdd2Exq++60Pok=;
        b=bSdt83b+STqv3sRkm97i6CNTLb5vmyIPPBOtsDdCeR9q504OtYvtUZpnjR43P6rpQW
         QAKQGboF/VDP7rEtJ2hO307qIW7qFcTaQzOiqM1Yv6Q/lqFaa67Cu3RB+5RnPr4/Ey/T
         3BFXhJP4/k/B226e01Ve03cAXIZsoH1efsb56+VHOh3wNF60vZUwGm0MoaofXw7Pkrmt
         SzCQh1LFyalLhqpZsptgfkRM3vYiK736Ktu+nflInnVeg3jZC335nISUbCn/xJdK2D1V
         zAzsX9+VQEOPdGSJady+UoCoHQPirJgDQZPhMazvZROwz3SOKemvlMPdWcUR/4ttnfCo
         v4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720611589; x=1721216389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lrw0KmyxDKt0z/+5CdGnxoQjpcekSUdd2Exq++60Pok=;
        b=kiuXqO4wTzvtmUM5OhE05Gd6mCmPSFZYxy0/MsiHmTokyXkcFcly/T6cAUlXofYRSS
         GXvLHylbzg4hrH9p9CyyH+srO9VA8bzMCtNp8PcPObr1KAvMKMwjHA3ycVCfjmG8XRbs
         qClsDMeJasmwRUaPkAjw4TGGESvIEprZRup7n6sATlss80/RwXnbyVaLacCXOHtPA5fR
         rNFOZTIdrZcMo6J6grxHmnpfP06yYduKV+JczKlizsG/pdwFmxHqaALlXnCpjpBei4OJ
         xbnZy7ntCDCym5PNnRX6AK/s+1raYKPOVSLmvO2d06LtUvS2E8kNClE5lAd7cRffJMTS
         aE3A==
X-Forwarded-Encrypted: i=1; AJvYcCW5Xvv8wJbQtodwX5WFvnWyTrNrIiRLwKKOsPCFvOne1ajM+r5Sgar32JhVV2xZmthGAe7pbUoMavgKYGnp8uNN1MGXpxKtE08MRSeF
X-Gm-Message-State: AOJu0YyeN20icn48UIM3xQyftg5bLIPZ+4T1BGHScR86IDINTb22ruyc
	XUEwbl/gNpXLmFtpIh0+36cKitzbEUFeWk0E0He/Y9xwfIWkTAnkacavV3vY5uI=
X-Google-Smtp-Source: AGHT+IGCIfQQFWizC9oYA0R7wEwIwKOXXTqvLbF5U7LfpTs+Ls/Zyvmg+QDt0ocqWOmzblGuzvrQSA==
X-Received: by 2002:a05:6512:b0b:b0:52c:a724:5ae3 with SMTP id 2adb3069b0e04-52eb99cb0admr3854086e87.51.1720611589220;
        Wed, 10 Jul 2024 04:39:49 -0700 (PDT)
Received: from rayyan-pc.broadband ([2a0a:ef40:ee7:2401:197d:e048:a80f:bc44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f7361b5sm78602875e9.29.2024.07.10.04.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 04:39:48 -0700 (PDT)
From: Rayyan Ansari <rayyan.ansari@linaro.org>
To: devicetree@vger.kernel.org
Cc: Rayyan Ansari <rayyan.ansari@linaro.org>,
	alsa-devel@alsa-project.org,
	Banajit Goswami <bgoswami@quicinc.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 1/2] ASoC: dt-bindings: qcom,msm8916-wcd-digital-codec: convert to dtschema
Date: Wed, 10 Jul 2024 12:36:06 +0100
Message-ID: <20240710113833.39859-2-rayyan.ansari@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710113833.39859-1-rayyan.ansari@linaro.org>
References: <20240710113833.39859-1-rayyan.ansari@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Qualcomm MSM8916 WCD Digital Audio Codec bindings from text
to yaml dt schema format.
Make bindings complete by adding #sound-dai-cells.

Signed-off-by: Rayyan Ansari <rayyan.ansari@linaro.org>
---
v1 -> v2: removed unneeded minItems, added ref to dai-common.yaml

 .../sound/qcom,msm8916-wcd-digital-codec.yaml | 55 +++++++++++++++++++
 .../sound/qcom,msm8916-wcd-digital.txt        | 20 -------
 2 files changed, 55 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-digital-codec.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-digital.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-digital-codec.yaml b/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-digital-codec.yaml
new file mode 100644
index 000000000000..a899c4e7c1c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-digital-codec.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,msm8916-wcd-digital-codec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm MSM8916 WCD Digital Audio Codec
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description:
+  The digital WCD audio codec found on Qualcomm MSM8916 LPASS.
+
+properties:
+  compatible:
+    const: qcom,msm8916-wcd-digital-codec
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: ahbix-clk
+      - const: mclk
+
+  '#sound-dai-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#sound-dai-cells'
+
+allOf:
+  - $ref: dai-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-msm8916.h>
+    audio-codec@771c000 {
+        compatible = "qcom,msm8916-wcd-digital-codec";
+        reg = <0x0771c000 0x400>;
+        clocks = <&gcc GCC_ULTAUDIO_AHBFABRIC_IXFABRIC_CLK>,
+                 <&gcc GCC_CODEC_DIGCODEC_CLK>;
+        clock-names = "ahbix-clk", "mclk";
+        #sound-dai-cells = <1>;
+    };
diff --git a/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-digital.txt b/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-digital.txt
deleted file mode 100644
index 1c8e4cb25176..000000000000
--- a/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-digital.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-msm8916 digital audio CODEC
-
-## Bindings for codec core in lpass:
-
-Required properties
- - compatible = "qcom,msm8916-wcd-digital-codec";
- - reg: address space for lpass codec.
- - clocks: Handle to mclk and ahbclk
- - clock-names: should be "mclk", "ahbix-clk".
-
-Example:
-
-audio-codec@771c000{
-	compatible = "qcom,msm8916-wcd-digital-codec";
-	reg = <0x0771c000 0x400>;
-	clocks = <&gcc GCC_ULTAUDIO_AHBFABRIC_IXFABRIC_CLK>,
-		 <&gcc GCC_CODEC_DIGCODEC_CLK>;
-	clock-names = "ahbix-clk", "mclk";
-	#sound-dai-cells = <1>;
-};
-- 
2.45.2


