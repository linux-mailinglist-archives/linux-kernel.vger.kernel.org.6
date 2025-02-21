Return-Path: <linux-kernel+bounces-525114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28907A3EAFD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 04:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005B3423169
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 03:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3891DB124;
	Fri, 21 Feb 2025 03:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g6E/Mzni"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0134623A6
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 03:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740107172; cv=none; b=ddwX7umBT7yd7V6PUXT1MpaNk5ihpB0Flp78z3GGCUjPC9XOyhTk19Ec6w8dET9TlpK2foOeda6aivWYMCLgRmFH4BTuq9Dr8/1f0aAr6ww1Co368l3FMmcZjAWaZsUQTLMS3e1ii4b7JZeHQ7U5wVv4P1PKylLuE7SEzT16RIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740107172; c=relaxed/simple;
	bh=h41p5OP+JGUWnkefKPRuMJP7onFPK2xv7UsIeCTWeA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=svCoJ2TaSI9c19+QhH9BN5Uwey+Vfvb5+Yac9gVmIaFYEYNir+hVXv66XzeZDVLAHtTkuFpgtoWRqSUhOBrQaJdfnCBr2g8xs2kqvQZUbkpDVWCdA9h3T1++JLkcjPgDG7y0E1zBLASozX2RUa2NQdWGG5zMEQ5v5azzoWl2TSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g6E/Mzni; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30615661f98so15741411fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 19:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740107168; x=1740711968; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MyvOysAyejlDc0UdTyWb1kJow3RGjM7zTB/5Ujh2Ar4=;
        b=g6E/Mznia5NgZ/dRv95RNoasGG64Wh6J0SvVoLJemIkH/1egFqcQLg+IWBpln0XfTG
         5BzgHuYyLEmd5aMc+9pavME55kcWyURaJegVrqWQLlftz9bvtvgcQa3XchviY5JG68XI
         +ZAiSUTjrQDlu3LgOtYWXcMWOyw1shLaHrYcdKUZSEFI6/Fpx4v9nHa5YMk0tg8EujOq
         bgFonzroie5dQyGcCHib5ufPytsAIYL4WDRVrAKTM6pf9lNG0RIV2wiQ80jbIz06tjQC
         11oyhZcIxNcJGKgnv7FYUmkZ2TK0vv6FEoWvz6pe4LpRYpQCRR4h3AW6PI7nO7ah9ho+
         sc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740107168; x=1740711968;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MyvOysAyejlDc0UdTyWb1kJow3RGjM7zTB/5Ujh2Ar4=;
        b=U+SiXlhvdtfFOqmiiu3seruyo6dpaQoeUK/JMZD54k/lIYusmSaHI0U3ONCjk+vxUw
         tGD8EKzXAXU78FN4pAXCtXpgyEx+VGse074tG+Y8soSX9M8MyRK/Lw/5d7zf117bOrXd
         ai8B7Tqxxynq6k4Zuf7TNq5KqJNY7x0xl15kAAY0JSAaWADRLI7aqhZcGTLsHhjGu55c
         yM8rQyAgLn379e9/EceSnjPVKuG933jRGX4LlPbZIdJtT/UVh3CD96S/D2tDoS6sy8lm
         rQacaqrQbIkfCFRKgxYWEr1vs/zciGUTvFy82q8Wfe0w370QTFpueR1eHdiaucUWQJ/R
         t9VA==
X-Forwarded-Encrypted: i=1; AJvYcCXOczC0XJgobn/6pk3oE7kNBIrEfGty48aHNzAomXBZEKLqKFeMCA3BH/oSBuN101XP9IHefpEGTuw/Dx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzDK51bM94m7WFg0zUZ60NaApOgqIWxkaOYocZLK7Ry3HJjsUM
	m2cXz2dGv4PJtrK81ehA4pR5fOt+dpT+mjf7JimsMGkktToduAci8iHtsuRxNjE=
