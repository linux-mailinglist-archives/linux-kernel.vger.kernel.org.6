Return-Path: <linux-kernel+bounces-518220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25124A38BAA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF83C16481D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 18:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CAC23718D;
	Mon, 17 Feb 2025 18:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oQk7CtwQ"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9287235BFF
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 18:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739818586; cv=none; b=PmRHjRvAxS+Ff7SKwY/z0XmfvYKf3RDFmLWutKXgg9BLhtPKIZLgKHCVqu/DyEb1r1PhD2Zy42gFOHY4i+wdvqgMvIQ8Vd8R/Gf4Wsb0yJeyj2FYM3RycQyvjKYNiDPjnRwSnjYE8S+gwUjoiF4GAuBRb8tXa8Qz+SP35SdGvII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739818586; c=relaxed/simple;
	bh=H82/mjIwe1bn5g0vrkR5c3LtXjJgPihFdpxO7CtcYlg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EzHVWmMddSeJM2P0p5hQsJagydEx5ceJ6t+5iHz1y/0lE8+AhiO9sldawSBZzsi49WuE7Ae2qB7DkP+G8go2c4im6pTHaELiMU3KYe4hEMnpfB/TE6pusG8iTU2LD8qYwn+EwFnUjKKZFQrjIq3RIzqSVYw5h2v3XZr9re8ToNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oQk7CtwQ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5453153782aso2162835e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739818582; x=1740423382; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qw6XAk1G8/C1Ik+qSgwe4qm3bLoWXPlX8U0n2KP3mBA=;
        b=oQk7CtwQ/L6FaImC5QGQCf8Rv4x5V1XSjh84Oki4PlCKnVs3QNwzUaGRe7nXCAQiGG
         wD+pOvLUdoUYyTPuggX+9t7AnCQU5al7FfBeKJzLrykHbrsCFBusxLtp8RgTzl/GzqOh
         xqv2FhyH9/XerAH3lPqSlDBVGNzWdji1GZGLdgCnIHsp2MjsFnjWxy+9Qe3u4M5iYp/U
         2kQiVf2aoEKBoHf5AdtpVDA9nXlrj1iriDdYK+ZixDOzc1x6/cw96QvFik1btwtfSHFc
         iE0m/8GKHxSmci+FnT9EuFbFUD/g1JByGyK0ij6ZI8nUGVMnMCks2xWvPl8vPgA8INeF
         Tk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739818582; x=1740423382;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qw6XAk1G8/C1Ik+qSgwe4qm3bLoWXPlX8U0n2KP3mBA=;
        b=BSLYOwiR78BPJi/2hLcir/879Tpwo/pbOEEpXgGrEXnHHGE6O+fLrJIaF72EwSC9uh
         nBPLFlfqdqsGAAdE1sVEx0mpluBSCX+YEz9Hqj0/k3jOpg2TUIO4ZUYMo6GvrRuCpnrP
         vUU+TTnP3tkJmGXQgREA0N34adO0KUuGPRwJWNS5rAvQXdJo1ZUa+RuwkaaSD0Jt+zRY
         684dJE47j0/jcwVvdBMZ4w7Di+rxAh5TWE9gQuKG0gFFy0smIrxTh9csIsQXZuQzviVo
         EXwNUzr3k9WVb1US/aXXgPCQfcFsn3fLvp1snBc2ar5vVVSCqQTRIc9AXeWu5HxnSRg2
         2rkA==
X-Forwarded-Encrypted: i=1; AJvYcCXHgaxBlqWbSAhmYz50ZSqx7KlnNjWV4TptBdOk883M7bhrO6i8xubXl7iIykEhggJEdEIQTTBg135lyuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIxqstjECb6KnXxq2ULm0YNXKFVMVsyH8uQs7nqsl/EPy4nuBi
	rMgNHRU+VDDPRXIiyD8Ov6SsWvhqRM6Bv+gqedYhdWjqxTQ4zfLmD0jhOjGnnaI=
X-Gm-Gg: ASbGncuwNqpFKVx+87Jc39UzRDFxnl7i6bdDG22G2aOdqI9rhq4rrW9yjhvLsTxa4Hw
	eKVqbhgtuOu/wvFhWg9pbNSTR/Z+USvmT6ox4sVPhHapkw7LETSgHpdQk2AKSJcOrUi/0t23Ijc
	FfmDEC3Qm3hH2Ep1Bp9qmuxzujxJ4gGLw+qCPY4KmcwwKpjde9lI8oq/eyE6eK+jdpsLH2caQJ6
	SoRa2Ktu+MQtpdpWEyWxQmlPgOsO+pf1A/6K32bjXnd60KufeSoMwyJno8iJh0VrR9fUNRS13UE
	ntueQwBqrQLelvBOnX5esgVIsTxgm+MZ9+23xrka/5QneCfw0ijClwPI2nE=
