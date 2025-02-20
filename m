Return-Path: <linux-kernel+bounces-524086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A94A3DEF5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C20E91894647
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A791FE45A;
	Thu, 20 Feb 2025 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g2cUMLWd"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0226C1B4243
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066101; cv=none; b=Q+2Lotgpuptyuc8ml10yUdiZH+KXA/L3GTRt6l84LWdDo941JaMOBpFnfgnlqJ6op+4pRjM847DmW4S1b8XSf/i1TQMXQf93JVnfGo7KFfsfmd8ddpysvqRr2zkQkTUEbwdXmbaQz3otGOW71gYnyP6g0S28oElalXiLZzNSXlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066101; c=relaxed/simple;
	bh=g7tyuwR9gUJihZXDPyoe71VF4DyU1ICECDXXEFnbpOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gsyOYtyT4mABK3mSEjSdoGwv2zX6rYDQGq+1JMQNh+In1hhxP9i+JTWX1Ra8fezqZYpC9pRpP17OGXEtWJBGLNLjOlGkinS7ej/wELv6V9FL6z3sZ3E16+dT63wU2q9q7x7eQJmYjKbbnNUAr/V5Hr8gkeMTiPy5yENMKeArE8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g2cUMLWd; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5dc050e6a9dso204374a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 07:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740066096; x=1740670896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nEYeQ6GtRcKGrYsaEJZjfB2MCXvU3nNrB1n4nbL63sM=;
        b=g2cUMLWd4Y3PGRoCatNDfFZ4c0o9WNW5466k1P5MSqA5mvgrRPktrGEwAWc8lVQRrp
         Szk2TI2hRwPp5xGs4c6U3DXJU7Goh7SVUUz+PoxKa3eMbc1KB9H4vKXj94aVHBIXMAP/
         GftQ4Let+em4FB/C70VTNrGwfj3Yv8intocmthWrPhvtO6IwOpSWAqk06UdzOc2r3nqJ
         xUuaRZNjJDwi1+cevDubw0tSTC+6pOI8IyHMfxVWtlR8NRgjVTfjRigGMcd4i6WxVCzE
         7SexP5aFcPqZspPfhAwv4i3QPp4fxK6JhE2ap5F3ZSApP6IlvPXHeOrN5PGxGoKPejov
         +8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740066096; x=1740670896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nEYeQ6GtRcKGrYsaEJZjfB2MCXvU3nNrB1n4nbL63sM=;
        b=Z6CJZnLpLdGikCh+HOxqcUmdgcfTe4Oi1HlAxsyp7BR9piIlf4860Nm2kUALByy0qT
         L+G0EeOUBbAyBm7w+j9PevCN8iBDGpRmt0F0HSFSnBGfQLq0DEvpcczHRkIUdtu4WhID
         4W7cJzPT29WGUELLQVbW2K9FYZG3dutWWRSe/M4GRVT9RwOVdBR34GArpW6vCfWkutTr
         HD6TFY8yrfGOtO+WxPl7wcUg5rexN9rwMWuYwgRsM6ZrsIiiy5AJr9yGL8EsirkueY25
         vccmSx+VG9BWALMtrdkvHOWmJQaXuydDrrI2k+6bM9C1dt8K1ekPkFP6WsrvjSafG14c
         tKJg==
X-Forwarded-Encrypted: i=1; AJvYcCU7UoY/CLP41pVc8+2gzJsLCFjuHSBcetKWAH70A1pvBJZWCPmRApPfGPMJff9q00g+P0jwgDLPn3Lqhmc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4k3NdGovpvNtpqTqsZMFcRnAr52zxt2alR+slAhO1qpjqAu00
	liDOWfjwbHysXRWi+7z2ilf/begB71RaB1CitNeoqKkFIUhnnM/OAF9x+0DX9k0=
