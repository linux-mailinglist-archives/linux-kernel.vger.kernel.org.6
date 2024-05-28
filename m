Return-Path: <linux-kernel+bounces-193050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3818D2624
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D6E61F27778
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C01117B422;
	Tue, 28 May 2024 20:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GFuOpHU6"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BCC179665
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 20:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716929019; cv=none; b=VbG9AmlH6gPBRb+E9rjfItBs1FBeda4sjXyEd2scZAuWoHv7DaUG4+wh0lE5I3icAplfDJeXzPPzDxH40LcVl8WC44qaXeiXbJqkE/PVRE1FLVtp46bh6JKh+hT+R2PaFTbAwgvmWHjdOORoY7oTZXIobDkx7MxFlIv8zYSzKtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716929019; c=relaxed/simple;
	bh=9s74QROIdj/ssBLgC2P/yPwTNYf9hFSl4T/EYVO/gcM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jkP8bEOPdtH6BPPgVLOI8ttWWE1NFvqUxMT8WBMiOIFVfKOQQomaRY5xJ39xd5pb+3HreLMn/eorCjmAj7IZinUGODKU6XKU2QHOEsJnXQiXq+Hhzgju6uxojsYosZ7ZmqtRSR0zIqMO0+bW1c9bLiCUx/RVtfm7LQnYty8ak+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GFuOpHU6; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-529c05a8982so659605e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 13:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716929016; x=1717533816; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lfbFJurFvfU+tanl3sPE7BFrzTMfAJNeqDxbIYsOBck=;
        b=GFuOpHU6AHy7Rr5rTmivV+VbTMa7WmrpBjXfHPJtOyhYQofUJTp575Gy62SV+oVkJ/
         njasjpksjkNQ+7/cIoSYSV7ZE7G4K5SVbzZFteNqtRwUFd9kFQ+OvD05Xn0Re6RMHOEo
         yrpgCsn6u56L2YWSTbbhdF1mWzMpBt2XXJSVCG9osB//UQ/kpBCcgU4uQGlGymuNyLBN
         oxErRhay1btDEZawTWVpc5GuHt0QQxChbcILii+gnxqz8baif87BtQDRBGB9T++2pSZj
         FUl8d4cQp9fhScRZpkNUPclzhq4JnNF1V1kL0jpYAKv1XGZQ7fHIAQdzql3g+ymD1Le3
         jnlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716929016; x=1717533816;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfbFJurFvfU+tanl3sPE7BFrzTMfAJNeqDxbIYsOBck=;
        b=urBm5eVFMjXjXZrG/GNiWBikKOsCCFGY+hHoiq/NnLiif3YD73uFIRwaz8rTSfxhm4
         fBsO8moad1/5c62SNItrxcEFKPkAztFl6cHkvCwcDAtERerTc5eSLsVCm8lPxjRPcVAx
         Mxa4WDIV0+rM9MIHquoyRkttibRAjX7Jm6n3qGn7Q3UxKX50cHsMGYIk0boI1j3eVuhb
         5fow+I3dbSYMNIFacjTVqTejl1aug2ceqiBeLIl5nHH3cKiiaRcOizHZNZmfJvfddh9l
         36W6WYjWSECwfrjf9UE3DpNj608BicaMK+Co6hWr91ZeHv2cnaZj6No0sRzUWnVHmcKw
         3yVw==
X-Forwarded-Encrypted: i=1; AJvYcCWDCt1LDfzltlTpiQtx6QosnT2ngODE+Lif1D/Iq/pctD6IrUWpRpi9rQskcVnL9ikVN1Q2wYMNb1I7sMWqabcSw0RngKjRqyxI1SZd
X-Gm-Message-State: AOJu0YzLCMj7UIVnYGtgrQV3SQu8NRjlEJMXJ1VZiIMr1rXqnge6Idqh
	8PNF0C+Xd6LM70UxG4Sq5WUxNE06aMq2g6GJzWT1xHNcYSQBTV0PTs8+dreqN2Y=
