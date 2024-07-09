Return-Path: <linux-kernel+bounces-246161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0924192BE63
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32E2AB20B62
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F28519D89D;
	Tue,  9 Jul 2024 15:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="USC/nyOG"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0409C19DF52
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720538930; cv=none; b=ao4yHcZ6w67yybB+dXqegh31wmQsyA+GDQ5oDRZSy2ZGp02D9/YmzwW4YF3I4sNWOvWAWUu2iytpyi33UfRtYFkgdBCvYZA+siAIjq0gnBasnN2Y/TaFSjwuJsG0YEwl0vv3ZNab23lz5saNS6x/yVEDkfUNdi09Bmo99p/HpA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720538930; c=relaxed/simple;
	bh=Xq8uJAy88lv1uxCiheZGM9OSarqyJTMwcEDG1B96A2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gWU+0Ea/j5pbpeoW+LhKJx4Ebrpy4VDhQzfx+agDCjoAVD/Rl3hYgBEFAPbHTCVl2kv/iLCNw/8q/y5P/n+yausOs93etxeXx23zde1NfHpQV9pOQq0LHLkC9MGrQt43zhyFxiVsFpJyqwc6HDCPAZpw+UWYshQIMSxhLUE5xcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=USC/nyOG; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4267345e746so6168665e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 08:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720538927; x=1721143727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNtSueuDtXsARVEbcRgGrAWRHcIqldsm424wzohUyiY=;
        b=USC/nyOGym9uD8D9PN4NldFBkE0D/SuRbr/fdEdx0zKNph4f0yOz/Imit4zsHVeLv8
         yII0uFILGQTf9xj4x4mS3v8VC2l5xY1WEI44oC7tXfhSXodz0gTfUIvVKEXLel5T2pC/
         ZsEiij8+/xe2CabCfPzLzEzyk0Rr9qPd+BZJT6222wAWV8oqCG6FSA6tlfSwuWwEvwjN
         4lzyvW/3qC4Q+CyPlMi+xBvr5+mPP1GFMrn0cQrR1haAi+060eqvi2rFRrc0Iuj+4/Li
         QXT1Tj9oLg+QfCpmlPkE0ukI8J8EyhOCFAdPxu8boqfJkFU/ArvXq76MragiV+rIKD3F
         RteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720538927; x=1721143727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNtSueuDtXsARVEbcRgGrAWRHcIqldsm424wzohUyiY=;
        b=bn9iHZp1wTlQslxn74B/+0fL7TMuihKgs67eT0CA/rsjkcegkakN89pWoU94ftzaIB
         IKBCATqRr9hwNvYA8bSCKpQ7Nus//79qcd/ik37VoQnQyEygkczTNBfHDEjXFDEWPS3E
         vfEhztdYpwsYPQ5VmRmTCgdbEZid/yu/Brnz+ZpJXumaOUrlnr/6f0r5tgNG+1iigWVy
         h19y21v7x9PMMABKF+Uio+qJIKxBXB8nXohMyZSeH6WUWTY9EE1KnPbJuuZBHrpZsdfg
         XWOAYvaKn58jSJawfYr3UrnR302mOgGqgejo+KIfmJrzlQbzIqvzecSI/itKVMHYKIsE
         aDnw==
X-Forwarded-Encrypted: i=1; AJvYcCX5vdyb1kH22ETYCAd2ocZVwxhtuoqut+DgisHgjDlHJ5PW5GvM+WKGaTHuTuEHCESOi6Lk7h6H92WWQBqR0nq3Zxz3ti+p+w0Di/Lo
X-Gm-Message-State: AOJu0YxCXQya3pn10715vouT36uQRD7pjgbwHBimHb1s/gXYfZOD7yPd
	9qacru4ReUq+OoOb9OVsL+ac4/V0BWhV1bjL81p+U1cgGJt8BrOH3Vl9LrkU+IY=
X-Google-Smtp-Source: AGHT+IEiiEdiOEJvS824Y/O3HEpYDyOdjBG53LXdLiwlz6IeDKbNx00nUjCQ8cB6GpjwQh1jLEsC5w==
X-Received: by 2002:a05:600c:4a05:b0:426:6618:146a with SMTP id 5b1f17b1804b1-426707cf1c8mr19505775e9.2.1720538927353;
        Tue, 09 Jul 2024 08:28:47 -0700 (PDT)
Received: from rayyan-pc.broadband ([2a0a:ef40:ee7:2401:197d:e048:a80f:bc44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6f5a32sm45883775e9.24.2024.07.09.08.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 08:28:47 -0700 (PDT)
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
Subject: [PATCH 1/2] ASoC: dt-bindings: qcom,msm8916-wcd-digital-codec: convert to dtschema
Date: Tue,  9 Jul 2024 16:24:42 +0100
Message-ID: <20240709152808.155405-2-rayyan.ansari@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709152808.155405-1-rayyan.ansari@linaro.org>
References: <20240709152808.155405-1-rayyan.ansari@linaro.org>
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
 .../sound/qcom,msm8916-wcd-digital-codec.yaml | 53 +++++++++++++++++++
 .../sound/qcom,msm8916-wcd-digital.txt        | 20 -------
 2 files changed, 53 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-digital-codec.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-digital.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-digital-codec.yaml b/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-digital-codec.yaml
new file mode 100644
index 000000000000..5e7d15b61ad6
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-digital-codec.yaml
@@ -0,0 +1,53 @@
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
+    minItems: 2
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
+additionalProperties: false
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


