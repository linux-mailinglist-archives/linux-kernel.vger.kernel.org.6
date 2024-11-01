Return-Path: <linux-kernel+bounces-391533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9417E9B8854
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 02:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24602282B08
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 01:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C02A12AAE2;
	Fri,  1 Nov 2024 01:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mys92O3J"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6761C4E1CA
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 01:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730424180; cv=none; b=jhlE+MY0YoTVhxhLSH/+Yn3pkL0LSGV3BYjG1rO09Zh9M4vv+KEiUcQvliBLyL2doz9Gi7+FdK3FK0i7znyNQExQxae0UljEa7BXidS646vldezF8rGQX/VDNvFxX/q3JH1ii4f8wiCZHGly8jYM+fkkFEWKoH89hCOiJDYL7N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730424180; c=relaxed/simple;
	bh=VSz6u0OmMTsrtnLmZvPYijuoFZ3V2heCXlt5BgEegSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rXvZZD/e62xnY9efQxU8qE7hjznOdDDdnatGVyblALklnRsLEiDBsyGOcTX468p9iSMqoTuFWnHR/rcYpPzkyKdsq9WOJURSPEd3Z9vG5ggRelytb7qCYCBU/YAIHI0ZYig5LDVORy0ZVcp/LqYqX5r7NHGauNLtl5u8SBYpQu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mys92O3J; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4315839a7c9so13187085e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 18:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730424172; x=1731028972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2CwB4Qts6MAXahbsrdAc/r1Nx/s61A4u9eeqlNVrd8M=;
        b=Mys92O3J0aXg8B3v49tWuW178+7jHV2LOwX470/ffWPkgRRqfj6Qt0MckUuGrfdRgZ
         Q8ihdtOJrNbnflfkqGB+fUhnNbpbiCiJAJvD8bUuGY4YOwFwc9zBlaa0V0Z4OTphdg2G
         An/BSTgvsgLce4k5d0GdyoGJ6MBOL9A5zBvvzx8Iq30WbmkOyYDH1XLRbllORKny5uBp
         1hRo5XXn6L2yAT1pE+lJHeRHQcwfnqp58ku5WzrjFJlnysRFSDCPD+j0RWTjL3lJvQEZ
         3vxLe0+E05qRDyu3gs3sfQV+TchhMud4PXIb7nFEzevvxS/Iry6/Dp/mnjSRIkOIP1ut
         0lHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730424172; x=1731028972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2CwB4Qts6MAXahbsrdAc/r1Nx/s61A4u9eeqlNVrd8M=;
        b=he7VuSqkiAEQaglYgQ+O1c86F+3YGTQyP43XtgtOe+e52/ZeyJRlws0Xrt/6w3g+H0
         XDCYiAevtRKWJQiQ3/nsAuatsB5obMgRtipetc7vFj9zsze5OB58S6TcD3hjZrGSMFB9
         bSqUaql5rjHFFS0jRX7r06TjVh/wIA6fXdPXzr91gUZf0lFVHOQiZZtwV5a5EduN0y6e
         5vfDM/BWGfColUEha3TyWoyqIKBV2slReL9QYF5MMtmQvG35S3kWNuer8jLVlljkN07a
         3px4Fg3fSFVJ2CTfywYvbwQuW6AHETzcQRDKgoqzK94Xa3jXr1GruNStojAQpofLu8ca
         kFFg==
X-Forwarded-Encrypted: i=1; AJvYcCX6206csv8mGESVoX92s8wlWFtU5vfZ5hQrDZrkGzwOKGyuLl+FLMncrKApjcyaxjxRnspWNwaqMTxPtsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUwSOse776c9BG9pjFrGl6p5+HIRgVD9KWYmWBQ4n3FYIZnBva
	ErEYS91t6aqFI5Dwc6v/xTHS5MW8RwO6SjD8JOKIqn9oncLzyevH37kuJ6eyVqM=
X-Google-Smtp-Source: AGHT+IEtemOwpedOmfVlJL21AxprSY5tnd5BjFNat2smNw6pLx0lFewLg+wqDtkiiHAaI9fxvvtOeg==
X-Received: by 2002:a05:600c:4f4a:b0:42c:b9c8:2bb0 with SMTP id 5b1f17b1804b1-4319ac70637mr175039615e9.4.1730424171652;
        Thu, 31 Oct 2024 18:22:51 -0700 (PDT)
Received: from localhost.localdomain ([2.222.231.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116ad3fsm3501622f8f.95.2024.10.31.18.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 18:22:50 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: konradybcio@kernel.org,
	konrad.dybcio@oss.qualcomm.com,
	andersson@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	krzk+dt@kernel.org
Cc: robh@kernel.org,
	conor+dt@kernel.org,
	srinivas.kandagatla@linaro.org,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmitry.baryshkov@linaro.org
Subject: [PATCH v2 1/2] dt-bindings: clock: Add Qualcomm SM6115 LPASS clock controller
Date: Fri,  1 Nov 2024 01:22:46 +0000
Message-ID: <20241101012247.216825-2-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241101012247.216825-1-alexey.klimov@linaro.org>
References: <20241101012247.216825-1-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konrad Dybcio <konrad.dybcio@linaro.org>

SM6115 (and its derivatives or similar SoCs) has an LPASS clock
controller block which provides audio-related resets.

Add bindings for it.

Cc: Konrad Dybcio <konradybcio@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
[alexey.klimov] slightly changed the commit message
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 .../bindings/clock/qcom,sm6115-lpasscc.yaml   | 46 +++++++++++++++++++
 .../dt-bindings/clock/qcom,sm6115-lpasscc.h   | 15 ++++++
 2 files changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm6115-lpasscc.yaml
 create mode 100644 include/dt-bindings/clock/qcom,sm6115-lpasscc.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm6115-lpasscc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm6115-lpasscc.yaml
new file mode 100644
index 000000000000..247b6b0a9f5a
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sm6115-lpasscc.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,sm6115-lpasscc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm LPASS Core & Audio Clock Controller on SM6115
+
+maintainers:
+  - Konrad Dybcio <konrad.dybcio@linaro.org>
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description: |
+  Qualcomm LPASS core and audio clock controllers provide audio-related resets
+  on SM6115 and its derivatives.
+
+  See also::
+    include/dt-bindings/clock/qcom,sm6115-lpasscc.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,sm6115-lpassaudiocc
+      - qcom,sm6115-lpasscc
+
+  reg:
+    maxItems: 1
+
+  '#reset-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    lpass_audiocc: clock-controller@a6a9000 {
+        compatible = "qcom,sm6115-lpassaudiocc";
+        reg = <0x0a6a9000 0x1000>;
+        #reset-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,sm6115-lpasscc.h b/include/dt-bindings/clock/qcom,sm6115-lpasscc.h
new file mode 100644
index 000000000000..799274517c9a
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm6115-lpasscc.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023, Linaro Ltd.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_LPASSCC_SM6115_H
+#define _DT_BINDINGS_CLK_QCOM_LPASSCC_SM6115_H
+
+/* LPASS CC */
+#define LPASS_SWR_TX_CONFIG_CGCR		0
+
+/* LPASS_AUDIO CC */
+#define LPASS_AUDIO_SWR_RX_CGCR			0
+
+#endif
-- 
2.45.2