X-Google-Smtp-Source: AGHT+IHYHXuOScvJxhTHoQsDr5e7r3sh+MeusL05wgkavlQt9gjMO0KEm42W758Kqgw3NFJOVJnnRg==
X-Received: by 2002:a05:6512:4801:b0:51b:e42c:2ec4 with SMTP id 2adb3069b0e04-52964bb1a8cmr8311539e87.24.1716929015772;
        Tue, 28 May 2024 13:43:35 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5297066b885sm1095493e87.127.2024.05.28.13.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 13:43:35 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 28 May 2024 23:43:19 +0300
Subject: [PATCH 01/10] dt-bindings: clock: qcom: split the non-PD schema
 for GCC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-qcom-gdscs-v1-1-03cf1b102a4f@linaro.org>
References: <20240528-qcom-gdscs-v1-0-03cf1b102a4f@linaro.org>
In-Reply-To: <20240528-qcom-gdscs-v1-0-03cf1b102a4f@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Robert Marko <robimarko@gmail.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2430;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=9s74QROIdj/ssBLgC2P/yPwTNYf9hFSl4T/EYVO/gcM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmVkH0ZLT9jQ32tNp7V9NTRcYxPnV9a7gJrfixM
 VLTecuQIOaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZlZB9AAKCRCLPIo+Aiko
 1fV7B/9/7Oj9mVPGNj9VASEnJSUSU37lfcviaOul0IUwCDeiNybOhCT7GxrcnaUVo3kfrvyQvVK
 SCzF9Ce9U0s2h6vQ6HjP9b5E+0U8+IgaZEjZE1HLkXuZOk+ZHrbj4SWmH2FYsxQTLmTPC5xM9YI
 XonWxUEZkEbTaILORSr1KboKMzKVMOXrq6FWyY3J5wG1H5qotkyV3hAGHPLU38hnu0qpMFFrXCn
 R/yZ4lxFfaczz2eLhYxG+9HVua8rXgAqtmOREwDlxV/sv6UV/w4mfsCNYK/2nh2wmGtdTmxrnvj
 MiUSEpKzGA+8OEpwVQzzVgMQzfV7Th7g6O9eprXZWI41ACzn
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

On some of Qualcomm platforms the Global Clock Controller (GCC) doesn't
provide power domains. Split no-PD version from the common qcom,gcc schema.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/clock/qcom,gcc-nopd.yaml   | 38 ++++++++++++++++++++++
 .../devicetree/bindings/clock/qcom,gcc.yaml        | 19 ++---------
 2 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-nopd.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-nopd.yaml
new file mode 100644
index 000000000000..a941e75a930a
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-nopd.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,gcc-nopd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Global Clock & Reset Controller Common Properties
+
+maintainers:
+  - Stephen Boyd <sboyd@kernel.org>
+  - Taniya Das <quic_tdas@quicinc.com>
+
+description: |
+  Common bindings for Qualcomm global clock control module providing the
+  clocks and resets.
+
+properties:
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+  reg:
+    maxItems: 1
+
+  protected-clocks:
+    description:
+      Protected clock specifier list as per common clock binding.
+
+required:
+  - reg
+  - '#clock-cells'
+  - '#reset-cells'
+
+additionalProperties: true
+
+...
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
index 788825105f24..e7ec15b1780d 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
@@ -14,27 +14,14 @@ description: |
   Common bindings for Qualcomm global clock control module providing the
   clocks, resets and power domains.
 
-properties:
-  '#clock-cells':
-    const: 1
-
-  '#reset-cells':
-    const: 1
+allOf:
+  - $ref: qcom,gcc-nopd.yaml
 
+properties:
   '#power-domain-cells':
     const: 1
 
-  reg:
-    maxItems: 1
-
-  protected-clocks:
-    description:
-      Protected clock specifier list as per common clock binding.
-
 required:
-  - reg
-  - '#clock-cells'
-  - '#reset-cells'
   - '#power-domain-cells'
 
 additionalProperties: true

-- 
2.39.2


