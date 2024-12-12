Return-Path: <linux-kernel+bounces-442414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F009EDC78
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 01:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C446018897BC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 00:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFBD63B9;
	Thu, 12 Dec 2024 00:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DKxwVjDd"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269816AAD
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 00:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733963159; cv=none; b=GrRPDKRWILC9iWvv/MNcDdnFifT1Dw+aVLrjXKzGJjP4cn201rn8bQR26ZoXbyK/HwXYf0el9r/6A8g/t3Ig6vehWdgzBkuLTnFBfXSs9rULk1ul7AZIt3uzcdEMprgkdykPvalHFxADvNfZHCnTkwKdkV7nTXaz8uF0gjml3H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733963159; c=relaxed/simple;
	bh=VSz6u0OmMTsrtnLmZvPYijuoFZ3V2heCXlt5BgEegSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m6vSvFcKOlp+q5AB/TMfqEP26yseqiYs3AgFGC/yyTlkEyY+7uBPnGzeRLFRK1TYDKiiR4dcpErjfgX2NkgPPM/2MkJ/tD4L/K5sCq24TXghyYLAU2OqOsoBpnzY63GAkp8XICAf47jVNT8+rWTIy93b9y0J/IwXJD2ZNkKgzEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DKxwVjDd; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4361d5dcf5bso309455e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733963155; x=1734567955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2CwB4Qts6MAXahbsrdAc/r1Nx/s61A4u9eeqlNVrd8M=;
        b=DKxwVjDdzUvhwER+3UPG1Ei+L1zbfYVpFemAKr1gpEUZiYqQEICd610WqOQb7kHmrX
         JYH0lSBaILnTdUMZ0XeTRy7ej+Hjv/UeBmAW/7h1mqMhKjymlMhJQe2jtLeWed9chKId
         Uy+NyFnmipSuhgO+dKcsVl8Qhikmt8zD8h6KxEMQD82AOBqRV7tQUqVgmM8tWEyTfPIT
         0oXBBhTfKXv7mGawB63nk0zsCS86YsrWJKx4qznbzZha/GZGdAO1Ie3qpoOh4ObneGNu
         wKSBRLs5KtV5wDj4/TF5HmdPbdJK6sWe21W1BnUiMOi5uhszkWx8S3GOeliVBh9nQh+L
         LVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733963155; x=1734567955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2CwB4Qts6MAXahbsrdAc/r1Nx/s61A4u9eeqlNVrd8M=;
        b=ZSFI6C3+WC6xm7gAvxR31dYqG+cXJovdAKsnlaEaUnSGB+04r2TZURhb7Cbp+XDNVo
         ZdpVDXYLB00qXCAyYaJzW3NDZkrebGwk4dS9Z1js7AiOpnrsDIDfk3EmzaPo25Mb74Xx
         q13E78BsUnvasDxO8WTnwbIVEHpcEnnl30iWbVtUVHC4ubryr+QpmdOjGWcyQnidrpxq
         8N751ZU6+OWzcQ4ImO19/AYpOAk25W/+am3sLIBWL3Ouqksbe95cWXz+8sb6OaiInfYZ
         IY1Z46Y1Gxw0u2L5oICcISoCUkOre8SGGzrDV8lsJc+orTF1QewhjSahWGEif2rfBg9f
         fvoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv9Q5pzXDJ4YUGNDYEPCZ4lewDv/w+Ync0i+xMwveteo/jFWBB37peErZ7R7UPFcutXd+y9+avLlN6tEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBQ55HJD2SG3mZ6m3BgdfHaVGLNo8GazV0D2CN/oCBhogL0GgO
	pePMuKABWGVXIyYK1ZwPHnt2g9XLeqq+O3EWfaFw7w3h6YLZJACIcLKQG02B+3U=
X-Gm-Gg: ASbGnctw4oIS8/ylXVGeYhEBxGG9SO5201OvqiI124moZEPqY8IivZwneIP2ePeoV/b
	z9c2+uutEt+iryW894qTXe+XvqgGzBIrVmVAtEtEgjIaKQN4cE8mwXV5kzc+9z8bPLN/pFrQ2QH
	090LXKOJpnUkpeTTnkAfSoOIyEt4vYAx6EI8C30FByXZViCQEn1uYn4hvH2IsAjA87XwvWnFfHv
	bgiMsW5MNRSlt8+lqlA7Vp6IxFxtz7NoBFHOVTyt+CzufrP1Jtka5oGUrYAN7/ViAmntKH4
X-Google-Smtp-Source: AGHT+IGewZ2z2IqE90vllYh/bn/+uyDjmucW9rlC3njOtz/uGCDCzsIBsNpq2nCLNEzu2+p+2Qc21Q==
X-Received: by 2002:a05:6000:1acf:b0:385:e37a:2a56 with SMTP id ffacd0b85a97d-387877dc7bamr991607f8f.52.1733963155437;
        Wed, 11 Dec 2024 16:25:55 -0800 (PST)
Received: from localhost.localdomain ([2.222.231.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625553333sm46095e9.6.2024.12.11.16.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 16:25:55 -0800 (PST)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: andersson@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	krzk+dt@kernel.org
Cc: konradybcio@kernel.org,
	konrad.dybcio@oss.qualcomm.com,
	robh@kernel.org,
	conor+dt@kernel.org,
	srinivas.kandagatla@linaro.org,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 RESEND 1/2] dt-bindings: clock: Add Qualcomm SM6115 LPASS clock controller
Date: Thu, 12 Dec 2024 00:25:50 +0000
Message-ID: <20241212002551.2902954-2-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212002551.2902954-1-alexey.klimov@linaro.org>
References: <20241212002551.2902954-1-alexey.klimov@linaro.org>
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