X-Google-Smtp-Source: AGHT+IGitQDvRK6ewY7mCLOw01u4oKU+hUBnH8fKbKmky0J+4NNyV4/eUF7RPvmIju2VRWAi4HUd1g==
X-Received: by 2002:a05:6512:a96:b0:545:ee3:f3c5 with SMTP id 2adb3069b0e04-5452fe45e25mr3123339e87.17.1739818581772;
        Mon, 17 Feb 2025 10:56:21 -0800 (PST)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00--782.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::782])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5462006b0ecsm559806e87.160.2025.02.17.10.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 10:56:20 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 17 Feb 2025 20:56:13 +0200
Subject: [PATCH 1/6] dt-bindings: PCI: qcom-ep: describe optional IOMMU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-sar2130p-pci-v1-1-94b20ec70a14@linaro.org>
References: <20250217-sar2130p-pci-v1-0-94b20ec70a14@linaro.org>
In-Reply-To: <20250217-sar2130p-pci-v1-0-94b20ec70a14@linaro.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Mrinmay Sarkar <quic_msarkar@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1369;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=H82/mjIwe1bn5g0vrkR5c3LtXjJgPihFdpxO7CtcYlg=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBns4ZPefQLfbWS8T8hT7pmVPyLqHiJC9XlTw/T+
 h0vBvHLrb+JAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZ7OGTwAKCRAU23LtvoBl
 uPCzEACf6n4nEZ13Thw+iJd1uwtmqOjNb0nzq4X63+Wl1BE9GYVB3KLAC2xU+Sff7gtv/y1Vhnl
 faseZrFqQRvIwD1oYAX2L750kYyB0hodEw6LvackREggG08BSpptZT10gSLaPULpGDjgVw8q2eu
 dvAZzU9lswDh6PtO13LGwCbNhEN5nyxTFMMKr1Or9On7lTSRhAxtl2n2c3lyzM08e3kWu8SBjT7
 7wH9K+5alYYDmofT9hC2cXOV6z2tmiAHd7T4SYTzkvzMLJK7b4iGk/q6SaiVIyCkHZpwGPku2lA
 H5R5VAHPWugwOFDv/nADHcrgkIcCsM0AUG5caNRqupFzCGgm+26/9X/EjO4cZb4Kcp5YQ0atBIq
 cpxLQdlQFaEGl8sylXTdgL4AeSBbo2Cen5EVAzq/wQH9fB0/amEdKuH/8QY+cDdE4Cnul8HZG8i
 jzRDVa7/vKZHJTKOUexY6vb522gP7Nw8TGwdUiXNqwCqrROKpeyTxMxKtcVHEjkG24yptPjg3i0
 J/oY/X0N0DXgrolrbFSCDS/K+BACiDkXSNYCr1IpTcffq3WCa0k2cKdElscQ1ErwLMeRhnu7m6K
 BQ+X4gHUjQ5FNt/bx0Y/4T7Pk9hWsk2TvQJXQVZQoWXv/EBGpBede6F/9D6bUcMot8BQVtxr2mk
 RWhqDf6BeWIjV3A==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Platforms which use eDMA for PCIe EP transfers (like SA8775P) also use
IOMMU in order to setup transfer windows. Fix the schema in order to
allow specifying the IOMMU.

Fixes: 9d3d5e75f31c ("dt-bindings: PCI: qcom-ep: Add support for SA8775P SoC")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index 1226ee5d08d1ae909b07b0d78014618c4c74e9a8..800accdf5947e7178ad80f0759cf53111be1a814 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
@@ -75,6 +75,9 @@ properties:
       - const: doorbell
       - const: dma
 
+  iommus:
+    maxItems: 1
+
   reset-gpios:
     description: GPIO used as PERST# input signal
     maxItems: 1
@@ -233,6 +236,20 @@ allOf:
           minItems: 3
           maxItems: 3
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,sdx55-pcie-ep
+    then:
+      properties:
+        iommus:
+          false
+
+    else:
+      required:
+        - iommus
+
 unevaluatedProperties: false
 
 examples:

-- 
2.39.5


