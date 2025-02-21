Return-Path: <linux-kernel+bounces-526077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15859A3F984
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B98327AD035
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5A21F3FD9;
	Fri, 21 Feb 2025 15:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vltd0TAg"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81C71DB551
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153130; cv=none; b=fvcK6YkEck6s28oIdGsavujyIW9dyUijkihY7lptFesx3ck55oJQ7s8sYfAig9+cdWlQw/Wjp1+nbR2HtZ9zCChtW1RiValPMvX9yjmZ9f3ho3+O0Cu+wir40e7FUsEIXf5jnl3Gmb01F7jwg813HZu2Bc3w/rAH9hQAC7DatOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153130; c=relaxed/simple;
	bh=8nVGeN+HC+bXQ8NfYsOEnO3Wa1b/eYod1wwftfqnfSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lf3yQrQYlanro0U4aWYd/Ap1RPv5sf2stcVjEdA8vjEV35ukxa9SLG02Bg8yE0OvJact1eCJpHLlJcTIE1repOcNeoFfdlYCeajMK/JaL+XrpZNU4MGbsSwFLNA3DYt8RYJJR5UjwdLMvQbknaufGzSHWBNnoQ/wuy0cc5koHMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vltd0TAg; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54622e97753so2084746e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 07:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740153126; x=1740757926; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=59l7mbGaP2HmkD17BVYwmiA+/2aqKP82W4Rw21F/4bg=;
        b=vltd0TAgcROXDZ/Ag1ed1+uib8j4JNic8g7OabKUxmJYC+g2w1LMVb+p5SjCCvp2vd
         hg3p6zQe12oJCQn0J82ht+xkIbM3T9rT6rXLm4YHwQu79dsWU173vYJf4o3bEBth8MZU
         jiiIEdRowMLzVoi+A1LDsHXcqhnpHOPf8ZuqIrHoqy5bQE7FnCA3g3uPYiL3ozS2gx7i
         hTrtJIgcRFj7nvtfi/pq6yHMZof6XV14zhhyvHlTVDNgaewTLSccvj7+FVRvprPZOPAk
         EMqKJE+YxCa0cERaFPPHb+D86Qrx97YWdFdtoHJGEgT/piEaV4cIyd2wHh0Ox0RL23+q
         3H1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740153126; x=1740757926;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=59l7mbGaP2HmkD17BVYwmiA+/2aqKP82W4Rw21F/4bg=;
        b=qSC9Rl8bhzdanteCiuC97z0WMvTc7Q2kQFuDM8JexAdWs44hx1SR5HPaA78Lfkv3DL
         UYegnyYJU44KFmM5vucCUF9N8kqisCkwwxwKZ9inJLy0ELri0+ay3QoNa0Wgr72gIkVi
         U4PKX7eFq9vHuj13C0zEV8M10WRKr9xbcVaRRLNUshoAxEba5L6igTFQH+r+XXIKpjL+
         /+AbVdg8XSGR+TDcYFP+QDJ7ZAhNQUKPqpOw/L8kfKCbzplrN5aIfwFKWb7Tnm3b9IJy
         Vu5Q3DRmYGoSyZH7vM3DNYi8WKa5wm7Yan6IYT808tvS8/wKYcwH9Xy3heTyR6A5WX07
         X4kA==
X-Forwarded-Encrypted: i=1; AJvYcCUu/aSEZEud62VKrJP/sBX4mw5Xsyqj/HS3RV5q5TrV5ewRKJNFVW0s3ZaeWhBMTzCZCv7nL/YS8IdTjk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOhC5QSqSTiuxCLS5/2dCTRa7veYZKART42FqQwnVnCJaOl4Vf
	1RvlPtNzNmAOdeAj7ih21G+E0XODUPufN9dIYkcdmTkvLV/NmbPo7YP3t0RrhN0=
X-Gm-Gg: ASbGncvxdE6bRWCVElY1ePu/63u0npo9p00z+n/GKR/ui1LY4XtaHlL3TCoM+ye17jG
	GAYl+dnoJEZG14MuMa04PETM4U1vjvA7P2I9fGpaulzlotercYoq52oeFUoKeFMNT/g70xGk5in
	E7g7/U+knVgv2432WXt/jVzY162GzwzqHrCq8fd8Fjut8jf4FAe9zsC4ZaIN+HbYBusxu3X/BFU
	qyXmEnQ7UBPjfXEYUOfGJopOCuoUTzYwhM6QE2bokcQ0VOzrnAolckh2ytNdtRdAyFeCgGSRZDy
	u+hrUgp3bjHlDlfd7+nUxf+1JIlptmIUUOo+cdOVP01PBkJ2WcqxD1T74UlMJH0g0MXtEQ==