X-Gm-Gg: ASbGncvmVkJ0YIkkCrHZKZ8YNK8vrOLiiuwY6d5QavF3mURCoqiH+DkRG4J9c75hTZe
	sO+BrTpKC+hO6h/eho8/wn7VcvvjnPxEe2SRg3m231kNX2NXfMLqDquZnOUU/2g/0MynURx7Zw+
	UpCAK+LA00G02WAqjPxuKD4QOVxA5jHMgHaNud+Q1kEOIfZ22I9yYAviRKA/H8ZE7uKv9gOBnU4
	HeFxOdu+Jx3qQX2eKswRdIJ9H8YNR6V4lirIiXVThpNrDoIknQA2sFY2oMSwhW8PimIg9ZqlB5u
	1AmNf69/jPPnWADpSIvAPhDJ3etnhefJ6ZzX8JlWb6LRJFo0vCKs3UbYUiL9hXJk
X-Google-Smtp-Source: AGHT+IExwKWWZGa3QQuOIsvL9AuraePZZp67jekYfmLrqefoxYMI+vPNlwgRQmppVbQJY0ggaquYhQ==
X-Received: by 2002:a05:6402:5246:b0:5d0:d183:cc11 with SMTP id 4fb4d7f45d1cf-5e035ff8110mr7633794a12.2.1740066096180;
        Thu, 20 Feb 2025 07:41:36 -0800 (PST)
Received: from krzk-bin.. (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece287c7fsm12097608a12.70.2025.02.20.07.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 07:41:35 -0800 (PST)
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
	Conor Dooley <conor.dooley@microchip.com>
Subject: [RESEND PATCH 1/2] dt-bindings: remoteproc: Add SM8750 MPSS and CDSP
Date: Thu, 20 Feb 2025 16:41:31 +0100
Message-ID: <20250220154132.199358-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add remote processor PAS loaders for SM8750 MPSS (modem) and CDSP
processors.  Both are compatible with earlier SM8650 with minor
differences:
1. SM8750 CDSP has one more sixth shutdown interrupt.
2. SM8750 MPSS lacks fifth memory region for Qlink Logging, according to
   downstream sources.  There might be other differences, because the
   modem currently crashes after starting.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Resend after some time.
---
 .../bindings/remoteproc/qcom,sm8550-pas.yaml  | 46 +++++++++++++++++--
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
index a24cbb61bda7..2dd479cf4821 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
@@ -24,11 +24,15 @@ properties:
           - qcom,sm8650-adsp-pas
           - qcom,sm8650-cdsp-pas
           - qcom,sm8650-mpss-pas
+          - qcom,sm8750-mpss-pas
           - qcom,x1e80100-adsp-pas
           - qcom,x1e80100-cdsp-pas
       - items:
           - const: qcom,sm8750-adsp-pas
           - const: qcom,sm8550-adsp-pas
+      - items:
+          - const: qcom,sm8750-cdsp-pas
+          - const: qcom,sm8650-cdsp-pas
 
   reg:
     maxItems: 1
@@ -114,6 +118,23 @@ allOf:
         memory-region:
           minItems: 3
           maxItems: 3
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8750-cdsp-pas
+    then:
+      properties:
+        interrupts:
+          maxItems: 6
+        interrupt-names:
+          maxItems: 6
+        memory-region:
+          minItems: 3
+          maxItems: 3
+
   - if:
       properties:
         compatible:
@@ -144,6 +165,21 @@ allOf:
           minItems: 5
           maxItems: 5
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sm8750-mpss-pas
+    then:
+      properties:
+        interrupts:
+          minItems: 6
+        interrupt-names:
+          minItems: 6
+        memory-region:
+          minItems: 4
+          maxItems: 4
+
   - if:
       properties:
         compatible:
@@ -171,6 +207,7 @@ allOf:
             - qcom,sdx75-mpss-pas
             - qcom,sm8550-mpss-pas
             - qcom,sm8650-mpss-pas
+            - qcom,sm8750-mpss-pas
     then:
       properties:
         power-domains:
@@ -184,10 +221,11 @@ allOf:
   - if:
       properties:
         compatible:
-          enum:
-            - qcom,sm8550-cdsp-pas
-            - qcom,sm8650-cdsp-pas
-            - qcom,x1e80100-cdsp-pas
+          contains:
+            enum:
+              - qcom,sm8550-cdsp-pas
+              - qcom,sm8650-cdsp-pas
+              - qcom,x1e80100-cdsp-pas
     then:
       properties:
         power-domains:
-- 
2.43.0


