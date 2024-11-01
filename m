Return-Path: <linux-kernel+bounces-392612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A6C9B9634
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A646C1C223D2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A5C13777F;
	Fri,  1 Nov 2024 17:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hS5vwtwe"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B711CB31A
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730480596; cv=none; b=p17JjrRU+iKFCum44zdyRz88XLbzUOYgVzLJaYbgPnHq3i1/u2b+9kimOwkN6/CAgmNq1CjFrV+HXQS7aEVH1PLTFGo1QkZrP5i7/7Y+0pf6HrIYSVXDLLaZRmBoIhFqyJwlDV3ZYcYb1o1QlkEbRUxlHKt5ryTwIXUWu/X69UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730480596; c=relaxed/simple;
	bh=hMCCbLDioYy+Gyryrg/qDlm9Q8ImU8TUBBfa89jXyLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cdJ84cVhdfxcpnYVW+wf4krBTyr8QAofZ/qVfWz08cbVwIyv5p+Q4ej6CHrdGC2z6RzayNauNlAnwX178DocCWPH4fY1pv+UovUasQhx3E7RTyVJOY6plEQUEfFjrr0m6cTsetTiyfkxWkFxH01CRgf8yY+XyLi45JSfvPUjv24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hS5vwtwe; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d4dbb4a89so210838f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 10:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730480592; x=1731085392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q3NYpsGTgrceer71ppOAoBgRk89YYUeZ50Pg0gfV+Bk=;
        b=hS5vwtwemZXn2RA1q8n+A5yKbG/9BhXrrWJEZEY7lizErSQ1SQTyMWi4mK86yF3Vhw
         6um7XUf/CPCMX6LEOwSp6UKSNMETv2BtkUbJSmFipA5dLW7MNrsrltsPuEko+thPzTAD
         g7kwrE3CuFrz/uEVHcoHvGJlmksXMUfxex47G9OGFPTVWPHjSC60qKx0h4KjO7YfQ9U9
         M+X4sfedy9Vd3+hklxLII6mcRUQKdcZBy2zTZgSTm1ZwOSoC1QphMpIxclFmm0dghh0b
         Gfi4igFFRE46twprPHiXRH0TySIyQY0RjAiNVUT7YbRuU62q6IO9F8QHgFgvzlXQpt5h
         bKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730480592; x=1731085392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q3NYpsGTgrceer71ppOAoBgRk89YYUeZ50Pg0gfV+Bk=;
        b=nRJPHlhLryw0WLqr4M225M5mKYHg6M9WRIS1MazgMRSXY8W6X/Qmk6Lhgty8ZqcS0z
         2464TDo5TfqoufISHHrl+rylsgOlYgCQzWZqmGTU3jU3jJy+OnB6aWoLSgyOOJJCi+8y
         pV93apio0G0M5pyW2y33+VxbsTPMYiIme6GR35mRwtY4ASqnfpd6OxGIju4j+WaevAYZ
         UyAwdg0eg08oeuqPI09NCU3YFjrY7Wj+4dQ7jiXMrs9kmy5JgK2vQ/lT5RPiSt+C3R7f
         tCsvd9vrbKVBu3aOG76tf3w9kIXINk+KmpHNShGZxiSG0JostmzPYYG9uzRFkqivXQlR
         VJBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVib6hpTFMPD0AwQyoLjohGWdgyxW0C4ZvJ3oqBPFrHVYEs2u8BGz+2Mzf9pfMd1xNSO/cYhRSDGtbhORk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1y2f/v5zsbw5/UKaAWltNPC30fmzrSZGqcwV+fJBQ4eDEONLH
	aJmKc/Tqqh3caaowN44n+Rwn88eLLN1iL38URvCakji6PG3EvG7kK1VdnwnJu6U=
X-Google-Smtp-Source: AGHT+IFCZ23WEBwwcLfQP4WYBJ1WQPAvLjnNpkz+Y58FV/YsX35Y9/WCJ4gXDC+pJP7nEDi262mLrg==
X-Received: by 2002:a5d:5f46:0:b0:37d:4aa2:5cfe with SMTP id ffacd0b85a97d-38061173287mr8248808f8f.6.1730480592542;
        Fri, 01 Nov 2024 10:03:12 -0700 (PDT)
Received: from krzk-bin.. ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116ae82sm5687923f8f.93.2024.11.01.10.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 10:03:11 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Melody Olvera <quic_molvera@quicinc.com>,
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] dt-bindings: remoteproc: qcom,sm8550-pas: Add SM8750 ADSP
Date: Fri,  1 Nov 2024 18:03:09 +0100
Message-ID: <20241101170309.382782-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document compatible for Qualcomm SM8750 SoC ADSP PAS which looks fully
compatible with SM8550 variant.  The only difference from bindings point
of view is one more interrupt ("shutdown-ack").  Marking devices as
compatible, using SM8550 ADSP PAS fallback, requires changing some of
the conditionals in "if:then:" to "contains".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Melody Olvera <quic_molvera@quicinc.com>
Cc: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/remoteproc/qcom,sm8550-pas.yaml  | 48 +++++++++++++------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
index d7fad7b3c2c6..a24cbb61bda7 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
@@ -15,16 +15,20 @@ description:
 
 properties:
   compatible:
-    enum:
-      - qcom,sdx75-mpss-pas
-      - qcom,sm8550-adsp-pas
-      - qcom,sm8550-cdsp-pas
-      - qcom,sm8550-mpss-pas
-      - qcom,sm8650-adsp-pas
-      - qcom,sm8650-cdsp-pas
-      - qcom,sm8650-mpss-pas
-      - qcom,x1e80100-adsp-pas
-      - qcom,x1e80100-cdsp-pas
+    oneOf:
+      - enum:
+          - qcom,sdx75-mpss-pas
+          - qcom,sm8550-adsp-pas
+          - qcom,sm8550-cdsp-pas
+          - qcom,sm8550-mpss-pas
+          - qcom,sm8650-adsp-pas
+          - qcom,sm8650-cdsp-pas
+          - qcom,sm8650-mpss-pas
+          - qcom,x1e80100-adsp-pas
+          - qcom,x1e80100-cdsp-pas
+      - items:
+          - const: qcom,sm8750-adsp-pas
+          - const: qcom,sm8550-adsp-pas
 
   reg:
     maxItems: 1
@@ -82,6 +86,20 @@ allOf:
           maxItems: 5
         memory-region:
           maxItems: 2
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8750-adsp-pas
+    then:
+      properties:
+        interrupts:
+          maxItems: 6
+        interrupt-names:
+          maxItems: 6
+        memory-region:
+          maxItems: 2
   - if:
       properties:
         compatible:
@@ -129,10 +147,12 @@ allOf:
   - if:
       properties:
         compatible:
-          enum:
-            - qcom,sm8550-adsp-pas
-            - qcom,sm8650-adsp-pas
-            - qcom,x1e80100-adsp-pas
+          contains:
+            enum:
+              - qcom,sm8550-adsp-pas
+              - qcom,sm8650-adsp-pas
+              - qcom,sm8750-adsp-pas
+              - qcom,x1e80100-adsp-pas
     then:
       properties:
         power-domains:
-- 
2.43.0