X-Gm-Gg: ASbGnctkdlYJGa+1mkH1qIS9mW6hRZ/0PFY5xukk2Z02tiZaIP3wZlavcIi+uTCGzIm
	kRc40EHdczbNmSdkYzPFao+PA7rQubddhLV4kTv1bhZIkiu+Q/KnOwxk8WwlMZMtPFF8g3kCcQN
	DadWbnU86XgInALmb2Q0xeGlVtpSNCCVY7yaNLZUMnZPQi8djEwpZYnKz+Kd+C/AtausuvPoyOF
	2A3X5rQV3kUMQRHjnD/+1d7CZFPENUbvWPaPKua5o7O/dsQEDc+tgucvOXZHNSgxSBKZRx71nVF
	wPGCjFgvBfxvfn38affg8F6QL4kLXFhFkNa1x2qTvK9W5KQ+kA8OZtyBBydHrvwOsuVQlQ==
X-Google-Smtp-Source: AGHT+IHEXimMAaKjnDfHOBm5Bk1IPHIUFn0oxeZQN8nmbgxih0yKLiTInO1+aDy5zxoHfxt0KERGLQ==
X-Received: by 2002:a05:651c:226:b0:304:588a:99ce with SMTP id 38308e7fff4ca-30a5976e4d0mr4176401fa.0.1740107167957;
        Thu, 20 Feb 2025 19:06:07 -0800 (PST)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00--782.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::782])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a2be45876sm16021071fa.68.2025.02.20.19.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 19:06:06 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 21 Feb 2025 05:06:00 +0200
Subject: [PATCH v2 1/6] dt-bindings: PCI: qcom-ep: describe optional IOMMU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-sar2130p-pci-v2-1-cc87590ffbeb@linaro.org>
References: <20250221-sar2130p-pci-v2-0-cc87590ffbeb@linaro.org>
In-Reply-To: <20250221-sar2130p-pci-v2-0-cc87590ffbeb@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1332;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=h41p5OP+JGUWnkefKPRuMJP7onFPK2xv7UsIeCTWeA0=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnt+2ZJ1d2rnD4QvueIoK3bZoOBqEM3ytwcD+Rk
 feHNpdrg/mJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZ7ftmQAKCRAU23LtvoBl
 uPghD/9cbfOizPzPViaH53MjmsJG+AMwDka8bh0Ol5Ah/3WZi3m2G9pb/VIEW2UfXCCI5vOq2J1
 FlrsOGw0sgnjgDQZDptaXxutCri2EHVAl7OoXIT1Ghg/OoMgyCrAlEEJDNJjIzVdHMm2wX1Dpel
 dRK453wZiEbTV11pThtkcZTGU0A139G/AqeaHfEM1kyBqNG4o0jCKFq3ORSEl/j+b004CQh60sf
 pXc9AbjPGMB0RycngkK9txFg/MHNAWFsK4YUyodcnIgmOegqAt279r4fiUup5UnQ7+a0ASNn0cQ
 ALI429oQB4G6KO2oNJz5E6hmBigdlklfHG2E8TQbPK/hYW9H8lEG34qtPozt7fWbJUJq5Ll+u6y
 lb5LLTF5YQaredQemJjlY2usB52eEcEdvlZ3KwGc5rQyl0M7hXEB16DvgaLWlDPJf03m8ygR9MK
 jq66RRblrrTyovlWlMAcihjL16u1vFQ33hdJ2plQ3tPt7EHwn8J/lbqqFuXuBf4b0obMkKzRXgc
 KDRBMc8L7kO1Ac2H3au80EkiXZBGDO00Zv9a0dcsqqh5bXashm1b4ZREUdTmtBnPuGyeNi05eJk
 fQcgKnJTEkpL9VO4FHyCyM9MoU5mxT3nz8bkrAnYg3U1OFFeUYV1D70/89CyKeMTSH0QVURgH5W
 saFTFxbhjkq6bDA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Some of Qualcomm platforms have an IOMMU unit between the PCIe IP and
DDR. Changethe schema in order to allow specifying the IOMMU.

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