X-Google-Smtp-Source: AGHT+IERYtiLjyfICQk2nAReG2xpvpvYnQJuCtw/sHHQ7gXTROiXL7nhNEZ8D10TdsGqPqtRZi7EcA==
X-Received: by 2002:a05:6512:3b86:b0:545:4ca:d395 with SMTP id 2adb3069b0e04-54838c56efdmr1375885e87.2.1740153125906;
        Fri, 21 Feb 2025 07:52:05 -0800 (PST)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00--782.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::782])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54816a55851sm287643e87.27.2025.02.21.07.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 07:52:05 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 21 Feb 2025 17:52:00 +0200
Subject: [PATCH v3 2/8] dt-bindings: PCI: qcom-ep: describe optional IOMMU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-sar2130p-pci-v3-2-61a0fdfb75b4@linaro.org>
References: <20250221-sar2130p-pci-v3-0-61a0fdfb75b4@linaro.org>
In-Reply-To: <20250221-sar2130p-pci-v3-0-61a0fdfb75b4@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1585;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=8nVGeN+HC+bXQ8NfYsOEnO3Wa1b/eYod1wwftfqnfSc=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnuKEgtI/6KSbLukLpS9h+mZzvpXF9Pff7bFVH4
 v5sTu3LsLWJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZ7ihIAAKCRAU23LtvoBl
 uPaqD/4w+FLDEY4jeoA7AMqattg5NHR8xblcA04R7vCcEJeQRH+8bnGRcxI4hEDE/omf2smZuIe
 e+UapEZkBweqQli9YOi1VoDx5+DRVCcKFkRV+MatufpG7N0I8ZBbqGaRVHtUbiFytlM9ZZaz9uS
 N/T167GeprtM+EuVDsja79i1zGS2TnA7AuB37U2A0BU+woqHkx0VcO+wKXhD2hII9gZFC1x7tPf
 drF+nkuX3m3trFacyOX5bwbEZ6HGgoBwec0WkyVtd7zYd7hQpKLpFzNCcjJ01EakZzm/ElTaS10
 ALgKYpxW6qTt+KJQ3qQP+iuj5nbA7NJU/3BuME+IoHxWqt5KYL/kfZV4b+GqqsFgltJHHU3rx0+
 rfw+My+MIb/96Pv6yH0NbkSdfJ5qNvnyKl6RKNBHM+D9ForcQArWm347a7d0pEMEBjKKpUzQThw
 1uCzhofZE4vOnwkuyltSyAmGSFWrnvwy3oofppvAtjaa/pGzRmHJbAb/vtEctMlpPvplOxi17SU
 XMM9lcNrvPAA/wkWT2dSN1ha/aiHlHetkzvyfZzZ38uA19PjXZzbcyL60pDn/xGL9730+HUaRba
 ODYoTzKjwsQT1aT3YRZ+lLKYe9lKcwiVy8D9eAZ3bxqGsb3SBuR9NbE+WaaKPh4BZ5aqNmSSga2
 IGhmaI0eAwnLAJg==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Some of Qualcomm platforms have an IOMMU unit between the PCIe IP and
DDR. For example, SA8775P specifies the iommu alththough it is not a
part of bindings. Change the schema in order to require the IOMMU for
SA8775P and forbid it from being used on SDX55 (SM8450 will be handled
in a later patch).

This fixes the following warning:

pcie-ep@1c10000: Unevaluated properties are not allowed ('iommus' was unexpected)

Fixes: 9d3d5e75f31c ("dt-bindings: PCI: qcom-ep: Add support for SA8775P SoC")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index 0c2ca4cfa3b190b3fb204f0d7142370734fb3534..6075361348352bb8d607acecc76189e28b03dc5b 100644
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
@@ -162,6 +165,7 @@ allOf:
           maxItems: 2
         interrupt-names:
           maxItems: 2
+        iommus: false
 
   - if:
       properties:
@@ -234,6 +238,8 @@ allOf:
         interrupt-names:
           minItems: 3
           maxItems: 3
+      required:
+        - iommus
 
 unevaluatedProperties: false
 

-- 
2.39.5


